Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB236FA393
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjEHJqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjEHJqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:46:15 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A972D63
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1683539165; x=1715075165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bxAJ94fTRwnJlrBy3/Vcz0J3sPe5ZF21V14m9SUB09Y=;
  b=JiLdeGeCcEZ+JfQiUVqqKwOKBEUYzmENakb425eL8sGZ80ytZAml3lzJ
   ix9JFdDKW7JyZKCdQp/6L3wH4oTDqnZIpvLCgAQrRubRpx/rzg/4apiO7
   p98gNKQhj616awo9WpTW3A2/X9SFghTgK+8pKcvJYMilXpWzfRbI9uXuY
   ChLQDmcjIM5d8wmjpTyN4GExZ/iJlJkRkvpVsO4CzhVXyV30AZsJ7xEzA
   J9oBolLMqs6NtqiCjiZSfUS6Yb5IQ9quUvwTYyNglECpShrPmODy8z1kA
   i0aDvfT1/Bjr07Gq2PWGpOVUiLe19abv4s42zs2VFfpPuwfI+Q3k9zaqv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="92012919"
X-IronPort-AV: E=Sophos;i="5.99,258,1677510000"; 
   d="scan'208";a="92012919"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 18:46:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2NjqtAMAKqEuVBVBzi9VpJyDZIX6wyYxUB37XBrIq5+QflQKobIjCROPVwRk0GUa9400CzSpyIoYUNE8HHXVcO6Qw7oSIMAh9N4vfw2hxkKb363snakJdJmqzKvPrw4N84i3dBG+XJfOFaoKny65hlp29N55TGXJGsgAe0otagjYuaRDM9tNc3aHSr8r+gbjnMeJXU22u37Iu685MfoHoMNhHsTAZsBN83RpRrrN87LSfJVGFbkV4iPTl1awSId4CT/j39RsupxLPAaA327753eRWYdtfOeO54AB09bk5t6cuaPpK+dX3ncb6Xmsl8R00FSngpjtmORU8N9LlU4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxAJ94fTRwnJlrBy3/Vcz0J3sPe5ZF21V14m9SUB09Y=;
 b=bXGjnIkf1dTstss2EIQqKyURlKixaMYp/o+4QxsI3YmZsRuUcBIobaAA7WG9/3Yyzi0AIH349hrgQIyLsVlovdVO57ZY229OOOu+XtRGP0Qq3fT5uBsE9mfqnEdtJ9X2qLe6ud/RBZNAm8YL5wSlqGixWGvmGxcYbM+y4ibVsqBr6tpw0+tvZjaa41wa+Dd3IdTWdxi+M11Afk1mlL8ZG44GUUHD96P8pwZTEbj75qzuxWs1zN9NeMTPzzH9hbIpoIOoiFjp7/UxlflF0YGrzxK2smk3T0xPcU8iH0ucTGPV0mVRmfTbEVcDary7Z1evefApXoDV9VBgP6QtMEnhFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYWPR01MB10630.jpnprd01.prod.outlook.com (2603:1096:400:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 09:45:58 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835%7]) with mapi id 15.20.6363.030; Mon, 8 May 2023
 09:45:58 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "Shiyang Ruan (Fujitsu)" <ruansy.fnst@fujitsu.com>
Subject: Re: [RFC PATCH v2 0/3] pmem memmap dump support
Thread-Topic: [RFC PATCH v2 0/3] pmem memmap dump support
Thread-Index: AQHZePGyDbRSw7SlpU2xnWSJHHhjFK9BFSkAgA8cuQA=
Date:   Mon, 8 May 2023 09:45:57 +0000
Message-ID: <774fd596-5481-aeff-aace-8785158728ea@fujitsu.com>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
 <644c17823cf83_13303129460@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <644c17823cf83_13303129460@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYWPR01MB10630:EE_
