Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBF3695A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjBNHLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjBNHLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:11:07 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5DB21292
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:07:56 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m10so5684982wrn.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2CrTfSdCZ8kL9Y45Dpaj6OWp5Cgjxivq7kfQiy/YkcU=;
        b=PeWqRzzvm0ugtXQYxWSFo8ZVorGdIZZljysgCm3eYjurJcaIWpSn8GwMtTPYRJHsNv
         PtP3q/m54YcM1A28lJkwfD3oKK77uCmcCo5CS0NX1fbtTUlme3NSrq2fc/ngj1ro1ySi
         +8LoHJhQV1S3kDa2Y7OoUVyPan1wl7fWPHttYnhmCCOdT0JF9tYw3drFEvDW8ALBF/Rs
         gTSAa430eVUqHGO5aNnU+kgVaebS9S/39riM/N+edh1f+j5OKGUlZTW8UmtCXbVYKxAM
         I3CbUm1kGZen7DB3knjEgHSd4YfsUvVCimoRx9RLHN7E3tb+7lvU/doisOLYl4NBYv/R
         b4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CrTfSdCZ8kL9Y45Dpaj6OWp5Cgjxivq7kfQiy/YkcU=;
        b=vLqFlT03jZ/DXSdFAHdJfeaJb/YzFyxZ1VYD9qwx4AAnCJF4BXT8jvV9fH6PFZsAOz
         6tgVi7vvWIxfKfo/YUff+J7xD5Qv0wFuj4IRtfVn6pCDLf6koYxDf0DmNqpu5JleKZ6U
         gprEJFHAAhFz/3t1QMT3x3+jsP95mkDT7/l457l3vnjfWH+IqD9IrfNwsMNhYzT9QfwE
         kXABJ0f/rEhUCzbTkd0KOOUlXMau5aHLNIeoH6WTlf0IrKkmpL8vGe6XrDys2F8wyfbW
         F/SZW4xfKszdjs3cs5EDvPwB1SagUjrUi3N0m/f0P044V5vgyOVPOFiyts9OFPRFzKOE
         NF8w==
X-Gm-Message-State: AO0yUKWKe/8Fx04kKPvbW81uVGj3ftpO+XYJy7cD+m7JVw6hiwap9hcO
        muwnfwXcdG8umaKTU7aq/dI=
X-Google-Smtp-Source: AK7set/u/EeB7g/2bx9z/lATJMIlaAtUQfjrmqR25IF5wouTdISjba3Bb4V91UDgzB/5S5dbZ2bOJg==
X-Received: by 2002:a5d:6091:0:b0:2c5:5847:7374 with SMTP id w17-20020a5d6091000000b002c558477374mr1143867wrt.67.1676358474534;
        Mon, 13 Feb 2023 23:07:54 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d13-20020adfe88d000000b002c54f4d0f71sm7246984wrm.38.2023.02.13.23.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 23:07:53 -0800 (PST)
Date:   Tue, 14 Feb 2023 10:07:50 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: Revert "staging: r8188eu: simplify
 rtw_get_ff_hwaddr"
Message-ID: <Y+szRoaj2rEz/0KN@kadam>
References: <20230211183205.426820-1-martin@kaiser.cx>
 <20230213195407.15085-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213195407.15085-1-martin@kaiser.cx>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 08:54:08PM +0100, Martin Kaiser wrote:
> This reverts commit fd48124e0982 ("staging: r8188eu: simplify
> rtw_get_ff_hwaddr").
> 
> The cleanup in this commit removes the qsel to addr mappings in
> rtw_get_ff_hwaddr. The underlying assumption is that rtw_write_port
> uses its addr parameter only for the high_queue check.
> 
> This is obviously incorrect as rtw_write_port calls
> ffaddr2pipehdl(pdvobj, addr);
> where addr is mapped to a usb bulk endpoint.
> 
> Unfortunately, testing did not show any problems. The Edimax V2 on which I
> tested has two bulk out endpoints. I guess that with the incorrect patch,
> addr could only be 0 (no high queue) or 6 (high queue), both of which were
> mapped to the first bulk out endpoint. Data transfers did still work...
> 
> Fixes: fd48124e0982 ("staging: r8188eu: simplify rtw_get_ff_hwaddr")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
>  - use correct patch prefix
>  - add a Fixes tag
>  - use 12-digit hash to refer to the reverted commit

Thanks, Martin!

regards,
dan carpenter

