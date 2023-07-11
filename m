Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FDF74E84E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjGKHpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjGKHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC4610CB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 00:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 425E66135B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AFDC433C8;
        Tue, 11 Jul 2023 07:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689061501;
        bh=9Ag/B60GOyqVuKlVkpbznxGrmbO2mCDq1YuNpV11Ykk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gZWE6ZW7pLesJpRPzMUXnHXSmjVPX9iM0812pBy+Y7g0qcoLGTl4ewOJNJplISRwO
         kdXL9maNVYyCxJCTy/EbDRGxIDGtmAt9R6nL7wJYIEMggtXQzuKmxAU6M+a/9dOvf8
         sLju4rrO+2+WLHMEkse8Wp4iUhtgug7F7VN4i2d2zC1pXVVmyJLd3VasUkv0JjoQQ3
         lC+rVuyfi7RFGurCsdYBW/FuHseREuEhi/VIF8vPIJKjnTPM1QkbFze1tArRYpneyw
         5RMtswB++5qQdejnUhC8ffwmT9IRLh1tpxbxgMrOJ4x9Al8myv77EkmUxNmjNLkdSQ
         Gd0V5zae/3xbw==
From:   Vinod Koul <vkoul@kernel.org>
To:     anurag.kumar.vulisha@xilinx.com, laurent.pinchart@ideasonboard.com,
        kishon@kernel.org, michal.simek@amd.com,
        Piyush Mehta <piyush.mehta@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, git@amd.com
In-Reply-To: <20230613140250.3018947-1-piyush.mehta@amd.com>
References: <20230613140250.3018947-1-piyush.mehta@amd.com>
Subject: Re: [PATCH V2 0/2] phy: xilinx: phy-zynqmp: dynamic clock support
Message-Id: <168906149833.189433.6561958193632482750.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 13:14:58 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Jun 2023 19:32:48 +0530, Piyush Mehta wrote:
> This patch of the series adds the following supports:
> - Runtime PM support:
>   Added runtime power management support to power saving during the
>   suspend and resume calls.
> 
> - Dynamic clock support:
>   Current zynqmp-phy driver, by default all the clock enabled for all
>   the lanes, that consumes power even PHY is active or idle.
>   So, the dynamic clock feature will be enabled clock only for active
>   PHY in the phy_init and disabled in phy_exit. Clock enabling is not
>   required at multiple times. Activation of PHY depends on the peripheral
>   DT node status (status = "okay";).
> 
> [...]

Applied, thanks!

[1/2] phy: xilinx: add runtime PM support
      commit: 1414920a5fd570e67bb7d367eda08f8851b2e378
[2/2] phy: xilinx: phy-zynqmp: dynamic clock support for power-save
      commit: e4f01e75cdcf003f07ca5f4ba61823b687fd941c

Best regards,
-- 
~Vinod


