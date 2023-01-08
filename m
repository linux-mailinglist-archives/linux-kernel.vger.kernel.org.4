Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E846616A5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 17:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbjAHQaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 11:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbjAHQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:30:04 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2491E1;
        Sun,  8 Jan 2023 08:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673195397; bh=+49/K2sPatrtd8JAfOCpWQ9VkmDiH7+o75Z1YN8ypjc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=e7ouvHoHRSMlnqXAECzQXn7Dk8w6gbXMxCEmALVnDnd1MH/77Bi+bFpGbdR7GNQdy
         mHbv1adhO3d29S9H8VN/KddJ8feBe2cQS1B2Q+od/EqFlahQvgxB+zLRAEZxSGKlE3
         C5TFlhjkH+YoO2TCau0+YVMeBer7DoMkO+KjVZVA3ZsAKuUNiun2KNpsAPmhrGxOYO
         u1lclzWBwEyeOz0N1UetcsOxRfz7gYLz2iFZBAgwBxgymO5fvLHeUzztJxDNecOYOp
         UIhmtBudAnEM6dAp7uSznbLt3C8EydTX1rM2w+qXmnIXCM3Eee1rSpy+DCkIJX89+h
         4D75Fbx0XjVuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.216.48]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1oqyfS1CNb-00zWcP; Sun, 08
 Jan 2023 17:29:57 +0100
Message-ID: <6ff1691d505630f3cc7bc1d5c128a7252f66bf71.camel@gmx.de>
Subject: Re: brcmfmac regression - cfg80211_set_channel: set chanspec 0x????
 fail, reason -52 spew
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Chi-hsien Lin <chi-hsien.lin@cypress.com>,
        Ian Lin <ian.lin@infineon.com>, KalleValo <kvalo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Sun, 08 Jan 2023 17:29:56 +0100
In-Reply-To: <509b8748971fd988c5dd623adc6db97617a50fb5.camel@gmx.de>
References: <509b8748971fd988c5dd623adc6db97617a50fb5.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZRC5O3trthvLiGdvwZaEbXwbgSM6rQ/lYOZU8IgXvZNW6JR5grj
 Kz0Lgam5kZB9rxuTF3wMY36HQakOKKVgzU+i+wC/361X/XBR5s9+nDK6nyP7gFa0/6oIKCu
 Sk5KcD7Yo+fm9d2bmR0Iy+dw2MICWGr0Y083Z8/xNJyss15AYwkwQs10rEKhIzwAgoBUPi0
 dzOcsrt1gtrYHg6pceliA==
UI-OutboundReport: notjunk:1;M01:P0:HBTCLLyol5A=;ZBd8zpB5VtIgDea7dP7xTQbOnfq
 Htmh53nnVldvc/ygMIa7EyPg53JHOO3G7EKrMubRoPl0rKJqowylh7wCv+kaVW846GGOHvEVs
 fnsipIgnZKQaqTniqQXrZAwe2l2a/8qnpDOmRkQz2IdGQDoFuouF4tuMPZ2y4/TmICYzODbdr
 cXcu2LJz7IFwgBs5GntekpUbJwQ+2AHMDx3OB1sJ47AkTn/PpjYmeoitPBb9TWd6IKmfpqaO6
 nqzP5d60Gqf/53KdnekGkYTZnzuHW+0Uzg68tNlZrl8KdtV+iG0IRPECQg3yXvQ4N0lTowkRu
 3a2QRXL0SQ5s6UKtndyyR3VkC1zVDbDJMWQxFxpK2dTzy0IokXi5TQSH05rpq2ZXF1MKwIU0h
 Lve1GjFEjjxXICHH4Z2Sl5tVakxp2SML06a9eJqm1ELdkHFAG2W7f/QC3nEdk5rxM9IJfNCNm
 omPKsRgdgLW/xUpIFT0ZIRHLPCd1FzsCLqcHsKrOTJCoENzs+L7jJlq4UfbsYq2FyynhSgo4+
 DbRf44eovyX5dNQZngGdn+rWqtKWoWOioBTvCA7yb3MTGonvPfTqBIczFJkWffxPawMaJVY/k
 iMwjlLMhXpE21k/Apzmdz9pXxOdD6QX1sMwYdE68d1FcUWiI8q+E629jlLge5nS+3WGbzmClE
 d1UnhsRS8UwD7u3FCJ3PINrRj5/VZDXCT4ejASznml+iQ0EgKJYZhZZ15tqL5d/Vm9J7+zzKZ
 6/te0sMrDDfL9lrZXuIIQDbi2g2cuXUfa3M92cMcwNYT5qhW7DJmPucDu92cuoUljdyBYlQ+3
 gtqOdWvglO5HUrBye9KPt489U4FR8P8m5D+65MS10AC7P0S+hatZkycRCAEtEh1KtIJxuFjgh
 B5GVPOz9CseiFZ/LOYw8piv9nLbVgy0Mosn5hpBGm/hQqq+ReKXkJaQr7GX5z9DwFMHAAJRRZ
 FpPd6XmrGPdZ0Qd5A1RyknhLsNg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geez.  Sorry for multiple copies, let's see if any of the CCs work.

