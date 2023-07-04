Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BDF746A84
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjGDHXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjGDHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:23:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAF5199;
        Tue,  4 Jul 2023 00:23:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHYGKIc6YYA2XJ8dtR+ONN8IHNZJQRDKQyzixPVx4etS9ZxVLAuneqBLTCq+iq5wqOWFIFAg0LREuzHynWHFQ0iG0HZ4SJjgaB4gOp7Cam1LkhOsIDOQlFPL1HBfY53yb88+eqAl5/xowDsrJ2DSXXp20zPjYjA4xzs6R/lfmltZsgwm6LrzTpW+u9TSsWyU7Tzi8hMO4dszjZwHF8/UqolxPCkX3lMZLsylB0H/XfZ+wxS97hdj3A38PJ9ZZme5f4Mf8W2cI5Ii0y7R9zNUKjc/QN4M3rGa7wYqO900nVPbXkKMSssR4SmwzmmBX7/lSJ1ftYyx6jDTLfqHL1lYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1guMXRw2CyuMEz0QIG18ePlzD7hRyE/eQCphXoQMBrM=;
 b=cCQ1Z5jRVbvnQlSAOkndGOj6nYT9TbO53n7dJ6NFZpxaOwtO0aSFYPlALBhTkttNaVkKQ199pvCwpG2GP3mxozFpV9sJH3hg0VAbc5PWPGyIsRWVxyxAYQ4YPR4rtyc/EYdRZyLZ/69B46sFOTb5uxWSmFXhzo3a37vFmwXhvEZtFtfZNy1Zm0y3Kx4llhKGzYlIEgp+gfuLzPuVp3xbsi95JveY8GSw123mABZ07vN23fEArvtzid9g3tWsnVFuwDkkx3Bj2/4lsPcwlaPx65V5v33wmj7Stp5UDNMjMIvzA9Kz624tOBMrFyhGx3AJGPu7oCSqm9gLYRTW189Zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1guMXRw2CyuMEz0QIG18ePlzD7hRyE/eQCphXoQMBrM=;
 b=P9RYkyrR20kT8zRnaw780hQejEo/i1fUkgznQYYiMW247XszEDvfiJtkWgofA/XD8Lbbejb3ZSn3Uk4axICWauoUKKYUjkX6CaJs5aVG6ZxUSpZ+6faaRLyYijIBN1g5XrhIlGnBd5QHBbl/0l+3+3u9w8qqiCfDg1IBX6E8n2UxfBsaqNkOxjvLjNxdQq0+vg5X8cJO9eitzbJBtxKdF0wSqk5Bo3NLDeHDj6VV7vRYVXRwZlk50Y46yWoPUvTYA8QJBtKUQ69k0Rqexhs8SegGvOLmYyTm2tI5SXeIA9PZrESr/lbvju7TCEXYio/O0k8ZGtSBvhOjwHyrXmPYpg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB6178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 07:23:39 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 07:23:39 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] net: dsa: mv88e632x: Refactor serdes read
Thread-Topic: [PATCH v2 1/3] net: dsa: mv88e632x: Refactor serdes read
Thread-Index: AQHZrkUZZDO1zuqRAkCpTyybF7/pSq+pNFwA
Date:   Tue, 4 Jul 2023 07:23:39 +0000
Message-ID: <a72834b7880df48cb2c58d3d70e61732b2b0c1b8.camel@siemens.com>
References: <20230704065916.132486-1-michael.haener@siemens.com>
         <20230704065916.132486-2-michael.haener@siemens.com>
