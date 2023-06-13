Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C4172E661
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241179AbjFMO4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242952AbjFMOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:54:52 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606BA1BD2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:54:47 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-78cc78d79deso394765241.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686668086; x=1689260086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujKpeDBf4dlsgCHpOAeVReymujxCrTOGm/9TDlUS9o8=;
        b=4yz4ATvwH1tPmaTnf4zVg+ULGJd7OA2GjN6pjySEKg2LlPnbuAfWLgzRLxbOxLDFsy
         t0zLz28hhGrpKT37Q/V6KNpTPpQqASBYD4vInsJa9X8GxiT3/JUMEMR4k3bOBrdAUFYX
         PrAEH9xCmS+Ce5Tv9DKOybyWqaRnFij6oAJ89DSXxg4aW09/5YSg20GJHHXtDN+tJp71
         oHOoLcJWWBAPh4u6UdiJnnL/5SMGmpqYC1SLV+pCUwc38ODvvxRy29maEWOx4AtzK5jY
         JtqFKbDrmDmGXWPAzdPaIIqxxmR1FxwJPLDMyeYp0D0/rnPQp7j2mGuEfM5fu06QyaXQ
         /drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686668086; x=1689260086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujKpeDBf4dlsgCHpOAeVReymujxCrTOGm/9TDlUS9o8=;
        b=KkBebsBAxCEFzfggdemu4ZBpxZWjxPgXsI6cKLUpuwLVu6cG2IRPnBBOkyb7z9HjM3
         jWE/rl4xYdMqy9PBEZokQovEn/vlf0aEPCWRB4FeT0sMu96pW6CnEGNQp8G4ro33Oy4T
         3ko7OhAy3qEluGr3PjeBec3dcWW2h5IMU59gYRavzhHVziVS7asNSMkXTgV0Q1QEbslu
         WjB2L4eQsh8xCHiNB6LXfPuHK4gg3+gOAK80d6Nrf2Lfyh/6B0ev2i9ZTelaP5ZxBl1P
         s/OLw7XlAfo894HZD02GYOn1Y6B8bF4LTer6GUGM3gv5PZ0SyHviuElcL5tCPEezxSoT
         jRxA==
X-Gm-Message-State: AC+VfDzQTLIUFMQ6szL5LsEIyBO7M9jE1GSZtFMbCUh91WqQj6hTh9sG
        0Z98sizQd2dOrIWYXrnzhYpr5ucvzCgz3mY2IPc5CQ==
X-Google-Smtp-Source: ACHHUZ6F0BD0AfkU0XluXJjcMLWPntGpPl2nLiNPAiceu39hatrS3xE+Zp8rfKjyLrBOQhARtVcB0FhfuQlHNJxrDTA=
X-Received: by 2002:a67:f9c7:0:b0:43d:cf39:456c with SMTP id
 c7-20020a67f9c7000000b0043dcf39456cmr4690712vsq.15.1686668086467; Tue, 13 Jun
 2023 07:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de> <20230607115508.2964574-3-l.goehrs@pengutronix.de>
In-Reply-To: <20230607115508.2964574-3-l.goehrs@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 13 Jun 2023 16:54:35 +0200
Message-ID: <CAMRc=Me5VJ5xfNSW2hu2EYwV2wkHJpd+dvx-iGsR70Dso3EX5w@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] dt-bindings: gpio: pca9570: add gpio-line-names property
To:     =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sungbo Eo <mans0n@gorani.run>, kernel@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 1:57=E2=80=AFPM Leonard G=C3=B6hrs <l.goehrs@pengutr=
onix.de> wrote:
>
> This patch allows giving each of the controller's pins a meaningful
> name.
>
> Signed-off-by: Leonard G=C3=B6hrs <l.goehrs@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml b/D=
ocumentation/devicetree/bindings/gpio/gpio-pca9570.yaml
> index 5b0134304e51c..452f8972a9659 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-pca9570.yaml
> @@ -24,6 +24,10 @@ properties:
>    '#gpio-cells':
>      const: 2
>
> +  gpio-line-names:
> +    minItems: 4
> +    maxItems: 8
> +
>  required:
>    - compatible
>    - reg
> --
> 2.39.2
>

Applied, thanks!

Bart
