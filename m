Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE266865ED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjBAM3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjBAM3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:29:17 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E645954C;
        Wed,  1 Feb 2023 04:29:09 -0800 (PST)
X-UUID: 010b99d8a22c11ed945fc101203acc17-20230201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EO6EYUIDrvW7s10ulS3UYo0/OavRnuollGF2eEaxZ6o=;
        b=BdFoFyRoZdI4+dlcyQzjfEKCNZFWlB1R1LNvMi07Yee0UofTCo9dW6WnDfv4q8towsX7RGof9W3GHKOqsX8Zi/lZkFNc6ppqCtHHkmlU9J6WShidq5OvHOtWk3vgNruM1rUOQ9cXsprH4IHfSCj7DrHS1E12Rim4Cer5JKAPdQQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:c4ef54be-b953-4f7c-a4cc-16c417ad681f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.18,REQID:c4ef54be-b953-4f7c-a4cc-16c417ad681f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:3ca2d6b,CLOUDID:eef326f7-ff42-4fb0-b929-626456a83c14,B
        ulkID:230201202902UAP9B61C,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0
X-CID-BVR: 0
X-UUID: 010b99d8a22c11ed945fc101203acc17-20230201
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1593558678; Wed, 01 Feb 2023 20:28:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 1 Feb 2023 20:28:58 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Feb 2023 20:28:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvfZ1yGOS3qP/T5eJ2xLvW9i1uRDNh4uXNqSwek4B8hXaixd6KBGHCm4F3dvcZ6x6Pagv0tuq6dDZu615dluB6Zxwf+gO/GZS9fsPpoayExr/JqfK1AVhTnoGHaluZFxVRIV6t0m3kZQux2sCeaJi2Glec1W41nKHTPUM9EvRbmAt6hIveS9G9836SJ5hwgl4tStLPLUS1F/jt4qXkfWgrbUN5yXgfDsH3HMN/amaq99el5STpIZhcLkaHarxTe+XcZvon4UAT76gdXXTGCyDbLaGn7ETgG33CW83xnKJoALJtoM3932Vpg2t0s+W08igh7s9im1d8jpRDj+dy9nkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EO6EYUIDrvW7s10ulS3UYo0/OavRnuollGF2eEaxZ6o=;
 b=K4LpdDJn4zdeyERGq4jw9xVqpMFT4b2fdPgV/6tSScAbJHoUCGDGSzUq9DiXxPABm9mGOD9mQi6pgpQ2b++wejoT5ngWrG4svba/V/IQUJO3NRZDChWgN6xQfsyocP64IN0mX5Pc+rwahzixfag0ZSmB9/rSXXAefQGhSxIvos5N2MXRpRvVOur5ESJqL4HEPacrYGFWEWnuAD+GK1E66HhRS/YIeh+SIK8zdkyH6V63YEFa6w95JEY05Y0KN1QeDXF1o5qfcsqVNWShbcke0N2e0VH8HXXhmIFLaGxEtigVUvKDVE7ocm1aRXC//kUVa0yDmZjCp1hJ3g202SuJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO6EYUIDrvW7s10ulS3UYo0/OavRnuollGF2eEaxZ6o=;
 b=MvYqOROo6Jqa2pLnGsywXoeZQPHK4S+vgTwda59Dnu3OPL6VM/q3aaN99W9LP87KXRocP91lftRj4f0PpcZ8aYqJg3LqmC1Lf6V41ww4rq3inOTTsualf3FZVPpaaap9X1suXcGAEXobMgJx/gNBQEwU0HoVOtMZYSKy3cbbTZg=
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com (2603:1096:4:26::14) by
 SI2PR03MB5532.apcprd03.prod.outlook.com (2603:1096:4:12a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.23; Wed, 1 Feb 2023 12:28:57 +0000
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::42eb:28a2:4d2e:d051]) by SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::42eb:28a2:4d2e:d051%5]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 12:28:56 +0000
From:   =?utf-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>
To:     "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "drinkcat@google.com" <drinkcat@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>,
        =?utf-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>
