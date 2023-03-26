Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044046C96FF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjCZQ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjCZQ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:57:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA784C27;
        Sun, 26 Mar 2023 09:57:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y14so6317813wrq.4;
        Sun, 26 Mar 2023 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679849831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5QdxNjjZRZ0PDxQDn1YuSSVtqF8SC5453jOB4hYT5g=;
        b=k3sRQUiZjU5LJAwQvgLaAo8oHqjvzZ1Xiut5EtrtakbkKdg+fUoo9Nao+pranX0Klp
         HV9rsQryr1O9uVdPZzknU6rlIzV7aCrVPVXdQ2bQoEkB84YXhA8cMT6IxE+ZfVdxqc3z
         hJrETS9YFo6nw85i8U/u9FUJ6wjJx8jNeHugA7DAAE2JxHyTt3fRll9/NZ2qlWKl6xgT
         Wp43C7lBZg2Gmn7oQMZDp35ecpF1VKdbJM3QvrVrjvnU9iSZk5LIPYp2j8AV2b2CQ1Xt
         543OX3aKp/jkzbNt2rIsjb8DSIJizHIDb3pMxtKqK+mBEpCVk1Q0qRtdLw3aJmL2MXkS
         adeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679849831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5QdxNjjZRZ0PDxQDn1YuSSVtqF8SC5453jOB4hYT5g=;
        b=zLDn8/E4e0GSryhYdIVN//+6PxPsRoqf7mVdHImvtzAxR6Ry0gTZHvDyEr4fO3U7L2
         QahRdgqkB61s77Hku+Rv3RaSlqxciEr3Y48yWorJ6jyV2tKfufOjJv+9KsRhb3TLd+dh
         MyeeP0B9QHYdBb57m3mkNuVzsNI2vIlxbPFgcPnBsEKDOqRQ0ljCiSPstrSZatpMFjGX
         RJNoxPLdNOWtO62GzOR648bmGLlmG1hvfOosLDxTyljnuraOFJ/3Tg1i6D6LvwVBFmQA
         XydSPprFDDrlCIeYWYbkLq0lUaKZQicHAyoaUJjMWRGY95s8hZQ0h3aipT1/YtaGVFQY
         deOQ==
X-Gm-Message-State: AAQBX9dIam9hnTFx3oc58hZL/VuLEV0OxXyrIqT9u4kdgZvj/Yw4m27I
        cx7N714U05ducrtK22evzQ4XmBJxHmng1I7Kq7Ycua91EEJaUw==
X-Google-Smtp-Source: AKy350ZQJxyFHb+gYWiDsIv/lZd04YiXPEsVLN4AhFyx1FayiiHaNfFXf94JSdtHVVCwz/tSBiobq0QujLGK4Y/nBWY=
X-Received: by 2002:a5d:59a6:0:b0:2cf:eff8:48a1 with SMTP id
 p6-20020a5d59a6000000b002cfeff848a1mr4501392wrr.2.1679849831193; Sun, 26 Mar
 2023 09:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
 <20230326001535.149539-2-bigbeeshane@gmail.com> <10930783-e1dd-5e75-a2cc-a09af862d949@linaro.org>
 <CABnpCuCzdbWTTp1Gc6wWPsB80J5GYw1QzKtZzzyEYU456E=1JA@mail.gmail.com> <1b9c8e19-10f2-824d-9b50-51e7a9287bb1@linaro.org>
In-Reply-To: <1b9c8e19-10f2-824d-9b50-51e7a9287bb1@linaro.org>
From:   Shane Francis <bigbeeshane@gmail.com>
Date:   Sun, 26 Mar 2023 17:57:00 +0100
Message-ID: <CABnpCuCKYBb_JBqBgMfjEvzUjkzQ6RgKbz9Ny78L+tPKs55wwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: clock: update rk3588 clock definitions
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

So mention this in the commit msg.

On Sun, Mar 26, 2023 at 3:51=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/03/2023 14:02, Shane Francis wrote:
> >> Please wrap commit message according to > > Linux coding style /
> > submission
> >
> > Will do, I haven't submitted patches for a while totally forgot the
> > wrapping guidelines
> >
> >> Unfortunately the reason is not good enough > for ABI break. Replace
> >> vendor boot uboots with open-source one or > just correct them (it's s=
till
> >> U-Boot so even for vendor one you have the source).
> >
> > Replacing uboot is fine for this case, however I can foresee that can c=
ause
> > issues further down the line.
> >
> >
> > 1. No uboot source from the vendor, we all know no everyone respects co=
de
> > licencing
> >
> > 2. Secure environments (like android tables), this chipset will likely =
end
> > up in android tablets that have the secure boot chain enable. These wil=
l be
> > unable to replace uboot even if source is available.
>
> So mention this in the commit msg.
>
> >
> > As this SoC is new to the Linux kernel (not even useable for much it's
> > current state) would it not be better to aling on this so vendor and
> > mainline DTS "agree" now rather than possibly have to address is in the
> > future ?
>
> Then commit msg should also mention it.
>
>
>
> Best regards,
> Krzysztof
>
