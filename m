Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7236B0B48
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjCHOcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjCHOcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:32:39 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194343E098
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:32:23 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x3so66458545edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678285941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+fyK4YA1HpAuVK65asM3FAs3wr3ryk+n68l8CxNeq1Y=;
        b=qIgBvHg9z9dTCAGP2mF9RSGn1R9Xx3TKBNYYUOynjP2kqaSACAYGBA6rYdVjBl3CpA
         a6u8g6P16OVnH3jLwit/t8+px+oZr4GYBPcUeFK64iprq65J4UF9GjvvQNQjmVTjZjMY
         DAyMpBeqfs6K8/JiYRu7yFzUtc7RiEFyPEWp4mdWE6JyyZHQKHbNFSIfJhTVYbQbZw/g
         /BIDzyJ7g+X9MXq7huETdVrZA480SxaqZgVO5Ifp2IG271/wJNgleS1nDSkX19HfJUx4
         3HETBub1tC5RebwxLPqICNjbJ2snHQWOo7wQ1DZr3THggRtYawfbvek5raz8xiYgMj6A
         C39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678285941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fyK4YA1HpAuVK65asM3FAs3wr3ryk+n68l8CxNeq1Y=;
        b=4Z97wXauGUpar+2TQCpww5G66dSjRNMlC6+MkTKMhJIdGKovx12Xido+xx+kh9Xeb2
         ctEYckuIftvCOZMQ0c6Uu3u+F+1I1Mx84c0h1tqq1d6uKlKVuHhUBtKOsDLXOh0LTzBz
         vJ5sVM8WikH+e4h3hrqSduSW+TxGjFfZaTzoj70Y0a2RUuKF3aEqVoobUJkTYaYSETPt
         F98D/WmTTr5SICvaugjRve34j8YWpcyIkrr9N35/uixEzE+/CQ/jgqic8aqzdbKx6Vwx
         4gxhd0qu03eR39TjJ8ZQa9zYzXNJxKA/Qw80nBqpGBNyapOxTGMivCjh4X+RbwAb3l8L
         HGWg==
X-Gm-Message-State: AO0yUKXfP9X8GQCHj52FiFXOaOX0nt5PTP+gmqEDX7rbMh3/iUJsdOak
        8EoCxI6aQ8VUEDRQVT4K3PuYFQ==
X-Google-Smtp-Source: AK7set+2AimgtMvfe912MwSWm/L3MpUZ5A1DkecNw40vmpX6PoKxo/ZPFkqr7KPPJ8WNip7ZDRTvvQ==
X-Received: by 2002:a17:907:9719:b0:895:ef96:9d9b with SMTP id jg25-20020a170907971900b00895ef969d9bmr20674279ejc.30.1678285941601;
        Wed, 08 Mar 2023 06:32:21 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id kk14-20020a170907766e00b008ee84860964sm7518865ejc.35.2023.03.08.06.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 06:32:21 -0800 (PST)
Message-ID: <48d0217d-283f-354b-fcb5-12801895376a@linaro.org>
Date:   Wed, 8 Mar 2023 15:32:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 03/25] arm64: dts: colibri-imx8x: Sort properties
Content-Language: en-US
To:     dev@pschenker.ch, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230308125300.58244-1-dev@pschenker.ch>
 <20230308125300.58244-4-dev@pschenker.ch>
 <9d213504-d457-21a6-d467-41d8783d53d3@linaro.org>
 <309ec2042a73b943485671f926ec0f25c5d8f80a.camel@pschenker.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <309ec2042a73b943485671f926ec0f25c5d8f80a.camel@pschenker.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 14:29, Philippe Schenker wrote:
> On Wed, 2023-03-08 at 13:57 +0100, Krzysztof Kozlowski wrote:
>> Is this approved coding style for IMX DTS?
> 
> How the ordering should be done is nowhere specifically documented (at
> least this is my current understanding).
> The ordering how I noted it is what we gathered from multiple feedback
> on mailinglist discussions.
> 
> With that ordering I hope everyone is happy.
> 
> Philippe

Yeah, but what if next developer next month re-orders all your nodes
again because he will use different coding style?

Best regards,
Krzysztof

