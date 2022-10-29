Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558C56123E4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJ2OZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJ2OZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:25:55 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6302C5D893;
        Sat, 29 Oct 2022 07:25:54 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id s125so8447176oib.6;
        Sat, 29 Oct 2022 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMYFDz08Ce9/jRfepwkxAzuYEo0BVPk0VR2KWcLfiGo=;
        b=DZ0ESldL2rqqkFuDsKJGFgHzLVsaEvRJp2vgrdiUX/WtNUmceTDMtSJ3xr2WUNXIDB
         2S/K9sU5s9lIXzCMXX7hc/ci/KnGnJl4rkVgdbIWOVSkuKy4FSQ7aHPEZv8W+DyotQoO
         EfqSOlgrePpeK8iDrn9C5N2gVraWVI/VLh9ffEGl+yt8DAZqX40OUL870qeSWLxwl4nu
         +Kp5+rA2kyU/8kCxWhyahmyRFhvQSAQjyOskfpz8+0+jqHlS1lkf1cdURMRIKTp3zmFu
         RbZERw9/WGfW20faBruO0PO+Gm/nCc65D/z9+Eu2ZD2kRAOlhK2UpkdszHs04JlMzCQI
         D8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMYFDz08Ce9/jRfepwkxAzuYEo0BVPk0VR2KWcLfiGo=;
        b=5huqrvERA4CRUtR0p+2OsNdiJBRiaZvE5+JwzbqxazYwwAMAPGFXxA4VcODUwcChIM
         VH2NRNrR8//54F8p2QN4NhvIQGNEyayX/yYy5b/79z66SgfHkwMRKdaTtnG53W1nCv0i
         9safofypwMBAYzvTaZfmCTkkQh3DZNiF1oFki/imJn755qhBW5DED3vWzE3pOp+X9vwm
         cAUa77M4ZC+qUAEKrpXxglEh1O2U3TDsGD+fDt2qPQjJcklFihRDcRoLq3bOAb+k3Xls
         oAnQbxD9JggMSv66gfiC47hVHqzDih7Araz3xo06rTvPMUMPrvFa++CG7GWkwyFieaXm
         cEUg==
X-Gm-Message-State: ACrzQf0mST0fFtCqkw6qF+rS+jiedmCbwNO/SgfWII3DIohwCp9UG92R
        Hwxi+yuF/8JA/Zw5LtQvsic=
X-Google-Smtp-Source: AMsMyM4tp/nbsxga2wOQW9kCwuQcA7i+NwV1WRSMmCwasbE9TcDoXWlB4bKdlgVB8ARPBgAanTNavA==
X-Received: by 2002:aca:d886:0:b0:357:5bb6:bd with SMTP id p128-20020acad886000000b003575bb600bdmr2189491oig.8.1667053553785;
        Sat, 29 Oct 2022 07:25:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o4-20020acabe04000000b0035494c1202csm549601oif.42.2022.10.29.07.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 07:25:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 29 Oct 2022 07:25:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 2/2] Input: matrix_keypad - replace header inclusions
 by forward declarations
Message-ID: <20221029142551.GA3222119@roeck-us.net>
References: <20220923184632.2157-1-andriy.shevchenko@linux.intel.com>
 <20220923184632.2157-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923184632.2157-2-andriy.shevchenko@linux.intel.com>
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

On Fri, Sep 23, 2022 at 09:46:32PM +0300, Andy Shevchenko wrote:
> When the data structure is only referred by pointer, compiler may not need
> to see the contents of the data type. Thus, we may replace header inclusions
> by respective forward declarations.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/input/matrix_keypad.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
> index 9476768c3b90..b8d8d69eba29 100644
> --- a/include/linux/input/matrix_keypad.h
> +++ b/include/linux/input/matrix_keypad.h
> @@ -3,8 +3,9 @@
>  #define _MATRIX_KEYPAD_H
>  
>  #include <linux/types.h>
> -#include <linux/input.h>

Possibly, but may other drivers rely on those includes.
This results in widespread build failures such as

Building arm:allmodconfig ... failed
--------------
Error log:
In file included from include/linux/input/samsung-keypad.h:12,
                 from arch/arm/mach-s3c/keypad.h:12,
                 from arch/arm/mach-s3c/mach-crag6410.c:57:
arch/arm/mach-s3c/mach-crag6410.c:183:19: error: 'KEY_VOLUMEUP' undeclared here

Guenter
