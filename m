Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC46092A3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJWMZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiJWMYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:24:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C788319009;
        Sun, 23 Oct 2022 05:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 415FDB80D6B;
        Sun, 23 Oct 2022 12:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8217AC433C1;
        Sun, 23 Oct 2022 12:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666527886;
        bh=KRxc30fHjTzv+sKWd7/X4dO/++yO0svmpvqVOief22o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3uQs6URR8wr7BUQkCGuoMdlxDQlyRvn9NBY9KTHyeH5+rcZnGGb6ekiFA3ax70Mt
         YSkX6Has89Nu/YtFzhlDEwdFmpYp1jF8HkRUKUwQRykA9j4E7pmG5lJE2MJar9AQ5Y
         F+tQRUwtd5egJXtjbuOKahM9GPVdwlsg7BwmG7/G9rGXu2/ZB84hfrUXeruRKG2+6F
         AdiWdYiIcC9M2M7AcctZ35FMc6s2HhGgXi20g0A5+zji02yEnCoVU32ymQShpsa2qX
         wYEVRoKOFBUzY6B78VzR8USoYCl9LMNvbdmR+nqEFud75KHEV4cOa/kaiFEPKxApGE
         YD5kZBy7IlkTg==
Date:   Sun, 23 Oct 2022 20:24:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: firmware: imx: sync with SCFW kit v1.13.0
Message-ID: <20221023122439.GF125525@dragon>
References: <20220921143603.175195-1-viorel.suman@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921143603.175195-1-viorel.suman@oss.nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 05:36:03PM +0300, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> Sync defines with the latest available SCFW kit version 1.13.0,
> may be found at the address below:
> 
> https://www.nxp.com/webapp/Download?colCode=L5.15.32_2.0.0_SCFWKIT-1.13.0&appType=license
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Applied, thanks!
