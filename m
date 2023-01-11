Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37DC6663FC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjAKTtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjAKTtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:49:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF218C6D;
        Wed, 11 Jan 2023 11:49:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F98361E10;
        Wed, 11 Jan 2023 19:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598A4C433EF;
        Wed, 11 Jan 2023 19:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673466549;
        bh=4i9bzDj0YZu4xqrGKHzS6bTWaQtXMywORIB8RQxbUa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oeD40Rg3/mDgKLqO1a4D8VSfEkuE6nPZKvlw0cozmVRxvp4SsrhEFSqk9m84cZRW2
         MzLGoO6EU3obULc1Ao1yaXBQpZYy5LVnmgDmVhXff2XjUonGFQuVdf0PwQmhrn/dH6
         YBIl9mdSqg4VaF0ETjOLzfuR2FUIZbGQ9a/tAIqWoDOa3p3zGxMsD8Mtl0j8LI0K4l
         VrgxtWXpU41wGDu1rtDoj6/B+SDl03Kwd8FTWsS2crvo3dpniXETI5Asj8HXmr/MVR
         MIUWKlF/qjZCpzEu3iwcgl9Q7LwGoOf7U19bgoyEuub/denKtsdSgdOU78O5TUsmAP
         2RgOzx1rCF3xw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     catalin.marinas@arm.com, will@kernel.org, abel.vesa@linaro.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable GCC, TCSRCC, pinctrl and interconnect for SM8550
Date:   Wed, 11 Jan 2023 13:48:59 -0600
Message-Id: <167346654439.2315924.14452766872188532223.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230111080254.1181325-1-abel.vesa@linaro.org>
References: <20230111080254.1181325-1-abel.vesa@linaro.org>
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

On Wed, 11 Jan 2023 10:02:54 +0200, Abel Vesa wrote:
> Add the SM8550 GCC, TCSRCC, interconnect and pinctrl drivers as built-in.
> All of these are necessary for the Qualcomm SM8550 platform to boot
> to shell.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: Enable GCC, TCSRCC, pinctrl and interconnect for SM8550
      commit: 62d8b7f90084b697fff4be7d62b128a6c3b2a60c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
