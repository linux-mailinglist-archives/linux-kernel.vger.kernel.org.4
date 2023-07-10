Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC7974CC89
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjGJGAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjGJGA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:00:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C3FFB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:00:23 -0700 (PDT)
X-UUID: 0df3ed701ee711ee9cb5633481061a41-20230710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8zVyHZ3kkfcbbC9RroWaUGzCbU0+4Oe9M/CuExucebo=;
        b=Bawndm9+mb4rb/v8urjBiSymFmerkWZt2kkS9/U14yUe6L74uFLLoUwbQRHfMUJbgpRnGa0XowzZS+q6gjBmOmLw7uC5/nkjkTjGHlRSxFriJ+XcPEbieO8e582g9grSjHhtjbe2MDrqWFFXy2oQWZRhWFBaeCrNXp5fMhSBiPA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:10c77ada-8501-4a3b-9f2c-d81899906ea9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.27,REQID:10c77ada-8501-4a3b-9f2c-d81899906ea9,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:01c9525,CLOUDID:08420c68-314d-4083-81b6-6a74159151eb,B
        ulkID:2307071945064NACNQMP,BulkQuantity:7,Recheck:0,SF:29|28|17|19|48|102,
        TC:nil,Content:1,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 0df3ed701ee711ee9cb5633481061a41-20230710
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <chunhui.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1152231595; Mon, 10 Jul 2023 14:00:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 10 Jul 2023 14:00:20 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 10 Jul 2023 14:00:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a93VLv619LbTAzqFdiFaQe/5sIZXgiBye7xr0MHDY/i+35wZ8PkHPs0sGW+0Ng/RZXc+HvhuJwAgntkg0IYSSB0z3zDgsxantTpLsgeCssb4DcCocKo2QgVFy9zoqQhK1mHL7DyL54eaFp8n4rNYmTdsJHXptuOpWlsCYOoakIIU8BRb/mCVHWiPAnDAeArqTk66DKDe3ZFZmuOzUudehrU5Yqd3/a0G9OrNKC+U+IkOQzRM8te5yYLmhNdt0DgftUTNMzZWV5nBNLz8uujoxCV9W7AhUXXncTI7/RV1URxBsHANpae85UiR3G7jNfL6d+WQvq9x0WDuWzm80u14pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zVyHZ3kkfcbbC9RroWaUGzCbU0+4Oe9M/CuExucebo=;
 b=FVaM/+fwOnmlFn7UVX2htkazJBMpa1JGvcLbwuM5O1GB1JvPLA52Bby/AQnqSCdq26A8kBanbiBIxFTUkEbAclOQJSmnAIoBOA5m58YXCCKkC0vx+HJ/zUPdcnJff2PCn/NwwBl73bDVEzHSfz6mQG/9R5fZC1BBjIUiP4d3RUl27tVd2PLSE4Xu7CPTkfLbEYOVz5GI1ddw2Wif6I38Ps9xgOuUrHHRCyEF0Up1QRyYVDYxHBgvKDulIr8VIAsGaa64yTI6fm+FJ5rQKitKgSicKHOve/s6C14JysSklyJuMg0TY2KNoq7Iv+6zXfyLfMvNN8o+sEgz+YHBZQRuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zVyHZ3kkfcbbC9RroWaUGzCbU0+4Oe9M/CuExucebo=;
 b=eup6FW7DwEN5vVyf6itg/IxKKWiHUHYFO+9n0Xw2KogxaRm4qzk/Lg+KjGgPMdhqA5StV6PV9GHDmg+1ohxop4KGU5QJteVb7BIRFpbvxQXzVT1+ueDDcpu1LgmJqOcniYEPUaKQYexjPUtKkeQ0BtbBxVv6Ip6xdZoxtbz5FA0=
