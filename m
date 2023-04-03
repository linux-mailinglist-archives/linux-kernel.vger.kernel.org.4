Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FABE6D516B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjDCTen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjDCTek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:34:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C66B2D7E;
        Mon,  3 Apr 2023 12:34:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j11so39437597lfg.13;
        Mon, 03 Apr 2023 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680550451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIajKJBgadiXZXqYnPUD/TCMgXwlp9reunu5G7CWM+g=;
        b=QqvGJsF2BvdQegTa5mHU3kr0DQiLCfkAuKcVUKQleCWcQcRr/asIH+ZeINNLVMq2bP
         Z2ZtZ0uCto6W0MI1K2cdULlLlwwpUD27gJLsZ1LWe+h1fc4uTh3j2o5uI3MlUjd5P97x
         8s4cKmxcwbxOZMEEkZ79cjc4kQ+V3WtXp/qZ/OKUAdwPa0jMoZLvdavMDpxOu1ErsOlh
         /1n+uPkyuU5roVFqdZsLXDKQ6iP3eet/dAgxgVXLjxiAnyvUkB8A6WI753KHQczUXria
         fYzMVgo4DGVVtB37yBs51ogrt9W5ZhT5n6uqeqGyn975ENfHao+2gNDmL9ioXAAig3t3
         SJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680550451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIajKJBgadiXZXqYnPUD/TCMgXwlp9reunu5G7CWM+g=;
        b=CPnxUlNdZKOaaJ75gPnDVlUPEknCtupvP4eaFTTlEw6kL0ApYIHXN8D6avSvLkxmsW
         aqjZphpl/0nxlv53CezhopEDiegqsQMBAEVmOdVCVKSB93bycz1IfiQ9pE+crT9uQMRf
         9slXiTmSu7ZZn4uk/rlNLHIehjieBvCxmslwGmVc3t0DSATgR5tK/b5hs1bC6mGEECD5
         LIxFvUva07CMLzi8RBYXRi6MYI3HiGI7gk/gDh0igLjGMYSwAwDeLf8GT2e6o+cIpqps
         KAT8iuyeE0AEcTOA0HFCLNWZFURcnZoNK8OBLyoH2H14dVSOsxDXuMlGncJSjMdcMaKe
         We1A==
X-Gm-Message-State: AAQBX9ediYrRJz0ClqzvLNpKMOXKA6/ZkiSKBI7D4NYS+dpV6DuzZrzR
        pKkW78qRQ3sm40udrF1FNxALN5xkSJIVD3Uztak=
X-Google-Smtp-Source: AKy350bG6atjI0AV6NRr4eWR2moSd0wqdyD8mzS7K4ryi4FFnVT4sIEVvUkCBENDrwB04bSJAQ3M4PmP/O5jmTdCV58=
X-Received: by 2002:a05:6512:39c2:b0:4dc:7e56:9839 with SMTP id
 k2-20020a05651239c200b004dc7e569839mr8716210lfu.5.1680550451369; Mon, 03 Apr
 2023 12:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230309201022.9502-1-jorge.lopez2@hp.com> <20230309201022.9502-5-jorge.lopez2@hp.com>
 <6da33dcc-0526-4398-bf35-655b64d07e20@t-8ch.de> <CAOOmCE_kzVnUr9WoPAEu-e+E5=-RfHUCjj6U7kL_yhqKHsP84g@mail.gmail.com>
 <f68304f0-c533-434d-9f74-92327cd4a002@t-8ch.de>
In-Reply-To: <f68304f0-c533-434d-9f74-92327cd4a002@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 3 Apr 2023 14:33:53 -0500
Message-ID: <CAOOmCE8aQ3YOyheC_U27FtV1xcMgV73eNsr9aooboqijaHENaA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] Introduction of HP-BIOSCFG driver [4]
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
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

Hi Thomas,

Please see my comments below.

> > > > HP BIOS Configuration driver purpose is to provide a driver support=
ing
> > > > the latest sysfs class firmware attributes framework allowing the u=
ser
> > > > to change BIOS settings and security solutions on HP Inc.=E2=80=99s=
 commercial
