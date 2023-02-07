Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA0768DF8B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjBGSC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBGSC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:02:58 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B49199DE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:02:56 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id v1so2305629ilg.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bUQ+Q0O4InpaxQsTYmk72fYT5UIvjG/Pm2uUP+Phbwk=;
        b=JGHoYL40Z6fjjUrLtEJSGnhqJ5HXvZqZ45pUm+86mk1oyvSMIQ6hL2kSeRAqxRs686
         rMOxQaQhOIUbvArfmOgeHG/va2KZMhBxe88CJ/UDb5mK5zau+L4jSNjKHn/N4rrHR7sL
         xaT6BSBIOSA5nNoJ9b6EHgzgrFronLQpS8Pdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUQ+Q0O4InpaxQsTYmk72fYT5UIvjG/Pm2uUP+Phbwk=;
        b=mgs4zYh2u2I+yQaNxnT5Xz9ag26MuOsrLIWKwy/tioBNYMkmWIy3dYome9PmfDTHXr
         NpENlOjvDtYM/NKm4Uxs+Glw/KTbxUSLLd3RxtWqgTarPQrpInfHPrQTjsY9NVYsfWbO
         QWSlVXaPBv84ZbZXYvxIFzO9N4wEU1okRfJHAQvt9HXHzZlqKOGUCj9kb4us8DNSS4vz
         fS2yGAXvif8rzpp6YdPI8vRwto2oxc1tQJRUFMLeZmmDNENA4OmdcT4Z035NavvBiTK6
         n3ji4awDvcU0beyCGANK1y8b4RXN7xKQ4Py2vhH6bXjp0F8un7CwjWBokQvgGfVFz+I3
         EdDQ==
X-Gm-Message-State: AO0yUKVbajCXcu9MkL9d51MXkDUltpic4Xf4OBp3Ah3L7szMX56Ju5zw
        yvyd8gfli9Mipc+Yxul6SaVjBg==
X-Google-Smtp-Source: AK7set+Gs5sMZkpCEn+J2Ws04h4s1CYRJPvjEKEvzqVHSPh/cEtUPPOERE1fGdpKjwzCw+QLP5RncQ==
X-Received: by 2002:a05:6e02:1be8:b0:313:cd79:adcb with SMTP id y8-20020a056e021be800b00313cd79adcbmr4889037ilv.18.1675792975934;
        Tue, 07 Feb 2023 10:02:55 -0800 (PST)
Received: from chromium.org ([2a00:79e1:abc:1702:24:af62:de72:11ae])
        by smtp.gmail.com with ESMTPSA id q15-20020a02cf0f000000b0038a6ae38ceasm4647885jar.26.2023.02.07.10.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:02:55 -0800 (PST)
Date:   Tue, 7 Feb 2023 11:02:52 -0700
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julius Werner <jwerner@chromium.org>,
        David Gow <davidgow@google.com>,
        chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: coreboot: Remove GOOGLE_COREBOOT_TABLE_ACPI/OF
 Kconfig entries
Message-ID: <Y+KSTG92TtFK4PQm@chromium.org>
References: <20230207081130.1.I657776750156793721efa247ce6293445137bc8a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207081130.1.I657776750156793721efa247ce6293445137bc8a@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-07 at 08:12 -0800, Douglas Anderson wrote:
> Ever since commit a28aad66da8b ("firmware: coreboot: Collapse platform
> drivers into bus core") the Kconfig entries GOOGLE_COREBOOT_TABLE_OF
> and GOOGLE_COREBOOT_TABLE_ACPI have been dead. They have no "help"
> text and thus aren't user choosable. They also aren't "select"ed by
> anything. They also control the compilation of no code.
> 
> Let's remove them.
> 
> Fixes: a28aad66da8b ("firmware: coreboot: Collapse platform drivers into bus core")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Jack Rosenthal <jrosenth@chromium.org>

> ---
> 
>  drivers/firmware/google/Kconfig | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
> index 9f190eab43ed..1bc7cbf2f65d 100644
> --- a/drivers/firmware/google/Kconfig
> +++ b/drivers/firmware/google/Kconfig
> @@ -44,14 +44,6 @@ config GOOGLE_COREBOOT_TABLE
>  	  device tree node /firmware/coreboot.
>  	  If unsure say N.
>  
> -config GOOGLE_COREBOOT_TABLE_ACPI
> -	tristate
> -	select GOOGLE_COREBOOT_TABLE
> -
> -config GOOGLE_COREBOOT_TABLE_OF
> -	tristate
> -	select GOOGLE_COREBOOT_TABLE
> -
>  config GOOGLE_MEMCONSOLE
>  	tristate
>  	depends on GOOGLE_MEMCONSOLE_X86_LEGACY || GOOGLE_MEMCONSOLE_COREBOOT
> -- 
> 2.39.1.519.gcb327c4b5f-goog
> 
