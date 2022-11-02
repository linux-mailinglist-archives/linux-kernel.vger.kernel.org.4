Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F039616D2D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiKBSup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiKBSud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:50:33 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB5D22505;
        Wed,  2 Nov 2022 11:50:32 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n186so2816735oih.7;
        Wed, 02 Nov 2022 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkro2mEfGgqHjQSLdYSXtUVFZaecXrTiFKLF9xcuNAE=;
        b=Q5Qgebhy//4ker67ANEAwkDUXvofa0yQUoqJGlJPVx1fnaFF1FPTNBKM6p5vW+g7ul
         Fnn/KOThwp+dGjE9aqlX/NONFGzYYMvAGZr0YP8jlrdbX512iIZG30ODmNWjPvpqOStY
         D8On9qPHLh4IZ/uLfSuqP6qEbftBvCek6EBwirP+NS+8Q/eW0NYCRmWOyzBAxaQKGx97
         tUbcvNJuwBpR2bDe13W6cPOfRsqNtGyKTk0w/teKazhChHylKMyixQPrk2bbuf3Gh3zR
         CDoiNx7CdMrTdLKkNQ+RjYgPnNDC54Sp7g+n83jti6sNO7ko9qLhBYQPsyFN1x6ZHkRw
         ap2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkro2mEfGgqHjQSLdYSXtUVFZaecXrTiFKLF9xcuNAE=;
        b=gREXqxW3a0TW/YYZfsysF9MFGFN/aY2x6iuOPPgZ/gjR5XbIHVdzZKsZDsNYp19Bmv
         nyxwjGeHE1xcUhA3JeQpA+rxt+TnrOzxKb14CdLXGbl6aONENcLLhMNAY2sQW7uvaws8
         NCQ9UekjqI0aG8UPyBPpQOm0e3qZTyeUkBe+z8x1t8swaZ+REt+xWy9nNgx6A36CV1r1
         DjWzKL+GUaXQktoLQFuvVLfsNeykmMIkt/XZpAkZwcSzGZ/UIMRWXE55eQBm7jM9iexe
         ku3XCaQlzYyMlkj4j1VeY+rHcUB0A3gepSWemdQiVxxdafKVHZVg6JcTVE4/SYLKUAW4
         UZ0Q==
X-Gm-Message-State: ACrzQf2Ki6mHqd8BKiwnd/5c/rDB70HV5SZIsVbOcRHXBmWTjbhUK6pi
        FbV5Yw+nqcWCN8xEXqUQqSo=
X-Google-Smtp-Source: AMsMyM4wRjOrLkZkv0Wsv4fSrtftM2IOJS3YQdgCg/XxQIIq/516uB1XZxhl0G7ZD+y8CqcqDNXoGA==
X-Received: by 2002:aca:c088:0:b0:35a:436c:39de with SMTP id q130-20020acac088000000b0035a436c39demr1579444oif.290.1667415032177;
        Wed, 02 Nov 2022 11:50:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bl8-20020a056808308800b0035028730c90sm4798536oib.1.2022.11.02.11.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:50:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Nov 2022 11:50:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] thermal/core: Protect thermal device operations
 against removal
Message-ID: <20221102185030.GA2026081@roeck-us.net>
References: <20221017130910.2307118-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017130910.2307118-1-linux@roeck-us.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 17, 2022 at 06:09:01AM -0700, Guenter Roeck wrote:
> Accesses to thermal zones, and with it to thermal zone device operations,
> are still possible after the thermal zone device has been unregistered.
> For example, thermal_zone_get_temp() can be called from temp_show()
> in thermal_sysfs.c if the sysfs attribute was opened before the thermal
> device was unregistered. This is problematic and may result in crashes
> since the operations data structure and the underlying code may be gone
> when the calls are made.
> 
> The following series solves the problem by protecting accesses to thermal
> device operations with the thermal device mutex, and by verifying that the
> thermal device is still registered after the mutex has been acquired.
> 
> This was previously sent as RFC/RFT as single patch [1]. The code was reworked
> to match thermal subsystem changes made between v6.0 and v6.1, and it was
> split into several patches to simplify review.
> 

Any thoughts / comments / feedback on this series ?

Thanks,
Guenter

> [1] https://lore.kernel.org/linux-pm/20221004033936.1047691-1-linux@roeck-us.net/
> 
> ----------------------------------------------------------------
> Guenter Roeck (9):
>       thermal/core: Destroy thermal zone device mutex in release function
>       thermal/core: Delete device under thermal device zone lock
>       thermal/core: Ensure that thermal device is registered in thermal_zone_get_temp
>       thermal/core: Move parameter validation from __thermal_zone_get_temp to thermal_zone_get_temp
>       thermal/core: Introduce locked version of thermal_zone_device_update
>       thermal/core: Protect hwmon accesses to thermal operations with thermal zone mutex
>       thermal/core: Protect sysfs accesses to thermal operations with thermal zone mutex
>       thermal/core: Remove thermal_zone_set_trips()
>       thermal/core: Protect thermal device operations against thermal device removal
> 
>  drivers/thermal/thermal_core.c    | 76 ++++++++++++++++++++++++--------------
>  drivers/thermal/thermal_core.h    |  3 +-
>  drivers/thermal/thermal_helpers.c | 65 ++++++++++++++++++++++-----------
>  drivers/thermal/thermal_hwmon.c   | 14 +++++--
>  drivers/thermal/thermal_sysfs.c   | 77 +++++++++++++++++++++++++++++++++------
>  5 files changed, 169 insertions(+), 66 deletions(-)
