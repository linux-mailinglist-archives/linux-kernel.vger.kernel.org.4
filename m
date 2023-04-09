Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC06DBF2E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 10:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjDIIVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 04:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDIIVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 04:21:36 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35445B83
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 01:21:32 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id E23B324010B
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 10:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1681028489; bh=GCmo/FQZEbl3ShLJvIwU3fxDcrVQZl3kl6EFP8KaIFc=;
        h=Date:From:To:Cc:Subject:From;
        b=Caf1SSvgMuXeYpAY5NXoJcSW/DiduWlRF7Bm5M8X3AE3VK+hU3Ib3EZYWatrGRd9d
         hU0/cOD7ET8SMU2+DLk17dFFzv1hrUfgy0Bax1G+hqhb9tCYqW0Pbpj/3ALnAZEtBq
         B1V0jf2KyKj1suPHOS1nmHTyGFys4XOZB6L6oAqouycgkMElq1TeRmuFRiVd/sWHsP
         x0JVTTDepAAX2XyI0JMlZ6fsVIFC1hh0O2lw9e/P6nV9KUNC3NpEBZ85PtaXqPU1nr
         rx+KvREciQJ3SSOD5AoBMnPsDx4f1p1ajoU5JpiE1wRXhTtiT87pqoAJrNpnl0DsQU
         sqQQk9gm7S7rw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PvQ6k2vpXz6tvw;
        Sun,  9 Apr 2023 10:21:18 +0200 (CEST)
Date:   Sun,  9 Apr 2023 08:21:17 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oded Gabbay <ogabbay@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Marius Zachmann <mail@mariuszachmann.de>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Rudolf Marek <r.marek@assembler.cz>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonas Malaco <jonas@protocubo.io>,
        Aleksandr Mezin <mezin.alexander@gmail.com>,
        Derek John Clark <derekjohn.clark@gmail.com>,
        =?ISO-8859-1?Q?Joaqu=EDn?= Ignacio =?ISO-8859-1?Q?Aramend=EDa?= 
        <samsagax@gmail.com>, Iwona Winiarska <iwona.winiarska@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Walle <michael@walle.cc>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Agathe Porte <agathe.porte@nokia.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@opensource.cirrus.com, openbmc@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 12/68] hwmon: corsair: constify pointers to
 hwmon_channel_info
Message-ID: <20230409102117.6fcdc42f@posteo.net>
In-Reply-To: <20230406203103.3011503-13-krzysztof.kozlowski@linaro.org>
References: <20230406203103.3011503-1-krzysztof.kozlowski@linaro.org>
        <20230406203103.3011503-13-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Apr 2023 22:30:07 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index 2210aa62e3d0..dc24c566d08b 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -571,7 +571,7 @@ static const struct hwmon_ops corsairpsu_hwmon_ops = {
>  	.read_string	= corsairpsu_hwmon_ops_read_string,
>  };
>  
> -static const struct hwmon_channel_info *corsairpsu_info[] = {
> +static const struct hwmon_channel_info * const corsairpsu_info[] = {
>  	HWMON_CHANNEL_INFO(chip,
>  			   HWMON_C_REGISTER_TZ),
>  	HWMON_CHANNEL_INFO(temp,

Wait a minute. Can you at least match it to the coding style of the driver?
A lot of work went into it to keep it consistent.

greetings,
Will
