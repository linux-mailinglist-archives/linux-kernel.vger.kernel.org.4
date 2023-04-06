Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F1F6D8CE8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjDFBoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjDFBoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:44:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC5E7EEC;
        Wed,  5 Apr 2023 18:44:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E84C764250;
        Thu,  6 Apr 2023 01:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F808C433D2;
        Thu,  6 Apr 2023 01:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680745469;
        bh=drgpXKJ+0i0RnCQqppOYsWBMOPpTHwhRC91xcePhIfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lR7sXE7D2TE1JV0ZwCaWhqBsKFjdr2Hunvc9GBE4Iba7cegqS4JoYtKzjuBOjmhYt
         uTOwt7RSp1JhL7cdj4/18XGaTYtSaGQ6UPA/o4O1bclvvTzlmIMUXq28s6BJbB8rku
         x+Af5M153I2wJZIAI/KD2WUVIOksJMzBiLscLuYGex/bvjMgiaAAmmPd/Qo3/U8wgG
         bGiANCHREKHoeqbKCr3NEo71ZPcvaAhmQUJqNBugVE6rKxjAe+8OthzaRC9pFwSD/O
         Hqye4YT4BxMd7b0c4schKPjpR5M3x2pzREtHGQ6KHEOaWOgHH+6Z2YJW0T7hlAw8Dn
         bLXdXJE0j+Tnw==
Date:   Thu, 6 Apr 2023 09:44:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Subject: Re: [PATCH v5 0/3] dts: imx8qxp add cdns usb3 port
Message-ID: <20230406014422.GK11367@dragon>
References: <20230327145523.3121810-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327145523.3121810-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 10:55:20AM -0400, Frank Li wrote:
> cdns driver code already upstreamed. but missed dts part.
> 
> Change from v4 to v5
> 1. using shorter clock name
> 
> Change from v3 to v4:
> 1. drop assign-clock in yaml
> 
> Change from v2 to v3:
> 1. drop fixed frequency clock binding
> 
> Change from v1 to v2:
> 1. Add binding docoument.
> 2. Fixed all shawn's comments
> 
> Frank Li (3):
>   dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3 glue layer
>   arm64: dts: imx8qxp: add cadence usb3 support
>   arm64: dts: freescale: imx8qxp-mek: enable cadence usb3

Applied two DTS patches, thanks!
