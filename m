Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999DE6C5C38
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCWBlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCWBlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:41:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA5C1C5BA;
        Wed, 22 Mar 2023 18:40:57 -0700 (PDT)
X-UUID: bf4d1e24c91b11eda9a90f0bb45854f4-20230323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Pb3DpgRVVCWCKHZ3Sjtrv2dPiOfPBbyYGO71lA6gOIA=;
        b=FKbf9kocDjbvwz2K6QNpA5ucQmfko7r0DtemKX3Vuuvx6rqPztwZiHuxX3BXRwUehsRR2lmhM3INCL6cdF9Fpe60BytUa3EZaOhTECPdZZPU/CCDejPCZuZjh7g+bVJmGkDp4P7TYnMEMzAe6oY0U/MUa+rDWL43cwTXf2G/eaE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:a216f119-6db2-46e2-a7f9-f38e5b4ce8d7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.22,REQID:a216f119-6db2-46e2-a7f9-f38e5b4ce8d7,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:750f3329-564d-42d9-9875-7c868ee415ec,B
        ulkID:230323094054YFV0VOVF,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: bf4d1e24c91b11eda9a90f0bb45854f4-20230323
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 448535254; Thu, 23 Mar 2023 09:40:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 23 Mar 2023 09:40:51 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 23 Mar 2023 09:40:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM/gqZRLqDu8+z/mlvdByvgM8maqB4wyCGRDVpai1GNys9p/fHvA4lcalmznSjGC3yNLXb9JLh/5IfHu3lBMWnOpGMU55vM0Aekt38bs28Qb4rvHLI29Zm/L13IVi5fby3n496CjeLf+EdDabtKQCbkSM6mjjyzqriRhdd53cGFYAxTKXPCjuaBWVpEpjMZ6gSQ/Z9o40pFwi5qi6xa3Ay044SWrmiF5mdYz81wL+QkDqkgNhfbgHIYl15I33z/6aycd/GuJDhwhX8hmdjbEXps9fmcGIhzHC4Yik2Z4GQn9V4Ui+o1a5Wz/L3+0m72tOTWPfhP8VhAYpPWoazz9SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pb3DpgRVVCWCKHZ3Sjtrv2dPiOfPBbyYGO71lA6gOIA=;
 b=eHiYzZ0iRBJO/PtXQ/yKo1XLTgPLvyCb0x9fazw5FBZCVABMlcZbO0TxJGAcL0o0mQAK9/gIJkesAvyTE7wc1ZuomJ/ZjK1TxKGZ8U94+lpucWaT0DBapCgsprDfeBaDvvNTy+E6HVcZ3PHWhGzoxfEQW+Yq+ZmwGwLkNK2E2Igrso2dJJQl27NL9qC8Ip9TJLpYUJESE0yYYnrVxq2+JTUQqhLZN5OU/jY5e0mBcjZ5S9LMrRln9tqi8KGIz1ayoOVYr8lo4BFe+Yik6svJX65XK7D8l5sgC89stO49xRmRfMv3+Rzzdj9WYyCQOWnEar2CaWoWPPstK/t495Pr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pb3DpgRVVCWCKHZ3Sjtrv2dPiOfPBbyYGO71lA6gOIA=;
 b=mFcyDvIc6tYLIiGv87Wkgo47/+FsVa8cOR1/XOo3b44vVgvwIUymroT5B7MfhJ11/VIf599t/V5fYXiJsPWa3UtyNeo6IuV5rBHOeSsIoviHXuKtUAO8SdyCsMob/b45v83Aldzh8rkVJjUr9AU9OjCe7lQJ20HLxiG/sMxCLVg=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by SI2PR03MB6054.apcprd03.prod.outlook.com (2603:1096:4:14a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 01:40:49 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2%5]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 01:40:49 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2,2/7] media: mediatek: vcodec: Add debug params to
 control different log level
Thread-Topic: [PATCH v2,2/7] media: mediatek: vcodec: Add debug params to
 control different log level
