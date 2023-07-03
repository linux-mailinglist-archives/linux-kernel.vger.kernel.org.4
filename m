Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A66745F4B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjGCO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjGCO7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:59:55 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B404E75
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:59:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb41682472so6865203e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688396387; x=1690988387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJbV4N7RLwElD/TMXfmSwrFrJd7AnATyySwRyBz/hoQ=;
        b=kOaT+uWHkgGk5HsBjYPxtWaMuXM6HogvNgwkhgIFSBRHBuJClwWuaLflr2ViTkbWzn
         2SWHjIDcWmbniM/GIIZpNhJO+hmRiv8qeF52E6aMUzNIcz4hY3UaoTvoKyOFNudLmSsZ
         MqPtoyThQLWFMDxtHLowi8cHb0nZ9P3KmTfOgw/SJGEpGT4o1P3tkrFca1/isGr2w7gW
         EcYDNVIuH5yYlgfZ3Rmw7Kh0KL7tpTBna8+J9BEbYvJyOFY6X/ksJwzthrspvqDVL3Tp
         S8hq6Jo7Uk6ob/UmN33PHobQ5N/WwopdAiJ4jZd+gkN67NV56ELFJI5tqFhgsfGuCNah
         VlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688396387; x=1690988387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJbV4N7RLwElD/TMXfmSwrFrJd7AnATyySwRyBz/hoQ=;
        b=Qa6ovePrjh+ol0Y5wiXGfZLig+8Jl0Tgns2YwB/5zrvWOZxpGqQ9xqY8RS5QSHcaoE
         uMCzh2+ZmJ3fUrK41ZmSxDsZMCIDBwFCfs1Udsi/drQBrVO8JF/OMwNqmuYDt154G4RM
         LBGa/EU4TwnwmC55p49IHbS6Sw8V1ipsVup0yA0TMoMOfr1vvdMrIAY5UyoJh0PdmTQo
         H2/o0GOc84GghL8sOT/be0VpMpi9mS2KJF1frf3PLZ20KcvHOz5WjJ+bhcH32PcSXraf
         TGIY6LwKLxZBqAjyVYaH9s0Vk1PBCLa3IEUYjXKetdXPr2ShQw6Cm3yXDt4KieHxTLQk
         Rp2A==
X-Gm-Message-State: ABy/qLZ35dhL4mlK8zpQdzNMpe/ou+SngpVXC2P+JMsrZesS3CzqO9Pu
        JFW0Cre2xDZiyjV5yKGquUsPqA==
X-Google-Smtp-Source: APBJJlG9ApmvdjqzfVKnyOdHThzxebr1CwTamo13HN9k60suQ2wP0Gn6o8umombS4pOFRzHYJohAjQ==
X-Received: by 2002:a05:6512:31d6:b0:4fb:96ed:93b3 with SMTP id j22-20020a05651231d600b004fb96ed93b3mr9651485lfe.65.1688396387608;
        Mon, 03 Jul 2023 07:59:47 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id y16-20020a197510000000b004fba5eb0a64sm2013958lfe.42.2023.07.03.07.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 07:59:47 -0700 (PDT)
Message-ID: <0d468d08-6410-e424-b4f3-5245cdb0334a@linaro.org>
Date:   Mon, 3 Jul 2023 16:59:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 02/10] dt-bindings: power: Add rpm power domains for SDX75
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688395346-3126-3-git-send-email-quic_rohiagar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1688395346-3126-3-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.07.2023 16:42, Rohit Agarwal wrote:
> Add RPM power domain bindings for the SDX75 SoC.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  include/dt-bindings/power/qcom-rpmpd.h                  | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index afad313..58e1be8 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -40,6 +40,7 @@ properties:
>        - qcom,sdm845-rpmhpd
>        - qcom,sdx55-rpmhpd
>        - qcom,sdx65-rpmhpd
> +      - qcom,sdx75-rpmhpd
>        - qcom,sm6115-rpmpd
>        - qcom,sm6125-rpmpd
>        - qcom,sm6350-rpmhpd
> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
> index 1bf8e87..8092d0d 100644
> --- a/include/dt-bindings/power/qcom-rpmpd.h
> +++ b/include/dt-bindings/power/qcom-rpmpd.h
> @@ -57,6 +57,14 @@
>  #define SDX65_CX_AO	4
>  #define SDX65_MXC	5
>  
> +/* SDX75 Power Domain Indexes */
> +#define SDX75_CX	0
> +#define SDX75_CX_AO	1
> +#define SDX75_MSS	2
> +#define SDX75_MX	3
> +#define SDX75_MX_AO	4
> +#define SDX75_MXC	5
Please instead introduce a set of defines without the SoC prefix
(i.e. CX, CX_AO, MX etc.). We've been putting this off for too long
and you're the first unlucky guy that submitted new RPMhPD support after
we've concluded it'd be the way to go! :D Sadly, we can't replace the
existing ones retroactively..

Konrad
> +
>  /* SM6350 Power Domain Indexes */
>  #define SM6350_CX	0
>  #define SM6350_GFX	1