Received: from PSAPR03MB5528.apcprd03.prod.outlook.com (2603:1096:301:4f::5)
 by TYSPR03MB8047.apcprd03.prod.outlook.com (2603:1096:400:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 06:00:18 +0000
Received: from PSAPR03MB5528.apcprd03.prod.outlook.com
 ([fe80::1d10:57b1:1800:cd84]) by PSAPR03MB5528.apcprd03.prod.outlook.com
 ([fe80::1d10:57b1:1800:cd84%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 06:00:18 +0000
From:   =?utf-8?B?Q2h1bmh1aSBMaSAo5p2O5pil6L6JKQ==?= 
        <chunhui.li@mediatek.com>
To:     "maz@kernel.org" <maz@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?SGFua3MgQ2hlbiAo6Zmz5b2l5bu3KQ==?= 
        <Hanks.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        =?utf-8?B?Q2hlbmctWXVoIFd1ICjlkLPmlL/oq60p?= 
        <Cheng-Yuh.Wu@mediatek.com>
Subject: Re: [PATCH] irqchip/gic-v3: Workaround for GIC-700 erratum 2941627
Thread-Topic: [PATCH] irqchip/gic-v3: Workaround for GIC-700 erratum 2941627
Thread-Index: AQHZsMyUsn+UkcBx202tmPRCTRWnV6+xGuqAgAFmi4A=
Date:   Mon, 10 Jul 2023 06:00:17 +0000
Message-ID: <79a9ad046061512073525ef23e19c961ea5b33ef.camel@mediatek.com>
References: <ed3c5fe3f7ed42d58d98e77b3513d6eabf2ad6cd.camel@mediatek.com>
         <877cr98pia.wl-maz@kernel.org>
In-Reply-To: <877cr98pia.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5528:EE_|TYSPR03MB8047:EE_
x-ms-office365-filtering-correlation-id: ead45635-0f2b-4a90-daec-08db810aefe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j03K7rfLnURLZVf1Niml2nul+bQ1QDeeZlED1S6Jr1qMvy9PKnHu2nSEchIcI9aO+izQv7TREFJ/qCfFiYVkiVCqY+pbkkDBZKPeyLaYNdoTwb4bSEPyd8VppzDBrABDwZjNE4AjMCmNQtvKbrJSikXrlgnH/g6vyeodP7rPc9PlBsmsl8V98kBBt9B7Z/2heTsEUMWe85m/eYallXef7kZnel0ZUuBbUmW073iKEm1bwYPO9W7d5Sb312XZP117Axt3YC4PCs5dCd4r3Xug5QHKXTVLmkRnAFSvhM6IBZ8CIprytnXnQ3H+HFMEd4rfNKSvNnZFgNx8weM7GVOhGa6awoVWVnPpRSxCf2E9Y7OzCgIJUeScX/Jh3Ncitkty3PzNrB9AI1srcSoGOdlABaneB5vce8yoV+yGIvj+jWhj19ko4ii8OzAbQnWWCqApqwSwJWUqsrn50DlfbYnE3yfS33bDXC0iwzXnKse41NU9YspMppfWfvoSXKccpksQuKdcaUEyMMUAyfA2J9XB4CbJ9URz+6L8MCYCSfVD8iIK94qTdQ8kqg58rLuepTkfSwlH+QGw3K6g+IwIRvYxnUy4YPZ5ZqHoM0BW4o8yHEVerj4SnQZkpVDCbN/djgYkGfUfWMehduy1azscLzLvPzlmBqpIkDBhCj2HubZutbc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5528.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(71200400001)(6512007)(38100700002)(76116006)(66946007)(91956017)(2616005)(6486002)(478600001)(26005)(186003)(86362001)(6506007)(122000001)(36756003)(107886003)(54906003)(85182001)(41300700001)(38070700005)(83380400001)(316002)(4744005)(5660300002)(8676002)(8936002)(64756008)(6916009)(2906002)(4326008)(66476007)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0MrRlk3MFJUSG5TTVpBN2JzSkhlUE94emYxaFBlZHQzeDJlSWJDTTFqLzJr?=
 =?utf-8?B?c2I0SjVUQkpkb0hSVDlUL2t3bzIvZDJmcC82QytaUm1xNSt5enJsVkt6R1BG?=
 =?utf-8?B?eUJBeEswQmpvY3FZQ0d5ajJKMG51OWlEeVlIaGRJalN4TDhyVjdJRXhsSEVJ?=
 =?utf-8?B?eWZhbHVzdStIVEtFaGNuUXo1dkNXYnVvVDJ6RHJFeFYzTWh6ZmphZWMxd1Rj?=
 =?utf-8?B?Y0ovMWY0ZUVqMnBoTXlBdDJpZDNsT3dZVmd2K2hLVVlYalBaWkZiZVR0NE9V?=
 =?utf-8?B?MURuTFlOQlExd3hham9wbFliOUVTQUtMRU5JNHFVUWJMMFZYSzJzQXNuWE5h?=
 =?utf-8?B?MDVPUWR4ejZiSS9odDRqQTF2aHAvVDhCYTczWWRtR2huWU1PL0FjSzdncVhN?=
 =?utf-8?B?ZFZHbjRibDMwUkVOeTVUSmVzZFYydDJCWFl1NTJ6cHRzUGhnUUlHNmFNMVBC?=
 =?utf-8?B?L0xwVWlHMFpuQUU3QkdibFRVeEpsOXdsOWlRcGk3SnNxSWUxQjBDS1hhWGN3?=
 =?utf-8?B?MzltTzVJckQ3eE1zSVFzdk1yU0RzaHI3QkgvMmVqWEFFb3RoMG5KQjNkbGds?=
 =?utf-8?B?a0thaXlIVERSWVdhU01vMFFPeWRuYW4xWTNxdTBhenQ0czhSYkx1VUd1UXdO?=
 =?utf-8?B?NXE1Y013NXk0UjN0aWxBdkJMREFDNDl5NG1YKysxQjhhYVhVZjUrdFJEcndH?=
 =?utf-8?B?UUV5Mld1a3NBRnpSbXovUk05RHNQSjdVLzk1V0hpWFE1QTVJdm56VmtLaUJP?=
 =?utf-8?B?ZzFXSFhMQnF0YXdzMkt4T2xwdTFHTFRWb1orQ29sNm8xcTlMV280NHBrTnc2?=
 =?utf-8?B?ZkkwZXpoYzdBR0tkTHl4ZjNpbUtSS0lxZkFTOGVkbzExWkRSWEtuWHFmRnZl?=
 =?utf-8?B?T2FhNzJJVW9HbU45RTFSWmR4SjRITDFuVVNYYWRBVEgwTmNRN2RjaEF4OEJp?=
 =?utf-8?B?VXB1dXJyMDNQZHQrMjN4R25PbmtZbWhPN1J1aEhUdHljbXN2Mm95dXJ6Sjdr?=
 =?utf-8?B?MENkaitkcmh0bXJjTEFXTHYrUDhkNks5Q3cyaGJ6VTMwMjBvbDlqejAyYlVF?=
 =?utf-8?B?NFRkUXljcldhSUtsUmpncWJ2dlZIK2laYXJyUVY4Q2huVk0zWTRjQjA3N3FS?=
 =?utf-8?B?V0FIbkd4eVNHcVRBMUpmOU1uZ0hpWTYwTWJTVkRHOVBtNXVQZ3ljZTgxMnN4?=
 =?utf-8?B?NmxMc3IvQ2xabnlrcWJqYWt6d25VK3V5Rm5vSzlzTEE1a0JiNEpqOXdickhm?=
 =?utf-8?B?V3hnNjczZTVIV1ZOMG9FcW9qTlN4bUttWTNPcElFVHA4eTR6ZXZITUJZd3JE?=
 =?utf-8?B?OEl5VlNZWEprem9PYUhlV3I4elQ4eUdwZGc1UFRleHgyeXRzSU5zcFJ4OG5o?=
 =?utf-8?B?VHNPSVdmeFpuNEhpS2V5UWxtaEFTYUNobmhtMXM2SEZEMkxYelBWUHovem01?=
 =?utf-8?B?WFNId29hNGpPOUc1M0tadEVVV1NaMmFYc2o4SUROeGVoNDRkYnYyWTdXdUVF?=
 =?utf-8?B?b2UveEQ4TDl6T3c5OTRPdmpERkVydzh6emE0YklKaWFYR0NMWStiMGo5dFBD?=
 =?utf-8?B?b3NpWC9hdHIzL1Q3Q1NJVVZVRS9kTkprS1B5UitXWDFWdC90Z1ZjeUF6a3VG?=
 =?utf-8?B?U296aWZVdTZnODdaSmtvV1BtRWRGQWJUWGVkNGpPd3FRSVg3d21UeTVOaDFR?=
 =?utf-8?B?SVRCZ1VjbzVmaUpYR1g0Z0dnL3BXQkliTHJIcGdSSVpIYWlGUzlUU0tFUG0y?=
 =?utf-8?B?R01BV25UeXR2VkJYRkFJUkdyQUcyR29BZ1ZkUlVIVWdLVTRodWF3OFhUZytD?=
 =?utf-8?B?UlFiYjhYMHlnVlF1Z0huN1pIa2MzM01nU1pyU2ZwQnhNZURFc3dQSVZOSG9W?=
 =?utf-8?B?SzFFMmJqWDhZaXVjUjVsZ2xyczBoUHlWVmZ4eFFtRnM4WGlveVhSNnBNczM2?=
 =?utf-8?B?SEZINFlaRnhXSThheHgyUVRJdXREM2UxNXJMWmZsdWJpVDRDWXNjOFBNcjdz?=
 =?utf-8?B?bFFmT3huNkdleTFlcmF2ZUZ0SDE3QSs0bjNSY2NGOUNCK0ZMNmx0a3NkaDVY?=
 =?utf-8?B?YnZNTXdOVXlIU0pTWHBjUlMwL1YwbEczbTI1dU1RTTE0U0FQV1BscVhwcTNn?=
 =?utf-8?B?aTgvT0Q4Mmp3bnVGZDQvTUlxeFFJWGFKeHAwckdhZFNCR0FSSXZWOWZ2YW16?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A770B9CF67AC2F408FBDDDE0AEBD6D25@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5528.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead45635-0f2b-4a90-daec-08db810aefe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 06:00:17.7040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L6ZSZxxf13V0W4IjlQgw3vyG75F789qJcgNBfk9ENfiXjExz+16wz7ZxkvaHxfyGi6W1Ne2Cwj2AJKPfu77lTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIzLTA3LTA5IGF0IDA5OjIwICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gRnJpLCAwNyBKdWwgMjAyMyAxMzoxNDozMCArMDEwMCwNCj4gIkNo
dW5odWkgTGkgKOadjuaYpei+iSkiIDxjaHVuaHVpLmxpQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+
ID4gDQo+ID4gVGVzdGVkLWJ5OiBDaHVuaHVpIExpIDxjaHVuaHVpLmxpQG1lZGlhdGVrLmNvbT4N
Cj4gDQo+IFlvdSBzZWVtIHRvIGhhdmUgdGVzdGVkIHRoZSBpbml0aWFsIHZlcnNpb24uIGJ1dCB0
aGVyZSdzIGEgdjIgYWxyZWFkeQ0KPiBwb3N0ZWQgYXMgYSByZXBseSB0byB0aGUgaW5pdGlhbCBv
bmUuIENhbiB5b3UgcGxlYXNlIGdpdmUgdGhhdCBvbmUgYQ0KPiBnbyBpbnN0ZWFkPw0KPiANCj4g
VGhhbmtzLA0KPiANCj4gTS4NCj4gDQo+IC0tIA0KPiBXaXRob3V0IGRldmlhdGlvbiBmcm9tIHRo
ZSBub3JtLCBwcm9ncmVzcyBpcyBub3QgcG9zc2libGUuDQoNCldlIGhhdmUgdGVzdGVkIHRoZSBQ
QVRDSCB2MiB3aXRoIE1USyBwbGF0Zm9ybSBiYXNlIG9uIGtlcm5lbC02LjEgYW5kDQpjYW4gY29u
ZmlybSB0aGF0IGl0IHdvcmtzIGFzIGV4cGVjdGVkLg0KDQpUaGFua3MNCkNodW5odWkNCg==
