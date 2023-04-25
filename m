Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842566EE294
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjDYNPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjDYNPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:15:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F412913FB6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:15:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94f109b1808so1079251666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682428510; x=1685020510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S3BikuggXhWs1OPUQPTsPuMkYRDNlCEeDeec0U2qCGU=;
        b=npeWsqFvrxdDEjHJ40Ljy4HgJG2I6Qag8a8pP//WROOGC4bMMXJXG3NUbeC2rI+Agm
         zM9WBSRzLcIEKfcvxacDUawYlNSrP0XYjoBLYQGI6uUElAthC5524feJDJUWQ+PehVdc
         22poIpMVGBO5EQJrClH4W5BuJtjELXcdAgYPtFQAD9z5BOd9XCCXF+MvEBJ3A6ef5SXB
         4pHezttks4lY4jLY79TrMulHjKlLvwIpKISxTo7x1l5cUonXCI4y1LUOAyfSiS0LeiIT
         jQ83HGi1AWY3Utj5K0L0cnNQlqX/oqhs2cOYsjyRCbRG/N4b7Tw9S7bca+7qjcYjynjM
         fDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682428510; x=1685020510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3BikuggXhWs1OPUQPTsPuMkYRDNlCEeDeec0U2qCGU=;
        b=heKJ+XhO0iRZuXj/vmqfDWUYLqX1qxloA4G8ks5XHrE/eaFmW+RhpebhO4dRtkdk5T
         1XGXnBmyx3iabNrH88n2teBLAwxnHfDnhj47Cyn8+WuMH5c0uoteJtgm64wkAxBtWGsc
         5IJXgozlwt2ebBw2eb68mDVj+qPO+bGt9cB6W5B1lVc4PwgZMYfudzqCjIx+M28SOYEE
         J3vHKTLkvLhJoWbFrd/IOjf+TtiSf2ESod2rPvf511vqhezbGAdM7miQAknCw3ZEDRUY
         +gW5hc45LYBNDOb+UrBVAM/V+vvBsEN15wY9RDjLuTw30/1EYNqoElp/PeBNXp+s6owa
         /whg==
X-Gm-Message-State: AAQBX9eZNK+Vo/NtoVZupa9Kh5ohfWXH01NuaChsId0G8/l2erIw1bgT
        TkcjtSTLcprgfOWFeF272XJNdw==
X-Google-Smtp-Source: AKy350Ykr4gtdZ1ZSW54CjRQJltXgFAHvYw5B1VZUVrxe/v1FVbbmrQbyexNMdoBYd1tjbR3rUIt/w==
X-Received: by 2002:a17:906:40f:b0:94f:a8fd:b69f with SMTP id d15-20020a170906040f00b0094fa8fdb69fmr14098617eja.18.1682428510422;
        Tue, 25 Apr 2023 06:15:10 -0700 (PDT)
Received: from [192.168.9.102] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id ox6-20020a170907100600b008f89953b761sm6753105ejb.3.2023.04.25.06.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 06:15:09 -0700 (PDT)
Message-ID: <7ee3eec8-b5b4-2591-adcd-1831bf7de02b@linaro.org>
Date:   Tue, 25 Apr 2023 15:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] ARM: dts: aspeed: mtmitchell: Add I2C Fan
To:     Chanh Nguyen <chanh@os.amperecomputing.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230425065715.21871-1-chanh@os.amperecomputing.com>
 <20230425065715.21871-3-chanh@os.amperecomputing.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230425065715.21871-3-chanh@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2023 08:57, Chanh Nguyen wrote:
> Add the MAX31790 node as a Fan I2C controller. It controls the
> TACH and PWM for Fan Mt.Mitchell system.
> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> index e79f56208b89..6455cf80da0e 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> @@ -477,6 +477,18 @@
>  			line-name = "bmc-ocp0-en-n";
>  		};
>  	};
> +
> +	max31790@20 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "maxim,max31790";

Unfortunately the compatible is undocumented.

Please run scripts/checkpatch.pl and fix reported warnings.

Best regards,
Krzysztof

