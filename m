Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC8F713132
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbjE0BED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbjE0BDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:03:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01201189;
        Fri, 26 May 2023 18:03:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3D7A6102D;
        Sat, 27 May 2023 01:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9749DC433D2;
        Sat, 27 May 2023 01:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149431;
        bh=X/V8ccMV8RLRPDZNgK/77xaxHdeXrVE00+Zo/PFjwzE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=t/0K+VcbztwECq1KB+E/Ca7oqFSqOQKOgF9vbXJ9AQf1cFWFkwb2gMiqGW1IuvEIe
         V3O6jLrGDf0d8mINh9be9saM0k5O3zmKRmbIzvbTzOEZ09LQbaWd4rTxlEcA/L6xKu
         WPflXzSq9UB1GzbsJAo4TYsXtajeIQhnYkbWZAmiGBVm69zHMkE2aQhC9FvoXlQteX
         e2OJ1ZD11l+irs4l9r9D6B0IXTcNVbxNZcnaURbDC4L7YUi6RdNIelikA3XAu+I8B6
         K1B1mMXTP6okAt4158qIkxHkyf75PYhtctiAwXIBHZI/yYLAaOEzB3i2XvHk2SZzYf
         +S+ofU1OoVGYg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: (subset) [RFT PATCH 1/3] arm64: dts: qcom: msm8996: correct /soc/bus ranges
Date:   Fri, 26 May 2023 18:07:26 -0700
Message-Id: <168514964951.348612.10272379898437507550.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420180746.860934-1-krzysztof.kozlowski@linaro.org>
References: <20230420180746.860934-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 20:07:44 +0200, Krzysztof Kozlowski wrote:
> The bus@0 node should have reg or ranges to fix dtbs W=1 warnings:
> 
>   Warning (unit_address_vs_reg): /soc@0/bus@0: node has a unit name, but no reg or ranges property
>   Warning (simple_bus_reg): /soc@0/bus@0: missing or empty reg/ranges property
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: msm8996: correct /soc/bus ranges
      commit: 24cf51a2e4519c230fd5cbf281c73043e8bf1eeb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
