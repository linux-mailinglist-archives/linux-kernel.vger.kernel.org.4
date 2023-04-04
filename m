Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7211A6D6DF5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbjDDUYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjDDUYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:24:38 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF2E10CA;
        Tue,  4 Apr 2023 13:24:36 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bx10so16885540ljb.8;
        Tue, 04 Apr 2023 13:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680639875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oVf5L1s5vC5i2BV4mWtMiZo2kKfcnDSErU32Isic1c0=;
        b=LFJn/i75qWzTZnNmOARwhUp1VIvYhF57EyWOrDLJMraSpbC3m31EuNymXVDnsaBh25
         FhAYzTfHo9Ev+dUAVrmpib9+g6RWMFb8tqq6Nakq4Sr3gHFndTTiFNZ1j9Vdz9zEBb+F
         C+8XPkOiLBL412T5yo2Zu2rSvdayZaiKVn1pNRSdXmFR8qkfPzqvHUl5OKjNGGLdcIe2
         qwTx6kf22IbLR+VtcLBs+gMygBQQ16ha4RjZYDJgLC3dni4P1b4w9n1yee9TObcqU/h9
         H5wvEvk2LaJ3vj/WT2r4LdS2JrEtJ7oIP679mxNvE+yhQZ6sKxSRuHs4rJyZZts2n4pP
         yDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680639875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVf5L1s5vC5i2BV4mWtMiZo2kKfcnDSErU32Isic1c0=;
        b=s9Z/cPyk4y+TUKBT7yqM1bqBOpd3F1+MfHL+BuDMc41NKpyytqPlrLOVHax9namgxk
         tC84YVlbgLwMTAUu8x3toZ+MeKCjTi0vAk/H0F91ry5bcyVLtLLtiKbwrGTwl/z1kdnO
         ZWfx/tcBcTnnsIh7XjOX3/C16JBrE0IIyb3+j9G0Bz/mkwbbMR6VORunAacc9O+iYbeY
         as2RD4rVJ5LmQLa18pZRKrKVKLspMoAPVQfJRh5cxbqybIdvGFcM6oEFie5YMbORX4F1
         Wh2v0vlQ+EKRsOBn5bv0i4mMM28MuAKSzbldOI6fwviYmqyCykSVhEl5UAHrYCHVKotQ
         lGmQ==
X-Gm-Message-State: AAQBX9fxlZWYJlfTKCzj7M9qjmeeN26+TxCbhHTwrVP/aKcmYeTykjAK
        Yjv9VHLkWLISTtfNPDSVZGAdH1bNLuVTuNKuGMI=
X-Google-Smtp-Source: AKy350bAs0nGXa3BuJqVl2jqEm2na7mau8O6bShq31dmcE6naDoixDWRQlkRnuFwO9FX7EqnoB9mrJypSDMTei9CCYI=
X-Received: by 2002:a2e:6817:0:b0:2a6:334b:21e9 with SMTP id
 c23-20020a2e6817000000b002a6334b21e9mr1420402lja.7.1680639874591; Tue, 04 Apr
 2023 13:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230403211548.6253-1-jorge.lopez2@hp.com> <d5fbc118-3b33-44b8-a7b6-4738e121b170@t-8ch.de>
In-Reply-To: <d5fbc118-3b33-44b8-a7b6-4738e121b170@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 4 Apr 2023 15:24:16 -0500
Message-ID: <CAOOmCE8z_UDs8dG0MqX+SFcvd-CTX12XXKzOrVOKDuvrPkyeCQ@mail.gmail.com>
Subject: Re: [PATCH v7] Introduction-of-HP-BIOSCFG-driver-documentation
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

BTW, I decided to submit all files individually to facilitate the
review process.  Only Makefile and Kconfig files will be provided as a
single patch.
I will be out of town until April 11 and will reply back upon my return.

Please see my comments below.

>
> > +             HP specific types
> > +             -----------------
> > +                     - ordered-list - a set of ordered list valid values
> > +                     - sure-start
>
> Could you explain what "sure-start" does?
> Is it actually an attribute type of which multiple attributes can exist?
>

