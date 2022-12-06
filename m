Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753A2644B34
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiLFSU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLFSTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC0ABF46;
        Tue,  6 Dec 2022 10:19:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F1A9B81B29;
        Tue,  6 Dec 2022 18:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4189C4314C;
        Tue,  6 Dec 2022 18:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350785;
        bh=j4WKYzbuvF8pRZENcvE70eiApecHVgy4JhfLsWf9m/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JKWHXhCfNCN1x9t1IMZixnMlbeuOspKFI+CHWkN0r7wPV1hqOFkuSC6Z3+nvKzuZT
         E//YWdZKr88G5tSAGJTS9umCwV8RgYv6DETDHkLffQ9f3mbEUSW1SAdfDknir01KMJ
         PaUHjRMdIkwAGh56jIEnbyK06Jt8g1+ogR7D3N3GVcF0Ujua2Hmzksayxfw7pIO9NH
         8pSI0Z2tCyqP5w0h/RhSJ7ZnajJe00HRlmkW9EGWj/nimd/8baBUYJ1vp0Dh28ULnT
         Mo23v0Aj9efLzcT6tB84ReyCbh2Bv09ZhCAQ8HJQCpZvMeRWaFfkg9WdzMhBffsitp
         hPODQISKP1+qQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     bmasney@redhat.com, krzysztof.kozlowski+dt@linaro.org
Cc:     robh+dt@kernel.org, psodagud@quicinc.com,
        quic_shazhuss@quicinc.com, echanude@redhat.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        agross@kernel.org, ahalaney@redhat.com
Subject: Re: [PATCH v3] arm64: dts: qcom: sa8540p-ride: enable PCIe support
Date:   Tue,  6 Dec 2022 12:18:50 -0600
Message-Id: <167035076354.3155086.13493782253518624178.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221202120918.2252647-1-bmasney@redhat.com>
References: <20221202120918.2252647-1-bmasney@redhat.com>
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

On Fri, 2 Dec 2022 07:09:18 -0500, Brian Masney wrote:
> Add the vreg_l11a, pcie3a, pcie3a_phy, and tlmm nodes that are necessary
> in order to get PCIe working on the QDrive3.
> 
> This patch also increases the width of the ranges property for the PCIe
> switch that's found on this platform. Note that this change requires
> the latest trustzone (TZ) firmware that's available from Qualcomm as
> of November 2022. If this is used against a board with the older
> firmware, then the board will go into ramdump mode when PCIe is probed
> on startup.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sa8540p-ride: enable PCIe support
      commit: b8bf63f8eb728dc9cb0ae0ee921eb889a11186cb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
