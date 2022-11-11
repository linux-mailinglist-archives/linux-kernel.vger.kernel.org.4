Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C606252E6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiKKE5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKKE5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:57:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1717671;
        Thu, 10 Nov 2022 20:57:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9979B823E9;
        Fri, 11 Nov 2022 04:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443D4C433D6;
        Fri, 11 Nov 2022 04:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668142656;
        bh=Estt/Z+lEYnmR8fT1vRI3VhUQiE2h2Tzj9TxnuhLWJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YtgOMGe3hzVvxxmlcieE/cYs+0zU9SvUXgYaIEA/uXbsENRcvjKw6iYf02ajsXUX+
         FJvdPanvvOq3tHSkggDydVpixNz1EaFZ3OaamArPlJVS/nRnxW3fcJ7RE6X3CdomoS
         IwE316TbuofF7n+E4IV/BLZpB7HU500CanoImoB1lEosu1bw2uXxTClsNemzmC5tez
         DFNkrZgUhwEtbBvvaizYFhRNy+jbDWYI4mxFJf2XFiHSm4kXduM3ts8yyyS47K8EfU
         3USnu9XukFcSvC4fGpS6il9EE+zLEBV70p8OgseltH/o3YxgOo/AqDyV2+bQZuy38w
         WJgEhBibSTVow==
Date:   Fri, 11 Nov 2022 12:57:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chester Lin <clin@suse.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, Rob.Herring@arm.com,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 07/20] arm64: dts: Update cache properties for freescale
Message-ID: <20221111045727.GM125525@dragon>
References: <20221031091956.531935-1-pierre.gondois@arm.com>
 <20221111025553.GJ125525@dragon>
 <Y23URNBaDS4wmykw@linux-8mug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y23URNBaDS4wmykw@linux-8mug>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 12:49:08PM +0800, Chester Lin wrote:
> Hi Shawn,
> 
> On Fri, Nov 11, 2022 at 10:55:53AM +0800, Shawn Guo wrote:
> > On Mon, Oct 31, 2022 at 10:19:51AM +0100, Pierre Gondois wrote:
> > > The DeviceTree Specification v0.3 specifies that the cache node
> > > 'compatible' and 'cache-level' properties are 'required'. Cf.
> > > s3.8 Multi-level and Shared Cache Nodes
> > > 
> > > The recently added init_of_cache_level() function checks
> > > these properties. Add them if missing.
> > > 
> > > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > 
> > Looks good to me.  Should I pick it up on IMX tree, or it needs to go as
> > part of the series (via other tree)?
> > 
> > Shawn
> > 
> 
> The change for s32g2 looks good to me. I would be grateful if you could pick
> this patch to the IMX tree. Thanks!
> 
> Reviewed-by: Chester Lin <clin@suse.com>

Ok, I will wait a confirmation from Pierre that the intention is indeed
for platform maintainer to pick up individual patch.

Shawn
