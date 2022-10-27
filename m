Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ED160F9C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiJ0NzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiJ0NzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:55:12 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C65C1EC63;
        Thu, 27 Oct 2022 06:54:48 -0700 (PDT)
X-UUID: 8c1c48b664b44ed6aa1bc436e0fc4a49-20221027
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NOBAVbl2sOcBWpNyokfUezISW/fIcm/vRguM+lad98g=;
        b=ZNfLUp+W/c+aGdLsxJ7GuYpGk8Wav1d9z3U3pzM0sYOW50+XZbwjWEc1CVDr19R3dLb219Jv7xM6IOS0G0LI5d9X+YN5V97yjdhp6a1nPgQ266b9+9JIaOY5glJhWaHBgXECp9qpCoKgretYcdSx9pffPYOAPk1sWQnICV4My4c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:83db5438-1b19-476b-adba-0ffe99bbb137,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.12,REQID:83db5438-1b19-476b-adba-0ffe99bbb137,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:62cd327,CLOUDID:3636dfe4-e572-4957-be22-d8f73f3158f9,B
        ulkID:2210262326504FFSA4QL,BulkQuantity:29,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: 8c1c48b664b44ed6aa1bc436e0fc4a49-20221027
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 927787607; Thu, 27 Oct 2022 21:54:44 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 27 Oct 2022 21:54:43 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 27 Oct 2022 21:54:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPu4k4yBVUDBvX8D0pBq0GglOFBLJAj0fkYvJMWNTJFpUuGttRPiEFvSy8OBnS7qz6CatWtDgo7FesiD9u6blnlhsbDA5eD1Ln0OrXJNj7oQdwvLmsTd9qjjWzwCT+QdkAZiUvp5OTFDbeS/DXrQvoGxOCbV/8AlYlL5nfANixLZyJJ102hNPhtYcSTVxHxuh6R57dDO/3H7Hd9yITzoKhW5ZnAIMx3o5Y2olkGGJCs7CB3ktPUhki92IXrWJYJbdLCfIdRm2+XuOggQuGQGnwWWgCfvpdn85pCeBoWPUlIuDtRY3orPr9MTPYL35e+iurYMVegDhoM97E0NdfkupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOBAVbl2sOcBWpNyokfUezISW/fIcm/vRguM+lad98g=;
 b=n4p7bZ84mAuiuGmioQdBDXtiZw2+b71WT8cdoyEPcont+GdSbymSqFFu71sZrLuXiwoQGsOKk2/ZjjvzfrOcC0sBq78Ak9sf+FaKhctLMA3kYAz62CKO893jXwiOyNNK6xbPliC8aAEDT0fHuVcrED5457ztQ7uNVGgBofJm2hEtOLyg9T5SUzpU/7Tb9dG+9eMQ3WNmsmNP37uEEQhtMZZovF52VT2pImV4y9vqENnNc9x0WKTd+e0lQ3YQlJDMc8wpOd/DWWHlz7wmD4ZpIZDI1qVyKVDNvRk+OqbxvsigYM34Mhftki7qx30hJWVbBkue4nV/tgDMdmqamQ/c+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOBAVbl2sOcBWpNyokfUezISW/fIcm/vRguM+lad98g=;
 b=W+MQKiqpX6R2UKgftjl5ON0XLPTuhRQooctNPrs4mdHgdjnX1dYOpdbHwvpd9mx9vO1tgPtyLWKiGzNWif0v16ihYZkF+5MfUHewqhubc3OcQeA8vxLvu0pJxy1rkZ71lWVuhvfVXh88ojRQdd5P3OBtjkLK0Ty6P39TcVmMWAI=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SG2PR03MB6612.apcprd03.prod.outlook.com (2603:1096:4:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 13:54:36 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::aafc:9c3e:1c76:c891]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::aafc:9c3e:1c76:c891%7]) with mapi id 15.20.5769.013; Thu, 27 Oct 2022
 13:54:35 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        =?utf-8?B?UnVueWFuZyBDaGVuICjpmYjmtqbmtIsp?= 
        <Runyang.Chen@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [RESEND v3 1/3] dt-bindings: watchdog: Add compatible for
 MediaTek MT8188
