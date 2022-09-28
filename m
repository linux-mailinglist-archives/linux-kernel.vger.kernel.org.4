Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4CB5EDDE0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiI1Njr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbiI1NjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:39:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E3AA6C47;
        Wed, 28 Sep 2022 06:38:56 -0700 (PDT)
X-UUID: 39c2525465d34bf8b6a840feb1379f8e-20220928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HfJOUeiIl67YQyQ8MLp6Zfp/I/7v8+eIJv+8UMQZxeg=;
        b=ZJUEns+HPctEmaI6q7ygjByJLb9wQMCDT8gw4JQ3oMYLdZ3pMPuuz9n8IVuwKyoJGY5E26P6tBE11iwDaBqEmRkAr34sxvP4PXTX1r4scK5TZRwxzEstAhEujSP+6IMEZxHHn8udB72gx566XbI4hypwhN/zsaBbXUMhSBfSdKI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:7062ed15-e784-40a9-a415-fb2dce4bf26a,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:a2ca87e4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 39c2525465d34bf8b6a840feb1379f8e-20220928
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 20874004; Wed, 28 Sep 2022 21:38:50 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 28 Sep 2022 21:38:49 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 28 Sep 2022 21:38:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYGMvMJYWh/hWdQyp62pNWSakFjLVwYYbq9No/tFafPAYPwES3KuoFSCP+iBcYuz12+UTubkWtDRAPLwS4a4zXyAJP86noUDfHwEPRQIroxrXU36tIOzriNstkGhVafFg1E/6AgKqMVflVWwnw237oroxv1IMcKMAwZBYoAwwxF6PRzBUIUeZqZ17IX3ToYS7tfd34f2pi5MzcAtOLMFGX6MoWcwYFBidss+CgmscpBnN5yxYo4KFeX64I0e9EC/RDyip09Uj4UVSFH96eAxmwdKSUKhuEZ6Pgvkeek38Z+MXDk33wUoTMEBIgSMzqrDTwnL5lYRZLd/FBJ0z8WHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfJOUeiIl67YQyQ8MLp6Zfp/I/7v8+eIJv+8UMQZxeg=;
 b=PttyQk2pAYQZonGX/udQ+dNySmdJmRNrK8TNJSmT2ml4wFEb/b0UtdQHOb+oR50mEzpjm6FkXdCEzyq1v9Gbg4boM7Q1sYbtNm6eP95ugOAD3ncw7HYQkmCNrdibiOwgvGO2cZMCqxAtxdGb9mr4CVkRwRE8uMcxGszIsi/RBJF5nPBlgpjI9n2fPDiAY34gLRUsY8CEOs7lcRsO+FIuCCAS7MNAmXBr1fjjcMoZfqUeujrjc7AoDbBAJ7MAzE9tyLAXMArry7zwOB6Vqg1E/9U92C7CE1p8w35PPWGSYbuJ+gDge3JtsOPawqb5aJvoSbUsiwF/25WHQO+ukCBChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfJOUeiIl67YQyQ8MLp6Zfp/I/7v8+eIJv+8UMQZxeg=;
 b=TbijmFAojzzA+eGUrZt2D1mEOBq/SOTO/PS85oJK/oDHEI1oMlaV1aXyNXelscc+NNISY5432ci8QOqjnFppQFCGIj2TOvDo8f/TBuHACyXxU2AHu5cYYfWP/r7fJ4vdEULbaB8k4iH5NVQdI3Nb+G7YAHIYXJU0oH5ZZorK+cQ=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SG2PR03MB3944.apcprd03.prod.outlook.com (2603:1096:4:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 13:38:47 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a%3]) with mapi id 15.20.5676.014; Wed, 28 Sep 2022
 13:38:47 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "acourbot@chromium.org" <acourbot@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TG9uZ2ZlaSBXYW5nICjnjovpvpnpo54p?= 
        <Longfei.Wang@mediatek.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] media: mediatek: vcodec: Skip unsupported h264 encoder
 profile
Thread-Topic: [PATCH] media: mediatek: vcodec: Skip unsupported h264 encoder
 profile
