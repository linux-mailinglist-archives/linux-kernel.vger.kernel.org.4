Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F805F6609
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJFM2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiJFM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:28:02 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8679B85E;
        Thu,  6 Oct 2022 05:28:01 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id u19-20020a4a9e93000000b004757198549cso1317824ook.0;
        Thu, 06 Oct 2022 05:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LD+/bVMKWMVi1TdoFb/7Rk7QFNHmQh7iMpdXxnsmZnM=;
        b=BbWQuCJvv4WEhStyPG8W5AL4pv6qujtjfc88fW8X0KoCethazL9IstDRWgJKkZaPFa
         WVZoVg8EkcDVBrt64+4oCcEz4IK9ThwFOtmxiR/9rn1H7OSV2DlJ8C53FFDCNIJb5Fl5
         VFmhBbXgL0a7bpaazIKR9IkcBPXfHcwA7NcI+v5qsp9+LZN1nwLPC0QHKdKsvm1frfXl
         uKGUfn2J2lhebiKE9MOUHVY5eA0fJFfSfVZCeCdZvHjhXoVteGW9eHblbxCVLJCo5mry
         JP3t22MZfjL6hrZ3SbJTaFcoYYDlvTcS/2oS+CYnVgZhb44RRQasKkGke3GRk3CzG/Jd
         nAfA==
X-Gm-Message-State: ACrzQf3W5BpkJ8fRJlg99xkHKLcbDLN5r6HlFbhaO4Wpho5VfSrtpEA2
        21gkjrq7yuz9XMLf1MJCQxLlrS02aw==
X-Google-Smtp-Source: AMsMyM6vEm0NpFozxeOWrt/cdZf0yoOiGMfTBbW4yKmcM3Yv5D2tCZ+gIN1JXJoyWpdYFDibLQL2yg==
X-Received: by 2002:a05:6830:650a:b0:655:e38b:dcd4 with SMTP id cm10-20020a056830650a00b00655e38bdcd4mr1730591otb.189.1665059280885;
        Thu, 06 Oct 2022 05:28:00 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o64-20020aca4143000000b00342ded07a75sm5652474oia.18.2022.10.06.05.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:27:59 -0700 (PDT)
Received: (nullmailer pid 1613451 invoked by uid 1000);
        Thu, 06 Oct 2022 12:27:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-gpio@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v1-1-0cbc006e2a30@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org> <20221005-mdm9615-pinctrl-yaml-v1-1-0cbc006e2a30@linaro.org>
Message-Id: <166505882828.1602503.18185089088624527425.robh@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: pinctrl: convert qcom,mdm9615-pinctrl.txt to dt-schema
Date:   Thu, 06 Oct 2022 07:27:55 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 09:57:58 +0000, Neil Armstrong wrote:
> Convert the MDM9515 pinctrl bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt      | 161 ---------------------
>  .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     | 101 +++++++++++++
>  2 files changed, 101 insertions(+), 161 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


pinctrl@800000: 'gpioext1_pins', 'gsbi3_pins', 'gsbi4_pins', 'gsbi5_i2c_pins', 'gsbi5_uart_pins', 'reset_out_pins', 'sdc_cd_pins' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb

