Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF136092D5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiJWMnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiJWMnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:43:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3136D63FCA;
        Sun, 23 Oct 2022 05:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D150CB80BED;
        Sun, 23 Oct 2022 12:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7FAC433D6;
        Sun, 23 Oct 2022 12:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666528977;
        bh=vrFk6NMIz6UAgnOLVnkBD64jbgD9mYeUIHhy/LZoHKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9WrvSXa6HYHHKodX3Qn80rSlHP2xt8YHUUs0djqXwupe7TI6NDnat92FsIlqolaK
         ZmwflspNGJ03RtOREPT55XB/F358xEI0KPRVn3vEg283PJFf+TnIyc9QyJpqUngDRv
         sxvlNqd60HbPgU60It0wbahqHi3jOpzrOGNR1GtJIU9Fv13h6M76s9v/SSZuDzxXAP
         vDbAWuC2SbUJA7FSA8k3VCGQMBkEMif1ZVG3uFij9Sl9CBszzFgCcfx8MTJWIf6vhR
         PclYNVHnBm9k3w9tuJywB3CImwLaCQs9mZ8jOB4DTP0ZV3l7qomvfwqLfa/8S+oW6F
         SFegSeGTeWWjQ==
Date:   Sun, 23 Oct 2022 20:42:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8m*-venice: add I2C GPIO bus recovery
 support
Message-ID: <20221023124250.GG125525@dragon>
References: <20220921164620.3298914-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921164620.3298914-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 09:46:20AM -0700, Tim Harvey wrote:
> Add I2C GPIO bus recovery support by adding scl-gpios and sda-gpios for the
> various I2C busses on Gateworks Venice boards.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
