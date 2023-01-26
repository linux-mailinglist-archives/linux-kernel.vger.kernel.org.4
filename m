Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7F667C51E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 08:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbjAZHsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 02:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjAZHsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 02:48:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121AA3A8E;
        Wed, 25 Jan 2023 23:47:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 623EBCE1D9A;
        Thu, 26 Jan 2023 07:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1B2C4339B;
        Thu, 26 Jan 2023 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674719261;
        bh=cWzPUPHRhYLWPXWeP+c1yAdqMHSIpVSEZAzI1cfprDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pByM1yY7eqgdH4BR4rYbQCa/dIKoF/cj0fBlRYiXOAhz8V2vS3VpGT12lbi0RzKaK
         UJ+0C8vuyDgqTqXQsmfyh86tSjXVP0bfwLPEqmDE9FbZ3nxw7ryN+f7osZjIvr77EH
         qVXvP524SPASiZ2vs1bkK49zjGle3jt9ykaT/hdS9hO+XCYIuWv1LfJ+0/u9TlOeVp
         QHAd4F0qXJ1Xu+kd2TreJFg9m8WIIuYiRKXkGwh7dgTtD8tFXxURxpUG8b1T6DptCV
         A5HzH0Z0m5trFWHgpf2ojSkDdJLcLgiI4VMiH1o5EWf/8pZEJkYUD2cbsZny2IjWs4
         h5fuh3AKjBkjw==
Date:   Thu, 26 Jan 2023 15:47:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 2/2] arm64: dts: imx: Introduce imx8mp-beacon-kit
Message-ID: <20230126074732.GZ20713@T480>
References: <20230117223846.465016-1-aford173@gmail.com>
 <20230117223846.465016-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117223846.465016-2-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 04:38:45PM -0600, Adam Ford wrote:
> Beacon Embedded has an i.MX8M Plus development kit which consists
> of a SOM + baseboard.  The SOM includes Bluetooth, WiFi, QSPI, eMMC,
> and one Ethernet PHY. The baseboard includes audio, HDMI, USB-C Dual
> Role port, USB Hub with five ports, a PCIe slot, and a second Ethernet
> PHY.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Changed subject prefix to 'arm64: dts: freescale: ...'

Applied both, thanks!
