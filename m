Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75552634B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiKWADx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiKWADu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:03:50 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD4D22AC;
        Tue, 22 Nov 2022 16:03:49 -0800 (PST)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMNgLQN021966;
        Wed, 23 Nov 2022 00:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=cBkL37Fq7Czcye11XWFiIjz/wQTvPTlqy4G6cF6B5+o=;
 b=S9EGVpcqKCsiB2LuJtZu88JpqBtTJ5Ii3eQYUIKmOcdx2LoyLPc5R7mM6Sy+7lR0iy4q
 cMWLZh2e0Mr2yWrMSo1W93kOS2eABUxixA5HYh4ueKOdBu7j8JeB9PDxVKL0TPJIKOkr
 qbcgenvvyoWjEMazl4HGpzhLKneaz7drFc9XCileE+wooOgb1pVY5aIyrWT6eU0t35q4
 AX7snKV1k2ag1geUYbGVMnkwyyhFKX3ROxOFfsB0t3aQtKFqmK37nU3Jco1bI9GNw4pb
 algvhnJpLmcqRYLjghoq8B3N5wiREHBrFu2gZTmoX7XttTOUfSMh0RFz/KVQvkzcMWGU 4Q== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3m188wg4pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 00:03:38 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id AD74C2FCD3;
        Wed, 23 Nov 2022 00:03:36 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Nov 2022 12:03:30 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 22 Nov 2022 12:03:30 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Nov 2022 12:03:30 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNe+4ffZ6KjhZ3R0nX/CtN84f6QA2ej7bZq5eNyyGbnJ0YT7kYgWjBMSlDdGUR1wFqnANNNgTZMUd2utdmWXsHVmDAbQFuYoYIH8vzb2eGJUQUQt7H0thdk7zk1cYsyb74ktH7Ssrm/HEyUiG5MyE9DxV79p7K/mQu7ZV6RJ5UKQOFxNg5YYMW6GnKkQQzQ7GuYK3Ye1Oj/9KBWm4saVp/Cx6jN/hwewsmGmu+xxKbZNS+NWcDdJT0R5HJqH3MPBdx4GT8IBjWKp13CEaPrl7hT/uAALmPisEnL3/sUX0vXF6NzieuEFWRLnFyKzhObBhbfC+fwVBYxyFnHsqPNzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBkL37Fq7Czcye11XWFiIjz/wQTvPTlqy4G6cF6B5+o=;
 b=lWCxUAJB2EX17xP6pVB6IY6PcGDTgpHqLtF8negBu4vFy/f0fP06briJv56f3eMbSOYhkCy6kj1ek962DrcD/GAx8lLQQW/jt4NK+WbXQgDZc6D/G6hBF9UjWhY7ZhlLFcmwunqKdJppWAGUQhEWO73alzjw6FxnP7uBvEJzNw4zjNLo9foaS8d9wrh77YeZyk/TAUwAElwGiHC6NUDQIkKepD5gWdOePbJfDjnWSm21oXCqlcAc9KkG7v0QtysZVx38o9CwZK6ewwY2JqpIsqo74rmzxj3nzaIZ0L1Q8ELrJL9YXtg8/j+MwG36pzktkwBXDQq9bld1632oQwzQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by SJ0PR84MB1822.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Wed, 23 Nov
 2022 00:03:29 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816%9]) with mapi id 15.20.5834.011; Wed, 23 Nov 2022
 00:03:29 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>
Subject: RE: [PATCH] crypto: amlogic - Save a few bytes of memory
Thread-Topic: [PATCH] crypto: amlogic - Save a few bytes of memory
Thread-Index: AQHY/r1Y6XZq176x5k28ODzKw0ibBa5Lfq0AgAAJmYCAABJxIA==
Date:   Wed, 23 Nov 2022 00:03:28 +0000
Message-ID: <MW5PR84MB1842D71513C7F3B06323BF40AB0C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <c797dc5e9248498918916a6eeedaa25de2196e8c.1669154149.git.christophe.jaillet@wanadoo.fr>
 <CAFBinCAEwYaEvmGjen_LPO52BcyUFD2EKtzzzfZ1rMuVuihEqA@mail.gmail.com>
 <a83e5419-c19f-764f-9860-08385d7dd757@wanadoo.fr>
