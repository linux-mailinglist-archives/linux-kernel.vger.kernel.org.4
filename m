Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0A5735870
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjFSNWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjFSNV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:21:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E2C18D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:21:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-987accb4349so376201066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687180917; x=1689772917;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8pQt42tuZOaEcZJQna4/Cwq6MKA6BWPB4n7tVzM8MRY=;
        b=pMkRsPeDMBLQxmzKLaHVI3WRMU+qqyVmqwn+hDIW5kBxoKxxYWnIinu0IP0Dwpq7S9
         U2jnmFz6tSg6WGiG7TPDheXKENR+EX/efRnvhIs4gc6l4WjHJZvTcR6n8/g4T0NfGN9X
         KWvRk121Cs0nc1rXZuLq7gyrEYwX4xhBf/SgRydyj2xladTRy19HmCF35iJfZaLujma3
         iEYwBrBnGMFDSwVyKxFMyUi6M3BOc7k7QtLzUrGkZcoIAeM2AfyXFAVXw/i84ARU8RXb
         kbdSnirfYgAEj8ubi7SRrq2ddvKRUVksW1kMKdQb/cFYC6BDHrRxW4e+7zHz92qdByL9
         ueFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180917; x=1689772917;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pQt42tuZOaEcZJQna4/Cwq6MKA6BWPB4n7tVzM8MRY=;
        b=ZfYJr6IOvZy1ClZG+FcsF73jCaxASPejLvSSPTdgKB8LtdDaobdEm/2N1D0Vzc7Bw4
         QeUwcIHxMN+cdfr2PlrXHDZseEe50EFEQ0gZOJPPeMhkW2PMgBLHWcqgMaezGcgxPivW
         /rDo6r+lAgC1pWgxkaI0iD0neKPcZCSC3hOuXy0f0xmqUVDnX+gj2lhMJj3x/lehgNTO
         fPfp7fTkjBH5+LPsGd3tCDFvP+oRdQyTrBeT9tAxsj1v0LQhIglRI7Sl0XXeXWpDCJtv
         QK4lJAU+UTNuh554x3RYpBSoVJPnfvaLvz1YfEHMeuhphheUWGFToxrhvUaVRl6AjcFO
         tP6A==
X-Gm-Message-State: AC+VfDwSauI4ghox3arvmGIA+y5WTh6zxbj/OIgsIdcM+NJ9RbhrZOR8
        V6Or++sLralHqGAm6lYMq66RfQ==
X-Google-Smtp-Source: ACHHUZ7TL0YdR4iW1qRe0W3OT7gQkUPn1kbZkjtyoDJnRS8uVI7hAvS5Jv6EZ6yzCR4TjcL5lBECqQ==
X-Received: by 2002:a17:907:5c8:b0:974:7713:293f with SMTP id wg8-20020a17090705c800b009747713293fmr9200608ejb.41.1687180917011;
        Mon, 19 Jun 2023 06:21:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x13-20020a1709064a8d00b009871016d520sm3730540eju.42.2023.06.19.06.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:21:56 -0700 (PDT)
Message-ID: <162f01b1-bc4c-2cfd-5457-88bb08adec7b@linaro.org>
Date:   Mon, 19 Jun 2023 15:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8350-hdk: include PMK8350
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230616190222.2251186-1-krzysztof.kozlowski@linaro.org>
 <bc5e6de9-c28c-8ead-799c-8e46752469c0@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bc5e6de9-c28c-8ead-799c-8e46752469c0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 15:19, Konrad Dybcio wrote:
> On 16.06.2023 21:02, Krzysztof Kozlowski wrote:
>> HDK8350 comes with PMK8350 PMIC, so include relevant DTSI.  This also
>> allows to use reboot reason.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> What about the other ones though?

Step by step. Whoever wants them, adds them I wanted reboot reason, so I
added this one. :)

Best regards,
Krzysztof

