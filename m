Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1C86E07B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjDMH1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDMH1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:27:47 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2869E8A4B;
        Thu, 13 Apr 2023 00:27:40 -0700 (PDT)
X-UUID: a9dbd82ad9cc11edb6b9f13eb10bd0fe-20230413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nKLsh3itvQJJYZKgomY2ucOS30zZGZinK1cK8/j/z/M=;
        b=uAGmgqScsdMpx5wxUYH7p3Dm8bVYro2ydvC2c1Ol2EPPtV10QcKvDwA7uJ19LYZrJuGaA/sT3UEHB2d46kL0/eWLL5+VcEsaSltftn3gXzV8OHfex2hvU7NWT2CUgjkZA5m3SYS2+HTcNqq8QKB1H3/QZhI555ENhf7VrIyXO9s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:ddeec4d3-0a88-4ced-b577-048ae72197f7,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.22,REQID:ddeec4d3-0a88-4ced-b577-048ae72197f7,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:120426c,CLOUDID:251f31a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:2304131527388F4ACEWR,BulkQuantity:0,Recheck:0,SF:19|38|17|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: a9dbd82ad9cc11edb6b9f13eb10bd0fe-20230413
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 510626785; Thu, 13 Apr 2023 15:27:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Apr 2023 15:27:35 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 13 Apr 2023 15:27:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWrsKDWu9YI0eT/q6l/KgpMBt8WXCXDoPtoHMULYhGfj2PL4QYk2C/LnDlIrgoyNrU61n4kMzWAIol37dNA77ER/TiqaPpv4HmsMJK1h9uKe/NAOi76Qp5665voQp+0EoQsUgcobiDf7Z9bryDCrk4Ivj2Je09jSpDFDyxz0FjEQl3GD5QI2ibOrUWEBK+6TfJvw0/aCE0/QrBsuUny99I3etpAnyAs3xKrh9USyl/Uv+AfHGT22pEON6lBauKWZ9MybD+Yree68+nG+3e2HlKPUczu1jmkPeJ404YhjtCpXLtuObqo01edW2D9xmsBno+z/M3cie8VkSY9Hfc66DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKLsh3itvQJJYZKgomY2ucOS30zZGZinK1cK8/j/z/M=;
 b=YkX3yGdPJ+P/l35fflwvjGGNEBhBSVdl2MbvTgoiB02TYvA50Zt64ugBqopRb1GLq91V+DJKFCyVt3nP/70ObS6AC+xOE9evhsOXnAEE9SmBehp7+V7CJdYXCrg8VFgdebE1KOOywBNno+K+smt1smlL8oAsY7VFpyTGkFOHELPauedeQpauPdCQtONlqmLUc6A2iSnY+plmCoYxqzB6iQW2dys6r/jLmoj3auAhit49qujsY4VasW2gXeh3OgzSo0b8JEjAH4B9v0ONKEyD0pzV+2Su8BwVvXTeTOqUIgz3svz/i7cA5djQ3R5scsckfdmSWIAHPgvDi6cA4cbAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKLsh3itvQJJYZKgomY2ucOS30zZGZinK1cK8/j/z/M=;
 b=mM5vDcWKz5v/Dyo70Wyhs07+iRrEgKn6Hr6YJeC3HTeVG+s4xq+M4/pe2qJLMYc8P6U5arM1qzSlZDYTX5FO2YjQ9i2vHHFGhqMsLFk/XOqag061E6H7maZ6ThK4abpTyTAFcrf/wryAmmMd4Vji0oCHIZYfZIbF0YGo22HWkDI=
