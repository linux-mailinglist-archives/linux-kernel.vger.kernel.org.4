Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC4727CDC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjFHKbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjFHKba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:31:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F632103
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:31:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5147e8972a1so748366a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 03:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686220287; x=1688812287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzabY7vXSDqTV0zHyDdUt7dcTAnwiZRufWPLQL0ZyLA=;
        b=n8X5h+Zkf38JIxcmKu62gby5+eiL8pdtiAbRBmu+s09P+cpu1koLaXQqKpAo4pB5bm
         uLaehMpVXwxW64CwemDjLlQXSmvw8/tHkCKYLPvOw1KV88eOPmGW9dmW1PD0a145lWMC
         qLPQHjMeusyicTY973jCVWPYgM10Re+3PsUO0mvo8fm3W1xoRZGB6iHt/md87S/ewi2z
         o96ARDb5NeTtezdjsEgK98yfAd+UYbZQ/gQAek7wFeDIeB/VrTHfo2Pk6Q5icjsySBxe
         yLX0p31qylEfkMPPVrv+oLXRsLMA7HYZVvoGQSyjSfkvXPvpdjmI3K/m9og5Y0Qfo/B7
         QN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220287; x=1688812287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzabY7vXSDqTV0zHyDdUt7dcTAnwiZRufWPLQL0ZyLA=;
        b=XXDaxOqPRUiFeP9diepm6nNH1CSPB9TOBZjyM4+iQTmR3Up+cXYwOW0ElT9CiiGeje
         y2qa8w/y6KVXY4CmFgJBCF90MjZdRO1zru+HwcqK0G0VWDgUW32Mz9veUz96BxSKLp8y
         eAWzK7p085QeBwcsL0VBwuo/uKRRvMdIIakE0SbxbcLriSYeUFGvGhilXiRK/shdFLMZ
         hs9J6b8+KqbrqytGoahAXu3bjz64qrOMNYlUSnsrAEufvJvgHbbDtoI6vDYShq8T+Zk5
         +Bzm9oXujFmBBpRSJCDCsxdjh1c5SY9BDJeMiknqmvtGyqrB7JIesW7DosQVYA0Yp7S0
         /Udg==
X-Gm-Message-State: AC+VfDyXJtSeYMoHeDyMoUsynEjiX8VIrHbPNA1OtE3g1px3pxE3hK2q
        +DqWpuQjpsH6LSo7B4eazYT07j9nn/2PsmN9P18=
X-Google-Smtp-Source: ACHHUZ4Z5Myari2DC49ETLkiWHt/WB5AgmQJsJbpnXCk4MO545EImRzgj1FD2bdeeC8tyBExkyLdUw==
X-Received: by 2002:a17:907:2d14:b0:970:925:6563 with SMTP id gs20-20020a1709072d1400b0097009256563mr10092760ejc.8.1686220287309;
        Thu, 08 Jun 2023 03:31:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id mc17-20020a170906eb5100b00969cbd5718asm511362ejb.48.2023.06.08.03.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:31:26 -0700 (PDT)
Message-ID: <f0b4b1fb-e9ba-6752-3070-dc70c25a0663@linaro.org>
Date:   Thu, 8 Jun 2023 12:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sm8550-mtp: add pmic glink
 port/endpoints
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v2-7-3bbdf37575c3@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v2-7-3bbdf37575c3@linaro.org>
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

On 07/06/2023 10:05, Neil Armstrong wrote:
> Add nodes to support Type-C USB/DP functionality.
> 

Thank you for your patch. There is something to discuss/improve.


> +
> +&i2c_hub_2 {
> +	status = "okay";
> +
> +	fsa4480@42 {
> +		compatible = "fcs,fsa4480";
> +		reg = <0x42>;
> +
> +		vcc-supply = <&vreg_bob1>;
> +
> +		mode-switch;
> +		orientation-switch;
> +		svid = /bits/ 16 <0xff01>;

I think this property is not documented.

Best regards,
Krzysztof

