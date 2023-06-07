Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D906E725534
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbjFGHPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238841AbjFGHPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:15:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D36A19AA;
        Wed,  7 Jun 2023 00:15:13 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 328FC6606EF8;
        Wed,  7 Jun 2023 08:15:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686122111;
        bh=f4cx7LEjgdBQ20mkfGT5V8OCsYXY+yPh4SHMgyvYoA8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PfH5PXmP10MTgpuggjPd6ZbKaX8Mx7dBqMJ2fE+38L3nNITZRu7McUYHTijXarED4
         tzOUGPOwy0uVroSBq5Yjn523Gdvpg6iSsXDV6pgqew8Blx5gPt19HS6MgBAcyqoy95
         4iTqXDKTKFGy03knE7QPJwBmyc2gnuiEqva4Gno9eKzyDvhX3OEkb8n9bjbDS1+SY7
         DmQUxiNZcsklXUdbHphyaTboQ0mNJmNHJ6sdBMpg8o8tipzfjFDFlfps/vjpt8Ki9v
         RmCWzlCZJTSaZITqhoX4S6P+UYPKrt+mwwf80zypwdIIpioGdivJhUqHUFXqjNSuE1
         RIwHdPCG16s/g==
Message-ID: <a69ddadd-8d59-e784-ddce-16c83a7f13a6@collabora.com>
Date:   Wed, 7 Jun 2023 09:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8250-edo: Panel framebuffer is
 2.5k instead of 4k
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230606211418.587676-1-marijn.suijten@somainline.org>
 <974f68dc-b667-c9a7-94c4-1023ef271fab@linaro.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <974f68dc-b667-c9a7-94c4-1023ef271fab@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/06/23 00:52, Konrad Dybcio ha scritto:
> 
> 
> On 6.06.2023 23:14, Marijn Suijten wrote:
>> The framebuffer configuration for edo pdx203, written in edo dtsi (which
>> is overwritten in pdx206 dts for its smaller panel) has to use a
>> 1096x2560 configuration as this is what the panel (and framebuffer area)
>> has been initialized to.  Downstream userspace also has access to (and
>> uses) this 2.5k mode by default, and only switches the panel to 4k when
>> requested.
>>
>> This is similar to commit be8de06dc397 ("arm64: dts: qcom:
>> sm8150-kumano: Panel framebuffer is 2.5k instead of 4k") which fixed the
>> same for the previous generation Sony platform.
>>
>> Fixes: 69cdb97ef652 ("arm64: dts: qcom: sm8250: Add support for SONY Xperia 1 II / 5 II (Edo platform)")
>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>> ---
> And so I derped again.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

I would've liked more to see a commit saying "replace simple-framebuffer with xxxx"
(where xxxx is DSI panel, etc) but that will as well do for now... :-)

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> Konrad
>>
>> Changes since v2:
>> - Rename griffin (copy-paste from related patch) to pdx203 in comment.
>>
>>   arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
>> index 3d22be747f042..8f867f841cb83 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
>> @@ -54,9 +54,10 @@ chosen {
>>   		framebuffer: framebuffer@9c000000 {
>>   			compatible = "simple-framebuffer";
>>   			reg = <0 0x9c000000 0 0x2300000>;
>> -			width = <1644>;
>> -			height = <3840>;
>> -			stride = <(1644 * 4)>;
>> +			/* pdx203 BL initializes in 2.5k mode, not 4k */
>> +			width = <1096>;
>> +			height = <2560>;
>> +			stride = <(1096 * 4)>;
>>   			format = "a8r8g8b8";
>>   		};
>>   	};

