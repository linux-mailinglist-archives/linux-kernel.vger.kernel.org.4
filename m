Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BDA5BA69F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiIPGLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIPGLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:11:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26590A1D59
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:11:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r18so47077232eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=T4Qlm7+uR9SVFbfB41B8xYIH44tr4UFSZKNZe5dH1tA=;
        b=qFW3354HCkHmvxiBRd9HSllHtOFfYEepdnPyBxxjMJ/SJZdnkYXZlNaB3Fpl96Wkie
         wsBBvLmpN4EdvoiUJM+Z3rrPFiFBRUssIxOuTi+ye9Ct4PH++XVjbR+uapgtehwVjeul
         KQAxkYM+z6wb5p5OFVzETof/2MCNPjFwKSzma4+IIcDeysVtuyvY1Sq0OHqaPQorXhKH
         1WfCoOayGLeZibSGCjtzaR1U1oCItW3tLAnFYgV+jyKrr87+RayzGnOS0rI8uTawBL1j
         6syh/by9BqWfJOrgpA+7ZEB95smNsTnUVHmFeu7h+e/pA9EQ3bSNfTiz+7oa/nTxtbE3
         AVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=T4Qlm7+uR9SVFbfB41B8xYIH44tr4UFSZKNZe5dH1tA=;
        b=pOmLAraT+W8tqmZSXCwrerCq2XoaEjBXR1ko0smPv1yBifY2qz69y9Da6XlUB9B6AZ
         GGeypQYBX+A+hW8JeVHvAlTDk36qOIcGkUf4qVDgC188FNYFSi5IK6N85Omi0RDx2ozM
         jwOMSlSILFBLL5BQxyjbQ8bQzmkkk2/PKNAfvW/JlxC8/02kREZ0WFAfj2brYU6lju+g
         Fi+Get8Cwb2TuQTkd6irjtnDJqpHmFPBiS3+wj2KwMi1udadX26kb30l8tSG/juKuyhj
         4+0gHYSbOSh/BMHlkDhw67XH0OLtkzNzR/dFslNYyMdWXhL06NfnElDAQgl5ftAdvfU4
         MuwA==
X-Gm-Message-State: ACrzQf1uZHvJ84Zq2fdIQT+wXPuK0XbZvkGERcOn0MI0/nKT7CBzsr/d
        /zVB80BD3By37MlZzLkd8N5tFUS3iA==
X-Google-Smtp-Source: AMsMyM4aPZnhtH5GGlYP0SOulV2FpitaZP2NAb5dcb5MLBDxacUphrRLGsK6Hxvis2p9jIXN7GiuGQ==
X-Received: by 2002:a17:907:3fa1:b0:77b:6f08:a2f9 with SMTP id hr33-20020a1709073fa100b0077b6f08a2f9mr2485319ejc.52.1663308701382;
        Thu, 15 Sep 2022 23:11:41 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.126])
        by smtp.gmail.com with ESMTPSA id x20-20020a170906299400b0074a82932e3bsm9990983eje.77.2022.09.15.23.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 23:11:40 -0700 (PDT)
Date:   Fri, 16 Sep 2022 09:11:37 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     yangyicong@hisilicon.com, viro@zeniv.linux.org.uk,
        jonnyc@amazon.com, hhhawa@amazon.com, andriy.shevchenko@intel.com,
        farbere@amazon.com, akpm@linux-foundation.org
Subject: Re: + libfs-fix-error-format-in-simple_attr_write.patch added to
 mm-nonmm-unstable branch
Message-ID: <YyQTmZG/tNWd/ErO@localhost.localdomain>
References: <20220915213426.3BC15C433D6@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220915213426.3BC15C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 02:34:25PM -0700, Andrew Morton wrote:
>      libfs-fix-error-format-in-simple_attr_write.patch

> From: Eliav Farber <farbere@amazon.com>
> Subject: libfs: fix error format in simple_attr_write()
> Date: Thu, 15 Sep 2022 09:15:44 +0000
> 
> In commit 488dac0c9237 ("libfs: fix error cast of negative value in
> simple_attr_write()"), simple_attr_write() was changed to use kstrtoull()
> instead of simple_strtoll() to convert a string got from a user.  A user
> trying to set a negative value will get an error.
> 
> This is wrong since it breaks all the places that use
> DEFINE_DEBUGFS_ATTRIBUTE() with format of a signed integer.
> 
> For the record there are 43 current users of signed integer which are
> likely to be effected by this:
> 
> $ git grep -n -A1 -w DEFINE_DEBUGFS_ATTRIBUTE | grep ');' |
> sed 's,.*\(".*%.*"\).*,\1,' | sort | uniq -c
>   1 "%08llx\n"
>   5 "0x%016llx\n"
>   5 "0x%02llx\n"
>   5 "0x%04llx\n"
>  13 "0x%08llx\n"
>   1 "0x%4.4llx\n"
>   3 "0x%.4llx\n"
>   4 "0x%llx\n"
>   1 "%1lld\n"
>  40 "%lld\n"
>   2 "%lli\n"
> 129 "%llu\n"
>   1 "%#llx\n"
>   2 "%llx\n"
> 
> u64 is not an issue for negative numbers.
> The %lld and %llu in any case are for 64-bit value, representing it as
> unsigned simplifies the generic code, but it doesn't mean we can't keep
> their signed value if we know that.
> 
> This change uses sscanf() to fix the problem since it does the conversion
> based on the supplied format string.

> --- a/fs/libfs.c~libfs-fix-error-format-in-simple_attr_write
> +++ a/fs/libfs.c
> @@ -1017,9 +1017,12 @@ ssize_t simple_attr_write(struct file *f
>  		goto out;
>  
>  	attr->set_buf[size] = '\0';
> -	ret = kstrtoull(attr->set_buf, 0, &val);
> -	if (ret)
> +	ret = sscanf(attr->set_buf, attr->fmt, &val);
> +	if (ret != 1) {
> +		ret = -EINVAL;
>  		goto out;
> +	}
> +
>  	ret = attr->set(attr->data, val);
>  	if (ret == 0)
>  		ret = len; /* on success, claim we got the whole input */

No scanf please. Just revert original patch if something broke.

scanf may be tolerable if it is just one format conversion but it is
disaster as an interface.