x-ms-office365-filtering-correlation-id: 397165bc-e761-4f06-7456-08db4fa90675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ONjInwk9HAGisEU3A6PB5rk/1akACsCpuel0Y2JddPF0M2FeqJZxiuBvv/t5P8vLjQ5bSyRizaEoA7yvYDfwqD8//IEbXcoGbpo2PgxP7Ksdt36C886dw9yuVcMP/qH7Rh8EwdOJz4ZS/bbS7y/5ervtWaoFd+8TI1/B6Ejlqja7mVheVOPeryPsz9C4nCjkTo0owat5P1Q+1WOv7XABXSAdiV76DxDTRz7VGSSkgNHtcJxvEKdu46cECbE8b5VMuw0YGrKZ8P7rdUs9K9uOESX099nydqzzqjbUeg41ArvMh+QmA7cIqqPMEqV+KCst8JcBziRu9q5+AgW4htoLBZDuuT0HlglWJa4vq6hT6ENdbGq3zjDIO7jez6JmQuhUgVbyKQXzgxzV8WAdZ+o5e7D9L4I2gohsf/LiWsNtcaiaI3LPBN4VENq59/pv8QIUR3MUylVPoZM3G+wUwzDQAq+zgeWc7wbLXE8t/nLtBjzkrgJmKTX7D3S7Wn8Vf2yfaCK9+j98KI8YYaRENwDK3csn4pSbtB9BerXro0jBukp6El7JsACgMXw0c9N0lIdMwtuwEYYO4IRGngfY2DqsNjhquHyRF6PJ8p3mrUFJpzGiPl6Kw1ghf653xq2kvgZcBynX5zUQ9iDgiM76g/CVGlF4I1Z77BP+1SOnJTGk7DdKS3P1CrMTxdq39q7qNYpCmd++YP7cL9bdHC8d+Ae0Yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(1590799018)(451199021)(83380400001)(966005)(91956017)(6486002)(478600001)(71200400001)(110136005)(54906003)(2616005)(6512007)(6506007)(26005)(53546011)(186003)(107886003)(2906002)(38100700002)(36756003)(66946007)(76116006)(64756008)(82960400001)(66446008)(66476007)(122000001)(4326008)(41300700001)(66556008)(85182001)(8676002)(8936002)(38070700005)(31696002)(86362001)(5660300002)(316002)(31686004)(1580799015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGdMNG1tS3g3MVVtZVJWUjg1NHcyejRkZjQzYXlyRVhBc2Z5djBkUkk4ejJh?=
 =?utf-8?B?MGxDTXZLa1g5RGpsRCszTWRqMU82ckdWQzBoM2NQNlpHUEtSN0owWVdKd3NV?=
 =?utf-8?B?cXFBdjN1eVhGbU1CVTZCVDhmQTVyOHFkTGY3MVBDTzMzbkJodkxFbE9ZekMx?=
 =?utf-8?B?ekJiaVVJZHZMMVl4a2xqaEdqd3pmT2hWTDBnbWhtQldqdFZxMVRabjk1bXVV?=
 =?utf-8?B?RUNXVWxtb3pGaEllSmhhL08raW0yVmxoMG90NVZpRVBXeE9iRzVjVldyenFJ?=
 =?utf-8?B?dkFseHJEaWlRMmczcWk5TXJPV3ZFS2dvTGRXeitwVlN6b0FJZlZxNDdBQjZi?=
 =?utf-8?B?VE5tY3hMT3JHSTlDd2FTWVRJbFhSNkVra2dia2ZEL1dRRXN4RUloRkFOK05B?=
 =?utf-8?B?VTUyR1JGamlHRGxEQ3k2RzRZRWFzTjZha3dvMHdKQ3l4OVhPYXB2a0E0ZWpy?=
 =?utf-8?B?VHQ3VlZJSEQrRmc1OTVSWHBhSUNMVlBkOEtkSmNYaTl2WVB0U2NDZ3o5NGRm?=
 =?utf-8?B?d2trSXZUYjFXSmxUUW9TelRQTE9Wb3NiK3lqcFNzR01SaUhoVVVZUHozVVdW?=
 =?utf-8?B?MG93OWNjSzRML3V2YjhCNEhsdHB1Lzl0ZmhXazBCVW5DK1RaejRhSGVHQzEr?=
 =?utf-8?B?NlBFTUdGRUMrRmhsT0NmdmJyU0s5QkVvTFF4cFRoYzNZSXFSOTk1MWNJN2kr?=
 =?utf-8?B?d0RkeXpSa1hOcFhFNTFmSWVkelJMamR0WDN3TnhOUytUOGFGaWltc2V1T1Ri?=
 =?utf-8?B?RDVVUWVsNWptdmVVUExnUG9rZG9Fb0FPVWV3K1JKNTZQM29STWhZeU1PZTUz?=
 =?utf-8?B?aC9ZUjFHOURjZXhTTythTWk4T3dpb2VyQ0k3UUxRZUw1aGpOdmRKc002NTdI?=
 =?utf-8?B?N3M3NDB6c0x4SnlzOGZHMHNIcUVoMlpPRUhFVEFEOFNHblRiNVJLd200VFk0?=
 =?utf-8?B?QVYxZVIwL2xHN2hSd3R0amp5NEpwNmI1M2pDYXhxdktzVlJrR1J4dTI5dlUz?=
 =?utf-8?B?VVVhTUdRVkw3SVprL3ZkNkY2WWlzcFdtU21vdjlOYlRNWFlRN0F5RDFtaWpu?=
 =?utf-8?B?Z3hQckNNWFhXTjA3dDNEZ2lZZWZVQ1Z2L2dRb1ZFN0Q0a1h6NUdwY0ZDS2Mz?=
 =?utf-8?B?OG9aMWRpNUVmbzFFWWNta2FldGswaTVSTllhNHRxQm94dXAzaUl4eDRXU3Na?=
 =?utf-8?B?UC9MZ1JmVWo1NXdxWEV6Z21Hbyt3NEtzeE1NMWUrR0tUdWg0M1E5aDhUWity?=
 =?utf-8?B?aEN6T1RPcVRVMkZpdEJTVFJHei9HS2h2WVdPL3hUR05QaUljdW82MjRDd2ll?=
 =?utf-8?B?dlFBaXI1QzRHUmZNVit6bDBJNGx1QUI4Tm16L2prSHh1MnVlUytvUlc2a0My?=
 =?utf-8?B?UkZwQmJKWW9KdHFEL1ZEanhLVGRpdzhaQVBqU21MVEkwVTcyWGY4S2k1M3VO?=
 =?utf-8?B?eGVTai9DNmo5RVZqV3FxN3R2aUZuSlhhL1dIQ1RRemJ4ckpCdGNlMklzdlZB?=
 =?utf-8?B?bllqdkh1bFF5MXFOR3owYTBrS0p6VzFldDI3bHVsZ3lIZEpudktHUUJIMlFm?=
 =?utf-8?B?M2RNZUlUaWFEdFBaNHRDcHljb1IwMWlOSytPaW8vT1AyTGthb1FiRjYzNndQ?=
 =?utf-8?B?NVk2SzZsSm8zQWRsdkZRM2wvcC9YTjYwY2x5ek94dDJJUFNWR0xOampNc0N6?=
 =?utf-8?B?QWZhZUtRRGVFZjE4S1N0QmFLVlMrYzNMZUZpOE9pM2dCQWF3UXg4MFlVVU81?=
 =?utf-8?B?UFpOdFpNR25TMkhmTHdnbTlma2tkLzgvWlhUOVNiRDMvL1FsS1VDSktFY0c3?=
 =?utf-8?B?YnEvQ2hpQUhIdjhzdFBNRkVDTnNMN0JxNjhTSXhJdHRxL1FHOEhhbjlvVUJO?=
 =?utf-8?B?NnVIZTBMWUoxUEUrRFRIaXI0SUtHcnFsZ1hCenlkUzFkL0padkJIWVVLcTVK?=
 =?utf-8?B?Wkt2blNHYW1aN0RDZnpKOFc1bkJoSEplY3lOelUyOHJKMFErUmNaUGZ0dUw3?=
 =?utf-8?B?MEU4SE5lemRNL3QvVnY3VzRRcHkyb3pZTUc2VHQ5Z2pvYXA3R3BCMS90RWNj?=
 =?utf-8?B?bWE1emtGeUIySFlyeDhNZm54OWNLcGZRaTkxYU9mYWpqV0N4aFFtbG1CbTVH?=
 =?utf-8?B?a3JRa0hvMG1TakF0ZlMzK3FWWGNVckwrMkRwYjZiSVhWNkZ3R1hBUHpta2sy?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91293082011AD6408392E24906E9C504@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YFarCe495PxMKRHkZpXIHMmrVKk5FtHRgDRWQx/PzYIpPPudsQCJiwTq+5laAXVAWv5w/rcT6cNmDAT3yOdGZ2giItWWXNiLKd6NQaL9eS1u5WCqD+LvxkxoM+t68VpdMUmUnYUvF13+9XRsBCLPPjtCly3qohztBKxetm+B9krTV9KzKfA/WeFBtSZY17QimT7Is6YwXGqY4kyS6NmwXM54BA3fR5tu3hGBgE7MDDYpJ9cNy59j2hS47Ndy9nM0OvgaFCOUuCKcDfnVrpCiEetz9e7GZ9fHT66sYlYPTXP55x4FA7O8xgxhkU+zb+Un8arwOMGFj4jJOgfOo3Dnfqx5IVm+0ml0eLPotksFBEimk1cfdESqjiIBHKaQX29fPPKZMl6BUBtpFtqbjkqvnoLaDthDbajqb0pc4XK6hIBS85mEBxOvHLFR3BuvRfltgIJDQmRcRMPFz82ZuFzcEsf8l6RRGQ6PxojEQlAVuOMdWlPLQrY6UyhRADe98zahx4QE+ltHStBE3PD7r54pK1zZWyArschkAFsns5pcqTv8sfwcpAAr5ittI3zv2kbrPUieDGiY4LeDzuKA2kC5wILZczeiX4BlMPDFpK0XD/Zc85a9SoJ1qkj+xHuwstSAFLEHaZf43VQUiNg7K5S9W2+57i2LXvUCyjjLOn4pPl8gvEbSz/F5FU/SBQq1BT4BC5Dkx1AVmZH68PXKnyMU2zHN/XJu9vB1M9W7zf07+MomsL2oBFKoYP6ZBhjtHFD1SnBi+k2ofPATr9sXr2V+L1fnHbOj4Y0MA9XMx7S7P5SoLA92hRtQ+avvcDI87YTVpL9exg1Ew/xVuC5L3vjrfXkqHvutGhbLrFSownmUgQvxTjzrfPz8hyf5txC6rm1ZztExTXufKBmk1l4Le8sTFszaEPEkHHwGMa9MP2+YTFE=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397165bc-e761-4f06-7456-08db4fa90675
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 09:45:57.9245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaVsGzuau8+1ez1oOhctYAbblKbUg3a7pfwfGuo/+NeV9MoJOheP/gvgR6g5+4SOJoltDbnHNiIedhWtEp6QWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10630
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGFuLA0KDQoNCk9uIDI5LzA0LzIwMjMgMDI6NTksIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gTGkg
WmhpamlhbiB3cm90ZToNCj4+IEhlbGxvIGZvbGtzLA0KPj4NCj4+IEFib3V0IDIgbW9udGhzIGFn
bywgd2UgcG9zdGVkIG91ciBmaXJzdCBSRkNbM10gYW5kIHJlY2VpdmVkIHlvdXIga2luZGx5IGZl
ZWRiYWNrLiBUaGFuayB5b3UgOikNCj4+IE5vdywgSSdtIGJhY2sgd2l0aCB0aGUgY29kZS4NCj4+
DQo+PiBDdXJyZW50bHksIHRoaXMgUkZDIGhhcyBhbHJlYWR5IGltcGxlbWVudGVkIHRvIHN1cHBv
cnRlZCBjYXNlIEQqLiBBbmQgdGhlIGNhc2UgQSZCIGlzIGRpc2FibGVkDQo+PiBkZWxpYmVyYXRl
bHkgaW4gbWFrZWR1bXBmaWxlLiBJdCBpbmNsdWRlcyBjaGFuZ2VzIGluIDMgc291cmNlIGNvZGUg
YXMgYmVsb3c6DQo+IA0KPiBJIHRoaW5rIHRoZSByZWFzb24gdGhpcyBwYXRjaGtpdCBpcyBkaWZm
aWN1bHQgdG8gZm9sbG93IGlzIHRoYXQgaXQNCj4gc3BlbmRzIGEgbG90IG9mIHRpbWUgZGVzY3Jp
YmluZyBhIGNob3NlbiBzb2x1dGlvbiwgYnV0IG5vdCBlbm91Z2ggdGltZQ0KPiBkZXNjcmliaW5n
IHRoZSBwcm9ibGVtIGFuZCB0aGUgdHJhZGVvZmZzLg0KPiANCj4gRm9yIGV4YW1wbGUgd2h5IGlz
IHVwZGF0aW5nIC9wcm9jL3ZtY29yZSB3aXRoIHBtZW0gbWV0YWRhdGEgdGhlIGNob3Nlbg0KPiBz
b2x1dGlvbj8gV2h5IG5vdCBsZWF2ZSB0aGUga2VybmVsIG91dCBvZiBpdCBhbmQgaGF2ZSBtYWtl
ZHVtcGZpbGUNCj4gdG9vbGluZyBhd2FyZSBvZiBob3cgdG8gcGFyc2UgcGVyc2lzdGVudCBtZW1v
cnkgbmFtZXNwYWNlIGluZm8tYmxvY2tzDQo+IGFuZCByZXRyaWV2ZSB0aGF0IGR1bXAgaXRzZWxm
PyBUaGlzIGlzIHdoYXQgSSBwcm9wb3NlZCBoZXJlOg0KPiANCj4gaHR0cDovL2xvcmUua2VybmVs
Lm9yZy9yLzY0MTQ4NGY3ZWY3ODBfYTUyZTI5NDBAZHdpbGxpYTItbW9ibDMuYW1yLmNvcnAuaW50
ZWwuY29tLm5vdG11Y2gNCg0KU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LiBJJ20ganVzdCBiYWNr
IGZyb20gdGhlIHZhY2F0aW9uLg0KQW5kIHNvcnJ5IGFnYWluIGZvciBtaXNzaW5nIHlvdXIgcHJl
dmlvdXMgKmltcG9ydGFudCogaW5mb3JtYXRpb24gaW4gVjEuDQoNCllvdXIgcHJvcG9zYWwgYWxz
byBzb3VuZHMgdG8gbWUgd2l0aCBsZXNzIGtlcm5lbCBjaGFuZ2VzLCBidXQgbW9yZSBuZGN0bCBj
b3VwbGluZyB3aXRoIG1ha2VkdW1wZmlsZSB0b29scy4NCkluIG15IGN1cnJlbnQgdW5kZXJzdGFu
ZGluZywgaXQgd2lsbCBpbmNsdWRlcyBmb2xsb3dpbmcgc291cmNlIGNoYW5nZXMuDQoNCi0tLS0t
LS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0rDQpTb3VyY2UgICAgIHwgICAgICAgICAgICAgICAgICAgICAgY2hh
bmdlcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KLS0tLS0tLS0tLS0r
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSsNCkkuICAgICAgICAgfCAxLiBlbnRlciBmb3JjZV9yYXcgaW4ga2R1bXAga2Vy
bmVsIGF1dG9tYXRpY2FsbHkoYXZvaWQgbWV0YWRhdGEgYmVpbmcgdXBkYXRlZCBhZ2Fpbil8DQpr
ZXJuZWwgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfA0KICAgICAgICAgICAgfCAyLiBtYXJrIHRoZSB3aG9sZSBw
bWVtJ3MgUFRfTE9BRCBmb3Iga2V4ZWNfZmlsZV9sb2FkKDIpIHN5c2NhbGwgICB8DQotLS0tLS0t
LS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tKw0KSUkuIGtleGVjLSB8IDEuIG1hcmsgdGhlIHdob2xlIHBtZW0ncyBQ
VF9MT0FEIGZvciBrZXhlX2xvYWQoMikgc3lzY2FsbCAgICAgICAgIHwNCnRvb2wgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8DQotLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KSUlJLiAgICAgICB8IDEuIHBhcnNl
IHRoZSBpbmZvYmxvY2sgYW5kIGNhbGN1bGF0ZSB0aGUgYm91bmRhcmllcyBvZiB1c2VyZGF0YSBh
bmQgbWV0YWRhdGEgICB8DQptYWtlZHVtcC0gIHwgMi4gc2tpcCBwbWVtIHVzZXJkYXRhIHJlZ2lv
biAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KZmlsZSAgICAgICB8IDMu
IGV4Y2x1ZGUgcG1lbSBtZXRhZGF0YSByZWdpb24gaWYgbmVlZGVkICAgICAgICAgICAgICAgICAg
ICAgICAgIHwNCi0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQoNCkkgd2lsbCB0cnkgcmV3cml0ZSBp
dCB3aXRoIHlvdXIgcHJvcG9zYWwgQVNBUA0KDQpUaGFua3MgYWdhaW4NCg0KVGhhbmtzDQpaaGlq
aWFuDQoNCj4gDQo+IC4uLmJ1dCBuZXZlciBnb3QgYW4gYW5zd2VyLCBvciBJIG1pc3NlZCB0aGUg
YW5zd2VyLg==
