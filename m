Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22A972F09F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240983AbjFMXr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbjFMXrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22682D4C;
        Tue, 13 Jun 2023 16:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCA3C63C85;
        Tue, 13 Jun 2023 23:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23650C433C9;
        Tue, 13 Jun 2023 23:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699944;
        bh=B4SCq0iczA9nvDpM+xGfWptMw9Oi7D28BNYtK11OW0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2g4ddkHfQmMSHrhzk3565U5nnjXV5BZktWsZIZywd3oaOAgpm7OA2tkJ3Iqy0OmG
         VLCrK2KIUIlM4hbUVPDMM2EOuJRE1U7fRMfKXG+cZbxGU+hAzX5r6OsIpQIAPNBCc0
         QbZLgoyiLbzfzWScDy9jaNYKKjxg2LxMzcQj9fnmw5xKX1dzzHGl/ws7kwYs/7Lb/k
         CnFSE5s1iL8cAjfsthEB/kZOBPRBB03llteMpSFmAhJbJBayW3auAlLm8aD0wGdLyh
         x3XOWqW5FNjmXZAC2aDNbVjO+lNWlu8SXq4rsZF72lBKA90DkRS7jABzvXXxzAi73p
         wwKiJpbfu18QA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        iommu@lists.linux.dev
Subject: Re: (subset) [PATCH 0/2] SM6375 GPU SMMU
Date:   Tue, 13 Jun 2023 16:48:47 -0700
Message-Id: <168670013502.1400697.11946020572385370506.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531-topic-sm6375_gpusmmu-v1-0-860943894c71@linaro.org>
References: <20230531-topic-sm6375_gpusmmu-v1-0-860943894c71@linaro.org>
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

Applied, thanks!

[2/2] arm64: dts: qcom: sm6375: Add GPUCC and Adreno SMMU
      commit: 852865530a21d139196106543cdf3e76c389659b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
