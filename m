Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0317D6050F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiJSUDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJSUDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:03:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AFF157F71
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:02:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JIOUbV012333;
        Wed, 19 Oct 2022 20:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oE4mMek9HR8oSZMChJDIVlAnWFXiZhRgynkEpxh44eE=;
 b=fIR/w1OA9X/wjlbL3YIxfFW3/buiF/p76zCLmGoC4jbHS7iyloySVWZTow2AqG0+cti4
 knA7vn4xyPCD/OmQMgKsCNPIqqZhwOXD9mqQd/PsBlSNaSh5tJs8hGRMEetnhIQD60ek
 J513EijYIV7i7yl9v197Q1iP1YLHln+eLmQhl/yZJlUz7rF9c4WL+RKu7h48USckbyVf
 QcLbqwBuOPFw1Mn+faKGDqYMc1NWSTJYEGD6UU6oFOMqkOj8dUjarGGTVgbYur9tmRo4
 IDrCHvrLZx2C12uoHYWWdhuZK4CZhEa9HP6eH0IZ0GNuf6FRlSsbNAZ1FGgLPydYy+Nh ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7spj6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 20:02:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JHo50R016515;
        Wed, 19 Oct 2022 20:02:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hrc4xva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 20:02:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUQM4Qaj0pFe/QZUqHxcfiFBJWa4SNHxQCR0ZLsgjfeZ+kZ+Y5wK/9rRKxTBEcaoddUmzHwzYQ7QKjCNJi3oKjBy5gVA2yLWSdZWW6dC8PVjegvQx3dIqcZ8tCfKmqQeOSZA8GvkELnpC93l+bA2bZKeVWszyos24JbjXVY1SWnDb9DaX7CutR0SR+5r1kySZSaJ8uYy9d5X9zrdvaIvQlUXdnCMj8xXp2gLa5jleCpLEKgnCfNFkobY72fn/FK6c9dWUgrYtSX4x927kSOo2PhytrUdVzZUTgNohVXiMtmT2lEVf9+lcJ7LTGwSOc3K88bftJNOghnlSgkFbrtuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE4mMek9HR8oSZMChJDIVlAnWFXiZhRgynkEpxh44eE=;
 b=AtLYxzAJO9QBSrkQr5fmuTF1UJitodJ+M9AUsT4NLAyYcLPLY28I4ZNUZtJklbiox5l0RXwoFKxnV6VapYJKdYme+xBjuAUBEe9/QeDIoOyMqtnZOehOcUBn4NrgR0cmiT6ZE7cfMlx67pRfoHUchDGX3CEMQZ9VnyziFIYn8UInkcdku30p4s/ueonwMMyJQrIMPp2NKn3Vly6EehpreXBlwkvkw6AxL3EgUcdOi/397HIjIJ2bhs6IgpavHHYw7zGAGTgyL0m8lJ5vZdeiU3Ql+/nphnPrlPLDLi01cGEm2KUwLvc3MvfLdRqIyvuYFtEIdKOz5u1Nued1zRv0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE4mMek9HR8oSZMChJDIVlAnWFXiZhRgynkEpxh44eE=;
 b=yxrqf0zI4G4yjhmKkG8Hd28bjriawlkwgQJxyGZI0wx6EgDQmCXPShmVDXRqdsqkKpW1nxahzL4wLvEifFFU4w5F4y/vQQ4uWWlSKYLHok8N1RRH3eFAmGFTmqEtvHU8K219qv0tAs/FJZUqN49Xb9thyi+FXFzjpBAjbN6Gp7s=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by IA1PR10MB6051.namprd10.prod.outlook.com (2603:10b6:208:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 20:02:36 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::b281:7552:94f5:4606%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 20:02:36 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v2] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Thread-Topic: [PATCH v2] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Thread-Index: AQHY4mDwWLEpoK21xU2/k+8Paef3ha4TCOCAgAAMkoCAAK+5gIAAx/YAgADp5oCAAK+sgA==
Date:   Wed, 19 Oct 2022 20:02:36 +0000
Message-ID: <860872bd-127f-36ee-f803-6553a6f03826@oracle.com>
References: <20221017194447.2579441-1-jane.chu@oracle.com>
 <Y026l2PZgvt+G6p0@smile.fi.intel.com>
 <71c9bce7-cd93-eb2f-5b69-de1a9ffe48b5@oracle.com> <Y05Yi7xJ3E8EjnTj@alley>
 <288a7aba-c647-b51f-bdb3-99a62449dbb3@oracle.com> <Y0/EfVB7fRFXrz2c@alley>
