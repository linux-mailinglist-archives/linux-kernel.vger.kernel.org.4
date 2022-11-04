Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B86F61923E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiKDHxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiKDHxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:53:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF4C14081;
        Fri,  4 Nov 2022 00:53:32 -0700 (PDT)
X-UUID: a19efc002d35411bb5881a0cbc0492b5-20221104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3c9wWiN+8oMqh21/U9FOVfxVsElK+x3UlRx95555E1I=;
        b=GjO4T+B/MSrS+3meqR2zOx97VkwM22GgF0rwJNNHfYDiDGVdxuqi6xpzDLG2kQrDsLLF2uKZWef+KazFZN94MFOvbwPxJTN68RsdLp3Bah7CVyTnHqeTx6HLBauhD3LA5WHkvrDYuCZd/oq4Tn8jRoTYyHgeHjcpAA2iADjuO+M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:9de92618-4a6a-49a4-889c-b924a054ae46,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.12,REQID:9de92618-4a6a-49a4-889c-b924a054ae46,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:62cd327,CLOUDID:03a46eeb-84ac-4628-a416-bc50d5503da6,B
        ulkID:221103134402S1O6PI6K,BulkQuantity:13,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: a19efc002d35411bb5881a0cbc0492b5-20221104
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <bayi.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 315762809; Fri, 04 Nov 2022 15:53:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 4 Nov 2022 15:53:24 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 4 Nov 2022 15:53:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eF6SRoekHKEC7T7YQFHU5LU44NzW10A3nZ2x84Qqg/Jegh0e70l5tNoLh++5UX3aR0jLdVseUeqr2hiJ8A0UxJNH+iH6enmd1b9XRyHU87aWjXKmBc4m09IGRXJ5XII88Y3yrwg/L6HTdGamYI2dkbbMcb7iVRDfLd+zBAk3vqpIc4iAexwnfLJBnLZgBHU6ynQ/KZinlJoFO9xIZsn4LPkUC9lpV8q+P7DU2fdbaP9OLt3bjJZnyhV8Fskwt3EEaHic6hRZOysN2I71R+Go0RgqyRS9YHd7OsI2SikLDQ9okBSbfY1W1nI/Q/o9c8XP3nzUCtX6Su0XfLQMqoPPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3c9wWiN+8oMqh21/U9FOVfxVsElK+x3UlRx95555E1I=;
 b=iMUlGz3JKTOPzDmklL1b5fTMXW5uJlRQvnKkSGji1o+JT5rGvYfcP/0289vg2vzk7VjV1cbqcI3o6ZfMThYfrjwFwemqYFjIR2SBcTVPPXvjwEp7kzlvlC/jZwYySdwK8dd+RJXcOQVPTUcqGSeb05z++c9HttWthG8G1QM00m71SZV0DMwYguGSVMybaGry0H+JXQcXyA5vspCaZTzWZ4v9YtaRvtv1ieSzFYuBasFEC5nbN3xh7U/nnxf+wWWVSi/sodGmPUVezAxun3mmW+4yV+YHlM2WkffBW1RMxAQg1l8HGGVCnufSLnro7jiR5ueBEbKnrsUa6pUitIeylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3c9wWiN+8oMqh21/U9FOVfxVsElK+x3UlRx95555E1I=;
 b=XfTDNMdfJF220wJl9ruIOVBBW8Nt0TiKLNEAHngfP+Um+f7kLi9YT4K+IoVPmxhd/tx8zCdCfG1ZkZ39+XL+qMv4njFc0VsdTYIueYQHBJNEFivslVS8C+CG+DPNci2HJ4pbUVWnyEIvfjoSA0b/qu22luhlVHg1TWcVkR+QF7E=
