Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C07370E1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbjEWQOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbjEWQOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:14:47 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A3CC2;
        Tue, 23 May 2023 09:14:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BFB025C01A6;
        Tue, 23 May 2023 12:14:44 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Tue, 23 May 2023 12:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684858484; x=1684944884; bh=dxu1dO39Wxb6UsHw03YdxHqxhUteh63mls9
        UH1pUmIM=; b=w9nIlnmCEjKRDa4rE2o0YKKlhxqtIF3+h3RRYlawrz18eXVRYSV
        j7f9MzmE8JhbgdX+eMMRZ0nL6yzIFCcBskA+GKnsSUq0gn+vIwneWNp4JNfXZz70
        emQtlqjBXoY/lVLtxPG2RvbzcErO+Fb454AFpFoB4yJ2Ouadi0t46JXvxOMSoFte
        FvqBXEmf08ViMHy7rqRXP5A87Le6SwrH3Q6Mfn2E6IF91qjWOK2Tgx39tlWaedMy
        t1Nr4ACAwQMC/UdCEuOUEv5L/flelpRcrOpMGT+GIT57BEx9o8roChi3NNJoQK3c
        GbDi0REXLD98/aQWNEinapGO3qZkW15WFlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684858484; x=1684944884; bh=dxu1dO39Wxb6UsHw03YdxHqxhUteh63mls9
        UH1pUmIM=; b=K8LsVSjsMYgzaDascXI7XHbjNziK4NXZMaWivarrZ4oMTo4EVgr
        wJsW2R+7/1DkibV579HYdd+/i/5qP6sQkKjdYZqvKDLHPksT6xy4gZoZhrBcqKQr
        OJ3UDjs2NnYU97IaNpbdtnDzJk42VNcuvQ8gDyhY5FeWi0F0DZBaPb2iacinPTqT
        OdROXSm/F3FLEjklqL7QUY2eneYbM3ISOGFyTLtOm0QfFD+4GBU0CsQfoc2sW1cS
        uW9evNyi/OvvYROs1BLgj5xtwdoM0UIGqd3FEZz6Dogct+gJWEiA5MOu1GrvkZpP
        FSI+eJ+vEYBI5TSt6+RNmqLwZK6ax+aBGgA==
X-ME-Sender: <xms:dOZsZHc4OPnppnwwEQrW21C4-ZQ8gAb4sPfHLbog6kXv8gIwOJBKog>
    <xme:dOZsZNMQVSdUYEzisQMxPWTJFbUhumqv7wGKnWfiuJluYpDPV07Qb-KAZVKequNRl
    7N87RK6NEU-GOSMoFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhephfefgedufeetgfetlefgkefgvdejleelvefg
    hfejfffhtdeitdejfeekvdeugfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:dOZsZAgUOqCw-vFwJlG9JKuyd_CbVojERfOVJFiH1Y0cgMwdGrNKlg>
    <xmx:dOZsZI8j_RJ0qMATM9qp6ZcXm6Zddk8HYv74eSzypqxJX1LPEKokCw>
    <xmx:dOZsZDti0omRpzSlIrcAu8NAeJuk7LNzAn1-WDY-L6J-RsBRGSNlRg>
    <xmx:dOZsZDI0gHEdA9T0j_o4wd5BHaJibUZJCV7wcVnYmAJ6SGhgEWdA2Q>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 43BE3C60091; Tue, 23 May 2023 12:14:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <78e5ae29-5ebb-47d4-bd9d-38909c0ff7e2@app.fastmail.com>
In-Reply-To: <CAOOmCE-1LykpkkSFd112F=YFsY2Vmyphn-coE_SbDbnfGrdyGQ@mail.gmail.com>
References: <20230517155026.28535-1-jorge.lopez2@hp.com>
 <20230517155026.28535-2-jorge.lopez2@hp.com>
 <0abdb306-1e24-4653-9a14-e5db8d508a82@app.fastmail.com>
 <CAOOmCE8-GB-yM-cfCP6Sw8xdnOgNm4b7viUziA48YJ4mGkGfag@mail.gmail.com>
 <7406150c-4ac0-4a61-b7e5-fd5f89ef0d45@app.fastmail.com>
 <CAOOmCE-1LykpkkSFd112F=YFsY2Vmyphn-coE_SbDbnfGrdyGQ@mail.gmail.com>
