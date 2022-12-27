Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0EC656DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 19:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiL0SJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 13:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiL0SI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 13:08:59 -0500
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:405::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7945E1010
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 10:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=KI9iD44piwOpBV52n8OpH29GyNQO91VabKgAppUD7IY=;
        b=P2s64QcldiviamGQN7U8GXah8wChnjisqppwmj8RrqIOtzHP/dfWXgKw1HslrQDg6CZx89B31RYdQ
         6ZrafWmgxlhNz8srHyw6SNkqnmLchpoMIRelJhvDRpgiuZ20K7ZEt7argYzTBp7qpx50Io8eXbKK3e
         Mxik95eUC0vUs5H41dyjP0KnrZKcBs8kyGGhRg5niDOa/1aPha/rRHSo4nsWpIUoPFa5ZoK+gdR5Fx
         ntG/svgXmcI/HK3288PRdR79W3e2Nz0vqp1vDvyLB1WZeNEOPPK0xYBhYSTjFKMjNig6+qkMHyFG6K
         xLju5i9gv7o4hGUlBY0q+DA93yOjIBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=KI9iD44piwOpBV52n8OpH29GyNQO91VabKgAppUD7IY=;
        b=ctTAO7FNvLNqUCI6AWLVNzjzEuGtizrNhJkVLAhKgy/nY09ZZ6EtrGIRXt1rkLN8cVbSpNI/eJ/gf
         FhpCvufCw==
X-HalOne-ID: 84f55dba-8611-11ed-a921-cde5ad41a1dd
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay6 (Halon) with ESMTPSA
        id 84f55dba-8611-11ed-a921-cde5ad41a1dd;
        Tue, 27 Dec 2022 18:08:54 +0000 (UTC)
Date:   Tue, 27 Dec 2022 19:08:53 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Martijn Braam <martijn@brixit.nl>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Kamil =?utf-8?Q?Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Mader <robert.mader@posteo.de>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        Ondrej Jirman <megi@xff.cz>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 3/4] MAINTAINERS: Add entry for Himax HX8394 panel
 controller driver
Message-ID: <Y6s0tWEvqDqR4c54@ravnborg.org>
References: <20221227110335.2923359-1-javierm@redhat.com>
 <20221227110335.2923359-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227110335.2923359-4-javierm@redhat.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 12:03:34PM +0100, Javier Martinez Canillas wrote:
> Add myself as maintainer for the driver and devicetree bindings schema.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> (no changes since v1)
> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2e832cf29bec..175d72203fb6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6480,6 +6480,13 @@ S:	Maintained
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	drivers/gpu/drm/tiny/gm12u320.c
>  
> +DRM DRIVER FOR HIMAX HX8394 MIPI-DSI LCD panels
> +M:	Javier Martinez Canillas <javierm@redhat.com>
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
