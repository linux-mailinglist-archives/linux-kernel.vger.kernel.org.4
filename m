Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C285F6A6B69
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCALKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjCALKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:10:13 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027113867C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:10:04 -0800 (PST)
X-UUID: 9cb89376b82111eda06fc9ecc4dadd91-20230301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=O2WzMx0ArZitOyvBrS0o+kbTJn0qnyw4jpa3bcgqE7I=;
        b=WLpBwwDTE2xuGGIyBdRT19mRRgFYAClgc7tYPwzbvmX2DU2JGy40twX781oKgVLO4HtmZhE4VAMz+qbL6yr2pA053KsngexjVMV7hDYjXi+o1oxTmuXBRC3025uLGsIP6Atg1h4z5GKdayYzYLIfUXjnNHvs35+8e4mc4fsRiS4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:15e3aa50-a124-4947-95fc-c4eaf1d923a9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:25b5999,CLOUDID:a733deb1-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 9cb89376b82111eda06fc9ecc4dadd91-20230301
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1276757335; Wed, 01 Mar 2023 19:10:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 1 Mar 2023 19:10:00 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 1 Mar 2023 19:10:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZPrubQ0Tbz8BUrNBP5J8EnBBq7HCkSS0gk4HH89Mm+vdxAqDYB6lJtcElXF7bIOGjAfCLXFK2M5G3v+11Rp1NmBMg7KUWEqAb1E6PCRaFlqvW5AW7mRsacYsk//wkjGCL+2HR0prR3jHIHVlqH2W4kb3u0I+4p4i1nGtX3hWamVgiBoAYOUmz2EjZgEjQCxecG85LxbDy6g//u4LFxCe5rQyL9JD+xkGgffAnPppK6TIz9BNIcze1uKRxlSXgi5Tgc+UijhrxpnVp8c1We+3gzkGWxAfqquhWtXafiauX3LPYII1JJu8ngrzNEhBGwFd4VpSOCdANhU2ymNa+gqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2WzMx0ArZitOyvBrS0o+kbTJn0qnyw4jpa3bcgqE7I=;
 b=RxxdCycRRHjMFHf84mDkp+nyqtDJ3Nyx8oYatTT5RWtX3H9zSOjt6bVf2oyq3Sp/kW+nZMkdh7ehhF3UNXp7pPoqrQMVj8DZS7ogMka3T4gnWSHXDyWsUnnyTdf6fShCEO1IHdT+bsWtKuCQYX4bUp4rmDhC9brQ/6oD91AQFBlvRU7fTgBfebtTkTNTRblLZo5uSoyzdaj4KBx+FMSC45+DUKfGQZBwQeHlKzEH7Vh+bcGC3SxAAFBlAVbEyWHIzmDvLS92YDtL9X/jZ+ZeSyb+rIyeIoCxzCyoAZ5XfcBUbtA8M+sM4G0ue4w4cLdocdc10d4I8y1A9aSToZtgsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2WzMx0ArZitOyvBrS0o+kbTJn0qnyw4jpa3bcgqE7I=;
 b=WgmoOMKqd0aRIGTXqPBXUjMbAGrigSMh2FeK/fcNQ9UyYuBLqHE2EzhSuS3Tc5rIo873q3vlEIZQRG8+hdzZOb9JwpI/Xm1H0TXttgJHhasKijIS2+RWWV8fSyqs7lYvKKJXy2w/YHNn9s6jBciFgr59C0/wMRgZQC4CLKZ8rOA=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SG2PR03MB6586.apcprd03.prod.outlook.com (2603:1096:4:1d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.28; Wed, 1 Mar
 2023 10:37:12 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::5055:f50e:65c0:6815]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::5055:f50e:65c0:6815%9]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 10:37:12 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "perex@perex.cz" <perex@perex.cz>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] ASoC: mediatek: add missing initialization
