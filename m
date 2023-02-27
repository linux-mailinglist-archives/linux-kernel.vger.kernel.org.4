Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4886A4432
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjB0OVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjB0OVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:21:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C411117D;
        Mon, 27 Feb 2023 06:21:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DE5AF1FD65;
        Mon, 27 Feb 2023 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677507665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qo1xHDzz0CiE4GJBuWYj9nYsJQEDCtqAEvRS6B7iAe4=;
        b=ewwihNBjmlP04zDaw/bFnkHRxjYxUdPocGZlIdVj1yTYokIzLLeDxoJoZ20HErhiS0KtgL
        zI8eWzp82zHt8bcDYpTqTfnGlfIDyqug/Gy1VHhiIcV6lO933eTv9ID8HxZLA6yqMV1HYV
        //WZKY/w3TEzdd5Lv5xuVIDkViqDh24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677507665;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qo1xHDzz0CiE4GJBuWYj9nYsJQEDCtqAEvRS6B7iAe4=;
        b=eHh9HID6SBfx6LbPpi8zYdzUXHZJTZGDe4wSQW/lgeUSIWPyy72rmc+hsVgDkM+xSNXpsV
        gFqV8WhXtLesqrBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9075313912;
        Mon, 27 Feb 2023 14:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PDSLIVG8/GO/BgAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 27 Feb 2023 14:21:05 +0000
Date:   Mon, 27 Feb 2023 15:21:04 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 15/20] thermal/hwmon: Use the thermal_core.h header
Message-ID: <20230227152104.4f901340@endymion.delvare>
In-Reply-To: <20230226225406.979703-16-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
        <20230226225406.979703-16-daniel.lezcano@linaro.org>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Feb 2023 23:54:01 +0100, Daniel Lezcano wrote:
> The thermal_hwmon is playing with the thermal core code
> internals. Changing the code would be too invasive for now.
> 
> We can consider the thermal_hwmon.c is part of the thermal core code
> as it provides a glue to tie the hwmon and the thermal zones.
> 
> Let's include the thermal_core.h header.
> 
> No functional change intended.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/thermal/thermal_hwmon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index bc02095b314c..c59db17dddd6 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -17,6 +17,7 @@
>  #include <linux/thermal.h>
>  
>  #include "thermal_hwmon.h"
> +#include "thermal_core.h"
>  
>  /* hwmon sys I/F */
>  /* thermal zone devices with the same type share one hwmon device */

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
