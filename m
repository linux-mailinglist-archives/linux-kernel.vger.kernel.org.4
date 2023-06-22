Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BA7739F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjFVLFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjFVLEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:04:49 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96E9D1FC6;
        Thu, 22 Jun 2023 04:04:42 -0700 (PDT)
Received: from [192.168.20.2] (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 18E59140131;
        Thu, 22 Jun 2023 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1687431880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hMIGp0XkfixJG5tNTnka9Mj/2C9D7xIvZyrC4qUu0GY=;
        b=w7sDrazh3blSiSO3P4EVMKk4EqtqvrWB27Q4Oarzldeg26VZQgvZWaRB/V4RazY9cW4K3a
        EzZQ8AZm+6V2Z9uNp00+nW8mdKB/B20Hw1uToyMh3/v7HZls6tbuXswP6FvbNjR+6NMsvL
        OAtGjxWQ5egK+Nz8Us3Tyv8fFmxOGto=
Message-ID: <c7f35544-3cfa-8304-dce3-6f3c7df84940@postmarketos.org>
Date:   Thu, 22 Jun 2023 14:04:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm630: Add support for modem
 remoteproc
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230621175046.61521-1-alexeymin@postmarketos.org>
 <20230621175046.61521-3-alexeymin@postmarketos.org>
 <5e381133-969f-943a-a7a1-1243d7b105b2@linaro.org>
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <5e381133-969f-943a-a7a1-1243d7b105b2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.2023 09:22, Krzysztof Kozlowski wrote:
> On 21/06/2023 19:50, Alexey Minnekhanov wrote:
>> Modem subsystem in SDM630/660 is similar to MSM8998 and
>> device tree node for it is based on the one from msm8998.dtsi.
>>
>> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm630.dtsi | 65 ++++++++++++++++++++++++++++
>>   1 file changed, 65 insertions(+)
>>
> 
> ...
>> +
>> +			mba {
>> +				memory-region = <&mba_region>;
>> +			};
>> +
>> +			mpss {
>> +				memory-region = <&mpss_region>;
>> +			};
> 
> mba and mpss are deprecated. I think this was changed to memory-regions
> in remoteproc node.
> 

That's what I thought after reading DT bindings document, but none of 
closest siblings (msm8996.dtsi, msm8998.dtsi) use the new way.

Will change in V3.

-- 
Regards,
Alexey Minnekhanov
