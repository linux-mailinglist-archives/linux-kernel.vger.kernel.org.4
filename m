Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158586DE5B9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDKU0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDKU0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:26:30 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B958E55AD;
        Tue, 11 Apr 2023 13:26:28 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q15so6181451ljp.5;
        Tue, 11 Apr 2023 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681244787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQVVITLQWclfjFe3YqWywryPzaNAk23mxsgQqVNJwQY=;
        b=Ird8NRqrKf19gxtM1ta7hArw7+t3gFLnbntkpKVwQMtawpzd8vtVsJfSKqoOz7Xhl5
         FIytCBaDUhwYtaV6WjgFoqL/kwbd1JI+cX6F1VsiIWdRvu1ZkngkaD2uxEAo+vuuZm36
         6f8XhFKBhQEEGvmHaMZDLJfsEFOhjXQccVlT85oBQVysb/baPylomSlqN/IgtWOJpdNg
         p0GKhmPZozeNhEYWux3LXKkbHSUjGK2OW/7GrWn+qxtille3a+aRkaQveckCJg3zdTuh
         0og77o5w1zN+Q94uVfMnEFVXsiF/UO6lbCr50ESY9TVbZ+lxalcsxZRQ10Raf0zibr+J
         6faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681244787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQVVITLQWclfjFe3YqWywryPzaNAk23mxsgQqVNJwQY=;
        b=zZ9VS71E0vA26x9ByN3PmZys3O36cM4nwU7CvyDH7fo3VMknhOqLdWT4DZMidn53kD
         t9gvMVJbX20oHJVRxoPChqSn8VXMsYAT/FRjZl011+N/BwlVuF96oP79ULFVXP270g2N
         IGWBnvcm2X4xScLdqqqx5n1hj8EBXdRnv7YZMJOJ+HsdrONv4BBtxdqP58NlRdNAX04X
         Te60hAS1YB7beLVT6TCuwlG95TPoisJSaKPkrZNRYucDKxH1Dmda5eNlKnS3Bxe4+vht
         KmUH82EGTbf8hDWI+L31gQwjpE/nmYjyDtNZ2gxid1+aV6CEdZYy9LS0mGPZuvGgeG4U
         raQw==
X-Gm-Message-State: AAQBX9foBR3IRGXm29/wz0nlRkse4FDrj1ygAtOmm1EUeqJ2+scUaJIm
        2hBP8hyjgb7s+v11FXWiBGcVkIbSYhQpRC+qzMw=
X-Google-Smtp-Source: AKy350Z4XWKYKFI5n0GeJ6zsX2xk9akJ/Dcx4k18MxKtNfto1XHNOAXebbc532C8bHQmvDRaTcJFRYAo1Q4bv5SKKK4=
X-Received: by 2002:a2e:80c3:0:b0:2a3:5c1c:ec20 with SMTP id
 r3-20020a2e80c3000000b002a35c1cec20mr3609643ljg.7.1681244786692; Tue, 11 Apr
 2023 13:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230403211548.6253-1-jorge.lopez2@hp.com> <d5fbc118-3b33-44b8-a7b6-4738e121b170@t-8ch.de>
 <CAOOmCE8z_UDs8dG0MqX+SFcvd-CTX12XXKzOrVOKDuvrPkyeCQ@mail.gmail.com> <e656fc58-a910-44b3-adb2-56f952dd740e@t-8ch.de>
In-Reply-To: <e656fc58-a910-44b3-adb2-56f952dd740e@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 11 Apr 2023 15:26:06 -0500
Message-ID: <CAOOmCE81NTALi-AWOd0JNuzy6UCcCr2qAF0DQAVjUGi=w_eEOw@mail.gmail.com>
Subject: Re: [PATCH v7] Introduction-of-HP-BIOSCFG-driver-documentation
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Thomas,


On Tue, Apr 11, 2023 at 11:16=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8c=
h.de> wrote:
>
> Hi Jorge!
>
>
> Apr 4, 2023 22:24:36 Jorge Lopez <jorgealtxwork@gmail.com>:
>
> > Hi Thomas,
> >
> > BTW, I decided to submit all files individually to facilitate the
> > review process.  Only Makefile and Kconfig files will be provided as a
> > single patch.
> > I will be out of town until April 11 and will reply back upon my return=
.
>
> Sorry for the slow response.
>
> >
> > Please see my comments below.
> >
> >>
> >>> +             HP specific types
> >>> +             -----------------
> >>> +                     - ordered-list - a set of ordered list valid va=
lues
> >>> +                     - sure-start

> But what does it mean?
> For ordered-list there is a nice explanation.
>

The latest submission includes a short explanation

                HP specific types
                -----------------
                        - ordered-list - a set of ordered list valid values
                        - sure-start - report audit logs read from BIOS


> >>> +             audit_log_entry_count:
> >>> +                                     A read-only file that returns t=
he number of existing audit log events available to be read.
> >>> +                                     Values are separated using comm=
a (``,``)
> >>> +
> >>> +                                     [No of entries],[log entry size=
],[Max number of entries supported]
> >>
> >> Will log entry size always be 16? Or can it be bigger in the future wh=
en
> >> more bytes are used?
> >> This should be mentioned.
> >
> > Log entry size is always 16 bytes in size.  The reason is to report a
> > maximum of 256 entries.  Total 4096 bytes
>
> Does it make sense to expose the number 16 from sysfs if it never can cha=
nge anyways?

