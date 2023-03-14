Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70A26B8905
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 04:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCNDhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 23:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCNDhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 23:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1766C9310D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 20:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3E1C615BF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CBFC433D2;
        Tue, 14 Mar 2023 03:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678765070;
        bh=NCqxPSQfBYujzE6WCx/Ib2yfyNZa5wtUSGL78tmfLvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJqgGPrj9Ti1i8AiA7Rv+UlwOYbc5/alyTs08/tw/LELUn8vgbKHxvuLbpe4YW/pS
         g/r7/5N2uhVoUnIvHt//E+H8MuL86mOh8AeWOPgxetKwlau5jYAPSwiO/6uLlW5iDV
         9J/lN/c1oqJLS7m2zdazMrT1U4vW5laDNPl7xZuabG8qVJZN84CK4KRdGA7+jCNMoV
         vI4cTOvW0wCPGF5KAcLd4iJCDbMCRYOtRgL1qQtbLY0z68LMUobgg7bqhv1wfqDE3S
         o/xFZJjdE4MvCl4J+HWuxo0Fhje2/WOO8yOUWusaNdpumrQYVCwATmUGQQT+RH+BYW
         5wWAFclTvDSOw==
Date:   Tue, 14 Mar 2023 11:37:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jindong Yue <jindong.yue@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        l.stach@pengutronix.de, peng.fan@nxp.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        m.felsch@pengutronix.de
Subject: Re: [PATCH v3 0/7] soc: imx8m: Support building imx8m soc driver as
 module
Message-ID: <20230314033743.GP143566@dragon>
References: <20230301130557.3949285-1-jindong.yue@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301130557.3949285-1-jindong.yue@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 09:05:50PM +0800, Jindong Yue wrote:
> This series adds support for building imx8m soc driver as module.
> 
> ----
> v3: Update commit message to include link error of
>   undefined genpd_dev_pm_attach_by_name symbol
> v2: Use dev_pm_domain_attach_by_name() for imx8m*-blk-ctrl.
> ----
> 
> 
> Jindong Yue (7):
>   soc: imx: imx8mp-blk-ctrl: Use dev_pm_domain_attach_by_name
>   soc: imx: imx8mp-blk-ctrl: Fix typo of imx8m_blk_ctrl_of_match
>   soc: imx: imx8mp-blk-ctrl: Add MODULE_LICENSE
>   soc: imx: imx8m-blk-ctrl: Use dev_pm_domain_attach_by_name
>   soc: imx: imx8m-blk-ctrl: Add MODULE_LICENSE
>   soc: imx8m: Add MODULE_LICENSE
>   soc: imx8m: Support building imx8m soc driver as module

Applied all, thanks!
