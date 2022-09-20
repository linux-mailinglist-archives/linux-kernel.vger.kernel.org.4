Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C775BDFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiITIVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiITIUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:20:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA30F655F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:18:30 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K8CC4b020824
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=fVh8je+RiUAR/xZhsR389/WO4BGd3b2lJF2hc1JS0nw=;
 b=neaV6WM2IcgiNTR5+ALWDGUscoULmCFSYQSrY4V7B0sciKxzRhqaNmZANzlRujHrw5Sl
 07pbY+Xm5Q0YUPDBSRJjlyLRlXIn7PgrX0h0ChZwatQK1YfuTtW+SGknVgxNupUX1/vR
 dxN2LpQUXly4hA8DM2kKDV1VpTJb9mWQ57hPRgu988b3eMWSybl4NgkdDZRCZXxf42w6
 F7OxhKfGMPBSsyDawjxu7ysfXxR3nsiYDVvTiesHSfBlbnqNch0X6FE49sE3B0yz6pFK
 leUVO/AMU5omYQiIobZoMAp7dPgwC3QE0KfLXQqzIr0mipIjjfxF9zb+K7WlfZTE6jvz aw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jq9sx86qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrZ47U2MAqaVgGZF5qjWiX2SNlZVi7z6tnkKP8r5UKn5vp/IVC5/we/Rxge0dN0lHAUgJ2/bWVwItLDBOEw/6wJRSPLshXQWqghFQMd+wbxIh2jUCP/DaEstV7PQ6gOrrzELuf53/GnoIQ+lHRYNcbH9nvq4R/TIf8ieluPEuDrqGrc1YzoejpihgzBj3DASODPAsnKqpFWXGh5R/9ymhrlpb5TqOzbnwJkSyjCBRZZokRJ2Mkmgh0il+vPSWxmLFKeSlDc6NDFGeBpg31ZFpLvqUKrBxytvok/a9pPo+vsw9THL286sU/4Ex/EZ+hm2lY8h+BrivKZBOJ4vV6+/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVh8je+RiUAR/xZhsR389/WO4BGd3b2lJF2hc1JS0nw=;
 b=j60XjaPoJIspno0n4iU4mfLcCoBQ80g2TjSHuZ5yI6XSyy4eoWdS2Ai2jrF0HNoPIELrFoE/Dq95Epd3oaYcQ2vj0BUAOYRppUjupX0QpPpQUBEOpf7N3GmzPwx7eaZtgZ+zfIgbptVNNL8m8hW7u8nuWFvKzd7iBbxySoxv1zNFmtGA/4fIc8mK6GrJcU8zZ0zgSkHPxr4xc/kMYqIvXkucFmKOGqQHGKw5lYHriez0cZnH9a0EB1jsjf6oOfnb40jrd7e7wCRb7DMIlLGZhVLlmcYJ+M1KdIXVQsnWsWUXfS7xkCP0Ec17KkSfOOIId7zuY6YnKAMdbcuyBPBUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by SJ0PR15MB5246.namprd15.prod.outlook.com (2603:10b6:a03:42a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 20 Sep
 2022 08:18:29 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80%3]) with mapi id 15.20.5632.015; Tue, 20 Sep 2022
 08:18:29 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/siw: Always consume all skbuf data in
 sk_data_ready() upcall.
Thread-Topic: [PATCH] RDMA/siw: Always consume all skbuf data in
 sk_data_ready() upcall.
