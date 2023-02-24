Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98A36A1C52
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjBXMiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjBXMit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:38:49 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E381716E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:38:41 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e5so17678565plg.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7qH17OyGyM47GPzRwHNiOgr9TsgAnfi2ZEjhVFPdcg=;
        b=Mt68vRPDJBeoMxtMNOChw+A7exoz18+aUvT6JRwUTf7K6bXqvpMUHqiEycS//qFsU3
         HVdWLFrDh4zfTrJzhPu2zMFHFEunSFyBhQV0tGwm6ZEledQKfno2fjmw9IYGXTyIjVRl
         1Nm+zeM2tTD7pSA9lu3lTGMI/d0QVyfgoWpNFbINA93+xvMoUd/Fr7IjSV8s2fxuXsZJ
         Tjm0hW77pG/PzMT/AubtH3oi+nwOcYi3d7K3WO6T9YEpBRxLlbYtPPcMEZgxoCyM/r14
         WUWMf+wcebBgEmu8T37SAyyYhXWLxLMj668fZH+HRXchJEwKLXSaKdrFeM1lA0ZmPGTP
         XWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7qH17OyGyM47GPzRwHNiOgr9TsgAnfi2ZEjhVFPdcg=;
        b=0YLZAGZqheWuOHTyTPoT8abndZoN5D/UQ96a+32JA+Rz2YuaHE8WLyGGKy/RXi8xg3
         nq/9ZXP1jLFjpgXIlR6Y2C2OzokoWm/ZNzNMcuSw2kw1z3H8oufCtc2Bjbsia4Jb0qld
         O/57pLyxJvMgjDz+qlvPMD5Ae/nrPLa4KDAjdym1aq5Kcc6RPzPJ3wKRGicbsxKlvzg+
         69+1yVVefoc1Q4Bv04uSyIAqTx7Tv/wha27WEfirdRFb2QLRE0puBJuRg+DHNRWUgD/W
         /q3skYMQVMjDAYYTbsY+XO8cgXxjII+YLn5Flu/P1sCmvBM6X85onMtqvy8pPPXmjy2Q
         V7nA==
X-Gm-Message-State: AO0yUKWadwJX79m8NGsxtXSfYVjWbpS3YK4V/+OhSdeTygBIXdd9XPYk
        eW+9k4Zp1VDEoZeY32KVJDTJmA==
X-Google-Smtp-Source: AK7set9/IK46oIHdAjUgWq+wlPNf5E+YpHOahLJ9kH52yTNvgxOt21mZCyPmEi1etMRXaG2aNV/qhw==
X-Received: by 2002:a17:90b:3a87:b0:233:c301:32b0 with SMTP id om7-20020a17090b3a8700b00233c30132b0mr17950540pjb.10.1677242321176;
        Fri, 24 Feb 2023 04:38:41 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902744800b0019a593e45f1sm9363605plt.261.2023.02.24.04.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 04:38:40 -0800 (PST)
Date:   Fri, 24 Feb 2023 18:08:32 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V2 20/21] MAINTAINERS: Add entry for drivers/acpi/riscv
Message-ID: <Y/ivyGVW/v6Nf5Nh@sunil-laptop>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-21-sunilvl@ventanamicro.com>
 <20230220201432.5lz7rvwqhfxa4fno@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220201432.5lz7rvwqhfxa4fno@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 09:14:32PM +0100, Andrew Jones wrote:
> On Thu, Feb 16, 2023 at 11:50:42PM +0530, Sunil V L wrote:
> > ACPI defines few RISC-V specific tables which need
> > parsing code added in drivers/acpi/riscv. Add maintainer
> > entries for this newly created folder.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 39ff1a717625..d47212194457 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -450,6 +450,13 @@ S:	Orphan
> >  F:	drivers/platform/x86/wmi.c
> >  F:	include/uapi/linux/wmi.h
> >  
> > +ACPI FOR RISC-V (ACPI/riscv)
> > +M:	Sunil V L <sunilvl@ventanamicro.com>
> > +L:	linux-acpi@vger.kernel.org
> > +L:	linux-riscv@lists.infradead.org
> > +S:	Maintained
> > +F:	drivers/acpi/riscv
> 
> This section should go under the "ACPI FOR ARM64 (ACPI/arm64)"
> section to be in alphabetical order and also in a more logical
> place. Also, shouldn't this section include
> arch/riscv/kernel/acpi.c and potentially other arch/riscv/ files?
> I see arm64 doesn't, but maybe it should too.
> 
Okay. Let me update.

Thanks,
Sunil
