Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8080D722CC0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjFEQfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFEQfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:35:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7721EC;
        Mon,  5 Jun 2023 09:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A3976281F;
        Mon,  5 Jun 2023 16:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA573C433D2;
        Mon,  5 Jun 2023 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685982923;
        bh=9MUmkLDtIToYd9V8NeIlMZ2u6glZyMADhdjMo7PXa/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o9p3vloDHX1j/zkqijJx5n840xvdqcWa9nb+UxkHX546s1eNB8WZghVr2JfQ2SloE
         ujooE/1fhezPJyZu1STyVIFo/5sbR/WPZI6b1rv5603nKQoCWSg3whzirKvfVr7M15
         NOlafbciQ5cnRJagU4e+z42JXsySpUWkrq8KY78uyVnyvZ2mbBIZyW3ikuZWZq8/AO
         CPLZ2EmC2hqbatV0VBRWs0klxIG/FVryjtAnUQ7cisrRznAazL9VL8TdGYhDDLpvoi
         +m4nzW33PsGMJ5k5Myr6/969o+SN5t0CovZEZWq+5wA9Y8d/SDRrOdgYOQ9UB4DzSL
         BuIoSeXoUnNJg==
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        iommu@lists.linux.dev
Subject: Re: [PATCH 0/2] SM6375 GPU SMMU
Date:   Mon,  5 Jun 2023 17:35:04 +0100
Message-Id: <168597965563.30054.140440008485884265.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230531-topic-sm6375_gpusmmu-v1-0-860943894c71@linaro.org>
References: <20230531-topic-sm6375_gpusmmu-v1-0-860943894c71@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 17:04:22 +0200, Konrad Dybcio wrote:
> This series hooks up the GPU SMMU, as well as GPUCC as its direct
> dependency.
> 
> The thing sadly can't seem to be able to do PPPT, not even on downstream..
> 
> Depends on (bindings and functionality-wise):
> https://lore.kernel.org/linux-arm-msm/20230529-topic-sm6375gpuccpd-v1-0-8d57c41a6066@linaro.org/
> 
> [...]

Applied bindings patch to will (for-joerg/arm-smmu/bindings), thanks!

[1/2] dt-bindings: arm-smmu: Add SM6375 GPU SMMU
      https://git.kernel.org/will/c/44984d56e059

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
