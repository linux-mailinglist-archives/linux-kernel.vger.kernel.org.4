Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5D964515D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 02:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiLGBmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 20:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiLGBmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 20:42:17 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA69528AD;
        Tue,  6 Dec 2022 17:42:10 -0800 (PST)
X-UUID: 964bbd14c7e74acf8a29b3c706c547ca-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=iFAprb2AtwMEUP0wyHWG2VACi4PXJyH9Dttyux8Z4Aw=;
        b=V5i8a+iNNZDw4MFB+Ea4Bp2J/IE3OvpiYV8TyFSnhYfA3hauuidlmFlTa/APWOm8JonScGxDeRTL6LxWaqospCS51Dqtdjx+gsNRxRNE3zyoMCEhJdsJdKLIRVyRoXnSaOiKH0DtFpbd0CSOc4Zo3nAbZi1nZeZAFri4Vzy+67U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:f6bf82f0-350b-48d1-9725-ffc6a6d5b48c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:ea9fbe16-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 964bbd14c7e74acf8a29b3c706c547ca-20221207
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1679579869; Wed, 07 Dec 2022 09:42:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 09:42:05 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 7 Dec 2022 09:42:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOvRtG8ySXk6AenxpoD1tH0jflHoI0lCHuQDRnN0vRrOYuH73PKsRV6omSpWH6GrvicDtBIlJV7pRUCIuqDXjVEbcxBLZvOteGD+kePIDNACRSllsPMMnpV5xQTeFaHLbwctKMeW2GqGuXTqlcpvVbCf/Jol6q+2JSEAcTH4lQgv3c3DOE9A7obzMo2yvWTPJy9kl60KFhg+gOYQBE3LTtX4hv2JaVxqWo8A0oudesRrX0fszEuR3bermtIGv2qaGjKm6mbUb/WHKQ92WGqbxY3g3I8I1FmXwTJSS6zaRk02QpVcUWxhfRRaMJYgb14G2SgBVyvgUxmFpP7KsE1LaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFAprb2AtwMEUP0wyHWG2VACi4PXJyH9Dttyux8Z4Aw=;
 b=OpeB6eHNmWoUbvSBvun8RryYDwtiaRJtYKwyOKWsXWrkXn7G2eriKW4DAmtaQzloLho8hzK+/JprfUyl3/bXOJF2sZcEFs04USlD4vTL7bPHy9/nF0BEb4Rn456NgOWSJehfyuZOwAlEIt4Z0LDT8ef2Q5Vi8PxpSNukCYyGztbBMYyTJ/m9LYZQ1WYnWFF1ejL+oN+m1Pn+nE7YF5WqS3BSY2xMWgZF4MgM7wyspxeJ0YjxstbXY9nsE5KV55U8BHl1WDpGBxMqnWyMTg7n09Gop8jmgqm0yBV7HhspQPwJcEMmqScpeDhnrwdsukgvYO4tD92l9gjDb77iQktdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFAprb2AtwMEUP0wyHWG2VACi4PXJyH9Dttyux8Z4Aw=;
 b=o1enETlzmR8dcruUAdywSilwKx2/36d2CjEdzmgQZ6POXfgPO4wfleNpCr5SQdUSfI5+7wZ3e3H36ci3X53dX4tkY+citIbgtWDAOD7GSPCOyi8JkfsTXhQE9vtbR7eJN+xF85kE05rFXqGxGzx/H1Sa7TMxsRSYa+T+v7I9rkk=
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com (2603:1096:4:84::10) by
 TY0PR03MB6984.apcprd03.prod.outlook.com (2603:1096:400:274::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Wed, 7 Dec
 2022 01:42:03 +0000
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::3d3b:d288:88e3:59c7]) by SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::3d3b:d288:88e3:59c7%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 01:42:03 +0000
From:   =?utf-8?B?WGlhbmdzaGVuZyBIb3UgKOS+r+elpeiDnCk=?= 
        <Xiangsheng.Hou@mediatek.com>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?= 
        <Benliang.Zhao@mediatek.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>
Subject: Re: [PATCH v2 3/9] spi: mtk-snfi: Add optional nfi_hclk which needed
 for MT7986
Thread-Topic: [PATCH v2 3/9] spi: mtk-snfi: Add optional nfi_hclk which needed
 for MT7986
