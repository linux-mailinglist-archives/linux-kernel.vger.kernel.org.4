Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5953F730464
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245198AbjFNQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245100AbjFNQAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9C62101;
        Wed, 14 Jun 2023 09:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27B036441E;
        Wed, 14 Jun 2023 16:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFD9C433CB;
        Wed, 14 Jun 2023 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686758417;
        bh=1X3QAOHMv18jPXA9aP5gteykIFEWVG+CIyEYl8dRj+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4AWc+Ov62cEL9m+jkX+8syY9nIiu/0hOe3bxgObFDpzs4jQJRIyq/ppXxgG2XoDr
         54CTp6mwu3q662CXKkiF7CWo23yGht/2Y7ZAmhDk/Nhn8zDedybcYGkwk+8DbaTkDW
         Q7lT9DJ4XLPnm3wb6nztSAj0ypazmGllvvFzQf7gvFYWU/MXPaZGlqx42Pkakl/54I
         u3q+aJhXoAcCjZEXmNQEnvM/Pn8Q+uPc5k3zKNkfcltBHadyEccZHe3Jal1uJqIa58
         lGce1ASmoQMFVSeQzkO+671tzDG+Fx28qEMgqJzhpiFRf7Nib6XEvvp7V8OPoKysL7
         Qs6ipid0DG7Iw==
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
Subject: Re: [PATCH v2 0/3] drm/msm/adreno: GPU support on SC8280XP
Date:   Wed, 14 Jun 2023 09:03:34 -0700
Message-Id: <168675861182.1453524.13825528487008901071.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523011522.65351-1-quic_bjorande@quicinc.com>
References: <20230523011522.65351-1-quic_bjorande@quicinc.com>
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

On Mon, 22 May 2023 18:15:19 -0700, Bjorn Andersson wrote:
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
