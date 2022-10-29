Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D88612151
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 10:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJ2IQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ2IQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 04:16:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAD692586;
        Sat, 29 Oct 2022 01:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 938E9B80936;
        Sat, 29 Oct 2022 08:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFEAC433D6;
        Sat, 29 Oct 2022 08:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667031379;
        bh=JoYCL88mRATAPBkCXFf8OAMPZaND6No/VZOZajC4SrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kLwcaFFiiRXzpcoR9KUEiv7xkOJeyuoe4ATRihn4xWNzsDI/mL0hFtyaXCn7i6iSu
         ZEceT6tv13eEuPRMBMNAoRX1CJQubz3kqPlqi7ZKn1sh4PZtvCCaPIZ9M7yyMC+kdY
         kRRxYfdq+bSoPw0Usc+QJ0GaPrfhqYv9DdsZow8D26JQf5trRdq6ZYWJVYjy9WEUwA
         QfEHP6tnnsvAMhe5AlMAjzRJPnre9quaSGA7XM5EkxfVvAb6TmxSDqtfbQrBNbrnmp
         TOpYYNZ3KLv/xQ6P8Mk7VpffOgJaMR1yU6xw4NdppX3IfAKxYYwIkIBjf8vCAq47By
         0DvPvVOJdvOhg==
Date:   Sat, 29 Oct 2022 16:16:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: imx: imx93-pd: Fix the error handling path of
 imx93_pd_probe()
Message-ID: <20221029081613.GQ125525@dragon>
References: <717cb5dee892bc01257d52b10bb9a1ee79ced87f.1666418916.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <717cb5dee892bc01257d52b10bb9a1ee79ced87f.1666418916.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 08:08:55AM +0200, Christophe JAILLET wrote:
> In imx93_pd_probe(); if an error occurs, some resources need to be released
> as done in the remove function.
> 
> Fixes: 0a0f7cc25d4a ("soc: imx: add i.MX93 SRC power domain driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thanks!
