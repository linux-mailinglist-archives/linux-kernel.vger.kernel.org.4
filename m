Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61858611CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJ1V5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJ1V5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:57:05 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3469124CC3D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:57:04 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id mi9so4948958qvb.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MUWbiScYvPNDPAH5SO6hLMvIWSq0j/aSTl7hAdbp+eM=;
        b=ofpXCdMGwrvsDSFzvhpHRIVKl/C/xGzCwEox1ACQea24YUKHeNANtX6oZHhnkz61Yu
         kiRBDW1FMJ3q8PwC//hCzVbshy1h4Q9fnCZVCNUZybN6AjkFwcxz/Q9654OwMkQDaQgB
         fFxgJ1SyhlPnKZr64mn3o11dZ0cItCBz3OQfY5+1XnHK+w9EocXXIWaBEVWYGka5mKfH
         xbSU5My4+mGBqaoeD60+WA60dcv34uGucVzx2VQ/Km6P55IibVKB9OEV44VMsKgYGdYO
         WHP23Beb0Yd4iZ4dVqL4ArUz8iKd0cbSBMaMsys0aIaxdqk/1yQlKT5CPJv0kY0nW4Wi
         dWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MUWbiScYvPNDPAH5SO6hLMvIWSq0j/aSTl7hAdbp+eM=;
        b=BNsp2hzl1WRQisIeXHOeGHKcvFrNZWUrQiKbmAksxUZBtiVeInZDyOo0llJhUTwsRH
         mdems37kEuD9gZ9/dNm8qLxS8UVMJKV399eWBvl8yfMaARcxbIo8LRWesWkzy8VCe1s9
         1H9eDbecKDXVNyYJV+7cxttxHZwnsBDMGQ9tq0Kvnq4doUa52/R6wcph/yEpphTwusQ+
         thTh4EbRmTR/5+o1U+gJ/U5HG/Dj6xj+UaxCniL1JTjcv3Mxr4uL235hxBM5UeOgfR5o
         dGP1+cb+fKS/5Z31DsT+kIR7sL+/1zEpYwO/KisjbKoKQLThOFWlwrWC/JiVgcpWbYkI
         U0sA==
X-Gm-Message-State: ACrzQf2hnUh+hcOxbxMcsR84O68gFyBBlr0eHVHg2HfA1UpMWqDlYXUg
        LSroCBLyR2WEuAdo8lYyTfNa4A==
X-Google-Smtp-Source: AMsMyM5o6391rBXXM8kVVIWRdZrhrUEKL+CGQRbHz2sDc/uL5JAsZCXZZnC5JtkC+TJV2J1iW9FVdg==
X-Received: by 2002:a05:6214:1cc2:b0:4af:891b:4e75 with SMTP id g2-20020a0562141cc200b004af891b4e75mr1408505qvd.30.1666994223399;
        Fri, 28 Oct 2022 14:57:03 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id t18-20020a37ea12000000b006af0ce13499sm3681335qkj.115.2022.10.28.14.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:57:02 -0700 (PDT)
Message-ID: <33b13789-33d6-a22f-82c9-4c5691d0737d@linaro.org>
Date:   Fri, 28 Oct 2022 17:57:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 10/16] dt-bindings: phy: qcom,qmp-pcie: rename current
 bindings
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221028133603.18470-1-johan+linaro@kernel.org>
 <20221028133603.18470-11-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028133603.18470-11-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
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

On 28/10/2022 09:35, Johan Hovold wrote:
> The current QMP PCIe PHY bindings are based on the original MSM8996
> binding which provided multiple PHYs per IP block and these in turn were
> described by child nodes.
> 
> Later QMP PCIe PHY blocks only provide a single PHY and the remnant
> child node does not really reflect the hardware.
> 
> The original MSM8996 binding also ended up describing the individual
> register blocks as belonging to either the wrapper node or the PHY child
> nodes.
> 
> This is an unnecessary level of detail which has lead to problems when
> later IP blocks using different register layouts have been forced to fit
> the original mould rather than updating the binding. The bindings are
> arguable also incomplete as they only the describe register blocks used
> by the current Linux drivers (e.g. does not include the per lane PCS
> registers).
> 
> In preparation for adding new bindings for SC8280XP which further
> bindings can be based on, rename the current schema file after IPQ8074,
> which was the first SoC added to the bindings after MSM8996 (which has
> already been split out), and add a reference to the SC8280XP bindings.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Also missing cc devicetree list.

Best regards,
Krzysztof

