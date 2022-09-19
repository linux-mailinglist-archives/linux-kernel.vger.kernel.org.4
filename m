Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE745BCCF2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiISNVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiISNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:21:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88F92AC40;
        Mon, 19 Sep 2022 06:21:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id go6so23628596pjb.2;
        Mon, 19 Sep 2022 06:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=c8v0pPudaUHOGb5I2xZD2DLK0qhvam3p8jSwE8ThuxQ=;
        b=XYXkSI7bxLac+lREwMvrejiDVqiWZ5B5iDCwYZOnP2XqwBvCz7q3IB7wF6bsiXBGNH
         GXpVCKdTUndXBgxDZLQRVtYph3Cukvl6oAvZpSOjyq8Vqlt6zpEXK0ZRm+jtQEbjadCT
         wY0Vssx9U1mJybzBvq+rLtS8oCiTacaIxxTpwY3dK+U0xI9jv1dHc0pMW7Umdyrh1cWe
         n479okBb/sf84RGB/bPAWQoElOFOo9MP3snvjrbRpKAHPFxqgbBlcQ3ihQ0C7ymuJFoC
         gU1x30reXLcF8/fxfj+/0DuHqvtTZaizD623RzZOSxOyvWP0TomsRYLgrVjrQ9L37kX3
         iv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=c8v0pPudaUHOGb5I2xZD2DLK0qhvam3p8jSwE8ThuxQ=;
        b=UoRIeinPyVNWZfJ5vhm7jCwtQSCNynJepFRM/gJIphNyTwVQcBsq4GyYeVeRVbALUV
         GfA7n72EmeG2nhvlpnv9npEphJ8gJyKAWfKkZke2jAEBMmi2W/qz9R9RMm7JCnV7dbwf
         oiqfyLYjypkfKqEdUx5crd+Ism8MXWZYnoSBs2td5K81Vw53MeGOJlLh6ibpKDewyUzH
         Qmy8S+nyHLnod8rgQhEjP+CRPZ3Xg0Qg6y0ovjG6yJ15aN4OnOB4ozEZ9BKeIQl2pcE0
         iiRBpinmzFjJGKN135+KdcZw7sJQJURBZLJr1Lc8q2kGu6jxk2RSba8jcHprwW4v0IpW
         s88Q==
X-Gm-Message-State: ACrzQf3P+tBgSiIPo45pYZxpIOf7uMZCHwYqyuzitOzFzRKx9ATb70fX
        YYX3YrzJsLlVmAXkL8bg9FN2uEuBPx+JpQ==
X-Google-Smtp-Source: AMsMyM4EJrhrGddvxF/FAJ4cHz1mqUF6lsivsf3R3vfOYiuZwSxQoaSxFwzO1283xJ0k8nvNopOCNw==
X-Received: by 2002:a17:90a:f291:b0:200:acc9:422d with SMTP id fs17-20020a17090af29100b00200acc9422dmr29722908pjb.21.1663593685682;
        Mon, 19 Sep 2022 06:21:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902710200b00172f4835f60sm20540908pll.189.2022.09.19.06.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:21:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 06:21:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, andriy.shevchenko@intel.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hhhawa@amazon.com, jonnyc@amazon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 19/21] hwmon: (mr75203) parse temperature coefficients
 from device-tree
Message-ID: <20220919132124.GA3547396@roeck-us.net>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-20-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-20-farbere@amazon.com>
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

On Thu, Sep 08, 2022 at 03:24:47PM +0000, Eliav Farber wrote:
> Use thermal coefficients from the device tree if they exist.
> Otherwise, use default values according to the series (5 or 6).
> All coefficients can be used or only part of them.
> 
> The coefficients shall be used for fine tuning the default values since
> coefficients can vary between product and product.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to hwmon-next.

Thanks,
Guenter
