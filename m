Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC880612312
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJ2M7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2M7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:59:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB02E108E;
        Sat, 29 Oct 2022 05:59:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70AF560A57;
        Sat, 29 Oct 2022 12:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11CDC433C1;
        Sat, 29 Oct 2022 12:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667048367;
        bh=UABPw7ygbkkGhmQSbcjLOCcdCg+jqhDTmbr0t9QLgF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsUL+3VC5CzVl8iEnIrDVSnzAcbfFDVzClC1C3QYKERcX23LI3n6wfnJCmutvHz16
         z7egBZjmllGWVmCTyYgPRpcRkZo87BLxhaZ29pz3A9qlAZKBnGh1TJ07ClNeqNFtoi
         htG+QObCz2sD7E/6CSTbNGdmRuf3fFg4vZ3Msi0QxLBRkJyKxNE2WBeM40rTwZcCI1
         e16EU1DQCbgwHqh6tNX1B/ZcF7ZJ8PannImCLtVitORKZDj9gHV6iqoojDqpg8wGPV
         ApoAdR2zpoMELMsIJvE3Icx8zDmcMKHb6r133SxWVEQF/Mi6CG8J5P4TsYSv9Ypx5g
         73GNyKnN3R1Cg==
Date:   Sat, 29 Oct 2022 20:59:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH] arm: dts: imx: e60k02: Add touchscreen
Message-ID: <20221029125920.GY125525@dragon>
References: <20221026173015.1172816-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026173015.1172816-1-andreas@kemnade.info>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 07:30:15PM +0200, Andreas Kemnade wrote:
> Add the touchscreen now, since the driver is available.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

We idiomatically prefix i.MX arm DTS patch like 'ARM: dts: ...'

Shawn
