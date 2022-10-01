Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA305F1B01
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJAJJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJAJJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:09:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7B4152223
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:09:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a2so10173693lfb.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Mi4lVfw+IHcwJ5lVPsJSIkTGyr1PyheHdIcmyKlZe1Y=;
        b=KeDG5TKrOzZ7tm7yp3J+b7W+BW81w/IMLQpDEbBU9eqEupeDKtk2ppnVRKnqXJl/Vc
         LUOjmJx9Xf1VkZRbixMXPa4FqLnXCSmKCV2Udva/3mFlKojaSi5R1bFcYkEivGawXaP5
         WFL0CDeGyJ74O/N8rtkDonrJ/HvopFX+wxUc2TWdHj2Sy0MKMqJZwhYI1/9rUR7F1HD2
         kH+yG4Pgm8Tq1i4B/IQou2o+YNg5Tx+Fsp/8SpFVI8+fA8YIIdO8/52dLwOXbuTJg8QA
         /ALOLx3v8iETZqaC5YCgjtegJlrMYFI+as7pOC6as+XxOUlVjNGWwXFSTknkUNkgxpTK
         ZyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Mi4lVfw+IHcwJ5lVPsJSIkTGyr1PyheHdIcmyKlZe1Y=;
        b=3CL0r15ZgB8cdMaycWHkWCMBAoCUEsoS3H724Fu9GeBLgF8TzYvFJQVZcwlbdQRVNc
         VPjK3cdNuyIsaDPpqirCvRagJ7gZ09gY4PcgumsFCGJV80c6bObGQFqV5b+5/wgxCEy6
         f2759OjENO7OvFiZDVrWGFzeW3JPoj8OcmqOqIpv8JEZI3tXmPt8AjTsSrPjmtr/JNN0
         4NMDGZlXq+EqamUVAL3cLtm1jB0TuLFbfKLEUHQzZckUKeymi0DgZ2B7MLNSj5e2RTbq
         t1haTGsPYjCXW0afws/8F+jMzyFLp5HLXrax+EhykFkKJUdAPUauMoeHvCAD75PxEWpi
         o/9Q==
X-Gm-Message-State: ACrzQf0lnIe/CsR5xDZfW38nFHZczd7o/spLRFtX+AA6HHGPtT+drwGX
        DMxf51/zuN93XmZnAaKvlJN5VQ==
X-Google-Smtp-Source: AMsMyM5r/bKFV4pBSeOFKESQI4LJ0/kAs64NBjyrtwkObyRf5Hz1x/bTiCXe0CrOl8IWvejrqi18wg==
X-Received: by 2002:a05:6512:462:b0:4a2:22ff:e628 with SMTP id x2-20020a056512046200b004a222ffe628mr783765lfd.4.1664615340174;
        Sat, 01 Oct 2022 02:09:00 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q7-20020a0565123a8700b0048aef1abb08sm685433lfu.297.2022.10.01.02.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:08:59 -0700 (PDT)
Message-ID: <0af4b02d-094a-ae12-1365-c5df3f472fe4@linaro.org>
Date:   Sat, 1 Oct 2022 11:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: qcom,sdm845: convert to
 dtschema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
References: <20220930200529.331223-1-krzysztof.kozlowski@linaro.org>
 <20220930200529.331223-3-krzysztof.kozlowski@linaro.org>
 <166457528911.1113207.5679249386040323169.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <166457528911.1113207.5679249386040323169.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2022 00:05, Rob Herring wrote:
> On Fri, 30 Sep 2022 22:05:29 +0200, Krzysztof Kozlowski wrote:
>> Convert Qualcomm SDM845 pin controller bindings to DT schema.  Keep
>> the parsing of pin configuration subnodes consistent with other Qualco=
mm
>> schemas (children named with '-state' suffix, their children with
>> '-pins').
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 176 -----------------=
-
>>  .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml | 158 ++++++++++++++++
>>  2 files changed, 158 insertions(+), 176 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm=
845-pinctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm=
845-pinctrl.yaml
>>
>=20
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>=20
> Note that it is not yet a requirement to have 0 warnings for dtbs_check=
=2E
> This will change in the future.
>=20
> Full log is available here: https://patchwork.ozlabs.org/patch/
>=20
>=20
> pinctrl@3400000: 'ap-edp-bklten', 'ap-suspend-l-hog', 'ap_suspend_l_ass=
ert', 'ap_suspend_l_deassert', 'bios-flash-wp-r-l', 'cci0-default', 'cci0=
-sleep', 'cci1-default', 'cci1-sleep', 'ec-ap-int-l', 'edp-brij-en', 'edp=
-brij-irq', 'en-pp3300-dx-edp', 'h1-ap-int-odl', 'pen-eject-odl', 'pen-ir=
q-l', 'pen-pdct-l', 'pen-rst-l', 'qspi-clk', 'qspi-cs0', 'qspi-cs1', 'qsp=
i-data01', 'qspi-data12', 'quat_mi2s_active', 'quat_mi2s_sd0_active', 'qu=
at_mi2s_sd0_sleep', 'quat_mi2s_sd1_active', 'quat_mi2s_sd1_sleep', 'quat_=
mi2s_sd2_active', 'quat_mi2s_sd2_sleep', 'quat_mi2s_sd3_active', 'quat_mi=
2s_sd3_sleep', 'quat_mi2s_sleep', 'qup-i2c0-default', 'qup-i2c1-default',=
 'qup-i2c10-default', 'qup-i2c11-default', 'qup-i2c12-default', 'qup-i2c1=
3-default', 'qup-i2c14-default', 'qup-i2c15-default', 'qup-i2c2-default',=
 'qup-i2c3-default', 'qup-i2c4-default', 'qup-i2c5-default', 'qup-i2c6-de=
fault', 'qup-i2c7-default', 'qup-i2c8-default', 'qup-i2c9-default', 'qup-=
spi0-default', 'qup-spi1-default', 'qup-spi10-default', 'qup-spi11-defaul=
t', 'qup-spi12-default', 'qup-spi13-default', 'qup-spi14-default', 'qup-s=
pi15-default', 'qup-spi2-default', 'qup-spi3-default', 'qup-spi4-default'=
, 'qup-spi5-default', 'qup-spi6-default', 'qup-spi7-default', 'qup-spi8-d=
efault', 'qup-spi9-default', 'qup-uart0-default', 'qup-uart1-default', 'q=
up-uart10-default', 'qup-uart11-default', 'qup-uart12-default', 'qup-uart=
13-default', 'qup-uart14-default', 'qup-uart15-default', 'qup-uart2-defau=
lt', 'qup-uart3-default', 'qup-uart4-default', 'qup-uart5-default', 'qup-=
uart6-default', 'qup-uart7-default', 'qup-uart8-default', 'qup-uart9-defa=
ult', 'sd-cd-odl', 'sdc2-clk', 'sdc2-cmd', 'sdc2-data', 'ts-int-l', 'ts-r=
eset-l' do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dtb
> 	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dtb
> 	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dtb

This is fixed in patch #1 in this set, however for some reason DT
patchwork did not get it (maybe size too big?).

For reference, the patch is available in Qualcomm patchwork:
https://patchwork.kernel.org/project/linux-arm-msm/patch/20220930200529.3=
31223-2-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

