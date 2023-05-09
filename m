Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE38A6FCE23
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjEITDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEITDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:03:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BE235BC;
        Tue,  9 May 2023 12:03:32 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D6F221EC0159;
        Tue,  9 May 2023 21:03:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683659010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=09GW99NTVS22Mwaev3kLFWTnYH/VOWJS3HI9jylLJcA=;
        b=X+iucjUdz3uKI5pV5cuSAOat380cNZEYU1x7y0FMxuXVSx+doaA6kae9CGuB1AnYdZ3u8F
        iElCG2ro39XbSku3idL9VMSbxlsa/pUn0hcZS6XjN7fqEJdIAHikXl58mql1MlYfF60o2F
        s/x84JQaAZ1oKOV88Zc/Lm26HbXglXs=
Date:   Tue, 9 May 2023 21:03:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: make config X86_FEATURE_NAMES visible with EXPERT
Message-ID: <20230509190325.GEZFqY/SfuCnadUjcW@fat_crate.local>
References: <20230509084007.24373-1-lukas.bulwahn@gmail.com>
 <7cbe80f0-dcc3-bfc3-3bd8-c9f96704618d@intel.com>
 <CAKXUXMxO4b-8wT-88fJ=++woH-p79_4R-vUr=aELNFYinGcEuw@mail.gmail.com>
 <ea00d762-b0df-ab72-988b-98c62ffc7949@intel.com>
 <20230509184135.GDZFqT3yC/j5bJA1l5@fat_crate.local>
 <c0dcbda3-e131-2460-4c61-e98d0be750ff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0dcbda3-e131-2460-4c61-e98d0be750ff@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 11:43:12AM -0700, Dave Hansen wrote:
> Like remove the option entirely?  Or just remove the prompt so folks
> have to hack the .config for it?

I wanna do entirely as we have waaay too many config options but we
probably could start with removing the prompt only and see who
complains...


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
