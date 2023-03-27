Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3436C9AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC0FD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjC0FDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:03:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A7B4231
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 22:03:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r11so7260869wrr.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 22:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679893399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y7YZc7+GXIQDusVUYqDOj5P6rOU9cQWWbR2WAwt/ZP8=;
        b=Au31X4bAiYNikzyau9Yfhg61ao8BTyae3kBdmWF7+w8cKS6x5kPmT6nu82vEZ0040a
         jvugcn6hzLwKsx3Dd1gMYUfYl38cfjFf8DbCugPyv6EMG8e/tu5l3FR29XUU3lKVHnr4
         wMy8rWT09dTWjJMvUtZy/Ka2MleRCb7igF8l3wfhwX4YhgMw1h8sNrI0del/xnLidaY4
         ljMQv2rRc9pX+hX4MU5kqFxEGSR2b/rSuffaK6xWXrQXlJlHgmrrtRPuxBd7Ru8vf9Jv
         056OoNcnN38e37ZrG4olglwyhHz9iM84vIqDU3OO9tKr5JFwng+jv0OzIhNoqzIxGN9m
         EtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679893399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7YZc7+GXIQDusVUYqDOj5P6rOU9cQWWbR2WAwt/ZP8=;
        b=QsXYdiztEawAPyvW7OcD/c+On/Lk5mvqZ6uTIuaepGPllciTd3celYIq5LigR1wdSZ
         VevmNHzZ1Qel1qSAluK/2S8RplwMW+9HvmPqVwXbfxPho+ZQGRsQwx7wdj0DMp31W5Gm
         06OzqQ6xMPToSsZCsB3EcPRz9xTFu5wBY9igXJ3PFBWZb4klc/SyQkiBrP8wF6Ejt0N+
         sAlR3vJiZitP5cn02+Dp0tad68t36ggyhUk+ZXBZ08LYbn2mFGrM0bUW2kQ/auDqTiHY
         skZ276tlDL9b48RjLjBffCPuFz1L7fXvLTZKHRmvLicJiCCUxAeZRAjSSOSixS5kwDZE
         Gf8A==
X-Gm-Message-State: AAQBX9eURygXMk9oq5Fvw/C/d6MnEnU3s/FIxjIHzojeZF2IyvDW14li
        Wn1LdS3RfzdLR/KgEnrvIuE=
X-Google-Smtp-Source: AKy350aLBQR2xPYxawU6Rc6qi8vaKa9Q3oJfOb9xD9r02p7cdkbEIZyhOWFb6S3aQUxQIGPy8D0zAQ==
X-Received: by 2002:adf:ea09:0:b0:2d1:f705:a602 with SMTP id q9-20020adfea09000000b002d1f705a602mr7986169wrm.22.1679893398684;
        Sun, 26 Mar 2023 22:03:18 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n17-20020adff091000000b002c5534db60bsm24065337wro.71.2023.03.26.22.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 22:03:18 -0700 (PDT)
Date:   Mon, 27 Mar 2023 08:03:14 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: rtl8192u: reformat block comments
Message-ID: <32819686-cce9-40d2-8707-547bdb1a72f8@kili.mountain>
References: <cover.1679831899.git.kamrankhadijadj@gmail.com>
 <d49d15e620aa9239f3d68df1a5f8b600de77b536.1679831899.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d49d15e620aa9239f3d68df1a5f8b600de77b536.1679831899.git.kamrankhadijadj@gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 05:18:27PM +0500, Khadija Kamran wrote:
> Linux kernel coding style for block comments uses a column of '*' on the
> left side and  uses '*/' on a separate line.
> 
> Fix block comments by adding '*' on subsequent lines and moving '*/' at
> the end of block comments on a separate line. These issues in block
> comments are reported by checkpatch.pl script.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_dm.c | 38 +++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
> index e5c0bece4bb4..99c38a4cf54c 100644
> --- a/drivers/staging/rtl8192u/r8192U_dm.c
> +++ b/drivers/staging/rtl8192u/r8192U_dm.c
> @@ -1,13 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*++
> -Copyright-c Realtek Semiconductor Corp. All rights reserved.
> -
> -Module Name:
> -	r8192U_dm.c
> -
> -Abstract:
> -	HW dynamic mechanism.
> ---*/
> + *Copyright-c Realtek Semiconductor Corp. All rights reserved.

You need spaces after the '*' char.

/*
 * Copyright-c Realtek Semiconductor Corp. All rights reserved.
 *
 * Module Name:

> + *
> + *Module Name:
> + *	r8192U_dm.c
> + *
> + *Abstract:
> + *	HW dynamic mechanism.
> + *--
> + */
>  #include "r8192U.h"
>  #include "r8192U_dm.h"
>  #include "r8192U_hw.h"
> @@ -243,7 +244,8 @@ void init_rate_adaptive(struct net_device *dev)
>   * Output:		NONE
>   *
>   * Return:		NONE
> - *---------------------------------------------------------------------------*/
> + *---------------------------------------------------------------------------
> + */
>  static void dm_check_rate_adaptive(struct net_device *dev)

There is a proper kernel doc format for comment formats.  The format is
described in Documentation/doc-guide/kernel-doc.rst

(Change the function comments as a separate patch from the top of the
file changes).

regards,
dan carpenter

