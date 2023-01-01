Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A7A65A90E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 06:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjAAFaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 00:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjAAFaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 00:30:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E766412
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 21:30:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D1E5BCE0950
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 05:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE22C433EF;
        Sun,  1 Jan 2023 05:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672551000;
        bh=q0VqIRoHyqhDGlF24ZE7eHTjVVVmPfleCXKlnlZNoZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CnyyH6VmV9dlBYipdkaIqqqei1FSzLaUbu+JHhx/DDJ00sfjBzV6TN6ud0dLbeX0N
         C34Dr5RfBhTb0cpsFh51v8BcLBZCHd5sdJ09BnSIprcGfdEnl8LiPdXy4UD0EIrWjh
         AE791tjBX7k3omUDMZBiU0arWykuZymX773fAjXaBWdyF9RevmIrqltIkb1HW8ympy
         79JEaQrAuotan+k8EXA91UXu5rQ4FABRZEBOa4L4PGUyDs4nku+um1K/fFjuPY/EaF
         JR2e3rOQc3bw35brbcxTH5U3d/HIfty4mIOZkEq47IcPtn6Rv5j66s3Kzz2q4MHsLJ
         Vq32q7+B0/c6w==
Date:   Sun, 1 Jan 2023 13:29:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] soc: imx: imx93-src: No need to set device_driver owner
Message-ID: <20230101052953.GA6112@T480>
References: <Y6Sab92tTDTk5Nox@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6Sab92tTDTk5Nox@qemulion>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 11:27:03PM +0530, Deepak R Varma wrote:
> There is no need to exclusively set the .owner member of the struct
> device_driver when defining the platform_driver struct. The Linux core
> takes care of setting the .owner member as part of the call to
> module_platform_driver() helper function.
> 
> Issue identified using the platform_no_drv_owner.cocci Coccinelle
> semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>

Applied, thanks!
