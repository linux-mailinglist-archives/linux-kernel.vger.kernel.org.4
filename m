Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4FC72E40A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242606AbjFMNZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242455AbjFMNZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:25:36 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7471B0;
        Tue, 13 Jun 2023 06:25:35 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-62df2192d13so7676466d6.1;
        Tue, 13 Jun 2023 06:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686662735; x=1689254735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGWVSRLSWiSQmgCzVp1crJX1PaYgdtyOOFzd4KI8WPY=;
        b=HWfrF9TfgiK84XltXfvEgJRiai43zOeGut8vINME/9REh2L3cElV8+jnFD9w1O4hCa
         DOSLZRxfWQrvdXAonKLk4FnRb2jIBi7XLmGQgeF3fpheKhw1QiiaXteIPU65Z3BHmabx
         PVBvMLCKFvLvZsn1uFcP9OKv5ZYU/OmETC3D8hALocTj1s02fudpY9GutoTjtLQSfq8N
         BUM19YwPqIKRWmM0hed8lbHmYSNn4IXrLcq6JgCKGChoNCZKD5uyNWifQfBXN5dmMNiy
         tgkqxWiCu53VpV40XJc5vCbXO37JudVTGjb4hjVI4J48uy6frPRTHL4AhmzHS8eD/2WY
         EzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686662735; x=1689254735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGWVSRLSWiSQmgCzVp1crJX1PaYgdtyOOFzd4KI8WPY=;
        b=hcbvx+JEWJUekvXLRT65OrNi3GKOxLebMbgEWpYSb7x2VaeycyzYL31cx8f7zJrXdN
         azZrSlYARefUlBPeHtu/faNybWCjEQ/RxM/0aDl/ZSa4/uLiEZX6j3NjL9WcvB8C6qDd
         9VH8FBmZlPsExhjjqmF6M7NnkXVf+lyQnUatfvCcHXHvPaxZ1WLaFF78fYJfVdZVfJqJ
         EDQ4HpttNeaRJoWYw9ry9posD4Wt1RRDuPDOTrUkkD6pdB2UhvhtuYL7wILVDdjYdzSl
         +eFykw3GzRxUlY495MqVU4itBsWT+6g9mOBHrWnX4dw0Duzk/U0OE1DUg6vOyoAkIIIx
         9odw==
X-Gm-Message-State: AC+VfDzQj6SJkc0qyLp/4tX/16e2/ubzNyCASUXNwzCp7JSmWQT+GWFi
        vmpeXsw4nIPqmA/+4FmUrV1/W8XejDN17AYfno0=
X-Google-Smtp-Source: ACHHUZ5kz189tnuVuyMuffOhKxE4YMOwXJzuYUWwxct+eUXsThGzOBu6ItCuKQ3mJGC+D7Re2VsLvEk8QpOGwIlN9E8=
X-Received: by 2002:a05:6214:1cce:b0:62d:fddb:1856 with SMTP id
 g14-20020a0562141cce00b0062dfddb1856mr392857qvd.43.1686662734879; Tue, 13 Jun
 2023 06:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230612122926.107333-1-herve.codina@bootlin.com>
 <20230612122926.107333-12-herve.codina@bootlin.com> <CAHp75Vfz+vSJ7rQ4sxb0R+zRbrjipXUX3VpaHyvOWWePdPxejQ@mail.gmail.com>
 <20230613113707.0b5d9648@bootlin.com>
In-Reply-To: <20230613113707.0b5d9648@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 13 Jun 2023 16:24:58 +0300
Message-ID: <CAHp75Vd0SNY6XgKwS5j74VftY46MDQ9=Zc3wXwGLOiMc_ZX8Ow@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 12:37=E2=80=AFPM Herve Codina <herve.codina@bootlin=
.com> wrote:
> On Mon, 12 Jun 2023 17:37:00 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> > > +       struct snd_kcontrol_new control =3D {0};
> >
> > 0 is not needed.
>
> Not for this one.
>
> The variable is in stack.
> Some of the structure members will be set in the code but we need to ensu=
re
> that all others are set to 0.

Yes, and as I said, 0 is not needed. Compiler assumes that if you just
use plain {}.

--=20
With Best Regards,
Andy Shevchenko
