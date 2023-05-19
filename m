Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5DD70A33E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjESXT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjESXTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:19:55 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A634F1B0;
        Fri, 19 May 2023 16:19:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E1C675C0129;
        Fri, 19 May 2023 19:19:52 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Fri, 19 May 2023 19:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684538392; x=1684624792; bh=K5IPsJh3X21kba0sm8R7NAUFo4lnz18z8Bs
        x1zEGYZ4=; b=YoZriiW+ybDQ3uuQKP/YSaxyGVmipEsFny/BcQbazo6ez5q3DHf
        Ciu2fH/6DP+ZLaHN4Dapa7hZPuXj+gxDD/5Rb1pvkq7BhzB3ZZc7ovFfKQYuuUzb
        vcSOKXhuj64Ja1qxU4uljd5C4jNAX3e3+GCWI/NcWAT63qAY1qMmU6uQYbXcvSG1
        wkJSHxwt3gxwkPCgKMgLki08HMMeve5Ns36/8n1ZaVm5IV8Zjpi30/PsLSrONJEP
        dDDBhv1A7KAomByBZKZBi4lBHr6V5YFnXyXEuMWXE/ByNbf9LuuweNYvmGFB6qc9
        DD8d9l8TbihkdnChPal98OCghDEoNfQlUVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684538392; x=1684624792; bh=K5IPsJh3X21kba0sm8R7NAUFo4lnz18z8Bs
        x1zEGYZ4=; b=jBhzeYDLNFQnTVIG1iiEoO4vfD5hwgv8VZ/oWrmJZWRqEjokMDt
        ekaE2q26MM0AbQ+2g3sdR/3z8pMOqT2nY7GFZDKyA6dTY+mFoqllMoYtrT/8GBbv
        Ia4VU6ttq2NjNcrnqWgGcob5rRKi5Q4cmtzbPIj7W5xaTIj91lPMHQu8JKyeXBH1
        fCRThDtBEnPTiCcmMEtefwg6bxsu6kgPjw5oVz3ytY96sz5S/jsvJI3VxvtYEyIf
        WUCtLxihJ7mxSGV0uYkHWJKq5DTKSgCFsSvMdHwmcRU9FmuHVdc40HbhmQUVp9h2
        OqZXzwTPOGAXixgb1RLV6WDqD/+QdrCSLUw==
X-ME-Sender: <xms:GARoZL6P4b1s4kpn7TDpQn44gNCX_7j7tbMhqxyQ0dBnZbRfTbIe8Q>
    <xme:GARoZA4ETQ_v4arWA21F71mpOOCbcKKCo5knfEbM7Hh_0gchgL0rAqj7m77I-s6qb
    f6EayxyJUK7xIRyCxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiiedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhephfefgedufeetgfetlefgkefgvdejleelvefg
    hfejfffhtdeitdejfeekvdeugfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:GARoZCemt42d_Li4cFYrJ9_2kiL6WjqcDIxGbXHp4JUD1K4CPcr5qQ>
    <xmx:GARoZMI0UJn0hRAPrFP4D4ywEopg3gAKq-J-pX6hHkh02hNHvKb84A>
    <xmx:GARoZPKGqHENXTntLOm5L-34wxfDnF26yQyfvXZzXhmI-eYjJwMjUw>
    <xmx:GARoZH2yfWrPiBlxscUiqg3Zf5PyYVW_QuSoPN7Au01vS4RPqm3ZHA>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0E360C60091; Fri, 19 May 2023 19:19:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <7406150c-4ac0-4a61-b7e5-fd5f89ef0d45@app.fastmail.com>
In-Reply-To: <CAOOmCE8-GB-yM-cfCP6Sw8xdnOgNm4b7viUziA48YJ4mGkGfag@mail.gmail.com>
References: <20230517155026.28535-1-jorge.lopez2@hp.com>
 <20230517155026.28535-2-jorge.lopez2@hp.com>
 <0abdb306-1e24-4653-9a14-e5db8d508a82@app.fastmail.com>
 <CAOOmCE8-GB-yM-cfCP6Sw8xdnOgNm4b7viUziA48YJ4mGkGfag@mail.gmail.com>
Date:   Fri, 19 May 2023 19:19:31 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Jorge Lopez" <jorgealtxwork@gmail.com>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v14 01/13] hp-bioscfg: Documentation
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jorge,

