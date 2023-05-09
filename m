Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6BF6FC419
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjEIKjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjEIKjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:39:44 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E271FCA
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:39:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-956ff2399c9so1073392166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1683628782; x=1686220782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRU5PEt+oDmkOJvCwl4AyqNhX/jjlVJcC8ztVdTKQLE=;
        b=X+rZIzKPdMbSlBMThdYfAojZTGhcsUbH9SWbS0mPquMKSXjX3kEtZ+AqsebDyh9xaW
         lE0GJl13J0k49ij3784AOfGHEhBxqujNOV0kvuvfZJjIkaUQOgJutt/4m1iCNvg8jFj3
         8Mu0H8hPnQmC4hiKwlnrKHAmAkvwgZfdGbd9xwQ7bsR8F/JzpI3Tyk7jUt6MfeYp4kbU
         IidhgNrwy93u5zMw8bN3Dl9KLC3fObB9FPjP8zLXTEPoODpGUeD0D7WYqZpkU5fqQIRQ
         KNVpTGiSxyhwmPa5wDelpGQYZ/XivJoLXWJmN/4s+n31zNAdoMCiHmHWFqy9yQ5E9yhj
         SBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683628782; x=1686220782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRU5PEt+oDmkOJvCwl4AyqNhX/jjlVJcC8ztVdTKQLE=;
        b=lGc9z9/n3o4XZGbjmVQJt2aM4ORDUc+mbxQsN/sKdkDEP4YhC5Gh637Rkje0eCEdNZ
         smWyd5bgVLfWjKTxihiX+RAydwFBhfp767qY74Eqm2tI9riLOo4KZdOjkJKd/iDxh/8r
         GX/Gbkhfpuo8zRPtq+EXhij3fKet0x+aNSqksyRx3G6eyhKwJexnY5+i7y6MbMY9dhhg
         1Yfqu93koeVUsx3IQEl3hB999kgF9mbVFRFU8fcX+vVRkGTxcV63wTRHrVJcAS5IBwOr
         K6wuKXNRT9YeDg8oROZQfZoigL07YxkI1u3Tcp0+iDiJzXlApvIXQDOYJ9Cw9uVeGMRN
         46Sg==
X-Gm-Message-State: AC+VfDzPvpphRt60K80pE1BgS9auPgM/rgrUbGuBf7y60BEMduN5J7u2
        PFFTChFq+8rLLlksLlxvUaa8Cg2LdT0O/HWS7AUNdw==
X-Google-Smtp-Source: ACHHUZ5X1A7lGSzOUQocjKDUPJO/UZV85RYU+AZC28CWaOm5bVpor/ag+VkqoWqHXFa5J7LyWaMGHQcKCW2raQWEHoo=
X-Received: by 2002:a17:907:1c03:b0:94e:4489:f24d with SMTP id
 nc3-20020a1709071c0300b0094e4489f24dmr11943775ejc.61.1683628781939; Tue, 09
 May 2023 03:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230508113037.137627-1-pan@semihalf.com> <20230508113037.137627-5-pan@semihalf.com>
 <b8306c55-8551-4c86-f85d-3aebe1ad0ca1@linaro.org> <ZFoYai1Zawd4GGtU@finisterre.sirena.org.uk>
In-Reply-To: <ZFoYai1Zawd4GGtU@finisterre.sirena.org.uk>
From:   =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Date:   Tue, 9 May 2023 12:39:31 +0200
Message-ID: <CAF9_jYSXxmnm80Yq4gD6U5ygHvBTDagR_HM4LcHQT1vq=d7tVw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] ASoC: dt-bindings: Add Google Chameleon v3 audio codec
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        amstan@chromium.org
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

On Tue, May 9, 2023 at 11:54=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, May 09, 2023 at 08:18:15AM +0200, Krzysztof Kozlowski wrote:
> > On 08/05/2023 13:30, Pawe=C5=82 Anikiel wrote:
>
> > > +  "#sound-dai-cells":
> > > +    const: 0
>
> > No supplies? How do you get power?
>
> My understanding is that this is deployed to a FPGA so the power would
> be going into the FPGA.  In general a memory mapped I2S controller like
> this will be part of a larger SoC of some kind.

Yes, both the codec and i2s controller are implemented in the FPGA
part of the Arria 10 SoC.

Regards,
Pawe=C5=82