Thread-Topic: [RESEND v3 1/3] dt-bindings: watchdog: Add compatible for
 MediaTek MT8188
Thread-Index: AQHY6QT4ocXGA4ckS0yyWspoIxwFm64gzKyAgAEUB4CAABFXgIAAT+IAgAADUwA=
Date:   Thu, 27 Oct 2022 13:54:35 +0000
Message-ID: <c42c4fff91a0794ff0514880182564d28026297a.camel@mediatek.com>
References: <20221026063327.20037-1-Runyang.Chen@mediatek.com>
         <20221026063327.20037-2-Runyang.Chen@mediatek.com>
         <20221026152645.GA2946818@roeck-us.net>
         <e889728c-13e9-37f8-4d1a-e31332a39498@collabora.com>
         <5abd63240a7890895a6de26a52fc24086f1c8ddb.camel@mediatek.com>
         <e6035c60-29b7-a03e-29cd-77c37f5375e6@roeck-us.net>
In-Reply-To: <e6035c60-29b7-a03e-29cd-77c37f5375e6@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SG2PR03MB6612:EE_
x-ms-office365-filtering-correlation-id: e1e04eb3-fd79-4a54-c492-08dab822c80f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gLKG5mK2cAn8jYpJBDEHGBiFm7LTicIjVZNoJailzESNJH97RW8G/Gz3Y9cItdRD+YS/U1xjRQgpUEO+fmqc01dX20B/4YT/DR2QDr3PYxjYSSMrBhugAQieBC9VVM8kdkVjUnYnInCwZOd1tpC3/NVot02GYP6gpLO2hEikCeQTgdTyX9Cz6kaXoPtN1CVuh4eQj7BT3s9JMtALuX/CJiFA21e71UhhlJp5ElozNsAi4ebEsDrAZTDFiFwKL0l/Sn/4mwnHbjluS4KcUxmZz2Km/jNx308ohrshWK+0QWgKrggzmZpe9dAdhy8LNaaKl15VCKzb3UYVxjiDSE4UpthNy+edp96ohiyfX8yRlrkIqHemcXjk8phLmztQJ2wA86Q07k+T64zhx4ApyOf81VFC8M1BGlp7BDXZ3NXaglfiAQ5AutmufruOgoikz6u7cAaT9gsCsx54In1mLPzf810nSRIdJ05xhQqmB2ZlAALT/aSJNnqb95NjnGq4CPmiCKKqDRBSeJaHF4V3hLwxIfsjCd9odZ7ZXUqfw5HvA+y17kcQ4PB1eLmJOPCaPzBAY0HEUyOHfiBwZTsQ5NXSG6mlafzupUdLaAJRrRuiaH64QPgGZG+unO0wB4SuAqIM8FIEyk5V6tBKSDwxyQEwffDOMDdAtIwLogubQ0aFsMEZGHfO0bpHQQ/VBD805srumMORIPg9VTqcAHPVgJssUfZQRZgPJO//L9Gfivqqw5I+ITlHO1VJqpNztObYW4s3uNW+SfDOez6qMulWA3UIxAFeqZEx3h3FboMx5aF5sQ0xZWPORhiAcFvgiSI62und7BSPWV9aXmI3yNohKij9IQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(478600001)(38100700002)(85182001)(316002)(54906003)(6486002)(966005)(86362001)(38070700005)(122000001)(71200400001)(110136005)(36756003)(186003)(2616005)(53546011)(6512007)(26005)(6506007)(5660300002)(2906002)(4001150100001)(7416002)(76116006)(8676002)(66556008)(66476007)(66946007)(4326008)(66446008)(64756008)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0JvcUJYMW5oRVB0TG9neUhlUkdTNHpLZjZlK0luNUM2dlgrVmNpQ0lQSnly?=
 =?utf-8?B?RWpaTWZiSnFzMmxGa3ZRUVNKTzh5cjlTZ2ZkRFF2TDRtZUJ6dUl6cTJjVWN6?=
 =?utf-8?B?Q0dyWExnYWlSdWZDTEoxK2kvMjZ5WE9GYnNYay9kMmZMejE4ZHFTSUM2WUdW?=
 =?utf-8?B?eCs5L2lubU1yM2dwNlBEQnMzditjVlZCTUs5eWlpeDZDUy94Ri9iWnhkSFB1?=
 =?utf-8?B?Uk85azltcEh5cEFYZEVicCtyRTlWK2crb2hlTURZa1RsTGNWRHNhMW85MWFU?=
 =?utf-8?B?WHhrbml5VE0rWUdEQzB4a3BwRFhkc1YzTGRBTi9FMDVuYWF0MUhUejZxcGdR?=
 =?utf-8?B?bjNaZ0xLN3NCeE5FdUdKTDFvS2xPKzh0WVhFbStWaVh5c0pSNGEyYjlnQWRw?=
 =?utf-8?B?R2hWNGFKUmhaZndGQ09oNHJKdEFicDlrYmlWTkZDRDBlM1MzQ1BjTk13bFZU?=
 =?utf-8?B?REprQjI5Ym5zblQ3L21kV0ZKbFpoTnR1bkhQcTZyeEVyQXZ4UnQyS25LOXhD?=
 =?utf-8?B?MC9DeDF5NEFMUEMrM3RLVFpqRXB6Q2VDbHM0Q0E4aW01dHBvWnFOcnFRd1dZ?=
 =?utf-8?B?QWM1ODJnNk5rckNvTFU0N2tJM282ME10WEtROFRPd1Jqd0psUTBzaml3NkVp?=
 =?utf-8?B?Y0N1M2MvWlZCWHhkWVphY3BHblFpVDVOYytRSGlyTWtQSXR1djBWM2lacmtL?=
 =?utf-8?B?bXJtQzlxdlBzMFBCVmRvZ0c2enhXaGRpcUNoRW4vTEYyanQ2M1lwTWJxeGNR?=
 =?utf-8?B?bkttRWlMemRtRGJLYThyUUtZeGNjT0d1a0lMaFE5dkxLRzNUalpqdUhQN3FT?=
 =?utf-8?B?eHZTd0NudXpUTko2U25TSVMwREliS05KNUlCRlkrU0R6UC9lcWRGNFN0NDl2?=
 =?utf-8?B?M2t5VW12emk0eWxqY2RzVlFRK2NueExLTHFBSStRMDhuTXZOL2p5S3U4TEpF?=
 =?utf-8?B?Z3g4TVNBMEMvT3lhS0ovcldXMWxlZkRqbExFVzFHeCt3OXYzOVFpUUhCeUVF?=
 =?utf-8?B?QWIvcitjOVRCazI2VmtrdlpUalZqdzZJcXZzd3lucEZPV2J4L2YxYlM3dnJm?=
 =?utf-8?B?c0s3enNGMjNzeTgwM3c5NGlkOUMzZ2ZBTHpUZHl0STF6cEY2RVB4YzFpT3E1?=
 =?utf-8?B?UThVSlhBcmFZMDd4NldPdG10dGpOZlc2YVFwWENvZUJYcXJlSDRRVTdBUEFu?=
 =?utf-8?B?VzRQeUlnaElLcCs0WHk5SkZ5Y2RMb1BCTDc1Q3JUSEtMM1greGhFS3F3NEV6?=
 =?utf-8?B?ZXE1aEZabmVwbEpoR1dhNmd2aCtpYWVWQkE4dlMyZHRGN2JsdkhOd1B5MytV?=
 =?utf-8?B?NHpZWmRrNjNxUUVwR0Q4YkRHVk01ZFZEdjhCdVM3V05lbWx0dGJiSmZxRnB1?=
 =?utf-8?B?T1ZDcldyVmFDUDYwQVZtSjF5UXVJaXMxMjMxQjJqcmxZM0VTcFluS2NEL3pM?=
 =?utf-8?B?eTNrM0MvL2xHQWtmOWN1SExvR2Y4WGtVY0tTTjk3Z2c1M2t6RzVPNUVpWmp6?=
 =?utf-8?B?Vk1tS2RTM1ZUZUI2RkgvK0VkU1c2Zm9YSzF6OWdyVVdrWG53Z2x6bk1xcnVv?=
 =?utf-8?B?MmlrTUs0T0dlTjZHL0lFeXlnUDM5SUU5Y3QyZUlJd2FET0JSL2lBWFRUMXhy?=
 =?utf-8?B?RXVLRFFyL2VqTEZRRnZvdk1WN2hVcWw2U05EUUNsdVBSZEhZSmFOdXBBYnY2?=
 =?utf-8?B?QmZtY0s3UytqdVZrcVc3ZGpBOHBhcEVSNWs2MEJGRUI1OTEzaUVMUTlKVXdn?=
 =?utf-8?B?Vm9Pd1BuWTNSbi9Yb0ViN1R4RHg4VUZ5bzBkR1BhZGlFc3F4ZFYzMGJVczZo?=
 =?utf-8?B?ZUhtaVZXVFUzRjdNWWVwNC9sY3pJNGExWDFvQ0ZqNG90YWpBSGU3UkpWakdm?=
 =?utf-8?B?SXltWjkyK0s3V3BnTmlOZW1TQVc2RnN3YmtYdG9jZ2ZLdlFrdzROeThVNm54?=
 =?utf-8?B?R2gvVk9LQXEyNk5WazJ5TjdjWDcxV2RyS0VjNS9Ya2UxVXBrWlFkMTF1NllR?=
 =?utf-8?B?MXJqdEs5Sy9FeWNOK1hkV1dtYjcydUpQUHVEY1NBZkhFNFBTMExvaklUUFVY?=
 =?utf-8?B?Vi9TRFRzTHF1NWRpRHNzdTVMUmJoQlVKbjRkbVNGQTdSV0cvZkh0RE5HbG5D?=
 =?utf-8?B?NFhwdXJOZGRjUy85a0JLR1ZqWUVEMkZlUUwyZVA0U1F2cFNtM2dyUjhzWGRn?=
 =?utf-8?Q?rBq+C2sOCWmukrrXAhG7Mpc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56BADE914D62B644AF2A12755E5A5FA9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e04eb3-fd79-4a54-c492-08dab822c80f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 13:54:35.0753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vOkbE9OmRG+c5OS/ukdP4ZuAQ5T8QdbL0PcH6wIFgroRTBOSDz4AYZpCo+WtUF+IsJw8ssLqtw/tr9R6soun2UjvuCchED2kPkHZeXp2FbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6612
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTI3IGF0IDA2OjQyIC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBPbiAxMC8yNy8yMiAwMTo1NiwgQWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsykgd3JvdGU6DQo+
ID4gT24gVGh1LCAyMDIyLTEwLTI3IGF0IDA5OjU0ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERl
bCBSZWdubw0KPiA+IHdyb3RlOg0KPiA+ID4gSWwgMjYvMTAvMjIgMTc6MjYsIEd1ZW50ZXIgUm9l
Y2sgaGEgc2NyaXR0bzoNCj4gPiA+ID4gT24gV2VkLCBPY3QgMjYsIDIwMjIgYXQgMDI6MzM6MjVQ
TSArMDgwMCwgUnVueWFuZyBDaGVuIHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IFJ1bnlhbmcgQ2hl
biA8cnVueWFuZy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBZGQg
ZHQtYmluZGluZyBkb2N1bWVudGF0aW9uIG9mIHdhdGNoZG9nIGZvciBNZWRpYVRlayBNVDgxODgN
Cj4gPiA+ID4gPiBTb2MNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSdW55
YW5nIENoZW4gPHJ1bnlhbmcuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gQWNrZWQtYnk6
IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZw0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVn
bm8gPA0KPiA+ID4gPiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4N
Cj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgY29uZmxpY3RzIHdpdGggdGhlIG9uZ29pbmcgeWFtbCBj
b252ZXJzaW9uIG9mIHRoaXMgZmlsZQ0KPiA+ID4gPiB3aGljaCBpcyBzdGlsbCBub3QgYWNjZXB0
ZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiANCj4gPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5j
b20vdjMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2F0Y2hk
b2cvcGF0Y2gvMjAyMjEwMDUxMTM1MTcuNzA2MjgtNC1hbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25v
QGNvbGxhYm9yYS5jb20vX187ISFDVFJOS0E5d01nMEFSYnchelQzOU9laEQ0Z255REtQWXdNYkxk
ZXlHSV9vTk9mdldhNEhJcmNvb0wzQXg4TzctTi1CalhCWkFvbHNDT3VMYjM5Zko3USQNCj4gPiA+
ID4gIA0KPiA+ID4gPiANCj4gPiA+ID4gTmV2ZXJ0aGVsZXNzLCBJJ2xsIGFwcGx5IHRoaXMgc2Vy
aWVzIHRvIG15IHdhdGNoZG9nLW5leHQgYnJhbmNoDQo+ID4gPiA+IGFuZCBhc3N1bWUgdGhhdCBp
dCB3aWxsIGJlIGluY2x1ZGVkIGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlDQo+ID4gPiA+IHlh
bWwgY29udmVyc2lvbiBwYXRjaC4NCj4gPiA+ID4gDQo+ID4gPiA+IEZvciBteSBhbmQgV2ltJ3Mg
cmVmZXJlbmNlOg0KPiA+ID4gPiANCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEd1ZW50ZXIgUm9lY2sg
PGxpbnV4QHJvZWNrLXVzLm5ldD4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4g
R3VlbnRlcg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gQWRkaW5nIEFsbGVuIHRvIHRoZSBDYydz
IHRvIG1ha2UgaGltIGF3YXJlIG9mIHRoYXQsIGFzIGhlIHRvb2sNCj4gPiA+IG92ZXINCj4gPiA+
IHRoZQ0KPiA+ID4gbXRrLXdkdCB5YW1sIGNvbnZlcnNpb24uDQo+ID4gDQo+ID4gSGkgR3VlbnRl
ciwNCj4gPiANCj4gPiBJIGNhbiBzZW5kIHRoZSBmb2xsb3dpbmcgdmVyc2lvbiBvZiB5YW1sIGNv
bnZlcnNpb25bMV0gZm9yDQo+ID4gY29uZmxpY3RzDQo+ID4gYWZ0ZXIgeW91IGFwcGx5IHRoaXMg
c2VyaWVzLiBUaGFua3MuDQo+ID4gDQo+ID4gWzFdDQo+ID4gDQo+ID4gDQpodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4
LW1lZGlhdGVrL3BhdGNoLzIwMjIxMDA3MDkzNDM3LjEyMjI4LTYtYWxsZW4ta2guY2hlbmdAbWVk
aWF0ZWsuY29tL19fOyEhQ1RSTktBOXdNZzBBUmJ3IXg0RkhGNXBkTHh6UEpnR2NRdDB5bkw2d2xt
dkVUTUd2SlVDTzluMWhsSTgtYmVlS05ZRW5PTndubDUtV0k0a3ZDVi00NXckDQo+ID4gIA0KPiA+
IA0KPiANCj4gWW91IGRpZCBub3QgY29weSB0aGUgd2F0Y2hkb2cgbWFpbGluZyBsaXN0IHdpdGgg
dGhpcyBwYXRjaCwgY2F1c2luZw0KPiBpdCB0byBnZXQgbG9zdA0KPiBmcm9tIG15IHF1ZXVlIChl
dmVuIHRob3VnaCBJIGhhZCBhIGxvb2sgYXQgaXQpLiBJZiB0aGVyZSB3ZXJlIG90aGVyDQo+IHdh
dGNoZG9nIHJlbGF0ZWQNCj4gcGF0Y2hlcyBpbiB0aGlzIHZlcnNpb24gb2YgdGhlIHNlcmllcywg
dGhleSBnb3QgbG9zdCBhcyB3ZWxsLg0KPiANCj4gR3VlbnRlcg0KPiANCg0KSSBhcG9sb2dpemUg
Zm9yIG1pc3NpbmcgdGhpcyBhbmQgd2lsbCBwYXkgYXR0ZW50aW9uIG5leHQgdGltZSAodjMpLg0K
DQpCUnMsDQpBbGxlbg0KDQo=
