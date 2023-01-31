Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B21A68274D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjAaIrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjAaIql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:46:41 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9674B898
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:42:42 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z1so6821296plg.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ARSqzITLXBgBgKXOXaBzTznpHHClJvtQ0GMIZieUXhk=;
        b=NG4bXOsXt/J3qkvlabr4QEliZMMvxYhxRDdDb7ES2Lri3vzuL69Aci/0/UtE9kd9Zt
         nFDzUetjHjHybSdI7eNAKYgx5bq0GTqgvKh9C2Ox6xlQc1qwp8m39TtEf166CRFItG2R
         N/iuvJwOJAlDky3OuCjHT2/MFSpP5DDXIm+KVF/KFQlyNggkekRJqX4c6sEalbQOWP5l
         n7VvTJ0yisYwsUtrVs8nIcHTONLxSdH/o6qRo2u1kxwLaahB8THkyOfbv9RJW0TiwHz+
         1hFxlexNIyyJzoK6n88BHTz4/tLJo9wYPRWPOUVh95MG+XVunx52UmSCJP86KEeDANAl
         7OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARSqzITLXBgBgKXOXaBzTznpHHClJvtQ0GMIZieUXhk=;
        b=TgTQA1YlA5QI03afD5kNLgOYhBu8ygUuOL90yfyjCI9rzvzHCjiBDNnRN0Sk0HNq4f
         hUUErYGA85dq54dAq+5d/yj6nBY2QSYaaY6QqOQYn5EBD+hjmVvlEhwzYw1bI53ouWok
         SDGiZOjOTTyk3vf49EWmbEeGi5rPwOwgA0UiEv/II2CJTCSLTtrE8hcj7jRH4Hxt9P1c
         a97Qdg80SdGskULI17LON5vvPKU96QF4iIY5GQB0qYHREF9318OCJ5I5hp/fOUd+0JL9
         rZIjRviCGXTu4NGYTIUOR4YflrmL1YaxWqQpDpVhsoVEvIm939/NlY66ZeslTfcYlGhR
         tUbQ==
X-Gm-Message-State: AFqh2kptsGP6KdRNZXJM8kgkOhHN9ucC3ouWR5fnQFvIsqWCra0f2Yuf
        ZF3hCNUsg9KqJzRD05MXPi+Fkg==
X-Google-Smtp-Source: AMrXdXvDWtXgsitMeIdZoasXXSOSj70rH/aFeCaP2XDbmUOEeY0dvlFfKQ/myV1EU79OkGFGBNzrAQ==
X-Received: by 2002:a05:6a20:6698:b0:b8:701f:1d04 with SMTP id o24-20020a056a20669800b000b8701f1d04mr53756232pzh.11.1675154556416;
        Tue, 31 Jan 2023 00:42:36 -0800 (PST)
Received: from sunil-laptop ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id z19-20020a62d113000000b0058bacd6c4e8sm1005959pfg.207.2023.01.31.00.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 00:42:17 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:11:57 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 22/24] RISC-V: ACPI: Enable ACPI in defconfig
Message-ID: <Y9jUVZRUigLqoIKT@sunil-laptop>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
 <20230130182225.2471414-23-sunilvl@ventanamicro.com>
 <Y9hXF8RpNawkuTEN@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9hXF8RpNawkuTEN@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,
On Mon, Jan 30, 2023 at 11:47:35PM +0000, Conor Dooley wrote:
> Hey Sunil,
> 
> Two quick comments while I think of them..
> 

Sure. Thank you!

> On Mon, Jan 30, 2023 at 11:52:23PM +0530, Sunil V L wrote:
> > RISC-V: ACPI: Enable ACPI in defconfig
> 
> btw, about half of this series redundantly puts "ACPI:" or "RISC-V:
> ACPI:" into $subject. None of commits that mention ACPI after the last :
> should mention ACPI in the prefix IMO, it's just noise.
> 
> For example, this one should be something like:
> RISC-V: enable ACPI in defconfig
> 

I agree. Will update in the next version. I added ACPI in begining so that
I could quickly identify them along with other patches in my branch.

> > Add support to build ACPI subsystem in defconfig.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/riscv/configs/defconfig | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index 128dcf4c0814..8ce06fb0dde8 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -218,3 +218,7 @@ CONFIG_RCU_EQS_DEBUG=y
> >  # CONFIG_FTRACE is not set
> >  # CONFIG_RUNTIME_TESTING_MENU is not set
> >  CONFIG_MEMTEST=y
> > +CONFIG_ARCH_SUPPORTS_ACPI=y
> 
> This needs to go into the arch Kconfig file, where it will be selected.
> Check what arm64 does if you are not sure what I mean.
> 

Yes, I have added in "[PATCH 07/24] RISC-V: ACPI: Enable ACPI build
infrastructure". But forgot to remove here. Thanks!. Will update it when
I send next revision.

> Hopefully I'll get a chance to look at the rest of this this week
> sometime,
> Conor.
> 

Thanks!
Sunil


