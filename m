Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5598C6E41D6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDQH6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjDQH6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:58:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6FB3595
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:58:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f0aabd1040so33538755e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681718293; x=1684310293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PC+Wb1Daz590LfS2gycNTQGY4FbkJM9lrY7YeUPGYqM=;
        b=P+dIDobKbmLvkfIeDEToWoFVL0cL0YuUzk450daekGSG3MvVV8sEXA50PaqEQie5eX
         W1gUQPjak0x6VGmWdVCZMwNnfa+FSnxJPPfYBZaM8wtH0wBNC68Gg+FwZBaE9wYMhnnK
         EofyACzgjSg8iQ0tUGYTJ9J01QIVPAj4hwmvgK7BxKeMMgWv2SZ4rrpGBL98kOFSQXRH
         67ra3vACKQJXaZSBfobbqIlGrIsEDqwJQfmk/+WSvJ5WSAvFu5r1jrcQQOaAbYrz72Tr
         7l1uwUCyT6BJ5w4vfJUfDAKsvf3B8IgOaCgShZZ2LbgNwy9Au7hhEkhgdUxcVO8j0POs
         LDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718293; x=1684310293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC+Wb1Daz590LfS2gycNTQGY4FbkJM9lrY7YeUPGYqM=;
        b=DTX3NOMdg4iBoejhh1MCmv5ACnIrcBylIAWqmA5eTsQfSpP7h5xGb8xZaHmF/1+ZOL
         uzq1FBSuuw0hzyUYRD0hDe7dD3dF2IDTWkYt1JFhoqta0oed1YsRNf/EfJdcK1jOWbyy
         y33fA+oce8hrO3e5OUFYsEaG/SKDaCEQoUQRcuL+FWVF5C0bRovbV+Lcc1KlhkSiyy1D
         KyxRKjgrZ9EYpKOQKEJeTZCzNRgX2ea1K6WhRaCGqKCD6BL0xbZJWUcemLe9+suZdJmd
         Ykxf8IFreXtKKkYevy2Wce9O2mpElJS8Ju/ee5TlNlu/ycxnMK/nLKjZC6F4CwBtaIwq
         Cexg==
X-Gm-Message-State: AAQBX9cnsFh7/09GD2ctNrr1x3uikPifMVy6Y3iAl38pUIOFab5MCFXJ
        fi6a+P3yuRIgIs2H5z5ACEU=
X-Google-Smtp-Source: AKy350a3BSkiR0s1jrBpd0I/e4AY6cWIqfZvZCzekO7pUbc9cauU+xeO5/epUoeNVsp2v/te2PEFpA==
X-Received: by 2002:a05:6000:10c1:b0:2d0:58f9:a6b with SMTP id b1-20020a05600010c100b002d058f90a6bmr4436606wrx.13.1681718293157;
        Mon, 17 Apr 2023 00:58:13 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d4e51000000b002f01e181c4asm9915931wrt.5.2023.04.17.00.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 00:58:12 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:58:09 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Fix W_DISABLE# does not work after
 stop/start
Message-ID: <0c843f46-ec0f-4b45-8684-d78b087bde32@kili.mountain>
References: <20230414183452.GA12295@matrix-ESPRIMO-P710>
 <2023041515-overhung-grime-d9fc@gregkh>
 <18cc3a02-dd57-787f-4c99-cbae259e838d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18cc3a02-dd57-787f-4c99-cbae259e838d@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 07:55:32AM +0200, Philipp Hortmann wrote:
> On 4/15/23 18:02, Greg Kroah-Hartman wrote:
> > On Fri, Apr 14, 2023 at 08:34:52PM +0200, Philipp Hortmann wrote:
> > > When loading the driver for rtl8192e, the W_DISABLE# switch is working as
> > > intended. But when the WLAN is turned off in software and then turned on
> > > again the W_DISABLE# does not work anymore. Reason for this is that in
> > > the function _rtl92e_dm_check_rf_ctrl_gpio() the bfirst_after_down is
> > > checked and returned when true. bfirst_after_down is set true when
> > > switching the WLAN off in software. But it is not set to false again
> > > when WLAN is turned on again.
> > > 
> > > Add bfirst_after_down = false in _rtl92e_sta_up to reset bit and fix
> > > above described bug.
> > > 
> > > Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> > > ---
> > > Tested with rtl8192e (WLL6130-D99)
> > > Transferred this patch over wlan connection of rtl8192e
> > > ---
> > >   drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > 
> > 
> > What commit id does this fix?
> To me the driver was introduced in V3.2 and the issue did not change up to
> now. Have a look at:
> https://elixir.bootlin.com/linux/v3.2-rc1/A/ident/bfirst_after_down
> https://elixir.bootlin.com/linux/v6.2.11/A/ident/bfirst_after_down
> 

Just resend with a Fixes tag.

regards,
dan carpenter

