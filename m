Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA63B72F7E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbjFNIcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243640AbjFNIb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:31:57 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC2E1FD4;
        Wed, 14 Jun 2023 01:31:46 -0700 (PDT)
X-UUID: 851863320a8711ee9cb5633481061a41-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=BabtH32petYewVqFiqSWHW8RgCtD8nb1bbgemSXRIiM=;
        b=gmB2vthAv2XVczJwfh4PcauNPZqyAghN6ncdDWl6GrAJV7MSt+kR2YswdBKfU6kTL3UEhMOfqDMFzziyHZ3FbOqhGTqk+1HbaGxY2TfnjJHRMXCsrXYl5RxzO8ARNcZwGurY8jzHSNqdi8Bx+CBx05ORiEzJrxSmwMcvlwyLw/o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:8014e388-7f84-40b2-a34d-484b4cddcd6e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:79
X-CID-INFO: VERSION:1.1.26,REQID:8014e388-7f84-40b2-a34d-484b4cddcd6e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:79
X-CID-META: VersionHash:cb9a4e1,CLOUDID:24c0933e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230613152730ZTYEEGP1,BulkQuantity:4,Recheck:0,SF:38|29|28|17|19|48|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40|20,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,
        TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FCD
X-UUID: 851863320a8711ee9cb5633481061a41-20230614
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1471731039; Wed, 14 Jun 2023 15:46:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 15:46:05 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 15:46:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mH5OkvY45CzdQTSvqFuuaFia198dL0tYL2FV15pGq203Q/79tKHgBosjBGFAoNPy94NPRPnePvCaa9+pc3i9Rwp6gRwdbppzIrS1L20P1/2byFMqu+rEY+/zGwAqb6yGxf1Zf/5ceFZoKnx8uxJSI2j11OoikAPKsAeFxnBNHDSlaxElwhtxY8aH3l8J0PFGUsuF40iaSsOSlN98aolEEo63qcDuDmK4cnZHvDPy49aGQpi9Sbcf+7EKVAVpAGVL+yTQTQor2Xq7NpL3j1TLKGZT7aczMvJ4aga7XybxTLnYpQk6yTrUhzzHU9Q5MY/paEDiUpgAP1fPIxBZy1tzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BabtH32petYewVqFiqSWHW8RgCtD8nb1bbgemSXRIiM=;
 b=CVJcPgftZ2kHMArGKuqP+TyGqnsrMqvsFQ0lhhyX2OczQO5mAfJ7KFHkwomTCjn2h+3XD1kYJjltt6jhrqP7XtxLcxuSj1UDuMFzkK3WbMgosbiqaa9t4VSi1E87oBtUFz338rLmriM5cjI6KqrXSUptvGrCgdVNS/ZqarZ/nNoknD4OZKbkeI6f7HowGLoDAhwE0UIBcqwGVnzjr6NjA9WZ5DvhiC4+QUZdHnjweirvW7LiyyiyP294s/KYZxNI15o6sO9zn0tEPBE1j4IeUdsp+0naWYEiwiGOHtd2XE3tarQ19jUee3BsBuRfUa1XgBrYhVGeHIkRVK5xie2YnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BabtH32petYewVqFiqSWHW8RgCtD8nb1bbgemSXRIiM=;
 b=Li2sGhdQu+5whkTtKTY6F5Yzc0J1N3bliaDstCfex+KploWeeJArZO7p3zMNEL9YvsRSVYnrG3iPB1OcMTkZCSJ/Bnp39/m+BUOvzJslkQYKWnG9w7ZSvtnJrBypn2G6s5jnjFiYpO3yfZoXQq10khj2KEY9bf7J9o684sz1q9c=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by TYZPR03MB7082.apcprd03.prod.outlook.com (2603:1096:400:33c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Wed, 14 Jun
 2023 07:44:02 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d%3]) with mapi id 15.20.6455.043; Wed, 14 Jun 2023
 07:44:02 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Claudiu.Beznea@microchip.com" <Claudiu.Beznea@microchip.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
