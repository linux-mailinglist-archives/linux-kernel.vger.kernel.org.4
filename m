Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF45C73046C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245230AbjFNQAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245105AbjFNQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897E61FCA;
        Wed, 14 Jun 2023 09:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 223E663FDB;
        Wed, 14 Jun 2023 16:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4D1C433CC;
        Wed, 14 Jun 2023 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686758418;
        bh=axFekjr54sw0KjPsVIliju7NLE77XPWr8/EwmApJkHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3ARJp6AhqbxM6n8ZkLdxu+ktlppWCY3gmEMGT0LVOxgLVKrw7dMJI3zSfLWv9b7R
         NxdTSE8RucHckQ/1EHJeEeN4OwOfq8aFBAv9AqJAnGIMYyWPbMkzfgiGVk9BmX4nL/
         2PL2Hk+8cu3Ej5hSiTeuYKSNSGNIrRYGbHRPUqv+IbteH30t7B7gTFQnmAysidySoe
         7UozY4W85+3z7eSO12VYAWZSc1PSO8ofpSiHm+LfAu3sWHcddQkgq3ji+dlVNPKQ9E
         ew0jvfsrFhKNWv0h/jHOSA6HXTCUKWw9gKKweQ6HwHdvouxqQ64tuBFKoyNVuSa0kH
         ObPpEbtRlCPkw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, johan@kernel.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        mani@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 0/2] drm/msm/adreno: GPU support on SC8280XP
Date:   Wed, 14 Jun 2023 09:03:35 -0700
Message-Id: <168675861183.1453524.15760956769812748282.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230614142204.2675653-1-quic_bjorande@quicinc.com>
References: <20230614142204.2675653-1-quic_bjorande@quicinc.com>
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

On Wed, 14 Jun 2023 07:22:02 -0700, Bjorn Andersson wrote:
> With the A690 support merged in the drm/msm driver, this series adds the
> DeviceTree pieces to make it go on sc8280xp.
> 
> Note that in order for the GPU driver to probe, the last change
> requires (which is now in linux-next):
> https://lore.kernel.org/linux-arm-msm/20230410185226.3240336-1-dmitry.baryshkov@linaro.org/
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sc8280xp: Add GPU related nodes
      commit: eec51ab2fd6f447a993c502364704d0cb5bc8cae
[2/2] arm64: dts: qcom: sc8280xp: Enable GPU related nodes
      commit: 598a06afca5a2ab4850ce9ff8146ec728cca570c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
