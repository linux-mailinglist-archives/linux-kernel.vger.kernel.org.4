Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F196BC460
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCPDSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCPDRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E171897FE0;
        Wed, 15 Mar 2023 20:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FE0361EE9;
        Thu, 16 Mar 2023 03:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43657C433EF;
        Thu, 16 Mar 2023 03:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678936670;
        bh=VjSopPcXqPt9bY3Edmmw9RExl6QOCeRhxi/CGzdO4xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qh+9WAJkKnE/KeMtjYShRT2RjqNmQtKHyK7iXqjtQMQ5oBbS569AFBRsBliygpJ53
         WmDJ0tpL9GsktMCI/QLzKjCULG07oKNJWZVOvXCbXNMY+JcAxV9n1lbQI4bBRF9RhX
         CrZGc6oRequaWTm0MBH6hDVptlgtsSZjXFCT+fxcPBAYZH814xOOu3URZYvuLSL4CG
         +aHQyf+NkLVf0bu1aDjydkYlFw+rpSYvZeJp3pgEEcRUS/F8VrfQiMylxVvXG0XUye
         seG+PNLk+IG07HMKsafcOXF73nsWBc+4B2tsSf1a8kjAOJyKckE40PQIqgTzp6YW0X
         Sx5n/RRKxSn8g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, arnd@arndb.de,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: (subset) [PATCH 00/16] Qcom: Fix PCI I/O range defined in devicetree
Date:   Wed, 15 Mar 2023 20:20:55 -0700
Message-Id: <167893686410.303819.17267915000695876077.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
References: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
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

On Tue, 28 Feb 2023 22:17:36 +0530, Manivannan Sadhasivam wrote:
> This series fixes the issue with PCI I/O ranges defined in devicetree of
> Qualcomm SoCs as reported by Arnd [1]. Most of the Qualcomm SoCs define
> identical mapping for the PCI I/O range. But the PCI device I/O ports
> are usually located between 0x0 to 64KiB/1MiB. So the defined PCI addresses are
> mostly bogus. The lack of bug report on this issue indicates that no one really
> tested legacy PCI devices with these SoCs.
> 
> [...]

Applied, thanks!

[14/16] ARM: dts: qcom: apq8064: Use 0x prefix for the PCI I/O and MEM ranges
        commit: 84160da56dd0ce48dd8eed56237cc8be45bd55dc
[15/16] ARM: dts: qcom: ipq4019: Fix the PCI I/O port range
        commit: 2540279e9a9e74fc880d1e4c83754ecfcbe290a0
[16/16] ARM: dts: qcom: ipq8064: Fix the PCI I/O port range
        commit: 0b16b34e491629016109e56747ad64588074194b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
