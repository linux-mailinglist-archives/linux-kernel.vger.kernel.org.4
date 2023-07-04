Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E84746A87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjGDHX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjGDHXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:23:48 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECCB199;
        Tue,  4 Jul 2023 00:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lImoRIJ1zPFwkLl0sRAoKIFrPSKmGNpv9aQg3urVB7yskoq/5wwNyM2WNjxHNKvZutEx1sRAg1g9dg00DkE6M12RV54RwcQx7JR5J2BJGnvUgZ/JU03XEemIZJqkC82F+sVKFxY6Ofw8sQWdrNq+iWY+45y7OSohT3KASEjC9RZhYuX/UVEu1r5Df89EkWei86LiuLyGmVDGq00HAl8M9rIFcm7x9p4525K3Qdg1GDsHXtDjB1r0uFCOdpCPFcFo7A9rBXVdRI0nAQEbc0QxvjUOkvW8Thx17T57LQE18ihl2q8g8ewnudkBoOCzzyzUtvjlywDai40T/9cgqqknEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xv2w8hKIgi8M+pmP/6OU+rKXzp/SVjnZjB07tdocZY=;
 b=RIADuLPKrOV5AXMC6SFTYcsSHA7Xdj6RjzBHaWhmRIIUscVmYDCEh2Nr0XZaDrEusmeuD/LeXFlIud592/uk0axu1uG7Blzr8d4UR7IbPufVrbKMcyYADbFhjVPVoUGY0K4hYWXAELBp3Gh+oaO4Wyt0QxLyIRHieykoZy23MheVkA792IQ2Cjh6P5lDg64yZqMWrmY5cD0niMxyGqXzha425CSYmq8sXg9ysixPaTQG/P2GYLx8YV5ByufXOhEebWU07HSFv+vvUIGDxGngV3vNp8z3tbcBrwuIm6vAjA4TCLHX7gjZRTwndogd8UY4PhRn+ycdnY94bKsBBUJjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xv2w8hKIgi8M+pmP/6OU+rKXzp/SVjnZjB07tdocZY=;
 b=TRNUmZz0MqYRp+fqBP9ag3zbvg+FZP0ytQ0Q0sTpRHkU05vUWG0DpUz5FwOHUMgmBXcIIL3maeZeFYJ6Srslw85eHTGpXTSM0/kbNUnLuggtPeI7wvOLxaiSS8m6DVbs8D4VYQZUHx8LTFbYUox4P056rbqHgK3XdIHS5Nto3Xln++1ty7/azGvuxdWwqcvBX8ybgjr7P730oEkzTRPksC0YcW7sEX1yOaq2l2VJ69cdixtWSrOsXCoUKLV8SY1SxL+bq8AYrjQfkneLenV7INh4n3wcDtyKO3sXHBYbCCIHbZZ0W8DnXEyzaGJ1o0Fw9JoH7k0f2NU9V+scmNzPRA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB6178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 07:23:45 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 07:23:45 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] net: dsa: mv88e632x: Refactor serdes write
Thread-Topic: [PATCH v2 2/3] net: dsa: mv88e632x: Refactor serdes write
Thread-Index: AQHZrkUaOnWb0FbvmEiEMNbBhWDnm6+pNGMA
Date:   Tue, 4 Jul 2023 07:23:45 +0000
Message-ID: <cb6f1e78a36cd1fab6a19866a96121be3dd10c95.camel@siemens.com>
References: <20230704065916.132486-1-michael.haener@siemens.com>
         <20230704065916.132486-3-michael.haener@siemens.com>
