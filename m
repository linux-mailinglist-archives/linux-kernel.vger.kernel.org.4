Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D724D6C1D67
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjCTRLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjCTRLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:11:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25CD37B53
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:06:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d17so2647582wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679331952;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xW5Ocn8+5vHuJfNM9+tN+8Zsnupq2u+BkYV9wTXAw4Y=;
        b=NyGvT0378NuDjZ9dHCYUvYGPUtTCef8K8siMI7SPfTIRaEmuBlW8kyVdzuo+N7TnmM
         OM4W7IkbMOwUY0fdKdpfn+ezcX+YEOUEK55KD35x1YGF/xqc7yifGtH0PrZeWkPKDmrx
         7nv06IyFOBF9PaclQGCPXoCu+gkLGE0+aeQA1wxQLVoRdqK9RpZqEP1Q7hRPFOGOmLGs
         aYVobW043r8nO4sKiq67xgHpKfkO+1DJHZIH/UaqMiud8XIOZLY0X0+tH/zDIfyQtOca
         fztN2cJuVPiMK9VzeJOqgfCVcg1oHATyMYfHwHQoymqgbwVSgwYuIz+6FnAzkm2UqhE0
         K9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679331952;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xW5Ocn8+5vHuJfNM9+tN+8Zsnupq2u+BkYV9wTXAw4Y=;
        b=wjwUDB1Mb4G/16HvtTBCdoXEsAup8pwtIzYrm+bs9svbq3pdy3rZ8hMGD6gq+ljY8/
         M5FByS5ClXcl0JDY2RCJPM5fwP9BxOzjTugb02zXIJeaHzeQkv4TPdolMnvORhEaXdMd
         cAKBubHpamU0yFKg8e5Q+bVjcbL7aGa4LcXEg7uJdA5H+QdXWTcVTS9awl+bpz/QAwqT
         GdXOzbEYfs/3b8NjqFIEkfzAp0Imtoz/nd1T+68ayIwEYb2VJdSViUqMVCZbqYlvCLz0
         GzhgAoST6dTV1IH3Pe8FcDVgUZ3fS64NwXRXpBWhI6BHZAlVSLKo4LLTnw3y9HNTie8e
         yY3w==
X-Gm-Message-State: AO0yUKUX17U/4Ir4AmLhAJyte7TAo3UUM0aYKXr8P7Fmo9Tdegz5+7+h
        mOO+/JnPrEtyArDTLgX7e68T/A==
X-Google-Smtp-Source: AK7set8Nv2T8kL+fvPeCqSg+RfYzuTdyylCYV5CDr7EFK/Iiy/36EHskF4J9tyV6pgSi2iiH0QVolA==
X-Received: by 2002:adf:e28f:0:b0:2ce:a8d5:4a89 with SMTP id v15-20020adfe28f000000b002cea8d54a89mr48706wri.37.1679331952411;
        Mon, 20 Mar 2023 10:05:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4f6f:868d:9c7b:5ab1? ([2a01:e0a:982:cbb0:4f6f:868d:9c7b:5ab1])
        by smtp.gmail.com with ESMTPSA id s13-20020a5d510d000000b002c794495f6fsm6338143wrt.117.2023.03.20.10.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:05:52 -0700 (PDT)
Message-ID: <12606dcf-feba-c5b8-abda-b2657e3b9ace@linaro.org>
Date:   Mon, 20 Mar 2023 18:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: defconfig: Enable QCOM eUSB2 SNPS PHY and repeater
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230320151707.1842171-1-abel.vesa@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230320151707.1842171-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 20/03/2023 16:17, Abel Vesa wrote:
> In order to have USB 2.0 working on Qualcomm SM8550, both the eUSB2 PHY
> and the eUSB2 repeater need to be built as modules.
> So select them accordingly.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   arch/arm64/configs/defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5029ff92eb68..87824cc1604a 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1308,9 +1308,11 @@ CONFIG_PHY_HISI_INNO_USB2=y
>   CONFIG_PHY_MVEBU_CP110_COMPHY=y
>   CONFIG_PHY_MTK_TPHY=y
>   CONFIG_PHY_QCOM_EDP=m
> +CONFIG_PHY_QCOM_EUSB2_REPEATER=m
>   CONFIG_PHY_QCOM_PCIE2=m
>   CONFIG_PHY_QCOM_QMP=m
>   CONFIG_PHY_QCOM_QUSB2=m
> +CONFIG_PHY_QCOM_SNPS_EUSB2=m
>   CONFIG_PHY_QCOM_USB_HS=m
>   CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
>   CONFIG_PHY_QCOM_USB_HS_28NM=m

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
