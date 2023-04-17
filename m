Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F16E517C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDQUPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDQUPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:15:03 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECE446AC;
        Mon, 17 Apr 2023 13:15:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4CB913200991;
        Mon, 17 Apr 2023 16:14:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 17 Apr 2023 16:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duggan.us; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1681762495; x=1681848895; bh=puHS/9Gsnu4EihLPDZetwQwvkbohwlsflAA
        TKAuIYAY=; b=GjgYs5EUwhDq3E2kJ1Dr9Cvj3F2neXvZ0NxHQOHd7AhyOReFHmZ
        MosDrgKZB6IEn2ghSLtnOvC1VTSk0fGI2kf4w836OcXBvXCvcrhFxR5J7pk2Ifm3
        J846h18LI139zRgFiyP4dVhfJO4sHQCjlpKWhxLLbTsK+x/cMxv36OctJUhxrH17
        WwIY5TWDal8bkJYADKtvdKq711QFDf190pWHPLyAwC0MfUMygI5rSud38gW2BJoH
        Haht5+feVM6OerXrhaT4oLq5gN6MZU5tWWe8nb2LzS9n7RaVYuaZXMDfhmn94zLT
        OAKlymtsFFSTEVrdze1WNYWtk38fjaky34g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681762495; x=1681848895; bh=puHS/9Gsnu4EihLPDZetwQwvkbohwlsflAA
        TKAuIYAY=; b=iOJDf/IjxQQr0+qwLaqFi8xLiTgXDvlPkUJj750Ei/5bDPKVEZ6
        M9dTAoTeBnJk4WLaYcjkwUPUSBdC0/LYXzkEiw3ocaqfe+Sykp+dfTK820d7Mq+G
        2z/Gi9owyFQV7++sunsZFb9nt7byHNjhhAnJoDAgL0owzJxwwVJlbpuKcDDesx8/
        PSQHDmONtTwWGMrQKDfrniQnI9bU4fr4Dz6C6x8MDd6lAA9ZYPUvU8++OyPsnDDX
        RCt2evhLJqFTo5uzEZ+3s9c8SSzBStSvWc8egE2XiB2khDIOLys3sMj4CVBIPGku
        kq8lXdieoQYnMgGT95r2FgSiI3qQkZW6kug==
X-ME-Sender: <xms:v6g9ZHvAdMFaXs1TFPGMswTX492b-9rIlOPq3zIbvWG2kW6Luw5Zhw>
    <xme:v6g9ZIeS_qblLLL7y8kafnU_ST4_sNWGV0bVvecwkrrzbX4mrL_fegG-mZvS9rjIG
    d9hoFmygAh9p4a6Tg>
X-ME-Received: <xmr:v6g9ZKwF3u-Yk8gY7TR6jb960iNGdd1Y-4Akpo9CpzwLjOJk9_lJiu2rVf-WAHiiKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheptehn
    ughrvgifucffuhhgghgrnhcuoegrnhgurhgvfiesughughhgrghnrdhusheqnecuggftrf
    grthhtvghrnhepveehheeuffduteeuhfetfefhleetteekvdehlefgfeekhfekteeujeet
    teeludetnecuffhomhgrihhnpegsuhhtthhonhhsrdhpshenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesughughhgrghnrdhu
    sh
X-ME-Proxy: <xmx:v6g9ZGNeFEJaYfKdydCsbrzi2azBCQDE-6M0pvMxk401gYecHk_YGw>
    <xmx:v6g9ZH_mAImqGGpZTpwcmoD9AuGYyuh_kexunzfSsZwOxqBsEZ5d5w>
    <xmx:v6g9ZGXackSYofpmzc7DVT6jmPtST-l9pcAremJo07_BzWuIp-viGA>
    <xmx:v6g9ZObd2fFoxkZ4fXaT21wnnib8NboxaSXV5oOXyavdxZGY_smo7g>
