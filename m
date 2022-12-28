Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E8A65858A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiL1SOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiL1SNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:13:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E62617065;
        Wed, 28 Dec 2022 10:13:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AC01B818BC;
        Wed, 28 Dec 2022 18:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69BFC43398;
        Wed, 28 Dec 2022 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672251231;
        bh=BJcqRAuz8/wtDVPS6fJ39cVWXnokQlN399XKWYKe7hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEf3tsWksMEVhCFIZJ9tfIUomuke+qsRQxhcfrxQNMtafp9TN9Tk8eebmW3iOIZQd
         6ohHvbCN8Fhf0n0YIbISm67GuZ9vfXJu3YFAlR7sTxq9qI93543KCdeYk8rM6iQg/o
         RtHWN874X7iijenJrSOAI/OYQ5j5TBQMq1Q2aujaFndaoDYHUjQ7+Lhh+MnWjVvNiH
         ssprsjU6IzyeyvG8ObLynEDoeQYqDjLqr4Rjq+eNK382WNgDMyThOmar9+10pq+WaQ
         R2wEK7u9OKyBGuF+Igc8Ew/Ozd/m2ck1P+SznWTOIQBia5MtwoYUcX1kQNf6pV88p7
         o8bZ2rDQQePpg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     quic_schowdhu@quicinc.com, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        elder@ieee.org, agross@kernel.org
Cc:     quic_rjendra@quicinc.com, quic_sibis@quicinc.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, quic_saipraka@quicinc.com,
        linux-arm-msm@vger.kernel.org, vkoul@kernel.org
Subject: Re: (subset) [PATCH V21 0/7] soc: qcom: dcc: Add driver support for Data Capture and Compare unit(DCC)
Date:   Wed, 28 Dec 2022 12:13:45 -0600
Message-Id: <167225121532.949655.12016348712803700368.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1672148732.git.quic_schowdhu@quicinc.com>
References: <cover.1672148732.git.quic_schowdhu@quicinc.com>
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

On Tue, 27 Dec 2022 20:52:44 +0530, Souradeep Chowdhury wrote:
> DCC(Data Capture and Compare) is a DMA engine designed for debugging purposes.
> In case of a system crash or manual software triggers by the user the DCC hardware
> stores the value at the register addresses which can be used for debugging purposes.
> The DCC driver provides the user with debugfs interface to configure the register
> addresses. The options that the DCC hardware provides include reading from registers,
> writing to registers, first reading and then writing to registers and looping
> through the values of the same register.
> 
> [...]

Applied, thanks!

[4/7] arm64: dts: qcom: sm8150: Add Data Capture and Compare(DCC) support node
      commit: d4b94c8244919742417c3a165ef73081de37ef3b
[5/7] arm64: dts: qcom: sc7280: Add Data Capture and Compare(DCC) support node
      commit: 029d6586dc2d1d10e9df3962633e29e145d764ec
[6/7] arm64: dts: qcom: sc7180: Add Data Capture and Compare(DCC) support node
      commit: add74cad7c9d1bf59d41b229852f3ebe0be4a84f
[7/7] arm64: dts: qcom: sdm845: Add Data Capture and Compare(DCC) support node
      commit: 91269c425649baad9758dbe269e7069ad7fa05fc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
