Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C0C6E08A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjDMIJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjDMIJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:09:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4122717;
        Thu, 13 Apr 2023 01:09:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id my14-20020a17090b4c8e00b0024708e8e2ddso3478350pjb.4;
        Thu, 13 Apr 2023 01:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681373367; x=1683965367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3usAevUkwYEPoVZ9NbqmTVdaHoLpUUZfaMzU3BLgVG0=;
        b=KXJn4SfvDxJXHYevdAzbNFUyEQLdpPOxoXmilWt0x0Oy4YzOc8ti0jveON0wxechSc
         YfBb13ritfY6f2CD2cPcFrQHK4rFFNWYWlk8WpNvy8veQH6xQsumg+lzQMflLA0r+sGP
         HQSkzKME6LwJxZ1dUt29l/uXXZ++4zU/FBOqveRtQnxbCE4KSHFkACTXyI1e19bBv5Hm
         WZXHhFbGl1p0OzW+LbQmPjfa2kpthfGpsSQwXUsImjH3NvLWGQgrR3V2WuEGzgdQB7SK
         RgBQ8vCF7nav7pt+oeuEMyHcPS1H2aGcjxmu0C7rNS7BmLtAigqHPUXzDFIFhfeqfxk+
         Va8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681373367; x=1683965367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3usAevUkwYEPoVZ9NbqmTVdaHoLpUUZfaMzU3BLgVG0=;
        b=hObYsuJ/dFyFZIzVCR0PcpUpRy53J1vPVeW6/XkG1leoJQ3p8gGUNkrdLOMbA2v8Ng
         IAZInoBs1ObyzOGIPFpjscGh+JYvu2W2o8iskxo/cT2VRemJbyUIAgcr0HEwtGO0E2aP
         +gCw4QeRhMSlJkJ/yUj5i1SaQqFDJGoag+WQ4Y1+K5JJdZevSUVDdSjQSA5RLIjuO1Sk
         OR2mHW4AIAW0w1Qt2NaaF7hM9qKVzagbADPjhFhzTdVgVmctJQ7uH7hYQGRf/U4HV87K
         4lpP3Bua/s0SByKZ9c8unsI3OggARnzfczxi7JSaBaFTPsBQcIbl2FBUUbDgdOlo1gte
         U1vg==
X-Gm-Message-State: AAQBX9cwSsIb+EA4PIPpoZEsQ4tr1Tfmfkwhup+YS9BRI554Qz8wEHYY
        U1njqXo57yPQlI3FKITGItf7pZSp2VqsNDqfC/E=
X-Google-Smtp-Source: AKy350aAR30SMQ+L46VJ1FOtMUeK13aKw7vnx1FzUZ7sRTuDZSI3dpUKakQtDd/Fn2NzPTGhpfwxG5F2YGAcUWJ+av0=
X-Received: by 2002:a17:903:4101:b0:1a6:8a07:960a with SMTP id
 r1-20020a170903410100b001a68a07960amr215272pld.0.1681373366824; Thu, 13 Apr
 2023 01:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230317100954.2626573-1-zyytlz.wz@163.com> <d05ae776-ee19-2ce0-c06b-9825e5cbea82@linuxfoundation.org>
 <CAJedcCwK8Z_nuBM4NnM1PwbTqTnfX2n6UEy9dd5LKf_GScq=xA@mail.gmail.com>
In-Reply-To: <CAJedcCwK8Z_nuBM4NnM1PwbTqTnfX2n6UEy9dd5LKf_GScq=xA@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 13 Apr 2023 16:09:15 +0800
Message-ID: <CAJedcCxT0ggGbVSQnqpcYcN=5gahUOEwGWZrP4P1Lz29A8Smqg@mail.gmail.com>
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

Friendly ping about the issue.
Sorry that I couldn't make test about the driver.

Thanks,
Zheng

Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8818=
=E6=97=A5=E5=91=A8=E5=85=AD 15:39=E5=86=99=E9=81=93=EF=BC=9A
>
> Shuah Khan <skhan@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8818=
=E6=97=A5=E5=91=A8=E5=85=AD 06:53=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On 3/17/23 04:09, Zheng Wang wrote:
> > > In vudc_probe, it calls init_vudc_hw, which bound &udc->timer with v_=
timer.
> > >
> > > When it calls usbip_sockfd_store, it will call v_start_timer to start=
 the
> > > timer work.
> > >
> > > When we call vudc_remove to remove the driver, theremay be a sequence=
 as
> > > follows:
> > >
> > > Fix it by shutdown the timer work before cleanup in vudc_remove.
> > >
> > > Note that removing a driver is a root-only operation, and should neve=
r
> > > happen. But the attacker can directly unplug the usb to trigger the r=
emove
> > > function.
> > >
> > > CPU0                  CPU1
> > >
> > >                       |v_timer
> > > vudc_remove          |
> > > kfree(udc);          |
> > > //free shost         |
> > >                       |udc->gadget
> > >                       |//use
> > >
> > > The udc might be removed before v_timer finished, and UAF happens.
> > >
> > > This bug was found by Codeql static analysis and might by false posit=
ive.
> >
> > This statement that this could be a false positive makes me hesitate
> > taking this patch.
> >
> > What kind of testing have you done with this fix? Were you able to test
> > the scenario of unplugging usb?
> >
>
> Sorry I did't make a full test for I did't have the device. The
> attacking scenario if based on other cases.
>
> Best regads,
> Zheng
>
> > thanks,
> > -- Shuah
