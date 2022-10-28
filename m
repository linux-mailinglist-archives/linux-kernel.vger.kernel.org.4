Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0243611565
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiJ1PDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJ1PDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:03:21 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2198C207531;
        Fri, 28 Oct 2022 08:03:20 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ce329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ce:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD3D51EC02F2;
        Fri, 28 Oct 2022 17:03:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666969398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i/4Cjq8GYwaXxiXVKl0FhiYMVNlnZzPqMpB349dIQEo=;
        b=gxQSofa/L8yGDLBNTJGXcDQT1BZ9EN2QpEBOtb8fae2l7kkacWjuo0irRxC4ObsNM3cmGG
        bPB442gmbrlZRjjavdzIHDYaIOFPK4Q5k/F+Co/CHbM3wSA0Xik4w6msl5qJHKYZvW3nFR
        flu71/Fhe1SdET62l2UNhiU1pG+TDjA=
Date:   Fri, 28 Oct 2022 17:03:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>, x86@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <Y1vvMlwf/4EA/8WW@zn.tnic>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
 <20221014155845.1986223-3-ajones@ventanamicro.com>
 <20221028074828.b66uuqqfbrnjdtab@kamzik>
 <Y1vrMMtRwb0Lekl0@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1vrMMtRwb0Lekl0@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 07:46:08AM -0700, Yury Norov wrote:
> I'll take it in bitmap-for-next this weekend.

Why?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
