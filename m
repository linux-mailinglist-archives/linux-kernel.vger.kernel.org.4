Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3F15BB7F1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 12:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIQK7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIQK7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 06:59:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22740419B2;
        Sat, 17 Sep 2022 03:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACD86B80D31;
        Sat, 17 Sep 2022 10:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA25C433D7;
        Sat, 17 Sep 2022 10:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663412350;
        bh=4YhfXXVITaxyZ7ickgJk1+TK+jaPswSVW817YmzQetg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mlHCnKP0WB2uWbChrk4q6RL0Qx2r/gHQDC9oSJpxW2EbflDButPVeikbnLPDqRuAa
         uMBNIAxUK9YP6cJ8t088PZToAtuG+fNjSjR1cCN+UFjy1NSR4Fe+vii3eIQ++5/J2t
         G32gzhZbqibD7HIndba0d3nwaO6DhkgEj8JWwI484H7lSPNjcKiuf+lKgZzp145UKc
         /rWyFp393Jz382lw1mp0vKr2MFARtOSXzRJp2N2/VdtnThMFXTJB+055ZPSba5Qla3
         eNal325u2+WTwCZYezJX9gJTu2HlqZJ1v6xPyr5h7svm/gR+KopGdwkenk6Ht9hg4Y
         p3TMKbSRfTsXg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-12b542cb1d3so45846254fac.13;
        Sat, 17 Sep 2022 03:59:10 -0700 (PDT)
X-Gm-Message-State: ACgBeo2gA5hQW41IZNTfbbaN6JnxCrOOkENcL2knzPs4YVmtEyH5J3oA
        Rvq06M1fkvQLw/lMZCbMDXKHTE9ypd6TaVGgyck=
X-Google-Smtp-Source: AA6agR4sClFlGuDsJqtKaYj0hkDas61Hr4pLmOYJ+LWicDByGyz5Jc5/SoMTyBglnH1gA6Au8ZBBCEB98KwdYTTgtGU=
X-Received: by 2002:a05:6870:a78e:b0:12b:542b:e5b2 with SMTP id
 x14-20020a056870a78e00b0012b542be5b2mr10590424oao.112.1663412349408; Sat, 17
 Sep 2022 03:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220917015522.44583-1-zouyipeng@huawei.com>
In-Reply-To: <20220917015522.44583-1-zouyipeng@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 17 Sep 2022 18:58:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRDspQZUZk=KAC_P+YCr=86o4EgOGAVGcB1kdgsymhyVQ@mail.gmail.com>
Message-ID: <CAJF2gTRDspQZUZk=KAC_P+YCr=86o4EgOGAVGcB1kdgsymhyVQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] make weak attributes in {k,u}probes
To:     Yipeng Zou <zouyipeng@huawei.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
        linux-s390@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@linux.ibm.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, mhiramat@kernel.org,
        namit@vmware.com, catalin.marinas@arm.com, peterz@infradead.org,
        mark.rutland@arm.com, liaochang1@huawei.com, chris.zjh@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a riskless cleanup.

Acked-by: Guo Ren <guoren@kernel.org>

On Sat, Sep 17, 2022 at 9:59 AM Yipeng Zou <zouyipeng@huawei.com> wrote:
>
> We have some function implementation under some arch does nothing.
> We can mark it with weak attributes to improve.
> 1. arch_init_kprobes in kprobes
> 2. arch_uprobe_exception_notify in uprobes
>
> Yipeng Zou (2):
>   kprobes: make arch_init_kprobes as weak
>   uprobes: make arch_uprobe_exception_notify as weak
>
>  arch/arm/probes/uprobes/core.c     | 6 ------
>  arch/arm64/kernel/probes/uprobes.c | 6 ------
>  arch/csky/kernel/probes/kprobes.c  | 5 -----
>  arch/csky/kernel/probes/uprobes.c  | 6 ------
>  arch/riscv/kernel/probes/kprobes.c | 5 -----
>  arch/riscv/kernel/probes/uprobes.c | 6 ------
>  arch/s390/kernel/kprobes.c         | 5 -----
>  arch/x86/kernel/kprobes/core.c     | 5 -----
>  kernel/events/uprobes.c            | 6 ++++++
>  kernel/kprobes.c                   | 5 +++++
>  10 files changed, 11 insertions(+), 44 deletions(-)
>
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren
