Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7926C4E17
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjCVOnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjCVOmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:42:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33B966D20;
        Wed, 22 Mar 2023 07:42:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28FBA6216A;
        Wed, 22 Mar 2023 14:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01391C4339E;
        Wed, 22 Mar 2023 14:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496130;
        bh=kir2I7rPoukVyDnZQ0uFmMBRLvohQ/IDtR1s+C8Dew8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVpGl0wwUR0tdJ2qzuF76yhgJz1UpaoEgNxFphd2gqnlAz32tBPYzLR9+OAO4leyx
         vIqaTn1Cc7uZO8cBAoc4zVJb8sRKC/YITeAdl3+Wi1u4irOLhw7uakQfIVb3j14mV3
         ptuLv4IuMAnm/TmHKA1HIp17UF+LvADjswf9RrjsWS+hrm5qCmecmQC9JeJXwxbYis
         xuFJkgyP9RmdULbrDjRWI2G+LevnO82IqIrQiIuAcJ7fUCQLCt4eP+ozUuqQd2ao8O
         mfaVDezZNufsQyjPFQPTXDu+3763AW0pG917uC4ctAYUvuNzBsestUCk1+9FmiPEeY
         FU9p8a7MIQasg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: defconfig: Enable QCOM eUSB2 SNPS PHY and repeater
Date:   Wed, 22 Mar 2023 07:45:00 -0700
Message-Id: <167949631651.1081726.9531427147124914385.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320151707.1842171-1-abel.vesa@linaro.org>
References: <20230320151707.1842171-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 17:17:07 +0200, Abel Vesa wrote:
> In order to have USB 2.0 working on Qualcomm SM8550, both the eUSB2 PHY
> and the eUSB2 repeater need to be built as modules.
> So select them accordingly.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: Enable QCOM eUSB2 SNPS PHY and repeater
      commit: 1c894486fc638b1aafabe78cd38441518e7cdb00

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
