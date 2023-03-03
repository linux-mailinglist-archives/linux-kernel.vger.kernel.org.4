Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8E46A9E02
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCCRyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCCRyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:54:04 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60E91027A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:54:03 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 323BDQAZ000991
        for <linux-kernel@vger.kernel.org>; Fri, 3 Mar 2023 09:54:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=9XMp8mVVxccic1Mn3gW+jKHOYupQdwX1SlyI/L/U+jo=;
 b=d0+p+kxrhL7+o5gP6QbXnxU9DFhfEf0d5CzjmqXNl4SpAfx1P4Gv5PsbzgSfo02kby+Q
 8Sl+OtnNCurCW5jq0zqZ8ev6ppW7HzAXET96pDJQcQ8qXJpgydZYrFAihNdEu2LTw2U/
 R2JxomwLLEq6ok8jeePVPeHslW6WfvnNwG4ELIEDuG/QNk2ZEjEgkazhPugd33GmfaMJ
 IhUmOXM0orxnp6IRFBA4Aq9a81+Xg4Pl9440hqTpCJ81niLupNG7FX93Zb9hGGsqxhj5
 7oFviItkMC49abgCUf2kesXC5c6CO4l4nfCQ8QeGAa4k30j/qBF1hhY66lSq+OUiwMZn NQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p3etwjjtr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:54:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnRMqz2F59ZnZXoyJwmsdIb4IMkhh3mF5d79cHWMndJMnUMH/6ZdrsRF2Qu73r5sXyAgMM8WL57h4/YZ8xAJZ55ItuaBwjGOF0MybYNrlv0O72LUyXpR7d3NRtQ4FMyK/UK7oWywZKkrlEA3+8X+5wY/WAVDU3vUUdxfcXIW5Pjj5uQFXsXWeXkX31Ij8/IvHciq9d5G4/hJsyJVt7U+x/WNqaN6Cx8SlRsBefV7iVNbMAWm68IS3z2681bqFtoNk8AbdH64dcvy8e69j+S9aMXLj92r2rqWsaCDyryUqCzlR9nxtHRMt2+DVxhLztH9HL1/xpFYCf5Y1XlfALXpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XMp8mVVxccic1Mn3gW+jKHOYupQdwX1SlyI/L/U+jo=;
 b=fbk83Z2ZnFZ/5uW6GAmiznNNQ0WiknwG0aR92pX/yls8v55uJ2aAgoEJFtjMTkX9DEyDZfeRHESm7ImVof2jKIQKe4L+4LuuzH0Ma5WgKJvAqBtKQ7WJiruxA8szCdrnCx/CE74Z/E9VHpit4jB0cS4S336O4X2Vzhp4RpYFdx9QqsHfS10qc1X4ZJ+PUqgM/E0OHR91e1z4SHX2DbN7PJa2fEpXx6eawDMxtpZwWXMMN3QOfaPh6EvhzUP0gh1G/yOHpeG1hUI+hiKS6BrUPKZQ/Zi2gCf+Se+oGGsDn0gH5jyrqIIKUKm4sR+J1rzThnx8RHAC3reKIylFYoU2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by DM4PR15MB5454.namprd15.prod.outlook.com (2603:10b6:8:bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Fri, 3 Mar
 2023 17:54:00 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::4376:73:fdf9:d34a]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::4376:73:fdf9:d34a%6]) with mapi id 15.20.6156.018; Fri, 3 Mar 2023
 17:54:00 +0000
From:   Nick Terrell <terrelln@meta.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Nick Terrell <terrelln@meta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>
Subject: Re: [GIT PULL] zstd changes for v6.3-rc1
Thread-Topic: [GIT PULL] zstd changes for v6.3-rc1
Thread-Index: AQHZTZizamXiGRhPv0GWaVIL9zubi67pT/wAgAAHCYA=
Date:   Fri, 3 Mar 2023 17:54:00 +0000
Message-ID: <4BA6A759-F69C-406E-9D29-EDCC9B48F798@meta.com>
References: <C8C4DFDA-998F-48AD-93C9-DE16F8080A02@meta.com>
 <CAHk-=wghhViNZCj4ibSr42HjVGdHro_DWW7wCOQ61p2v59cciw@mail.gmail.com>
