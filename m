Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA51F6E1204
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 18:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDMQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 12:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDMQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 12:16:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B1C869E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:15:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kt6so603200ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681402555; x=1683994555;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBcMBYYWDgCNbn8m62BANAhlRwT5LGCaXgl9yX8eaYU=;
        b=A2Ym5dOmOXuFeSBtKD7QsykA90vohpyqnppghJWzYEsGCrGCW5ztGiJxT+AUz3DOdU
         1nfy8DjiAVQ0KKTinfsROdo5kVmDBwBWrmhYw59t/BIoI+icxZNgD0x6dHGgypvm3rio
         Y8gZOniL2OfVxfZx0uAt28ympTR3KVUJAsJWkU61GhnK6reqW4uuYgYHUgZyDrWBgHFj
         FZF9Nwdlm4zS29Y4xfZSyRU4LHy4skIEpACzrBznC3lE5ewut9iU9HB7lDRujy7TOCSI
         7soH/gz088nVEGRvGfubwxh7VstcfYXNeZpDzQStvrcTrp85HHYzzPRWSNSo8634VqAo
         7Yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681402555; x=1683994555;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBcMBYYWDgCNbn8m62BANAhlRwT5LGCaXgl9yX8eaYU=;
        b=RX6OCDxUcEkphWY7ZQJw1+Q/CR4iG9vuy2ShdTP0BRWECAf7kSYbNKeCW9QbMBJKcu
         4wtGNJePqrEPv16RyJQAoCv4j19svXlDzkLkWP6VSF6hw/ye8Nr7/yJIH/Yht94pmb72
         qAc+es9a8XHngxAQvNyj/JRw7nepilQAjxdRuaXf6/eOv+TjitNkruk8NKtAyMkv7cti
         AQNJqcV34SYuagjQ+FatUg+/sGdGpL1QCelQJRRWitE9wwmrko8hOyYBi4o+Gf17ea57
         iwJaQQZ4mq3ubTC2tyKzj5PCN9BcrVFKlFLF0NDfuGOHgXcPHWw4903RLVI55GdRSAXV
         Py7Q==
X-Gm-Message-State: AAQBX9dZWRG6E0DLIHaK2c1wbdjl2fxmKfuJWwgibgUIkQ/ZuilYXY4t
        tCicui68fHJhr5YIdACtRDInoA==
X-Google-Smtp-Source: AKy350ZC3/htT9jKCMQHFZEYh7Dr4Lk8To/TD9Tv6JaBMpUmG2iswjq+xu2YFQksaS3IrBiwviSwIA==
X-Received: by 2002:a17:906:a243:b0:94a:9683:7501 with SMTP id bi3-20020a170906a24300b0094a96837501mr3290082ejb.73.1681402555608;
        Thu, 13 Apr 2023 09:15:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5032:d2d4:ece5:b035? ([2a02:810d:15c0:828:5032:d2d4:ece5:b035])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b0093034e71b94sm1176949ejb.65.2023.04.13.09.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 09:15:54 -0700 (PDT)
Message-ID: <d6099154-032e-d4ff-5732-1be856fcebc0@linaro.org>
Date:   Thu, 13 Apr 2023 18:15:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sa8775p: pmic: add the sdam_0 node
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230413131705.3073911-1-brgl@bgdev.pl>
 <20230413131705.3073911-5-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230413131705.3073911-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 15:17, Bartosz Golaszewski wrote:
> From: Parikshit Pareek <quic_ppareek@quicinc.com>
> 
> Introduce sdam_0 node, which is to be used via nvmem for power on
> reasons during reboot. Add supported PoN reaons supported via sdam_0
> node.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> index 5abdc239d3a6..49bf7b08f5b6 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
> @@ -88,6 +88,14 @@ trip1 {
>  			};
>  		};
>  	};
> +
> +	reboot_reason {

No underscores in node names. This is almost always called reboot-mode.
Please, do not use downstream naming and conventions.

> +		compatible = "nvmem-reboot-mode";
> +		nvmem-cells = <&reboot_reason>;
> +		nvmem-cell-names = "reboot-mode";
> +		mode-recovery = <0x01>;
> +		mode-bootloader = <0x02>;
> +	};
>  };
Best regards,
Krzysztof

