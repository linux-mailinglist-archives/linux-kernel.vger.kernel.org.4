Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE746EF12A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240312AbjDZJ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240364AbjDZJ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:27:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A45A5249
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:27:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-2f625d52275so6586732f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682501252; x=1685093252;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFdiO6joj6arbNGa8AfJTjuA/3lKR1v6syP3aTkc9po=;
        b=RUCCTXqtTiXgX2ZpJnQfOTP4J/4bM7iRPb9l9VsvEoZ8Ym7FVBPjr0o9CQHm3w6tZi
         9ea1AdnkcPf9bXqPnwrMVh696dSaY3vDiMxUp6x04A52dlUlAuebzPWWG2m/ZYINbvdO
         QSKngw/r8n5SPW/diV3f+l4PJrkA/ufwMA7RHOWF13CSUgbHY1xEdapOWsC8gnkLzeCi
         w2yej8YB8fy22C5roJuu9rfWgA59GPtde+KQ0sPl5fLUyLmEAfU+P0aKzLeH3vLlhK7i
         6iqyBs6WPPN9hnKJQ5yidE4cMuCUbNg7uCyUuYeW6jDqz6fKsD7enXP7ScX5PkZYB5Kk
         EVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682501252; x=1685093252;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yFdiO6joj6arbNGa8AfJTjuA/3lKR1v6syP3aTkc9po=;
        b=An97wxWRcvQKcy1cbanXhAj9YtWAyM3Uj6KNBQ8CZ/OU23JRgzRjxR6kQ+k77C1+I1
         C+GV8fubZ3cuB4L+2RuFapYqeVYSQU2MVkwDAkhHPEcBf/l+TYbcT+Vd+m9dTHHwFwRp
         Gj5hXKVkCMX+QdF6f/hrBE7dpcQmVWExhh/9jkPCdOaThPmGxH4o35V0oyfkKfoDaOrf
         CnH3OriFTpnzFSTgTQPFIX/dahYUlwjETBZ7JHxrUeBOQc8e0Uy5J5WAjz9zgCf1TKx+
         6YY2mGIdAYbUhqlOhE6fdfW3UT7t3xc9xew4dJ3+Yi+iQBZNHg2tmFMYcDom8gQKEhpe
         H3JQ==
X-Gm-Message-State: AAQBX9eezs93uaqJbW5CqgsxPzgSQZDgfe6d/IB4uFPfaF2Tv6obUFjy
        sR9EUyjG+y5bkX99TgT6S93FLw==
X-Google-Smtp-Source: AKy350YCR5SLk9yIfPYbZJphyReTqBAA8dDTfdRnPk14FA1stupTXFfWE8sxY9/06ZUWX6TX8cKDIg==
X-Received: by 2002:adf:eacc:0:b0:2fa:aeeb:303e with SMTP id o12-20020adfeacc000000b002faaeeb303emr15293928wrn.12.1682501251675;
        Wed, 26 Apr 2023 02:27:31 -0700 (PDT)
Received: from [172.23.3.48] ([31.221.30.162])
        by smtp.googlemail.com with ESMTPSA id k5-20020adff5c5000000b002f103ca90cdsm15206751wrp.101.2023.04.26.02.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 02:27:31 -0700 (PDT)
Message-ID: <36983e07-832a-868d-6b8d-3656f0a4d873@linaro.org>
Date:   Wed, 26 Apr 2023 11:27:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kang Chen <void0red@hust.edu.cn>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Subject: [GIT PULL] thermal for v6.4-rc1 #3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

can you consider pulling these changes ? They have been in linux-next 
since several days and they fix some minor issues, except one of them 
which is an urgent one for Mediatek.

The following changes since commit 5bc6b1df65c87f8dd7d0afe494a2c0b9d5c73140:

   thermal: intel: int340x: Add DLVR support for RFIM control 
(2023-04-18 15:24:40 +0200)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.4-rc1-3

for you to fetch changes up to 2afa82d1fc648c8d4c2ef9e876626abb1089f9ab:

   dt-bindings: thermal: qcom-tsens: Correct unit address (2023-04-26 
10:38:35 +0200)

----------------------------------------------------------------
- Add compatible strings DT bindings for imx6sll and imx6ul to fix
   dtbs check warning (Stefan Wahren)

- Update the example in the DT bindings to reflect changes with the
   ADC node name for QCom TM and TM5 (Marijn Suijten)

- Fix the comments for the cpuidle_cooling_register() function to
   match the function prototype (Chenggang Wang)

- Fix inconsistent temperature read and some Mediatek variant board
   reboot by reverting a change and handling the temperature
   differently (AngeloGioacchino Del Regno)

- Fix a memory leak in the initialization error path for the Mediatek
   driver (Kang Chen)

- Use of_address_to_resource() in the Mediatek driver (Rob Herring)

- Fix unit address in the QCom tsens driver DT bindings (Krzysztof
   Kozlowski)

----------------------------------------------------------------
AngeloGioacchino Del Regno (2):
       Revert "thermal/drivers/mediatek: Add delay after thermal banks 
initialization"
       thermal/drivers/mediatek: Add temperature constraints to validate 
read

Chenggang Wang (1):
       thermal/drivers/cpuidle_cooling: Delete unmatched comments

Kang Chen (2):
       thermal/drivers/mediatek: Use devm_of_iomap to avoid resource 
leak in mtk_thermal_probe
       thermal/drivers/mediatek: Change clk_prepare_enable to 
devm_clk_get_enabled in mtk_thermal_probe

Krzysztof Kozlowski (1):
       dt-bindings: thermal: qcom-tsens: Correct unit address

Marijn Suijten (1):
       dt-bindings: thermal: Use generic ADC node name in examples

Rob Herring (1):
       thermal/drivers/mediatek: Use of_address_to_resource()

Stefan Wahren (1):
       dt-bindings: imx-thermal: Add imx6sll and imx6ul compatible

  Documentation/devicetree/bindings/thermal/imx-thermal.yaml         | 
14 ++++++++++----
  Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml | 
4 ++--
  Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml   | 
9 ++++++---
  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml          | 
4 ++--
  drivers/thermal/cpuidle_cooling.c                                  | 
3 ---
  drivers/thermal/mediatek/auxadc_thermal.c                          | 
89 
++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------
  6 files changed, 64 insertions(+), 59 deletions(-)




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
