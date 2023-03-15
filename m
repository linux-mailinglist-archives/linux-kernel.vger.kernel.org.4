Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D106BC188
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjCOXgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjCOXf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:35:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7758EA8EBF;
        Wed, 15 Mar 2023 16:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7937B81FAC;
        Wed, 15 Mar 2023 23:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35E7C433D2;
        Wed, 15 Mar 2023 23:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923167;
        bh=oUY7bYexWB42Zbiims/Q/Oe7zusnZrJ32+bkHQJ1Dkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BmZhNRW2rmpBr0Hw1gjMUEWKzQGhrqq0YF+6Mj+JYx+Fqc9x52qBeM1yJhet4SwLi
         N3szMpp3GKmFCNDLS5UCU9zTB2evlsV/I5Ut7olXjMn3hlRbsRb1MWb1KfG2vZp6+2
         wvL6pXgx5vihWa6YVnoifmo6jPRERZO9INB0gey0ZILD++fxcpm0EM1SvLm0EKvZ9L
         xE8TYQsIgqCAAUAPkCrJE/7TChM4DZVXuBa4CW0+9j9FcC3a+DZ9g9XnpEetm/3+i5
         isa1Zsq5+aMK2DCHlk0bli/5WqULe4JeXodeyLdNLFtUlZUXec6bcBALry0ZWYUKxZ
         rDdQ/ThJsiXLQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        agross@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        Kathiravan T <quic_kathirav@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        lee@kernel.org
Cc:     quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: (subset) [PATCH V2 0/2] Add the download mode support for IPQ5332
Date:   Wed, 15 Mar 2023 16:35:19 -0700
Message-Id: <167892332568.4030021.2021586293901844303.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230210060401.24383-1-quic_kathirav@quicinc.com>
References: <20230210060401.24383-1-quic_kathirav@quicinc.com>
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

On Fri, 10 Feb 2023 11:33:59 +0530, Kathiravan T wrote:
> Enable the support for download mode to collect the RAM dumps if
> system crashes, to perform the post mortem analysis.
> 
> During the bootup, bootloaders initialize the SMEM. However the bootup
> after crash, SMEM will not be initialized again. If the memory for the
> SMEM is not reserved, linux consumes that region, which leads to the
> loss of SMEM data. So, during the next bootup after crash, bootloaders
> will hang due to invalid data present in the SMEM region. Due to this,
> added the SMEM support along with this series.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: ipq5332: enable the download mode support
      commit: ed32155302fc3e5b8d30c51b95666e844f1449e1
[2/2] arm64: dts: qcom: ipq5332: add SMEM support
      commit: d56dd7f935e125244bc15f5a0a9e68cdb0ec87ca

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
