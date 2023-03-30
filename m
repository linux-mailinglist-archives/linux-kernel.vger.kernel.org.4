Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040306CF947
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjC3CxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC3CxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:53:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27A31FCC;
        Wed, 29 Mar 2023 19:52:57 -0700 (PDT)
X-UUID: f73ccea8cea511eda9a90f0bb45854f4-20230330
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hWgYqi8F2HbJ4u9MtWJqtm1VrjL5uMVFkz3ymBLD4Es=;
        b=hY+W7zVyyzQ+j9XM1N7frC9EQihrjaUyHFy4MBwdlTxflTU9dL+o3XDKDDnOa48ElK+MKiWUSDt47p3EcpazfOI3KulpzEIwgbpIoPymoUv++jt0vnO8ihHTLCb7HDLbEv+A7kTsdi7IVgCjVE6ozoakzGdTBiDCeH8DYix+7pw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:ec94f9a9-0d14-4ec3-8211-128d493a9bfa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:7b3259f7-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: f73ccea8cea511eda9a90f0bb45854f4-20230330
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1504190348; Thu, 30 Mar 2023 10:52:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 30 Mar 2023 10:52:51 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 30 Mar 2023 10:52:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCkG6bxgEa5wWz4zmeE15/339ZF7yOiqtojXyHxyqs9I5R4YzCr7IMTIIciPRsN5Wg2d14P5fIA1UMaTysCJcIsD/SeqAyMVzcNCClrmPMAcEz1lxxLYNlWs2t5n0rDLedVaZ/CYPo8dDV02DZuSVjuo8YnaLYX4Lr8SfwhuDnUFTuJIp8v7WABRM4UeFwHGj5tVO0kRpiltCWSRvtKaETXEPAb6K4X2XJnXTKk+m7i5YSk+y3in4vcAUpm3AGJSNpy5OLSU9E2EbKlGhpl1Bl+DLB7g5GR+t3bUl2VskkufiJTHu+DXjklUqBtyrJnNbMBX5HCvnUt8RBGeY3K2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWgYqi8F2HbJ4u9MtWJqtm1VrjL5uMVFkz3ymBLD4Es=;
 b=dBdDfhe2cM37uE70vdZ+uYPAXBIL09kuAuKrhSgPfE7df9jAx9WJc3nyHYQNk8aHN0Mn3NzAV1zTFPaiHiXx8uygWaNjG1idSOm9st2F7asEHhJbT0aR+qBO9qv7u0bHW3N/si2gtweMDzFgdG94GuV29Vb1+WmmwujLOtMhZ9RwSiRUK8ifTmA4y/cexgBVAYDJLAeGmkZXF6QrpiE7PzB8EaFJ44TKpUpXYiqrrIh4R7gSJJaN/n4MAftcNgvHr05WkhE4go2iiJaSzb1jEt8ZFK5aNiuZYkq5HuOTLcVcdVF6gJSAo424VbKEYhqFTBilMrAlCZ+jc3sOMYc3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWgYqi8F2HbJ4u9MtWJqtm1VrjL5uMVFkz3ymBLD4Es=;
 b=gvMKjYV18RL3FkDIfDrhhhAizeczHLAZaYQZyJKAd2Xp4ctT4/EwHeDCZ+UAPMK0PTftJ8KF5KIK1y6QCmbaNekOjgyeFGIIQysiYZLchzNaWY/GalNSL+0akNiI3dbeCRlQ6+fOSs9voNSXAzD79h37CN0aof4lidWS3JwSXZY=
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com (2603:1096:400:120::13)
 by TYZPR03MB5775.apcprd03.prod.outlook.com (2603:1096:400:89::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 02:52:45 +0000
Received: from TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::c85b:1180:16d0:a852]) by TYZPR03MB5825.apcprd03.prod.outlook.com
 ([fe80::c85b:1180:16d0:a852%3]) with mapi id 15.20.6178.041; Thu, 30 Mar 2023
 02:52:45 +0000
