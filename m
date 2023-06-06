Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BED723475
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjFFB07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjFFB05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:26:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577F38F;
        Mon,  5 Jun 2023 18:26:49 -0700 (PDT)
X-UUID: 320d2f30040911eeb20a276fd37b9834-20230606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4n3ZPzeXFUKYIGv2pfM/BN0z6Ir3pVyniYYX1gVymLE=;
        b=H3SPWlTs8pYr6iGzwtBO2n0IJGyhL2A3+SzzuiEzCI0pvoKtUyJ+lawup61l6iGVFYBPFw4OXevjh1lw+hlZGDE8dFQW4qkzcKXC77bJVG0ZllwBmFmhw8quYAi8ejBh4KhsHNnc0PO5aWECu8XJFF3oElXykeN6sBiVXPcy3kQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:adb59a26-3c63-4fe0-b2bd-c483d4bd0c3b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.25,REQID:adb59a26-3c63-4fe0-b2bd-c483d4bd0c3b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:d5b0ae3,CLOUDID:50a5793d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230605212233LMPA4YL0,BulkQuantity:17,Recheck:0,SF:19|38|17|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 320d2f30040911eeb20a276fd37b9834-20230606
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1051345986; Tue, 06 Jun 2023 09:26:43 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Jun 2023 09:26:43 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 6 Jun 2023 09:26:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M15YBGCh7BtP8vZne/LzwMc9gEBEkagSiw/bR1cJOg45QWnOixQt8zvRCVM4/0QxFsIt2NQmZ5p9KF5kkSN3sT9m1pC5SEClqWhRUyPggyZVKkVdES4KKx4hGV9hwOId4QFmb4McZmdUpu3OZU6gaGzV7x2MKktDaKh3FBXmxbNihxIPwIkSG71yqiv84XcIBwxI2jQo0Gi6vtWDQwZ7Irsdg+l1CTjHAQT4AjBkGScTGlQ40s7r7E33fMwPYjPaXmvv6kFbVNpEzzqkFCoDXqYtNV5FRYSzUb1JTKeJZbjXUqkmDLcOF1sZUQTiVWIedfJfD6uG3+1wwHC+rw1pvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n3ZPzeXFUKYIGv2pfM/BN0z6Ir3pVyniYYX1gVymLE=;
 b=jh+DrS/GixSTFIEjRaE3ij7gY+/7/vd0zgVqBADTw095Db6txxHjzPhlg1/TH2cvAeqbiyfjVUiRWWeOCYTK7K3SycQ7QRIx8pW+yWLu+HoywUDtxrO0qGDLXI8xECgyKnVpaA6K5uRsihawOlr485BEzGTtXQKuubjcEfoR2rJnVx2ntMobzhKwbbrrmEPU2MkkJrNlBqIt04dsB6k7ZyTD7U3H9k6KdJcDzf/yw8YvYO3S5BYllqfhInf6Pu1ZZO3vr+7rGPhh3amRnxyhoXaAd1UcLiyl2YVFc+8x1Q0/lc6Xv3DxBSXkN78UQgZHB/Bg7UMjAy+wO0G2UBdZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n3ZPzeXFUKYIGv2pfM/BN0z6Ir3pVyniYYX1gVymLE=;
 b=Abt61f9Hi+IjvXzaqZXezwyEZ82aOHfdrol8UVCuhvvz1lEiMd/mluRk474JWWYyzm/t+JidB+RS7uo4x76TPj0sB6wnmcUocz8q2CQDRuBiA9+cJf9bYFYtI5HrEL+dPO/nvMeXd87rqV0LsuKPsHMXKDU5LQo6VBn/3A7TI2M=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by KL1PR0302MB5428.apcprd03.prod.outlook.com (2603:1096:820:45::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 01:26:41 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147%9]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 01:26:40 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH v4] mmc: mtk-sd: reduce CIT for better performance
Thread-Topic: [PATCH v4] mmc: mtk-sd: reduce CIT for better performance
Thread-Index: AQHZl6dRPPunsFP83kqJ9kXlEUngRq98MjWAgADKXwA=
Date:   Tue, 6 Jun 2023 01:26:40 +0000
Message-ID: <09ae4155174ce8ffeef46b942542addeedbe761e.camel@mediatek.com>
References: <20230605121442.23622-1-wenbin.mei@mediatek.com>
         <2ef5a7e5-3772-f7ed-9aad-f51c53a7a24b@collabora.com>
