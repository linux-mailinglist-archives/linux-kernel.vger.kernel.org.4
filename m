Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7F36B23BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjCIMMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCIMMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:12:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C01E9183
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 04:12:12 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A8BB1EC03CA;
        Thu,  9 Mar 2023 13:12:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678363931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jfvqr3DME89liz1ktXadHeat8KSFUXaqDcs3bHgDNhQ=;
        b=ebt/xkScXtKcshM4mmgpzQ1k0e2xQ0+M0jnxkvvNLhTuc5fmUQQf0lxfsXtW3jkXvM1Aao
        44ly/rvchy5TeuWqwACU0MBou/Uc8x8ueiqVroDhgaEl8gd65vvtr9gYwIKA1o8N55u0F/
        Xs9tk/j6RV6ujPhsp3OrdViK6ktJvf0=
Date:   Thu, 9 Mar 2023 13:12:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dionna Glaze <dionnaglaze@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Peter Gonda <pgonda@google.com>, linux-coco@lists.linux.dev,
        x86@kernel.org
Subject: Re: [PATCH -v3 00/11] SEV: Cleanup sev-guest a bit and add throttling
Message-ID: <20230309121207.GBZAnNF+lJmoqPlazP@fat_crate.local>
References: <20230307192449.24732-1-bp@alien8.de>
 <1643fd48-c055-ebfa-6790-b49d35fa8d54@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1643fd48-c055-ebfa-6790-b49d35fa8d54@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 02:33:58PM -0600, Tom Lendacky wrote:
> One thing I noticed is that patch #3 fixes an issue where the fw_err field
> returns uninitialized stack data when success (0) is returned by the
> ioctl(). There's no Fixes: tag on that commit. But I guess the later Fixes:
> tag on patch #9 would cause #3 to be pulled, too, right?

Yeah, that's the plan...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
