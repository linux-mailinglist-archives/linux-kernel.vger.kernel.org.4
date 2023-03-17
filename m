Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF166BDFDF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCQD7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCQD73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:59:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132639F061;
        Thu, 16 Mar 2023 20:59:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s8so2242392pfk.5;
        Thu, 16 Mar 2023 20:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679025567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKJzSlTJpBJFu2IaJinbkxWa4ifRpptUf4ymisbVbQ8=;
        b=bX9Hoi/QV/VUr+RA8FdesEPmGW5aXbdx++PyiH+1QXTixGuQpIba0Uz3MCEdj3pP0J
         fFZiB4WYv6WpdxBo7aObcuK5b/PfQFbmhctogurcjTyL2jRKbV1100sOv+HGVFuEdlE5
         b68JqBbq5TQlxL59EtAY0KCSjmY+LVI6RjZZeB0WVyLmWiSrJpoPbk+gqmByGNCzzX46
         nAd8pp3mJfzpDfR320RYejVFZRUqTuCSwEdvOnxg1BVOYKoSOIb9uXGDaUXyOFP/Uy5M
         MpzzTxiGQD3AOazG00emKZrTL8GKganYq7Z+t/nLY6W7ezxBHjiN7OFbxYyOIfa74j8J
         aRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679025567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKJzSlTJpBJFu2IaJinbkxWa4ifRpptUf4ymisbVbQ8=;
        b=jE3pDTEVOegfsKWPf53ExsafGHOopt+hoDa/7BYC+cLv5u0X1Ei8RcL8uyyP73Mq0f
         bTb3tFnVI6OTXuo+cr0Qje0ZEx7nUCxmyWmaVz7ZRFZcRaas1YefD11JDBzq6FIQ6krn
         E+XlXkmsfPxYmWAidO+pXjygoPxeld4QLe+84fUHeI6Vki45NfREiYnFvXFRjSFd5t42
         Cc+t8hRMo2bgFQnEnl/iwqDHpmtIR5Hquv8rU36Z4tNhRk0VL8P1XhAHEBCQMtTxRvxp
         lhh6GKQrta1VNDP8OGbvjKzAly/t/OOA8ArAv3GVA0aEX0j3Toz7ToErERrnIlNHkcQR
         8+BA==
X-Gm-Message-State: AO0yUKVYbEv6C2oZOmCglAS1+j73ZpU9ZhkFPbASvp1aU0hC9Qp7GVme
        lH0VdQSpheSq1kKfv6pwJfgNd8ePFYjSJ/yQUcip5H0raWLQP4PE
X-Google-Smtp-Source: AK7set+QT5wohYxkBAwCODifmUK+68IdRD91hK+QCen+trV+tLX9LbsGMWId0YeN4GcQqtr96PkatvKLxViMzdd1gQA=
X-Received: by 2002:a65:528c:0:b0:50b:18ac:fbea with SMTP id
 y12-20020a65528c000000b0050b18acfbeamr1574474pgp.9.1679025567424; Thu, 16 Mar
 2023 20:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230316180940.1601515-1-zyytlz.wz@163.com> <a83b2f5f-732c-6d71-3e0c-1dce76076817@linuxfoundation.org>
 <CAJedcCyb_XP=X=2XzjKJ-ay=mzPdEJEdRsAcU2KbeaQPjLaW3g@mail.gmail.com> <ZBNpf5X+y26+eKYf@kroah.com>
In-Reply-To: <ZBNpf5X+y26+eKYf@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 17 Mar 2023 11:59:16 +0800
Message-ID: <CAJedcCwAU+piERJcthGTOY4+MKqjrGNYiNVAvTN5JQ4ugrjPjg@mail.gmail.com>
Subject: Re: [PATCH v2] usbip: vudc: Fix use after free bug in vudc_remove due
 to race condition
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Zheng Wang <zyytlz.wz@163.com>,
        "valentina.manea.m@gmail.com" <valentina.manea.m@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
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

gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=
=B43=E6=9C=8817=E6=97=A5=E5=91=A8=E4=BA=94 03:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Mar 17, 2023 at 02:27:05AM +0800, Zheng Hacker wrote:
> > =E5=9C=A8 2023=E5=B9=B43=E6=9C=8817=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=94=
=EF=BC=8CShuah Khan <skhan@linuxfoundation.org> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > > On 3/16/23 12:09, Zheng Wang wrote:
> > >
> > >> In vudc_probe, it calls init_vudc_hw, which bound &udc->timer with
> > >> v_timer.
> > >>
> > >> When it calls usbip_sockfd_store, it will call v_start_timer to star=
t the
> > >> timer work.
> > >>
> > >> When we call vudc_remove to remove the driver, theremay be a sequenc=
e as
> > >> follows:
> > >>
> > >> Fix it by shutdown the timer work before cleanup in vudc_remove.
> > >>
> > >> Note that removing a driver is a root-only operation, and should nev=
er
> > >> happen.
> > >>
> > >> CPU0                  CPU1
> > >>
> > >>                       |v_timer
> > >> vudc_remove          |
> > >> kfree(udc);          |
> > >> //free shost         |
> > >>                       |udc->gadget
> > >>                       |//use
> > >>
> > >> This bug was found by static analysis.
> > >>
> > >
> > > Tell me which static analysis tool did you use to find this and
> > > the output from the tool.
> >
> >
> >      This is found by codeql=EF=BC=8Cthe rule is complicated. It     fi=
nally found
> > there is no timer stop behavior in remove function.
>
> When using tools like this, you are required to follow the rules in
> Documentation/process/researcher-guidelines.rst
>
> Please do so here.
>

Thanks for your assistance. I'll read it carefully and keep that in mind.
And I'll append more information in the next version of patch.

Best regards,
Zheng

> thanks,
>
> greg k-h
