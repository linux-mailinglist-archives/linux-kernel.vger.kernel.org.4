Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3220E6CC1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjC1OU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjC1OUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:20:21 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC479A8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:20:19 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91EE41EC0420;
        Tue, 28 Mar 2023 16:20:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680013218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRKVLohPfZZjpWr7Is2aCsxT1HTKZq+0Z1Xz+PX6hEM=;
        b=q8u8St3VnEG5yPLdZT5Bog0atL1P+wz27OY5jVBSJa0ixh2LxVo30R99JSIPgOwNP8XvUm
        TMPBwti2gIG23j7Lk3JodGLw1/HQacMFLpwChx6Yh0C/aNqqZrFZ8EUgjHLS4xEzlqd9lk
        WNjgiZDsKtRB9ULaYqhya80D1GFJjKk=
Date:   Tue, 28 Mar 2023 16:20:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     David R <david@unsolicited.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Message-ID: <20230328142014.GCZCL3nkW5Qx5jhfsB@fat_crate.local>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
 <20230327074952.GAZCFKoDOiJUdtse2H@fat_crate.local>
 <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net>
 <4c660f0f-2845-0e02-ccf9-619958e24236@unsolicited.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c660f0f-2845-0e02-ccf9-619958e24236@unsolicited.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:02:57PM +0100, David R wrote:
> After more investigation :
> 
>     Revert "x86/acpi/boot: Do not register processors that cannot be onlined
> for x2APIC"
> 
>     This reverts commit ce7d894bed1a539a8d6cff42f6f78f9db0c9c26b.
> 
> Corrects the issue for me.

Hmm, weird. That commit came up already yesterday. But in conjunction
with qemu.

Does this fix it per chance?

https://lore.kernel.org/all/20230327191026.3454-2-eric.devolder@oracle.com/

You'd need to revert the revert and apply this one ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
