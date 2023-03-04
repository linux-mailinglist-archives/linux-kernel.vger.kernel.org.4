Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327BD6AABF1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 19:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCDSxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 13:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDSxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 13:53:19 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A040EB70;
        Sat,  4 Mar 2023 10:53:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p26so3414185wmc.4;
        Sat, 04 Mar 2023 10:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677955997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VdySrHoCMqsO79VSMWCrq3niAvBezbtFI2hsdytVZQ8=;
        b=jtRNEH1smyAaBSJjayP7T8JGy9BVBsphnhYlwcEND6/I3hx6z9Lm67tYPZJSgdE2aU
         PKp9ETVWSz/DmJAcL4l2E1nqCcFDsheeRne+HF9LpYsLm6XU5wTK0lzKcf+Xkv0PVCNO
         dE4JELuF8f9X6N9qAr+XyaHC6c/4OqsfNpax1nDqzGy8HeHDl8Y7jfEFwCu55fROiMdH
         F4bBHs3uUw9YVYFpvLe4XbN3Un3LnlBVmydCHdM2UowxUNKbJ+V6PDVMjXO6pysQwzuf
         XyTbbqY5KdOdOJ+yFAx6M8NblF+5z2jpe4w+1Yf/pYohmZzuj9GtPOGHUkOKKgVvDdDM
         lqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677955997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdySrHoCMqsO79VSMWCrq3niAvBezbtFI2hsdytVZQ8=;
        b=Osuqu/3W2q8BfecwZEc1zIBsD7YMzJRLuGWALqhhxhxXotGI3j9w7ijMPYy8EwJ9Lc
         UQH2CBPQ6Qh5nP75+xlt5BvF+dtSNDJvh5yNJMAfaMM/T1DBp0k7YLjXPL/8Yrl7zlZj
         kHFb/H7kit4ccUPwnaTARE1QdN3kHjh+l3zEep93b3jPw7HEdijFvRooq37BZytzzNcT
         1BUvAMlk7tj8Piky0ewaGcgX92ox5pnmPMyOCGX0dUoa8JX+HUH6zH8rN6ssoJFXYiRN
         LkRhy0yYUESxjgyJZka/VRmNTKx7ripT3qZ+kyMI/U0689dSVn6GloIOT51EkwSz2z6k
         bwiQ==
X-Gm-Message-State: AO0yUKV/AyPuuiHH/kMWMfDxCEACzNXM6ri6TgtjhiKuR/GTI6KgSeGM
        pwgOGovkoW7JoqX+6cD8fBWkS3BN4g==
X-Google-Smtp-Source: AK7set8Le8ez+PHZfcvzxwBPuAPD/74oYhqFDGRaIQmfQDd5SEiYHTR4b1ditY9GNrtr/ijbaInfVQ==
X-Received: by 2002:a7b:cb01:0:b0:3ea:d611:f8 with SMTP id u1-20020a7bcb01000000b003ead61100f8mr5427627wmj.38.1677955996754;
        Sat, 04 Mar 2023 10:53:16 -0800 (PST)
Received: from p183 ([46.53.251.240])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c161300b003eb5a0873e0sm5882232wmn.39.2023.03.04.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 10:53:16 -0800 (PST)
Date:   Sat, 4 Mar 2023 21:53:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] menuconfig: reclaim 1 more vertical line
Message-ID: <a5a4bfb5-90ec-447f-82a2-28804e3353b0@p183>
References: <94a94ef4-9d55-4293-8363-3c0243eceae1@p183>
 <8a8c8ed8-f322-4024-9433-3a9cb524484e@p183>
 <ae258f1e-5c44-d349-4704-fbf5c7c28b85@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae258f1e-5c44-d349-4704-fbf5c7c28b85@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 09:52:55AM -0800, Randy Dunlap wrote:
> Hi,
> 
> On 3/4/23 08:56, Alexey Dobriyan wrote:
> > Empty line after legend is waste, use it for config options.
> > 
> 
> I don't see an empty line after the legend. For me this patch
> truncates the menu_instructions[] text from 4 lines to 3 lines,
> dropping good/useful help text.

OK, I do need to test this one on more screen sizes.

> menu_instructions[] was already truncated before this patch
> (in an 80x30 size terminal window).
> 
> What size terminal are you using?

135 x 31

> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> >  scripts/kconfig/lxdialog/menubox.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/scripts/kconfig/lxdialog/menubox.c
> > +++ b/scripts/kconfig/lxdialog/menubox.c
> > @@ -185,7 +185,7 @@ int dialog_menu(const char *title, const char *prompt,
> >  
> >  	height -= 2;
> >  	width  -= 5;
> > -	menu_height = height - 10;
> > +	menu_height = height - 9;
> >  
> >  	max_choice = MIN(menu_height, item_count());
> >  
> 
> -- 
> ~Randy
