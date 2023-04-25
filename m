Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7276B6EE532
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbjDYQCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbjDYQCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:02:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FA414F4D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:01:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-505934ccc35so10325176a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1682438518; x=1685030518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RJ+5zJDDMo1/8WJAqxVpdeeLTssXpHq2gUqzpKG5vI=;
        b=SsRkaEkMdg2ndcTNrHlpzZVcvHCluT+lcwzJla6/VU/U35aKL49OMaSKIjnq1o7qNl
         dpePGp7DgeKnjKsOL7mQLIUaShpvWZWxY5SZbMbjO1JeKSNg43koPozOF3iToBrlcwyV
         jzqY5vBpVLEQqO/WlLjdCoC92YNS8ZIW1ReLH7M+7f3mTCGP/hQRYx+vgstLlnZ2lyqu
         Ju1R3yVWOeyvlFEFe4d8Ky4ZFP0ItLLqst/zpKcZcXP7oCrnvZabXzhPT0DzTjySRZYJ
         iBTkV4pe9z72PDSKVaQ7rXJdffKctoRy5T/B4TOr9aBv/aKdi1qlbnwujrJfN2vzVKha
         ou+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682438518; x=1685030518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RJ+5zJDDMo1/8WJAqxVpdeeLTssXpHq2gUqzpKG5vI=;
        b=UEpvcFz28rR6GB29CyHhYxCJuL9L5N31+IsH6IUJtOCt+Nai4F8LHM2vbg/mCdIO3O
         lfdQtEQgG0eOfBCzf9KFtbCNdGb+evHtpZ1oqhUMjEPXqFo09d5YqohWPq68dQ5KQUio
         SEdew3q0t25ROQGtl3geWw21CpEPCxGSrJO3HOOyBGkGyClDw7guwQ+HYXOZcBZHKIgf
         nqb4YqaxfJ34z6iM8mxjpWlCnomK0QVdjwyqCierWx+EFRYG+EpFXxiAhsVeWfvSsxXU
         5gANwrJxp0YqyDNV331gh0IUY5T25JWA6Ks8+449lFOmKNaj7AaAjJGvag8kZflnCI4C
         l96A==
X-Gm-Message-State: AAQBX9e5bd1FpaB4ePdMBjVx92bTU3NVdk3gG1blaVwO2ByB3xnH+WYT
        snE+FH6lqyNMx354xKjTUfHxWyH56En2tDGEN5Z6Pw==
X-Google-Smtp-Source: AKy350aCYt9+H38EzOymUUlzq2ywL6EUgQE4nvIPdQc3H/fw2KwwLtvgjTktdRJECEpkkCcDc+g99yPJJsFFAy6ETQ0=
X-Received: by 2002:a50:fc01:0:b0:502:7d3f:25e9 with SMTP id
 i1-20020a50fc01000000b005027d3f25e9mr15129919edr.1.1682438518376; Tue, 25 Apr
 2023 09:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230414140203.707729-1-pan@semihalf.com> <20230414140203.707729-4-pan@semihalf.com>
 <20230417204150.GA3328603-robh@kernel.org>
In-Reply-To: <20230417204150.GA3328603-robh@kernel.org>
From:   =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Date:   Tue, 25 Apr 2023 18:01:47 +0200
Message-ID: <CAF9_jYQc1QwVNwFjhqgvzO1CHmmKxPLK_MFcqus2S=6Vd8QpYg@mail.gmail.com>
Subject: Re: [PATCH 3/9] dt-bindings: ASoC: Add chv3-audio
To:     Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:41=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Fri, Apr 14, 2023 at 04:01:57PM +0200, Pawe=C5=82 Anikiel wrote:
> > Add binding for chv3-audio device.
> >
> > Signed-off-by: Pawe=C5=82 Anikiel <pan@semihalf.com>
> > ---
> >  .../bindings/sound/google,chv3-audio.yaml     | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/google,chv3=
-audio.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/google,chv3-audio.=
yaml b/Documentation/devicetree/bindings/sound/google,chv3-audio.yaml
> > new file mode 100644
> > index 000000000000..8b602b60eaee
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/google,chv3-audio.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/google,chv3-audio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Google Chameleon v3 audio
> > +
> > +maintainers:
> > +  - Pawe=C5=82 Anikiel <pan@semihalf.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: google,chv3-audio
> > +
> > +  google,audio-cpu0:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of controller #0
> > +
> > +  google,audio-codec0:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of codec #0
> > +
> > +  google,audio-cpu1:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of controller #1
> > +
> > +  google,audio-codec1:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: The phandle of codec #1
>
> Why do you need custom properties when we have standard property to
> point to these things (sound-dai). We also have bindings to handle
> multiple devices.

Thanks, I will read up on that and try to use it here

Regards,
Pawe=C5=82
