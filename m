Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77555BA9E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiIPKDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiIPKDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B03AB063;
        Fri, 16 Sep 2022 03:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5239D629E7;
        Fri, 16 Sep 2022 10:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D660BC433C1;
        Fri, 16 Sep 2022 10:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663322626;
        bh=IrRpLDMDs+HT59NwqXm6upgxwRox+YGPLMl9PZVetIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gc1uEV31QDg+WFDw4XOc2ZUk7YA/iih++U/R6kY58biDgvePOMtoXWu1ekZ+cNLAa
         V9em2DoIROQ9e7E3V/A5z1TL/mKP9BQxwDLBxajwGlpviCA7lp7Vqh/ZdwfuepdkXO
         zOGTK5e7nkJPW3PWs7fwBtngOBWl/2dpGwcvPHlPHhGO+sKu3hLfzkmrHS/NRmHKc5
         WjXtfoiOTvPvdNrUNyPwWekDZA07Ka9E5Ue4j0De5QemP9GmSEP6CNgcAii3CtG8N4
         OGJ9PkG1OBzhZqKgTeTbApYSai66tXJWP1Qbz48wYJfd9URg9Gua1R3R8thzDnDCv8
         wpoJCESh8tCxQ==
Date:   Fri, 16 Sep 2022 18:03:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mp-venice-gw74xx: add PCIe support
Message-ID: <20220916100340.GM1728671@dragon>
References: <20220908154903.4100386-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908154903.4100386-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 08:49:03AM -0700, Tim Harvey wrote:
> Add PCIe support on the Gateworks GW74xx board. While at it,
> fix the related gpio line names from the previous incorrect values.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
