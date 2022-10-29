Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B38E611F5C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 04:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJ2Cjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 22:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJ2Cjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 22:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7C363A8;
        Fri, 28 Oct 2022 19:39:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E205C62B46;
        Sat, 29 Oct 2022 02:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8017EC433C1;
        Sat, 29 Oct 2022 02:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667011169;
        bh=csx8wmxxWUKnGS177UVXFMXaARE/rRs7rGyuI7jTgtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+O4yE+GFxGItHWd6Mvv7ejOn28W8rY3GgTN2hsv+zh4SO/Q3NjcrTiupSJb5AQ3q
         GzhR0jyfxHKeq3Kirt19wjd0mQ8m2+0I06dcIe9u7cD4NqwGSj3KOh9+pg86gwphRY
         nqqryADy1s2hLXrgnNHL3AuMFBUEj8qm+6l3XmMUk1P8F9oBsjn/2RQb3azTHwz/zO
         KNck9d6CA0KczV04e0M7LhtmhGuJaQV4itxjKz/j6Q4aXGsNiGm0ubifhr9OogV5tL
         32kfMXnMw0StMtPfo97TAVYG5qy2WH63bj/YyIt2O+AWJdWCf5gX8gJgyJEdbP2QME
         Q8wRFkVEp6/+Q==
Date:   Sat, 29 Oct 2022 10:39:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ulf.hansson@linaro.org, l.stach@pengutronix.de,
        andrew.smirnov@gmail.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] dt-bindings: power: gpcv2: add power-domains property
Message-ID: <20221029023921.GI125525@dragon>
References: <20221010100958.290307-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010100958.290307-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 06:09:58PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Some pgc power-domain requires a parent power domain, so
> add an optional power-domains property, otherwise there will be
> dt check warning:
> gpc@303a0000: pgc:power-domain@1: 'power-domains' does not match
> any of the regexes: 'pinctrl-[0-9]+'
> 
> Fixes: 30af8513bdb5 ("dt-bindings: power: add defines for i.MX8MM power domains")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
