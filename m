Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03246D351A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 02:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDBAsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 20:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDBAsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 20:48:16 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF2AE192;
        Sat,  1 Apr 2023 17:48:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 65848320069B;
        Sat,  1 Apr 2023 20:48:11 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Sat, 01 Apr 2023 20:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680396491; x=1680482891; bh=U0wlLnIw1gG6CrNNGYcaBrjDC92Wf3EkbCa
        2G70M6hw=; b=Uti1hv28RWerqRNE6WscJGwMnxlGRmIhGRyNuzv9VEjTm+c0zYZ
        Dsczp6L/BcHBzRXuNPJ9ruu+qOm0r56GtsP/DwVf00d8TWiPSTVFimmvWg8vLmHN
        nTEImcLlun1TH6KXqQU7KJ1oqo72mHG3XxCV4IllwCgdImQpHomAwvR7mSrAfAAF
        IjwzI6rcbtXKRtMlL32Rg/SQ0YWs2bVCppBpA9ZfLcFS0gIIQr9G+nqx6p68PaTG
        PDdwXD1h+Nd3a/Sj/ErUcUUCC1/Dac/vlqCABzXpr8v99H/GriGL49VIc3ulUn9V
        rTh2PhUZyv97G+avt8DYgf0U6+LvheyO6OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680396491; x=1680482891; bh=U0wlLnIw1gG6CrNNGYcaBrjDC92Wf3EkbCa
        2G70M6hw=; b=rwMKcwgR64j2TMfR28sgg2ME9Xjy2GGSipw0LBnKGKF4JS8IZeh
        09do22OHUzd6pzQ1McYjDntjmFkZIqTwZK7zWUOpJeOIJo5thGyGYPTPyQ8IIoaG
        7lEDJ3XWzNXKdzi8C+RSzmac/NNMTruJ+p0y5q+xFX+Ve4e1OGt02Om7F3scUUnD
        MeEOioapH28TdWPeWowfa5DwqWuPyfcTrusR8/3RLa2mGCzpwOILwVSjUhKWaWDG
        VWHGckGOCS7YIXlEydEXxkuVaTCb683bjN+ob3MoItAJwRSO6R9yA9AqfVd4172c
        wVKR20g4Gm1KMGEOvH48jlZkQ3jUhK7eZLw==
X-ME-Sender: <xms:ytAoZJUcKBl2MViQJcsVDh7toQiMsqVWttt43U9Do0QKVN-zzY6yJA>
    <xme:ytAoZJklFJeIOxNh9UmbW2P9AZkWKRtr1U9HSaoG1iOCC-toS6J4ezNvkp9YjDbRN
    hgyeNZVmvVQSUFmDM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeigedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhephfefgedufeetgfetlefgkefgvdejleelvefg
    hfejfffhtdeitdejfeekvdeugfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:ytAoZFbQx7vO1ECuCjW7ae0g5x1YllHSC3yI83RxwdQq1uReys1yAA>
    <xmx:ytAoZMVkbGENvIA2kMO5cPOD2p1szkdWScfPBAZDX7AUVNg57RfxJw>
    <xmx:ytAoZDmqj9VactPmaZ6HjWES-lNXmmWoEv9W6dSe7MV-NttLydE-zw>
    <xmx:y9AoZIxlRoBQDIk33Lq8uKbScZgJbgg-ND3zO_HrWIPjD9nY2Zt_JQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A14F1C60091; Sat,  1 Apr 2023 20:48:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <3ca7fa3b-f0d6-4b63-bfe4-8a30197d7261@app.fastmail.com>
In-Reply-To: <6da33dcc-0526-4398-bf35-655b64d07e20@t-8ch.de>
References: <20230309201022.9502-1-jorge.lopez2@hp.com>
 <20230309201022.9502-5-jorge.lopez2@hp.com>
 <6da33dcc-0526-4398-bf35-655b64d07e20@t-8ch.de>
Date:   Sat, 01 Apr 2023 20:47:50 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        "Jorge Lopez" <jorgealtxwork@gmail.com>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] Introduction of HP-BIOSCFG driver [4]
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

As I implemented similar on our platforms I have a couple of suggestions=
 which may or may not be helpful.

