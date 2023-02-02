Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0477688500
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjBBRAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjBBRAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:00:06 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE28F6EAFD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:00:03 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1918121wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 09:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RhWcv5ExWaP3//OnTLElwVyp8DmK2Pshcf2EZSENjBg=;
        b=S59BU50BWaDwXZXUjhHPMPQGa7RFaMvglYDORCeXz5DaTmSlUJ2pEeHpVpvG1odNcn
         2/pJ/ApUNg8czmIkCXmqq94V4vHr0lpDUY1HXzt63FSvGvTx/543eX5t3veDdyCnIfAk
         5/6DMQ9TqnW/4suGIJVNiXNXj1ypi5g3KnXflobuo6jM3mSUP69IEQxmPX0K0dZF7Bec
         5UJUrww+pMs2a7TzET06rDEcgb+YhC+41FHr1MlwZAeobNe7ABaVjgqsFEAoLElR58SP
         TtJ7XRHL8jHflHSjoptLYiEFMOf6TltMRO3uKW653hr0XZv25puj4uxx0hS0nXvs17vg
         idFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhWcv5ExWaP3//OnTLElwVyp8DmK2Pshcf2EZSENjBg=;
        b=dQX0d8bvYHIpCk5WutA+Bxf7SQpk0VI+o04DAuxCdFWYnjJub90BZwhuQ8gRUZOH5t
         qhSG3xK+e4FGutkSsKPuHbttIpcEqcgiNYcLQki5pCo30jY/Jt8vQ2x6LXgu3MfwM0N3
         l2Gi4Mhd7TqPanVTAYxH2VSxrfGdY0hqF75+zl0E00O3PHZpxsU/k32knVCru+/a5pS4
         7sHcOsswIUiJhngDIp2PXiSttlMkxV08vtA5c8n9dD4ZU+yktjkg5ydErC/2ei8mk0r+
         SD1LbqlH9HoeZzJmKNjjyKy7cJ6cFSCkvxvLbF28uDK8AwRu+86vmWKN1pN8V7bjhamI
         EAGQ==
X-Gm-Message-State: AO0yUKWZwavunf+aj+jPMCDz2lpn4Q0qqYQFDKvb2vi/bz/Jkb9esJZ1
        7HCFtVSepvTU7fzy3M8PwobeyA==
X-Google-Smtp-Source: AK7set8Mz6f9IAFqisS/S6MhfAxrzntIV6lhfSiMTdk8c1G+CNehf5jH9DotPDB/8tObaNdLMHytCw==
X-Received: by 2002:a05:600c:1e13:b0:3d9:f836:3728 with SMTP id ay19-20020a05600c1e1300b003d9f8363728mr6856891wmb.11.1675357202092;
        Thu, 02 Feb 2023 09:00:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id he7-20020a05600c540700b003df5be8987esm3632611wmb.20.2023.02.02.09.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 09:00:01 -0800 (PST)
Message-ID: <9bc34d9a-e4f3-272e-1ebd-c717509b709b@linaro.org>
Date:   Thu, 2 Feb 2023 18:00:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC v3 1/7] dt-bindings: mfd: qcom,spmi-pmic: Add pattern
 property for phy
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
References: <20230202133816.4026990-1-abel.vesa@linaro.org>
 <20230202133816.4026990-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202133816.4026990-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 14:38, Abel Vesa wrote:
> The phy pattern property will be used for providing eUSB2 repeater
> functionality. This will be modelled as a Qualcomm PHY driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++

You need to re-order your patches to keep everything bisectable.

Best regards,
Krzysztof

