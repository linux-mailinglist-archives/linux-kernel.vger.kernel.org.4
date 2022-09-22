Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E715E6EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiIVVsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiIVVsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:48:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B533FF8C35;
        Thu, 22 Sep 2022 14:48:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w13so10068306plp.1;
        Thu, 22 Sep 2022 14:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vFFY3rh84yOuYPuVnI3lRYvTzhLEPqFEznPPwuwFY3M=;
        b=mQYrehBkW0Tp8m8Z92J+sUWuoHaNyKSJGsM63/CbKHcRsyDKdNSeJ0FIyTyvU+hCU5
         kICwerayKtM6cRjpG+iPR2H7kvi+FTeNkS7uqlQjYGuMLRd2ICn0lUVnorO8jlyok8ng
         WEUFogy2xra3ii0ZfvdhERRdNb/H+ObezXLvAQBWAU5Fq0I3PIV3+9jjjny+LA3nUwML
         hbh0LLe06bHG5EKft3uyDA+TfGNJt76Lj3XfZLDxOyQe9NLgL8eISn8QUUI7a60aYqD+
         Ea1zulRIFsTuesGYc4guku+yFDiqOUmveLAcsDeSB/ZpUT25Bm6fnCRDZr/ZUtL9AwZA
         yS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vFFY3rh84yOuYPuVnI3lRYvTzhLEPqFEznPPwuwFY3M=;
        b=5QJl3fyWQ5ZdGF4GyiUx1lRLa7pWlPD6FfAvi1tMs5NlPLxeRX622ki2UGeL009Ecf
         6/eQZbu2z82DZ3VW9qJTrP6WBnhajBUgb2D7iIHx7xtU0+yMt1KqtbNXwo5KcPEYucuO
         BGbiuZWCEkFzeKJWuI6sNU4FwIyQAAuPX6dsHWN2hnfgKiyxGI+mVUuQSWSkzdL37hfM
         /aaDZf4UTBUWB6Ul8svWBIZ/TjmSEZgJoY/GkxQWzm/YCXfwc2TrdExaohTSxq19EySo
         0yX6jUm8uRAlvPvL8mn02kUj5+5HCEQm8mz8OcHexGdJlJMW5PlRcs1zzQx08reQW7ig
         Ah3g==
X-Gm-Message-State: ACrzQf0599jwu8851fA7Ob8t98pxFsZyoQt3bqZp1Kr+/N1r/5fZRNkM
        Vvbs9zjgJfLd+WRahQt2Vzk=
X-Google-Smtp-Source: AMsMyM7Tl5x3qq3rpo9H8vHIvgajXbO3mDq3Rl+jvxpGF1uRvjW0c9A26/fvCDdGQ27LMj3HQvb+Sg==
X-Received: by 2002:a17:902:b7c5:b0:178:a207:d789 with SMTP id v5-20020a170902b7c500b00178a207d789mr5241220plz.70.1663883310074;
        Thu, 22 Sep 2022 14:48:30 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:c558:d894:7bf:3842])
        by smtp.gmail.com with ESMTPSA id cp2-20020a170902e78200b00178b77b7e71sm4478027plb.188.2022.09.22.14.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 14:48:29 -0700 (PDT)
Date:   Thu, 22 Sep 2022 14:48:26 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Get rid of
 devm_fwnode_get_[index_]gpiod_from_child()
Message-ID: <YyzYKmsjKflqT1xZ@google.com>
References: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel, Marek,

On Fri, Sep 02, 2022 at 05:55:24PM -0700, Dmitry Torokhov wrote:
> This drops the last uses of devm_fwnode_get_[index_]gpiod_from_child()
> from the tree and drops the stubs implementing this API on top of
> devm_fwnode_gpiod_get_index().
> 
> Note that the bulk of users were converted in 2019, the couple of LED
> drivers are all that have remained.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> ---
> Dmitry Torokhov (3):
>       leds: gpio: switch to using devm_fwnode_gpiod_get()
>       leds: lgm-sso: switch to using devm_fwnode_gpiod_get()
>       gpiolib: remove devm_fwnode_get_[index_]gpiod_from_child()
> 
>  drivers/leds/blink/leds-lgm-sso.c |  5 ++---
>  drivers/leds/leds-gpio.c          |  5 ++---
>  include/linux/gpio/consumer.h     | 21 ---------------------
>  3 files changed, 4 insertions(+), 27 deletions(-)
> ---
> base-commit: 7fd22855300e693668c3397771b3a2b3948f827a
> change-id: 20220902-get_gpiod_from_child-remove-a62638849e91
> 

Could you please consider picking this up for 6.1? Or would you be OK
with this going through other tree (GPIO maybe)?

Thanks.

-- 
Dmitry
