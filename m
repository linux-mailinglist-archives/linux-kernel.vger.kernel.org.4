Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA86E096E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDMIzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjDMIyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:54:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D239004
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:53:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ud9so35391654ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681376031; x=1683968031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n79aH7t+7YaiwMC+LsJWfPSbDCVgfHVxlIcCzJ5AxQ8=;
        b=avZOEPdZAZakbtvXmV4z8dZwAaasGbtwju1ykDU/7JuFtA0QTrJSMTr+z1RwEbQ2r2
         YvUeliMJeqldi//kQFvkKdAUlCq2PtJq14cwRoQFSQgKlEAHpiHX8GoXFSQNXxpF8iIY
         h+H+5qW2ErlMq9fTbRP9ApT9Wr/kAHUPB1EWgYKxGyHLonXw+xjST525QYKgecA7lXR9
         p9R73ZAvSthZlkBUPvguiHGb7RKfmnCXqTacEckJPn/68V9FstULWubxX7P7zGaQfbiR
         2Dy8aRix6mdmonv4IKWV9bGLmqPaO4XkebF5WHpySnQ/bSCU3SIu90wxEAt8prSBnVfK
         /mLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681376031; x=1683968031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n79aH7t+7YaiwMC+LsJWfPSbDCVgfHVxlIcCzJ5AxQ8=;
        b=hu9UB9AzJ175o0bDXu75/5ph7o99mTx2I2mwC0S/zNvrZ8Ck1XN3P8OQDjuk2JUgjL
         d6nT4SS4JeUabpvDxeZLeCMuNoPGQs2/6VCNWa1y3XT1Z0CDxNGRG2BBmP5LdptRhIst
         XUciBbkJ8NbDB3F2G5qWPawoMZSc5Ppgnzfz1kvfTPRPI4dO+S5eYVN1+FX3K3TU/N8u
         cpIVX+T0XeRSzYL46pOfL4V5QPqN89r51vVW20QGuiueopjGaGD2kM29oyJPGKT5JZk1
         kgCMkPmnFCAPrvyWEBeodpxA9Lmo5id1v8/nOPEyRy58iZJKVvMAS6blvulelUhWuSg+
         SgfA==
X-Gm-Message-State: AAQBX9ePZ9Bu2K2pH8lgbZkfG4G1hZE9SRUqew9mJGj3aONv/uZdR+M7
        022xHg2twPCBl/awwIdgG/6/rQ==
X-Google-Smtp-Source: AKy350ZbooTuXaoyj984ynzF5OuH2J6uhgPG3zJY/w0w3ciprQZl2IOFCz4VlYP26mlNTi+CTWmkbg==
X-Received: by 2002:a17:906:ca1:b0:94a:bd17:fc40 with SMTP id k1-20020a1709060ca100b0094abd17fc40mr2051456ejh.25.1681376030741;
        Thu, 13 Apr 2023 01:53:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ec6f:1b33:ab3f:bfd7? ([2a02:810d:15c0:828:ec6f:1b33:ab3f:bfd7])
        by smtp.gmail.com with ESMTPSA id kx13-20020a170907774d00b008e54ac90de1sm657007ejc.74.2023.04.13.01.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 01:53:49 -0700 (PDT)
Message-ID: <88b393c4-0b65-c451-3e69-c9f60559218d@linaro.org>
Date:   Thu, 13 Apr 2023 10:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-lenovo-thinkpad: correct pin
 drive-strength
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230407180710.128815-1-krzysztof.kozlowski@linaro.org>
 <ZDVtXkCON8DFUDjh@hovoldconsulting.com>
 <887eb9f6-9882-37c6-4332-ddae7a354187@linaro.org>
 <ZDZUiW+74rhhRAfS@hovoldconsulting.com>
 <15e1d05f-b7e1-27bc-7363-aefd2d155eea@linaro.org>
 <ZDZbif25qQh79cuG@hovoldconsulting.com>
 <6f2621bc-5442-f409-2d18-ea64dce3cc58@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6f2621bc-5442-f409-2d18-ea64dce3cc58@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 09:22, Konrad Dybcio wrote:
>>>
>>> Thanks. Do you know if this rule applies to other long-names? I was
>>> usually keeping full name or shortening them by cutting end, but maybe I
>>> should cut the middle?
>>>
>>> sm8250-sony-xperia-edo-pdx206
>>> sm8250-sony-xperia-edo
>>> sm8250-pdx206
> I do sm8250-pdx206 or sm8250-edo for common dtsi changes
> 
> Generally anything that contains the SoC name and isn't ambiguous
> works, IMO. And the more concise, the better.

You should have named the files like this...

Best regards,
Krzysztof

