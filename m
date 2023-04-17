Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEAD6E472F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjDQMKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDQMKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:10:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52CD7D8A;
        Mon, 17 Apr 2023 05:10:01 -0700 (PDT)
X-UUID: b73b88a4dd1811eda9a90f0bb45854f4-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CQqJgFd5u5OZrgPQG1mJrNilImvx7gkj1SaDpkbVS/E=;
        b=Ez2/fRJuSca/D5DLHxHLuspJ3LxHI93R4pLokLBeskuGSPnrJK/y5A7E8D8IwLJ1PI3KPwQb1u1y/fe+lrBhid8aCUAildS77dJRAF0pe3Tj7kvz4AsUs1SWDviBqyTCa26gcUJteuvi6zV+mD0/9J51Oo8Vjo/UeIf6nseDES4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:2116e411-03a3-40c5-b7c3-aee61960f619,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:3c499aa1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b73b88a4dd1811eda9a90f0bb45854f4-20230417
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 176548288; Mon, 17 Apr 2023 20:09:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 20:09:32 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 20:09:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URB3ZrAPCNjVLBCV1ZFvusy/cWgimXtQeDIdkd6QruTbeauElzsCc0hAbPnCFIbauQu/tX/tG4I0Bj8fNln/ctt117oUD6MwfA1zJ4aAyIFwtdlqSPgxwEcQ1jpJcRrA/ADUUcq5l+U2tl5CPdiYlLR7NNhAzc4gNALr+VaP4yWm2MHcDilCtdFCwi8m/fhqwr9z3kO63pNZm6/wHqwwWLuFz858tDIOZ1RI541r7kEyHmBkh9a43t51O04C60LsXyvP/hxenzH4praKS7SiVroJ7jJi5sM/gxQ0Gq94mcpnLu5FZpO1b+fNxxahDWd7ltgQRa4Y4FFUB9zKgAvXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQqJgFd5u5OZrgPQG1mJrNilImvx7gkj1SaDpkbVS/E=;
 b=CJrkvK8kuV0l2E5HTYrXxqptCPWGoh77m0JP/yiAT7RyVamcranMXTXBCwBd0xgnTrQYhgdCTxl61NecyE98cD6CsLZ4mHs6Ci91FxViMPMYiFjJLN51OPKmFj9h8dk3NXBsm47YcyeU//PeH9GoNfNTAoKz5zxWiHBm+Jmd+9FgIo5bfrs6uyKRwF/+q6tZgFbvF0wQlpg9DQc+5ZzRVAOfXYdJnmEke0bdUbPUcFvD0AJK5DhY9PvHCEaP/JX1XX5WErNkh0XfrElYA3qal2ejRoLl5yWTyZvagGNYb+WJrX1pw4ONFoyIH0psmkfmXtm5+WLCnjjSNCToGpADMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQqJgFd5u5OZrgPQG1mJrNilImvx7gkj1SaDpkbVS/E=;
 b=U4OlA17Byrc9L2ONKmkS6dhM8HMO7J+lxhdPaqLQSt+v+w/UD0Mn893/dCCqQtdomKZPlf8ZGPz5741TrFUtSmFuoGtw0lWtIpWvzsss4rCjSjYOGDsPWV2YG0XID3PjFuem8TM37VX/fNc9HlmRg5VSB/1qIdnf/+HorejOhZo=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYUPR03MB7231.apcprd03.prod.outlook.com (2603:1096:400:357::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 12:09:29 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::30b:621:6d75:8337]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::30b:621:6d75:8337%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 12:09:28 +0000
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
Subject: Re: [PATCH 1/6] media: mediatek: vcodec: can`t regard getting lat
 buffer fail as error
Thread-Topic: [PATCH 1/6] media: mediatek: vcodec: can`t regard getting lat
 buffer fail as error
Thread-Index: AQHZcPBKKppLn8xgnUeRrMPUJTRBjq8vOTOAgAAv1YA=
Date:   Mon, 17 Apr 2023 12:09:28 +0000
Message-ID: <5491caa1ee132672fcbd7c284451739172fdc698.camel@mediatek.com>
References: <20230417054816.17097-1-yunfei.dong@mediatek.com>
         <20230417054816.17097-2-yunfei.dong@mediatek.com>
         <37b56f69-99c2-adf0-cc9f-572fbdaa2eee@collabora.com>
