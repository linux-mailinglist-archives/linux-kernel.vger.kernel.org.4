Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E7A70211C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 03:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbjEOB0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 21:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjEOB0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 21:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4210E5;
        Sun, 14 May 2023 18:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3291760ED6;
        Mon, 15 May 2023 01:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DEBC433D2;
        Mon, 15 May 2023 01:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684113992;
        bh=FBAJcK48G0/3ozZ6xTCX78O8o6Xt6mni2Fpe2uK3Mws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISQOrI7quFV4DMPDKbpBcxUM6gqiWDlXYrRu5TTjJrw+MmevG3z4xNctsre1aPAa1
         xE/N3eeE5Ukv7LTLWWgJry17l1cMskXIB8jFBaDI6V8baGeE2VQDePcm2pE4pSKYZ6
         GBi706Zl5uST6BDhVEaJkxfBp+tFxh5k6DzFV7/Z/1JqeySSFrXCcBo0HgnanL+BjO
         Mt4bclWu37nBWqzqrBSZxnGPGThuLaWgV8VF9OVxqfrc7uWaViG08ianLVybz8xTYY
         8gIHVsoOXCzxAgCtZsN+/QY1MO0fXozRA09uNGcw8AduYM8Ff/TJUSfG2bqqr/Rrsu
         GiETTgU1h6TFQ==
Date:   Mon, 15 May 2023 09:26:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/3] arm64: dts: imx8mn: Add CSI and ISI Nodes
Message-ID: <20230515012619.GA767028@dragon>
References: <20230507151549.1216019-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507151549.1216019-1-aford173@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2023 at 10:15:46AM -0500, Adam Ford wrote:
> The CSI in the imx8mn is the same as what is used in the imx8mm,
> but it's routed to the ISI on the Nano. Add both the ISI and CSI
> nodes, and pointing them to each other. Since the CSI capture is
> dependent on an attached camera, mark both ISI and CSI as
> disabled by default.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied all, thanks!
