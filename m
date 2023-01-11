Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A266C665395
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbjAKFVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjAKFSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7781F13F1E;
        Tue, 10 Jan 2023 21:10:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E2BBFCE1AB1;
        Wed, 11 Jan 2023 05:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F15C43398;
        Wed, 11 Jan 2023 05:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413805;
        bh=cg0HFU12IDLtMBwrpw3yWJbsacPC+RH1FwE5VZf1kDU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Iv0Hnt4vxgRpPHtJl/b4vzIj2/rus760pPnn1YULTw4a52pSmBwg4tk7W9SjBHzha
         vKDVbRRW5zoFIKJhzwXyINZ2ckqO6cEobod0ydP+/j2TaM4VR2Kp8HK/u6OHgovCKa
         a/ELX0ZkdHRJduegxZsBOsWP/e2a2H7aoTvNKg8jER0rJMfZUEJMYWm10ZqMaA2nHX
         CIE56/Zj/a01St54CuXjxVhAZEthMSm44qDPRYGYYyA4XFT2Xz4uiOR2ZfhU0q1fBV
         k9ffJs0A21zjcnlEth300HNSsrKR10rqrDrdwGQHrwKcpROVpIJ0lxwjJXAaon85nz
         cCECFCSh4Wo4Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: arm: qcom: add board-id/msm-id for MSM8956, SDM636 and SM4250
Date:   Tue, 10 Jan 2023 23:09:30 -0600
Message-Id: <167341377728.2246479.15899693030955438149.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221214150605.173346-1-krzysztof.kozlowski@linaro.org>
References: <20221214150605.173346-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 14 Dec 2022 16:06:05 +0100, Krzysztof Kozlowski wrote:
> Allow qcom,board-id and qcom,msm-id leagcy properties on these older
> platforms: MSM8956, SDM636 and SM4250.  Also mention more OnePlus
> devices using modified qcom,board-id field.
> 
> 

Applied, thanks!

[1/1] dt-bindings: arm: qcom: add board-id/msm-id for MSM8956, SDM636 and SM4250
      commit: 47c6315ea64de35aaa738e8d647a4359ede202e8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
