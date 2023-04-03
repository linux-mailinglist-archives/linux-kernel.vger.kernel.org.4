Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B0B6D52C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjDCUpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjDCUpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:45:09 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5E4139;
        Mon,  3 Apr 2023 13:45:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a11so31710247lji.6;
        Mon, 03 Apr 2023 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680554705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkdjmCtGVb+5nxY71D+tZq13otQ52uuWmZ7dsuIAj1c=;
        b=DWUJ3dQI2iPjcNDJcSYgL9Y5UkWBk4E7r2GSZvmyHqDBVE1YxrmIlEokdoKZ+qG8Gx
         t7+mMOdSVXQkIyJzTf6c+kIPndI3sVaGCrS+/ajmXsfFtd2rcLTy7KHDAoqizf0pXWW3
         WSFHsB8p0ZkQ0+mbEmn6wrfuKZ/ByLI941siSZMbH0OdkvnHg312U8o5O7KWYc+nKYO1
         ZCUIJxo4uUlfwtR8r7Hu+nPXXEbVYvawtbORfXkHS2Mq2L0T3sPztK+cM2PZIuqiQfxP
         Xr++jrjJFx/kJeFWFhnToP1dBjC+/HUe5NP573pa5/JYRMkr/2IiJeZQJiK9my7D9GOW
         K2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680554705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkdjmCtGVb+5nxY71D+tZq13otQ52uuWmZ7dsuIAj1c=;
        b=NMrwI23Tmhgl1PqeCivCiu9SBRTH5bLnJeD9dmDJxpSlNwkOeas/DIHqOgHlcNGSNT
         bXuTnRj1sLbW0bRQccX/EbLXRnCwcNQnJJUWdmdvEuSWoUbkRaJmxL0z+977N7vGFPLC
         i72Eo6Fr1U3C9LcCYsMC1e0jQzqPsz37XuS406ijBdc3XPlgqMlVcNO3jwgEayEzI9xZ
         KAu0tRycpTRtG2sLNa2wQdB85mD0FBusqhVT2+X46dK8Com0Ixzkj4CSuekPtuAcp/PH
         +wNeCXEZSsOOjfEPyOEIwE4d+59BKDUM/kZdHNZ/ydDk0bp+ScQLOpxcSL2AaWkFdM55
         HoNA==
X-Gm-Message-State: AAQBX9cMQfFfikjWpbdAnd1EhXuxq4S6TARoIZ0Kysa0dg5YCsgkZiul
        GPCZnGoBqvgf7mha6co8kWmnNW4Eia5obSkwVf0=
X-Google-Smtp-Source: AKy350ZnesGkhzSE8qOp+/zMfRaXQgH0/VVXGfjceSKaX0Lt5ftbs/aLMSdUntCdY1/cI7/dOIkYhkpT/1uKzLKb9zo=
X-Received: by 2002:a2e:8817:0:b0:298:b3c7:293d with SMTP id
 x23-20020a2e8817000000b00298b3c7293dmr274222ljh.7.1680554704574; Mon, 03 Apr
 2023 13:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230309201022.9502-1-jorge.lopez2@hp.com> <20230309201022.9502-5-jorge.lopez2@hp.com>
 <6da33dcc-0526-4398-bf35-655b64d07e20@t-8ch.de> <3ca7fa3b-f0d6-4b63-bfe4-8a30197d7261@app.fastmail.com>
In-Reply-To: <3ca7fa3b-f0d6-4b63-bfe4-8a30197d7261@app.fastmail.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 3 Apr 2023 15:44:46 -0500
Message-ID: <CAOOmCE8WtTmP7JBGFDg7NKHeVjJKMWeMhpn+C8YBVAe+vazfBA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] Introduction of HP-BIOSCFG driver [4]
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Hans de Goede <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
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

Hi Mark,

Please see my comments below.

On Sat, Apr 1, 2023 at 7:48=E2=80=AFPM Mark Pearson <mpearson-lenovo@squebb=
.ca> wrote:
>
> Hi Jorge,
>
> As I implemented similar on our platforms I have a couple of suggestions =
which may or may not be helpful.
>
> On Sat, Apr 1, 2023, at 7:58 AM, Thomas Wei=C3=9Fschuh wrote:
> > Hi Jorge,
> >
> <snip>
> > On 2023-03-09 14:10:22-0600, Jorge Lopez wrote:
> <snip>
> >
> >> Many features of HP Commercial PC=E2=80=99s can be managed using Windo=
ws
> >> Management Instrumentation (WMI). WMI is an implementation of Web-Base=
d
> >> Enterprise Management (WBEM) that provides a standards-based interface
> >> for changing and monitoring system settings.  HP BISOCFG driver provid=
es
> >> a native Linux solution and the exposed features facilitates the
> >> migration to Linux environments.
>
> I'd remove this paragraph personally - but as a minor note, typo in BISOC=
FG
>
> <snip>
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes=
 b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> >> index 4cdba3477176..d1ae6b77da13 100644