Feedback-ID: i06a0429a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Apr 2023 16:14:53 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v2] Input: synaptics - disable intertouch for Lenovo L440
From:   Andrew Duggan <andrew@duggan.us>
In-Reply-To: <CALNJtpV4WsknSSfBBer-MM0y_V=O5Fv2Lc3ei3heEyZwvR2rzQ@mail.gmail.com>
Date:   Mon, 17 Apr 2023 13:14:42 -0700
Cc:     Lyude Paul <lyude@redhat.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        "amandhoot12@gmail.com" <amandhoot12@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "jdenose@google.com" <jdenose@google.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "markpearson@lenovo.com" <markpearson@lenovo.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        benjamin.tissoires@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <65C23A49-5A55-4CF4-9AFD-2DA504DAABF5@duggan.us>
References: <063c8f77c216ffac463532023009124542d54c19.camel@redhat.com>
 <20230414092353.v2.1.Ieb687047a5b75c7b7ee5dd258207ef5ca9a3b728@changeid>
 <CALNJtpXLHHSV8YshUnk0opLNMUJpT7DgBNRYXoP2Yn-fnA8vPA@mail.gmail.com>
 <CALNJtpV4WsknSSfBBer-MM0y_V=O5Fv2Lc3ei3heEyZwvR2rzQ@mail.gmail.com>
To:     Jonathan Denose <jdenose@chromium.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lyude and Jonathan,

I was just about to reply and suggest that we look into this issue a =
little more since the touchpad in the L440 would benefit from the =
additional data from the intertouch interface. Especially, since it has =
a large area and several buttons. PS/2 only reports position data for =
two fingers so three finger gestures is another example.

Generally, these types of suspend / resume issues are the result of the =
touchpad resetting and the firmware expecting commands from the PS/2 =
interface. On resume, the PS/2 driver should send a command over the =
PS/2 interface to switch the touchpad firmware back into intertouch =
(SMBus) mode. The logs you provided look like that's what is happening =
here. The SMBus driver is sending commands, but the touchpad firmware =
won't respond until it is switch back into intertouch mode. It has been =
a while since I have worked on these touchpads, but from what I remember =
I think there is code in the psmouse-smbus driver to handle these =
situations. I added Benjamin Tissoires to CC since I think he worked on =
that handling. I thought suspend / resume was tested on with these "top =
button" touchpads when support for them was added. I don't know if the =
L440 specifically included in the testing. I'm curious if this is a =
regression or not.

Regarding the patch, I do have one comment below:

