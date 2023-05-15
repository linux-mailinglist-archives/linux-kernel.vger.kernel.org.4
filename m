Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183AC70226E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbjEODc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbjEODbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:31:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC723C26;
        Sun, 14 May 2023 20:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE40F61E4C;
        Mon, 15 May 2023 03:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D2DC433A4;
        Mon, 15 May 2023 03:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121372;
        bh=Erx/dvvIqfZcA/48vAEKUnPeosVouLSRGWcGC6DqMik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lF/nM9JIBEMDK8Yj8tKATcz0E3XmSgNRfrXyj5vH5Bt3CdzCcVx4Zxg/QRVv84D9x
         XR9gPbaHTPhUBhLJhW9uDSRCqE58KZzfucZrF+2LXgflrcLYrel4vRqk20SxlvZfVA
         iyoUFfGWlj0F4CGoG5Qy/FPXCNtsNR8ki6JIomzXdsr4oPueVd1IxRddACVyU7HBtG
         3L4ArAcf2bMyTZmPfAq/Yjd9q2Xj4O6UlUlAYO9nMMFZRLM/zQumpjwCwl+WK5vfAo
         boLi4AKct4d72Ja+mC3X2AO3e3fur/al9tDtOs6KbwbOw05fw72nxLefhRbVYarYQP
         poiB6UnuKrvmg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     linux-usb@vger.kernel.org, athierry@redhat.com,
        linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, dmitry.baryshkov@linaro.org
Subject: Re: (subset) [PATCH v2 0/6] arm64: qcom: sa8775p: add support for USB
Date:   Sun, 14 May 2023 20:33:10 -0700
Message-Id: <168412158456.1260758.3501683399991411428.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428130824.23803-1-quic_shazhuss@quicinc.com>
References: <20230428130824.23803-1-quic_shazhuss@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 18:38:18 +0530, Shazad Hussain wrote:
> Update relavent DT bindings for USB, add new config to the phy driver,
> add USB and PHY nodes to the .dtsi and enable them in the board .dts
> for the sa8775p-ride platform.
> 
> v1 -> v2:
> - correct dwc3 device tree bindings for irq's.
> - collect R-b, A-b and T-b tags.
> 
> [...]

Applied, thanks!

[5/6] arm64: dts: qcom: sa8775p: add USB nodes
      commit: de1001525c1aa21380349ffbef8154149ef637e8
[6/6] arm64: dts: qcom: sa8775p-ride: enable USB nodes
      commit: 4eefaf51f716be584bbc4f548d368255c682a3b9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
