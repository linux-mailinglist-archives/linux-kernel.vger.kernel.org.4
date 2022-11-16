Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC5F62C07A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiKPOHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiKPOHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:07:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3221B9EB;
        Wed, 16 Nov 2022 06:05:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E19B61E15;
        Wed, 16 Nov 2022 14:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94B6C433C1;
        Wed, 16 Nov 2022 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668607521;
        bh=R8UCmC2PII2RGSBxpsMRtJ4RLUVrVzZ8ARuUjOc0CLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bfG1n1t/4pXfJpmdenAxdRhMapuo09xYup27Ck8KCVIhUwO+IbhstQSbmy8bk5bRQ
         sVouTNIntNsthevLuBt4FBh6N5oAww7Nyfhm2bnk9oFiIWZc/xWMhoHST1dpMRB3MZ
         xpJjWB+0579QwIScULLQ1M0WdDlDwgUncCYiM43QyUkI/JI5rXV1UEhpG0c/rP9cQK
         +67hv8F5FH5kmvBmXmY21DpLq6A3S/xQTP+AOGwSPkmB6uHWJOu73xJwRVLABOUaJm
         6pyDtcuK2msLIhbvL63deTiclPQoDyd8e5eKjPAiZ6WpClAOMaBhxzErV36C3alZq7
         O+Euh/xk09Vrg==
Date:   Wed, 16 Nov 2022 14:05:15 +0000
From:   Lee Jones <lee@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mfd: qcom,spmi-pmic: rename extcon node
 name
Message-ID: <Y3TuGzPnU6LTWzSm@google.com>
References: <20221031175717.942237-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031175717.942237-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022, Luca Weiss wrote:

> extcon is a Linux-specific name and shouldn't be a part of the dts. Make
> it be called usb-detect@ instead.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> This patch builds on top of
> https://lore.kernel.org/linux-arm-msm/20221031173933.936147-1-luca@z3ntu.xyz/
> But could also be applied without, if conflicts are resolved.
> 
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
