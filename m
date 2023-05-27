Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE9F71311A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbjE0BDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjE0BDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FCA135;
        Fri, 26 May 2023 18:03:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CFB065498;
        Sat, 27 May 2023 01:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB3CC433EF;
        Sat, 27 May 2023 01:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149425;
        bh=G72MIr3ZkLK2Bg8p3M3TKDBLKRjaxr14jHV7eQK6YUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CVsTvtNK5ERx6X7DXnzCb9QDAGfMcw6IBlWEfLgXKHFoW9IOliLGXJf+zrwrWHow4
         XJ1yBRHa+ZtnISsQ3g32BCzhW2Ebqdgpc7efNyb0vIUi/VaeLOk5ZqhDOvF7/ao5IW
         qi9iYDBXw7Itivvsc3R7L6Pb0r/wkA/3Ips5gzhqwXHGXPOkuQXh5cVyG7msqJ9LCz
         mxTxoV57g+BwDseu/XyPQS9ylVi4xZlUtLok774xHjWDwg0p/v+VBSxrgG76VBu0Fu
         nfsXX7HoITpkNgeC1EA/j5M1qhZ4qPlQuJ0V5OxiYPId5n6dw2tgTP9dD/mzpMJ9eS
         atXKnA6AwM8qQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     djakov@kernel.org, agross@kernel.org, linux-crypto@vger.kernel.org,
        robh+dt@kernel.org, neil.armstrong@linaro.org,
        vladimir.zapolskiy@linaro.org, krzysztof.kozlowski@linaro.org,
        bhupesh.linux@gmail.com, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, rfoss@kernel.org, stephan@gerhold.net
Subject: Re: (subset) [PATCH v8 00/11] arm64: qcom: Enable Crypto Engine for a few Qualcomm SoCs
Date:   Fri, 26 May 2023 18:07:20 -0700
Message-Id: <168514964949.348612.17426430561348201035.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
References: <20230526192210.3146896-1-bhupesh.sharma@linaro.org>
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

On Sat, 27 May 2023 00:51:59 +0530, Bhupesh Sharma wrote:
> Changes since v7:
> -----------------
> - v7 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230519214813.2593271-1-bhupesh.sharma@linaro.org/
> - Addressed Stephan's comment about RPM clocks for sm6115 crypto block in dtsi.
> - Also fixed the iommu context ids for sm6115 crypto block in dtsi.
> 
> Changes since v6:
> -----------------
> - v6 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230405072836.1690248-1-bhupesh.sharma@linaro.org/
> - Collected Acks, R-Bs and Tested-by for various patches.
> - Addressed Konrad's comment about iommu sids for sm8150 and sm8250
>   crypto node entries.
> - Addressed Konrad's and Stephan's comments about adding RPM clock for
>   crypto blocks on qcm2290 and sm6115.
> 
> [...]

Applied, thanks!

[03/11] arm64: dts: qcom: sdm8550: Fix the BAM DMA engine compatible string
        commit: 31dfb8014f6bbebf06ca5084a072f755d8dd9797
[04/11] arm64: dts: qcom: sdm845: Fix the slimbam DMA engine compatible string
        commit: 20bf3ac438fd2f6f9a98bc5cbddb5024cd31560f
[07/11] arm64: dts: qcom: sm6115: Add Crypto Engine support
        commit: 61baef687d81ffda97ac26db8f100b5b27069477
[08/11] arm64: dts: qcom: sm8150: Add Crypto Engine support
        commit: f7f485f3dc09d21c58f46756a7e6463c29a0f85b
[09/11] arm64: dts: qcom: sm8250: Add Crypto Engine support
        commit: c58be6c87f482b6bdba804ee0a2d7b588e6a2d6a
[10/11] arm64: dts: qcom: sm8350: Add Crypto Engine support
        commit: f1040a7fe8f069d2259ab3dab9190210005ceb33
[11/11] arm64: dts: qcom: sm8450: add crypto nodes
        commit: b92b0d2f75820540182e4edf9b57ead7ef344d45

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
