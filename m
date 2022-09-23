Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E125E8248
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiIWTDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWTDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:03:06 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7961231E6;
        Fri, 23 Sep 2022 12:03:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b23so976881pfp.9;
        Fri, 23 Sep 2022 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9JjiAxbRKO/Cz1ooxAjo8GsGHxSbPrP4gMRHGvd322w=;
        b=o/qKEZVlLtJisqT+xtfOyv2Yrg6Kag+dmDlK6bT3jhD+QByFikg7uMjqjci/liCZbh
         7WLmI8XBj8M1HuFPe6gsvib4XeEGtprvzHeB7TxnBgQs8qf3LEROMuJJQlTvKRdUTnYK
         Y803BRDa+GBujY5JCFp+EJ/bUgxyfxw6RA/NW8c11rJ+QfsKJNf4Gae97B5IMZoTleFp
         OBq9YyZFeJUAqbIEE7lfvNceOfa5KHVUyleHaQmPBPpkAGXSqsf74Px1a7gYqXD36n8Z
         J9fXKqTEnIyHivA7IM+gcvjTlBODrDPlsDDDHDo42VFIdjxdqOrR4tc9YAYwyHbBc1+5
         QusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9JjiAxbRKO/Cz1ooxAjo8GsGHxSbPrP4gMRHGvd322w=;
        b=x/MVg4yescM3cBS+Whulgdr0tX3MrXh/O0dn15r0Q+mM3fn8lFgEDhmKP8Bf1OipyT
         PdSf51v2+sFvHA9r6b0blFi+P4nQlsbppS5Dx315+jtk3vepVXMGI8dfuTOZlJVUc9/K
         jwXlSEAloxDhNQKU1tyoGh+OYNIoGN3kVAhwbyqrbpT6PBn2pN6VhnaSgEX+skVCx1wy
         5tKd53P889PZKtvGRd7N20ciNp0p6Y14CGfWWhBqgTbkuMp+rUdRda849uOHAMYt7ckY
         lJri7vhDc8EFHSMSfI/seI7Sr3U09/Rgb0PEhw9k6eDgaMplYCisRuscfbYXhccBY19Y
         GegQ==
X-Gm-Message-State: ACrzQf1VRoZ55NRE6oy/o4tEMa0zvGiz9FALjY6RnFNqxZDYj6vUSEhX
        XlmK5WKvx8hVcF90n/l7Nqw=
X-Google-Smtp-Source: AMsMyM4jlylOD9Lp+oDu1pb5GepRaDIZ5CTRE5tUE09EE9UXAHXPl/9bEV/P6Yki0yVvBmAbzgutdw==
X-Received: by 2002:aa7:88d0:0:b0:542:d98d:bf1f with SMTP id k16-20020aa788d0000000b00542d98dbf1fmr10596346pff.78.1663959784052;
        Fri, 23 Sep 2022 12:03:04 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:8b46:be3c:2c54:68a5])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902e74700b001769cfa5cd4sm6469398plf.49.2022.09.23.12.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:03:03 -0700 (PDT)
Date:   Fri, 23 Sep 2022 12:03:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] Input: matrix_keypad - replace header inclusions
 by forward declarations
Message-ID: <Yy4C5HH3yxssLMPh@google.com>
References: <20220923184632.2157-1-andriy.shevchenko@linux.intel.com>
 <20220923184632.2157-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923184632.2157-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
> -#include <linux/of.h>
> +
> +struct device;
> +struct input_dev;

This results in a ton of compile errors. While I believe this change is
a good one, we need to fix users of this include first.

Thanks.

-- 
Dmitry
