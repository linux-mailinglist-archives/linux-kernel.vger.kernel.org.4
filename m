Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6CB690E92
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBIQpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBIQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:45:38 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1195D1FF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:45:37 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a2so2391675wrd.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 08:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5uR5i0FrMW5N/c1BvQuZ5egyuH7BVj5RSnsyknMvLzQ=;
        b=XaUegsDxVj5QXZDHVD7KSRMczAS+lUxthkMpuK4CerQmBlvHQNoBNpIvqVyaiBM91l
         bLJL457lpw4igMDHcFVjRooyjly+y7KQxf2yN3xXap1m9Ae/nn8fW94Ap2R8g5lU6DwS
         vPLvvfDy7XAYrqJXLotfkJl+o4g35ARzuNG6szs5XHhL3jFGojpgN1CVZzOHM/ACQXHO
         8MIY4OIFNBH/I+26/y2mM+3wAnugSOnhfjOg1/ABjiYmN2OfdHmutuXl9MZewLh54qzM
         vQaWjDoGPssQTK2v3O4JDd0KwHrEaHNVrX9EhyZiVONHFNHRC6FKZ48VFs714X+CtzpP
         5Fig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uR5i0FrMW5N/c1BvQuZ5egyuH7BVj5RSnsyknMvLzQ=;
        b=wFx4fGz0PAB1WE2Uf9G6QwJbhUeYirv/8WuZy/VBN6RB1rIO1n3uV70YJXyCsL4FfR
         2hW44XQ2NBFHAm0iv9t6fha4IUkLYwX0fk5ydSJ9D7Q7xrlHIM4Fr2FfNLB/PLLUbFV1
         2g4qwP+vA6MFJyRXBWnq3SmijN6+T2IEIKHUDuYohLIOeOTdSSJW9rpm3dNodPDF5eMh
         jhIqesMTdgqxxm0nXNmrDoV8Vewpej8eGzHK7czA4T2SfvNsmkwYHSavbGAoWIAhYJVi
         yEF5M7uz1Tpp57c7+4bQd5PkswLKNCPG5538E2C7y45SnHOkEYuAldfP4umWnKWEvbt4
         ucYw==
X-Gm-Message-State: AO0yUKXqWO1iHLnLqznJOj6/A/M+fHnamLN+R+eIIAnbtZtnW3o/TV3a
        xO7gkqwTId+QzATKRutwTXQq/w==
X-Google-Smtp-Source: AK7set+p7l3XRf70/iTHIzo4O2nXKUZqUcmJodQy8/cPPK7RklqnjaQsmn5XZrA/tviz7lznisNvLQ==
X-Received: by 2002:a5d:498d:0:b0:2c4:b150:9273 with SMTP id r13-20020a5d498d000000b002c4b1509273mr2836816wrq.19.1675961136292;
        Thu, 09 Feb 2023 08:45:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d4001000000b002bcaa47bf78sm1649946wrp.26.2023.02.09.08.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 08:45:35 -0800 (PST)
Message-ID: <3c1b7ab9-c228-6d72-47e9-855e12fdba4f@linaro.org>
Date:   Thu, 9 Feb 2023 17:45:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 1/8] arm64: dts: qcom: sc7280: Extract audio nodes from
 common idp dtsi file
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org,
        quic_mohs@quicinc.com
References: <1675700201-12890-1-git-send-email-quic_srivasam@quicinc.com>
 <1675700201-12890-2-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1675700201-12890-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 17:16, Srinivasa Rao Mandadapu wrote:
> Split common idp dtsi file into audio specific dtsi and common
> idp dtsi file.
> 
> It is required to isolate idp and crd-rev3 platform device tree nodes
> and convert crd-rev3 platform device tree nodes into audioreach specific
> device tree nodes.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi | 135 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts     |   1 +
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 126 -----------------------
>  3 files changed, 136 insertions(+), 126 deletions(-)

Actually you need to rebase on latest Bjorn's tree or linux-next as few
properties were removed, so you need to remove them from
sc7280-audio-idp.dtsi:

https://lore.kernel.org/all/20230119122205.73372-2-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

