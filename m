Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359B9675A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjATQto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjATQtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:49:42 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05314EE5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:49:41 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bk16so5355580wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ReqL3/KdTtoMI5gOn47wEfy8Brch/hDuTRzHxmxqXLI=;
        b=HrWAbzIu1bfu5+Ce6Jw2FEMPVasYO23fFdoUKI+s2D5dbd/iFNqYGuO1NWjYcusFKy
         fP9liXt78VZOHABtZOIYTAWWAAwkkrz7GVp/N10X76oFvPrJmDlHk+4Fgwv8rjCKwuus
         tFouDnkYAVUa4IIcvCYAQxzY/2uIqD/2hPonHIq4+yuN/6kQgGsnpArb/o55+WXIgbEB
         tRn0xd4tH8ozAowgLV/G7pe9Hr7HEcWabeLEvmDCDJNMCpwGvWH2rIokvMONX8B9UE5M
         pQuSJnDvLsfG3xLeUvaKGtLV2rDhWCWwojOJBeUj/zyGuO6T4FPiweqaOlj1sZm9tP9y
         mvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReqL3/KdTtoMI5gOn47wEfy8Brch/hDuTRzHxmxqXLI=;
        b=GrEa7MBqZgSXYHIqFZELC9sAx3KP3OOo0Dv22yykXYA4+zwoNXPKZuyxbd0iVmBTAe
         p9Oe7ReJC6CS31cFTt1nkugNpr7cYlx5hMrwZH4hJoTmZhqkl0pJH80ocGRykiRrFMAP
         SOrtF6bolITvQxoVQYq7ziaEr7lGqS1CFZWU/FMxglTqkEjM9xB26M8BjnJR0Os3j3h3
         29ah5C+hyUAmkyLuLthCETjxNqNMP7a/2r8Sq1Dq2cDTIWZprHxqOWiO6rMNJYZLCKOG
         y5J5B/n3dS35F8yyr/JQNJ9JrXMpOfcsn3qh2FB6ltEXfPLjFm1meqv+NbilDa97f5s6
         Aefw==
X-Gm-Message-State: AFqh2koQwCVCb8vOZq/wPoYdqwZXlIMOG/Bul4Fy/nBuuu4AqsrJJ047
        T/Rdx6uS0EEhEjhL852KwdOM9Q==
X-Google-Smtp-Source: AMrXdXtEWQc0BoNfAHarjgxoITnBqOmzi3Fm+XNUr6JyoaeecEc3V7G+XJtcFtNOp9ktTOsRs0d5CQ==
X-Received: by 2002:a5d:4e84:0:b0:2be:c94c:ebff with SMTP id e4-20020a5d4e84000000b002bec94cebffmr1852291wru.56.1674233380271;
        Fri, 20 Jan 2023 08:49:40 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6152000000b002425be3c9e2sm35581781wrt.60.2023.01.20.08.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 08:49:39 -0800 (PST)
Message-ID: <e5ff49d4-45c7-8c4a-d624-d8f7cc9ce2cb@linaro.org>
Date:   Fri, 20 Jan 2023 16:49:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sm6350: Add camera clock
 controller
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221213-sm6350-cci-v2-0-15c2c14c34bb@fairphone.com>
 <20221213-sm6350-cci-v2-2-15c2c14c34bb@fairphone.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20221213-sm6350-cci-v2-2-15c2c14c34bb@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 13:13, Luca Weiss wrote:
> +		camcc: clock-controller@ad00000 {
> +			compatible = "qcom,sm6350-camcc";
> +			reg = <0 0x0ad00000 0 0x16000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};

Should you include

required-opps = <&rpmhpd_opp_low_svs>;

?

---
bod

