Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEE2651B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiLTG7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiLTG7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:59:00 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF593165B3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:58:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOA2tsWU7Zyf0RumOatDSGJ8/hIsM1Xz60Ny+RgbmAl+CF0oH5EXR8mdfd2Nrc6vO/LqKqFLL0iYOkZpZ5gGJb7PEEsC5tfMzZztuoSwmVD2vprd1GhNC+PXySvifcwcZ1MSHZQHIk2FNaVqEaSEPrgg9DtlFedIJcWHOYwopRqXxAST2r4tmb9jDkGQa+33BLVqceqK+KWrD6jQefSKF2OqDzwiGwHGkC1Vi008i0+6TeSBmsc3ECQkFpoFCuE96ftoiNhVrJUIyFFSyhWOoqxjuWTVWCR7/YZ76wGwKb/qXCFyK1014ozcQGphQdF0UlCwSxuXAh80fjvEPqJiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wigAv22UkD7o9SHFjgyQJ85B8KS7t+BzRueUtPWGjU=;
 b=OelgUU33vQ4IPjD4namYVJh7MhfWmupKmkG53FiWMuy8woSfXnEx4pqPmoaxDtfyNP47ykgI3NYehU2+G95677onHskND1F5xqDIeMyafZ912BzGByk5B5gEUsVLYfwuB+KQhhuvSQ7al8ICOOtXZSt7JMZd4RogOLVZp2EU8hWzps6QtL6YOc4xAKqRBI0EDl9GmBk8AS29efUHmabkzMlSP1EkclmkaS6Yqs1feOkYJK3SIzJLNe/7/kHVGuI3ntkaiSHci4eGGTzgZAcwiF7twr/u4stP9T/AOKSMgDCnVJXnvaYEhkI7TVgVpBtu6OnNDTLGi3CrMh7swUkl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wigAv22UkD7o9SHFjgyQJ85B8KS7t+BzRueUtPWGjU=;
 b=RRWsd6JfAykFsU4JLv2zTcQR5jvQoWu57IbZ/ALOmnbw4YJKHuY/YdzZSrV/wvZDpBAoid7vU+cktJsXUYtsNTRIDzeNbqLbqBYVtX8TvFai0a4rk62Ebm15EB0NvAlvA2lmdHKx13d1oKXaREz/z83TGlupFDqW1hxLmnldGgEkGAvUCJ5OoU48842mB9jhhgGACl2E1OwmWbBYC6o4o06fxCY69kqFfSYaI31IJmfywtzJkF1i6DgIvDEA1iXZMd7rjwj7ws/9dMI47EBalBXQiNTgB+AYhDi4nbsSfWCVjacvKiWwIhvGVjHGy5+KdgKO20N1yfrfH46R+2lmrg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB6666.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 06:58:41 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6180:97c1:d0ad:56a9]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6180:97c1:d0ad:56a9%2]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 06:58:41 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "manfred@colorfullife.com" <manfred@colorfullife.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "1vier1@web.de" <1vier1@web.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH 3/3] kernel/irq/manage.c: disable_irq() might sleep.
Thread-Topic: [PATCH 3/3] kernel/irq/manage.c: disable_irq() might sleep.
Thread-Index: AQHZEV/GZzBrhyYxKkmDnOs4JW58Ta52XjsA
Date:   Tue, 20 Dec 2022 06:58:41 +0000
Message-ID: <ca1972cec9724189b5a97a09069f3ee4f8c3f97c.camel@siemens.com>
References: <20221216150155.200389-1-manfred@colorfullife.com>
         <20221216150441.200533-1-manfred@colorfullife.com>
         <20221216150441.200533-3-manfred@colorfullife.com>
