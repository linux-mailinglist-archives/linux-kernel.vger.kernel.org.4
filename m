Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484726E223F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjDNLcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjDNLcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:32:14 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E706AB442
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:31:53 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z38so2378223ljq.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681471911; x=1684063911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmebibJcFHPM0HYnu4gqi5WPZvQ6x+mjUWqYPAJoB3k=;
        b=bHg01QwJKN2U5FCexVrCoue+ufy3RHkhSNlPAYPtSOyf7VpcxstPmQWAHSMK8anctE
         uZRxk0b9fzAC843uXb7XKYSjjVJBuh8a49MbwRCQy83UjSEgics6c9ei7Ieq5fbpVFkA
         /zFfujuX+5rEtmDOS6cfk34yxTv6WjtL0szTXziSmdb0oH2cBoKsLdAP3NcVbA4ccvmR
         uFmixwpdddITtZYmXb9pmkXtqEe1Z5Zyvvc6+mFSOtq7EY6Kfk4cHTCtnfVJGb73zjlQ
         coi/K8cZTW0YCQmqHsTfwmX3csmYWxg+O+yeVvOyEzp2ETz1X9FHoR2ARmdgA2i6Eys6
         DfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471911; x=1684063911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmebibJcFHPM0HYnu4gqi5WPZvQ6x+mjUWqYPAJoB3k=;
        b=QgSs0oX5+t8aANzibIqX0iB0sek4YV1lRVbh98c0BnsWI5d5cWBi8VXqcUitTsySn+
         oPUtYGtLdXrX3SYsH6QdrCTKCjI1IM7lwpRA5+DUW8uGI65Zjml9nESmZR9MkyHZROh2
         Sqw5h0FQArWq8kDfkd2JyiqX3pINPGjoPDgZ8J3OOCcxX+HuHQqwqy8H6xjlCEkhzVTD
         V/cb61cUekazQgnK6P6R/E/zDfeOJ8bd2UYH2NPuiITfO8Asd9NXPADm0z2jr6AnQePM
         6fyNN/8hGogTz0ge3rAhZXTlYnsPlXKCkhDyYEQ8D/n6iV/TyMvIW2dgdHAqJkXegFw+
         rA9A==
X-Gm-Message-State: AAQBX9d31sF8KcsgHmfx52ARbl2hWHCQMJt9GliKsD0rhswCMpx0UvpL
        AedUTapWI2W8iNr/zc7/ObhQuQ==
X-Google-Smtp-Source: AKy350aoCUPfzbHh/nQudk/fBZ3ANMN821/KdCe3z4FZx8t/3E1+urYa91Dnxxqe833fGGWCjsUtzw==
X-Received: by 2002:a2e:9a82:0:b0:2a7:723b:fd5c with SMTP id p2-20020a2e9a82000000b002a7723bfd5cmr1493821lji.7.1681471911504;
        Fri, 14 Apr 2023 04:31:51 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id j7-20020a2e3c07000000b002a76dd438ddsm770088lja.79.2023.04.14.04.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 04:31:51 -0700 (PDT)
Message-ID: <01b21803-9367-f253-3b66-b0a6c1d93cf2@linaro.org>
Date:   Fri, 14 Apr 2023 13:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V3 8/9] arm64: dts: Add ipq5018 SoC and rdp432-c2 board
 support
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, ulf.hansson@linaro.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
 <1681468167-11689-9-git-send-email-quic_srichara@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1681468167-11689-9-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.04.2023 12:29, Sricharan Ramabadhran wrote:
> Add initial device tree support for the Qualcomm IPQ5018 SoC and
> rdp432-c2 board.
> 
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Co-developed-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v3] Fixed all review comments and DTS schema warnings
This is too vague.

[...]

> +
> +			v2m1: v2m@1000 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x00001000 0xffd>;
Doesn't this exceed the ranges=<> of &intc?

Konrad
