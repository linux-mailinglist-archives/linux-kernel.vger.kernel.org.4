Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4943C736BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjFTMMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjFTMMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:12:01 -0400
X-Greylist: delayed 579 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Jun 2023 05:11:58 PDT
Received: from mail.dieselschrauber.org (mail.dieselschrauber.org [178.209.53.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C08B7;
        Tue, 20 Jun 2023 05:11:58 -0700 (PDT)
Received: from dummy.faircode.eu (unknown [194.209.24.240])
        by mail.dieselschrauber.org (Postfix) with ESMTPSA id A6737376014D;
        Tue, 20 Jun 2023 14:02:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=dieselschrauber.org;
        s=dkim; t=1687262536;
        bh=x8K3MMaszO5Uf0nnxeIGXclTqclkKBKc3JBT5oBivsE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ddcnxai8reizsJ+YPex5eUb1BjbhDhZ8TPgHF8NQIUuV7fQrGMv1kaW+zoaJiKADk
         cBmGYi23WDb5o71fu1EqUnGzoT7d1Z2AtVJsujvQWOw3cV6u51bDYd8E2fm1UAkicY
         AAsM8xYW/of92LyFClMkZMdWILWWTLAvd8ixcCfk=
Date:   Tue, 20 Jun 2023 14:02:15 +0200 (GMT+02:00)
From:   Rainer Kaufmann <shop@dieselschrauber.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kaufmann Automotive GmbH <info@kaufmann-automotive.ch>
Message-ID: <4a7e6dde-f45f-4bb5-9f81-d0ec17ce32e9@dieselschrauber.org>
In-Reply-To: <ZJFDvJh6TRJhyKFe@hovoldconsulting.com>
References: <20230613093351.3383-1-oneukum@suse.com> <ZJFDvJh6TRJhyKFe@hovoldconsulting.com>
Subject: Re: [PATCH] USB: serial-simple: adding Kaufmann RKS+CAN VCP
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <4a7e6dde-f45f-4bb5-9f81-d0ec17ce32e9@dieselschrauber.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

it is a CAN bus interface / license dongle with a custom firmware.

Details about the interface hardware:
https[https://shop.dieselschrauber.org/en/can-usb-interface-kit-p-313.php]:=
//[https://shop.dieselschrauber.org/en/can-usb-interface-kit-p-313.php]shop=
.dieselschrauber.org[https://shop.dieselschrauber.org/en/can-usb-interface-=
kit-p-313.php]/en/[https://shop.dieselschrauber.org/en/can-usb-interface-ki=
t-p-313.php]can-usb-interface-kit-p-313.php[https://shop.dieselschrauber.or=
g/en/can-usb-interface-kit-p-313.php]

Best regards, Rainer

20.06.2023 08:14:25 Johan Hovold <johan@kernel.org>:

> On Tue, Jun 13, 2023 at 11:33:51AM +0200, Oliver Neukum wrote:
>> Adding the device and product ID
>=20
> Can you say something more about the product here (e.g. to indicate that
> this is indeed a custom firmware that requires a simple driver)?
>=20
>> Reported-by: Kaufmann Automotive GmbH <info@kaufmann-automotive.ch>
>> Tested-by: Kaufmann Automotive GmbH <info@kaufmann-automotive.ch>
>> Signed-off-by: Oliver Neukum <oneukum@suse.com>
>> ---
>> drivers/usb/serial/usb-serial-simple.c | 7 +++++++
>> 1 file changed, 7 insertions(+)
>>=20
>> diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial=
/usb-serial-simple.c
>> index 4c6747889a19..3612031030bb 100644
>> --- a/drivers/usb/serial/usb-serial-simple.c
>> +++ b/drivers/usb/serial/usb-serial-simple.c
>> @@ -117,6 +117,11 @@ DEVICE(suunto, SUUNTO_IDS);
>> =C2=A0=C2=A0=C2=A0 { USB_DEVICE(0x908, 0x0004) }
>> DEVICE(siemens_mpi, SIEMENS_IDS);
>>=20
>> +/* KAUFMANN RKS+CAN VCP */
>> +#define KAUFMANN_IDS()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
\
>> +=C2=A0=C2=A0 { USB_DEVICE(0x16d0, 0x0870) }
>> +DEVICE(kaufmann, KAUFMANN_IDS);
>=20
> Can you add this one after GOOGLE_IDS() to approximate some ordering?
>=20
> I'll try to move the rest in place later.
>=20
>> +
>> /* All of the above structures mushed into two lists */
>> static struct usb_serial_driver * const serial_drivers[] =3D {
>> =C2=A0=C2=A0=C2=A0 &carelink_device,
>> @@ -133,6 +138,7 @@ static struct usb_serial_driver * const serial_drive=
rs[] =3D {
>> =C2=A0=C2=A0=C2=A0 &hp4x_device,
>> =C2=A0=C2=A0=C2=A0 &suunto_device,
>> =C2=A0=C2=A0=C2=A0 &siemens_mpi_device,
>> +=C2=A0=C2=A0 &kaufmann_device,
>> =C2=A0=C2=A0=C2=A0 NULL
>> };
>>=20
>> @@ -151,6 +157,7 @@ static const struct usb_device_id id_table[] =3D {
>> =C2=A0=C2=A0=C2=A0 HP4X_IDS(),
>> =C2=A0=C2=A0=C2=A0 SUUNTO_IDS(),
>> =C2=A0=C2=A0=C2=A0 SIEMENS_IDS(),
>> +=C2=A0=C2=A0 KAUFMANN_IDS(),
>> =C2=A0=C2=A0=C2=A0 { },
>> };
>=20
> Similar in these two arrays.
>=20
> Johan
