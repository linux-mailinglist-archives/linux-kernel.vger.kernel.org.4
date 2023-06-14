Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A471C730463
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245124AbjFNQAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbjFNQAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:00:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A49D1FF9;
        Wed, 14 Jun 2023 09:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0729C6441A;
        Wed, 14 Jun 2023 16:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BF2C433CC;
        Wed, 14 Jun 2023 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686758416;
        bh=zPad16VQA2o+Tv/QSFx5CXwfrqAoNBmN4FNn4dNqSfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IqIz4aoYiZIynb4a0IkxtYp1hA3pbZdfOEr9EI/SmjMoK+97BonO9VYTXDWyARNvQ
         gD7yeeIcvMI2ffB/UTlLDd7ftokEJwxtWJzu26+2kTVfStFkKgcIHir2V089tlk1XS
         auPJV9J3SyvAc83wz4nRNY9mzRfvVIUtM/61LTB9PGQLSRD0nbaRU88wBXPvOihMHd
         1Y/JpjbJwD8fRJgvo46FYW+zDjhyVL3MmYE0dm3JMiLMWT99aqB8QKEbcIkO5eR/ul
         GUeH9O7SJpDlWvODlwG9SZPNG5VqIgw5pmgNY7x/u5j5plrzRhy+GOQFLTi9MTuApE
         dABo0JIY+Qt/Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        johan@kernel.org, Akhil P Oommen <quic_akhilpo@quicinc.com>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        mani@kernel.org, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/msm/adreno: GPU support on SC8280XP
Date:   Wed, 14 Jun 2023 09:03:33 -0700
Message-Id: <168675861182.1453524.13931605500633983519.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230208034052.2047681-1-quic_bjorande@quicinc.com>
References: <20230208034052.2047681-1-quic_bjorande@quicinc.com>
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

On Tue, 7 Feb 2023 19:40:49 -0800, Bjorn Andersson wrote:
> This series introduces support for A690 in the DRM/MSM driver and
> enables it for the two SC8280XP laptops.
> 
> Bjorn Andersson (3):
>   drm/msm/adreno: Add Adreno A690 support
>   arm64: dts: qcom: sc8280xp: Add GPU related nodes
>   arm64: dts: qcom: sc8280xp: Enable GPU related nodes
> 
> [...]

Applied, thanks!

[1/3] drm/msm/adreno: Add Adreno A690 support
      (no commit info)
[2/3] arm64: dts: qcom: sc8280xp: Add GPU related nodes
      commit: eec51ab2fd6f447a993c502364704d0cb5bc8cae
[3/3] arm64: dts: qcom: sc8280xp: Enable GPU related nodes
      commit: 598a06afca5a2ab4850ce9ff8146ec728cca570c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
