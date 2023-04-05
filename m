Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAED6D72FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbjDEEGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbjDEEGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:06:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6F23A9C;
        Tue,  4 Apr 2023 21:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4873563961;
        Wed,  5 Apr 2023 04:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F124CC433D2;
        Wed,  5 Apr 2023 04:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667579;
        bh=br2N9hNb3hz+1mZ0Sb+v1Erc46TdP+Tsn0xefJ+rDmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJxv8OKgWJgUvUorCvCjF/3UdjBsqFxjPqm0RVCbMtxbfJGZP8BZpsCiYR5Wdn5mQ
         A7oBEmVrqq5HuPG9TVTv+qgTA7QuwnRtQGziD8mf3O5EA6Vp9AkT3F30IOXzM1cqpi
         ByfXKDw5aMVua60O5Nfu685qcv3UcMW/YjXTnXMU2pmZJHsZbVykBkOFemnGpA7uqb
         J2I/+dqIF/LcO0Y/MY5cZ9pmlFhM/Eeh445JGbg7ouggz0/0hi1Us89Izz2+QC+STf
         0yg9C6jcP8gJyobuPu2cfAqooCB9GhUVdOHjzKKuJxLZNP6jo2dIsCPFKCNfxYuQOT
         ainzVakRpgG6A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Yang Xiwen <forbidden405@foxmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: (subset) [PATCH 1/3] dt-bindings: vendor-prefixes: Add Henan Yiming Technology Co., Ltd.
Date:   Tue,  4 Apr 2023 21:08:51 -0700
Message-Id: <168066774410.443656.16595050579634358657.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <tencent_27DD0718C3FD9C5F7D6E2FBA225CAA760405@qq.com>
References: <20230310143330.9485-1-forbidden405@foxmail.com> <tencent_27DD0718C3FD9C5F7D6E2FBA225CAA760405@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 22:33:28 +0800, Yang Xiwen wrote:
> Henan Yiming Technology Co., Ltd. was established in 2021. The business
> scope of the company includes: communication equipment (excluding radio
> control equipment).
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: msm8916-yiming-uz801v3: Add initial device tree
      commit: 7a888e143f0c87017d91490ea9d0ecc2dc21f2a9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
