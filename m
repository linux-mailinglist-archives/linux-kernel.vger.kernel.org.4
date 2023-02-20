Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B121269C8A9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjBTKfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjBTKfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:35:40 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3273718AA6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:35:39 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s5so758498plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+z/NHgpQhXhDjHwBLSYVFwSFC58OGYouAhnx3qnZbzc=;
        b=cR2+TPlFrRVMxJF2vtR+XUF22ifQ2DwQ+KmL+o3334n4nG56Dzt7tAmu/Goj04gSe8
         A1rF89/4VUDtem4fLP+QxijjSP41RTEOu6y9MSxSJqI+P5TNEkun9dw+yB8MinqjNV8n
         sayxWUPperj9IlkR5vL5tVrWfKrGpbdbxT3OF3OgvTHfGQ9Bd2yw9SrvlRoAGNXWQ5KO
         9OPSz/yWQVQONeo0UeupJMyA1RO2lAWDL2cRD0Xp43SYrq7i+8VOd/BFLHQ/r/C7u6bd
         Rz/0ljIIxE2UHR1F+RgVFp2OCspfVIo2yIy5JJDJLat4oSFvaG4RxD/Yg4PN2GgwRV4t
         0OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+z/NHgpQhXhDjHwBLSYVFwSFC58OGYouAhnx3qnZbzc=;
        b=RRCevKebEo3m0epWK/ps7kf++043zxMw+ePorqZyE8IjLpVI++5LPzDt6aaR0EFiiK
         lFTsMUembk3XGOpYRi8senIb9xx3MOqXg0ImAvWtqkcU8gaz1yXxWOqRCAecChuCSV6P
         3lwcY8zfrQYwR56S3dG2jkZgisnUIaY1Wts4zvuE4Kv4eq6a6xYhfnRDhwQHQji9BZGk
         nj/JsGfTfmCBiZyR1ZNr6daAaBrYDpIuco58Xk9cmOqmn5lSOqtnvhNhqhrCy+GtewV2
         PMyHa4F6/846KYKcv2S7vMoxnfPt1T/Yo7lp3sD9qrUqln5pxNptfoPUADn/019kYa9g
         59cQ==
X-Gm-Message-State: AO0yUKUl6OdAoQMO5Y3+tYyu0VB2mTptsPC7koq3qW1Vb79uZczcZM+G
        js7FjaJiU3fZaFNVymUmKYVTY1YEf997HzWtxbFPxQ==
X-Google-Smtp-Source: AK7set+knIauy1BDK1rbRechVdsqIAJg37qEThwNYkh3zSsV+l0YnFb4rk7g2A7/qbYO9RfEUBPgY7BGegAroxZDebA=
X-Received: by 2002:a17:90b:3c05:b0:234:3620:4ac0 with SMTP id
 pb5-20020a17090b3c0500b0023436204ac0mr1287801pjb.110.1676889338557; Mon, 20
 Feb 2023 02:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20230220051723.1257-1-masahisa.kojima@linaro.org>
 <20230220051723.1257-4-masahisa.kojima@linaro.org> <CAFA6WYPdhWAgkBs+ehADVB__5-C9xDmdGL=D9Q5V047yEoL2EA@mail.gmail.com>
In-Reply-To: <CAFA6WYPdhWAgkBs+ehADVB__5-C9xDmdGL=D9Q5V047yEoL2EA@mail.gmail.com>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Mon, 20 Feb 2023 19:35:27 +0900
Message-ID: <CADQ0-X9XAqyavimLS=91h9HYExSCYxKCg6DsGRSgP5L9noGw_Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] tee: expose tee efivar register function
To:     Sumit Garg <sumit.garg@linaro.org>
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

Hi Sumit,

On Mon, 20 Feb 2023 at 18:17, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Masahisa,
>
> On Mon, 20 Feb 2023 at 10:47, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > This commit adds the functions to register/unregister
> > the tee-based EFI variable driver.
> >
>
> I am unsure if this commit adds any value now since the TEE StMM EFI
> driver should be able to directly use efivars_{register/unregister}()
> APIs. Do you expect any other TEE kernel driver to use these?

You are correct.
Now this patch is not required and the StMM EFI driver should directly
register efivars ops. I will remove this patch in the next version.

Thanks,
Masahisa Kojima

>
> -Sumit
>
> > Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  drivers/tee/tee_core.c  | 23 +++++++++++++++++++++++
> >  include/linux/tee_drv.h | 23 +++++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 98da206cd761..0dce5b135d2c 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/cdev.h>
> >  #include <linux/cred.h>
> > +#include <linux/efi.h>
> >  #include <linux/fs.h>
> >  #include <linux/idr.h>
> >  #include <linux/module.h>
> > @@ -1263,6 +1264,28 @@ static void __exit tee_exit(void)
> >         tee_class = NULL;
> >  }
> >
> > +void tee_register_efivar_ops(struct efivars *tee_efivars,
> > +                            struct efivar_operations *ops)
> > +{
> > +       /*
> > +        * If the firmware EFI runtime services support SetVariable(),
> > +        * tee-based EFI variable services are not used.
> > +        */
> > +       if (!efivar_supports_writes()) {
> > +               efivars_generic_ops_unregister();
> > +               pr_info("Use tee-based EFI runtime variable services\n");
> > +               efivars_register(tee_efivars, ops);
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(tee_register_efivar_ops);
> > +
> > +void tee_unregister_efivar_ops(struct efivars *tee_efivars)
> > +{
> > +       efivars_unregister(tee_efivars);
> > +       efivars_generic_ops_register();
> > +}
> > +EXPORT_SYMBOL_GPL(tee_unregister_efivar_ops);
> > +
> >  subsys_initcall(tee_init);
> >  module_exit(tee_exit);
> >
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 17eb1c5205d3..def4ea6212ee 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -7,6 +7,7 @@
> >  #define __TEE_DRV_H
> >
> >  #include <linux/device.h>
> > +#include <linux/efi.h>
> >  #include <linux/idr.h>
> >  #include <linux/kref.h>
> >  #include <linux/list.h>
> > @@ -507,4 +508,26 @@ struct tee_context *teedev_open(struct tee_device *teedev);
> >   */
> >  void teedev_close_context(struct tee_context *ctx);
> >
> > +/**
> > + * tee_register_efivar_ops() - register the efivar ops
> > + * @tee_efivars:       pointer to efivars structure
> > + * @ops:               pointer to contain the efivar operation
> > + *
> > + * This function registers the tee-based efivar operation as an
> > + * EFI Runtime Service.
> > + *
> > + */
> > +void tee_register_efivar_ops(struct efivars *tee_efivars,
> > +                            struct efivar_operations *ops);
> > +
> > +/**
> > + * tee_unregister_efivar_ops() - unregister the efivar ops
> > + * @tee_efivars:       pointer to efivars structure
> > + *
> > + * This function unregisters the tee-based efivar operation
> > + * and reverts to the generic operation.
> > + *
> > + */
> > +void tee_unregister_efivar_ops(struct efivars *tee_efivars);
> > +
> >  #endif /*__TEE_DRV_H*/
> > --
> > 2.30.2
> >
