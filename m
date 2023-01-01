Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B83E65A90D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 06:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjAAF3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 00:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjAAF3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 00:29:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965D962D9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 21:29:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D63E3CE0950
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 05:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AE5C433D2;
        Sun,  1 Jan 2023 05:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672550981;
        bh=89iz10CRf6sE4nl3+7jyD4inuyE1Gpb4QmuDRVtvMNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=owKSLecdqPQUgeoV+cO5/q7oVzQF4co9xEWJ/s184L8Gr1/sLOf1aLzV11TIr7/d9
         HwOYKRzsuq8wMjMG7C+8cAFtwb7h8oMBNzyuHXznuygPhGGQx1y1Nt5pLOwF/CyNKJ
         eu2lWs9t0ToeuZ/fetlUZxFoq6dx0nFOtPqXhrPaooWTr4G0Um44XBk7RJXpQzbd6C
         zkjmWvwB0qA4b3g8fEyZh8RNeTb7JbiaqfjUsbLggUiBeJ6t2FNXqg8MnOnjTKTJX1
         DJ7PsZ9VZGDLBzLuYueqeBGQViG5Qu+FcoBAoH75zzskYb0GcZFhhKzTEIIZFm9OqA
         DSoNqkHKEe+RQ==
Date:   Sun, 1 Jan 2023 13:29:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] soc: imx: imx93-pd: No need to set device_driver owner
Message-ID: <20230101052934.GZ6112@T480>
References: <Y6SZjDKWve8/T/ld@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6SZjDKWve8/T/ld@qemulion>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 11:23:16PM +0530, Deepak R Varma wrote:
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
