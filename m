Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A5C609804
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 04:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJXCB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 22:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJXCBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 22:01:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CF25FF78;
        Sun, 23 Oct 2022 19:01:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B38E460FA0;
        Mon, 24 Oct 2022 02:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E239CC433D6;
        Mon, 24 Oct 2022 02:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666576882;
        bh=Qp4NxwKLVlxG1wabAuhtntQKS6y0LQ4sQFdRQBDiin4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4DwdBFdIHPDbHcjhF5v4t8BFBD0ncbqGY8BShLqMAdUKgiICH0x24pQx5jZFFC36
         xZEXVncjrKMVW9WnAjm5s47oSk4ZtC1jshDFch34yETtG3vQR3K9TBw43mgRpJTGm/
         KA+j2zwox1MRxL0qhmFk04G4qsDFu58cECYXP0TRVvPhxhEQoHjIKCnNAgq/+rL8UO
         RASkAyEEIrHqTh2QsFjL0vRK8L+MypveIbPOMjeFlmuonR+SQViS4TWqudbitMRR6z
         Pl2seOr3iMq0DoAzbi1v9yw3n1zlQTFl/KbUyWaw7qlkRX51gdm24h3DarObByT6Uf
         Mfs6hHJFXJPmA==
Date:   Mon, 24 Oct 2022 10:01:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6qdl-gw59{10,13}: fix user pushbutton GPIO
 offset
Message-ID: <20221024020115.GY125525@dragon>
References: <20220929195222.1293294-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929195222.1293294-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:52:22PM -0700, Tim Harvey wrote:
> The GW5910 and GW5913 have a user pushbutton that is tied to the
> Gateworks System Controller GPIO offset 2. Fix the invalid offset of 0.
> 
> Fixes: 64bf0a0af18d ("ARM: dts: imx6qdl-gw: add Gateworks System Controller support")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
