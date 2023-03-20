Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9666C174C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjCTPMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjCTPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:12:07 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06272F786;
        Mon, 20 Mar 2023 08:06:57 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso13357628fac.4;
        Mon, 20 Mar 2023 08:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679324816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7YpfBMmKik5fyRb1sTMcuw7NMMBv9nAuQ8q/bwtgsQ=;
        b=n/22YNK4rN1K3IyXWPnIUa5wGwkpj6zLelrNEqXjD3GTB44k02OMrLffGYXGMgFl7B
         dqtD8hYO06wQrA49uZAK+ffZhTcEXEpjCnFcOT1cz/VfIUd6E40GOdvsfvtB8e05YZQs
         rOT6FXonW28V9p2wXs8FfLr30NR/qfTVnemVGUm4GY+e8zeeNVqpXZwm70eNjrifUHiX
         FC+UcwjwDfU/eZnb+DiFpYmZ5NlS4O0lctTjiqyKflKYsAQuuPs351mBo0sk1AAu5NW5
         BTrIztt5jr/CH1bOv0Bwx7cX6cAJl9TIK9RJcE3LrkOjbP3/cMXRYAWiIYnjpzg6bekv
         1a3Q==
X-Gm-Message-State: AO0yUKXTuaWPtZyX9CCOKTz4ScVH85PVyC7YqNQLH1neSPkdhqod5UlT
        Rl/2Yi+4O4iybCbqYlKR5A==
X-Google-Smtp-Source: AK7set9mmJhorYDqQuydAs+ZbxnJmb8gTLAvs6lzNv0Uj3eJI4VBeP9nEichYbLiQmPiAGAn/kCe9Q==
X-Received: by 2002:a05:6870:3306:b0:177:9753:f82c with SMTP id x6-20020a056870330600b001779753f82cmr4903005oae.32.1679324816490;
        Mon, 20 Mar 2023 08:06:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o9-20020a9d7649000000b00697be532609sm3991634otl.73.2023.03.20.08.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:06:56 -0700 (PDT)
Received: (nullmailer pid 1671282 invoked by uid 1000);
        Mon, 20 Mar 2023 15:06:55 -0000
Date:   Mon, 20 Mar 2023 10:06:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 12/14] dt-bindings: pinctrl: qcom,pmic-gpio: add
 compatible for pmm8654au-gpio
Message-ID: <167932481463.1671056.6507644110391745897.robh@kernel.org>
References: <20230314183043.619997-1-brgl@bgdev.pl>
 <20230314183043.619997-13-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314183043.619997-13-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Mar 2023 19:30:41 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a new compatible for the GPIO controller on the pm8654au PMIC. It
> has 12 pins with no holes.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

