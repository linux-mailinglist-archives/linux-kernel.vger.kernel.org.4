Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40759701D89
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 15:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjENNIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 09:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjENNIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 09:08:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF2C26B9;
        Sun, 14 May 2023 06:08:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C5861230;
        Sun, 14 May 2023 13:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131C7C433EF;
        Sun, 14 May 2023 13:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684069695;
        bh=NK5zrijl/RLPBl7canPlAL1BHL2QLiAgW3Yo0oueNxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3n/lqwzNwkUO7gdH3UCTX/3sjVOAsLcXRAPgwF02Txu7NNE3uvpAAE2cZIYX79xF
         b/ZBitWsgonYKDylFeBLNsb1lFkV9m7fo9UesdTYVNYM3tj+ARkABFkmRhTeCD0ato
         d7En9UvuZwJ/7TaCHHG2OPyea7CnSRqU3IDOhr6JKr3qdrjUl4ONEkVeXDBsPckW74
         PhqKzNk3K5Fiaz3U4Do7yncmcHkqiUtm4ThlpHdGLn8any3SqJWzRRvk8wJFzpXa4y
         cK+yJ0nnu3NfLMlzZnRWLqXbWkA/5z3FLIelxCj5nCdy+3Cv9VbcvVGq90XFMlvQFW
         G7gpWqFZky/wg==
Date:   Sun, 14 May 2023 21:07:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: Re: [PATCH 0/2] Add i.MX8MM-EVKB Support
Message-ID: <20230514130750.GY727834@dragon>
References: <20230503-b4-v6-3-topic-boards-imx8mm-evk-v1-0-1e15a371d374@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503-b4-v6-3-topic-boards-imx8mm-evk-v1-0-1e15a371d374@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 05:20:03PM +0200, Marco Felsch wrote:
> Hi,
> 
> I picked the patch series from Johannes [1] and reworked it according
> the comments and the discussion.
> 
> @Krzysztof
> I dropped your ack for the bindings since I adapted the comment within
> this oneliner. Please can you check the current state and provide your
> (n)ack again?
> 
> [1] https://lore.kernel.org/all/20230130172553.2738182-1-johannes.schneider@leica-geosystems.com/
> 
> ---
> Johannes Schneider (2):
>       dt-bindings: arm: fsl: Add i.MX8MM-EVKB
>       arm64: dts: add NXP i.MX8MM-EVKB support

Applied both, thanks!
