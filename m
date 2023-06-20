Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1DD7369AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjFTKoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjFTKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:44:07 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1541FE3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:44:06 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b46a06c553so45262561fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687257843; x=1689849843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=faoJAf5HLjrBrs+IcgqfpLzetaGrKEXpSA60Yow7EsE=;
        b=OXFUWVLjaJd8V9KgupeF1CaurU0XOAFsMPzh9+id4S8/d8ji5GgCReuF9khP1ihvKd
         0KgLg1nz5tSh27tKR9fB1rjF/XSRcxxL1tmJs+CJo5nL8XUFi43p5PVOW9oXfzPy/9yC
         2hVdaH92UXlfjD8A/EVr0C7PMifQrez3wBrHbPfAHFg3wKuqcUngTOW++5kNPD2I0NqO
         r598tt/yFZhISYVLyyV39SZJzpz87uuYMxksCVkikmrBSfzjE8iN1FYpsNDQIapyxS2y
         vgEUu8QmDAKep7JUJK+MtpIShhSAlWybuPpJfJ5wW71E6sx6bKZoOir0VaHg9JjEIe44
         9GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687257843; x=1689849843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faoJAf5HLjrBrs+IcgqfpLzetaGrKEXpSA60Yow7EsE=;
        b=cJdEGtRX8kJqFikHGXDpA565ykgKPQPbWIRttPsINtDB7R1V0HTWUe3tvYbTqXZF52
         k4WkrIgVn0BFtgEX8ug/72kbMaEi2RPSsG5Nc/Jy3Ov2VC0QIkH/ExJEj22Gi1xSelIw
         uCdd/KwXRFHa0zyDDN0oBO040m+qplNtQ8DLP/pTpb2vKWwSJH9QBNAXGDYwQ4P72F7m
         bYcao708UolJhLA+kn2zb+pzOeynXVFWtJzcrkFAjUbiwYnrMl9CjmX8j6m/O3BVozkx
         WwRASdmIzr6wBFJZzomOLWsK/YvG1cDWCWW8X1qr7gRsWecHyASBUCmW9aB7krowQ2C+
         7V+A==
X-Gm-Message-State: AC+VfDzVaND/khFmNWtJwjKF37KHwwmspM5SAMmyVh6/YzYWVj1w3+9f
        CX4R8n/RiNYgP9plRctuijHXWw==
X-Google-Smtp-Source: ACHHUZ4P2ZMWloakXb40I06YdKtCNuGDp3Bvc4L3BXixlWUCHvujiSGB/uspgI/o6yV+CHWEQKCXyA==
X-Received: by 2002:a2e:9593:0:b0:2b1:be57:5c0c with SMTP id w19-20020a2e9593000000b002b1be575c0cmr7642708ljh.12.1687257842994;
        Tue, 20 Jun 2023 03:44:02 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id p16-20020a170906141000b0096f937b0d3esm1158226ejc.3.2023.06.20.03.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 03:44:02 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:44:01 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Haibo Xu <xiaobo55x@gmail.com>
Cc:     Haibo Xu <haibo1.xu@intel.com>, maz@kernel.org,
        oliver.upton@linux.dev, seanjc@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 10/10] KVM: riscv: selftests: Add get-reg-list test
Message-ID: <20230620-95ce8ab70956a72b9da3a31a@orel>
References: <cover.1686275310.git.haibo1.xu@intel.com>
 <8cd4ce50f5f4a639f4508085959aae222d4d4386.1686275310.git.haibo1.xu@intel.com>
 <20230609-fba04b424a4d46574e04e587@orel>
 <CAJve8okjRZEt6_6SB9EWm+6c7utpExzenfWo2T1N-J6G9w9czQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJve8okjRZEt6_6SB9EWm+6c7utpExzenfWo2T1N-J6G9w9czQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 06:05:59PM +0800, Haibo Xu wrote:
> On Fri, Jun 9, 2023 at 9:35 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Fri, Jun 09, 2023 at 10:12:18AM +0800, Haibo Xu wrote:
> > > +static struct vcpu_reg_list aia_config = {
> > > +     .sublists = {
> > > +     BASE_SUBLIST,
> > > +     AIA_REGS_SUBLIST,
> > > +     {0},
> > > +     },
> > > +};
> > > +
> > > +static struct vcpu_reg_list fp_f_d_config = {
> > > +     .sublists = {
> > > +     BASE_SUBLIST,
> > > +     FP_F_REGS_SUBLIST,
> > > +     FP_D_REGS_SUBLIST,
> > > +     {0},
> > > +     },
> > > +};
> > > +
> > > +struct vcpu_reg_list *vcpu_configs[] = {
> > > +     &zicbo_config,
> > > +     &aia_config,
> > > +     &fp_f_d_config,
> > > +};
> > > +int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
> > > --
> > > 2.34.1
> > >
> >
> > I see we have a bit of a problem with the configs for riscv. Since we
> > don't disable anything we're not testing, then for any test that is
> > missing, for example, the f and d registers, we'll get output like
> > "There are 66 new registers. Consider adding them to the blessed reg
> > list with the following lines:" and then a dump of all the f and d
> > registers. The test doesn't fail, but it's messy and confusing. Ideally
> > we'd disable all registers of all sublists not in the config, probably
> > by starting by disabling everything and then only reenabling the ones
> > in the config.
> >
> > Anything that can't be disabled is either a KVM bug, i.e. we should
> > be able to disable it, because we can't expect every host to have it,
> > or it needs to be in the base register sublist (meaning every host
> > will always have it).
> >
> 
> HI Andrew,
> 
> I found several multi-letters ISA EXT(AIA/SSTC etc) were not allowed
> to be disabled.
> Is it a bug? shall we fix it？

Extensions that a guest could use (regardless of whether or not the host
described it in the guest's isa string), because the instructions or CSR
accesses don't trap, can't truly be disabled. So, it's not a bug to
prohibit disabling them and indeed the test cases should actually ensure
disabling them fails.

Thanks,
drew
