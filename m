Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431CE60C054
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJYBDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiJYBC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:02:29 -0400
X-Greylist: delayed 1503 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Oct 2022 16:58:37 PDT
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C59917252B;
        Mon, 24 Oct 2022 16:58:31 -0700 (PDT)
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.17.1/8.17.1) with ESMTPS id 29OMOeVe015083
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Oct 2022 08:54:42 +1030
Date:   Tue, 25 Oct 2022 08:54:40 +1030
From:   Jonathan Woithe <jwoithe@just42.net>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Ike Panhc <ike.pan@canonical.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mattia Dongili <malattia@linux.it>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Azael Avalos <coproscefalo@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Robert Moore <robert.moore@intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        ibm-acpi-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org,
        devel@acpica.org
Subject: Re: [PATCH 09/22] platform/x86: fujitsu-laptop: Use
 acpi_video_get_backlight_types()
Message-ID: <Y1cQqG2eiISdKv0S@marvin.atrad.com.au>
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
 <20221024113513.5205-10-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024113513.5205-10-akihiko.odaki@daynix.com>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 08:35:00PM +0900, Akihiko Odaki wrote:
> acpi_video_get_backlight_type() is now deprecated.

The practical impact of this patch series on fujitsu-laptop is obviously
very minor assuming the new acpi_video_get_backlight_types() function
functions as advertised.  Accordingly, as maintainer of fujitsu-laptop I
will defer to the opinions of others who maintain the lower level
infrastructure which is more substantially affected by the bulk of the
changes in this series.

I note that Hans has naked the series and I'm happy to go along with that.

Regards
  jonathan

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/platform/x86/fujitsu-laptop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index b543d117b12c..e820de39cb68 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -387,7 +387,7 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
>  	struct fujitsu_bl *priv;
>  	int ret;
>  
> -	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
> +	if (!(acpi_video_get_backlight_types() & ACPI_BACKLIGHT_VENDOR))
>  		return -ENODEV;
>  
>  	priv = devm_kzalloc(&device->dev, sizeof(*priv), GFP_KERNEL);
> @@ -819,7 +819,7 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
>  
>  	/* Sync backlight power status */
>  	if (fujitsu_bl && fujitsu_bl->bl_device &&
> -	    acpi_video_get_backlight_type() == acpi_backlight_vendor) {
> +	    (acpi_video_get_backlight_types() & ACPI_BACKLIGHT_VENDOR)) {
>  		if (call_fext_func(fext, FUNC_BACKLIGHT, 0x2,
>  				   BACKLIGHT_PARAM_POWER, 0x0) == BACKLIGHT_OFF)
>  			fujitsu_bl->bl_device->props.power = FB_BLANK_POWERDOWN;
> -- 
> 2.37.3
