Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7488369E7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBUShm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBUShj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:37:39 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823CFD;
        Tue, 21 Feb 2023 10:37:34 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e10so2150262ilu.4;
        Tue, 21 Feb 2023 10:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDKdFfMckTVPhjv2RYXqg2o5W2mzsKTKPjeXzQMcsDk=;
        b=P7WlENnHLWHn9WkAgRfC0KOOEcp1e5g8Oow5qF02P3MI1ALPAE2pJmzGMBBJ+dg6Cx
         hECVPyX9d1uoA9f5BM5AA+u+2M9r8mfF6LImqnYPSfKVz8KwPPv1FxRGtHBJ0VdR2hFb
         JfOZbo5YoYqLF445lgvdna34fvyv4NtYrcAAr385NYOUsa3AWj4fbP7eNzRhAlwaZrce
         y+cMNChsPOPb60opuSnAlOSa6YfjQYEpQIcF8WIXnee2mCz7kvGPodkuaTvi/zQVPxb9
         m4E3SoZKfqA8orHV3OCh/vjFoU/et34QVo1R4/tCVShXaLGeHZCXG/6zlWEKMW03O7EI
         uTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDKdFfMckTVPhjv2RYXqg2o5W2mzsKTKPjeXzQMcsDk=;
        b=WaPAgUzhMDtnZRH/azNxTIJSim0oX86VNeGwgLqJwUG+0jkCDvPepImIWyG84xZ+wq
         nZlaC72DexnAfzi9VWyvSt9JDa0YeA68yiC4M9fSv5nJsmQY1JBTu0MAhZD7No7NRw+y
         Kl9Sqq6khwpL6NLtgFhjCr2j567xrT0BCsHESrstJrtW+cYNnoJ1wyPzHbNPPddUajMz
         5Oyg5vzPumVy1qQ9tFziTpkHpePupNvVgKvPssI2UXJpDJPtKjBNU4V8zK3hXObT8V0v
         /Udy/6z2GW87s3imFtxu+FN3CpFNHT9liCAtKZ3fe5vy4PRRZWnmk81l3UnO0HiQ0g6r
         stIg==
X-Gm-Message-State: AO0yUKXUA42FJ0cYyf4zJ9nUsVeqRCdoqvLNgRqDtXYs6avNHcXBlAoF
        qB5AIRXNXdDv3g3QDMhc8y0729OASpU=
X-Google-Smtp-Source: AK7set8jCsQBtIRn5GPmTglMopkDBMQZUIZxvDW5n+RtcDg4CK4l2oKtA2gUFXvACcR9jriWz6wIeg==
X-Received: by 2002:a92:1a0a:0:b0:316:b0b2:bf26 with SMTP id a10-20020a921a0a000000b00316b0b2bf26mr5530025ila.28.1677004653877;
        Tue, 21 Feb 2023 10:37:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f23-20020a02b797000000b003b0bd93117esm1338839jam.40.2023.02.21.10.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:37:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Feb 2023 10:37:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 11/16] thermal/hwmon: Use the thermal_core.h header
Message-ID: <20230221183731.GA1606246@roeck-us.net>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
 <20230221180710.2781027-12-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221180710.2781027-12-daniel.lezcano@linaro.org>
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

On Tue, Feb 21, 2023 at 07:07:05PM +0100, Daniel Lezcano wrote:
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

Acked-by: Guenter Roeck <linux@roeck-us.net>

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
> -- 
> 2.34.1
> 
