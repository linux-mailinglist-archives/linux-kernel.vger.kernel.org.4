Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C70623AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiKJEJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiKJEJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:09:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709027FE3;
        Wed,  9 Nov 2022 20:09:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 143A6CE214D;
        Thu, 10 Nov 2022 04:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D60EC43470;
        Thu, 10 Nov 2022 04:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668053359;
        bh=81lSIlfnbBdiRPpJNDMzG8ycVnvzAqMfAXrNG856iJ4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=StnQH+n2430+Bem/9YzRlTlh+6vkhRxNmrPJTakkYrKlzjQDJQhVu07vkdoTB1H/M
         0Wg6C7gCm9GBtMrSe7x4f6zOA/I+/e5iQAE5JbR2E/qVZL2/GOE9qA1dQOEjm6qURx
         Vc3oxvkIXJEKc7mTaa4qHmhikhgZLunlhlcamtniJXJmHko1rgwhKQ+Zf5IzfCrnAK
         5+kBCNC/KARlNE49LJSpwBpAbpbKCsVq+ryAYbffpCnEjMnELju5ds3qVZJu8TlvsJ
         H9tk0TROADX867Cm9IjY816WBHd6kekY5kWziX0upBIEMqnC4L9YuM/XvMVz1P/esv
         FulPI4ZbmzidA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_rjendra@quicinc.com,
        dianders@chromium.org, swboyd@chromium.org,
        srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org,
        vkoul@kernel.org, quic_rohkumar@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, quic_srivasam@quicinc.com,
        mka@chromium.org, judyhsiao@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, alsa-devel@alsa-project.org
Subject: Re: (subset) [PATCH v6 0/4] Convert soundwire bindings to DT schema
Date:   Wed,  9 Nov 2022 22:09:11 -0600
Message-Id: <166805334842.800572.16401396604947075257.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1667918763-32445-1-git-send-email-quic_srivasam@quicinc.com>
References: <1667918763-32445-1-git-send-email-quic_srivasam@quicinc.com>
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

On Tue, 8 Nov 2022 20:15:59 +0530, Srinivasa Rao Mandadapu wrote:
> Convert soundwire bindings text file to DT schema and update
> device tree entries to follow strict dt-bindings.
> Changes since V5:
>   -- Update indentation of few properties description.
>   -- Update minimum and maximum limit for few properties.
>   -- Fix Typo errors in commit message.
>   -- Update commit message with differences from text file.
> Changes Since V4:
>   -- Update interrupt names in example.
>   -- Fix blank lines.
>   -- Remove dependecy patch info.
>   -- Split dtsi patches as per SoC.
> Changes Since V3:
>   -- Remove subnode description and add appropriate pattern properties.
>   -- Add interrput names in example.
>   -- update some properties description.
>   -- Revert minIteams change in previous version.
>   -- Rebase to latest code base.
>   -- Update dtsi node names,
>   -- Remove redundant property in soundwire node.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: Update soundwire secondary node names
      commit: bd35f4b0179692cacc8cd80aece56012b3b36c69
[2/4] arm64: dts: qcom: sm8250: Remove redundant soundwire property
      commit: 837f597ebc529b2dce6451da27f24d93ebe194c8
[3/4] arm64: dts: qcom: sc7280: Remove redundant soundwire property
      commit: 78043031281bbb31f89b66128982f404bcde94e8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
