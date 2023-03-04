Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5106AABF7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 19:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCDSys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 13:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCDSyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 13:54:47 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF22CC3A;
        Sat,  4 Mar 2023 10:54:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h11so5190826wrm.5;
        Sat, 04 Mar 2023 10:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677956084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O8CwBMPZqiMPf+Olsuo39xYfsEwAhTtv4vEO7nleaFI=;
        b=pTdT43ZVV/V/am5HqbZ4LyqchY+bx6YZlAacsG109k2hhNjAzng9PlV6XYjwAqj1Eb
         oK128sFkN6lGROC9rti4ks7TWTeT9woQRPtcdZFj57Cdyyaieg0SOIoo+7waehXzZWLU
         GbC3LD5T2qvUlWSWfgCeX2dpsw5iFEkS+buf6BgAyuO6VGyip97/CN7Ysht0+JOmiWnn
         at7u9HzcV1w/NCMO2pNDt9wUbveGwA7Nstu2LQmTJ9Xdh+egQKNGePQNvqLIs6vRvkL6
         w2FG+pGLXJdg0i4szlPhIB2hWsUcUvhysYGQJbJPlmklfWpC3BBtYV0Y209uI5KcL4Ix
         FzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677956084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8CwBMPZqiMPf+Olsuo39xYfsEwAhTtv4vEO7nleaFI=;
        b=wxBAzg8PjVNxdRCZaz+sidW4E790Re3OiEh5m9xf5vojJ9/0lwndI4KbSvYq0vf5e3
         IilEXGOaJA98WqmZJvmdVHR7mS+SVkI9crZMs3rPZoYKAM4RA92FnYmN+Ynus/1Qep5D
         lAubjil14AyOe5se1QSu7Q/tzbwefwDGDxkHLDJGgeH61jcejNnGUqCYG9d11TGrsbXh
         sTc3MQi3nMQuz2k5pIlgH3CI8Rx1fo8YX8j2fPvQEdNJTOCFo2/0EtOEwkFrTzr9wYpb
         f2O3ZKQCL4MJfxvAgE+lBGp3xUXTqK4MzIYNonUXC34VH2ufozB6w+PXrcw8vwJiZL6k
         TFYQ==
X-Gm-Message-State: AO0yUKW5FlVrazEqF4YTcdxjOG9uY8bKjyysiTzn4ncr/PqvA5/V1b/x
        5IDeCglt47Dpuc5eYRwouQ==
X-Google-Smtp-Source: AK7set9DfWUBuQwd7VZLnyCFkC8IS5WaTdbovMiEu51lDf8vmbEJBbhwoMlWUKpqxlJbQUs4TVobog==
X-Received: by 2002:a5d:494e:0:b0:2cb:8f6a:6e7f with SMTP id r14-20020a5d494e000000b002cb8f6a6e7fmr3482175wrs.35.1677956083884;
        Sat, 04 Mar 2023 10:54:43 -0800 (PST)
Received: from p183 ([46.53.251.240])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b002c7066a6f77sm5597914wri.31.2023.03.04.10.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 10:54:43 -0800 (PST)
Date:   Sat, 4 Mar 2023 21:54:41 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] menuconfig: delete shadows, reclaim vertical space
Message-ID: <1c28155c-6931-432c-8308-c9b3638e3202@p183>
References: <94a94ef4-9d55-4293-8363-3c0243eceae1@p183>
 <d01112c2-b5a4-4aa3-4ee7-711abc9da079@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d01112c2-b5a4-4aa3-4ee7-711abc9da079@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 09:56:08AM -0800, Randy Dunlap wrote:
> Hi,
> 
> On 3/4/23 08:55, Alexey Dobriyan wrote:
> > Menuconfig has lots of vertical space wasted: on my system there are
> > 17 lines of useful information about config options and 14 lines of
> > useless fluff: legend, horizontal separators and shadows.
> > 
> > Sitation is even worse on smaller terminals because fixed vertical lines
> > do not go away, but config option lines do decreasing informational
> > density even more.
> > 
> > Delete shadows and increase menu size to reclaim vertical space.
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> >  scripts/kconfig/lxdialog/checklist.c |    2 --
> >  scripts/kconfig/lxdialog/dialog.h    |    1 -
> >  scripts/kconfig/lxdialog/inputbox.c  |    2 --
> >  scripts/kconfig/lxdialog/menubox.c   |    6 ++----
> >  scripts/kconfig/lxdialog/textbox.c   |    2 --
> >  scripts/kconfig/lxdialog/util.c      |   22 ----------------------
> >  scripts/kconfig/lxdialog/yesno.c     |    2 --
> >  7 files changed, 2 insertions(+), 35 deletions(-)
> > 
> 
> This patch works for me, but since the right side shadow is
> also being removed, the one column (width) that it had
> occupied might as well be used (reclaimed) instead of just
> going to waste.

Horizontal space is not really important because monitors are wider
than taller and our config option descriptions are quite short.