In-Reply-To: <a83e5419-c19f-764f-9860-08385d7dd757@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|SJ0PR84MB1822:EE_
x-ms-office365-filtering-correlation-id: 8711610f-5df4-4140-1e8e-08dacce626b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wIxzhVLHHSBnXL1RqKVz7iaH1jOMm1Io7oX9ie3z3BXtZuAWfUIus568eOnEqt/KIeCDZInwgOmesnUrYwWe22Z47oQ1Dn9/sqW17Ca4c2H3Od3fViuv6Zo4clGIiPYPx4Oku2w06uSpyNEs/jhETQ+5A+Rcb2Him3Ho79XmhHcAY3o283q3h25ZJ4X4IKVaNhgJVsVwmTyAiL8u/3baNgTtzx3SbtBgEVN/w/JAmSI1ud8nGyYLrZ65hRC2bw0wZIdlZLZpY9sBDkN/43Aalq33ouWUtYr8m2npU1iM6Xx2hSuVhA6PEDBWPbn0SVC5u5IPrM4XAsOD/CRRjZZJ0WPp/IlApysklFykzVm+XLrIUIYXpVheGZVOCEKXeGg/VXjMXO5nt935fpTJ77F89Lf55r4RBfvE3mY6K+SjHNaynPUV51cSRNLPEz9gvHZWxK8J8AwNe+IwQNTsINSQRMPlAxhExc36T1bYCpGzLo4JoaCU7uas0bHrCFjcJWc1MzMVmhaHrLyTzzqkoLGq1s9qVSsQ2i1HIM1LLS+0ZF7zFip8tbcjJK1jsbpgRo0wKP/5RHFvZhIqZfepwqImmWvmrMRW5/oKRMyeTK+eTPqA4ZbT2P8mNI1pvcgnciG0XJPoVgJh34oJW9s5OMDnEao/knB7ccGh1Xwkx/Q1I3xpvwjOLfKm26SGzaHtoKWsQd0L2FZW5u3TW2VSPz2RxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(71200400001)(5660300002)(316002)(478600001)(8676002)(66446008)(66946007)(66476007)(33656002)(4326008)(66556008)(76116006)(64756008)(41300700001)(8936002)(186003)(52536014)(26005)(83380400001)(9686003)(2906002)(54906003)(82960400001)(7696005)(6506007)(53546011)(110136005)(86362001)(38070700005)(55016003)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WksxcExEQytvaHpxQS9VaU5Uclp0dVE4S09HbS9Xc01iSEs5K0tPOFlyYTJP?=
 =?utf-8?B?eEY5VG1Bdm5EbStZWUUzNU1vQzlsdWNOVEVvalAxaFYzeHNNYm1oOHd2Yy9Z?=
 =?utf-8?B?VjFnaXVLcnYwenpIbXVQK2kyK2dtVlpoa0JlaFp2L2RYUEFVemZiVlRxUzJD?=
 =?utf-8?B?bmRoMVNub2V2SlM1UlBRdmlrWlE2aVJOdWhEK21ZOWNpQzJCc2lIa3FMaXlv?=
 =?utf-8?B?Snh5WTlyZC9qcVp5MU1TeHorR05SWUpMUEhEMlZKVHl4K3A3SzJQWFN5K3hn?=
 =?utf-8?B?VUlwaVdZU1BUVm5UeFcrVnFoeXZoK3UzK21RejFLQmw3cE9Qc2JkcloxbUx5?=
 =?utf-8?B?UDlqSGpXZWlweXlNdW9PU05UY3MwemNkK0RRNk1tQlJqUkM5U0Qzd1A2bTF5?=
 =?utf-8?B?cjloR2FOY1VhMy9EUzFmTHdpTjM1WXRGdVRMVDQ1MDViYkluNDlXQ0Zob21l?=
 =?utf-8?B?ZDdPZzF5TFd5dEsrSHFwY2hsOGE3YzBQLzlxa3lSeVMwNHFzU2h3a1dHQU1H?=
 =?utf-8?B?aDI0VUhHN2hOS2NNQ0hUVEZxU3d2UnAvM2VrazZkMG5qeHpYcmR0K1NCOHR4?=
 =?utf-8?B?cEduUUZXVGRyanIwaGVkbyswK1o5SURVOTBzSlZGZ243bEJSaGFBR0szSGpj?=
 =?utf-8?B?YThpcDVodWREZGRCL1RxQ3loZElyd1VyNHNxcHFnaFpyUkhmL25XcXpoL0JR?=
 =?utf-8?B?UVVqTDh0c2hrNkxTQUUzYnRhVGpudm5JWFU2dWMzbDJEQTgxTUk3SEtHWllG?=
 =?utf-8?B?UmJaWC85Nndqb05OSHg0aDJKalFEenQzN3FyZnVodHE0eWU4VENxQ2dRM3RN?=
 =?utf-8?B?UERDWVoxTU5TakZZL21yY1hNV0xMUVVIUHI5cytFRmxRZWxMTWUzbExuUmEz?=
 =?utf-8?B?SmZZZHZKSzdNM04vSm9sdjh3TmRVbUlOTUtDaUsxa0oyVVYvaDN4M3h2K1VE?=
 =?utf-8?B?R1FTZ3Zvb1VUZEFxQ0szbC9tRldra1lGVmZzZHVFN2lVYmxLWWE2TUQ0NSs1?=
 =?utf-8?B?amMzcUw0RDVGdVFvbHRLZ1hPWHlTQmdqa0pTQjZ6eDF3c2pXMnJIMWhOcmxL?=
 =?utf-8?B?dEhjNStFUTZhbGw2S3lZcWErU1hXQm1GYWlUNVlmdTFjOXlXTDNBbVFETGpV?=
 =?utf-8?B?MHBqaVBJVWFXNjhpUDRkUTEzT1pkR29UM2t0Ymt6TVVrUXVJb3V3NDRxUHVO?=
 =?utf-8?B?SUtlQTJmaHluZUhtQUJENmZ3MnV1bUNnWGNhMUs0WnhudWFLa2tPWFBYM0xt?=
 =?utf-8?B?RlBybHVnSWFNMERxWXdiZFNOUnlzUnVOVWhSQ0JtVXZPdURselFNQVdsajR0?=
 =?utf-8?B?cmxJQlRDWDIwcjhhTSs1UHJlL0puWFNpdzk2KzZRbmtYNHBITDVwK2xCZDJB?=
 =?utf-8?B?OUZqd1hmM3MxaFd2V3VPR2VXWmd4WUVuK21JZy9tQ2s0V0xvYWVORVlXWTJz?=
 =?utf-8?B?Z0JNeWIrVEFyNVB1T1dPdnIzN01pbDJnZ2JqTTgyU2kzR1A5OWtTR2YxSFM0?=
 =?utf-8?B?dmFIaGJ4LzNUTkIyYjdySlQ0TmQ2Q2IvR3lyaW0xaSt6ZDI0MFhnb1BMSElV?=
 =?utf-8?B?RytHN1ZPQWJmTzh4OTZJRHZKR1hRWWpBY2dpc2ZjN2E2djdtdUtyMVFUcWgz?=
 =?utf-8?B?SkdjRnFrSDVKRmI4aWF5R3dGVitaL01qNjZidHBpUzdxak1BQWhXd0J2aCtI?=
 =?utf-8?B?RTBBWVZwalliYnhtVWFDUHdFSjhGa3FqUGFSMTFJeFRvNnVETnczVE1hYVUr?=
 =?utf-8?B?c1JsNWlNb1lIaGNTYXVHRkFLMFVKQWlwclFwRWxuQ0xrR3FBeU5ET2F3NHlL?=
 =?utf-8?B?aTZ6dFV4NzFyY0tsZzM4YVhhYmRLMTJqZEhobEZ0SE4rQmV6M0JNRjcrbHVO?=
 =?utf-8?B?UDZ4ZW10THYrZ3Z0QjVMZGhSMjAyRUkxR0M4OVBrYm5kMUh2bHFuRnJ0Lzdm?=
 =?utf-8?B?S3RxL1AwRzN3bnFQNmVCSnh4eFhxaU9wWlR5UmYvWTNkcWpsQXZxS1FsT3RX?=
 =?utf-8?B?NVZnaXY2Q0dxSXpHbkdvTkJ6alF6VXgrQWxYL2JYbWd6cTgvdXR3QmxwbktZ?=
 =?utf-8?B?SEp4bGhkbmxrdzBqTjU3UzcrYW9SVXEyd2ZFSktCZVQyeGVBREdaS3dyYVl5?=
 =?utf-8?Q?Rz4o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8711610f-5df4-4140-1e8e-08dacce626b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 00:03:28.9564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22EVMUw3D5sogbcYya4BE4Ui0Q3akSFGa/QKkrVhYQJx0eVdBno/GuSuLMG9Zp0B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1822
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: PjQTKCmIRGPYAk15l8dDjVErajlEl6i5
X-Proofpoint-ORIG-GUID: PjQTKCmIRGPYAk15l8dDjVErajlEl6i5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=713 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220181
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0b3BoZSBKQUlM
TEVUIDxjaHJpc3RvcGhlLmphaWxsZXRAd2FuYWRvby5mcj4NCj4gU2VudDogVHVlc2RheSwgTm92
ZW1iZXIgMjIsIDIwMjIgNDozNyBQTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjcnlwdG86IGFt
bG9naWMgLSBTYXZlIGEgZmV3IGJ5dGVzIG9mIG1lbW9yeQ0KDQoNCi4uLg0KPiBVbnJlbGF0ZWQs
IGJ1dCBJIHRoaW5rIHRoYXQgbWVzb25faXJxX2hhbmRsZXIoKSBuZWVkcyBhIHNtYWxsIGFqdXN0
ZW1lbnQNCj4gdG8gYXZvaWQgcHJpbnRpbmcgYSBzcHVyaW91cyBtZXNzYWdlIGlmIHJlYWRsKCkg
cmV0dXJucyAwLg0KPiANCj4gTWF5YmUgc29tZXRoaW5nIGxpa2UgdGhhdD86DQo+IA0KPiBAQCAt
MzMsOSArMzMsMTAgQEAgc3RhdGljIGlycXJldHVybl90IG1lc29uX2lycV9oYW5kbGVyKGludCBp
cnEsIHZvaWQNCj4gKmRhdGEpDQo+ICAgCQkJCXdyaXRlbF9yZWxheGVkKDB4RiwgbWMtPmJhc2Ug
KyAoKDB4NCArIGZsb3cpIDw8IDIpKTsNCj4gICAJCQkJbWMtPmNoYW5saXN0W2Zsb3ddLnN0YXR1
cyA9IDE7DQo+ICAgCQkJCWNvbXBsZXRlKCZtYy0+Y2hhbmxpc3RbZmxvd10uY29tcGxldGUpOw0K
PiAtCQkJCXJldHVybiBJUlFfSEFORExFRDsNCj4gKwkJCX0gZWxzZSB7DQo+ICsJCQkJZGV2X2Vy
cihtYy0+ZGV2LCAiJXMgJWQgR290IGlycSBmb3IgZmxvdyAlZCBidXQgY3RybCBpcyBlbXB0eVxu
IiwgX19mdW5jX18sIGlycSwgZmxvdyk7DQo+ICAgCQkJfQ0KPiAtCQkJZGV2X2VycihtYy0+ZGV2
LCAiJXMgJWQgR290IGlycSBmb3IgZmxvdyAlZCBidXQgY3RybCBpcyBlbXB0eVxuIiwgX19mdW5j
X18sIGlycSwgZmxvdyk7DQo+ICsJCQlyZXR1cm4gSVJRX0hBTkRMRUQ7DQo+ICAgCQl9DQo+ICAg
CX0NCg0KWW91IG1pZ2h0IHdhbnQgdG8gcmVjb25zaWRlciBhbGxvd2luZyB0aGlzIGlycSBoYW5k
bGVyIHRvIGRvIGFueSBwcmludHMuDQo4MCBjaGFyYWN0ZXJzIHRha2UgNSBtcyB0byBwcmludCBv
biBhIDExNSBrYnBzIHNlcmlhbCBwb3J0LCB3aGljaCBjYW4NCmxlYWQgdG8gUkNVIHN0YWxscywg
c29mdCBsb2NrdXBzLCBldGMuDQoNCklmIGtlcHQsIGRldl9lcnJfcmF0ZWxpbWl0ZWQgd291bGQg
YmUgYSBsaXR0bGUgc2FmZXIuDQoNCkluIHNvbWUgc3lzdGVtcyAic3B1cmlvdXMgaW50ZXJydXB0
cyIgYXJlIHJvdXRpbmUgYW5kIGFyZSBub3QgcmVhbGx5IGENCnByb2JsZW0gdW5sZXNzIHlvdSBv
dmVycmVhY3QgdG8gdGhlbS4NCg0K
