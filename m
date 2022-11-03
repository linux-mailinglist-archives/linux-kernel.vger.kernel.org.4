Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C2F617432
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiKCC2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiKCC2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:28:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FED613D47;
        Wed,  2 Nov 2022 19:27:57 -0700 (PDT)
X-UUID: 6ddb3a9cb6544ad5a42d32ce71a49eae-20221103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ytLASIsPp4N9pDnQauXv9eR9yks12LJEXATVpzaW3dY=;
        b=qVXf0Z2oQPcMlrQWMv9RKeXIzBufqqioz9YmgLykAf0gmspZEj/QojRwcw2vOt+e5NC3x+Ej7yHkkFNB85bJzF17hHLVGoIbbririurjNdImHo4Xtv8IGW0IasLUEmA3jD62tRVR7VDj2QcO636BoDwMm/TcX4Gs3a/ZKXFt78M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:24ef00f2-a6d6-4b6f-97c2-60b22a57fbda,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:5d007581-3116-4fbc-b86b-83475c3df513,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6ddb3a9cb6544ad5a42d32ce71a49eae-20221103
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 957521402; Thu, 03 Nov 2022 10:27:50 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 3 Nov 2022 10:27:48 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 3 Nov 2022 10:27:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSacm9ln+oMhfqYSG7/KornBIWLUWtWh/nQDchTXMAeHIIzNVPI8cRPZKH7G/9EHeUnzwf7RnAXQMxAzS3YCkEV6kFdFrpnFzz02eFuswEYpUsZqn95jFmc8i4NKS88IJ5ykWSJkifld9sv7kymvdbhKqiHFEU5J4ZbbcrIf557u1nZPrdx3YchvbEn9QCtBlbMcrH57BodynL2bGD1bS5bVLkuYe51esUewUx/HSHYleRkZHDT01SY8GYj1jlZS00OW0Ocsw+O6TyxcgtO8Jdc8qB/8lVsjEMAcxLInNvODAefawwWBlQs+Xz1WoQEYVyRUAEIfVri+cY21kx3YMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytLASIsPp4N9pDnQauXv9eR9yks12LJEXATVpzaW3dY=;
 b=i0ru3QoNZHemvIQ7QbjgQbYidkBBLR7LeHZn7YIx5cJh0qeSA5R2JwFmUFxnnH5ziZC31X45Jya2NhCAUMoXA37MhLowMhEMOrWWRgLcKHirVdiTCDBx6QM7VsQJnTS6owNnkw4F7KMsWOduLkPsjlq8ScmUcqmMqPDEXHvAmjRclcb8C5vFWm/vQOWUMJAC3jM78chLHZXv+EmjJMS0xbmaFXTi8NQaQsAdykmq3H0QwROldkHdT6Zg7qwJgKlFM6X3Pj2OfMfgfzwsYRVHBFLOGJy9v94iMDrEA8Caf2zc7xNljj53/xo5HiLR09yp+hu1zbIEJRIc9IaMzE3+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytLASIsPp4N9pDnQauXv9eR9yks12LJEXATVpzaW3dY=;
 b=Y4sGkzJ+PnNDEL0+M5lnxmP/V0/WQ3RjmV/S19huYF44G8FKljrE3+zeTKtQI/uVq+/R97w2B8JI5+r++zh5h5wq2afXsqcpAXLyuUIhGqPhfEIlzjRcyk7lfLsBcp/4pJlUZVtbohSrwHlFR7CNjz84TUYM/CiPMY4YVWQh2bQ=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by TYZPR03MB6163.apcprd03.prod.outlook.com (2603:1096:400:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9; Thu, 3 Nov
 2022 02:27:46 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::a302:d5da:f54f:a75d]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::a302:d5da:f54f:a75d%4]) with mapi id 15.20.5791.009; Thu, 3 Nov 2022
 02:27:46 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?WUMgSHVuZyAo5rSq5aCv5L+KKQ==?= <yc.hung@mediatek.com>,
        "kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "sound-open-firmware@alsa-project.org" 
        <sound-open-firmware@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: dsp: mediatek: Add default clock
 sources for mt8186 dsp
Thread-Topic: [PATCH v1 1/2] dt-bindings: dsp: mediatek: Add default clock
 sources for mt8186 dsp
