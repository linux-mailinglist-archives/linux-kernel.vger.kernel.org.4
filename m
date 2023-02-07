Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1461168D48E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjBGKkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjBGKkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:40:18 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FA538647
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:39:58 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso12814764wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5+lhn/RAOgUw5kJseoplTxhKQOuNDKB7ShxrngVaBg0=;
        b=sfOXUWLf/vG+gpGgRo7gTwAn/e/LgG4WP+yYM7wjmuIFGlOjE/k8VpWxVKsZr1aNoW
         atsFDJ4FAzkNnG2pxCm4KGU0cLd6tokq6RcQ3ubC7liKoOj4f51jPSXRBH7NgEGflhMc
         a3DRfoOJm6ACOMfTOMWNyIQIQw+Fojm7KQZzl5OkG+Yd4FBPAbviQXlcHr66nhSybvzx
         /djC6zRZHDpDwW0rjcqdU/7xVCRPKw5z/ztSMBLiu+tZ/1sTCNlde/8yJjRa0Bm6cKW0
         EDV0kA299/W1eoOMVyS9SfS/rXS1xag2KmipmdGSuyj2GTYU7/SYsimd+1LJGmQPnIwq
         N/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+lhn/RAOgUw5kJseoplTxhKQOuNDKB7ShxrngVaBg0=;
        b=EIFWsbJ9FqUw65AL+2GZX48L89P5LH6btK8qSA9d0bEPk6UUEserIacvYw4Sa8tz9D
         3PHcxtKuBGuIjFBLKPPQpPbxEggFkOuEac4kEu5z0QL9RrRUnm+Q+XDY8uhAxl+HpV2s
         1r7O17iXW3IlcSJszFMmVA0xV7X7PbvrrvHgJ1S3x3FAYa8FEbvgX4hu742yyveRkH5E
         VFTyGQwgrX440IOS6p48hpfJLoW/d5jhDitOWLdqHyVCRut0XGEpkkKKMCZVRsw8AdUi
         kA8q/4DUop6EbN8uCaH3xs6nMbz5OMn39gwVUm4qat5GK30FgJsaefpcDxotHaQEQ38p
         RLYg==
X-Gm-Message-State: AO0yUKUO1oGAl1fzvfCLSzsXWcuLjsBUgJXxFikqh7ZMWjIZgBXujyv6
        CHUSXaIJCzMp8xegc9kPOTxLQ5o6yLHpIK6ydqhcbw==
X-Google-Smtp-Source: AK7set/nW3PQBmRun72hManGIFsb4K/hFpw1o/drx6Vo60TIwf+bWdH8QczsZ1xjtr1KiY9b6jYxMRMu6QcjEfCyTwg=
X-Received: by 2002:a7b:cde1:0:b0:3da:fef7:218 with SMTP id
 p1-20020a7bcde1000000b003dafef70218mr239601wmj.94.1675766394811; Tue, 07 Feb
 2023 02:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20230130094157.1082712-1-etienne.carriere@linaro.org>
 <20230130094157.1082712-2-etienne.carriere@linaro.org> <CAFA6WYMDP88=3+NnrwTm_u99M-1BZe5ob-bo4mQDRA=QZ9xQXw@mail.gmail.com>
In-Reply-To: <CAFA6WYMDP88=3+NnrwTm_u99M-1BZe5ob-bo4mQDRA=QZ9xQXw@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 7 Feb 2023 11:39:43 +0100
Message-ID: <CAHUa44Hkd10Rby1JViiMxC9OcNjU6Fn6Q7Gvm=bCwPDWpiNqSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: arm_scmi: optee: use optee system invocation
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 10:59 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Mon, 30 Jan 2023 at 15:12, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Changes SCMI optee transport to enable sys_service capability of
> > its tee context to leverage provisioned system resources in OP-TEE
> > preventing possible deadlock.
> >
> > Such deadlock could happen when many Linux clients invoke OP-TEE are
> > are all suspended waiting for an OP-TEE RPC request access an SCMI
> > resource through the SCMI OP-TEE PTA service.
> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> >  drivers/firmware/arm_scmi/optee.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> > index 2a7aeab40e54..91840345e946 100644
> > --- a/drivers/firmware/arm_scmi/optee.c
> > +++ b/drivers/firmware/arm_scmi/optee.c
> > @@ -559,6 +559,9 @@ static int scmi_optee_service_probe(struct device *dev)
> >         if (IS_ERR(tee_ctx))
> >                 return -ENODEV;
> >
> > +       /* SCMI agent can used TEE system service resources */
> > +       tee_ctx->sys_service = true;
> > +
>
> As per the other thread for patch #1, this feature will only be
> available with OP-TEE supporting TEE_GEN_CAP_REG_MEM. Can we add a
> corresponding conditional check here?

What would be gained by that? If a system thread isn't available or
already is busy we're supposed to fall back to normal threads.

Cheers,
Jens

>
> -Sumit
>
> >         agent = devm_kzalloc(dev, sizeof(*agent), GFP_KERNEL);
> >         if (!agent) {
> >                 ret = -ENOMEM;
> > --
> > 2.25.1
> >
