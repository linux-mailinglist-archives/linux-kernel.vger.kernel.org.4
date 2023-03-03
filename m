Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000496A967F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjCCLhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjCCLhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:37:32 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEEF5D8B2;
        Fri,  3 Mar 2023 03:36:59 -0800 (PST)
X-UUID: b0bfe422b9b711ed945fc101203acc17-20230303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=rYWiWlbBhuA2v1gGVevug7XqPqlzJJiMf0k/VE/jAHg=;
        b=Rqza16P//hZ/QRUhMT/uf25WEWPnOz4WVFDRd5M25NJSizWazaTiRsA/juxlQPLd7didcA9EsQl2djMBAJnyq1VgPEg2p6pvwrXxyyJ9nRrG3Ifxc/0xK31WT/j7Qfas5B/sIZaKnMfSaxECNFCets+tuMG4ASPor8NNjUBGG24=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:b5628e10-3d36-4318-a076-74888178a821,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.20,REQID:b5628e10-3d36-4318-a076-74888178a821,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:25b5999,CLOUDID:ab854027-564d-42d9-9875-7c868ee415ec,B
        ulkID:230303192407MNJPZQKF,BulkQuantity:7,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0
        ,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: b0bfe422b9b711ed945fc101203acc17-20230303
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 304837705; Fri, 03 Mar 2023 19:36:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 3 Mar 2023 19:36:50 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 3 Mar 2023 19:36:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1CsJjhmEN4uZzq6Zpz2QqhAI/Rb4VfMt4bHsmtD4jw8ivAEt270UJayLCCCcq9rlcx/0vypp/pHF5iZpxOzPboPme69PXxqo7YEahfL0DdMYaMl9Ajyt9ZjeE+Rtx8o0kimMFmDtXc38VWShga0bmjtKuD/iSm2Q0HKsajtdxCSgIclZKM5H3UsTfESmc29QxrAD5bNvi317vhWvE+xGP0VeBZuQtztUf/EmWcnxtSHmTncACmnZwWl9oGGGkEG/5Ix6Hq3YI6HhwRmwn0amaitEskMxQkEwHXXqDpe9ILvkoDdB5A63wA13q8JngdCNRvJft7HUXsn45aWZND0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYWiWlbBhuA2v1gGVevug7XqPqlzJJiMf0k/VE/jAHg=;
 b=VKiWIZ5DtIBfoIle+WSqM8cVKBtF7HFpIO7IxhRB2ffzo+qCejLgDkoLIjH16lBKDEOBKKF7a7kOXQESl4ZrgLJ5E4ziiraSe9bJpReCS4h7VamVztsE8XstcRV9VZjCX2dWRUXSWzXSpq2jLTSIf72YTa/Prlu8US7duhjZYd5AiGOI6EJnuG99TpXo27OvKPNVmdw8v4/MCgbQ/eJVcutUBDH6ZyUHImjCikdsay7bkFGnOxM/QudbQ9yWxZVdeNccCq/ZjC/GjLPzyTif7Owvawplip/nms5SOwotGICmZtjWDLGvDoE3rIfD761GGPv23KOLKhmmase0MNTPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYWiWlbBhuA2v1gGVevug7XqPqlzJJiMf0k/VE/jAHg=;
 b=gw7NEK6QdnUMdWpAMPiNdpIL1Wf2hdIXQmSICrjmoevcWSsnCPArrncJVfXP8vCPrrQfrWi3/WRopPfbVFuFoN5gpVq/W8pm18A4fIMyDPZG/9TdHWFX/rPrfnyYQRDEmoXc3Y2EF0Ngv+oerokjMFIhj7u7NcVgVxlj+eLNjwA=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SI2PR03MB5676.apcprd03.prod.outlook.com (2603:1096:4:15b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 11:36:47 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::c821:f285:9b2f:35e8]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::c821:f285:9b2f:35e8%4]) with mapi id 15.20.6134.031; Fri, 3 Mar 2023
 11:36:47 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: mediatek: Add cpufreq nodes for MT8192
