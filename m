Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F0A6A3A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjB0EpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0EpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:45:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAC51BAE2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:45:18 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r7so4832265wrz.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ef1eXKymSCJ8axKk34kHhc+GvKhotAKCjiYY25M70U=;
        b=FCeLmTH+FJtGqgCTAVRBa+KEIioqteBcqSog0UWZGRm7vpPObpjNkAhNKWVZ2q1R9a
         3Mna1gesKZpbcSPaqcSCbqt2YLvEpnYISnetOscUaUsr8c2yqcxRqpMrD0zGjDNY6ZOm
         PiFnquFkY7gKW5oq3sWf0eb66rvUKCgSgJy1fY3Uig8NJxoTQlWhkVREctqz0+KN4L08
         /lkpu9FMCztBvwcV3ueWGASJfwpmZSSLhjYBZGFXPvLaDFNbevP8b4df/SdIqC1Cuf8B
         pSXzymNBpDuVF58waUmrL+b39Gyv77621yxOoFvgzw46aWoExYpm/bL5qtQCFkBDwur/
         5bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ef1eXKymSCJ8axKk34kHhc+GvKhotAKCjiYY25M70U=;
        b=KoNce4DGR9qlccQcVnNDv1iyQKhHxL96/fg8j5U/sS/R3zQyRbjzHikFSbFXTd8Lff
         UimFUphbe8kPJg9rKY3zRYSj8jW8UjS+es5VlxF2YUoX8AKI7dlrd2Y23gYMvtpdJohz
         a7NmfxsPXoY3b7kWzgF8jhC7MLje9OU1XmyGCOG903mvyPyjkU/h67zj9a7L0b9dgNIh
         7dEHKSh+6BQXsH3yhvjrP8FzQn7UU49Y0vTR69zHbea0/fX0l0QvavjvELN9rm0VTuVw
         wgHGyFr7B+lEOsVDdHjCxcK49CczUT0NoxRvWLWBFgtWMzKoffdef8X5g8OTC9fsjMl6
         Gozw==
X-Gm-Message-State: AO0yUKWzBDABSt3n5pIEc5WmtLkBqjTt9MpxQpm4+0FI3RP1kuBbndkW
        6HSTLnCg46Go6zjfhQhJcAw=
X-Google-Smtp-Source: AK7set807VTcubdpYBl6vUB/jc7SWxpQeatjuPP1ahHjDC38EuBR7LcXS6VHHtGvKwpr+A2X6ZpCKA==
X-Received: by 2002:adf:ea07:0:b0:2c7:420:5d52 with SMTP id q7-20020adfea07000000b002c704205d52mr17648600wrm.62.1677473117292;
        Sun, 26 Feb 2023 20:45:17 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d5149000000b002c54c92e125sm5944690wrt.46.2023.02.26.20.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 20:45:15 -0800 (PST)
Date:   Mon, 27 Feb 2023 07:45:11 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Shibo Li <zzutcyha@163.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fixes the problem of irregular
 indentation
Message-ID: <Y/w1V5cYwTfDVn5p@kadam>
References: <20230226122820.194074-1-zzutcyha@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226122820.194074-1-zzutcyha@163.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 12:28:20PM +0000, Shibo Li wrote:
> This patch fixes the problem of irregular indentation
> 
> Signed-off-by: Shibo Li <zzutcyha@163.com>
> ---
>  drivers/staging/rtl8712/rtl871x_mlme.c | 182 ++++++++++++-------------
>  1 file changed, 91 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
> index fccfa0915a02..d8af4f370060 100644
> --- a/drivers/staging/rtl8712/rtl871x_mlme.c
> +++ b/drivers/staging/rtl8712/rtl871x_mlme.c
> @@ -51,7 +51,7 @@ int r8712_init_mlme_priv(struct _adapter *padapter)
>  	set_scanned_network_val(pmlmepriv, 0);
>  	memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
>  	pbuf = kmalloc_array(MAX_BSS_CNT, sizeof(struct wlan_network),
> -			     GFP_ATOMIC);
> +				GFP_ATOMIC);

The original was correct and the new version is incorrect.  Checkpatch
will complain about the new version if you re-run checkpatch on the file
(not if you run it on the patch itself).

CHECK: Alignment should match open parenthesis
#54: FILE: drivers/staging/rtl8712/rtl871x_mlme.c:54:
+       pbuf = kmalloc_array(MAX_BSS_CNT, sizeof(struct wlan_network),
+                               GFP_ATOMIC);

regards,
dan carpenter

