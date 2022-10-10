Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E58E5F9A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiJJHua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiJJHuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:50:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8DF167E5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:48:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11C60B80DE0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F9EC433D6;
        Mon, 10 Oct 2022 07:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665388087;
        bh=h/wqk4opLky2Xk7jBx4TrniLv51NjHfiJViecUF3ifo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1zCzvY/lUv8puUqWeHxiSDjgV+VIiyKmuSOP9ED1Wa52cFBN30523ZzGXQ3x1lHL
         ck9GGCxKP6HCKxCgT5aDEt+FkjGiU3sa44o3An9nOWmq6H22gn/OGh45KAkgOGryCe
         Uxp23cKiD1/zKX2XSWXJV3lefEWO756QnAOA7wIqVc617bqtF8hrIiMHw1haSjAj3Z
         SS1Adz+sqiz184vG0PsaRjn2C0Hjbh0heSE/XCe7oC79TnXif1Qb1RMLQG5Szt9eOs
         Kc7uIGiUXYOqwEQXzHPOTK2DD3mNxfgopjXT8U+BlOlo7WxNbwQO7dj7rGNrrS96rs
         6F01cruGb8oTw==
Date:   Mon, 10 Oct 2022 08:48:02 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mfd: syscon: Remove repetition of the
 regmap_get_val_endian()"
Message-ID: <Y0POMogrdDN+BR37@google.com>
References: <Y0GZwkDwnak2ReTt@zx2c4.com>
 <20221008154700.404837-1-Jason@zx2c4.com>
 <CAHk-=wiqN9EJ6zKXh21EQ2CV-B7_oDJKy73+yhRwtbNMWCzfVA@mail.gmail.com>
 <Y0HKeTWneX12OP+Y@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y0HKeTWneX12OP+Y@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Oct 2022, Andy Shevchenko wrote:
> > And if not, please just send me the revert through the normal channels. Ok?
> 
> Yeah, revert is a good move here.

Thanks for the clarification Andy.

Linus, by normal channels, do you mean you'd like a follow-up PR?

-- 
Lee Jones [李琼斯]
