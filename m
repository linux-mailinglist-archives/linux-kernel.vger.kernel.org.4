Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB5F5B656A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiIMCKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIMCKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:10:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3244628E14;
        Mon, 12 Sep 2022 19:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCF93612F1;
        Tue, 13 Sep 2022 02:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FBFC433D6;
        Tue, 13 Sep 2022 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663035028;
        bh=iOCa/FOL18eu25U24rNQrT/Q1C5N9fUY4knAgfJAbw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u6B3JbWVVNBuEb+sTPlq//nvc1w11lCpPl/Bjnf8XqbwnHiQE8Qu9RqHTP8UDi13f
         QHa0o6Gs1IW8ytNMZEwyzTSwAiz/ZSNRYNt6z5EPr7CfKTHxw5duYrltmZMaQlU9e6
         uO6p2OGrbCUoFVFNL/PKYDpGFhRv/ZIIdbyZ+xx+943/c9vSr0QGrwfQHelr+LzxVX
         RiHS/N7UYxg7rLuAhJWyVzmVuvxTd57hTfAORr9PJjOaJM2EBCjRQzDPSgiJ8nNygn
         Mla/vJeYgMYbxJMi8P+dYKDQ0C7hoczCINWz0dK7FELA8HeB6TcoZvvtHkH2W13rya
         rDlWKBt+swlAg==
Date:   Tue, 13 Sep 2022 10:10:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jun Li <jun.li@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-venice-gw74xx: add USB DR support
Message-ID: <20220913021021.GF1728671@dragon>
References: <20220908154227.4099410-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908154227.4099410-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 08:42:27AM -0700, Tim Harvey wrote:
> Add support for USB DR on USB1 interface. Host/Device detection is done
> using the usb-role-switch connector with a GPIO as USB1_OTG_ID is not
> connected internally.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
