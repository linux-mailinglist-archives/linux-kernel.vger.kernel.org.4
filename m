Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6183C6BB9A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjCOQ0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCOQZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:25:58 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2072f.outbound.protection.outlook.com [IPv6:2a01:111:f403:7010::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06D923DBA;
        Wed, 15 Mar 2023 09:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQTkXBWpVBKARXItBLRhOcofXl5a8EbPKtThm3Dc8bLqjyza1npl69fkgGngAhYqF0ZoJKrnEdjCC8JO4MXW0tV0aTbeAIcH3lEK/UEgys/JqsGMQR7PyBz3Jtob7b/8L0htAuRc3625UjuqqAi46N/GFIOJ20VvxhIqVkRDm9+r5sBsYFvJVi8KIJ4O85p72JgBEY0x7ovpyp4ResTkyGsLKLgACLbJ85kn3kCQQbTn7bMbAoVZBonoprDQ2KPWznv+ioHX1Xmv1NXz/Xl3mVVhzbr93DfommTcR1r8ZEQoOA9MZXxg8/YavlJqViO/I5SbHce6EpwY49X+zYPM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+zIuWq00Uo04yw+VRm9eqzwBaBWM1TlTOJrr6Q8Twg=;
 b=T8+9y0aawuEr9lsnqWndYaj97yOV3/2YmayvhM03XJqHK/DhZfHzfCOtO6bCVhzc9LBKTx6i0OuWL/QZ16nEUHAx+WIfdop1kr2t2nX+MXW1HC3oxQPAFt4SxUnSBMbsEchYH8A19WC8FR4etj6THLGYjSo1fLI9afmQrmB6z/kFZOBeID5neiZx2WlUubnaQYLLRnHMbd2Ev4mCHKWWuCpOnIWNFzkOO5gfaEeWMm3lZaG012u3WJheLZ9RltiV+2PqUPtvkYem+6bHubZ9XzHbR7/Mp8Ub3YNzEEVzFMkU5puQXaUWUS/sFy4Zzrlm7QHWaaN7J2udMNqVjF1OTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+zIuWq00Uo04yw+VRm9eqzwBaBWM1TlTOJrr6Q8Twg=;
 b=DaspJ2dGo+Tar2tYasOGc6bssDau0C3OvYywToaNJ4FH6Zkzbu49x7y1zt/TKownJTvyMyNlE0dLvjcjHeVkAzLO6dFYWlSvpNGmHdacE0P7BLfZWcVuZ0bOC9/UCG14ZfKRy0tADzvjog1JQHSRUWHUKiQmOE3F4krRjhxoDEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 TY3P286MB3568.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.29; Wed, 15 Mar 2023 16:25:40 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fdad:8d7e:adad:dc90]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fdad:8d7e:adad:dc90%9]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 16:25:40 +0000
Date:   Thu, 16 Mar 2023 00:25:33 +0800
From:   Zenithal <i@zenithal.me>
To:     =?iso-8859-1?Q?Sosth=E8ne_Gu=E9don?= <sosthene@nitrokey.com>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robin Krahl <robin@nitrokey.com>
Subject: Re: kernel =?iso-8859-1?Q?BUG=A0a?= =?iso-8859-1?Q?t?= mm/usercopy.c
 when using usbip
