Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E9C6AF7FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjCGVtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjCGVtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:49:06 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5150A99273
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:49:00 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4PWTbt57zjz1S5Jx
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 16:48:57 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:from
        :references:to:content-language:subject:user-agent:mime-version
        :date:message-id; s=dkim; t=1678225735; x=1679089736; bh=LBDNRan
        2Cd8nNBtnj8IHxtHFO6mc9pcFTMtM8qGwz6s=; b=X2z9Dsayhu4KWlNcB7whmXg
        zKTUxyqY5o8Wv3jPrV1MVZPidmzBNHjcw6ieAS+0Jp+mFTMSXmQru2rnjvPal3F/
        zQ/l0txh/kZBvWXTlED2861cz5kQj62mGQdXSH6hEKIfg98h1tHdX9X6KUQ+oSgR
        Ksf1eG1t2y9rQ6fa0Q+XXLs8I//ScK/VBoT1qceeBg7U19KegpGz8qUH3bHOj+fx
        /ytN7tiukSQ2mSKfASvDSbRQeBW5gV7zgboi8+JfqZBj+c4CRmc/3EuQOT2uyydy
        gSjv+Sk7V3CHEscktNAtyBUk/8WNx0YWMXQfodu1B7+6Vcw//pIuvS8UwumnhEQ=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WnoXMmLpM4pm for <linux-kernel@vger.kernel.org>;
        Tue,  7 Mar 2023 16:48:55 -0500 (EST)
Received: from [192.168.1.90] (unknown [186.105.8.42])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4PWTbS4Kjkz1S4yx;
        Tue,  7 Mar 2023 16:48:35 -0500 (EST)
Message-ID: <18156dee-4fd2-80e5-b04d-c96c267fb615@mint.lgbt>
Date:   Tue, 7 Mar 2023 18:48:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 1/6] dt-bindings: ufs: qcom: Add SM6125 compatible
 string
Content-Language: en-US, es-CL
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230306165246.14782-1-they@mint.lgbt>
 <20230306165246.14782-2-they@mint.lgbt>
 <4670ddae-6b01-1e5c-b0ed-1f2f498a4f66@mint.lgbt>
 <dfd1d81e-76a0-f8eb-e529-9f8ea1e927b6@linaro.org>
From:   Lux Aliaga <they@mint.lgbt>
In-Reply-To: <dfd1d81e-76a0-f8eb-e529-9f8ea1e927b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/2023 14:09, Konrad Dybcio wrote:

>
> On 6.03.2023 18:01, Lux Aliaga wrote:
>> On 06/03/2023 13:52, Lux Aliaga wrote:
>>> Document the compatible for UFS found on the SM6125.
>>>
>>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>>> Reviewed-by: Martin Botka <martin.botka@somainline.org>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  =C2=A0 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
>>>  =C2=A0 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Do=
cumentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>> index b517d76215e3..42422f3471b3 100644
>>> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>>> @@ -29,6 +29,7 @@ properties:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 qcom,sc8280xp-ufshc
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 qcom,sdm845-ufshc
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 qcom,sm6115-ufshc
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - qcom,sm6125=
-ufshc
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 qcom,sm6350-ufshc
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 qcom,sm8150-ufshc
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 qcom,sm8250-ufshc
>>> @@ -185,6 +186,7 @@ allOf:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontains:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 enum:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 - qcom,sm6115-ufshc
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - qcom,sm6125-ufshc
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 then:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
>> I have to apologize. I worked on a changelog for this patchset but I s=
kipped the subject header, therefore it didn't send, and as I realized th=
is I interrupted the process, leaving the patchset incomplete. I'll retry=
 sending it, this time correctly.
> Happens, next time resend it with a RESEND prefix, e.g. [RESEND PATCH 1=
/2]
>
> Konrad

Thank you! Will take this into consideration for the future. I received=20
this email after I resent the patchset, so that's why I didn't add the=20
prefix.

--=20
Lux Aliaga
https://nixgoat.me/

