Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4455569F282
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjBVKJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjBVKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:09:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764492E0C6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:09:57 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 092521EC0622;
        Wed, 22 Feb 2023 11:09:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677060596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=efmGMNG9B+mdqMf7s/t0MQIi1wPRwzoJkvLtSbsvMt4=;
        b=TdG0IIN2Alqhrg53rQNmyPwAWswElPOPjVdW2xTC5Ls/U1W+H6QMMG/SWARbkcWGZiCeIz
        vyMHtdK7R67rbjlPbVTYINcl8aTuyiZE3jDIccbtWNb8s6pZ6PTgZa4Kr6keEiZCCwbaGs
        lUYnGRSamTer5pW+0/fjvanDac/IJMw=
Date:   Wed, 22 Feb 2023 11:09:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Tavis Ormandy <taviso@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: x86: AMD Zen2 ymm registers rolling back
Message-ID: <Y/Xp73KJe3c/1jrn@zn.tnic>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <Y/XTT59OrLw2as4R@zn.tnic>
 <Y/Xc+yMzI83WZ4V1@zn.tnic>
 <0371ec3d-0899-f94a-7f21-21d805df2927@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0371ec3d-0899-f94a-7f21-21d805df2927@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 09:38:09AM +0000, Andrew Cooper wrote:
> This sounds suspiciously like an errata which was fixed with a ucode
> update last year.

Yes, it looks like it.

Alternatively, you can try booting with "clearcpuid=xsaves" - that
should take care of your observation too but yeah, you should rather
update your microcode.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
