Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8444A623806
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiKJAK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiKJAKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:10:54 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4394101C4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 16:10:53 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b185so253258pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 16:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yfINp8pb5N6Kx42V2kF3zccXP5miAwmr+YVzAQR38b8=;
        b=hrulcqmGHvIDI7EqZKqSueWhh85PNmFzN08aIKM7w4yjyfwkcS4HuPqLRRHwcVjggo
         jpKx4rESzVfQK/lHta+SCGcvocKoB4TOc1+BvhJeW5UbuYExMukkbO58TBObElRpmcBA
         16H84vUhdPO6YaHsoin3oZPfwskSYzp++yb/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfINp8pb5N6Kx42V2kF3zccXP5miAwmr+YVzAQR38b8=;
        b=z9ViGI2gWZym38ENiDc0qtgNeeDfOtMbmSA9l+K4G01gvMXtSH+oeRdMZorlhhZ/9a
         2HcrR7FRWiDasWGg51O2DmJnYd+cftbxv+wtxCqDNeZ/2Nv/HxBoPSMAd+oa1OnA+P7P
         4ZsIpVbuAm85aVngyxglFDmw7j7ZA+pncus9LLku/5ITwE8iATvTBkg6DDD2/y7TpwaY
         7qTFOALBigxisFjeMHqrG/A6daFNxfLuaFNLAEDJdAv9CEp/UR4EG/BzJdGzque/4UlG
         ibTJ2LvgkRfWPPcX5F+izOlZO/8nZ1pKnrRaog6SaXBM5m/sMm1W6O9v9pFrmGoVWg6a
         Gm1A==
X-Gm-Message-State: ACrzQf0pfH4vIDmZDVnHnkg8kyWI0DS65bqidjyJVf5XbJ1JOCIfXoeZ
        8RQAa9o2P1JffD1fkJHnQjHVRw==
X-Google-Smtp-Source: AMsMyM5Ur4+2jdo21Hc7VyMq48tFV/jggd85uZGIwa6o2cvJu/+hjBRLNTLAWr8lbwDHdOX2nk1e5w==
X-Received: by 2002:a63:2cd2:0:b0:41c:5901:67d8 with SMTP id s201-20020a632cd2000000b0041c590167d8mr53661261pgs.365.1668039053278;
        Wed, 09 Nov 2022 16:10:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902650400b001869079d083sm9748551plk.90.2022.11.09.16.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:10:52 -0800 (PST)
Date:   Wed, 9 Nov 2022 16:10:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 7/7] staging: ks7010: Avoid clashing function
 prototypes
Message-ID: <202211091610.8D12F1F@keescook>
References: <cover.1667934775.git.gustavoars@kernel.org>
 <8d2ceee1248b5a76e9b6c379f578e65482c91168.1667934775.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d2ceee1248b5a76e9b6c379f578e65482c91168.1667934775.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 02:34:46PM -0600, Gustavo A. R. Silva wrote:
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
> These changes were made partly manually and partly with the help of
> Coccinelle.
> 
> Link: https://reviews.llvm.org/D134831 [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

The "mode" churn makes this a bit harder to review, but I think the
final result looks better.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
