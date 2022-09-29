Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473D15EF78C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiI2OaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiI2OaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:30:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C543AB06;
        Thu, 29 Sep 2022 07:30:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id cc5so2492015wrb.6;
        Thu, 29 Sep 2022 07:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=D2lkRQCuHF3ThWvs1mxiesV0wdVCquhCSxFRRCWyCv0=;
        b=iMALSbyky95yHXp5C/DMlsV0O/oQPXNZBMo/IcK0/Hu+vb1V0jE0irnly5s9LEo9ZC
         lYLkIWwy2IlSL27z8W/8QsUtcaRDmnuXiOWgChnGkeY5GZe5yvPsyKMxyDWaJqhpiTH/
         QBN5B4lbCkfddf2xAtX5T2LnzAHp31Z35TU6vV0ALXQek3/xf/FdScfzVkdA1GQd5SkQ
         ifYYRcaIZsR6F8KG0MW1wWNIdyX/ik9HGMA7t9zSNofmZWM8ZvHM65FgBAsj8YCbkCkc
         uYozeYwDg9Kef2PpcUxOS0UxNOsQmFB81/8x5llU2k1TIW6PF+fCZTtEKu+eGecCGvpQ
         PSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=D2lkRQCuHF3ThWvs1mxiesV0wdVCquhCSxFRRCWyCv0=;
        b=Wt1VRyD0Xq4YHEH/PReMXs5/VDZgDsnglBh9Z6sW8WhfD23AAyUVlfcYfPL1fXvqu9
         tX5ZUzl+EKc3jc6hcEn3zeZV3HbCGWBgqBDHRjqgPX/IEZXGSqdQk0PWYDEIts9Mgz7S
         o/rHsebJIT3cyRgdcM5L2TWrLpygOeoUUYTriP5tAL6wWVTH07tMEweDMFMyp/7SaCwI
         OSjDit2MABC/1KEZSeEZoGS6uPHDQUJvSHtsOvZGdlRRjY+cj3UZqxXB61Dn1Sq7N5U8
         1NX9eIjGukXNcpN/O1CESpn/C4R4m+J36Myh7RigcCoZie0G7pO1lToNSPvpYm5uJa1x
         w0Tg==
X-Gm-Message-State: ACrzQf0tR1RM679SNPdDvVX75MRL0x5AT5AOSflRdBFLzI9N19M5McAt
        Pk7kZydIcjw6ds6U7h+5hKc=
X-Google-Smtp-Source: AMsMyM6xPtQOGyS1GcMriCqoY1+CKok3+WbriymFW3pwIEfpIfR3XLIuCYZ3t85p9ZgVut5Wa/Bfyw==
X-Received: by 2002:a5d:4bc3:0:b0:22a:4b7a:6f60 with SMTP id l3-20020a5d4bc3000000b0022a4b7a6f60mr2572401wrt.549.1664461819743;
        Thu, 29 Sep 2022 07:30:19 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b003b4e009deb2sm5127754wmb.41.2022.09.29.07.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 07:30:19 -0700 (PDT)
Date:   Thu, 29 Sep 2022 14:30:18 +0000
From:   Stafford Horne <shorne@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: update config files
Message-ID: <YzWr+mmtLy2DRYEA@oscomms1>
References: <20220929101458.32434-1-lukas.bulwahn@gmail.com>
 <YzWp+p+1V1UmCAb3@oscomms1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzWp+p+1V1UmCAb3@oscomms1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


On Thu, Sep 29, 2022 at 02:21:46PM +0000, Stafford Horne wrote:
> On Thu, Sep 29, 2022 at 12:14:58PM +0200, Lukas Bulwahn wrote:
> > Clean up config files by:
> >   - removing configs that were deleted in the past
> >   - removing configs not in tree and without recently pending patches
> >   - adding new configs that are replacements for old configs in the file

Not all of these apply to this patch.  Can you on mention what you changes you
are doing here?

> > For some detailed information, see Link.
> > 
> > Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/
> > 

This extra newline is not need.

> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> Hello,
> 
> Thanks for the patch this looks fine to me.  Usually I just generate this
> defcnfigs using make savedefconfig.  If there is some better way which
> doesn't generate the file with the # comment's I haven't found it.
> 
> I will queue this.

Actually..

About the subject 'openrisc: update config files' and description.  Can you be
more specific about what updates you are making for this patch?

For example: remove comments from config files.

-Stafford

> > ---
> >  arch/openrisc/configs/or1ksim_defconfig    | 5 -----
> >  arch/openrisc/configs/simple_smp_defconfig | 4 ----
> >  2 files changed, 9 deletions(-)
> > 
> > diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
> > index 6e1e004047c7..af1164807206 100644
> > --- a/arch/openrisc/configs/or1ksim_defconfig
> > +++ b/arch/openrisc/configs/or1ksim_defconfig
> > @@ -19,9 +19,6 @@ CONFIG_NET=y
> >  CONFIG_PACKET=y
> >  CONFIG_UNIX=y
> >  CONFIG_INET=y
> > -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> > -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> > -# CONFIG_INET_XFRM_MODE_BEET is not set
> >  # CONFIG_INET_DIAG is not set
> >  CONFIG_TCP_CONG_ADVANCED=y
> >  # CONFIG_TCP_CONG_BIC is not set
> > @@ -34,7 +31,6 @@ CONFIG_DEVTMPFS=y
> >  CONFIG_DEVTMPFS_MOUNT=y
> >  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
> >  # CONFIG_FW_LOADER is not set
> > -CONFIG_PROC_DEVICETREE=y
> >  CONFIG_NETDEVICES=y
> >  CONFIG_ETHOC=y
> >  CONFIG_MICREL_PHY=y
> > @@ -52,4 +48,3 @@ CONFIG_SERIAL_OF_PLATFORM=y
> >  # CONFIG_DNOTIFY is not set
> >  CONFIG_TMPFS=y
> >  CONFIG_NFS_FS=y
> > -# CONFIG_ENABLE_MUST_CHECK is not set
> > diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
> > index ff49d868e040..84ca3203af9c 100644
> > --- a/arch/openrisc/configs/simple_smp_defconfig
> > +++ b/arch/openrisc/configs/simple_smp_defconfig
> > @@ -27,9 +27,6 @@ CONFIG_NET=y
> >  CONFIG_PACKET=y
> >  CONFIG_UNIX=y
> >  CONFIG_INET=y
> > -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> > -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> > -# CONFIG_INET_XFRM_MODE_BEET is not set
> >  # CONFIG_INET_DIAG is not set
> >  CONFIG_TCP_CONG_ADVANCED=y
> >  # CONFIG_TCP_CONG_BIC is not set
> > @@ -60,5 +57,4 @@ CONFIG_SERIAL_OF_PLATFORM=y
> >  CONFIG_TMPFS=y
> >  CONFIG_NFS_FS=y
> >  CONFIG_XZ_DEC=y
> > -# CONFIG_ENABLE_MUST_CHECK is not set
> >  # CONFIG_RCU_TRACE is not set
> > -- 
> > 2.17.1
> > 
