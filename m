Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10E26120F4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJ2HUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2HUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:20:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9C846D94
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:20:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b185so6582121pfb.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ss9mHb7Up4WJPG174BroMQ/rFUMxSmAvI9HWcoDXYeI=;
        b=lfDRgG4gcFVjPXy6WNAXfQOcZUwQLCRZzSVWisL6fGMaIBSiyE00C6zMO1EvlHZgv2
         0tHmkWcODvxiSRdK9Ax1/zGgaWNYudHsoleWrPIRDTNCFZ+Jb/nmrjqTpg/xO2e8YFz5
         8837MWqCeZonLNzlfWlRAuQAViIMtdkMad8wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss9mHb7Up4WJPG174BroMQ/rFUMxSmAvI9HWcoDXYeI=;
        b=TWOjNhp77jvaQfwapRfHwZkVzKuIz4T4ij0GALD2PN7F+iuC08fnuyYnSRwsssfms+
         SBRm63SdMtPpW5/EWIFBuqFcAitp4aLUzzcuPPGj6GLyyR66d/iXhBM2JjV05hHRvY5X
         /NT7rArDO5VV+qh4wfiXjBoPvZOzDe6CKumnLJ7SW68CLsJbF/1Iol24HpJ1T0/QFcNy
         kZad5A5WLnZPPOgWebL7m1NQwSwzIgOA9pMwARmapGGJd2QIoDwWIMBsOUBCkrtZHpzy
         fuowjbzBQeJWcwg/0VQyAiGkTk+jeO3eWenfrKwB3WW0jlYUh86j8GVk/05BriMc6z/7
         8/sw==
X-Gm-Message-State: ACrzQf0AHxeTWcVv+3jXnHNmZWbkK3r6jWOzQuk2K+5uGBbzbNnL2Jqu
        jhnZ33aeQJ2iHV16euhIGf7iw1VpAuCnaA==
X-Google-Smtp-Source: AMsMyM4mHeFnX3w8YCr2wsNw66bw81ioiWfWld+qaCT8h6ltyUO0X1H0B9yBBV45mm3eQJY7kd2lZw==
X-Received: by 2002:a63:7909:0:b0:458:1ba6:ec80 with SMTP id u9-20020a637909000000b004581ba6ec80mr3057284pgc.414.1667028014840;
        Sat, 29 Oct 2022 00:20:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m18-20020a62a212000000b0056bd737fdf3sm585170pff.123.2022.10.29.00.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 00:20:13 -0700 (PDT)
Date:   Sat, 29 Oct 2022 00:20:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 6/6] staging: ks7010: Avoid clashing function
 prototypes
Message-ID: <202210290019.CD8CB27A63@keescook>
References: <cover.1666894751.git.gustavoars@kernel.org>
 <34bf3ce1b1ca2da4c5ec8a6e26f31bbb9ca1c4f5.1666894751.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34bf3ce1b1ca2da4c5ec8a6e26f31bbb9ca1c4f5.1666894751.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 03:22:46PM -0500, Gustavo A. R. Silva wrote:
> When built with Control Flow Integrity, function prototypes between
> caller and function declaration must match. These mismatches are visible
> at compile time with the new -Wcast-function-type-strict in Clang[1].
> 
> Fix a total of 27 warnings like these:
> 
> drivers/staging/ks7010/ks_wlan_net.c:2415:2: warning: cast from 'int (*)(struct net_device *, struct iw_request_info *, struct iw_point *, char *)' to 'iw_handler' (aka 'int (*)(struct net_device *, struct iw_request_info *, union iwreq_data *, char *)') converts to incompatible function type [-Wcast-function-type-strict]
>         (iw_handler)ks_wlan_get_firmware_version,/* 3 KS_WLAN_GET_FIRM_VERSION */
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The ks_wlan_net Wireless Extension handler callbacks (iw_handler) use a
> union for the data argument. Actually use the union and perform explicit
> member selection in the function body instead of having a function
> prototype mismatch. There are no resulting binary differences
> before/after changes.
> 
> Link: https://reviews.llvm.org/D134831 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - None. This patch is new in the series.
> 
>  drivers/staging/ks7010/ks_wlan_net.c | 184 ++++++++++++++-------------

I think the casts in ks_wlan_private_handler can be removed, too?

-- 
Kees Cook