Thread-Index: AQHY7bji8bQiCaOD/EuwnZrzM5Rdka4rWzoAgAEhCoA=
Date:   Thu, 3 Nov 2022 02:27:45 +0000
Message-ID: <29345c6f3497b3470d627fc9f09bc99216971def.camel@mediatek.com>
References: <20221101061137.25731-1-tinghan.shen@mediatek.com>
         <20221101061137.25731-2-tinghan.shen@mediatek.com>
         <1f0bb630-20b0-160e-a530-05fae7572b10@collabora.com>
In-Reply-To: <1f0bb630-20b0-160e-a530-05fae7572b10@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|TYZPR03MB6163:EE_
x-ms-office365-filtering-correlation-id: 0793bfef-58b8-4141-05ab-08dabd42fe61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZi7u37VAl5iVzG7bIb7DiEFEzrLLMY5o+xjHkwO42PoYFmpgIqwrnnaohndRWREN+giHSkZyDWjkB+EFa0Og+trkEXkiBkxFv4joc2Qzid7uGxFU/6/5Wco/wDhVSR7hW68ECMrzM/iOyylluWeno7YUOMp+fgF09Sa3mEPaeRIqyBq3h2HY7jjQcYBoftN2MgQJjYVimmg4t+NTPNIwpjw+Ob5qjn1kV+rFvpQ1TOocv4ELG7JVApwITrES2F/HDziSGA1vG1mh2fPWlfFsDfEt+CfLqcj6a/u7uo3tnM5OaB0pfbGSYBtb+47EWzo3r9dUDXY0tLz9aRPyqtWuxKkIqVoeehyjrd9e5ghc4Mx01Wtrm04pM9/mVvMtHJvfXOlvqVaVRTxz/rBvwQujf6+gePuOQQUEmfx8cKq/oQY6puuRCdo9WgLw8QjgQp7gmRL/mRJjAI0D/24IpV8BKEEOhRASYVV137FgkWrll3XKYQTsYxc0JeVeI6yv4BmmlX6bSUdp4B1ygyQBkuYd1E6ZVmHpN9pKWPRj0+/bvM54hXS1giLBpdQSAAkX7RCd9qK+gSnAkL8V18Z+vXFe+CjWlExZTdev5SNiX9Mukv8ABLdGRNJIWuPDl+DKcvXCA3P+p/pCEzNXcCEp82URY/HaZwHXQsH+CKUO+dPZMC3OdaVivX5whI3aQAmgSmvEUihuS+OMscrb/poZgZqn+rcxbFPJyBRkLVU0G7dOr0vOyeQNX7WoeOQS0pc7UglZBw3gCdLzJF2WIGQYxqMa3pda2q1kW/1bhcpuWroQ6IE3CV2Nq9IWx9wbVn3rt5upwGBuShBuSBlzXIxl4hkcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(38100700002)(85182001)(36756003)(64756008)(4326008)(38070700005)(122000001)(8676002)(921005)(66476007)(66446008)(2616005)(83380400001)(66556008)(91956017)(26005)(86362001)(107886003)(478600001)(6506007)(110136005)(54906003)(186003)(71200400001)(5660300002)(316002)(6486002)(7416002)(76116006)(66946007)(2906002)(8936002)(6512007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnZjYXh6V3N2bzNTV1hOeEpaMWt2cFpiZVRFeEM1SUFBTkl2SHZyYklsdzZV?=
 =?utf-8?B?NXFoa3lCYUxOR2tBcDBINVorWGpHRHdWdlY0bHh5VDJEYXR4NDRZMDFPUTRY?=
 =?utf-8?B?c3hvUFd5MGxya0FLOU9rWGI2M25WMVdRa2w2MkF2Ym8zR05LWG5KQkhGblg4?=
 =?utf-8?B?Qy94UEthbzFoSXozcHdvQ0dHM1RpVkROUmtjR3FtQnhIeUpRaTVsQ3Jqa0Rr?=
 =?utf-8?B?WXk3MFlJSGFtSmppVTBaT1lDQmxldEtiRktCQ3N6d1N0RHF3TDBNTHdhd2VC?=
 =?utf-8?B?ajM2WWVUaDNPWnZGSCt0RFd4VUVVazVPYWhsY1IzZWFlTGg1RmdUem9hRXJ4?=
 =?utf-8?B?ZlNsWFUwS0QrUStaSkZJVlhMbXJ5UXZmclUveGwyYSt0UW90MndwRFFxK0FW?=
 =?utf-8?B?WXhTMThtSnUzZFhVV0dPYnBPaHhKU0trQ1k1VTJJMERaNXJoVDc1eHpiY01h?=
 =?utf-8?B?eHgxTWlIU3ZFMGQ2RXYzK2NiMWdGVHVXWXAyeHBGZytVTFQ5NHkxbk1xQmlW?=
 =?utf-8?B?SExOcXZzS3A0SUVKckp1RmNTL0NTUXpjR3JWcDlsd0h2Mk9RU1RFdGVwNzAz?=
 =?utf-8?B?RU0xL1p1bExhME4wMFc3SnI0RXFqdThaZDhhRFQyNzdrOFRmMklmL2NKd25R?=
 =?utf-8?B?cTBndHFwaWQ4R2xMUzA4Q2VCWElBZjhKdWNpMFNiZkpGU0U3ZVI2NnJEZGo0?=
 =?utf-8?B?OFN4NDR1K2FKT0FmR1JrMEtUcW9obWE0SnlQZlJnaXltMjdUQTFmeThKSXRW?=
 =?utf-8?B?VXU2WE1Vdjl2c3doSGlrWDdGQU1kQVVWQjdFemNPdVIzdTB1MHVLTmtpL1p0?=
 =?utf-8?B?aXF6TjF6KzEwVHBsSTBxN3FCTHNXaWtnVTladE9XWmR2Rk5Cam52a0Q0N0lk?=
 =?utf-8?B?ejZsUEtvb1gyK1BCMExHRjFpYTliWFhzLy9TKzZKcjJKcURQUnBmM0RzNFN6?=
 =?utf-8?B?clplNHJhdVVnbWwrRGVPVjU5NE1LQU5Wem9ISk9lUi9lMVVyUFlGbXJxWW1C?=
 =?utf-8?B?dUtyd0VJZjdUeW1lTXJwcExramc4YnZDZTE4ZkhlSGhkRmJKSWxLcGtWai9m?=
 =?utf-8?B?MmpVcGcwQnF6dW13WHVlYWNLRmJhZTNQNjZBWUtwUko2S0p5VDd3RDRLSWht?=
 =?utf-8?B?UkI3SEF4QTZ5NlN0aXZlWG5ZUU1oTHdaN2J4TUs4Q056ZmdFWGhvcmtLdUZj?=
 =?utf-8?B?WDlZTmtrTzU5bkpXR0V0OERzQTh6c3drY0F0ZjJQYm9QTVhSUzk3WENnUXMz?=
 =?utf-8?B?TzFKa3VEVkptcnpMeU03R0hNZk5aNW9kbnFrcisxZWdlWmRoVnVuSkVFbmo4?=
 =?utf-8?B?b2pZaVMzbjA4b2VlVWdvUFVaWlJ0WEVwSVNBK0RNN2JkSDZBL1BIS0JzT1Ja?=
 =?utf-8?B?amY4ZXVZbmJjbXIzeXd5cDJFWmhhN1lZQkhxWEh5bUZPOGhtSWRlZ2s5Rjc5?=
 =?utf-8?B?bm11Q3ZCalM0cGZQaUtCd0RCSlJ4NzlEc1RtdlRwQVhTSWNsRksrQUlUbXdx?=
 =?utf-8?B?dmNrdU8wdGxvRWhjYzBQQ09lZ2JZcHJyYVFJUHFKVk5Sd1pwNkdDM3J6a2Zl?=
 =?utf-8?B?NVdQVlZXZEFiUkdPUkhHQkVndVZpSFBHZTJBREJDV1FBbkF1anRtM1dYYVJG?=
 =?utf-8?B?TWtWQ24zMGpxRzFsaHFvK1BiMksvRTlzZDFCOVFnM0xkVzliU3hJbVBlNUZq?=
 =?utf-8?B?UnBVZ0QyZklVdWVHUDBhbEZ4aVErakZzMlZNa0dadHFCcFB4TkxYdVg0UC9n?=
 =?utf-8?B?bkx4a3pnN09SNTdSdFlJRDMzcDRWcHJsT2lOWU1zTmp2d1A4R0xlR0cyOTBl?=
 =?utf-8?B?K1V5Q0hKV3pvQW1UVFVUQmlMMUdSOVd0WloyWCt4QnpOS21IQW04QzltSGtV?=
 =?utf-8?B?WHQ4VkFLWFRGVEYrWVVUTTNBOUZUb0xGNDUzcGhQdVc4c1NxVnRkTnBZajd3?=
 =?utf-8?B?ZTh6cUxkLzYrbndMeDMrdTBsK3N2SDlodVBmdTVadEl5Yjd0NUk1b1Vib09t?=
 =?utf-8?B?RDNsdDdHbEhXYmtESmpseHRiMkd1VjBDSFI3YXAvK1dVMnpPc0JxQjQ2cTR4?=
 =?utf-8?B?WjhTcDdUOWhMZWpqSXdmYlNDRnFXUnRnODhialFMZVFIL3pIbmNUK05RcVFi?=
 =?utf-8?B?ZTdRN3huZElRd0xjTU1OQ0FneE5DVmJSREVFS0JnNnJ0RUVGTkhQSWcveWpv?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF93005714D4454D99354515357ED984@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0793bfef-58b8-4141-05ab-08dabd42fe61
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 02:27:45.9452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGex/kv5uGgixyZpZWO8NCCZESptOi+N/WS6whgsbp2H4cOoxMCvcozLi5bnaVzcogL0OAf6ditC8dfQ0GRvZq9SzoFEeZ6yNkH5+4GdfzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTExLTAyIGF0IDEwOjEzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDEvMTEvMjIgMDc6MTEsIFRpbmdoYW4gU2hlbiBoYSBzY3JpdHRv
Og0KPiA+IEFkZCB0aGUgZGVmYXVsdCBjbG9jayBzb3VyY2VzIHVzZWQgYnkgbXQ4MTg2IGRzcC4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaW5naGFuIFNoZW4gPHRpbmdoYW4uc2hlbkBtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9kc3AvbWVk
aWF0ZWssbXQ4MTg2LWRzcC55YW1sIHwgMTIgKysrKysrKysrLS0tDQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZHNwL21lZGlhdGVrLG10ODE4
Ni1kc3AueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kc3AvbWVkaWF0
ZWssbXQ4MTg2LWRzcC55YW1sDQo+ID4gaW5kZXggM2U2M2Y3OTg5MGI0Li40Y2MwNjM0Yzg3NmIg
MTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RzcC9t
ZWRpYXRlayxtdDgxODYtZHNwLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZHNwL21lZGlhdGVrLG10ODE4Ni1kc3AueWFtbA0KPiA+IEBAIC0zNSwxMSAr
MzUsMTUgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICBpdGVtczoNCj4gPiAgICAgICAgIC0gZGVz
Y3JpcHRpb246IG11eCBmb3IgYXVkaW8gZHNwIGNsb2NrDQo+ID4gICAgICAgICAtIGRlc2NyaXB0
aW9uOiBtdXggZm9yIGF1ZGlvIGRzcCBsb2NhbCBidXMNCj4gPiArICAgICAgLSBkZXNjcmlwdGlv
bjogZGVmYXVsdCBjbG9jayBzb3VyY2UgZm9yIGRzcCBsb2NhbCBidXMNCj4gPiArICAgICAgLSBk
ZXNjcmlwdGlvbjogZGVmYXVsdCBjbG9jayBzb3VyY2UgZm9yIGRzcCBjb3JlDQo+ID4gICANCj4g
PiAgICAgY2xvY2stbmFtZXM6DQo+ID4gICAgICAgaXRlbXM6DQo+ID4gICAgICAgICAtIGNvbnN0
OiBhdWRpb2RzcA0KPiA+ICAgICAgICAgLSBjb25zdDogYWRzcF9idXMNCj4gPiArICAgICAgLSBj
b25zdDogbWFpbnBsbF9kMl9kMg0KPiA+ICsgICAgICAtIGNvbnN0OiBjbGsyNm0NCj4gPiAgIA0K
PiA+ICAgICBwb3dlci1kb21haW5zOg0KPiA+ICAgICAgIG1heEl0ZW1zOiAxDQo+ID4gQEAgLTgy
LDkgKzg2LDExIEBAIGV4YW1wbGVzOg0KPiA+ICAgICAgICAgICAgICAgICA8MHgxMDY4ZjAwMCAw
eDEwMDA+Ow0KPiA+ICAgICAgICAgICByZWctbmFtZXMgPSAiY2ZnIiwgInNyYW0iLCAic2VjIiwg
ImJ1cyI7DQo+ID4gICAgICAgICAgIGNsb2NrcyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9BVURJT0RT
UD4sDQo+ID4gLSAgICAgICAgICAgICAgICAgPCZ0b3Bja2dlbiBDTEtfVE9QX0FEU1BfQlVTPjsN
Cj4gPiAtICAgICAgICBjbG9jay1uYW1lcyA9ICJhdWRpb2RzcCIsDQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAiYWRzcF9idXMiOw0KPiA+ICsgICAgICAgICAgICAgICAgIDwmdG9wY2tnZW4g
Q0xLX1RPUF9BRFNQX0JVUz4sDQo+ID4gKyAgICAgICAgICAgICAgICAgPCZ0b3Bja2dlbiBDTEtf
VE9QX01BSU5QTExfRDJfRDI+LA0KPiA+ICsgICAgICAgICAgICAgICAgIDwmY2xrMjZtPjsNCj4g
PiArICAgICAgICBjbG9jay1uYW1lcyA9ICJhdWRpb2RzcCIsICJhZHNwX2J1cyIsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAibWFpbnBsbF9kMl9kMiIsICJjbGsyNm0iOw0KPiANCj4gWW91
IGFyZSBhc3NpZ25pbmcgdGhvc2UgY2xvY2tzIGp1c3QgdG8gYmUgYWJsZSB0byBjYWxsIGNsa19z
ZXRfcGFyZW50KCkgaW4NCj4gdGhlIERTUCBtdDgxODYtY2xrIGRyaXZlci4uLiBhbmQgdGhhdCdz
IG5vdCBuZWNlc3NhcnksIG5vciBpdCBpcyB0aGUgYmVzdA0KPiB3YXkgb2YgZG9pbmcgd2hhdCB5
b3UncmUgdHJ5aW5nIHRvLg0KPiANCj4gSW4gcmVhbGl0eSwgeW91IGRvbid0IG5lZWQgdG8gYWRk
IG5ldyBjbG9ja3MgYW5kIHlvdSBkb24ndCBuZWVkIHRvIG1hbmFnZQ0KPiB0aGF0IGludG8gdGhl
IGRyaXZlciwgYXMgeW91IGNhbiBzaW1wbHkgYXNzaWduIGNsb2NrIHBhcmVudHMgaW4gZGV2aWNl
dHJlZQ0KPiAuLi4gbGlrZToNCj4gDQo+IGFzc2lnbmVkLWNsb2NrcyA9IDwmdG9wY2tnZW4gQ0xL
X1RPUF9BVURJT0RTUD4sIDwmdG9wY2tnZW4gQ0xLX1RPUF9BRFNQX0JVUz47DQo+IGFzc2lnbmVk
LWNsb2NrLXBhcmVudHMgPSA8JmNsazI2bT4sIDwmdG9wY2tnZW4gQ0xLX1RPUF9NQUlOUExMX0Qy
X0QyPjsNCj4gDQo+IHdpdGhvdXQgYW55IGNsa19zZXRfcGFyZW50KCkgY2FsbCBpbiB0aGUgZHJp
dmVyLg0KPiANCj4gV2hlbiB0aGUgZHJpdmVyIHdpbGwgY2FsbCBjbGtfcHJlcGFyZV9lbmFibGUo
KSBmb3IgdG9wX2F1ZGlvZHNwIGFuZC9vciBmb3INCj4gdG9wX2Fkc3BfYnVzLCB0aGUgYXNzaWdu
ZWQgcGFyZW50cycgcmVmY291bnQgd2lsbCBhbHNvIGJlIGluY3JlYXNlZCAoYW5kDQo+IGlmIHRo
ZSBwYXJlbnQgY2xvY2sgaXMgbm90IGVuYWJsZWQsIHRoZSBjbGsgZnJhbWV3b3JrIHdpbGwgZW5h
YmxlIGl0KS4NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCkhpIEFuZ2VsbywNCg0KVGhh
bmsgeW91IHZlcnkgbXVjaCENCg0KSSB3aWxsIGFiYW5kb24gdGhpcyBzZXJpZXMuDQpUaGFuayB5
b3UhDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpUaW5nSGFuDQo=
