Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8466016E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJQTEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJQTEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:04:39 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0D812D28;
        Mon, 17 Oct 2022 12:04:37 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id g10so13166526oif.10;
        Mon, 17 Oct 2022 12:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOP2b9Nau8iEeSvyNn6E8PPEtGHiAXX+/w7I4SFcS4I=;
        b=OduiD0zzbEOMnP2ZwdY4/guD8sC4rcIy/61h5b8yHSXBL+l4lF/ZRrybU4YCMz7A+f
         DscnnV0ZyDP3zqp6wE88gUF2UeLaL3kZnJA68z7rafF1A9WYYJIwmhb3PLUMwVf30rOk
         s6FKSpI7CY6a5WE56uNIdelcSbR6JpTlGCdbe7KHD+W4jFl3XsD9gWGwGEI8xer7xa9X
         77DUJbsQvuOqVL/CQlfSF9ugBMDiC+RMGWq3HXdTduD1wUiTRTt0G7H/KVrTVq/Nfmvk
         7xRJqRgulLFxZLak63y+dRjMGJVxrhKnvwrwt7t6UbYqLzJ4NYkztipO9AW5zk7oTVp2
         B+jQ==
X-Gm-Message-State: ACrzQf3J8GnapUK/Th95LitqKjVvV05S+NKsIhxHed38AYCO5ahT/3zT
        CeZdmgQC58IqGbiwa0tMVQ==
X-Google-Smtp-Source: AMsMyM7gUX9iEsWtrsviepRzM8t4rKYICHZWOu6v02gWK7pLfbAlZLF73bl7W7Fn55GknUxce5Z62w==
X-Received: by 2002:aca:5808:0:b0:350:9790:7fe with SMTP id m8-20020aca5808000000b00350979007femr14498202oib.79.1666033476307;
        Mon, 17 Oct 2022 12:04:36 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 94-20020a9d0de7000000b006619295af60sm5026981ots.70.2022.10.17.12.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:04:35 -0700 (PDT)
Received: (nullmailer pid 2292539 invoked by uid 1000);
        Mon, 17 Oct 2022 19:04:36 -0000
Date:   Mon, 17 Oct 2022 14:04:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-gpio@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: pinctrl: convert
 qcom,mdm9615-pinctrl.txt to dt-schema
Message-ID: <166603347554.2292483.5082356726414220368.robh@kernel.org>
References: <20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v2-1-639fe67a04be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v2-1-639fe67a04be@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 12:23:05 +0200, Neil Armstrong wrote:
> Convert the MDM9515 pinctrl bindings to dt-schema.
> Keep the parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, optional children with '-pins').
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt      | 161 ---------------------
>  .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     | 120 +++++++++++++++
>  2 files changed, 120 insertions(+), 161 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