Thread-Topic: [PATCH] ASoC: mediatek: add missing initialization
Thread-Index: AQHZS/OB7KTboj73Nku/VeXTJ7+/kK7lsYIAgAAKJoA=
Date:   Wed, 1 Mar 2023 10:37:12 +0000
Message-ID: <eca88f53e1f767eb7c2e6e45b0e335accf18023b.camel@mediatek.com>
References: <20230301040835.6322-1-trevor.wu@mediatek.com>
         <3d2f385e-dc85-8033-cf77-e5f0634c5be0@collabora.com>
In-Reply-To: <3d2f385e-dc85-8033-cf77-e5f0634c5be0@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SG2PR03MB6586:EE_
x-ms-office365-filtering-correlation-id: 1a7f4cea-3ab5-4bef-5a31-08db1a40eafc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sChtZMVCYTCzq+2A5me2+t8Bmj+xHmcFdrXnDnbUsQvMRTaGJjNPlFCnCxhRY16N125NiLj1ukLVa7hvPSqxt3rsD0H5hEGl0LLVGKIM7QiO6fnTqHfJgkPDnvStMgUwks35TxgwvZULgwrfWx7saMjJBmV1pvMYwtiw+++BIvUYd0wal/WE75HQeuQNeKHFspihjhCciOwkmzLJP9Rq5198jGlnwnFrppzaWjIk0eM8WM6uYfSnXREKmUSMINpyLQIyFwfYOFP+aATDUP1XF98RHv9WSU/4L9MuOTw8Wgn6CJH4tMJBE7kGMvtZlnV9obeBejhO9an6puqNmywt1140R/ff0V5Q6iOj8xTaELRvjXj+F9cAaLfwhyYyiFuP2tUkzIlYBGfWzGbfF2/XAt0ix0WARnWb8bQGmn7aex4e+ZtZl7KzF4Sr3Yq0ux03Iqaw/Gm14bwn7Fkl8vPpDl9QqxYlZPq6+yoSTiksbHPoC2nc+9uc/YMGPj9QY6XaLrUbnt0+y0K46orfRPiXxq0olEAdpHXwx3FtBGvJesIKCIZQTc8J8ZnhCPZhCGXQMI8N5fhI3gWff6/98aaoc39C0NQwWoOzO/KJMZFLom+OW3vQNj49bHdl17njuAUCy7y1liNcBSriyYV0kvj0rPhcIvVyju4Lsuz9/RCvWRWaVzD6GuF61nnIevXis4I+pbtsU0JdgA4c5A5if88zDyJA7OC+Dbw7tNid7BFM6GGfGW59h4BShSad96DhWxUVpRo2JtNIitB2e31kDnJQXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199018)(8676002)(122000001)(86362001)(85182001)(36756003)(38100700002)(8936002)(7416002)(5660300002)(6512007)(38070700005)(64756008)(26005)(6486002)(6506007)(478600001)(66476007)(76116006)(66556008)(66446008)(2906002)(4326008)(316002)(66946007)(71200400001)(186003)(4744005)(110136005)(2616005)(54906003)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHFveG1ZSHRMR1VkU2Nhc1plS0duV2dOcnVrayt6N1JnZnhpZFJEQUJDTnBk?=
 =?utf-8?B?SXI5cWNuZVFPeEZHcmJXVWFrNGQvLzViZFRpR01qS004dUI4MUkzWUZ2dzJT?=
 =?utf-8?B?cWNId1JiQ3hrNXdTNndYbUEyeW0xak9nYXBNUjJhSmVnbWtjMEIyU2xCVndV?=
 =?utf-8?B?d3p1S1V5TU44NVEvd0ZPemIyOCsxZ2RaS3Y4QXFWSFZBMHpLT05uNWlFUVIr?=
 =?utf-8?B?UnFzT0ExKzFRYWxpelVidG5vQm9DZW90VzU2MnBCZVRtcURScFdmYWxLTVhy?=
 =?utf-8?B?RTUwQk5uTk9HcWpIV01pR1pxcFNrV0NuV1FhalVWNWtpSUdpMEdzaElFSkhn?=
 =?utf-8?B?WnU4UUxONDhPRWNzR1dKUnhXUUpaRkVjNHZMUFBJRlo0MTlLYnZFTXg3SzR2?=
 =?utf-8?B?TFduR1pxbmkxMDVsRk91eGkydjhMNDFQMHhzcWo5WXhlemFRMkUrNmdJZ1c4?=
 =?utf-8?B?cENSNmwwWmdyNTV2aTJpaitiVlVaVG52bGYzaEVlMWVlUHVFazVFdjB2dDlw?=
 =?utf-8?B?V21RcHJvN1RrRGhxekIxZGtWT3NzMU5LdXVKdnZYRk1BUjFiaGppNnFxM2xJ?=
 =?utf-8?B?YXEyWHNrUjZlTXVlZ3ROS2VVamtDL3lLdkhRaVY1NUtZN1ZYNEEzWXhndjNh?=
 =?utf-8?B?RkVwa0pTS2hSQWFCeDVNQUZNTDBsK0RHY09yWGxPMmd0UHZ6cDRtMC9DUTBm?=
 =?utf-8?B?emd6TUxOcFlPemtnZnhYM1pWSWppaVRDUDlWRkpHLzB6UVJWM0xLeDhzUkhn?=
 =?utf-8?B?TDhzdzJXb0dWTVZvd2s0dkNjb0RaTEZWNm9tYmNFMkJNRXpFZlpzZGZLbk5S?=
 =?utf-8?B?dUR0Nzdsb3Q1UW1kNmNSb29vbmpUNzRtM211MzRlL3BHSXVJY0pnVDdFR0Ny?=
 =?utf-8?B?WHE3Wnd3U0dJNGRBMXBCOEtzbGpUaFBiRmRWVGo4dVd2ejh2LzlqdnkwdVhh?=
 =?utf-8?B?ZDVJcVM1UUNHdnBnZ201YUkvU2g5YVpwRUxmbXJhL0YvdzFFQnFvd00vSFV4?=
 =?utf-8?B?Uzh5dEdFdS9jRVd1bk4wVDlIYlp4WjFSVGw2akMzYW9VQWJTU1J1SGJkbkpF?=
 =?utf-8?B?OTZzQit0aWowSzZPL1pYbXlpa2h5Q2pmMjViWEJ5QmFRS3EvWHNWRyt2dkJD?=
 =?utf-8?B?ZjI0WjZpbmhVS2NuaXVEcVZaNzFVQVF2RElLdXMzV3RFamtMVXhzZGNoUVYy?=
 =?utf-8?B?RkRkZFhjRWxJQk1LV2V6Vm91bk0wLzJ0c2huVXhMSUZ5K0h4YjNUcWFSZ1NC?=
 =?utf-8?B?MDJDOW44SE5nSHlMS1lqRm0xTDJBQ3c0ZWlmYkUrT3BZeXc5ZnBwdkJUL2hC?=
 =?utf-8?B?SUxtN1JIclhqNXl3MXkzSTlCZDNwaXJYWVlrQjMybHNrUXZQYlUwU0YzUE5r?=
 =?utf-8?B?RkptZ3Z6RVB3Yk41QUN0YUxROTd5THpGSEdXWXVNU2c1QnNxejlaV0JVRVhz?=
 =?utf-8?B?elpkclZsTTVGWUdqMWc2T1J5Yk5GSHFwaGhxR2RVcEZmUm5USVhUQ0pZMjkx?=
 =?utf-8?B?L2djc0R0NHlXVGxHb0R1dk5uNXppdTRoWHI2QWZQOUFLWTN4YVF3OUE4c0tB?=
 =?utf-8?B?R0lLQ2N1bUdLRFI2MWk2azlKUGNZZVRLRW9GV0wyOXRIT25YVXpDQVdOSjlz?=
 =?utf-8?B?UmY5azI1TGdVUEk4R21OaXpSbVBzVTkzNnd6eXZzbytjRHlkb3c4L1hBQ0F1?=
 =?utf-8?B?VnE3NmVqUkd2ZTdRY0tzYmNHTEZKUDE2dU9OOEpka3h5ZFJ5UFgxWHN1aGlO?=
 =?utf-8?B?VTU5ZHdHQk1VWi9LR0VsRHNPM2JKM3czQ1VQSWZheFF3YUwrOW5xQ0Uxbml3?=
 =?utf-8?B?aFd2c0VHWTdKZnJWQkp1Uis0NUFZNERFMjMzTm9DNEtmVmthRVBnSUVXanRQ?=
 =?utf-8?B?NmRxaVN0bjZlUHlVNElmT1VXbWZmUFAxZVhhNmxLZTViWCs2STI4cGR6eFJh?=
 =?utf-8?B?UEhMVzBGMktDQXZsOUllRW1pdXlLUCs3eW00SWpYbXBJRkFnenY2b0x0bW1i?=
 =?utf-8?B?dlB5RkpubWJ1Q3RiM0huRjdlQ01QdU5DTU1yL28wRzA3UlVJK0lxQnlQK1ZD?=
 =?utf-8?B?dDRkSlFRZGk0aXZFWVRVWDE1bkwxcVk5bW5BRVRrb29KK29MOVQ4d2N4cFIz?=
 =?utf-8?B?dkJCU25Hb3ZCbkl2ZHVWcHZ1N0VIbmtib3dmSkdHdkR4cmdOUDdKSXRrZzhk?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A7FFBE83DFC5E4EA3CAA0CD77E36D1F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7f4cea-3ab5-4bef-5a31-08db1a40eafc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 10:37:12.5536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +iflu+AIoo/X8ss2lNs4S/5fkp8vqgBiomQLcPBp7shTZnpVNEbnJELaD6PekJrK1evxqYSbamfuzrPNgc3l4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6586
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

