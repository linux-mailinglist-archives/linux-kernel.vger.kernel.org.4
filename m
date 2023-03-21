Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3316C32E5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjCUNao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjCUNak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:30:40 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808832FCE9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1679405426; i=@lenovo.com;
        bh=R6R/BH2v/NNKmIXKO1FX+W24KFfA4iPnbiRee8Y59XU=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=wLPl9lL9U+wM3Z3fJ5AvNvHJPDXKhorxlFaQgJ4DXXZ/pgbFPwIvTynWFVA7ZGP3o
         MeY/h/19B6tMTNUAEjNAynDQ8BLf0BsHxvUWL3rcuwfMRcqjPowH7Y5BYoegWs+Bs9
         6kNFi+HpqINBgs+rVsaGeld2NEtzaSl92ZhPSbLftdnB7by441l5w3dVbeo0ioOdAA
         8pETg8rMl51eA5+fQIPdLMyTS135+VgqJarIC9gIUyoDByFoak/QNUTWXVkXkaYoHa
         7qtDBbubtN8/cpWYQFZeABPBxctKqAR2/dxosjz5Hv2aM9eQ4w2jVRfeGAkWd3RKJU
         RM/SXz3Le3J1A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJsWRWlGSWpSXmKPExsWSoZ+np5u7UTL
  F4MsObov/e46xWXzoXMNosXL1USaLSYeuMVpc3jWHzWL+sqfsFutev2dxYPeY2PyO3WNBz3lm
  j/P3NrJ4bFrVyeaxeUm9x+6bDWwenzfJBbBHsWbmJeVXJLBmfHx5l6mg1b7i/crPTA2Mc+y6G
  Lk4GAWWMkvMPXyPGcJZxCrR+WcTO4SzgVGi+9dnRhBHSGABk8Tcrq+sEM59Ronj23cC9XBysA
  moSyyadZoJJCEi0MEosXtXBwuIwyywlVHi5IWJYFXCIM6SHUIgtohAjsTFz3fYIGw3iY9z5oL
  ZLAKqEg+a9zOC2LwCsRK7lt9gg1g3nUli0bRGsCJOAXuJlsVPmEBsRgFZiWmP7oPZzALiEnOn
  zWIFsSUEBCSW7DnPDGGLSrx8/I8Vor5E4tbL9WwQcVmJS/O7GSFse4kLn/6yQ9i+EsuO3ofql
  ZNY1fuQBcKWl5i26D1UjYzEgxvbwY6TEJjAJnH40hp2COc0i8SeL51MEFUGEvO+HYGquiEisW
  vubKCxHECnakqs36UPcbWixJTuh+wTGLVnIXliFkLVLCRVs8ABIyhxcuYTlgWMLKsYTYtTi8p
  Si3RN9JKKMtMzSnITM3P0Eqt0E/VKi3VTE4tLdI30EsuL9VKLi/WKK3OTc1L08lJLNjECk1pK
  kWPLDsbGvr96hxglOZiURHk7VkqmCPEl5adUZiQWZ8QXleakFh9ilOHgUJLg1VkGlBMsSk1Pr
  UjLzAEmWJi0BAePkgjvw3VAad7igsTc4sx0iNQpRnuOK9v27mXm+LbxJJC88H3+AWaO/11/Dj
  ALseTl56VKifMeXA/UJgDSllGaBzcUlhEuMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmnQG
  ynCczrwRu9yugs5iAzoqbIQFyVkkiQkqqgYlf1vut4EPlydfYV3daN/5r2HNo7fdbGpu/Po2d
  2v/w4k7vx88umOrNS4g03fh474Gml4rVTZb/tZb1bbm4Z83CloDtCz7uvsTpFVz/tfvErtnMb
  wSWtYm2J95PyuIQqzPmTuWOX6VoFea0UHlVhbml+WuLpTzOE25aZP/9xrxaJ22yRfhTFsag6X
  0f8mefMlrQ/eRGvMzl68b18VOc0lfX3N+8JFD53gc+cQVGl6bFb6IlOMVuNqewTtmjfvTKo32
  dvMuT4w6sjfbft6fWvvxUroLiz4vCFxaErtAVOlt++ufNroJkR573RvJVm8tlZl9ZdsFK85+w
  1J+UnY2WOytm7dPgkhGZoPZoYS/DrRtKLMUZiYZazEXFiQB8pxrwgwQAAA==