Thread-Index: AQHZXKNCs/H4iuZjnUqqojzn8JWzLa8G0PsAgADGuYA=
Date:   Thu, 23 Mar 2023 01:40:49 +0000
Message-ID: <fa719c9b76b82f9d0ca299a088b69ae90d2beb75.camel@mediatek.com>
References: <20230322094617.19410-1-yunfei.dong@mediatek.com>
         <20230322094617.19410-3-yunfei.dong@mediatek.com>
         <4da63f5b-87f3-89be-31fc-f574a1d7c9bd@collabora.com>
In-Reply-To: <4da63f5b-87f3-89be-31fc-f574a1d7c9bd@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|SI2PR03MB6054:EE_
x-ms-office365-filtering-correlation-id: adea4fbe-f754-4f43-0376-08db2b3fa158
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2uEhlixmikk5wj8brOu2C2JCtIqB0ELknupq/faM2g+icw9KjIgcvTDzDAayK3U8r5rR1vOJxSU7guN5jkYIE+dTUV9Cui/rVjq9JV2e1iks/c19eP57lbwp4RjjH7Si3/wjMMx6Eiycy6n1Wqx+2YX9DAFFhHx4lacEdycaqPmMU7qakvBhfNdoMSv83U5Qd4+FunOaUJnXgJuP3HxeBA/sBUL5BfnjA4gyEL7qPq1K9x1VldziHIlJdlyqjBw+d9mtNNbbKjtdzIrqfFhtNY58YBh3BuB641VH4O9A7C9CnzxGTaHgHGE3IHstC+JAxi0B4SoCdWgsqr7vLCvm9OibYixup4cWoVKoGxqj5+rhwZWd19CmZQnp8OQzXVhQBnDTwc0lekikw/zQuuyNdHQUN1D1DIPoO8MavKs5GoisLlwIjF/Mnna3gGVybaVvD//PrTAHVYiD2/PUnPvIJvOfLEzuSCJk94+nW+nRNs7894n+Ihd1EkzuzZcx91EGUXsI+/6IvSHi7tLtuutZjJtNmXnvNfxttbGENWNFWdgWPSL9Jx/gctrkagfD6OH/sYrX6TFSOid3E7s7ICrpU0fOzfV2bn/wjbUFMxsUdIXIsKpdH2mDUCiJV4lCzmHoNJ1aIari3x5mjNgHhpEGTyY1dNm+YYPRW3LbWiXtzsP1Rh54geEH0+sOr9Ga3NcZoUXipbLfJESTBMV8UP+hk66yaiDTaekXLYi25TJBuUTWMk8G1hgrmqlFxb9ZCTyF2eWJam2bAvB0vq0IL8KsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199018)(2616005)(83380400001)(122000001)(38100700002)(86362001)(6486002)(38070700005)(4326008)(8936002)(66446008)(64756008)(41300700001)(36756003)(85182001)(66556008)(66946007)(91956017)(66476007)(8676002)(76116006)(2906002)(71200400001)(186003)(5660300002)(26005)(6512007)(54906003)(6506007)(110136005)(478600001)(316002)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVFhM0JsMkljQ0dRa05lVnovcDhseVJhZDRIRnQwYUE0bEdib2QxSERsOEpK?=
 =?utf-8?B?TlAxZmVvaEhucHRHakgwaGN2UFBsb3I1QjZOYmYxRkdsc2tjRU1UenlPVmxr?=
 =?utf-8?B?eHFFMkY1M1pOOEhzaWpSNnhMZFNyeXh1c1djekVDZWlqSWVwMVRSelpONE9o?=
 =?utf-8?B?OVlIOEI3bUxrWXRtTnN5NElMMnhlUjN2M2F1NHRzQUxZa2p0UGdzRy83a0gw?=
 =?utf-8?B?OEtZb0djcTFlSjBheUJLNmx1K1N6THJVOE9Wa3JXeDJBb09laGNlMnZxM3V0?=
 =?utf-8?B?VVdOQUYwUnhGMFk1K1Fxd1pjNDdDRW5DY3QrRUVIUmREbkk1T0JOakdSYkJ5?=
 =?utf-8?B?Y1RmbnVGWTV0UW10RW04N293VVNuSW83c2NOK0tHWWswNXRqV3gyR1lSWWps?=
 =?utf-8?B?YnBablA1M1g4YXNtN3ludDFQbk1QdGFyY0FmYzUxRFU3aDg2cmEzQzRERDNz?=
 =?utf-8?B?d3UrbWlyOUE3VDg2MjRNb21qZXViNjZUbU83OXFJcnpNODhxZXptRWlaQXBu?=
 =?utf-8?B?TTU1cFR2blRCUTRlQ3h3d3MzYXBMcE1HZkRxcks4YWhid2taUldJV2FsbSti?=
 =?utf-8?B?VEVOeWlsZW9YbnRPeDl6ajNWNDNLZm5iU1hyTm40UFZSTWRUcmNpcjRXNkd0?=
 =?utf-8?B?WXhhWmJqSGxFTlBLcmJxL1lyVldOVXVQU0lsNVEvandndEMvYjQ5T2dxT1ZD?=
 =?utf-8?B?Y1V5RmZxWERVVEpmM2RrOW5CbEdHYUVmOXcrdzhBRVdocE9iT3AvdmtiK0tZ?=
 =?utf-8?B?SUV3SFdpaEVrM09MTTRBWGtyMXlZK0UwbGhwV1FJQ2dkWnlQRlNZR2ltQllN?=
 =?utf-8?B?dnNMVFFheDJCTTFicXBoWjRaRHNlQ3U1ZWZmTldCSFF5dEZ3MW81MWhmN2Iy?=
 =?utf-8?B?VEFoMjRSbmFiYTR0dlpIZVZiNVhVNVJoV010R1A5Vm1wSW94bDlhemZVKzYx?=
 =?utf-8?B?NTJ2K2JvYTdZQUhPZlBEUjVndFdLanNCR2lpbU1LaXpUei92OE56ZnVhb3B5?=
 =?utf-8?B?Y2hIWURrRVFydC9MUmlXWlNtWFdCMUtYQjNrTmh0bTFOMGpyU2xwL2RKSHZP?=
 =?utf-8?B?eWZTUGJxclFqaE85UHV0K1U2MWQvbWNtSnBzSUtCM3BtS1daN2tTYUhwY1pm?=
 =?utf-8?B?THNJQzZZNkk0bFdQdllWL05uVmJXRFJQT05SYTdpZkhLTmxXWmJqeWhYL3Ji?=
 =?utf-8?B?c3VLME5wOFJEdTJYRThZTlZkSHB6bHNnTkZZQ2F3NExBMWMwcUhFWFNEZHB6?=
 =?utf-8?B?eU1LYmJDWGIvUlMrZDFsTzVFb2NhU0hwenZkRlhkNVhvaGIxOFp5N1JYOGho?=
 =?utf-8?B?N2JkSERqb1cyZkVVdVY2bGRCU1N5RERNc2dMTnVFZnBDOTRETEpBWWs0SDZv?=
 =?utf-8?B?R3UvMEU0NHpYTTBidFlXWGFuS29RSlhKY3VvREszdTIrd2FhUU8xbzl2YzhW?=
 =?utf-8?B?bmhQclJMMndOUExPb0F2azZBUHBWbWdhZ1E0bHNHK0pXT2creEo1UG4ydUV6?=
 =?utf-8?B?SG81NDUzeUtqUWFoaEtJOG96dU1pZ3J1OGlKOGRGYWg3ZlE3MFA4cTYwTUlM?=
 =?utf-8?B?TThUaU5tWUJ1bGJ6TFJ3QXpzRnkxOEhRS3lydk5LOFI1U2xDclNyUzdMQ1FX?=
 =?utf-8?B?VG9kcjlud2pOc2wwZDc2RTI5R2hhaFdiVDl1bzNLZjM2Vk1yU3pIT25Tc0g2?=
 =?utf-8?B?WUkySmNJZ0pORGhqUDBHUForMVF2ZGh6alJlQm5Pdkc3YU1WM0twbWx6Skhs?=
 =?utf-8?B?UG91ZVhXZ1F0N1gvWnJCSC9SL1ZzWkE2SGxicDBtblhDSWFqQkdWY1VvRVJz?=
 =?utf-8?B?QWJUQm8vWGtnRkJnWDZieG9BQzJiZmZjZ1R0emE1MlpvYUMwU2h3WjlvL3Qy?=
 =?utf-8?B?Sm10KytSY01RMVdXdVJmWVcyRGhMdE9aYWV6Ry92VkpaS2ZYTHBxbWRNN01n?=
 =?utf-8?B?NGpSZy9QRlNtclIwVlBVMXVjdWE3cHVJYXBKSExKV29Vem5OTlNtaDVrSmZh?=
 =?utf-8?B?ZTRkaytJTUlyQTZwR3lwV1lXU0pKU3lodXJPWjRjTUhIdXQ0V1ZEZElud204?=
 =?utf-8?B?Z09pSkR5OGx6V0d1Q0FQR3hIYUFDcUNCKy9aTlVFYmtlc0dlU1BoOXBOSitJ?=
 =?utf-8?B?blh5MnJLMzUrWitGQ2tJemtCb21SdENUbGR6SkJubjFTeG1jMkJkd0hnOSt1?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70D0C9B467D59C4C91F9DF7799272C6F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adea4fbe-f754-4f43-0376-08db2b3fa158
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 01:40:49.2578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ev4sDUXD4Y4j6gD3FDpFGYQKAR3ELO4smo9Z7F9DtHQHN59e3E6Xzee4dGuZ9VLBqKmg7v6MOgm+np1xobIQPULGGMd+NzSjQqQN3MR4wcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6054
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