From:   =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?= <Powen.Kao@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= 
        <peter.wang@mediatek.com>,
        =?utf-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>,
        =?utf-8?B?SmlhamllIEhhbyAo6YOd5Yqg6IqCKQ==?= 
        <jiajie.hao@mediatek.com>,
        =?utf-8?B?Q0MgQ2hvdSAo5ZGo5b+X5p2wKQ==?= <cc.chou@mediatek.com>,
        =?utf-8?B?QWxpY2UgQ2hhbyAo6LaZ54+u5Z2HKQ==?= 
        <Alice.Chao@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= 
        <Chun-hung.Wu@mediatek.com>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        =?utf-8?B?TmFvbWkgQ2h1ICjmnLHoqaDnlLAp?= <Naomi.Chu@mediatek.com>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?utf-8?B?TWFzb24gWmhhbmcgKOeroOi+iSk=?= <Mason.Zhang@mediatek.com>
Subject: Re: [PATCH] scsi: ufs: core: Make UFS_MCQ_NUM_DEV_CMD_QUEUES a module
 parameter
Thread-Topic: [PATCH] scsi: ufs: core: Make UFS_MCQ_NUM_DEV_CMD_QUEUES a
 module parameter
Thread-Index: AQHZYWBigdfCSJAbPkyKKhs0Lx7P968RFy+AgAGLdoA=
Date:   Thu, 30 Mar 2023 02:52:44 +0000
Message-ID: <38f0094ed6d75c47a1e7205970040926e9f2e33a.camel@mediatek.com>
References: <20230328103000.10757-1-powen.kao@mediatek.com>
         <9266aa1b-2d63-43d5-f06e-5a228bc131be@acm.org>
