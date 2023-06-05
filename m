Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874CD722CC2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjFEQfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbjFEQff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:35:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA90411C;
        Mon,  5 Jun 2023 09:35:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7799D6281F;
        Mon,  5 Jun 2023 16:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C04C433A7;
        Mon,  5 Jun 2023 16:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685982928;
        bh=YpF8KnazYCU1ts51crNZK0GQy+R6C0M3FsaVYRAaWu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k89yT2+0OdiOHy7eFZIplfBfY8cBM26XycksSCxqn2/TYK7yJq09GeBNCY0/gogUA
         ZKHFMKkCXEWkBlOm0GskrF4pZxMRsQt3h76rDzs4L/1xfVM9z2WMKaOYWOqhKzq6Ue
         PJ51Ds5/MmLPJ+zyYapsaB9RoXHxgKPsaxsYLR+INtKMfnRQTnQ1dtroUVL2s/oveS
         4aSkyIIZ4Wx3LvXUoH/5ohf0fNDl5fzH44z0rFd0D+YBgeZcQUgEND1sNX3kuAp3y7
         qDI2jU9YQXKeKK8DLY8wSmhPGWF8IypFKBszWMi0oBkMsoCKYIwt8I3OlXBM/uhRSi
         R2laYsDrRsxmA==
From:   Will Deacon <will@kernel.org>
To:     Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] dt-bindings: arm-smmu: Fix SC8280XP Adreno binding
Date:   Mon,  5 Jun 2023 17:35:06 +0100
Message-Id: <168597889655.22601.5244449695920772097.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230523010441.63236-1-quic_bjorande@quicinc.com>
References: <20230523010441.63236-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 18:04:41 -0700, Bjorn Andersson wrote:
> The qcom,sc8280xp-smmu-500 Adreno SMMU binding has clocks, so fix up the
> binding to allow this.
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: Fix SC8280XP Adreno binding
      https://git.kernel.org/will/c/84b8a7fe2920

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
