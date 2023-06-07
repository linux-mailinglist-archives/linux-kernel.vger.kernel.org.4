Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8F3725B65
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjFGKRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbjFGKRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:17:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCC21BD5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:16:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso1200155a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686133018; x=1688725018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHtmIDD4uaTq4ABNxhYKW6qHDGlLDL1+HvFDCmmnPDM=;
        b=aMzYf6YMdsw58k4/wDNtAfJLXXqxovmskhmugL855D5kSCqCJjdRY+o2q8WTho6dy7
         r9INUS6z3glv3VuHQ+s872OmExPym88zOxwEvr66swh/5vYkAiY0wmzn9BsHFRaGXrzh
         vb+DSlYUKFwAYBznX2p3t+gpnGYKxtQoakYYUy0FkUHDsJ6MCLoqTK2NgY5sMntJHOn+
         TImv1OfDcFMGIvEkZ+iLp+bZy7I3Gz0WXSEbefn8Akij7Lhv6wat8MqIUfNGInASKTbj
         4cyhJjHxqVwQfYg4mjvBWhkGuZI1dWIH/4f/E4JGdBy5nxV2T+Pi6k2mDkG1ws9foy5w
         9Yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686133018; x=1688725018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHtmIDD4uaTq4ABNxhYKW6qHDGlLDL1+HvFDCmmnPDM=;
        b=LoxiyMKKbvaVIBEjOjQWA2ZRzRhXvm2tKJ6KmEeduP5Ggcvij7fsmOmV7c+jv0wUTy
         j+zZB6WXUZFZHZ+4JBdw1muNZ26+xvRIbs+bO2KqxIRwkJQPAmQ3y3OmIu+p4CKfpHrE
         0sqpnfQw4RPIGHBW/PgwEZyOk5sZk9VeUqO5nK+Tje6MumxATUz5jjUR5h06o23EiyG3
         GBMGkSY3LAU4UUd2pGtx2bbxhw19kkAVRoKR6NdgsE9iHYKC6RnESPHnL//8qlRvL/LI
         hMPntqCSS4UfKd2CTYEy15mdZYwhbiNTS0spPWIGInxP4DB13N1IJhX1KJ76uFd6AZvu
         z/vg==
X-Gm-Message-State: AC+VfDxKDu/3Y94eSTFylBSLSM0WSJxa4rgazJwiAfCX3CxUu9X7yqn1
        jjPNmGSlvFSryUupdEbIK8fyDQ==
X-Google-Smtp-Source: ACHHUZ4lRRxrWth26CaqnLWO9ge6gORx93AXTbvI8KrjJTI8Zd7pTHxYuR04YqlYa5SlHY4O/9m+EA==
X-Received: by 2002:aa7:d315:0:b0:510:82b4:844d with SMTP id p21-20020aa7d315000000b0051082b4844dmr3980381edq.2.1686133017905;
        Wed, 07 Jun 2023 03:16:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w15-20020a056402070f00b00514bb73b8casm6158198edx.57.2023.06.07.03.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 03:16:57 -0700 (PDT)
Message-ID: <55f07600-3fa5-f3c2-eb3e-e87a57244812@linaro.org>
Date:   Wed, 7 Jun 2023 12:16:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Move LVS regulator nodes
 up
Content-Language: en-US
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
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
 <d0dfdfba-7a70-7d12-2c30-ad32b3f95bb8@linaro.org>
 <CAMi1Hd1Upo8zV4MPtdqHgEaMQ72yK0gZgf5Z4uOaqKqhw8Hndg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMi1Hd1Upo8zV4MPtdqHgEaMQ72yK0gZgf5Z4uOaqKqhw8Hndg@mail.gmail.com>
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

