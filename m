Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359B760E570
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiJZQZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiJZQZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:25:31 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1776C974
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:25:26 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a5so10941649qkl.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZQcXM3LzUgWshsooUg5clBTBMHsmZQp0/MMqR4cX+P4=;
        b=lSNvf6A4WkWW5OCLkMXHEgi5PVRpmhUMGOQj+oj0HlOJKE7tQh52O5saaMPQRud5Pc
         PCLwssgxP/yavcI/WI2HMJwtYAKw36nYPhfQrulTvb8JqVcO2T2GeX9v5aDcL3eu5Qhu
         boKvr/pZFau68B2ZVi0uSptZzaPDiVxIp/TEvvxOVZCmOUf5TmudGoGsGsqi0Qm6jVQ1
         du7kLzd0a91NgMATrlvtZyJvf243072+8VmeCSn5TEQGx94HkLFL2q2wzQTgli58hae7
         +bWyBO0qL4NYCEFDpIZkIS5eucvovXF8yCj2tLOcuwwpyTe0hXUO/pIBPpiHNMjwvKM7
         CtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQcXM3LzUgWshsooUg5clBTBMHsmZQp0/MMqR4cX+P4=;
        b=fjylW1j28PRqk/lX8gisYX2Hzt9GL7hFKcJomwVBhFMnIyGQMvoOQppD2cg0sVoZI1
         cO0jdEXIBgc/+My/BBBd7NLxjbUGTNjnkK0XjZSV+4PD+qewZfzUjyLwwZNIxR1z/zEo
         JAURASPn0sHTp+ZR5Qi6cWCH18p+9Uh8iUpoZhYkaeKJqZxQcGB6ze2DzRrspiLg7mJD
         Bwr5592pAgiIvoVRozHwgUcc8EuG6INLrhdMrzdNWjQh4wrdijkvzWjdnpidQ5p5B3Np
         TapNL9hhGdGX3HC5zH0eba8ZSp0GDnFWKd2q7GDl0A01xf7v1BTXzku+V+dxpSR+c7gX
         JbUw==
X-Gm-Message-State: ACrzQf1aQCrE+kkwL8rcyhifsAeSt9DJs0lG6aw5asn8vtXDsJvM1mNN
        JKlUfrlnvODTAlW9fz0vVKSmjDm7u9Ej4A==
X-Google-Smtp-Source: AMsMyM6CJenk5LXXB6LFdb/D6qObP4CtevYOYwPDOlm4Ek1GFD1nya0PG3ERX5JNELbNFaJXjNbEbg==
X-Received: by 2002:a05:620a:4626:b0:6ee:b43:d2bc with SMTP id br38-20020a05620a462600b006ee0b43d2bcmr30134768qkb.764.1666801525700;
        Wed, 26 Oct 2022 09:25:25 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id d2-20020ac80602000000b0039853b7b771sm3321494qth.80.2022.10.26.09.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 09:25:23 -0700 (PDT)
Message-ID: <03447c2c-aba3-ab5a-657e-3604b1d1f695@linaro.org>
Date:   Wed, 26 Oct 2022 12:25:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 0/3] arm64/pinctrl: dt-bindings: qcom: sc7180: convert
 to dtschema
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221020225135.31750-1-krzysztof.kozlowski@linaro.org>
 <CAD=FV=VRgEF=bADEKttmtGqrQ6mDqipGZFRh7JKa5mf4ovF2iA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=VRgEF=bADEKttmtGqrQ6mDqipGZFRh7JKa5mf4ovF2iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 11:33, Doug Anderson wrote:
> Bjorn,
> 
> On Thu, Oct 20, 2022 at 3:51 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Hi,
>>
>> Changes since v3
>> ================
>> 1. Drop bindings patch: applied.
>> 2. Rebase.
>> 3. Add tags.
>>
>> Changes since v2
>> ================
>> 1. New patch: revert of glitch SPI CS workaround
>> 2. dt-bindings: Drop entire drive-strength (not needed, brought by common TLMM
>>    schema).
>> 3. Add tags.
>> v2: https://lore.kernel.org/all/20221013184700.87260-1-krzysztof.kozlowski@linaro.org/
>>
>> Best regards,
>> Krzysztof
>>
>> Krzysztof Kozlowski (3):
>>   arm64: dts: qcom: sc7180-trogdor-homestar: fully configure secondary
>>     I2S pins
>>   arm64: dts: qcom: sc7180: revert "arm64: dts: qcom: sc7180: Avoid
>>     glitching SPI CS at bootup on trogdor"
>>   arm64: dts: qcom: sc7180: align TLMM pin configuration with DT schema
>>
>>  arch/arm64/boot/dts/qcom/sc7180-idp.dts       | 236 +++----
>>  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  36 +-
>>  .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  41 +-
>>  .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts |  16 +-
>>  .../dts/qcom/sc7180-trogdor-kingoftown.dtsi   |   8 +-
>>  .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  16 +-
>>  .../dts/qcom/sc7180-trogdor-mrbland-rev0.dtsi |  25 +-
>>  .../boot/dts/qcom/sc7180-trogdor-mrbland.dtsi |  72 +-
>>  .../qcom/sc7180-trogdor-parade-ps8640.dtsi    |  32 +-
>>  .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi |   8 +-
>>  .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  14 +-
>>  .../qcom/sc7180-trogdor-quackingstick.dtsi    |  56 +-
>>  .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |   8 +-
>>  .../dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi |  16 +-
>>  .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi |  25 +-
>>  .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  72 +-
>>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 650 +++++++-----------
>>  arch/arm64/boot/dts/qcom/sc7180.dtsi          | 597 ++++++++--------
>>  18 files changed, 776 insertions(+), 1152 deletions(-)
> 
> I'd love to see this series land sooner rather than later. It'll cause

Yeah, me too...

> conflicts with pretty much any other patch to a sc7180 device tree
> file, so it'd be nice to get it in the tree. ;-)

It's not only about these series but a bunch of others:
ARM: dts: qcom: msm8974: align TLMM pin configuration with DT schema


... although I see now that some were applied and I did not get any
notification from patchwork.

Best regards,
Krzysztof

