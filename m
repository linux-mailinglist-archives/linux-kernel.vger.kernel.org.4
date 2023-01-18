Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8327A672BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjARWux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjARWum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:50:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3AD66011;
        Wed, 18 Jan 2023 14:50:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 479AC61A7E;
        Wed, 18 Jan 2023 22:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47073C43392;
        Wed, 18 Jan 2023 22:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674082236;
        bh=K3MwySgaGr4uR4YBvu/S+P4vlN6aVcDBlXg4JxQHv0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mbg7NK/B+D1cTjL7QNcAeZnVUU3Qzya0p1LbeXZPAcnEIXz+CVxuh5UsleUWSE3os
         PizOYbjN0Ndw23a5DJI8kzwcnCQu/W2HRBurt0c1bCcnECcvV49UJMCUf34FzBiMRY
         U2c7n8buD0V7+MkUfIVjMaX48QAmekicrp+cGUu2x9XSlZI81B+PfmRlAkVW7nFzye
         UIIar+EwfdE8mw16dir2e2oS7xy+5DNIOzm58x4DlOQYO/ds6NVnvGvtyPaCE4fukV
         0p8/Ao3svHdufPNFRKasVWQjZtqvIQAm6mhlbZhq7j0i/QSgIrD0a1qWdO8SRvEvTj
         efVSAhlXwHMJQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, neil.armstrong@linaro.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] arm64: defconfig: enable modules for Qualcomm SM8550-MTP display
Date:   Wed, 18 Jan 2023 16:50:27 -0600
Message-Id: <167408222414.2952004.2530965945019683985.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230110-topic-sm8550-disp-defconfig-v3-0-11b558f7ff5d@linaro.org>
References: <20230110-topic-sm8550-disp-defconfig-v3-0-11b558f7ff5d@linaro.org>
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

On Wed, 18 Jan 2023 09:50:30 +0100, Neil Armstrong wrote:
> Enable the SM8550 DISPCC and Visionox VTDR6130 panel drivers as module
> to enable display on the SM8550 MTP device.
> 
> 

Applied, thanks!

[1/2] arm64: defconfig: enable SM8550 DISPCC clock driver
      commit: 406b4c06cb61bb2d19aa2e5a9267044f17a539a0
[2/2] arm64: defconfig: enable Visionox VTDR6130 DSI Panel driver
      commit: a0cacf7f9a55581cfe6a6511fd7f8e490655a27e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