In-Reply-To: <2ef5a7e5-3772-f7ed-9aad-f51c53a7a24b@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|KL1PR0302MB5428:EE_
x-ms-office365-filtering-correlation-id: 8e76e021-097c-44c0-a7e1-08db662d14a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ixiFcyfKQemhaYEoLAR7Y0bRlcrsVMgYAQ7v43Zw/Zb2v4uVWXp6F8UTNR9Ag9isE4EN10Jjpaw1B8pXNbMQHz8uTinXb/TLNApTjGlwZ20+0ycSkyyKlKUVAqeo+nv2Hjkvq7nnUjomhq5gWBZrKit4SefqeHOnVhbhJf0DnQPmMQncteF4YRrUfwIRnTgQu/N5cM80izhfqw9fgf/FZrVuGWx74595FZydqzDYI7wia555Rqsg5V7i5tQPhvDiMLjzI4Gkh7M7jPFV/+79Fr2+tBB5LYjvDFMFdzczcstIGgPwN186ebyA5dy6djJELBW1vC0IDOQ2f2r5uSVPF2pb8nFGozX4OniM49m+hdZH5JbCXRwesGYtr7igBUJ+YriYRIcHRAuy3Epq7+/raRLhVWrv5MRIoVn6jZKUtZtPQi58JefyI1uzZrgNG+Lc1ebLAHqnJ6hrODfFwOK9KpZFNPsAzV6DPytRG3u5KxvrY2+SGu8WopmMBnghpEXXv+fVOopKbPXlpq4nE2SZrI0IjxITH9c8lkaeai76Ih0EJ8Vlh9RnbS7xUuaTV1FJHy0FpuEa0V7seRxlFYtpycflm052uCGaFxLtl9ZyeqY6gDbHaIGrE8g31GJ3ZgpB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(85182001)(36756003)(38070700005)(2906002)(86362001)(5660300002)(7416002)(71200400001)(83380400001)(6486002)(186003)(6512007)(26005)(6506007)(478600001)(110136005)(54906003)(91956017)(38100700002)(64756008)(66946007)(316002)(122000001)(66446008)(41300700001)(4326008)(2616005)(66556008)(76116006)(66476007)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1FPV2xYSkRoOEJ6dHI3TGsvb1haNUx2NzI4ZFZaNDVCN3Exb2pRdXJqT0lX?=
 =?utf-8?B?a2pYWlBGOEZBajhHbnF1WVE5Q3daS2t2Z1BXazNuSWptc2MvVmhpNVUxNExU?=
 =?utf-8?B?ZWNlaUtFLzZYMkR3czdaL0dLRDF3T2pEdzBXOWgrNnVWL1RVZE9NZlNUNHZx?=
 =?utf-8?B?UHhoeFJRR016TGl6NFpoSWhTbld2Mnl6VFNJNmZTMUVKeFdYbGhtNmtpY3hw?=
 =?utf-8?B?MzJqZ0gwNm1zZXZVTmZ2WExRNjBoZUVyUksvbnVXcEM4elZPV04vTCtUNm5r?=
 =?utf-8?B?REZuT2RYdTRyWXZpT29GOHlBRVR4d2xwYWJ0cWNBRzhqN3hmNy8vOXlSb0xY?=
 =?utf-8?B?dzJnNVdtR2VVVWhYa3VqWjhHdG9OWk9IbUJlWk51WHlMcURmMTkvVm9tMHQw?=
 =?utf-8?B?aTkyMXdXTDVKOHZXWXY2NkI0cmJ1UzVIYTRoeS9iQlcwUVFzYjBwT2s2cGJX?=
 =?utf-8?B?S1dzUUVQNlU1UlhtU01lR2lOSyt5Unk2UEVBOTREa01HaDBUMzZiYzZqVEht?=
 =?utf-8?B?SUFwU3VTcE9kT2V3ayt2ajRHZjQyajVZdWI2NGIrVVdHOVJSeGcvMGNjUVRX?=
 =?utf-8?B?VXpCamJPZThzS1VmUXZEVElaSmJ0YmxuY053UVB1TVFsdytDS25OQk5Obmlx?=
 =?utf-8?B?cUMwdk1iaEcxSHBBeDVwelorUXVuWlZ3WWx5WGgydGhURXV1cWt1b2YxeS9w?=
 =?utf-8?B?WURlaVcrbTNGT0dVV2xiV2k5bGpXOEdhTlJldEJEQXN5aWFOMGx4ZlBiSW9J?=
 =?utf-8?B?eWh6NmpPNkxaamV6QnBxdVZXalR5M2xpTTVUTHFubG42OWJWN2pCWWZuSlBD?=
 =?utf-8?B?OVBkYUVrQ2QvbUNCOEQ5NkkxNkk0SUEyZVNBSm1jdXFHYnlHRi9jZk52Qlp5?=
 =?utf-8?B?cXdncnBiNk4yQmJxZmlmV3pJYW1ZNnJtbjc2QVE0amZsUE1pYytkdTZwRUVw?=
 =?utf-8?B?VE5GZlpDbnRzbUxySVAyZFU0MDZtU1V3YWtoU21xSTF1aVFBREFHd3lBL2dL?=
 =?utf-8?B?RmlKalY2ckdMUmNHbjI1RHR2SWlFbDFzYnFQRlptZThLUCt4bThFcmlabXFJ?=
 =?utf-8?B?RFFUL1VxdGtsdjlvVlV4dlVsTUwybHAzcXZ5RWo3QmEwQmpUbFBLNXJUTjJW?=
 =?utf-8?B?VWFYVUlaVWkwRER2aFZtMVUxR09GbHZFSzhDSlJaMGZ1UCt2TTI2TkJ2VGx5?=
 =?utf-8?B?V2xWa2RIUGJyTnk3UDN2azRwQjNvRHVmY2hBOTRkMFBtaVhVbGwwZ0Fya0w1?=
 =?utf-8?B?VlluNDBUaGJ3WTdoTUdBZGVFRk4wYy9EUk5lQzY4V2NMYU1PZ05IWmg5eVFt?=
 =?utf-8?B?eTVlRmQvWkZocEF3Mm9BRDRxZWUvaW8wSlFEbnVWaTZmTFJUOHlNYVVMS09I?=
 =?utf-8?B?bDZzTzk1b3lSbnFYeEtpaU1tVGl5OGlLQXFZSmFlVnB1SHlhZ0tud3ZkZHI0?=
 =?utf-8?B?QUY3cUh2cTlKdVVnV3hvWlhkUC8wZDlzR3ZIeGdOZ0tQdWpCQmtKY0dHSVAz?=
 =?utf-8?B?eldQSEo2MlMyaGdFWTQzbkIvWlJYSGFBSm5uUjVKQk5aOEZKMktTdnhnbHZJ?=
 =?utf-8?B?dDdJN29PaThCRzB2M3VqcURxYWxad1UxemRWSGQ1c29CQ2ZaYTQ4UUo1YVVu?=
 =?utf-8?B?Y3lHcC9MMzZ0bkFVa2xVWkROcjNxd2pNQjNTYUgxc1NaUmNtSFVFeXY2TVBk?=
 =?utf-8?B?bFFqYWxtMk93N3pDRmJDR2xIVS9EUENsWUk4ZlFCWURudGN0N0tYTHp5cVFV?=
 =?utf-8?B?S0RTVHQ4YzhZaDlBbVY2NXJRMTZQU0prN1RLWFJMQktDVnl5Ukw3Z0x0TGhX?=
 =?utf-8?B?RERzSWp1TmRHTnJVZWk5aEFINVZBOG80MzlxdkM1RHYyekh4T2pYcUVCbTEv?=
 =?utf-8?B?amZUWEVmditIbGN2Z3A0R3dWb0lJRGJWOElwWDFkbnJTMEhmT3lBZklhb21E?=
 =?utf-8?B?UFppTlpmWXhCbWU5eEhKMkgyakxZcDkyTTRMZCtONUZ0Q0FzYm5VMmxQU2o1?=
 =?utf-8?B?S1UxTEcrdU5oSmMvbEdZNU1nb3JxK2pXSmlCSXRuWkFYNmdIRHNLa2hIMGhJ?=
 =?utf-8?B?T0RvYWc0c0NUN3ArMlpGMHBYcnhmSGwxVTF4ZmNmekVsUFoyc2FDbTdBZHdU?=
 =?utf-8?B?L2FNYlF4L0NtMW5pZ3RqK0o5UHp4d3RETGFXY3ZrWkh5c3dIeXlxc1RveWFK?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <359CAE399F541A478C8BCDBA1750A108@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e76e021-097c-44c0-a7e1-08db662d14a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 01:26:40.8883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/YMWdUeiImYD04+8yZBVqMbSuyLXaVxIhTbOIWMo3KdIX5/eyvWVgv8OjK5HuIrlKrVI/tqFaBnJdb88OaIRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5428
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTA1IGF0IDE1OjIyICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBJbCAwNS8wNi8yMyAxNDoxNCwgV2VuYmluIE1l
aSBoYSBzY3JpdHRvOg0KPiA+IENRSENJX1NTQzEgaW5kaWNhdGVzIHRvIENRRSB0aGUgcG9sbGlu
ZyBwZXJpb2QgdG8gdXNlIHdoZW4gdXNpbmcNCj4gcGVyaW9kaWMNCj4gPiBTRU5EX1FVRVVFX1NU
QVRVUyhDTUQxMykgcG9sbGluZy4NCj4gPiBTaW5jZSBNU0RDIENRRSB1c2VzIG1zZGNfaGNsayBh
cyBJVENGVkFMLCBzbyBkcml2ZXIgc2hvdWxkIHVzZSBoY2xrDQo+ID4gZnJlcXVlbmN5IHRvIGdl
dCB0aGUgYWN0dWFsIHRpbWUuDQo+ID4gVGhlIGRlZmF1bHQgdmFsdWUgMHgxMDAwIHRoYXQgY29y
cmVzcG9uZHMgdG8gMTUwdXMgZm9yIE1lZGlhVGVrDQo+IFNvQ3MsIGxldCdzDQo+ID4gZGVjcmVh
c2UgaXQgdG8gMHg0MCB0aGF0IGNvcnJlc3BvbmRzIHRvIDIuMzV1cywgd2hpY2ggY2FuIGltcHJv
dmUNCj4gdGhlDQo+ID4gcGVyZm9ybWFuY2Ugb2Ygc29tZSBlTU1DIGRldmljZXMuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogV2VuYmluIE1laSA8d2VuYmluLm1laUBtZWRpYXRlay5jb20+DQo+
IA0KPiBZb3UgaGF2ZW4ndCBhZGRyZXNzZWQgYWxsIG15IGNvbW1lbnRzLiBJcyB0aGVyZSBhbnkg
cmVhc29uIGZvciB0aGF0Pw0KPiANClNvcnJ5IGZvciB0aGUgdHJvdWJsZS4NCg0KUmVwbHkgdG8g
eW91ciBwcmV2aW91cyBjb21tZW50IGhlcmU6DQptc2RjX2hjbGsgY2xvY2sgaXMgY3JpdGljYWwg
Zm9yIE1TREMgQ1FFLCBpZiBtc2RjX2hjbGsgaXMgbm90IHByZXNlbnQsDQppdCB3aWxsIG5vdCBn
byBoZXJlLCBiZWNhdXNlIGl0IHdpbGwgcmV0dXJuIGVhcmxpZXIgYXMNCmJlbG93KG1zZGNfZHJ2
X3Byb2JlKCkgZnVuY3Rpb24pOg0KLi4uDQpyZXQgPSBtc2RjX29mX2Nsb2NrX3BhcnNlKHBkZXYs
IGhvc3QpOwkvLyBoY2xrIG5vdCBwcmVzZW50LCByZXR1cm4gZXJyDQppZiAocmV0KQ0KICAgCWdv
dG8gaG9zdF9mcmVlOwkJCQ0KLi4uDQppZiAobW1jLT5jYXBzMiAmIE1NQ19DQVBTX0NRRSkgew0K
CS4uLg0KCW1zZGNfY3FlX2NpdF9jYWwoaG9zdCwgMjM1MCk7DQp9DQpzbyBJIHJlbW92ZSB0aGUg
ZWxzZSBjYXNlIGZvciBtc2RjX2NxZV9jaXRfY2FsKCkgZnVuY3Rpb24uDQoNCkFueSBxdWVzdGlv
bnMgcGxlYXNlIGZyZWUgdG8gdGFsayBhbmQgbWFueSB0aGFua3MuDQoNCkJlZ2FyZHMsDQpXZW5i
aW4NCj4gUmVnYXJkcywNCj4gQW5nZWxvDQo+IA0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9tbWMv
aG9zdC9jcWhjaS5oICB8ICAxICsNCj4gPiAgIGRyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgfCA0
NQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDIgZmls
ZXMgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21tYy9ob3N0L2NxaGNpLmggYi9kcml2ZXJzL21tYy9ob3N0L2NxaGNpLmgNCj4gPiBpbmRl
eCBiYTkzODdlZDkwZWIuLjI5MmI4OWViZDk3OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21t
Yy9ob3N0L2NxaGNpLmgNCj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L2NxaGNpLmgNCj4gPiBA
QCAtMjMsNiArMjMsNyBAQA0KPiA+ICAgLyogY2FwYWJpbGl0aWVzICovDQo+ID4gICAjZGVmaW5l
IENRSENJX0NBUDB4MDQNCj4gPiAgICNkZWZpbmUgQ1FIQ0lfQ0FQX0NTMHgxMDAwMDAwMCAvKiBD
cnlwdG8gU3VwcG9ydCAqLw0KPiA+ICsjZGVmaW5lIENRSENJX0NBUF9JVENGTVVMKHgpKCgoeCkg
JiBHRU5NQVNLKDE1LCAxMikpID4+IDEyKQ0KPiA+ICAgDQo+ID4gICAvKiBjb25maWd1cmF0aW9u
ICovDQo+ID4gICAjZGVmaW5lIENRSENJX0NGRzB4MDgNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvaG9zdC9tdGstc2QuYyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gPiBpbmRl
eCBlZGFkZTBlNTRhMGMuLjlmNTQwOTczY2FmZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21t
Yy9ob3N0L210ay1zZC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+
IEBAIC00NzMsNiArNDczLDcgQEAgc3RydWN0IG1zZGNfaG9zdCB7DQo+ID4gICBzdHJ1Y3QgbXNk
Y190dW5lX3BhcmEgZGVmX3R1bmVfcGFyYTsgLyogZGVmYXVsdCB0dW5lIHNldHRpbmcgKi8NCj4g
PiAgIHN0cnVjdCBtc2RjX3R1bmVfcGFyYSBzYXZlZF90dW5lX3BhcmE7IC8qIHR1bmUgcmVzdWx0
IG9mDQo+IENNRDIxL0NNRDE5ICovDQo+ID4gICBzdHJ1Y3QgY3FoY2lfaG9zdCAqY3FfaG9zdDsN
Cj4gPiArdTMyIGNxX3NzYzFfdGltZTsNCj4gPiAgIH07DQo+ID4gICANCj4gPiAgIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgbXRrX21tY19jb21wYXRpYmxlIG10MjcwMV9jb21wYXQgPSB7DQo+ID4gQEAg
LTI0NTAsOSArMjQ1MSw0OCBAQCBzdGF0aWMgdm9pZA0KPiBtc2RjX2hzNDAwX2VuaGFuY2VkX3N0
cm9iZShzdHJ1Y3QgbW1jX2hvc3QgKm1tYywNCj4gPiAgIH0NCj4gPiAgIH0NCj4gPiAgIA0KPiA+
ICtzdGF0aWMgdm9pZCBtc2RjX2NxZV9jaXRfY2FsKHN0cnVjdCBtc2RjX2hvc3QgKmhvc3QsIHU2
NCB0aW1lcl9ucykNCj4gPiArew0KPiA+ICtzdHJ1Y3QgbW1jX2hvc3QgKm1tYyA9IG1tY19mcm9t
X3ByaXYoaG9zdCk7DQo+ID4gK3N0cnVjdCBjcWhjaV9ob3N0ICpjcV9ob3N0ID0gbW1jLT5jcWVf
cHJpdmF0ZTsNCj4gPiArdTggaXRjZm11bDsNCj4gPiArdTY0IGhjbGtfZnJlcTsNCj4gPiArdTY0
IHZhbHVlOw0KPiA+ICsNCj4gPiArLyogU2luY2UgTVNEQyBDUUUgdXNlcyBtc2RjX2hjbGsgYXMg
SVRDRlZBTCwgc28gZHJpdmVyIHNob3VsZCB1c2UNCj4gaGNsaw0KPiA+ICsgKiBmcmVxdWVuY3kg
dG8gZ2V0IHRoZSBhY3R1YWwgdGltZSBmb3IgQ0lULg0KPiA+ICsgKi8NCj4gPiAraGNsa19mcmVx
ID0gY2xrX2dldF9yYXRlKGhvc3QtPmhfY2xrKTsNCj4gPiAraXRjZm11bCA9IENRSENJX0NBUF9J
VENGTVVMKGNxaGNpX3JlYWRsKGNxX2hvc3QsIENRSENJX0NBUCkpOw0KPiA+ICtzd2l0Y2ggKGl0
Y2ZtdWwpIHsNCj4gPiArY2FzZSAweDA6DQo+ID4gK2RvX2RpdihoY2xrX2ZyZXEsIDEwMDApOw0K
PiA+ICticmVhazsNCj4gPiArY2FzZSAweDE6DQo+ID4gK2RvX2RpdihoY2xrX2ZyZXEsIDEwMCk7
DQo+ID4gK2JyZWFrOw0KPiA+ICtjYXNlIDB4MjoNCj4gPiArZG9fZGl2KGhjbGtfZnJlcSwgMTAp
Ow0KPiA+ICticmVhazsNCj4gPiArY2FzZSAweDM6DQo+ID4gK2JyZWFrOw0KPiA+ICtjYXNlIDB4
NDoNCj4gPiAraGNsa19mcmVxID0gaGNsa19mcmVxICogMTA7DQo+ID4gK2JyZWFrOw0KPiA+ICtk
ZWZhdWx0Og0KPiA+ICtob3N0LT5jcV9zc2MxX3RpbWUgPSAweDQwOw0KPiA+ICtyZXR1cm47DQo+
ID4gK30NCj4gPiArDQo+ID4gK3ZhbHVlID0gaGNsa19mcmVxICogdGltZXJfbnM7DQo+ID4gK2Rv
X2Rpdih2YWx1ZSwgMTAwMDAwMDAwMCk7DQo+ID4gK2hvc3QtPmNxX3NzYzFfdGltZSA9IHZhbHVl
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIHZvaWQgbXNkY19jcWVfZW5hYmxlKHN0cnVj
dCBtbWNfaG9zdCAqbW1jKQ0KPiA+ICAgew0KPiA+ICAgc3RydWN0IG1zZGNfaG9zdCAqaG9zdCA9
IG1tY19wcml2KG1tYyk7DQo+ID4gK3N0cnVjdCBjcWhjaV9ob3N0ICpjcV9ob3N0ID0gbW1jLT5j
cWVfcHJpdmF0ZTsNCj4gPiAgIA0KPiA+ICAgLyogZW5hYmxlIGNtZHEgaXJxICovDQo+ID4gICB3
cml0ZWwoTVNEQ19JTlRfQ01EUSwgaG9zdC0+YmFzZSArIE1TRENfSU5URU4pOw0KPiA+IEBAIC0y
NDYyLDYgKzI1MDIsOSBAQCBzdGF0aWMgdm9pZCBtc2RjX2NxZV9lbmFibGUoc3RydWN0IG1tY19o
b3N0DQo+ICptbWMpDQo+ID4gICBtc2RjX3NldF9idXN5X3RpbWVvdXQoaG9zdCwgMjAgKiAxMDAw
MDAwMDAwVUxMLCAwKTsNCj4gPiAgIC8qIGRlZmF1bHQgcmVhZCBkYXRhIHRpbWVvdXQgMXMgKi8N
Cj4gPiAgIG1zZGNfc2V0X3RpbWVvdXQoaG9zdCwgMTAwMDAwMDAwMFVMTCwgMCk7DQo+ID4gKw0K
PiA+ICsvKiBTZXQgdGhlIHNlbmQgc3RhdHVzIGNvbW1hbmQgaWRsZSB0aW1lciAqLw0KPiA+ICtj
cWhjaV93cml0ZWwoY3FfaG9zdCwgaG9zdC0+Y3Ffc3NjMV90aW1lLCBDUUhDSV9TU0MxKTsNCj4g
PiAgIH0NCj4gPiAgIA0KPiA+ICAgc3RhdGljIHZvaWQgbXNkY19jcWVfZGlzYWJsZShzdHJ1Y3Qg
bW1jX2hvc3QgKm1tYywgYm9vbCByZWNvdmVyeSkNCj4gPiBAQCAtMjgwMyw2ICsyODQ2LDggQEAg
c3RhdGljIGludCBtc2RjX2Rydl9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiA+ICAgLyogY3FoY2kgMTZiaXQgbGVuZ3RoICovDQo+ID4gICAvKiAwIHNpemUsIG1lYW5z
IDY1NTM2IHNvIHdlIGRvbid0IGhhdmUgdG8gLTEgaGVyZSAqLw0KPiA+ICAgbW1jLT5tYXhfc2Vn
X3NpemUgPSA2NCAqIDEwMjQ7DQo+ID4gKy8qIFJlZHVjZSBDSVQgdG8gMHg0MCB0aGF0IGNvcnJl
c3BvbmRzIHRvIDIuMzV1cyAqLw0KPiA+ICttc2RjX2NxZV9jaXRfY2FsKGhvc3QsIDIzNTApOw0K
PiA+ICAgfQ0KPiA+ICAgDQo+ID4gICByZXQgPSBkZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYs
IGhvc3QtPmlycSwgbXNkY19pcnEsDQo+IA0K