Subject: Re: [PATCH 2/7] ASoC: mediatek: mt79xx: support audio clock control
Thread-Topic: [PATCH 2/7] ASoC: mediatek: mt79xx: support audio clock control
Thread-Index: AQHZnRwi3EsYZyVwBEGsAYE86NWkHK+IVraAgAGXCYA=
Date:   Wed, 14 Jun 2023 07:44:01 +0000
Message-ID: <4583d8df9711fad708da3437284734364610d268.camel@mediatek.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
         <20230612105250.15441-3-maso.huang@mediatek.com>
         <6fde0597-a4f4-8f22-fc31-bc8bef3296d8@microchip.com>
In-Reply-To: <6fde0597-a4f4-8f22-fc31-bc8bef3296d8@microchip.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|TYZPR03MB7082:EE_
x-ms-office365-filtering-correlation-id: 90813e33-4836-48ad-f712-08db6cab1f1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dv55WBvLbzkSH0ujVVWsmCwdYF4IcwyEiVKMW8S4cq0J+s0rjR4ZKFI8W/UQgauU/ihWXrC7HChD8FJ/71TvBORK2lpVZrrEhhKWFhLkDKgRfdHOwOdy0FN7FLLF/f6PnWXrX0VTHQ9/eztgmYz4QvrVVvSttFKjogrIKFiLQMxysMvromAMtxqOqNnm1UlxmIMZaOGXxIkhbKh9Nc2i0UYUf0aLp6WikN0UFbsBW9LjGOsWMH785wTMOdMqTmyaklbFiKy8yNiRYOkNJ8oR6FZMldqT2yNHsFQA4uwC+sWcN11TiMnVG4CNysUvNsMBezQTMcc1tpviy/FWdi4rKs66oTI933NBxpofMIXKjEx8WXeSqBOkE8/QTGzqFAwGS8rEmNMqb004xe+qs5aMUIgTOgSqGDYNRIdtPeai63Bc/KCCjdD5uP4e23skmVHBaKrSUjl5yCfpCZtQp6g4fkKQ9FBhwSYBtNcUjYN9VhsVuxlNaKiahuAbsK4QlSIXNcLgadrIX+172LdHWaoYaw029vecSrwFFSXot23HrPh4T5/yTZ3r/NWb8fHaqBHDEa9qaNrL9TvkgybNpf5fv+bqWyoVXfHeWWgU93UyX8gLZ5i4QAoTACQ66+gD2+VfVsCp6VYPSy8SO3tIBajW9tQgQuOK/ZUZDrqUUYf0HwI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(921005)(122000001)(38100700002)(86362001)(38070700005)(8676002)(5660300002)(8936002)(7416002)(316002)(41300700001)(66946007)(64756008)(66446008)(6636002)(66556008)(66476007)(76116006)(91956017)(83380400001)(110136005)(2616005)(85182001)(186003)(6506007)(6512007)(53546011)(478600001)(36756003)(26005)(2906002)(6486002)(966005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cENwR3pjQURuMnBVN0dyODNnRHh2UDF2ZVg5cmZncExsUTlQTUtlV0tmSU02?=
 =?utf-8?B?OGVFV3I4c2lsbTBJR01EcDhQVUdnWXV3ZEVZRk5JUmJwY3JoeG5LYU9jSldN?=
 =?utf-8?B?Y2Q0TnRPS2JJTGFzWWNvY010Z3doSFowayt2WWdmSkZsMlNZYi9scjRmRktx?=
 =?utf-8?B?T0xndVVSTkFKbWVpdTlSQTY1T0xRVWpvQ1pVTTROZCtPcXAvamxaL0RwRVgy?=
 =?utf-8?B?N1pxU203YmhhTkwrbk8zZHJhMlNmTmpqN09YMGZPMkxQWDMraS9rOUVvRzRp?=
 =?utf-8?B?QWU1bEVkZU95MkJoSlRGTGhPZ0RFYjNFQ0w5c3dtVHIxOEZmV3IvRXp0ajlG?=
 =?utf-8?B?N1RrOFlvQkl2WU9UeUtyeHljRHh5dVV4OHZKcU01ZmwwQ3l6Y250V0FmRVVU?=
 =?utf-8?B?MkRTMkFWYk80dm5lcFpqZ0ltRDJDYUFqdURVM3lROW45c1c1YVRYWkUzdUo3?=
 =?utf-8?B?OG94eFNYVXl3WDZmazVHSHhLR1lWQTF4ZmMvbnZJZnhKNWxyN2NPWUsyNkRK?=
 =?utf-8?B?QVdVc1g0TUZqdzlSV0hEMkVJaDhqWldDNVpMVlZxTGZyOHJCcXJIOFpET3dC?=
 =?utf-8?B?bE5lVnE4U2NrNmZJRUZpQ3VlUnpJeUNMTmJWTTVVVFMzOTB5aWwrOXpzQlpw?=
 =?utf-8?B?ejBtMzZXcFQwRlhDcEMzTnNuSnd0YWpiSW1sWWFyM293d2ZyL1lGLzdUVUo3?=
 =?utf-8?B?em9ML3BrQ3NDNVIrelI3dkthb3M3Ri9EbStCK3JqUks5UnNjeEVhbW5VNTFC?=
 =?utf-8?B?VXQ1VHdGbkEzNUhTUHZNNzY5dTRRNGZSZE93WGdKeStlcndibmRhMUx2SjYz?=
 =?utf-8?B?WjlBZU5nWU1ZZzd0TEVCYnVLWURleU5aU0I1NXBJZzdUUHdrQ3pyR09UWEdt?=
 =?utf-8?B?WWRaTm53dzM2di9LMDRJakJSWmdRRVBKZjl4YXkvY3RmYjVaM2JKb3BTSVNz?=
 =?utf-8?B?WkY5Y2ZseUt3NHUxUFQzKzhyTDRiRVQvMzZrRzVJMFJLNldJanpTTGl1VldK?=
 =?utf-8?B?TjY5UGl5THRkSVcrL0M1cEJQbDRueDNYKys2V096UXNtUkdsNVdGSTlNTUdp?=
 =?utf-8?B?bUNDdlE4ZnF1WThWSHhGeGVxY3NGU2VPMXQ1dDFXRjcwTXlBdVBiZUd6Y2lx?=
 =?utf-8?B?b3gvSEZFeGthSUU2b3A0cGdBSm81eHJSMlRBV0sxUVdNUis4NVJVZzJxT3d4?=
 =?utf-8?B?Rzh6ZXJJODJFUm5tSE1aRnlneThwbjZGUW4rcmhhbzZDM0VMOGlNWmhVd2dz?=
 =?utf-8?B?bUY1Vy9xbk5SRjFXYXRTWm5lZmFXT2pUdXZVdUpBekRWU0pWb2RNQTdJWUx3?=
 =?utf-8?B?MkdEUTBoYmx5VHQ0dFY4QksrQnJadkorZ2Izck9yVzgxSk9vRjB1ZWY0WVov?=
 =?utf-8?B?cVd1aTI0Q09rSFFJQ2YzT0xoa1Q5QkpyZ0NSRk55Y29oTmxiNklhQWhjK0l0?=
 =?utf-8?B?cHZXeXgwamNaY29Udk9UMEhGdVIzVnFReVRSYVhUYVZyZ1BYcU9lWDl3bEVu?=
 =?utf-8?B?ZjI4c25QeUxwSjRrQU5UV0NuTXVuRmVkd29DcXU2b2s0NFMvb2RxYU9jd1NS?=
 =?utf-8?B?S2RhYWR5aHNURFA2WUZpNEc0VldSd2NJek5TbmRQQnhvMDhIa2RvUHJtNVBU?=
 =?utf-8?B?Y2s3cVoxbGpIZWxIdlI3V2NrWkJaZGZXT1Vua05mUTJaMmF4b1BxUDFvd3RV?=
 =?utf-8?B?ejRzQkFIODMvVElJUFVSek5kaXcxWGlHaE0vVXJuMmZIUUdNcFBWc05BcUpq?=
 =?utf-8?B?M1RhSEhueG9EUk9ob3NYUTVuT1RoaTFMR2FUTTFYSTFMUjNZNzJQSnVTTWdE?=
 =?utf-8?B?OFY1SGJhaGg2eFF2N2dka2tFdjVJWEtVUm1wNDNPRkNBWldlVlhDRUlIY1BP?=
 =?utf-8?B?Um13R2JnS0l5QnlUeGRZQkJnVDVpd0ZCcUhlRFNvaUIyMi8vMzNMTE40UUNH?=
 =?utf-8?B?UjluaC9YMlZVVCttQk8xaVpBZUtLODFYNmlmWFdIY0NqbUJOdnpadktyL2JS?=
 =?utf-8?B?cmZDU0M4WXQ5eHJiNDBtTW1vVldMblVsUjRLK3dic29NcTRCc1AwNXdMUjI4?=
 =?utf-8?B?d0psR1RPbGRRUmVHM04xUDUzTURzaHpDekYzQ1U1dHBuYlFwM21DVnJBcC9J?=
 =?utf-8?B?ZDVZVGowZ1ltS1JHL2lEMm9FZ0loQ3NLU1ZNVTJBMVljbncrQXVRS1R5b1Mx?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E12924999905C478E8ED398CC18A439@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90813e33-4836-48ad-f712-08db6cab1f1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 07:44:01.9666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8j7uJhuK9CUpC91qFQ50tPV3QUS+LYlCugCYI+9pXQM81vpKbBNKAsiq9a2dR9Gc9ABt8iIqLacSi47AQKQVjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTEzIGF0IDA3OjI3ICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2No
aXAuY29tIHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQg
dGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIE9uIDEyLjA2LjIwMjMgMTM6NTIsIE1hc28g
SHVuYWcgd3JvdGU6DQo+ID4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBtYXNvLmh1
YW5nQG1lZGlhdGVrLmNvbS4gTGVhcm4gd2h5DQo+IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBz
Oi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+ID4gDQo+ID4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+ID4gDQo+ID4gRnJvbTogTWFzbyBI
dWFuZyA8bWFzby5odWFuZ0BtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gQWRkIGF1ZGlvIGNsb2Nr
IHdyYXBwZXIgYW5kIGF1ZGlvIHR1bmVyIGNvbnRyb2wuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogTWFzbyBIdWFuZyA8bWFzby5odWFuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIHNv
dW5kL3NvYy9tZWRpYXRlay9tdDc5eHgvbXQ3OXh4LWFmZS1jbGsuYyB8IDEyMw0KPiArKysrKysr
KysrKysrKysrKysrKysNCj4gPiAgc291bmQvc29jL21lZGlhdGVrL210Nzl4eC9tdDc5eHgtYWZl
LWNsay5oIHwgIDE4ICsrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE0MSBpbnNlcnRpb25zKCsp
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OXh4L210Nzl4
eC1hZmUtY2xrLmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHNvdW5kL3NvYy9tZWRpYXRlay9t
dDc5eHgvbXQ3OXh4LWFmZS1jbGsuaA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mv
bWVkaWF0ZWsvbXQ3OXh4L210Nzl4eC1hZmUtY2xrLmMNCj4gYi9zb3VuZC9zb2MvbWVkaWF0ZWsv
bXQ3OXh4L210Nzl4eC1hZmUtY2xrLmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uZjAwZjBkN2RlODYxDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsr
KyBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5eHgvbXQ3OXh4LWFmZS1jbGsuYw0KPiA+IEBAIC0w
LDAgKzEsMTIzIEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+
ID4gKy8qDQo+ID4gKyAqIG10Nzl4eC1hZmUtY2xrLmMgIC0tICBNZWRpYVRlayA3OXh4IGFmZSBj
bG9jayBjdHJsDQo+ID4gKyAqDQo+ID4gKyAqIENvcHlyaWdodCAoYykgMjAyMSBNZWRpYVRlayBJ
bmMuDQo+ID4gKyAqIEF1dGhvcjogVmljIFd1IDx2aWMud3VAbWVkaWF0ZWsuY29tPg0KPiA+ICsg
KiAgICAgICAgIE1hc28gSHVhbmcgPG1hc28uaHVhbmdAbWVkaWF0ZWsuY29tPg0KPiA+ICsgKi8N
Cj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiArDQo+ID4gKyNpbmNsdWRl
ICJtdDc5eHgtYWZlLWNvbW1vbi5oIg0KPiA+ICsjaW5jbHVkZSAibXQ3OXh4LWFmZS1jbGsuaCIN
Cj4gPiArI2luY2x1ZGUgIm10Nzl4eC1yZWcuaCINCj4gPiArDQo+ID4gK2VudW0gew0KPiA+ICsg
ICAgICAgQ0tfSU5GUkFfQVVEX0JVU19DSyA9IDAsDQo+ID4gKyAgICAgICBDS19JTkZSQV9BVURf
MjZNX0NLLA0KPiA+ICsgICAgICAgQ0tfSU5GUkFfQVVEX0xfQ0ssDQo+ID4gKyAgICAgICBDS19J
TkZSQV9BVURfQVVEX0NLLA0KPiA+ICsgICAgICAgQ0tfSU5GUkFfQVVEX0VHMl9DSywNCj4gPiAr
ICAgICAgIENMS19OVU0NCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBjaGFyICph
dWRfY2xrc1tDTEtfTlVNXSA9IHsNCj4gPiArICAgICAgIFtDS19JTkZSQV9BVURfQlVTX0NLXSA9
ICJhdWRfYnVzX2NrIiwNCj4gPiArICAgICAgIFtDS19JTkZSQV9BVURfMjZNX0NLXSA9ICJhdWRf
MjZtX2NrIiwNCj4gPiArICAgICAgIFtDS19JTkZSQV9BVURfTF9DS10gPSAiYXVkX2xfY2siLA0K
PiA+ICsgICAgICAgW0NLX0lORlJBX0FVRF9BVURfQ0tdID0gImF1ZF9hdWRfY2siLA0KPiA+ICsg
ICAgICAgW0NLX0lORlJBX0FVRF9FRzJfQ0tdID0gImF1ZF9lZzJfY2siLA0KPiA+ICt9Ow0KPiA+
ICsNCj4gPiAraW50IG10Nzl4eF9pbml0X2Nsb2NrKHN0cnVjdCBtdGtfYmFzZV9hZmUgKmFmZSkN
Cj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IG10Nzl4eF9hZmVfcHJpdmF0ZSAqYWZlX3ByaXYg
PSBhZmUtPnBsYXRmb3JtX3ByaXY7DQo+ID4gKyAgICAgICBpbnQgaTsNCj4gPiArDQo+ID4gKyAg
ICAgICBhZmVfcHJpdi0+Y2xrID0gZGV2bV9rY2FsbG9jKGFmZS0+ZGV2LCBDTEtfTlVNLA0KPiBz
aXplb2YoKmFmZV9wcml2LT5jbGspLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBHRlBfS0VSTkVMKTsNCj4gPiArICAgICAgIGlmICghYWZlX3ByaXYtPmNsaykNCj4g
PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsgICAgICAgZm9y
IChpID0gMDsgaSA8IENMS19OVU07IGkrKykgew0KPiA+ICsgICAgICAgICAgICAgICBhZmVfcHJp
di0+Y2xrW2ldID0gZGV2bV9jbGtfZ2V0KGFmZS0+ZGV2LA0KPiBhdWRfY2xrc1tpXSk7DQo+ID4g
KyAgICAgICAgICAgICAgIGlmIChJU19FUlIoYWZlX3ByaXYtPmNsa1tpXSkpIHsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGFmZS0+ZGV2LCAiJXMoKSwgZGV2bV9jbGtfZ2V0
ICVzDQo+IGZhaWwsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQgJWxk
XG4iLCBfX2Z1bmNfXywgYXVkX2Nsa3NbaV0sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBQVFJfRVJSKGFmZV9wcml2LT5jbGtbaV0pKTsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gUFRSX0VSUihhZmVfcHJpdi0+Y2xrW2ldKTsNCj4gPiArICAgICAgICAg
ICAgICAgfQ0KPiA+ICsgICAgICAgfQ0KPiANCj4gWW91IGNhbiB1c2UgZGV2bV9jbGtfYnVsa19n
ZXQoKQ0KPiANCg0KSGkgQ2xhdWRpdSwNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQpJJ2xsIHVz
ZSB0aGlzIGFwaSBpbiB2MiBwYXRjaC4NCg0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0K
PiA+ICt9DQo+ID4gKw0KPiA+ICtpbnQgbXQ3OXh4X2FmZV9lbmFibGVfY2xvY2soc3RydWN0IG10
a19iYXNlX2FmZSAqYWZlKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgbXQ3OXh4X2FmZV9w
cml2YXRlICphZmVfcHJpdiA9IGFmZS0+cGxhdGZvcm1fcHJpdjsNCj4gPiArICAgICAgIGludCBy
ZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGFmZV9wcml2
LQ0KPiA+Y2xrW0NLX0lORlJBX0FVRF9CVVNfQ0tdKTsNCj4gPiArICAgICAgIGlmIChyZXQpIHsN
Cj4gPiArICAgICAgICAgICAgICAgZGV2X2VycihhZmUtPmRldiwgIiVzKCksIGNsa19wcmVwYXJl
X2VuYWJsZSAlcyBmYWlsDQo+ICVkXG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIF9f
ZnVuY19fLCBhdWRfY2xrc1tDS19JTkZSQV9BVURfQlVTX0NLXSwNCj4gcmV0KTsNCj4gPiArICAg
ICAgICAgICAgICAgZ290byBDS19JTkZSQV9BVURfQlVTX0NLX0VSUjsNCj4gPiArICAgICAgIH0N
Cj4gPiArDQo+ID4gKyAgICAgICByZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoYWZlX3ByaXYtDQo+
ID5jbGtbQ0tfSU5GUkFfQVVEXzI2TV9DS10pOw0KPiA+ICsgICAgICAgaWYgKHJldCkgew0KPiA+
ICsgICAgICAgICAgICAgICBkZXZfZXJyKGFmZS0+ZGV2LCAiJXMoKSwgY2xrX3ByZXBhcmVfZW5h
YmxlICVzIGZhaWwNCj4gJWRcbiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgX19mdW5j
X18sIGF1ZF9jbGtzW0NLX0lORlJBX0FVRF8yNk1fQ0tdLA0KPiByZXQpOw0KPiA+ICsgICAgICAg
ICAgICAgICBnb3RvIENLX0lORlJBX0FVRF8yNk1fRVJSOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsN
Cj4gPiArICAgICAgIHJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShhZmVfcHJpdi0+Y2xrW0NLX0lO
RlJBX0FVRF9MX0NLXSk7DQo+ID4gKyAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAg
ICAgIGRldl9lcnIoYWZlLT5kZXYsICIlcygpLCBjbGtfcHJlcGFyZV9lbmFibGUgJXMgZmFpbA0K
PiAlZFxuIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgYXVkX2Nsa3Nb
Q0tfSU5GUkFfQVVEX0xfQ0tdLA0KPiByZXQpOw0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIENL
X0lORlJBX0FVRF9MX0NLX0VSUjsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBy
ZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoYWZlX3ByaXYtDQo+ID5jbGtbQ0tfSU5GUkFfQVVEX0FV
RF9DS10pOw0KPiA+ICsgICAgICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZf
ZXJyKGFmZS0+ZGV2LCAiJXMgY2xrX3ByZXBhcmVfZW5hYmxlICVzIGZhaWwNCj4gJWRcbiIsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGF1ZF9jbGtzW0NLX0lORlJBX0FV
RF9BVURfQ0tdLA0KPiByZXQpOw0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIENLX0lORlJBX0FV
RF9BVURfQ0tfRVJSOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJldCA9IGNs
a19wcmVwYXJlX2VuYWJsZShhZmVfcHJpdi0NCj4gPmNsa1tDS19JTkZSQV9BVURfRUcyX0NLXSk7
DQo+ID4gKyAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoYWZl
LT5kZXYsICIlcyBjbGtfcHJlcGFyZV9lbmFibGUgJXMgZmFpbA0KPiAlZFxuIiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgYXVkX2Nsa3NbQ0tfSU5GUkFfQVVEX0VHMl9D
S10sDQo+IHJldCk7DQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gQ0tfSU5GUkFfQVVEX0VHMl9D
S19FUlI7DQo+ID4gKyAgICAgICB9DQo+IA0KPiBBbmQgY2xrX2J1bGtfcHJlcGFyZV9lbmFibGUo
KSBpbnN0ZWFkIGFsbCB0aGVzZS4NCj4gDQoNCkknbGwgdXNlIHRoaXMgYXBpIGluIHYyIHBhdGNo
Lg0KDQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICtDS19JTkZSQV9B
VURfRUcyX0NLX0VSUjoNCj4gPiArICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShhZmVfcHJp
di0+Y2xrW0NLX0lORlJBX0FVRF9BVURfQ0tdKTsNCj4gPiArQ0tfSU5GUkFfQVVEX0FVRF9DS19F
UlI6DQo+ID4gKyAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoYWZlX3ByaXYtPmNsa1tDS19J
TkZSQV9BVURfTF9DS10pOw0KPiA+ICtDS19JTkZSQV9BVURfTF9DS19FUlI6DQo+ID4gKyAgICAg
ICBjbGtfZGlzYWJsZV91bnByZXBhcmUoYWZlX3ByaXYtPmNsa1tDS19JTkZSQV9BVURfMjZNX0NL
XSk7DQo+ID4gK0NLX0lORlJBX0FVRF8yNk1fRVJSOg0KPiA+ICsgICAgICAgY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKGFmZV9wcml2LT5jbGtbQ0tfSU5GUkFfQVVEX0JVU19DS10pOw0KPiA+ICtDS19J
TkZSQV9BVURfQlVTX0NLX0VSUjoNCj4gPiArICAgICAgIHJldHVybiByZXQ7DQo+ID4gK30NCj4g
PiArRVhQT1JUX1NZTUJPTF9HUEwobXQ3OXh4X2FmZV9lbmFibGVfY2xvY2spOw0KPiA+ICsNCj4g
PiAraW50IG10Nzl4eF9hZmVfZGlzYWJsZV9jbG9jayhzdHJ1Y3QgbXRrX2Jhc2VfYWZlICphZmUp
DQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBtdDc5eHhfYWZlX3ByaXZhdGUgKmFmZV9wcml2
ID0gYWZlLT5wbGF0Zm9ybV9wcml2Ow0KPiA+ICsNCj4gPiArICAgICAgIGNsa19kaXNhYmxlX3Vu
cHJlcGFyZShhZmVfcHJpdi0+Y2xrW0NLX0lORlJBX0FVRF9FRzJfQ0tdKTsNCj4gPiArICAgICAg
IGNsa19kaXNhYmxlX3VucHJlcGFyZShhZmVfcHJpdi0+Y2xrW0NLX0lORlJBX0FVRF9BVURfQ0td
KTsNCj4gPiArICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShhZmVfcHJpdi0+Y2xrW0NLX0lO
RlJBX0FVRF9MX0NLXSk7DQo+ID4gKyAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoYWZlX3By
aXYtPmNsa1tDS19JTkZSQV9BVURfMjZNX0NLXSk7DQo+ID4gKyAgICAgICBjbGtfZGlzYWJsZV91
bnByZXBhcmUoYWZlX3ByaXYtPmNsa1tDS19JTkZSQV9BVURfQlVTX0NLXSk7DQo+ID4gKw0KPiAN
Cj4gQW5kIGFsc28gY2xrX2J1bGtfZGlzYWJsZV91bnByZXBhcmUoKSBoZXJlLg0KPiANCg0KSSds
bCB1c2UgdGhpcyBhcGkgaW4gdjIgcGF0Y2guDQoNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+
ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKG10Nzl4eF9hZmVfZGlzYWJsZV9jbG9jayk7DQo+
ID4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5eHgvbXQ3OXh4LWFmZS1jbGsu
aA0KPiBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDc5eHgvbXQ3OXh4LWFmZS1jbGsuaA0KPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5iZjljM2VkYjY5MjIN
Cj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvc291bmQvc29jL21lZGlhdGVrL210Nzl4eC9t
dDc5eHgtYWZlLWNsay5oDQo+ID4gQEAgLTAsMCArMSwxOCBAQA0KPiA+ICsvKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiA+ICsvKg0KPiA+ICsgKiBtdDc5eHgtYWZlLWNs
ay5oICAtLSAgTWVkaWFUZWsgNzl4eCBhZmUgY2xvY2sgY3RybCBkZWZpbml0aW9uDQo+ID4gKyAq
DQo+ID4gKyAqIENvcHlyaWdodCAoYykgMjAyMSBNZWRpYVRlayBJbmMuDQo+ID4gKyAqIEF1dGhv
cjogVmljIFd1IDx2aWMud3VAbWVkaWF0ZWsuY29tPg0KPiA+ICsgKiAgICAgICAgIE1hc28gSHVh
bmcgPG1hc28uaHVhbmdAbWVkaWF0ZWsuY29tPg0KPiA+ICsgKi8NCj4gPiArDQo+ID4gKyNpZm5k
ZWYgX01UNzlYWF9BRkVfQ0xLX0hfDQo+ID4gKyNkZWZpbmUgX01UNzlYWF9BRkVfQ0xLX0hfDQo+
ID4gKw0KPiA+ICtzdHJ1Y3QgbXRrX2Jhc2VfYWZlOw0KPiA+ICsNCj4gPiAraW50IG10Nzl4eF9p
bml0X2Nsb2NrKHN0cnVjdCBtdGtfYmFzZV9hZmUgKmFmZSk7DQo+ID4gK2ludCBtdDc5eHhfYWZl
X2VuYWJsZV9jbG9jayhzdHJ1Y3QgbXRrX2Jhc2VfYWZlICphZmUpOw0KPiA+ICtpbnQgbXQ3OXh4
X2FmZV9kaXNhYmxlX2Nsb2NrKHN0cnVjdCBtdGtfYmFzZV9hZmUgKmFmZSk7DQo+ID4gKyNlbmRp
Zg0KPiA+IC0tDQo+ID4gMi4xOC4wDQo+ID4gDQo+ID4gDQo+ID4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdA0KPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bA0KPiANCj4gDQoNCkJlc3QgcmVnYXJkcywNCk1hc28NCg==
