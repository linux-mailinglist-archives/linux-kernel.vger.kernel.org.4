Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC17C6F547E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjECJTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjECJT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:19:29 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2094.outbound.protection.outlook.com [40.107.135.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAF41BFA;
        Wed,  3 May 2023 02:19:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBGZFQ7sgo19kyAlHhwIwL331kUj88Ys04Tj5MZqDU/kpaSBAm/Dt0g+wk6A8/Cjk9yHO2MewbKJB0kyfdS9woCQIyzEfJf5iVzL50YyDojxhOt3tthHTaVr5j7R69+FvCDZ19XyVo5ZW9f+5dPQzGZX5CSkvu2cMCg5E3+UCFerIcdq40zTDQRoqcQqHKjBzt7Q00YXfW+e+aVH4Q3Qx5ccfFv4H9JsiFDFgzRnAhJqm4ylHEKdcidK4Grz52WJoWrEqTYnW2ZoiD0B7BvTcdzddr3MJJ7jD7oKSCeohb3SsSDzj76tqld3PtMGNlFPcGU71HiCkPFkumJI7/QAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gFL4a0azTetJiKGmlER+zBPFHDQdaIIsg8QP8QaTuk=;
 b=Jo6PEhrnXn3MrscMHM6ti1kzZ8t272zXk2WuRe9Z8T3ouJJKgLdj0L05Bx9DneKV12iHSvdoNf4ysbB8xqgiUesGNsHIlabc0fEabs5oiOJhO3yhNhVyMK9ln7yc6/fjpdbaWM+oS90lE8iYEXsd2bOOFvMlBr6i1fHP4VZY0jLUzxM+U18yox7Lh8ff+KuInUx9bu0ENVTHuAIx+5Rzah6sRijyyl4C/IXyNbCka/tByj1VevlCEgnaGdCBfAUc01IfJm09md/4ffB0ROS+njOy5Nhj8W/OZAzx7pDxbDZ/pbgMMwJS/jDuzci8gNeSOVaTLIsjZIW6WPGnqRvTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gFL4a0azTetJiKGmlER+zBPFHDQdaIIsg8QP8QaTuk=;
 b=dFrnNXlhvNKq15RrcXaJZCds1WIh7vWiqxn200TCRRjTSfvqT8OkpRBj67RJH/vYFuK6xun7/2HRESsVTWCCffSo3SapyGVRZn1s9rVc9AkeEvmPdv22Q7xEvTBry2roeH/1pc8lCtd9xud9bLqIcMvSQIF2vm0sBhPlAw9qgUc=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR2P281MB2857.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:67::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 09:19:01 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4218:fb63:61ae:c42a]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4218:fb63:61ae:c42a%5]) with mapi id 15.20.6363.021; Wed, 3 May 2023
 09:19:01 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: bu27034: Ensure reset is written