Received: from SG2PR03MB6540.apcprd03.prod.outlook.com (2603:1096:4:1d4::13)
 by TYZPR03MB7026.apcprd03.prod.outlook.com (2603:1096:400:338::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 07:27:33 +0000
Received: from SG2PR03MB6540.apcprd03.prod.outlook.com
 ([fe80::577:6f28:8d2a:8a6]) by SG2PR03MB6540.apcprd03.prod.outlook.com
 ([fe80::577:6f28:8d2a:8a6%3]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 07:27:32 +0000
From:   =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
To:     =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        =?utf-8?B?WGlubGVpIExlZSAo5p2O5piV56OKKQ==?= 
        <Xinlei.Lee@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 3/3] drm/mediatek: dsi: Add dsi cmdq_ctl to send panel
 initial code
Thread-Topic: [PATCH 3/3] drm/mediatek: dsi: Add dsi cmdq_ctl to send panel
 initial code
Thread-Index: AQHZbc6e49JkgJ6UyU6qxALOY2cgpa8o1zQA
Date:   Thu, 13 Apr 2023 07:27:32 +0000
Message-ID: <ef7019930edfbdea53042437818a401f5f50ecd6.camel@mediatek.com>
References: <1681366162-4949-1-git-send-email-xinlei.lee@mediatek.com>
         <1681366162-4949-4-git-send-email-xinlei.lee@mediatek.com>
In-Reply-To: <1681366162-4949-4-git-send-email-xinlei.lee@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6540:EE_|TYZPR03MB7026:EE_
x-ms-office365-filtering-correlation-id: bd89bff2-0128-477d-a617-08db3bf08be3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u6yMH66kr+Gzmpw7Q4emUir+sINAJXBdTCzzHwdzlwVaw7TU4UluVvXsSmePjdVqB+8BrJOIXSil9Y4SJlTocbLmYw/e4bAIAkFIhhI9pymy0Fu8/sumOzpgkvw2kMEQ5z4zOKYOD0iqY/A4A5HEW0fc7Y3EVf/uOkj174Vtc8rfLNSsLTNt3Im6CDd4ZhM+EIR6sPbGw1TCOkOqMBNekBh7o8TmzGmmZGmaWUH+7mLnxPg7Mv5yM3Dx1kIdFn7Fo6g8bVVhMjv90lYSARoLTgK23RAcn0YGPd6pQwQFWh6eI5kI4Wpmw/rKP26OpFzJm5DBRLeV2K+9n3SrhF4swz28Co7WAVtU00hUHVSuqVChs0t00FhiJMYHqOm0ul6SGno7G0NY8uPGO+rOza/6+DwkLUJn7Dnhk0UIcYexhW1IdZ6b70GxYy0yyxrNI3QeWcgcIOksmdONIrQ9jbY7Sutbx/c5GchJLvlILjM/NRhJpTCwOimQbGGb03U2gER8VklWZH6h7XWz6b4WBXbZSw6xmp/Jj7heumA6iQ/Q0cMz6poF4CL+qcd+rbh9dbatKzTrARsPewV7GwfBwiahiw3XusyKpGYTg5xWb0glfejf01zLfsc63yyEOJfgsVKQR/rEmycgEl/SjzKcpvruJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6540.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199021)(478600001)(107886003)(54906003)(921005)(6486002)(8676002)(8936002)(71200400001)(86362001)(26005)(6506007)(6512007)(122000001)(38100700002)(316002)(110136005)(36756003)(91956017)(76116006)(66946007)(186003)(41300700001)(66556008)(2616005)(4326008)(66476007)(64756008)(66446008)(85182001)(38070700005)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzN3bE00ei9DaUdpczltN0d4ZGMyTk05ZGJIOThGTzMrdFovOGlhbDlNdm50?=
 =?utf-8?B?eWVzOG05T0U3UXV1dWs2Slo2UTFEMHNQS2FsNzJDTmhEczBCd0h3Rkt0UjZz?=
 =?utf-8?B?UlVhM3Q2MXA3SVJDSFhib0Q3U2hCRmF0VHp0d1l1UW9iTlVBSTdrbFI2NjhI?=
 =?utf-8?B?NUpGL21lNGREeWNhL0VCeWt2S1pBMWhFQlJIM0RYZjV0cHBUUWY4RCtXZGJO?=
 =?utf-8?B?bUVUVThndzBjU3FHMit6d3hTamhlZzc1RStKM2lyNkExUkZ3Z29FTzZsMWxC?=
 =?utf-8?B?NnhlVDR2REdTa3JUSyt5NzQ2UUUrOTl3am9UZEJuaEJMVTVoVkNjMHhBdk94?=
 =?utf-8?B?Z1BBRWljWTd3bk1PZmJRL3VuUWkycWRhL2V6ckdDb3dqUkpCWGszb2J0VmFJ?=
 =?utf-8?B?VnJXVmJzRGxlaW9paDRla3ZvbVc4Z3pleTloeXloSGQ5QjFHVkJJMXdvWGpi?=
 =?utf-8?B?bURoVlRYaDluWFpmMWJJR1VpUzM1blFxRllCQjAzSkt2ZHVrWklGSXdIei8x?=
 =?utf-8?B?NDVSSzhyU3lPei9uWk10Tjk0bE9VUVRVZVJSZDIrNTZmczIwMDdtN2V1WTlI?=
 =?utf-8?B?WHExOHYzOEROVDRDamxldGhmYWpjZTZtRnNYSkR5VkRQOVhmWW1DcjRXYU1Z?=
 =?utf-8?B?L0x6ampLVHlia05kMGVSa0FQeC9DK0dFdDIyVjdnUWN0djU1dlg3d2FjU0hO?=
 =?utf-8?B?d3hzVDlEVlNRT0JUWldYeG1YMkZOemkrS0lLck5BamNndXJCMCs3R2N5Sjhw?=
 =?utf-8?B?aWdJVldUM05LQzhkRmUrRWJTVVZzczB3TG1RdThUTTlSN3QzWTJBWjFpOHFD?=
 =?utf-8?B?eU1mTVc5SFRTOGNWY3lBUTdhNVY3dkx4MFB4SWFNNDIyODl6cTV2QVpSUzBy?=
 =?utf-8?B?eXpnRFNXVys0NHpaeW5pQzFHQWxObmZIM1M2M1dVN0Ivd1R2S2FTY0FiYVlX?=
 =?utf-8?B?WGFhcWZoWGRaZWdHOTQ1M2FWZWZscndpNDZpdlRWUHg0VXUxaTh3U0wxd0wy?=
 =?utf-8?B?Z1pZdDduVWp5S05aZDBxT0dPUGJTdGhzRTRaYjdUU29KWUtkdG9EM2RSQk9Z?=
 =?utf-8?B?SnBRSkpKTUZ1eGt6ajJtL0VEY3dHcHVZQWRsaElGcXJGSWZZRVp0QmVlUkdT?=
 =?utf-8?B?OE1PNlNaM0Q1RnBYT1ZIc0xHLzRWalZlbEFLd0NHRDVoRjF4NnB4cmR2VXI3?=
 =?utf-8?B?QzJsbWFYSllRTUF4ZjNIYWtEd3UvSHNqSTQ5eXZMKy9nQVRvR0NlMnBUU1py?=
 =?utf-8?B?bHRBZ3FQd0RiREk3MWo3QUxESEpiVHJXSWZIeEZacVRkeGNWL2UzeGFmbjBm?=
 =?utf-8?B?a2NhNllCZjlTWlZ2K0ZhMFVRY2cyNkhRSWhwRi9XK2FkSjRNWjRORVUvUUxX?=
 =?utf-8?B?K21yWE0wTEJieHRaUkd6NnU1WmJEUlZlTUUvSzZ5a05XNHpidG83VitwUitT?=
 =?utf-8?B?NlNrT1ZYQjBCRUI1RmUybG9pODdOSG9EaVAxMVQ4SHlLdGhGMTBoZVAwTDgx?=
 =?utf-8?B?aUhkRjhzd3B6UTZ2RlQrTmNOaTdXY09FQk9XUk5mTXdKSFgxdmN6ZUpid3RV?=
 =?utf-8?B?VzNmbHpGajlXemYxVWovdnRnTFdFL1VUUXBSOXBjejJJaURERkt1UmNxeU92?=
 =?utf-8?B?Ym0xRFVMcE1tT2ZLOWdSS2l3VlV0N1NseDZiaWt2OTN5enZwREpPNDhmTnJL?=
 =?utf-8?B?N1lTNHl1WHBnUEFzdUVIQURrY1FlVitxU1BpQUM0OUVZdlBDRDY0WE9FK2VC?=
 =?utf-8?B?aFVJbTNiWURZK1BRaTQ0dU1xZDZ4azFnOWozTG5OOHN6L2l6dGpEOVdOdVEy?=
 =?utf-8?B?N2VLU1hmUWRacmJOZXR6RmFoYUJReERuWUlKM25RbkxYZVlhU3VPQzA5Rldv?=
 =?utf-8?B?ek1vdkhIUkNTdXE2YU1RcHVpalV6cW5uTHdENkhCNytBSjdGUWk0aTJpeGVC?=
 =?utf-8?B?Wk0xR1gxaFZUWVdtSGY4bmhyaWFYUFZLQ01ROGgwRlFjUjVpZXdhaUxKdkJW?=
 =?utf-8?B?alhUQWdma1hodG03TmpGekpXVVFhVkEzcG1GQjJoTG9DZUFycGNENjlGWXlk?=
 =?utf-8?B?Y2FmNjdmWW94Y1FBZ29yQkx5WkppTHpBT0RKdVp6eDRJZWZ2dGc3QkkzM21i?=
 =?utf-8?B?aGdVQWpzRTEwOTNiUEdGTUJseTcvY005cS9lUitWQndQbEx6SDFkUzNyNkU4?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59722B853D98BB4EB732BCD0DEA04ED5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6540.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd89bff2-0128-477d-a617-08db3bf08be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 07:27:32.7925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFaZr7pgz+XxFsjWw7ikgk4bdCXZ1GigLiWWjhpimDw9FHQoEAZRpzogKd5iprp60VVSi8rhyoaDPya/ID2PFu06fXGB3p5IOGxb6rN6eOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7026
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gWGlubGVpLA0KDQpJTU8sIFsyLzNdIGlzIHdlaXJkIGJlY2F1c2UgdGhlIGRyaXZlcl9k
YXRhIGZvciBtdDgxODYgYW5kIG10ODE4OCBhcmUNCnRoZSBzYW1lIGluIFsyLzNdLiBTbyBJIHRo
aW5rIFsyLzNdIGNvdWxkZSBiZSBzcXVhc2hlZCBpbnRvIHRoaXMgcGF0Y2guDQoNCkJScywNCkJv
LUNoZW4NCg0KT24gVGh1LCAyMDIzLTA0LTEzIGF0IDE0OjA5ICswODAwLCB4aW5sZWkubGVlQG1l
ZGlhdGVrLmNvbSB3cm90ZToNCj4gRnJvbTogWGlubGVpIExlZSA8eGlubGVpLmxlZUBtZWRpYXRl
ay5jb20+DQo+IA0KPiBGb3IgbXQ4MTg4LCBhZGQgZHNpIGNtZHEgcmVnIGNvbnRyb2wgdG8gc2Vu
ZCBsb25nIHBhY2tldHMgdG8gcGFuZWwNCj4gaW5pdGlhbGl6YXRpb24uDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBYaW5sZWkgTGVlIDx4aW5sZWkubGVlQG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgfCAxMiArKysrKysrKysrKysNCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHNpLmMNCj4gaW5kZXggNTAwYTMwNTQyODJkLi5jYmZlNWRmNDY0N2MgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiBAQCAtODYsNiArODYsNyBAQA0KPiAgDQo+ICAj
ZGVmaW5lIERTSV9DTURRX1NJWkUJCTB4NjANCj4gICNkZWZpbmUgQ01EUV9TSVpFCQkJMHgzZg0K
PiArI2RlZmluZSBDTURRX1NJWkVfU0VMCQkJQklUKDE1KQ0KPiAgDQo+ICAjZGVmaW5lIERTSV9I
U1RYX0NLTF9XQwkJMHg2NA0KPiAgDQo+IEBAIC0xNzgsNiArMTc5LDcgQEAgc3RydWN0IG10a19k
c2lfZHJpdmVyX2RhdGEgew0KPiAgCWNvbnN0IHUzMiByZWdfY21kcV9vZmY7DQo+ICAJYm9vbCBo
YXNfc2hhZG93X2N0bDsNCj4gIAlib29sIGhhc19zaXplX2N0bDsNCj4gKwlib29sIGNtZHFfbG9u
Z19wYWNrZXRfY3RsOw0KPiAgfTsNCj4gIA0KPiAgc3RydWN0IG10a19kc2kgew0KPiBAQCAtOTY1
LDYgKzk2NywxMSBAQCBzdGF0aWMgdTMyIG10a19kc2lfcmVjdl9jbnQodTggdHlwZSwgdTgNCj4g
KnJlYWRfZGF0YSkNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHZvaWQgbXRr
X2RzaV9jbWRfcGFja2V0X2N0bChzdHJ1Y3QgbXRrX2RzaSAqZHNpKQ0KPiArew0KPiArCW10a19k
c2lfbWFzayhkc2ksIERTSV9DTURRX1NJWkUsIENNRFFfU0laRV9TRUwsIENNRFFfU0laRV9TRUwp
Ow0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBtdGtfZHNpX2NtZHEoc3RydWN0IG10a19kc2kg
KmRzaSwgY29uc3Qgc3RydWN0DQo+IG1pcGlfZHNpX21zZyAqbXNnKQ0KPiAgew0KPiAgCWNvbnN0
IGNoYXIgKnR4X2J1ZiA9IG1zZy0+dHhfYnVmOw0KPiBAQCAtOTk2LDYgKzEwMDMsOCBAQCBzdGF0
aWMgdm9pZCBtdGtfZHNpX2NtZHEoc3RydWN0IG10a19kc2kgKmRzaSwNCj4gY29uc3Qgc3RydWN0
IG1pcGlfZHNpX21zZyAqbXNnKQ0KPiAgDQo+ICAJbXRrX2RzaV9tYXNrKGRzaSwgcmVnX2NtZHFf
b2ZmLCBjbWRxX21hc2ssIHJlZ192YWwpOw0KPiAgCW10a19kc2lfbWFzayhkc2ksIERTSV9DTURR
X1NJWkUsIENNRFFfU0laRSwgY21kcV9zaXplKTsNCj4gKwlpZiAoZHNpLT5kcml2ZXJfZGF0YS0+
Y21kcV9sb25nX3BhY2tldF9jdGwpDQo+ICsJCW10a19kc2lfY21kX3BhY2tldF9jdGwoZHNpKTsN
Cj4gIH0NCj4gIA0KPiAgc3RhdGljIHNzaXplX3QgbXRrX2RzaV9ob3N0X3NlbmRfY21kKHN0cnVj
dCBtdGtfZHNpICpkc2ksDQo+IEBAIC0xMjAwLDE4ICsxMjA5LDIxIEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2RzaV9kcml2ZXJfZGF0YQ0KPiBtdDgxODNfZHNpX2RyaXZlcl9kYXRhID0gew0K
PiAgCS5yZWdfY21kcV9vZmYgPSAweDIwMCwNCj4gIAkuaGFzX3NoYWRvd19jdGwgPSB0cnVlLA0K
PiAgCS5oYXNfc2l6ZV9jdGwgPSB0cnVlLA0KPiArCS5jbWRxX2xvbmdfcGFja2V0X2N0bCA9IGZh
bHNlLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHNpX2RyaXZlcl9k
YXRhIG10ODE4Nl9kc2lfZHJpdmVyX2RhdGEgPSB7DQo+ICAJLnJlZ19jbWRxX29mZiA9IDB4ZDAw
LA0KPiAgCS5oYXNfc2hhZG93X2N0bCA9IHRydWUsDQo+ICAJLmhhc19zaXplX2N0bCA9IHRydWUs
DQo+ICsJLmNtZHFfbG9uZ19wYWNrZXRfY3RsID0gZmFsc2UsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19kc2lfZHJpdmVyX2RhdGEgbXQ4MTg4X2RzaV9kcml2ZXJfZGF0
YSA9IHsNCj4gIAkucmVnX2NtZHFfb2ZmID0gMHhkMDAsDQo+ICAJLmhhc19zaGFkb3dfY3RsID0g
dHJ1ZSwNCj4gIAkuaGFzX3NpemVfY3RsID0gdHJ1ZSwNCj4gKwkuY21kcV9sb25nX3BhY2tldF9j
dGwgPSB0cnVlLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQgbXRrX2RzaV9vZl9tYXRjaFtdID0gew0K
