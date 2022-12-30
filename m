Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1193B659A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiL3PnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiL3PnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:43:16 -0500
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A591B9D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1672414992; bh=w9fhMs5fspO/slo/bCQ0zUyvbC6Ov4MaIWY/dq3FWIc=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=ecOJKlTVZT7pYN6fFl0dVKUkKKjwd1f/cbokCbDz3ItCoOxeODKYrSgV3ib9p1r9Y
         lBQUQCErsE5hIDXhjXp1nj8+M3o/M3/LnB9lum4hCPANHpHkDbtKiQtEBblqH5cBQ1
         3w3L6AMiQXy9OgR7280HBqrDkSLj33SbTEfwzjuM=
Date:   Fri, 30 Dec 2022 16:43:11 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Mader <robert.mader@posteo.de>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Peter Robinson <pbrobinson@gmail.com>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        dri-devel@lists.freedesktop.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v4 3/4] MAINTAINERS: Add entry for Himax HX8394 panel
 controller driver
Message-ID: <20221230154311.bvgmjlryu5guctyr@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>, Sam Ravnborg <sam@ravnborg.org>,
        Robert Mader <robert.mader@posteo.de>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Peter Robinson <pbrobinson@gmail.com>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        dri-devel@lists.freedesktop.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20221230113155.3430142-1-javierm@redhat.com>
 <20221230113155.3430142-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230113155.3430142-4-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Dec 30, 2022 at 12:31:53PM +0100, Javier Martinez Canillas wrote:
> Add myself as maintainer for the driver and devicetree bindings schema.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> Changes in v4:
> - Add Sam Ravnborg's Acked-by tag.
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7729a30b9609..c901e536303b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6551,6 +6551,13 @@ S:	Maintained
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	drivers/gpu/drm/tiny/gm12u320.c
>  
> +DRM DRIVER FOR HIMAX HX8394 MIPI-DSI LCD panels
> +M:	Javier Martinez Canillas <javierm@redhat.com>

+M:	Ondrej Jirman <megi@xff.cz>

thank you,
	o.

> +S:	Maintained
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> +F:	drivers/gpu/drm/panel/panel-himax-hx8394.c
> +
>  DRM DRIVER FOR HX8357D PANELS
>  M:	Emma Anholt <emma@anholt.net>
>  S:	Maintained
> -- 
> 2.38.1
> 