In-Reply-To: <CAHk-=wghhViNZCj4ibSr42HjVGdHro_DWW7wCOQ61p2v59cciw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3667:EE_|DM4PR15MB5454:EE_
x-ms-office365-filtering-correlation-id: f6f0b8de-1f69-48a9-2d56-08db1c1044af
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2rr04sgfrzxrPDEhuT1jMzHBqprJcd7EDgyP1P4vPE/DfRaOMxXMm5c9kjp43Kw7TRm3NPzYp5Ua3WFXF/x8uIDWOQgcx6omWRgeDX1cG1zexP8E6V2DfKXD7El70lS0NZo9YOh8lCuyhhv3QBXyWNSCkQKl3+/bR+MhcfLjGSveAH10V7ZMcJRAUW1B3EETuAP5lV+ejAp4FtsZrtyRSnPVnXg4mknABZEoKuhA8NPvD3Fgx8JyFCA3U1HrQPTzmEBMvl5mqlo8GyZqLu5WozY5e2VFmbGThZJRx8TNBdY/Ed1+/IPR7x9HbUc9Rb++zDhYW1mwUXlLS41ZM+IEY7wSFSj8POYmElCZuijWvTMrI7CIXjFGF043tkT9ente63tZ9ycRL2F8dCCjLTJVYLy/DQKS7rYUqK3hdX/LQ0r7bCNkUYwuDfCl90Eas8TFeJPHXPGmvnuzI+fZhzp7NiUsqL/2RXdD/fbASgbrrhRD5nl5O27rS4ZH4Aoby9cd/r8JyAiNAzosgC/M1BAqRqG5fAgFLycADUcmFCzTvvqZYjHWdF5cVEMNOBENc5CS99Mkfkd7Cywcz48w1sgIABh1CfT5Cr1J3kdb8YJyredLN+9GmALXymevgTYroUuiDcNeO/NJ6WJYaYm7bZhjafO4ar60/5bOvbss7HuomHpvRnvZ+7hyArxqvF+X+gp34wxa3NK3U6PKZCdUW++X0Sh6BvOWrsnx2WqFL7grHfE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199018)(5660300002)(33656002)(8676002)(36756003)(8936002)(2906002)(4326008)(66946007)(66476007)(76116006)(6916009)(41300700001)(86362001)(66446008)(71200400001)(64756008)(38100700002)(122000001)(38070700005)(316002)(6486002)(966005)(478600001)(54906003)(2616005)(66556008)(53546011)(83380400001)(6512007)(6506007)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3hybW1Ba3ZWUG1CcFE2T3l2MDQ2U1hsYlhqUWZSNXFqYms4am9RU2l5a2tC?=
 =?utf-8?B?K3RYUjBVdGhYNFlpODVSMWdsVTMrRVFtdXZ6Yk9xWVByNy9JWFB0SGtjVjNY?=
 =?utf-8?B?VTNaUkZOazFQQXJPTEhibzVPckl5R0JBVTQrK2Z6NlZnUUMzd2Q1VlB3cXUz?=
 =?utf-8?B?L1RNdEVPT01kY0cvamcvckg5ZzlHKzd2c05nRllPakVQelpDRUJVQ3RCQ3F0?=
 =?utf-8?B?R3BMbnFwVG1hbE9vb29xajBMbXVPc1RBQXdaTi8yekhSOEh2aFhmcjk1Y2h5?=
 =?utf-8?B?cWEyK1NKZUlmbGFUbnBsOFN5eW5YZTN2czByV1lNM09BcTh6aEtVNnVjSWlD?=
 =?utf-8?B?MFF2MXZmVnRrUEpkWGJORlE2RzhZUVVxYlI1WktYdmhXaEVNY1UyM0dNTXVT?=
 =?utf-8?B?Nk8rN281cUNYVFQ3Y2ZGOEQ4aUNtWmd4ekNLalBrR1M0ZnNXd0hDSFlEclVr?=
 =?utf-8?B?dXlqTnk5TTZZT2FFN0p5OC9LeThkTXdhWGhOeW1ERFNLZ1BpNk14bXpWMHZn?=
 =?utf-8?B?b0h3c1pybGQzaE84RlQ1LzF3bTB2QTZxbk51UDFhZjFWQjA3cmcwTWhCUUlr?=
 =?utf-8?B?NWttaFBOLzBaT1VIWkpoTysyMTA4WjZZYmlhMU1SWEk1ZFlQKys0MjZpemRG?=
 =?utf-8?B?UUFZZ2MzaEV0K1VsSVRGYk13TktOYy9IS2RoeUVCdTNWWFdKRHkzYm4wc0pJ?=
 =?utf-8?B?bnUwVjlPanRmc3dNWnVQYm1zQ0t2OHhNRElOWmhEWHpqMUc5RGoyWmh2VFQy?=
 =?utf-8?B?cmhGd3ZBVzJpM0dTTmFGK3BUclYyd3NXYnhLNWpXSnZNQW1vNzVDOHRWR05h?=
 =?utf-8?B?ajBXcXROYzRIVVp3NEI1cVhjQVpHaUExUCtlOVhueUJaZ3ZTaHlWM0ZYWU1t?=
 =?utf-8?B?VlBhWEt4UHg0NFQvbEVoYWduWk9YOENxb3V3SUVLcHpGNDZTM1llK2ZRVGlP?=
 =?utf-8?B?aWViV1pBYkFzcG5jM0x0eWZGUm1WTlo2bFZWU0kxa09zQmV0dUpyMzZvS0I0?=
 =?utf-8?B?dlZISjQ2SEk4N2FqUW4rOTFLSGUrdTZEUXBXM3I2SkYzM0pHNG5VdlNSZjI3?=
 =?utf-8?B?VzFwMFQzSTlGbGlGZzd0RW44dmxBNkEzK3pDZjB0YXlDSWFzaERhVXB2SGpj?=
 =?utf-8?B?SXBtbEhlb0h1VXJ3WkIxNmZzdElkdHhicjJVNWNDRkRmVEtwVE9iQWtsWWh0?=
 =?utf-8?B?T1pWaXk0aHNzTFp4ckpJaWJjNTZJSmhEcElEamlXaUloWmk3V2NTZmhCUHlL?=
 =?utf-8?B?R1dPNElUcE1tS1V0REZiV215a3Rzbkh5Y3Z0azZlS3dZY1RNb1JxNTZiSkRD?=
 =?utf-8?B?dlg2b1I1b2NCa1lQR0dpZ1czeUxSMFhjaUV1a1hmaUZrazZXOXZLNUtDUVcw?=
 =?utf-8?B?L3dVaEc2ai9HVXBLOXcySlByREN2V3Q5NUlWSzNqaXZ6OHJueFZ5eDZleit2?=
 =?utf-8?B?eUJNbGJzMkRBL1dKRlZoWnJ4QlZ2a2RvazB2aEt0UGNIemQrNnhwNG9PdmtI?=
 =?utf-8?B?WmtrVklsd2t2TSt2WGFqQS9SU09qWjA0MWtGUE5YS0V0Y0R6NHcvZ2ZOKzNv?=
 =?utf-8?B?KytMVHdrVU1OZWdnRFhCQVpRZms4SEVSa29XUnl3cWRyQzBkellUOFFldi9i?=
 =?utf-8?B?RG9za1V2empwVmxMdUtQQWE0R3IrNklSNjdmaDFuczJhWGNaSXczQmloZ1lw?=
 =?utf-8?B?RTZjZW1YV1AxM2tIcXc0T21uTW9iS0dzTlFKelNjaWVWdUdTRUkwalVaTHZi?=
 =?utf-8?B?ZWJuakJkWm0xQ1hsRm9qWDh3b3d0dm5STG0rc0ZNSHdBaUxBVmZpSEpxV1Nw?=
 =?utf-8?B?NkRYYjc2NVlnVFhSaDJpc05DZHZYeGRYU2F1TmkvMFVPQ2xuL0I2MDZ0Smd0?=
 =?utf-8?B?MStuOEVNQ2F4dndodkZIeHprV0d2SnA2d3hQcVZ2NzNwajdQSDhZc0FKblJs?=
 =?utf-8?B?QnZtWUdXWmNSL2hUOGtRQ09jcmhyNGJLbEJ1bmdyQk40SzBGSDR1RVZac2pm?=
 =?utf-8?B?Q05zSzVsMFRuYmo4S3VTTVZLUXM1eXV2U2w5R0RyWGczdDNMcE9pRGJKelRD?=
 =?utf-8?B?SWNvZ3VhckhLQkNiVnMybjA4U2NBazg1dk5IUDNROGxUc3NwZ3IrcFc3b1Bj?=
 =?utf-8?B?NGMrZ0VORlVFYUNwR1M3WWhjM3d4Qk9wOUE4ZHdSN2xwenIyMGUvTG5qR0Ru?=
 =?utf-8?Q?GY72saAaU/pJjTDFsHjtu3c=3D?=
