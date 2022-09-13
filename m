Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799435B762D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiIMQKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiIMQKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:10:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E9D9C8F8;
        Tue, 13 Sep 2022 08:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADF3AB80F9B;
        Tue, 13 Sep 2022 15:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CCAC43146;
        Tue, 13 Sep 2022 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663081493;
        bh=YKWqRD9wZIFrxL18F1BNYMX4z1L3xqPjo9erakavuBU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b6BbhXpMfeGlD5twA1x00f6ASvphPE1IPmL4ENfrj0FWQ4AJnD3cJYbJa95H/cvT1
         3N7cseAHaCiq8Fugs6VAJFjioBuJxOcQ4o1XD/SMYDYeSNB9aR1PDF45RlUz2t05JU
         GGLAAotRgCFSJeht45NuYjtaeXc92cvxRbOLumvXOuvxJTyHy1wQ2b8GHDfHOvMLAk
         BbBVKV6k3n/JIi28nqevBsz/5dy5jfbPegPVKAVeke8ZrSSb5NooNsUjqeb6Rgv4+C
         24xZjIGEwKZ4FeAHaL+zG1JmwfN9LI1iMhnch90LQitfU1pORlWXTubxqgVare8LBS
         P45Un9kYRslOQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_srivasam@quicinc.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org, swboyd@chromium.org,
        judyhsiao@chromium.org, robh+dt@kernel.org, dianders@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, quic_rohkumar@quicinc.com
Subject: Re: [PATCH v12 00/12] Add soundcard support for sc7280 based platforms.
Date:   Tue, 13 Sep 2022 10:04:45 -0500
Message-Id: <166308148199.625876.290176664932096979.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1653049124-24713-1-git-send-email-quic_srivasam@quicinc.com>
References: <1653049124-24713-1-git-send-email-quic_srivasam@quicinc.com>
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

On Fri, 20 May 2022 17:48:32 +0530, Srinivasa Rao Mandadapu wrote:
> This patch set is to add bolero digital macros, WCD and maxim codecs nodes
> for audio on sc7280 based platforms.
> 
> This patch set depends on:
>     -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=638776
>     -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=634597
>     -- https://patchwork.kernel.org/project/linux-clk/list/?series=637999
>     -- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=638002
> 
> [...]

Applied, thanks!

[01/12] arm64: dts: qcom: sc7280: Add nodes for soundwire and va tx rx digital macro codecs
        commit: 12ef689f09abb50f0862c8e08138dd45cbf27233
[02/12] arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD 1.0/2.0 and IDP boards
        commit: d3219de8bcebe4057696a2f99ce90c8812114c78
[03/12] arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for CRD 3.0/3.1
        commit: d5a959f96be1b27c81d6197d66624cd6cc146fe6
[04/12] arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 1.0/2.0 and IDP boards
        commit: f8b4eb64f2003e0a1fa5011009955d46f90af285
[05/12] arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 3.0/3.1
        commit: 0a3a56a93fd96cb3e3d42778f275e91750c242a7
[06/12] arm64: dts: qcom: sc7280: Add max98360a codec for CRD 1.0/2.0 and IDP boards
        commit: d6c006f510d9f29ff78761bb3ef50f14ebc05b7b
[07/12] arm64: dts: qcom: sc7280: herobrine: Add max98360a codec node
        commit: 14afeaf917375967bb84b4347cd8e4156b84c470
[08/12] arm64: dts: qcom: sc7280: Add lpass cpu node
        commit: aee6873edb93a3919706f70884e55880d8c727a5
[09/12] arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 1.0/2.0 and IDP boards.
        commit: 8cf4133bc1fbb6fbc695e4398b940caf3ec59ba5
[10/12] arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 3.0/3.1
        commit: f10c73ac6e90ca2343fc4f06b61ce8c1824c9bfd
[11/12] arm64: dts: qcom: sc7280: Add sound node for CRD 1.0/2.0 and IDP boards
        commit: ece7d81f2447f4fd4f5d5345e921036871babf2b
[12/12] arm64: dts: qcom: sc7280: Add sound node for CRD 3.0/3.1
        commit: 29e0b604f040ef794cd36d43b97bd9c040ed99e6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
