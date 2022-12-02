Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB8B640FA9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiLBU7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiLBU7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:59:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4090EBC80;
        Fri,  2 Dec 2022 12:59:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 329FEB822B2;
        Fri,  2 Dec 2022 20:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93C6C433C1;
        Fri,  2 Dec 2022 20:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670014742;
        bh=4f91Ig4lqU05AgsUoYBx452LJNygOSOyb5lsao0prkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sT1mWac9NI1E+ViQpWuRr07cYjHj6m4WFD6zI1CAsqNA4T/g/1nXerzuoOaaeyabH
         PFiJ+EAa1+YRPgCC2oIUzUOOwphW1QPfp+GnUfGz7pZR/NObiReR+eoSDmqXlOBW3I
         tedBKMY/VmlvQIr0pC2Ag6db4zOwue4dzOxpNdg0rBvH/RUDcCMkfpZ6E90WoOh4K8
         lX65XqF+a0xCC1WhggEgVfO+ZJ2MTyJJVt4XOFH6ebRTDpZjoNzI0FvcOegazayoEY
         LjdaG9oXLpH94YrzoydTtz5EJr0TlimZpOBX8ihACTkX9WsPoBuc/Lz5KpsvKxyk0o
         Qky8EnUYawl8Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     konrad.dybcio@somainline.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        catalin.marinas@arm.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, will@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, ardb@kernel.org,
        robin.murphy@arm.com, Christoph Hellwig <hch@lst.de>,
        agross@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: fix PCIe DMA coherency
Date:   Fri,  2 Dec 2022 14:58:48 -0600
Message-Id: <167001472414.2721945.8639781336468185182.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221124142501.29314-1-johan+linaro@kernel.org>
References: <20221124142501.29314-1-johan+linaro@kernel.org>
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

On Thu, 24 Nov 2022 15:25:01 +0100, Johan Hovold wrote:
> The devices on the SC8280XP PCIe buses are cache coherent and must be
> marked as such to avoid data corruption.
> 
> A coherent device can, for example, end up snooping stale data from the
> caches instead of using data written by the CPU through the
> non-cacheable mapping which is used for consistent DMA buffers for
> non-coherent devices.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: fix PCIe DMA coherency
      commit: 0922df8f52b88d5c718d0cfe10794ac44b95ac78

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
