Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C8F71F484
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjFAVSb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 17:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjFAVS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:18:29 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2098.outbound.protection.outlook.com [40.107.222.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCB9184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:18:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2fN2tvRkjYL0wDmQTkNy0v2/zuGCQOtn27OoNqm9nThpBMV2nVmd6fjlKEYH1gLuPsYwyMQzKU5Uho/U1DKxJJbC6/2GKRRNfXd7JJrPdT67YKvmm21eymhovQj8QhidlXkj62eX2ZZIp7mcuxNuNxqXPkWhx6BpDfFUj6J9UdRdx/DZmH6/igQtVNpnbzvNd0EnZ6gbA+K3aLHFzf2HcKd85FCppz0ycKXuzXCbsPlgwGe0aL+6PclrpfCyy3TxThYHDB6btw5aqUksiPpTSeow+iA8xED+zmKJgoJPw2oP3F44fKwiMHYSsHlMvw9RCCdPYgdTaIWufx1Xwgkfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcVIo9ipl2cd7dKJ9T8pAhWAQiRJiKKoXRStQShzCpg=;
 b=eZYsezy+9AF7ZUG6ypJJF/EPd/tdSiYQfK+rAzKhC0A1kwuwnXy9cTv1tE4pWVnJHtUpMWpxyvApAEJtO5fW6d+FunhzE2jPDUyAbNB5CRd30LqQZmvm3UWiaUqLwxFVwxENLtsVg2NUxSKy6MTXevtvFtrv2/rWIYIacpaNplPxGdR+ai2jtQY3ozClH4/0LGsnWM5IFh0Xejo+vuljmQBWdUZ2LLic+UVfurxYvLz1vFviEWaRIR3hekrGAtQMVRNxSTc6y1dz6mpzWUi8ylNLdUkGrRI0YLUGkaQGIBk9BI/CzAbyPMsPg8zog9+2hERLCDNmV2mv0euANfELEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bizprospectinsights.com; dmarc=pass action=none
 header.from=bizprospectinsights.com; dkim=pass
 header.d=bizprospectinsights.com; arc=none
Received: from MA0PR01MB7626.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:28::12)
 by MAZPR01MB7874.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:25::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 1 Jun
 2023 21:18:25 +0000
Received: from MA0PR01MB7626.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a922:93a4:289c:a3d6]) by MA0PR01MB7626.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a922:93a4:289c:a3d6%4]) with mapi id 15.20.6433.015; Thu, 1 Jun 2023
 21:18:25 +0000
