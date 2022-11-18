Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E64A62FAD5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242383AbiKRQva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242352AbiKRQvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:51:24 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC3694A52
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:51:23 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id b9so7486611ljr.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRf8hyfAQU0WsdMAWiwhiLJaBcc5V3IvYJ9MjSy7h3A=;
        b=pMIsl77TkqsVAj83n5C6yp1HFCL1WoL0UMo1Ab9uPOLHXOssGYfbuxD84dQZ20Oofx
         990Dgpmc2xcIitkBwMBdR2e+V184lOKsEjJaUSOs1iHjANOiRE5edJrdwQPOfgJJnQgD
         NAUdf/8xl8ETAvutNyj1OLMlGt4oyyg7Brh8j/Iaws1mwjRfbYDaiFQ7SiY0RNkWGXG0
         C21mpOuWwFo5eAGckp3SCI+tLCx1gEchLiIxHaRSqmpwseETHRz6dnts63J3u+bVUzp6
         LYdrcYlIjEMRLVFJrfCSLqBJm6WRSNjVHjWmtQdnZmLqb+3VzbdMZ/kcL3VyNo0GP5Wn
         VgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oRf8hyfAQU0WsdMAWiwhiLJaBcc5V3IvYJ9MjSy7h3A=;
        b=60IjOqGzCvjI91lrlOidcFwqKiWBdIyyCI7cmPXUCt/r631DDXBbPpqZ4a5pvK4gUe
         3rjOAtXgLcPsRRdAWHABHl8pTqzzYkdPuyXMJfFAQjoFLHC8KOkTVpfE7y8g3eo9gS+s
         ZvBynloevrmZvSj29ZyoqfCpgf34D5fNnnuyla375P8auiUL+4lMC2KciknntqfGUw6t
         rE3HWeEQlBE+iDkWBSowR2tc4kfQtB0tSlWpU1PJ3rkwcJMPiJSXPWin/8d5I3NuPGhM
         NM6v1hJSddE5fDdn8UgFtx/vyQe2sENQl5ANEsW3GEJ7SVqB/u2JrDast+7FElk/YUgG
         dukg==
X-Gm-Message-State: ANoB5pkhiNINmwqsKnuSkO3azQcy6E3uaSK/WNQUbezqJwpV22r8v5mJ
        A04FsplrGzNteUaOW4lsnHB/wg==
X-Google-Smtp-Source: AA0mqf5G7ZTlx9y8sMyD83CzwwqNtpB4UTzIpE2DSbetVlMOeMk7gLlN/TrpkfoYIMKEu57NRobT1A==
X-Received: by 2002:a05:651c:c89:b0:26f:bd61:ac4f with SMTP id bz9-20020a05651c0c8900b0026fbd61ac4fmr2950909ljb.396.1668790280826;
        Fri, 18 Nov 2022 08:51:20 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id p28-20020a2eb11c000000b0026e059a3455sm728446ljl.51.2022.11.18.08.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 08:51:20 -0800 (PST)
Message-ID: <0750fa8d-72d9-2a14-4d4c-15ca428619a9@linaro.org>
Date:   Fri, 18 Nov 2022 17:51:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [RFT PATCH v2 1/2] arm64: dts: qcom: sdm845-db845c: drop unneeded
 qup_spi0_default
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Doug Anderson <dianders@chromium.org>
References: <20221118164201.321147-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221118164201.321147-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/11/2022 17:42, Krzysztof Kozlowski wrote:
> The qup_spi0_default pin override is exactly the same as one already in
> sdm845.dtsi.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Doug Anderson <dianders@chromium.org>
> 
> Changes since v1:
> 1. New patch.
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index 02dcf75c0745..56a7afb697ed 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -1274,11 +1274,3 @@ ov7251_ep: endpoint {
>   		};
>   	};
>   };
> -
> -/* PINCTRL - additions to nodes defined in sdm845.dtsi */
> -&qup_spi0_default {
> -	config {
> -		drive-strength = <6>;
> -		bias-disable;
> -	};
> -};
