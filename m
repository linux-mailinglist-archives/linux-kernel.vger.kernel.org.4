Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2B06205E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiKHB2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiKHB1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:27:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0602AE05;
        Mon,  7 Nov 2022 17:27:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40744B81711;
        Tue,  8 Nov 2022 01:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B381C43470;
        Tue,  8 Nov 2022 01:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870868;
        bh=mj2CkqKyrRQCE9gS8pWPHxCMQuCruAUEPSa++i1xp3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cr35a+xs2w/8+cGkqD0nD61brwWBEi8TkXzrG09mUXa9erv8r3sSrsds5ZnETLOtl
         jwM0vtUqcMhv0+V6nK9+MD26k6KpdTcuXtj5J2ZOoyaj0wr9Y1CXxKGCZBQ27KBw2y
         bSFqWmacuSODc5MEkSOBT93BuePhWOD9wGx2VEUl1t7yxJQFB4XSnoj2VexptbZtuD
         x8nRHna9gZ5FHaq/UfEeGyF3veU05cSP2yNPkMKPRnHyyh1IWVupLnaMy2S2ksgtrJ
         MHs/7eATxS8xy0pTSyaX7AURd319TZb+I510MDu89OQ6H1k7nRF2busULZW28jjhpI
         fgNf563tht2eQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: fix USB MP QMP PHY nodes
Date:   Mon,  7 Nov 2022 19:27:21 -0600
Message-Id: <166787084686.599230.4516103701135899392.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221107081705.18446-1-johan+linaro@kernel.org>
References: <20221107081705.18446-1-johan+linaro@kernel.org>
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

On Mon, 7 Nov 2022 09:17:05 +0100, Johan Hovold wrote:
> Update the USB MP QMP PHY nodes to match the new binding which
> specifically includes the missing register regions (e.g. PCS_USB).
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: fix USB MP QMP PHY nodes
      commit: 0d0be9d88bf2b1c36146712761ab04623a855647

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
