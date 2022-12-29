Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA6B658FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiL2RYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiL2RYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:24:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14F615824;
        Thu, 29 Dec 2022 09:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B943BCE16C3;
        Thu, 29 Dec 2022 17:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630F4C43446;
        Thu, 29 Dec 2022 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334632;
        bh=op6isd15GR/BYLoGA4qEKeEXd0FRybjXSgNNmg0wziI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YfhR6ZNEB1DDOxZ9OMNBVd7ItCIGIJJJ1BHPhm1Vkdj5z5QJIJJb8erYNMqc7egOR
         ehhE9QuSHMjO3GYnDuRgZmErUVGv03vyJ2x+Oz7TUsesiX7pmRxodXhRuQQuhkcU+A
         gqBIu/CKRPO6ZKgXk0lrXleLpd2kYwGEwEy+IpNkutEn5H5yIcEyb3xx7o3s2g4tpG
         jmfuAPUWeqHqOPmDlNeWzUBR0+ru3vl/N9o1xRmWDGxidL2mDkZ2zYBdw9+C/hyg0t
         PoQnHSrRkRD/fiu9L5YeAbdlLiZTL4xy8c29gsdkViAXBjGgKy4jcK0u4zCTnTt72W
         UGAFnjvasOS/Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8350: correct SDHCI interconnect arguments
Date:   Thu, 29 Dec 2022 11:23:31 -0600
Message-Id: <167233461761.1099840.5517525898039031248.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221224214351.18215-1-krzysztof.kozlowski@linaro.org>
References: <20221224214351.18215-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Dec 2022 22:43:51 +0100, Krzysztof Kozlowski wrote:
> The interconnect providers accept only one argument (cells == 1), so fix
> a copy&paste from SM8450:
> 
>   sm8350-hdk.dtb: mmc@8804000: interconnects: [[74, 9, 0], [75, 1, 0], [76, 2, 0], [77, 36, 0]] is too long
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8350: correct SDHCI interconnect arguments
      commit: 74b91a1bdb994dfaed0074154ca7d493aeb735a6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
