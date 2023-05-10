Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABED56FE2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjEJRBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbjEJRBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:01:11 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B835588
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:00:54 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-333866a265fso42884575ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683738053; x=1686330053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBtF7LYkXSUt83SUWJ9QjemTqyVA/iZGdvboiNmRLKo=;
        b=A+R7ioq0e74ZvC0NZ/Z7xGTuJG2Um8qhEGCM7Yx/wgrYSnsf353gWtHqFoThC9KRtz
         Z42CTDGdljcZXtww9Su9lbBYEPVrO+LdhoP/FPgP9+5UcL8lKMjE2ZHpMa/gkmcwBIFY
         GZiMb3Wdisz+9RzjXnvLQZBO5HG5Q4tZx0ca3ecPL2IQrVhYg1NSzADYmvCp/VZHLO4a
         8uqIKS0oXHj++3PgwXtyM7W2aXMk1uAQ2MsBedUgPQ3ymx2PQTpX0zDSL424EiROh/ap
         FgLDvZOCl3FAgr1VL43ll+L8Fk72JMowJiGc7hEVd9WE8Z/ldJHu3Clhl53HOzVyN9y3
         /axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683738053; x=1686330053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBtF7LYkXSUt83SUWJ9QjemTqyVA/iZGdvboiNmRLKo=;
        b=UOokev/Ud8OFe4p2dB97zeq2UuWvJHpN6uVC+84cDeN9X47/JCis7CkqoiDgw+AAkc
         0y/T+6j1546NjsPqPIK15fX24d1tsatLQZtPxe3/OqfX6QfGIg4ovtl974RlagfMV7n7
         0gm+lQdFxF4idLyUpaO142/3ZlYCeFJZMsZZmAMb9vu9aDmMQONQt16F96WzYovn0j6Y
         4PhLibceDqAAzwmbkoTF0hxm19v4l8sOHfYczeiIeZMnf81GRz9DGUEQqtY9ILjPEwkx
         iZ9bA3OSnfPZIhFQkYr7V2HLJdbplyJuuX4QwjCL2tcc1MLOWi1FowjxyWESdfV9QNnf
         ggHQ==
X-Gm-Message-State: AC+VfDypyXetLzHyDWOUUw6uryTU6Qh/LzqxukliWf2azIHW5ebOSSAN
        2L7OPMqIE0w4SYL08HQ992X1Hv9ChzxzP4+0+1ETYw==
X-Google-Smtp-Source: ACHHUZ5N9CS3CqU4NU1sy+urJFNG0b8bx2si2jJT7pLVYWpiBuXIOYmwNDCAOsTy75ZvINZV52K8ENNUmr4PnELimYw=
X-Received: by 2002:a92:d245:0:b0:330:f7b3:ea4 with SMTP id
 v5-20020a92d245000000b00330f7b30ea4mr13478553ilg.2.1683738053613; Wed, 10 May
 2023 10:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030611.521807993@linuxfoundation.org> <863a112f-f4a4-d580-9687-f6214d555939@linaro.org>
 <2023051035-monitor-sandy-2a5b@gregkh> <CAEUSe79AViqsHimbYbFjkKAxcvROGhFKA2yKVuC3aP1Gm=jc1w@mail.gmail.com>
In-Reply-To: <CAEUSe79AViqsHimbYbFjkKAxcvROGhFKA2yKVuC3aP1Gm=jc1w@mail.gmail.com>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Wed, 10 May 2023 11:00:42 -0600
Message-ID: <CAEUSe7_ZBW_hPUZYeKkZ6zuckeqYb+O46GdgGx0wE6T0=c5wZg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        laoar.shao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, 10 May 2023 at 09:46, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wro=
te:
> Hello!
>
> On Wed, 10 May 2023 at 01:43, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, May 09, 2023 at 09:12:33AM -0600, Daniel D=C3=ADaz wrote:
> > > Hello!
> > >
> > > On 08/05/23 21:26, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.15.111 relea=
se.
> > > > There are 370 patches in this series, all will be posted as a respo=
nse
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > > >
> > > > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patc=
h-5.15.111-rc2.gz
> > > > or in the git tree and branch at:
> > > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-5.15.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > New warnings are introduced for Arm, PowerPC, RISC-V:
> > >
> > >   /builds/linux/kernel/sched/debug.c: In function 'print_cfs_group_st=
ats':
> > >   /builds/linux/kernel/sched/debug.c:465:41: warning: unused variable=
 'stats' [-Wunused-variable]
> > >                   struct sched_statistics *stats =3D  __schedstats_fr=
om_se(se);
> > >                                            ^~~~~
> >
> > Odd, and this isn't on other kernels too?
>
> Only on 5.15, not on the 6.x RC's. I'll share more info after my
> bisection is done.

Bisection leads to:

  sched: Make struct sched_statistics independent of fair sched class

Reverting makes the warning disappear.

Greetings!