Date:   Tue, 23 May 2023 12:14:23 -0400
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jorge

On Tue, May 23, 2023, at 10:16 AM, Jorge Lopez wrote:
> On Fri, May 19, 2023 at 6:19=E2=80=AFPM Mark Pearson <mpearson-lenovo@=
squebb.ca> wrote:
>>
>> Thanks Jorge,
>>
>> On Fri, May 19, 2023, at 4:58 PM, Jorge Lopez wrote:
>> > On Fri, May 19, 2023 at 12:34=E2=80=AFPM Mark Pearson <mpearson-len=
ovo@squebb.ca> wrote:
>> >>
>> >> Hi Jorge,
>> >>
>> >> On Wed, May 17, 2023, at 11:50 AM, Jorge Lopez wrote:
>> >> > HP BIOS Configuration driver purpose is to provide a driver supp=
orting
>> >> > the latest sysfs class firmware attributes framework allowing th=
e user
>> >> > to change BIOS settings and security solutions on HP Inc.=E2=80=99=
s commercial
>> >> > notebooks.
>> >> >
>> >> > Many features of HP Commercial notebooks can be managed using Wi=
ndows
>> >> > Management Instrumentation (WMI). WMI is an implementation of We=
b-Based
>> >> > Enterprise Management (WBEM) that provides a standards-based int=
erface
>> >> > for changing and monitoring system settings. HP BIOSCFG driver p=
rovides
>> >> > a native Linux solution and the exposed features facilitates the
>> >> > migration to Linux environments.
>> >> >
>> >> > The Linux security features to be provided in hp-bioscfg driver =
enables
>> >> > managing the BIOS settings and security solutions via sysfs, a v=
irtual
>> >> > filesystem that can be used by user-mode applications. The new
>> >> > documentation cover HP-specific firmware sysfs attributes such S=
ecure
>> >> > Platform Management and Sure Start. Each section provides securi=
ty
>> >> > feature description and identifies sysfs directories and files e=
xposed
>> >> > by the driver.
>> >> >
>> >> > Many HP Commercial notebooks include a feature called Secure Pla=
tform
>> >> > Management (SPM), which replaces older password-based BIOS setti=
ngs
>> >> > management with public key cryptography. PC secure product manag=
ement
>> >> > begins when a target system is provisioned with cryptographic ke=
ys
>> >> > that are used to ensure the integrity of communications between =
system
>> >> > management utilities and the BIOS.
>> >> >
>> >> > HP Commercial notebooks have several BIOS settings that control =
its
>> >> > behaviour and capabilities, many of which are related to securit=
y.
>> >> > To prevent unauthorized changes to these settings, the system can
>> >> > be configured to use a cryptographic signature-based authorizati=
on
>> >> > string that the BIOS will use to verify authorization to modify =
the
>> >> > setting.
>> >> >
>> >> > Linux Security components are under development and not publishe=
d yet.
>> >> > The only linux component is the driver (hp bioscfg) at this time.
>> >> > Other published security components are under Windows.
>> >> >
>> >> > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
>> >> >
>> >> > ---
>> >> > Based on the latest platform-drivers-x86.git/for-next
>> >> > ---
>> >> >  .../testing/sysfs-class-firmware-attributes   | 102 +++++++++++=
++++++-
>> >> >  1 file changed, 100 insertions(+), 2 deletions(-)
>> >> >
>> >> > diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attr=
ibutes
>> >> > b/Documentation/ABI/testing/sysfs-class-firmware-attributes
>> >> > index 4cdba3477176..f8d6c089228b 100644
>> >> > --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
>> >> > +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
>> >> <snip>
>> >> > +
>> >> > +
>> >> > +             HP specific class extensions - Secure Platform Man=
ager (SPM)
>> >> > +             --------------------------------
>> >> > +
>> >> > +What:                /sys/class/firmware-attributes/*/authentic=
ation/SPM/kek
>> >> > +Date:                March 29
>> >> > +KernelVersion:       5.18
>> >> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
>> >> > +Description:
>> >> > +             'kek' Key-Encryption-Key is a write-only file that=
 can be used to
>> >> > configure the
>> >> > +             RSA public key that will be used by the BIOS to ve=
rify
>> >> > +             signatures when setting the signing key.  When wri=
tten,
>> >> > +             the bytes should correspond to the KEK certificate
>> >> > +             (x509 .DER format containing an OU).  The size of =
the
>> >> > +             certificate must be less than or equal to 4095 byt=
es.
>> >> > +
>> >> > +What:                /sys/class/firmware-attributes/*/authentic=
ation/SPM/sk
>> >> > +Date:                March 29
>> >> > +KernelVersion:       5.18
>> >> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
>> >> > +Description:
>> >> > +             'sk' Signature Key is a write-only file that can b=
e used to
>> >> > configure the RSA
>> >> > +             public key that will be used by the BIOS to verify=
 signatures
