Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F65B6AF892
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjCGWX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjCGWXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:23:02 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B50DABB0E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:22:47 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id c80so5968746ybf.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 14:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678227766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YjSGVFL23aGYtOKm1Ftz/b64+tciORVkVlETDnLgUk=;
        b=D2t4vF6DzPY+77yDIu1t4LFweWOShObHecQg5NqGy/oZK9AjKf5QnwOAFUwW2JwrY+
         vo2Ko3K76Hufbxsgketu/Kq7FNcZwnlOIgaF8CahifqfRieoDIA68MGTO/Nqua8tBp9o
         sa8B540PwXujUNNmfJ2jXarBM0DGPOOEQ3M24Opk+JJCqaza+atah7OXtgMVIFD49esI
         ARhh+ixJG6ViSTC+YegTevzvt35O5lZj9CVx5b3JLS3NMLsZxahY5NZmThxCFv53KokQ
         vWK+kPd40Cg7PJ//fEwHLYiMVoo5EUvsbysXQnchoSHa+i8LrZHgIIU6pe26OiY5IWio
         W/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YjSGVFL23aGYtOKm1Ftz/b64+tciORVkVlETDnLgUk=;
        b=RwFGj+ESFTk/Q+me1uNKXZWH+RMY/o2qxuSEcHRU7AZlDKk208OTo9c5hap6Y37ty6
         xbegiYlMVZ5Og8N6pj5fw4h4e4Qzl7VVRMeYBYPXejlee1WjWAifz0eVYz3xYopz6Af+
         FzpPWzWhv57PTC9RVpZSvquYe6fOib/A5h6TqfxOu3XJQmkKxoEu/vFVroMWHH+l6Bdo
         ps1NFg8Wo3fS3Zr/F52CwHvDPzan7J6WEXUAdhkE6SLXk2gfyBza/68rQWIZpuDuBX8o
         jbbQQnoVgWPI5XYHsfeSEFZLtCHCuhpKYM2NembX9pA57+SWIGOsvcBGO+Zj6O6NTrb1
         zKvQ==
X-Gm-Message-State: AO0yUKVBA2NHBT91tH51kh+/ArXn1VOaQ1+mxVJ9Ur0qV5KSN6Oq+2Lo
        C47tFTMhAHKmkqMO28NuUVRVBgMOJ7hXxy3KO8elKw==
X-Google-Smtp-Source: AK7set9r2P3aZtqkFd8o65fo0pR9pujvbwTr8Q0ckC+reGxZ6RbMx9OnXFP41k7NDPtIp8qWJODCk28Yw6NompBM0ek=
X-Received: by 2002:a05:6902:c3:b0:9f1:6c48:f95f with SMTP id
 i3-20020a05690200c300b009f16c48f95fmr7759792ybs.5.1678227766488; Tue, 07 Mar
 2023 14:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20230220121258.10727-1-lujianhua000@gmail.com>
In-Reply-To: <20230220121258.10727-1-lujianhua000@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Mar 2023 23:22:35 +0100
Message-ID: <CACRpkdZ=6bU2gPv4zVzMBFaCgEY+fkRbrnLAB6NGOhWus1gwaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add Novatek NT36523 bindings
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 1:13=E2=80=AFPM Jianhua Lu <lujianhua000@gmail.com>=
 wrote:

> Novatek NT36523 is a display driver IC used to drive DSI panels.
>
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
> Changes in v2:
>   - Drop unnecessary description
>   - dsi0 -> dsi
>   - Correct indentation

I'd like Konrad and Neil to look at this before we merge it.

> +required:
> +  - compatible
> +  - reg
> +  - vddio-supply
> +  - vddpos-supply
> +  - vddneg-supply

It appears vddpos and vddneg are not necessary on
all variants, can they be made non-required?

It is also possible to do some - if -construction of course
based on the compatible, if we want to be fancy.

Yours,
Linus Walleij