X-Env-Sender: yinlei2@lenovo.com
X-Msg-Ref: server-19.tower-715.messagelabs.com!1679405419!92659!1
X-Originating-IP: [104.47.110.46]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1298 invoked from network); 21 Mar 2023 13:30:21 -0000
Received: from mail-tyzapc01lp2046.outbound.protection.outlook.com (HELO APC01-TYZ-obe.outbound.protection.outlook.com) (104.47.110.46)
  by server-19.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Mar 2023 13:30:21 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJBNLeTfyUucZm/NIKmzGVKvMoxhCwNLmcHQ8YSRdyUGku+yDeaHhzAfQVl6X/4wwV5FLXLEn/ajtPwQcTY8mbC0A6KpuX+lix39CMncUTBN2tkJbBGHBzlvZoUIgn32ebvUELT1oJfAUQAQ0qywmAXQ1Mr180ejnexrUkqtaesnRdLoWAW4tvlcL5gxPEYsAJZHWoPYBMfVLR72YW+VxcjvJDIa2qUmVKpMGWkXBfmA1iriTpjkPs4w33SFAFX5cL0itaeyf4yYvtjWd47+DsJ3dpSZHQzCtZvtlOJ6SC2oTsDJdHsrcPzcgWQgKpr7QGTfRKibR4FCYDds8QrgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6R/BH2v/NNKmIXKO1FX+W24KFfA4iPnbiRee8Y59XU=;
 b=W3QXB7kAUSh5oLHM8L+0P43QCKcGE/EED4qHrtrY50BMAF4Jn00qHu87E/0PQQRJTP1OiKP0SxvpaEOpYZNUs32/cye/XS/wH40bIT1tkSHIvrnTZrX/is9OQJPYAVsiVKgY72cfbyTRXg2ucCs1ZS7t28GJa1DyRtJbTNpw2RDyZTBVJEDGqk4oPF03HtYnflJ5wvV4ZTb4b6SbdEgVkYwXhk+lZAlgxf3RNVUvYyt3w8NWm+7w9zBnZfO5yUicnQUmokspwuS0Eh3yyMad51ebcnDsGtH9G3EFQTLOCHGKbp9pWl6/NN/4If3zu2cOB5h6mFlX3h/AvbnFkARncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from PS1PR03MB4939.apcprd03.prod.outlook.com (2603:1096:300:84::21)
 by PUZPR03MB7113.apcprd03.prod.outlook.com (2603:1096:301:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 13:30:18 +0000
Received: from PS1PR03MB4939.apcprd03.prod.outlook.com
 ([fe80::6f60:2bd9:5f36:c4f9]) by PS1PR03MB4939.apcprd03.prod.outlook.com
 ([fe80::6f60:2bd9:5f36:c4f9%6]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 13:30:18 +0000
From:   Lei Lei2 Yin <yinlei2@lenovo.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cybeyond@foxmail.com" <cybeyond@foxmail.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRXh0ZXJuYWxdIFJlOiBbUEFUQ0hdIG52bWU6IGZpeCBoZWFw?=
 =?utf-8?B?LXVzZS1hZnRlci1mcmVlIGFuZCBvb3BzIGluIGJpb19lbmRpbyBmb3IgbnZt?=
 =?utf-8?Q?e_multipath?=
Thread-Topic: [External] Re: [PATCH] nvme: fix heap-use-after-free and oops in
 bio_endio for nvme multipath
Thread-Index: Adlb4qYZRCgfva2qSAaoRzaKM2NfXgAAuViAAAGVKVAAARzEgAAActxw
Date:   Tue, 21 Mar 2023 13:30:18 +0000
Message-ID: <PS1PR03MB4939A124F814F35E69C7D59B88819@PS1PR03MB4939.apcprd03.prod.outlook.com>
References: <PS1PR03MB493948DD1ECFAF150EE7B2F688819@PS1PR03MB4939.apcprd03.prod.outlook.com>
 <042385ef-285e-5179-941b-ab37f490c1d8@grimberg.me>
 <PS1PR03MB49395AC5BC73DDDA6A79E87488819@PS1PR03MB4939.apcprd03.prod.outlook.com>
 <56620baf-6195-b987-6067-ae81d23e39c5@grimberg.me>
In-Reply-To: <56620baf-6195-b987-6067-ae81d23e39c5@grimberg.me>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB4939:EE_|PUZPR03MB7113:EE_
x-ms-office365-filtering-correlation-id: 84fefe16-3f80-48d9-0024-08db2a1069a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yt1n522jOK8TL7V0bCiDpB7TaFzSJ2xiOs75GoIM9/EiFTGMbi9GCi6tCvGFXE6CZb4MTPQVfQ4HFioa+Q8rtScF4KHUQdUpeIW+2wxUoWTOl1Vgyl9SgU2iCZoIWG355+s2nngc6fzzpsv4DZpQ1FN2KYmxFq63YyaR2LzmvjyHOJrR57uc5uZrPyjdMmjNQ/v0HQ8pGeLy+LxQ3o2GiipQNU+VOfxd2snEZJ56LByygXrBjqa3ASvqh62hHhBzUZe/BqhXd+8USlron9lFpMI7DE6ipll5yaVKrvHpaombzS6k+R1y4nxQ6SBmVPuzbVGSVeIZ5mwryy+Fme96PwPwMslES7vWoZlqqZCq5+1DtSL7e6YtXXppxhXOblv/INKisy3kh92SdBIHWPHyNMsn9z3rJS6aXeCuVHTHQmiGThaiP0PB918yhXl434cfOTUIZC1wnwyxf+lu0gavqSBYKn6g3gd91e0dDk+Ukw92uNNzF/TUZg/GVhggwN4vXaGJEI5dLtVeo+hrzXMJf6ugf34iMlXmbp68+g57LxrhMU9AYFKmjSzjV/QwXM66/nx/VaOARqknHGMtfr3DpEyhA1/NtrKXIOWNOwAzIQWg5l2qfmpotyi4RZlYtxIMF4R19+gqMKTQdFoW2lVVPMDFAD4Q5XoInhizzYJ0ojo8GZJX+AEYGypVjFYJWYT6IHbcpXUFmKcdIvPj/4FpNv2mYDBu308qtOP7JGUqFks=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB4939.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199018)(66446008)(8936002)(66946007)(41300700001)(66476007)(5660300002)(64756008)(66556008)(110136005)(478600001)(52536014)(54906003)(224303003)(38070700005)(33656002)(86362001)(4326008)(76116006)(6506007)(186003)(55016003)(7696005)(316002)(122000001)(82960400001)(9686003)(2906002)(26005)(83380400001)(38100700002)(71200400001)(48020200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzNuL212TjlHN0pBbjRmQkpybGJ1SVhpTWpxa2N4eGFxakhYZmhLenh2TjRi?=
 =?utf-8?B?ZEZrUHZURmswNVE4MXoyNGNKMnY0NW9rTFlZUmtvaGNJVFRNQkpzZ3FYa1F4?=
 =?utf-8?B?cm9pSGZld3g0WFE5a1dFL2dvOU8yYXNrQkd4and5UkxpNUM1WlFtMTd6Y2NN?=
 =?utf-8?B?RkV2Y1g5Wm1kaklzaWRkeEtKWnFHMmFRWDd3bnlBanl2bFlSZHIxeU1PaXpk?=
 =?utf-8?B?MWc1ck1oTi9EcGw3WXFtL2l4YjJCNGxjRmlYd1hYVEg2QXVFaytwTVJhNys5?=
 =?utf-8?B?aUhrYnRpUjJaeFR0QXN2T1hNclUyaFFyVlBMbU5UVzVOWnJjcTFLSXlxVEFa?=
 =?utf-8?B?Y051TGErUFo5YkxvNExINUYvMkhWMm1RKytTV3hWVEEyQjR5Y015akZvQ1R0?=
 =?utf-8?B?NDhvanM5QWMrZ1V6WVIvQnZPZFgrOXEvTmQvMmtWV0MwdHFOTUsreEVSOWM4?=
 =?utf-8?B?NHJ0dFNSeG94eE80M1p2cGZ1WE16b2VJQVREcjhMSFZId256WUdoa1htOHNQ?=
 =?utf-8?B?bFdiTk5qMGs5SUZsRTNHWEh5V1VtOVk2VG1KajJGVDBCZncxOTNGQVVsOUk1?=
 =?utf-8?B?dHUzbjVKUHdGUGxXczVDeDZ6S2dzS2dtUVRQZS9JVGpWSXNkVlNNb2VrVmxG?=
 =?utf-8?B?Q1FGS0tRSHY1TXhsNEVWcXJLWU1UdzZXYjBCVzdJYmcwanVYVzNFSGdPbmpY?=
 =?utf-8?B?ZlVSeEMvOC8vSFpkKzJHaWZ5Nks3NEtrTmppdlN5VWhXZThmWGw2cUdTbTZr?=
 =?utf-8?B?M3hVSkJUN2dXN3hyOXlKQ0M1UHhPKy9xQm9sKzBXMlBoL01MTFZGNzZmUUxE?=
 =?utf-8?B?eTZtV3Q1NlJHbHlxdm1sVzFRN01xTE00QlYxYlk4aUkyMUw5NGJ4enlBcUtl?=
 =?utf-8?B?MGFINE1sVHVNeVh3OVZTOHlBc20veFdWSFR2dU5YYTVqTUhFSEJETVdEUm8y?=
 =?utf-8?B?a3NDN0dZbGVBYURKWVhTb3hEQjd1a1lZelVzRkkvaVZkeHdoc3VJMkhTbEdp?=
 =?utf-8?B?SngydmQybHNkZjlEeDFVNDFoWHZzaW4wUmIwRHZzOExINW92SFI5dndjeHlu?=
 =?utf-8?B?dnQwZ3N0dWdEOGV0T25PQjVjK2JybERaTmxoOTduY3VOV1NMQ0g0NXVZWmpx?=
 =?utf-8?B?cXB0aXd1bEtSNFM5R2J5ZXg4NWltbkhWVjVjbVJldTVSbkhwWTFlV1YzMDdT?=
 =?utf-8?B?YVVQcmREU2VSeWNDazlNWkNDU0wzVGpKb1B1Rk9Za2tFZlVZYjlTdVppWFlU?=
 =?utf-8?B?WHBtN3VFdmljRmZiWVhRNnBGNjBHVGcrd0RZRjJ2UlRkK2puc0Q3WkF0ZXli?=
 =?utf-8?B?WlFVNnhyaStIK0JZRVJ5YnlmSUdkcFlaQlZPVTloZmkwTWdPdzYzOVZuNEV0?=
 =?utf-8?B?VlNNNmxyK3gvcFRhclZrSE9UQytYRmhIT3JpcE5ZbWpsV1A0UU0xdCt6SWZD?=
 =?utf-8?B?VXBlaHI3QUlwVVpIMXJOTGJmMUVCWjYxOTkzRU15QWFVSmRWYlEwbkZ6MzJE?=
 =?utf-8?B?b3VnR1NDTXJhdUU4NkF2dXpXWTl5YkVZR2s1R3h1ajF0OW9CanBWYjQxU1Bp?=
 =?utf-8?B?S3pnZUpmSUV3bDg0bzkwUW8ranFuc05BRFRNTlhEb3lpak5HWksyNkpEN3Ux?=
 =?utf-8?B?NmpGRmoycmN0Q2dROU9tUjMzaWtNNGg4eUhYUnJRRkYyTUpnVG8rNDNCbWpC?=
 =?utf-8?B?dzlFbTR1RDhwcHc5ODRxL0IyTk91OEVwT2p5TzNLNnE2Y0gvNVlzUlIxdzdH?=
 =?utf-8?B?ZXFQVlhIQ0g2YVQ4aHRLbnI0V2lvVWFJRThURTVYeURkMEhwemtTemdUZE9U?=
 =?utf-8?B?SWx6OXhMN0M3VnF4M095eERmaFlPOWdWNlFZMHA1bnFMVkFZVExTeHJEUnVG?=
 =?utf-8?B?TG1NMSt0VXZuZWZ1WWtRODdQcU9tN2hFUE54Q1Y2ajJDUzdwUGNHaWd6OW1G?=
 =?utf-8?B?bk51a2NtWEZCdjNUbGgzK054U0JFeE5lcDVOR0wvWXZYMmc0WlVBRTBTUnVm?=
 =?utf-8?B?WnpDVTdvTXNvd0VZejRUK1prSSs2QjVmdGowTDFpaVpCaHR5SVdJTDJKZUdF?=
 =?utf-8?B?VTdHc0p0a1dwNGMrME9PQ1lmMGxRWFdGelVJWklnZzZZK1d4b2R0TTNuTzZr?=
 =?utf-8?Q?z4Rw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB4939.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fefe16-3f80-48d9-0024-08db2a1069a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 13:30:18.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCSw73OvvTK6DdsBDQkjwVkNmmxPH/WCfx7qI4IrHN83uAG+UmVutaef6TlwBHb67b7H0JDeoyce9tqUizdLew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoJTm8sIEkgaGF2ZSBub3QgdmVyaWZpZWQgdGhpcyBpc3N1ZSB3aXRoIGEgc3lzdGVtIGxhcmdl
ciB0aGFuIDUuMTAueShzdWNoIGFzIDUuMTUueSBhbmQgNi4wIG9yIGZ1cnRob3IpLCBiZWNhdXNl
IHNvbWUgZnVuY3Rpb24gd2UgbmVlZCBsaWtlIGNncm91cCBpbiB1cHBlciB2ZXJzaW9uIGtlcm5l
bCBoYXMgY2hhbmdlZCB0b28gbXVjaCwgd2UgY2FuJ3QgdXNlIHRoZXNlIHVwcGVyIHZlcnNpb24g
a2VybmVsLg0KCQ0KDQoJSW4gYWRkaXRpb24gLCB1cHRyZWFtcyBoYXZlIGNoYW5nZSBiaV9kaXNr
J3MgbW9kaWZ5IHRvIGJpb19zZXRfZGV2KGJpbywgbnMtPmRpc2stPnBhcnQwKSwgYW5kIGFzIHlv
dSBzYWlkIHRoZXJlIGlzIG5vIGJpX2Rpc2sgaW4gc3RydWN0IGJpbyBhbnltb3JlLiBTbyB0aGF0
IGlzIHRvbyBpbnZvbHZpbmcgYmVjYXVzZSBvZiBjb2RlIGRlcGVuZGVuY2llcywgIGkgd2FudCB0
byBkbyBpcyB3aGF0IHlvdSBzYWlkLCB0byBzZW5kIGFuIGFsdGVybmF0aXZlIHN1cmdpY2FsIGZp
eC4NCgkoSSB3aWxsIGNvbmZpcm0gdXBzdHJlYW0gZm9yIHRoaXMgcHJvYmxlbSBpbiB0aGUgbmVh
ciBmdXR1cmUsIGlmIGl0IGhhdmUgc2FtZSBwcm9ibGVtLCBpIHdpbGwgc3VibWl0IHRoaXMgZml4
LikNCg0KCUknbSBub3Qgc3VyZSB3aGF0IGV2aWRlbmNlIGlzIG5lZWRlZCB0byBwcm92ZSB0aGlz
IHByb2JsZW0gYW5kIHBhdGNoLiBUaGUgZm9sbG93aW5nIGlzIGNoaWxkIGJpbyBhbmQgcGFyZW50
IGJpbyBzdHJ1Y3Qgd2hlbiBoZWFwLXVzZS1hZnRlci1mcmVlIG9jY3VyIGNhdGNoZWQgYnkgY3Jh
c2goSSB0dXJuIG9uIGthc2FuIGFuZCBwYW5pY19vbl93YXJuKS4NCg0KCVBsZWFzZSBoZWxwIG1l
IGNvbmZpcm0gaWYgdGhpcyBpcyBlbm91Z2gsIHRoYW5rcy4NCg0KCWFsbCBiaW8gZnJvbSBudm1l
X25zX2hlYWRfc3VibWl0X2JpbyB0byBiaW9fZW5kaW8gaXMgbnZtZSBoZWFkIGRpc2ssIGFuZCBm
YWlsZWQgYmlvIGlzIG9yaWdpbiBiaW8ncyBwYXJlbnQsIGFuZCBpdHMgYmlfZGlzaygweGZmZmY4
ODgxNTNlYWQwMDApIGlzIGtmcmVlZCBiZWZvcmUga2FzYW4gd2FybihJIGNvbmZpcm1lZCB0aGlz
IGJ5IGFkZGluZyBhIGxvZykuIA0KDQoNCiAgICAgIEtFUk5FTDogL3Vzci9saWIvZGVidWcvdm1s
aW51eCAgW1RBSU5URURdICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgRFVNUEZJTEU6IHZt
Y29yZSAgW1BBUlRJQUwgRFVNUF0NCiAgICAgICAgQ1BVUzogOA0KICAgICAgICBEQVRFOiBNb24g
TWFyIDIwIDE5OjQzOjM5IENTVCAyMDIzDQogICAgICBVUFRJTUU6IDAwOjA1OjMzDQpMT0FEIEFW
RVJBR0U6IDczLjQzLCAyMC42MCwgNy4xMQ0KICAgICAgIFRBU0tTOiA1MjYNCiAgICBOT0RFTkFN
RTogQzgNCiAgICAgUkVMRUFTRTogNS4xMC4xNjcNCiAgICAgVkVSU0lPTjogIzEgU01QIEZyaSBG
ZWIgMTcgMTE6MDI6MTcgQ1NUIDIwMjMNCiAgICAgTUFDSElORTogeDg2XzY0ICAoMjE5NCBNaHop
DQogICAgICBNRU1PUlk6IDY0IEdCDQogICAgICAgUEFOSUM6ICJLZXJuZWwgcGFuaWMgLSBub3Qg
c3luY2luZzogS0FTQU46IHBhbmljX29uX3dhcm4gc2V0IC4uLiINCiAgICAgICAgIFBJRDogNDE3
DQogICAgIENPTU1BTkQ6ICJrd29ya2VyLzU6MUgiDQogICAgICAgIFRBU0s6IGZmZmY4ODgxMjY5
NzIwNDAgIFtUSFJFQURfSU5GTzogZmZmZjg4ODEyNjk3MjA0MF0NCiAgICAgICAgIENQVTogNQ0K
ICAgICAgIFNUQVRFOiBUQVNLX1JVTk5JTkcgKFBBTklDKQ0KDQpjcmFzaD4gYnQNClBJRDogNDE3
ICAgICAgVEFTSzogZmZmZjg4ODEyNjk3MjA0MCAgQ1BVOiA1ICAgIENPTU1BTkQ6ICJrd29ya2Vy
LzU6MUgiDQogIzAgW2ZmZmY4ODgxMGViY2Y4MjhdIG1hY2hpbmVfa2V4ZWMgYXQgZmZmZmZmZmY4
ZjcwMWIzZQ0KICMxIFtmZmZmODg4MTBlYmNmOTQ4XSBfX2NyYXNoX2tleGVjIGF0IGZmZmZmZmZm
OGY5ZDI4ZWINCiAjMiBbZmZmZjg4ODEwZWJjZmE2MF0gcGFuaWMgYXQgZmZmZmZmZmY5MTM5Njdl
OQ0KICMzIFtmZmZmODg4MTBlYmNmYjMwXSBiaW9fZW5kaW8gYXQgZmZmZmZmZmY5MDI1NDFmNw0K
ICM0IFtmZmZmODg4MTBlYmNmYjc4XSBiaW9fZW5kaW8gYXQgZmZmZmZmZmY5MDI1NDFmNw0KICM1
IFtmZmZmODg4MTBlYmNmYmE4XSBiaW9fZW5kaW8gYXQgZmZmZmZmZmY5MDI1NDFmNw0KICM2IFtm
ZmZmODg4MTBlYmNmYmQ4XSBudm1lX25zX2hlYWRfc3VibWl0X2JpbyBhdCBmZmZmZmZmZmMxM2Nm
OTYwIFtudm1lX2NvcmVdDQogIzcgW2ZmZmY4ODgxMGViY2ZjYzhdIHN1Ym1pdF9iaW9fbm9hY2N0
IGF0IGZmZmZmZmZmOTAyNmIxMzQNCiAjOCBbZmZmZjg4ODEwZWJjZmRiOF0gbnZtZV9yZXF1ZXVl
X3dvcmsgYXQgZmZmZmZmZmZjMTNjZGM0MCBbbnZtZV9jb3JlXQ0KICM5IFtmZmZmODg4MTBlYmNm
ZGY4XSBwcm9jZXNzX29uZV93b3JrIGF0IGZmZmZmZmZmOGY4MTMzYzgNCiMxMCBbZmZmZjg4ODEw
ZWJjZmU3OF0gd29ya2VyX3RocmVhZCBhdCBmZmZmZmZmZjhmODEzZmI3DQojMTEgW2ZmZmY4ODgx
MGViY2ZmMTBdIGt0aHJlYWQgYXQgZmZmZmZmZmY4ZjgyNWU2Zg0KIzEyIFtmZmZmODg4MTBlYmNm
ZjUwXSByZXRfZnJvbV9mb3JrIGF0IGZmZmZmZmZmOGY2MDYxOWYNCmNyYXNoPiBwICooc3RydWN0
IGJpbyAqKTB4ZmZmZjg4ODE4OTBmNDkwMCAgIC8vIGNoaWxkIGJpbw0KJDEgPSB7DQogIGJpX25l
eHQgPSAweDAsIA0KICBiaV9kaXNrID0gMHhkYWUwMDE4ODAwMDAwMWExLCANCiAgYmlfb3BmID0g
MzM2MDU2MzMsIA0KICBiaV9mbGFncyA9IDE5MjIsIA0KICBiaV9pb3ByaW8gPSAwLCANCiAgYmlf
d3JpdGVfaGludCA9IDAsIA0KICBiaV9zdGF0dXMgPSAxMCAnXG4nLCANCiAgYmlfcGFydG5vID0g
MCAnXDAwMCcsIA0KICBfX2JpX3JlbWFpbmluZyA9IHsNCiAgICBjb3VudGVyID0gMQ0KICB9LCAN
CiAgYmlfaXRlciA9IHsNCiAgICBiaV9zZWN0b3IgPSAxMjI4Nzc0NCwgDQogICAgYmlfc2l6ZSA9
IDY1NTM2LCANCiAgICBiaV9pZHggPSAzLCANCiAgICBiaV9idmVjX2RvbmUgPSAxMDY0OTYNCiAg
fSwgDQogIGJpX2VuZF9pbyA9IDB4ZmZmZmZmZmY5MDI1NDI4MCA8YmlvX2NoYWluX2VuZGlvPiwg
DQogIGJpX3ByaXZhdGUgPSAweGZmZmY4ODgxOThiNzc4ZDAsIA0KICBiaV9ibGtnID0gMHgwLCAN
CiAgYmlfaXNzdWUgPSB7DQogICAgdmFsdWUgPSAyODgyMzA3MTIzNzYxMDE0ODENCiAgfSwgDQog
IHsNCiAgICBiaV9pbnRlZ3JpdHkgPSAweDANCiAgfSwgDQogIGJpX3ZjbnQgPSAwLCANCiAgYmlf
bWF4X3ZlY3MgPSAwLCANCiAgX19iaV9jbnQgPSB7DQogICAgY291bnRlciA9IDENCiAgfSwgDQog
IGJpX2lvX3ZlYyA9IDB4ZmZmZjg4ODFhNDUzMDAwMCwgDQogIGJpX3Bvb2wgPSAweGZmZmY4ODgx
NDFiZDdhZjgsIA0KICBiaV9pbmxpbmVfdmVjcyA9IDB4ZmZmZjg4ODE4OTBmNDk3OA0KfQ0KDQpj
cmFzaD4gcCAqKHN0cnVjdCBiaW8gKikweGZmZmY4ODgxOThiNzc4ZDAgICAgLy8gcGFyZW50IGJp
bw0KJDIgPSB7DQogIGJpX25leHQgPSAweDAsIA0KICBiaV9kaXNrID0gMHhmZmZmODg4MTUzZWFk
MDAwLCANCiAgYmlfb3BmID0gMzM1ODkyNDksIA0KICBiaV9mbGFncyA9IDE2NjQsIA0KICBiaV9p
b3ByaW8gPSAwLCANCiAgYmlfd3JpdGVfaGludCA9IDAsIA0KICBiaV9zdGF0dXMgPSAxMCAnXG4n
LCANCiAgYmlfcGFydG5vID0gMCAnXDAwMCcsIA0KICBfX2JpX3JlbWFpbmluZyA9IHsNCiAgICBj
b3VudGVyID0gMA0KICB9LCANCiAgYmlfaXRlciA9IHsNCiAgICBiaV9zZWN0b3IgPSAxMjI4ODAw
MCwgDQogICAgYmlfc2l6ZSA9IDAsIA0KICAgIGJpX2lkeCA9IDUsIA0KICAgIGJpX2J2ZWNfZG9u
ZSA9IDANCiAgfSwgDQogIGJpX2VuZF9pbyA9IDB4ZmZmZmZmZmY4ZmY4ZGY4MCA8YmxrZGV2X2Jp
b19lbmRfaW9fc2ltcGxlPiwgDQogIGJpX3ByaXZhdGUgPSAweGZmZmY4ODgxYjBjNTQwODAsIA0K
ICBiaV9ibGtnID0gMHhmZmZmODg4MTk3NGRmNDAwLCANCiAgYmlfaXNzdWUgPSB7DQogICAgdmFs
dWUgPSAyODgyMzA2NjUyNjQxMTM2NTQNCiAgfSwgDQogIHsNCiAgICBiaV9pbnRlZ3JpdHkgPSAw
eDANCiAgfSwgDQogIGJpX3ZjbnQgPSA1LCANCiAgYmlfbWF4X3ZlY3MgPSAyNTYsIA0KICBfX2Jp
X2NudCA9IHsNCiAgICBjb3VudGVyID0gMQ0KICB9LCANCiAgYmlfaW9fdmVjID0gMHhmZmZmODg4
MWE0NTMwMDAwLCANCiAgYmlfcG9vbCA9IDB4MCwgDQogIGJpX2lubGluZV92ZWNzID0gMHhmZmZm
ODg4MTk4Yjc3OTQ4DQp9DQoJDQogDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6
ujogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4gDQrlj5HpgIHml7bpl7Q6IDIwMjPl
ubQz5pyIMjHml6UgMjA6MjYNCuaUtuS7tuS6ujogTGVpIExlaTIgWWluIDx5aW5sZWkyQGxlbm92
by5jb20+OyBrYnVzY2hAa2VybmVsLm9yZzsgYXhib2VAZmIuY29tOyBoY2hAbHN0LmRlDQrmioTp
gIE6IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgY3liZXlvbmRAZm94bWFpbC5jb20NCuS4u+mimDogUmU6IFtFeHRlcm5hbF0gUmU6
IFtQQVRDSF0gbnZtZTogZml4IGhlYXAtdXNlLWFmdGVyLWZyZWUgYW5kIG9vcHMgaW4gYmlvX2Vu
ZGlvIGZvciBudm1lIG11bHRpcGF0aA0KDQoNCj4gCVRoYW5rIHlvdSBmb3IgeW91ciByZXBseQ0K
PiANCj4gCVRoaXMgcHJvYmxlbSBvY2N1cnMgaW4gbnZtZSBvdmVyIHJkbWEgYW5kIG52bWUgb3Zl
ciB0Y3Agd2l0aCBudm1lIGdlbmVyYXRlIG11bHRpcGF0aC4gRGVsZXRlIHRoZSBucyBnZW5kaXNr
IGlzIGNhdXNlZCBieSBudm1mIHRhcmdldCBzdWJzeXN0ZW0gaXMgZmF1bHR5LCB0aGVuIGhvc3Qg
ZGV0ZWN0IGFsbCBwYXRoIGtlZXAgYWxpdmUgb3ZlcnRpbWUgYW5kIGlvIHRpbWVvdXQuIEFmdGVy
IGN0cmwtbG9zcy10bW8gc2Vjb25kcywgaG9zdCB3aWxsIHJlbW92ZSBmYWlsIGN0cmwgYW5kIG5z
IGdlbmRpc2suDQoNClRoYXQgaXMgZmluZSwgYnV0IGl0IGlzIGEgcHJvYmxlbSBpZiBpdCBkb2Vz
IG5vdCBjb3JyZWN0bHkgZHJhaW4gaW5mbGlnaHQgSS9PLCB3ZWF0aGVyIGl0IHdhcyBzcGxpdCBv
ciBub3QuIEFuZCB0aGlzIGxvb2tzIGxpa2UgdGhlIHdyb25nIHBsYWNlIHRvIGFkZHJlc3MgdGhp
cy4NCg0KPiAJV2UgaGF2ZSByZWFwcGVhciB0aGlzIHByb2JsZSBpbiBMaW51eC01LjEwLjEzNiwg
TGludXgtNS4xMC4xNjcgYW5kIA0KPiB0aGUgbGF0ZXN0IGNvbW1pdCBpbiBsaW51eC01LjEwLnks
IGFuZCB0aGlzIHBhdGNoIGlzIG9ubHkgYXBwbGljYWJsZSANCj4gdG8gTGludXgtNS4xMC55DQoN
ClNvIG15IHVuZGVyc3RhbmRpbmcgdGhhdCB0aGlzIGRvZXMgbm90IHJlcHJvZHVjZSB1cHN0cmVh
bT8NCg0KPiANCj4gCVllcyAsIHRoaXMgaXMgYWJzb2x1dGVseSB0aGUgd3JvbmcgcGxhY2UgdG8g
ZG8gdGhpcyAuIENhbiBpIG1vdmUgdGhpcyBtb2RpZmljYXRpb24gYWZ0ZXIgbnZtZV90cmFjZV9i
aW9fY29tcGxldGU/DQo+IA0KPiAJRG8gSSBuZWVkIHRvIHJlc3VibWl0IGEgcGF0Y2gsIGlmIG1v
ZGlmaWNhdGlvbnMgYXJlIG5lZWRlZD8NCg0KWWVzLCBidXQgYSBiYWNrcG9ydCBmaXggbmVlZHMg
dG8gYmUgc2VudCB0byBzdGFibGUgbWFpbGluZyBsaXN0DQooc3RhYmxlQHZnZXIua2VybmVsLm9y
ZykgYW5kIGNjJ2QgdG8gbGludXgtbnZtZSBtYWlsaW5nIGxpc3QuDQoNCkJ1dCBJIGRvbid0IHRo
aW5rIHRoYXQgdGhpcyBmaXggaXMgdGhlIGNvcnJlY3Qgb25lLiBXaGF0IGlzIG5lZWRlZCBpcyB0
byBpZGVudGlmeSB3aGVyZSB0aGlzIHdhcyBmaXhlZCB1cHN0cmVhbSBhbmQgYmFja3BvcnQgdGhh
dCBmaXggaW5zdGVhZC4NCklmIHRoYXQgaXMgdG9vIGludm9sdmluZyBiZWNhdXNlIG9mIGNvZGUg
ZGVwZW5kZW5jaWVzLCBpdCBtYXkgYmUgcG9zc2libGUgdG8gc2VuZCBhbiBhbHRlcm5hdGl2ZSBz
dXJnaWNhbCBmaXgsIGJ1dCBpdCBuZWVkcyB0byBiZSBqdXN0aWZpZWQuDQo=