In-Reply-To: <9266aa1b-2d63-43d5-f06e-5a228bc131be@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5825:EE_|TYZPR03MB5775:EE_
x-ms-office365-filtering-correlation-id: 6cd08af6-55f6-4b43-65c4-08db30c9d63b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5tqkX3P+zMN4RVD9569OOEQis3R2FHODKQDjkKC7UI0+nWQyJ6o4dA/Rjgp6nRuRem6QxcSbHGwKemWOFzIA9TEaewqR+ynBfxSLgZBjwOPxl5v7BYClzMjjFR+V0uCmKSLc8Ir/JhBmkQ812WKPe0KgXaYfQ+pLULks2lFBq0HBpwDUwlT81zJoiI3shfSXfrua3NLzpXcUgUskoMj+HYe2Tbj17f8aOG1EEn7/czqUUMAfxYXLeNnjF7/7snF435hKs3e+yQRRp00jB2sOGdnR8Lh6Bsu0rHvXsrka0BJDuxP/j/ad4xAh6rm3bFgT3Jdz7XEgh2fMX9X5EWAi3tXwBzmT7+gXutuJl1a+2mfdaFXpmRk1bP3fE6fHqJnl7Wip5NhuvQyH2Ud6qsahIkJPTXvD4y62bIFQwJ1fVLZ/qqFbzsa20RPh2PI0RLodZ3vuAmnUC7C3WAFfyoVOvHvVl1IH5m3tctVlCpGgM4gqzkEXZCb1jdMJkcZvrtW43OyYzQ+MSPIwtPEs8O0AAC+Ac+kdq4XtDOaW1UQfkqp6cnreY1e3WqItuf5C0DdbOR172ql0ZlqmtyPbRPGXlPSD8j+1UQX6+Lj0xQ916fCLC/Cx3hekEVSD+Un7j/L+vt++w2In9lC6pzM4ml5Px/T77c/iFI6YSFh03kiznwwmiY7GBRongvfFOFGV2c9si5LNZcK7kn0rePQRXFaTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5825.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(53546011)(6512007)(26005)(64756008)(6506007)(41300700001)(186003)(107886003)(6486002)(71200400001)(83380400001)(2616005)(478600001)(54906003)(316002)(110136005)(66446008)(76116006)(66476007)(38100700002)(4326008)(66556008)(7416002)(66946007)(8676002)(2906002)(86362001)(36756003)(921005)(85182001)(38070700005)(5660300002)(122000001)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXVKM2VjZWNwWXJ4YjJPR2tTaVluSFdpSEpRMnpnVklHclE1a0JKVlBybk9H?=
 =?utf-8?B?VWxqaDdkTkpVMDhnRFgzM1JtNjNEKzFRK0w4eURzcythZnVDZCtRUUlxMTRH?=
 =?utf-8?B?WkcyT0wyVTZselJBWHNEK3BGck4rRlk5OER2K0ZobzBtclk5MDFjYXM3UDhh?=
 =?utf-8?B?cE1odnFZbnZqcG5PNFFXZUFqT1ZXV3FMR3FBZWg3cDB5d0lyS2xHVVcxRlFS?=
 =?utf-8?B?d2VqbXg5QTZGdFk1dDVmMjNpejRVTndkS3FrakZmczVOeGNqd2NrSGdXa0hq?=
 =?utf-8?B?Y3laYlJ1N1FkY0lXUzVUL1RwVXRSN1N5SXdvaUQwNFQvVmYvaDZaTnVmRlh0?=
 =?utf-8?B?MzlDZW5lcURCVXJGR2pURnl4YUdRUWh0RWlFcXpVcUdESjlTRlM4RnFCM1pa?=
 =?utf-8?B?VU44MmVYdDFIVnhuZy9aYUZiaWdTMmdFR0JlQ0FxTmxZWjhiai8wWFExSEdL?=
 =?utf-8?B?c0RIMFpPdGtxcE43T3doQVpKcW5nenorbkhnclBJMzV5ZEhnNkpGV0g2a3ZD?=
 =?utf-8?B?Ni9EZVpSNmRlRkd2bU53UkZqdnlRdHNWNjk1TytLUTJDYXNYd3lrVTZXQWc2?=
 =?utf-8?B?clRFWG9FU3o5NzRUR0pzb01uRHhnc3VkOWlwUlA0WHRzdFlpL1BvQUJlWmVv?=
 =?utf-8?B?d0VITHZFL0RWalVpWjJkdnhYYTFENDlqQW1SMVBGNVZseXFpMHFpVWJnREFy?=
 =?utf-8?B?K1VEdE1hMlJLSWp3VWVVY3oycy9kMytQbzdGM0h6d3Z2RFprUzBPeTdoby9Z?=
 =?utf-8?B?d0pINHBENVBGazJ3TmpYbjI2Mk9DNTBXNXRvczdWaWZZdzJYdGlPdFhvMVRD?=
 =?utf-8?B?eGNzR0ZSTHVCSlRLOWh4bWgyQWpJY25NTHpxNXc0VzkxRndCRDZsSFZpWmxH?=
 =?utf-8?B?UDFDSy9CWmQ0WmlHSlBwaERUZnFTbmh4RWJ2YmJGU2xaT2xqRktoRU9LMWZ3?=
 =?utf-8?B?aGFSb1ZCUk9DZnNuSmZBWk05TjhvNi9WSk9RTWFmOW1Ud2F4M1UvNXNoZjYr?=
 =?utf-8?B?MnVuckJnZEVUUkFhZ1B0a2NyT1pFdGk3QXZXN0Y4bEFOcnFVWFFHcDIzSWNS?=
 =?utf-8?B?bnRaejhSdWppaWE5UWxEdE5iUlc1cWM3dENGd1F1THJJQktIZ2NJZDR3V0ZW?=
 =?utf-8?B?SVVvOGpNUENmZUdJcGhrU1k5a1dBUHA1WmtwcGdacy9aM3JWQlQ2Ni9uclFj?=
 =?utf-8?B?eDNET2V1Q3lreFVzRVlRWWZXd0pObStZdktkWGtWeVMrS3ZDdHBCRmVLdVZM?=
 =?utf-8?B?RDFmbkFHYkZHTDM0dWhmanVuMUEyZStIVlB5S1ZPNXZtQWx0eDZSRmZvbklX?=
 =?utf-8?B?bTY0MVlxNk9ITjc2cjZVK21uUXNScDMvKzBjUk15ODJxOEZPSUYrY2ZjV3Ri?=
 =?utf-8?B?c0NHZnFzRUgxbjRVUllNNW9IbWpCSkIraEpZQ0hGYVQwbzBxU0VqZEFoYWYz?=
 =?utf-8?B?VnhNb1owZFdYRHB0Q0dqUzRqdlppdUdOUjhHQnBod3IvNnJwMkxrTUJiVUdO?=
 =?utf-8?B?bmhIV1VMQ3hHdms0NHdaUWxnSHZTOStiVzRTckFWbW9SZ1pxa3hvQzQrdjlW?=
 =?utf-8?B?RjQ5elN0dmlNa0kreGtvYURiQ2dub3F0d05XOGlHcXNVMHM3SzNLY2R1N09J?=
 =?utf-8?B?WVFBUXNMcjlyQjJtUG1xTkxBTlZFbjlQMVUyNE1JdDFxZ2hNK2RmdzgvaEVz?=
 =?utf-8?B?QUI3L0pjU2RNbVNlRDh4MjkweHFabDBaYm5FZjVEK3E5TkZVaW8yTnEvRHNJ?=
 =?utf-8?B?MEJsbTcvZGJNVldJUWFrSW1ad0RydFk5WlluSW5LWk9vWVJXeUQ5QmR6Wmdv?=
 =?utf-8?B?RDYwcW12NU5XMXpqeDRIMjVydzBiNVFXbWJMRWZmbmkxRlBpKzFmelpaMXhy?=
 =?utf-8?B?Vy9qMnpIZ2FJdnVYb3lSU1VXN0kwTUFGS1k1RGxFUEJWMXBOUFZwWlhIVzNT?=
 =?utf-8?B?QTJ4NGhlNXlvREdOV3dlMU5PRWlSaEZsWG9NbUxqNld6RU1Ic1drcHdvYXh5?=
 =?utf-8?B?YlplMmFYZ090ZnFkeXJwcko2MXFxamhpR0tueHkwYmd1MCtpZVRHaWNNUkVY?=
 =?utf-8?B?dTIzVkxPNmQvMU9lbnBJOVhURncvTjZJamowcExsQnV1aFlKdkhycVMwcFJB?=
 =?utf-8?B?YkpGSVZCRm5Qd3RuWmVjejNQZGtWOWVycTdOUTNKdWI0M2RHYitsdFh6cUpU?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99DF81EF247EC54A9F5C18A5EC768EEE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5825.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd08af6-55f6-4b43-65c4-08db30c9d63b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 02:52:44.3365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i42c7Du8lxMJhN5aZeYkPupzssqPD6aDSNi4lG/T8QOfGTlkODzuDhba5j4RYaewYMnQ2tgFyjWgS/JT1ep4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5775
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAzLTI4IGF0IDIwOjE3IC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+IA0KPiANCj4gT24gMy8yOC8yMyAwMzoyOSwgUG8tV2VuIEthbyB3cm90ZToNCj4g
PiBBIGRlZGljYXRlZCBxdWV1ZSBmb3IgZGV2IGNvbW1hbmRzIGlzIG5vdCBtYW5kYXRvcnksIGhl
bmNlIGxldA0KPiA+IFVGU19NQ1FfTlVNX0RFVl9DTURfUVVFVUVTIGJlY29tZSBtb2R1bGUgcGFy
YW1ldGVyIGBkZXZfY21kX3F1ZXVlc2ANCj4gPiB0byBhbGxvdyBzaGFyaW5nIGZpcnN0IGh3IHF1
ZXVlIGZvciBkZXYgY29tbWFuZHMuDQo+IA0KPiBXaGljaCBxdWV1ZSBpcyBzZWxlY3RlZCBmb3Ig
ZGV2aWNlIG1hbmFnZW1lbnQgY29tbWFuZHM/IA0KDQpRdWV1ZSAwIGlzIHNlbGVjdGVkIGJ5IGRl
ZmF1bHQuDQoNCkBAIC00MjMsOCArNDQxLDExIEBAIGludCB1ZnNoY2RfbWNxX2luaXQoc3RydWN0
IHVmc19oYmEgKmhiYSkNCiANCiAgICAgICAgLyogVGhlIHZlcnkgZmlyc3QgSFcgcXVldWUgc2Vy
dmVzIGRldmljZSBjb21tYW5kcyAqLw0KICAgICAgICBoYmEtPmRldl9jbWRfcXVldWUgPSAmaGJh
LT51aHFbMF07DQoNCj4gDQo+IFdoYXQgaXMgdGhlIGltcGFjdCBvZiB0aGlzIGNoYW5nZT8gSWYg
YSBkZXZpY2UgY29tbWFuZCBpcyBxdWV1ZWQgb24gYQ0KPiBxdWV1ZSB3aXRoIG11bHRpcGxlIHBl
bmRpbmcgY29tbWFuZHMsIGRvZXMgdGhhdCBtZWFuIHRoYXQgaXQgY2FuIHRha2UNCj4gbG9uZyBm
b3IgdGhlIGRldmljZSBjb21tYW5kIHRvIHJlYWNoIHRoZSBVRlMgZGV2aWNlPw0KPiANCj4gVGhl
IGFuc3dlciB0byB0aGUgYWJvdmUgcXVlc3Rpb25zIHNob3VsZCBiZSBpbiB0aGUgcGF0Y2ggZGVz
Y3JpcHRpb24uDQo+IFBsZWFzZSBleHBhbmQgdGhlIHBhdGNoIGRlc2NyaXB0aW9uLg0KDQpJIHdp
bGwgbWFrZSBjb21taXQgbWVzc2FnZSBjbGVhciBpbiBuZXh0IHVwZGF0ZS4NCg0KPiA+ICt1bnNp
Z25lZCBpbnQgZGV2X2NtZF9xdWV1ZXMgPSAxOw0KPiA+ICttb2R1bGVfcGFyYW1fY2IoZGV2X2Nt
ZF9xdWV1ZXMsICZkZXZfY21kX3F1ZXVlX2NvdW50X29wcywNCj4gPiAmZGV2X2NtZF9xdWV1ZXMs
IDA2NDQpOw0KPiA+ICtNT0RVTEVfUEFSTV9ERVNDKGRldl9jbWRfcXVldWVzLA0KPiA+ICsgICAg
ICAgICAgICAgICJOdW1iZXIgb2YgcXVldWVzIHVzZWQgZm9yIGRldiBjb21tYW5kLiBEZWZhdWx0
DQo+ID4gdmFsdWUgaXMgMSIpOw0KPiANCj4gSSBwcmVmZXIgYSBzb2x1dGlvbiB0aGF0IGRvZXMg
bm90IHJlcXVpcmUgYW55IG5ldyBrZXJuZWwgbW9kdWxlDQo+IHBhcmFtZXRlcnMuIFRoYXQgbWVh
bnMgZWl0aGVyIGEgZGVkaWNhdGVkIGRldmljZSBjb21tYW5kIHF1ZXVlIGZvcg0KPiBhbGwNCj4g
aG9zdCBjb250cm9sbGVycyBvciBubyBkZWRpY2F0ZWQgZGV2aWNlIGNvbW1hbmQgcXVldWUgZm9y
IGFueSBob3N0DQo+IGNvbnRyb2xsZXIuDQoNClRoZSBtb3RpdmF0aW9uIG9mIHRoaXMgcGF0Y2gg
aXMgdG8gYWRhcHQgVUZTIGRyaXZlciB0byBkaWZmZXJlbnQgaG9zdA0KaGFyZHdhcmUuIElNSE8s
IHNvbWUgaG9zdCBtYXkgaW1wbGVtZW50IGEgZGVkaWNhdGVkIChleHRyYSkgcXVldWUgZm9yDQpk
ZXYgY29tbWFuZHMgYnV0IG5vdCBhbGwgZG9lcy4gSW4gZ2VuZXJhbCwgb25lIGh3IHF1ZXVlIHBl
ciBDUFUgKElPDQpxdWV1ZSkgdG9wb2xvZ3kgaXMgZGVzaXJlZCwgaGVuY2Ugc2hhcmluZyBhIGh3
IHF1ZXVlIGlzIGluZXZpdGFibGUgb24gdGhvc2UgaG9zdCB3aXRob3V0IGEgZGVkaWNhdGVkIGRl
diBjbWQgcXVldWUuIFRoZSBob3N0IHdpdGggZGVkaWNhdGVkIHF1ZXVlIHdpbGwga2VlcCB0aGUg
YmVuaWZpdCBvZiBoYXZpbmcgZmFzdCBjaGFubmVsIGZvciBkZXYgY29tbWFuZHMuDQoNClRoYW5r
cw0KDQo=