SGkgQW5nZWxvR2lvYWNjaGlubw0KDQpUaGFua3MgZm9yIHlvdSBzdWdnZXN0aW9uLg0KDQpPbiBX
ZWQsIDIwMjMtMDMtMjIgYXQgMTQ6NDkgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25v
IHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IElsIDIyLzAzLzIzIDEwOjQ2LCBZdW5mZWkgRG9uZyBo
YSBzY3JpdHRvOg0KPiA+IEFkZCBwYXJhbWV0ZXIgbXRrX3Zjb2RlY19kYmcgdG8gb3BlbiBlYWNo
IGNvZGVjIGxvZy4NCj4gPiBBZGQgcGFyYW1ldGVyIG10a192NGwyX2RiZ19sZXZlbCB0byBvcGVu
IGVhY2ggaW5zdGFuY2UgbG9nDQo+ID4gYWNjb3JkaW5nIHRvDQo+ID4gdGhlIHBhcmFtZXRlciB2
YWx1ZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdW5mZWkgRG9uZyA8eXVuZmVpLmRvbmdA
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgLi4uL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNv
ZGVjX2RiZ2ZzLmMgICAgICAgIHwgIDIgKysNCj4gPiAgIC4uLi9tZWRpYXRlay92Y29kZWMvbXRr
X3Zjb2RlY191dGlsLmMgICAgICAgICB8ICA4ICsrKysrKw0KPiA+ICAgLi4uL21lZGlhdGVrL3Zj
b2RlYy9tdGtfdmNvZGVjX3V0aWwuaCAgICAgICAgIHwgMjUNCj4gPiArKysrKysrKysrKysrKysr
LS0tDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9t
ZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kYmdmcy5jDQo+ID4gYi9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RiZ2ZzLmMNCj4gPiBpbmRleCBmYjll
ZGQzNzlhZjUuLmI1MDkzZTRlNGFhMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RiZ2ZzLmMNCj4gPiArKysgYi9kcml2
ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RiZ2ZzLmMNCj4g
PiBAQCAtMjAsNiArMjAsOCBAQCB2b2lkIG10a192Y29kZWNfZGJnZnNfaW5pdChzdHJ1Y3QgbXRr
X3Zjb2RlY19kZXYNCj4gPiAqdmNvZGVjX2RldikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
SVNfRVJSKHZjb2RlY19kZXYtPmRiZ2ZzLnZjb2RlY19yb290KSk7DQo+ID4gDQo+ID4gICAgICAg
dmNvZGVjX3Jvb3QgPSB2Y29kZWNfZGV2LT5kYmdmcy52Y29kZWNfcm9vdDsNCj4gPiArICAgICBk
ZWJ1Z2ZzX2NyZWF0ZV94MzIoIm10a192NGwyX2RiZ19sZXZlbCIsIDA2NDQsIHZjb2RlY19yb290
LA0KPiA+ICZtdGtfdjRsMl9kYmdfbGV2ZWwpOw0KPiA+ICsgICAgIGRlYnVnZnNfY3JlYXRlX3gz
MigibXRrX3Zjb2RlY19kYmciLCAwNjQ0LCB2Y29kZWNfcm9vdCwNCj4gPiAmbXRrX3Zjb2RlY19k
YmcpOw0KPiA+ICAgfQ0KPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwobXRrX3Zjb2RlY19kYmdmc19p
bml0KTsNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX3V0aWwuYw0KPiA+IGIvZHJpdmVycy9tZWRpYS9w
bGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY191dGlsLmMNCj4gPiBpbmRleCBhY2U3
OGM0YjViOWUuLmYyMTRlNmY2NzAwNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3Bs
YXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX3V0aWwuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfdXRpbC5jDQo+ID4g
QEAgLTEzLDYgKzEzLDE0IEBADQo+ID4gICAjaW5jbHVkZSAibXRrX3Zjb2RlY19kcnYuaCINCj4g
PiAgICNpbmNsdWRlICJtdGtfdmNvZGVjX3V0aWwuaCINCj4gPiANCj4gPiArI2lmIGRlZmluZWQo
Q09ORklHX0RFQlVHX0ZTKQ0KPiA+ICtpbnQgbXRrX3Zjb2RlY19kYmc7DQo+ID4gK0VYUE9SVF9T
WU1CT0wobXRrX3Zjb2RlY19kYmcpOw0KPiA+ICsNCj4gPiAraW50IG10a192NGwyX2RiZ19sZXZl
bDsNCj4gPiArRVhQT1JUX1NZTUJPTChtdGtfdjRsMl9kYmdfbGV2ZWwpOw0KPiA+ICsjZW5kaWYN
Cj4gPiArDQo+ID4gICB2b2lkIF9faW9tZW0gKm10a192Y29kZWNfZ2V0X3JlZ19hZGRyKHN0cnVj
dCBtdGtfdmNvZGVjX2N0eA0KPiA+ICpkYXRhLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHJlZ19pZHgpDQo+ID4gICB7DQo+ID4gZGlmZiAt
LWdpdA0KPiA+IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zj
b2RlY191dGlsLmgNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVj
L210a192Y29kZWNfdXRpbC5oDQo+ID4gaW5kZXggNzE5NTY2MjdhMGUyLi45MzhmMDNjYWIzYzkg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMv
bXRrX3Zjb2RlY191dGlsLmgNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlh
dGVrL3Zjb2RlYy9tdGtfdmNvZGVjX3V0aWwuaA0KPiA+IEBAIC0zNSwxNSArMzUsMzQgQEAgc3Ry
dWN0IG10a192Y29kZWNfZGV2Ow0KPiA+ICAgICAgIHByX2VycigiW01US19WQ09ERUNdW0VSUk9S
XVslZF06ICIgZm10ICJcbiIsICAgICAgICAgICAgXA0KPiA+ICAgICAgICAgICAgICAoKHN0cnVj
dCBtdGtfdmNvZGVjX2N0eCAqKShoKS0+Y3R4KS0+aWQsICMjYXJncykNCj4gPiANCj4gPiArI2lm
IGRlZmluZWQoQ09ORklHX0RFQlVHX0ZTKQ0KPiA+ICtleHRlcm4gaW50IG10a192NGwyX2RiZ19s
ZXZlbDsNCj4gPiArZXh0ZXJuIGludCBtdGtfdmNvZGVjX2RiZzsNCj4gPiANCj4gPiAtI2RlZmlu
ZSBtdGtfdjRsMl9kZWJ1ZyhsZXZlbCwgZm10LCBhcmdzLi4uKSBwcl9kZWJ1ZyhmbXQsICMjYXJn
cykNCj4gPiArI2RlZmluZSBtdGtfdjRsMl9kZWJ1ZyhsZXZlbCwgZm10LA0KPiA+IGFyZ3MuLi4p
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ICsgICAgIGRvDQo+ID4geyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+
ID4gKyAgICAgICAgICAgICBpZiAobXRrX3Y0bDJfZGJnX2xldmVsID49DQo+ID4gbGV2ZWwpICAg
ICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcHJfaW5m
bygiW01US19WNEwyXSBsZXZlbD0lZCAlcygpLCVkOiAiIGZtdA0KPiA+ICJcbiIsIFwNCj4gDQo+
IFRoZXNlIHNoYWxsIHN0aWxsIGJlICpkZWJ1ZyogYW5kIG5vdCAqaW5mbyosIGV2ZW4gaWYgeW91
J3JlDQo+IGNvbnRyb2xsaW5nIHRoZQ0KPiBsb2cgbGV2ZWwgZnJvbSBkZWJ1Z2ZzLCBhcyB0aGVz
ZSBhcmUgYW55d2F5IGRlYnVnZ2luZyBwcmludHMgd2hpY2gNCj4gY2FuIGJlDQo+IGF1dG9tYXRp
Y2FsbHkgb3B0aW1pemVkIG91dCBmb3IgYSBrZXJuZWwgYnVpbGQgd2l0aCAqbm8gZGVidWcgYXQN
Cj4gYWxsKi4NCj4gDQpJIGNhbiBjaGFuZ2UgaXQgZnJvbSAqaW5mbyogdG8gKmRlYnVnKi4NCj4g
VGhlIGxvZ2xldmVsIGNvbnRyb2wgaXMgYSBjb21tb2RpdHkgdGhhdCBzaG91bGQgYmUgbWVhbnQg
dG8gYXZvaWQgdG9vDQo+IG11Y2gNCj4gc3BhbSBmb3IgcmVhZGFiaWxpdHkgYW5kL29yIHNlbGVj
dGl2ZWx5IGVuYWJsZSAiY29tcG9uZW50cyIgbG9nZ2luZywNCj4gYmVjYXVzZQ0KPiB0aGVuIHRo
ZXJlJ3MgYWxzbyB0aGUgdHJhY2luZyBmcmFtZXdvcmsgcHJvdmlkaW5nIG1heGltdW0gdmVyYm9z
aXR5Lg0KPiANCkkgY2FuJ3QgdW5kZXJzdGFuZCBoZXJlIHZlcnkgd2VsbC4gV2hldGhlciB5b3Ug
bWVhbiB0aGF0IGp1c3QgbmVlZCB0bw0KcHJpbnQgdXNlZnVsIGRlYnVnIGluZm9ybWF0aW9uLCBu
byBuZWVkIHRvIGFkZCBzbyBtYW55IHByZWZpeA0KIltNVEtfVjRMMl0gbGV2ZWw9JWQgJXMoKSwi
PyANCg0KPiBCZXNpZGVzLCBJJ2QgYmUgaGFwcHkgaWYgdGhpcyBmaW5hbGx5IGJlY29tZXMgZGV2
X2RiZyBpbnN0ZWFkIG9mDQo+IHByX2RlYnVnLg0KPiANCk5lZWQgdG8gY2hhbmdlIHNvIG1hbnkg
bG9nIHRvIHVzZSBkZXZfZGJnLCBwcl9kZWJ1ZyBzaG91bGQgYmUgYWxzbyBvay4NCk1heWJlIEkg
Y2FuIGNoYW5nZSBpdCB3aXRoIGRldl9kYmcgaW4gdGhlIGZ1dHVyZS4NCj4gUmVnYXJkcywNCj4g
QW5nZWxvDQo+IA0KQmVzdCBSZWdhcmRzLA0KWXVuZmVpIERvbmcNCj4gDQo=
