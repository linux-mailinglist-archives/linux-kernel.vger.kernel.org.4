Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FA862C028
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiKPNwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiKPNwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:52:18 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2696339
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:52:17 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d6so29569065lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/sN5vMqqZJd47ORA+vw4SJ22RY5WmlWa/SLNGxSvwM=;
        b=Oq3dUlyrys9vxonQC4MsTkZ21x8iJwr+9O5UJ9iP8CU0Alz8/1hHv47Ez1S22GeT2W
         +jlBY7Hagz82mxhRCRWgFIlKZdCCgep9yuirytiypk/m0+C9iVQaK34h3uRRiew64F5y
         DGLsF0jSXwsSDoYTA7Q81jdnPyZeXNtA8dzrfKeNNC9HCNuxr9k3nth6zicyw6xiZT4m
         LZdbD/AXmim9FVjSaAcSSyIXdpZ1QUYy3r8IF3QWtW5D5GZH9nZbZNUvXmrzVEBay88/
         RgaZz7vZ0/R+jD6aiZyFbjLlwaYWFlzu1lRhMox12anb6orTQZmR4AYEkpUVi1SJrVS5
         3iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/sN5vMqqZJd47ORA+vw4SJ22RY5WmlWa/SLNGxSvwM=;
        b=z+imiJuDjwmYGuYz4q3R8+FnXccgv2wTaNF397Afb06svufHodDAAFcp1ZYr4bgN8T
         TthnKHxcfFHDFk8mGglBBaETHqWA0l3tMhgeRcWpW2IDzeVziSZyQsZ2E6yRToJkwRxg
         Y4vJ3/b9nDOcG2XfEYhzcBJaST1oXYxJe2uOMIRzSn0hNBipKrFR89VuF+iA4tg5j/v4
         oXBFKqmXlk5zXjT91eJktM5l8zfnCC64+nmCH5pE6zOqDARkMH8MsjBlTZl286ewqHvI
         aycQ5BernHVu0uZBRiBpbCLSt9dl2MqJS5MCt9NukEEsmUlq3b8MMTZRWvUugdQ3+qGv
         chJQ==
X-Gm-Message-State: ANoB5plKCaVLhH3r0DDgb7KPpzpkelyS+CSo3qz9YCM59DaNCA9kIz60
        6Se+42qZ8XpuhBnjhPexeezC0A==
X-Google-Smtp-Source: AA0mqf5+Aaf1IJii/g8amoHIECoguxNGsuytXSKTayNUMZBmyuc3V/oB/+JDgp0I9wUAKbgx6gpyDg==
X-Received: by 2002:a05:6512:2387:b0:4a4:7f36:c62e with SMTP id c7-20020a056512238700b004a47f36c62emr6914841lfv.389.1668606735855;
        Wed, 16 Nov 2022 05:52:15 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id z18-20020a056512371200b00498f77cfa63sm2606448lfr.280.2022.11.16.05.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 05:52:15 -0800 (PST)
Message-ID: <7e55b085-ae60-22c8-d961-9bced1edcb02@linaro.org>
Date:   Wed, 16 Nov 2022 16:52:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 15/15] arm64: dts: qcom: sc8280xp: fix USB-DP PHY nodes
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221115144005.2478-1-johan+linaro@kernel.org>
 <20221115144005.2478-16-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221115144005.2478-16-johan+linaro@kernel.org>
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

On 15/11/2022 17:40, Johan Hovold wrote:
> Update the USB4-USB3-DP QMP PHY nodes to match the new binding which
> specifically includes the missing register regions (e.g. DP_PHY) and
> allows for supporting DisplayPort Alternate Mode.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 77 ++++++++------------------
>   1 file changed, 23 insertions(+), 54 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

