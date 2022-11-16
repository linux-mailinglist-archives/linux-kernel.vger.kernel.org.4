Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9FD62C703
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbiKPR6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239112AbiKPR56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:57:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED16627C8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:57:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BBE1615A2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA86C433D6;
        Wed, 16 Nov 2022 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668621477;
        bh=olo00VFn2M2DWQlSaa0U9zhHLWhIXWQwE8OcnzW+jq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gw2UN5nPAgDcFEogS9fMnJVq2bcrjc836fL6+oj321W/KNKKgU2uP0HKPIR414Qpm
         FjkaPfGk+Rdp2wsaCMSEar5nml3zmGCE1c6JhM3aI2lCPWOBGZIpFkiVy2ex/4JUlg
         6RR5WiXGgIeR8S5uPcubWLVd9NFib+QYMXpQgXcxb4SX1Ym7HqC88wfRk6cHSfV4Mc
         jxq39S2UtsdVsA1tE9ilVWYZerzmDLYbgU1BACmeN+ugCZWciFPhC5Kz36cT7quBxh
         txcj3A30ZdmEUJBIC3+fTrH2dl2xbNor5x1fKqlq3nuLsd4phWr39BCAXRFjyD7Y7T
         k4bRIT00frwjw==
Date:   Wed, 16 Nov 2022 17:57:50 +0000
From:   Lee Jones <lee@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, brgl@bgdev.pl,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 13/18] mfd: rt5120: Replace irqchip mask_invert with
 unmask_base
Message-ID: <Y3UknliD/vnYLccC@google.com>
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-14-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221112151835.39059-14-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2022, Aidan MacDonald wrote:

> Remove use of the deprecated mask_invert flag. Inverted mask
> registers (where a '1' bit enables an IRQ) can be described more
> directly as an unmask register.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/mfd/rt5120.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
