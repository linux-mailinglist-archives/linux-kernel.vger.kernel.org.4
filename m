Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2899365EF86
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjAEO6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjAEO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:58:01 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D96A1A3B7;
        Thu,  5 Jan 2023 06:58:00 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id c133so32191603oif.1;
        Thu, 05 Jan 2023 06:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYSt1XatIEk02lW48s5E9qx2qd+gLfOO7+rMgHWKSs0=;
        b=b7+RfIlWTcoTNF07h8P0DfMNVsnAI/BVbHQ39VMph/CsEHAcpkALkgSlBIFAZAQAFr
         c2LRSs8Tw1JRozJRk/LEV7efR5ODBOicH16ob7OOAxlq53nE4nGSXoB0QqMdOETUX+w7
         m8iV+Ek4tfvd0S5muUaLR+VbPil26w8Q+we2lKCLqlcQGrFfFLmmbweaJNFSdcI7TfFx
         9x/L5USKI20uKfZTP47PT1vzIA/gp8B+Um2eki5FM/LFO881QJRzDbYuBw0ekrVk2BEi
         jEPOQ6oq3djdbJEgLMACO0e/WoSuek9fOnEu2AmCVNA+ybq3V6rZC1np//s4z7W+98rK
         nOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYSt1XatIEk02lW48s5E9qx2qd+gLfOO7+rMgHWKSs0=;
        b=ecD3gydhjaZ1PzOutvTCgcJukyBIV52DhViU5ij5Ipf05nRlMOtnPv0AP979O+5OUz
         iX4xVLk9PLWXQ7fsMZeifmC9p92DStGd4l6EhYvIXJhUsb5W/zDHIXsxGJW4AdKWrqag
         pGh+yFHav4xt7HWjd5ONsOCEbIhvutYYZ2DoeFlDerNvAq9q3K2WVr50O+3Xeeo6zKtd
         TsHPthh7gkfwSXuZdn/jhhYX6QAKt60VvW0PqEaE5CGW3AM9uuaMrIfRSDLgb38SPI/N
         g9bVlmTviGrgJkL6CYl0yd2wYt31sHh7M5US+dVtPqTleSbhW8dXQdW/JnrZvHIE4zXt
         6miw==
X-Gm-Message-State: AFqh2kqlsSX8H1acnhHCegKQe1X9q7EQ8aAwFpXTcTN5iq6SBI3VW2Nh
        X2c+7ekQhtIEFysc5Du8r5vErdRzFK4=
X-Google-Smtp-Source: AMrXdXsRPZJwcMGKWjlSZROm2i5nLPxaVnDaO+UzzOzRUhNgZkrAXrwIO0329ofmm03gc9pRRYJSFA==
X-Received: by 2002:a05:6808:1b0d:b0:35e:574c:c246 with SMTP id bx13-20020a0568081b0d00b0035e574cc246mr28434515oib.24.1672930679555;
        Thu, 05 Jan 2023 06:57:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 63-20020aca0742000000b0035028730c90sm15646273oih.1.2023.01.05.06.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 06:57:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 5 Jan 2023 06:57:57 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Convert to *_with_info() API
Message-ID: <20230105145757.GB2405273@roeck-us.net>
References: <20230105141911.8040-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105141911.8040-1-W_Armin@gmx.de>
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

On Thu, Jan 05, 2023 at 03:19:08PM +0100, Armin Wolf wrote:
> This patch series converts the ftsteutates driver to the *_with_info()
> API, reducing module size by ~30%.
> The first patch does the actual conversion, while the second patch deals
> with the nonstandard fanX_source attributes, which are being replaced
> with the standard pwmX_auto_channels_temp attributes. The last patch
> adds support for fanX_fault attributes.
> 
> All patches where tested on a Fujitsu DS3401-B1.
> 

This is the second time in less than two weeks that I get a follow-up
version of a patch series, unversioned and without change log.

That makes me wonder - is that just coincidence or is someone promoting
that ?

Guenter

> Armin Wolf (3):
>   hwmon: (ftsteutates) Convert to devm_hwmon_device_register_with_info()
>   hwmon: (ftsteutates) Replace fanX_source with pwmX_auto_channels_temp
>   hwmon: (ftsteutates) Add support for fanX_fault attributes
> 
>  Documentation/hwmon/ftsteutates.rst |   5 +
>  drivers/hwmon/ftsteutates.c         | 550 +++++++++++-----------------
>  2 files changed, 210 insertions(+), 345 deletions(-)
> 
> --
> 2.30.2
> 
