Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C999C6C9B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjC0Foi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjC0Fof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:44:35 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F594EE4;
        Sun, 26 Mar 2023 22:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXQqKcp30ss47eQlxh4mssbQQZAIp7lKXSy9qUfimGKXoVyiapgd0mXRk0/19MaXohqDCPK2oBKgL3m+8BnAyf09sZPTlW76D1pi7FlxzlbBexPmjYXR3lNpIFn1NiouDpyuNQlIthk56oiM7m6ZxBkG+fnXAi1+FkhCgmdLSs9FqTd00jBWCbur3TCwM3H65u0TQwYSvxX1TOEbCQiogWY9s78LNsCLmdrMmwZLY3CiqVJaN4ggrB8NFKFyPxNeK805lb7AydEWjThgywQ595jF2N+Gwcc0ErqcsUl4HTkbTucxa7WDguijtS98WWo5tlHtmXCNxfKR68E9WWHjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP+XGQV9eirwMRJI6VCOs8Jy7nyibqxRsOwAK/BbMHI=;
 b=RkKyFJ26hDcO7aHmKr509FnQ0syzwmmF/hMf6Hkhc33z5VGAoqM8J6E/XM5IYVAFnvFIZWO/8mzIDE6x28VCtsY9UKc5a4O6B75Aexr0h4Kkit9wf0BmeMdGkHq9fivNXJU2P/3WOXbCXST0C52tHOoft9yLJWniPPjQbHBweh2bQtVQKQvXp5KKOS/mnLbFMu+xDRszCuDqR8wxDuoaXHGtoyxgDAr8dOa98yiQpuf8OY0KbFua79oGn1Z4o9P3JifYFmGl4D+9BhbzWdYq7ej/ijBKLRWTud4FcBWdyBw/WVt9zkzPrQZEWZpRYA+w7DGDgRhPZCOqoL1ARYaaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LP+XGQV9eirwMRJI6VCOs8Jy7nyibqxRsOwAK/BbMHI=;
 b=Qm+w/Mdwg9NbL5BHkQMeant99CfOki4mJhdSTsEWaZUqn6jAMAigB2Q0bIbpgSUeuyg90Q4+rVG44031cQOVRzOA064w8xce5uBNzG7BOGw8A/ye3qQvYidbq8Woj0vrQu+LJL1ZNy2qTVj2CjNq/kPSMrd2tGYCkZ8x0Tgu4kVJPqas65pBSLU8H2tVB/AyueBVrmPjCNBIZm2ZgIqaH6NEOGz2YNunXprUpzH5NZNH1e8jhEQObWk+lx/a6cXm0Ki11qXfbLp5FY2E/wsKc4LkrJsuPepsmTQjJDM7x7sRuIXlZ4vTU9U2V66llC8MrFcidIEc3aosUPr2pi0/CA==
Received: from AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::22)
 by DU0PR10MB6387.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.40; Mon, 27 Mar
 2023 05:44:30 +0000
Received: from AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a5de:aa91:6d51:426e]) by AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a5de:aa91:6d51:426e%2]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 05:44:30 +0000
From:   "Bouska, Zdenek" <zdenek.bouska@siemens.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Thread-Topic: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Thread-Index: AQHZXitnsElEVi8SeUyEotrWHWfO2q8KKDUAgAP4mD0=
Date:   Mon, 27 Mar 2023 05:44:30 +0000
Message-ID: <AS1PR10MB5675F191C6EC49ED8BEA9BECEB8B9@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
References: <AS1PR10MB56750EFD7BEA779D033A68CBEB849@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
 <ZB3XaNtVqGtYHHBw@arm.com>
