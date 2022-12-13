Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AD064BF2B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbiLMWMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbiLMWMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:12:34 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FD9193DB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:12:32 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id q6so7306437lfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T57htGX7w3pkH4iZZTnHtoAqVjQqavKl1hAXdV9m3Xw=;
        b=aWL7c0bP6EiVYuu/P0uqLB73C7ZV/p4lnopcLYdPlg5vBlfdWSSS5J5K+68KyrWS2o
         jEqKn65kKUCDERq3/4Kc27EWfEu3nisJcQ86SU4Ef3i5kuJJtmtDThP9/tESLNCMsqWI
         /JtF/+sislqE8NIhkmm8tO6vgCALEVSHey2x8igeGSmA3ItCGa+cvhybGm6/BJz4pqwh
         V/hBcq6fzfg+1XhARv7E4x2ql/AvFifeRkUWuTnE4JXQxY0wE6R9NuCXY8Nt1F0xafiS
         2KfaRgv2mwmEOmZZ3umY5AmcRvK/TPa89EpnVXId5xqsTEj+/29aDnVj2X6BaSIIOPCu
         aYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T57htGX7w3pkH4iZZTnHtoAqVjQqavKl1hAXdV9m3Xw=;
        b=v0T+cry2u9gLQk74FMbvEZ6C2SLyAIKbRQB7OFwAQC82s0M4h4h6Hvo297Vpk8QQ7v
         PWqvU0iie2mR5mRq6M1/gdxwrvXHobsX554o65e9Jlue3a45l/7VDdcyg2JIePsHJ0Dc
         j8mGyyOXsaV7jPwAQ+Hz4sZp63J138yXVmU8ZrBoT/qN/1MKjsXu4bs4Hu02ie7vWXMf
         bmuhAdxYlm+YFOxmH0e1APc8MrCfY6OdnT3uMr7jS5u4SlT6cMGRRNvOX9t/8e/CHN3I
         9Ds7y3msNaXEP9h/IVNp2voL/Qzv3BuHisH91xQp7AF1k/7JyfL0tPr4XmPu6se6ax/Y
         Ar/g==
X-Gm-Message-State: ANoB5pnrpv52BNSmneg7OlRZxpa1Kc/lDpqP9UQJLD8QMgdDvqhg7pnX
        3WVypAiQtrWMG55J1lQToOxI0w==
X-Google-Smtp-Source: AA0mqf4EGeYBCVnq7ugiUMSP85O1VdGYrTp1W6FPDn9r/8+q1Or+VRc9vCV7Jr28hpe4ERzuNLodXQ==
X-Received: by 2002:a05:6512:3e19:b0:4b0:6023:6f6f with SMTP id i25-20020a0565123e1900b004b060236f6fmr8448931lfv.57.1670969550443;
        Tue, 13 Dec 2022 14:12:30 -0800 (PST)
Received: from ?IPv6:::1? (dzccz6yfpdgdc5vwjcs5y-3.rev.dnainternet.fi. [2001:14ba:a085:4d00:8c19:462c:c647:13f2])
        by smtp.gmail.com with ESMTPSA id z2-20020a195042000000b004b4b90a6992sm534511lfj.95.2022.12.13.14.12.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2022 14:12:30 -0800 (PST)
Date:   Wed, 14 Dec 2022 00:11:58 +0200
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>
CC:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_01/12=5D_dt-bindings=3A_displa?= =?US-ASCII?Q?y=3A_msm=3A_Rename_mdss_node_name_in_example?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ad7ecffc-3fc9-7859-82b7-9d161fc28cae@quicinc.com>
References: <20221130200950.144618-1-a39.skl@gmail.com> <20221130200950.144618-2-a39.skl@gmail.com> <19e78a06-2f3d-92af-1988-b22dc3ffc84e@linaro.org> <ad7ecffc-3fc9-7859-82b7-9d161fc28cae@quicinc.com>
Message-ID: <86FA3AF9-5B35-4E27-80DA-8B5BF9E6B3AC@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 December 2022 23:53:48 EET, Abhinav Kumar <quic_abhinavk@quicinc=2Ec=
om> wrote:
>
>
>On 12/1/2022 11:54 AM, Dmitry Baryshkov wrote:
>> On 30/11/2022 22:09, Adam Skladowski wrote:
>>> Follow other YAMLs and replace mdss name into display-subystem=2E
>>>=20
>>> Signed-off-by: Adam Skladowski <a39=2Eskl@gmail=2Ecom>
>>=20
>> Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>
>Going to add two fixes tags here as we are touching two chipsets:
>
>Fixes: b93bdff44a85 ("dt-bindings: display/msm: add support for SM6115")
>Fixes: 06097b13ef97 ("dt-bindings: display/msm: split dpu-qcm2290 into DP=
U and MDSS parts")

Note, your tag gif wrapped, so patchwork will pick it up incorrectly=2E

>
>Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc=2Ecom>
>
>>=20
>> We will pick this into msm-fixes during the next cycle=2E
>
>Yes, we can with the above fixes tags but first, can you please send a MR=
 from msm-next-lumag to msm-next? So that I can send a MR for fixes to msm-=
next=2E

This would create an additional merge commit in msm-next for no particular=
 reason=2E You can branch -fixes from rc1, or from the msm-next-lumag and t=
hen send MR to msm-next=2E

>
>ATM, they are out of sync=2E
>
>
>>=20
>>> ---
>>> =C2=A0 =2E=2E=2E/devicetree/bindings/display/msm/qcom,qcm2290-mdss=2Ey=
aml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>> =C2=A0 =2E=2E=2E/devicetree/bindings/display/msm/qcom,sm6115-mdss=2Eya=
ml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>> =C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm229=
0-mdss=2Eyaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-=
mdss=2Eyaml
>>> index d6f043a4b08d=2E=2E4795e13c7b59 100644
>>> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss=
=2Eyaml
>>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss=
=2Eyaml
>>> @@ -72,7 +72,7 @@ examples:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #include <dt-bindings/interconnect/qcom=
,qcm2290=2Eh>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #include <dt-bindings/power/qcom-rpmpd=
=2Eh>
>>> -=C2=A0=C2=A0=C2=A0 mdss@5e00000 {
>>> +=C2=A0=C2=A0=C2=A0 display-subsystem@5e00000 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =
=3D <1>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D=
 <1>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D =
"qcom,qcm2290-mdss";
>>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115=
-mdss=2Eyaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-md=
ss=2Eyaml
>>> index a86d7f53fa84=2E=2E886858ef6700 100644
>>> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss=
=2Eyaml
>>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss=
=2Eyaml
>>> @@ -62,7 +62,7 @@ examples:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #include <dt-bindings/interrupt-control=
ler/arm-gic=2Eh>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #include <dt-bindings/power/qcom-rpmpd=
=2Eh>
>>> -=C2=A0=C2=A0=C2=A0 mdss@5e00000 {
>>> +=C2=A0=C2=A0=C2=A0 display-subsystem@5e00000 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =
=3D <1>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D=
 <1>;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D =
"qcom,sm6115-mdss";
>>=20

--=20
With best wishes
Dmitry
