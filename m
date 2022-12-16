Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE74A64E767
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLPGto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPGtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:49:41 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA7A55A82;
        Thu, 15 Dec 2022 22:49:40 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id r204so725662vkf.8;
        Thu, 15 Dec 2022 22:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9q4hNAhFX5TgKEHkZZjHQgWEJZiBDgjlX0UodJD6O5o=;
        b=qOktYSYrC5bTpZcPM0UPPRZ5QRrj7Apa55cFwDsqMG3d07ElVuL9lmmykstsib2DSm
         4teUj67sEcjvGnu4l3ujj1kd+TFYACgj8+o/Aieapxd0jAqxXtKDQx9SOIToLPYmsjhq
         F331XcTy2SGbj8S83cIDTG20xvvMrfMblPmPtc6vvWPg5H99VxznHk97B8bwijfI1eiD
         Wc2rGM74cKpLasvd3EMHBBcEPvliUBTUhgijY1IZjXHLmE9Co3iRNIii9h+MGkiddS7K
         2x4v0dJe7N1yULmDIb9IXvQRDp0CspmmUtT6x9wYz253qKKvOUuZvwPLKylMhixITVZe
         1tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9q4hNAhFX5TgKEHkZZjHQgWEJZiBDgjlX0UodJD6O5o=;
        b=tP70oaVAcT1PqQvIckuj/ZuNSI/ZIDAXOGb2nkmH3t5PQap7qDZvLnN/EyByrrV95N
         kMB1n0Ryov5G0OkBYzq93ptwL6ShDRYFTB5QGfiA3mlOvHSPeo89vjI4hmHvFj/5v6Zr
         B4byhTX+M5vebGPH5YsQkqRHOwhEtjbiR9sE704LDvJmflgYVItShsYOqUnMHUEQxwCB
         o80dQ+GFszfpJI5z+Xe18C3V8SZUMn2yTXhzPkLqs1xrpszWSBVw50N2tygunLlgbyZv
         eTyA58N1iZjmhihrrFpYEfIAbMPtm78uHCVaL2S2mZKIG635NQCGARo5IrHN3z+5Z5ya
         xd+Q==
X-Gm-Message-State: ANoB5pnuX5ktuE0Qi9UNSO7xM5SkiSxG3Qcduo96n15onzipkx5t3Rol
        H7R6h4mx4N9II5r36jGIdx05VXZ4kXHYUveB6Ao=
X-Google-Smtp-Source: AA0mqf6HfpclnQaKxpSrvKyq1P3aMZh0188ZBlj8B6v1RDg4dTiOwh+APqu68QIhLcVfwQg6sE86qO2mRxKE/xUhZfg=
X-Received: by 2002:a05:6122:50f:b0:3ab:820:316f with SMTP id
 x15-20020a056122050f00b003ab0820316fmr60023855vko.15.1671173379765; Thu, 15
 Dec 2022 22:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20221214092636.810883-1-milkfafa@gmail.com> <20221214092636.810883-4-milkfafa@gmail.com>
 <505acb6e-24c4-45c7-7a54-1a77e3718fec@linaro.org>
In-Reply-To: <505acb6e-24c4-45c7-7a54-1a77e3718fec@linaro.org>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Fri, 16 Dec 2022 14:49:28 +0800
Message-ID: <CADnNmFp9ajB2cPy4rFw6CWiMfbjxp=eS3zk3kV0+U1QWuAgfyQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] dt-bindings: arm: nuvoton: Add bindings for NPCM GFXI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kwliu@nuvoton.com,
        kflin@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B412=E6=9C=8815=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:58=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> On 14/12/2022 10:26, Marvin Lin wrote:
> > Add dt-bindings document for Graphics Core Information (GFXI) node. It
> > is used by NPCM video driver to retrieve Graphics core information.
> >
> > Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> > ---
>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>

Thank you for your review!

Regards,
Marvin