On 07/06/2023 11:17, Amit Pundir wrote:
> On Wed, 7 Jun 2023 at 13:19, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 07/06/2023 01:34, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Fri, Jun 2, 2023 at 9:12 AM Amit Pundir <amit.pundir@linaro.org> wrote:
>>>>
>>>> Move lvs1 and lvs2 regulator nodes up in the rpmh-regulators
>>>> list to workaround a boot regression uncovered by the upstream
>>>> commit ad44ac082fdf ("regulator: qcom-rpmh: Revert "regulator:
>>>> qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"").
>>>>
>>>> Without this fix DB845c fail to boot at times because one of the
>>>> lvs1 or lvs2 regulators fail to turn ON in time.
>>>>
>>>> Link: https://lore.kernel.org/all/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/
>>>> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 24 +++++++++++-----------
>>>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>>> index e14fe9bbb386..df2fde9063dc 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>>> @@ -301,6 +301,18 @@ regulators-0 {
>>>>                 vdd-l26-supply = <&vreg_s3a_1p35>;
>>>>                 vin-lvs-1-2-supply = <&vreg_s4a_1p8>;
>>>>
>>>> +               vreg_lvs1a_1p8: lvs1 {
>>>> +                       regulator-min-microvolt = <1800000>;
>>>> +                       regulator-max-microvolt = <1800000>;
>>>> +                       regulator-always-on;
>>>> +               };
>>>> +
>>>> +               vreg_lvs2a_1p8: lvs2 {
>>>> +                       regulator-min-microvolt = <1800000>;
>>>> +                       regulator-max-microvolt = <1800000>;
>>>> +                       regulator-always-on;
>>>> +               };
>>>> +
>>>>                 vreg_s3a_1p35: smps3 {
>>>>                         regulator-min-microvolt = <1352000>;
>>>>                         regulator-max-microvolt = <1352000>;
>>>> @@ -381,18 +393,6 @@ vreg_l26a_1p2: ldo26 {
>>>>                         regulator-max-microvolt = <1200000>;
>>>>                         regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>>>                 };
>>>> -
>>>> -               vreg_lvs1a_1p8: lvs1 {
>>>> -                       regulator-min-microvolt = <1800000>;
>>>> -                       regulator-max-microvolt = <1800000>;
>>>> -                       regulator-always-on;
>>>> -               };
>>>> -
>>>> -               vreg_lvs2a_1p8: lvs2 {
>>>> -                       regulator-min-microvolt = <1800000>;
>>>> -                       regulator-max-microvolt = <1800000>;
>>>> -                       regulator-always-on;
>>>> -               };
>>>
>>> This is a hack, but it at least feels less bad than reverting the
>>> async probe patch. I'll leave it to Bjorn to decide if he's OK with
>>> it. Personally, it feels like this would deserve a comment in the dts
>>> to document that these regulators need to be listed first.
>>>
>>> Ideally, we could still work towards a root cause. I added a few more
>>> ideas to help with root causing in reply to the original thread about
>>> this.
>>>
>>> https://lore.kernel.org/r/CAD=FV=UKyjRNZG-ED2meUAR9aXdco+AbUTHiKixTzjCkaJbjTg@mail.gmail.com/
>>
>> We do not shape DTS based on given OS behavior. AOSP needs this, BSD
>> needs that and Linux needs something else. Next time someone will move
>> these regulators down because on his system probing is from end of list,
>> not beginning and he has the same problem.
>>
>> No, really, are we going to reshuffle nodes because AOSP needs it?
> 
> Hi, other than the fact that I reproduced it on AOSP, there is nothing
> AOSP specific in this patch. I'm sure there may be another
> platforms/OS (which load kernel modules from a ramdisk) that may trip
> on this bug. But I can try reproducing it on an OS of your choice if
> it helps.

I wrote earlier imaginary system where RPM driver loads the regulators
from the end. It would require re-shuffling to previous order of the
nodes. Feel free to change the RPM drivers to simulate it and you should
see that your patch stops helping.

The problem looks like in missing consumers, missing probe dependencies
or something in the driver how it handles these.

DTS should not be used for solving OS related problems.

Best regards,
Krzysztof

