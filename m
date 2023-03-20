Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC306C1593
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjCTOwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjCTOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:51:44 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DBC2A99A;
        Mon, 20 Mar 2023 07:50:10 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso13302709fac.4;
        Mon, 20 Mar 2023 07:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24gLtemlwEwclYk97xQS3tgIiOLty5AImjT/aeDGFUU=;
        b=OwgEJApZxGZEEEwdblDsB3ZaQxjElwpHGGuBAzOdzg2yNCmCuJjdhzpC/lS9LD6gR9
         HUZt/gN91IlQY3r0a2/6fi1uNAf/FYZ87EVFkpyn6zqTdWnUOZIjGHHplH8gn0fTTIms
         zvwDBKMaSYua1JfQQxq/B00jVUUYYEI2WklLQLuzsdPhTCrdpq0x6lEyKCfQgn9zGqaI
         80gNEJHc8kiFXkWuEij0uBVmoHlMKLaGL971sGghzQcuN16LUYSRi7vYSc1K/62Cp8S1
         DDd/JSm/hu/qw04xzcmqivT3ZdbmoJWPnUsRXLciSHG0zH4d/tjYczcNGk+827bNCFaI
         m47Q==
X-Gm-Message-State: AO0yUKWmoy+GCeZdnGxqyQQ6KQqy57sZrOSulMJVhYLY+8ggRsjHqUSF
        4MY0ef4KbujJAPLoCHFlyw==
X-Google-Smtp-Source: AK7set+RqlXkEMahjquygOnExk5k9/cbtl8ORARJq5x3F2i+ux3p2b42vHbNFUCMROqdgqtZnFU/nA==
X-Received: by 2002:a05:6870:8a1e:b0:17a:a825:6be9 with SMTP id p30-20020a0568708a1e00b0017aa8256be9mr5620143oaq.43.1679323783824;
        Mon, 20 Mar 2023 07:49:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t1-20020a9d7741000000b0068bc48c61a5sm140647otl.19.2023.03.20.07.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:49:43 -0700 (PDT)
Received: (nullmailer pid 1616110 invoked by uid 1000);
        Mon, 20 Mar 2023 14:49:42 -0000
Date:   Mon, 20 Mar 2023 09:49:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 04/14] dt-bindings: mfd: qcom,spmi-pmic: add compatible
 for pmm8654au
Message-ID: <167932378237.1616052.3467011584315312595.robh@kernel.org>
References: <20230314183043.619997-1-brgl@bgdev.pl>
 <20230314183043.619997-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314183043.619997-5-brgl@bgdev.pl>
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


On Tue, 14 Mar 2023 19:30:33 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> PMM8654au is the SPMI PMIC variant used on sa8775p-ride. Add a compatible
> for it.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Lee Jones <lee@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

