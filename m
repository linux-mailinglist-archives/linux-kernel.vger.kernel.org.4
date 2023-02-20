Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A559E69C780
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjBTJR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjBTJRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:17:23 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A0D1165C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:17:22 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id 26so294342vkn.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676884642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XLuISGfJQz6zltLFCoKr8DlpUMxBl8e7Y8Zw2CLDKq8=;
        b=S9MI9YjKoTB63VvqXhVlvO6pw33RhafAlgTa3uudVSmfE2yaIHfyilXcYZ9xkBonWD
         8J9BLKqOyx02YnBarsqIF8/g1DE9ohNn1Sn5JMztYTmHKRkXo7Bf6ZtgyTgQA11l/DUl
         i1idYlCRU2Fm/jF6GXSTrbunR7sgUP6GMSlsZflFmtg1wbw964sHX8SgP5ItBLyCrxnG
         l68JIqltO0A3yCDtEIHPlm9H/QIdurILTSVak4zmMM267a3Sdv9I/HBfmZu2pDBWa6GH
         2Yl6eEpmXdDw8YuVWorum+2pMH5Bl8+kMSfTl8aTMhVLYBh0ooEORWrjcAPe1kqsMlWK
         rruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676884642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLuISGfJQz6zltLFCoKr8DlpUMxBl8e7Y8Zw2CLDKq8=;
        b=rF0AvEVOQFqq99OjcwugtL2ekN6ksK23x92PvUcsPoRfinDSO5wVdp6WQNM5Avb6F+
         c3BPxFAjeakcCFsnIrSynX8Vd9wZ8UAANQsuCQlA4GF8ZT4zGnrSffyEfcobYXgq2Pwp
         hTQYl2Z5LO8MY2VSp+EBFcvqo88b9o3cN0anbH0pXZbT/v3h9NLqbPNSTg3Jom0HK97E
         uOp3M1ibCavEQIHaSjq/8AFRIxhYX2TH7Mi49V+JiJSDFJtWmG2wxmsEqh2YAcEvtNN5
         wxm2Vsv7YIQfywXIXXAbqh7x1kiEmAqxoVznI4+0WaZed7Sndumnjb8CHXsjd5sCvPqU
         z3ug==
X-Gm-Message-State: AO0yUKX71zrgy3eXcEiBlbvB9Jy/9VGESEnyWfI7e6HMQr0+NJt1PuE5
        evOt9p1Lz3oOFpdeAQkGrlVBjN3xzX4E80qeKgsopg==
X-Google-Smtp-Source: AK7set8LeB7kTT1iKD7WbHMRpuG4dToaKcXA+XG20qQgHpnLYOyFGHlWNFanUMrt565brFUK7e/B5qzf/1DfGtLA1Nc=
X-Received: by 2002:a05:6122:1435:b0:3e1:f8b0:e35d with SMTP id
 o21-20020a056122143500b003e1f8b0e35dmr119185vkp.35.1676884641885; Mon, 20 Feb
 2023 01:17:21 -0800 (PST)
MIME-Version: 1.0
References: <20230220051723.1257-1-masahisa.kojima@linaro.org> <20230220051723.1257-4-masahisa.kojima@linaro.org>
In-Reply-To: <20230220051723.1257-4-masahisa.kojima@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 20 Feb 2023 14:47:10 +0530
Message-ID: <CAFA6WYPdhWAgkBs+ehADVB__5-C9xDmdGL=D9Q5V047yEoL2EA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] tee: expose tee efivar register function
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahisa,

On Mon, 20 Feb 2023 at 10:47, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> This commit adds the functions to register/unregister
> the tee-based EFI variable driver.
>

I am unsure if this commit adds any value now since the TEE StMM EFI
driver should be able to directly use efivars_{register/unregister}()
APIs. Do you expect any other TEE kernel driver to use these?

-Sumit

> Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  drivers/tee/tee_core.c  | 23 +++++++++++++++++++++++
>  include/linux/tee_drv.h | 23 +++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 98da206cd761..0dce5b135d2c 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/cdev.h>
>  #include <linux/cred.h>
> +#include <linux/efi.h>
>  #include <linux/fs.h>
>  #include <linux/idr.h>
>  #include <linux/module.h>
> @@ -1263,6 +1264,28 @@ static void __exit tee_exit(void)
>         tee_class = NULL;
>  }
>
> +void tee_register_efivar_ops(struct efivars *tee_efivars,
> +                            struct efivar_operations *ops)
> +{
> +       /*
> +        * If the firmware EFI runtime services support SetVariable(),
> +        * tee-based EFI variable services are not used.
> +        */
> +       if (!efivar_supports_writes()) {
> +               efivars_generic_ops_unregister();
> +               pr_info("Use tee-based EFI runtime variable services\n");
> +               efivars_register(tee_efivars, ops);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(tee_register_efivar_ops);
> +
> +void tee_unregister_efivar_ops(struct efivars *tee_efivars)
> +{
> +       efivars_unregister(tee_efivars);
> +       efivars_generic_ops_register();
> +}
> +EXPORT_SYMBOL_GPL(tee_unregister_efivar_ops);
> +
>  subsys_initcall(tee_init);
>  module_exit(tee_exit);
>
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 17eb1c5205d3..def4ea6212ee 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -7,6 +7,7 @@
>  #define __TEE_DRV_H
>
>  #include <linux/device.h>
> +#include <linux/efi.h>
>  #include <linux/idr.h>
>  #include <linux/kref.h>
>  #include <linux/list.h>
> @@ -507,4 +508,26 @@ struct tee_context *teedev_open(struct tee_device *teedev);
>   */
>  void teedev_close_context(struct tee_context *ctx);
>
> +/**
> + * tee_register_efivar_ops() - register the efivar ops
> + * @tee_efivars:       pointer to efivars structure
> + * @ops:               pointer to contain the efivar operation
> + *
> + * This function registers the tee-based efivar operation as an
> + * EFI Runtime Service.
> + *
> + */
> +void tee_register_efivar_ops(struct efivars *tee_efivars,
> +                            struct efivar_operations *ops);
> +
> +/**
> + * tee_unregister_efivar_ops() - unregister the efivar ops
> + * @tee_efivars:       pointer to efivars structure
> + *
> + * This function unregisters the tee-based efivar operation
> + * and reverts to the generic operation.
> + *
> + */
> +void tee_unregister_efivar_ops(struct efivars *tee_efivars);
> +
>  #endif /*__TEE_DRV_H*/
> --
> 2.30.2
>
