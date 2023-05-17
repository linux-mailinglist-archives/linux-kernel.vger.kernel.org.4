Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCAB706458
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjEQJmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjEQJmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:42:02 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF5A3C19
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:42:00 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-436750830efso135131137.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684316520; x=1686908520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a3Mivkl0m++lbcWbpQkVlNl5ORvNsZ6jk54N2wY1md0=;
        b=jjm18+pOvvSnrefEU4G2PU3sT8st9HXjb5z4v+ND+XQG8NVoq0cWopy0yosK0miokt
         56lKeKlWxi3tsMAxAJpXP4SHq21uG4yVbSnLZYWUkZ1FYco9sjxKzb66y1yATmi0wipn
         /czSyNtfPE1+tmolFVZOr0z+IblYPQxlXOk2PElMsRF77eB+5LkNEcze62T9W3zx5ee9
         lLdXfpoepE/oZqQj+obKbAbhxiIls6JC4FLvmlCCV49+1exHlFkeAcszGo7la4k06yOm
         qSjfyW/fqwcUkE9S7naAVh1v8A/a5fiAaeEx6AOMLIgPCMZgTTDoINH+TrlauMpfCSHb
         oOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684316520; x=1686908520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3Mivkl0m++lbcWbpQkVlNl5ORvNsZ6jk54N2wY1md0=;
        b=JjdCC11eYNwsO8Y53WgSc5UE1Snya9J7kf3DvUGJ7UrL0hY/VcESYK87EZBHQFjbpZ
         iHOzinVfDc82+cRw/P50KZlt3bnh5Mc5o3Tw2FjeM4c+vkJPtJjmp5ZB6/2YtmTRdgOp
         tCUjAZp3uPuILskLB4VwT9BOXlkbQtJ9pOycQtSEnG7iDMq5hQrg/zrtxygwe8tyOVi8
         QLsKl7n/Bq+LB/vHKX0Ip1QIiq7O12LheLB5B7rTLyYqi/0en/FMPwDRMboGi8++c5bb
         849EesoHTQk2/FHFauoWjySVhOPEHIJiCrcHvx7CDT5W1+AeECBCr2T0IzhLBK8F7zXT
         5iTg==
X-Gm-Message-State: AC+VfDwvUJDT57t3ubX27kKwWcIuPX0XtjufA65syrQcYnkrEWsjRvah
        i672AHXZv4ZlWtAY5we6fqrhTMSwbVkkCVBrDNqf3A==
X-Google-Smtp-Source: ACHHUZ7mWY6Azo/e+kuhTCa16/oxLHkgGl4+Aund0CSHP63AYlLAE3pemYCGfvh4PH/Ldx+271hy2Kfxj5g/xc34bH4=
X-Received: by 2002:a05:6102:e52:b0:425:e0ab:6fc with SMTP id
 p18-20020a0561020e5200b00425e0ab06fcmr15212264vst.35.1684316519605; Wed, 17
 May 2023 02:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230515161736.775969473@linuxfoundation.org> <ZGNJfAPd8eeVoCJ3@debian>
 <2023051711-thespian-sponsor-8878@gregkh>
In-Reply-To: <2023051711-thespian-sponsor-8878@gregkh>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 May 2023 15:11:48 +0530
Message-ID: <CA+G9fYvw6HJopruUn4QKPCcqbdgw++AFf1wnwMP9hP1rJsmq3g@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/381] 5.10.180-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 at 14:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 16, 2023 at 10:14:36AM +0100, Sudip Mukherjee (Codethink) wrote:
> > Hi Greg,
> >
> > On Mon, May 15, 2023 at 06:24:11PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.10.180 release.
> > > There are 381 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> >
> > Build test (gcc version 11.3.1 20230511):
> > mips: 63 configs -> no failure
> > arm: 104 configs -> no failure
> > arm64: 3 configs -> 1 failure
> > x86_64: 4 configs -> no failure
> > alpha allmodconfig -> no failure
> > powerpc allmodconfig -> no failure
> > riscv allmodconfig -> no failure
> > s390 allmodconfig -> no failure
> > xtensa allmodconfig -> no failure
> >
> > arm64 allmodconfig build fails with the error:
> >
> > /gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_tlb_flush_vmid_ipa':
> > (.hyp.text+0x1a4c): undefined reference to `__kvm_nvhe_memset'
> > /gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_tlb_flush_vmid':
> > (.hyp.text+0x1b20): undefined reference to `__kvm_nvhe_memset'
> > /gcc/bin/aarch64-linux-ld: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.o: in function `__kvm_nvhe___kvm_flush_cpu_context':
> > (.hyp.text+0x1b80): undefined reference to `__kvm_nvhe_memset'
>
> That's odd, I don't see that symbol anywhere in the tree at all.
>
> And the only arm-related kvm changes don't have those symbols either
> (the other kvm changes are x86-only)
>
> Also, no one else has seen this issue.  Can you bisect?

This is an old issue,
Many other reported long back [1]

[1] https://lore.kernel.org/stable/CADYN=9KSKQx816id-zWepV-E3ozph3k2_i9Rhs6QseFv0hkPfg@mail.gmail.com/

- Naresh
