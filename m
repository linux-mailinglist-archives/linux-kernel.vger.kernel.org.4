Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAD472EF56
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjFMW2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbjFMW1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8CE1BE8;
        Tue, 13 Jun 2023 15:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44ADB63BAE;
        Tue, 13 Jun 2023 22:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5DEC433CB;
        Tue, 13 Jun 2023 22:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695242;
        bh=/giBIYOdbVKt2nNPEKWExWP7ihJj262AshCzdvOhLBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgGjBs9WX6i9EZ2M0O5qxYt4hvTVwuhDRjrgugdkXrs5wHyNNusDDKLVhFz5qwF/s
         x/WheKzPw+j27KOO4pe7fnbmUhvXQ8k5pZRZiCmSbWmthMO9qZsab8aqvFiyOb+Yae
         YUhg47AcP64zUQKSWPJjuQ7KehFEyHnGRb3d88hWtpup2OTtUtmLWmR1dkEViJ9bLX
         f3seWqRkHx3r4CeO/EfiTNTc9t0cV/n4PVcv82RDumVPvEGTtw9P2RSZJd8tVAQYIM
         IDDYPsEOTrc76WguNTLbxbhwpQfQbxGeyTSSIjA9FL2l4wNRO/mYMlcGG0ZaYUThBN
         EtGrBT1y//5+A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v4 0/2] arm64: dts: qcom: add DP Controller to SM8550 DTS
Date:   Tue, 13 Jun 2023 15:30:19 -0700
Message-Id: <168669542892.1315701.7023894164338964260.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601-topic-sm8550-upstream-dp-v4-0-ac2c6899d22c@linaro.org>
References: <20230601-topic-sm8550-upstream-dp-v4-0-ac2c6899d22c@linaro.org>
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

On Tue, 13 Jun 2023 09:30:11 +0200, Neil Armstrong wrote:
> The DP output is shared with the USB3 SuperSpeed lanes and is
> usually connected to an USB-C port which Altmode is controlled
> by the PMIC Glink infrastructure.
> 
> DT changes tying the DP controller to the USB-C port on the QRD
> board will be sent later.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sm8550: fix low_svs RPMhPD labels
      commit: bbde65f9da9291a77636e1467b28f27ced1b4ece
[2/2] arm64: dts: qcom: sm8550: add display port nodes
      commit: 66adfbc4d33993865a180016db73520a15e754c9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