On Sat, Apr 1, 2023, at 7:58 AM, Thomas Wei=C3=9Fschuh wrote:
> Hi Jorge,
>
<snip>
> On 2023-03-09 14:10:22-0600, Jorge Lopez wrote:
<snip>
>
>> Many features of HP Commercial PC=E2=80=99s can be managed using Wind=
ows
>> Management Instrumentation (WMI). WMI is an implementation of Web-Bas=
ed
>> Enterprise Management (WBEM) that provides a standards-based interface
>> for changing and monitoring system settings.  HP BISOCFG driver provi=
des
>> a native Linux solution and the exposed features facilitates the
>> migration to Linux environments.

I'd remove this paragraph personally - but as a minor note, typo in BISO=
CFG

<snip>
>>=20
>> diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attribute=
s b/Documentation/ABI/testing/sysfs-class-firmware-attributes
>> index 4cdba3477176..d1ae6b77da13 100644
>> --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
>> +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
<snip>
>> @@ -126,6 +133,38 @@ Description:
>>  					value will not be effective through sysfs until this rule is
>>  					met.
>> =20
>> +		HP specific class extensions
>> +		------------------------------
>> +
>> +		On HP systems the following additional attributes are available:
>> +
>> +		"ordered-list"-type specific properties:
>> +
>> +		elements:
>> +					A file that can be read to obtain the possible
>> +					list of values of the <attr>. Values are separated using
>> +					semi-colon (``;``). The order individual elements are listed
>> +					according to their priority.  An Element listed first has the
>> +					hightest priority. Writing the list in a different order to
>> +					current_value alters the priority order for the particular
>> +					attribute.

isn't this already covered in the 'possible_values' attribute - it's jus=
t a string of items? Curious as to when/how this would be used instead o=
f possible_values (but I should probably read the code)
Typo in 'hightest'.

<snip>
>
>> +
>> +
>>  What:		/sys/class/firmware-attributes/*/authentication/
>>  Date:		February 2021
>>  KernelVersion:	5.11
>> @@ -206,7 +245,7 @@ Description:
<snip>
>> @@ -296,6 +335,15 @@ Description:
>>  						echo "signature" > authentication/Admin/signature
>>  						echo "password" > authentication/Admin/certificate_to_password
>> =20
>> +		HP specific class extensions
>> +		--------------------------------
>> +
>> +		On HP systems the following additional settings are available:
>> +
>> +		role: enhanced-bios-auth:
>> +					This role is specific to Secure Platform Management (SPM) attri=
bute.
>> +					It requires configuring an endorsement (kek) and signing certif=
icate (sk).
>> +

Your implementation might be different on HP's; but on the Lenovo's this=
 was still used along with the regular roles - it's just the authenticat=
ion changed from password to a signature approach.

Just checking that you really need a whole new role and that it isn't pa=
rt of the existing role.

<snip>

>> +		HP specific class extensions
>> +		--------------------------------
>> +
>> +What:		/sys/class/firmware-attributes/*/authentication/SPM/kek
>> +Date:		March 29
>> +KernelVersion:	5.18
>> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
>> +Description:	'kek' is a write-only file that can be used to configur=
e the
>> +		RSA public key that will be used by the BIOS to verify
>> +		signatures when setting the signing key.  When written,
>> +		the bytes should correspond to the KEK certificate
>> +		(x509 .DER format containing an OU).  The size of the
>> +		certificate must be less than or equal to 4095 bytes.
>> +
>> +
>> +What:		/sys/class/firmware-attributes/*/authentication/SPM/sk
>> +Date:		March 29
>> +KernelVersion:	5.18
>> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
>> +Description:	'sk' is a write-only file that can be used to configure=
 the RSA
>> +		public key that will be used by the BIOS to verify signatures
>> +		when configuring BIOS settings and security features.  When
>> +		written, the bytes should correspond to the modulus of the
>> +		public key.  The exponent is assumed to be 0x10001.
>

I wondered if these could be combined with the signature and certificate=
 fields that I implemented for the Lenovo platforms - and those be moved=
 out of the Lenovo specific section and then made general (and optional)
kek looks like it corresponds to certificate and sk to signature?

>
>> +
>> +
>> +What:		/sys/class/firmware-attributes/*/attributes/last_error
>> +Date:		March 29
>> +KernelVersion:	5.18
>> +Contact:	"Jorge Lopez" <jorge.lopez2@hp.com>
>> +Description:	'last_error' is a read-only file that returns WMI error=
 number
>> +		and message reported by last WMI command.
>
> Does this provide much value?
> Or could this error just be logged via pr_warn_ratelimited()?

This one seemed odd to me too - doesn't the driver return the error to t=
he use on a failed WMI access?

