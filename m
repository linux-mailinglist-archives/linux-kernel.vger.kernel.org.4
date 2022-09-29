Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6088D5EFA78
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiI2Q2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiI2Q1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:27:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0A11181FC;
        Thu, 29 Sep 2022 09:27:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so985340wms.4;
        Thu, 29 Sep 2022 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=icV6cxvXLdy/u1P61WPyBZFENlozm8iS3OoyNfd2f5Q=;
        b=Lqili1lHrpn0yuYSaYBPZxkVMnlBUFLeI2TVXfPPNP8+mAlJOLfQ5y6B2JArvg6zAf
         BrBgP5YflGzmsZ4Im+u5YXxPC5njXfyUnYblj/z7eRcveVKot+tjr4IWqGEFmb3mjKIi
         PbQtxa6iPVUlYXtZkzWlKUyUUYWDHgTQ5hrMagrEAgYsnjDRoiSct9ajfXr1wnbdHgwN
         sSs9cF+Xxv6widRyjBMBlHGUk0QhbE3uGr1UKQEW+KVZNOlImKX28x82tubE1YAFLrd1
         vduscc6FbrQZ1q1El5KSptqIGMhAj9aYJju/iJD4EO9TV8/UsNyxPAV2EL6MyV40x0ra
         4uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=icV6cxvXLdy/u1P61WPyBZFENlozm8iS3OoyNfd2f5Q=;
        b=2bKn71mVt63Rog4iA6Ouvu6Ml2cdV4nzE/+B52UGx35ves09C/182rZVi9Zmx+SzaW
         RhkyZUc4PTuS0QaV0eOq1wepn6Mf1CIHeq7gBgp1OeZ6nUQHeuAs4BNXm+TzRiouHJjl
         qHpmdPzk0vx7Q2Hk67qWkTQgN7Gj+054qZGh8B7RNAi7fdc10ExS/ahSK91uueewSzRD
         dSuQemxkd6CN9qMZI3myZAVOB4wiEiNYgSUfqIg2k+31WGkIlW3EuhH+O7e+jo7Z5Uw7
         e8v0AhgR9pHLX2UPgAEaDxNSlSkrDF3oteRDxc8Qyjic2ZJCwgiico+CMuyGe3F6TGB0
         hmMw==
X-Gm-Message-State: ACrzQf3TQag+RBjBWQiERzylLT9QlEola0t6HgpEzDNsRAe0YfAydP3L
        UsMv0QzveYv0h44LZm/POKE=
X-Google-Smtp-Source: AMsMyM7WsNBU8dNmdrnrV6FryYuT3bRv7UJ5WDgSBEi2W+cfzeMgqEXo5xk+WrXjvI9JpkAwxAEiKQ==
X-Received: by 2002:a05:600c:4f46:b0:3b4:fed8:331e with SMTP id m6-20020a05600c4f4600b003b4fed8331emr11585833wmq.198.1664468829288;
        Thu, 29 Sep 2022 09:27:09 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
        by smtp.gmail.com with ESMTPSA id d22-20020a05600c34d600b003b49ab8ff53sm4987940wmq.8.2022.09.29.09.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:27:07 -0700 (PDT)
Date:   Thu, 29 Sep 2022 16:27:06 +0000
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonas Bonn <jonas@southpole.se>, openrisc@lists.librecores.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: update config files
Message-ID: <YzXHWteIFh2kUOXY@oscomms1>
References: <20220929101458.32434-1-lukas.bulwahn@gmail.com>
 <YzWp+p+1V1UmCAb3@oscomms1>
 <YzWr+mmtLy2DRYEA@oscomms1>
 <CAMuHMdWx5RKP8WfNAyOofGFTGQNfOtDYMOJmvPgPhtyvRPG1Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWx5RKP8WfNAyOofGFTGQNfOtDYMOJmvPgPhtyvRPG1Bw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, Sep 29, 2022 at 05:07:40PM +0200, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Thu, Sep 29, 2022 at 4:30 PM Stafford Horne <shorne@gmail.com> wrote:
> > On Thu, Sep 29, 2022 at 02:21:46PM +0000, Stafford Horne wrote:
> > > On Thu, Sep 29, 2022 at 12:14:58PM +0200, Lukas Bulwahn wrote:
> > > > Clean up config files by:
> > > >   - removing configs that were deleted in the past
> > > >   - removing configs not in tree and without recently pending patches
> > > >   - adding new configs that are replacements for old configs in the file
> 
> > > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > >
> > > Thanks for the patch this looks fine to me.  Usually I just generate this
> > > defcnfigs using make savedefconfig.  If there is some better way which
> > > doesn't generate the file with the # comment's I haven't found it.
> > >
> > > I will queue this.
> >
> > Actually..
> >
> > About the subject 'openrisc: update config files' and description.  Can you be
> > more specific about what updates you are making for this patch?
> >
> > For example: remove comments from config files.
> 
> These are not comments, but options that default to y or m, and
> are overriden to n by "commenting them out".
> 
> This syntax dates back to the days Kconfig was a collection of
> shell scripts. Nowadays, switching to "CONFIG_<FOO>=n" would
> perhaps make sense, as Kconfig already recognizes that syntax.

Right, I remember the *comment's* do actually are material to the config files.
In this patch not everything is removed, just old non-existent configs.

I sill prefer having a more descriptive subject.

-Stafford

> > > > --- a/arch/openrisc/configs/or1ksim_defconfig
> > > > +++ b/arch/openrisc/configs/or1ksim_defconfig
> > > > @@ -19,9 +19,6 @@ CONFIG_NET=y
> > > >  CONFIG_PACKET=y
> > > >  CONFIG_UNIX=y
> > > >  CONFIG_INET=y
> > > > -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> > > > -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> > > > -# CONFIG_INET_XFRM_MODE_BEET is not set
> > > >  # CONFIG_INET_DIAG is not set
> > > >  CONFIG_TCP_CONG_ADVANCED=y
> > > >  # CONFIG_TCP_CONG_BIC is not set
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
