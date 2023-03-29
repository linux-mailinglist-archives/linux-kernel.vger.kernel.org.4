Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CC66CD3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjC2H4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjC2Hz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:55:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD4A132;
        Wed, 29 Mar 2023 00:55:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t10so59590688edd.12;
        Wed, 29 Mar 2023 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680076556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O122BHPc4dPwHwRIK8rluC6nWDBZlMUyHBLwGYixrk=;
        b=H+MF7jiFd70LkK2o3/c8ubP8vxP4hBTwjpF7uR1bVUfZpLBeF55/6I61WDipmc4/BZ
         pK6gHks8KGAv61XTikPoiIWDekaWIh+w+xBsYbqL6bcX+gOBaEoW87OqhVqRPz+qdnj+
         a2J7LCrxMLjLruJ7GrVkSBGLeTXol0LIIkaIQB+eeUvggpJUD6RjvzVaRZ27pxFeH3kZ
         XaXrzbpnV/zv1ktGdVVI9tHdO/n6c2wcd5nmoOrbA6U5Ff5wCYEnUKqvqOhRRRGazoej
         l0gMA2DnOefuot8IWET0EsLOjUOoE7Mqi+ugLjzquOPAh3bKXz1Pbx0lv/WnjrQG3W8k
         N/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680076556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4O122BHPc4dPwHwRIK8rluC6nWDBZlMUyHBLwGYixrk=;
        b=0r/jIi+s0rAU4NVD4jCp/yQGqoEKEKtIoJaQTlnUEXnfjDB51PIq3n/MApt0/Wo+n5
         B4HxnruWE42txn441oX5URAjXR8UIcxlHxUf7OsFXTFid/jZ6OGRfIkdZfR/VahOLXOh
         wgtZMJxJaLPKstPome5nwIYTjTi1eCcRTIV+V10Bye1Iu0gc97PuajF3RbYDEULmkUis
         ofddMJivVXx1DEv3KrmTm2D6d6bezH7+GhdAN+ncCkF0cD9KsK8Vzp3jZ3n8+Yy2hF/h
         S6aUm/kMJchrQNhUn2AU+I5vvaE92A8dHid9W/shp/y9Ya14Co7u3IKQqVkERgUCPDOK
         y43A==
X-Gm-Message-State: AAQBX9cBFVuX0NWkVUz6Pp+qlRalZGRYFxKHvcaf0gVm+YlA5j0Gvfgf
        B67VksjFGCMsOUNU7J7twF9Tw2jpPhpw+VBatQ0qr/is8rRsmQ==
X-Google-Smtp-Source: AKy350bYgczfkDMQ+rkb7XZAKJDkzRqUeBy6lQaMqCcvM4QYWIn0zhuAB9N2q7F7VmQbOUsj1fN0OWw8udsQvzujhI0=
X-Received: by 2002:a17:907:b60b:b0:8ae:9f1e:a1c5 with SMTP id
 vl11-20020a170907b60b00b008ae9f1ea1c5mr9088512ejc.3.1680076556438; Wed, 29
 Mar 2023 00:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230329071724.11082-1-lukas.bulwahn@gmail.com> <ZCPrKaIcsoj3Vvcs@kroah.com>
In-Reply-To: <ZCPrKaIcsoj3Vvcs@kroah.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 29 Mar 2023 09:55:45 +0200
Message-ID: <CAKXUXMxbPQEgryovSdjiRu9zgXXfsHnoTkZFH_doMzHA=2rDcA@mail.gmail.com>
Subject: Re: [RFC PATCH] usb: move config USB_USS720 to usb's misc Kconfig
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 9:39=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 29, 2023 at 09:17:24AM +0200, Lukas Bulwahn wrote:
> > The USS720 parport driver source code is in drivers/usb/misc/, the
> > corresponding config is defined in drivers/usb/Kconfig. Some digging in=
 the
> > kernel's history revealed no good reason why it needs to be defined in
> > USB's top-level Kconfig file, and why the config for the USS720 parport
> > driver should be the first in the list of USB port drivers, while all o=
ther
> > configs for drivers in drivers/usb/misc are in the USB Miscellaneous dr=
iver
> > configuration file.
>
> It is that way because this was one of the first USB drivers we had, and
> we only had one Kconfig file at the time and no misc/ subdir in the usb
> directory.
>
> So it's just inertia, that's all.
>
> Your change looks great to me, want to resend it without the RFC so that
> I can apply it?

Thanks for the quick response and confirmation, Greg.

You will find the patch without RFC in your mailbox and on lore.kernel.org =
at:

https://lore.kernel.org/lkml/20230329075125.32352-1-lukas.bulwahn@gmail.com=
/

Best regards,

Lukas
