Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB336D8153
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbjDEPOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbjDEPOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:14:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F1E9027
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:12:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ml21so12317479pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680707527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uc9pS7LWOx9W2W+bVOlzBxwPbz5vuE1RzHaVZSPLmto=;
        b=E1iN/rVli6IlEc+9dtSf766sTAMDsKoBOf9+0HqG/1UKxBY9CsRrocmEKMyToLlGz4
         gMn6oqiNZ2oMqeY+GCNgDGhKqzkpTMAFFbowFGbmLQ9VD3ZuzCvBevmg56kH26n23Rmb
         pbtQjZFZUMnZs1F+k9M/tQLTuSqOdPg7cHgV/Fn6G7azHT/tkIxNegBxHN0JT5DrumSE
         3F/7mc2bp3puj/e/PI/bFn4DGw984aOT8BFORB2XD4EqHbdNt6OXltvazgvL0dausRra
         E7UOXUBJs9OCJZQQVHxikMXd3WNStS19nw7frBf76aEmS5gjvAKrr4C3jKExIkVaX/r9
         JBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680707527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uc9pS7LWOx9W2W+bVOlzBxwPbz5vuE1RzHaVZSPLmto=;
        b=j4zcx0DAE9kF5TzvTXd0dLLKDHBeaLcNxYpb8SqYdkDMp7W2Ki4lNJvgNvKcKLxe4j
         sAjKWFng0V3vtd/eGmB5MGuRDa/UOJVfky5X7CQvF5dNYHhCAlQ21u3ZpH2JwZmkvf4u
         8PwTTopLGiGKckQkFhX/Yi96ACfmEPGTVZ2v0vXZJF3PfSHrwy13IxsR7VfY66NmMrqi
         fTjP9PCVNTHHSfBMgJs+kxicFZm2LsBe5s7QB0HOrcFwjJXXLAI2JyvKuj/yOBwzsZKZ
         9P9kiQKf3Fzmt8cEGUMP05XWEaf8vKtHlxjr4Pix8jYrbn47xywr27mRF3pB3G1WdRl6
         D95w==
X-Gm-Message-State: AAQBX9fFwjKMMByvr7A+MiqSLZ/YTSMyYS2qMW6tfDl/r1t+mpwrpIpn
        dAmovEUjlaYuSwdjeowwj/kQag==
X-Google-Smtp-Source: AKy350acIs5ZpayOCA2w9KEEQrlHejGlhpqGSCjTnMb7JdKR0jSYZZQPlwOcN3qK4L6jamW1VaYfVw==
X-Received: by 2002:a05:6a20:6b98:b0:df:81de:93dc with SMTP id bu24-20020a056a206b9800b000df81de93dcmr6125484pzb.34.1680707527314;
        Wed, 05 Apr 2023 08:12:07 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id x24-20020a62fb18000000b00582f222f088sm10810109pfm.47.2023.04.05.08.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:12:06 -0700 (PDT)
Date:   Wed, 5 Apr 2023 20:41:54 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Weili Qian <qianweili@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Len Brown <lenb@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH V4 19/23] RISC-V: Add ACPI initialization in setup_arch()
Message-ID: <ZC2PuiY5Xscz305H@sunil-laptop>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-20-sunilvl@ventanamicro.com>
 <20230404-escalator-fridge-daf9aaffad12@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404-escalator-fridge-daf9aaffad12@spud>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:38:56PM +0100, Conor Dooley wrote:
> On Tue, Apr 04, 2023 at 11:50:33PM +0530, Sunil V L wrote:
> > Initialize the ACPI core for RISC-V during boot.
> > 
> > ACPI tables and interpreter are initialized based on
> > the information passed from the firmware and the value of
> > the kernel parameter 'acpi'.
> > 
> > With ACPI support added for RISC-V, the kernel parameter 'acpi'
> > is also supported on RISC-V. Hence, update the documentation.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> > +	/* Parse the ACPI tables for possible boot-time configuration */
> > +	acpi_boot_table_init();
> > +	if (acpi_disabled) {
> > +		if (IS_ENABLED(CONFIG_BUILTIN_DTB)) {
> > +			unflatten_and_copy_device_tree();
> > +		} else {
> > +			if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> > +				unflatten_device_tree();
> > +			else
> > +				pr_err("No DTB found in kernel mappings\n");
> > +		}
> > +	} else {
> > +		early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa)));
> 
> I'm probably forgetting something, but this seems very non-obvious to
> me:
> Why are you running early_init_dt_verify() when ACPI is enabled?
> I think that one deserves a comment so that next time someone looks at
> this (that doesn't live in ACPI land) they've know exactly why this is
> like it is.
> 
> Doubly so since this is likely to change with some of Alex's bits moving
> the dtb back into the fixmap.
> 
Good question. The kernel creates a tiny DTB even when the FW didn't
pass the FDT (ACPI systems). Please see update_fdt(). So, parse_dtb()
would have set initial_boot_params to early VA and if we don't call
early_init_dt_verify() again with __va, it panics since
initial_boot_params can not be translated.

Thanks,
Sunil
