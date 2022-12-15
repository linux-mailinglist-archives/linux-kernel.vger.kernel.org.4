Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053DF64D7F7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLOIoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiLOIoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:44:18 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A2D303D6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:44:16 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id x11so9219118ljh.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4JgPf0I2trJtnvNFuGdGdS8w+r7WydweU0Qz8JdEMA0=;
        b=ratcEzdwnRNxqbOyPGnzq69AYEfXQ8t9SXTM6HxsbihGIKLxrP7OVd5+LXOrkdFsu8
         nZJgaQeH4GkwB67T4HjAKbzkRhRuVPRK+oA9FjkuVNUWbW45BAvN65LZaKTUOULvO5Ef
         xK9r/zLDvt3UuNZCWw3yE9wLWVM1GI9Cd0vAYwJSHG6U0bdnfGWcQZGCocOLBO40hmew
         7yhtj3IplgP1SOa+RIRgNPam6MJ02GxW/6yb63TmVkg73J37ga4wCqzPf4sBn7wUD6z5
         CSk/wgf7yREVjnkY6YKcbXWEkM8zFKb1VAitMm6tDTnrF6BmTzG8bKk28mpOs3//g2fb
         313w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JgPf0I2trJtnvNFuGdGdS8w+r7WydweU0Qz8JdEMA0=;
        b=fFK97PuhQ0xFQxeNkXK0HL3S0iqgBICwadJ7BtApFTN2A+cODakoOBSxBCQ+Iq/GiU
         FtGnVXvb3fCszR/9k52upwLGZNjkl/DjwxHWQABJ8a4W1tKljClSimgR0wy7f01pIDdh
         jjym9XuoAhvNGGvEFJ74OPFWP3A7Ji4R5chHTcNgwjRfPA+wF6EqNKZzm3i/lrDUM9yH
         DHvmX+3amLUCM8x7V3frdongr4ndLfet5/WjO0+uykC5dVpLJ5rFszsxFq9RDUBV5jT8
         voQm7BVA5QxJjMoLG/pJMJvTbe+uVEcfIaiWpn/bEosajE09wp+UeJjqdbQs7/y9zGaT
         gTQQ==
X-Gm-Message-State: ANoB5plLyf9eDtJMyVTej+xLjAgPCgWXGQULww5abf+F9EXBuYjNqVD+
        LaOZAT32uP31i9QQFkE0+Njibw==
X-Google-Smtp-Source: AA0mqf7nIzSZ/F4qdDJi35AuwztOq8aNj4pHFPYa2W9y74W+FlS3i4KCpjmjvEOREO1l/bjUAztn0w==
X-Received: by 2002:a2e:a170:0:b0:279:c1a9:3af1 with SMTP id u16-20020a2ea170000000b00279c1a93af1mr6679413ljl.10.1671093854582;
        Thu, 15 Dec 2022 00:44:14 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i18-20020a2ea372000000b002773ac59697sm330603ljn.0.2022.12.15.00.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 00:44:14 -0800 (PST)
Message-ID: <5cd9e71c-8147-2ce1-b137-0342e271031b@linaro.org>
Date:   Thu, 15 Dec 2022 09:44:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221118192241.29384-1-quic_molvera@quicinc.com>
 <20221118192241.29384-3-quic_molvera@quicinc.com>
 <20221202033721.4slwz2utw5u6rv7b@builder.lan>
 <9e4e6149-bc24-b727-fff7-3fb7038fc066@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9e4e6149-bc24-b727-fff7-3fb7038fc066@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 19:59, Melody Olvera wrote:
> 
>>
>>> +			#clock-cells = <0>;
>>> +		};
>>> +
>>> +		sleep_clk: sleep-clk {
>>> +			compatible = "fixed-clock";
>>> +			clock-frequency = <32000>;
>>> +			#clock-cells = <0>;
>>> +		};
>>> +
>>> +		pcie_0_pipe_clk: pcie-0-pipe-clk {
>> Afaict these clocks are not referenced anywhere, so please skip them.
> 
> Yes, so I included them to be consistent with the bindings. They will be needed later;
> should I still remove?
> 

If they are not referenced anywhere, how is it consistent with bindings?
Where do the bindings require defining such nodes?

Best regards,
Krzysztof

