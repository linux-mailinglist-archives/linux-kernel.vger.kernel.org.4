Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E09C601480
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiJQRQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiJQRQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:16:00 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F5369F43
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:15:59 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t25so7060083qkm.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZecDoFZ2FP/kx+KdceBdgeFczEPpStIKFSrAh+N6jU=;
        b=LXDJSdcdeLuJYxtyhdZsAI0SNOP4m46trXhDeGqAl1V4CXsnADHkT0hIDME8MnMKpI
         XBRruyzZYQU82Ll4/zEH84hcvRlJ5p0pM24FEdi5Trj7CTeEI1d8RPsKNT7QdSC9Kk7j
         FUS7JzlCBQn62wGI4XV7Zpvnrd+X8g6r3HyWyrjajvVTkywCowHWSf0/u/g+UB71GKVG
         ZpVr4VlhfALLqJaTazVk01O8UnzXNlTtBo5yQ3Tsze986io4/+j+sr6ysWbXSR/GHd6b
         NJNjvUQnYN1Nh7QE2Hx/xz1HWrS+egDBtsPwtlDO59O0zmebeJERkOTe9SqTbp4xeFXd
         dXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZecDoFZ2FP/kx+KdceBdgeFczEPpStIKFSrAh+N6jU=;
        b=rVycdoM6WyF0UBfNhbXT9RD5mQQ+zEWhK1CBlF6NGLrmO0FE/hy1eQuA/jeioFu18J
         L6gS1VjcdFBHzg5RsqB4nPONBkUOKQLYr5R7nrgjcS6Ql09KaUuBZ26LO3I9gg/IqqZd
         zJljflW1XnU9Fah4ESm2CE79PlVUM/5W2oB7upl/20ajRb/U9Nxy31U+2A/tMrrPwOJg
         4TmusKQJX6o6b6tOarQ666Rc9thVngT0UrWtiXbcIxARn5aEuq+UPLgllF2A9xPPZvdL
         EXZ6I3wgswmsv+pivOesprh73HB41u8iizwNjQTY3EPTlmpZbxFBfM97W0N8ss3pi7L7
         vS1g==
X-Gm-Message-State: ACrzQf2/G0YrrFNbr2STBAeHghGxdySBj34hoPLhMnisuLMFpupg3ngm
        r7TyABi+I70ZqQ4jN7qSXKUeLw==
X-Google-Smtp-Source: AMsMyM78cEACn7q29/KOCzKKbKrK66y2E/xmtRkYp6XmajqupdFIvn1kcwfKZf54KpEbLcIXuiHOEQ==
X-Received: by 2002:a05:620a:46a7:b0:6ee:dea7:cc1c with SMTP id bq39-20020a05620a46a700b006eedea7cc1cmr6200325qkb.506.1666026958537;
        Mon, 17 Oct 2022 10:15:58 -0700 (PDT)
Received: from [10.101.5.247] ([148.59.24.28])
        by smtp.gmail.com with ESMTPSA id c25-20020ac81119000000b003996aa171b9sm169442qtj.97.2022.10.17.10.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 10:15:57 -0700 (PDT)
Message-ID: <5e153119-f853-ff57-8277-2d782e255be2@linaro.org>
Date:   Mon, 17 Oct 2022 13:15:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 09/15] dt-bindings: phy: qcom,qmp-pcie: mark current
 bindings as legacy
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221017145328.22090-1-johan+linaro@kernel.org>
 <20221017145328.22090-10-johan+linaro@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221017145328.22090-10-johan+linaro@kernel.org>
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

On 17/10/2022 10:53, Johan Hovold wrote:
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
> bindings can be based on, mark the current bindings as "legacy".
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../{qcom,qmp-pcie-phy.yaml => qcom,qmp-pcie-phy-legacy.yaml} | 4 ++--

I don't think we should rename anything as legacy. These are "normal"
platforms, not legacy ones. SM8450 is not even that old.

The recommendation is to keep names matching the compatibles, not adding
some legacy/newer/newest suffixes.

Best regards,
Krzysztof

