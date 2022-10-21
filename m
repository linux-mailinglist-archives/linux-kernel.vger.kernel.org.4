Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4994C607891
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJUNek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJUNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:34:37 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60136.outbound.protection.outlook.com [40.107.6.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9810418352
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBIIh4epWBEeL96lk/WKEP/bqb+XITplcRpH8+MtshSEl35ev/HumSTRT+yQS7qeawXXCTJvAxP+PiuQz0jrxiJPYrpCj4th4UGj7hRB8P0GOK/DxBw/OTWRhSYpnsFUIBvhEbATIi/1w00dM4TBR/+QXfHqXwMhKROgoWCjU0SFCY698NjUTLN3Ev+J8SwWfZsRufF9trjhLpnhHhi94ueCfPfs6LeqdWEFOfmN8lktz6vPHlUqiS3WWa5ZxDUuRJvrvN9uHIGmzd83PxCz9b870+WMofmm1qeWxeM3xr05vz4IcTYOV3j0/5UdbFNFXawxcuwvA9J7EfqRvRAOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMrmB3EyS8twvcdeFLA7rgnFz757PksBKM3QiAeOQQE=;
 b=a1/uT1h4Squ1Qtb0jIaiWIM5xOFy5bLCvgK/Ryd3RLI2xrtp0MDvbJoovU4Qfvz4zowMolJ34wMTO9KclUJYVHBlwxXftXDf0zXTwpzFeHP9wuw+H8VIq06tiX3/KRgi6pDW3BcqRGBSj8pcIkMUWjM+s36wiJOnPTCXTMw0zfFpJc+9F1fwfuh0WxSW0Yz1Vsinef6lhY0ZiXGWwq6aBiORs9zH30qvXdFVhb+Pqxp4u9zPq5gG+Vj/gakpIgOhQfveL3Yh6V6nGLBzhaOz/5BF6FTt+B+k/NmdIGqTDpAL3M3CDiU22HQDYZohENpZyRmJEFkrxRhiAWC96cGMNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dronus.com; dmarc=pass action=none header.from=dronus.com;
 dkim=pass header.d=dronus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dronusspa.onmicrosoft.com; s=selector1-dronusspa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMrmB3EyS8twvcdeFLA7rgnFz757PksBKM3QiAeOQQE=;
 b=Mm43uBeqKQ3NkB8K1TvUpqatFkQbDO2lVAn/PqeK6YKgdYUgaa9BlJcKB2wqIOOfp09zAerW6Sd1uNnCMIaBWWIhwf5DnuavaknMxDQUnKiJDy18Jnix2pl9e8oSGxBRT58h39OKS/jaIbTRdfL6tl7hO09eosG1H2aibchJEVg=
Received: from VI1PR09MB3822.eurprd09.prod.outlook.com (2603:10a6:803:131::14)
 by AS4PR09MB6517.eurprd09.prod.outlook.com (2603:10a6:20b:4f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 21 Oct
 2022 13:34:27 +0000
Received: from VI1PR09MB3822.eurprd09.prod.outlook.com
 ([fe80::4571:81ff:f1cd:a302]) by VI1PR09MB3822.eurprd09.prod.outlook.com
 ([fe80::4571:81ff:f1cd:a302%5]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 13:34:26 +0000
From:   Enrico Bandera <enrico.bandera@dronus.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Kernel oops issued
Thread-Topic: Kernel oops issued
Thread-Index: AQHY5U8lfF2ga6iAY0CM/4wqVoRxHA==
Date:   Fri, 21 Oct 2022 13:34:26 +0000
Message-ID: <958955d6415f4782b955612e6854de72VI1PR09MB38226F88153D921E6B4FD9B6E92D9@VI1PR09MB3822.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dronus.com;
x-ms-traffictypediagnostic: VI1PR09MB3822:EE_|AS4PR09MB6517:EE_
x-ms-office365-filtering-correlation-id: 9e394c22-39fa-4914-831f-08dab368f940
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MAsAWMWiKsuCdvByHYY9Tw0BnH4mS4jRB+oARz70e4zRy/xtEun7uGjcFj1ftCpHjv5HJ7gZrjef7ktuNdvOGd0RpYVwQUhcaxaYVyjuEyTFCIW7tk7baRnaDSU6fInHdPAXfL1H9Egdgy7YRPrBF6cj7dGjC/RLP52lCYB0F3LWeBBSjYA3HHoAlGAVwQqReXvlnUQ30Xwh7jzm0ULDgpSL+lAzpLOOhRhJ8gkYl2JivURlpYZIPyRiCQjSBUaTmJBHD07MmW2tvs24jF5cLvwKclbudh0sTHvQd9Lh/vMWSWbeKCAF20xU4oG4AO2sumyiVNRn1o2b2VxdMUNcovJcXcA/6SSLNxwrIxyz3709pNxeHL6kKJaS3C8iL58UKFr3bmHs3Gb5vRupk/jB3q2GLPKVXYPjigQ4kRw/AKDPaCZCv4tr902OgQ9JcYlqQ4ptOwGHVKm4nFV27HCViRqxhnMvl/FT0iIBnj3ApjrtGNxhnYHWUhGvk38YMgrIQ1rgqNCicK6meLOMDSc39qaeq1z9ZSVUqPmQnkjwFexf9SqXOiuNqjtvaDRO19wy4wCB20Ltvjpgt5it1PdsjdFgHgxOxCR7GKfEqYxMuM0poltF5LwHGvwBAOwBMfb3L1tdIWgH7Tt8oPzMwZFWW0wsyrOX4YwZKagOgHxG+JT9PjCYdyaqJ6/qclBXg8DuTbNpqqsXR78OLAJ/y3hSpY78Ltq30T4lxmKkHnPQKbmdrCHAE3crZVhXsSFcOQqmH8SVhEWcGyD9Exjtg0tsAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB3822.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(136003)(39830400003)(396003)(451199015)(76116006)(83380400001)(3480700007)(6916009)(86362001)(186003)(38070700005)(7116003)(316002)(38100700002)(99936003)(6506007)(122000001)(2906002)(44832011)(41300700001)(5660300002)(8936002)(55016003)(26005)(71200400001)(91956017)(478600001)(9686003)(7696005)(8676002)(66556008)(66476007)(66446008)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?qxmTVql8jvhx+BtMotgSsRutu5Dqawxbx+SZpeiKgLMegqWukpTpjSoV?=
 =?Windows-1252?Q?Z4reoKjOnVpkWfdck4376Jqt/ztsUgxDkaLAUk6Y0c6k9/zU7Akbl3CM?=
 =?Windows-1252?Q?1LSU4qHhm51YVM9K2rTMV1GW2KH0EmFAwdxjqOri+f0W9Rkm5Z8deZ5e?=
 =?Windows-1252?Q?+VFZLkQ1/9o7Ck0b1NFuMhfkiYbNKxwhiknRCDkBniJPV7ZA+8vf2nHS?=
 =?Windows-1252?Q?x8xahlVzkpjGrZ2wLh/QLFo0oyHV4wjMrpsWKMLRDBmfmUSpjVqE5kPz?=
 =?Windows-1252?Q?CgM6a0eZuRxxsbpYrrViZLjbol3j/xsMsu0ZR1DF3eqaeYatDoNilBYv?=
 =?Windows-1252?Q?A6dc6WBZUtt74zLL77T8zG2l9MqUzcgJnbPFQ82uGSxwplBN6SS3r1PG?=
 =?Windows-1252?Q?J4jCz0g9olCPeUphKeY5yB0N0peCi/mJZRYwkuq+xkc/SuT4fMpX1FZj?=
 =?Windows-1252?Q?TNtjkJXeCBy23fr4pQzF9ot4iswuGoufk4fOJETfjJpZFOKZr3rUi004?=
 =?Windows-1252?Q?0/wYKwwwYdm62fi3H9jNjMLd35tjcpvCeiB0bwUmGdz0rASa25jx8p0o?=
 =?Windows-1252?Q?GHC2wONFUJyH+54maN1ecyz15WMhCYe/5OTNbHha8W3CgcVpCk+wNsNS?=
 =?Windows-1252?Q?K2oFTXA7HuErYRwrMLir3c7ZuQet9TAzzpuUS10vOLGFLWT5YFOAKMeI?=
 =?Windows-1252?Q?Cj518JrHSXsHgEBIS7n54SdaMxFyYceGkfQuC8IkIbB/EWfuGhXHseXv?=
 =?Windows-1252?Q?czRSMbEyf8B5F+8x+8QjTz8ecbcemIO2o4N+EfBuLoNyhudpG9TZq2do?=
 =?Windows-1252?Q?hPswYJs88W6VALRmMBMsgSmmNrZrktu2pSpNGYz7l5O6SDlV5QPsgmuS?=
 =?Windows-1252?Q?SL22wB3C18mX5z2VWBjxyYYFU60yEHvvqdUVyRHMdNIAVbAACuyYeq2M?=
 =?Windows-1252?Q?KDkndupqz+ltyFTfDmpSt3joYupQVA6O8sZnJ1CjLgIhIIm8Uul4Fy1X?=
 =?Windows-1252?Q?3hr5BGmijF/P9Qdz9932LowI1OI41n5QzzulBmbBbBecvAvIgrmkAzvp?=
 =?Windows-1252?Q?tSS3lT6OsDegU0dnoYi0SPwssdnR7Q+Fc+LJA133MRgHV8oaDlSuXQ78?=
 =?Windows-1252?Q?ReUtpySFcPUM8vmICobgVH8wtTjhOYY9YAPcFZtQkjdYr6p6W0ErlVuv?=
 =?Windows-1252?Q?hvzigcXoRULQ6Zfe1kFEpOuWSoiFz4A3fhyS6l9CGA0ziWTF3EGDHF7S?=
 =?Windows-1252?Q?w0cH+kk4CMcF6k0gyng8hXeWUMzZT78ZOrPpsbk8WbKTBWOTdnds+o0P?=
 =?Windows-1252?Q?Rzhu1HBZdb4Dp7P33gapUN9dzyBUEwKEnSgzU8Dinf6SNr8UVwQE+DLg?=
 =?Windows-1252?Q?d2k5qVDKUiDtecAbtO1Eq47rZV8F06rjSLEMX4b4UPcAlPL+IPPfUKVA?=
 =?Windows-1252?Q?wYpbf34RowTW5lYHCTqRt+SidxmCaP1TXRRobdL5h2hM85PsH0caIz7X?=
 =?Windows-1252?Q?5ItEGhTWNut6+M5F6lU7vtyBf2kofa0l/3NAohGZesaDFWWQsTAbRt4f?=
 =?Windows-1252?Q?/ds0h/korJJim7iKaGejCAef+8ftuQUkrQ42E/ct7iSkKW6dmfbdDtk8?=
 =?Windows-1252?Q?cWOz6n7MhyNPmcJKzcswEmRgEJGORy/lK3azBopXtXEwJH2d1uDE0SU3?=
 =?Windows-1252?Q?rvD0gYdUqZNGFCWEOVzuKtBeqRFvhwN9?=
Content-Type: multipart/mixed;
        boundary="_002_958955d6415f4782b955612e6854de72VI1PR09MB38226F88153D92_"
MIME-Version: 1.0
X-OriginatorOrg: dronus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB3822.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e394c22-39fa-4914-831f-08dab368f940
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 13:34:26.5603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8d9c427e-9c16-48a5-b13d-c3135a27612e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5T2EdFErddNJNeAGXwwdy+KnS1VcdrevLqD7QbcCo4OVheKat116/WAqVaJPlSia8uaYy8zcucJlYZmdKkhpDYTYpuKhhldoCFw7FTnHhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR09MB6517
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_958955d6415f4782b955612e6854de72VI1PR09MB38226F88153D92_
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <BB2D3B1A2BE465418235B7FCD98D91FB@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

Hi,
I'm facing a systematic crash of kernel, whenever 2 instances of gstreamer =
are launched together.
Namely, in our system there is a service that runs a camera manager (that u=
ses gstreamer libraries to handle video streaming).
If another gstreamer pipeline, accessing the same device, is launched the k=
ernel crashes.

Please find attached the ending session of kernel log (dmesg)
I've enabled all debug info possible (I guess)

Thanks in advance
Enrico



Enrico Bandera
Software Engineer
enrico.bandera@dronus.com
dronus.com
t +39 345 295 00 42
Laboratorio T45 Ed. Q
Area Science Park
Basovizza, SS14 km 163,5
34149 Trieste - Italy

Dronus S.p.A. =95 Sede legale: Basovizza, SS14 KM 163,5 34149 Trieste (TS) =
=95 P.IVA 14668071005
Ai sensi del GDPR 2016/679 si precisa che le informazioni contenute in ques=
to messaggio ed eventuali allegati sono riservate ed a uso esclusivo del de=
stinatario. Qualora il messaggio in parola Le fosse pervenuto per errore, L=
a invitiamo ad eliminarlo senza copiarlo e a non inoltrarlo a terzi, dandoc=
ene gentilmente comunicazione. Grazie.
Pursuant to GDPR 2016/679, you are hereby informed that this message contai=
ns confidential information intended only for the use of the addressee. If =
you are not the addressee, and have received this message by mistake, pleas=
e delete it and immediately notify us. You may not copy or disseminate this=
 message to anyone. Thank you.

[https://git.dronus.com/img/logo_firma.jpg]
Enrico Bandera
Software Engineer
enrico.bandera@dronus.com<mailto:enrico.bandera@dronus.com>
dronus.com<https://www.dronus.it/>
t +39 345 295 00 42<tel:00393452950042>
Laboratorio T45 Ed. Q
Area Science Park
Basovizza, SS14 km 163,5
34149 Trieste - Italy


Dronus S.p.A. =95 Sede legale: Basovizza, SS14 KM 163,5 34149 Trieste (TS) =
=95 P.IVA 14668071005

Ai sensi del GDPR 2016/679 si precisa che le informazioni contenute in ques=
to messaggio ed eventuali allegati sono riservate ed a uso esclusivo del de=
stinatario. Qualora il messaggio in parola Le fosse pervenuto per errore, L=
a invitiamo ad eliminarlo senza copiarlo e a non inoltrarlo a terzi, dandoc=
ene gentilmente comunicazione. Grazie.
Pursuant to GDPR 2016/679, you are hereby informed that this message contai=
ns confidential information intended only for the use of the addressee. If =
you are not the addressee, and have received this message by mistake, pleas=
e delete it and immediately notify us. You may not copy or disseminate this=
 message to anyone. Thank you.

--_002_958955d6415f4782b955612e6854de72VI1PR09MB38226F88153D92_
Content-Type: text/plain; name="kernel-Oops-log.txt"
Content-Description: kernel-Oops-log.txt
Content-Disposition: attachment; filename="kernel-Oops-log.txt"; size=5500;
	creation-date="Fri, 21 Oct 2022 13:18:45 GMT";
	modification-date="Fri, 21 Oct 2022 13:33:47 GMT"
Content-ID: <FF209C5072099F41BE46EC53362F5C57@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64

WyAgIDM3LjEzMDM2NF0gYXAxMzAyIDEtMDAzYzogQ2FsbGVkIGFwMTMwMl9zX2N0cmwgbGluZTog
MTM3MSBldmVudC1JRDoweDAwOTgwOTAxLgpbICAgMzcuMTMxNzA4XSBhcDEzMDIgMS0wMDNjOiB3
cml0ZV9yZWdbMHg3MDAyXSA9IDB4QUExMApbICAgMzcuMTMxNzE1XSBhcDEzMDIgMS0wMDNjOiBD
dHJsLT5pZDogVjRMMl9DSURfQ09OVFJBU1QKWyAgIDM3LjEzOTU0Ml0gYXAxMzAyIDEtMDAzYzog
YXAxMzAyX3NldF9tYnVzX2ZtdC4gY29udGV4dD0wClsgICAzNy4xMzk1NDldIGFwMTMwMiAxLTAw
M2M6IFRyeSBNQlVTIEZvcm1hdC4KWyAgIDM3LjEzOTU1NF0gYXAxMzAyIDEtMDAzYzogRW50ZXJl
ZCBhcDEzMDJfdHJ5X21idXNfZm10X2xvY2tlZCBsaW5lIDgwOC4KWyAgIDM3LjE0MDMzN10gYXAx
MzAyIDEtMDAzYzogd3JpdGVfcmVnWzB4MjAwMF0gPSAweDA3ODAKWyAgIDM3LjE0MTQ4OF0gYXAx
MzAyIDEtMDAzYzogd3JpdGVfcmVnWzB4MjAwMl0gPSAweDA0MzgKWyAgIDM3LjE0MjcwMl0gYXAx
MzAyIDEtMDAzYzogd3JpdGVfcmVnWzB4MjAyMF0gPSAweDNDMDAKWyAgIDM3LjE0NjI1MV0gYXAx
MzAyIDEtMDAzYzogYXAxMzAyX3NldF9tYnVzX2ZtdC4gY29udGV4dD0wClsgICAzNy4xNDYyNThd
IGFwMTMwMiAxLTAwM2M6IFRyeSBNQlVTIEZvcm1hdC4KWyAgIDM3LjE0NjI2Ml0gYXAxMzAyIDEt
MDAzYzogRW50ZXJlZCBhcDEzMDJfdHJ5X21idXNfZm10X2xvY2tlZCBsaW5lIDgwOC4KWyAgIDM3
LjE0NzA1Nl0gYXAxMzAyIDEtMDAzYzogd3JpdGVfcmVnWzB4MjAwMF0gPSAweDA3ODAKWyAgIDM3
LjE0ODIxN10gYXAxMzAyIDEtMDAzYzogd3JpdGVfcmVnWzB4MjAwMl0gPSAweDA0MzgKWyAgIDM3
LjE0OTM3OV0gYXAxMzAyIDEtMDAzYzogd3JpdGVfcmVnWzB4MjAyMF0gPSAweDNDMDAKWyAgIDM3
LjE1OTE0MF0gZ2V0IDQgYnVmZmVycywgZWFjaCBob2xkaW5nIDk4NDAgYnl0ZXMuClsgICAzNy4x
NjY2NzNdIGFwMTMwMiAxLTAwM2M6IHdyaXRlX3JlZ1sweDIwMzBdID0gMHgwMDFDClsgICAzOC42
ODk4MTZdIFZTWU5DIDE2NSBtaXNzIQpbICAgMzguNzE0NzI5XSBMb3N0IGZyYW1lIHN5bmMhClsg
IDI0MC4wNjEyMThdIFZTWU5DIDIxMzY5IG1pc3MhClsgIDI0MC4wODYxMjldIExvc3QgZnJhbWUg
c3luYyEKWyAxMDMxLjY3MjQwMF0gdmlkZW9kZXY6IHY0bDJfb3BlbjogdmlkZW8wOiBvcGVuICgw
KQpbIDEwMzEuNjcyNDEwXSB2aWRlbzA6IFZJRElPQ19RVUVSWUNBUDogZHJpdmVyPW14NnMtY3Np
LCBjYXJkPWkuTVg2U19DU0ksIGJ1cz1wbGF0Zm9ybTozMmUyMDAwMC5jc2kxX2JyaWRnZSwgdmVy
c2lvbj0weDAwMDUwNDRhLCBjYXBhYmlsaXRpZXM9MHg4NDIwMDAwMSwgZGV2aWNlX2NhcHM9MHgw
NDIwMDAwMQpbIDEwMzEuNjcyNDM0XSB2aWRlb2RldjogdjRsMl9yZWxlYXNlOiB2aWRlbzA6IHJl
bGVhc2UKWyAxMDMxLjc4MTAwMF0gdmlkZW9kZXY6IHY0bDJfb3BlbjogdmlkZW8wOiBvcGVuICgw
KQpbIDEwMzEuNzgxMDExXSB2aWRlbzA6IFZJRElPQ19RVUVSWUNBUDogZHJpdmVyPW14NnMtY3Np
LCBjYXJkPWkuTVg2U19DU0ksIGJ1cz1wbGF0Zm9ybTozMmUyMDAwMC5jc2kxX2JyaWRnZSwgdmVy
c2lvbj0weDAwMDUwNDRhLCBjYXBhYmlsaXRpZXM9MHg4NDIwMDAwMSwgZGV2aWNlX2NhcHM9MHgw
NDIwMDAwMQpbIDEwMzEuNzgxMDQ2XSB2aWRlb2RldjogdjRsMl9yZWxlYXNlOiB2aWRlbzA6IHJl
bGVhc2UKWyAxMDMxLjgxMDMzMV0gdmlkZW9kZXY6IHY0bDJfb3BlbjogdmlkZW8wOiBvcGVuICgw
KQpbIDEwMzEuODEwMzQ0XSB2aWRlbzA6IFZJRElPQ19RVUVSWUNBUDogZHJpdmVyPW14NnMtY3Np
LCBjYXJkPWkuTVg2U19DU0ksIGJ1cz1wbGF0Zm9ybTozMmUyMDAwMC5jc2kxX2JyaWRnZSwgdmVy
c2lvbj0weDAwMDUwNDRhLCBjYXBhYmlsaXRpZXM9MHg4NDIwMDAwMSwgZGV2aWNlX2NhcHM9MHgw
NDIwMDAwMQpbIDEwMzEuODEwMzc3XSB2aWRlbzA6IFZJRElPQ19FTlVNSU5QVVQ6IGluZGV4PTAs
IG5hbWU9Q2FtZXJhLCB0eXBlPTIsIGF1ZGlvc2V0PTB4MCwgdHVuZXI9MCwgc3RkPTB4MDAwMDAw
MDAsIHN0YXR1cz0weDAsIGNhcGFiaWxpdGllcz0weDAKWyAxMDMxLjgxMDQzN10gdmlkZW8wOiBW
SURJT0NfRU5VTUlOUFVUOiBlcnJvciAtMjI6IGluZGV4PTEsIG5hbWU9LCB0eXBlPTAsIGF1ZGlv
c2V0PTB4MCwgdHVuZXI9MCwgc3RkPTB4MDAwMDAwMDAsIHN0YXR1cz0weDAsIGNhcGFiaWxpdGll
cz0weDQKWyAxMDMxLjgxMDQ0Nl0gdmlkZW8wOiBWSURJT0NfRU5VTVNURDogZXJyb3IgLTYxOiBp
bmRleD0wLCBpZD0weDAsIG5hbWU9LCBmcHM9MC8wLCBmcmFtZWxpbmVzPTAKWyAxMDMxLjgxMDQ2
Ml0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBhZGRy
ZXNzIGZmZmY4MDAwMTBjM2M4ODAKWyAxMDMxLjgxMDQ2M10gTWVtIGFib3J0IGluZm86ClsgMTAz
MS44MTA0NjVdICAgRVNSID0gMHg5NjAwMDA0NwpbIDEwMzEuODEwNDY3XSAgIEVDID0gMHgyNTog
REFCVCAoY3VycmVudCBFTCksIElMID0gMzIgYml0cwpbIDEwMzEuODEwNDY4XSAgIFNFVCA9IDAs
IEZuViA9IDAKWyAxMDMxLjgxMDQ3MF0gICBFQSA9IDAsIFMxUFRXID0gMApbIDEwMzEuODEwNDcx
XSBEYXRhIGFib3J0IGluZm86ClsgMTAzMS44MTA0NzJdICAgSVNWID0gMCwgSVNTID0gMHgwMDAw
MDA0NwpbIDEwMzEuODEwNDc0XSAgIENNID0gMCwgV25SID0gMQpbIDEwMzEuODEwNDc3XSBzd2Fw
cGVyIHBndGFibGU6IDRrIHBhZ2VzLCA0OC1iaXQgVkFzLCBwZ2RwPTAwMDAwMDAwNDBmYzAwMDAK
WyAxMDMxLjgxMDQ3OF0gW2ZmZmY4MDAwMTBjM2M4ODBdIHBnZD0wMDAwMDAwMGJmZmZmMDAzLCBw
dWQ9MDAwMDAwMDBiZmZmZTAwMywgcG1kPTAwMDAwMDAwYmZmZmEwMDMsIHB0ZT0wMDAwMDAwMDAw
MDAwMDAwClsgMTAzMS44MTA0ODVdIEludGVybmFsIGVycm9yOiBPb3BzOiA5NjAwMDA0NyBbIzFd
IFBSRUVNUFQgU01QClsgMTAzMS44MTYwNjRdIE1vZHVsZXMgbGlua2VkIGluOiBoeDI4MGVuYyBi
cmNtZm1hYyBjZmc4MDIxMSBicmNtdXRpbCBsZXB0b24oTykgY2lfaGRyY19pbXggY2lfaGRyYyBl
aGNpX2hjZCB1bHBpIHVkY19jb3JlIHJvbGVzIHVzYmNvcmUgdXNibWlzY19pbXggcGh5X2dlbmVy
aWMgYXAxMzAyX25ldyhPKSBzcGlfaW14IGlteF9zZG1hIGhhbnRyb2RlY184NDVzIGdhbGNvcmUo
TykgW2xhc3QgdW5sb2FkZWQ6IGh4MjgwZW5jXQpbIDEwMzEuODM3Mzc2XSBDUFU6IDIgUElEOiA2
OTkgQ29tbTogZ3N0LWxhdW5jaC0xLjAgVGFpbnRlZDogRyAgICAgICAgICAgTyAgICAgIDUuNC43
NC1pbXg4bW0rZzk4Y2E1NjlmYWZjYiAjMQpbIDEwMzEuODQ3MTExXSBIYXJkd2FyZSBuYW1lOiBW
YXJpc2NpdGUgREFSVC1NWDhNLU1JTkkgKERUKQpbIDEwMzEuODUyNDIxXSBwc3RhdGU6IDYwMDAw
MDA1IChuWkN2IGRhaWYgLVBBTiAtVUFPKQpbIDEwMzEuODU3MjE1XSBwYyA6IG9zcV9sb2NrKzB4
ODAvMHgxYzAKWyAxMDMxLjg2MDc5MF0gbHIgOiBfX211dGV4X2xvY2suaXNyYS4wKzB4N2MvMHg1
YjgKWyAxMDMxLjg2NTMxNl0gc3AgOiBmZmZmODAwMDFiMmEzOTMwClsgMTAzMS44Njg2MjhdIHgy
OTogZmZmZjgwMDAxYjJhMzkzMCB4Mjg6IGZmZmYwMDAwN2QxMTYyMDAgClsgMTAzMS44NzM5Mzdd
IHgyNzogMDAwMDAwMDAwMDAwMDAxZiB4MjY6IDAwMDAwMDAwMDAwMDAwMDAgClsgMTAzMS44Nzky
NDZdIHgyNTogZmZmZjgwMDAxYjJhM2NkOCB4MjQ6IGZmZmYwMDAwN2NhZDE0MDggClsgMTAzMS44
ODQ1NTRdIHgyMzogMDAwMDAwMDA4MDAwMDAwMCB4MjI6IDAwMDAwMDAwMDAwMDAwMDIgClsgMTAz
MS44ODk4NjNdIHgyMTogZmZmZjAwMDA3NGY5MGQ4MCB4MjA6IGZmZmYwMDAwN2QxMTYyMGMgClsg
MTAzMS44OTUxNzFdIHgxOTogZmZmZjgwMDAxYjJhM2E4MCB4MTg6IDAwMDAwMDAwMDAwMDAwMDAg
ClsgMTAzMS45MDA0ODBdIHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMDAwMDAwMDAwMDAw
MDAgClsgMTAzMS45MDU3ODldIHgxNTogMDAwMDAwMDAwMDAwMDAwMCB4MTQ6IDAwMDAwMDAwMDAw
MDAwMDAgClsgMTAzMS45MTEwOThdIHgxMzogMDAwMDAwMDAwMDAwMDAwMCB4MTI6IDAwMDAwMDAw
MDAwMDAwMDAgClsgMTAzMS45MTY0MDddIHgxMTogMDAwMDAwMDAwMDAwMDAwMCB4MTA6IDAwMDAw
MDAwMDAwMDAwMDAgClsgMTAzMS45MjE3MTVdIHg5IDogMDAwMDAwMDAwMDAwMDAwMCB4OCA6IGZm
ZmY4MDAwMWIyYTNiNjggClsgMTAzMS45MjcwMjVdIHg3IDogZmZmZjgwMDAxMGMzMTAxOCB4NiA6
IGZmZmYwMDAwNzRmOTBkODAgClsgMTAzMS45MzIzMzNdIHg1IDogZmZmZjAwMDA3ZDExNjIwYyB4
NCA6IGZmZmY4MDAwMTBjM2M4ODAgClsgMTAzMS45Mzc2NDJdIHgzIDogZmZmZjAwMDA3ZmJhMjg4
MCB4MiA6IDAwMDAwMDAwZmZmZWZmZmYgClsgMTAzMS45NDI5NTJdIHgxIDogZmZmZjgwMDAxMGMz
Yzg4MCB4MCA6IDAwMDAwMDAwMDAwMDAwMDAgClsgMTAzMS45NDgyNjFdIENhbGwgdHJhY2U6Clsg
MTAzMS45NTA3MDddICBvc3FfbG9jaysweDgwLzB4MWMwClsgMTAzMS45NTM5MzJdICBfX211dGV4
X2xvY2suaXNyYS4wKzB4N2MvMHg1YjgKWyAxMDMxLjk1ODExMl0gIF9fbXV0ZXhfbG9ja19zbG93
cGF0aCsweDEwLzB4MTgKWyAxMDMxLjk2MjM3OF0gIG11dGV4X2xvY2srMHgzNC8weDUwClsgMTAz
MS45NjU2OTNdICB2NGwyX3F1ZXJ5X2V4dF9jdHJsKzB4MzAvMHgyNTgKWyAxMDMxLjk2OTg3Ml0g
IHY0bDJfcXVlcnljdHJsKzB4NGMvMHhlOApbIDEwMzEuOTczNTMyXSAgdjRsX3F1ZXJ5Y3RybCsw
eDgwLzB4OTgKWyAxMDMxLjk3NzEwNF0gIF9fdmlkZW9fZG9faW9jdGwrMHgxN2MvMHgzZTAKWyAx
MDMxLjk4MTExMl0gIHZpZGVvX3VzZXJjb3B5KzB4MTg0LzB4NWMwClsgMTAzMS45ODQ5NDZdICB2
aWRlb19pb2N0bDIrMHgxNC8weDIwClsgMTAzMS45ODg0MzNdICB2NGwyX2lvY3RsKzB4M2MvMHg1
OApbIDEwMzEuOTkxNzQ2XSAgZG9fdmZzX2lvY3RsKzB4OTY0LzB4YjQ4ClsgMTAzMS45OTU0MDZd
ICBrc3lzX2lvY3RsKzB4NDQvMHg5MApbIDEwMzEuOTk4NzE3XSAgX19hcm02NF9zeXNfaW9jdGwr
MHgxYy8weGI4ClsgMTAzMi4wMDI2MzldICBlbDBfc3ZjX2NvbW1vbi5jb25zdHByb3AuMCsweDY4
LzB4MTYwClsgMTAzMi4wMDc0MjddICBlbDBfc3ZjX2hhbmRsZXIrMHgyMC8weDgwClsgMTAzMi4w
MTExNzNdICBlbDBfc3ZjKzB4OC8weDIwNApbIDEwMzIuMDE0MjI4XSBDb2RlOiBmODYyZDgwMCA4
YjAwMDAyNCBmOTAwMDQ2NCBkNTAzM2FiZiAoZjgyMDY4MjMpIApbIDEwMzIuMDIwMzIwXSAtLS1b
IGVuZCB0cmFjZSBhMDAxY2QwNzgzYzJhZWU5IF0tLS0KWyAxMDMyLjAyNTAyOV0gbm90ZTogZ3N0
LWxhdW5jaC0xLjBbNjk5XSBleGl0ZWQgd2l0aCBwcmVlbXB0X2NvdW50IDEKWyAxMDMyLjAzMTYw
N10gVlNZTkMgd2FybmluZyEKWyAxMDMyLjA0MTEwMF0gVlNZTkMgMTA0NzYyIG1pc3MhClsgMTAz
Mi4wNDU2OTFdIExvc3QgZnJhbWUgc3luYyEKCg==

--_002_958955d6415f4782b955612e6854de72VI1PR09MB38226F88153D92_--
