Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2F7658FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiL2RYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiL2RXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:23:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F051572A;
        Thu, 29 Dec 2022 09:23:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F059BB819FC;
        Thu, 29 Dec 2022 17:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AC3C433F2;
        Thu, 29 Dec 2022 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334628;
        bh=f4qbSIX1trq/ppAn5tzcZT+1xA6g2aglJXbO/tuuCRM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dYY0J2PBAd0V/YFP5y2pQi0vUeVDJssBM3nWOqpSn63wdU4/SGGnQid9i6MwhWr6x
         LzAZUVyMrMWf5uzVtY09LKdB1arHdPctg0Pc+GXluKEh1EbATuOBVUiffBYDCLNtxu
         kQtVdIpfhPDaYspXMkxD19NUS+sWAtIhq7pzSVABzaIngJv0J6cl5vvVIYYlrrlaBZ
         sTxt0jDfMBq6y2UXFDElr196YKis7RWpR/dVrcxcMjnO3VEo9azoS3HCW91XOEc9sm
         oKcqbFwKs7PMBkacvN8OEG4xM7wIGMFJnOoZsC52LSp1euksT2+m86egKFKdlWyGrU
         GtkNklu8UOpjg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8350: add missing core_bi_pll_test_se GCC clock
Date:   Thu, 29 Dec 2022 11:23:27 -0600
Message-Id: <167233461761.1099840.12664860663268924520.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221228112456.31348-1-krzysztof.kozlowski@linaro.org>
References: <20221228112456.31348-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 28 Dec 2022 12:24:55 +0100, Krzysztof Kozlowski wrote:
> The GCC bindings expect core_bi_pll_test_se clock input, even if it is
> optional:
> 
>   sm8350-mtp.dtb: clock-controller@100000: clock-names:2: 'core_bi_pll_test_se' was expected
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sm8350-sony-xperia-sagami: specify which LDO modes are allowed
      commit: 8ea261588fe98d171fcecf477a9f27aea8a06fd0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
