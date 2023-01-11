Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D66B66537E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbjAKFTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjAKFSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5C2E0DC;
        Tue, 10 Jan 2023 21:09:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88940B81AC7;
        Wed, 11 Jan 2023 05:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E75C433D2;
        Wed, 11 Jan 2023 05:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413796;
        bh=7qmMucPiERC7Rf7pkzBhb/7gzkgvGyoLcRhMbyEhRd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMvHj+3LgpmmdXz91qdJCl9N+S3RgVDFwzSQGEy5gDT+bPvGI2wyy2uAmTlf+fNAs
         eYzLvfjCVSPiPnqenNjtoJ+8Q4O9wHnfOFUdgFwPqQpaXAF29lnHd3OeMI3IkCgur/
         4dwT01ImwIuRV2/0S4Srwtx+dSR47F2whntRjgbLIOcVUJ+/kHs++8EHP7uBXbtVRr
         UgfitTiMSr1EGYL6iSem9xbB2Go7Q+m4CR3NdU/J4FXXK9iiBYSgjVqC5V+jnHOdeD
         cMJz2Qs+DrrgbdZpJPTWNI/GKVBgeHbASHRGQfNI832sjXqIJtpucGWwhwAcWqFLcQ
         eipu3G/Oy8dlg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8350: Drop standalone smem node
Date:   Tue, 10 Jan 2023 23:09:21 -0600
Message-Id: <167341377729.2246479.5620774959453178990.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221219162618.873117-1-konrad.dybcio@linaro.org>
References: <20221219162618.873117-1-konrad.dybcio@linaro.org>
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

On Mon, 19 Dec 2022 17:26:18 +0100, Konrad Dybcio wrote:
> SM8350 is one of the last SoCs whose DTSI escaped the smem node
> conversion. Use the newer memory-node binding instead of a memory *and*
> smem node.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8350: Drop standalone smem node
      commit: 8503babc3d2abe5170ac987696d5ec5e90ba53a4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
