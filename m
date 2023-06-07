Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E66725663
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbjFGHvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbjFGHvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:51:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308AF2D59
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:49:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-973f78329e3so1139553666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686124148; x=1688716148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sUmif8+PJuo1t9H5/fS1dgHw3TEAkR2eQjvlt4ezA7Y=;
        b=P//BIhq2msQubwmODXxKb6JMeyvTjBvQ7lbTXY2gQ08CaAF0kghL3k6b9lqkt8FzMC
         l5d1TtpqSOvfyUtwOs6t9fJGjGr6OAOOFCr8KdA/0CiuTDZGpOw9QcDvrVghXtVi5/Ua
         jfBXi0gYHDWW8D+3aXrjQg47fdqv19wnx5RGN79FZcRb1uKUjriNk1SbCDUdcw944Mm7
         eHpxaVbt/HIWxvO6ffpXA8QYIF9JLhWdqZIp8x00pl4dGrrFpm3Z/1Qdb/epsMjWiZra
         hVk+egKKHJOATS9i7uAE2hJh02f8jyO5P3Y22+OSefH1M/AU6I9MT47/6vczZqSfdLbZ
         UBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686124148; x=1688716148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUmif8+PJuo1t9H5/fS1dgHw3TEAkR2eQjvlt4ezA7Y=;
        b=X4ABAALQHRXU/XgSWPt89dnEKB7I0lCp4SThkUI/9fWUJrQ+tjcz8hMI56TCCmeXNN
         cV6E2VoZNPlEGuIKoAXkgqudySWd0qnElm28XzVj4dsKebjw1wqD+5fXiC0cTopFfdma
         HmJlMv0nVLookDeXAI5MeuD/rQmtG3vSvtN4iz0hCS9PvsY2OzI02Cz2WB8a1JgNkEzk
         QLSoKw++/CbeZFKpQjufUfEhTtCCYhZR1+fDxNRwnP3FCirCu/vHmmgku3aoSK4Upnny
         bOnZUqGyAYpnO68A7LZcGmiELa/kDWJk1Rvqvbxj0u0vBhqVL8UzYCLvLBhZl5gkuZIe
         ckTg==
X-Gm-Message-State: AC+VfDwmPQeGQW7n3xgXP3JxXFBnJPAWnumi8R++y1RrvA1nuBNXITxm
        J1UgGG/pGHIXvQN3HKp/XUwDBw==
X-Google-Smtp-Source: ACHHUZ4tHicUEQZZDx3qvkqytJ1UUjgre5Dp5VZ4TgLhAgMrJ77wvl2/vrm+tWipBTJaMBWuLCjwNw==
X-Received: by 2002:a17:907:6e0d:b0:974:c32c:b485 with SMTP id sd13-20020a1709076e0d00b00974c32cb485mr4637812ejc.45.1686124148561;
        Wed, 07 Jun 2023 00:49:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x22-20020a1709060a5600b0096f6a131b9fsm6533605ejf.23.2023.06.07.00.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 00:49:08 -0700 (PDT)
Message-ID: <d0dfdfba-7a70-7d12-2c30-ad32b3f95bb8@linaro.org>
Date:   Wed, 7 Jun 2023 09:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Move LVS regulator nodes
 up
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Amit Pundir <amit.pundir@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        regressions <regressions@lists.linux.dev>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230602161246.1855448-1-amit.pundir@linaro.org>
 <CAD=FV=U9xwxC4+wDYFMSoLWaj8vaLH_jettZ=nxEZP+1tNk=oA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=U9xwxC4+wDYFMSoLWaj8vaLH_jettZ=nxEZP+1tNk=oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 01:34, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jun 2, 2023 at 9:12 AM Amit Pundir <amit.pundir@linaro.org> wrote:
>>
>> Move lvs1 and lvs2 regulator nodes up in the rpmh-regulators
>> list to workaround a boot regression uncovered by the upstream
>> commit ad44ac082fdf ("regulator: qcom-rpmh: Revert "regulator:
>> qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"").
>>
>> Without this fix DB845c fail to boot at times because one of the
>> lvs1 or lvs2 regulators fail to turn ON in time.
>>
>> Link: https://lore.kernel.org/all/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/
>> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 24 +++++++++++-----------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>> index e14fe9bbb386..df2fde9063dc 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>> @@ -301,6 +301,18 @@ regulators-0 {
>>                 vdd-l26-supply = <&vreg_s3a_1p35>;
>>                 vin-lvs-1-2-supply = <&vreg_s4a_1p8>;
>>
>> +               vreg_lvs1a_1p8: lvs1 {
>> +                       regulator-min-microvolt = <1800000>;
>> +                       regulator-max-microvolt = <1800000>;
>> +                       regulator-always-on;
>> +               };
>> +
>> +               vreg_lvs2a_1p8: lvs2 {
>> +                       regulator-min-microvolt = <1800000>;
>> +                       regulator-max-microvolt = <1800000>;
>> +                       regulator-always-on;
>> +               };
>> +
>>                 vreg_s3a_1p35: smps3 {
>>                         regulator-min-microvolt = <1352000>;
>>                         regulator-max-microvolt = <1352000>;
>> @@ -381,18 +393,6 @@ vreg_l26a_1p2: ldo26 {
>>                         regulator-max-microvolt = <1200000>;
>>                         regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>                 };
>> -
>> -               vreg_lvs1a_1p8: lvs1 {
>> -                       regulator-min-microvolt = <1800000>;
>> -                       regulator-max-microvolt = <1800000>;
>> -                       regulator-always-on;
>> -               };
>> -
>> -               vreg_lvs2a_1p8: lvs2 {
>> -                       regulator-min-microvolt = <1800000>;
>> -                       regulator-max-microvolt = <1800000>;
>> -                       regulator-always-on;
>> -               };
> 
> This is a hack, but it at least feels less bad than reverting the
> async probe patch. I'll leave it to Bjorn to decide if he's OK with
> it. Personally, it feels like this would deserve a comment in the dts
> to document that these regulators need to be listed first.
> 
> Ideally, we could still work towards a root cause. I added a few more
> ideas to help with root causing in reply to the original thread about
> this.
> 
> https://lore.kernel.org/r/CAD=FV=UKyjRNZG-ED2meUAR9aXdco+AbUTHiKixTzjCkaJbjTg@mail.gmail.com/

We do not shape DTS based on given OS behavior. AOSP needs this, BSD
needs that and Linux needs something else. Next time someone will move
these regulators down because on his system probing is from end of list,
not beginning and he has the same problem.

No, really, are we going to reshuffle nodes because AOSP needs it?

Best regards,
Krzysztof

