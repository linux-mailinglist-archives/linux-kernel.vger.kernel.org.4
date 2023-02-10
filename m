Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D619692207
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjBJPXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjBJPXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:23:19 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E1C2914D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:22:57 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l12so5076855edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEl9N0bZFrWfYhpwvG+ZgSBySFP7PKVG/qIsk3/2cu4=;
        b=NAY6r8c1z5ei0Y9CNRlwiwhzWSLbOVaLqZVyJypJtlXqmYaaCjlMEy4kqFm6XDUy1r
         V3voEJpAC1uX1Kky/l1AeNHp8QvQHF3MivRSaZB/A3gUh6whbga3tYrSUFRjS9dRpqIu
         SIEdpNQh4rY12phOKbRW4n/yoEOnYTcEB1mWtb9dG3c3qNi6JtW9VsU30VeyoaLQ9FxF
         aMwvNERQ7LmObYAL/7mzEM+zPlKv1Yqkrn+rupzVR8nVmhu6zo8YvCeura3k4lt76dQm
         +aPJQH+sL6rJSA9/IUz6Xk7Ni1WpSTsF4Fr0wGeL+EkohyBDG+22vBi/xT2o68LsaoZW
         vwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEl9N0bZFrWfYhpwvG+ZgSBySFP7PKVG/qIsk3/2cu4=;
        b=GCsnMeVQSigFgOt+oy5VpI4JAU0OOx0gkTEyFqJYi4Qyx/aRMtZC4DYLhkxqxYJixF
         M8jKhLRLcZ5JAIldR9QrS5Cv/JMsrqDb2fAV2qUH4KXcBcb76CFqHD+V/781EtXv6Z8a
         tlIQ32lJIKtnXIQ8h8axkcyKwRCSzIlU/V7NLnciBhNefMMynlFhPMdE91hiBy6Z1GDn
         6ujLMGwHXlNn6udAjBxTjtYTXLfk+NMR1csnqwSZ29WLmAPbDWn1xHffxoXaCUAOJKk9
         JICvRG82onpm02Ugq63Y5TALvM+bH4FaSnHZSRyYEp3FImOufRZfvLH1FeUkYu4TJGGI
         bx8Q==
X-Gm-Message-State: AO0yUKWnH12L6j+iEx796ihQYmDFNpFTVgtxqX/MYLkxuTvxw9d2cxEu
        dq2QNVpFB8TrEBURdIDs+FcqnQ==
X-Google-Smtp-Source: AK7set/BwerVSm+uSQ0pFOrYXmzSkHbd1YsVWvOfKO//fiJfaR/bY+InCvBCiyeXfAWvCFfS4VOv+w==
X-Received: by 2002:a50:d0c4:0:b0:4ab:1f18:7839 with SMTP id g4-20020a50d0c4000000b004ab1f187839mr6851870edf.22.1676042576119;
        Fri, 10 Feb 2023 07:22:56 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id b2-20020a50b402000000b004a245d70f17sm2375124edh.54.2023.02.10.07.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 07:22:55 -0800 (PST)
Message-ID: <099fd269-2185-24c2-563e-749af3301881@linaro.org>
Date:   Fri, 10 Feb 2023 16:22:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 11/11] arm64: defconfig: add PMIC GLINK modules
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v2-11-71fea256474f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v2-11-71fea256474f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.02.2023 16:02, Neil Armstrong wrote:
> Enable the PMIC GLINK core, altmode, battery and UCSI
> aux drivers as module to enable USB Type-C management
> over the PMIC GLINK protocol on modern Qcom platforms.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/configs/defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e7e42bf79a26..1773254de7fb 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -287,6 +287,10 @@ CONFIG_VIRTIO_BLK=y
>  CONFIG_BLK_DEV_NVME=m
>  CONFIG_QCOM_COINCELL=m
>  CONFIG_QCOM_FASTRPC=m
> +CONFIG_BATTERY_QCOM_BATTMGR=m
> +CONFIG_QCOM_PMIC_GLINK=m
> +CONFIG_TYPEC_UCSI=m
> +CONFIG_UCSI_PMIC_GLINK=m
>  CONFIG_SRAM=y
>  CONFIG_PCI_ENDPOINT_TEST=m
>  CONFIG_EEPROM_AT24=m
> 
