Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A366AB968
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCFJMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjCFJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:12:39 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC522A0B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:12:38 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g3so35609569eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678093957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mTfGx0mp9/LWUdj2UvEsovJkAt+RFABCOqqYv14V70=;
        b=NdvnDywVIzQx5bVkpYvWuwCDxBJEtDr0Ft8ay2Ya8vmx1+sKT2IuSp+ovPnd6Lp2Ob
         Rlh1nNqfs2FwGSmfpgl/A7++KH4lmY8sqOzQkZGNnOZnyl8s0z5+r9GlgIgp2m1IGPCP
         CrZTc5n8a3XtQ3y+35LWFi8mz7dSgAVALC4F5/r+iHxq5G6DQrm+YBdr+0N/ZIOzB5VX
         9rvSubDB7XMapgeBtKatGvMDD+6enfhJ2D50rSvvzfyZ2qBcl9m3tFY0v6Hw861UrejV
         rTE0rf7632ZTmZnkNZne+vcoEAyiKwhNp4ZyQtavNHG/KUntcCxvQScBMAe1dlsn9eS4
         0awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678093957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mTfGx0mp9/LWUdj2UvEsovJkAt+RFABCOqqYv14V70=;
        b=pxuMvODGGrDmMlkor9+RemKEB0JYe/QJcc063/0+A9vTUkfbjX1176oxPf6QxMFQDe
         GzfYyFXgDCL4TjZyn/OyzhJXeFTmoT62KE39d9BqV46zWtqd0fEMzIPZIH9xZ8MpCT1O
         aEAbH912IB6C8C0JBynwODHOa/Tyvz0YzloXBYIvm8KlzGNnNBhqwqCtzSYP1KLSoyRo
         uHANjPEfuvSFq3ovD4SZmeHZ0b1hQIOJshjCxkzwciOBYnRzu8sxWZ0Ko310JdbavnAM
         gsNR0nfkFW/IGw/PCersah6PewiKuxHvmlNTuhT37KzF/WoPzmNW24GEdWJVGI62aw1b
         GKPw==
X-Gm-Message-State: AO0yUKVq7CY+FgfpxSojIdbglrOZkTg74k75Q5+pgJ+Ukc3vmcnR0mrv
        lJjSf8W/DTSSRyel0aZdldg=
X-Google-Smtp-Source: AK7set8+B/WkBbXW6QVxciYpO7XflUL7lhU5VYTsfbZ66mjsMs/p4NW1PHT7yRc+xC9MZYQwCHa89Q==
X-Received: by 2002:a17:906:af62:b0:8d9:383a:be39 with SMTP id os2-20020a170906af6200b008d9383abe39mr11790006ejb.41.1678093956822;
        Mon, 06 Mar 2023 01:12:36 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b008eb2a1474d0sm4293780ejd.77.2023.03.06.01.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 01:12:36 -0800 (PST)
Date:   Mon, 6 Mar 2023 12:12:32 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8192e: Remove empty Array
 Rtl8192PciERadioC_Array
Message-ID: <51b147e6-d502-461d-9c29-647ec67e0d38@kili.mountain>
References: <cover.1678051460.git.philipp.g.hortmann@gmail.com>
 <d8f0e8c7ee6dd820b56636db8d891012aa3ab263.1678051460.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8f0e8c7ee6dd820b56636db8d891012aa3ab263.1678051460.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 11:33:05PM +0100, Philipp Hortmann wrote:
> Remove empty array Rtl8192PciERadioC_Array and the code where it is used
> because it is dead code.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 12 ------------
>  drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h |  2 --
>  drivers/staging/rtl8192e/rtl8192e/table.c      |  3 ---
>  drivers/staging/rtl8192e/rtl8192e/table.h      |  2 --
>  4 files changed, 19 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> index 35ca01ab65ff..fe0ef52c163a 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> @@ -649,18 +649,6 @@ u8 rtl92e_config_rf_path(struct net_device *dev, enum rf90_radio_path eRFPath)
>  					  bMask12Bits,
>  					  Rtl819XRadioB_Array[i+1]);
>  
> -		}
> -		break;
> -	case RF90_PATH_C:
> -		for (i = 0; i < RadioC_ArrayLength; i += 2) {
> -			if (Rtl819XRadioC_Array[i] == 0xfe) {
> -				msleep(100);
> -				continue;
> -			}
> -			rtl92e_set_rf_reg(dev, eRFPath, Rtl819XRadioC_Array[i],
> -					  bMask12Bits,
> -					  Rtl819XRadioC_Array[i+1]);
> -

Why is this dead code?  So far as I can see "== 0xfe" is always false
so this calls rtl92e_set_rf_reg() on every iteration through the loop.
It only does one iteration through the loop.

Is it dead code because case RF90_PATH_C is always false?  If so then
that needs to be explained in the commit message.

regards,
dan carpenter

