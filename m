Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8168969AF8D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjBQPcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBQPcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:32:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6856F3E7;
        Fri, 17 Feb 2023 07:32:00 -0800 (PST)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C876666021B3;
        Fri, 17 Feb 2023 15:31:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676647918;
        bh=z3neAe3zoYlZjaNu5/O4X7BlXl5dBIVOCRdEyu7SXI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nxh4xsmaUDncSMm3Xd4ZUNIVUVCFSZpnwyMMAk2yZk7jPmNwjl9AVlGUgoNWzKlQa
         di0Umh1TV7gB5sQTQMFJc/rYvKopRkQKCIf9ewVBqA4whnjzZ7KnLgPlS8TyXz3FXv
         1eKjOVMvbD/u6K1pPw/+6xgUVkeIbpwn3jU3/+yith2Y7Gn19e9LEe3hgj421tJF0x
         uT8ql0nhsVDl1O10zXEm4IGkS4xrpJZLJjCKe2Wb4/iOk3JEVNUORP9H1iO0Xamr/z
         WGlGxmhR0TSvn8drY0HIf3cZJ+QBa13Mdn2LrVl4QTgQT4V/O/WZsZ5ElmWvsZKuA1
         ISNwaECR5P4rg==
Date:   Fri, 17 Feb 2023 10:31:50 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        devicetree@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        Lyude Paul <lyude@redhat.com>, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        chrome-platform@lists.linux.dev,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH v11 6/9] drm/bridge: anx7625: Register Type C mode
 switches
Message-ID: <20230217153150.tl3zqywvpw6elyg5@notapiano>
References: <20230204133040.1236799-1-treapking@chromium.org>
 <20230204133040.1236799-7-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230204133040.1236799-7-treapking@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 09:30:37PM +0800, Pin-yen Lin wrote:
[..]
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
[..]
> +static void anx7625_set_crosspoint_switch(struct anx7625_data *ctx,
> +					  enum typec_orientation orientation)
> +{
> +	if (orientation == TYPEC_ORIENTATION_NORMAL) {
> +		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
> +				  SW_SEL1_SSRX_RX1 | SW_SEL1_DPTX0_RX2);
> +		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
> +				  SW_SEL2_SSTX_TX1 | SW_SEL2_DPTX1_TX2);

This seems inverted compared to the binding. Binding says 

  0, 1, 2, 3 in "data-lanes" maps to SSRX1, SSTX1, SSRX2, SSTX2, respectively.

But in anx7625_register_typec_switches(), lanes 0-1 mean orientation normal,
then in this logic, you set RX2 and TX2 to carry the DP signals. So the driver
is mapping lanes 0-1 to SSRX2/SSTX2 and lanes 2-3 to SSRX1/SSTX1, the opposite
from the binding.

Thanks,
Nícolas

> +	} else if (orientation == TYPEC_ORIENTATION_REVERSE) {
> +		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
> +				  SW_SEL1_SSRX_RX2 | SW_SEL1_DPTX0_RX1);
> +		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
> +				  SW_SEL2_SSTX_TX2 | SW_SEL2_DPTX1_TX1);
> +	}
> +}
> +
[..]
> +static int anx7625_register_typec_switches(struct device *dev, struct anx7625_data *ctx)
> +{
[..]
> +		ctx->port_data[i].orientation = (dp_lanes[0] / 2 == 0) ?
> +			TYPEC_ORIENTATION_NORMAL : TYPEC_ORIENTATION_REVERSE;
[..]
