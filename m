Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D83F5B6992
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiIMIbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiIMIaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:30:55 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E01FD10;
        Tue, 13 Sep 2022 01:30:53 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D8T3Pf026607;
        Tue, 13 Sep 2022 08:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=mvQEEGpEkC2k3RpQeBzNWuxePX1h/nws5V36ngNyY0w=;
 b=Wyr2S5lopdqz/dPOQZF8yb/T0PWNVUAodSqSv+KBnvNNYdU95bk5CE2DRAkKnL8b6x9Y
 svSeIYZErC2lMz0uoz38KQp0IpXsJV/v6Ja51Wesam/vkccg72P+fKCDB/A1WmPvqbIn
 ZbL62FEYsqUIe8g5N9pgg2JOWJxomM+4nK4oJeJUl2vGicENMiIDu+5petJSXkNycWjx
 5b7M9mwH0wMoQ9YadQwIJMOzABVt4bzJ1BVwsmopq9mccF2NbmTfqB034TECC4LR77rT
 nNqYW9Cvu9e/bJA371IL2SjgW88I/oc1H/tM4mHmLnXwM5AemDiFRbFCnCYX+ZZrtxf4 6w== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3jjpd2g15r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 08:30:49 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 0C858D249;
        Tue, 13 Sep 2022 08:30:48 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 12 Sep 2022 20:30:47 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 12 Sep 2022 20:30:47 -1200
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 12 Sep 2022 20:30:47 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFMvVBDumszwEVj27JgXwkzw9xAxgi72kFEt+vd2iWBI+jey+kgvmj3oICHi+nhBF3xN/XAs8b18Ao/Oxshri8T+a0akUMRUrR1cegvWkRYFErumMAUDXItlNF8HQoHWvpfid96HrtWugtheXJypxmaQGU9MM5nPEVGNJVdZUxeYmCuC0RmbxVdNYT8kCWGGsZqc/VffGJegQiar6kOZtdwCOW65g1c/NAYvFa6HfN0QfR2g15nYVtW6p8pAY9Y23552lDCmW6J+V5deLbuDvlwOYJatVYi7BrYNO1vNmepUpvmjQL3diKtMxLGb8GI3uw97vWH683yppNfAMAsXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvQEEGpEkC2k3RpQeBzNWuxePX1h/nws5V36ngNyY0w=;
 b=RAE3uzm113ZJB9BTQUtaT5dvBHioXX+7PeNhUgo8/B0qRszhtln4yOtP9akFFjzmMYIk0YO4HcHKihcr7twcNGL97W7Wwls1FM+ZchhDCYrzG5GGZ/+HBL2AFO0oasuW6Q7gRmRMI76BqWlja6fGVTiZ9Vzb4drzhgV9oqpXn6s9kPkphmLKH3bPGdTJ84wSdCLmM0D2mg05d9GxYztBEsep/D+nNtWXTt7nSPn1S3BVIv7qHJYDnHm2YKoXdT2V69raGUe98jL5tRdXEQqqPg40Noq9ZV5LPsXblVAHYKOunPEmZ5XJ3GCmmTJHz9BROcEp8oa0LD8WW9HE5un/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by SJ0PR84MB1773.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:433::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 13 Sep
 2022 08:30:46 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1cc2:4b7b:f4c5:fbb4%6]) with mapi id 15.20.5566.021; Tue, 13 Sep 2022
 08:30:46 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Accidental config renaming in commit 3f342a23257d ("crypto:
 Kconfig - simplify hash entries")
Thread-Topic: Accidental config renaming in commit 3f342a23257d ("crypto:
 Kconfig - simplify hash entries")
Thread-Index: AQHYwotkX1VmGChNeUikuus3IkKTTK3dB+sQ
Date:   Tue, 13 Sep 2022 08:30:45 +0000
Message-ID: <MW5PR84MB18424AB8C095BFC041AE33FDAB479@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <CAKXUXMyMUNgra_B47Qk3kjqgmR-FcCbDpEZMH5rv=whrQDRQww@mail.gmail.com>
In-Reply-To: <CAKXUXMyMUNgra_B47Qk3kjqgmR-FcCbDpEZMH5rv=whrQDRQww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a96fcde1-e1ac-4f81-2799-08da95624143
x-ms-traffictypediagnostic: SJ0PR84MB1773:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fz+jnEqy7BLq7tO0CVu06zPY137/4njweF/RqyUeZsxZ7nHyi5/f2aIplAE3uLzexCdoqqDllcuPcojIwFc7G4QV+VwSbEWvaasMk/h4iAVavrSPa2ZLsHNNDzkXbjM52dm7xua+z+RVH72E4Z+kWtkw2xTmCxa8Mw5ztjR3mHzJMBqjiYFicDoff+v/xOJ59Ur412mcMDU0KlEbBzfzODr9kVD+WQs06x5VWuaX6jbRVVaBTcK+ILWr7xluBVYEu65HUQTcS6qrCFlp6ApDWfeWITidTsI9LPMhUd9Ilnu+fBpTEN5jJF+avAyoALEw2UdAcmmWuGuYBO9MPIAuWslmwnh6gj8LjNQcymllZ3LFWnqCkbJ80v6s3Fyyr6AnHnlQ/3UD6M+/DUpGzJeKMWgcJiVF7hLi63g1jnK0lv6/DS+fyssNmDyIXMHZ2GargzOWTMXnJ65c1rslDgVQZ43LcHTU1YdwRDt0aMpNloDgmb4PiSdA2NvKjeBLmly66ZwP6zMTs7vQfAPKn7KdaEbam4vm49C5ORwLVVspcpf0oAkHrONIqajXTOpDmZvgTRxmRMlK+UPOlyGPHN7Z/iNrMpxf4QC7YMM3RRsNk/XPvjIrpbqaF/YGHHs1E3AzJTd5/Jh1EQtRjWo6bwhIpp56cUG9h6iDVSUu+0lOY0f1LzrAEJWtQFHa/nEvfiYgQkEBdXuA0xLkU122NLxOywLJHL4Gnjlqun38xiSIg1E0ZJaKjiBUK7eJk9/nQh5AJbGIh+FdlNoZqvpTuzFLFhBVWOIXPyKxmZwaXfmHse0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(76116006)(6506007)(86362001)(33656002)(53546011)(64756008)(478600001)(7696005)(55016003)(5660300002)(316002)(83380400001)(26005)(110136005)(2906002)(8936002)(38100700002)(52536014)(8676002)(186003)(71200400001)(9686003)(66946007)(66446008)(66476007)(122000001)(38070700005)(82960400001)(66556008)(41300700001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y05PSkJRUEUwVnlIYWlZOXZHYWhpWEhwT1QvTEdnUm82cWhCQjJaZUJWTTRm?=
 =?utf-8?B?Zk9DdTJOUm5BQ09oZmFiV096VG93bWFUREpQUUlEU1pldGVTZDdNb3FTWTlm?=
 =?utf-8?B?V0MreC8wVmlseGxlWmlJWkgrampYcnFONGpRZURlKzQreEp5endQVHhYQkQw?=
 =?utf-8?B?TU5RcENZNWFTN0ZDc09pYmNHaVY2R0dRQVVmcHlrWXM5VXhhSzZhdHFQM1dO?=
 =?utf-8?B?YWgzaVJCMjRobm40cnZNeDdEYytWaW1CdTJld1d6eFhWakJUbUxXS05jejZo?=
 =?utf-8?B?YlV6MllmWUJVWlUyVWJ1K1NSYjJIaC9jYmQ1eG5PY3J0ZG9rbnNsVU91STFa?=
 =?utf-8?B?Qkh5dlNCVWxDaHJTbnVLN25xNVN3bkVBUkJmbTFrNmVSSDgwOFNiSTNlS3J3?=
 =?utf-8?B?aXFDeDAwVUxwYktKU1hsZWRRZzFTUzdOb3ZncjdwODhEbGhicVJIbTNRM283?=
 =?utf-8?B?QVBWQ0pFNHpIUUZDRGZYUGpmMFhHTjFQd1IwRTNUaWhmeU5vM2lXTmY4N2p4?=
 =?utf-8?B?bmFqemhLOWVKb09qTWlNN2l4TDJyOXgvRWp1TkpIWGRmZmlLVHZsNFNaekJs?=
 =?utf-8?B?MWdmOEM1ZjZ2ZDljSmZJT09PTzFLTytPSTRVT1lJTWtZT0M1Y2NvU210eWdR?=
 =?utf-8?B?WE12QXN4U3NZcjUvYTBzYzJjRzlkZlM0QTcyYWZOMmhtRWZKWjg3L0E4dXFz?=
 =?utf-8?B?cXBTbjJHQW1USFFWQkZ6a1ByZklNZHo1cHZ1NmZUa3BHNWJrZUdUU2FLWTZT?=
 =?utf-8?B?blFwdUFiNi83MEhJS2UwNlMyZWZvTXJERE43OWNKS2pNN3dvbWk2NHZ5clZt?=
 =?utf-8?B?RnUrSE1FKzNMQ1BIa1NuT1c2bjZXWURBTzVJUjdRYWpqSzNlREdyUmJXYlgy?=
 =?utf-8?B?cS9HMmVHWnpjWXJlVUFPUTVBOUR4TlNqT0l4TzBwMnRidlZlaEN3MGN4MTRj?=
 =?utf-8?B?Yi9CUHh3bVdndnhFak1icmhnT3VscjdXTWM3RlpMUnVmVzV1OVA5TTBxTG5p?=
 =?utf-8?B?Y0dNdk9yaUJ5MTZabFNNaGMrbWgwSVgrcXl2V0t1ZENMa2NtMmcrYzY4QVFs?=
 =?utf-8?B?c3YrQjN0RHdhSElCZjIxZ09sVVFrV2w1dFIyV2JvU3dQVVA4MGowN0didC9n?=
 =?utf-8?B?MkxlbEZHSjdLZWs0S0JPM1p5bDZvdHhqYW5KN2hVeG8xVldmMGJuMEI0eXJ6?=
 =?utf-8?B?ZUF2WHM3WUlzaDZuVTRYbXlabmR1R1BqbVpBK2p1dktyUlo2aFFlQWNsTEVW?=
 =?utf-8?B?UGdBSy9ZdTdKSXFqRWlTRVJIbjh1NW5wQ0J3UC9BNUVtM1NxYzgrdWtRcDI4?=
 =?utf-8?B?dHJwYnNzY0VybXhRNS96eHE3T1JkU2ZITzUrSDIrcWVoMkdVc1RYYXhaekxC?=
 =?utf-8?B?Vk45Y1RmSFR5V21abUpBdGR5Ry9NVFpaZ3dlTXpGVGVxaVE0QWl1SXQvMXBC?=
 =?utf-8?B?TnhFN09sd2xRY0lKMzU3NS9ROUZYZFQwbE9NT09XbHZhVTFncHV6ZDZzZVcz?=
 =?utf-8?B?b0NpMHYyWEdyWEs3TWducThRdGd2eDYvV3VBTVdhUy9XNVRaUU9XTEpJaTgv?=
 =?utf-8?B?UklZekcxYmJPVEwwZDVoeXpCcFVNckZ4TDRNYkhIRHhTZWJ0KzIrRUZ2K3lH?=
 =?utf-8?B?M0xTQnpKMXdxQUZaSVR1Qk54ZExTSkRzUU9wOCs3N0VGaVArUFBQaUZhV0Z5?=
 =?utf-8?B?YThoRTlINUk3QmR3SkYyL2c0WE1tZGNSanU0S3dwUWVwK3lRS01BYmlOZWNy?=
 =?utf-8?B?R3pPNURIRkVqc056eFd1OGdreUROYXlnK2d5QXZIQUNwSEN4LzhXK3U0K2F1?=
 =?utf-8?B?dDc2b1JKZVJaNnlKczBxU29xaFI5S2VvUURDT0JCZWQ1VFFFdTEyUVJnRXJR?=
 =?utf-8?B?TjE2ZnBBQmVvZEtvdUYvRlBFTytwaWxlVk9sSS9IaDVlRUswWENDd2hpN01T?=
 =?utf-8?B?K1FvaTkvRlIvNDZabkd5eVJwL1A0VXl4bFFROExDZ01rbXlaRWVSSmhoaFJ6?=
 =?utf-8?B?YmN5dHVibExjTEFHQk5xMk9wTm9QSS9BSzl5SCt5cHVxcERPNGEvaEQ5QW00?=
 =?utf-8?B?QWg0bkkxUG9DSjhvOUVkUmxLMUgyNlorMVpiSFZTbUE0a3FLNndKcW5rdVhp?=
 =?utf-8?Q?0P5E=3D?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a96fcde1-e1ac-4f81-2799-08da95624143
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 08:30:46.0443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1N9PWLytrxoOZB1/kiF27QB+qPzqeIv3diSH1QA9XSk6mZvEkUx0o3CxIj/F8fJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1773
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: kmzY1ClGuZw90SwqX3OqfWnB2nmw1JF2
X-Proofpoint-ORIG-GUID: kmzY1ClGuZw90SwqX3OqfWnB2nmw1JF2
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_03,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130037
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgZm9yIHRoZSBkZWxheSAtIEknbSBvdXQgb2Ygb2ZmaWNlIHRoaXMgbW9udGguDQoNCjEu
IEkgYWdyZWUgdGhpcyBpcyB3cm9uZzoNCg0KLWNvbmZpZyBDUllQVE9fU0hBMV9BUk02NF9DRQ0K
LQl0cmlzdGF0ZSAiU0hBLTEgZGlnZXN0IGFsZ29yaXRobSAoQVJNdjggQ3J5cHRvIEV4dGVuc2lv
bnMpIg0KK2NvbmZpZyBDUllQVE9fU0hBMV9BUk02NA0KKwl0cmlzdGF0ZSAiSGFzaCBmdW5jdGlv
bnM6IFNIQS0xIChBUk12OCBDcnlwdG8gRXh0ZW5zaW9ucykiDQoNCg0KSSB0aGluayBteSBncmVw
IGNvbXBhcmlzb25zIHRvIG1ha2Ugc3VyZSB0aGUgY29uZmlnIGxpbmVzIGRpZG4ndA0KY2hhbmdl
IHdlcmUgZm9pbGVkIGJ5IC0gYmVpbmcgYSBzcGVjaWFsIGNoYXJhY3Rlci4NCg0KSGVyYmVydCwg
Y2FuIHlvdSBmaXggdGhhdCBpbiBhIHdheSB0aGF0IHdvbid0DQpjYXVzZSBiaXNlY3Rpb24gYW5v
bWFsaWVzPw0KDQoyLiBUaGVyZSdzIG9uZSBtb3JlIHByb2JsZW0gaW4gdGhhdCBjb21taXQgLSB0
aGUNCkNSWVBUT19CTEFLRTJTIHN5bWJvbCB3YXMgZHJvcHBlZCBieSA2LjAgYW5kIHNob3VsZCBu
bw0KbG9uZ2VyIGV4aXN0LiBJdCdzIGEgcmVtbmFudCBmcm9tIHRoZSBvcmlnaW5hbCBzZXJpZXMN
CmJlaW5nIGJhc2VkIG9uIDUuMTkuDQoNClRoZSBleHRyYSBzcGFjZSBiZWZvcmUgImNvbmZpZyIg
bGVkIG1lIHRvIG92ZXJsb29rIGl0Lg0KKEknbGwgaW52ZXN0aWdhdGUgaWYgY2hlY2twYXRjaC5w
bCBjYW4gY2hlY2sgZm9yIGxlYWRpbmcNCnNwYWNlcyBiZWZvcmUga2V5d29yZHMgbGlrZSB0aGlz
IG5leHQgbW9udGgpDQoNCisgY29uZmlnIENSWVBUT19CTEFLRTJTDQorCXRyaXN0YXRlICJCTEFL
RTJzIg0KKyAgICAgICAgc2VsZWN0IENSWVBUT19MSUJfQkxBS0UyU19HRU5FUklDDQorICAgICAg
ICBzZWxlY3QgQ1JZUFRPX0hBU0gNCisgICAgICAgIGhlbHANCisJICBCTEFLRTJzIGNyeXB0b2dy
YXBoaWMgaGFzaCBmdW5jdGlvbiAoUkZDIDc2OTMpDQorDQorCSAgQkxBS0UycyBpcyBvcHRpbWl6
ZWQgZm9yIDggdG8gMzItYml0IHBsYXRmb3JtcyBhbmQgY2FuIHByb2R1Y2UNCisJICBkaWdlc3Rz
IG9mIGFueSBzaXplIGJldHdlZW4gMSBhbmQgMzIgYnl0ZXMuIFRoZSBrZXllZCBoYXNoIGlzDQor
CSAgYWxzbyBpbXBsZW1lbnRlZC4NCisNCisJICBUaGlzIG1vZHVsZSBwcm92aWRlcyB0aGUgZm9s
bG93aW5nIGFsZ29yaXRobXM6DQorICAgICAgICAgIC0gYmxha2Uycy0xMjgNCisgICAgICAgICAg
LSBibGFrZTJzLTE2MA0KKyAgICAgICAgICAtIGJsYWtlMnMtMjI0DQorICAgICAgICAgIC0gYmxh
a2Uycy0yNTYNCisNCisJICBVc2VkIGJ5IFdpcmVndWFyZC4NCisNCisgICAgICAgICAgU2VlIGh0
dHBzOi8vYmxha2UyLm5ldCBmb3IgZnVydGhlciBpbmZvcm1hdGlvbi4NCg0KDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVrYXMgQnVsd2FobiA8bHVrYXMuYnVsd2Fo
bkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciA2LCAyMDIyIDk6MjggUE0N
Cj4gVG86IEVsbGlvdHQsIFJvYmVydCAoU2VydmVycykgPGVsbGlvdHRAaHBlLmNvbT47IEhlcmJl
cnQgWHUNCj4gPGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdT47IGxpbnV4LWNyeXB0b0B2Z2Vy
Lmtlcm5lbC5vcmc7IExpbnV4IEtlcm5lbA0KPiBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IEFjY2lkZW50YWwgY29uZmlnIHJlbmFtaW5nIGlu
IGNvbW1pdCAzZjM0MmEyMzI1N2QgKCJjcnlwdG86DQo+IEtjb25maWcgLSBzaW1wbGlmeSBoYXNo
IGVudHJpZXMiKQ0KPiANCj4gRGVhciBSb2JlcnQsDQo+IA0KPiBJIG5vdGljZWQgdGhhdDoNCj4g
DQo+IENvbW1pdCAzZjM0MmEyMzI1N2QgKCJjcnlwdG86IEtjb25maWcgLSBzaW1wbGlmeSBoYXNo
IGVudHJpZXMiKSBtYWtlcw0KPiBhIGxvdCBvZiBjaGFuZ2VzIHRvIHRoZSBjb25maWcgZGVzY3Jp
cHRpb25zLCBidXQgYW1vbmcgYWxsIHRob3NlDQo+IGNoYW5nZXMsIGl0IGFsc28gcmVuYW1lcyBD
UllQVE9fU0hBMV9BUk02NF9DRSB0byBDUllQVE9fU0hBMV9BUk02NC4NCj4gDQo+IEdpdmVuIHRo
YXQgeW91IGRpZCBub3QgdG91Y2ggdGhlIGNvcnJlc3BvbmRpbmcgTWFrZWZpbGUsIGl0IHNlZW1z
IHRoYXQNCj4gdGhpcyBjb25maWcgcmVuYW1pbmcgd2FzIHVuaW50ZW5kZWQgYW5kIGFjY2lkZW50
YWxseS4NCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgY29uZmlybSB0aGF0Pw0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiANCj4gTHVrYXMNCg==