Subject: Re: [PATCH v4 05/14] soc: mediatek: mtk-svs: use svs clk control APIs
Thread-Topic: [PATCH v4 05/14] soc: mediatek: mtk-svs: use svs clk control
 APIs
Thread-Index: AQHZJZDHI+SQIEhX8UKhJMQ/hdyBe664ohSAgAGESoA=
Date:   Wed, 1 Feb 2023 12:28:56 +0000
Message-ID: <546d7f2b3607310f0ebe11b3d4e0aac40ac44c7a.camel@mediatek.com>
References: <20230111074528.29354-1-roger.lu@mediatek.com>
         <20230111074528.29354-6-roger.lu@mediatek.com>
         <5192bc94-12c7-dce4-c2e6-fa4b8c1ced9d@gmail.com>
In-Reply-To: <5192bc94-12c7-dce4-c2e6-fa4b8c1ced9d@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3434:EE_|SI2PR03MB5532:EE_
x-ms-office365-filtering-correlation-id: 8bba8036-821d-4580-83df-08db044fe352
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y9ZwWNgjkmB7ZEpil1hKc1y+HdsB1aIwKN6XJfaYZ55WGNoLAdQigPyO8miukK+lYpUZJaERz3cEZAcJ2CqQD0NXmiGQf+XNJWG8OqPF06d6G8cflseZwMwbkmZOOTg78EAGX6GpRq52XoM8Aa27iJDISiIzUsnw2TrV/0A0UlfV5b9s47VU05cElVEQkE+H44iYb+cYVPERuxpZJ1wdvlQ+fmUFdWTtZ4NCVHr3WUeSgw742erLEo5Q8w99kX0/no9PaWQsaeX+RQAhW0ygMkrxPmAs6YHSlDEZFAty3rYP0W3xklfvvEQYIvu+FRqh98RYbK2Yw5q/3FieIT/FyGFe/mlS4n9Uw69DJrCR5FGG2I0jsWG7TDVBsR/xKtwIHe4xalDm3evO5GmReDxfTyplK8+rpA/pY0BHd0s2XpJr/DIDF80oEn4x7L6BZy3m73Aph1uUWiqglxuHgeHM6ahf1HhiBb1LEbxOOux/mLw1qQCanE1uYoU8SAGHe2f8bvLklNfRRXksuQfbzdBokg/WNsTUVh7qUkk31grfI7k28nC+KvP/ZX6x7mfWRJTb+5JUGlkvQjGJ3l3pcBG6Zfb4sCB0+kwES9A8sGgiLduWUb1PvPlqENCh9S+WQtRobkKkvJ1GcSv4pvfwwnO4L6Q2Io4sqc4wJrPe8nw9Px6obFV+ruKJWvuf+rea1iTzvZRB3MosJfeSondasSbinA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3434.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199018)(5660300002)(110136005)(54906003)(7416002)(85182001)(36756003)(316002)(8676002)(38100700002)(66476007)(66556008)(41300700001)(66446008)(66946007)(122000001)(64756008)(76116006)(4326008)(8936002)(38070700005)(53546011)(478600001)(2616005)(6512007)(26005)(6506007)(107886003)(186003)(86362001)(83380400001)(6486002)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUpwWlp3QkpZbTA1VFA5REhOS3hvTG4rMVNua3gyY25VNVZsbWhkZ3AvNWtG?=
 =?utf-8?B?c1h5RmZ0S0RZNjN4QUpoQVZQNmVSVUN0M21HbEVZVmhtcUZYaE9XSFJmNkgz?=
 =?utf-8?B?c0dTem9wc0FWS05OMXNTVGFIK1JCZkNBSVJ4NlQ3QjkvQlk5NWVScVk4R29B?=
 =?utf-8?B?VFpIYkc4Vm56dVpZbS9aMGUwQWNnWDhEUGZnMElsMHNlbUFzY0VaZ1FGVWxW?=
 =?utf-8?B?MWltb2RJSWtvRE1RbTBpczdVUlduZW1JdDdrRld6UFNSRTFZTUp6RDlDRmZB?=
 =?utf-8?B?RnkwaExtbnhxSk5nY0dJTnlOVjlYcUhjdFVKY0JQbC9HbTdZeHVRN2RYR0Nh?=
 =?utf-8?B?dFNpaUVMRlE5MUFxOVlHeWJYV21xazg3c3J5enY4N1d5VUJxcGxuQzlqTkRx?=
 =?utf-8?B?MGFnek1hUDhhZ3RPcGJMTTVWY2k1cHNDT3VkMTVsbWYzMFB3RVdGY21qQVh5?=
 =?utf-8?B?UFVkTDUwZ2t3cE5QRjNHTG9DKzhOM0pLcnkxNHJNV1pwRWtIbDRVNVpVcFRJ?=
 =?utf-8?B?YkJpaklkTTZpWExEOVJCSzhjMTQ3VFVRblNieDF1cG90Qyt0c1piTkwrZ25n?=
 =?utf-8?B?T0VWd1krKzhZd2xGQ1I3NDBjQkIzRWJOUGkvVXpIeU1XUGxxTk00dzVNYUEz?=
 =?utf-8?B?dmVwMkxPVWpoS3Q5Vnk2T2RvVTlzQUFpdlduazgxZUNmaXBydXZVcHBUZ1Zm?=
 =?utf-8?B?RXZnU2VzemFMbERrTTFDbURVVTgwZ0puRUE4V29lQnJBWEtqd3h2NnB2OXBt?=
 =?utf-8?B?KytHVjZ0QWhqbDNCUzJTM1VNN2lVWVgrMFhsajBRbVBnOThhekpIaEY2d3J5?=
 =?utf-8?B?OHFHai9JS0g0dk9PbEYrZWRSN2h4MmlxclRZMmEreVFLUkJIZ242cXdXTTY0?=
 =?utf-8?B?ZnZibDU5dW5yMCtuME9ETko1SGc3TTc4TjI3MFY1MVRMWUJ5OXIyaitVWFJU?=
 =?utf-8?B?UDhyVWh5SlBUazJBTWhKZmcyUm8rRk5McU1XOVNwL2pUdjNLeXJFMVY4ZHNH?=
 =?utf-8?B?ZmQrMUkrZ3JULzBjT1E0NHdrUFNlOVYrRFFldEp1bXB0TmozQXF0VlhOSEVN?=
 =?utf-8?B?aTJ2R3AxLzVPOXVzSHBMTm9ZMG56MkpScTNSalhnTmYvdFdTVC9MRHc2OUFX?=
 =?utf-8?B?b2ZiRlZqMWFJT1hGZnh6VFIxb3RrbjlCai84OTY1WFkyZ3JyUzFiVjBaRGFj?=
 =?utf-8?B?cVNZeFBOcGxNSUtYV2RlT0ZiUTFlNDhuSzlBWFBpd0I3MUErVHNaVTJhY3k0?=
 =?utf-8?B?T2hsc09pdnBXcmZzanYvMjZvcEVZQ0RmdnkxZTJsdUFXakJuMUJGQlh6bUhP?=
 =?utf-8?B?ZXljZkU3a1NSaVV3SGx5b2dDbVlsSW52NkdxVHplUVZ6dmlLNXFWcXJ3aVRG?=
 =?utf-8?B?aVJmdVlURXR1MzF3Z1hyZDY4TkFyaldpWE5pbDZxRTZiZTBZZnZmcVFuZDFW?=
 =?utf-8?B?Z2o0UzIwZnIrYzBGSmhpazk2WktRVXU2eDVIVUg2QlBvTmJ3b1hHeDA1TCsv?=
 =?utf-8?B?bHZ5MDk5Yk53d1NoOXhZQ1RxQWhIZGhuaGgzVnV4MzZkaEZyRW5CbGRsN2xV?=
 =?utf-8?B?TnpQNkM2SFp3Y0dRUVRzMitrNGc3bmRIcGE5aUx2R2NPUWlQaGl1TXBRUlRo?=
 =?utf-8?B?TndKWVArVGRZSFpJUmMzOVpxcGJpTkpxd01LRkRPbndKMGgzL2lKeWd2TldR?=
 =?utf-8?B?NkZFRnE0bnB2bHNlSHpQM0x6Wko3TXpjckFaUXdnNktrYmlaNkt0QUFYdXZu?=
 =?utf-8?B?RmFWT2c2c2dTOHVqZHNWQ2hVbnd2SnRjcFYyVHNsdGlwSlRnNFhIcWZwRk1D?=
 =?utf-8?B?ZHpCV1dNQUx5SmRGM0N3ZCtuUWg0dzBLN1BxTlVIUmZiVlVWMDRFVDBXTDFv?=
 =?utf-8?B?b3lFWWVzRFZlMjRtWmpneVJaV3JLU3kyTnd2d0xGVWd5US9JbEpTMXJRcng4?=
 =?utf-8?B?cXJHYW9zOGFRQW9CNFhiTkxKVGpFSWYzeTZqS2VkS3NzT0dEL3dYOHViNkN0?=
 =?utf-8?B?RkhiaUNYL3d1OFpmSi9YQ2pyNUd4d1dBWWJndW13dEFaQTlJK1lyQmxtZVVF?=
 =?utf-8?B?SVdwd24rUVVtSUN1Y0RTMlVidTlXZHJzNk4raGJhUTA3V2l6YktYNFI2Y0xl?=
 =?utf-8?B?Rzk2RlZTb1RSTDZScDR1RGtIcjVUUGpBakhJVHArVC9ZQkl6TENVMXRrY3lQ?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8593800D44B1814CA7D73FB406111AA3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3434.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bba8036-821d-4580-83df-08db044fe352
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 12:28:56.5664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i2tpvl39U02Bim/0rs/njRaAZWzpTM5Fp48vArtGbfRXZcN7ex17aZBhKbQ2SLLanqPozhbukGMw2dHwxhoyEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5532
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMgU2lyLA0KDQpPbiBUdWUsIDIwMjMtMDEtMzEgYXQgMTQ6MTkgKzAxMDAsIE1h
dHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+IA0KPiBPbiAxMS8wMS8yMDIzIDA4OjQ1LCBSb2dlciBM
dSB3cm90ZToNCj4gPiBJbiBNZWRpYVRlayBIVyBkZXNpZ24sIHN2cyBhbmQgdGhlcm1hbCBib3Ro
IHVzZSB0aGUgc2FtZSBjbGsgc291cmNlLg0KPiA+IEl0IG1lYW5zIHRoYXQgc3ZzIGNsayByZWZl
cmVuY2UgY291bnQgZnJvbSBDQ0YgaW5jbHVkZXMgdGhlcm1hbCBjb250cm9sDQo+ID4gY291bnRz
LiBUaGF0IG1ha2VzIHN2cyBkcml2ZXIgY29uZnVzZSB3aGV0aGVyIGl0IGRpc2FibGVkIHN2cydz
IG1haW4gY2xrDQo+ID4gb3Igbm90IGZyb20gQ0NGJ3MgcGVyc3BlY3RpdmUgYW5kIGxlYWQgdG8g
dHVybiBvZmYgdGhlaXIgc2hhcmVkIGNsaw0KPiA+IHVuZXhwZWN0ZWRseS4gVGhlcmVmb3JlLCB3
ZSBhZGQgc3ZzIGNsayBjb250cm9sIEFQSXMgdG8gbWFrZSBzdXJlIHN2cydzDQo+ID4gbWFpbiBj
bGsgaXMgY29udHJvbGxlZCB3ZWxsIGJ5IHN2cyBkcml2ZXIgaXRzZWxmLg0KPiA+IA0KPiA+IEhl
cmUgaXMgYSBORyBleGFtcGxlLiBSZWx5IG9uIENDRidzIHJlZmVyZW5jZSBjb3VudCBhbmQgY2F1
c2UgcHJvYmxlbS4NCj4gPiANCj4gPiB0aGVybWFsIHByb2JlIChjbGsgcmVmID0gMSkNCj4gPiAt
PiBzdnMgcHJvYmUgKGNsayByZWYgPSAyKQ0KPiA+ICAgICAtPiBzdnMgc3VzcGVuZCAoY2xrIHJl
ZiA9IDEpDQo+ID4gICAgICAgIC0+IHRoZXJtYWwgc3VzcGVuZCAoY2xrIHJlZiA9IDApDQo+ID4g
ICAgICAgIC0+IHRoZXJtYWwgcmVzdW1lIChjbGsgcmVmID0gMSkNCj4gPiAgICAgLT4gc3ZzIHJl
c3VtZSAoZW5jb3VudGVyIGVycm9yLCBjbGsgcmVmID0gMSkNCj4gPiAgICAgLT4gc3ZzIHN1c3Bl
bmQgKGNsayByZWYgPSAwKQ0KPiA+ICAgICAgICAtPiB0aGVybWFsIHN1c3BlbmQgKEZhaWwgaGVy
ZSwgdGhlcm1hbCBIVyBjb250cm9sIHcvbyBjbGspDQo+ID4gDQo+ID4gRml4ZXM6IGE4MjVkNzJm
NzRhMyAoInNvYzogbWVkaWF0ZWs6IGZpeCBtaXNzaW5nIGNsa19kaXNhYmxlX3VucHJlcGFyZSgp
IG9uDQo+ID4gZXJyIGluIHN2c19yZXN1bWUoKSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogUm9nZXIg
THUgPHJvZ2VyLmx1QG1lZGlhdGVrLmNvbT4NCj4gDQo+IFRoYXQgbG9va3Mgd3JvbmcuIEFsdGhv
dWdoIEkgZG9uJ3Qgb3V0IG9mIG15IG1pbmQsIHRoZXJlIHNob3VsZCBiZSBhIHdheSB0bw0KPiB0
ZWxsIA0KPiB0aGUgY2xvY2sgZnJhbWV3b3JrIHRoYXQgdGhpcyBjbG9jayBpcyBzaGFyZWQgYmV0
d2VlbiBzZXZlcmFsIGRldmljZXMuDQo+IA0KPiBJIHdvbmRlciBpZiB1c2luZyBjbGtfZW5hYmxl
IGFuZCBjbGtfZGlzYWJsZSBpbiBzdnNfcmVzdW1lL3N1c3BlbmQgd291bGRuJ3QNCj4gYmUgDQo+
IGVub3VnaC4NCg0KT2ggeWVzLCBDb21tb24gQ2xvY2sgRnJhbWV3b3JrIChDQ0YpIGtub3dzIHRo
ZSBjbG9jayBzaGFyZWQgYmV0d2VlbiBzZXZlcmFsDQpkZXZpY2VzIGFuZCBtYWludGFpbnMgY2xv
Y2sgIm9uL29mZiIgYnkgcmVmZXJlbmNlIGNvdW50Lg0KDQpXZSBjb25jZXJuIGhvdyB0byBzdG9w
IHJ1bm5pbmcgc3ZzX3N1c3BlbmQoKSB3aGVuIHN2cyBjbGsgaXMgYWxyZWFkeSBkaXNhYmxlZCBi
eQ0Kc3ZzX3Jlc3VtZSgpLiBUYWtlIGFuIGV4YW1wbGUgYXMgYmVsb3csIGlmIHdlIHJlZmVycyB0
byBfX2Nsa19pc19lbmFibGVkKCkNCnJlc3VsdCBmb3Iga25vd2luZyBzdnMgY2xrIHN0YXR1cywg
aXQgd2lsbCByZXR1cm4gInRydWUiIGFsbCB0aGUgdGltZSBiZWNhdXNlDQp0aGVybWFsIGNsayBp
cyBzdGlsbCBvbi4gVGhpcyBjYXVzZXMgdGhlIHByb2JsZW0gbWVudGlvbmVkIGluIGNvbW1pdCBt
ZXNzYWdlLg0KDQpzdGF0aWMgaW50IHN2c19zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCnsN
Ci4uLg0KCWlmICghX19jbGtfaXNfZW5hYmxlZChzdnNwLT5tYWluX2NsaykpIC8vYWx3YXlzIGdl
dCBgdHJ1ZWANCgkJcmV0dXJuIDA7DQouLi4NCn0NCg0KPiANCj4gUmVnYXJkcywNCj4gTWF0dGhp
YXMNCg0KLi4uIFtzbmlwXSAuLi4NCg==
