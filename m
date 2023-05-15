Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E493702F54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbjEOONH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEOONE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:13:04 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD8D1727;
        Mon, 15 May 2023 07:13:03 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ac82912a59so135948651fa.3;
        Mon, 15 May 2023 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684159981; x=1686751981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chkZheqYGYzsbUmgQjZR+WqcgawPReoRF0Mt00D+UqA=;
        b=ZWgwlfvxUB0S1xeKw6ZiyF3zHl+Ipk8aw00WTABAru+4kbJOBcNVp1Sj3CO+7d6u5g
         HeyfCghJDQ44KYgn4QplEzIuFvahGuj81Z4oVxHyzseIyEZCclcNYM9CDRWqdgefvyEv
         NOEcgnG/6C6FwlsYlIX5+jXPgp1ofnBj9p7mVVkFpNlYUp3jbB8bJv+ZpN/+jap6aHGR
         T7mHLQfxij8LU+RwHR4iQ1IXSTBxDI6Algmns6BFaf2PP2L1taRE7KhZdbLHH87wfpgz
         9QMiOWlotkDY4eYDFhNnkih7JuhydLS9ihxtbK2ljwejc49UZxUkD/ysrHy/UVB2FW9q
         +eEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684159981; x=1686751981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chkZheqYGYzsbUmgQjZR+WqcgawPReoRF0Mt00D+UqA=;
        b=ahQIH0qbMWSZBMbz1hO6njRt26so77uHp+Kf0XRyvSDdJKvDu4JghxbihJby7rVG6j
         yJ560xNiQtnS2CH6HTvBYR/IBE6aUgOLijpfusyoWe5t/6WfuhF16qx2I95NA/QPlhqe
         V14lAVjPuVXMs6IPEv0gnSWKzB1Vyxuuw6/+GB3i8x7ZVVjA2EVHOaH49a8HdJoPrO9o
         6RY5Xy6jXvlQlD34nAPiTEk+zp+xFUwB8fqtvknFy4jBXBNF3yfinrTS8BREhSBEMIUj
         7XRU2v/U+KVBC0B6RshzqoCMyY3rHdAQYYUZm3mqxYzgBcOtJ7tIHvIi6WTcWypCmoYK
         clzw==
X-Gm-Message-State: AC+VfDz16HPWi8/4NcRhBL1cjV2Hcy4MIdQDJKtsJWYBzzscscQEK1Ke
        /JXN7Lc/9auPQWwAJSADT6NgEBFssPz9bOm2yHXiF4jO
X-Google-Smtp-Source: ACHHUZ6ogG8v/77kF7RT8ye9NqI9NsJg8UC/prEmD6zJhXqj2pb8gMpr++4JY6MvW/Q6CLSF4ztDJDD67mkhC7w5iU8=
X-Received: by 2002:a2e:93d5:0:b0:2ae:d757:4c41 with SMTP id
 p21-20020a2e93d5000000b002aed7574c41mr1649060ljh.23.1684159980843; Mon, 15
 May 2023 07:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-11-jorge.lopez2@hp.com>
 <4537f210-4a7a-3c11-ecbb-ed4762a1f598@linux.intel.com> <CAOOmCE9m5++_4nBu3C64uWVOeyUQs3afn_Q9AJz9oudGvMHHiQ@mail.gmail.com>
 <4a14de7-58fb-4192-496a-279dd4109b6@linux.intel.com>
In-Reply-To: <4a14de7-58fb-4192-496a-279dd4109b6@linux.intel.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 15 May 2023 09:12:30 -0500
Message-ID: <CAOOmCE-gipT5r1ABCkqkfFCdssKEwHhvz47yYnHa1fy74jAsFQ@mail.gmail.com>
Subject: Re: [PATCH v12 10/13] HP BIOSCFG driver - spmobj-attributes
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, thomas@t-8ch.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 4:23=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 10 May 2023, Jorge Lopez wrote:
>
> > On Tue, May 9, 2023 at 8:48=E2=80=AFAM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Fri, 5 May 2023, Jorge Lopez wrote:
> > >
> > > > HP BIOS Configuration driver purpose is to provide a driver support=
ing
> > > > the latest sysfs class firmware attributes framework allowing the u=
ser
> > > > to change BIOS settings and security solutions on HP Inc.=E2=80=99s=
 commercial