In-Reply-To: <20230704065916.132486-2-michael.haener@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB6178:EE_
x-ms-office365-filtering-correlation-id: 6b1845fc-21b8-4501-9c36-08db7c5f96a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z6P+T0JrI0kJqDJgMNNh41VJQPQ5h7w+wSut4iN8/YHAnTZUZMiVLDJqEkLs6qcS4ou6VxEhlhUZ5S0e2nyJYX0VCedW0/uHJVmmlod+lCX7bQDCmf61qvx2o7QuAnq/YPZthIVd6VO/L+O8wQmkJdkU25cxWt7cGSXusiU2RCa+QRuogK6Iqi0EpT+Dpd25kw/HSRPytFocW7PYHm1XXsqghB3ckkON9oFY291tMdEa/0tnBqgKcJwJFIpQwBpDkOH2JelMh/82GIygWT9dc/3hj3JBKrwlKRyu0RJstrWDtWk/oefAblkpxOHoOL6HR+mnKXwsl4+zPDKUrkQ4ERm4stfU9Gnd08iUaYQW9zGQwNVbV6VBMDC3ufIQtDO2X3mXNPYxqsjlOypHOBa6BUgObuC/+lHDwxPT/Fa/u+uoLSDDyoybOb7GEX2TWEqL5Zd/Vn7PGDoRds1CE7yl/yVs58jmd4KcpQhgU1mzuoo+jk6lfwHFJpQjyK+Jvh6NrDEOWOYBqZvu99Qx7pGiVhm/kA5ZfRP4ADalrYqOE4XiEPTR6UpwE+kONS01LEkS0jloaRSo8LcMOnND3Rgq77xnxDG/hwoUYKoQze8jWzJqlZHX3DF7oLkfNxjeYEtmbwUn0BdF/tr6xbRLjJrcEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(83380400001)(36756003)(26005)(122000001)(82960400001)(38070700005)(71200400001)(186003)(55236004)(6512007)(6506007)(15974865002)(2616005)(86362001)(38100700002)(6486002)(450100002)(91956017)(8676002)(8936002)(316002)(478600001)(41300700001)(5660300002)(4744005)(2906002)(66476007)(66556008)(64756008)(66946007)(6916009)(66446008)(76116006)(4326008)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFhaMVA2aUpKYTFkdlBSWFhmRnhBSE9hZVZDMHdXektuS2dKN1V6enZnRTlU?=
 =?utf-8?B?QUc3NnB3Y245S0hqVzZidWc1b1FSK2RrRlF3MkpRV2UwUXdDbXlHZ0tPTlNR?=
 =?utf-8?B?bmVqbmM3ckdwcFZQMVdVSCtQOHFnTFlvb20zN3VzaFZFYnJjUTVFMzk5U0tE?=
 =?utf-8?B?ZWVKVVo0eVcySnhsOGNSOHEzeWJuQ0hvd2ZTKytrakhhNDhYZmpVOGZRTVZH?=
 =?utf-8?B?ZTdpV3QyeUJrWk9MZTROclY0ZnR6SXVlaVlIUVdiVVJxWHN6R2ZwUWxNMnFl?=
 =?utf-8?B?czVXdTZEbzdwbGNTb01Jd3duenM1bHQvZTAyQzQ0VFgrSGE1bjNvM3FSS0dp?=
 =?utf-8?B?YnNkMXlFUTJkK1JGM1lGMm1jaU9oeFBodmR6eEQzeFlRZWhlU3dCcTlZZHBj?=
 =?utf-8?B?ZEJablo3SDFrNDN5TlNJMHBDQ1QvVWwyVjFQUlJBYmFUZC9FaUVPRmw3UWpZ?=
 =?utf-8?B?UUFISDZHWGhmdjhsVE41U2F1ejVUM1JYRGtzbGZnODQyelB2QmM0OTA4aDV0?=
 =?utf-8?B?aDNwWngxNjJxUjhFb25VR2tZNS8zSjVKOUxINVNCOTdQYW8yQWtZNUtMQm1G?=
 =?utf-8?B?WlY4cWVLclVLZzg5eWE2WU1FL1liMTdOSDRXQzM1K1Z2YncyOFRid3dTWStM?=
 =?utf-8?B?VW1sdktPRHZDd1lwVWxGWXRwVFF4WngxOTY1d0V0dE90YlpwVVRabTB2Tmxa?=
 =?utf-8?B?Z0FYQlBHOE9KSWtJd0xhTnF3TER0TFY2ZXFvdkQ5WEhWMFhJc084VTBmbTJV?=
 =?utf-8?B?YjEvc0JYTHI0enpqMjViVXUxSW5ibDB0UCtDM3NYbVpsTTF6VTB6RGxsSVhU?=
 =?utf-8?B?TVVRTTBDdURvRmU0emJxczQ4dnVxRG80WnhoUkcvMVFYWkl4UDJDSWRxRnNT?=
 =?utf-8?B?K3BUR0Z6MTJva0tQbE03NEwxUS94N3l4MU9DKzZRSGF1UjVqbHA1Q0xlb1pS?=
 =?utf-8?B?Q2x2a3BFUWdTQWFiaExXTkZDbkx4SmtNUGtNVVZ2ejYzVkc4aXdDaEpnVHhD?=
 =?utf-8?B?WWtYREp3ejBJejZYTkdwNk15cnNwVkFWSFdXTHZMOW9DRHZJcWY2ZzBxMW1q?=
 =?utf-8?B?VnJBbzVOb0hDQUF5WFVtcm51Y2VtZXZ3MXJOSlBTMHpPOWZoVmQ0ZFVWT0Ew?=
 =?utf-8?B?WWRIOVZWUW9TTitVamlVRjMzZFF1ZUdOclRrWkdhRjlocFdEM0ZDNnVnMGZG?=
 =?utf-8?B?YW81a1NVbDFKR2ppNXVCU3dXbGFaMDVGZmJuaDgxZXZvdFVMQlNQalQ4Wjc3?=
 =?utf-8?B?ekN5eVJvTU1nR3NiY1FqMk9haGo0Y2gwd3JxQTZ2elNYVEhGQ28wNUoydUVo?=
 =?utf-8?B?WVlyT25lNytWSnJySGJPN203WGo4VHVMNWRiSEJqQUlKWHlaSUc3bkQvR3Qr?=
 =?utf-8?B?d0N2RVh1b05hK2VjUjBrTlRJU2xHQjcwcXpZWlRwNXc5WTR6SGE2K0pVNkNt?=
 =?utf-8?B?V1JPNlFHcWNNQjhub3B0cDR0eWRSSmY5VTVzc0pDY21waW10RTgvVTRzcUlH?=
 =?utf-8?B?V0tNRGNnOVBSZ3FXRUJxSmFlTDVGWXZOVkZVaHBmSk9pQWR2dkFieU9lMHdY?=
 =?utf-8?B?N0QwOEFyQzN3UkNhNWZxK2RJNzdvK0VUQVZaQTN0OGZDMzJTYkhxT29sU0JO?=
 =?utf-8?B?Wm9uRldYODJCL21NUEdmU2p2NFJSMmpFeDVkYmd1RExKYU9TQlNvT1c1WHhN?=
 =?utf-8?B?L1lNQWJxWGhzcDhPTDRLMnVNV1dISmNPZjYyZWMyQkxWd0YwNUJ5SkNHckpT?=
 =?utf-8?B?ZFE0dy85NzFBVFBXclZkMU9HalhuK2JPdjhjQ2E0VVIrelZ0MTNzYUxoc0lC?=
 =?utf-8?B?S3FzVlVaYWMyVFV2UFYxTEZwT3ZsNnhoYW15ZXhpTjN1cXpxbmpaclNmZzZ2?=
 =?utf-8?B?NXZvdGJGNGpWb1ZkSTBCUVQ5ZWxRKzlMWmc0MVBUS0tSY0JHUkJka3pxZlNt?=
 =?utf-8?B?d3lzZEJlaEpTSjJ2emZYSXBoR2hzUk0zMzA0ZWpsc2ZMdW4yS3BGbmhjNjh6?=
 =?utf-8?B?NUE4Rlg0NCtzTEdZbytTaXI2VWdSaSt3c3dmYjVRM0oyVVc4QlFlNCtsQUww?=
 =?utf-8?B?L09VYmtSSVdZb3huVVl4bVlianNwcVQzeWhvNGNhUFFpTUlSS1RFNFZvbUVn?=
 =?utf-8?B?T2piNW9Cc3dqZGphNlFPOW90SzFwam1tVEFOeUxzb0hKT2NXQUdtVjRTdHgv?=
 =?utf-8?Q?tWZE23LWr7QjpzDGkXZiXxk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C325FD6A1907AD4F9A43918D92D59AD9@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1845fc-21b8-4501-9c36-08db7c5f96a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 07:23:39.3725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVtm03snEaY7H628zN63iparXnoSlsNXyh6SAg701ghWTETGrz3pxTGoRIOc1xOl8FjgXxr8n43V7v9CgYAwbiekhSZ9BbNGuN0wKoirbtc=
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
IGF2b2lkIGNvZGUgZHVwbGljYXRpb24sIHRoZSBzZXJkZXMgcmVhZCBmdW5jdGlvbnMNCj4gaGF2
ZSBiZWVuIGNvbWJpbmVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBIYWVuZXIgPG1p
Y2hhZWwuaGFlbmVyQHNpZW1lbnMuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJk
bGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IMKgZHJpdmVy
cy9uZXQvZHNhL212ODhlNnh4eC9jaGlwLmPCoMKgIHwgMTMgKysrKysrKysrKysrKw0KPiDCoGRy
aXZlcnMvbmV0L2RzYS9tdjg4ZTZ4eHgvY2hpcC5owqDCoCB8wqAgMyArKysNCj4gwqBkcml2ZXJz
L25ldC9kc2EvbXY4OGU2eHh4L3NlcmRlcy5jIHwgMzEgKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLQ0KPiAtLQ0KPiDCoGRyaXZlcnMvbmV0L2RzYS9tdjg4ZTZ4eHgvc2VyZGVzLmggfCAxMyAr
KysrKysrKysrKysrDQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCAxMyBk
ZWxldGlvbnMoLSkNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5z
aWVtZW5zLmNvbQ0K
