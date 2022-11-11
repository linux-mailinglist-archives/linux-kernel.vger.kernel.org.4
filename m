Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98283625405
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiKKGpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiKKGpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:45:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029A56C73A;
        Thu, 10 Nov 2022 22:45:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92F7C61EAA;
        Fri, 11 Nov 2022 06:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E29C433D6;
        Fri, 11 Nov 2022 06:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668149146;
        bh=XdnoI2mnchIv1Dr53hsJYK4MVDi1fguWFCtXHIuAJbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUIG0gJPasqy/7PtczlqXZaNANV5fyAI3RYDlSbSiJqQCC8U5FwEc0BMKEs0IODli
         IDMs1qLPDkymgYb8tEZ2h4KDQHXvExX5L0Dan+mycBJJ4uq8vFxGNWLbAQFRSwyICb
         mws7idXT+6jWd9tjDKICi1UjgfiWem2y6ZTVhUePDBrOmRrh4fhI65Fx39tmGsbaon
         o2Yzh2ZUiWgbMcYcWwMpDri5Jm/KEBnCajjMPz/vqDY3pSawJcruNjh/ARrtA9jI44
         I7f0zVgcrqes8eWeZIu7A3ouC2vhezvsb0l/MVmac/RYJjzs1aO0je/iaKC0KBPGJk
         3ojrzMHt/7wOQ==
Date:   Fri, 11 Nov 2022 14:45:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] ARM: dts: imx6ul/ull: suspend i.MX6UL watchdog in
 wait mode
Message-ID: <20221111064537.GM2649582@dragon>
References: <20221104070358.426657-1-andrej.picej@norik.com>
 <20221104070358.426657-4-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104070358.426657-4-andrej.picej@norik.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 08:03:58AM +0100, Andrej Picej wrote:
> It was discovered that the watchdog triggers when the device is put into
> "Suspend-To-Idle"/"freeze" low-power mode. Setting WDW bit disables
> watchdog when the device is put into WAIT mode.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied dts, thanks!
