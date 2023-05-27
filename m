Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89C3713144
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243584AbjE0BE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242328AbjE0BEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145FBE47;
        Fri, 26 May 2023 18:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA32654DC;
        Sat, 27 May 2023 01:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D5EC433AC;
        Sat, 27 May 2023 01:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149437;
        bh=gZMhn3bHq0yvoQxw6lNIOR44naL1N+4jdyxeTA5VpkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+mws0sI4S+6Lo69Fe+hwkppyvHdKaCQDdZ2FLPvkftLnbIrJUmAe+f0vArN5xSPg
         eCtVtmWGnZSX8MM6lUBYemp4DfzwX3s2/scOrgzibCqNfj/GU6DshTe9Hajqob9xXS
         KhfjRQIxoD9rIG1QJqoUkQDmlPW3RZcoNgDykVGEFraLeJSqP2f2vTDAoQSfScPRO1
         7tCK380gnw5qSv4WD6M1gttjHe+CxmOUmUzQSutQLr2PNKzol+LC3ShLbet3JaS4XL
         HIe3MYza2FJ5NO3vAXsFN3USbzgkMZi2KhE8xSAgyj/lJJMSFLoqd0uuwB2GY1RaCd
         oSaPKu8wpZv6g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     conor+dt@kernel.org, agross@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>,
        konrad.dybcio@linaro.org, lee@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     quic_kathirav@quicinc.com, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_anusha@quicinc.com,
        quic_varada@quicinc.com
Subject: Re: (subset) [PATCH 0/3] Enable download mode support for IPQ SOCs
Date:   Fri, 26 May 2023 18:07:32 -0700
Message-Id: <168514964950.348612.1896904644619462149.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526110653.27777-1-quic_viswanat@quicinc.com>
References: <20230526110653.27777-1-quic_viswanat@quicinc.com>
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

On Fri, 26 May 2023 16:36:50 +0530, Vignesh Viswanathan wrote:
> Enable download mode support for IPQ8074 and IPQ6018. Also add reserved
> memory regions for uboot and SBL avoid losing the RAM contents which will
> be used in postmorterm analysis.
> 
> Vignesh Viswanathan (3):
>   dt-bindings: mfd: qcom,tcsr: add the compatible for IPQ8074
>   arm64: dts: qcom: enable the download mode support
>   arm64: dts: qcom: add few more reserved memory region
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: enable the download mode support
      commit: 9b2406aaba7841863ac041225316c1ec1c86ea36
[3/3] arm64: dts: qcom: add few more reserved memory region
      commit: 0cd4e90cb2dec02ff859f5c98f744f43a23aea65

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
