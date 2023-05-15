Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85824702221
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjEODYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEODYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7C0A0;
        Sun, 14 May 2023 20:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1679961E17;
        Mon, 15 May 2023 03:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDD7C433EF;
        Mon, 15 May 2023 03:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121046;
        bh=eRxOckbGUkh/rtq6ytjzrH+UpziV7wzHkqyPJ2Vv2GM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=koPsS6DN+GyxGApwxH2QZn7o5Nvs/WnC/4BRNRIhi1kkdWmH1aUoJwm8h7Y4TSEEC
         ELl1NjufEiE7yTdzE2ix25XWQYIYCYNJGUi9SmI3fDaUDSawqXs6ltCiWFLf7iImBz
         jz8FpCQL7QNprR8DcRMpyUeudWhBG7oDYzaWpz7owLQh7CItJ9NJqzf5OcXg0XeGUQ
         PQnwYLzNosKa/GMlIV5h+f2iVv5Bopfv9UWssIRoh3u2n1u1MWCDEXUkIBDqYEA95s
         8/f6W1FSFTWSVM879sUgfOO5l6vguenf639Q8PhcqVRxXHjRWYZEgcImeHs69nvs2v
         GDwRNV6uVka4w==
Date:   Mon, 15 May 2023 11:23:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/5] arm64: dts: imx93: add nodes and minor update
Message-ID: <20230515032355.GF767028@dragon>
References: <20230510083153.3769140-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510083153.3769140-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 04:31:48PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add watchdog/ocotp/cpuidle for i.MX93
> Reorder nodes
> Enable WDOG3 for i.MX93-11x11-EVK
> 
> The OCOTP yaml has got reviewed by DT maitainers:
> https://lore.kernel.org/all/01be24b3-aaf2-e27b-d00e-f8649a497463@linaro.org/
> 
> Peng Fan (5):
>   arm64: dts: imx93: add watchdog node
>   arm64: dts: imx93: add ocotp node
>   arm64: dts: imx93: reorder device nodes
>   arm64: dts: imx93: add cpuidle node
>   arm64: dts: imx93-11x11-evk: enable wdog3

Applied, thanks!