It is an attribute type of which multiple attributes can exist.
At this moment  Sure-Start reports both the number of audit logs and
all logs reported by BIOS.
Sure-Start is exposed directly under
/sys/class/firmware-attributes/*/attributes/.   Sure Start does not
provide any authentication.

> Or are there just some global properties that need to be exposed?
> If it is global it should be directly under
> /sys/class/firmware-attributes/*/authentication/
> without needing the type.
>
> > +
> > +
> >               All attribute types support the following values:
> >
> >               current_value:
> > @@ -42,16 +48,16 @@ Description:
> >                               description of the at <attr>
> >
> >               display_name_language_code:
> > -                                             A file that can be read to obtain
> > -                                             the IETF language tag corresponding to the
> > -                                             "display_name" of the <attr>
> > +                             A file that can be read to obtain
> > +                             the IETF language tag corresponding to the
> > +                             "display_name" of the <attr>
>
> Are these reindentations and other cleanups intentional?
>
> If they are intentional and there are no interactions with your actual
> patch you could split them into their own patch and submit them
> separately.
>
> This way we wouldn't have to worry about them here anymore.

They were unintentionally.  I will reset them back in the next review
>
> Note:
> These indentations are different from the newly introduced documentation.
>
> >
> > +             audit_log_entries:
> > +                                     A read-only file that returns the events in the log.
> > +                                     Values are separated using semi-colon (``;``)
> > +
> > +                                     Audit log entry format
> > +
> > +                                     Byte 0-15:   Requested Audit Log entry  (Each Audit log is 16 bytes)
> > +                                     Byte 16-127: Unused
>
> How to interpret each log entry?
>

Byte 0: status
1: event id
2: msg number
3: severity
4: source ID
5: system state at event
6-12 Time stamp
13-15: internal buffer data

Application needs to have knowledge of the data provided by BIOS in
order to interpret the audit log.

> If it is an opaque thing from the firmware that would also be useful to
> know.
>
> > +
> > +             audit_log_entry_count:
> > +                                     A read-only file that returns the number of existing audit log events available to be read.
> > +                                     Values are separated using comma (``,``)
> > +
> > +                                     [No of entries],[log entry size],[Max number of entries supported]
>
> Will log entry size always be 16? Or can it be bigger in the future when
> more bytes are used?
> This should be mentioned.

Log entry size is always 16 bytes in size.  The reason is to report a
maximum of 256 entries.  Total 4096 bytes
>
> Is audit_log_entry_count ever used without reading audit_log_entries
> right after?
Yes. The counter is necessary to determine how many logs are available
to be read.

> If not the count file could be dropped.
>
> > +What:                /sys/class/firmware-attributes/*/authentication/SPM/status
> > +Date:                March 29
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description: 'status' is a read-only file that returns ASCII text reporting
> > +             the status information.
> > +
> > +               State:  Not Provisioned / Provisioned / Provisioning in progress
> > +               Version:  Major.   Minor
> > +               Feature Bit Mask: <16-bit unsigned number display in hex>
>
> How are these bits to be interpreted?
This information is provided by BIOS.  It is one of those obscure
values from BIOS.
>
> > +               SPM Counter: <16-bit unsigned number display in base 10>
> > +               Signing Key Public Key Modulus (base64):
> > +               KEK Public Key Modulus (base64):
>
> Is " (base64)" supposed to be part of the contents of the file?

The information reported for Signing Key and KEK public key are
reported as base64 values.  It applies only to the data and not to the
file contents.

>
> > +
> > +
> > +What:                /sys/class/firmware-attributes/*/authentication/SPM/statusbin
> > +Date:                March 29
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description: 'statusbin' is a read-only file that returns identical status
> > +             information reported by 'status' file in binary format.
>
> This documentation should contain enough information to understand the
> files contents.
>
>
> I understand that one WMI call will return all the fields that are part
> of the "status" and "statusbin" in one response.
>
> Are these WMI calls especially expensive or called especially
> frequently?
>

Unfortunately the WMI to read the Status binary data is expensive
hence the reason of only calling once.

> If not I would still argue to split them into one file per field and
> remove the statusbin file.
>

Regards,

Jorge
