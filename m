Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682AF6564CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 20:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiLZTXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 14:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLZTXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 14:23:48 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E492AFD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 11:23:47 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id kw15so27537520ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 11:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n3b01VwtEzai+EREaidblo11c5/qk2N8EUh1vLnvfDs=;
        b=OLFtGaHMl0AVoG6H78hZtg6oaBSftd3cLEWMfAdCjNh1UcZo29YT7gFRjgl8rtwuVV
         peNihXzPab7mIe9RjA/esbx7wRAdSJSOsN9BaDFyOOtnMM3XSKLKeMBd/EysyPlRBMjW
         4WOJS8Dz5GSAxnbup2UyCOJ59+RqDYHXNmnMf0MqXzNh05a0l+GQ0QF4wg8d2rH7p8pu
         zjKWbg7pFTKhzrK3ZfLgBE7o+pGZ4su7mBMSm7bKaUDfu7i0sMhe/EUZ6+xBt9+XFg1h
         QovnA/++AqN+40HO5QHySL8fYkKXZrAJc3bc3Xki+SrFRc2We7lGkCJ4eXH+lwlDmaDF
         dchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3b01VwtEzai+EREaidblo11c5/qk2N8EUh1vLnvfDs=;
        b=OIWf311OhTKMBXzTvUSvhmBksVaEmog4s9iEqsxQIlIMJDUmaXxdBy0yW0UIcg49SI
         i3+6HP2t/s+MAW2OOwGTSo0dkGXnKefRMAipkRnCr6+s25vxicbEP7LhD63jDl9yQIi5
         WolhiMrofkrJmFVZPIfAex2UGLIPs6DfOIf/eR6OZafaXNeNt74CLHrznoFoad3FUvpt
         jtW6IjSW87N6Dl5fluUgSBQQQTn5+6IgvEHFrJebRgchaJTGltS5zMXAHRTitkbimCoP
         7Xh4rMGcYCKCOHOpFsqt8I/Nb4VxSaBydry0e8DBC5S3vKgFJpA9nnUoMbdMMpn9jbGh
         OhIA==
X-Gm-Message-State: AFqh2kpu69tSHuikxtMClw/mCGbF8hWN1vEjDbd8h5vCOzxCBdAZ+SFL
        kx9rWksTYto0N7YXlQbrdnuqr5mdkGMd1AQzFoxJJw==
X-Google-Smtp-Source: AMrXdXvbiUXpYsruHSQzJqwM+PIVVjTo6P7g/8Fc9ZI0VrIn+GYFFMpTPvnj0QDLZr+oJBf6nuUTOlr+QSfEUBRgahk=
X-Received: by 2002:a17:906:d212:b0:7c4:f402:9766 with SMTP id
 w18-20020a170906d21200b007c4f4029766mr1144497ejz.232.1672082625661; Mon, 26
 Dec 2022 11:23:45 -0800 (PST)
MIME-Version: 1.0
References: <20221225040821.8395-1-steev@kali.org> <20221226004727.204986-1-steev@kali.org>
 <ee597e4b-2656-3852-4daa-f3db7abe6db0@linaro.org>
In-Reply-To: <ee597e4b-2656-3852-4daa-f3db7abe6db0@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Mon, 26 Dec 2022 13:23:34 -0600
Message-ID: <CAKXuJqi-ApBGHewYEhnJJR_s-xf5EAfJA2J1ieww9eZjXYFUYQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: c630: Fix firmware paths
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 6:04 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/12/2022 01:47, Steev Klimaszewski wrote:
> > The firmware paths were pointing to qcom/manufacturer whereas other
> > devices have them under qcom/chipset/manufacturer, so fix this up on the
> > c630, so we follow the same standard setup.
> >
> > Signed-off-by: Steev Klimaszewski <steev@kali.org>
>
> Do not attach your patches to some other threads. It messes with reading
> and applying.
>
> Best regards,
> Krzysztof
>
Sorry, I screwed up my first patch, and this was supposed to be a v2
of that one.  I'll do better on other submissions.
