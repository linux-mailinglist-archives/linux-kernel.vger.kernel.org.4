Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEB36D68F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjDDQdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjDDQd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:33:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0E91BF3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=OHKZZ1EG3y1uOFLskk086hwVba+C+855Onv5kCrd+4s=; b=SOGAOjGKPLh5z/g9UwfDG9Xq73
        ytrjmBAcp6/fRp6RHV51FzhDI0Gq7VZjd/TJIU8hQnfP1SxcpKehqfugdnFtWATBPQJjCBh8LS7qp
        v4NnpksdUZCgH8I0x/ZIhKnXyY7C5P9elL82hbqWj15dKHHx7Da+/HxD8BMpiD7WJyavRGM3MM7Um
        aizCg/LbjunV+0mUsk/lHoFGlmipEmZ5c0+7TudAJfk7JoNa59YnbyrjuQNtWh9ZIvHXuYzi+RY0c
        8XJgj+cA36s3RaZfbBISj/Bv3d1+gitdo4WYGHhDT5Y3h8nVGlzWSkWu18lAidLChVZM/K45Q4rhP
        hcC+mlZg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjjax-002Dsw-2q;
        Tue, 04 Apr 2023 16:33:19 +0000
Message-ID: <02d3149a-27a1-ac94-45d7-9e8ca67bc73a@infradead.org>
Date:   Tue, 4 Apr 2023 09:33:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND PATCH v2 1/3] iio: Add some kerneldoc for channel types
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-kernel@vger.kernel.org
References: <cover.1680610554.git.mazziesaccount@gmail.com>
 <6cbe49605986fe1b82e4f3d67344e549846c5f6c.1680610554.git.mazziesaccount@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6cbe49605986fe1b82e4f3d67344e549846c5f6c.1680610554.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On 4/4/23 05:24, Matti Vaittinen wrote:
> For occasional contributor like me navigating the IIO channel types and
> modifiers may be a daunting task. One may have hard time finding out
> what type of channel should be used for device data and what units the
> data should be converted.
> 
> There is a great documentation for the sysfs interfaces though. What is
> missing is mapping of the channel types and modifiers to the sysfs
> documentation (and entries in documentation).
> 
> Give a hand to a driver writer by providing some documentation and by
> pointing to the sysfs document from the kernel doc of respective enums.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Changelog RFCv1 => v2:
> - add missing channel type docs provided by Jonathan
> - add @in front of member names and fix typos pointed by Andy
> - drop TODOs as Jonathan clarified the units
> 
> Initial discussion about these docs can be found from:
> https://lore.kernel.org/all/0e0d45b7-e582-82b2-9bac-1f70f9dad9f7@gmail.com/
> ---
>  include/uapi/linux/iio/types.h | 134 +++++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
> 
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index c79f2f046a0b..78f4cfdc5e45 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -11,6 +11,124 @@
>  #ifndef _UAPI_IIO_TYPES_H_
>  #define _UAPI_IIO_TYPES_H_
>  
> +/**
> + * iio_chan_type - Type of data transferred via IIO channel.

    * enum iio_chan_type - ...

as you did in patch 2/3.

> + *
...
> + */
>  enum iio_chan_type {
>  	IIO_VOLTAGE,
>  	IIO_CURRENT,
> @@ -49,6 +167,22 @@ enum iio_chan_type {
>  	IIO_MASSCONCENTRATION,
>  };
>  
> +/**
> + * iio_modifier - accurate class for channel data

Ditto here.

> + *
> + * @IIO_MOD_<X,Y,Z>:	Value represents <X,Y,Z>-axis data.
> + *			Typically used by channels of type:
> + *			IIO_ACCEL, IIO_TEMP, IIO_GRAVITY, IIO_POSITIONRELATIVE,
> + *			IIO_ANGL_VEL, IIO_INCLI, IIO_MAGN
> + * @IIO_MOD_LIGHT_BOTH:	Value contains visible and infrared light components
> + * @IIO_MOD_LIGHT_IR:	Value represents infrared radiation
> + * @IIO_MOD_LIGHT_<RED, GREEN, BLUE>:
> + *			Value represents visible <red, green, blue>  light
> + * @IIO_MOD_LIGHT_CLEAR:	Value represents all visible light frequencies
> + *
> + * Please find the detailed documentation for reported values from the
> + * Documentation/ABI/testing/sysfs-bus-iio.
> + */
>  enum iio_modifier {
>  	IIO_NO_MOD,
>  	IIO_MOD_X,

Thanks.
-- 
~Randy