T24gV2VkLCAyMDIzLTAzLTAxIGF0IDExOjAwICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDEvMDMvMjMgMDU6MDgsIFRyZXZvciBXdSBoYSBzY3JpdHRvOg0K
PiA+IEluIGV0ZG0gZGFpIGRyaXZlciwgZGFpX2V0ZG1fcGFyc2Vfb2YoKSBmdW5jdGlvbiBpcyB1
c2VkIHRvIHBhcnNlDQo+ID4gZHRzDQo+ID4gcHJvcGVydGllcyB0byBnZXQgcGFyYW1ldGVycy4g
VGhlcmUgYXJlIHR3byBmb3ItbG9vcHMgd2hpY2ggYXJlDQo+ID4gc2VwZWFyYXRlbHkgZm9yIGFs
bCBldGRtIGFuZCBldGRtIGlucHV0IG9ubHkgY2FzZXMuIEluIGV0ZG0gaW4gb25seQ0KPiA+IGxv
b3AsIGRhaV9pZCBpcyBub3QgaW5pdGlhbGl6ZWQsIHNvIGl0IGtlZXBzIHRoZSB2YWx1ZSBpbnRp
bGlhemVkDQo+ID4gaW4NCj4gPiBhbm90aGVyIGxvb3AuDQo+ID4gDQo+ID4gSW4gdGhlIHBhdGNo
LCBhZGQgdGhlIG1pc3NpbmcgaW5pdGlhbGl6YXRpb24gdG8gZml4IHRoZSB1bmV4cGVjdGVkDQo+
ID4gcGFyc2luZyBwcm9ibGVtLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRyZXZvciBXdSA8
dHJldm9yLnd1QG1lZGlhdGVrLmNvbT4NCj4gDQo+IEkgYWdyZWUgYWJvdXQgdGhpcyBmaXgsIGJ1
dCB0aGlzIGNvbW1pdCBpcyBub3QgZmluZSBhcyBpdCBpczoNCj4gUGxlYXNlIHNwbGl0IGl0IGlu
IHR3byBjb21taXRzIGFuZCBhZGQgdGhlIGFwcHJvcHJpYXRlIEZpeGVzIHRhZyB0bw0KPiBlYWNo
DQo+IGZvciBiYWNrcG9ydHMuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQoNCkdvdCBp
dC4NCkkgd2lsbCBzcGxpdCBpdCBpbnRvIHR3byBjb21taXRzIGluIFYyLg0KDQpUaGFua3MsDQpU
cmV2b3INCg==
