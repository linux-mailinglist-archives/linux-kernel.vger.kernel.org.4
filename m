Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67ED6617BF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjAHSFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjAHSFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:05:41 -0500
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BE9FADE;
        Sun,  8 Jan 2023 10:05:38 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id g20so3518363iob.2;
        Sun, 08 Jan 2023 10:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4q02u4YKJwEwJ5w235q3KP904Bt4YMYy+ECpwNFHUc=;
        b=yjOxIZ3S6hNFQQXLShLkSIUC02CqS47nopaQumOCVnL77hduzuR+GLt6pJu1MW1IZT
         e24twArRvjla0OJ1YNkFQt70rjqHKIwzN2NESambjNTT8BuH38VKTxYwops2Eg8QF4Zs
         rsdRyrkIh8HHhOiVyDpfGa55M8agR3QoQMg/MsLFoAvJYdAoh2VYKOlTa+FNnYOEZCCb
         GcnuStpcX9zDQlJS/aQ9Fn2lwWwv7r8CwghiP7ILQqW8HOYX7lIvo4MnJ8TGLJKxWkjj
         edcgvgRhhdcIVambDxwvL+dGshUlXizyAPcHvqNUqlPC4c5NCvE2sPel2HnSRA1vW1AT
         pf9Q==
X-Gm-Message-State: AFqh2kp8xU0hA7dqsAkXb0Z4C+U7SzoxmedX+WB4h+I0i/f0EA1qklMf
        YGusXDLLM7re4nXkcSa8ikOu+szXmw==
X-Google-Smtp-Source: AMrXdXvM0xK7vfhU2j8FSpnnaWboidKMI/eUFI5FTarXacL+fP6aAg3YkqJBw8C2AeNSnn1qNexUHg==
X-Received: by 2002:a5d:840d:0:b0:6ea:6c79:d21d with SMTP id i13-20020a5d840d000000b006ea6c79d21dmr40130442ion.20.1673201137496;
        Sun, 08 Jan 2023 10:05:37 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id d27-20020a02605b000000b00374fbd37c72sm2126236jaf.147.2023.01.08.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:05:37 -0800 (PST)
Received: (nullmailer pid 148261 invoked by uid 1000);
        Sun, 08 Jan 2023 18:05:25 -0000
Date:   Sun, 8 Jan 2023 12:05:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: qcom,qusb2: do not define properties
 in "if" block
Message-ID: <167320112477.148208.15939584193406100216.robh@kernel.org>
References: <20221224154226.43417-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221224154226.43417-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 24 Dec 2022 16:42:26 +0100, Krzysztof Kozlowski wrote:
> It is more readable to define properties in top-level "properties:" and
> restrict them (if needed) per compatible in the "if" block.  Defining
> properties in "if" block  does not work correctly with
> additionalProperties:false:
> 
>   sc7180-trogdor-pazquel-lte-ti.dtb: phy@88e3000: 'qcom,bias-ctrl-value', 'qcom,charge-ctrl-value', 'qcom,hsdisc-trim-value',
>     'qcom,imp-res-offset-value', 'qcom,preemphasis-level', 'qcom,preemphasis-width' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/phy/qcom,qusb2-phy.yaml          | 160 ++++++++++--------
>  1 file changed, 85 insertions(+), 75 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
