Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AAA72792F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjFHHuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbjFHHu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:50:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7ED2139
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:50:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso402843a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686210619; x=1688802619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CdtBaZj4Wh7F/cKA1LiZJZb7T0ESxgrV+Q/DGxp5Urg=;
        b=R7Nwox0yH/aJ1X5B1nl0KPyzpfm4V5u26ECctIxgmM0pW6O45RS9p/z6ugEXZHxld3
         DjX41wmgm3W2wiylZ3JH+T9hTIdg2lDIgS7mu6rRvM7G3IHsrfqz3L8JY4TJ7rBIpG9p
         hiswHpGixEop3mJFf6I9aOJg3BUkuBKiOEUlJuYHZJP2o9F2SynFs6qO+/53tX29u3gb
         MvG7qIJbr7uQmWVKbkXVK6ePdE7aRL747Z/lyXf+hWkQRroTD8wIonKX/T05p6g37HDs
         vR1CsfP2ism0Cz604grw/YPBMqkAyHzA8FMPYQWALk1QL/QyaNBlXpOAHHbv3M4H3sdj
         jNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686210619; x=1688802619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdtBaZj4Wh7F/cKA1LiZJZb7T0ESxgrV+Q/DGxp5Urg=;
        b=eHWfgSIxLgSlkuv5eXsGyIwcP+nECVn7W/CMlmYT2oETB9LNGcoNym9OHbIwNdmczK
         5QPvn3PBUxUk7ll0cggJ0hsBGhWkKaTRZQr6WgDvDhYCSFL8DX16jEz1TZPaALAnYPU7
         D9dVJT6CjyVFkRpaKv4QsJRS3fhux+OnnErFUKju9r5Ua4ft6+darz5X3/w3XLJRkAkB
         Eexc7VcLG2XH2RaFdtzJ2rAtZMNmdD/fjUqnPPqNXRvHNhsdvJo0mJkR+2vGK8RgaUU1
         kgd97N/7C8oyuJ1OdpmBalfTvLM/Gz6vVTjigui+zPaHz/ejvhORovT0AUVhQoL+KUhn
         nx6g==
X-Gm-Message-State: AC+VfDxplFwy/kkbn1/r0OZAY+XJ1SMYTp+PeqSKhHZl9dR0fhymRKmp
        ogy/dwrXZFWwpBLt4tN3+xb6/A==
X-Google-Smtp-Source: ACHHUZ4NNrwVqtQg76eKybrTKDBwByaBNPg+h0SR5A+VjJVIVBsGpjFs+P41gY1zcmunuv5OV0a0jA==
X-Received: by 2002:aa7:d1d4:0:b0:514:945c:6cea with SMTP id g20-20020aa7d1d4000000b00514945c6ceamr6074596edp.37.1686210619206;
        Thu, 08 Jun 2023 00:50:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x23-20020aa7dad7000000b00516654bf182sm237626eds.41.2023.06.08.00.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 00:50:18 -0700 (PDT)
Message-ID: <f06d9f97-591b-c76d-0313-49c1b7a1217e@linaro.org>
Date:   Thu, 8 Jun 2023 09:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 5/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 3.0 PHY
Content-Language: en-US
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ray Chi <raychi@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-5-stanley_chang@realtek.com>
 <58aea31d-8f47-a558-6e17-17b55059bb23@linaro.org>
 <1f13680401e449a3b9384710206cc2b0@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1f13680401e449a3b9384710206cc2b0@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 09:32, Stanley Chang[昌育德] wrote:
>>> +examples:
>>> +  - |
>>> +    usb_port2_usb3phy: usb-phy@13e10 {
>>> +        compatible = "realtek,rtd1319d-usb3phy", "realtek,usb3phy";
>>> +        reg = <0x13e10 0x4>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        #phy-cells = <0>;
>>> +
>>> +        phy@0 {
>>> +            reg = <0>;
>>> +            realtek,param =
>>> +                    <0x01 0xac8c>,
>>> +                    <0x06 0x0017>,
>>
>> First, this is matrix, not uint8 array. Second, 0xac8c is past 16 bits long, not 8.
>> Third, you put some magic register programming to DT.
>> Please don't. Drop all this from DT.
> 
> realtek,param is an uint32-matrx.
> I will revised the type.

Drop the property. It is not explained and not justified to be in DT.

Best regards,
Krzysztof

