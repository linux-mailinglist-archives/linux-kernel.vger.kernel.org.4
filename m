Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4759170D7D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbjEWIrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjEWIrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:47:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D7A95;
        Tue, 23 May 2023 01:47:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f7377c86aso807213966b.1;
        Tue, 23 May 2023 01:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684831656; x=1687423656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ahriv3hQPzNSBqcQ2rj+8i22uvJ5XInYHJKUuq+mYbY=;
        b=JnF400TtbkaYPHYhbIrzx2dVLpG47PGKsWxw0bkfG2TgKD7uDKjPhVXuHmjsrfMgOW
         MsS3nMweZyuW0Q5biW8UdmIKi1nYRU5Ic5qwO4d+XShLk4uuuBqtkfPdyNMULkspsqZk
         4OxCP3J9tSq1IRpxdECQMsTjYXBJ/mXh+sIE20IPk52Bp/omnpnJaza290eZ6GmUUCM7
         B+XmGm0AojhfWsjvfqXXBCaSm99xL0+JEg24JymtHMHKCR2/1HjBXydfrON+rdvPsJTT
         id/tNt4pZ5hWppWJbzp1VbBdZkfUX5njvs4mbAR/lrtcb9NaQwAX3uQkOurSi+wFF7kf
         K0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684831656; x=1687423656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ahriv3hQPzNSBqcQ2rj+8i22uvJ5XInYHJKUuq+mYbY=;
        b=alfG3+32u1WWZnb33P1eyqQWAF5j7UmC9kLXPr3MlsMt1oXrXJ9etFi657pN2vtxkC
         VePiOQ1/A/0Z7tTWE8fhUiM0mNHFhEQBYhB1DeK+mEu/JrGrhm3Vrm8MwgqUxU9dGZ82
         aPbR5xu9tcW5bvJ5iRhupsFXb1Lnj3Fb4iPE5YSA3ub2GuEMocZ09gD81ASDZ4n0Y6O2
         TOep1gDaIq2qMinHrBAYDunAAeW6P750ii/2MgttpS0kGuENNWBCj+R74PuhtssrR2vL
         /X4NRorcF9VOoBWmoZXlanSfz8y+JItHXiGibHdYMkcH9kQu0dfoyYWsYbYsZzcnwfKc
         jtnw==
X-Gm-Message-State: AC+VfDz0HnBhWzKxloZweCAiEUPur1s6+H7MClZ0DDYpoWeTXX8xcG+z
        bTfyN+JjQl73eYMK3Eg04DVWvwY9NgadrQVp16U=
X-Google-Smtp-Source: ACHHUZ50NeMWkjSlcZx1u8oDl6ktW+PpUTtcmM2C8u5cx7WkQUT59/lfkbl9YMZq38S3+Ci+P+vfiyTNBrftMORq0aM=
X-Received: by 2002:a17:906:d550:b0:966:4bb3:df63 with SMTP id
 cr16-20020a170906d55000b009664bb3df63mr14605361ejc.63.1684831655291; Tue, 23
 May 2023 01:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230522190412.801391872@linuxfoundation.org> <OSBPR01MB3783F0D4C6006FFF6DF9AA28B7439@OSBPR01MB3783.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB3783F0D4C6006FFF6DF9AA28B7439@OSBPR01MB3783.jpnprd01.prod.outlook.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 23 May 2023 09:46:59 +0100
Message-ID: <CADVatmOB3ENUQXojP61fahwfMfRTAJ5WwDEN1fWQq+GzuHyduw@mail.gmail.com>
Subject: Re: [PATCH 6.3 000/364] 6.3.4-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        Chris Paterson <chris.paterson2@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, 22 May 2023 at 21:29, Chris Paterson
<Chris.Paterson2@renesas.com> wrote:
>
> Hello Greg,
>
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Monday, May 22, 2023 8:05 PM
> >
> > This is the start of the stable review cycle for the 6.3.4 release.
> > There are 364 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> > Anything received after that time might be too late.
>
> I'm seeing a few build failures with Linux 6.3.4-rc1 (20efcce0526d) due to the drivers/usb/host/xhci.c driver:
>
> drivers/usb/host/xhci.c:497:19: error: static declaration of 'xhci_try_enable_msi' follows non-static declaration
>   497 | static inline int xhci_try_enable_msi(struct usb_hcd *hcd)
>       |                   ^~~~~~~~~~~~~~~~~~~
> In file included from drivers/usb/host/xhci.c:22:
> drivers/usb/host/xhci.h:2146:5: note: previous declaration of 'xhci_try_enable_msi' was here
>  2146 | int xhci_try_enable_msi(struct usb_hcd *hcd);
>       |     ^~~~~~~~~~~~~~~~~~~

I am also seeing this same failure on arm (exynos_defconfig and
hisi_defconfig) and mips (cavium_octeon_defconfig)


-- 
Regards
Sudip
