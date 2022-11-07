Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3195961ED54
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiKGIrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiKGIrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:47:47 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2129.outbound.protection.outlook.com [40.107.117.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A86CEB6;
        Mon,  7 Nov 2022 00:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWw4+lSzZ3qNdDZrkXO9yZbC5mwGKWlhFuFpkchvekIxrTg8exmeib2eQTUScxFCdd19RfDXudO8bwRtN/R+TQpeMCM6+Irdw4goN41+Yfhj4DR96gSJP0zpRJ3MurT+t0vl6cbbbMB9TJCT/DIS4Stfgt9Z9Eo93ozlw7z8cj8YKys8Gu/qKpfVWo6Zb120EvLRwy+5m/UUSbfhZgMYPm7To8ycmzNdFKWv4b7ryhI3K6kIHTVUxiECq1nst/hbJGFLVEvfvhPW2JjowT9s5hx9AxcV3WX4u9nL6BJX2hzKHwIWJQnEuWblRPyYwXcYOc9gmG9qEju9LiQZazT9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVN2V2TGnbXs8jw/uwA+pfYx4d15g7gP8fKx7SP2vvU=;
 b=HcXCcYWI1g77gGzmGIxLGE0y9BMuIoy0dXDvziOkW5t9tzg54jr7IbSJEYG+awFtihnmWdnYZQu4txDyQ75nNSI4jsAeZDb8H/Hp6VuYTMd2lLv70Jk/od9k6wZMhQ0j4yr0zoM4soyrTMrtoy1zXsGxooTuryxzj6cFxUpqT1u0UoRTVEKRMUGMGbH1xz7pYwt4cFkkPP3DYCt5LtkMPf5A1gv98wxwwReK+lR1l3y3qBz41LEsGxHD8Zz8Haapy5PovRAAfB97m61WgVIqvXdmpu41l1kl/YqEpc75aBY+ZqAvq19xcbi3aqwNULOxZ9zJ9Q5h1GOl80x2soB8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVN2V2TGnbXs8jw/uwA+pfYx4d15g7gP8fKx7SP2vvU=;
 b=dqtplrM2X15wimLMFv3Jzk1/YJFbgTQBMoeCYT5iOnU88cC90TVTXnr63iDYWwaa3hFv/bViVlgvMKojcDG+cyCAAdLHsRS4NBFkNl0Ua2s7BnWrrh5926Aq6NtO6UIALE38EYbu98+a6DVHmNsoCHM9TEQGMEdB5jAUGFSkjaQwhX3Jv1+vRLklZfe8pxzBBd2DBEODMt1NgL9qJv/3vNMc/+t5K6NCznhymnXEciML/an2Hjp/B50E5p9kTL/Nr2OhFcbOvQrzY8VKfq7Dhi7tK9nkUgp5AKFHY0p+ZyBYcixHKxVdJgarhf21JZlcf+ymjt0EA3jWp5OQse6Vdg==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 TYZPR06MB4063.apcprd06.prod.outlook.com (2603:1096:400:2d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Mon, 7 Nov 2022 08:47:35 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831%6]) with mapi id 15.20.5769.019; Mon, 7 Nov 2022
 08:47:35 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "garnermic@meta.com" <garnermic@meta.com>
