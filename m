Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8BC6B3243
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjCIXsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjCIXr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:47:57 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7AA198A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:47:54 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m6so4452803lfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 15:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678405673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0SVPt+h4FP4oJDZC6OlFD7ds1qk6UpRDvDwg5Hg2Ch0=;
        b=qOF8IJ9CgvDsTlfU/8eoO1f6RspcB4sHxm9UeX9TFcT4atBj8xB6gEoLOsFGYN444h
         ycK9aYQMdjDpF3aZAPYkh6i5m2xqgQHH74bi/AP1So09TXRxCRFvmV4bgxA65MgKfQNt
         a1QAnKAHDzb1I/TMjnle/icABRaNsrbq8t7vSM259FwKCaNoIYB8GrEims5Emd0R7fhk
         65ntWyddvk0oceLMo6eaWL3fL7WDwHWDLmH4SeRL0U0gcHB3z+CcjK+GrGxlCpZHq8+K
         8GOfwvC4LBMIAsEDBrSxdpHwrepiQZgLKzocjxrCpJ0zw21TiBkh1k1oq7GJjQrgXNZ9
         aHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678405673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0SVPt+h4FP4oJDZC6OlFD7ds1qk6UpRDvDwg5Hg2Ch0=;
        b=a6PAdXNv3sF82OuEpTxIpV6+berwzIsoKTOYtksCJi2E6wxa91nc4ofav7l0DsK9yV
         YegIalXsp0dhL/zdsGvz9b18BgQ//NWT2b3qLDLR9ZpC/5xbSRUhq01ocGR2vswokRRP
         mnaHHWsPV+T/SV6Y5SaVV8Uwf1KRdTmR8m1P7wal160IkqoCIpEoImWFncf9MlS70jbM
         SOi6jaEth1XPhthax9AA92OxLoX6SmACPIqNYK6A4kdccRnoXbqon+bNA9Sdt2h8oYhl
         VZK46ocK/JIAvx7sSq/jwd4LNfapDHS3tceBtWLWlWM8ebWXstqjjSZxM5nlL9NzEJLz
         KnOQ==
X-Gm-Message-State: AO0yUKUAPSWVuwYDTddlVBplguvrvWD4oSpW5M0jwWGTZxmPPcwqGNfz
        Nw1VQnHRYliibz0QIE29ew09xQ==
X-Google-Smtp-Source: AK7set+p5ZH/21/+ytoGxOzCZqhn5qFsf6Cr8OTUVLsl1UVreF+fG8OGkqnex37YJM4kqTm/sXIzQQ==
X-Received: by 2002:ac2:5238:0:b0:4d8:6e26:c74c with SMTP id i24-20020ac25238000000b004d86e26c74cmr6850336lfl.53.1678405673020;
        Thu, 09 Mar 2023 15:47:53 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s28-20020a05651c201c00b00295b597c8fasm57939ljo.22.2023.03.09.15.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 15:47:52 -0800 (PST)
Message-ID: <43c11038-91d5-cbfd-7349-06fcd61a0661@linaro.org>
Date:   Fri, 10 Mar 2023 00:47:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: add symbols to dtb
Content-Language: en-US
To:     Eric Chanudet <echanude@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230309233945.1199358-1-echanude@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230309233945.1199358-1-echanude@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.03.2023 00:39, Eric Chanudet wrote:
> ABL uses the __symbols__ section to process the DTB before passing it
> forward. Without it, the bootstrap is interrupted.
> 
> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> ---
Fix your ABL.

Konrad
> Depends on initial sa8775p-ride.dts:
> https://lore.kernel.org/all/20230214092713.211054-3-brgl@bgdev.pl/
> 
>  arch/arm64/boot/dts/qcom/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b63cd1861e68..72e85ab31d74 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -1,4 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
> +
> +# Enable support for device-tree overlays required on sa8775p-ride.
> +DTC_FLAGS_sa8775p-ride := -@
> +
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