From:   Lalaine Loffer <lalaine.loffer@bizprospectinsights.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Techno graphic Audience Contacts
Thread-Topic: Techno graphic Audience Contacts
Thread-Index: AdUsJ8uUlO5zo0N9Ty6OEOcWS7AZAA==
Date:   Thu, 1 Jun 2023 21:18:25 +0000
Message-ID: <MA0PR01MB76268F2B78259FE416A49AB69549A@MA0PR01MB7626.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bizprospectinsights.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB7626:EE_|MAZPR01MB7874:EE_
x-ms-office365-filtering-correlation-id: ecd1c327-9d47-4870-f137-08db62e5bc64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XAF9s5UYIoLuoap6eHO3KZANvvSDKMrzmEBRyvEk+uYPw4L3WaEMMpy69MOs2cwhhZv9QzQww6dAd0AUNYfryqxJ/jspG67ilczsyPEZk/5lvQIC7xyaHJf5wM0/7JVJZjdhVqu3fe9QDf6L+ROq4LFzzG02/E32CNAirzi9u3iD45st/NzqmTpsTajH8hSb8jh+HMUWN0ApNr3yLuvyoxdIZ46QOqpJ8KYpCDg15Eujn8uQCKY4eh5n1lkUQhISwy8Yf4e45Oodoy6MSTnKUz9366QBJhe4z9qX6Xpbp9JjZeR9DrgYbVik2Bjm5zDaWk1P6Jxkvhu80MgfWExVCCODmJa/7s9OeyLXA5iGzjGQBsb0Zq6GpFKJpFpxaT21YamMUEpH0qeNAWu+haZyk4zsDO8xNRjPfJCv8+gGqIHIvWNB5eJPfuFVsH69a438WdxxTRJn+Z9FdoEhwrI3VxaLnosmmIpBU8BK5wHM+L2CqfF3TwMStGK3lUIKZDNt2fMFoo96KLHAnWgsmtHuHyK5c3QmkJ7Oyu4LomdIunEhf4UplnbjoaaZKfuv2eA+VxZeluT9vhAiAAy9duCPlhzvdG17xVO09H4hs9Y4UMnm8funGXdLmm/K1IcA2efJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB7626.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39850400004)(346002)(396003)(451199021)(38070700005)(83380400001)(2906002)(186003)(33656002)(86362001)(38100700002)(122000001)(55016003)(8676002)(8936002)(64756008)(66946007)(6916009)(66476007)(66446008)(5660300002)(66556008)(478600001)(71200400001)(41300700001)(316002)(44832011)(7696005)(6506007)(9686003)(76116006)(66899021)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qjgHwU6iC4RYyofX3EL6WLhmrSevBAI0Dxzy2H9oZeS3+0nLgSrg158Xc6?=
 =?iso-8859-1?Q?oUOtLgqi7+AitCrun63NbFjc+9B9XkxFDBbxY82+OXLWFbwjD/Oe3iqS1Q?=
 =?iso-8859-1?Q?ZplooczCm6TxMOR4llaKLzy7wan/FwAi22+99q7NanPGuJdC7macJyfhf2?=
 =?iso-8859-1?Q?SwMOrex1tZ1yy/5XZI7ESU4xuC5zT135KuH9kEVBpCCoyafqAlvJVyldd4?=
 =?iso-8859-1?Q?aEPskfYu0wfJDzenxZkmSd3h7EC7bhzyfWyZTYSfkw5rL69Jx7pfRBZWaa?=
 =?iso-8859-1?Q?yZ0vsAgDh1G+xhXPcEho0FkUv6YtsIlBOUzaXXda0dq7+hlzpkyDRA9Xq2?=
 =?iso-8859-1?Q?xUWPANhfXM27OYTO2AnsA79Afs/xc35z1/Loasf8LBiUIV8kN/vehTCQnG?=
 =?iso-8859-1?Q?LOORfkakFOGP1jIMYMBYChZSAJcVTjTOL+Uvk8xOaEuvy43jCSzd9VHgxr?=
 =?iso-8859-1?Q?xCHXcsTum2f6+lR7/NqcI6h1/MH4q+iETDWkmg6S25bbhnsuYZuQkSmS0S?=
 =?iso-8859-1?Q?qY7xTDlyvXxkO4XZiidi04Wgf1GJKr/y/TkUdHrQLDG0veYYddeCWDC9uA?=
 =?iso-8859-1?Q?/ac+4oa8/5Ph1bfWRypc/DScMKlYM9jmQvuWtYjovA997XlxmeQdIsApz7?=
 =?iso-8859-1?Q?rO8MPOwF9j5MqtPZPlthvFHpWGeCvqfa3D5yU6DFEBI1vy8xB56WvdWX6V?=
 =?iso-8859-1?Q?Utt0od9houvt6HhLoC+8BNJTgm+6rQFQtFem2bIRpihSAPPnRJ1tPmoJh9?=
 =?iso-8859-1?Q?3LdYDJIsX3UFfIvOp4LvoxMWcnIg/boqEuDYME3iPGuIe6KNyq6MTh+H+3?=
 =?iso-8859-1?Q?uUc6Lkxf3oiDQyW35SeuWEY2PnoFbnCAhn+PGJnKYyRIhPl/AcSPYAul9q?=
 =?iso-8859-1?Q?/9V8IyOVfJxbSC0ULlp+8Z+ZVhkaNrcAVZj/jWXlflughILVSY/7hmRKiK?=
 =?iso-8859-1?Q?ZSTRPTOYnqLBNGe8HJz/QusEIbdRfKux6zf6w9PgDEVCsa3zIsujWuZY7D?=
 =?iso-8859-1?Q?z7vHUlq2bztMLow6tMwU97uz9q9P6iluwlLMjeoqAomOk3c2ngcs/RGiv4?=
 =?iso-8859-1?Q?llAA+zGmSecO++0v0pEMrspF46bM/D8c2PLErILS9ud8X9Rc9udWWjBqyk?=
 =?iso-8859-1?Q?EY4dSNaQrV42118waC6LDpCGV+o2pKhbeM6rZjCzESMN3x9lQcjMIEpKgf?=
 =?iso-8859-1?Q?lolVrRm5O+hwC6GFDeoJUycf0GZ6eOE0Pd23NQT1h+sQh7jQM3jK+Y/0vE?=
 =?iso-8859-1?Q?9kUASjPwEQcreRSlaQX4tTOBE/KWBk5zmC4X1Cgf7efIrZLaP6YiabORVJ?=
 =?iso-8859-1?Q?iy7vdglBsNHFAAlVObKojp9KslOc4pp0WXxiyG9vNHxSr22wgrq10djzRA?=
 =?iso-8859-1?Q?kndV3oUAJ6LIQuJHVAfEu73E9YbFczx81HmCKrhnPudUS70A886CAdcebI?=
 =?iso-8859-1?Q?kVZ3N3QzuJfavf3mTi0rbANhm9XWpUuCF4EZmkhIl3Khr2ARUdvw0TYzqK?=
 =?iso-8859-1?Q?x7T91Zxl31elOHtFeboB18tN2MX+i35qeT+mcyetHfwOAjanHtlRlu5Lj1?=
 =?iso-8859-1?Q?a8fG3L/SXT/1mT3IftS5yvtFZhUWh22o9wfDzoxQ2RsreSypWltevHm8l7?=
 =?iso-8859-1?Q?FY2GfIrJ5JpfGToEB+UaybUNodwOtcPBdWjTA1wsfaForAWi/BLa+v6/LX?=
 =?iso-8859-1?Q?H+ONUcThDw35VUwaPDLVqLpqfdsYOjl90ot1vrucs2JG6hbb97wixinLwZ?=
 =?iso-8859-1?Q?EJwK8ECWXfZpNJ/otc1jO6o9M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: bizprospectinsights.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB7626.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd1c327-9d47-4870-f137-08db62e5bc64
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 21:18:25.0625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 35678ef3-00a6-4fd8-b0e9-f182b69f214d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rtcd3kx9ULisfe+iPTx1RRXO1fpZV3lzDcDKshRAlvNKdPt40G1ZjDVdxeaPZf5fVVufGOQSfAkT7G16kYv7US3ZIqY7OKkMhTGNsE6QHlPyYxXc+KbFhJpewh4AETv3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7874
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Are you interested in acquiring the contact information of Install Tech Users and IT decision Makers?

Titles: CEOs, CTOs, CIOs, VPs, IT Directors, IT Managers and many more.....

Air Watch, Cisco, Web root, Symantec, IBM, SAP,MS Users, Oracle, Sage, Accounting Software's, MS Dynamic, MS Exchange Server, Siebel, Sales force, Goldmine and any ERP, CRM, Storage, Cloud, Security Users and other Technology users list.

We do have verified contacts for various industry verticals like Technology, Networking, Telecommunication, Healthcare, Finance, Manufacturing, Education, Chemical, Construction, Human Resources, Automotive, Printing & Publishing, Marketing and Advertising, Hospitality, Real Estate and many more...

If you could send me your target audience, I would be glad to send you the exact information of your requirement ASAP. If there is someone else in your organization that I need to speak with in this regard. Please let me know.

Appreciate your time and look forward to hear from you.

Kind Regards,
Lalaine Loffer
