Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD5E6D3D32
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjDCGR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDCGR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:17:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B38D8
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 23:17:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn12so112795224edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680502674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sPU+k5Dii+Pl5dwm1iVz6jH2SOAHhEPucNsoSGY5PvI=;
        b=PRe6QUC3nR/2OZdR9bXdXcRvsn08hKPaw8sdWaDoplmtW9vqt5OYLYcyO38rKrL/Dn
         nU4Sw1lGkmHh76GjuHzgUycbrA9GkQoSv9Kl5HLTjsNgTUjHoT+oVlEv4dP9WzxOYl6R
         5bO6MExFkFUiEC77LcZsntbHEeVpArDeuekF47tZHrgZ6ok+xbVLiPlWzSX/7oKlnu98
         VIPnsdMK5TzEw5P7J5KGX2xXTdTqv4VOEcmRxyN8PJ8GcWRT7KxXRzvkFk5ZoM4kHC0X
         15fSd9ecTmlp5wm0mSzdVC8vDPX61hybelW+V/YLEi8g95WCws5a7BS3YLjG747Oa/cd
         O6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680502674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPU+k5Dii+Pl5dwm1iVz6jH2SOAHhEPucNsoSGY5PvI=;
        b=wvGFa4zlbFZphCVB/ivRHqwEB9uUXy3LAfB/v8S3+dWrfsIQKo9RryBMe6b60tOILL
         YCnQKWKseNeA01tJ+pQbbjwsbm7cpZc79Oaspw/T+kNRyASP6mpQNEtm4XsMKxg7IQwQ
         yeHZ3ZU6w8HQwGZCO6BV4Tbpva1wGYHgYamTvqMqy7WMfdPgy2/NENo+o/QFlaYntma9
         6ajsV79lCsPs6amc5nKoGkOXPqqAwbbcO9Jdx3fcEMs8V95SNwpYvQ9iEkeskyrKObDK
         Eq5nmVJ8mHTlamcQRM6jxnpTpFipto/PBu1Sv6SrByquRxtaLoMEa4Fpmdik+BQ7DuzK
         7r6w==
X-Gm-Message-State: AAQBX9eHdvOXIQO2mbu3+R+ldspEjH+C8IzINY6+F1JAj2JoKB3kt38N
        5YCpKIELWxIELTJ6fwQW8Fw=
X-Google-Smtp-Source: AKy350YHSbxzegcW2mkTpFZYnRIASQMU5daFkaJAvd++9Zrz/s2TZQaQYfadfF9e+ePuR/fXgHUcew==
X-Received: by 2002:a05:6402:2693:b0:4bc:edde:150d with SMTP id w19-20020a056402269300b004bcedde150dmr16404444edd.0.1680502674566;
        Sun, 02 Apr 2023 23:17:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f24-20020a50a6d8000000b004acbda55f6bsm4108176edc.27.2023.04.02.23.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 23:17:54 -0700 (PDT)
Date:   Mon, 3 Apr 2023 09:17:51 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: remove typedef declaration for
 cvmx_fau_op_size
Message-ID: <ef806781-72b1-457b-bb01-570c8145ab41@kili.mountain>
References: <20230401212002.GA30519@koolguy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401212002.GA30519@koolguy>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 11:20:02PM +0200, Dalvin-Ehinoma Noah Aiguobas wrote:
> Fix checkpatch.pl warning: do not add new typedefs in
> drivers/staging/octeon/octeon-stubs.h:216
> 
> Signed-off-by: Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
> ---
>  drivers/staging/octeon/octeon-stubs.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> index 3e7b92cd2e35..cf560c321c92 100644
> --- a/drivers/staging/octeon/octeon-stubs.h
> +++ b/drivers/staging/octeon/octeon-stubs.h
> @@ -213,12 +213,12 @@ enum cvmx_fau_op_size {
>  	CVMX_FAU_OP_SIZE_64 = 3
>  };
>  
> -typedef enum {
> +enum cvmx_spi_mode_t {

The _t means typedef and it isn't a typedef now.  Change the name to
"cvmx_spi_mode".

>  	CVMX_SPI_MODE_UNKNOWN = 0,
>  	CVMX_SPI_MODE_TX_HALFPLEX = 1,
>  	CVMX_SPI_MODE_RX_HALFPLEX = 2,
>  	CVMX_SPI_MODE_DUPLEX = 3
> -} cvmx_spi_mode_t;
> +};

regards,
dan carpenter