Received: from PS1PR03MB4747.apcprd03.prod.outlook.com (2603:1096:300:86::18)
 by KL1PR03MB5636.apcprd03.prod.outlook.com (2603:1096:820:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 07:53:22 +0000
Received: from PS1PR03MB4747.apcprd03.prod.outlook.com
 ([fe80::b0f2:a34a:b2b4:3eef]) by PS1PR03MB4747.apcprd03.prod.outlook.com
 ([fe80::b0f2:a34a:b2b4:3eef%7]) with mapi id 15.20.5791.009; Fri, 4 Nov 2022
 07:53:21 +0000
From:   =?utf-8?B?QmF5aSBDaGVuZyAo56iL5YWr5oSPKQ==?= 
        <bayi.cheng@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v1] spi: spi-mtk-nor: Optimize timeout for dma read
Thread-Topic: [PATCH v1] spi: spi-mtk-nor: Optimize timeout for dma read
Thread-Index: AQHY70U3L+QgZhq720C1cLpB3c3zja4s8viAgADXjICAAJv0AA==
Date:   Fri, 4 Nov 2022 07:53:21 +0000
Message-ID: <617c0b563a2602668fde7d96e1bc98648870d30c.camel@mediatek.com>
References: <20221103052843.2025-1-bayi.cheng@mediatek.com>
         <20221103052843.2025-2-bayi.cheng@mediatek.com>
         <10529948-a9b8-2121-7adb-0e94cf3cbf6a@collabora.com>
         <c612cc0eb4fc463a9bfd9094ff652ac9@AcuMS.aculab.com>
