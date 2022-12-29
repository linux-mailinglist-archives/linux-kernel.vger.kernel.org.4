Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE54E658ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiL2I4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiL2I4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:56:03 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CD41EF;
        Thu, 29 Dec 2022 00:56:02 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id h27so4142708vsq.3;
        Thu, 29 Dec 2022 00:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zdi5JNQLgXGQ66qKu+yMeeWn88rw9Bky4W1XebdlBEw=;
        b=D56q6hHZtVDkrih3nWz96tO0tf1ETJTioa9UJmFtlGOcgLwyVcG0N4bT7abG4iHyTK
         taiOmgzI3/MFU25z/6eACBHBsm0ZUcykUQVJedq9U4CbMYzDxArIv72uYbCo95e4/iK0
         SLxlYWW6Ouq817lvgU6TGpvSl58TdyfDCYYw5vweZ9+y8yHvhRA0JpOCyYo3NedDFKG9
         dx/8A2MIwQqYB4pFcohP8C9/DnmuhH7rjBBMQERFgYCgqkcAf3dnPuNii/PSvymQVGi7
         LCIrQE0ZUI0cygqCW74rY1+eIjvRnYWR5H73K5ndrQNTj46Lj6x4hT8v6ObhbgQddN//
         DMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zdi5JNQLgXGQ66qKu+yMeeWn88rw9Bky4W1XebdlBEw=;
        b=DHQvaqil6DBjCIgQ5dZmR3RPbGUZKxxW7UaM34vz2o9DZ6mpm2vGoCoI7ou9PeH/SF
         U2GtRqMVej5YmAZydmrEkm0acd+T4m1cI12jBr7mq37lppw0KmJodLhzpgaXwOEmqgID
         bD6+XQsJgIPxlSH+ojAPfEibKsR1+8y5wiTJJDKMYReNIHPeskLql4MoZFX8n09oS+tR
         ajwzG0f7PXRwimImkJ7XNRyUz647vTatQThtl40FOhz5HItrPG9fOrw7Gf2TgG0Odw1o
         sJh5O+XVBTgnKLZ/2W95FW/9GBALhG2vZTWeao1XvEn33LGa1w5pz6ls0Hu6PhMODcgX
         gOog==
X-Gm-Message-State: AFqh2kq/RxtYMAESKlMiHe4O5EnHrqtuvNvscawFPEP/37q0gMy3kD6v
        4q/WUHY1EE5I2eW3rswO6OIKlboEWrmFie78FAvqUH1gqjZL8A==
X-Google-Smtp-Source: AMrXdXvNrWrqy7ubjkhG7TGAHD6J4jDrQchAzhwTRpmi1zRv9eF8yToeWNw3Uhq9nGQovgVQ2fqq8ofaBMYifzcDReM=
X-Received: by 2002:a05:6102:f8c:b0:3c9:8cc2:dd04 with SMTP id
 e12-20020a0561020f8c00b003c98cc2dd04mr1182236vsv.73.1672304161401; Thu, 29
 Dec 2022 00:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20221227095123.2447948-1-milkfafa@gmail.com> <20221227095123.2447948-8-milkfafa@gmail.com>
 <b8f173c0-6d40-d6aa-543e-fa8b06557f4f@molgen.mpg.de>
In-Reply-To: <b8f173c0-6d40-d6aa-543e-fa8b06557f4f@molgen.mpg.de>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Thu, 29 Dec 2022 16:55:50 +0800
Message-ID: <CADnNmFr1naRfam=z0p-4hEugSDJy_HCK8XZyQJ0eFirnmwuH4A@mail.gmail.com>
Subject: Re: [PATCH v10 7/7] media: nuvoton: Add driver for NPCM video capture
 and encode engine
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com, kwliu@nuvoton.com,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kflin@nuvoton.com,
        linux-media@vger.kernel.org
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

Hi Paul,

Thanks for the review.

> > Add driver for Video Capture/Differentiation Engine (VCD) and Encoding
> > Compression Engine (ECE) present on Nuvoton NPCM SoCs. The VCD can
> > capture and differentiate video data from digital or analog sources,
>
> =E2=80=9Cdifferentiate video data=E2=80=9D sounds uncommon to me. Am I ju=
st ignorant or
> is there a better term?

How about "The VCD can capture a frame from digital video input and
compare two frames in memory, then the ECE will compress the frame
data into HEXTITLE format", is it better?

> Wich VNC viewer and version?

I used RealVNC version 6.21.1109 to test.
Do I have to add this information in the commit message?

> Maybe also paste the new dev_ log messages
> you get from one boot.

Do you mean dev_info/dev_debug messages of the driver?
If yes, I get these messages from one boot (only dev_info will be
printed in default):

npcm-video f0810000.video: assigned reserved memory node framebuffer@0x3300=
0000
npcm-video f0810000.video: NPCM video driver probed

> It=E2=80=99d be great if you noted the datasheet name and revision.

I can note the datasheet name and revision in the commit message but
can't provide the file link because it is not public.
Is it ok with you?

> > +static unsigned int npcm_video_ece_get_ed_size(struct npcm_video *vide=
o,
> > +                                            u32 offset, u8 *addr)
> > +{
> > +     struct regmap *ece =3D video->ece.regmap;
> > +     u32 size, gap, val;
>
> Using a fixed size type for variables not needing is, is actually not an
> optimization [1]. It=E2=80=99d be great, if you went over the whole chang=
e-set
> to use the non-fixed types, where possible. (You can also check the
> difference with `scripts/bloat-o-meter`.

So what I have to do is replace "u8/u16/u32" with "unsigned int" for
generic local variables as much as possible.
Is my understanding correct?

> > +MODULE_AUTHOR("Joseph Liu<kwliu@nuvoton.com>");
> > +MODULE_AUTHOR("Marvin Lin<kflin@nuvoton.com>");
>
> Please add a space before the <.
>
> > +MODULE_DESCRIPTION("Driver for Nuvoton NPCM Video Capture/Encode Engin=
e");
> > +MODULE_LICENSE("GPL");
>
> Not GPL v2?

I'll correct them in the next patch.

Regards,
Marvin
