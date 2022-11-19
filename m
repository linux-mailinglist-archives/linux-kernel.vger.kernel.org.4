Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD3063089F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiKSBpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiKSBpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:45:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D57A8D45;
        Fri, 18 Nov 2022 17:05:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F400B81BA7;
        Sat, 19 Nov 2022 01:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87BCC433C1;
        Sat, 19 Nov 2022 01:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668819908;
        bh=TxxQFhDUQHQG+g5u0Odvwv1alzYZaF5Jbg/IPge8kYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgMmGVFtSaaiIb5WJk6uPq68RsyHSFd4zxQilN4zFzsxTv9sysbsPqzfCQhdwCu43
         z9r3Gnvq+xf1eCbOU7yGitiBxtpWhzhyP4UmDa5meqBTplnpHhO1SmQS9cGHt/FXah
         PTYHymAsM5QdELOEjitIJnq3z3Kp2P2RjRuMLDMDeqdfbsRucD6Kg/2YKSj08ZtJI1
         Bu4iXPzt6fYcyO1YAYE43tZKk3Varnjp8RLZxONNryqhwSni8HBRfSXkvihFTi4kM/
         VQ2eWKrFeMH4ZwACavPi7hUNqzmVaUkOpB0SnZaMg5vU8nS9VXRjdRlgCOYzO0ycFM
         qaW2XNVY6pfOA==
Date:   Sat, 19 Nov 2022 09:04:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     devicetree@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: colibri-imx6ull: Enable dual-role switching
Message-ID: <20221119010458.GA28505@T480>
References: <20221115180554.73696-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115180554.73696-1-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 07:05:54PM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> The Colibri standard provides a GPIO called USBC_DET to switch from
> USB Host to USB Device and back. Make use of this GPIO by adding it
> with usb-connector framework.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Applied, thanks!
