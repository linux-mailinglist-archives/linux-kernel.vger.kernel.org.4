Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051E16572C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiL1Ei1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiL1EhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7DFD2D2;
        Tue, 27 Dec 2022 20:37:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E03BB8125A;
        Wed, 28 Dec 2022 04:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C6CC433EF;
        Wed, 28 Dec 2022 04:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202228;
        bh=4OUbzkNT5pRRehrTxUb9pnJXA8JtAeKZJ116wUtU0xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gv2agjcXBN615ZENcTsBmvUwEoTLa7eb3M4Mdd/8wFtJHBeRhlBl5unhELnoz2Wbq
         VTAXsNdGf7nvKYzPiwUMU4Ra8WyDBmbbE89azXbxOrMtkGSH9ubV6HFZTgTppK6Uc4
         N7fyy6gWoaj1MGCdFEFZcLeWbwSesO7beRbke8JKpcENp4cjXeaIRloWJbTwPBhic1
         FgomEse3UbIb4KgAy2y5vmG4rsFGPF+ILHzR9SmdBfaiFaCUNJp4FgrKqYRWkYl3Ka
         /D548SVQle8HQE+WNYwYq1Q8tQa2XCHf+8FksSfQayMEy5ZDBBBAWvPAJXaGv3Rk8+
         F0eCOFTUnKt4g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, agross@kernel.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/4] arm64: dts: qcom: sc7180: move QUP and QSPI opp tables out of SoC node
Date:   Tue, 27 Dec 2022 22:36:43 -0600
Message-Id: <167220221234.833009.4820424062186895476.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
References: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 10 Dec 2022 12:57:01 +0100, Krzysztof Kozlowski wrote:
> The SoC node is a simple-bus and its schema expect to have nodes only
> with unit addresses:
> 
>   sc7180-trogdor-lazor-r3.dtb: soc@0: opp-table-qspi: {'compatible': ['operating-points-v2'], 'phandle': [[186]], 'opp-75000000':
>     ...  'required-opps': [[47]]}} should not be valid under {'type': 'object'}
> 
> Move to top-level OPP tables:
>  - QUP which is shared between multiple nodes,
>  - QSPI which cannot be placed in its node due to address/size cells.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sc7180: move QUP and QSPI opp tables out of SoC node
      commit: 524dfd2ddbd74ed5b4cbb3e002984cf95878c827
[2/4] arm64: dts: qcom: sdm845: move DSI/QUP/QSPI opp tables out of SoC node
      commit: 85966125ecfe75735d8a02f00c83545aaad0ba88
[3/4] arm64: dts: qcom: sdm845: move sound node out of soc
      commit: d0b014a74823cc52dde447d0af61ff14fce5a785
[4/4] arm64: dts: qcom: sm8250: move sound and codec nodes out of soc
      commit: e5b8c08245307a82cdf180cd5d385a34ba1cfd9d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
