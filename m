Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8810B5E9C87
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiIZIxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiIZIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:53:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F3C3CBEE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:53:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso7039623wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=jkEVmESIjldrQZxP/waf6fg7i9RzypTZ17JTwhip758=;
        b=OVpYxgPJKpPIV5mF285rMiNBj6OV+KyYJVUuKsBARQVLYj/aVVcB871bslFwZsiS+0
         +CyJT4PkzM8caxZOj33MAwSkQ7Xjg5sjOxc+UWyWdHLR6/t6iEmrfMSFx3Cil5U2eLbI
         YyfSg3eXpvoJM+eLY5tqtOboXuDPsdYm4MUIBaRZluYfOZn4Bc+FeNA4N/DofxHHpK/l
         Sy2sOIwAM6K1//rWGR2xdiLcyXYj4xO90t9kSdESOywSyqa7/vR7O+8IbDRe0zGIdD7d
         WZ7nTv93GvUK6VU4b8+p1PvxODe6NtJ9B+pqiyStVO0vo/0W2x1hEr4Bs8XOnzaItr9D
         x05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=jkEVmESIjldrQZxP/waf6fg7i9RzypTZ17JTwhip758=;
        b=JQP9PGiKOS2CqAP3UY6oYRh0Nueip+CuwsDIYzgM/6vTdmVzMkY350AK319bOziDKP
         qOK29GCObE1g4kDVn2K3XyI4HCuFp/1wiHTpw50Vn6WcT17ZHw7ko9w9khjoB/JhKX9J
         00Rk2HRdnB+BpyYb+Vt6jraqzmvOIBfXBnaasTOPDtP1oV5dPM+MRMlBi/+326YOWJ5/
         7LuRH3Daj5sYz2iITisjLsh3qdMNwLcBSW+NBp13mP0FG0ElFLQz2Fr7hlzWoVZG+kxy
         Z2CIDWP243swxs+kFUxAC2dWrDbYJ2B08o3Ar10wZiDxAMDYhuV9OQors/0gPDbt5cFA
         VGFA==
X-Gm-Message-State: ACrzQf30/WZpiNdOmFmUavgCcpaH76NGlat4uiR22TD+pTOaCy5wl/1W
        Lk73a9PLQGIjatDwByOl2Z62bA==
X-Google-Smtp-Source: AMsMyM7cfcoxe30tr7ZB4w6NFKaS/3Fn4R0iWlG1tRQoIcNHmTheKCoOudFH+SG6cXAbJbFaaj5qXQ==
X-Received: by 2002:a1c:f002:0:b0:3b4:dda4:b58f with SMTP id a2-20020a1cf002000000b003b4dda4b58fmr20817414wmb.184.1664182383419;
        Mon, 26 Sep 2022 01:53:03 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b003b4764442f0sm10838798wmq.11.2022.09.26.01.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:53:03 -0700 (PDT)
Message-ID: <e195f7dd-bb93-1269-9399-c5f58ebecdc8@linaro.org>
Date:   Mon, 26 Sep 2022 10:52:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: dts: qcom: msm8974: Remove bogus *-cells from
 smd-edge
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925173203.96117-1-luca@z3ntu.xyz>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20220925173203.96117-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2022 19:32, Luca Weiss wrote:
> The bindings check complains that #address-cells and #size-cells
> shouldn't be in the smd-edge node. Remove it.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>   arch/arm/boot/dts/qcom-msm8974.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index da247d799492..c2cf6a95d40d 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -1703,8 +1703,6 @@ smd-edge {
>   				qcom,ipc = <&apcs 8 8>;
>   				qcom,smd-edge = <1>;
>   				label = "lpass";
> -				#address-cells = <1>;
> -				#size-cells = <0>;
>   			};
>   		};
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
