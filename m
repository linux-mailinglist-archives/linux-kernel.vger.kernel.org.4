Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A326275F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 07:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbiKNGbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 01:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiKNGbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 01:31:46 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E97915A27
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:31:45 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id b62so9480844pgc.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H6MJ2kCyoq5eEtUDlHoQWWIXnNVgqbCZg+3HomRuzWo=;
        b=rzRc/Sj2MKjUucVDlaT8UXQT19YIu87ppVfdCJBePtT9eeS7GXkgfxPO7EEj6jeLyQ
         KyhkMEJhptbG+9SXi6MEjL91pXeYqQdEV4Xq+8IKb5pHc4Tj5fTGEwbtotO3P1eej7+Q
         F5nThxXSmNOwXrK1Xxi7+yVJWwncDQVCb8fdcq0f2e6BjeZWEvOD1fEx3S3B1gsGsCmj
         RLjzx7ZsfbcwNdZeITrV6JHE7PbURo9NyQaNFYyprCEOMeoc/8Vxm0hU9C8utR9X/eUr
         4MPQTrP+Ooj4kN/UehmNurrrtdJhGHJQWVuk2rXwgCMdudKE/gDRqtj5ZvlU1kbEXCgt
         bSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6MJ2kCyoq5eEtUDlHoQWWIXnNVgqbCZg+3HomRuzWo=;
        b=bQlqZQK1Ny2+qZxp4uHftBehKz10SoOTl5jgvAjcHfycwawui6uodN4FhKlIfA+uze
         RSJmO5ZDdxaasIdVCsHk0MW8mA3DTIFVzFV/L6FBFjwc+TDcib6MAQT6Uecup4nZ2Hl/
         LxbXglUd2Q60tevgSCtRhKr4bDP1v4+FCvjcar7c4nv3oHFj6Vuzi8uSnlzlKIV5hd0G
         LVbNnyZ57gEONBwZEZNLO7asD+/p+pDmMQwMkPPttF0iBnl/FkUB5hdOOmyyUo/Kl2nr
         YtZaHHv8nLaZZFWk49yyXQbg3Nj/ZWSKhoVwi3gQkY2jOM5Z3giLCrzFnQLARFmyf7eu
         b1Dg==
X-Gm-Message-State: ANoB5pkHao6+gXhrL3UXBeYIys9TJO3VkEQBeWsc1PKSn9Mr43k6vV5b
        bg0+5l25Oqq4RclUec13FSh4oatbb4JZuMSBYiaUKw==
X-Google-Smtp-Source: AA0mqf71EgPvw8iGutidUfgr50B6UrX2LbxvGXyOtYOOc+HCFg0bG9Yu1jxtAMlW6ZnAkMYrWZJynLYA+ksrh0dNpzg=
X-Received: by 2002:a63:e258:0:b0:447:ed69:761 with SMTP id
 y24-20020a63e258000000b00447ed690761mr10484895pgj.181.1668407504780; Sun, 13
 Nov 2022 22:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20221111095313.2010815-1-sumit.garg@linaro.org> <20221111143800.k7xje6g23ujefnye@bogus>
In-Reply-To: <20221111143800.k7xje6g23ujefnye@bogus>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 14 Nov 2022 12:01:32 +0530
Message-ID: <CAFA6WYMdNjbMRZxt3iicmKOhQa3ax7_HYtqmNN9bmpndqT8e9A@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Resolve dependency with TEE subsystem
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, cristian.marussi@arm.com,
        Ludvig.Parsson@axis.com, jens.wiklander@linaro.org,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Fri, 11 Nov 2022 at 20:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Nov 11, 2022 at 03:23:13PM +0530, Sumit Garg wrote:
> > The OP-TEE SCMI transport channel is dependent on TEE subsystem to be
> > initialized first. But currently the Arm SCMI subsystem and TEE
> > subsystem are invoked on the same initcall level as subsystem_init().
> >
> > It is observed that the SCMI subsystem initcall is invoked prior to TEE
> > subsystem initcall. This leads to unwanted error messages regarding TEE
> > bus is not present yet. Although, -EPROBE_DEFER tries to workaround that
> > problem.
> >
> > Lets try to resolve inter subsystem dependency problem via shifting Arm
> > SCMI subsystem to subsystem_init_sync() initcall level.
> >
>
> I would avoid doing that. We already have some implicit dependency with
> subsys_initcall because this driver creates/registers bus and need to be
> done early.

Yeah but that should work fine with subsystem_init_sync() too unless
you have drivers being registered on the bus at subsystem_init_sync()
initcall which doesn't seem to be the case in mainline. Have a look at
usage of subsystem_init_sync() elsewhere to see its similar usage to
resolve dependencies among different subsystems.

However, if you are too skeptical regarding this change then we can
limit it to OP-TEE transport only as follows:

diff --git a/drivers/firmware/arm_scmi/driver.c
b/drivers/firmware/arm_scmi/driver.c
index f43e52541da4..19c1222b3dfc 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2667,7 +2667,11 @@ static int __init scmi_driver_init(void)

        return platform_driver_register(&scmi_driver);
 }
+#ifdef CONFIG_ARM_SCMI_TRANSPORT_OPTEE
 subsys_initcall_sync(scmi_driver_init);
+#else
+subsys_initcall(scmi_driver_init);
+#endif

 static void __exit scmi_driver_exit(void)
 {

> Now in order to solve the dependency between SCMI and TEE,
> both of which creates/registers bus and are at same subsys_initcall,
> we are relying on subsys_initcall_sync.

True.

>
> Me and Ludvig discussed this in private and I suggested him to do something
> like below patch snippet. He mentioned he did post a patch on the list but
> I couldn't find it. For this the scmi node must be child node of OPTEE as
> it is providing the transport.

TBH, the first thought that came to mind after looking at SCMI OP-TEE
DT node was that why do we need it when those properties can be probed
from SCMI pseudo TA at runtime? Maybe I am missing something as I
wasn't involved in its review process.

The whole idea of TEE bus evolved from the idea that if the firmware
bits can be probed at runtime then we shouldn't use DT as a dumping
ground for those. I hope you remember discussions around discoverable
FF-A bus too.

However, the change below is simply an incorrect way to fix the actual
inter subsystem dependency problem via DT. How would this fix the
problem in the case OP-TEE driver registers on FF-A bus? There won't
be any DT node for OP-TEE in that case.

-Sumit

>
> @Ludvig, ?
>
> Regards,
> Sudeep
>
> --
> diff --git i/drivers/tee/optee/smc_abi.c w/drivers/tee/optee/smc_abi.c
> index a1c1fa1a9c28..839feca0def4 100644
> --- i/drivers/tee/optee/smc_abi.c
> +++ w/drivers/tee/optee/smc_abi.c
> @@ -1534,7 +1534,9 @@ static int optee_probe(struct platform_device *pdev)
>                 goto err_disable_shm_cache;
>
>         pr_info("initialized driver\n");
> -       return 0;
> +
> +       /* Populate any dependent child node(if any) */
> +       return devm_of_platform_populate(&pdev->dev);
>
>  err_disable_shm_cache:
>         if (!optee->rpc_param_count)
>