In-Reply-To: <20230704065916.132486-3-michael.haener@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB6178:EE_
x-ms-office365-filtering-correlation-id: 84e83f29-4c18-4e46-d0d1-08db7c5f9a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P2n+Qzs5tuINqFEb89b5j+XQ205J6SAaW0S3FX+6U5QumLVQ3OV/1tvqO5fmh3itL3kzaXibYcPNKEjAsXp74Xm4Ae7mEdsmWpvR/0TKx2pII3wQ8yhDvYSWoQ9JBSL1NDdZdMKZLnyGGCxJcKA68nwU6+PVoZFhLUi2opVXVZkKjHagV/3JifGJg5HHaycgkVqEAxmBr8eIdIBAJGHIx7Mco3dy1GVNYU+2yquub4JyEQ69qjNtURTQUJH6XpFcwRIs6G7msT+B7SGXuVec2nhhu1PONApFXy64Vm8pWoGEnl8RdKg6mXVqVlRyLIYdADZUnkV1kKKiDTSPKWK03jVCPGaCWWUZdDwUWrtBfA4ueXlzPQQ1NpMSQINU6MOm2qPXNp2EQTNBJ+hOjLitlzqUbRahK7dgpLEsTqVr8eu3sVHq9vDPm8O0Y5n48Soa3RN6VK+F5njYmBSKoF5aKaSzNGzWUawZ8bVO2lRrQb/3GcIFBlmT+cIbpgMLD74qQUYQyQpbCaD2kICVpHT86uG65dh3v55qp1TpjvsNZSjgxYtAW623BaLyWxBM4ODNBn0WuP5/mTWwoVyLJajLAFIbcRA55GpymAPuv+JgBaQi1nS4ITh3hHvHwjd6hWugkqMsBBbPDFKi+2fwYsQM0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(83380400001)(36756003)(26005)(122000001)(82960400001)(38070700005)(71200400001)(186003)(55236004)(6512007)(6506007)(15974865002)(2616005)(86362001)(38100700002)(6486002)(450100002)(91956017)(8676002)(8936002)(316002)(478600001)(41300700001)(5660300002)(4744005)(2906002)(66476007)(66556008)(64756008)(66946007)(6916009)(66446008)(76116006)(4326008)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlVxRnBSTTRTbWZNWjkrQlJNVFVLVlgzcmhjdUxYZnVQUzhjT2E0bzFaa1Zx?=
 =?utf-8?B?RnRldUJSNFVHSjRIaG9rSVhqRm9RYzNLcFE2TlFPYjR6RHE1QXZ0d3hJVjkw?=
 =?utf-8?B?MDJhSnFCUEdPeG5BSnk0aFJWRjIrRG4rWS95ejlYSnFWNzRRUlhhT2l1ZVU5?=
 =?utf-8?B?Mlc0KzdKWTZ1Sjgva3NKSTJPYWZMS1czZEltR2pRWERPTzRGMTZ0bDdic2JK?=
 =?utf-8?B?ZThMa3lkYUhodGZONzlXaXllVnRRK0dDdXMrcnpGa0poYi84cldGbkdIaE1y?=
 =?utf-8?B?SmZOWlFVYVN3RlhiY01ZRjBxeUZXbjVrUWZvTXdJcGJyOTRQdno4c200WHAz?=
 =?utf-8?B?OFFDOVN0SkJEeVV2UmMrR0V2Ymo0RVgxUVJKbU84b3RiYlRVV1Jnb1BLMThE?=
 =?utf-8?B?OXVwVmpjQlgxdDhiNFpXaEpiWjFKejQwVEh5MDlGSW83ZGMza255c0RLWFZw?=
 =?utf-8?B?T3FCSEU4R0RyK2FDTzBOL1RJQUxBK3NmR3Z0OTFXOHpvc3N0Ty9mRzVVWmJy?=
 =?utf-8?B?aTdRN3YvQ2RJS2pzd1dWSU4vQzZpM3FKQUJZZ0w0Y3NBdm55L1BIbWJoczRa?=
 =?utf-8?B?ZFVoVEdwdThzemUvWG1TSmdtck11RlJUelcvNXBXakFCRUY5UXpNZzZlMXVJ?=
 =?utf-8?B?Njl1S0RQajBjdklIZEtGMlZpYVRqbkw3WVFER0p4dHZPT1VqRjBBeTh4Mjky?=
 =?utf-8?B?WFJoWFRnOWxtaVRHM09JcENBME5LUUJ4Q1NtakdjOHYreVN0R2ZrT0tIZ2xP?=
 =?utf-8?B?VTFlczNmTnY4Tk5LWDE1N2hTVmxtN3lLM0tzWTUxU0FLWjNEelF6SGZ0WVRo?=
 =?utf-8?B?WVJZTjJTOG5kMXJwbTBsbjlRdDU0SmhDSFoyaHRxeXBzSlFmeVEzMGl6ZWpz?=
 =?utf-8?B?TEFCcWFTZDluQWhuNDR3Zy9kWld0QUNtSUsvRGg1N0x2UkNERFdWeTQ5bDlM?=
 =?utf-8?B?dFRVb3d6K3pSZ2s2bTBQTHhHUVBBVi9PSExLVXRvVW5CME5raU5QSWk3OXBH?=
 =?utf-8?B?eFpxVGo1SGp4KzNwdkRTUEQ3M2lGaTZNcTZGUkJPa2VpSXZKVHNBMTVnMkY5?=
 =?utf-8?B?Q1BaWEIvSkJoSkZ6VEhZMlVGMVV2Yks2VlFOSjNyRmd3ODZKZGFjdUtjOXpp?=
 =?utf-8?B?TWIyZm0vNUtNdFplY3lVRjc0RU9CUlJSL2VtNFRLTnlPY0pxUy9ZYjdxOHpx?=
 =?utf-8?B?ekVtYVhMTW81c0twRUY1d2xXcE50dTVFcjFUWmZmRnhBUFlSWVlyM3BQOFhy?=
 =?utf-8?B?ejdpRFBJNmd0N2Z4REhZL2o4YkxqSE9MVnhpQUpXRSsrdE5xcHhKOEQrUlVn?=
 =?utf-8?B?V2FyUVczQUpjYXRiUGZmVk5pa0MxL3k1NXhzL0Z4TTkwSnpXdFo3NXMrOFdC?=
 =?utf-8?B?dEpUaTZwRDBQY3BVVHppdFVLdWk2RE5aSzJqcTJpQTNWTnU5K291QmtYT3RM?=
 =?utf-8?B?aFR1dmJTTmIxRDVNamx3UlVWb1NsQTJYdkV2Z2wzNk4rZXlTbk96QTFZenNz?=
 =?utf-8?B?M0wwc0ZEbVU3cnd0Z0taYURKRnZDc0hpMFo0a0JPL1FRT3dXN2RxaEgrL1Zq?=
 =?utf-8?B?dzNKd3J5aC81RXpoR0pjYkZaVURST0FUQjZmU1pHTEcxZ0NGU2o3TE1EVjJO?=
 =?utf-8?B?QWRuYWJOM0FKZ3JVTEsvT2ZTdW9oM2k3b3huNDRmV1lrQk9oN0Q2dU5mUHJM?=
 =?utf-8?B?cmFVK2RjanYwZVYvK3l5UDB0YWZYTVdjUUoxTlFtUWJhd2NML2NCVkVsL2RM?=
 =?utf-8?B?c201Tk5wemFrSzBNRGlGK1FuQS9FcWk0U2toTnZlZjNCTVVNU0FpbXNnV0N1?=
 =?utf-8?B?SC9TTVU2UUtZNThNclJ6Ni9ncXBEam1BV21tUndKaWw3VXYrcFF5dSs3UGJH?=
 =?utf-8?B?YStCWDNKai9UZVAremd5THo3UlpoMTBRYStvTnEzSjdMMFo1NTBtb1pNTUdy?=
 =?utf-8?B?dGN0SDA0YlZ1NVFodFcrTE5haHlXN2QvMkcxTWNSRm1rb2IzdktyT3VKbGM3?=
 =?utf-8?B?WmdnWXcxM05HZHFTL0pjRVlaY29ha3pHZDlHNWYzTk84SUlLYzlobGZkek15?=
 =?utf-8?B?dzBJSFVaRnQzTXRsbU5rY3IwRjIvZlk5WU5DRk9TM1JSQXRoVTlBdWdpdHZS?=
 =?utf-8?B?Y1BFY0YyaEhzWWpnZGpNVnEvam9Nc1JUREYrMWFrVDd5WUtxT0s2RHBNOWpD?=
 =?utf-8?Q?ZnR9En1Wm7wN6BXQeCmXH40=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <854BAEE250B69648A53CF9922B3470A2@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e83f29-4c18-4e46-d0d1-08db7c5f9a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 07:23:45.5035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cFtEhp54yUvaGjATU5T4dfrhsN5moY2ggOI548Hk1s7JImf2jwRhGEjE3So6IlBUSpxfLWe6ildcz9GGToDBBCRNxJ/Y9uVEJSRtHYIlsi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6178
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTA0IGF0IDA4OjU5ICswMjAwLCBNLiBIYWVuZXIgd3JvdGU6DQo+IEZy
b206IE1pY2hhZWwgSGFlbmVyIDxtaWNoYWVsLmhhZW5lckBzaWVtZW5zLmNvbT4NCj4gDQo+IFRv
IGF2b2lkIGNvZGUgZHVwbGljYXRpb24sIHRoZSBzZXJkZXMgd3JpdGUgZnVuY3Rpb25zDQo+IGhh
dmUgYmVlbiBjb21iaW5lZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSGFlbmVyIDxt
aWNoYWVsLmhhZW5lckBzaWVtZW5zLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVy
ZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiDCoGRyaXZl
cnMvbmV0L2RzYS9tdjg4ZTZ4eHgvY2hpcC5jwqDCoCB8wqAgNCArKysrDQo+IMKgZHJpdmVycy9u
ZXQvZHNhL212ODhlNnh4eC9jaGlwLmjCoMKgIHzCoCAyICsrDQo+IMKgZHJpdmVycy9uZXQvZHNh
L212ODhlNnh4eC9zZXJkZXMuYyB8wqAgNiArKystLS0NCj4gwqBkcml2ZXJzL25ldC9kc2EvbXY4
OGU2eHh4L3NlcmRlcy5oIHwgMTEgKysrKysrKysrKysNCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDIw
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGlu
DQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