The current audit log file is 16 bytes but future BIOS can expand the
audit log to up to 128 bytes.
Additional details are now included in the audit_log_entry_count
section.  WMI  reports only the total number of audit logs but not the
individual audit log size hence the reason the size is hardcoded to 16
bytes in the driver.  A patch will be provided when the audit log size
changes or a new WMI is provided.

>
> Note you can also customize the filesize reported in sysfs to expose the =
maximum size to be used by userspace.
>

This is another area with additional details in the latest review.

                "sure-start"-type specific properties:

                audit_log_entries:
                                        A read-only file that returns
the events in the log.
                                        Values are separated using
semi-colon (``;``)

                                        Audit log entry format

                                        Byte 0-15:   Requested Audit
Log entry  (Each Audit log is 16 bytes)
                                        Byte 16-127: Unused

                audit_log_entry_count:
                                        A read-only file that returns
the number of existing audit log events available to be read.
                                        Values are separated using comma (`=
`,``)

                                        [No of entries],[log entry
size],[Max number of entries supported]

                                        log entry size identifies
audit log size for the current BIOS version.
                                        The current size is 16 bytes
but it can be to up to 128 bytes long
                                        in future BIOS versions.



> >>
> >> Is audit_log_entry_count ever used without reading audit_log_entries
> >> right after?
> > Yes. The counter is necessary to determine how many logs are available
> > to be read.
>
> I think the cleaner interface would be to have users provide a buffer to =
read into and then they check the return value of read().
> Users can't trust the count value anyways as it is prone to TOCTOU races.

Audit logs buffer information includes an audit log number associated
with each log entry.   The log number information is added by the
driver.  The audit log is read as a single continuous buffer and the
application does not read individual audit logs while reading sysfs.
The application copies the whole buffer, extracts and identifies each
audit log from its local buffer.

Byte 0:       Audit log number
Byte 1-16:  Audit log information



>
> >
> >> If not the count file could be dropped.
> >>
> >>> +What:                /sys/class/firmware-attributes/*/authentication=
/SPM/status
> >>> +Date:                March 29
> >>> +KernelVersion:       5.18
> >>> +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> >>> +Description: 'status' is a read-only file that returns ASCII text re=
porting
> >>> +             the status information.
> >>> +
> >>> +               State:  Not Provisioned / Provisioned / Provisioning =
in progress
> >>> +               Version:  Major.   Minor
> >>> +               Feature Bit Mask: <16-bit unsigned number display in =
hex>
> >>
> >> How are these bits to be interpreted?
> > This information is provided by BIOS.  It is one of those obscure
> > values from BIOS.
> >>
> >>> +               SPM Counter: <16-bit unsigned number display in base =
10>
> >>> +               Signing Key Public Key Modulus (base64):
> >>> +               KEK Public Key Modulus (base64):
> >>
> >> Is " (base64)" supposed to be part of the contents of the file?
> >
> > The information reported for Signing Key and KEK public key are
> > reported as base64 values.  It applies only to the data and not to the
> > file contents.
>
> Put is the file format:
> KEK Public Key Modulus (base64): ...
> KEK Public Key Modulus: ...
>
> The docs indicate the former.

Also included in the last review is additional clarification on how
the Modules are reported.

What:           /sys/class/firmware-attributes/*/authentication/SPM/status
Date:           March 29
KernelVersion:  5.18
Contact:        "Jorge Lopez" <jorge.lopez2@hp.com>
Description:    'status' is a read-only file that returns ASCII text report=
ing
                the status information.

                  State:  Not Provisioned / Provisioned / Provisioning
in progress
                  Version:  Major.   Minor
                  Feature Bit Mask: <16-bit unsigned number display in hex>
                  SPM Counter: <16-bit unsigned number display in base 10>
                  Signing Key Public Key Modulus (base64): <256 bytes
base64 in hex>
                  KEK Public Key Modulus (base64): <256 bytes base64 in hex=
>

>
> >>
> >>> +
> >>> +
> >>> +What:                /sys/class/firmware-attributes/*/authentication=
/SPM/statusbin
> >>> +Date:                March 29
> >>> +KernelVersion:       5.18
> >>> +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> >>> +Description: 'statusbin' is a read-only file that returns identical =
status
> >>> +             information reported by 'status' file in binary format.
> >>
> >> This documentation should contain enough information to understand the
> >> files contents.
> >>
> >>
> >> I understand that one WMI call will return all the fields that are par=
t
> >> of the "status" and "statusbin" in one response.
> >>
> >> Are these WMI calls especially expensive or called especially
> >> frequently?
> >>
> >
> > Unfortunately the WMI to read the Status binary data is expensive
> > hence the reason of only calling once.
>
> Hm, I still dislike the interface, sorry.

No worries.  The implementation is a legacy from the Windows driver
and security applications define it.

> What about caching the values in the driver and exposing them via differe=
nt files?

The information changes as a group during the SPM configuration
process so caching would not help much.  Version field is the only
field that can be cached.
If the information is split in difference files,  there are conditions
when the user would read stale data in one field or another.


> >
> > Regards,
> > > Jorge
>