Thread-Index: AQHY0Yt9Vx/BZ8Cjp0GbfbzJYlR2y6303CuA
Date:   Wed, 28 Sep 2022 13:38:46 +0000
Message-ID: <e8bb661ec83129a1c660e876cb4fe9aaad41adfd.camel@mediatek.com>
References: <20220926093501.26466-1-irui.wang@mediatek.com>
In-Reply-To: <20220926093501.26466-1-irui.wang@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SG2PR03MB3944:EE_
x-ms-office365-filtering-correlation-id: 6087c73e-c63b-45cb-acbc-08daa156c4f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hsMjN2my3RIyklaAHK1T944KyCT9njzkXvVJjciCdDvTsUPouvjk95iXVMLCfkTkcptZkum/eA+hawufTBh+secpjl3A2DUSk/+nrmvxwSCkgQGaLsb5mtCJU5+ngn/2d6S+b2hhCN27MPvm90FjgcLnRmn2omtkkQRoGMPqFOy5g1dWVUpUhb023XPD2u5iCH1lzhNpTHyq7kRRprmCeTgxC6hfuozWnoL1YS3HUfUHczQYajTORjndEqSa4oU9lHO1z3VzS4dT80MpNza1hC63oVzN4NpPDztQ3da36Z0/li9riX+39r2m5asccAGZDrF3PLOGoAAsiKwFniChIKUiBRCwRZ23vIQCC3pg8NIMxXRJfisbW2YqBx3H/ImJNio12iLSxk7mwPx122PqgcmUVXIkan5zcmq672L3aOOPVgZ5fh6XLaCrDWI0U0RX0hz3tvKURfF/KcX2gI0ZZvgzllbTx8cjFo+WHH520F/TruDdRE8+F+/7w4yaws4/J4kEKuvcNxN+LFvEK3q1cmY48NrbekUKTGQHbYk1PANo0uumi0iueLNd7dPfYWlbZnjmiovkKbs37l0hQOzO5pjc//e8IwAWDwC4/7oe15Bxg4tbGae+o9EQ0zcUr403yGyz7ZAhJLXayI6cXFT2sblrrcRU0yQtyQNpKUkvVGW8OCwO1B6grtmE+yvyQHSpZjO/CfiSe403CXw2QNXspnE6I/NqZ38irKCl4ZqhksOFYTZSNc9jxChf10TS5jCzBNrFE4Ajwph5YLwuSAAiJ+IIKzAt2GJYc2N7q6pgNWb3wnkZ1aXwM2I9b+wdod6Tg+r+1+O7m2Z1+xqDNX1NxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(6486002)(66446008)(71200400001)(6506007)(6512007)(478600001)(26005)(76116006)(66556008)(7416002)(8936002)(2906002)(85182001)(64756008)(36756003)(41300700001)(86362001)(110136005)(91956017)(316002)(8676002)(66946007)(66476007)(5660300002)(54906003)(83380400001)(4326008)(38070700005)(921005)(122000001)(2616005)(38100700002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1hoSEMwM09ZQmtTVmpRQVFramd4S3RvdVdWOHNoRWp4d0FrbzRDTkJoNG5U?=
 =?utf-8?B?Z25PVmwxd2JsWUhCcVpWaTlLTStFYlRWNUplQWRvb29SWThiVUR3Y1MwRSsy?=
 =?utf-8?B?KzJ6NUV0STMwUjZ0Q2VsMWFQQmVPUTRsc3JWZGhIVjg3SEtHQUdvall2WHR2?=
 =?utf-8?B?a0hORzNDVGhtOFhRODUvSStoSnk2ZEdueU9wVHZSeVRrb1M0cHkwcjY4NWhz?=
 =?utf-8?B?V2kvQlQvQ25RdGN1VHZwWElKSkNjbW5tOENZOWJnOUZkTVZ1NUorenJCSTZn?=
 =?utf-8?B?aEJ6NWIwOWVLaGlaZUlmdnd2WUovSlFrUDhEMDNNdmxDRVo0OG5tK25TQm95?=
 =?utf-8?B?cmp4dEVIT0tpdmxNMG56dnMrQVBaeWp0ZjlQeGxNMWpZWFMzSXVEY290N3pI?=
 =?utf-8?B?L0V4Rys3S2JpeTdwajlHN083bzdCOXB1UkdQaE9ZdVRSZnFCTUxGY0gwd2tE?=
 =?utf-8?B?dHF3Z1ZUSDcwUGpCZnpLOTVZdVdSZFQ5eURibmg2LzhRQjUrRlZnN0gwa1dD?=
 =?utf-8?B?UmpOMGFuZ0pyZjVmcWpnb3BudHZickxTaTFQRUJvL2NyRXVQRzZoOTRsU3p4?=
 =?utf-8?B?YU40QnU5bkJlbFh5N0wwYnliS3hSRU8zOHFlZk0xM1dvWEt3MzVqK0plNjZi?=
 =?utf-8?B?dHZsdHBCSzJnNnNmOVYydHMzZk81dGpac2E2M0d5YVovcTJXc3VmZ2RaSmk5?=
 =?utf-8?B?TjU1ZTc3eVVBQnFnY1NHM2pnV0xFTHdVYW5zV0svYk80WFBNdmZCZWdzMlA4?=
 =?utf-8?B?YmVYb1o0elMxOFhuT1VIZGFWeVRkTmYyMFVxbU00N3JMRWx4dXluZzBxVU5P?=
 =?utf-8?B?OEJGWG9ISElCcUt6YUV5ZEZNSFV1SDlVdUpOM0xVUjkrQjJvblplS1dvaXR6?=
 =?utf-8?B?UHhKd1RTSVo4djBkdEltcXpLYmV1NDIrdXdiek5ZZk1vakgyRlVwdnRoUllE?=
 =?utf-8?B?eGZKU3VJWG9TU3dKRCtlZnFwUVFLWXJjSWRtV3E5K1hwdVp5RVloU2xBR2FU?=
 =?utf-8?B?WWxrRW1WZXl0KzZHRkIxSFV3b3VKWnNqd0Fsd3RZaXVxb3RXYmZGWUdIVzBk?=
 =?utf-8?B?RlZYSzU4RWh6cmZERlYreHdmVzlMdkRiSXp0dkJmSlcrQW1ObGhtU3ZZQ2hq?=
 =?utf-8?B?cTNhdFBZdFViUnhDcnRJeW13SjhSR3o0ZFc4elpoZ3F2ajFXS3I5UVBBUEZt?=
 =?utf-8?B?V25MY0V4MTFYSTdkRVh1cllYSmw5L3QyamcwYzU1SGhQNkZmbjF0TEkreU5F?=
 =?utf-8?B?bmxra0NzdjQrMGFtc1VrWms4aFJNdThzT2dzL2JvMTlnbml6RXZlZzAySmd5?=
 =?utf-8?B?bFpGU1ZldlVmSWpPSGdPeTZ5a3dPcVRSeWxxWENxbnUzQTAzenJoaVB3aFZY?=
 =?utf-8?B?SUVZTUVWOWduUnJoeEQyRDk4Uk4xUjhIUGVJNWc4ZU9OWWJBT29TS2RZZnMv?=
 =?utf-8?B?Mlo3MG9aanRlWU9uaC9HUEFCL3NobVNpejZnb1hEVGZINFd1OHkvYk1MY3N6?=
 =?utf-8?B?OG1NL1Q0K1BtSjBMTUxSakR6REdHbjVrTGNEcU1jSXdKZy9PNmlCanlEMURp?=
 =?utf-8?B?d1c0bU9MTlFhZEhBWk0ralVTU25NNERYTVpEZTVxM2I3R3VPRk1pc0c2M0JV?=
 =?utf-8?B?QlNWZ1dlV3RkRmFHdFgyLzlFM01rU3Y2NzBEQjJpZGExR2JCclRpS0RNenpk?=
 =?utf-8?B?NkJ3MzM5ZkRkNUtjaVRWc0JYVTA5cEd1cUhPR0NaS3lHWDR6SnJ1N3pIdUp3?=
 =?utf-8?B?Lyt6Z0tZcXluMEJyMGpyWXV6V3lkY3A2SkFSV1BUSnEyUFAyRzQvQ0szaXRq?=
 =?utf-8?B?RmFhd2RCdmhVbGxJdmgvUlo5Rmp1RmFlZnpnVUdNRERnMC9vSmpaQWhkcUFY?=
 =?utf-8?B?SWFISzlrYmFUVmZCM1kxOWlFdnNsUEwxd1N2N0FsN3NPVkVvd3p4SFdHeTNE?=
 =?utf-8?B?WHNRM3NqV3B5dEdmS2hGdTlqaW9NVHpscUxycFJzd05zZmhxVDNHTGwxUmMr?=
 =?utf-8?B?bUNjNzVDSC94bnJLRXdGS1FybEdqUDQyS0lPK3hJeU4vZjQ4VDVXVTNRRFZs?=
 =?utf-8?B?Y0IxdW5IaExOUDZnUzU4SVdXTzZlQWlYcnUyWEg1U2xIRkJIOTRTM2V3NThN?=
 =?utf-8?B?MHNldXF2MVJGVER3RW5Manp5MTVTVUdrODlnaU1VTmpzbHJKU0x3bHRudWRI?=
 =?utf-8?Q?B4vdOQcYmPJad9hGgGeISB0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <053D1976AC389F498C841D8B0EC66A76@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6087c73e-c63b-45cb-acbc-08daa156c4f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 13:38:46.9622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6I3e2EXZkeews4vRc3FyzOAQIVlI7GWrXKZQoeEkZ27sTCtU++KX8WRv8SeZLCRvhKxtORF2Oa1IPBNmWxv/fgDHgWyR8t3yNPgON0m+B5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB3944
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSXJ1aSwNCg0KVGVzdGVkLWJ5OiBBbGxlbi1LSCBDaGVuZyA8YWxsZW4ta2guY2hlbmdAbWVk
aWF0ZWsuY29tPg0KDQpUZXN0ZWQgZm9yIENUUyBjYXNlcyBvbiB0aGUgbXQ4MTg2IGNvcnNvbGEg
Ym9hcmQuDQoNClRoYW5rcywNCkFsbGVuDQoNCk9uIE1vbiwgMjAyMi0wOS0yNiBhdCAxNzozNSAr
MDgwMCwgSXJ1aSBXYW5nIHdyb3RlOg0KPiBUaGUgZW5jb2RlciBkcml2ZXIgc3VwcG9ydCBoMjY0
IGJhc2VsaW5lLCBtYWluLCBoaWdoIGVuY29kZXINCj4gcHJvZmlsZSwgc2V0IG1hc2sgZm9yIFY0
TDJfQ0lEX01QRUdfVklERU9fSDI2NF9QUk9GSUxFIHRvIHNraXANCj4gdGhlIHVuc3VwcG9ydGVk
IHByb2ZpbGUuDQo+IA0KPiBnZXQgc3VwcG9ydGVkIGgyNjRfcHJvZmlsZSBieSBjb21tYW5kOiB2
NGwyLWN0bCAtZCAvZGV2L3ZpZGVvWCAtTA0KPiBoMjY0X3Byb2ZpbGUgMHgwMDk5MGE2YiAobWVu
dSkgOiBtaW49MCBtYXg9NCBkZWZhdWx0PTQgdmFsdWU9NA0KPiAgICAgICAgIDA6IEJhc2VsaW5l
DQo+ICAgICAgICAgMjogTWFpbg0KPiAgICAgICAgIDQ6IEhpZ2gNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IElydWkgV2FuZyA8aXJ1aS53YW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2VuYy5jIHwgNSArKysr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210
a192Y29kZWNfZW5jLmMNCj4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2Rl
Yy9tdGtfdmNvZGVjX2VuYy5jDQo+IGluZGV4IGQ4MTBhNzhkZGU1MS4uZDY1ODAwYTNiODlkIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtf
dmNvZGVjX2VuYy5jDQo+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNv
ZGVjL210a192Y29kZWNfZW5jLmMNCj4gQEAgLTEzOTcsNyArMTM5NywxMCBAQCBpbnQgbXRrX3Zj
b2RlY19lbmNfY3RybHNfc2V0dXAoc3RydWN0DQo+IG10a192Y29kZWNfY3R4ICpjdHgpDQo+ICAJ
CQkwLCBWNEwyX01QRUdfVklERU9fSEVBREVSX01PREVfU0VQQVJBVEUpOw0KPiAgCXY0bDJfY3Ry
bF9uZXdfc3RkX21lbnUoaGFuZGxlciwgb3BzLA0KPiBWNEwyX0NJRF9NUEVHX1ZJREVPX0gyNjRf
UFJPRklMRSwNCj4gIAkJCVY0TDJfTVBFR19WSURFT19IMjY0X1BST0ZJTEVfSElHSCwNCj4gLQkJ
CTAsIFY0TDJfTVBFR19WSURFT19IMjY0X1BST0ZJTEVfSElHSCk7DQo+ICsJCQl+KCgxIDw8IFY0
TDJfTVBFR19WSURFT19IMjY0X1BST0ZJTEVfQkFTRUxJTkUpDQo+IHwNCj4gKwkJCSAgKDEgPDwg
VjRMMl9NUEVHX1ZJREVPX0gyNjRfUFJPRklMRV9NQUlOKSB8DQo+ICsJCQkgICgxIDw8IFY0TDJf
TVBFR19WSURFT19IMjY0X1BST0ZJTEVfSElHSCkpLA0KPiArCQkJVjRMMl9NUEVHX1ZJREVPX0gy
NjRfUFJPRklMRV9ISUdIKTsNCj4gIAl2NGwyX2N0cmxfbmV3X3N0ZF9tZW51KGhhbmRsZXIsIG9w
cywNCj4gVjRMMl9DSURfTVBFR19WSURFT19IMjY0X0xFVkVMLA0KPiAgCQkJICAgICAgIGgyNjRf
bWF4X2xldmVsLA0KPiAgCQkJICAgICAgIDAsIFY0TDJfTVBFR19WSURFT19IMjY0X0xFVkVMXzRf
MCk7DQo=
