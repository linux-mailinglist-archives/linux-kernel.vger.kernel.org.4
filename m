Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074D05E66A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiIVPQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiIVPQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:16:21 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4F5E9CF4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:16:14 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 9E8ED1F690;
        Thu, 22 Sep 2022 17:16:11 +0200 (CEST)
Message-ID: <e9d55a49-e3c6-a6b2-43e1-8e643dc49d58@somainline.org>
Date:   Thu, 22 Sep 2022 17:16:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] dt-bindings: display/panel: Add Sony Tama TD4353
 JDI display panel
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220922135902.129760-1-konrad.dybcio@somainline.org>
 <02f44228-866a-f096-1e90-dfbd31660491@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <02f44228-866a-f096-1e90-dfbd31660491@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.09.2022 17:11, Krzysztof Kozlowski wrote:
> On 22/09/2022 15:58, Konrad Dybcio wrote:
>> Add bindings for the display panel used on some Sony Xperia XZ2 and XZ2
>> Compact smartphones.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +
>> +  reg: true
>> +
>> +  backlight: true
>> +
>> +  vddio-supply:
>> +    description: VDDIO 1.8V supply
>> +
>> +  vsp-supply:
>> +    description: Positive 5.5V supply
>> +
>> +  vsn-supply:
>> +    description: Negative 5.5V supply
>> +
>> +  preset-gpios:
> 
> How about bringing them closer to common GPIOs:
> panel-reset-gpios
> ?
> 
>> +    description: Display panel reset pin
>> +
>> +  treset-gpios:
> 
> touch-reset-gpios
> 
I can do that. I will however wait with resending in case somebody has comments
on the .c driver.

Konrad
> 
> Best regards,
> Krzysztof
> 