> >> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> >> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> <snip>
> >> @@ -126,6 +133,38 @@ Description:
> >>                                      value will not be effective throu=
gh sysfs until this rule is
> >>                                      met.
> >>
> >> +            HP specific class extensions
> >> +            ------------------------------
> >> +
> >> +            On HP systems the following additional attributes are ava=
ilable:
> >> +
> >> +            "ordered-list"-type specific properties:
> >> +
> >> +            elements:
> >> +                                    A file that can be read to obtain=
 the possible
> >> +                                    list of values of the <attr>. Val=
ues are separated using
> >> +                                    semi-colon (``;``). The order ind=
ividual elements are listed
> >> +                                    according to their priority.  An =
Element listed first has the
> >> +                                    hightest priority. Writing the li=
st in a different order to
> >> +                                    current_value alters the priority=
 order for the particular
> >> +                                    attribute.
>
> isn't this already covered in the 'possible_values' attribute - it's just=
 a string of items? Curious as to when/how this would be used instead of po=
ssible_values (but I should probably read the code)
> Typo in 'hightest'.

Done.  Possible values provides a list of values in any order.
elements in Ordered-list list items in level of priority such it is
case of list of boot order values.
>
> <snip>
> >
> >> +
> >> +
> >>  What:               /sys/class/firmware-attributes/*/authentication/
> >>  Date:               February 2021
> >>  KernelVersion:      5.11
> >> @@ -206,7 +245,7 @@ Description:
> <snip>
> >> @@ -296,6 +335,15 @@ Description:
> >>                                              echo "signature" > authen=
tication/Admin/signature
> >>                                              echo "password" > authent=
ication/Admin/certificate_to_password
> >>
> >> +            HP specific class extensions
> >> +            --------------------------------
> >> +
> >> +            On HP systems the following additional settings are avail=
able:
> >> +
> >> +            role: enhanced-bios-auth:
> >> +                                    This role is specific to Secure P=
latform Management (SPM) attribute.
> >> +                                    It requires configuring an endors=
ement (kek) and signing certificate (sk).
> >> +
>
> Your implementation might be different on HP's; but on the Lenovo's this =
was still used along with the regular roles - it's just the authentication =
changed from password to a signature approach.
>
> Just checking that you really need a whole new role and that it isn't par=
t of the existing role.
>
Unfortunately, we need a whole new role.

> <snip>
>
> >> +            HP specific class extensions
> >> +            --------------------------------
> >> +
> >> +What:               /sys/class/firmware-attributes/*/authentication/S=
PM/kek
> >> +Date:               March 29
> >> +KernelVersion:      5.18
> >> +Contact:    "Jorge Lopez" <jorge.lopez2@hp.com>
> >> +Description:        'kek' is a write-only file that can be used to co=
nfigure the
> >> +            RSA public key that will be used by the BIOS to verify
> >> +            signatures when setting the signing key.  When written,
> >> +            the bytes should correspond to the KEK certificate
> >> +            (x509 .DER format containing an OU).  The size of the
> >> +            certificate must be less than or equal to 4095 bytes.
> >> +
> >> +
> >> +What:               /sys/class/firmware-attributes/*/authentication/S=
PM/sk
> >> +Date:               March 29
> >> +KernelVersion:      5.18
> >> +Contact:    "Jorge Lopez" <jorge.lopez2@hp.com>
> >> +Description:        'sk' is a write-only file that can be used to con=
figure the RSA
> >> +            public key that will be used by the BIOS to verify signat=
ures
> >> +            when configuring BIOS settings and security features.  Wh=
en
> >> +            written, the bytes should correspond to the modulus of th=
e
> >> +            public key.  The exponent is assumed to be 0x10001.
> >
>
> I wondered if these could be combined with the signature and certificate =
fields that I implemented for the Lenovo platforms - and those be moved out=
 of the Lenovo specific section and then made general (and optional)
The behavior with Secure Platform Manager requires having KEK and SK separa=
te.

> kek looks like it corresponds to certificate and sk to signature?
> KEK - Key-Encryption-Key
      SK - Signature Key
> >


> >> +
> >> +
> >> +What:               /sys/class/firmware-attributes/*/attributes/last_=
error
> >> +Date:               March 29
> >> +KernelVersion:      5.18
> >> +Contact:    "Jorge Lopez" <jorge.lopez2@hp.com>
> >> +Description:        'last_error' is a read-only file that returns WMI=
 error number
> >> +            and message reported by last WMI command.
> >
> > Does this provide much value?
> > Or could this error just be logged via pr_warn_ratelimited()?
>
> This one seemed odd to me too - doesn't the driver return the error to th=
e use on a failed WMI access?
>
It was intended for debug purposes and to determine if the failure was
reported because of WMI error.  The WMI error is masked by the driver
and the error reported by WMI is lost.
for instance,   WMI error 6 is reported by driver as  -EINVAL.
This attribute will be removed and replaced by pr_warn().

Jorge.