>> >> > +             when configuring BIOS settings and security featur=
es.  When
>> >> > +             written, the bytes should correspond to the modulu=
s of the
>> >> > +             public key.  The exponent is assumed to be 0x10001.
>> >> > +
>> >> > +What:                /sys/class/firmware-attributes/*/authentic=
ation/SPM/status
>> >> > +Date:                March 29
>> >> > +KernelVersion:       5.18
>> >> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
>> >> > +Description:
>> >> > +             'status' is a read-only file that returns ASCII te=
xt in JSON format
>> >> > reporting
>> >> > +             the status information.
>> >> > +
>> >> > +               "State": "not provisioned | provisioned | provis=
ioning in progress
>> >> > ",
>> >> > +               "Version": " Major. Minor ",
>> >> > +               "Nonce": <16-bit unsigned number display in base=
 10>,
>> >> > +               "FeaturesInUse": <16-bit unsigned number display=
 in base 10>,
>> >> > +               "EndorsementKeyMod": "<256 bytes in base64>",
>> >> > +               "SigningKeyMod": "<256 bytes in base64>"
>> >> > +
>> >> > +What:                /sys/class/firmware-attributes/*/attribute=
s/Sure_Start/audit_log_entries
>> >> > +Date:                March 29
>> >> > +KernelVersion:       5.18
>> >> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
>> >> > +Description:
>> >> > +             'audit_log_entries' is a read-only file that retur=
ns the events in
>> >> > the log.
>> >> > +
>> >> > +                     Audit log entry format
>> >> > +
>> >> > +                     Byte 0-15:   Requested Audit Log entry  (E=
ach Audit log is 16 bytes)
>> >> > +                     Byte 16-127: Unused
>> >> > +
>> >> > +What:                /sys/class/firmware-attributes/*/attribute=
s/Sure_Start/audit_log_entry_count
>> >> > +Date:                March 29
>> >> > +KernelVersion:       5.18
>> >> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
>> >> > +Description:
>> >> > +             'audit_log_entry_count' is a read-only file that r=
eturns the number
>> >> > of existing
>> >> > +             audit log events available to be read. Values are =
separated using
>> >> > comma (``,``)
>> >> > +
>> >> > +                     [No of entries],[log entry size],[Max numb=
er of entries supported]
>> >> > +
>> >> > +             log entry size identifies audit log size for the c=
urrent BIOS
>> >> > version.
>> >> > +             The current size is 16 bytes but it can be up to 1=
28 bytes long in
>> >> > future BIOS
>> >> > +             versions.
>> >> > --
>> >> > 2.34.1
>> >>
>> >> Firstly apologies as I've done a poor job of following the updates=
 to this series - so if this has already been discussed and agreed by mo=
re seasoned kernel contributors please feel free to disregard my comment=
s :) I was catching up on my inbox and had some thoughts.
>> >
>> > No worries.
>> >
>> >>
>> >> For SPM - as this replaces password usage, is it done for all acco=
unt types? It seems a bit odd having it be a replacement for the passwor=
ds but in it's own location and not in the same place as (for example) A=
dmin/current_password.
>> >> For the Lenovo implementation I put certificate, signature and sav=
e_signature in the authentication/Admin directory and I realise your imp=
lementation is different with the keys but if the kek and sk are only us=
ed with the Admin account then shouldn't they also be in that directory?=
 It would be nice to have some commonality across vendors in my opinion.
>> >>
>> >
>> > SPM (Security Platform Management) does not replace password usage =
and
>> > it is done for the Admin account (Setup Password).  SPM is a securi=
ty
>> > feature available to the user to configure/update BIOS settings when
>> > Sure Admin is enabled in BIOS.  One of the files provided under SPM=
 is
>> > the key _role and its value is set to =E2=80=98bios-spm.=E2=80=99  =
 A =E2=80=98bios-spm=E2=80=99 role
>> > indicates a password is used in combination with an
>> > endorsement/signing key.  It is also the reason why SPM is kept
>> > separate under the list of authentication attributes.
>>
>> Ah - I think I get it, and in that case I can see why you keep it sep=
arate and it is a unique role.
>> I withdraw my suggestion :)
>>
>> >
>> >> For the Sure_Start I would propose de-branding this so it's generi=
c and I don't think it fits under attributes as it doesn't support any o=
f the other required attribute fields. I think your implementation of an=
 audit log seems neat but if another vendor was to do similar it would b=
e better to be able to reuse the same attribute name and enable common t=
ooling.
>> >> I propose having this as just log/audit_entries and log/audit_coun=
t and have the log folder in the top alongside authentication and attrib=
utes.
>> >> If someone wants to add other logs in the future it would be a goo=
d place to have them.
>> >
>> > I like the idea of having a log folder alongside authentication and
>> > attributes where future logs can be placed.  Unfortunately, Sure_St=
art
>> > is part of the security attributes  and the initial driver provides=
 a
>> > minimal implementation.   Other attributes associated with Sure_Sta=
rt
>> > and available in BIOS are  'SureStart Production Mode', 'Sure Start
>> > Security Event Boot Notification', 'Sure Start BIOS Settings
>> > Protection', 'Sure Start Secure Boot Keys Protection', and 'Sure St=
art
>> > Security Event Policy'
>>
>> Aren't all of these just regular attributes that show up under the at=
tributes folder (and have current_value and possible_value settings etc)=
? Do they get created in your equivalent of probing the BIOS to determin=
e what attributes are available or are they manually created entries? (I=
'm assuming automatic or they would be also added to the documentation)
>
> 'SureStart Production Mode', 'Sure Start Security Event Boot
> Notification', 'Sure Start BIOS Settings Protection', 'Sure Start
> Secure Boot Keys Protection', and 'Sure Start Security Event Policy'
> are reported by BIOS therefore listed under attributes.  'Sure
> Start/audit_log_entries and Sure_Start/audit_log_count_entries are
> created manually and kept under attributes/Sure_Start; same location
> as all other 'Sure Start' entries.
>
Thanks for the clarification

>>
>> It seemed to me the audit log entries were being handled differently =
because you had to specifically create the entries, with (I assume) some=
 special handling for display?
>
> Gathering the number of entries and reading each audit logs require
> making multiple WMI calls (Security related).  If 'Sure Start' was not
> part of a security feature, I would agree to move it under a log
> directory; sadly it is not the case.

OK - I'll defer to the more experienced kernel folk; but to me I think t=
he argument still stands that these two fields are not standard attribut=
es (they won't have any of the regular attribute fields) and by being in=
 a directory they look as if they are trying to be. My vote would still =
be to:

 - make them non vendor trademark specific so it could be used by other =
vendors for similar in the future.
 - move them out of the attributes folder as they seem a bad fit to me

Thanks for all the insights - appreciated :)
Mark