In-Reply-To: <20221216150441.200533-3-manfred@colorfullife.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB6666:EE_
x-ms-office365-filtering-correlation-id: f039a4d8-690a-49aa-4bd9-08dae257a0a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zmpPve5LnujYwi4ydbLqhXShoAtp/sQKzMenZ5pBOG0EH5aknlMXSVaiV+Xw3u4CXyMmtv01GA59fLe2P8DLtglp9/vR+JYWViZg5oe9gXVZFhS2BjAlwO6Wn7ilymbdUm6XKQO/uVD6ThaYtALL2l4bjdyK8RJS/XLNS5Tyfn9fUJdaPMt6qs03pJ0ebg3GFWFbQIEoh/QkjjhLYvOEP6pwXOVt6r8hGnXwYvNPo2S+ZdbxcmpZnmGkid3GqjundMq7RIeOGf39awV/M7myKpN1lAZx3dmhRZT4hJeS9M1A+/IXeIIVyKjGL5XuQgcafG5FvDIm3CuDwUpEN2UW+XDo4sx9guF1h/Ve+F/cGBGQuTlGWK1WMc/G3zXMrs/Cbq3j8QGeJ4dSw0Xm6q66gnu35FFazjSV+7GZkgTTUZ20Xn5hVZBTM5UgRiJjoO17MVLBKZZyehEb6gCUjQ3HZYT/E/V0WtA6nNDgr9WTr/MyPZspnBqVzikwbGdAo8iGwFA0WqwAhj4hhG4z3LoyMYyo/y1bgg8CXeisd/knr2xSeCjmMjNKLYqXD04RanY9gCsIlAIHfKwumB1QUK0WZeuqtALptGZTnOy+KlIVicVEYKdeLcE4X2EZuYCCa2X+t4zifTPRhy0Og2EMDhyrTojAVqIhgJjxoDOE5lOTLEj4/Mb5+C2cq+rQgnQEIkW0yYTxCOLC+f0wwwuSlsQEOm1WP10uDl5D+1A2baGHbdivDmKBEKSxcqyNpBysNw5E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199015)(83380400001)(2616005)(82960400001)(86362001)(15974865002)(122000001)(38100700002)(36756003)(38070700005)(316002)(8936002)(54906003)(110136005)(4001150100001)(64756008)(66476007)(66446008)(2906002)(76116006)(66556008)(66946007)(5660300002)(8676002)(4326008)(91956017)(26005)(6512007)(41300700001)(186003)(55236004)(71200400001)(6486002)(6506007)(478600001)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkZ6bkFlN2ZKaHZFYXhwMG5zVkFPVktWRFZweWc5RVRTVVpPZDR4d3pEckdU?=
 =?utf-8?B?ZWhNNjc2T0hWNzdDaWcveVFIMUpqWmVQbFlTOWh2UnJ2bElXMzVoMms5WWxF?=
 =?utf-8?B?Q0N5dFkxVHVKTUFpVDMyYmFDaVhHL1g3emR3TnJOdFhlRjJSQmR2d29DYitv?=
 =?utf-8?B?MjdZdmNySUxqTVV5RklJR3V1UHJTTnBEN2l4bHJlb2ZDL3NZc2ZURVFxUkZr?=
 =?utf-8?B?Z0RNWE1BTGRCUU96QXAzRVR5WkhOb2p3YUlTdGptY1JtSU1HSlNiR3VMVTdL?=
 =?utf-8?B?YjVUV1JvbWdja05hdDJKb1NlaFhZOTBHdWtKN0RpZTFxM1NWNWptM3BpdkRk?=
 =?utf-8?B?R0I5UjJ5MlNyaThzR1lDTTJlN3FQejNhOXVrdHBzS0VPa1JyVVpmZlZpTU5s?=
 =?utf-8?B?TFVEcmJLS2RMYndCNkJ5L2FZaUtMakoxM0RTblByNDBFdU52SnQ1UUI3RUp1?=
 =?utf-8?B?cnZvUUN1NksvVVVlc3dXMWQzYTFGa3BxWWw2dVpYZkNKTTlFUDk2RWdJaHAw?=
 =?utf-8?B?NlRQVTVkOWNpaWJkUnZQWE5vRUg2ZmFGblFqblRRQ1VCalVMaFNPb2xrVThR?=
 =?utf-8?B?MUdrWm45Ty9rYlVpUTNkK0lYNUorN2NuVlNVMStRd1ZId2F1SW5NSHZvYit5?=
 =?utf-8?B?L3owZFk5bVBWa1VlYklYZnpwcUFJdHR6WDFER1pIeVNRTHdiT0EyY3dSbWF6?=
 =?utf-8?B?Y0hyZDZqQVU1S090V1Z3Vm5vVTkwRUZVcCtid3JoSDE3QmZkVnJ6R0d0aWpV?=
 =?utf-8?B?bDJpd0pOdXNCelZ6Z0dSZFdIM3QwMnFuZmZCMUFnbDB1SXFEQ2pLQkdEWjlr?=
 =?utf-8?B?MisyemNkdXdpZHZsV3lwYURRWDA4VmozbUZORHZpUmNSY0ZVYTgxVjVhZ3l1?=
 =?utf-8?B?VzBPNzlDQ2pkd2lqUmVqRG5Ndy9reThLc0dUOHVNa25CSVFYUlYvekZXTlpX?=
 =?utf-8?B?aW5zSzRNWU9YbURDVFBRN2ZVNlYveC9laDBCY1IxVXh4Sk84OWh2VmZYYnEx?=
 =?utf-8?B?K2krWlRETmlOUFFleFZ2Y3VYa3FvRUVSOWdFa2Y1WDJkRzlQSUhpT0kyNkxw?=
 =?utf-8?B?eVV5SkpsZGt1VHFqQnhEQmtoZUthN0dpRUw0UUlGVWxyU3Z3UVlDM2RlRElx?=
 =?utf-8?B?WTV6VVhEL1ZpMUdCY1NMOXVodXgzQzBxeEJVUXd3OXYySDdXSDdvNHhWOHR6?=
 =?utf-8?B?aC84QVkrbitYamNzVUlYOUYzamJjZmtIOUlKUXdUYiszZU40ZlQ5WlZEY0o3?=
 =?utf-8?B?azJpMDVlRys4UEs1NHlkb0V2L3g4TW8xbVFUYzRnT01QaG02MkJobUxObC81?=
 =?utf-8?B?RGx5eXNIWm1TL0Z3YU5uOHc5MmJxQVM1K1RtdzNMWjFFcm1ybmxSZjNiL1Qy?=
 =?utf-8?B?NlkzYVllN0pHMnh3M3hZTitIWWpZSTErSVV1bjVxalE5SHArbjJucFlFemZz?=
 =?utf-8?B?MlNkbUo1QVpQV3hqeWhmRWh1ZlNGUDlWRGVuVlhLUEZLTGF6QUhxVDJ2dURv?=
 =?utf-8?B?aW1OVFBEYUYyRWl0bDlRZm4relcxaW5RT3RHSmFvVUlYd2VSS2d3OXY4N213?=
 =?utf-8?B?emdOTlZXby9LNmZrUzRaVGhXQ3FKM3ZjTjJscWRHeUFzaHRaVWZNZHFLenh2?=
 =?utf-8?B?bk1KeUF5SU5EdlFVVHhHN3VxVURGcUFBNXQzSUlia2JqUVhMSk5SbUpySCt2?=
 =?utf-8?B?ckFvR1hIWEREQmZFRzlsSG8xVzZyeFZJOERZM3l1QlJ2bVdmYUp2dzJabWQv?=
 =?utf-8?B?dTZ3NGZvck5BMkMrU09Kb3owTTVDLzVCZXB2cUtGYUYxL2E1S3hrM25RM0Rr?=
 =?utf-8?B?eUg4OXQxbVI1clczNzJXa3JHMmw4Snh4bThQSmFCZjVOSHNUelJ5M3VUbko4?=
 =?utf-8?B?SHFqVDVvcTAyUkpyWHpSRHNrSDYwOVF3by9abUtPdjFJRWdqVXFLK1ZSbkl4?=
 =?utf-8?B?RWpWaDVuOVhhR1B0TjI1aTdmckUxYjVsWVpJaWtyZG5ZcHpTeWFZc3ZhU3k1?=
 =?utf-8?B?WlV2STNFTElCaGFJL29MYU1WSVBCWVZ2aDRobUc5TkwvOVhtVFhoQm11OTN2?=
 =?utf-8?B?ZmNJMFdCWDZWby9QYW5ibDRLUXMrbTZTYTBxVFdRNTdpSVRUcEFkRktmeXdQ?=
 =?utf-8?B?cWxseFR4OHRLcHFSNFFlVm1WNWV6cy9XMTgxUVJTZndrS0hPc1J3S2tNVDZ6?=
 =?utf-8?Q?kDmL4+SxRrfDJy9d4r/dZQw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8026F587E075864A992343F7E937A396@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f039a4d8-690a-49aa-4bd9-08dae257a0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 06:58:41.1057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DxBDtL2qffXKizXlwkfaBP1yLrgZNhDZGwSn73+40IhOgLULhRjgv7s6zcihj0MJySth0gAzJ2Hkx5SZxnwVFCIrQmHqU17oYLQbB7ejlHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6666
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFuZnJlZCENCg0KT24gRnJpLCAyMDIyLTEyLTE2IGF0IDE2OjA0ICswMTAwLCBNYW5mcmVk
IFNwcmF1bCB3cm90ZToNCj4gV2l0aCB0aGUgaW50cm9kdWN0aW9uIG9mIHRocmVhZGVkIGludGVy
cnVwdCBoYW5kbGVycywgaXQgaXMgdmlydHVhbGx5DQo+IG5ldmVyIHNhZmUgdG8gY2FsbCBkaXNh
YmxlX2lycSgpIGZyb20gbm9uLXByZW1wdGlibGUgY29udGV4dC4NCj4gDQo+IFRodXM6IFVwZGF0
ZSB0aGUgZG9jdW1lbnRhdGlvbiwgYWRkIGEgbWlnaHRfc2xlZXAoKSB0byBjYXRjaCBhbnkNCj4g
b2ZmZW5kZXJzLg0KPiANCj4gRml4ZXM6IDNhYTU1MWM5YjRjNCAoImdlbmlycTogYWRkIHRocmVh
ZGVkIGludGVycnVwdCBoYW5kbGVyDQo+IHN1cHBvcnQiKQ0KPiANCj4gU2lnbmVkLW9mZi1ieTog
TWFuZnJlZCBTcHJhdWwgPG1hbmZyZWRAY29sb3JmdWxsaWZlLmNvbT4NCj4gQ2M6IFRob21hcyBH
bGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiBDYzogIlN2ZXJkbGluLCBBbGV4YW5kZXIi
IDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+IC0tLQ0KPiDCoGtlcm5lbC9pcnEv
bWFuYWdlLmMgfCA1ICsrKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9pcnEvbWFuYWdlLmMgYi9r
ZXJuZWwvaXJxL21hbmFnZS5jDQo+IGluZGV4IDViN2NmMjhkZjI5MC4uOGNlNzU0OTVlMDRmIDEw
MDY0NA0KPiAtLS0gYS9rZXJuZWwvaXJxL21hbmFnZS5jDQo+ICsrKyBiL2tlcm5lbC9pcnEvbWFu
YWdlLmMNCj4gQEAgLTcyMywxMCArNzIzLDEzIEBAIEVYUE9SVF9TWU1CT0woZGlzYWJsZV9pcnFf
bm9zeW5jKTsNCj4gwqAgKsKgwqDCoMKgwqB0byBjb21wbGV0ZSBiZWZvcmUgcmV0dXJuaW5nLiBJ
ZiB5b3UgdXNlIHRoaXMgZnVuY3Rpb24gd2hpbGUNCj4gwqAgKsKgwqDCoMKgwqBob2xkaW5nIGEg
cmVzb3VyY2UgdGhlIElSUSBoYW5kbGVyIG1heSBuZWVkIHlvdSB3aWxsDQo+IGRlYWRsb2NrLg0K
PiDCoCAqDQo+IC0gKsKgwqDCoMKgwqBUaGlzIGZ1bmN0aW9uIG1heSBiZSBjYWxsZWQgLSB3aXRo
IGNhcmUgLSBmcm9tIElSUSBjb250ZXh0Lg0KPiArICrCoMKgwqDCoMKgQ2FuIG9ubHkgYmUgY2Fs
bGVkIGZyb20gcHJlZW1wdGlibGUgY29kZSBhcyBpdCBtaWdodCBzbGVlcA0KPiB3aGVuDQo+ICsg
KsKgwqDCoMKgwqBhbiBpbnRlcnJ1cHQgdGhyZWFkIGlzIGFzc29jaWF0ZWQgdG8gQGlycS4NCj4g
KyAqDQo+IMKgICovDQo+IMKgdm9pZCBkaXNhYmxlX2lycSh1bnNpZ25lZCBpbnQgaXJxKQ0KPiDC
oHsNCj4gK8KgwqDCoMKgwqDCoMKgbWlnaHRfc2xlZXAoKTsNCg0KSSdtIG5vdCBzdXJlIGFib3V0
IHRoaXMsIGxhdGVzdCB3YWl0X2V2ZW50KCkgaW5zaWRlIHN5bmNocm9uaXplX2lycSgpDQpoYXMg
aXQgYWxyZWFkeS4NCg0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFfX2Rpc2FibGVfaXJxX25vc3lu
YyhpcnEpKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN5bmNocm9uaXplX2ly
cShpcnEpOw0KPiDCoH0NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3
dy5zaWVtZW5zLmNvbQ0K