In-Reply-To: <Y0/EfVB7fRFXrz2c@alley>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4429:EE_|IA1PR10MB6051:EE_
x-ms-office365-filtering-correlation-id: 49801715-819c-4a39-69c3-08dab20cde0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vZv7y1FR8d7Nb+dI9Rrlb0NzW52oYGc3f74yKWpuGV3plIpX9K0gG6EaU2+AMMj5sMwULCoTatdKWl0esFbsGf8rs0JLR+tt2W23+WqK0K52pID5+AjuWFr2VEWmoQmI/bsqb9PAK+mkHI7vUQnrMB7tvvnJ8y3IpKJ3/HTC5KMVrTdDjj6h53p1fYrObk4kdiA7QSTp6y+jDOE6ZEg1sX/GFQdkKcee9LrRjZD06Mlo3wxBz+VWtQNHizxMpnkzoMmN9OoYxtsrEfrP6oPVuSS66gkDKHuant3sTE8RVHH9qLPSUYwLw2XijGLv6tI3MXPdQjVq7sM9VjFML4vceXFIMTVPL5sh0o4OPBaNBdNxGiqkND901q1OEVV2fFjeP5E85CIKyxXbnpph9xqgLrIUtCHgjQ4kYOrCXZ5GHkl3v/6xTWlGRcgwZx2f62Be1v6xYzrwx4HvTtzUQwuaOFmR1F0O645iQG7KGS4CgbVikxpXcsNOHyeSTZ+M7zWsumlZVa2pLPjHNW4vYC3NXwWQiICdBt0pSkS0M9vQLath20EhrKuSRE/vBEpl/v8WUaXuLV/1P8gzUomir3Sb7U58mbnzs1of6hOevlQsaHYZMFVE1AQqTxllk1tLmFeCf64sIcjOvjwx8CMD/7+DsWMw71YU2qEhXePRuxHMgAkZwj+yFzoqEEu1k1HDRB8QXOGJc0BkUCcpeWEcwAY653Y+uJAkS8q3Rk6o9Frq0Npm+rNeG46xayYIh+gy1fgoO3GFEAnon1ucX7fRoO24XkuGOLEhml2dNkxzipLuJ6zmFEUI4aETcDWeewU8+JQj+liUlk3ySalZMlHVD/8VbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(26005)(31686004)(6512007)(38070700005)(71200400001)(83380400001)(8936002)(86362001)(66476007)(76116006)(186003)(66556008)(107886003)(66446008)(54906003)(64756008)(66946007)(5660300002)(8676002)(4326008)(31696002)(122000001)(6506007)(2906002)(38100700002)(44832011)(2616005)(478600001)(316002)(6916009)(41300700001)(6486002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUJlcE51bFpRYnQwRE5Lanc0S2pzaHpkSWdpdGd5OVB5ZnZ0QVZyUUllZWxx?=
 =?utf-8?B?blRrWVJZcTRPZ1NYc2NkU0xvZ21tSVBjd3RUZ0t5RWtLZWg0ZHZ5T0xCSVNu?=
 =?utf-8?B?UGF2dnozOExoN2w1cGl0bytGNXMyZ0d5ZHdUZytiWDczQnlxcXN3SGRYamRX?=
 =?utf-8?B?anNBTHhkNW51NDNOYkRRZVlGMWUrcEZvQ1MvdTQyNklOZ1hVamIwdmErUUM4?=
 =?utf-8?B?dmVxSW1FcXJlRzgwRWJpWnRaT2hGbmVpeTNnWnBYUEZGV0xDL3hEUkNYZnhO?=
 =?utf-8?B?eUJCdU5MM0tkcFQvam1UMmg2eE5mSHhaeWJzcmh5Tlp6Z3Y2MVJhMW4veEhQ?=
 =?utf-8?B?UFZLZzF3ZFJUbnZmelVaK1ZsSTFjSFhOZzZQb0lRcTVKVThZV3A0M0xOZUFa?=
 =?utf-8?B?WWptTEduWTN0cy9aMEpvTmVRbkt2YTZYMGQwZmVKMXJkeFFPRVZadFZxZThq?=
 =?utf-8?B?ZHVtWVJWaThjZ1pjSEVhSVdaeFpzRE4xb1o3akhSL1RsNnc0K1kwdzhyTXlJ?=
 =?utf-8?B?dy9TVXN4STl2WUt6NXRrZDNRd1VWT2E2V0QzUUhCcEJuWkNuejRJZkVJVXFP?=
 =?utf-8?B?TVVmUWNvTDVtN29La1B1UWhPRHB0NVNUQnkrTGRnanhnUXRiYS8yS3FWVVJG?=
 =?utf-8?B?MHNWM01lajVjY3hmUjJzNkZsR2pJU2dQK1FNV1ozdmZwRGVaYXRINnZGMHBI?=
 =?utf-8?B?bVpLekJCUEJ5Zm1PaUN3RFcvWHRJaC9MbldZWnY1UTRXZWh4NnJ2aXBjZWFS?=
 =?utf-8?B?ZGtCdkNYV2EweTl4cUlMNXBpOWF2cWIrNk5WSEFCbkduYmZkT1lqYVkvUU03?=
 =?utf-8?B?clUza0syVkVDNlJlVkRDdFVqMEdpR0IxU1FicE5EUEJuTHZqOHRsam92M2t6?=
 =?utf-8?B?UW9vbXM3SFIxQWh1T2dsd05zVTZBdlkrSVlUSWVlZ1p6MnMwemdTU21LRjJy?=
 =?utf-8?B?TG13aEx2SmgvOGdxMUpvOG5XQkxlVDNTWnROeUYveDQ1M1M3SUowZzV4dlY5?=
 =?utf-8?B?emU5ZyttaFJFVUVYemZsbk5sLzdkLzM0Y2hKdTF2aW1jT0VmSFIvZzhTMC9z?=
 =?utf-8?B?RlFmLzFiMThnRWs4MWkyemJFZXFmOCsrTnVxbEU0dlVGMXFZUTVDTlZzZ1A3?=
 =?utf-8?B?dFNrL3dyK0FYajZ1TDhUWHJJUkxJTUViOFhyeEJpUzhaelF3U2k1VzFBc1NO?=
 =?utf-8?B?N2cxVnprTnl5RkVvbnVrNEQvdWF2aUdURENsNEZkbGJXUlhuam1vaGp2aFZ1?=
 =?utf-8?B?clZaTFZjSHVSdHl5YTBiTjNEbms4Tzh6RDJ5cy8wWFNtZGZxOXpnZXp5ditZ?=
 =?utf-8?B?d1FCc0tPekpESk5ydnBVNk92dnIyRXVtR0NWS2k4NnAzTUw5N0d1dmZhODcx?=
 =?utf-8?B?dnZ2cjBoUm5mV0w0UjJkZ3Boa2I4MjZzYTRaazM0eDltK2w4bFpKYm9VYm10?=
 =?utf-8?B?OTl5M3NFdE9WZmcwRVBKdFBTUVRVM3dKdXYrZ0paeUpCSUtHSlVpUXpmWTFG?=
 =?utf-8?B?VGVUNW5LQmNvMWVnSzhXOElkKzJyNXFhVlBJbnl1VHV5SHFvTDQ1QmJTbFlD?=
 =?utf-8?B?Y3hhUW83RFNoWVY4ZkF1c1Q0QnlNbjRkUlFDTDM5TnNTM29jY0NkTTRPU0Mz?=
 =?utf-8?B?WVB2YzVjWlpDQjMyeXJKeXNCemw3S05KWVRFL0RyZGN5a25Pc2F2Qzl3Nnli?=
 =?utf-8?B?cGhEWDZsdWVRMCtyVTBsc1d2anZrZHpYSmorZ2kyN3JhWG93SVZwMVhvdk9l?=
 =?utf-8?B?MUo3bjkxRUY4czhLOWpXemdhV2VSMmRHQllXYlhhMWNvY2UvQmo3SzA4bUY1?=
 =?utf-8?B?VXdIZDVqaXNBcmNIcjdGTnVnSk5IaXN6UVFMeDFsVWVBQ2lMU29tOWUwdFJv?=
 =?utf-8?B?MlN0NHAwb2ZBQ3pMVzNSUkFoK3Y0R2h2WnZtTlpTZnJwRWNETThHOTZrOEZp?=
 =?utf-8?B?TzNuYjN3NTRWaVVjQTg3WEhKSFFKb1JCUnJzVlV3TzNuT3JKQ1phVmhmeERB?=
 =?utf-8?B?QXg0dW9CTmxDOGZmbWxWUkVEa3QydDM5Q2J4VnJuQkRWZjNWOTlVdklibzVr?=
 =?utf-8?B?VWtKYnQ3djREWDNpNlZYeVJuSUh6MURYamlMY0MxZTRQbnd2WTlYZFVPVTV1?=
 =?utf-8?Q?VEUA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2E787DBC2179D4EB4AB9E1B5C636688@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49801715-819c-4a39-69c3-08dab20cde0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 20:02:36.0559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdkB+X+u5CFk2W7s9wmnjBtshO11JpxocZBTl7HQRRlBmj5hdtmo+abF3XrJkKNBI7AGwbjwd+b06DXLMAPPFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_12,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210190112
X-Proofpoint-GUID: 7NJbOLATilifFuRCnb9DmSO5-Nde6dPz
X-Proofpoint-ORIG-GUID: 7NJbOLATilifFuRCnb9DmSO5-Nde6dPz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBldHIsDQoNClNvcnJ5LCBJIGRpZG4ndCBjYXRjaCB0aGlzIGVtYWlsIHByaW9yIHRvIHNl
bmRpbmcgb3V0IHYzLg0KDQpbLi5dDQo+Pg0KPj4gWWVzLCBrZXJuX2FkZHJfdmFsaWQoKSBpcyB1
c2VkIGJ5IHJlYWRfa2NvcmUoKSB3aGljaCBpcyBhcmNoaXRlY3R1cmFsbHkNCj4+IGluZGVwZW5k
ZW50IGFuZCBhcHBsaWVzIGV2ZXJ5d2hlcmUsIHNvIGRvZXMgdGhhdCBpbXBseSB0aGF0IGl0IGlz
DQo+PiBkZWZpbmVkIGluIGFsbCBhcmNoaXRlY3R1cmVzPw0KPiANCj4gSXQgaXMgbW9yZSBjb21w
bGljYXRlZC4gZnMvcHJvYy9rY29yZS5jIGlzIGJ1aWx0IHdoZW4NCj4gQ09ORklHX1BST0NfS0NP
UkUgaXMgc2V0LiBJdCBpcyBkZWZpbmVkIGluIGZzL3Byb2MvS2NvbmZpZyBhczoNCj4gDQo+IGNv
bmZpZyBQUk9DX0tDT1JFDQo+IAlib29sICIvcHJvYy9rY29yZSBzdXBwb3J0IiBpZiAhQVJNDQo+
IAlkZXBlbmRzIG9uIFBST0NfRlMgJiYgTU1VDQo+IA0KPiBTbywgaXQgaXMgbm90IGJ1aWx0IG9u
IEFSTS4NCg0KSW5kZWVkLCBpdCdzIGRlZmluZWQgb24gQVJNIHRob3VnaC4NCg0KPiANCj4gTW9y
ZSBpbXBvcnRhbnRseSwga2Vybl9hZGRyX3ZhbGlkKCkgc2VlbXMgdG8gYmUgaW1wbGVtZW50ZWQg
b25seSBmb3IgeDg2XzY0Lg0KPiBJdCBpcyBhbHdheXMgdHJ1ZSAoMSkgb24gYWxsIG90aGVyIGFy
Y2hpdGVjdHVyZXMsIHNlZQ0KPiANCj4gJD4gZ2l0IGdyZXAga2Vybl9hZGRyX3ZhbGlkDQo+IGFy
Y2gvYWxwaGEvaW5jbHVkZS9hc20vcGd0YWJsZS5oOiNkZWZpbmUga2Vybl9hZGRyX3ZhbGlkKGFk
ZHIpICAoMSkNCj4gYXJjaC9hcmMvaW5jbHVkZS9hc20vcGd0YWJsZS1iaXRzLWFyY3YyLmg6I2Rl
ZmluZSBrZXJuX2FkZHJfdmFsaWQoYWRkcikgKDEpDQo+IGFyY2gvYXJtL2luY2x1ZGUvYXNtL3Bn
dGFibGUtbm9tbXUuaDojZGVmaW5lIGtlcm5fYWRkcl92YWxpZChhZGRyKSAgICAgICgxKQ0KPiBh
cmNoL2FybS9pbmNsdWRlL2FzbS9wZ3RhYmxlLmg6I2RlZmluZSBrZXJuX2FkZHJfdmFsaWQoYWRk
cikgICAgKDEpDQo+IFsuLi5dDQo+IA0KPiBXYWl0LCBpdCBpcyBhY3R1YWxseSBhbHdheXMgZmFs
c2UgKDApIG9uIHg4NiB3aGVuIFNQQVJTRU1FTSBpcyB1c2VkLA0KPiBzZWUgYXJjaC94ODYvaW5j
bHVkZS9hc20vcGd0YWJsZV8zMi5oOg0KPiANCj4gI2lmZGVmIENPTkZJR19GTEFUTUVNDQo+ICNk
ZWZpbmUga2Vybl9hZGRyX3ZhbGlkKGFkZHIpCSgxKQ0KPiAjZWxzZQ0KPiAjZGVmaW5lIGtlcm5f
YWRkcl92YWxpZChrYWRkcikJKDApDQo+ICNlbmRpZg0KPiANCg0KVGhhbmtzIGZvciBwb2ludGlu
ZyB0aGlzIG91dC4gIExldCBtZSBkbyBzb21lIGRpZ2dpbmcgLi4uDQoNCj4gDQo+PiBJIGd1ZXNz
IHRoZSBlYXJseSBib290IHNjZW5hcmlvIGlzIGRpZmZlcmVudCBpbiB0aGF0LCBwb3RlbnRpYWxs
eSB1bmtpbmQNCj4+IHVzZXJzIGFyZW4ndCBpbnZvbHZlZCwgaGVuY2UgYSBicm9rZW4ga2VybmVs
IGlzIGJyb2tlbiBhbmQgbmVlZCBhIGZpeC4NCj4gDQo+IFRoZSBpbXBvcnRhbnQgdGhpbmcgaXMg
dGhhdCBrZXJuX2FkZHJfdmFsaWQoKSBtdXN0IHJldHVybiB2YWxpZA0KPiByZXN1bHRzIGV2ZW4g
ZHVyaW5nIGVhcmx5IGJvb3QuIE90aGVyd2lzZSwgdnNwcmludGYoKSB3b3VsZCBub3Qgd29yaw0K
PiBkdXJpbmcgdGhlIGVhcmx5IGJvb3Qgd2hpY2ggaXMgbm90IGV4cGVjdGVkLg0KDQpZZXMsIGFn
cmVlZC4NCg0KPiANCj4+IFRoZSBzY2VuYXJpbyBjb25jZXJuZWQgaGVyZSBpcyB3aXRoIHVzZXJz
IGNvdWxkIHBvdGVudGlhbGx5IGV4cGxvaXQgYQ0KPj4ga2VybmVsIGlzc3VlIHdpdGggRE9TIGF0
dGFjay4gIFRoZW4gd2UgaGF2ZSB0aGUgc2NlbmFyaW8gdGhhdCB0aGUga2VybmVsDQo+PiBidWcg
aXRzZWxmIGlzIGNvbmZpbmVkLCBpbiB0aGF0LCBoYWQgdGhlIHN5c2ZzIG5vdCBiZWVuIGFjY2Vz
c2VkLCB0aGUNCj4+IE9PQiBwb2ludGVyIHdvbid0IGJlIHByb2R1Y2VkLiAgU28gaW4gdGhpcyBj
YXNlLCAiKGVmYXVsdCkiIGlzIGEgbG90DQo+PiBtb3JlIGRlc2lyYWJsZSB0aGFuIHBhbmljLg0K
PiANCj4gUGxlYXNlLCBwcm92aWRlIG1vcmUgZGV0YWlscyBhYm91dCB0aGUgYnVnIHdoZW4gaW52
YWxpZCBwb2ludGVyIHdhcw0KPiBwYXNzZWQuIEFzIEFuZHkgd3JvdGUsIGV2ZW4gaWYgd2UgY2F0
Y2ggdGhlIGJhZCBwb2ludGVyIGluIHZzcHJpbnRmKCksDQo+IHRoZSBrZXJuZWwgd291bGQgbW9z
dCBsaWtlbHkga2VybmVsIGNyYXNoIGFueXdheS4NCg0KSG9wZWZ1bGx5IHRoZSBjb21tZW50IGlu
IHYzIGNsYXJpZmllcyB0aGUgYnVnLCBwbGVhc2UgbGV0IG1lIGtub3cuDQoNCnRoYW5rcyENCi1q
YW5lDQoNCg0KPiANCj4gQmVzdCBSZWdhcmRzLA0KPiBQZXRyDQoNCg==
