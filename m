Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E626A1900
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjBXJov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBXJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:44:45 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C18164D4B;
        Fri, 24 Feb 2023 01:44:44 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id w42so13875635qtc.2;
        Fri, 24 Feb 2023 01:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rt+vMP0zWCVohfkzCAgJ84Zd+cCLEU9rRAW/Bskx1A8=;
        b=Y9BCoryJLeoNcTEeJu/HS7BdBfNoncJUyK2y3Tnkh0TgojCWb24G/tfDIT/uopTznQ
         vCbYRqJMY1LaUL/wf6PPr6X/qYquu//s9MutRyuU3kChW7aKX+RPbdVbad5ghq+4l3Qg
         YNnM27dpk9csSaldZT4/9z6iFkP/t0Gj7wEf2MonWp2+uvsh/SMInF1LyI9KjIpvGagz
         YTTc3XNVcbGM/q/YoO3a3cxYVebtwFTOR5zzsiSLLuGbNbr0lCis8U9uf92sY3hbsM9M
         i1kVYganlYtEJqqD0AqroiGNVsxtdeup+K8HkXsNsa0RpTIVXhoHvcVF0hUXGP3dTfP9
         gp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rt+vMP0zWCVohfkzCAgJ84Zd+cCLEU9rRAW/Bskx1A8=;
        b=rcL5GT8968qnQ4QQglmKToTSLVCs7+96UWtE4yzj4r7g7Ksd4K4YyAdP6w22IQjzxM
         5wLol1KxwU7Lt4sN0jrOpTM/Tdt1Fx50WcYTjbdIx9qFETqiwf3RjMb+GWrARpNpJUq/
         U0dIMM3W2n4jmRiRrfV5JuYfvnExG4JfyZam7ePeP3OyOfsccTIUjXe3PIjQTgb7orDM
         RbVUo+noK+cWLk3VUf4/mOUv+trv6GYx6i/BtG4RqeHDsXQRmQwrym2n0Mgmd/ErkFs/
         fxqEOX0XMxH/0kv4PEFphpBEDNGQr1rrE2GEs7vOVm89ul8nfzyQy8KNrDVkyX/3ebQ0
         l3Iw==
X-Gm-Message-State: AO0yUKVhw9o35/4s5h466dLk7sufasEC7rpt7i7xwYULeC+P6IkGbG2c
        jFZWnbm1Do0f9s3dKPBFZD6JvSHcROQto8xVqyl4vuAtT6620Q==
X-Google-Smtp-Source: AK7set9fh1KW1Np7TalK0fGWQE++L1c5qG8u174r7V49YglPixWlm2FvKcrIM8zX4tVvhuIrrllw+k2IcFgU8UugxYo=
X-Received: by 2002:ac8:4146:0:b0:3b8:6767:eb15 with SMTP id
 e6-20020ac84146000000b003b86767eb15mr2603584qtm.1.1677231883468; Fri, 24 Feb
 2023 01:44:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676042188.git.asmaa@nvidia.com> <cover.1676668853.git.asmaa@nvidia.com>
 <4cda8cfc37fb15a0c3b180ab4c34a6f6f859fe3c.1676668853.git.asmaa@nvidia.com>
 <CAHp75VeTbV7CyVZrXsrm8rqLnYdOunzTDhanqzceyJ3KyPjdwA@mail.gmail.com> <CH2PR12MB38959833A5A4073F8B2A84FDD7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB38959833A5A4073F8B2A84FDD7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Feb 2023 11:44:07 +0200
Message-ID: <CAHp75VdFsxPPnNES0KS2koUGZz1C9dbNZbRtCRQBsFb1csqL7A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] pinctrl: pinctrl-mlxbf: Add pinctrl driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "niyas.sait@linaro.org" <niyas.sait@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
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

On Thu, Feb 23, 2023 at 11:07 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
>
> > > +static const struct {
> > > +       const char *name;
> > > +       const char * const *group_names;
> >
> > Use this instead
> > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-
> > pinctrl.git/tree/include/linux/pinctrl/pinctrl.h?h=3Ddevel#n215
> > and this
> > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-
> > pinctrl.git/tree/include/linux/pinctrl/pinctrl.h?h=3Ddevel#n222
> >
> > > +} mlxbf_pmx_funcs[] =3D {
> >
> > > +};
>
> so copy that struct definition and macro to my driver? (I don=E2=80=99t s=
ee these code changes in master)

Which master?

First of all, you should do your development based on the "for-next"
of the respective subsystem (okay, for pin control Linus Walleij
called his published branch "devel"). So, the above mentioned
functionality was there a while ago.

Second, a couple of days ago Linus Torvalds pulled PR, so it's part of
upstream now.

TL;DR: just use those types and macros in your code.

> > > +       /* This resource is shared so use devm_ioremap */
> >
> > Can you elaborate on who actually requests the region? And why is it no=
t
> > _this_ driver?
>
> This resource is shared with the gpio-mlxbf3.c driver. The gpio-mlxbf3.c =
driver does not access the same offsets as the pinctrl-mlxbf3.c driver, but=
 it accesses several other registers offsets in between.

Okay, so in such a case you need a common denominator that actually
does this all for you via, for example, regmap. If the region is not
requested, bad things may happen.

--=20
With Best Regards,
Andy Shevchenko