> > > > notebooks.
> > > >
> > > > Many features of HP Commercial notebooks can be managed using Windo=
ws
> > > > Management Instrumentation (WMI). WMI is an implementation of Web-B=
ased
> > > > Enterprise Management (WBEM) that provides a standards-based interf=
ace
> > > > for changing and monitoring system settings. HP BIOSCFG driver prov=
ides
> > > > a native Linux solution and the exposed features facilitates the
> > > > migration to Linux environments.
> > > >
> > > > The Linux security features to be provided in hp-bioscfg driver ena=
bles
> > > > managing the BIOS settings and security solutions via sysfs, a virt=
ual
> > > > filesystem that can be used by user-mode applications. The new
> > > > documentation cover HP-specific firmware sysfs attributes such Secu=
re
> > > > Platform Management and Sure Start. Each section provides security
> > > > feature description and identifies sysfs directories and files expo=
sed
> > > > by the driver.
> > > >
> > > > Many HP Commercial notebooks include a feature called Secure Platfo=
rm
> > > > Management (SPM), which replaces older password-based BIOS settings
> > > > management with public key cryptography. PC secure product manageme=
nt
> > > > begins when a target system is provisioned with cryptographic keys
> > > > that are used to ensure the integrity of communications between sys=
tem
> > > > management utilities and the BIOS.
> > > >
> > > > HP Commercial notebooks have several BIOS settings that control its
> > > > behaviour and capabilities, many of which are related to security.
> > > > To prevent unauthorized changes to these settings, the system can
> > > > be configured to use a cryptographic signature-based authorization
> > > > string that the BIOS will use to verify authorization to modify the
> > > > setting.
> > > >
> > > > Linux Security components are under development and not published y=
et.
> > > > The only linux component is the driver (hp bioscfg) at this time.
> > > > Other published security components are under Windows.
> > > >
> > > > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> > > >
> > > > ---
>
>
> > > > +     } else {
> > > > +             /*
> > > > +              * UTF-16 prefix is append to the * buffer when a BIO=
S
> > >
> > > What is "the * buffer" ?
> >
> > It is the data stored in 'buffer' variable which is composed of three
> > strings concatenated together to be submitted to BIOS via WMI call.
> > 'Buffer' will looks something as    [size attribute][attribute][size
> > value][value][auth size][auth payload]
> > size is the length in bytes,  attribute/value/auth are string represent=
ed in u16
>
> Even after this explanation I don't understand why it's called "the *
> buffer". Is that common terminology in this domain (in which case it's
> fine, I just haven't come across such term before)?
>

Point taken.  Replaced 'buffer' variable name to 'authbuf'

> > > > +              * admin password is configured in BIOS
> > > > +              */
> > > > +
>
> [...snip...]
>
> > > > +/*
> > > > + * status_show - Reads SPM status
> > > > + */
> > > > +static ssize_t status_show(struct kobject *kobj, struct kobj_attri=
bute
> > > > +                 *attr, char *buf)
> > > > +{
> > > > +     int ret, i;
> > > > +     struct secureplatform_provisioning_data data;
> > > > +
> > > > +     ret =3D statusbin(kobj, attr, &data);
> > > > +     if (ret < 0)
> > > > +             goto status_exit;
> > >
> > > Can you calculate strnlen() from buf at this point, or is the result
> > > garbage? Should you return ret instead here?
> >
> > It should return the error instead.
Done!

> > >
> > > > +
> > > > +     sysfs_emit(buf, "%s{\n", buf);
> > > > +     sysfs_emit(buf, "%s\t\"State\": \"%s\",\n", buf,
> > > > +                spm_state_types[data.state]);
> > > > +     sysfs_emit(buf, "%s\t\"Version\": \"%d.%d\",\n", buf, data.ve=
rsion[0],
> > > > +                data.version[1]);
> > > > +
> > > > +     /*
> > > > +      * state =3D=3D 0 means secure platform management
> > > > +      * feature is not configured in BIOS.
> > > > +      */
> > > > +     if (data.state =3D=3D 0)
> > > > +             goto status_exit;
> > > > +
> > > > +     sysfs_emit(buf, "%s\t\"Nonce\": %d,\n", buf, data.nonce);
> > > > +     sysfs_emit(buf, "%s\t\"FeaturesInUse\": %d,\n", buf, data.fea=
tures);
> > > > +     sysfs_emit(buf, "%s\t\"EndorsementKeyMod\": \"", buf);
> > > > +
> > > > +     for (i =3D 255; i >=3D 0; i--)
> > > > +             sysfs_emit(buf, "%s %u", buf, data.kek_mod[i]);
> > > > +
> > > > +     sysfs_emit(buf, "%s \",\n", buf);
> > > > +     sysfs_emit(buf, "%s\t\"SigningKeyMod\": \"", buf);
> > > > +
> > > > +     for (i =3D 255; i >=3D 0; i--)
> > > > +             sysfs_emit(buf, "%s %u", buf, data.sk_mod[i]);
> > > > +
> > > > +     /* Return buf contents */
> > > > +
> > > > +     sysfs_emit(buf, "%s \"\n", buf);
> > > > +     sysfs_emit(buf, "%s}\n", buf);
> > > > +
> > > > +status_exit:
> > > > +     return strnlen(buf, PAGE_SIZE);
> > > > +}
> > >
> > > Emit buf into buf? There's sysfs_emit_at(), however,
> > >
> > > while I'm far from sysfs formatting expert, this feels something that
> > > tries to expose more than one thing over same sysfs file. Shouldn't t=
hey
> > > be each in their own files?
> >
> > This concern was brought up in earlier reviews but it was decided to
> > allow returning the information as a single json file.
> > Because the information is part of the same structure and received in
> > a single WMI call, separating the components into multiple files can
> > cause the data read in one field to be stale by the time is read.
>
> Okay, makes more sense. Maybe add a comment that the return is a json
> string because that's not very obvious (I only realized now when you told
> me).
>
A comment will be added.

> The other point is still valid though, you should keep length in a
> variable and use sysfs_emit_at() to avoid printing buf into buf on
> every line.
>
I will update the function as indicated.

>
> --
>  i.
