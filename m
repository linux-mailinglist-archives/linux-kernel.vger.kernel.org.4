Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BA5617C1D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiKCMEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiKCMD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:03:56 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E33513D22
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667477035; x=1699013035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zZId3rfIkn3sgvsWEAd3GfViIq+yaJv99CaOFzD6TWQ=;
  b=LWESxAb7cB3sXz54mVORt3TE8a1CAZJwA9jvohe4+snjETQB9cG6ehjE
   BQ4QJ+YkJR2YG4InnQkB4bVqBxgi4SaGQ/g1bas+mwOJE4g01McBpH95t
   U01K4zST7Ob49gSZYWYTy+fV74VWhiksibnlfKJH08fJHIGueDrnCZR/x
   6Xk5xv6a5+sw2Aa2YyGwyRAs620xfOKLFKZ7DwKNwxcyxZHf11V6157cx
   k1jTVFzfTvIVVllVbeu37c4br2PUEJmb22j1fj0xcGVTDMFxk+clP8Ko8
   Ku0h9q8TPDoTtBNbCzZU2tGOpx9MNAHfdPOIRqFdl7FMTDiKvBuPYz4PO
   g==;
X-IronPort-AV: E=Sophos;i="5.95,235,1661788800"; 
   d="scan'208";a="215399722"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2022 20:03:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RL1p5YvEhF3KSOvT0k5IDF2f5QEWslsMdrlOCmqukG6xOsDCZJASZNqdHvSHO8zppltfzrOMbmGc2kQqM8tg4PR+gKG2TftKXCzsrE0VfcOAtUyHLcRetgnY4Hvt96d6aga53s6S5QsVIkw3/TBLb651jR0uI6rRXmjvSdFAKwg3paCmvSVHFNn7lfixQNqqZKJag6PGFdwYjvihYzInar0NiXplDgIN8ocw9jp+2AzPYwIoshmrCtP6y5apFPKXwuP3wzET/gpcrFEzLiALWsxZFC8GfyZqflWSJoDEQxHgHrnOvpDDhD8VIhRmwxDi9Ur6zVyqPmqUflOuqPxEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZId3rfIkn3sgvsWEAd3GfViIq+yaJv99CaOFzD6TWQ=;
 b=Ya80+I32KPx02Z/V/WCIvKgSSm3+94ZyLRw3E3BTG9SYeN29FdujIoYCvVchK9uC27qzZb8Vwf8CIdAtRHBO4Xl+W4UhkRvMyNZsPEd7KLk1agy72zzEHjlpSlzYVvmyPxOs+sttCWCBMKbdinUxqBwUpZ8XCL/OM7bfHxFtaY0tkR2zjoTINv3w3ciaDgtwzhQABqp8e6xWAC1NpsYD50Ak8jh4LdJ/PdihiXpU8Ho5kfD3VorKhtJxPCm4vr2OGSR8TRtofLePp8NmcOL7q2AwV+mbSeAOMhPAsrkfvfwfJ+Nsu6njO1f7DSI23VCM0GD54jYQfeuWpvWjFykbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZId3rfIkn3sgvsWEAd3GfViIq+yaJv99CaOFzD6TWQ=;
 b=lPE0nqDO5VQnRhA00LZO37OJMfjIIsDy0LlDlDsl7SxSc3lgvMrSPjY9F9z82RxLjnb6L94d0nM8MgGHfov6JjL5Frg0e23T2QWKsnYekCR44641keg0Vzp1oNc7fk937147D3SgA0spskaaRPA29YVv8JmBXryaHzjN+Z3g4sc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8028.namprd04.prod.outlook.com (2603:10b6:208:347::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 12:03:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 12:03:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "jth@kernel.org" <jth@kernel.org>
Subject: Re: [PATCH] mcb: mcb-parse: fix error handing in
 chameleon_parse_gdd()
Thread-Topic: [PATCH] mcb: mcb-parse: fix error handing in
 chameleon_parse_gdd()
Thread-Index: AQHY7R5Hv9STcOO/iUOi0DSYCtFYF64tHm4A
Date:   Thu, 3 Nov 2022 12:03:50 +0000
Message-ID: <162a0579-9584-eb45-f186-40992cb7a5ea@wdc.com>
References: <20221031114417.613612-1-yangyingliang@huawei.com>
In-Reply-To: <20221031114417.613612-1-yangyingliang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8028:EE_
x-ms-office365-filtering-correlation-id: 8797e8b6-c562-4467-a2cc-08dabd937898
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bl3nccqnEsWJAu6pVvqHz3kkKTnLbnhrbdTjpjx1gGrn8iTwW3SVuxc6lP9kNiF2ZSoJQrCFz9RLrw3Dg1qswmRElXv+6Yz8ptzjsS6Doh596JMK6SxL+FGNUQcyaUPhByQVUGWW+dR8crE7Kk4dXEi5aTy8+N/Ujj8VZLMr6vc1je7GUhNK7zlaff6S7GT6xUOR2ZV+4hdQ1pcVtBm7HNms6kvna/sYKWqN3scF9C6Rw7tQlpJGFVexF605Ev9lP02lKtVCYRPZJDINhRfn2/JYWTFC4f87mfln4rlatE2QCD7v+Ye5XHUAuSDCcQvk0Cqevi2RZ7Q5wUa10Kb7paFqf6FWk2jtYOW5eivaty+6dUBWAUjMzZtfNQbPvjjUopep8xb36AC0TVNleU+Sk7nC8gsxuGcUwo6r4E3WPAo27nBWgupuESk75O3svY9dEwFn31leVwMcu93qmRASXXn5fLyQRSNOsHKEdFz8iFKfDdJiK73PTyaACzHb8XZoUzU3aiYrnBcJaQdteunNSwSj4dZE+r/a2m7rg3RjHjfGnb+FvnBvRUrX5vfdvOQCszBnkUde3SdRIlRGQMjWUG4mSvbXsgXfZLw34yFC1Tu26cnPXZsibB+jPYwEbqlQAvsnL7A5AMHaytKIp2a4kggM6XtiuoHJgBP+gU5RUYqKV/5YLJ9Xv6nuGyKSgtqTNUlYVV2n3RX7RaVUX0IKgyo6RVp5YDHBjUGBUwJdm1sO3bx6ZJ1ps2ZOE5wi863X9xhI6LoyWyxlPju6h67bSz73U75DIOkyM7E69DnG9HVDdAibjMTupnca7h9D6CH1ZgRW6s9XnPIH2EZia7OMuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199015)(31686004)(2906002)(54906003)(86362001)(558084003)(36756003)(66946007)(6512007)(4326008)(76116006)(8676002)(64756008)(66556008)(66446008)(66476007)(4270600006)(41300700001)(38070700005)(31696002)(122000001)(110136005)(316002)(82960400001)(38100700002)(8936002)(91956017)(2616005)(5660300002)(186003)(6506007)(71200400001)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFhqT3BkYWFwdCtQWjViUGFGbkxnMDZNNHZsU1hDYmdralVTa3JZdE9sZnIy?=
 =?utf-8?B?WE51a0Q2czBlMkJXNUJJNmRYMFV4YzZ3NnhtMTBtTndWOUk4THZTaWo5aURZ?=
 =?utf-8?B?SmZaNEdXcnhSN2ErMHVWN3N1Y2RiYWNncy9CdHV0N2szam5EL1NlcTRMcllT?=
 =?utf-8?B?QWtKdXhNTkhpbnplWGtCNERHUVQ2OWh5S1JDL2dZUERYTlBMdmZkTFJ4SXpH?=
 =?utf-8?B?aDNOYzN1L1ROaC9TMnlQVTUxUUhEcnRxQ0M0OW1MeC9yNW5ISUJDZmgzT3hV?=
 =?utf-8?B?WEVSZElkVlZLR0F1U1F1WFJSV2dJMnF3NSs3ekZISGhRVkNUYVF1QVRpYTBV?=
 =?utf-8?B?dkYwUmx6ZEYwQUtOQ1RiLzlCWVlkR3lVOWk1Vm5TNlBzRTNRcTdvZlQvUDdD?=
 =?utf-8?B?dHpxYVhER21HanRDcGY1enZDM2NFRE5BMGU5RFBsR2tneXdSSTM1b0h1MWFu?=
 =?utf-8?B?ZzZwODBsdFV6aHRnb09yRE1vRXk2Nm9ranFNNUdsQU1aYnpURTRmVGNGKzdo?=
 =?utf-8?B?ZHNqNGRaK0tjSVJhTzVEVkY3c3JLR2pSU1phS0k2THc4NEtGTVdPMWN2UHJ2?=
 =?utf-8?B?MGpJcnhIMWU0UFgxZzUvbnhyalZjWHFaemxiSzZja1N2VGVtRXQ2d0VLYUpn?=
 =?utf-8?B?Q0l5VmhiRjFXVDZhTUFFL0JnOGkvSzhrT2ZPUjBxK3pBUmxkN003WlFVUzJh?=
 =?utf-8?B?dGk2ZHFlOStONkd2UEExeTEzNVlJM0k4aExORVRPdWUrdTIwNmM2alkwSGxh?=
 =?utf-8?B?aE9mSDZROWRycnRiNTZsRWRNY3ZYcGlTNXdNaUZieDdqalFsaml2S0szQ2ty?=
 =?utf-8?B?bkx2MkVrK2NXeGpEZjRUSC81U3pya3AxRjlIbkpoRXdsYkdRTXc3T0VrQ1Ex?=
 =?utf-8?B?bFpEalNrR1dSRXRBYlJsNnIzRVlGUGhuWnMrTGN6b3krTjhxT2ZvWWxkVHhX?=
 =?utf-8?B?U1kzaHpaV01OZXZFcm5tWDVVWktlaXYvblpuZ0tQRFFPNjRxZmN1Q1FvVW5Y?=
 =?utf-8?B?WkFsaS8vK0d5T1RRcjdwQXQ1amFvNWszTmI4amVVM3BBOWtDU2NWU0NBanBV?=
 =?utf-8?B?TWVFbW91dFVQZVprRC9EM1hhWkNIb01Ucm84QUhtZXhzVGJPUUo1L2tZekZI?=
 =?utf-8?B?dURhc2RxQUY3Tzl1RGwrY2xKMG1rY1dJY0liVkNoMDM1Wk1CdE9teGdra3FJ?=
 =?utf-8?B?Tmo4aXR6ei9EQnNveXFRVGtaeGtmY1ZRUjE4NlhiUTYzTjBDNVIxdml3UUR4?=
 =?utf-8?B?L0tlZG1XaVo5dzc2ZVBKbjVMNkc2Z0xxdHB3ZVlia2s1aFpSTUcyc0FiOVFR?=
 =?utf-8?B?WDhqZHI5UFRqNjBFbEkwRjdGYlFGS05yTDUrVFFWVnBSVXRTczNNTkRWc0xI?=
 =?utf-8?B?WWJXYm0xRXovYksycXF0U0xJR3JoTDV0dFpUdkFSdFpWYm9sUDI1UmhwdUx1?=
 =?utf-8?B?SmhHdllDZG1TN2ZYekhnTlRXNVNxTTVTZTFLNkZvcTJVSldpZWN1Nmd1Mllw?=
 =?utf-8?B?cnVmNEVuMUR3Qnl1T29DM09ndzJJZjd2dlBmeTlVTkxSd0RvN0RsK3E1QWZo?=
 =?utf-8?B?WW1jT1NkUTBMNGhZMGU3dmJabHlLZWw5b3Rkc1N3K0JpcUsrYWVKZFlXejZI?=
 =?utf-8?B?eEd6dFZ1SnNOaEN4OExZZTM0Mlk1ZjBIbDZrSWlGblQ2cDBzNDh3V3ltVHI1?=
 =?utf-8?B?cUtsT1VObEdpbzQ3M2FEWFFSaHUrTEd2dWRNa096WkZmYzRSci9QNGRTcFJp?=
 =?utf-8?B?K0o5dFFKQVY0WWQvS2IzWnVVL1VJOGovVFAvSnV6U1NIVERuTWloUmJHQWhH?=
 =?utf-8?B?ekNkSXQveE1ZcnVNcisxZm1CNzl1NFl6blJ5V3hkdkUxSkJUOUIzZkVpclJy?=
 =?utf-8?B?ZFlHQUkrZzYyanNaZzNzVVpWdjZ3TkRBYncyQXZReVQ2dVJZRHVOMXVaMEVO?=
 =?utf-8?B?N3ZXcHBXSmk2ZjlsMzlLaU9jOEdvdE11bXJuenBnbjhMZ2k2K2UvU1BGRGV3?=
 =?utf-8?B?SlJJTmc2d25iMkZxbFdIcHNrWmY5ZXlIT1lvZjM1aEcyWXZ2WS91NW13eUt1?=
 =?utf-8?B?ZTR0V1YxR05wemcxV3c0ZktKbkpCTXlUOUU3R2xkV0ttS3BiWU9BOHl6bHdy?=
 =?utf-8?B?NUVlZU41NGRFdGk4bElLM1hBVDhOenh2UzBhSFljR1JLemFybkVwbGtlY0J0?=
 =?utf-8?B?NExiOFltSURjMSt3d0ViMGJZWjgvbEFBYnVTRTBHcTl3TnNZcjNnOGw3WWpw?=
 =?utf-8?Q?LwycUiYKvyApTVDM1dhm01eNRfJVB1LR/oo2obBRLo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10EA709F9422114DA295B92D17D74648@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8797e8b6-c562-4467-a2cc-08dabd937898
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 12:03:50.7301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oV8taTauug+ZPPvmGAy3yUkUiHGkwEwCzbtFntTlxerIh7E/Ncax+XEIQrA121d9s8cT4bSDQRFCbkEHNb8oKe3sWm+1d1JaYIaDVR3qUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8028
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGp0aEBrZXJuZWwu
b3JnPg0KDQpJJ2xsIHF1ZXVlIGl0IHVwDQo=
