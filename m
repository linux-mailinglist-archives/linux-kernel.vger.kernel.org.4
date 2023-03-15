Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6F06BBB81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjCORzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjCORzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B891DB86;
        Wed, 15 Mar 2023 10:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1702F61E16;
        Wed, 15 Mar 2023 17:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C454C433D2;
        Wed, 15 Mar 2023 17:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678902938;
        bh=JuXgiW41uiDV3hd/zp6PO0gSqvlFUmnfNa4jKuk8rDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uEoUunSRhmYmTEU3KwzT/KMX5SLXZaB6bOX4At3kCw0XTX7NT0IpLs9k7IdVT+5Op
         0U3kCUz1jyUtbu5zHjw6ANP4p2/+RuwhvXxPcRqTJJ31ojhZgsBILSktsod9pveLl+
         ziDIw90mZSWcqAHav5L9HdVwY/tnGnbeDRompkCkz0MFtBOQKI0l72WwlJbmEdv9MR
         3Rnm6FBx6AKGJ8r65gd7bausjvBrax7let+p5nG8VOyJThLdhlIhhMfiVBW7g0iuZU
         zfJxMvF+KB1/um0Couxwr36G0cesDkj81mgCm/fytcBrYhrn42tdOJEMNaiOPbHt4o
         0QCmD6KwP8NXQ==
Date:   Wed, 15 Mar 2023 17:55:33 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: qcom,tcsr: document SDX55 TCSR
Message-ID: <20230315175533.GK9667@google.com>
References: <20230306072618.10770-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230306072618.10770-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Mar 2023, Krzysztof Kozlowski wrote:

> Add compatible for SDX55 TCSR block.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

--
Lee Jones [李琼斯]