On Fri, May 19, 2023, at 4:58 PM, Jorge Lopez wrote:
> On Fri, May 19, 2023 at 12:34=E2=80=AFPM Mark Pearson <mpearson-lenovo=
@squebb.ca> wrote:
>>
>> Hi Jorge,
>>
>> On Wed, May 17, 2023, at 11:50 AM, Jorge Lopez wrote:
>> > HP BIOS Configuration driver purpose is to provide a driver support=
ing
>> > the latest sysfs class firmware attributes framework allowing the u=
ser
>> > to change BIOS settings and security solutions on HP Inc.=E2=80=99s=
 commercial
>> > notebooks.
>> >
>> > Many features of HP Commercial notebooks can be managed using Windo=
ws
>> > Management Instrumentation (WMI). WMI is an implementation of Web-B=
ased
>> > Enterprise Management (WBEM) that provides a standards-based interf=
ace
>> > for changing and monitoring system settings. HP BIOSCFG driver prov=
ides
>> > a native Linux solution and the exposed features facilitates the
>> > migration to Linux environments.
>> >
>> > The Linux security features to be provided in hp-bioscfg driver ena=
bles
>> > managing the BIOS settings and security solutions via sysfs, a virt=
ual
>> > filesystem that can be used by user-mode applications. The new
>> > documentation cover HP-specific firmware sysfs attributes such Secu=
re
>> > Platform Management and Sure Start. Each section provides security
>> > feature description and identifies sysfs directories and files expo=
sed
>> > by the driver.
>> >
>> > Many HP Commercial notebooks include a feature called Secure Platfo=
rm
>> > Management (SPM), which replaces older password-based BIOS settings
>> > management with public key cryptography. PC secure product manageme=
nt
>> > begins when a target system is provisioned with cryptographic keys
>> > that are used to ensure the integrity of communications between sys=
tem
>> > management utilities and the BIOS.
>> >
>> > HP Commercial notebooks have several BIOS settings that control its
>> > behaviour and capabilities, many of which are related to security.
>> > To prevent unauthorized changes to these settings, the system can
>> > be configured to use a cryptographic signature-based authorization
>> > string that the BIOS will use to verify authorization to modify the
>> > setting.
>> >
>> > Linux Security components are under development and not published y=
et.
>> > The only linux component is the driver (hp bioscfg) at this time.
>> > Other published security components are under Windows.
>> >
>> > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
>> >
>> > ---
>> > Based on the latest platform-drivers-x86.git/for-next
>> > ---
>> >  .../testing/sysfs-class-firmware-attributes   | 102 ++++++++++++++=
+++-
>> >  1 file changed, 100 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attribu=
tes
>> > b/Documentation/ABI/testing/sysfs-class-firmware-attributes
>> > index 4cdba3477176..f8d6c089228b 100644
>> > --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
>> > +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
>> <snip>
>> > +
>> > +
>> > +             HP specific class extensions - Secure Platform Manage=
r (SPM)
>> > +             --------------------------------
>> > +
>> > +What:                /sys/class/firmware-attributes/*/authenticati=
on/SPM/kek
>> > +Date:                March 29
>> > +KernelVersion:       5.18
>> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
>> > +Description:
>> > +             'kek' Key-Encryption-Key is a write-only file that ca=
n be used to
>> > configure the
>> > +             RSA public key that will be used by the BIOS to verify
>> > +             signatures when setting the signing key.  When writte=
n,
>> > +             the bytes should correspond to the KEK certificate
>> > +             (x509 .DER format containing an OU).  The size of the
>> > +             certificate must be less than or equal to 4095 bytes.
>> > +
>> > +What:                /sys/class/firmware-attributes/*/authenticati=
on/SPM/sk
>> > +Date:                March 29
>> > +KernelVersion:       5.18
>> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
>> > +Description:
>> > +             'sk' Signature Key is a write-only file that can be u=
sed to
>> > configure the RSA
>> > +             public key that will be used by the BIOS to verify si=
gnatures
>> > +             when configuring BIOS settings and security features.=
  When