Content-ID: <E7F7093BC216E14F9828EB079C137C36@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f0b8de-1f69-48a9-2d56-08db1c1044af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 17:54:00.0286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgcqT0FosCYiERK8CzZ6R+0QKcJQHFyqb2qLdVJHe3TVK/P8pl0aA2oDq+SZ+tPuY3SlK0FFYLMzAEvhfqGEIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5454
X-Proofpoint-ORIG-GUID: Mr7Az1m95vrrd15QqY7QIFeo8-g2T5nS
X-Proofpoint-GUID: Mr7Az1m95vrrd15QqY7QIFeo8-g2T5nS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_03,2023-03-03_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDMsIDIwMjMsIGF0IDk6MjggQU0sIExpbnVzIFRvcnZhbGRzIDx0b3J2YWxk
c0BsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIFRo
aXMgTWVzc2FnZSBJcyBGcm9tIGFuIEV4dGVybmFsIFNlbmRlcg0KPiANCj4gfC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0h
DQo+IA0KPiBPbiBUaHUsIE1hciAyLCAyMDIzIGF0IDEwOjIz4oCvUE0gTmljayBUZXJyZWxsIDx0
ZXJyZWxsbkBtZXRhLmNvbT4gd3JvdGU6DQo+PiANCj4+IFpzdGQgZml4ZXMgZm9yIHY2LjMNCj4g
DQo+IEdyci4NCj4gDQo+IFRoaXMgdHJlZSBoYWQgZml2ZSBjb21taXRzIGluIGl0Lg0KPiANCj4g
T2YgdGhlIGZpdmUsIHR3byB3ZXJlIG1lcmdlcy4NCj4gDQo+IEFuZCBvZiB0aG9zZSB0d28sIEFC
U09MVVRFTFkgTk9ORSBoYWQgYW55IGV4cGxhbmF0aW9uIGZvciB0aGVtIEFUIEFMTC4NCj4gDQo+
IEhvbmVzdGx5LCBJIHB1bGxlZCB0aGlzLCBhbmQgd2FzIHRoZW4gKnNvKiBmZWQgdXAgd2l0aCB0
aGlzIGtpbmQgb2YNCj4gZ2FyYmFnZSB0aGF0IEkganVzdCBkZWNpZGVkIHRoYXQgSSdtIGJldHRl
ciBvZmYgd2l0aG91dCB0aGlzIGFsbC4NCj4gDQo+IFNvIHRoaXMgZ290IGFsbCB1bmRvbmUgYWdh
aW4sIGFuZCBJJ20gbm90IHB1bGxpbmcgdGhpcyBraW5kIG9mIHNoKnQgYWdhaW4uDQo+IA0KPiBJ
J20gKnZlcnkqIGZlZCB1cCB3aXRoIGhhdmluZyB0byB0ZWxsIHBlb3BsZSB0aGUgc2FtZSB0aGlu
ZyBvdmVyIGFuZCBvdmVyIGFnYWluLg0KPiANCj4gSnVzdCBzdG9wIGRvaW5nIG1lcmdlcyBpZiB5
b3UgY2FuJ3QgYmUgYm90aGVyZWQgdG8gZG8gZG8gdGhlbSByaWdodC4NCg0KSeKAmW0gc29ycnks
IEkgdGhvdWdodCB0aGlzIHdhcyBzdGFuZGFyZCBwcmFjdGljZSBmb3IgbWVyZ2luZyBpbiB0aGUg
bWFpbmxpbmUgYnJhbmNoLg0KSeKAmXZlIGJlZW4gZm9sbG93aW5nIHRoaXMgYXJ0aWNsZSBbMF0s
IHdoaWNoIHJlY29tbWVuZGVkIG5vdCByZWJhc2luZyBteSBwdWJsaWMNCnRyZWVzLCBzbyBJIG1l
cmdlZCBpbiB0aGUgbWFpbmxpbmUga2VybmVsIGluc3RlYWQuDQoNCkkgYW0gYSBuZXdlciBtYWlu
dGFpbmVyLCBhbmQgZWl0aGVyIEkgbWlzc2VkIHRoZSBkb2N1bWVudGF0aW9uLCBvciBpdCBzbGlw
cGVkIG15DQptaW5kLiBJIHdpbGwgc2VhcmNoIGZvciBkb2N1bWVudGF0aW9uIGFib3V0IGhvdyB0
byB3cml0ZSBiZXR0ZXIgbWVyZ2UgcmVxdWVzdHMuDQoNCk1lYW53aGlsZSwgd2hhdCBkbyB5b3Ug
d2FudCBtZSB0byBkbyB3aXRoIHRoaXMgdHJlZT8gSWYgdGhlIG1lcmdlcyBhcmUgdW5hY2NlcHRh
YmxlLA0KSSBjYW4gcmViYXNlIHRoZSAzIHBhdGNoZXMgaW4gbXkgdHJlZSBvbnRvIHY2LjIsIGFu
ZCByZS1zZW5kIHRoZSBwdWxsIHJlcXVlc3QuDQoNCkJlc3QsDQpOaWNrIFRlcnJlbGwNCg0KWzBd
IGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy81MTI3MjAvDQoNCg0KPiAgICAgICAgICAgICAgICBM
aW51cw0KDQo=
