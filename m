Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F637625451
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiKKHKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKHKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:10:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA8ABF5A;
        Thu, 10 Nov 2022 23:10:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C22BF61EB2;
        Fri, 11 Nov 2022 07:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239ADC433D6;
        Fri, 11 Nov 2022 07:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668150651;
        bh=44w+Fl51DHOavbg54OA+rUmVXD6RmtykGkZJuEnzcRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lfn389LsSaZIIFb6vDyCicz/Y7tqEhtcG15ht7ywC1xXXMH5G+Ek7ZVZN85AOrBpR
         5WJJyY8W9PZ7/loeHgwjpim5tpZQsCCZs9JzN1rJz9bH+Nhd3yUkJXF6LlLswjDN35
         bZjiXIhDBTqoMrlcHVSZ4JPP9TgJAzlfRRMzFyjQOvluLC3F3I67rlRgStFifWq9FP
         UD1AhC9LAqNJ4JRcBxztwzUBhBi0rOR0NIVJ+EvNOi1urFM/Y/qelGum9z15tdV3uJ
         Odvj86Pi9jtbVOCAoipLf19B5uWGElpSdEiq2AVdMC+61U1vVG2dyyZrmoumGmhaxB
         wUWWKi4lhkm6w==
Date:   Fri, 11 Nov 2022 15:10:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8m{m,n}-venice-gw7902: add gpio pins for
 new board revision
Message-ID: <20221111071044.GQ2649582@dragon>
References: <20221107181754.218158-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107181754.218158-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 10:17:54AM -0800, Tim Harvey wrote:
> Add gpio pins present on new board revision:
>  * LTE modem support (imx8mm-gw7902 only)
>   - lte_pwr#
>   - lte_rst
>   - lte_int
>  * M2 power enable
>   - m2_pwr_en
>  * off-board 4.0V supply
>   - vdd_4p0_en
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
