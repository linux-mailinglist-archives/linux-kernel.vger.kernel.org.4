Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1971046B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239276AbjEYEw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239077AbjEYEv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B44E6E;
        Wed, 24 May 2023 21:51:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA8C064203;
        Thu, 25 May 2023 04:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B7DC4339E;
        Thu, 25 May 2023 04:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990275;
        bh=XJEw+Vg8PW+q4MCQGbKmTRrVC7neOCFkArsx5Is1BYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ud1isFvFddY7CRbVZyy16F4JQVfTCUEanArputivBJqe/B3t0PjVmjyCA9SuVbTaU
         XlhYFhZWa8W/026noNfpCaaaNo8t03tlWvZedp301sA50mYKb3kfLI8WZj/Zgd2rHm
         nZAPSbBh0JIxDe/2dZUYm2nwzSzX2iwI4txP7XR7ZzYlKHG3onEe2LoO5iOv/5v5p3
         Ob/ZWTAUSQF4FAXXlOZlNWVjRA3scaSBYySGRf2LqTwLBneLS8gUbkYVHmqlQJOtBn
         ONJQ31/llvwLhHS7CV4TbsN+PLy6VJpZQX/UlHoyTAqZiyLXRJ+eukGqhz5S9WXtce
         nafjmmO6OA9mQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-edo: Enable Venus
Date:   Wed, 24 May 2023 21:53:55 -0700
Message-Id: <168499048183.3998961.3568230232045585620.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412-edo_venus-v1-1-bcfc82e0efc3@linaro.org>
References: <20230412-edo_venus-v1-1-bcfc82e0efc3@linaro.org>
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

On Wed, 12 Apr 2023 22:24:51 +0200, Konrad Dybcio wrote:
> Enable Venus on Edo phones. The firmware is signed, as per usual.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250-edo: Enable Venus
      commit: 6ce42cb4b7dc67fdb670930cc72732fa3fc8df2e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
