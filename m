Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3B06CA7D3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjC0Ogj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjC0Ogg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:36:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D081A2723
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:36:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h8so37088954ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679927789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uu6fkWav3ppxq5pM9npOEzd2xjd4ddBcnc58P+RleNg=;
        b=dixFlR7vwj58oeZiyskfKaq+idVN/lfcDfveh6RzsNqwaBbW6aRWgM1qAhigliKZit
         EamWShZ4+Qs5K9f9nvr0FGBc9gOxmHg00yR2Fb3vIaKfSAXErLTaPBUNar3jYWWD4XIE
         n2pRG51YIU9V+7RDMdd2iWtK1WqOrok8x6nWcpCfqSn/896hZZ1G5Eo6Jb14+td1NZwk
         JAntbz4MVUPW7PGJ46HYJdxjeW2HO5XHAicamRTXDR9gBHpUXl2+DiggkMNwYTrSh2KI
         RGqLcUOL713nAcRWmMulyjVO/8K6dDKUr5gD/U3ayQ2BROL1BN9t1+9YrzUBdLgp8PQD
         +J0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679927789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uu6fkWav3ppxq5pM9npOEzd2xjd4ddBcnc58P+RleNg=;
        b=xOP+Jroj66wx0AX+VpWRgYYJLrH0iO+8J+J1IxpOKQ/meswGYrxG5HjSYouzKI4tie
         mDvXbujEMnGKfGuuRfxrLfZeOqDwRHuwBnv/GSgU7pSa5RaL77wC6prte7wKJjytq6Ua
         Ig9OJ9fBLuA7tPjaBP/S2EtXY5RBUvksLeSCsh9A2RzpC28KAhxxLHu4YYd+WU6GOhti
         7Z10DllKq6F+ToGdopmMTGejtYBUlDSubyEjrNj/0lyVYXUfy+t+TncU+J7IV1UXKNcK
         a37rcHN5YFsdlN6Y3BJF3GPAPtmcDQj6aofE50buYtM8UUZpBKxKS3FwAi8XPQg+iSTC
         cXcA==
X-Gm-Message-State: AAQBX9ekXnK4d3jU2wXkjUned9yigPwZ3NtagD8lH4KyKYdP7WhqOgmq
        hbDKisJ+wLKEjkHQ0SiIwEVj3w==
X-Google-Smtp-Source: AKy350bg6TxFCCNmhZLnsqu23dSEIWha0A+ezGd8KtPB0/kJ0xc8L9JLyb1v5Kl3kmpV18AiNMr34Q==
X-Received: by 2002:a17:907:3f88:b0:909:4a93:d9d2 with SMTP id hr8-20020a1709073f8800b009094a93d9d2mr15929529ejc.2.1679927789302;
        Mon, 27 Mar 2023 07:36:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:581e:789c:7616:5ee? ([2a02:810d:15c0:828:581e:789c:7616:5ee])
        by smtp.gmail.com with ESMTPSA id ha8-20020a170906a88800b0093a6c591743sm8733914ejb.69.2023.03.27.07.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 07:36:28 -0700 (PDT)
Message-ID: <c540f72b-3fc9-f5c0-0cf4-20903e5f4625@linaro.org>
Date:   Mon, 27 Mar 2023 16:36:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: misc: qcom,fastrpc: add
 qcom,assign-all-memory property
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230325134410.21092-1-me@dylanvanassche.be>
 <20230325134410.21092-2-me@dylanvanassche.be>
 <883c3c48-c6e5-556d-431f-e92592b9106a@linaro.org>
 <b75b92bf64b55ba0ace0fbff65955c838a294dec.camel@dylanvanassche.be>
 <44904ffc-83d4-1137-3479-737a81b31d16@linaro.org>
 <1f3fb4bd5387c8d69a6eb068fb773b9273081c13.camel@dylanvanassche.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1f3fb4bd5387c8d69a6eb068fb773b9273081c13.camel@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 16:26, Dylan Van Assche wrote:
>> Bindings are not for driver behavior.
>>
>>> Downstream does guard
>>> this with a property 'restrict-access' as well, see [1] for a
>>> random
>>> SDM845 downstream kernel. On SDM845, this property is not present,
>>> thus
>>> the IF block runs. On SDM670, this property is present, then the IF
>>> block is skipped. That's why I opt for this property to have this
>>> behaviour conditionally. I'm not sure how to explain it better
>>> though.
>>
>> Still you described driver... Please come with something more
>> hardware
>> related.
> 
> So just updating the description is enough then?
> 
> As this is all reverse engineered, I have no access to the
> documentation of FastRPC, so best effort:
> 
> """
> Mark allocated memory region accessible to remote processor.
> This memory region is used by remote processor to communicate
> when no dedicated Fastrpc context bank hardware is available 
> for remote processor.

This description does not explain here anything. The memory region is
already accessible without this property.

You described the desired Linux feature or behavior, not the actual
hardware. The bindings are about the latter, so instead you need to
rephrase the property and its description to match actual hardware
capabilities/features/configuration etc.

Remember that any arguments to downstream are not really good arguments.
Their design choices and bindings are usually totally not acceptable.
They simply embed whatever driver needs in DT - policies, system
configuration, driver behavior...

Also, Dmitry made here good point.



Best regards,
Krzysztof

