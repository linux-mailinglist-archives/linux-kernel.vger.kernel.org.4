Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E146E1A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDNCdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNCdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:33:50 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3754E3AAE;
        Thu, 13 Apr 2023 19:33:49 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s72so17539230pgs.9;
        Thu, 13 Apr 2023 19:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681439628; x=1684031628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPvYNz8siUVtinxrnX/aB2GWosarSU2usvrXoKI9CcQ=;
        b=FRDTh8E1zL3Li72pg0jFgweEiwXg1JBlQbUEojjRDAq+iH9rv1w2HDqrNFP/IikKB8
         2YmtYYaaxqQyyEGYD0Ewq24hDBieZLfPE7MmPck3j22NB2gfjbEtDy3SFTR+XthPm0ic
         p4YrUN4CCGV4ssK6c3DeWwWcl74tpzN+VzQXn8t7n9w9MkQCRmS6IjVKZB2BaHs4MS15
         jYdNr/+tVVZ5Y8w92IzpwhQbAV/C0iK9mMCNjw0rEGmj69rofn4f44fugkSOnImaI99W
         J4ZmfOxvp7Ko++4NEZlqf24acvBN0vizMkZbRuBMK9mZjyrDfPWNVgQxOh+aJzrhnVIS
         h2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681439628; x=1684031628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPvYNz8siUVtinxrnX/aB2GWosarSU2usvrXoKI9CcQ=;
        b=JYmMuUVS7bFL5yOPuImx5tdI1kmkMC/HDlYAtshW83MJ3AEWpQHHBZDLjRUjcH+pnL
         P17bW9yDQMq8SCPnUZwns2ln4OwEev6e22eu3/3DVVZTRQ2DKYN1SVgjUEnRuQT9CiUp
         NhtxLzgf5zdn6Rpnqoe01rtm+o7B+kUXc6tDoWy56yLXOzUG1wlOCm45cvean13cbi4j
         IcWnBvdYYHQxE3LitI4nV/bIoseBgkIIUkVscx2gj76YkGfg53Jg/Jdzekebkiz9q6zc
         bBsSeyv7hocxU8bZQAvuqQRVqzFTnuWMSOXVO0oRJlp07yP+vzst4uLQe8wImyvUNJUq
         XjQw==
X-Gm-Message-State: AAQBX9fQw0lZCBo1dQwgD0YA2ZmGSt7Nssp8RGoaniJ49YIbzQpumGyH
        exH8ZZIiDIU5kPmYwgdVdhl0dFiLTDWwhmyn9Qo=
X-Google-Smtp-Source: AKy350ZrdkiwCtRVpyc+PO3lwBgZ/K/EfAGLuzTcsL5LYA9kUsoxJngWFZrehRVcUmiJdFijOO+LR8n1vhxTlDtNwKU=
X-Received: by 2002:a63:c001:0:b0:503:a7:d244 with SMTP id h1-20020a63c001000000b0050300a7d244mr298115pgg.9.1681439628623;
 Thu, 13 Apr 2023 19:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230317100954.2626573-1-zyytlz.wz@163.com> <d05ae776-ee19-2ce0-c06b-9825e5cbea82@linuxfoundation.org>
 <CAJedcCwK8Z_nuBM4NnM1PwbTqTnfX2n6UEy9dd5LKf_GScq=xA@mail.gmail.com>
 <CAJedcCxT0ggGbVSQnqpcYcN=5gahUOEwGWZrP4P1Lz29A8Smqg@mail.gmail.com> <8219a54a-f83d-f31e-bd10-74660d829a06@linuxfoundation.org>
In-Reply-To: <8219a54a-f83d-f31e-bd10-74660d829a06@linuxfoundation.org>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 14 Apr 2023 10:33:35 +0800
Message-ID: <CAJedcCxCK-J1zfKNU9q1VCxNJS-0kbeMc5XqVy2z6hatoEQBcA@mail.gmail.com>
Subject: Re: [PATCH v3] usbip: vudc: Fix use after free bug in vudc_remove due
 to race condition
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

I got it. I'll try it.

Best regards,
Zheng

Shuah Khan <skhan@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=BA=94 02:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On 4/13/23 02:09, Zheng Hacker wrote:
> > Friendly ping about the issue.
> > Sorry that I couldn't make test about the driver.
> >
> > Thanks,
> > Zheng
> >
> > Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=
=8818=E6=97=A5=E5=91=A8=E5=85=AD 15:39=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Shuah Khan <skhan@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=
=8818=E6=97=A5=E5=91=A8=E5=85=AD 06:53=E5=86=99=E9=81=93=EF=BC=9A
> >>>
> >>> On 3/17/23 04:09, Zheng Wang wrote:
> >>>> In vudc_probe, it calls init_vudc_hw, which bound &udc->timer with v=
_timer.
> >>>>
> >>>> When it calls usbip_sockfd_store, it will call v_start_timer to star=
t the
> >>>> timer work.
> >>>>
> >>>> When we call vudc_remove to remove the driver, theremay be a sequenc=
e as
> >>>> follows:
> >>>>
> >>>> Fix it by shutdown the timer work before cleanup in vudc_remove.
> >>>>
> >>>> Note that removing a driver is a root-only operation, and should nev=
er
> >>>> happen. But the attacker can directly unplug the usb to trigger the =
remove
> >>>> function.
> >>>>
> >>>> CPU0                  CPU1
> >>>>
> >>>>                        |v_timer
> >>>> vudc_remove          |
> >>>> kfree(udc);          |
> >>>> //free shost         |
> >>>>                        |udc->gadget
> >>>>                        |//use
> >>>>
> >>>> The udc might be removed before v_timer finished, and UAF happens.
> >>>>
> >>>> This bug was found by Codeql static analysis and might by false posi=
tive.
> >>>
> >>> This statement that this could be a false positive makes me hesitate
> >>> taking this patch.
> >>>
> >>> What kind of testing have you done with this fix? Were you able to te=
st
> >>> the scenario of unplugging usb?
> >>>
> >>
> >> Sorry I did't make a full test for I did't have the device. The
> >> attacking scenario if based on other cases.
> >>
>
> Sorry. I really need for you test this and provide information on how
> it was tested.
>
> thanks,
> -- Shuah
>
