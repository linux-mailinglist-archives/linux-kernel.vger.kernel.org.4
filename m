Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A9E69F113
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjBVJOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjBVJOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:14:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0B36459
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:14:41 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 86FE01EC067C;
        Wed, 22 Feb 2023 10:14:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677057279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uN/t9ooZt5sOGUgJT2lTmyGh1e++FX2YnQ2iJWxFNeA=;
        b=L0jTN3v9loHfnjpeGsja7xaqhBFhPmZ+c74TTF2cn9KWIMYz7vb8UYbsZBGITA7LY2RXt7
        FIYPhH8PZg9wpz3GAZ/mnzh5BwlR9uarPGxfJ4l2BPjuWTX7fTEswJa3G1B9usEb1a6uye
        Bp6gTVnHxem2xD9rQNc848HmqPh6f9Y=
Date:   Wed, 22 Feb 2023 10:14:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tavis Ormandy <taviso@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: x86: AMD Zen2 ymm registers rolling back
Message-ID: <Y/Xc+yMzI83WZ4V1@zn.tnic>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <Y/XTT59OrLw2as4R@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/XTT59OrLw2as4R@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 09:33:19AM +0100, Borislav Petkov wrote:
> It probably doesn't matter all too much but which kernel are you running
> this on?
> 
> Latest and greatest I hope...

Also, what does

$ grep microcode /proc/cpuinfo | uniq

say?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