In-Reply-To: <c612cc0eb4fc463a9bfd9094ff652ac9@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB4747:EE_|KL1PR03MB5636:EE_
x-ms-office365-filtering-correlation-id: 96ac8207-4fb4-4f88-8478-08dabe39a51e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eAdZY1iTf1nsXuG4hVC83qFjJ/jKlOkaF3bQCjb9XEtaJopcjR7UViVuSaifyrFIMyBTztxFPAiVBRT5htzvgdFaHBgCIV4uA3QGhg1RuZwOfovKh0seCPwDrV443Q9g8zKpmguplbZwq1EKlgYslvtjcDNsALcpw6S7cu2skRKb2fYLcSjrmA/lmLVp6Vp+IXHC8O9xcmjQISVkVsbYJXj9A0AL13gxb+kjEXdWzEGxUk7G6JxgKU+oyO5vqCaTlLE/JyLw9KjyL2B0iuLtK1t2+FOo1Zeh/WC1ASZwK/wbEDpVfhml0oq9cBwe27sap3h49kZyVi3HG761kWFVHfpYJCCX5xWMpKqacPZfKVhoYY/x6TSY9IH4KbNBw79LDOM+m1nMDgEMj3/krtkam07MpLchmC4p/G7w+789gGAJ8SJa79mjBVvcBUnyX15Z4WU1wymoqHT1yXebKFfeQZ+NSzAro3WWIPexIW15Z4lMy/iXnmIgWFgz6lFgiwO3mnadMZwm5SNEqkhSqkA7yia01YyLUoF/wJTgAY9X1gKoDjadsUe6TPO+ZnRDlEWOdbHt1I57jTntP0X4GxURuVc1tCLQJ96Jv0Y/eSa8nglkV3wWRy9VsY/DsX/jqREAt0+IZMDFWCuq0qSLbEghDC6FM4C3cRbrSTWcas56ySIC+M+tMD1QRG9lIkM0nUl9BHc8hRsJYq+yDBy7UxKySZ4kfVrqGNBAiZAs1qiCBPm02oefgQ7/GVcXGM2D1NeFf9R6CBxXbuyh+pOrjzlUQ8gkxi9cWbpm77I5F9Qh8N8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB4747.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(76116006)(64756008)(6506007)(66476007)(6512007)(4326008)(66556008)(66946007)(85182001)(66446008)(91956017)(36756003)(2906002)(6486002)(83380400001)(38100700002)(107886003)(26005)(122000001)(86362001)(8676002)(478600001)(71200400001)(54906003)(316002)(186003)(110136005)(8936002)(38070700005)(5660300002)(41300700001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0swU2RWcTZmUC9weGFvQitIOXZXL1EwRiszSHNSZHNnSmRNS3NtNitjaXRy?=
 =?utf-8?B?TDFHOE5rcGptZVUxU2pTL1ZUaHphYnNVaTJpeWs4eGRXckxkUDQxQmV3bUNQ?=
 =?utf-8?B?YitpSDYxYzRxOGxCcmwxSkdSZS95UWRyNDZFS3BlZnZMNUd3cG5OMkFnQXJH?=
 =?utf-8?B?MUErWHNKYnVnUVlwcEJaaFVYUDZaRi94eUxsZS9KaEZZa25iYnM3TGQ3WVFS?=
 =?utf-8?B?Y0hKQjc3RDAzYmtFY2JmRTc1M2ZZTXdvWUg4cTJENEI0SDN2Zk5UK0o5OG1Q?=
 =?utf-8?B?ZDdacHdaZERBb3hIUExDYlk3N2cwNnRaWk5tWHp4TE94eXVpN1BscnlZNG1s?=
 =?utf-8?B?dE5XeHo5QzdpUFJCWUZDenJYZ05xK21aU2Z6UDNJMUNzQ2VwWUZJYUZLVzJx?=
 =?utf-8?B?SlNSb0djemFCMzZCQWJSaHFzUERHdnlmbk9jQ0FOQWhaQzJublNkU0lGK0JO?=
 =?utf-8?B?TkRiWkQySTBhVE5lVUdDNlErUWpmemR1SGVTbUU5UGVHNm8vc3VTM3pZblFs?=
 =?utf-8?B?aEhpdWJtTTZhUjhtVy8zalo0dTBUN3Z5bVN6VlNJdWJDZUNYdlgwRGlhcU9D?=
 =?utf-8?B?NUlEZ0YrN3VXZ0VrNTNRdkRIYUEydnBPV3JRc0k1SWRXOHFHWndIaDMzMlkx?=
 =?utf-8?B?R3ZWS3BMSDdQVG9UR3kxSVF3ek5WaSs3L3hLZUZ5ZU02YmtaRHJyMlFaS0Jy?=
 =?utf-8?B?QWllZnYwbkR5QXJIQ251amMxUTRnS2JvL3EvMXV0UHJWRTNoZWFQcXF3WEZw?=
 =?utf-8?B?ZEt5NkIzNTEzOEdGaEVXUWZBWkczOFhoWFB2RjlaSlloc28vNjVEOVMxUXBq?=
 =?utf-8?B?cEtPTTZMYXErOTBXa0tZMHl1bjFNYUZtVTMydWx6TmRvNnlnb29aT3NRRUor?=
 =?utf-8?B?WmN0VE8xSzN2TG1rYW9BTlBJbFZEcGc0VlpTQ3RwSUxLUk8wdmZCbFRMbmlm?=
 =?utf-8?B?Z3JYdHBSb0VMTnJCNE9VUTRWRkR5YmRWYnlHVFJ1bXhGMWJaUzJ6WXFwQU10?=
 =?utf-8?B?SGZRdFZxMnFJS1dZZ0ZQSGEyYVgzL2xVK2I5T1pieEZ1OUtUZHczeVlWWlUv?=
 =?utf-8?B?Wm1YRzVWNXkxUC93amRndDlIVTBNWWovWkFyZ0oyMTl4YjhJZ05QajQreGNF?=
 =?utf-8?B?VEtQdHZISGZTSjhoOEIrTGtjbDhDNWJrN2ZkaDRxVkFjb1FXazMrNERtbVN6?=
 =?utf-8?B?bVRrRE5uTGVjTm5xL1hGRGtLSngwbGJ0NmtIZVlKUjNkYWhSek9TTW04eDY0?=
 =?utf-8?B?em54Z2IwaWFsWExTTE5uRE1tMWpVd2JvbkxvdGtNU2VuNTZpeVZkU0NmT2x6?=
 =?utf-8?B?UnF4ZEZIMnJVRGkzSWRPdWhLYUxGdUNITUZPOFFYQWZiam0vY2t5ckMxZ3gx?=
 =?utf-8?B?d2VueHNFenNoODhYNWREVzBsUjd6UzFnQ1dUaDRDb2xNVWFhWkdqMHRLNDE1?=
 =?utf-8?B?MENSV1U1dVBld0ZNeUN0US9VRWhYUWdHQmRRZTN1eEV5VTRJRGRqSUVzOERS?=
 =?utf-8?B?bm5KcjJ0bkZmcGFOOGwvcWN1RU11UHByZlNjY0NXQ3NiK3pqY1JzbzVWN2RC?=
 =?utf-8?B?aC9OMjZhN3QzdEQ3dlBzSkxWSXJpRm9qYithc3RsQnR6aTZKTnU4bC93RXhq?=
 =?utf-8?B?RVArT01QUTlJcXREWW9sQ1NrM2VxOUpZTVgzTnJ5ZDFFNG55d1FXNnJTOUxB?=
 =?utf-8?B?TmZ1WUxZRkZrbk9YRUlWcklzRUo5M3ZrV09aMTNnNTZUYVVLWFBYSUgxajZ2?=
 =?utf-8?B?MVBxcFFoUTE2MFlVTVFnbGM1aTVIY2QwNlBZdmp0bHZaMU9sdjcwYzJXa3du?=
 =?utf-8?B?K2hBV0VpQmxJNU5lVmtSOU0xOVp1N2JFOFlVWWxvRlh3dFFhKzUyTjNzeGtx?=
 =?utf-8?B?S0hEYVM1VHgxYkxmV0VXUEVtZklpN2lRZkNsN1VKTmVDTmE0azVIWVo3NkRx?=
 =?utf-8?B?bzhvKzFVZ2FNaWtKS3VNS2lyN1VMY0h2d0dhWE9IcXdyTlRJbWJ2WThMeWhZ?=
 =?utf-8?B?V001UFdrMWJCd2Mzb3ZpMVMwcFhjWFFqejRnWjJlR2NGQnpxNkFnYWFRbWFH?=
 =?utf-8?B?WlViRFdqekdFSUtETUY5SWxnd0VlUTI1YlBVU29aRTN6YkUxODNFYnRmaHZI?=
 =?utf-8?B?VmJncG1rZmw2K1EzcXhSMnllSHJrcDdNejc4UTlVaEl2ZUl4SEVZcUoyTnY5?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E774C3377A46ED4388F7008CEE14AC97@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB4747.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ac8207-4fb4-4f88-8478-08dabe39a51e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 07:53:21.8375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIf3nFfa/Z7UuCIikoP3fDZXbpbs4PoLHn8faT2LnxZ6cSZD/Fl5mfuPPoIT6rIQJjmKIazKRUTvtnBnvEbDEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5636
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTExLTAzIGF0IDIyOjM1ICswMDAwLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+
IEZyb206IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+ID4gU2VudDogMDMgTm92ZW1iZXIg
MjAyMiAwOTo0NA0KPiA+IA0KPiA+IElsIDAzLzExLzIyIDA2OjI4LCBCYXlpIENoZW5nIGhhIHNj
cml0dG86DQo+ID4gPiBGcm9tOiBiYXlpIGNoZW5nIDxiYXlpLmNoZW5nQG1lZGlhdGVrLmNvbT4N
Cj4gPiA+IA0KPiA+ID4gVGhlIHRpbWVvdXQgdmFsdWUgb2YgdGhlIGN1cnJlbnQgZG1hIHJlYWQg
aXMgdW5yZWFzb25hYmxlLiBGb3INCj4gPiA+IGV4YW1wbGUsDQo+ID4gPiBJZiB0aGUgc3BpIGZs
YXNoIGNsb2NrIGlzIDI2TWh6LCBJdCB3aWxsIHRha2VzIGFib3V0IDEuM21zIHRvDQo+ID4gPiBy
ZWFkIGENCj4gPiA+IDRLQiBkYXRhIGluIHNwaSBtb2RlLiBCdXQgdGhlIGFjdHVhbCBtZWFzdXJl
bWVudCBleGNlZWRzIDUwcyB3aGVuDQo+ID4gPiBhDQo+ID4gPiBkbWEgcmVhZCB0aW1lb3V0IGlz
IGVuY291bnRlcmVkLg0KPiA+ID4gDQo+ID4gPiBJbiBvcmRlciB0byBiZSBtb3JlIGFjY3VyYXRl
bHksIEl0IGlzIG5lY2Vzc2FyeSB0byB1c2UNCj4gPiA+IG1zZWNzX3RvX2ppZmZpZXMsDQo+ID4g
PiBBZnRlciBtb2RpZmljYXRpb24sIHRoZSBtZWFzdXJlZCB0aW1lb3V0IHZhbHVlIGlzIGFib3V0
IDEzMG1zLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBiYXlpIGNoZW5nIDxiYXlpLmNo
ZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL3NwaS9zcGktbXRr
LW5vci5jIHwgNyArKysrLS0tDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Nw
aS9zcGktbXRrLW5vci5jIGIvZHJpdmVycy9zcGkvc3BpLW10ay0NCj4gPiA+IG5vci5jDQo+ID4g
PiBpbmRleCBkMTY3Njk5YTFhOTYuLjNkOTg5ZGI4MGVlOSAxMDA2NDQNCj4gPiA+IC0tLSBhL2Ry
aXZlcnMvc3BpL3NwaS1tdGstbm9yLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1tdGst
bm9yLmMNCj4gPiA+IEBAIC0zNTQsNyArMzU0LDcgQEAgc3RhdGljIGludCBtdGtfbm9yX2RtYV9l
eGVjKHN0cnVjdCBtdGtfbm9yDQo+ID4gPiAqc3AsIHUzMiBmcm9tLCB1bnNpZ25lZCBpbnQgbGVu
Z3RoLA0KPiA+ID4gICAJCQkgICAgZG1hX2FkZHJfdCBkbWFfYWRkcikNCj4gPiA+ICAgew0KPiA+
ID4gICAJaW50IHJldCA9IDA7DQo+ID4gPiAtCXVsb25nIGRlbGF5Ow0KPiA+ID4gKwl1bG9uZyBk
ZWxheSwgdGltZW91dDsNCj4gPiA+ICAgCXUzMiByZWc7DQo+ID4gPiANCj4gPiA+ICAgCXdyaXRl
bChmcm9tLCBzcC0+YmFzZSArIE1US19OT1JfUkVHX0RNQV9GQURSKTsNCj4gPiA+IEBAIC0zNzYs
MTUgKzM3NiwxNiBAQCBzdGF0aWMgaW50IG10a19ub3JfZG1hX2V4ZWMoc3RydWN0IG10a19ub3IN
Cj4gPiA+ICpzcCwgdTMyIGZyb20sIHVuc2lnbmVkIGludCBsZW5ndGgsDQo+ID4gPiAgIAltdGtf
bm9yX3JtdyhzcCwgTVRLX05PUl9SRUdfRE1BX0NUTCwgTVRLX05PUl9ETUFfU1RBUlQsDQo+ID4g
PiAwKTsNCj4gPiA+IA0KPiA+ID4gICAJZGVsYXkgPSBDTEtfVE9fVVMoc3AsIChsZW5ndGggKyA1
KSAqIEJJVFNfUEVSX0JZVEUpOw0KPiA+ID4gKwl0aW1lb3V0ID0gKGRlbGF5ICsgMSkgKiAxMDA7
DQo+ID4gPiANCj4gPiA+ICAgCWlmIChzcC0+aGFzX2lycSkgew0KPiA+ID4gICAJCWlmICghd2Fp
dF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZzcC0+b3BfZG9uZSwNCj4gPiA+IC0JCQkJCQkgKGRl
bGF5ICsgMSkgKiAxMDApKQ0KPiA+ID4gKwkJICAgIG1zZWNzX3RvX2ppZmZpZXMobWF4X3Qoc2l6
ZV90LCB0aW1lb3V0IC8gMTAwMCwNCj4gPiA+IDEwKSkpKQ0KPiA+IA0KPiA+IFlvdSdyZSBnaXZp
bmcgYSBgc2l6ZV90YCB2YXJpYWJsZSB0byBtc2Vjc190b19qaWZmaWVzKCksIGJ1dA0KPiA+IGNo
ZWNraW5nIGBqaWZmaWVzLmhgLA0KPiA+IHRoaXMgZnVuY3Rpb24gdGFrZXMgYSBgY29uc3QgdW5z
aWduZWQgaW50YCBwYXJhbS4NCj4gPiBQbGVhc2UgY2hhbmdlIHRoZSB0eXBlIHRvIG1hdGNoIHRo
YXQuDQo+IA0KPiBUaGUgdHlwZSBzaG91bGRuJ3QgbWF0dGVyIGF0IGFsbC4NCj4gV2hhdCBtYXR0
ZXJzIGlzIHRoZSBkb21haW4gb2YgdGhlIHZhbHVlLg0KPiANCj4gUXVpdGUgd2h5IHlvdSBuZWVk
IHRvIHVzZSBtYXhfdChzaXplX3QsIC4uLikgaXMgYW5vdGhlciBtYXR0ZXIuDQo+IHRpbWVvdXQg
aXMgdWxvbmcgc28gbWF4KHRpbWVvdXQvMTAwMCwgMTB1bCkgc2hvdWxkIGJlIGZpbmUuDQo+IA0K
PiBCdXQgaXMgdWxvbmcgZXZlbiByaWdodD8NCj4gVGhlIGRvbWFpbiBvZiB0aGUgdmFsdWUgaXMg
YWxtb3N0IGNlcnRhaW5seSB0aGUgc2FtZSBvbiAzMmJpdCBhbmQNCj4gNjRiaXQuDQo+IFNvIHlv
dSBhbG1vc3QgY2VydGFpbmx5IG5lZWQgdTMyIG9yIHU2NC4NCj4gDQo+IAlEYXZpZA0KPiANCkhp
IERhdmlkICYgQW5nZWxvDQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50cyENClRvIHN1bSB1
cCwgSSB0aGluayB0aGUgbmV4dCB2ZXJzaW9uIHdpbGwgbWFrZSB0aGUgZm9sbG93aW5nIHR3bw0K
Y2hhbmdlczoNCjEsIFRoZSB0aW1lb3V0IHZhbHVlIHdpbGwgbm90IGV4Y2VlZCB1MzIsIHNvIHRo
ZSB0eXBlIG9mIHRpbWVvdXQgd2lsbA0KYmUgY2hhbmdlZCBmcm9tIHVsb25nIHRvIHUzMi4NCjIs
IENoYW5nZSBtc2Vjc190b19qaWZmaWVzKG1heF90KHNpemVfdCwgdGltZW91dCAvIDEwMDAsIDEw
KSkgdG8gYmUNCm1zZWNzX3RvX2ppZmZpZXMobWF4KHRpbWVvdXQvMTAwMCwgMTB1bCkpLg0KDQpJ
ZiB5b3UgdGhpbmsgdGhlc2UgY2hhbmdlcyBhcmUgbm90IGVub3VnaCwgcGxlYXNlIGxldCBtZSBr
bm93LCBUaGFua3PvvIENCg0KQmVzdCBSZWdhcmRzLA0KQmF5aQ0KDQo+ID4gDQo+ID4gQXNpZGUg
ZnJvbSB0aGF0LCB5b3VyIGB0aW1lb3V0YCB2YXJpYWJsZSBjb250YWlucyBhIHRpbWVvdXQgaW4N
Cj4gPiBtaWNyb3NlY29uZHMgYW5kDQo+ID4gdGhpcyBtZWFucyB0aGF0IGFjdHVhbGx5IHVzaW5n
IG1zZWNzX3RvX2ppZmZpZXMoKSBpcyBzdWJvcHRpbWFsDQo+ID4gaGVyZS4NCj4gPiANCj4gPiBQ
bGVhc2UgdXNlIHVzZWNzX3RvX2ppZmZpZXMoKSBpbnN0ZWFkLg0KPiA+IA0KPiA+IFJlZ2FyZHMs
DQo+ID4gQW5nZWxvDQo+IA0KPiAtDQo+IFJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLA0KPiBNSzEgMVBULCBVSw0KPiBS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K
