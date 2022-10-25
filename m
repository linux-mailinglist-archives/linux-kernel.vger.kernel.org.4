Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D82A60D28D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiJYRd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiJYRdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:33:36 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEB516F76E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:33:23 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id t26so6120429uaj.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OyZPad/3WHhE2gwwJ2DJTJ1DcO71VNGivu9bC6wvWw=;
        b=pscsm5b/BpqaJkN0jBsSPkChUDNN/W3YFnbeHwF+JJxqSZA27ITi+qCkskd1Q6BWQu
         C8Turxmnig5xHHeNbhDGzOi179zziUiPNv0Wj5VYlnZ1GnZQxA71/9PgTt8LlMtvJ7D5
         8Ypg9GEJnVj26NIpFPSVJwdlYjQbTVJeonesHSyCq4FAp75Pms7Sn13S7aurgmDeAzr/
         s9mX1ysqUqpYWenSAXhc9RzmY5pj5ozDuaGvRwA+0xpdZOX55wYqFVOZ1aPNejeqHh69
         CHkvHUNxKIe+N3lf2mp8Dw7cZnNgh54OTZcDJfyx+kOP3dy+EBZSzz+hvPfe72mfnRyx
         GwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OyZPad/3WHhE2gwwJ2DJTJ1DcO71VNGivu9bC6wvWw=;
        b=XJSL5otWCjqOR0KANcx5dnjtIsM7StX/aiEhM/bpvBf2Ix8x2kIaYLRb0vwRlEomEK
         IU36q1khH0ciRfORzKTAjnMOk5tY6XUmCbroOPTfYhwH9pGVHDgsc+LO72FJCv3QyJze
         kqY3E/j+1JPOqjQWSQtRsAaDwXrAbRIDpz27LxiAgRE41S5JJgMtL2XElULbVJUxHTFE
         cHVLbPZEQ2m8z+p8M0R21df0Bd16vQLxC73L9e4C+n/sTM23ivhzVwSSOIMLEiFhjZ6F
         PJsBnAObVW3MtQQzDWHbW0Yh32DoLwxXLtxnH/KjMqCtCzWGPP7ie6qm7bYuh8GFssBH
         2O2Q==
X-Gm-Message-State: ACrzQf2M4MY92c6FzYLVs/fq0kDUCCb71qcuMo60rjDedFXhwszqyIW7
        aftn7QB6ZcBx68WMtOq7nqviIE/NIhwhk3SkPvc=
X-Google-Smtp-Source: AMsMyM7XF/W4jIUZzRMI9eP6xosy2FNVneg9T5kyYKOgdd9oDBdQhMvGkryw9E4nhgpX+Rdmf+mgoeMPttEoIcLaxHU=
X-Received: by 2002:ab0:b91:0:b0:3bf:2c1b:9788 with SMTP id
 c17-20020ab00b91000000b003bf2c1b9788mr23425835uak.28.1666719202806; Tue, 25
 Oct 2022 10:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221024084925.262289-1-tegongkang@gmail.com> <CA+uqrQDuJQ3yBY8_re===u0f97pyr_hn_VNu6LqLJAZnDeqhVQ@mail.gmail.com>
 <Y1gbOfBBkqt1m5rS@kroah.com>
In-Reply-To: <Y1gbOfBBkqt1m5rS@kroah.com>
From:   Kang Minchul <tegongkang@gmail.com>
Date:   Wed, 26 Oct 2022 02:33:11 +0900
Message-ID: <CA+uqrQA3d96xpVEWEtj245=kqgtN4yJVnPwamOxbFbLUsTSoBQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] staging: r8188eu: cleaning up unused variables
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022=EB=85=84 10=EC=9B=94 26=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 2:22, =
Greg Kroah-Hartman <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> On Mon, Oct 24, 2022 at 08:23:08PM +0900, Kang Minchul wrote:
> > 2022=EB=85=84 10=EC=9B=94 24=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 5:=
49, Kang Minchul <tegongkang@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > >
> > > This patch series cleans up unused variables in r8188eu
> > > causing coccicheck warnings.
> > >
> > > Difference between v1 and this patch is that this patch series
> > > include making function amsdu_to_msdu in /r8188eu/core/rtw_recv.c
> > > into void function.
> > >
> > > Kang Minchul (4):
> > >   staging: r8188eu: remove unnecessary variable in ioctl_linux
> > >   staging: r8188eu: make amsdu_to_msdu void function
> > >   staging: r8188eu: remove unnecessary variable in rtl8188eu_xmit
> > >   staging: r8188eu: remove unnecessary variable in rtw_ap
> > >
> > >  drivers/staging/r8188eu/core/rtw_ap.c        | 5 ++---
> > >  drivers/staging/r8188eu/core/rtw_recv.c      | 5 +----
> > >  drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 +--
> > >  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
> > >  4 files changed, 5 insertions(+), 12 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
> > Oh, I guess patch 4/4 can be fixed as well.
> > I think the function rtw_sta_flush can be void as well.
> >
> > I'll resend the patch later.
>
> You broke the build in this series, please fix up and send a v3.
>
> thanks,
>
> greg k-h

I just fixed and sent v3,
thank you for your reply.

regards,
Kang Minchul
