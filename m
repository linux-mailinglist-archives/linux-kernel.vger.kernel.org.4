Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41056425DE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiLEJel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiLEJeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:34:37 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65953186DA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:34:31 -0800 (PST)
X-UUID: 07e38fe0f88547f8a5b713e4a3274d60-20221205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0mUweo9lU6te/N9U7XhWFi4SaD+0FRbkHjT8h/zMHqU=;
        b=pwPcFuxOxWrugtYzjVgJ+TKS3DEygfU4a/rJYkHcuqrybByEssr+NZskCiphkNtPtx4lGr3I2iE6hm4gvcDFJHPFV5qGjGDodUy/Cgg77MQ4n2GTQrNgiMdBbQok+xGXD69EmL9vHWgeV7+uSLyA3ZKfK2fLSpkgEBIPdSHfSfM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:28715a70-8628-4105-af75-0d02c1cef52c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:b9a25724-4387-4253-a41d-4f6f2296b154,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 07e38fe0f88547f8a5b713e4a3274d60-20221205
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1853569773; Mon, 05 Dec 2022 17:34:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 5 Dec 2022 17:34:19 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 5 Dec 2022 17:34:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6CZkt/uIJDzXIfiy9Km/ebOx0jgxHtQzrsUSTer7F4maLH2CBeV7JJgszsmJyVUZVdGsmJ27M9JrfrouBHAxC84mqw654ht6oaOv2XB6cI0bsdYt1bWYrpoozo2bqb3fK4NbQZ99hsSYzyp9fBexWBoB4f54KcWjb2E2cIAPlAkWAaU+GfOEaMRiX10iVRxhzmIwcJw9mZQ1NfEIe8dv0AvdZDqGoFBKjhhB952JaO+Q3RW+WzOrvhSLA/uehiu2ItA8oH725Wg1/trUAMmWu0+rmp1+YO2J4dp4zrSYwrBXa7vfL7EL10ubrqGbCKGVK6GCTKDHa7wPSoM8uDIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mUweo9lU6te/N9U7XhWFi4SaD+0FRbkHjT8h/zMHqU=;
 b=M3O0YRryGu8FMnwnymyjk6GaVLeT4cplisZ8QbMGE+vup+FBzM0aNoyDXuDCFGEue9FkSxvatPLqrkJzNVDuvpe6Uz1x/y5UFBXirzenDMt+xmdOPZ00QMkHNV7EF2WygykLalVj7fjCEKjDv8YuDZCybf2MsA9GD78ALF0QkjUdo5JXFO/9PhRlsafr0hUPcgTaxhSEmw/I4oKpf8TBy6jW3SVHbIGjda+6by9zmhDcb2MWugipVuJ/OJhJPJF+/+gHTpB7OZCL43HY7pyJbZkd8BE5qrZjPwuAtxRQN9Qn1Uue3tYjPXwWAOD98PwJ0tAPdng/du++Ld0q20C95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mUweo9lU6te/N9U7XhWFi4SaD+0FRbkHjT8h/zMHqU=;
 b=l0ezlf0XtfvLzyRPsAxac+m0/JsnGkIH7xeDdCJUTgUokuvozpowwFe6jSZMFd22oouQUjJ0AmWfKC9HA+AqRpFZ4F3oTfOd5NUQMPn+xFJbtOyjbeQl7s/Qs6GcA9obsoqRkgY2zizcUvyYS289XL6jb7wcHzPnLp1eDpUkMsY=
Received: from PS1PR03MB3384.apcprd03.prod.outlook.com (2603:1096:803:49::13)
 by SI2PR03MB5484.apcprd03.prod.outlook.com (2603:1096:4:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 09:34:17 +0000
Received: from PS1PR03MB3384.apcprd03.prod.outlook.com
 ([fe80::2e82:cce2:3b26:ab6f]) by PS1PR03MB3384.apcprd03.prod.outlook.com
 ([fe80::2e82:cce2:3b26:ab6f%7]) with mapi id 15.20.5880.011; Mon, 5 Dec 2022
 09:34:17 +0000
From:   =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "ajye_huang@compal.corp-partner.google.com" 
        <ajye_huang@compal.corp-partner.google.com>,
        =?utf-8?B?Q2h1bnh1IExpICjmnY7mmKXml60p?= <Chunxu.Li@mediatek.com>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 1/3] ASoC: hdmi-codec: Add event handler for hdmi TX