> > > > notebooks.
> > >
> > > Here it says "notebooks", below "PC's". Does it also support
> > > non-notebook machines?
> >
> > The initial release of the driver will be supported for business notebo=
oks.
> > Although the driver is not targeted for non-notebooks machines, the
> > driver was tested on non-notebooks in the event a decision is made to
> > targets them
>
> If it is not intended to support both, maybe the documentation could
> consistently use "notebook".

Ok.
>
> > > > +             "sure-start"-type specific properties:
> > > > +
> > > > +             audit_log_entries:
> > > > +                                     A read-only file that returns=
 the events in the log.
> > > > +
> > > > +                                     Audit log entry format
> > > > +
> > > > +                                     Byte 0-15:   Requested Audit =
Log entry  (Each Audit log is 16 bytes)
> > > > +                                     Byte 16-127: Unused
> > > > +
> > > > +             audit_log_entry_count:
> > > > +                                     A read-only file that returns=
 the number of existing audit log events available to be read.
> > > > +
> > > > +                                     [No of entries],[log entry si=
ze],[Max number of entries supported]
> > >
> > > sysfs is based on the idea of "one-value-per-file".
> > > The two properties above violate this idea.
> > > Maybe a different interface is needed.
> > >
> >
> > Both properties report a single string separated by semicolon.  This
> > is not different from listing all elements in a single string
> > separated by semicolon.
>
> The documentation does not mention semicolons.

It should have been documented.  I will update the docs.

>
> The nice thing about descoping functionality is that we don't need to
> worry about their details now.
> Instead it can be added later without haste as the core functionality
> can already be used by the users.
>
> > > Are these properties very important for the first version of this
> > > driver? If not I would propose to drop them for now and resubmit them
> > > as separate patches after the main driver has been merged.
> > >
> > We want the initial driver to have all predefined properties available
> > first.   There are plans to add future properties and features which
> > will be submitted as patches.
>
> With "properties" do you mean the bios settings?
> I agree that all these are good for the initial driver.

Yes.  All those properties are part of BIOS setting and security
related features.
>
> But the audit log, detailed error codes, etc... do not seem integral for
> the functioning of the driver or for users.

Error codes can be replaced as pr_warn() log when error is not zero.
Audit_log on the hand, it is part of the initial features we need.to
have.

>
> > > > +             HP specific class extensions
> > > > +             --------------------------------
> > > > +
> > > > +What:                /sys/class/firmware-attributes/*/authenticati=
on/SPM/kek
> > > > +Date:                March 29
> > > > +KernelVersion:       5.18
> > > > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > > > +Description: 'kek' is a write-only file that can be used to config=
ure the
> > > > +             RSA public key that will be used by the BIOS to verif=
y
> > > > +             signatures when setting the signing key.  When writte=
n,
> > > > +             the bytes should correspond to the KEK certificate
> > > > +             (x509 .DER format containing an OU).  The size of the
> > > > +             certificate must be less than or equal to 4095 bytes.
> > > > +
> > > > +
> > > > +What:                /sys/class/firmware-attributes/*/authenticati=
on/SPM/sk
> > > > +Date:                March 29
> > > > +KernelVersion:       5.18
> > > > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > > > +Description: 'sk' is a write-only file that can be used to configu=
re the RSA
> > > > +             public key that will be used by the BIOS to verify si=
gnatures
> > > > +             when configuring BIOS settings and security features.=
  When
> > > > +             written, the bytes should correspond to the modulus o=
f the
> > > > +             public key.  The exponent is assumed to be 0x10001.
> > >
> > > The names of the files 'SPM', 'kek' and 'sk' are cryptic.
> >
> > SPM - Secure Platform Manager
> > kek -  Key-Encryption-Key (KEK)
> > sk - Signature Key (SK)
> >
> > Those abbreviations were used because they are industry standard and
> > reduce the  size of the commands.  Any suggestions?
>
> Maybe mention the long names once in the documentation "Description".

