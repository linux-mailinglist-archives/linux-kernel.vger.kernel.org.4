Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6673E6122F1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJ2McF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2McC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:32:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5CF4362A;
        Sat, 29 Oct 2022 05:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A29BB80B8C;
        Sat, 29 Oct 2022 12:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88601C433D6;
        Sat, 29 Oct 2022 12:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667046719;
        bh=JQNqjjF1fdq01amg12SW8BOIrXiIMWFieuiSrg1ze28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RblPKuXoDjz+VlqpnwAHqEA5ZBWkuevnvxoryLvKTDSQ7GoPoZ2uAnMkqhF2IvnBQ
         nitctOqIlVnPM3XOq0mI36u7+dqtu34LUClQU8gesBVA5NoLbH+Xb1gGYONGRVs4fG
         vHZkvIXjWk+7C4BsROy1Ry86R6cOXrF2wjBa2s8KxvEVmrS0cnEBWsxGQGa79l8trB
         O0HOntUfD+y2Bnkt+jKx7L2qCASk5FWo21AAV5bWqrjA08ms9z2RrWf6fufxMaGjV/
         xDJyec4kxUzGtCwpEjz8PgI9zez8pcw28hmRhx2yHV5gY40Ew/1rAw8XbHFP0wqX9g
         HOtXma4QEJxFg==
Date:   Sat, 29 Oct 2022 20:31:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rmk+kernel@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arch: dts: specify the MDC frequency on Layerscape
 DPAA2 devices
Message-ID: <20221029123153.GW125525@dragon>
References: <20221025144117.1010488-1-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025144117.1010488-1-ioana.ciornei@nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 05:41:14PM +0300, Ioana Ciornei wrote:
> Up until now, the external MDIO controller frequency values relied
> either on the default ones out of reset or on those setup by u-boot.
> Let's just properly specify the MDC frequency in the DTS so that even
> without u-boot's intervention Linux can drive the MDIO bus.
> 
> This patch set adds the needed properties on all DPAA2 based SoCs.
> 
> Ioana Ciornei (3):
>   arm64: dts: lx2160a: specify clock frequencies for the MDIO
>     controllers
>   arm64: dts: ls1088a: specify clock frequencies for the MDIO
>     controllers
>   arm64: dts: ls208xa: specify clock frequencies for the MDIO
>     controllers

Applied all, thanks!