In-Reply-To: <ZB3XaNtVqGtYHHBw@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-03-27T05:44:29.837Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5675:EE_|DU0PR10MB6387:EE_
x-ms-office365-filtering-correlation-id: 14986360-bcde-424f-ae48-08db2e8655d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vLmB7xzBjdmdnzP0Xg8UTXDID815FDUTP24Zk+UW/rheenegSI7OfTiSZEQKNPWubF8Fb+bwGVld+AoZ1V8BS4IRmko224X4M25RDViHLOqCPTsS6voIVrX0zka5LWUrfDvv4XpBjNsvJNiXW7679khWxAyLRXhn9mhOgTd7WFf+IGlkkAr+oFz3qJ94tqe7c4zSADv7wsi/BYZj556139zCvNDxlzBt80o1no/j6g7M3cStetTverz7Bi0HyQ+JKZqE2nx9Fo6X5W8nss3DhILJhM6JefFEYfnZegw2fHY42jjn++V0ANYri8edu8hqhOL82B7FBVRhguFcjiS9G2vDxP3V38OUQ4ZoIdqg2rd+C46gE8aZM5SstKqdVPULsvuOkaSHUluZ2owXjFVte/HMXp3HjOxHqlbbWpwWfS6O/3In0TGKpEmgKyYLMcEt37NoVZ7aqTNdBFCSTDoNGErKwQ9z/bHFgshhyb2mIzSSToh3bbG4KbEDMHtHlWAOyxKwSSYu1Cu4bzfsNA01aTGFQyM8ZCg6JJ2F9hcOX/vEBFJ3CpjdJBWubW90rajIgUdSOQguoXL4M9Lha/HpU4tyhWsSUeh5BaVnaJu3mbna3NE9WZiSWzrXZUptkB0n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(2906002)(8936002)(122000001)(4744005)(38070700005)(83380400001)(82960400001)(71200400001)(7696005)(66556008)(478600001)(55016003)(76116006)(41300700001)(33656002)(66946007)(5660300002)(8676002)(6916009)(38100700002)(4326008)(91956017)(64756008)(66446008)(186003)(52536014)(86362001)(9686003)(66476007)(54906003)(6506007)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?DSiMHdab2kM5wfk9tLSDEWzb4zLuv4CmjFEaxWJEGy/Nwsd51luVxU0kC6?=
 =?iso-8859-2?Q?LHKEMyWnVcs6KcaEfZBJoyc59q7tZeMIrxCCHvoI6qnXkUbatFYeVUyCfw?=
 =?iso-8859-2?Q?Am1jy5UIy6N6okFX1+SOzXaCAur41VK8Zs5p8e3Fzqpjka2yI8gwe3ks5y?=
 =?iso-8859-2?Q?TCrL3855zYCAnLHwJ8sPbWovyLPFNhXMPooBX/rkvw1SUGrIvMT7bNOPpN?=
 =?iso-8859-2?Q?KNkf67wUOXq5q5H/3ijeNKcCpztpc3veD7151csnOU/xDBQYLNpOH/X5ua?=
 =?iso-8859-2?Q?UVbbQ05E9TNNLjXFeU4AMRqoTBtJ7sBV1DQ9ocq/74UZCAQzxy9NY97gZj?=
 =?iso-8859-2?Q?JCaktbbCKfzgEp/v7sIRXfvk59ErGzkLq+NjsxqhkOPX+1ciBFIEvCF3x5?=
 =?iso-8859-2?Q?kqhUqOCSEetzvEPb/fPhy7pQHawKmPboRZ5G0sr8ii+m6dtYpSAYxxf58v?=
 =?iso-8859-2?Q?agBLC/y9uVeNYwlu1c/czwMwr4Gl98J0F1m4/FAEg9w1txJXtLF+g3gpPm?=
 =?iso-8859-2?Q?VaLGyFdse0NEshlPjFbk0t03FU6SVI8RVkVCnUysfMX9/e3f8Jq8xJEDrb?=
 =?iso-8859-2?Q?8kEoWYkq6kq+a7Lmk/K6PKAkOIAnsGZgDB7P0WulutleUORj007KqcGDHE?=
 =?iso-8859-2?Q?aXifHSwirP6OAtkI+YFyT6h8tQaWZn3Sel5zNYfBcAopzBlMgf2tO/bqZb?=
 =?iso-8859-2?Q?YXe2wDMieU157OdsPWO5DNAizveMbtxnWF8A5qLHLGTmyx9M4f9k4/471l?=
 =?iso-8859-2?Q?2g4qvy1WxNGJ8MNQfyadwWnNrAK+f1qsA+LMe/uf9YxtOokwRmcqzKOTFo?=
 =?iso-8859-2?Q?p6uq401vnjxdoVExbZ0RFIe+8MadIb4UsxXUCNYwWL1c84cB+oqJfjiJ2g?=
 =?iso-8859-2?Q?ka2vh5628o0FvtdX2aDohc2r+RSQdFtMsSpkwtEWGFOs1yCNUpra+wqJqP?=
 =?iso-8859-2?Q?pPDWDO3LNt4gukmZgEG8fdWK/yrMY0zo5iPpI2KkgJ632nQMPw9qmwLFIg?=
 =?iso-8859-2?Q?Gxmaf0FXnQXWLAPMFPcSbS0QYJgFHmNJukxQvVkieu25e059uU5Uc5kE8T?=
 =?iso-8859-2?Q?S1whbmXnL1paq9ltKpdsJCnNgTOZ9peD/69vK+aiQo+T0XflBAft09osY0?=
 =?iso-8859-2?Q?Pp9QjpLPbsGugckRjX2ExAfChQwpf+/aWttDrmPuQS2DdT+GNkr8sAlyDJ?=
 =?iso-8859-2?Q?3vhfGafoZULyyLFKzhh/94aRd0EK8uyOG+jKOU3zt/gsGfaivNspR2RFWQ?=
 =?iso-8859-2?Q?2md9/YwGeHst60dNXwtbt0wk//8v18c6PF+Qbqzk3krBmWo/FW0erIjbl7?=
 =?iso-8859-2?Q?Zk11tCxbnQteb4PEbifywQC1UlH4epK29Nsx+D+zWfgdxChrSqY+qK/AhV?=
 =?iso-8859-2?Q?+tiUfH8qXUSD1ROTpA00noIzYQwhMCWM6Yci8A9BndTR9FQYHo1T0t7qu8?=
 =?iso-8859-2?Q?yEeXs9PSh+1EA1cACr9ZTDdi/NQkar/2XfPSuM4R1WEpicCCXwD7nWtCs2?=
 =?iso-8859-2?Q?icSNOKdvD/SmqmeJuX0lhAYltxlyNm2dX983V4mB/ES2jS9N94QShCQnIe?=
 =?iso-8859-2?Q?1zL6doZ2CznH+ctJZckRhGf+UJCXwqQeYBN1jOLeEVXJ1iOqwMdKXFkg1h?=
 =?iso-8859-2?Q?TtzhyGfMCGniTp+jqGDXeS4FzMI4u4TiTM3Cp4grILDF6UXBqoEHsvucc3?=
 =?iso-8859-2?Q?oX+UBWCCyzR0CGYoV3I=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 14986360-bcde-424f-ae48-08db2e8655d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 05:44:30.3266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItUzoyGo1Hp6zHBwfHvwUQxoETYiw7IBFSgUV6xrLXNqKlm9oiRE0G3deCnNg/SJIT9Z/q+gU/K7vLeUIlDjqZFlN5ZJYpnSAX0GVzefSyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6387
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> So I confirmed that atomic operations from=0A=
>> arch/arm64/include/asm/atomic_ll_sc.h can be quite slow when they are=0A=
>> contested from second CPU.=0A=
>> =0A=
>> Do you think that it is possible to create fair qspinlock implementation=
=0A=
>> on top of atomic instructions supported by ARM64 version 8 (no LSE atomi=
c=0A=
>> instructions) without compromising performance in the uncontested case?=
=0A=
>> For example ARM64 could have custom queued_fetch_set_pending_acquire=0A=
>> implementation same as x86 has in arch/x86/include/asm/qspinlock.h. Is t=
he=0A=
>> retry loop in irq_finalize_oneshot() ok together with the current ARM64=
=0A=
>> cpu_relax() implementation for processor with no LSE atomic instructions=
?=0A=
>=0A=
>So is the queued_fetch_set_pending_acquire() where it gets stuck or the=0A=
>earlier atomic_try_cmpxchg_acquire() before entering on the slow path? I=
=0A=
>guess both can fail in a similar way.=0A=
=0A=
For me it was stuck on queued_fetch_set_pending_acquire().=0A=
=0A=
Zdenek Bouska=0A=
=0A=
--=0A=
Siemens, s.r.o=0A=
Siemens Advanta Development=
