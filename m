Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2202B6B6A07
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjCLSXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjCLSW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:22:56 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA85062DB0;
        Sun, 12 Mar 2023 11:15:35 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id j6so1460493ilr.7;
        Sun, 12 Mar 2023 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678644828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBhKFNngoMDbvwNSzDNWcaqW697xKA6lIAPdNAaMhoc=;
        b=kI4NParOZ+lhNFAKR9Lep/1F+OTIJ3v6HotVPYQuM4JoQIAB04A76/fY7UTPklNHHb
         Go7AdPhDzXG1rUa1+qjsAGAoeGo4vTrDPhWfLTGRgpCJFwd5tGyU1VjwE869/x8H/BGF
         Vzpe0oCB57UCM9icLk4TmB22T+FG9T62OQLiW7wHcSoXOR6Lx/roASCJ1fdGox0+GJhZ
         9XBZ5rRKKkwW1RdEGBQhw0Q4ituU4w+wpntOaXIsBBLhQXNTBQyKqsg7VF8olrFXImrw
         yJomMoyCeUyisHOV7HyLdpmkaZZp3AMbdzs4GZYjOLnp8vMa+3sdBcdf4Vg1EnHHRlNH
         XUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678644828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBhKFNngoMDbvwNSzDNWcaqW697xKA6lIAPdNAaMhoc=;
        b=gaz5qi0UNwBgrOiX5CEbwEERUy7nGoFTfbW3wYAT/BRPnBooUJuUA4WtQ9QN798wp3
         wIExh3LtQxCwiUKN6lOcFrk2HLAY6IZMA/M8sAUrFUXhic/WEi5ekRWfbKKhLA0Wwitq
         r+uCJFV5lJNui9IpHRw2H2pw7/bxEBE2RcRrJ1N1zg9B1M17d6as2OWB6M9BDgiN3XRG
         t8wrcj2M+XkYDgoEfjuk9O5FQubECRlL0MuXIL/KS9pD4FrXiURtv+0RspESh7tWdHJu
         IfHFWK9GKXe5DHe6Wp/WkN/amapznemaMABYxWlqHKj0E/eJKpsxzl9MBOemsvf+qwOD
         Zm+w==
X-Gm-Message-State: AO0yUKXFudSbLq/Atr6IFoadCpJ/lZfU76oI0luQq9FHS4FZ/afewCwR
        dxIiJu0eAVOBqUw+l0qRxboLaVZTpN0=
X-Google-Smtp-Source: AK7set99eaB/tOAx9oetZS2Nd1lbb9Y4DcLSn1B/yluPn08tKQ8xgbuLL+TQoffPZDaHwu8q1LlAOA==
X-Received: by 2002:aca:220a:0:b0:384:8b17:3796 with SMTP id b10-20020aca220a000000b003848b173796mr13893632oic.11.1678643998867;
        Sun, 12 Mar 2023 10:59:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j65-20020acab944000000b0037d74967ef6sm2278346oif.44.2023.03.12.10.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:59:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 10:59:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: hwmon: sysfs-interface: Fix stray colon
Message-ID: <e12555cc-1816-4a31-b4b4-4d07c7db4960@roeck-us.net>
References: <20230312155714.17290-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312155714.17290-1-stefan.wahren@i2se.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 04:57:14PM +0100, Stefan Wahren wrote:
> The commit 036d6a4e75c9 ("ABI: sysfs-class-hwmon: add ABI documentation
> for it") moved all ABI attributes to the usual ABI documentation. But this
> change left a stray colon for the fan speed control method. Fix this
> to avoid a confusion of readers.
> 
> Fixes: 036d6a4e75c9 ("ABI: sysfs-class-hwmon: add ABI documentation for it")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/sysfs-interface.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface.rst b/Documentation/hwmon/sysfs-interface.rst
> index 209626fb2405..f76e9f8cc1ad 100644
> --- a/Documentation/hwmon/sysfs-interface.rst
> +++ b/Documentation/hwmon/sysfs-interface.rst
> @@ -201,7 +201,7 @@ PWM
>  		Pulse width modulation fan control.
>  
>  `pwm[1-*]_enable`
> -		Fan speed control method:
> +		Fan speed control method.
>  
>  `pwm[1-*]_mode`
>  		direct current or pulse-width modulation.