Message-ID: <ZBHxfUX60EyCMw5l@Sun>
References: <aa686f98-c9a3-6225-18e8-7ca57678ce4a@nitrokey.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aa686f98-c9a3-6225-18e8-7ca57678ce4a@nitrokey.com>
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|TY3P286MB3568:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e61f2dc-ded4-4c0a-9063-08db2571ea9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pQyyfPnI/84gDfvSZYShzlj13BDNPntBREY3GiT7IeDWTjy/xbe73K643gS1vNQBHTlYC/iw3HMe1dg/dFN9R3XhxGOn6vzuYpVisrNpUns66KN6WOQvHMQXPnmSn4Tkvh8Ta/lIcR6fr56BXVuhwYxUjftsusYqo46p4esYl7opjj/nEiw5iP15+gto/TB7K4j/P4XaNjcNU01Zq/ItrRWHxjkh7M/RXAsz0fml7d+wzbIGjBHItVMg05RdvCjH7bzouam6HLqAM8QOxaMEJx0oGa+lOP2vSGSjqF84UW8298sc7NS5xsVJZXKMYzoTjNxZrMsCOmLP+8NN0GYRIcSvUn56yHpR98FvtfMW5ut8MpJL+yom5vOpfOnsv2lbiljXYKTsAC40ULP0ifSe90v3mD458esmIiO07oMyHp+J8+x10lO617g/s/74BU03ITQvT9UJOakjEJ3iqgydZshyDnfQeMa/ZPyLCpWFa6d8k+8x1vjnpnwa/F8a89e8LBo1h4AwHg4AIVDsYwOkusKkTfkS5x+Eg+CwHE0Rvudt7YiTMra3pfpqZwNNVh7EJ++6vTvk8nOYGtgbYdY4qHna83dBax1BXTwMV7TUsRIiSTqr3eLzYttB04OFIsPWF+rwQFAIB5GtNJhGt/Cux2UHmajoDVqYp6jvjaAc08v0c2mxdy+CZ0bVO7lrzSpgnlNF8yHM1lQjrJHrnksdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(39830400003)(376002)(396003)(346002)(136003)(451199018)(30864003)(5660300002)(41300700001)(6916009)(2906002)(4326008)(4001150100001)(66946007)(66476007)(66556008)(8936002)(83380400001)(45080400002)(786003)(6512007)(316002)(54906003)(966005)(6486002)(6666004)(186003)(6506007)(478600001)(9686003)(66574015)(33716001)(86362001)(41320700001)(38100700002)(49092004)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AxGHLco/lIjUZXrM2qrRMn7iNaqRpgMk1OmgXrsmqUemNPFc8bSk+8LyAF?=
 =?iso-8859-1?Q?6IT1YXRGetn8J6zQ8fKhImCLKE9oYCVHpfUNI1a2RFTaxmWDqxeaTkDccW?=
 =?iso-8859-1?Q?bfX7umioKoW+sIDvmOo8uKl6TA1e1SJsFHMvo5Sml1LIyd137qCG6doQQm?=
 =?iso-8859-1?Q?xC1d3waEa6GL6IwmMWTX+YX9wzMMJUoyAMJdanJi7GD/Q/CqACl9li9nvN?=
 =?iso-8859-1?Q?eXOrmllP7PFDe3C1EGdvnYiTADTwA1f5qG87RABvuNbMn2XQ+PuiX9o5j8?=
 =?iso-8859-1?Q?OisgpabouTjHhyPpFObITX1D68KXhMBkmBHiy9oUndKnFBsAKiZsIvCTSE?=
 =?iso-8859-1?Q?yjon9ur4HP3e0tdgstImMnnw2fiOWbqowKY9PQTUZyI7xbLn+xFAzCuGWl?=
 =?iso-8859-1?Q?hluJxSijxzJ+FTuI1r6RfzjDORxnzCtO9F0TPvpAMeC2a9sOyUT5lpPiQm?=
 =?iso-8859-1?Q?iYkI2m8xfi6DMSZPB+GJLBz2bM1Nm5B9R3Ksqgzvmlk53E0tTnHxu9HtDN?=
 =?iso-8859-1?Q?0djItGGCzg9e5/mRIvxKAZLzOFQoMWgaMqbmlj7OkxmZo7xm364wzu9DIY?=
 =?iso-8859-1?Q?KL9DDBfGMNIWHoQtM+K1LvUPDZUmQyhDToID08wNeQcbSMrpsmfmwW8E1+?=
 =?iso-8859-1?Q?7eHHqcr0UXEjLHCkVFeCYzGEFBJsOdT/V/YUCXoPMGR3JBDFUKE3yzZ4cO?=
 =?iso-8859-1?Q?9xUV/CEHxWKGFlLPNbR02dbhBqKWF0MahoVRs5iQet6/Ric/2Qt+Zpd9lO?=
 =?iso-8859-1?Q?S3G0uXuyV0RfS0tZQkYNOP+qVY81pKCTooHL8JmHcqACSf+ArjpbScLAuj?=
 =?iso-8859-1?Q?yFls1GTvuBflfT7YNEifPD3QcTdKznFJmYz+hAHvsJNqr97FG9E6E0EkZK?=
 =?iso-8859-1?Q?kxfEjQI6Ep2Z7pOqXQoMhfK/5lD06QCUR0VNsJLa6W2uwwIOzNciuOtc1U?=
 =?iso-8859-1?Q?TC9SIoaLZvY93i1ZEe9g7nLo2Rwq6iD1pmDHcsmfmxO3j9L6auIGTHd5yU?=
 =?iso-8859-1?Q?IwgdOcWmz20FXd3Z3QeTz682sV3WTyo4LS5CPwa9Ax1Pz1Jb9gmWAveV7t?=
 =?iso-8859-1?Q?MVArlt3EOC+9G9ePE1BfsLw7tXMhXjwXCbJgzUJMDgFewp2MXC8MhNamBa?=
 =?iso-8859-1?Q?qYg/rco8KiiM/vu36WWXwZgk7Vgsl7czTRpoDqI96DTmI1ZWDSEBrw34mF?=
 =?iso-8859-1?Q?VRR6YSAnOu1lcUjZQrYffhUqazYVJZsolfhXUi8EJHhqu/fUIJRijrAv9k?=
 =?iso-8859-1?Q?2VuNkMJW8rI4YabT9qUHwIifIyIceYi0XU37VtwvGo0HvQ2sthIi3qUdm+?=
 =?iso-8859-1?Q?0c2xoTDthhWgnxn2AK5+NU4voagUAUZG/oKD9BxZktYeM3Y+FBCZHthXld?=
 =?iso-8859-1?Q?gnZWIMeE2rlpONuHsaURpQvfPG2ixYYKZB378Kqn822q0yIBRa1xYyrRlU?=
 =?iso-8859-1?Q?9/z1WKnCLYUlPt57kodibXc3hS/lkVnmUou7irMjB2l6bMMb/dvcAKWujX?=
 =?iso-8859-1?Q?wU9RjQhWtIIr3atydGnEo2127NprYmXQNPBtmZudPvMkVu6hOKL0kjThO9?=
 =?iso-8859-1?Q?wm49wuSaOKJXLgArOsVy91TK5Tpbr6Y9ZRycbx/3REsb9jE12D3xIdD6Hb?=
 =?iso-8859-1?Q?E3g9csiceXYyJg2w3poMaEyOiNLvMi4rzn?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e61f2dc-ded4-4c0a-9063-08db2571ea9e
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 16:25:40.4130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnEmtp34P6p3GVULFkEnugbWhaBQKzz7/BT4eoGjs+UzPtb0y5mH3pvrUxV6DyvN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3568
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 09:40:59AM +0100, Sosth=E8ne Gu=E9don wrote:
> Hi!
>=20
> I have stumbled upon a bug that is triggered reliably by using usbip.
>=20
> We are using usbip to test our firmware. usbip attach works, but once
> `opgpcard-tools` interacts with the firmware through pcscd, a kernel bug
> happens.
> Then usbip stops working, and `lsusb` as well as other tools interacting
> with usb devices hang.
> The symptoms are similar to
> https://bugzilla.kernel.org/show_bug.cgi?id=3D215487 but the kernel bug i=
s not
> the same (see attached dmesg logs).
>=20
> The bug can be reproduced on arch (Linux archlinux 6.1.4-arch1-1 #1 SMP
> PREEMPT_DYNAMIC Sat, 07 Jan 2023 15:10:07 +0000 x86_64 GNU/Linux
> ) and debian (Linux nitropc 5.10.0-19-amd64 #1 SMP Debian 5.10.149-2
> (2022-10-21) x86_64 GNU/Linux), though the reproduction is not minimal.
>=20
> To reproduce the bug on Arch Linux, with the packages rust, pcsclite, and
> openpgp-card-tools installed:
>=20
> - Compile and run the usbip runner from this
> PR:=A0https://github.com/Nitrokey/nitrokey-3-firmware/pull/149 (`cd
> nitrokey-3-firmware/runners/usbip && cargo run --features alpha`)
> - Run `usbip attach -r localhost -b 1-1`
> - Run `pcscd`
> - Run `opgpcard status`
>=20
> The bug should happen.

I can reproduce the bug and I have captured the buggy usbip request/respons=
e
by running `tcpdump -i lo "tcp port 3240"`

First the architecture is
pcscd --ioctl-> vhci-hcd --kernel usb stack-> usbip-host --usbip tcp-> usbi=
p-runner

This is a CTRL IN request which expect a response of length 0x22,
which has indicated its expectation in the transfer_buffer_length
and USB SETUP wLength field

CMD_SUBMIT:

usbip_header_basic:
00 00 00 01 00 00 00 0d 00 01 00 02 00 00 00 01 00 00 00 00
trasfer_flags:
00 00 02 00
**transfer_buffer_length**:
00 00 00 22
other meta:
00 00 00 00 00 00 00 00 00 00 00 00
**setup**:
81 06 00 22 00 00 **22 00**

But usbip-runner did not behave according to the
SETUP request, instead it returned a buffer of length 0x32.
It seems that it accidently added a descriptor twice.

RET_SUBMIT:

usbip_header_basic:
00 00 00 03 00 00 00 0d 00 00 00 02 00 00 00 01 00 00 00 00
status:
00 00 00 00
**actual_length:**
00 00 00 32
other metas:
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00=20
payload of length 0x32:
06 d0 f1 09 01 a1 01 09 03 15 00 26 ff 00 75 08
06 d0 f1 09 01 a1 01 09 03 15 00 26 ff 00 75 08
95 40 81 08 09 04 15 00 26 ff 00 75 08 95 40 91
08 c0

Then this leads to consequent errors in kernel

>=20
> --=20
> Sosth=E8ne Gu=E9don,
> Software engineer
>=20
> Nitrokey GmbH
> https://www.nitrokey.com
>=20
> Email: sosthene@nitrokey.com
> Phone: +49 30 1205 3434
>=20
> Rheinstr. 10 C, 14513 Teltow, Germany
> CEO / Gesch=E4ftsf=FChrer: Jan Suhr
> Register: AG Potsdam, HRB 32882 P
> VAT ID / USt-IdNr.: DE300136599

> [ 1464.886564] usb 5-1: new high-speed USB device number 2 using vhci_hcd
> [ 1465.019883] usb 5-1: SetAddress Request (2) to port 0
> [ 1465.036533] usb 5-1: Using ep0 maxpacket: 8
> [ 1465.153573] usb 5-1: config 1 interface 1 altsetting 0 bulk endpoint 0=
x82 has invalid maxpacket 64
> [ 1465.153591] usb 5-1: config 1 interface 1 altsetting 0 bulk endpoint 0=
x2 has invalid maxpacket 64
> [ 1465.189963] usb 5-1: New USB device found, idVendor=3D20a0, idProduct=
=3D42b2, bcdDevice=3D 0.10
> [ 1465.189979] usb 5-1: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
> [ 1465.189982] usb 5-1: Product: Nitrokey 3
> [ 1465.189986] usb 5-1: Manufacturer: Nitrokey
> [ 1465.231395] usb 5-1: recv xbuf, 0

usbip-host first detected such abnormality:

the returned urb->actualy_length is greater than
urb->transfer_buffer_length, the "recv xbuf, 0" path
is gone through.

https://github.com/torvalds/linux/blob/6015b1aca1a233379625385feb01dd014aca=
60b5/drivers/usb/usbip/usbip_common.c#L789-L791

> [ 1465.231548] vhci_hcd: stop threads
> [ 1465.231552] vhci_hcd: release socket
> [ 1465.231558] vhci_hcd: disconnect device
> [ 1466.209577] vhci_hcd vhci_hcd.0: pdev(0) rhport(0) sockfd(3)
> [ 1466.209586] vhci_hcd vhci_hcd.0: devid(65538) speed(3) speed_str(high-=
speed)
> [ 1466.209632] vhci_hcd vhci_hcd.0: Device attached
> [ 1466.234515] hid-generic 0003:20A0:42B2.0007: hiddev98,hidraw6: USB HID=
 v1.11 Device [Nitrokey Nitrokey 3] on usb-vhci_hcd.0-1/input0
> [ 1480.014598] usb 5-1: recv xbuf, 0
> [ 1480.014620] usercopy: Kernel memory exposure attempt detected from SLU=
B object 'kmalloc-16' (offset 0, size 64)!

Then vhci-hcd is not happy.

I did not reproduce the kernel BUG though. I was using 5.15.47-1-lts
from Arch.

I guess if usbip-runner behaves normally then such error
wont be happen.

But other way around: the abnormal exit of usbip-host
should not lead to vhci_hcd bugs. There may be URB
not freed when usbip-host exits, but
I have not investigated into it yet.

> [ 1480.014631] ------------[ cut here ]------------
> [ 1480.014633] kernel BUG at mm/usercopy.c:101!
> [ 1480.014640] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [ 1480.014644] CPU: 2 PID: 3912 Comm: pcscd Not tainted 6.1.4-arch1-1 #1 =
b56a0be67d6a5f69f99015da4a908cae98ee5acc
> [ 1480.014649] Hardware name: LENOVO 82NW/LNVNB161216, BIOS G9CN23WW 09/0=
1/2021
> [ 1480.014652] RIP: 0010:usercopy_abort+0x79/0x7b
> [ 1480.014665] Code: a5 a5 51 48 0f 45 d6 48 89 c1 49 c7 c3 b0 82 a5 a5 4=
1 52 48 c7 c6 2a de a4 a5 48 c7 c7 b0 2e ae a5 49 0f 45 f3 e8 34 57 ff ff <=
0f> 0b 48 89 f1 49 89 e8 44 89 e2 31 f6 48 c7 c7 fa 82 a5 a5 e8 6e
> [ 1480.014667] vhci_hcd: stop threads
> [ 1480.014669] RSP: 0018:ffffbc854a5bbd28 EFLAGS: 00010246
> [ 1480.014674] RAX: 0000000000000064 RBX: 0000000000000000 RCX: 000000000=
0000000
> [ 1480.014678] RDX: 0000000000000000 RSI: ffff98e85fea1660 RDI: ffff98e85=
fea1660
> [ 1480.014680] RBP: 0000000000000040 R08: 0000000000000000 R09: ffffbc854=
a5bbbc0
> [ 1480.014682] vhci_hcd: release socket
> [ 1480.014682] R10: 0000000000000003 R11: ffffffffa62cb828 R12: ffff98e5c=
0042300
> [ 1480.014683] R13: 0000000000000001 R14: 0000000000000040 R15: ffff98e67=
a690e80
> [ 1480.014686] FS:  00007f7b4a3a66c0(0000) GS:ffff98e85fe80000(0000) knlG=
S:0000000000000000
> [ 1480.014687] vhci_hcd: disconnect device
> [ 1480.014688] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1480.014690] CR2: 00007f7b4a374ff8 CR3: 00000001ba794000 CR4: 000000000=
0750ee0
> [ 1480.014692] PKRU: 55555554
> [ 1480.014694] Call Trace:
> [ 1480.014697]  <TASK>
> [ 1480.014699]  __check_heap_object+0xd9/0x110
> [ 1480.014706]  __check_object_size+0x1ea/0x210
> [ 1480.014711]  copy_urb_data_to_user+0xfc/0x120
> [ 1480.014715]  ? __rseq_handle_notify_resume+0xad/0x4a0
> [ 1480.014720]  processcompl+0xc8/0x140
> [ 1480.014722]  usbdev_ioctl+0x120/0x1280
> [ 1480.014724] usb 5-1: USB disconnect, device number 2
> [ 1480.014726]  ? exit_to_user_mode_prepare+0x16f/0x1d0
> [ 1480.014731]  ? syscall_exit_to_user_mode+0x1b/0x40
> [ 1480.014735]  ? do_syscall_64+0x6b/0x90
> [ 1480.014739]  __x64_sys_ioctl+0x94/0xd0
> [ 1480.014744]  do_syscall_64+0x5f/0x90
> [ 1480.014746]  ? syscall_exit_to_user_mode+0x1b/0x40
> [ 1480.014749]  ? do_syscall_64+0x6b/0x90
> [ 1480.014751]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [ 1480.014756] RIP: 0033:0x7f7b4d79cc0f
> [ 1480.014778] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 0=
0 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <=
89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [ 1480.014780] RSP: 002b:00007f7b4a385500 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
> [ 1480.014783] RAX: ffffffffffffffda RBX: 00007f7b440705a0 RCX: 00007f7b4=
d79cc0f
> [ 1480.014785] RDX: 00007f7b4a385580 RSI: 000000004008550d RDI: 000000000=
000000d
> [ 1480.014786] RBP: 000000000000001a R08: 000000000000000d R09: 000000000=
0000000
> [ 1480.014787] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000001
> [ 1480.014789] R13: 0000000000000003 R14: 0000000000000001 R15: 00007f7b4=
40705a0
> [ 1480.014794]  </TASK>
> [ 1480.014795] Modules linked in: vhci_hcd rfcomm snd_seq_dummy snd_hrtim=
er snd_seq snd_seq_device ccm wireguard curve25519_x86_64 libchacha20poly13=
05 chacha_x86_64 poly1305_x86_64 libcurve25519_generic libchacha ip6_udp_tu=
nnel udp_tunnel cmac algif_hash algif_skcipher af_alg snd_sof_amd_rembrandt=
 bnep intel_rapl_msr snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci snd_sof=
 snd_sof_utils rtw89_8852ae snd_hda_codec_realtek intel_rapl_common snd_soc=
_core rtw89_8852a snd_hda_codec_generic ledtrig_audio snd_compress rtw89_pc=
i snd_hda_codec_hdmi ac97_bus rtw89_core snd_hda_intel snd_pcm_dmaengine sn=
d_intel_dspcfg snd_intel_sdw_acpi hid_multitouch snd_pci_ps amdgpu wmi_bmof=
 edac_mce_amd snd_hda_codec snd_rpl_pci_acp6x mac80211 btusb snd_hda_core s=
nd_acp_pci snd_pci_acp6x snd_hwdep btrtl snd_pci_acp5x gpu_sched btbcm snd_=
pcm snd_rn_pci_acp3x r8169 drm_buddy kvm_amd btintel ideapad_laptop libarc4=
 snd_acp_config realtek drm_ttm_helper ucsi_acpi cfg80211 sp5100_tco typec_=
ucsi ttm btmtk snd_timer
> [ 1480.014861]  mdio_devres cm32181 snd_soc_acpi vfat sparse_keymap kvm i=
rqbypass rapl wdat_wdt pcspkr typec fat bluetooth k10temp platform_profile =
ecdh_generic i2c_piix4 snd snd_pci_acp3x drm_display_helper soundcore libph=
y cec rfkill roles video wmi mousedev industrialio lzo_rle i2c_hid_acpi joy=
dev i2c_hid acpi_cpufreq mac_hid usbip_host usbip_core pkcs8_key_parser dm_=
multipath crypto_user fuse zram bpf_preload ip_tables x_tables ext4 crc32c_=
generic crc16 mbcache jbd2 usbhid dm_crypt cbc encrypted_keys trusted asn1_=
encoder tee dm_mod serio_raw atkbd libps2 crct10dif_pclmul crc32_pclmul crc=
32c_intel polyval_clmulni polyval_generic gf128mul ghash_clmulni_intel viva=
ldi_fmap sha512_ssse3 aesni_intel nvme crypto_simd nvme_core xhci_pci crypt=
d ccp i8042 xhci_pci_renesas nvme_common serio
> [ 1480.014912] ---[ end trace 0000000000000000 ]---
> [ 1480.014914] RIP: 0010:usercopy_abort+0x79/0x7b
> [ 1480.014917] Code: a5 a5 51 48 0f 45 d6 48 89 c1 49 c7 c3 b0 82 a5 a5 4=
1 52 48 c7 c6 2a de a4 a5 48 c7 c7 b0 2e ae a5 49 0f 45 f3 e8 34 57 ff ff <=
0f> 0b 48 89 f1 49 89 e8 44 89 e2 31 f6 48 c7 c7 fa 82 a5 a5 e8 6e
> [ 1480.014919] RSP: 0018:ffffbc854a5bbd28 EFLAGS: 00010246
> [ 1480.014921] RAX: 0000000000000064 RBX: 0000000000000000 RCX: 000000000=
0000000
> [ 1480.014923] RDX: 0000000000000000 RSI: ffff98e85fea1660 RDI: ffff98e85=
fea1660
> [ 1480.014924] RBP: 0000000000000040 R08: 0000000000000000 R09: ffffbc854=
a5bbbc0
> [ 1480.014925] R10: 0000000000000003 R11: ffffffffa62cb828 R12: ffff98e5c=
0042300
> [ 1480.014927] R13: 0000000000000001 R14: 0000000000000040 R15: ffff98e67=
a690e80
> [ 1480.014928] FS:  00007f7b4a3a66c0(0000) GS:ffff98e85fe80000(0000) knlG=
S:0000000000000000
> [ 1480.014930] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1480.014932] CR2: 00007f7b4a374ff8 CR3: 00000001ba794000 CR4: 000000000=
0750ee0
> [ 1480.014934] PKRU: 55555554
> [ 1480.030021] vhci_hcd vhci_hcd.0: pdev(0) rhport(0) sockfd(3)
> [ 1480.030025] vhci_hcd vhci_hcd.0: devid(65538) speed(3) speed_str(high-=
speed)
> [ 1480.030034] vhci_hcd vhci_hcd.0: Device attached
> [ 1480.030396] kauditd_printk_skb: 3 callbacks suppressed

