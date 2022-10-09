Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415AE5F8A04
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 09:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJIHeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 03:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJIHeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 03:34:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158573386C;
        Sun,  9 Oct 2022 00:34:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bj12so19099217ejb.13;
        Sun, 09 Oct 2022 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TcltXX1LdWoOAyefprBIZA4YErGm5XD+4QXIrmFx73U=;
        b=Mf1Rn9gLGA6iv8vxQbOOODoJJCL/sBVy+ZOQflKcDqjO6kFJ2WeSvKrFRjqjhabGdl
         55sETv4Dqd8VVhjwlxVCkhDL9qXAJTfSWUZL4c1VgBv67+ivy4RPiZc1DdyAiZoloq2V
         cFLTAjcLWx6m2Ph0q5ZOnk5WEK7fMmPwUucrZHseo/7iRc2P2tZhoLAe/9/ezIzKnRXa
         a73BN8lRoE5cXAEXY2jYVOAuMWOCDi3T1hTXTX2VCcRQzUyWeCFGBO0liAHAstQN4Ian
         gi9lqdiFaLqfx9N7ZAvkkKf4pjBtjxpLV3AA9+3SBWt4kpINDyIZmR0cCg1RytRO9Cwb
         pokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcltXX1LdWoOAyefprBIZA4YErGm5XD+4QXIrmFx73U=;
        b=01lgSw0nXb+bY9I2+b2237UIFDk9U81o7Gbvl3sAdRB70GyMMtYGUvcguCjYH7zWpM
         olOh//n8H21gr98u9lDg79to5+sUC7V333i3UEyR9d9scQH1NEbfApxGqXx/ZaSJr8tC
         NSYQ26i2e/a2e7m8ZzDKJRP7bIuwmscqi3T05eRmE/Rm+gGuwdRha/x7qLqU66xKCRt+
         qJGGtkT4QOb42V7Ky59S8O0u9Q7aAjG/565jXuL/oV7uQrGO2wI+Iiwhkft5TWm7dUT5
         Lq6ukNrUBGt/FHMbIJpy2Ka+aw8ikSYMWN5odjAgoVQZo9EIqOdteRgP2z+MybbesScH
         RV1Q==
X-Gm-Message-State: ACrzQf2TdivI8DR4xIbRDzq2HpBg9nnuoFHfY3/boYoG/j0fRCbtCZke
        Sj3AepKthnAf7FNSlDLAIhXVyw/uVJh7wGyE9jo=
X-Google-Smtp-Source: AMsMyM5eel8bBb92o0PnLkdYxvua+NJAD7IPlPSX97TIlrOLGp4WigSjsxkTvYyQfCLwehPv8Hx5xRnt3ySPBTakMxE=
X-Received: by 2002:a17:906:7310:b0:782:cfd4:9c07 with SMTP id
 di16-20020a170906731000b00782cfd49c07mr10841307ejc.708.1665300858584; Sun, 09
 Oct 2022 00:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221009053245.154922-1-dzm91@hust.edu.cn> <Y0Jv0zkDYM9nuPol@kroah.com>
In-Reply-To: <Y0Jv0zkDYM9nuPol@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Sun, 9 Oct 2022 15:33:51 +0800
Message-ID: <CAD-N9QW8jpdHv71eCQvRb6g1oZHBPH6y39V=5fuvcVPgtZJN-Q@mail.gmail.com>
Subject: Re: [PATCH] usb: cdns3: adjust the partial logic of cdnsp_pci_remove
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Pawel Laszczak <pawell@cadence.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 9, 2022 at 2:52 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Oct 09, 2022 at 01:32:45PM +0800, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > In cdnsp_pci_remove, if pci_is_enabled returns true, it will
> > call cdns_remove; else it will call kfree. Then both control flow
> > goes to pci_dev_put.
> >
> > Adjust this logic by modifying it to an if else.
> >
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>
> Your email address does not match your From: address, and your From:
> address is saying it is being spoofed and not correct :(
>
> Please work with your school to fix your email system and do not use
> gmail to hide it.

My git config uses Gmail. I forget to change this after I joined the
new school and changed sendmail configuration.

I sent a new version several minutes ago.

>
> thanks,
>
> greg k-h