>> > +             written, the bytes should correspond to the modulus o=
f the
>> > +             public key.  The exponent is assumed to be 0x10001.
>> > +
>> > +What:                /sys/class/firmware-attributes/*/authenticati=
on/SPM/status
>> > +Date:                March 29
>> > +KernelVersion:       5.18
>> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
>> > +Description:
>> > +             'status' is a read-only file that returns ASCII text =
in JSON format
>> > reporting
>> > +             the status information.
>> > +
>> > +               "State": "not provisioned | provisioned | provision=
ing in progress
>> > ",
>> > +               "Version": " Major. Minor ",
>> > +               "Nonce": <16-bit unsigned number display in base 10=
>,
>> > +               "FeaturesInUse": <16-bit unsigned number display in=
 base 10>,
>> > +               "EndorsementKeyMod": "<256 bytes in base64>",
>> > +               "SigningKeyMod": "<256 bytes in base64>"
>> > +
>> > +What:                /sys/class/firmware-attributes/*/attributes/S=
ure_Start/audit_log_entries
>> > +Date:                March 29
>> > +KernelVersion:       5.18
>> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
>> > +Description:
>> > +             'audit_log_entries' is a read-only file that returns =
the events in
>> > the log.
>> > +
>> > +                     Audit log entry format
>> > +
>> > +                     Byte 0-15:   Requested Audit Log entry  (Each=
 Audit log is 16 bytes)
>> > +                     Byte 16-127: Unused
>> > +
>> > +What:                /sys/class/firmware-attributes/*/attributes/S=
ure_Start/audit_log_entry_count
>> > +Date:                March 29
>> > +KernelVersion:       5.18
>> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
>> > +Description:
>> > +             'audit_log_entry_count' is a read-only file that retu=
rns the number
>> > of existing
>> > +             audit log events available to be read. Values are sep=
arated using
>> > comma (``,``)
>> > +
>> > +                     [No of entries],[log entry size],[Max number =
of entries supported]
>> > +
>> > +             log entry size identifies audit log size for the curr=
ent BIOS
>> > version.
>> > +             The current size is 16 bytes but it can be up to 128 =
bytes long in
>> > future BIOS
>> > +             versions.
>> > --
>> > 2.34.1
>>
>> Firstly apologies as I've done a poor job of following the updates to=
 this series - so if this has already been discussed and agreed by more =
seasoned kernel contributors please feel free to disregard my comments :=
) I was catching up on my inbox and had some thoughts.
>
> No worries.
>
>>
>> For SPM - as this replaces password usage, is it done for all account=
 types? It seems a bit odd having it be a replacement for the passwords =
but in it's own location and not in the same place as (for example) Admi=
n/current_password.
>> For the Lenovo implementation I put certificate, signature and save_s=
ignature in the authentication/Admin directory and I realise your implem=
entation is different with the keys but if the kek and sk are only used =
with the Admin account then shouldn't they also be in that directory? It=
 would be nice to have some commonality across vendors in my opinion.
>>
>
> SPM (Security Platform Management) does not replace password usage and
> it is done for the Admin account (Setup Password).  SPM is a security
> feature available to the user to configure/update BIOS settings when
> Sure Admin is enabled in BIOS.  One of the files provided under SPM is
> the key _role and its value is set to =E2=80=98bios-spm.=E2=80=99   A =
=E2=80=98bios-spm=E2=80=99 role
> indicates a password is used in combination with an
> endorsement/signing key.  It is also the reason why SPM is kept
> separate under the list of authentication attributes.

Ah - I think I get it, and in that case I can see why you keep it separa=
te and it is a unique role.
I withdraw my suggestion :)

>
>> For the Sure_Start I would propose de-branding this so it's generic a=
nd I don't think it fits under attributes as it doesn't support any of t=
he other required attribute fields. I think your implementation of an au=
dit log seems neat but if another vendor was to do similar it would be b=
etter to be able to reuse the same attribute name and enable common tool=
ing.
>> I propose having this as just log/audit_entries and log/audit_count a=
nd have the log folder in the top alongside authentication and attribute=
s.
>> If someone wants to add other logs in the future it would be a good p=
lace to have them.
>
> I like the idea of having a log folder alongside authentication and
> attributes where future logs can be placed.  Unfortunately, Sure_Start
> is part of the security attributes  and the initial driver provides a
> minimal implementation.   Other attributes associated with Sure_Start
> and available in BIOS are  'SureStart Production Mode', 'Sure Start
> Security Event Boot Notification', 'Sure Start BIOS Settings
> Protection', 'Sure Start Secure Boot Keys Protection', and 'Sure Start
> Security Event Policy'

Aren't all of these just regular attributes that show up under the attri=
butes folder (and have current_value and possible_value settings etc)? D=
o they get created in your equivalent of probing the BIOS to determine w=
hat attributes are available or are they manually created entries? (I'm =
assuming automatic or they would be also added to the documentation)

It seemed to me the audit log entries were being handled differently bec=
ause you had to specifically create the entries, with (I assume) some sp=
ecial handling for display?

Mark