In-Reply-To: <37b56f69-99c2-adf0-cc9f-572fbdaa2eee@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYUPR03MB7231:EE_
x-ms-office365-filtering-correlation-id: af1a8923-b861-4c27-8889-08db3f3c97e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 03G4rAGDOVcqc/rANHjOdwKEZ5IbWlUxDZyw7JH51MgFwp32Cgpsvugp26yFXXIYlcE9CIs02S5KXIq6EX0pdZypISh/cQotIWM7bpYSpctVbGdoLNJi/d6acGOMBNKiIEujsKsZXJNIC9Q4aJYypp6F1U7kGyNUo+jHHvRQ4hC4SUIbq1GHp0O1jSr7L7SS84ZNq4DYfokTHcaSPvzrLVFIRnARHaz8khJK8bHZntJa8GpsSzxQW4v4Zp+hTpcVkmVQixw2HyCzGIcS6v5vay6AxH9/pZKLHS6BCwr8WhyHRa4WT0/pbJbm6vQmQY+56rMxRypJK6N+jqsjfCEwGRAGPEYiCEo3xgos48hWWmtzkG20ZWwUWMiqUmyUhwTQlUqL1jOCqIdADcDkl2a9AcyaLZVfI2lr9wti0LmWOHnQuomI1aOFwuaPb80ka+TkxxCzML9m2NP/o5DVV4B4p56DKJ/58sKYNMP/VOa7n2SX5GXJ+8ocZek5kx5gi6+cSNadFc1quhvDzt/SvWQR0ZuCsXiKUHaEurSIoxdhePcTbNjix6y1bnzkgK408BcntvZo3wmLIQ7heeu+II0Ao//+CWcA3XRa2fyk3qE7dUAeWUg5TRzBCuiDafbWS9muLIRWHm9HLKFgR5Rb0la/IremXV1QR71qBDg+zgJwsLU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(478600001)(2616005)(186003)(26005)(38070700005)(110136005)(83380400001)(6486002)(6506007)(6512007)(316002)(71200400001)(54906003)(64756008)(66476007)(66946007)(66446008)(66556008)(4326008)(91956017)(76116006)(122000001)(38100700002)(8936002)(8676002)(5660300002)(7416002)(2906002)(41300700001)(86362001)(85182001)(36756003)(99106002)(81973001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MElRVTluVUNOaUF6RHY1Ym1hVkxNSWY5dkUzM3dDbFpmTDZWekFrMnZIcWFP?=
 =?utf-8?B?RldEZmFFRnFRa1FobXF4ME1zazR2ZEU5bmlDZlZ2eUpLbmNLL3VqV0JVWVo3?=
 =?utf-8?B?OGxoN1JXQVZ4Z2pabkx5YThOSUtqWkp5VjVTL2pPTlRyUjdUNGRIaklYSWl5?=
 =?utf-8?B?UjJtZWtkNExmUWNNbjl6Y0RPZDE0LzVjeFVZUVdhK1Y5RWdpb2R2VG5SSUJZ?=
 =?utf-8?B?eFljdU9tMm1kNURYT1ljcEdXa3BBK3VlbzFxeVNLRjFVOVROa05hL0lubGQ5?=
 =?utf-8?B?U0l6cll4alNUTHpEek9BclhSRzc5c3hOTTJWV3k5S25qV3NIOEFrQzd5WklF?=
 =?utf-8?B?bUF3V3R2TUs0MGtEM21IalE3WTZnZnloaFhHYmVqR0NhbDZQc20xNHUzQ2dh?=
 =?utf-8?B?cVpmOHNIelcyQUJtdkZjMHRCMG8wTDB4eTFyU20xZzF6bWR6STZVQ1VKc3ps?=
 =?utf-8?B?Rmd0ZVRJZy9wSlhCTEl0TWEvY2lSTk9DQ3ZGcDNWblBVelFRc2JKNHFkQ2pj?=
 =?utf-8?B?MmRuRTg3aGM2RmNzWWdFc01ZeGpzSFdOV1M1VStYN1QwTU8zVGN5Nzg2WU1V?=
 =?utf-8?B?OVNDV0c3TFJld21QMlR6RFNEeE9KNTE4cjI1N3poNk10bG5JbEl6Vmx3U3Fh?=
 =?utf-8?B?UHpiUmxLdlF4TUdjSjcyM2VQZmprOUtIUEFydHh4MlJEM0NFbXZBSW1taE05?=
 =?utf-8?B?NWl1SVN2NjFvRmxUYUZacnZsU01FQUMxNUxuS25JNVBPekdwNDB3QUdUR2lu?=
 =?utf-8?B?TzA1QW5jUnVicTBjNnVDdkgreVRNbEdoT2hneDQ0ZnlMU1R6MzArVktnUlJk?=
 =?utf-8?B?VDZ0RVhUZ2M2cUcvbStpYnc4YXRtQ2FSUUlnd3RrS2V3Qk10M2l6ZFhDUWtt?=
 =?utf-8?B?eFU0eFV6UnpaKzduTnEyMDNveGNPOWFaRWlzVk9pUGlabmwyTVEyL3puMkta?=
 =?utf-8?B?U3psbnh2Y2JFYVl4UXQ4Vk5HZm4rQXIzUmFtNk0wYWxFQmltMjh2Z3I5eWJw?=
 =?utf-8?B?d2NhU2ljR0toT0V5bE5uQTFIeWFSTjhQSGpqNlk1M0xjemFsbWhDTDNVUTZq?=
 =?utf-8?B?bFExNGU4OUc0VkFxTE1NN2RUc0JqVm14VFBJYXd5V1orT0hiYmNzeDlhdGhO?=
 =?utf-8?B?Y2hBNzE5NC9sSXFRNERwL25TcFpNRzcrV2ZjNW5PcVFxaDMrbkl3aUVKc1Rx?=
 =?utf-8?B?cWdvOG1sUnRsNmVmbllDVkRXbldkVHpSNVRzUXVGMTUwbjZ6eU9CS1pWVU9H?=
 =?utf-8?B?ZGNhaS9VREl2bUIzTWlFQnVvY09yVUFSWHRXRUR6cTZRUmdSbW1CODVGWFNC?=
 =?utf-8?B?cElNaVA3blhkbFEweWlGZ3NpeWcvUDNLZ0xqTW5mY2UrOGJQbTJzbjZjZFBQ?=
 =?utf-8?B?aGNHS0FsQTNpVlVVR29DcnBRVW9FRWs5K05DWnNLZE1xb0IwRjJGeEcvNDdE?=
 =?utf-8?B?V1BOWDJ6ampJMnIvTTVoR1IyMmJ2T21UTmd6czdCZFhoeTlxYjFNdTdpbjgx?=
 =?utf-8?B?TDgyd0FGeTBtNDdEdDluUlVkanZGMTVLS0Rnb0hUWS9zcHpqRmxLVTBhMGZT?=
 =?utf-8?B?a1BwaExMOTc3ODFuOEtoTXBNTkliVTNmU0ZPZG1DN21mZ0RDbVhaWnVDNEFI?=
 =?utf-8?B?b29VeHByYWx4UXhwRUNsUElzZmEwYXFOek5RbEZPTTlVTGlZNnY1TXcrNXh6?=
 =?utf-8?B?WCtPTXZXTmMxMzkydzdIZXlNYWVtcjI1Y2w2cGJwdEYyVlVINzErSjRMT0F0?=
 =?utf-8?B?d1pCM0FnQml6U1hkalZkYTUvS2I2MkZyNGxlNXk3ZE5uREU5YjQ5dWpiZmdJ?=
 =?utf-8?B?cnRZcGlwQWkxdmxaYlZOVEZhTktpSWJPbFg2eFhRYWZSSVBsUFg5MkFtUnZs?=
 =?utf-8?B?VmtrelNZRzBVL0JubzN5VzRUTnE5N21rNzl3RXRHQTI3a3RBLzZzN05Wdk5x?=
 =?utf-8?B?SUJEZkV6VVFTeUxGNlQzQWlJbTRqcUxZb0N6cG9qZlZzY29sZHBGcGNzbXlF?=
 =?utf-8?B?N3l1SlRuKzNBaTB0Y0tmbllBVTFjbktPMzFaTXZCTE96OGR3aHBFTE5BdFNM?=
 =?utf-8?B?NGxXSTdnZTlvSjRkT1plSXBxWGRuMGZOMlhNcElOSUtLaC9rSHNpTlc1N0Q1?=
 =?utf-8?B?R3U4V1ZIK2dDL0swUmNaazV4T0dEdHZVSS8wVmRKM2lpaFM0VkV1a0hPR2pj?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2C0E0202EDCB344B56ECE211BD53114@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1a8923-b861-4c27-8889-08db3f3c97e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 12:09:28.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+UHz76QJXsU+1wgACbpXP3VMXGLQnSDYIbFOUcu/tbYesjk4leLaR9QphQm+crnwEU3Fw9MCyjoSYrwJ0Ph1XJ6LEMGvihr0GaEtc+walM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7231
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpPbiBN
b24sIDIwMjMtMDQtMTcgYXQgMTE6MTggKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25v
IHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IElsIDE3LzA0LzIzIDA3OjQ4LCBZdW5mZWkgRG9uZyBo
YSBzY3JpdHRvOg0KPiA+IFRoZSBzcGVlZCBvZiBsYXQgZGVjb2RlciBpcyBtdWNoIGZhc3RlciB0
aGFuIGNvcmUsIG5lZWQgdG8gZ2V0DQo+ID4gdHJhbnMNCj4gPiBidWZmZXIgYWdhaW4gd2hlbiBs
YXQgZmFpbCB0byBnZXQgdHJhbnMgYnVmZmVyLg0KPiA+IA0KPiANCj4gVGhlIGNvbW1pdCBkZXNj
cmlwdGlvbiBpcyBtaXNsZWFkaW5nLCBsb29rcyBsaWtlIHlvdSdyZSBkb2luZw0KPiBmdW5jdGlv
bmFsDQo+IGNoYW5nZXMsIGJ1dCB5b3UncmUganVzdCBjaGFuZ2luZyBsb2dsZXZlbHMuLi4gYW5k
IHRoZSB0aXRsZSBpcyBhbHNvDQo+IGENCj4gbGl0dGxlIGNvbmZ1c2luZywgc28uLiBJIHdvdWxk
IHByb3Bvc2U6DQo+IA0KPiBtZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzogQXZvaWQgdW5uZWVkZWQg
ZXJyb3IgbG9nZ2luZw0KPiANCj4gU2luY2UgdGhlIExBVCBkZWNvZGVyIHdvcmtzIGZhc3RlciB0
aGFuIGl0cyBDT1JFLCBnZXR0aW5nIHRoZSB0cmFucw0KPiBidWZmZXIgbWF5DQo+IGJlIGRvbmUg
b25seSBhZnRlciBDT1JFIGZpbmlzaGVzIHByb2Nlc3Npbmc6IGF2b2lkIHByaW50aW5nIGFuIGVy
cm9yDQo+IGlmIHRoZQ0KPiBkZWNvZGUgZnVuY3Rpb24gcmV0dXJucyAtRUFHQUlOLCBhcyB0aGlz
IG1lYW5zIHRoYXQgdGhlIGJ1ZmZlciBmcm9tDQo+IENPUkUgaXMgbm90DQo+IHlldCBhdmFpbGFi
bGUsIGJ1dCB3aWxsIGJlIGF0IGEgbGF0ZXIgdGltZS4NCj4gDQo+IEFsc28gY2hhbmdlIHRoZSBs
b2cgbGV2ZWwgZm9yIGNhbGxzIHRvIHZkZWNfbXNnX3F1ZXVlX2RxYnVmKCkgaW4gSDI2NA0KPiBh
bmQgVlA5DQo+IExBVCBkZWNvZGVyIGRyaXZlcnMgdG8gYXZvaWQgZXhjZXNzaXZlIGxvZ2dpbmcu
DQo+IA0KDQpGaXhlZCBpbiBwYXRjaCB2Mi4NCg0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0KPiANCkJl
c3QgUmVnYXJkcywNCll1bmZlaSBEb25nDQo+IA0KPiANCg==
