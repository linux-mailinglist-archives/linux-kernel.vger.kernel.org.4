Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027F76A183C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjBXIr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjBXIrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:47:07 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344655192A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 00:47:00 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id z20so2130150pfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 00:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMm4tTnCBx/UWlRMFi35xdsLvkcX8RtXFHwDjnM/k8g=;
        b=R7WanfuN4UrhQd8BNoxEa9os2dRd/evoOBxPjVlUaje5t2eNCIqE9nwXs+ujFcBbxH
         uC9Ppmp0NfNCCWnqND/LaF7KEEXc+6dV7aFZmADi8tGi/BCrc4MvnFxB7AbxGaHb0zPs
         kuj5udBV2ymPfzH4kosWoqwAo972VHDL6bqv+JKeY2cYOSQb0PBpLoEfw+NseDtccsWh
         wwPgNxRzCvcHibW67bPDVX2Vhr+raVNK/XfC7pfcmicZSI0XddoajlozT946Kb3tTSHr
         yZOg4aDSQftzxDd/e4u2Fk+8QCxJULu3hr6xkcWj5w+ym5wCagTNm2Ju6P64ko+UY6/F
         ARJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMm4tTnCBx/UWlRMFi35xdsLvkcX8RtXFHwDjnM/k8g=;
        b=gAFqPqCOipUKTGKKEIXDwfvk8KlZEcattvPoyANNQuzCgflc16binZgUUx0tldLDll
         ZpNmC0MO0yk1ZlygKEisFj6v1/xxKRQJl6BrwstpLc1k/uxXHNwrgIwx2QXgoyy5ZYoa
         N0Jl3NiXShmfukevE/Y+1Z6UO08USxEUUve9qn2aJ7knKov3GZZYJ7wMMORD4shVy92M
         N9Z7Cllhzh+KxbJ9GeTQX7k/M2I2Qv2Sx2bzAb+E+hU4cQdCac+L229GwDZ/frxcHfva
         rB0aJ23WvBoRtrhQw6LIt7NUXrE3n8lZKf5UAZ4mkwInddtvEiTv62ZVhcso+KBhx4+Q
         JjkQ==
X-Gm-Message-State: AO0yUKUUhUhUEblpVPyXl9MFLMqPX6uduPhjAmbpEVhTWdFwJ/N/1m8r
        m2X3DAeg2xShFllp2x1Rwdy8CQ==
X-Google-Smtp-Source: AK7set8FrW7c54xe2wApbvz8+IVHsJOwdjux1tqWoB5KJLo1CTFzoYM8ZtgqRDfWykSZaFnESf3lkQ==
X-Received: by 2002:a62:1545:0:b0:5a9:d676:ae58 with SMTP id 66-20020a621545000000b005a9d676ae58mr13650050pfv.13.1677228419747;
        Fri, 24 Feb 2023 00:46:59 -0800 (PST)
Received: from sunil-laptop ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id q22-20020a62ae16000000b005d6fcd8f9desm4483802pff.94.2023.02.24.00.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 00:46:59 -0800 (PST)
Date:   Fri, 24 Feb 2023 14:16:50 +0530
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
Subject: Re: [PATCH V2 19/21] RISC-V: Enable ACPI in defconfig
Message-ID: <Y/h5eoPyZeEpUSL8@sunil-laptop>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
 <20230216182043.1946553-20-sunilvl@ventanamicro.com>
 <20230220200909.gkwmpklocw36632w@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220200909.gkwmpklocw36632w@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 09:09:09PM +0100, Andrew Jones wrote:
> On Thu, Feb 16, 2023 at 11:50:41PM +0530, Sunil V L wrote:
> > Add support to build ACPI subsystem in defconfig.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  arch/riscv/configs/defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index 128dcf4c0814..f89f79294b34 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -218,3 +218,5 @@ CONFIG_RCU_EQS_DEBUG=y
> >  # CONFIG_FTRACE is not set
> >  # CONFIG_RUNTIME_TESTING_MENU is not set
> >  CONFIG_MEMTEST=y
> > +CONFIG_ACPI=y
> > +# CONFIG_PCI_QUIRKS is not set
> 
> I'm guessing the addition of the CONFIG_PCI_QUIRKS line wasn't
> intentional?
> 
Yes, I realized after sending the series. Will remove it in next
revision.

Thanks,
Sunil