On Sun, 2023-01-08 at 17:18 +0100, Mike Galbraith wrote:
> Greetings,
>
> 6c04deae1438 "brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoCha=
nnelSelection"
>
> This commit seems to inspire my little raspberrypi 4b to moan
> endlessly, though it seems to work.=C2=A0 Brute force revert silenced it=
.
>
> [=C2=A0=C2=A0=C2=A0 7.917448] brcmfmac: F1 signature read @0x18000000=3D=
0x15264345
> [=C2=A0=C2=A0=C2=A0 7.974270] brcmfmac: brcmf_fw_alloc_request: using br=
cm/brcmfmac43455-sdio for chip BCM4345/6
> [=C2=A0=C2=A0=C2=A0 8.326846] brcmfmac: brcmf_c_preinit_dcmds: Firmware:=
 BCM4345/6 wl0: Jan=C2=A0 4 2021 19:56:29 version 7.45.229 (617f1f5 CY) FW=
ID 01-2dbd9d2e
> [=C2=A0=C2=A0 10.799571] brcmfmac: brcmf_cfg80211_set_power_mgmt: power =
save enabled
> [=C2=A0=C2=A0 15.078022] brcmfmac: cfg80211_set_channel: set chanspec 0x=
100e fail, reason -52
> [=C2=A0=C2=A0 15.078347] brcmfmac: cfg80211_set_channel: set chanspec 0x=
d022 fail, reason -52
> [=C2=A0=C2=A0 15.185674] brcmfmac: cfg80211_set_channel: set chanspec 0x=
d026 fail, reason -52
> [=C2=A0=C2=A0 15.289609] brcmfmac: cfg80211_set_channel: set chanspec 0x=
d02a fail, reason -52
> [=C2=A0=C2=A0 15.393796] brcmfmac: cfg80211_set_channel: set chanspec 0x=
d02e fail, reason -52
> [=C2=A0=C2=A0 17.066478] brcmfmac: cfg80211_set_channel: set chanspec 0x=
d090 fail, reason -52
> [=C2=A0=C2=A0 17.066923] brcmfmac: cfg80211_set_channel: set chanspec 0x=
d095 fail, reason -52
> [=C2=A0=C2=A0 17.070632] brcmfmac: cfg80211_set_channel: set chanspec 0x=
d099 fail, reason -52
> [=C2=A0=C2=A0 17.071080] brcmfmac: cfg80211_set_channel: set chanspec 0x=
d09d fail, reason -52
> [=C2=A0=C2=A0 17.071653] brcmfmac: cfg80211_set_channel: set chanspec 0x=
d0a1 fail, reason -52
> [=C2=A0=C2=A0 17.072197] brcmfmac: cfg80211_set_channel: set chanspec 0x=
d0a5 fail, reason -52
>

