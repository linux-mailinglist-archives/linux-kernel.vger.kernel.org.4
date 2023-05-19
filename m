Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B444709E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjESRur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjESRuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:50:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B212B107;
        Fri, 19 May 2023 10:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EC74659A4;
        Fri, 19 May 2023 17:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0031C433D2;
        Fri, 19 May 2023 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684518644;
        bh=GPLFQUmxCW4bUicLJ/JTla9Va0nrQXI6jzLWU84kVj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P89LfOQ+XOErPOdtV8bhG9xzgiKXghm8H2q6uQNtYG650FHlc9HJg1PuIh1yXcqDg
         4mwaae8YJ8l/VWyRWqjj3CjHaJq2aksXStKDsyn/bGcu1s2eh32TZg6AVUWHJLYLR4
         hvRwpGWFVvH14yn5xg8M1LD4sub11XzJVjtPdbpkTcq2DMCP0+FfxnVfbKoKrokke+
         Ce/I9dfisfgfn8NHOYtZUcK7jDqle+4r+sg4EcuYybeqjdFIZ8lSvSOaxOv+GbcJTt
         0nlZutyavvq3k9GNG40adWPJzyKTq6t2Pf2L/e8chmdHt+TutZGmMeOGboJU17PtHD
         2eo76Zzev4EiA==
Date:   Fri, 19 May 2023 23:20:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, Li Jun <jun.li@nxp.com>,
        patchwork-jzi@pengutronix.de, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v2 0/2] Add phy tuning support for imx8mq-usb
Message-ID: <ZGe28E0CXaJv3eKk@matsya>
References: <20230516-lustige-usb-phy-dinge-v2-0-3383a0de34ac@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516-lustige-usb-phy-dinge-v2-0-3383a0de34ac@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-05-23, 18:20, Johannes Zink wrote:
> This series adds support for USB phy tuning parameters, which are
> required for meeting USB certification and EMI qualification.
> 
> Patch 1/2 adds the required properties to the fsl,imx8mq-usb-phy
> devicetree binding.
> 
> Patch 2/2 adds the phy tuning parameters to the phy-fsl-imx8mp driver.
> This patch is ported and cleaned up from the downstream Freescale vendor
> tree.

Applied, thanks

-- 
~Vinod