Thread-Index: AQHYyE20FuBbRmFqyUikdkCCcT2gYq3oAPMQ
Date:   Tue, 20 Sep 2022 08:18:29 +0000
Message-ID: <SA0PR15MB39192B3D3A84BE3154B20124994C9@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20220914152108.253128-1-bmt@zurich.ibm.com>
In-Reply-To: <20220914152108.253128-1-bmt@zurich.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|SJ0PR15MB5246:EE_
x-ms-office365-filtering-correlation-id: e824d19a-1f52-4d53-7d8d-08da9ae0b2eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5LNNyevUfg3lo/hbIKF/U0Z1KgwUZMd8qytRa3wSZZ+lSy2v1E7oN7Jc03lE9Ok9KjWiBufKyVcrzrLptdNsRJc3AogDI51biIVQyACA1nPX69x5ujRsv2879zeotChVALj8QXrBJgIdsQXc6n0HFHE5E+GVV1tChw/sqoaejhMakPekNSa27agH2KEZ5DcVrukOHtnTNVWhCMdukhtnAMtvayElbw1Diq4fgXdT5uvoPQQeLP9eMZhV6Y5FdY2xHkFN9PltE4k7SR3DKnYBEVQ0yup1sixzA4fYW7vJfOUdNw3lteGZVdnzKWyS3xJQTMypV0NPyNxsuZG+xW1VtasLIGPq4AJH2zi6C0zAmb+Og9L41e6eI2OL50nG23Tuubej03mhaBU9zFbXpVxQKhYVzEWn5MNjC4nAMY+m0gYlLNlFCozEorzhlobfSUkGlscDu8fS4UpR0hKd96Y4+whulUzLTD7CRZbdsfG9T74+OsKTqnRo5ASfWidf+fUz/quY01uCijnMkR/v95/tXcREcUwOzLP0aSbPCojBUoH3y25XwKPCINrQyWpXL0lgifx2MBV0w03ukj050K5D3hP9p0rvXFwv+4oqfzs/QttYwH/DbRZdS9S4Kj72KTQBU+xavL9WxUGD+gWI/tpONXYBXgv8yYtmcZIMUxnQ/qahU6vZDWdlEBlA+BuDPZ0IFAOsQrGzJVZsI+frS5oDDjJMtXnTpzmKHFaKNrD6ohlFngQM8hc0HkxaOBopBPoB5VaH3tIJNtLufaZNSLH8JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199015)(9686003)(478600001)(64756008)(66446008)(8676002)(55016003)(316002)(6916009)(122000001)(83380400001)(186003)(7696005)(38070700005)(6506007)(66476007)(2906002)(5660300002)(52536014)(66556008)(53546011)(66946007)(38100700002)(8936002)(86362001)(33656002)(41300700001)(71200400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmJSeEtBRFpRaXR2SFEwVHBxellaejFxTHkxT2Y5aHNSL0dYdFJTVVBnM1JW?=
 =?utf-8?B?cTFQU1FqSkFwREtTRVdra2RYZ2orSFhrSHFmdlNUYkVYT1ZoN1o5QlhRbEJS?=
 =?utf-8?B?Z3oySjVWTkNkdXE4WGZFSm9VSVF6WU5MWCtjWVJGaUFZRmo0TUxRT0VzMG9o?=
 =?utf-8?B?NWNoY0kxMTJtaHFRVllXU1lHRkQ0QTdkblBoVFR1V1I1UHdlZlNzVzVIK2lN?=
 =?utf-8?B?RE0wM0RWVzlZNUUxbjJqQ0t0MTJ3R01lQXZ0OTIwTzY5NU4vbFF2UmZsNWds?=
 =?utf-8?B?d1E4L2tidHF0alBaLytZckJZRnpKb1J0ZmJrc1BRK3U5dGQ3c0d5bVk2VmNN?=
 =?utf-8?B?Q0gxRnFpZkpWL3NUMllNK0N0bkpqeUVkdmdyYnIyWjVCQmxJQ2h1Z0tpSWNR?=
 =?utf-8?B?NWVHZkhCY1kwZ0d4dFBZbzc0ZVRsZUNUdTVJZExKTy9CWFI5TEsyY2Exa1B4?=
 =?utf-8?B?N2pTUEQ3QWRQR1NDK1orQnVaY2dCRTlMWjFTTWlwYmR2cTJFTkFndk45eGEw?=
 =?utf-8?B?SjBNc1pldFRJTS9SNDlEZHY5MG1OT0Npc21ndWl4dEQ3TktkTHR4NUF1YndM?=
 =?utf-8?B?ZHcxaUxlVkRrOERKN1NBSkkyMlNwV2J3SVdRM05vOUREVDV0NTcwOXhybmVu?=
 =?utf-8?B?RHRDdzZ4MnRRQ2ZYb1NTSkNZbjBsaEdPTlJuWks4Z3NXL0ZCVjVmVG1wVldS?=
 =?utf-8?B?TVQwOHlDV1EzVG41MTBnV2krdVFSTFh2YjhnQ0R2ck85bmRQaHpNZVQ5TXF3?=
 =?utf-8?B?eGFsWHQ4eVI3cW9pVEJhdjY5aGtCMmVKaHhuNkdsczlyb0c0VTJqS3JaY3Ux?=
 =?utf-8?B?VzlQdFUzWVNmaHFNblB6OGxScmxzeDEzd3cyT2xHMEp2TGhFMDdZYzZVRVRi?=
 =?utf-8?B?aWV5N2MxMUVKUXJhY1lERWxXL1EyVGFwclc2TFhkNHJyRUltVm9NQTJteERv?=
 =?utf-8?B?V014akQreEhGOUxkUHk3MUxNZ1ZRZ2JBSDBzUXNNZlRjKzUySGZPaGcvMG5j?=
 =?utf-8?B?cWxoUE1jRExYajQybFpGY3UzcVZzL01VRTBSRkJWTEhIMDFGQXQvbGUrbXdO?=
 =?utf-8?B?UWgycEEzcDVyVjdzcGJzYUZMYm1XQWt6eG4wb09EUkM0RkJQNmZIUG5nQU9J?=
 =?utf-8?B?TitTNFZEZUdsclRud3JQQTczNDM5U01uUjlLOFZqa1ZUREdtRStsc0NIRnFp?=
 =?utf-8?B?bmsxT2NWdzBidVpDQXVpM0s3eURoMmlwSkcrZTM0b0ZQQUhuV25oRHBzN1pW?=
 =?utf-8?B?anM5SlVHOHc5UlIxM3RBV0p0ZlNqK1NmN2Jkc1lrV3BsL3MxOS84RHYxUk1C?=
 =?utf-8?B?Ym5yekNxcGpFS2I1SnU2UktwUGw0cUpleGZLajl1T0pYMWsvQTVOSUxjTFRS?=
 =?utf-8?B?dk8vdjZ5ZDJTZmhzdlNhWFpuVGhSZDllSi9ZRndHWFVRL1poRE5wS2w4bSt4?=
 =?utf-8?B?S3NBWDJsVGVpVkUvb2w0dGtwWDhyemhabERZWEJMdC9na2ppMG9JWjdzSkMy?=
 =?utf-8?B?bThKbGYzQnJ6Ym1FMTF6ckNvMHRyeDJGcktDLzZHR2ZVdC9xa052SUh0MkVG?=
 =?utf-8?B?T1BtSC8vNENpQUVvMjE1cWlUNzZ3WEtaZWZld2I4WUJhd2tUSnplVi9jeUlY?=
 =?utf-8?B?T1k5bkdjTTRmajJDQlpDRFJWbTBsUFVjeWphd1BUMDBYYU5BZGsxQUR1dDNn?=
 =?utf-8?B?MTNJV1k0TVBlSTBFMk9VS1hmMlpkZG5RZjczTUVWeTlWYlp3VlVrSFVjaTJ0?=
 =?utf-8?B?QmpHZFZ5cDRYeWJvTjJnRmdaTFdkaFU1Y25wZThvNUMwR2xhZGlkVEliL3BV?=
 =?utf-8?B?Qkg0ZjVvV1pKYk14MVhiVzBKdW9keExKeFE2VVV3S3VUazBOaU5qOHdvV2Uv?=
 =?utf-8?B?MGY0V1FTUXVWLy9QZXVjckZFRDkxcDNGajdYeXJRa3M4UEpoQlh5MmtaejYr?=
 =?utf-8?B?alc5VDNyWTMrc0NSZStZQ1lnYjZONFNWaGpMRHlZeUZ5M3p6L3M1dlFrSTlW?=
 =?utf-8?B?amRMbHdSanM3RW1Ob2JVLy9rMUt1TFhISFJ1OXFBUHhJeVVTYy9iM2Q2VGdu?=
 =?utf-8?B?WmVRZ2NiWWpWQkJiZ3g0RlVnc1FFNWJIYkpVYlE2cDZMKzlPNVFWdlZMd1RL?=
 =?utf-8?B?RldReEw2Q3dXT01jdlRjTXB5cDBmbmNTVDJxYUhybUtvd01EMS9VeTF4UHlp?=
 =?utf-8?Q?AlQS7AtLX3pfFu+lDZ/F3fQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e824d19a-1f52-4d53-7d8d-08da9ae0b2eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 08:18:29.1007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ubtM6giHJvrvU7A2coHfB+x4e1Mjr067ZznmWF+0coxuF6KO2+3M9Oaxt/l8whRP80x3poKvRSkgFFpK54GH2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5246
X-Proofpoint-ORIG-GUID: vv2FbS7h3VfXCWARgU9e7km09iBYYeyM
X-Proofpoint-GUID: vv2FbS7h3VfXCWARgU9e7km09iBYYeyM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c29ycnksIHBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaCB0byBAbGludXgta2VybmVsLiBJdCB3YXMg
aW50ZW5kZWQNCmZvciBAbGludXgtcmRtYSBtYWlsaW5nIGxpc3QuIEknbGwgcmVzZW5kIHRoZXJl
Lg0KDQpTb3JyeSBhZ2FpbiwNCkJlcm5hcmQuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQmVybmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgMTQgU2VwdGVtYmVyIDIwMjIgMTc6MjENCj4gVG86IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGpnZ0BudmlkaWEuY29tOyBsZW9ucm9AbnZpZGlhLmNvbTsg
QmVybmFyZCBNZXR6bGVyDQo+IDxCTVRAenVyaWNoLmlibS5jb20+OyBPbGdhIEtvcm5pZXZza2Fp
YSA8a29sZ2FAbmV0YXBwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBSRE1BL3NpdzogQWx3YXlz
IGNvbnN1bWUgYWxsIHNrYnVmIGRhdGEgaW4NCj4gc2tfZGF0YV9yZWFkeSgpIHVwY2FsbC4NCj4g
DQo+IEZvciBoZWFkZXIgYW5kIHRyYWlsZXIvcGFkZGluZyBwcm9jZXNzaW5nLCBzaXcgZGlkIG5v
dCBjb25zdW1lIG5ldw0KPiBza2IgZGF0YSB1bnRpbCBtaW5pbXVtIGFtb3VudCBwcmVzZW50IHRv
IGZpbGwgY3VycmVudCBoZWFkZXIgb3IgdHJhaWxlcg0KPiBzdHJ1Y3R1cmUsIGluY2x1ZGluZyBw
b3RlbnRpYWwgcGF5bG9hZCBwYWRkaW5nLiBOb3QgY29uc3VtaW5nIGFueQ0KPiBkYXRhIGR1cmlu
ZyB1cGNhbGwgbWF5IGNhdXNlIGEgcmVjZWl2ZSBzdGFsbCwgc2luY2UgdGNwX3JlYWRfc29jaygp
DQo+IGlzIG5vdCB1cGNhbGxpbmcgYWdhaW4gaWYgbm8gbmV3IGRhdGEgYXJyaXZlLg0KPiBBIE5G
U29SRE1BIGNsaWVudCBnb3Qgc3R1Y2sgYXQgUkRNQSBXcml0ZSByZWNlcHRpb24gb2YgdW5hbGln
bmVkDQo+IHBheWxvYWQsIGlmIHRoZSBjdXJyZW50IHNrYiBkaWQgY29udGFpbiBvbmx5IHRoZSBl
eHBlY3RlZCAzIHBhZGRpbmcNCj4gYnl0ZXMsIGJ1dCBub3QgdGhlIDQgYnl0ZXMgQ1JDIHRyYWls
ZXIuIEV4cGVjdGluZyA0IG1vcmUgYnl0ZXMgYWxyZWFkeQ0KPiBhcnJpdmVkIGluIGFub3RoZXIg
c2tiLCBhbmQgbm90IGNvbnN1bWluZyB0aG9zZSAzIGJ5dGVzIGluIHRoZSBjdXJyZW50DQo+IHVw
Y2FsbCBsZWZ0IHRoZSBXcml0ZSBpbmNvbXBsZXRlLCB3YWl0aW5nIGZvciB0aGUgQ1JDIGZvcmV2
ZXIuDQo+IA0KPiBGaXhlczogOGI2YTM2MWI4YzQ4ICgicmRtYS9zaXc6IHJlY2VpdmUgcGF0aCIp
DQo+IA0KPiBSZXBvcnRlZC1ieTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+
DQo+IFRlc3RlZC1ieTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IEJlcm5hcmQgTWV0emxlciA8Ym10QHp1cmljaC5pYm0uY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3J4LmMgfCAyNyArKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAx
MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cv
c2l3L3Npd19xcF9yeC5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfcngu
Yw0KPiBpbmRleCA4NzVlYTZmMWIwNGEuLmZkNzIxY2MxOTY4MiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfcnguYw0KPiArKysgYi9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvc2l3L3Npd19xcF9yeC5jDQo+IEBAIC05NjEsMjcgKzk2MSwyOCBAQCBpbnQgc2l3
X3Byb2NfdGVybWluYXRlKHN0cnVjdCBzaXdfcXAgKnFwKQ0KPiAgc3RhdGljIGludCBzaXdfZ2V0
X3RyYWlsZXIoc3RydWN0IHNpd19xcCAqcXAsIHN0cnVjdCBzaXdfcnhfc3RyZWFtDQo+ICpzcngp
DQo+ICB7DQo+ICAJc3RydWN0IHNrX2J1ZmYgKnNrYiA9IHNyeC0+c2tiOw0KPiArCWludCBhdmFp
bCA9IG1pbihzcngtPnNrYl9uZXcsIHNyeC0+ZnBkdV9wYXJ0X3JlbSk7DQo+ICAJdTggKnRidWYg
PSAodTggKikmc3J4LT50cmFpbGVyLmNyYyAtIHNyeC0+cGFkOw0KPiAgCV9fd3N1bSBjcmNfaW4s
IGNyY19vd24gPSAwOw0KPiANCj4gIAlzaXdfZGJnX3FwKHFwLCAiZXhwZWN0ZWQgJWQsIGF2YWls
YWJsZSAlZCwgcGFkICV1XG4iLA0KPiAgCQkgICBzcngtPmZwZHVfcGFydF9yZW0sIHNyeC0+c2ti
X25ldywgc3J4LT5wYWQpOw0KPiANCj4gLQlpZiAoc3J4LT5za2JfbmV3IDwgc3J4LT5mcGR1X3Bh
cnRfcmVtKQ0KPiAtCQlyZXR1cm4gLUVBR0FJTjsNCj4gLQ0KPiAtCXNrYl9jb3B5X2JpdHMoc2ti
LCBzcngtPnNrYl9vZmZzZXQsIHRidWYsIHNyeC0+ZnBkdV9wYXJ0X3JlbSk7DQo+ICsJc2tiX2Nv
cHlfYml0cyhza2IsIHNyeC0+c2tiX29mZnNldCwgdGJ1ZiwgYXZhaWwpOw0KPiANCj4gLQlpZiAo
c3J4LT5tcGFfY3JjX2hkICYmIHNyeC0+cGFkKQ0KPiAtCQljcnlwdG9fc2hhc2hfdXBkYXRlKHNy
eC0+bXBhX2NyY19oZCwgdGJ1Ziwgc3J4LT5wYWQpOw0KPiArCXNyeC0+c2tiX25ldyAtPSBhdmFp
bDsNCj4gKwlzcngtPnNrYl9vZmZzZXQgKz0gYXZhaWw7DQo+ICsJc3J4LT5za2JfY29waWVkICs9
IGF2YWlsOw0KPiArCXNyeC0+ZnBkdV9wYXJ0X3JlbSAtPSBhdmFpbDsNCj4gDQo+IC0Jc3J4LT5z
a2JfbmV3IC09IHNyeC0+ZnBkdV9wYXJ0X3JlbTsNCj4gLQlzcngtPnNrYl9vZmZzZXQgKz0gc3J4
LT5mcGR1X3BhcnRfcmVtOw0KPiAtCXNyeC0+c2tiX2NvcGllZCArPSBzcngtPmZwZHVfcGFydF9y
ZW07DQo+ICsJaWYgKHNyeC0+ZnBkdV9wYXJ0X3JlbSkNCj4gKwkJcmV0dXJuIC1FQUdBSU47DQo+
IA0KPiAgCWlmICghc3J4LT5tcGFfY3JjX2hkKQ0KPiAgCQlyZXR1cm4gMDsNCj4gDQo+ICsJaWYg
KHNyeC0+cGFkKQ0KPiArCQljcnlwdG9fc2hhc2hfdXBkYXRlKHNyeC0+bXBhX2NyY19oZCwgdGJ1
Ziwgc3J4LT5wYWQpOw0KPiAgCS8qDQo+ICAJICogQ1JDMzIgaXMgY29tcHV0ZWQsIHRyYW5zbWl0
dGVkIGFuZCByZWNlaXZlZCBkaXJlY3RseSBpbiBOQk8sDQo+ICAJICogc28gdGhlcmUncyBuZXZl
ciBhIHJlYXNvbiB0byBjb252ZXJ0IGJ5dGUgb3JkZXIuDQo+IEBAIC0xMDgzLDEwICsxMDg0LDkg
QEAgc3RhdGljIGludCBzaXdfZ2V0X2hkcihzdHJ1Y3Qgc2l3X3J4X3N0cmVhbSAqc3J4KQ0KPiAg
CSAqIGNvbXBsZXRlbHkgcmVjZWl2ZWQuDQo+ICAJICovDQo+ICAJaWYgKGl3YXJwX3BrdGluZm9b
b3Bjb2RlXS5oZHJfbGVuID4gc2l6ZW9mKHN0cnVjdA0KPiBpd2FycF9jdHJsX3RhZ2dlZCkpIHsN
Cj4gLQkJYnl0ZXMgPSBpd2FycF9wa3RpbmZvW29wY29kZV0uaGRyX2xlbiAtIE1JTl9ERFBfSERS
Ow0KPiArCQlpbnQgaGRybGVuID0gaXdhcnBfcGt0aW5mb1tvcGNvZGVdLmhkcl9sZW47DQo+IA0K
PiAtCQlpZiAoc3J4LT5za2JfbmV3IDwgYnl0ZXMpDQo+IC0JCQlyZXR1cm4gLUVBR0FJTjsNCj4g
KwkJYnl0ZXMgPSBtaW5fdChpbnQsIGhkcmxlbiAtIE1JTl9ERFBfSERSLCBzcngtPnNrYl9uZXcp
Ow0KPiANCj4gIAkJc2tiX2NvcHlfYml0cyhza2IsIHNyeC0+c2tiX29mZnNldCwNCj4gIAkJCSAg
ICAgIChjaGFyICopY19oZHIgKyBzcngtPmZwZHVfcGFydF9yY3ZkLCBieXRlcyk7DQo+IEBAIC0x
MDk2LDYgKzEwOTYsOSBAQCBzdGF0aWMgaW50IHNpd19nZXRfaGRyKHN0cnVjdCBzaXdfcnhfc3Ry
ZWFtICpzcngpDQo+ICAJCXNyeC0+c2tiX25ldyAtPSBieXRlczsNCj4gIAkJc3J4LT5za2Jfb2Zm
c2V0ICs9IGJ5dGVzOw0KPiAgCQlzcngtPnNrYl9jb3BpZWQgKz0gYnl0ZXM7DQo+ICsNCj4gKwkJ
aWYgKHNyeC0+ZnBkdV9wYXJ0X3JjdmQgPCBoZHJsZW4pDQo+ICsJCQlyZXR1cm4gLUVBR0FJTjsN
Cj4gIAl9DQo+IA0KPiAgCS8qDQo+IC0tDQo+IDIuMzIuMA0KDQo=
