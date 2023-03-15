Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74496BC16C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjCOXfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjCOXej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:34:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2084DA881A;
        Wed, 15 Mar 2023 16:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3192B81FA7;
        Wed, 15 Mar 2023 23:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AADC4339C;
        Wed, 15 Mar 2023 23:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923164;
        bh=4VXlS4g8PoGWjOMxYGW39zGYuUNb0UtK5O8C+5jw0Us=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tnl6SkiXGmWnfV5ssvdq/cTzZPVH46Qx7/1D458hNtrbP2Hyl6YVyKlFtrCjXhrv5
         u8MZGRVBC7/uwrDHutPPJqK5vbytJYyWoSMfOYgGgFUqrFql12fy5suA1XFoIcU/Ra
         5z3jRIxCRfeYb8nJ09YmZmBX1bClB24QEv/EBw7ZqcJcnKlQ7UrbccEzgfK17CDx64
         i/w2ufBaQz1H+kFLoNre51/9uqstH/qZx5OoaMk2d+At3NQFqXzmiP8Z+u9UwXL7JK
         U59j9uOSkH9wW1RWsnraKB8D2O4bu6iQsYLsmIdA3Eqt0Ko9H/L2eUwRDH4amcrK+7
         UDCIjByiyS9pA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: Mark UFS controller as cache coherent
Date:   Wed, 15 Mar 2023 16:35:16 -0700
Message-Id: <167892332562.4030021.17298373449890846833.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308054630.7202-1-manivannan.sadhasivam@linaro.org>
References: <20230308054630.7202-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2023 11:16:30 +0530, Manivannan Sadhasivam wrote:
> The UFS controller on SM8550 supports cache coherency, hence add the
> "dma-coherent" property to mark it as such.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: Mark UFS controller as cache coherent
      commit: ee1d5100c37e7a95af506c7addf018f652545ce6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