> On Apr 17, 2023, at 11:52, Jonathan Denose <jdenose@chromium.org> =
wrote:
>=20
> CAUTION: Email originated externally, do not click links or open =
attachments unless you recognize the sender and know the content is =
safe.
>=20
>=20
> Sorry, I thought I sent this as plain text but I think maybe not.
> Trying once more, the message was:
>=20
> I think that disabling synaptics_intertouch would resolve the issue
> mentioned in the commit, but cause a regression in the functionality
> that intertouch is supposed to bring, like three-finger gestures. I'm
> attaching some of the logs that I captured when the touchpad was
> failing on resume. I think the main culprit is
> i2c_smbus_read_byte_data where the driver is unable to get the SMBus
> version number. I get the following lines in dmesg:
>=20
> [ 2869.745860] rmi4_smbus 0-002c: failed to get SMBus version number!
> [ 2869.746060] rmi4_physical rmi4-00: rmi_driver_reset_handler: Failed
> to read current IRQ mask.
> [ 2869.746260] rmi4_f01 rmi4-00.fn01: Failed to restore normal =
operation: -6.
> [ 2869.746262] rmi4_f01 rmi4-00.fn01: Resume failed with code -6.
> [ 2869.746264] rmi4_physical rmi4-00: Failed to suspend functions: -6
> [ 2869.746265] rmi4_smbus 0-002c: Failed to resume device: -6
> [ 2869.746268] rmi4_smbus 0-002c: rmi_smb_resume+0x0/0x6b [rmi_smbus]
> returned 0 after 549 usecs
> [ 2869.746446] rmi4_physical rmi4-00: Failed to read irqs, code=3D-6
>=20
> Any ideas on what might be causing this, only on resume from deep =
sleep?
>=20
>=20
> On Mon, Apr 17, 2023 at 1:47=E2=80=AFPM Jonathan Denose =
<jdenose@chromium.org> wrote:
>>=20
>> I think that disabling synaptics_intertouch would resolve the issue =
mentioned in the commit, but cause a regression in the functionality =
that intertouch is supposed to bring, like three-finger gestures. I'm =
attaching some of the logs that I captured when the touchpad was failing =
on resume. I think the main culprit is i2c_smbus_read_byte_data where =
the driver is unable to get the SMBus version number. I get the =
following lines in dmesg:
>>=20
>> [ 2869.745860] rmi4_smbus 0-002c: failed to get SMBus version number!
>> [ 2869.746060] rmi4_physical rmi4-00: rmi_driver_reset_handler: =
Failed to read current IRQ mask.
>> [ 2869.746260] rmi4_f01 rmi4-00.fn01: Failed to restore normal =
operation: -6.
>> [ 2869.746262] rmi4_f01 rmi4-00.fn01: Resume failed with code -6.
>> [ 2869.746264] rmi4_physical rmi4-00: Failed to suspend functions: -6
>> [ 2869.746265] rmi4_smbus 0-002c: Failed to resume device: -6
>> [ 2869.746268] rmi4_smbus 0-002c: rmi_smb_resume+0x0/0x6b [rmi_smbus] =
returned 0 after 549 usecs
>> [ 2869.746446] rmi4_physical rmi4-00: Failed to read irqs, code=3D-6
>>=20
>> Any ideas on what might be causing this, only on resume from deep =
sleep?
>>=20
>>=20
>> On Fri, Apr 14, 2023 at 11:41=E2=80=AFAM Jonathan Denose =
<jdenose@chromium.org> wrote:
>>>=20
>>> When intertouch is enabled for the L440 a (deep)sleep/resume
>>> cycle causes the touchpad driver to hang which causes the
>>> touchpad to become unresponsive. Disable intertouch resolves
>>> this issue and the touchpad is fine after resume from sleep.
>>>=20
>>> Additionally, when the PNP id for the L440 is only removed
>>> from the topbuttonpad_pnp_ids list, a message is logged to
>>> enable psmouse.synaptics_intertouch, which would cause the
>>> sleep/resume issue again. By removing the PNP id from
>>> topbutton_pnp_ids and then adding it to the
>>> forcepad_pnp_ids array, intertouch is disabled and the
>>> message is not logged.
>>>=20
>>> Signed-off-by: Jonathan Denose <jdenose@google.com>
>>> ---
>>>=20
>>> Changes in v2:
>>> - remove debug statement
>>>=20
>>> drivers/input/mouse/synaptics.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/drivers/input/mouse/synaptics.c =
b/drivers/input/mouse/synaptics.c
>>> index fa021af8506e4..b7218b7652c20 100644
>>> --- a/drivers/input/mouse/synaptics.c
>>> +++ b/drivers/input/mouse/synaptics.c
>>> @@ -150,7 +150,6 @@ static const char * const topbuttonpad_pnp_ids[] =
=3D {
>>>        "LEN2001", /* Edge E431 */
>>>        "LEN2002", /* Edge E531 */
>>>        "LEN2003",
>>> -       "LEN2004", /* L440 */
>>>        "LEN2005",
>>>        "LEN2006", /* Edge E440/E540 */
>>>        "LEN2007",
>>> @@ -198,6 +197,7 @@ static const char * const smbus_pnp_ids[] =3D {
>>> static const char * const forcepad_pnp_ids[] =3D {
>>>        "SYN300D",
>>>        "SYN3014",
>>> +       "LEN2004", /* L440 */

While this does seem to elliminate the message, the touchpad in the L440 =
is not a forcepad. Adding the L440 PnP ID here implies that it is one of =
these special forcepads which reports "force" data for contacts and that =
is not the case here.

>>>        NULL
>>> };
>>>=20
>>> =E2=80=94
>>> 2.39.2
>>>=20


Andrew

