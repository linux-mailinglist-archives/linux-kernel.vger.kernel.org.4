Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905B274C695
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGIRT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjGIRT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:19:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8801012E
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:19:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e278e344bso4376409a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688923164; x=1691515164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxMRy4/ZX59Gjw8AFiUdNiqxbSxqjUU/VT1J6LS1+jY=;
        b=V3PEFRinVlmUISMSTEBWWi+A+Id5wM6lxDwOU5Ky/AF6+yTwoHLw2Q5AA3CoCEHmzQ
         oJE2pG3XUai0Tf0ZrgoXcn3+DjuBTQJ5b4fGjgAXVP6eYAhLmshKgn3f2NQ9t8RMjG3c
         l7hg59kXci3I98oc9o04zV8mrReORbwQR1IbhKEV0hCCLtTCEEMvZwVZVilrhetfjUbC
         7bEBBCAWrnWMOh2zGgeQXrQndvWixlVOIB6Pclf9jmXCbYAq+YolUYbxEzifRZLxxgFv
         NjIGMFVHN91iI6PCoFJLXPw5PRP2jwI8Ii4SSaOfHJ/i4TXjfEvwoebT1CU9DwYQOGUm
         KqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688923164; x=1691515164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxMRy4/ZX59Gjw8AFiUdNiqxbSxqjUU/VT1J6LS1+jY=;
        b=Cbh9RVCYVwrO+9CdQ8GH8cLH5wOgfctnQjjGPMWITrmf4QwKpBtusqnk6xEdc5yjsS
         gw9NM0qxIY24+ltMHTB0JqokxikbwUAWx0eDRUIPHb3ZMIPc5eeROlEfTzhM7wcCaIFE
         s9SI4yWYIG++yqcFRXmzcltZrFJCoiDJ0ynq1hRKYVyrPm5krpkOafkK9oz45GHjr5gy
         Q0b44dJKav+Ts4GQUiFZg/QshLgEWEa21dAaR3/59ERBgsQdEbR7gtC2U/Msa0Krr1V0
         byLOB2AXAOHUP+50WbjmDWpJvad5saQoeEoDJ197KzzhaESLHwYvDlOBCzS6B/7xvKF7
         j+Uw==
X-Gm-Message-State: ABy/qLZN9UhYj1NgJLGa+psvJQ/zMHrXIExULE3L8V1tvQd9aXQ9dRZZ
        xP+vrL95QCBnwXK7pE/Y+ubT6w==
X-Google-Smtp-Source: APBJJlEKpLkUgb+Yuq/DwGb4Fz4U6Dm6A0KYZoHWxDN1MSqyW/la+01BJEq2DinOqGC6jvLPHm86Kg==
X-Received: by 2002:a17:906:cc57:b0:989:21e4:6c6e with SMTP id mm23-20020a170906cc5700b0098921e46c6emr8879153ejb.53.1688923163998;
        Sun, 09 Jul 2023 10:19:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id c21-20020a170906341500b00992ab0262c9sm5024947ejb.147.2023.07.09.10.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 10:19:23 -0700 (PDT)
Message-ID: <dffc7942-d9b6-e291-9cab-9a1642225fc3@linaro.org>
Date:   Sun, 9 Jul 2023 19:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 04/11] iio: adc: Update bindings to remove support for
 ADC7 name used on QCOM PMICs
Content-Language: en-US
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        sboyd@kernel.org, dmitry.baryshkov@linaro.org,
        quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
        quic_kamalw@quicinc.com, quic_jestar@quicinc.com,
        marijn.suijten@somainline.org, andriy.shevchenko@linux.intel.com,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Luca Weiss <luca@z3ntu.xyz>,
        linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-arm-msm-owner@vger.kernel.org
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-5-quic_jprakash@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230708072835.3035398-5-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2023 09:28, Jishnu Prakash wrote:
> Now that usage of "ADC7" name has been replaced with usage of "ADC5
> Gen2" name everywhere, remove all support for "ADC7" name.

Why?


> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  5 +-
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |  1 -
>  .../dt-bindings/iio/qcom,spmi-adc7-pm8350.h   | 63 -------------
>  .../dt-bindings/iio/qcom,spmi-adc7-pm8350b.h  | 88 -------------------
>  .../dt-bindings/iio/qcom,spmi-adc7-pmk8350.h  | 46 ----------
>  .../dt-bindings/iio/qcom,spmi-adc7-pmr735a.h  | 28 ------
>  .../dt-bindings/iio/qcom,spmi-adc7-pmr735b.h  | 28 ------
>  include/dt-bindings/iio/qcom,spmi-vadc.h      | 76 ----------------
>  8 files changed, 1 insertion(+), 334 deletions(-)
>  delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
>  delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
>  delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
>  delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
>  delete mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index f886977de165..eb7d16e385ad 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -26,7 +26,6 @@ properties:
>            - qcom,spmi-vadc
>            - qcom,spmi-adc5
>            - qcom,spmi-adc-rev2
> -          - qcom,spmi-adc7

NAK. You did not explained why dropping existing compatible is correct,
expected and okay.

Also:

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.



Best regards,
Krzysztof

