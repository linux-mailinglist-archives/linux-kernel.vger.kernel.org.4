Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F656B8DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCNI4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCNI4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:56:01 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7476472B0B;
        Tue, 14 Mar 2023 01:55:52 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 822A94183B;
        Tue, 14 Mar 2023 13:55:47 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1678784148; bh=L0zF40kbsxnf25i5ghpBFl6J1z50oeGFvrl5F0tRH0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YKA/K+utQtx7cKzzk3+jfvrVFDvPoRmeStiLzAsslUC6JESXZbURqF0WkVnUk+6yi
         6Kg/2V64BhP5eHsdb3g/EQIq8LeLQNUvjvk/UASdEObzA82lf8a5IVvPjnryaJpH0N
         udVqhQqio6OcbM/muOkfpseMbp5DOFLe8bT69MxJVrwj0u1yrHGx0ah5clDviwae7p
         HQM1rvarKzvAas+3Z7bTSB/bpT8ql5vVNPcpnBlG7izJzotdvWS84nzr+57X5W/jYl
         k/kEvuEHl1gdVkT8h2L+GiTPjJcLvp/UNNX9jJ+RtkavAm50mLrCVNQHb+mVu5skAt
         k6FvKVrv2jGtA==
MIME-Version: 1.0
Date:   Tue, 14 Mar 2023 13:55:45 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Add Acer Aspire 1
In-Reply-To: <92725aab-a540-b35a-6614-2b91039f433c@linaro.org>
References: <20230314064322.65429-1-nikita@trvn.ru>
 <92725aab-a540-b35a-6614-2b91039f433c@linaro.org>
Message-ID: <f09056264510944fbc35a0ad27e99c93@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski писал(а) 14.03.2023 13:21:
> On 14/03/2023 07:43, Nikita Travkin wrote:
>> Acer Aspire 1 is a laptop based on sc7180. Document it's compatible.
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 1bb24d46e4ee..903a5ea42cf6 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -352,6 +352,11 @@ properties:
>>                - qcom,qru1000-idp
>>            - const: qcom,qru1000
>>
>> +      - items:
>> +          - enum:
>> +              - acer,aspire1
>> +          - const: qcom,sc7180
>> +
>>        - description: Qualcomm Technologies, Inc. SC7180 IDP
> 
> Please merge with this one and drop the description (or rename it to
> something like SC7180-based boards). The sc7180 entries spread a lot and
> it is not helping to read the file.
> 

I was debating whether to copy CrOS style or the majority for this one.
Will merge with IDP (dropping the description to be in line with all others)
but will not touch any other sc7180 boards.

Thanks,
Nikita

> Best regards,
> Krzysztof