Ok.  I will do so.
>
> > > > +
> > > > +
> > > > +What:                /sys/class/firmware-attributes/*/authenticati=
on/SPM/status
> > > > +Date:                March 29
> > > > +KernelVersion:       5.18
> > > > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > > > +Description: 'status' is a read-only file that returns ASCII text =
reporting
> > > > +             the status information.
> > > > +
> > > > +               State:  Not Provisioned / Provisioned / Provisionin=
g in progress
> > > > +               Version:  Major.   Minor
> > > > +               Feature Bit Mask: <16-bit unsigned number display i=
n hex>
> > > > +               SPM Counter: <16-bit unsigned number display in bas=
e 10>
> > > > +               Signing Key Public Key Modulus (base64):
> > > > +               KEK Public Key Modulus (base64):
> > >
> > > This also violates 'one-value-per-file'.
> > > Can it be split into different files?
> >
> > I will split the information in multiple files.

The data reported by status files is gathered by a single WMI called
(statusbin) and then reported by adding multiple headers (ie Feature
Bit Mask:).   Do we still need to split the status lines?  Instead of
making one call, the driver would be making multiple calls to
'statusbin' routine and then report the appropriate item for the file.
  The additional complexity is unnecessary.

> >
> > > This would also remove the need for the statusbin file.
> > >
> > Status bin is used by GUI applications where data is managed
> > accordingly instead of individual lines.
>
> Can the GUI applications not use the split files?

The GUI applications could use the split lines but he data is just a
blob of binary data of sizeof  struct
secureplatform_provisioning_data.  The lack of headers on the left
handside ((ie Feature Bit Mask:) will eliminate having to split the
data read and make multiple calls to the driver.

>
> > > For the values:
> > >
> > > Status: I think symbolic names are better for sysfs:
> > >         not_provisioned, provisioned, etc.
> > > Feature Bit Mask: Use names.
> > > Keys: It would be nicer if these could be shown directly in the files
> > >       that can be used to configure them.
> > >
> > > As before, what is really needed and what can be added later?
> >
> > Status is needed when the user enables Secure Platform Manager in BIOS
> > and  KEK and/or SK are configured.
>
> Ok.
>
> > >
> > > > +
> > > > +
> > > > +What:                /sys/class/firmware-attributes/*/authenticati=
on/SPM/statusbin
> > > > +Date:                March 29
> > > > +KernelVersion:       5.18
> > > > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > > > +Description: 'statusbin' is a read-only file that returns identica=
l status
> > > > +             information reported by 'status' file in binary forma=
t.
> > >
> > > How does this binary format work?
> >
> > Yes.  Status bin is used by GUI applications where data is managed
> > accordingly instead of individual lines
>
> But this format is not documented here at all.
> So how can we determine if the implementation is correct?

The data gathered by 'statusbin' routine is  struct
secureplatform_provisioning_data.  The validation is done in two ways.
the driver validates the return code from WMI call, and the other is
by inspecting the data reported by 'status' with some additional
headers..

> > > > +
> > > > +
> > > > +What:                /sys/class/firmware-attributes/*/attributes/l=
ast_error
> > > > +Date:                March 29
> > > > +KernelVersion:       5.18
> > > > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > > > +Description: 'last_error' is a read-only file that returns WMI err=
or number
> > > > +             and message reported by last WMI command.
> > >
> > > Does this provide much value?
> > > Or could this error just be logged via pr_warn_ratelimited()?
> >
> > It is specially needed to determine if WMI calls reported an error.
> > This property is similar to the one provided by both Dell and Lenovo
> > drivers
>
> I don't see similar functionality for the other drivers.
> Instead they seem to just return the error codes from the attribute
> callbacks.

Ok.  last_error can be replaced as pr_warn() log when error value is not ze=
ro.
>
> This may be useful but it does not seem *necessary* for the first
> version.
>
>
> Feel free to only submit the patch with the documentation for the next
> revision. Then we can nail down the interface and initial functionality
> and you don't always have to adapt the code to the changing interface.
>

Ok.  I will submit the documentation by it self with the next revision.

Jorge
