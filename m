Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618196458F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiLGL0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLGL0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:26:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24011025
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1670412357; bh=iWB0Flg1LIj12Mdqtv46GMMJS/VLgndICaJ5qf0GKk0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=atjsyF5BO9kbRtR6SUckvXF1GJn35ImBXVsdRRs0dIatPjMSQKSNYKEbF6DYavguZ
         +9E7lQs65obWFdCLZMc0YVhlgBNnZZIUPf7BJQMfGgp2emkZ6HBnYYrHMBwYLGgf89
         zxbnWmIP8DZiIFWwjKQAQmQz94JUXAlvdcd3jqPHGlXKtTXN75CKcaeqQ+PLr33hNK
         LbZ6pSDtnKyaLGVdZ32f3ak3V/2R53623ilVvcds5xx3VKcHGqHhaBgow84zS4kkFN
         m/sjOxRfiNAOd9esuzuUdQVqf9XM7cTTnkFEJofSQvJ5HXQjox0czMlRQ126PXDqLt
         mISnvfiPEiLRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5UD-1p99xy2ihj-00FEMl; Wed, 07
 Dec 2022 12:25:57 +0100
Date:   Wed, 7 Dec 2022 12:25:53 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org
Subject: PXA25x: GPIO driver fails probe due to resource conflict with
 pinctrl driver
Message-ID: <Y5B4QeNMNboJ42n4@probook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aQ0C+mz0p8jyb4CT"
Content-Disposition: inline
X-Provags-ID: V03:K1:+aSGHhafDU13v3wYdeFD2QndWowCdMZNHk5e57ooPW2O+uSrwTJ
 yOKNiAJkIgSsSLnJp4RKNKkef3Bi222r4gPBpi/VJx2jeCVbsehbgxp2Nj5LvmwuMoSvQge
 x27Ogy/r1z+gjLfqR710l7Zbbb5sUREFvZ1zTOI57BW8ySo9epU9ujyOvJh7tq6FffNInLS
 A9CI0hAcfWK9NwoU6gSZg==
UI-OutboundReport: notjunk:1;M01:P0:Xa+/ZDnCzcQ=;N1IbOZv6TGPGxQBIsdgWy1CBuIe
 a2DWMq4kLghhl+c/uNGcFOAzAe7nv4wEV60LK49bSHiBUGDNsZeIbsAYzNrY5+PRTXNXjL1hp
 8uN6qiVmgUMquH6w2oPpgPeSMIP+1RLcvwYnm83PRDdcomJgohpSxZRR3aEqMngc1zEI+U2DB
 NbvMh31dlQywvUMXC720h8zpx097Pp++T4DxoDfCMx4b3SWw/BGJgzIEOippR1bkpUmesIFtt
 oKMqMHA+nMMGZRtw7z/El2kz7wwXA2UW8m9DZ5tyR9VpMGp96TWnZXuSGUTepXMqri0Fd712S
 SPTyMunRUYSlPoEQJfz7tra6Exg1nHrw/SOKg3B1P2+jCqk+2ynKXCVNt7ykYZya30HNhzg4U
 OVEuP1v6OvsGbrey2BrX6pYy7uktJzZFX2DVKP0eiz5xMqkU260M/BjWkGJ8/2OI3pW8sE3/E
 shzyC+qp1KFyEUQisweqcPTOLp0OsTjswM+6XDaYLn6lT08NUuEmeLwYRzThNdJy6ijV4yxL+
 BgljRS9FoZ4sS2esia9sW+4i8SBikbRcOnipz2dWWiZ/0iec7DY44DHMmdAiy1J6O1K9awCxu
 wfqhVgmkhpVZi1oh+GfR1qCv/xCKeyvJPWRNT1RSbs3BBNCqdovr/1kdwZwfupNG/Apjb5Nio
 eHMMI0xd6yGZs/Ai978KOeLul7lRHT7XDZoaeCShVfpYtb7NaSdMlgcLAx06HoXYm8MNWyuS/
 AxXWmiVJ+FcnBmWOLTCNgb0zNwScoEyjIzS4GdfBD/FKOVqQ154GgDMfrOLvcoSBMJMFkBJVm
 s4pD0IUwDPj33Fw8LywOLOnXovtqzyiNVYjPnkqe2Aj8lkQceNZDTOhKVhuEAw5/OWP9JScsX
 DBH+29pnZJIDgpr9Ta/JvIr+OIHr+SsKQSspqn8cAHQiNZEa8PnFlFuPgkDOPrcJyFarReIOy
 LM3CYmvfvKQlp+Au4Gg7HoQ6rZM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aQ0C+mz0p8jyb4CT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I am currently trying to bring up Linux 6.1-rcX on a PXA255 board, using a
devicetree. One problem I encountered is that the PXA GPIO driver fails to
probe because it uses the same MMIO register range as the pinctrl driver:

[    0.666169] pxa25x-pinctrl 40e00054.pinctrl: initialized pxa2xx pinctrl driver
[    0.694407] pxa-gpio 40e00000.gpio: can't request region for resource [mem 0x40e00000-0x40e0ffff]
[    0.695050] pxa-gpio: probe of 40e00000.gpio failed with error -16

Before I try to fix this myself: Is GPIO on PXA25x currently expected to
work and when has it last been seen working?

What would be a good way to fix this?

I've considered calling into pinctrl-pxa25x directly from pxa-gpio and
passing in the GPIO driver's register mapping, rather than mapping the
registers again in pinctrl-pxa25x. This seems like it should address the
kernel's requirement that resources shouldn't overlap, but some
additional locking between GPIO driver and pinctrl driver might be
neccessary to keep register accesses consistent/atomic.


Best regards,
Jonathan

--aQ0C+mz0p8jyb4CT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmOQeB8ACgkQCDBEmo7z
X9spEhAArFDxtq11404dxWxRTEZtkVxKwo5KRFcwCo3MJWe2KzfXby928asuBc7v
nxqKbSdNRsK9uy6hcX+uDCf/3i8hc3i8d5rxp8Y8FaLX5A6aFFWu7xL95qWWPctV
DILTwA2uzEEXUinYWprS+YRFlkmaYo9NVkbJ7a9kT8+A70GlwkBYQ/kL3jwlw2uJ
x7PnnTk53wEkwMJ7T7Z47uekJieIb/baSyk4bPUYacGZKwc1IUuvd9/ncc0VEM5W
xaWQc6UGcVXOIu4j6kXt5xg14dyqzHSK8zKBmrZAvEvwQQveNlNoaHNfU1RlcGtx
KjKwaOB1RBK5hlhdlRZzTdwpefM7i6JQJSfWwJRaiIQyfoLsMql/n8ETbA3k0Z5C
LI4pdhkHf8kn7u++wgkGq1H6p1VWDemwwDPUwJ8C5wmJxL9EOYcMpAMyHQS3tuRP
71xfo+bMssVvkzz4Rz4V3nPlB0jopSz7Wqrp5N+BJh65bqwJEkcCmFrqH7Gtx/hr
TXxomj9PpZUKBMQTmAnUxc89Iyd3EKECnnc2wDNB97MNEpFyXIxh9e5Peyb2PZ80
P2upMwRP/saroLsiB27EdZJcV01/1pzj2l1C8VASZVBAnFU2cKJuH9Luw6LC77NW
K7c+CzZNwJqsrHPjcdNtmdFKDwAUVb4MB46ZdLtu0VqtUxJJzVM=
=TWQm
-----END PGP SIGNATURE-----

--aQ0C+mz0p8jyb4CT--
