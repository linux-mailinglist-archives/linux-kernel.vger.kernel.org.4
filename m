Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD336250E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiKKCiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiKKCg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:36:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E6267F5E;
        Thu, 10 Nov 2022 18:35:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7054B823E0;
        Fri, 11 Nov 2022 02:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4D3C433C1;
        Fri, 11 Nov 2022 02:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668134152;
        bh=Kpivm6/kNme3G5wj03/48cDJZsJHfiRxJsW2BVujKBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cOmEvTT6bfugYGy3Ga8HU4R6F4h6myeAwwRvvUUnxrPHFJs5S+D7+w+WFOaVIlZTd
         UuErJLaSlEJcgjEKzHXi/g1mSRYXFeZ54Hv07DpFlY+mvuTVpvGJHIS1L4AH9deLkv
         A5J1ghF3CgI9/+U4yWIsf57nnfjslh08TQ3kJLjqmKPTaGFrNbfexrG0qhJ9CDGdMB
         WUQN+SpP9ejQ0Bh3I+pJ2W/v6U0c+kkU0yF8HJazh+8qpS3sZOEpmqKk5Hvdd1wxqJ
         8Jj3RBNEDWk0vd/gTPp41EJGA8LLqmuByXGVp5wZ9K8U50LfSFUj9AB9h/Tt4gAqJT
         28jja1P4MS8IA==
Date:   Fri, 11 Nov 2022 10:35:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shenwei Wang <shenwei.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: Re: [PATCH v4 1/5] arm64: dts: imx8dxl-ss-lsio: add gpio-ranges
 property
Message-ID: <20221111023535.GF125525@dragon>
References: <20221027130859.1444412-1-shenwei.wang@nxp.com>
 <20221027130859.1444412-2-shenwei.wang@nxp.com>
 <CAOMZO5Cy3h50QmjnTBDNweQS3JZN6HEx6A549860hUg5opuftQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5Cy3h50QmjnTBDNweQS3JZN6HEx6A549860hUg5opuftQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 10:29:53PM -0300, Fabio Estevam wrote:
> Hi Shenwei,
> 
> On Thu, Oct 27, 2022 at 10:09 AM Shenwei Wang <shenwei.wang@nxp.com> wrote:
> >
> > add gpio-ranges property for imx8dxl soc.
> 
> The commit log could be improved by stating the reason for adding gpio-ranges.

Shenwei,

Could you resend the DTS patches with commit log improved?

Shawn
