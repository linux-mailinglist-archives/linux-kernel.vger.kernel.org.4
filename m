Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784D8749B6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjGFMJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjGFMJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:09:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBBE1BE3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:09:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-993a37b79e2so78365666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 05:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688645352; x=1691237352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AD7SP5cEltC2P6iI+W24BH/0PK5a9j/yuLzGT21WDwE=;
        b=i9Vs0AY9co0nozmt6kxY8w+r5S9aLFWdrpYPpACl24iKi92FdSL06JLGkD4sX/JO5l
         9DOXPpCOuPivcnDRKzdI1ng4c0OIN+7XmWf00m95DrN8hgLXTVOk2lxToj+A/ZSwqTkh
         YXRXaTn/NDxVruaFvAm/4c3yiAN7Gv41JUKpQ1iiGEve2OvVw3X8SuUIqDZO5KWPqWOi
         B24q1P52iNdG5HHK+91w1vsvwSKIWzs+6GIyIwv9pXylC9HfPO/a2yF6G53euw+Zd5NI
         T2G1PjYvIqTIHXI9zJx/taJUYddohNXrHM0DDPhvnobjMOdxGtUw8a6RuGB2rA0kzppV
         FfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688645352; x=1691237352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AD7SP5cEltC2P6iI+W24BH/0PK5a9j/yuLzGT21WDwE=;
        b=UFWuljbF+jt+erOiqk8LCibyIFois8odjNAp1EwhOXxhN3uO45/UEBMcA6eYrBOeP8
         +0kzxjFQHY5EnifNjrZ7y/yra5lH+RB0MMoEWctjbHEi2P8BChYw/azE9K+23qg2Ousn
         SKvltz5U0iy8w8Y5b5fwp6Nw9Y0Cxk3lT6y+vJmp0KlxzP0QuAJE2elWQLVIVYb+hrzE
         391KEg6tV5Zaa5wAf428heLqRvG8KrXsyguUPI6SJvhxytiWZoimPEFsvpIAxIT8uzyy
         ERGusVJAPbjcNM+/w+d1OyNwQLwP39jTXXD5Em3ryherz4umFuGM/PDpJYi10A/XmrbT
         jlRA==
X-Gm-Message-State: ABy/qLa7KD9B1NNtFONqglI1ihgrFmNGlq/P9lsCLiQJu0CbhOWKkNgW
        6ExZN9k/hwPpaHZXukw206/Aog==
X-Google-Smtp-Source: APBJJlEigXpf0qIEu3w7bh82NDf+I+AZ5IvWRIyMOVolQrW0lhHOOtLk1gTA6aU6jjVr7ttCRNEt3w==
X-Received: by 2002:a17:906:196:b0:993:6b3c:fe06 with SMTP id 22-20020a170906019600b009936b3cfe06mr1175068ejb.25.1688645352276;
        Thu, 06 Jul 2023 05:09:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id gh9-20020a170906e08900b0098e0a937a6asm734388ejb.69.2023.07.06.05.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 05:09:11 -0700 (PDT)
Message-ID: <878103c6-0dc3-164b-92ce-17ec4f87bff6@linaro.org>
Date:   Thu, 6 Jul 2023 14:09:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/6] arm64: qcom: sa8775p: add support for PCIe
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <20230705084606.GF11854@thinkpad>
 <a450e2e8-307d-49e9-d76d-de397b801a96@linaro.org>
 <20230706111218.GA4808@thinkpad>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230706111218.GA4808@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2023 13:12, Manivannan Sadhasivam wrote:
>>> Please note that the dts patches should come before driver patches.
>>>
>>
>> Why? DTS is always independent thus usually put at the end of patchset
>> or better separate. It is the first time I hear that DTS should be
>> before driver.
>>
> 
> This is what I was suggested by Rob during my initial days and I've been
> following this pattern since then. If that's not the case, I have no issues.

I really doubt Rob ever suggested that. He probably suggested that
bindings must come before user, but not the DTS.

Best regards,
Krzysztof