Thread-Topic: [PATCH v2 1/3] ASoC: hdmi-codec: Add event handler for hdmi TX
Thread-Index: AQHZALKPLtjy9JnSM0qA0l4xMT7+Dq5PjsoAgATmBQCAAbf+AIAC/qmAgAAE8QCABeevAA==
Date:   Mon, 5 Dec 2022 09:34:17 +0000
Message-ID: <7023a2c7b471d6888d9079563a6c01f22599201f.camel@mediatek.com>
References: <20221125094413.4940-1-jiaxin.yu@mediatek.com>
         <20221125094413.4940-2-jiaxin.yu@mediatek.com>
         <Y4Cysgk5Gic5ae9B@sirena.org.uk>
         <18c82f6f723cd97a9d6b9a7ff16c6ed62fd005d6.camel@mediatek.com>
         <Y4Y/vEWe3dw0FPQH@sirena.org.uk>
         <cf9ea98a3263ffb8fc8b542888ad0ad680facfc7.camel@mediatek.com>
         <Y4jHAJgmz/P58Q/C@sirena.org.uk>
In-Reply-To: <Y4jHAJgmz/P58Q/C@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB3384:EE_|SI2PR03MB5484:EE_
x-ms-office365-filtering-correlation-id: 0c76e415-0d8a-4d1b-6232-08dad6a3e130
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AP5Nr2LnsbaHs4/95ssGmJrDoWUjDTOgSNfUiFn/5eLo/y/0vcyRqTJB5lOBZBRVkjTkUSJCE0jsRK4PztyLsDYF+vVrnUXjSdZJxnyLWjy7Ak4qyUny51ClsjU4BJ5O75LtjF1zbsqniiR8S8Yba/Phtc1H3ctA6lsq5V64Z9oR/99nquO8UnNQXKhMRVvxLytnJhYGcgpJMXQ395DNrI9CLa1mSVCz2JX2yZ8rqY5CFXP/T6XLHY4OCfNfYjkUKrSUZC0tO6+ziPqu6ri+2TREbytHPXvbkJQ7w3P5yg7yvIUiMutCml9D3wwfjIERuuBUlHpEPCG9ZlsRUeSxexAx/in03jMi9a9Iw5f1b6GVzBYlbMiTfah2pzNPxQgE2VQCOFU6y64uZnegPEh4NhI4/YE+P9WNMI3M3NSNr6JpBm6oU0sh0nYqgumgXHrqPWwb98a9pdX0Sv6KwQIvPGw1oCHavzsxtxPfsVuxLXJ1pWOSVid9vTeD8zHQNc7R725h/m3j0g+UKHHxVIL4AZ6BXQlthiP+HRb0DMpge797maNxtJFF+juvSzbF36iEJdzMjtA7XCHHT1/XmZaJaZeLu/CgbFKDl6hDkztQ9r7mZvwZX/1gwHtOcNR0B0iS9X2f3/vs6JiZCs8IaRIl+G97GcsdTkkmTX4SzcWS/yIWNxdQF3npEk9tz6wyrMTRXjJF14cGNNThg5BamxpxBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB3384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199015)(38070700005)(36756003)(85182001)(86362001)(71200400001)(478600001)(6486002)(26005)(64756008)(186003)(54906003)(6916009)(5660300002)(6512007)(7416002)(4326008)(8676002)(6506007)(41300700001)(8936002)(66556008)(316002)(66446008)(66476007)(4001150100001)(91956017)(2906002)(66946007)(76116006)(122000001)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2NuaEVsOXRRbWZjQ091YTVVYWZueDMwSWV3dmI4dFUvVE0xWkFNYllZOHY4?=
 =?utf-8?B?ZmZ3aW5vUGQzRVRheHdMUnZTbXFMR21KQ09zVVJydmhuOE9mZjdCNWsyOXpH?=
 =?utf-8?B?M1FPR0lHVTVOVnRyUDF5YWprZU5NQkRKajhxZHZRNkdZeklrU1RncGZkVnY4?=
 =?utf-8?B?WnVOaWRlbGJoSWlTQWk1MTJPOHZqRE82RjFwTHVMdmJBaG5NV2IxQlJjYktv?=
 =?utf-8?B?aEhOWkRlY2o5S1RpSHBCZGhLWm9SMk1ucDcrc2l4STRiMlBwVmM2QUlwcFpo?=
 =?utf-8?B?aDAvZFcwd2RJdk04L2FITXM1ZUlLOSs3Q1NSYWNlVUNjdzZxejhHb1M0WHFt?=
 =?utf-8?B?cjNmcHd3YjY4VE03cWlZeHdvRzJGMmZ2UGg0bzVZeDUrbTdTbytYa0I4VkFs?=
 =?utf-8?B?d2lseU1Md0hkUjVsRGdLeEw1bzh1NC83Y0xTSHpUaE5iZDh3S0ljLytLMVlP?=
 =?utf-8?B?d0F3RHFCTnpJMXduY3QreitDNGpVTkZaa3hRbHc0aFloZlZlSGFmOUJYL1hQ?=
 =?utf-8?B?aXVFc3EvNXZ5bWhxR2c0RnY5TWRHWlhHZXU3ZWJXTHNuYUtQTTFzNWxXZE5P?=
 =?utf-8?B?SGFESG53NG1EbUordDF0MU80WGExYzNBdTVselFKNm9aQk5RcWtsMW9FaDFR?=
 =?utf-8?B?cGVxTkI2dllEbmIzVVgyT1BkNGVjMm1TbGZmK0Q5SU10KzNuWlR5Y2k0R0R4?=
 =?utf-8?B?djc0dDJ3czE5eGFpMkxnYWFHRFlXSXIxR0NMVDl1S0ZVdWdzSU1wL1VrS1JS?=
 =?utf-8?B?QTZDdmdldzRXaFVlZThRZnFGcFpJTXFHZko4ZjBXU04xQ2xWMkRVbS9YMWVt?=
 =?utf-8?B?RzNpMzZCSnFHVU5TT2YvOFFRUm1mZ01Zd3oxV1c1cmllQWhFT1h1MllEbFE0?=
 =?utf-8?B?TE1GZUl0Um9ScDY3VWxWdFhrYnlEZVppanE0NHVDZXFsWFV2a01MTjYyczVH?=
 =?utf-8?B?TkZ1U2c1djBoR1ZsM2h1MThQVUpCTkZMbFRHTmo4Y1lvMFROaFFnMDVubWRJ?=
 =?utf-8?B?Tmw0Mm5vaXovUFd0bnBGdm5hb1o1WFNQYXRscU9MZm1XMUNsREZxQ0NKU1N6?=
 =?utf-8?B?RG1Xc2drM3lQYWdGRHQxcVpZa0xaSUs1WTlSREVkNzdUUFE4L2k0akVjdkpM?=
 =?utf-8?B?WnEvSGh3WlpzUjEwT0tVQjlQeU1KZ1FWV1RaSEYwbGkwbjR3V281NjJ6bU1I?=
 =?utf-8?B?T1Q4cE9ibjMrYU9SQ2xQZzVCMy9LR2tiSlZmcFk2R3B2RkpkUmFkZXU0TUtL?=
 =?utf-8?B?dGI3ZWFocG9VZUEzNEUzZmtIRllkUVNsMmxDbnJPUDljSHBaV0pKcVpqcW5Y?=
 =?utf-8?B?bktQUVdFVnUzWEFjRXpCeEREaXB5aHNXZlB6czJ3QW9PTEl0UkdWTmVVS0U1?=
 =?utf-8?B?UnluZXdNRWFSYzdIOHpLYU5FTlZzVlBGYjA1TmVxN25qRFlzZHUvR0dGelg4?=
 =?utf-8?B?NTlnVlF6WVp4RCsvMllPZDg4ZC9QUFdRZGNjS28zRnBoTk5WQjRKVTlZWDBt?=
 =?utf-8?B?L3lCSnN1YUl3WisyaUcyWjl3ZkN2QVdoVzRST0NJVWVDM2R0YU5KRjZDU0px?=
 =?utf-8?B?Y1RoUFJmdzFLV1NXb0tLUXJYWGg1bDRLS2xpL2xxT0x5V0p0NW4wZHJDZGw0?=
 =?utf-8?B?S2JYZHN1ZUNuVkNJbDBheS9BbmgrbFBWQ1pUOHRVWUN3azBEWWthcFdQa1pC?=
 =?utf-8?B?RjNZeE9wWVlZYTgwdkJleGUzMndGSjNWQm5sTXFIUjJCYnloa3FrNWYvbmZl?=
 =?utf-8?B?RktMN1lpYjRJZHhyVEpsK0Z1eVhuSWZaMFkvSXFNN0szcnpPTkpEL05saTJ2?=
 =?utf-8?B?Z01hdE9paGh2QzRlZ3BVYklTejUzQmZ3RWltWlI2WEVNSWpJWldrQ3dhcC9K?=
 =?utf-8?B?OUY0V3haNkJHS1hrenJXc3RqeEpaNjRvYTVoZVlFWGVnTVJ5OUNyamFEQXlW?=
 =?utf-8?B?K1lwNXRNbW5OcFljN1dYbEl0cmlXOWRXMWxsRUFlNllhUDZBWkF0bXhGM2pV?=
 =?utf-8?B?WEFDQ3djbU5IZ25kbGJRcEFJZ2RGM29sMHEzVklTeGlhU1ZiclAzWmJkNmd3?=
 =?utf-8?B?ckowOXlBeVJjdG1ab3RoMTZaT3BwZ1BJWGNPVVNORDdoakJ6QVBqLytlY2Nk?=
 =?utf-8?B?UHlSTXdLUGVCNEl0N05CY0VwbGwwQTAySmxuY0YxSnB0emwycGpOMFJ3OHcx?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1FCA03A0DCAC74EB0829A091B273323@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB3384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c76e415-0d8a-4d1b-6232-08dad6a3e130
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 09:34:17.2248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ps0uZT4Ij9/P6dMZHOZD6+wOWf+lzobS8j3Vn0f4pfjgslM+crLiyqpUm7UWowa6pctzFd5qvbEaJHMBW7VXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5484
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEyLTAxIGF0IDE1OjIzICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUaHUsIERlYyAwMSwgMjAyMiBhdCAwMzowNjowNFBNICswMDAwLCBKaWF4aW4gWXUgKOS/nuWu
tumRqykgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIyLTExLTI5IGF0IDE3OjIyICswMDAwLCBNYXJr
IEJyb3duIHdyb3RlOg0KPiA+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9sX25l
dw0KPiA+ID4gIG10ODE4Nl9tdDYzNjZfcnQxMDE5X3J0NTY4MnNfY29udHJvbHNbXSA9IHsNCj4g
PiA+ICAgICAgICAgIFNPQ19EQVBNX1BJTl9TV0lUQ0goIlNwZWFrZXJzIiksDQo+ID4gPiAgICAg
ICAgICBTT0NfREFQTV9QSU5fU1dJVENIKCJIZWFkcGhvbmUiKSwNCj4gPiA+ICAgICAgICAgIFNP
Q19EQVBNX1BJTl9TV0lUQ0goIkhlYWRzZXQgTWljIiksDQo+ID4gPiAgICAgICAgICBTT0NfREFQ
TV9QSU5fU1dJVENIKCJIRE1JMSIpLA0KPiA+ID4gIH07DQo+ID4gV2hpY2ggb3BlcmF0aW9uIHNo
b3VsZCBJIHVzZSB0byBpbmZvcm0gYnJpZGdlIGRyaXZlciB0byBjb250cm9sDQo+ID4gYXVkaW8N
Cj4gPiBvbiBvciBvZmY/IEknbSBjdXJpb3VzIHdoeSBJIGRvbid0IHNlZSAudHJpZ2dlciBpbiB0
aGUgc3RydWN0dXJlDQo+ID4gaGRtaV9jb2RlY19vcHMgY29tcGFyZWQgdG8gdGhlIHN0cnVjdHVy
ZSBzbmRfc29jX2RhaV9vcHM/DQo+IA0KPiBZb3UnZCBuZWVkIHRvIGFkZCBhIGNhbGxiYWNrIHRo
YXQgdGhlIHVzZXIgb2YgaGRtaS1jb2RlYyBwYXNzZXMgaW4NCj4gd2hpY2gNCj4gd291bGQgYmUg
dHJpZ2dlcmVkIGJ5IGFuIGV2ZW50IG9uIGEgREFQTSB3aWRnZXQgYWRkZWQgaW4gdGhlIGF1ZGlv
DQo+IHBhdGgNCj4gcmF0aGVyIHRoYW4gdHJ5aW5nIHRvIHNob2Vob3JuIHRoaXMgaW50byBhIFBD
TSBvcGVyYXRpb24gLSBhIGJpZyBwYXJ0DQo+IG9mDQo+IHRoZSBwcm9ibGVtIGhlcmUgaXMgdGhh
dCB5b3UncmUgdHJ5aW5nIHRvIGFkZCBzb21ldGhpbmcgdGhhdCBkb2Vzbid0DQo+IGZpdA0KPiBp
bnRvIGEgUENNIG9wZXJhdGlvbi4NCg0KRGVhciBNYXJrLA0KDQoxLiBJIGhhdmUgYWRkZWQgYSBE
QVBNIHdpZGdldCB0aGF0IGlzICJTREIiLCB3aGVuIHdlIG9wZW4gb3IgY2xvc2UgSERNSQ0KUElO
X1NXSVRDSCwgdGhlIGNhbGxiYWNrICdoZG1pX3R4X2V2ZW50JyByZWdpc3RlcmVkIGluIHRoZSB3
aWRnZXQgd2lsbA0KYmUgdHJpZ2dlcmVkLiBNYXliZSB5b3UgbWVhbiBJIHNob3VsZG4ndCB1c2Ug
U05EUlZfUENNX1RSSUdHRVJfU1RBUlQNCmFuZCBTTkRSVl9QQ01fVFJJR0dFUl9TVE9QPw0KDQoy
LiBJZiBJIGRvbid0IHVzZSBoY2Qub3BzLT50cmlnZ2VyIG5vdGlmaWVzIHRoZSBicmlkZ2UgaWMg
ZHJpdmVyIHRvDQpzd2l0Y2ggdGhlIGF1ZGlvLCB3aGljaCBvcHMgc2hvdWxkIEkgdXNlPw0KSSBh
Y3R1YWxseSB3YW50IHRvIGtub3cgaGRtaS1jb2RlYy5jIGFuZCBpdDY1MDUuYyBleGNlcHQNCmhk
bWlfY29kZWNfb3BzLCBpcyB0aGVyZSBhbnkgb3RoZXIgd2F5IHRvIGNvbW11bmljYXRlPw0KDQpN
eSB1bmRlcnN0YW5kaW5nIGlzIG5vdCBkZWVwIGVub3VnaCwgc28gcGxlYXNlIGhlbHAgZXhwbGFp
biBtb3JlIGluDQpkZXRhaWwsIHRoYW5rIHlvdSB2ZXJ5IG11Y2ghDQoNCitzdGF0aWMgaW50IGhk
bWlfdHhfZXZlbnQoc3RydWN0IHNuZF9zb2NfZGFwbV93aWRnZXQgKncsDQorICAgICAgICAgICAg
ICAgc3RydWN0IHNuZF9rY29udHJvbCAqa2NvbnRyb2wsIGludCBldmVudCkNCit7DQorICAgICAg
IHN0cnVjdCBzbmRfc29jX2NvbXBvbmVudCAqY29tcG9uZW50ID0NCnNuZF9zb2NfZGFwbV90b19j
b21wb25lbnQody0+ZGFwbSk7DQorICAgICAgIHN0cnVjdCBoZG1pX2NvZGVjX3ByaXYgKmhjcCA9
DQpzbmRfc29jX2NvbXBvbmVudF9nZXRfZHJ2ZGF0YShjb21wb25lbnQpOw0KKw0KKyAgICAgICBz
d2l0Y2ggKGV2ZW50KSB7DQorICAgICAgIGNhc2UgU05EX1NPQ19EQVBNX1BSRV9QTVU6DQorICAg
ICAgICAgICAgICAgaWYgKGhjcC0+aGNkLm9wcy0+dHJpZ2dlcikNCisgICAgICAgICAgICAgICAg
ICAgICAgIGhjcC0+aGNkLm9wcy0+dHJpZ2dlcihjb21wb25lbnQtPmRldi0+cGFyZW50LA0KU05E
UlZfUENNX1RSSUdHRVJfU1RBUlQpOw0KKyAgICAgICAgICAgICAgIGJyZWFrOw0KKyAgICAgICBj
YXNlIFNORF9TT0NfREFQTV9QT1NUX1BNRDoNCisgICAgICAgICAgICAgICBpZiAoaGNwLT5oY2Qu
b3BzLT50cmlnZ2VyKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgaGNwLT5oY2Qub3BzLT50cmln
Z2VyKGNvbXBvbmVudC0+ZGV2LT5wYXJlbnQsDQpTTkRSVl9QQ01fVFJJR0dFUl9TVE9QKTsNCisg
ICAgICAgICAgICAgICBicmVhazsNCisgICAgICAgZGVmYXVsdDoNCisgICAgICAgICAgICAgICBi
cmVhazsNCisgICAgICAgfQ0KKw0KKyAgICAgICByZXR1cm4gMDsNCit9DQorDQogc3RhdGljIGNv
bnN0IHN0cnVjdCBzbmRfc29jX2RhcG1fd2lkZ2V0IGhkbWlfd2lkZ2V0c1tdID0gew0KKyAgICAg
ICBTTkRfU09DX0RBUE1fT1VUX0RSVl9FKCJTREIiLCBTTkRfU09DX05PUE0sIDAsIDAsIE5VTEws
IDAsDQpoZG1pX3R4X2V2ZW50LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNORF9T
T0NfREFQTV9QT1NUX1BNRCB8DQpTTkRfU09DX0RBUE1fUFJFX1BNVSksDQogICAgICAgIFNORF9T
T0NfREFQTV9PVVRQVVQoIlRYIiksDQogICAgICAgIFNORF9TT0NfREFQTV9PVVRQVVQoIlJYIiks
DQogfTsNCg==
