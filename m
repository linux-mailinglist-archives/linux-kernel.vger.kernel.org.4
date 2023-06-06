Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC59724E78
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbjFFVH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjFFVHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:07:50 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10451721
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 14:07:48 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-ba81ded8d3eso7925850276.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686085668; x=1688677668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+y6SHVWj4pF5MY20rTsgRdiXa+WcKmixQy00esPM50E=;
        b=EOl30CEB7DhgzpZkCDtMdnYHv0s5KbEzck8NZ0W7b/glhsn6alr/EMW3LpFpl/iDWA
         uu3ytuS0PYp01CPPed8q4xLJyYn3PA7zYqxaYje05z6pZ/c+fTUVgrrAisACcDNn2313
         7/XeK7Fwry+Y5MfcMkdJWyh+bMnhtnVQbLRkm1kd2iZC0sDJxjz3JYTixAh6Tz6YX8Br
         TOLFcb1elE9dahLyOmwEvXUtr974N8YqZ19PSbnCKZ1r5V1UV835o4Eq4l6Wcf7iJ2u5
         /BYNvCzgybmkw7VxzL6SyLQrXQpsdqUh5+LltiGsHIfRqXVI7vD+2+eN65qsWZIhaZgY
         VQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686085668; x=1688677668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+y6SHVWj4pF5MY20rTsgRdiXa+WcKmixQy00esPM50E=;
        b=btDdVBd2g8tus0ApItgWowQz9tkvzeTvRFbi4GPNVn4l0aRUQzjsUlA1ULPciGDcKE
         a/MhrSb5WuZ9BYeWewyDiuSZtM6dl2XIZ7RXvVVe4xsn0mQC0/YzfnEYjpo4a3rB40PR
         mdWQi4WuB4ezwP3OTzRUozD2rQPcwIoC8CIForv3g+QuHUPieSQsN3HDejP4G5Ca8/Z9
         i/8pHME+FMEfg50HE87uTYuVDh64YAWh8E2X2lxYKD41w9ogSb4ht6Rtd2D6TFxl+HyV
         N9zdXfhqJ40BzDbkcKmRAoiiBln9Js/zWqZ55oQELqW8Io6HLEbVA9M/VmXA1TnJp6dx
         ZHpw==
X-Gm-Message-State: AC+VfDxbX3Trc0JG0HwArHfXoVcIH2UdoZsyYZP+NUwGxane87Ohb4Jw
        FJVUyuvJkt14OkKzNGmpSq74YRJAaTZ+3mcihF64
X-Google-Smtp-Source: ACHHUZ4vwsZlEk9YHuhNf3bCf+fatcKXBkSJ0DcAWSvzgq0urD7GOuIBWb8xfuTzhw3cGHrZv11+pp5pbKM9mQOIzlI=
X-Received: by 2002:a81:6f57:0:b0:561:7351:f56f with SMTP id
 k84-20020a816f57000000b005617351f56fmr4311493ywc.24.1686085668022; Tue, 06
 Jun 2023 14:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230602054527.290696-1-gongruiqi@huaweicloud.com>
 <20230606032844.GA628899@mail.hallyn.com> <CAHC9VhT8k87SdD4_JQFwXShwJeBb3KU7C+R5ABAOhDGvvC0X+w@mail.gmail.com>
 <20230606175005.GA639588@mail.hallyn.com>
In-Reply-To: <20230606175005.GA639588@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 6 Jun 2023 17:07:37 -0400
Message-ID: <CAHC9VhTkaXSD4EqeJg-tF_9Pt_6vvJD1eiGnOB3FiHJW20X_NQ@mail.gmail.com>
Subject: Re: [PATCH] capability: erase checker warnings about struct __user_cap_data_struct
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
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

On Tue, Jun 6, 2023 at 1:50=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> w=
rote:
> On Tue, Jun 06, 2023 at 12:45:00PM -0400, Paul Moore wrote:
> > On Mon, Jun 5, 2023 at 11:29=E2=80=AFPM Serge E. Hallyn <serge@hallyn.c=
om> wrote:
> > > On Fri, Jun 02, 2023 at 01:45:27PM +0800, GONG, Ruiqi wrote:
> > > > Currently Sparse warns the following when compiling kernel/capabili=
ty.c:
> > > >
> > > > kernel/capability.c:191:35: warning: incorrect type in argument 2 (=
different address spaces)
> > > > kernel/capability.c:191:35:    expected void const *from
> > > > kernel/capability.c:191:35:    got struct __user_cap_data_struct [n=
oderef] __user *
> > > > kernel/capability.c:168:14: warning: dereference of noderef express=
ion
> > > > ...... (multiple noderef warnings on different locations)
> > > > kernel/capability.c:244:29: warning: incorrect type in argument 1 (=
different address spaces)
> > > > kernel/capability.c:244:29:    expected void *to
> > > > kernel/capability.c:244:29:    got struct __user_cap_data_struct [n=
oderef] __user ( * )[2]
> > > > kernel/capability.c:247:42: warning: dereference of noderef express=
ion
> > > > ...... (multiple noderef warnings on different locations)
> > > >
> > > > It seems that defining `struct __user_cap_data_struct` together wit=
h
> > > > `cap_user_data_t` make Sparse believe that the struct is `noderef` =
as
> > > > well. Separate their definitions to clarify their respective attrib=
utes.
> > > >
> > > > Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
> > >
> > > Seems ok.
> > >
> > > There's still so much noise in the make C=3D2 output even just for
> > > kernel/capability.c that I'm not sure it's worth it, but no
> > > objection.
> > >
> > > Acked-by: Serge Hallyn <serge@hallyn.com>
> >
> > I'm guessing you would prefer if I pulled this via the LSM tree Serge?
>
> Yes, please.

Done, it's merged into lsm/next.

> > FWIW, if that is ever the case for future patches, just add a note
> > when you ACK something and I'll pick it up.
>
> Thanks, will do.
>
> If it starts happening more than once or twice a month, then I'll get my =
tree
> into shape and start cueing up patches...

No problem, as long as the patches are fairly trivial I don't mind.

--=20
paul-moore.com