Thread-Topic: [PATCH] iio: bu27034: Ensure reset is written
Thread-Index: AQHZfQ9DsqGNSmvkokOfr1cei/vxeq9IRngA
Date:   Wed, 3 May 2023 09:19:00 +0000
Message-ID: <1bba2342-a591-cbe0-bfa7-975abd91041a@fi.rohmeurope.com>
References: <ZFEzmA/0whRO6IFv@fedora>
In-Reply-To: <ZFEzmA/0whRO6IFv@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR2P281MB2857:EE_
x-ms-office365-filtering-correlation-id: c395ce73-ca2c-4ee4-957b-08db4bb76e96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zcOBfiwttnEgg33bt0HWsfD9Fs4YaC4LG8Uwfzof4BehLTSF9oI4l7FVTUyWpBn97x0hv6VbRm2Ct6Q2WKsFtzHX/iTm0FaQc6wjku+PaOHHbFNKdRuEcEgsGcix6qYx+8qBP3cO9Gv5dYMo8mOAZ5ZgbWXlYAPxGnpo2hDORyeXnoYlahotyqQDeUF4JuR+SAMImUWnFcmYpGgJPdIPPNcvutoFo5QZdYCcApaTLoRYX4HjtgJaZPwl6NNgixLthLnDSOBQhO6aCzwFG7ZojF9oBGAToXPvPshuzvp9lo3zly7prTYGh2yk4H73dts56bB/xaMiYh3WS/tez0ZWpz4x/FTSrgRM6SZYJXrc4nOh19FZf+lyIOGc1S8eflDDVppOmS/Mjl/wMXGrwNAffC7/+FMJr4re7hzJ0MMXSWIKa5Cwpz2AC4+8XQdxjnVfRqp8nyLOsipwgesx1SvTHSvXmoQBMxpzdQUkQ1jwAxVhUbmHIAPAWZBMZ7CfAEmBISLbrkhhb9CmuDnxvTCRW7sOeJJAsgjaab9DUDq4B/REgl8QLf5cBRaHh4uV+hAnN2uPd3rWAc3+32GrtEzDkruo+KDRiKlRMKoUH0OpNZqDBDaCVsosUQC3N5mm8Q/DV4GhBGiNdJ6QR1kZfe+MncF/B1ORUE61yDxjBJZd72CT4294QTX9V9clkx1uUYQk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39840400004)(346002)(136003)(396003)(451199021)(41300700001)(31686004)(5660300002)(83380400001)(122000001)(2906002)(4744005)(2616005)(8676002)(8936002)(316002)(6486002)(6916009)(38100700002)(64756008)(66556008)(66946007)(66446008)(66476007)(4326008)(91956017)(76116006)(86362001)(31696002)(71200400001)(478600001)(54906003)(38070700005)(26005)(186003)(6506007)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlEzUjFkYzViajFScEdkTW9WNDJ1WTNMQ2I3NXoycVFSYm85N1N3eFRncW90?=
 =?utf-8?B?MW5oWGxPL05zMVZRWjBqT1FlWTVMWXV0MzJ2aGxLV0k2UmNKdXhVYU93Ymxq?=
 =?utf-8?B?RFl4cUMzVFZmbDlSbnhjSjh3aURZTWpnOXhRb2l3NFlsSzFxUHJqd2FWUUtj?=
 =?utf-8?B?eWgyRTFXV3BCSXI4bm5Tem1aL2Z3MkdMSnRzSkg1Z0M0ZGszZlFwUDdGS1d5?=
 =?utf-8?B?djlDK1dtRm9iNVczYTBtZGpTN0xHKzkyVDVkVTQ3a2RXQUlwNHRJUWgwR1Iv?=
 =?utf-8?B?WmV2M0g5Z3pZZjR3UlZuMkwyUjRRQTloTDdBNHVncVpGRDVMUXNFVHYrNm5D?=
 =?utf-8?B?dWsySE5oY1FmOTFsZjc4U0lLd0g3MVplSTl0cTQxSkJkN3B4bjlKZkErTTkr?=
 =?utf-8?B?bW8wUlVwd0J5TVlTLzJpR1V4d21tR3hReXpRZnpHWGN0M1lzYk5NZ0JGNnBD?=
 =?utf-8?B?Nm5MbFptcGdJQjJCMjZhK3dtTUtCTmlhNDdpaWdjVGFoNVZoL2F2Y1gzSjZk?=
 =?utf-8?B?RDRLYW5wdkRSQy9lMHRRbGdpZmFOM0lZQThuNzlSZFlURkRVL09OQ0dRMDBw?=
 =?utf-8?B?cTZpT1hYV1pmQW1HZ1lSdE9SQTdDNE1vOStLeU1yU0szTmtFQUZQNjRzVlI4?=
 =?utf-8?B?Yyt3azNyeHJnSm1WSFdLNk9uTUJzeXpUMUtnMnJzNWh1UFhKSnRGYWJmV3Qy?=
 =?utf-8?B?TVNVNzJ0ekVaMjE5SnhLUzNMRXN1cXhSWVNKL2lyN1Y1aHQ2UXpFN0lGVTVJ?=
 =?utf-8?B?QnNHOTJ4M05LQW1RK2lEbk9tVHcvQnUvWi9JZ1JEQlQ4WEZydUUzQnBUNjFk?=
 =?utf-8?B?ZXUrc1BCYk9wUTAySzNiYWtLclIzMThmUHozbDlOOGM5RVVwVFp4U012Nkt5?=
 =?utf-8?B?cEVEQ1g3aFNYTVRRd05VdU13dG4xWXdQMHBUOW85NVRvVXVvdXJsRUh2WnMv?=
 =?utf-8?B?dE1ndHZxV0hBOVpOZ05rRFZONUc1S0tFWlJnUHM1emdoZnBIZG5tQTZQMUZJ?=
 =?utf-8?B?bmJLUXVzLzBxY3licFN0MGI2eVlhZnRmMWgrRmZIU0ZPNlB4K0VYWkhXMFVF?=
 =?utf-8?B?T2dCR2ZFOFU0bUpoclhtMEM0WXlJbm5FMEtmYjVPeENiUmlkeUlzcVJTTS9O?=
 =?utf-8?B?K3VBY1pVMWo1NTlMdEVsWWoreExzbGx1YktSSkVBWCtDZHArZnNYUDg0cksv?=
 =?utf-8?B?VEdKRTZrU2xscVRGNEM2MGphTHU0K1J2a1lhS05JamtTUEV5eGhxT1FUeUFz?=
 =?utf-8?B?RzRFM0xUWTltdnZtWU9PZUdTMjNZM3VNYTEzUERqNEQzdUZvcUdvUlRuS2ZC?=
 =?utf-8?B?dk9qOW5LdDBYQVpnd0s2MlUvL3NSQ0FIWEtSZExENDN1d0RTcmM4Wk1RRDhP?=
 =?utf-8?B?VzVmWWNMVU1ENEpydWFYaXIrL0FKdS92NHB2S0J5TzZIeGg3TW0vdE9pNWdo?=
 =?utf-8?B?UW13dm1SdGE2dytIaHd2S0Fhdk9NUXFtUTBkWDF3M2FaM2JOSnU1ODRWVGtC?=
 =?utf-8?B?bm02TDhaMUtweHQ5TU5IZ2c4RE53N2l0bHJXQ2w1YTVyeE5MMUgzTFlHbkxX?=
 =?utf-8?B?R1p1THRzakIxRjVDdFY3a0htSVNMV0dtUVd6dC9FK2FVbEt3em1PYTd3RUVS?=
 =?utf-8?B?ZzEwNjlaUDFRSE9zU3JVbUd6OGhyMlpxbTlFQmlvbjdMUFZNdW5uQ212Y2xB?=
 =?utf-8?B?T2o3cDRaQVZuN1NRV1MwTENJOEFvb0E0ZTZkTHBMY3pXSEhLNWNZSHpuZUls?=
 =?utf-8?B?WlpJK3piWGVGelBva1J1VWZXUmRsOVFXdEt2US9qZU80Wm54emczRThFTTBC?=
 =?utf-8?B?RWd2QXA0dVV1QUtyaVArQzh3OXd1ZTdkemVLNWNjOCtYckhZY1NYdkFTTmg2?=
 =?utf-8?B?UmpvWFhGM2xLOWRydFBXbFJKM3V5c0VZMjQyclY4clVqVlltaHVLRDIweVc3?=
 =?utf-8?B?SldEN3FwTUR6amVFb1NBWnM2TC9pYlpBNVd4TG5pNVJ3ekJldzR4SldGV2t0?=
 =?utf-8?B?bmR0S2N4aThCcWVSNERaKytUMWJrVEJMeFRML0IzYmQzYVNWTW95TEM5Nyt5?=
 =?utf-8?B?RE9hRWlvTGNNaXNKSGl2Syt1bjVMUE1NRjBrMVdDc0xjL2FaNjdGdHgrQjlZ?=
 =?utf-8?B?UEpkU2hLYkFEVG13UTJUdlBteDg1Ti9nK0RQK2lqUjVwUGtiUGRwR2VSd0Ju?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85E7640D844F9A4B9F13DF4D5CC0937B@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c395ce73-ca2c-4ee4-957b-08db4bb76e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 09:19:00.8970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjB1VVvyM6iQ0Litj0i0E3zd8bE2Ei/vI0FRWBfyrMg9ogp6/VCFyTHcj0ze2micwLuhuLKYhA/rGEucXnpw3lzztDbmbPiNL15hS1a0GgheHuL9LX0sJ+zmeI618zDH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2857
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yLzIzIDE5OjAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+IFRoZSByZXNldCBiaXQg
bXVzdCBiZSBhbHdheXMgd3JpdHRlbiB0byB0aGUgaGFyZHdhcmUgbm8gbWF0dGVyIHdoYXQgdmFs
dWUNCj4gaXMgaW4gYSBjYWNoZSBvciByZWdpc3Rlci4gRW5zdXJlIHRoaXMgYnkgdXNpbmcgcmVn
bWFwX3dyaXRlX2JpdHMoKQ0KPiBpbnN0ZWFkIG9mIHRoZSByZWdtYXBfdXBkYXRlX2JpdHMoKS4g
RnVydGhlcm1vcmUsIHRoZSBSRVNFVCBiaXQgbWF5IGJlDQo+IHNlbGYtY2xlYXJpbmcsIHNvIG1h
cmsgdGhlIFNZU1RFTV9DT05UUk9MIHJlZ2lzdGVyIHZvbGF0aWxlIHRvIGd1YXJhbnRlZQ0KPiB3
ZSBkbyBhbHNvIHJlYWQgdGhlIHJpZ2h0IHN0YXRlIC0gc2hvdWxkIHdlIGV2ZXIgbmVlZCB0byBy
ZWFkIGl0Lg0KPiANCj4gU2lnbmVkLW9mZiBieTogTWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNj
b3VudEBnbWFpbC5jb20+DQoNCkkgbWlzc3BlbGxlZCB0aGUgU2lnbmVkLW9mZi1ieS4gU29ycnkg
Zm9sa3MuIEknbGwgcmUtc3Bpbi4NCg0KWW91cnMsDQoJLS0gTWF0dGkNCg0KLS0gDQpNYXR0aSBW
YWl0dGluZW4NCkxpbnV4IGtlcm5lbCBkZXZlbG9wZXIgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0K
T3VsdSBGaW5sYW5kDQoNCn5+IFdoZW4gdGhpbmdzIGdvIHV0dGVybHkgd3JvbmcgdmltIHVzZXJz
IGNhbiBhbHdheXMgdHlwZSA6aGVscCEgfn4NCg0K
