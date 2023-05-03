Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566E06F5DDB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 20:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjECSZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 14:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjECSZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 14:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2203A87;
        Wed,  3 May 2023 11:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8DDA617DC;
        Wed,  3 May 2023 18:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2A5C433D2;
        Wed,  3 May 2023 18:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683138324;
        bh=OsjI071Y14ZXXjZ8NoGpl++zRV5XTfFhw8+/C06ehhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKhBkf/GnYD1clUSITpTqZQBSalvTpQHZivnVmpLbcyyNaNWGiNN+WaLuEr4vUMKG
         Ui81A7njHFJHVq1VQWn6l//1MbHk7cT5MY3pQpU33b/yyrE5LhTy2FvjiAkyRMmYW0
         jV4cMQT/lmSJ2PgFnwHFGlSrIeGInH4znM2UI7QPLdDjAmxUamhlUgMWSzskmKJPuJ
         vZuBdVZUTAR/SEZF+K5MmaH8y5BJd80/BEV4hpHF2j7kY8v+gghhb1nzq6Te1m2s/E
         pSUGwprI+/mmnASDwYx9jZzbI5MYiJct6A4eRCem8ZlSRgamD/O5CgjLUBIodfq/xf
         /5z2cXMwrq4rQ==
Date:   Wed, 3 May 2023 19:25:19 +0100
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] LEDs for v6.4
Message-ID: <20230503182519.GN620451@google.com>
References: <20230502162524.GJ620451@google.com>
 <20230502162815.GK620451@google.com>
 <ZFKl7GSNlStABYXG@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZFKl7GSNlStABYXG@duo.ucw.cz>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 May 2023, Pavel Machek wrote:

> Hi!
> 
> > Apologies, this is obviously LEDs, not MFD - long day!
> 
> Thanks for doing this. I guess it may have something to do with the
> subject, but please keep linux-leds@vger.kernel.org in the cc list.

No problem.

Sure.  I'll try to remember to do that next time.

-- 
Lee Jones [李琼斯]
