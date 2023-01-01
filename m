Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5079265A8A2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 03:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjAACcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 21:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAACce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 21:32:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6526144;
        Sat, 31 Dec 2022 18:32:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B50460CF6;
        Sun,  1 Jan 2023 02:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49144C433D2;
        Sun,  1 Jan 2023 02:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672540351;
        bh=FJFU71w/l5MS0DSmttT0bJ0A+5i5vzp/TsNcOQIg0J4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSSB95o+RwuGWoJ7lwiP6+nRZfWCIkTHmzyGVOA8zRfqKVnxocd4YAGY/ND7T1RFm
         XoPIdYWS1JOgOSajbgsprISVWTN4/5t93sqoDpvcoCf8frUfyhcG/abHa4zHco/MXB
         QuBmIJ+7DC8VA/Ve9z4rXPb3pB/hRiRPfbjWu2WPJEaAuIxUzdUsEASRBHIzmIP/ub
         pvS3WQTe0Rj8TX2JEhdpOrFcZX7ofLYXtludE5VFNl26tGoZVYvrw2ii09T6piJUG/
         uCwAYPjzR2Dk2nntz+Vu/+9dytTfBjva24AGZH7qBZZamaOJ18o3+EGbFrsL110lbl
         bJY/H3BWv/eXg==
Date:   Sun, 1 Jan 2023 10:32:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Nikolaus Voss <nikolaus.voss@haag-streit.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, nv@vosn.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] imx6qdl.dtsi: use MAC-address from nvmem
Message-ID: <20230101023223.GJ6112@T480>
References: <20221128084749.5F10D1D73@mail.steuer-voss.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128084749.5F10D1D73@mail.steuer-voss.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 03:27:19PM +0100, Nikolaus Voss wrote:
> IMX6QDL has fuse locations specified for storing the MAC for the
> built-in ethernet (Table 5-8 in Reference Manual).
> Define the fuse location in ocotp and refer to them in fec-ethernet.
> 
> If the cells are not flashed, the driver behavior is unchanged, i.e.
> other MAC sources will be probed and a random MAC will be used as a
> last resort.
> 
> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>

I fixed the patch subject prefix like:

  ARM: dts: imx6qdl: use MAC-address from nvmem

Applied, thanks!

Shawn
