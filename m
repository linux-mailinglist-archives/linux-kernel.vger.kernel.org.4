Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E68C692F97
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 09:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBKIt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 03:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjBKItw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 03:49:52 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D435CE5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 00:49:47 -0800 (PST)
X-UUID: 075e3d80a9e911ed945fc101203acc17-20230211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sS35CNWcIDxsoVFRfa9OhntM6Ni6xycuqmrSIF+MUbA=;
        b=Zt1HwVXHG5BoluaEekBkgd7MEQua1Bz+BJTECydsZQOCWGlU3TZuzuIHnSu+ikeE5Q+xN7NWJe9j/eapgHUA2D+0jDRwwsdyuzlbSGe+fkY5B5E39JQ7R0a9+2rqiIS+dM5AJd+F2PIr/K4vxouRXt1Dkas5iyS8WQdunLog/U0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:dfedf915-3ace-4ecc-a798-9373201992c2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:216021f8-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 075e3d80a9e911ed945fc101203acc17-20230211
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yanchao.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1062571315; Sat, 11 Feb 2023 16:49:43 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 11 Feb 2023 16:49:42 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sat, 11 Feb 2023 16:49:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRrSA+YDLII2g+XWJ8exONX30HorVgcoM7DLM+EblIMobMEb88TmEWuYgwGLe5hyX5aHiYtV3bhheBMiVSxwraoKBdrMTrDSgP3JeGGS931CtfhtNFuqNWzGSK5AWc3r/6uM6Wj2TIRi9Cs88vDF4QFs0tBmZToJiFZFIZ0MM/tMYheNcHlAy3wCKDUPCF7DcQHs8mWzDUTh6ydf7wuBcGiBf4QdwIVfPdN4Ov/QRqIs8AuQ5tS3h5/xdLBlmv7t+oi95mifAQkmC68DN7iA/b6TdLrVIRTL4UO5sV5bIwC97aLIwDjnuuA/1kYAj5kA2vf6Ln3g0aoA/C0dg8DUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sS35CNWcIDxsoVFRfa9OhntM6Ni6xycuqmrSIF+MUbA=;
 b=DtjeKJxjDy91oC1x3YDg+yeLyhmflWQ1sdFS36kTIw6pGFa3F9JTSWKnk6wDYY+MGbeIThNUUEibS+BE6XO/m8DoGE49o+8BimhIIhpHytzcr4avKVbiwlnPa1mVtv1yzJfkn53pmkqRyNCkv2m4Av3Dre26V6atKe+pQEM1IhEF9Oqk+2vHjsXXqDYq+Boj5qQrscfSHAX1PbWrN0enzU8l6HbhK5F8AEMfKyvhXOwAtCxBK4R5x4RxMwqmm3w8jPATLjOOI33y4VI/oG6UAp32D9RSLVl3wI/FkBYY7is0eS0W1NFEnIwoMYS83dwwiVWv6LEx7XO4i/YMpsSBIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sS35CNWcIDxsoVFRfa9OhntM6Ni6xycuqmrSIF+MUbA=;
 b=NlvTRASc7TZTf1+YHB6JfU3JT6nRFuALYVboOACjnPxmMKm5Y1qzY6uCkIXEL7yyNpV2BkZNUvSp4UdibS301l0ra5hmT1oZqUzezNnNDZr0Un9nVeZp1/QAd0k+Q+pV1LeR2SR/rIT7zFpEXiJab9F5zMWE08iOmzAf8ztfHAU=
