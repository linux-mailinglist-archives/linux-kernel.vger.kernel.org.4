Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83B272164F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 13:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjFDLQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 07:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDLQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 07:16:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C14CD2;
        Sun,  4 Jun 2023 04:16:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B152260ADE;
        Sun,  4 Jun 2023 11:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67308C433D2;
        Sun,  4 Jun 2023 11:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685877372;
        bh=gs9u365I+VHx1wbSO0kBBTyhE49vBMSK2th0tcnQ0aU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TMbGHRuowncq6U+WymTpdbZ7WwMtCMvVIDuCd2vw72vD1d6+1JsDzv+5UKMea2ltx
         MVmTUSwBC5vpnplCgDmN3A2ptUp3g1IKlXqUrtw1amwkCPzTPCIfiXg+B9/9rlqwGv
         pAWHC/piwraQndKQgpXlE60YUEWaY8J5NIZ/66iAKgIQm8QHXp+x9wtgxSCRt1/9hs
         HEu+d0KdoaxDArKQjtJ470UiWmyDki/yFBtVV9lS6RTm858bIsb/eT1YeW97bXltEL
         +xHutITSHbd7yuPb3EfGAhn2iSXfmLViLfVhHu5Ho4jOj87jlQ6SaQOoJk5sO9ZwG3
         qlqiqpMgJB5qw==
Date:   Sun, 4 Jun 2023 12:16:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     andy.shevchenko@gmail.com
Cc:     Astrid Rost <astrid.rost@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v5 4/7] iio: light: vcnl4000: add illuminance irq
 vcnl4040/4200
Message-ID: <20230604121607.1f633e61@jic23-huawei>
In-Reply-To: <ZHtENLuHKixK884F@surfacebook>
References: <20230530142405.1679146-1-astrid.rost@axis.com>
        <20230530142405.1679146-5-astrid.rost@axis.com>
        <ZHtENLuHKixK884F@surfacebook>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> ...
> 
> > -	val = state ? (ret | mask) : (ret & ~mask);
> > +		val = state ? (ret | mask) : (ret & ~mask);  
> 
> I'm wondering if you can prepere the code by introducing switch-case instead of
> current implementation in the preparatory patch and then do what you want to do
> here. It will show much better the change and make review easier.
> 
Agreed. Diff wasn't being particularly helpful in how it handled the changes here
so helping it along with a precursor patch would be good.

Jonathan