CC:     kernel test robot <lkp@intel.com>
Subject: Re: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHY7pXw7ASL6kfe60CZV9tzr/Df/64ryjuAgAfp3QA=
Date:   Mon, 7 Nov 2022 08:47:35 +0000
Message-ID: <C7224BE1-D81E-4FE0-8B7C-5A3CA69898D2@aspeedtech.com>
References: <20221102083601.10456-1-billy_tsai@aspeedtech.com>
 <20221102083601.10456-3-billy_tsai@aspeedtech.com>
 <OS0PR01MB5922014A7D74A884D2E7BDC286399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922014A7D74A884D2E7BDC286399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.66.22101101
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|TYZPR06MB4063:EE_
x-ms-office365-filtering-correlation-id: 3208f7fb-3952-4d63-27d4-08dac09cb787
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2CQmIy0PEGdcjJSefN2cYJCZ1RAq+7WP6D17h12GBUkcnfph+y4eNgItjMmVWfjbIjLJ0p8aIzvaRpOO48wdfxyGiVxhTtxi+DoHBbtY4M2OUk6HPWXol+LhADjF+wzpXIy0vAHR7wqb89Nrgx2M4/LJ5LZ2F2BgeRhIyOctDSgKmaj3zplYmOQCvwPCqL5UQSdG0VjY96kkbWCQ/3P1/TLntk6oxSclBt5NeDmbODZNWPFT9K14vo8oAVqiOcXG0Qm8e3UWo8E5NWFwEkXgM4ROYj0J2/FvJzx9zKLGcWOfgq+LRMP+7kRf3Z2vKEXBAWd5+vieAheRIbC+Q8ZS11RTyVxg99pry0bV/nt3eWDXgmGQ3B5iiWRm1X7DGzlFDFwwrsIM9kPgfkVO+iKmwe9UkTmpaonqVNHatJ0IBWdeltEAhM8L9F9tLhiOpZzwIA3QWlZx/Q/sN/83HMaUz/6Qy38vBkadOxZbqDaFjuRQz5rBjsA3p90YjacCPiIaNFt434PzP3DRfTuOhAPoec2gz7Vcjly4MZfRVlyUsr86Eg3W7yzxukhpTVPv6A42qCuaIUDumSSuov+0H0VNUxp0yfPJHrKFMW5z5MpCyvwymnvsLKkDJXCdm1E6DLBPGaMIPNWPIftHjZD7hmN0fOSP4UnlO40vROsR9KEQNshqTYOuNGtMZgCFtA3fL1Jr+zK2pAfGGhecVE7xGSipyoBNVKOqnPj3k32omnVI9nANoOubYW+DgnRxjtlA7KZxPTe/iD5CEb+U2i2z0cuyu1YvGHmAkurU12UwkKeb/jBkIQnrXIF8JS7AKV6qWvK7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(346002)(39840400004)(376002)(451199015)(76116006)(91956017)(8676002)(64756008)(66446008)(66476007)(66946007)(66556008)(4326008)(38070700005)(921005)(83380400001)(5660300002)(4744005)(478600001)(36756003)(6486002)(71200400001)(41300700001)(2906002)(33656002)(316002)(110136005)(8936002)(7416002)(53546011)(26005)(6512007)(2616005)(186003)(38100700002)(122000001)(86362001)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mi93NERGMDFJbWpjQnNvallnOThDZjA4OEVZb1dSUUdtN1VCNDdwS3V1WTVJ?=
 =?utf-8?B?eEdIaGxtNXJsRFFOWSsyTHBFTXhqNGZLVGtRZXFWR3RIQWsyb1IycERXVmo3?=
 =?utf-8?B?SVlmNG0vWUFwTHRWV0N2Zk55b2FKRm5XSjBRMUtEWHFSUVZkNFlIV2tnMmps?=
 =?utf-8?B?ektQTXhkL0xrYWdTQlord3Z2YS9IMVVXZ3RpMllNaGY4R3l3enMydlp4aUJw?=
 =?utf-8?B?ZDJUQ3ZNMUdQMGpvS2YzQk90YlRnZHNBT2kzYmxYc2JPWmFVSFZoL2MvSTJP?=
 =?utf-8?B?UE5tR0tuOHJlT0M1NmRiNkFBeUlJWE4wVWJkdCtQYXhJS1NscWhYaHBSajdP?=
 =?utf-8?B?Y2ZvOFBPdC9NQ1NGaGZKcFFWNnRvR0U1cjRxWGVOQllVaExwNjc2azE0K0Iz?=
 =?utf-8?B?eUUyN1dGd3NCaTBNbnIzQVVWYnBGaVc0N0FFM0Z0d3RsRjVFbjZ1OE1XQUpP?=
 =?utf-8?B?bWQyaUtFdWxmQmlaWUoreUxqWUNwT292UHVWWDQvYjdJRHZHTVRzOXJPbVdF?=
 =?utf-8?B?a213cEd1ZmdwU1JYbCtwVkx6Zjd4UDVURlVjaHd5a2MzTzBYdWRHbW15Sk56?=
 =?utf-8?B?N2U5UkpnbUlBVGNlbnhuUnZ3Y3MyNDRRRUJNdWZoejZucG9XZm96cWRjS09G?=
 =?utf-8?B?SVlrR09SSUJaclZXQi96am1WMENSTFpxWkIzdjEyejVXQ0liL1QxSmhsdFdX?=
 =?utf-8?B?TCtUaUZjZHBGbng0S0R6QTExYXpYbWsrUTJTVUkvNEFJRllLNkRYYlJBSU5E?=
 =?utf-8?B?aWdnaU9vMjk3ZzhiVzczVWV2ZU1FbWpFajF2eU5iSEZ2K1JaZko2RkNacVJi?=
 =?utf-8?B?c2YzUnRwd1lZOXQyWksrWUJhVlRWZHlMdGtMQmdFVzBweHpORHdJRHhab1JF?=
 =?utf-8?B?ZHljc0tCY2FpRGlLUkFZQmNnY0ZXMHhxMW1kUUdSbXBDT3hSRHJRdnE2Ni9W?=
 =?utf-8?B?L0JrUUdhbVN6cU13dWg2aFBwbERyOGthSVUyTlg1b0JiUmJZUG9OTnZGcVdI?=
 =?utf-8?B?cmozdVBzU2c4Znd6ZWdMRFNVNExtRXpid3FYRWN6UXhBVU5NczBmOUNPYWZ6?=
 =?utf-8?B?TG41WEVGUDIxalZLU04yZW04WjhxeEwrd211R0tHWVB1KzZjamt3YVcwZU5n?=
 =?utf-8?B?RTBzeUZLTDZlSlRyejVwekg5b21lbDB2Rkt2WlJUSmF6UHhLeTFqdEF5ZFFy?=
 =?utf-8?B?dldqMXdwdjRsYmxPWnhLT1dWc2lmQ1BtK3FkSUFZZ25Udk9ZNHdUb0NHa01V?=
 =?utf-8?B?SVExbGNqR1V2NlE0NW01M2hmdTE1dXNlamloNXd3NCt2REVEK251SGtSSXNP?=
 =?utf-8?B?MHM5cUxjcFZwQUNvNEkvUmx4MkR0dlNIM2ZVUVp5dTEyeUw3bU1pb1V1aEZO?=
 =?utf-8?B?UGdJY0tCMjNLdXEwV3R4anFleXdDNzh4MFNTYTZKd1l2bFNqaDhGbkU4QzNN?=
 =?utf-8?B?RDhNdTgrOXRiWmU1bWorSHhtQ3hDZFViNmQ4M3RFQ3N6bTNNbjVCeVFmRkZK?=
 =?utf-8?B?VkFWQ004RVdXSHR6MzZSSFdndyticnBJVnQ0T05wcEZHb1V4ai8zZFpGOFlR?=
 =?utf-8?B?UGxoY3YyMmJNb1ZuV3hvUE90MUlleTAwVWptVU1WNDhXZ1BHZkpyNVFJbmUv?=
 =?utf-8?B?blVXZXJGcCtnc0IrOFdsU1RCQ0J3b0U5N0FMcGZUNlRTQlUxMGJDQjB5eXlv?=
 =?utf-8?B?QmkrL0hubTB0L01SUnJCbFYydnJjSXlwZDhSd3IvSXNIa2JKdWxRRVBLMHhK?=
 =?utf-8?B?eDljZy9idUFsTW1WdlRuSFdkRUlTUm9LeklLdjdLUEdueU41TjRUYkhBUHFH?=
 =?utf-8?B?Y1dteWs4S1ZGTDdOc3NsSElkVitGUjVqckx0aHBrSkhvYU1FZkEyQWZnMHZp?=
 =?utf-8?B?OUlRcTcxOUFRYVZUVnFOaEFZWWU1Y3ZVZXVoVno3TFpVOFlyUGdiTTZIN2pV?=
 =?utf-8?B?RXZwOC96YW5LRmVaNWx5UjF4alh3S0R4N0pJVXVwbmdZQklEbXM2MjAxcmFI?=
 =?utf-8?B?RDZxTU1ub3YwL0cxbGJPaCtyQXpCeUVPbE1keHA0RFpmTFBJcHpWR1RpTGp4?=
 =?utf-8?B?cUFEbXpOTndqTm1GaENtSnQxckcwcnVSZUw1aWxncE1DWmMxSW5iM2prNTBr?=
 =?utf-8?B?OGxENVBmWFdFVnB1eWtuSktsNnd1Q2t1OFNlbXh0NWhIRytHRTAwcVlNZTJD?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1785FD0E118D5147820B9F496F89712F@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3208f7fb-3952-4d63-27d4-08dac09cb787
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 08:47:35.2397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hEZWvIXwiprUqmoG5D3QYvPUw+4/sk+dqHivdIrP7FZSlKnKlJAgYV7vjm9S3po10YsXo3dHGvfNK4oic72cxUIrftKzWGMWCk0BhNxoHy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4063
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMi8xMS8yLCAxMTo1NiBQTSwgIkJpanUgRGFzIiA8YmlqdS5kYXMuanpAYnAucmVuZXNh
cy5jb20+IHdyb3RlOg0KDQogICAgPiA+ICsJcGFyZW50X2RldiA9IG9mX2ZpbmRfZGV2aWNlX2J5
X25vZGUobnApOw0KICAgID4gPiArCXByaXYtPmNsayA9IGRldm1fY2xrX2dldF9lbmFibGVkKCZw
YXJlbnRfZGV2LT5kZXYsIE5VTEwpOw0KICAgID4gPiArCWlmIChJU19FUlIocHJpdi0+Y2xrKSkN
CiAgICA+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKHByaXYtPmNsayks
DQogICAgPiA+ICsJCQkJICAgICAiQ291bGRuJ3QgZ2V0IGNsb2NrXG4iKTsNCg0KICAgID4gV2hh
dCBpcyB0aGUgdXNlIGNhc2U/DQoNCiAgICA+IElzIHB3bSBjb25maWd1cmVkIGJ5IGJvb3QgbG9h
ZGVyIGluaXRpYWxseSA/DQoNCiAgICA+IE9yDQoNCiAgICA+IHB3bSBjb25maWd1cmVkIGJ5IExp
bnV4LCBub3QgYnkgdGhlIGJvb3Rsb2FkZXIgaW5pdGlhbGx5Pw0KDQogICAgPiBPcg0KDQogICAg
PiBEcml2ZXIgbmVlZHMgdG8gaGFuZGxlIGJvdGggY2FzZXM/DQoNCiAgICA+IEp1c3QgYXNraW5n
LCBiZWNhdXNlIHlvdSBhcmUgdHVybmluZyBvbiB0aGUgY2xvY2sgdW5uZWNlc3NhcmlseSBoZXJl
LA0KICAgID4gSWYgeW91IG5lZWQgdG8gYWRkcmVzcyBhbGwgdGhlIHVzZSBjYXNlcy4gSWYgaXQg
aXMganVzdCBmaXJzdCBvbmUsIHRoZW4NCiAgICA+IEl0IGlzIG9rLg0KDQpIaSBCaWp1LA0KDQpU
aGUgZHJpdmVyIHdhbnQgdG8gaGFuZGxlIGFsbCBvZiB0aGUgdXNlIGNhc2VzLiBDYW4geW91IHRl
bGwgbWUgd2h5IHR1cm5pbmcgb24gdGhlIGNsb2NrDQppcyB1bm5lY2Vzc2FyaWx5IGhlcmU/DQoN
ClRoYW5rcw0KDQpCZXN0IFJlZ2FyZHMsDQpCaWxseSBUc2FpDQoNCg0KDQo=