Received: from TYZPR03MB6161.apcprd03.prod.outlook.com (2603:1096:400:12c::13)
 by PSAPR03MB5767.apcprd03.prod.outlook.com (2603:1096:301:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sat, 11 Feb
 2023 08:49:40 +0000
Received: from TYZPR03MB6161.apcprd03.prod.outlook.com
 ([fe80::87ff:96c1:183f:4dfd]) by TYZPR03MB6161.apcprd03.prod.outlook.com
 ([fe80::87ff:96c1:183f:4dfd%4]) with mapi id 15.20.6086.017; Sat, 11 Feb 2023
 08:49:40 +0000
From:   =?utf-8?B?WWFuY2hhbyBZYW5nICjmnajlvabotoUp?= 
        <Yanchao.Yang@mediatek.com>
To:     "kuba@kernel.org" <kuba@kernel.org>
CC:     =?utf-8?B?Q2hyaXMgRmVuZyAo5Yav5L+d5p6XKQ==?= 
        <Chris.Feng@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TWluZ2xpYW5nIFh1ICjlvpDmmI7kuq4p?= 
        <mingliang.xu@mediatek.com>,
        =?utf-8?B?TWluIERvbmcgKOiRo+aVjyk=?= <min.dong@mediatek.com>,
        "linuxwwan@intel.com" <linuxwwan@intel.com>,
        "m.chetan.kumar@intel.com" <m.chetan.kumar@intel.com>,
        =?utf-8?B?TGlhbmcgTHUgKOWQleS6rik=?= <liang.lu@mediatek.com>,
        =?utf-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= 
        <haijun.liu@mediatek.com>,
        =?utf-8?B?SGFvemhlIENoYW5nICjluLjmtanlk7Ip?= 
        <Haozhe.Chang@mediatek.com>,
        =?utf-8?B?SHVhIFlhbmcgKOadqOWNjik=?= <Hua.Yang@mediatek.com>,
        "Xiayu.Zhang@medi" <Xiayu.Zhang@medi>,
        "ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>
Subject: Re: [PATCH net-next v2 08/12] net: wwan: tmi: Add data plane
 transaction layer
Thread-Topic: [PATCH net-next v2 08/12] net: wwan: tmi: Add data plane
 transaction layer
Thread-Index: AQHZKzJnz2yD50jcZUGHCVYMX1nNq66mrsAAgA54eICAAk7WAIASHxqA
Date:   Sat, 11 Feb 2023 08:49:40 +0000
Message-ID: <4e7b6cc0c5623f8ed26a913ad16ee0b49a07c825.camel@mediatek.com>
References: <20230118113859.175836-1-yanchao.yang@mediatek.com>
         <20230118113859.175836-9-yanchao.yang@mediatek.com>
         <20230119195210.03537a93@kernel.org>
         <ea8001238622a81bfb89dbdc35a6604914a4d052.camel@mediatek.com>
         <20230130120540.6ef059a3@kernel.org>
In-Reply-To: <20230130120540.6ef059a3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6161:EE_|PSAPR03MB5767:EE_
x-ms-office365-filtering-correlation-id: 11e6cd71-19d9-4940-d79f-08db0c0ce9bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BFmtkKVO6RLocbPg/KWG7xCBtqnh8f9x1IQ5BjST8Wzd98Mmv7Nw5BF2ZXwNuVk9suWsQ0W7fkHmtMdyM41lhPcQF03HVLAJkwhsk1FtJQqfQHEf1FaRlk4ATsqLqq3GsnjXr9NXiMVXAdcuXXn2QiqV7mIqycDhcW+TeU7gXkjdeH1SZffzCU777Z2catQRyFY8KB7/R9GrxeKuNMyXaGOSVQt8nYSQpUHrkh7lYkFkahaV3cnKzSRhrpsl33NM4ec2spvmK/ZL7fdUwjkiCkIP+8U2/tMEAGjHLDgto2RHJRW5nAs47dsAJxlYvZmx0FjQz2cvsQFTyNVb7+6ZTxk0qS0mLn+CIFxPSrbFHMsOCiCJxunOOcbQW1YCSuKBs5rg4H+oeJ89bm/MQuggL2iTnsE5hYErw4iUAoKTY9ynVb4pSAEvI/ge/QZzcgXEgjql69A8aP8ul7hNOHxwxceQQt46aKnWbuOWCzRYIq/HyeqiMcCRVyRfhUbSDnVhcEahDU6Y7QtdboQejp81f/nAPphwNqnRy+UdIIuMjyKx2UuNTy4BjJW1p4hcZRNbrhaR8ZkB2garCpGetmjKueWoS5PeuKpDxH26bHzZFTQBFydZxMfzR2vJSJso+OBaYSORura2UId2fohtnxTtn1bMAHXgfuSUiB9KVIimOtgflWhgVCUmqnx86ryTUZJPEqZ+NeCqQf7NAuayNWHidbYc0Xsk31EtRfPqj27N54A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6161.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199018)(85182001)(86362001)(8676002)(36756003)(38070700005)(4744005)(8936002)(41300700001)(5660300002)(76116006)(66476007)(66556008)(4326008)(66446008)(6916009)(64756008)(66946007)(122000001)(91956017)(38100700002)(316002)(54906003)(83380400001)(71200400001)(6486002)(478600001)(2906002)(2616005)(26005)(186003)(6512007)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUpKeXdrYkFJK1oyMGlmVjJVakw1SlZWLy9aaG5aSXFueVhtSjlzZXVyMWVF?=
 =?utf-8?B?T0NLbjNQb09KMXhORE5ZcHF4NFNMNVVMNUxnWXN4WTgxTnZ1ZmNsUDlyeDBQ?=
 =?utf-8?B?b0tEUjhLaUdacXQxVzRhaWVDNmdIRlQyZHFxOGUzRnZqYU5VK3kyaFpwTHF3?=
 =?utf-8?B?SU93eFhuai9manhpZkVTUUhUd285eGhxSXR1SHJBRWxMUWxjVDgyRmt0am85?=
 =?utf-8?B?K2hsUzV2YTZrWGlpdkIzcXc4WjEyQ0lXM0FVMW94anQ0ZXJ0dXc1S1BtazZN?=
 =?utf-8?B?aS9Cd0w2R1VxOU1UcXVIZGdnME40Y1RhQlZLaDdIcXo1Qk5nMmk3ajNmU2Fk?=
 =?utf-8?B?dGRoNjhpSDVab1JYd0xEZ2R0MnNtSkloS0FYb24rTE5iaFZaSHg0Zkd5OFRl?=
 =?utf-8?B?Qit2VmNtTnIrNU1xMExGRjRzdmFnU3hpaGpXeTIySTdSN1BsMDZXQWJFSWRO?=
 =?utf-8?B?dDNSSTJ6dHNFOWM0aW0zQVVGNEplSFVLVW1VcFp5Z1cvbERBc3B2OHhmRkVo?=
 =?utf-8?B?RytXN0lrdDMzT2FzUitRZm9ra3NuT0orbW45aHVXOHl5eFk5b3JDeFFmYUoz?=
 =?utf-8?B?NThCR1h3cE5mWUswaGY1ak1HT0VHeVQyVWVHN0VTdS9CZ1VGbG5FLzFtdWIr?=
 =?utf-8?B?eEZWKzNSNjhqVWVKS1ljUktkemVpK3JvUDYvNU5UaEdtNUowQXdtNXVZdEpR?=
 =?utf-8?B?NkFIdjZ4UXM3RXlsb0dkd1pTd2tRVVE5eUZVMFRKaEIra3lyZWpVQTA4OUJW?=
 =?utf-8?B?WE1rWW9JOWV2Sm5QZnhMQjlTZWlvSmg2UW1rYS95TDNoeHk1bXdIU0tkZlBj?=
 =?utf-8?B?STlhdUlCeHdrdVc5VUt2VmozVWI0dTdteHlyVFpDMHpndHJxWXFYVjVYQzlo?=
 =?utf-8?B?N0dRcDZIa3JNR3hUc21pM3Y2WDRmanU4NUR2Tk1YaGVldWRvbFJ1NUptTU5P?=
 =?utf-8?B?WFRoLzVFbjNiV3ZHOCtmT0JKRWtqYkcyTmswNTVrUE1jVldZM2ZHeDJoSkJs?=
 =?utf-8?B?c2Qya0RjZGd1YmxCd29JQnhwdlFtMVc5VUtqc3B3UENLS1FRVU44djFXMjFI?=
 =?utf-8?B?Z2lzOTVCOW9wa1czYjdvNXpybUg4T25oTlVQQmdjWUl2WTB6akVpSURCNlhs?=
 =?utf-8?B?cTBEZ2IzL1ZqN2FHRTdwSFZJTW40QzYxMkpqQUV1WFJTZ0puYWEvTEppZjA4?=
 =?utf-8?B?VU9yQUJEekVjTnZob1V3ZXF0NHk0ZG5mLzk0S0tuY1BqTjF0WE5rZm02MVBN?=
 =?utf-8?B?bVRhUTRHQnUzeFo2WHJXNzE2VXEraE8yMHdNOE5CRHVsOFFmU3JlT3RsWmEz?=
 =?utf-8?B?bkJ0ckcvT0RlQmx4cXR3L3V4M0d6UHZDcDgvRkNmQ3V1TEdGQU9ZY2lQT2M3?=
 =?utf-8?B?emE5WThKVkdkaWdkNW56dVRGUUh2cURjM1Q4ZVdlbW1oSVpmcmNUc05tV1Ew?=
 =?utf-8?B?ckc3QmxHdVFqSXlXZms0dUM2NnM3bnFyQndTM2Vaa2NyejhVeW9TUk5vTnFr?=
 =?utf-8?B?aHUxekhRYlR6ZDNLb21GNW9ZV3JNZUxPTEdMRG1wYVNBYlFudjVtVVVlTXZq?=
 =?utf-8?B?UE1EQmRETFpiMmRtNktOUVBUSlhvZkROS1JSNUlsaExjSXJNYkFUTzJWa2V1?=
 =?utf-8?B?UU1KeHdna2ZVQ0FQajhxM1ZVVmU2ZmVOTndwSENKMmZ3ZFRRSVRQSHBaRGc5?=
 =?utf-8?B?Y0MyWFpmWXI1TDZ1SG44ejhmVXNpWXkwYWEyUU1xbDZtRjJTbjcwTXhEb3BS?=
 =?utf-8?B?Ny9jeWgyYXIwa21TK1F2MFhQM2JHWFlPcVVvNFhFMllYdkFEN0Z4ME9WajJt?=
 =?utf-8?B?UGltUnFFc3NibzlRemE4dHBqWVpnMFhUWisvNi9zQnB5OUNoRk9GU29ydEpp?=
 =?utf-8?B?OEZ3dUF3L3FtQ1MxK09rNUR3eUxLbHBiZUlrejFmWjNiamdieGw4cnp0aEFL?=
 =?utf-8?B?SlJZZzRiak9uS0FwUWdIRnVMcjRZbzBraFduMlMxTFN1aXJpaFVCR1pwTDZh?=
 =?utf-8?B?bEtiZUNoSG9aaSs2aklhb041OEtQQ1BIbUlJM3YzTStNZXRzZ1RORzZSL3NL?=
 =?utf-8?B?TGRIRXFyK0xBNE9oYmZCNXlkME1hTlR0T2lEdy82dU9Yd0JWTm9WMUJKTk9t?=
 =?utf-8?B?cUxoNENiSFRYL3hWK1liamNnTk1ZdFhpYWhwK0RRd00wbFkyc2VNU2hvL01t?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72533F8DB0496D4685B404B32C1356F1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6161.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e6cd71-19d9-4940-d79f-08db0c0ce9bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 08:49:40.3508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzwSTWJpqbgezcvnslr/k/6Z1p8vkRBtcPP0U5l7J8/p2gxO1ijPsMyN0KeLkG9CwHr+kXdm6xCqdYvJ/5uUF0vnJqa88UJWcrnNSwjUO4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5767
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTMwIGF0IDEyOjA1IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gU3VuLCAyOSBKYW4gMjAyMyAwODo1MTowMCArMDAwMCBZYW5jaGFvIFlhbmcgKOadqOW9
pui2hSkgd3JvdGU6DQo+ID4gPiBQbGVhc2UgdHJ5IHRvIG1ha2UgdGhlIHNlcmllcyBzbWFsbGVy
IHRoYW4gMTcsNzcwIDovDQo+ID4gPiBTdHJpcCBzdHVmZiBkb3duIHRvIG1pbmltYWwgd29ya2lu
ZyB2ZXJzaW9uLg0KPiA+ID4gSSBkb24ndCB0aGluayBhbnlvbmUgY2FuIHJldmlldyAxN2tMb0Mg
aW4gb25lIHNpdHRpbmcgOi8gIA0KPiA+IA0KPiA+IFRoYW5rIHlvdXIgc3VnZ2VzdGlvbi4gSSBh
Z3JlZSB3aXRoIHlvdS4gQ29uc2lkZXJpbmcgYm90aCB0aGUNCj4gPiBjb250cm9sDQo+ID4gcGxh
bmUgYW5kIGRhdGEgcGxhbmUgYXJlIHRoZSBtaW5pbWFsIGZ1bmN0aW9uIGZvciBUTUkgZHJpdmVy
LCBvdGhlcg0KPiA+IGZ1bmN0aW9ucyBjYW4gYmUgcmVtb3ZlZCBhbmQgc3VibWl0dGVkIGFmdGVy
IHRoZSBpbml0aWFsIHZlcnNpb24gaXMNCj4gPiBhcHByb3ZlZC4gVGhlIHdob2xlIHBhdGNoIGNh
biBiZSByZWR1Y2VkIGFib3V0IDJrIGxpbmVzLiBJcyBpdCBvaz8NCj4gPiBPcg0KPiA+IGRvIHlv
dSBoYXZlIGFueSBtb3JlIHN1Z2dlc3Rpb25zPyBQbGVhc2UgaGVscCBzaGFyZSBpdC4NCj4gDQo+
IFNHVE0sIHRoYW5rcyENCg0KSGkgSmFrdWIsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBzdWdnZXN0
aW9uLiBWMyBpcyBzdWJtaXR0ZWQsIHdoaWNoIGhhcyAxM2sgbGluZXMuDQpJdCdzIHJlZHVjZWQg
NGsrIGxpbmVzIGNvbXBhcmVkIHdpdGggVjIuIFBsZWFzZSBoZWxwIHJldmlldyBpdCBhbmQNCnNo
YXJlIHlvdXIgYWR2aWNlIGF0IHlvdXIgY29udmVuaWVuY2UuDQoNCk1hbnkgdGhhbmtzLg0KWWFu
Y2hhby55YW5nDQo=