Thread-Index: AQHZCHcKAqDYAZ7VlkKM1ijAHZgn965fWNSAgAE5nYA=
Date:   Wed, 7 Dec 2022 01:42:03 +0000
Message-ID: <4db35ac3914e444b754f9075141fd69e07e7c858.camel@mediatek.com>
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
         <20221205065756.26875-4-xiangsheng.hou@mediatek.com>
         <ef2e6859-56e1-bbf0-dbde-44ea3d7d2f3f@collabora.com>
In-Reply-To: <ef2e6859-56e1-bbf0-dbde-44ea3d7d2f3f@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB4565:EE_|TY0PR03MB6984:EE_
x-ms-office365-filtering-correlation-id: 9178e1db-c9dd-4e4b-a4b3-08dad7f43d95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 85Kpp6usiW1yINFl0XtfunfnNpUOzN9kPH7YAtfjYdJg7dkqHLjMKuLJ7Dn7WEZKJdB/k/XFH1Lu7XVGVBkixmm3zsZo4812tC7y4KFSLAqg9pm+Y3sMesm+F6O7ookHttOeZuEC1cyLqN00L3n/JLArVyxG2Lgy2eGvmQl/eOLokmE295jzxyeZSnsr3Wm9ZGNFHOEGJX2lHMGxcz5P4M44XD1S0IEPMVc128qA4Pi9VxGyohWVYwG5Szv/L2DLMQpLfCNCkIQd+15u1CvEcbcSgqyST0JzFZ0b6Ywc5s5hfVTF2DFXnlQ2A1quhBUuSNrPQD+LNKohh5H3p6aBks8/L8MUincDDTeOqWecMoQP300naNMXmQW9MNzw2lKQQQc841H5R4KUHpzPlWBuLaXXN1FsAALFndBPFoIBO3VzljP3G53dpuH8nendulNW5fYo6L1zZiWPUC81zfKdfvhsbSPBmN9ZxI+1XNtBPq/1WLeutAL5tjiMCzPqkssfAT2avhdIJJZ/Hm6dd0w3cTsEQSKEIpdTzZpW/S4BmzaUj/rGnIwEq66u5gYK0UH3r0DM7NtNSZPAvvLdUyaTmJqYv+w+K40hZdZGzJP8+8VQrPNfbMjcrK2p6JhS8YWkAAFKTscRFhQN+WeKr0OZb6aAA7HDzUXQmPvFxYmDt3NU6oD1kEQ9FyeRx3ve/yyYDp9VT20CsmzPPNk3pVnCmmbVYz3L18N8SLwSvDXQq6TvLCxK7Qvpn/aERGw9TXjE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB4565.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199015)(8936002)(64756008)(316002)(110136005)(4326008)(6486002)(66556008)(38100700002)(41300700001)(54906003)(66476007)(86362001)(8676002)(66446008)(7416002)(66946007)(76116006)(85182001)(4744005)(36756003)(2906002)(38070700005)(478600001)(6512007)(5660300002)(107886003)(122000001)(71200400001)(186003)(6506007)(26005)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGY0YTNBc2lGK2YvaitRQng0ZFd0c1RCaWVtK0dEZFdEUU9YNXZXN0RCKzg2?=
 =?utf-8?B?aXpRKzd6RmdtUWFRZEdiTmZNc3FkTlJpeEJEV2EyQWd4cVNPdyt2RFRIalVQ?=
 =?utf-8?B?R1FwMzBYVS9jcWxHaXdGa3ZLNDQ2RnhRUVQxdzBOdGMxcStEaE1WRHh5NGNi?=
 =?utf-8?B?a1MrOVk0MllEQkt3NGtZcmVaNUhzMnJINmRxMVl0QWQ2eUZwVXhmM29tMHZJ?=
 =?utf-8?B?YXJUT2pSV1RRQjVJNHZmd3gyTnVGNVh0WVZ5Y2ZKbEt2Y1dmRjlreE84a1g3?=
 =?utf-8?B?dGxWajBVVnJVMUhldUY1bk1iV0J6enB2QjlTL0pDeUF1TmZxSFhFTFEyWlUz?=
 =?utf-8?B?YmFTMDFrYmhLRUp5T1VEdVRDZVRlWFl0Y1pLQnc4SUpSY0F5Ymp3aG0zZk5U?=
 =?utf-8?B?aXlKOHVTS1dOcEVMTnFsUit6OWxUZ2lVaG1XUENUMnV4dGxKZGxtcVdFdG96?=
 =?utf-8?B?cGdqQm01eVkybU9BNDh0K3BoTmZWZlNlOVQvMDZWOTJoNTJRSzJ0Q3RNN1hH?=
 =?utf-8?B?UVFhbmk4VzRrSkh5VDErKzUrVVo4R1Q4T3p5UU1ObU1pc21SVm55R290WFJG?=
 =?utf-8?B?aUpkNWRINVJOREc4M1ZLQmU0SUpnYjRLaU9RUURNN2c0RjEyWmNiRmhiRXFZ?=
 =?utf-8?B?eUo2bHcvZFZGMThzVVVLcWw0TVkzRHFMSnhvdS8zcFlWMVdjZHRJWUNHNlZz?=
 =?utf-8?B?a3NPUXlVenMvalVJc0RBSlJJb2xLUUJSWVZlWHVITkVZVGEwQnJYZ1dxekZ5?=
 =?utf-8?B?Tlc2Tzc0MVJxN1ZkdGVHV1hHMHYrS3lBbXpNc0JzVnNmUmdBVS9BS2M3bTJR?=
 =?utf-8?B?QVNYTkU4OHhRc0JlS0VGRFBlTWJEZkJRckhMS3picHdhekI5ZVE3WWRJYjgz?=
 =?utf-8?B?ZExVQk9ZTy8zTElQY3I2Z3p1amMyeDVaanpraHlwcG9ITDBTc0VXdEpVOXV6?=
 =?utf-8?B?emc1bk4zeUVFVFA5R3hqV3BjZnF2a3pydXZNbFpPazZmRXFXdVJ6cXVoc1d1?=
 =?utf-8?B?Vkx0K0RCV0pyanI5U05EZUplSFNhcjBqa3lVbEJpYXcyMVRySGlKUHRVcjhO?=
 =?utf-8?B?OUloaFVWRTgvcE9scE9qUFlaQXdRNjVjemYzTy9jRDNNVWtGYkhOTzRnUHZh?=
 =?utf-8?B?ZU93NzJFOXMzOEVsdWZ3QVJrVzRPY2RkeHl2Nk9Ib3lLaVJiTGJtZVIwdFZN?=
 =?utf-8?B?MjNQdTYxNDhocUJ4cEJlcXZpTzdUc3RUMUhIMm83Wm5DTlQyNkxmdWdWVUNC?=
 =?utf-8?B?eG5tNlhkSGhCMjAzOGx3ZnBMMGVLM3V2TGtQN1hTcUNxaGwyYythaXpLZUpX?=
 =?utf-8?B?NlZSdzNRWGFjWnplTVhyOWY3RkkrSm9TRXUyemUrWWg5RkFwcVFiNmpST1BQ?=
 =?utf-8?B?VjVlUTZZa0VENWVhTUNmTk1sTEtOY3NpbGNWalZPdDFKMW1kZlM1Ymg4MlJZ?=
 =?utf-8?B?cVZ0WW5vWHhYZFJNZ3YreVJjdU9tUyt6QTlQMXZXb1cxRW9VY3ZxUFJSQTRZ?=
 =?utf-8?B?YmFBODRBY29jMDZBQkk1aXlGVm1jZ3hUVzdYQ2kwOEQyYThUSHVqNUdpaHhB?=
 =?utf-8?B?QnJ4ejRJZmk5a1FwL0czeEQ4QjNNOFFXWGc0L3BwV3d2Q2xBWjdEejNiY1dX?=
 =?utf-8?B?eUdqSzdoZkFrVFFEa2w2Y2ZCd3oxZUdqK2h1MzUrUzhpZDVpQVN0TDF4OHNX?=
 =?utf-8?B?M3FCRFExaCswc2hrU3RNdE5WSytSVEpwNUU3Z1dOYWRnMVVJMktQYm5IOHpo?=
 =?utf-8?B?YVFHd0U1bWdNWndjdzRHWkhwRDE1WmFxSUtJM2JoZ1BETVlkTDQ4dkxmV0Fl?=
 =?utf-8?B?Z1FPVTVxanRBVWFJM0ZJYVkrT3RUSFoxZWhWWE96cE4wL3BPK01MZGFaa2tt?=
 =?utf-8?B?dmdvamU3eDBpQU9mZVN5L0JrMjRBUmJBNVlRbWhDRzZlU29Wc1FFdzZUTW1I?=
 =?utf-8?B?YlF1OXV6SDc3NUFZUTB3UTEvMWlOMjJPRERmMUVKdERFS2ZRdmVIOFU0cy9S?=
 =?utf-8?B?bEp2UU9IVmZ0eFhOVGkxazBBcXpZNGt0YnFOU3NSaC9oWjZHU3R2ZVA0YjE5?=
 =?utf-8?B?RGhnR00ydHdkbWF5OU45SGJVcXkyNVJGVlhTRENvanFZRnlOVmtSV2srdjdm?=
 =?utf-8?B?VzFYcnVhbUZBaVFDZ3lFWEFzNm02QkswTVd0citsbGcrQmhTS2pCV0RiNk51?=
 =?utf-8?Q?0bOW2JrzikxdK4yN8d1d3U4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6818DE503CF6734CB881C1A6519F2C89@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB4565.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9178e1db-c9dd-4e4b-a4b3-08dad7f43d95
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 01:42:03.1243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CA9XGRbnO/oNVzndHW9RYAOYM896XvCo2BYHfQgDhPMy8K+bIYSioFNElt0udMmb8FWy7hDPUHGOxZRHhU+HuOidADIL1iMAyJWhBqYbnww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6984
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBNb24sIDIwMjItMTItMDUgYXQgMTU6MjEgKzAxMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAwNS8xMi8yMiAwNzo1NywgWGlhbmdzaGVu
ZyBIb3UgaGEgc2NyaXR0bzoNCj4gPiBBZGQgb3B0aW9uYWwgbmZpX2hjbGsgd2hpY2ggbmVlZGVk
IGZvciBNVDc5ODYuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWGlhbmdzaGVuZyBIb3UgPHhp
YW5nc2hlbmcuaG91QG1lZGlhdGVrLmNvbT4NCj4gDQo+IElzIHRoZXJlIGFueSBvcGVyYXRpb24g
Zm9yIHdoaWNoIHlvdSBuZWVkIE5GSV9IQ0xLIGVuYWJsZWQsIGJ1dCBhdA0KPiB0aGUgc2FtZSB0
aW1lDQo+IFBBRF9DTEsgYW5kL29yIE5GSV9DTEsgY2FuIGJlIGRpc2FibGVkPw0KDQpObywgZm9y
IHRoZSBuZXcgSVAgZGVzaWduIG9uIE1UNzk4Niwgd2lsbCBuZWVkIHRoZQ0KUEFEX0NMSy9ORklf
Q0xLL05GSV9IQ0xLIGVuYWJsZWQgYXQgdGhlIHNhbWUgdGltZS4NCg0KPiBJZiBORklfSENMSyBh
bmQgTkZJX0NMSyBtdXN0IGFsd2F5cyBiZSBPTiBhdCB0aGUgc2FtZSB0aW1lLCBhZGRpbmcNCj4g
dGhpcyBjbG9jayB0bw0KPiBzcGktbXRrLXNuZmkuYyBpcyAqbm90KiBhbiBvcHRpbWFsIHdheSBv
ZiBkb2luZyB0aGluZ3M6IHlvdSBjYW4sIGF0DQo+IHRoaXMgcG9pbnQsDQo+IHNldCBORklfSENM
SyBhcyBwYXJlbnQgb2YgTkZJX0NMSyBpbiB0aGUgTVQ3OTg2IGNsb2NrIGRyaXZlciBpbnN0ZWFk
LA0KPiB3aXRob3V0DQo+IG1ha2luZyBhbnkgYWRkaXRpb24gdG8gdGhpcyBkcml2ZXIgYXQgYWxs
Lg0KDQpGb3Igc29tZSBJQywgdGhlcmUgbWF5IGhhdmUgb25seSBORklfQ0xLL1BBRF9DTEssIGFu
ZCBoYXZlIG5vIE5GSV9IQ0xLLA0KdGhpcyByZWx5IG9uIElDIGRlc2lnbi4NCg0KVGhhbmtzDQpY
aWFuZ3NoZW5nIEhvdQ0K