Thread-Topic: [PATCH v2] arm64: dts: mediatek: Add cpufreq nodes for MT8192
Thread-Index: AQHZTXPvXQ24s1a5pkqKA1vmqs8r6K7o6mAAgAADlgA=
Date:   Fri, 3 Mar 2023 11:36:46 +0000
Message-ID: <c0802fdf2fc69441afaad0fdfae593311c13ca70.camel@mediatek.com>
References: <20230303020014.23580-1-allen-kh.cheng@mediatek.com>
         <a1e5bc34-2feb-2832-73dd-25d3d64807f7@collabora.com>
In-Reply-To: <a1e5bc34-2feb-2832-73dd-25d3d64807f7@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SI2PR03MB5676:EE_
x-ms-office365-filtering-correlation-id: b5c7a4de-fa0f-485e-155d-08db1bdb9241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fH7vkNqvF36pHz8lhPqitSoJQYg2Ec3398+Zt0UAhi4w2cvaey+2lOO4Nz4frtUjsCvmyOrqJ/gwjpktZYS87UA9blQ1UqC6IcnWBkH2+EZvpw6ZLCEHw+3S70CPHxVhucjJDaTyzETq6vDnLvV91TlQDg+jdo0p7v+AHp+IcLNB+1YQh/+MXgMpm3fKIRGshJHYtIQ2xKicUxle0ZmX0+rVIp99zmYCVmJdXrJ85KjPPHMqJT0V/jABVst+AzIDSXaJS6P+hHPgM0asvGiwU4IvGr5dU6kJfZmeBmGB1gRTSd3UuFQimbgHoDTQC6salbMVJ4l6QQ2tEhT+tWMHp9gIHd4wDZ204nMrhhdLPEjuUG1nmnPL8pHVLJ6SAX+cIH52E/H318OT6MHY8cGAKc8tQYKv/q1jCivzTRK7uiddJ1AZW2p79AT4al+Fpi114pDkKC40yD5R8NLI5C2DwiAL1CkdBiiz48GXoNAZmFX3UASWF5lRrjUiUARu6HHQqVRJdp2BMdahWxqYVY2gnGMresG+bojas9L+5a/pav/tgKqqwkAvrafePJ8pjVpUOeh4bXOcyS8Sw4LZW/WSKRnLlKs1oTiPx87R79G+S7fSNd+06puefRLqB3sf82qYhfG6hVkN1KCT/NG5/5biv2MFqdAfeJexTjsmdi3aOqXUwpkitFOFz/fbRvPoREqJi1vxmYEISsys0o0zi6BGxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(451199018)(5660300002)(4326008)(64756008)(66476007)(66446008)(85182001)(8936002)(41300700001)(91956017)(36756003)(66556008)(66946007)(2906002)(76116006)(8676002)(316002)(122000001)(6486002)(38100700002)(6512007)(71200400001)(6506007)(26005)(186003)(2616005)(54906003)(86362001)(478600001)(110136005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm4wYjhWY201ampLend3YjNheWltajRjeTRWb3ZheWUyb2FNNk9QclI2OXRZ?=
 =?utf-8?B?SGpZN0kwTU5FOWh6NVpzSmdZZHFLOGFVUGlEREtoeUNkelo2SFBWMFQ4SFRn?=
 =?utf-8?B?bWJmcE1jMEd3bEtndG1nbmdJMG80Q3Erdk9UdHVJYXNMUXdRdW1kZVl0dUQ3?=
 =?utf-8?B?ZkxpdnJFamFTM0x2bkNvQisvL2ZiblBpMzlRaEtzR1hpV3FpdURVL3EyUVd2?=
 =?utf-8?B?TDNqN1hyZkVreml6RmpicjZrRXVIbCsvSi8wd2llU1dQVjJCOUt1TVBKZHpv?=
 =?utf-8?B?Q0ZucjBHUFBvTXlBSnFXbmg2QnI0T254RmU1alVSbWsrU3B2UjVkUjFkc2M0?=
 =?utf-8?B?Um1XbmFBdkdrZHNQVklXUHhqTC94MW9UdnRhUU9uY0x5SEFzUGF0eHg3TXNl?=
 =?utf-8?B?ajFtY0ZnTGdzN0puYXF1NUt1MVlQWjlCQ0c5V1RJVm1vbWczMElRNnpoRlJW?=
 =?utf-8?B?SXBBYUg4b0lKSUc2ZzVtRkNUNU5BVWNxR2tER2ZsNUd5VWJVVWJSU2JkY2t3?=
 =?utf-8?B?ejVPTGplMFlPcytENEg2Y21RazhoM1BEOXdQVGhiakQ0QWxvL3RhRkxKdDVS?=
 =?utf-8?B?TjFxK0dnYUNSWmZqVElTbkowWGdzYkltWVlPSVdrNnhuNkVQLzNOanEwbWll?=
 =?utf-8?B?cTJ6M2t2N2ZManN1dUxKYytjWFdKU2c0WXZHenljVmxhSXpiMjUzNlhGV0Vi?=
 =?utf-8?B?V21XL2E1Vnp5ZFp4aVJvUVVTblVmcUhvdkI3NXdiUE1yVU1LWUtOTmFaREhG?=
 =?utf-8?B?YnlwOE5LTDJlcmMxSHEweHNsdmlUU3FIVUlIOWVIRFl0RVY3dnJhMGF0cUtH?=
 =?utf-8?B?NnRaT2ZGd1h6bVc0K2JnejU2eDFTVkY1NGNaRE9sSENxSkhuQmpJdW1oZEZS?=
 =?utf-8?B?ZFZGOEZsNDBHR3VtM1M0R3g5cGtyYjhWcnY2TTRNMFBxRGF6RVBYeXlmTmRH?=
 =?utf-8?B?Qlhza3NEMGpkSDhyZ2hyYkQxWTdONWZOT210dUp2R1FoTG1ta2NKU0ZobXBS?=
 =?utf-8?B?VlF3bVdnaGFZYmV1ZzFJaVYwREtCSDNnNysvVUhHZGo3OGNrTUdER0VpUTZS?=
 =?utf-8?B?Q0NHd2s3NXJkem9wN1hCeGJibFkvVkxDL0YyZ2pmZ2Y2V2pjVnZBbnA0OUZQ?=
 =?utf-8?B?bkNhS0JqM00raXh5SWdVbmtoWVY1MXhrZ3dnRVF4ZjVlNXU0bnJ5MGxBeThT?=
 =?utf-8?B?azRZWk9iMTVJd2xaam9HNEV4bmg2T3IxRHBqeGwrQ1FNWVc2a21tb3N5MUdI?=
 =?utf-8?B?aXFMTiszWUxMSGdXOGlLR1FJZ3BNWmFIU3RRMzZQQ3NiVlJwNUw4MjI0cFJq?=
 =?utf-8?B?NDFXOGMySXRZb1N5UmJmMnB6Y2NaQlEzajR5TW9lREVmSVpTZVYwN3NYck9y?=
 =?utf-8?B?eVZIQnluRlBDaVdDbE5UeXNXZGJ5TDdlNjBNa0xlU3ZrSkIwVXU1eTZvMUxY?=
 =?utf-8?B?Mk1jMUtvU0I1OFZ1MDJUV0RVN0M0a1JnNTBCYUFqcCszTE50TFVSTlhqUXNp?=
 =?utf-8?B?N1U1YzlsRWllU2lweHVNRTBZU1EyaEZVK01uZzRwR0pYM1NsMmw3Tmh4V0c1?=
 =?utf-8?B?MmRhc1o0Z01YT05LMDdQc3Y5MHpwNkdDL2FHWmtIYWlPWHhiVjZ1M3kycnNm?=
 =?utf-8?B?L0dVQ0xyY0ZQWlFRN3p4TDcwYkc4c3RDZnFXVGhWeW94N1lraWpqRlFFTmxO?=
 =?utf-8?B?d2ozTytpOXBOZHBxazJYMSt6QzlFa2tIelVTeVpLQ28zcFRURjhpeXRXUnFS?=
 =?utf-8?B?SnlpYk11SU5VV0l1ekdTbnBoRE5wK2xjUFNsdk5Bd2xLV1ZaQ2M1aEV2NzZP?=
 =?utf-8?B?TXNHRzh0ZVB3bkl6ajZ0T1JPa1BxNXZac0ROdTkrMGdKTmUwNDFnR2FOTk9B?=
 =?utf-8?B?aXBjYUpLYXg4Rzg5U3JMeXVZOTdzdFNmVEZ6cWorcnIyM01pOTJETmZ2K0k3?=
 =?utf-8?B?L1F2SVR6bmdKWHkrMDVkZmQ1ajY4SHh0S1o3UkNpRXFLYmk3aHVXOFhraUtH?=
 =?utf-8?B?MlJpd3pnUGU2NFh6a2FYN1JPYUVRNFlmY1Z4ZENNUmZOYWg5d0JXNjVkMDBP?=
 =?utf-8?B?YzFHYVI1RXpBMzdkKzF6YitCS21RTWhFOWdoZFJQdkdoMlgxSitJd0d0QlFE?=
 =?utf-8?B?M0RmTGFpUDNCRnB3TElLNnpLWkk2YkZVY3I5dXdvZ1JMellPWEJOeDVBQnBV?=
 =?utf-8?Q?/VEcagJgWSavdHWJJ4CJrAs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D5E6AE419FEA64C9ECA3417571F6803@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c7a4de-fa0f-485e-155d-08db1bdb9241
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 11:36:46.8115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8LW0QKmOfcx+VGG6monK7u7bCxOGG4gblKB1zTa02S8vau1VX7cgvCQ/oiWLyKaxGmjQlg2kbMXvg9tCAKuQMGDMDeETGerxIYCVZJWBUfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBGcmksIDIwMjMtMDMtMDMgYXQgMTI6MjMgKzAxMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAwMy8wMy8yMyAwMzowMCwgQWxsZW4tS0gg
Q2hlbmcgaGEgc2NyaXR0bzoNCj4gPiBBZGQgdGhlIGNwdWZyZXEgbm9kZXMgZm9yIE1UODE5MiBT
b0MuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxsZW4tS0ggQ2hlbmcgPGFsbGVuLWtoLmNo
ZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2UgaW4gdjE6DQo+ID4gICAgICBG
aXggOiB0aGlzIHNob3VsZCBiZSA8JnBlcmZvcm1hbmNlIDA+DQo+IA0KPiBJIGRpZG4ndCBzYXkg
dGhhdCAqYWxsIG9mIHRoZW0gc2hvdWxkIGJlIDwmcGVyZm9ybWFuY2UgMD4uDQo+IA0KPiBJdCdz
IDAgZm9yIHRoZSBjb3J0ZXgtYTU1IENQVXMgYW5kIGl0J3MgMSBmb3IgdGhlIEE3NiBDUFVzLg0K
PiANCj4gUGxlYXNlIGZpeCBpdC4NCj4gDQo+IA0KDQoNCk9oLCBzb3JyeSBmb3IgbXkgbWlzdW5k
ZXJzdGFuZGluZw0KDQpJIHdpbGwgZml4IGl0IGluIG5leHQgdmVyc2lvbi4NCg0KQlJzLA0KQWxs
ZW4NCg0KPiANCj4gPiAgICAgIFtBbGxlbi1LSCBDaGVuZyA8YWxsZW4ta2guY2hlbmdAbWVkaWF0
ZWsuY29tPl0NCj4gPiAtLS0NCj4gPiAtLS0NCj4gPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTkyLmR0c2kgfCAxNCArKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDE0IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRzaQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDgxOTIuZHRzaQ0KPiA+IGluZGV4IDg3YjkxYzhmZWFmOS4uNDhhNGZjODhmZGU0
IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0
c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpDQo+
ID4gQEAgLTcwLDYgKzcwLDcgQEANCj4gPiAgIAkJCWQtY2FjaGUtbGluZS1zaXplID0gPDY0PjsN
Cj4gPiAgIAkJCWQtY2FjaGUtc2V0cyA9IDwxMjg+Ow0KPiA+ICAgCQkJbmV4dC1sZXZlbC1jYWNo
ZSA9IDwmbDJfMD47DQo+ID4gKwkJCXBlcmZvcm1hbmNlLWRvbWFpbnMgPSA8JnBlcmZvcm1hbmNl
IDA+Ow0KPiA+ICAgCQkJY2FwYWNpdHktZG1pcHMtbWh6ID0gPDUzMD47DQo+ID4gICAJCX07DQo+
ID4gICANCj4gPiBAQCAtODcsNiArODgsNyBAQA0KPiA+ICAgCQkJZC1jYWNoZS1saW5lLXNpemUg
PSA8NjQ+Ow0KPiA+ICAgCQkJZC1jYWNoZS1zZXRzID0gPDEyOD47DQo+ID4gICAJCQluZXh0LWxl
dmVsLWNhY2hlID0gPCZsMl8wPjsNCj4gPiArCQkJcGVyZm9ybWFuY2UtZG9tYWlucyA9IDwmcGVy
Zm9ybWFuY2UgMD47DQo+ID4gICAJCQljYXBhY2l0eS1kbWlwcy1taHogPSA8NTMwPjsNCj4gPiAg
IAkJfTsNCj4gPiAgIA0KPiA+IEBAIC0xMDQsNiArMTA2LDcgQEANCj4gPiAgIAkJCWQtY2FjaGUt
bGluZS1zaXplID0gPDY0PjsNCj4gPiAgIAkJCWQtY2FjaGUtc2V0cyA9IDwxMjg+Ow0KPiA+ICAg
CQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmbDJfMD47DQo+ID4gKwkJCXBlcmZvcm1hbmNlLWRvbWFp
bnMgPSA8JnBlcmZvcm1hbmNlIDA+Ow0KPiA+ICAgCQkJY2FwYWNpdHktZG1pcHMtbWh6ID0gPDUz
MD47DQo+ID4gICAJCX07DQo+ID4gICANCj4gPiBAQCAtMTIxLDYgKzEyNCw3IEBADQo+ID4gICAJ
CQlkLWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47DQo+ID4gICAJCQlkLWNhY2hlLXNldHMgPSA8MTI4
PjsNCj4gPiAgIAkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8JmwyXzA+Ow0KPiA+ICsJCQlwZXJmb3Jt
YW5jZS1kb21haW5zID0gPCZwZXJmb3JtYW5jZSAwPjsNCj4gPiAgIAkJCWNhcGFjaXR5LWRtaXBz
LW1oeiA9IDw1MzA+Ow0KPiA+ICAgCQl9Ow0KPiANCj4gSXQncyAwIHVudGlsIHRoZXJlLg0KPiAN
Cj4gPiAgIA0KPiA+IEBAIC0xMzgsNiArMTQyLDcgQEANCj4gPiAgIAkJCWQtY2FjaGUtbGluZS1z
aXplID0gPDY0PjsNCj4gPiAgIAkJCWQtY2FjaGUtc2V0cyA9IDwyNTY+Ow0KPiA+ICAgCQkJbmV4
dC1sZXZlbC1jYWNoZSA9IDwmbDJfMT47DQo+ID4gKwkJCXBlcmZvcm1hbmNlLWRvbWFpbnMgPSA8
JnBlcmZvcm1hbmNlIDA+Ow0KPiANCj4gSGVyZSwgYW5kIGxhdGVyIChmb3IgY29ydGV4LWE3Niks
IGl0J3MgPCZwZXJmb3JtYW5jZSAxPi4NCj4gDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4g
DQo=
