Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965C266A1EB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjAMSZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjAMSYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:24:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7D35FCA;
        Fri, 13 Jan 2023 10:18:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEECA617ED;
        Fri, 13 Jan 2023 18:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3A2C433D2;
        Fri, 13 Jan 2023 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673633921;
        bh=mKUT5+shFUmJtqhjiyzj9el6WptuGyz/rzSRZcDxRls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPrDS671h4NTjpuPfwK23nsvE2kHsEPNYRm/aI/JQHZjVJ6GDqp8WHhHjX4Esr3Uv
         2gV6DKeK8M5f5/JV9PVQ205kbFS6kCqMnlabNLOCKYJagQAkD9+Edz0nNrIruespo1
         hdOpSga+mLw1FohprG34N9B4QldVIOdFFOdm32SEDBSmZtmHt28EBrK+wQFI371BP8
         uic4RKsZJoepTyvWCxhfhn1YCG1+SNqnoYEl6rtMpGyHIKG0xTMf/eVQj4A6PAszFf
         iTZ9oPKA38ea+rXvezVEbuZgat+XdWh32oZe/NHuuulk5diNJyY17CZ4ivW6Do1FG5
         k24D8TKGWIDzg==
Date:   Fri, 13 Jan 2023 23:48:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom,sc7180-qmp-usb3-dp-phy:
 correct SC7280 compatibles
Message-ID: <Y8GgfJj0/AfpuWe7@matsya>
References: <20221225115944.55425-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225115944.55425-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-12-22, 12:59, Krzysztof Kozlowski wrote:
> USB3 DP PHY on SC7280 is used with SM8250 fallback:
> 
>   sc7280-herobrine-evoker.dtb: phy-wrapper@88e9000: compatible: ['qcom,sc7280-qmp-usb3-dp-phy', 'qcom,sm8250-qmp-usb3-dp-phy'] is too long

Applied all, thanks

-- 
~Vinod
