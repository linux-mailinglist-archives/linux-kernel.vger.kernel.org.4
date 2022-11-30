Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9779163D9A5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiK3Pmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiK3Pmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:42:39 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976F910D8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:42:36 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d6so27563493lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJwB6KqyIVMzn4j0wOAJzsrP46CJeofvzTlxVSWFabE=;
        b=MpLI+HwIt35XUcKstF+7e01kdbMmeNwPGMyF6irk4pZbP2Ko3LBfzD/NV7sKJEOM+C
         vkd61sLwPwgIB5lbYzOsVFxFec6rHktqopDE8X7n8CxDXaGOaLuxqG48uejGbgpznv7V
         lgepkRBnTY6r8aRqUg5dk9c5BTl9SmPmyRd43371xNcQ3kSoJ/9nfnL2HEEV5I1FdcQ9
         9lvbJO1m/DG60pT3eAx6hGeb56Jne2qlM/hniVoKrqR9bqbSJ2aXQp9g9a0FL7COJylF
         KOivOA8gZH4LLMCBbMbyM+3GhAtla7Yi1Xo2k8EjHczZkgTf55PKY/0ktYx/f8fneL4u
         qjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJwB6KqyIVMzn4j0wOAJzsrP46CJeofvzTlxVSWFabE=;
        b=KhyXB11dw1o/lsc84VriYegNTQBn6C0ZClmUWUWG1UdwGEYBp9FjqlbTiVxAyp1mFB
         qtA2x5Pa+HKN1rSQP5aqQ1Ip98hYx+gb6ZtoWNi1S/gndBg1lWyimOX1tEf6VbJjCRWZ
         uFIpp3YI4/DR7xbhW75JjEe1MgE3e8Ie4Qa+DKjye5IgBsah5cMPC+AMGT3OtLZHW/9g
         NTi8ShLm45BzXZftCFZ3KMzaENxX+3hGz6uXkkv2WlDR1jyV/JlX9gvadzhUuGpZTXwx
         MNL0r4VgJkG1cCcIqNRxVUFJ8mtyhKi4D+LF+GY8bbFzJkIB+4oe/5CO78pua/fwdNAr
         DeqQ==
X-Gm-Message-State: ANoB5pn+sbaJyln2v9ZbvgIob6p2MySmxkd+zk3XwgnAmvdaKco31uan
        t9PYYn3wxeqRPb4ffGJO5LJdyQ==
X-Google-Smtp-Source: AA0mqf57no+A+ocQq4RO9Pj5JGZQB5kXnOS4C3YitgaftA0nbDSAot9TyFZR2UWF17n9EfastBN/dw==
X-Received: by 2002:a19:7b1c:0:b0:4a2:701c:f252 with SMTP id w28-20020a197b1c000000b004a2701cf252mr19978667lfc.125.1669822954799;
        Wed, 30 Nov 2022 07:42:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z5-20020a2eb525000000b0027973ba8718sm162053ljm.37.2022.11.30.07.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 07:42:34 -0800 (PST)
Message-ID: <861fa711-3355-b08e-f542-afd73953144f@linaro.org>
Date:   Wed, 30 Nov 2022 16:42:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arm64: dts: qcom: sa8540p-ride: enable PCIe support
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_shazhuss@quicinc.com, psodagud@quicinc.com,
        ahalaney@redhat.com, echanude@redhat.com
References: <20221130153710.1369839-1-bmasney@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221130153710.1369839-1-bmasney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 16:37, Brian Masney wrote:
> Add the vreg_l11a, pcie3a, pcie3a_phy, and tlmm nodes that are necessary
> in order to get PCIe working on the QDrive3.

Thank you for your patch. There is something to discuss/improve.


> +&pcie3a_phy {
> +	vdda-phy-supply = <&vreg_l11a>;
> +	vdda-pll-supply = <&vreg_l3a>;
> +
> +	status = "okay";
> +};
> +
>  &qup2 {
>  	status = "okay";
>  };
> @@ -158,6 +187,31 @@ &remoteproc_nsp1 {
>  	status = "okay";
>  };
>  
> +&tlmm {
> +	pcie3a_default: pcie3a-default {

Add suffix: -state

> +		perst {

-pins

Same in other places.

Best regards,
Krzysztof

