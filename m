Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A0063755C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiKXJjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKXJjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:39:21 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F28C122954;
        Thu, 24 Nov 2022 01:39:15 -0800 (PST)
X-UUID: 0ce1da9d5d2449aba2cd10de6e80fc7e-20221124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WoqkKZ2MTvLNxGrLcXZHZ4Aae7OzYHZ3yHsAhirUUvk=;
        b=Kt3X/V6WSlbU+RgIc0SVuzVGh116hYSefhhS8700RIRtiqN6y8CC+rx9pCLMrZei0ulX3TO7TysLizcxgs6EGxmnExRMJ3teiRsRbsXqEwh9USq3nTIDig8QyEsDZHV11F2o4tJH4avbccqmH/b9DZ/3D/DeRTI6Jnx6vrQoFkM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:f8ac2dc8-6c32-427b-9fb9-474e101aef6d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:f8ac2dc8-6c32-427b-9fb9-474e101aef6d,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:e8c421dc-6ad4-42ff-91f3-18e0272db660,B
        ulkID:221124173913IMX5QHBV,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0ce1da9d5d2449aba2cd10de6e80fc7e-20221124
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <nancy.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1390792571; Thu, 24 Nov 2022 17:39:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 24 Nov 2022 17:39:10 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 24 Nov 2022 17:39:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjBSVjQJ6tljF7YEBFOOPGpNek152S8ihCpp5uHP6liIf4SusIDayMGySxpXKEy2kzEup4Mntgc1nRJws15TgkJss7IRtbhbrkyMTGxLPs7OJwzGYGaXmFNMISl2fZU4aSY9T2HMQWwTu5NJ+GxPbXSsi7yVlpm9msGGnVprgapadrKoVSTLqUQo1IjrVkooPsvINzuJhBCBHiPxJLJHxMxs/0lUU6jRuvXTd6ijau1cPS8slIsOi9B68X3kGKivkhm8IJUTf2u/kskXooRvGP8gX319jN3sAVSgjUUukHtgEAUlV5gM/xwtZkGjk06rWHeRaf/Ibugp44RntyzP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoqkKZ2MTvLNxGrLcXZHZ4Aae7OzYHZ3yHsAhirUUvk=;
 b=Nojyr7Fx/obJEQ3UxeqJlrrnIOjUz7/sgQG3j4sjvHT7NDx6cBhP7fAKVCnPvpxqRfB03dKDTV2ScEdE9hwXyfzWyQCrhTxcPrpwCCOPdGBuXDdi6Z7XtuLhUH0LBl3mcX8L7uRrT+eqSze/Y0H5427KY8iXRvVy9Eu92Uw1qASq7WsDPSiuG1Tq6nJQoQoa9c1LdgSmJoI81lyk0FrhzVZhw60EqwTscjGFsIC3/hW9+V2Pw0VLCPgyEUwfCAjAZ3OEWkAJde9dvyABXlMn6UJfEixv5Mrcr54HvwPuYd4zfFTFdrMRPgTEdeo0kRW9X3KlKUVXvyB1EzCMHmEsbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoqkKZ2MTvLNxGrLcXZHZ4Aae7OzYHZ3yHsAhirUUvk=;
 b=YoHGUTlbCmzt/nxQxKc7xMDGgYvl4hG2/DwoEqbG64GsBecbS6e6g49ao8k8r7fuPxj8DXUW8nHY6XPDBeCw5l2ZWyTwv95/rE4D2ghcCbdyqiqNCL6fxnhuuk+P0LBnOn8a2XKDDc5sereVXR8lNzV28/UWhUNo/wmN1pkpbbc=
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com (2603:1096:820:8::11)
 by PSAPR03MB5319.apcprd03.prod.outlook.com (2603:1096:301:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Thu, 24 Nov
 2022 09:38:03 +0000
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::9386:8c80:d06e:1c5b]) by KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::9386:8c80:d06e:1c5b%5]) with mapi id 15.20.5857.017; Thu, 24 Nov 2022
 09:38:03 +0000
From:   =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v28 05/11] soc: mediatek: refine code to use
 mtk_mmsys_update_bits API
Thread-Topic: [PATCH v28 05/11] soc: mediatek: refine code to use
 mtk_mmsys_update_bits API
Thread-Index: AQHY8nnThJFnySWTO0qldYSJ6lapG641TIyAgAAjWoCAArcwgIAVxNmA
Date:   Thu, 24 Nov 2022 09:38:02 +0000
Message-ID: <f726657c3d2b16ed18e9d24a69b736970c0cf316.camel@mediatek.com>
References: <20221107072243.15748-1-nancy.lin@mediatek.com>
         <20221107072243.15748-6-nancy.lin@mediatek.com>
         <58d55016-afc7-e560-32cf-8228794b5752@gmail.com>
         <20221108194351.u63k4mqzq3bkhpl7@notapiano>
         <aa7cab9c-8fe2-b42e-84ba-1aeb79d50190@gmail.com>
In-Reply-To: <aa7cab9c-8fe2-b42e-84ba-1aeb79d50190@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5175:EE_|PSAPR03MB5319:EE_
x-ms-office365-filtering-correlation-id: fb40864c-1bb6-40d4-9740-08dacdff956d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ipdxtKj3ZEvTxETDh0wgB4+voQqQbYE9YEVQ+DKfm41Ky5xfr5Ij65WIAYwhFWvRi/mO64hohKtK73Ce8weVuNN8bPwKHoiXF9yF4L94K/PAe45HNuUHjTTib5wAQcEM/gLDpMSMF1x/7GNRW98bjLhHfoZR+4+AgWXu+o8MA8bQtFDKsbWpjxmxVbkm95OQl6NYMSfmNPZs2rYw4ysXJdftFjZQpj4eHGHg4Zd9lo1hPMTUJeSwP1/4eRF80dkUl7lUuemtowqEXwleSbK/uX5t90RzQqRQysytiC81C7z0d2eyLZvkGfCzCDc8ln7MRW98zWLYUsJ4RH8IJIsSkp66mFvShlL2BYv6GVMx0C6Ajuli1a7IU+8jbxLQeezn30eWOOSOAOzIPK+aJSe75lf8wKrLFSK2YaM8kNeNwJs4mv94BMMnamd04HlOeLesWnsCFsy0ARvXMYR7awiV0hdorJyH/a+AWw+9qORlZT+/pDU+ktUL5PV8nRwk+jJC7YoelbP09ARKE+IbFPk9Kic/HiXJRFMTvLs1L8cfTbeyrjJ9+FTZhQ+qFhS6chFo+BmnJYzQ3b7VQp0lpR9Yg925TRFdIzgpwCDl0mdlsA+VZFEVhzS/hrG/LoTbpLLarKx2GKRN6f6VUp7QlhcPAXySL4eowcoLFId9ZGFaLy/XxyXftEQhEcpPxfHBgLHJ5jjfVPZuA+AUQ/RAoJhmWGk3yNuSlHVAaaBS6UByzMk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5175.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199015)(4001150100001)(83380400001)(2906002)(85182001)(36756003)(66446008)(2616005)(41300700001)(66476007)(66946007)(76116006)(186003)(66556008)(86362001)(53546011)(54906003)(6506007)(110136005)(122000001)(26005)(38100700002)(38070700005)(8676002)(5660300002)(7416002)(66574015)(4326008)(91956017)(64756008)(966005)(316002)(478600001)(8936002)(71200400001)(6486002)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWhtd2FQaWdXZWJnakEyajJiaDlVRU96TTZmK1h5UjRxOWRtT2lBZFFHZ2NX?=
 =?utf-8?B?dmJnZHpsQzgxZUJIWEhiMVhzWXg3M3VtSzNlNXd5Mm81cW1DOUNKSlhuVHFq?=
 =?utf-8?B?SW5NcGo1U0VEYkg0OXZQdjV3TUhSZVNOU2xXRFBhb0hKcVVkcTJnRDE0MVBX?=
 =?utf-8?B?M3dNend4MEpFVjdMUDZRazdMQTlzclBLTE81OWtXc25QbWU0bk9hcGczdXhs?=
 =?utf-8?B?YWNwWnNiVzAxSDd2Zi9MUnNDRXl0djV2a1dBUmFOVTFQNVNhR2RvK0RzVnBP?=
 =?utf-8?B?eFpQQzZkOTZtb2hMdDlOSDZ2SFBpdHpBdVh2Z05NRkJnSzNyTmUxVjdYS1Ir?=
 =?utf-8?B?OC8xZWlxa3kzQ2hZODU3QmFEc3ZvblYrcTJOamVRVVA1WlpVTDlIdTZnZHhj?=
 =?utf-8?B?UGdKL1JxbHo0anR6NjQ1RFhHcEQzWENvc2hLOExWRE5FTlM5endVbHFFcmRH?=
 =?utf-8?B?MzIyZzZCbkxaL29DWEUzcTVqbjAyL1lNeHpheWRxOGFvUWljZ0puOUJ6VjNw?=
 =?utf-8?B?UFJwZEhLQnpDa3dIMUJteTNrM0lmWmE5NjR5dXNNYWZzdnVUTE5TY241QVQw?=
 =?utf-8?B?NXJjMEpQcUlIQVFyR1g2R1JySUp5TGkyRUxuU0xzVk80WkVMNEt0TSswSWFP?=
 =?utf-8?B?dWl3cUU4ODlzbVhoYjNSUVRMZmVxMkx3cVpKU1ZNeGhEdmpuZVVqejk5Z3dO?=
 =?utf-8?B?c3BtNnRqV0FScGg4MzFIdjZkSEUxMlNSdzZLQnROTXM2Q0lvazZRSlVRZGtn?=
 =?utf-8?B?UWhmQ1dHOXJQVEI0dEVIMW1URmZqUlo0M2FseUJlMlRpSXdmYVA3S1ZQdXBv?=
 =?utf-8?B?SSs2YlVvOEd1TndXMmxBM2ZpNUEvbi9MNTJ2SkZ0WC9FOVJ5QzRTcnY0QU1o?=
 =?utf-8?B?eUlKbEhGRnJweFIySnh3NC8zWTFmQjQ1UjhaMzNLVGozNy9yQ3dtbGZlbjlj?=
 =?utf-8?B?WUpJVmlldkdyQ293TE02MGVUblhPTnV4bWZneHpTbU5mUlA0VG0wL0FLMHkr?=
 =?utf-8?B?QnZpMWZwRUhkSmFWZmE4UUdoYWhmaTBTVk1oT1RKRC9MRHJOMzdCQS9hbkUz?=
 =?utf-8?B?eE91STRNRHF5YklhaDF6ekJVaTVqUUpJWnRIT0VyMENrRVJVWUlDOW5oNFZa?=
 =?utf-8?B?WUwxMHdTNU9hS3dFRWR6d3FsVjlLS1hTTUJuWGRyeHowQlhXRnI5dUN4YlA5?=
 =?utf-8?B?MUNJa3dzQytvaHBkVDJnTFNoSjFxcW9ySTd1VVp6TEFhRjZqUVc2dUdMZGJn?=
 =?utf-8?B?Tngvblp3S3lKZDJLOXFqNGNadG5BOFJoSG83MHhZVlhTaFUyb2NhR2ppYXhv?=
 =?utf-8?B?RE1rWjFGVllPTGdkSTRybU9YcDNDSWhVUWpNbXF3RWh3RDNFTTh6SE4wSS9C?=
 =?utf-8?B?dGtua0RJRVN3K0tiYnBoeDhYVzRYUTBNbUJDdGduT1JYb2NNWUFyRWNQOUl2?=
 =?utf-8?B?TzMydWZ4QUJaOXo2NXFPRGJSSzBnaVhIOWRIVjlLQlZzNmNhTmR4cGlqRDIw?=
 =?utf-8?B?Y3gyK3N2bTY1bUtlbEpSREd0VzRJQW1hdGxyMzFUL0dLaTIwbUpGdHZndGEr?=
 =?utf-8?B?MmdyRW85Nkw1M05MaysyczFiVWZnb09UZnNrdnczUlVoaUs4QnIwSlRobm1p?=
 =?utf-8?B?bndESXAvam0vTmtTOXVaaDFwaVE2aTg2TWJuRElaeTNRM3RIU1krN2N3b2NJ?=
 =?utf-8?B?SHczQldzdm9ibm5ESVF1VnU2THpZU0V2akRxY3FKbC9oRGdHSmEyRks2RWhv?=
 =?utf-8?B?WWNJVUgrbzdzc1hjVWFnMGRiUTkrdG54Z2l0eVM5NWt6Z0lIZkRVMWxiZ1Bm?=
 =?utf-8?B?ZEU5QVRzdFFsaUppLy9UMmIxanpreEJwUEhNSmVTeEtJWEN6OUl3Mlk2WDc1?=
 =?utf-8?B?Tjhxa21ORzBrWXB6ZnJaTThMWXBhK3pEZURUZ1JoOUI0Nm5pcmZZTm5sTlBD?=
 =?utf-8?B?SmtZckVmQkVWaEhHbEd1TTJiamZyb25CcTl4eXo0QldXQ09rT241TlVNZE1Z?=
 =?utf-8?B?ZEtLb0pxVzV4OWV6djY2dy9OK09kQWx2SnlqbUdHWXdpbGVJc1cyOUVsaTFy?=
 =?utf-8?B?TXhHNWFHa1lZbEV1dllQbE9VSUZJK3htUi9BZGtoMkIvaFNrWTNXSHBJWG9B?=
 =?utf-8?B?eFNCeWNmcE9ZcmtZdUFFem9FdzRaVmFFd3JrNVhpTVBLZmxwV1R2NG1nR3BW?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <532BB0EE0E04BB4198C1D07BA547FF2F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5175.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb40864c-1bb6-40d4-9740-08dacdff956d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 09:38:03.3219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2m+sl3aiKUrLj0+wcD2DsDYIuR226hYtjUI7L57gwAM86SJ6f4Dty4KTZfbeFU/KHUmVIwPbCigQV5DtKi7vkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5319
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBNYXR0aGlhcywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpPbiBUaHUsIDIwMjIt
MTEtMTAgYXQgMTQ6MTIgKzAxMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+IA0KPiBPbiAw
OC8xMS8yMDIyIDIwOjQzLCBOw61jb2xhcyBGLiBSLiBBLiBQcmFkbyB3cm90ZToNCj4gPiBPbiBU
dWUsIE5vdiAwOCwgMjAyMiBhdCAwNjozNzoxOVBNICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdy
b3RlOg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IE9uIDA3LzExLzIwMjIgMDg6MjIsIE5hbmN5Lkxp
biB3cm90ZToNCj4gPiA+ID4gU2ltcGxpZnkgY29kZSBmb3IgdXBkYXRlICBtbXN5cyByZWcuDQo+
ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOYW5jeS5MaW4gPG5hbmN5LmxpbkBtZWRp
YXRlay5jb20+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdu
byA8DQo+ID4gPiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4g
PiA+ID4gUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQo+ID4gPiA+IFRl
c3RlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+ID4gPiBhbmdlbG9naW9h
Y2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gPiA+IFRlc3RlZC1ieTogQm8tQ2hl
biBDaGVuIDxyZXgtYmMuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBO
w61jb2xhcyBGLiBSLiBBLiBQcmFkbyA8bmZyYXByYWRvQGNvbGxhYm9yYS5jb20+DQo+ID4gPiA+
IC0tLQ0KPiA+ID4gPiAgICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstbW1zeXMuYyB8IDQ1ICsr
KysrKysrKysrKy0tLS0tLS0tDQo+ID4gPiA+IC0tLS0tLS0tLS0tLQ0KPiA+ID4gPiAgICAxIGZp
bGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0K
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmMNCj4g
PiA+ID4gYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstbW1zeXMuYw0KPiA+ID4gPiBpbmRleCA5
YTMyN2ViNWQ5ZDcuLjczYzhiZDI3ZTZhZSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLW1tc3lzLmMNCj4gPiA+ID4gQEAgLTk5LDIyICs5OSwyNyBAQCBzdHJ1Y3QgbXRrX21t
c3lzIHsNCj4gPiA+ID4gICAgCXN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiByY2RldjsNCj4g
PiA+ID4gICAgfTsNCj4gPiA+ID4gK3N0YXRpYyB2b2lkIG10a19tbXN5c191cGRhdGVfYml0cyhz
dHJ1Y3QgbXRrX21tc3lzICptbXN5cywgdTMyDQo+ID4gPiA+IG9mZnNldCwgdTMyIG1hc2ssIHUz
MiB2YWwpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsJdTMyIHRtcDsNCj4gPiA+ID4gKw0KPiA+ID4g
PiArCXRtcCA9IHJlYWRsX3JlbGF4ZWQobW1zeXMtPnJlZ3MgKyBvZmZzZXQpOw0KPiA+ID4gPiAr
CXRtcCA9ICh0bXAgJiB+bWFzaykgfCAodmFsICYgbWFzayk7DQo+ID4gPiANCj4gPiA+IEknbSBu
b3Qgc3VyZSBhYm91dCB0aGUgY2hhbmdlIGluIHRoZSBpbXBsZW1lbnRhdGlvbiBvZg0KPiA+ID4g
bXRrX21tc3lzX3VwZGF0ZV9iaXRzKCkuIE5pY29sYXMgdHJpZWQgdG8gZXhwbGFpbiBpdCB0byBt
ZSBvbiBJUkMNCj4gPiA+IGJ1dCBJDQo+ID4gPiB3YXNuJ3QgdG90YWxseSBjb252aW5jaW5nLiBB
cyB3ZSBoYXZlIHRvIGdvIGZvciBhdCBsZWFzdCBhbm90aGVyDQo+ID4gPiByb3VuZCBvZg0KPiA+
ID4gdGhpcyBwYXRjaGVzLCBJJ2QgbGlrZSB0byBnZXQgYSBjbGVhciB1bmRlcnN0YW5kaW5nIHdo
aWxlIGl0IGlzDQo+ID4gPiBuZWVkZWQgdGhhdA0KPiA+ID4gdmFsIGJpdHMgYXJlIHNldCB0byAx
IGluIHRoZSBtYXNrLg0KPiA+IA0KPiA+IFRoZSBwb2ludCBoZXJlIHdhcyB0byBtYWtlIHN1cmUg
dGhhdCBtdGtfbW1zeXNfdXBkYXRlX2JpdHMoKSBkaWRuJ3QNCj4gPiBhbGxvdw0KPiA+IHNldHRp
bmcgYml0cyBvdXRzaWRlIG9mIHRoZSBtYXNrLCBzaW5jZSB0aGF0J3MgbmV2ZXIgd2hhdCB5b3Ug
d2FudDoNCj4gPiB0aGUgZW50aXJlDQo+ID4gcG9pbnQgb2YgaGF2aW5nIGEgbWFzayBpcyB0byBz
cGVjaWZ5IHRoZSBiaXRzIHRoYXQgc2hvdWxkIGJlDQo+ID4gdXBkYXRlZCAoYW5kIHRoZQ0KPiA+
IG9uZXMgdGhhdCBzaG91bGQgYmUga2VwdCB1bmNoYW5nZWQpLiBTbyBmb3IgZXhhbXBsZSBpZiB5
b3UgaGFkDQo+ID4gDQo+ID4gbWFzayA9IDB4MGZmMA0KPiA+IHZhbCAgPSAweDAwZmYNCj4gPiAN
Cj4gPiB0aGUgcHJldmlvdXMgaW1wbGVtZW50YXRpb24gd291bGQgaGFwcGlseSBvdmVyd3JpdGUg
dGhlIDQgbGVhc3QNCj4gPiBzaWduaWZpY2FudCBiaXRzDQo+ID4gb24gdGhlIGRlc3RpbmF0aW9u
IHJlZ2lzdGVyLCBkZXNwaXRlIHRoZW0gbm90IGJlaW5nIHByZXNlbnQgaW4gdGhlDQo+ID4gbWFz
aywgd2hpY2gNCj4gPiBpcyB3cm9uZy4NCj4gPiANCj4gPiBUaGlzIHdyb25nIGJlaGF2aW9yIGNv
dWxkIGVhc2lseSBsZWFkIHRvIGhhcmQgdG8gdHJhY2UgYnVncyBhcyBzb29uDQo+ID4gYXMgYSBi
YWRseQ0KPiA+IGZvcm1hdHRlZC93cm9uZyB2YWwgaXMgcGFzc2VkIGFuZCBhbiB1bnJlbGF0ZWQg
Yml0IHVwZGF0ZWQgZHVlIHRvDQo+ID4gdGhlIG1hc2sgYmVpbmcNCj4gPiBpZ25vcmVkLg0KPiA+
IA0KPiA+IEZvciByZWZlcmVuY2UsIF9yZWdtYXBfdXBkYXRlX2JpdHMoKSBkb2VzIHRoZSBzYW1l
IG1hc2tpbmcgb2YgdGhlDQo+ID4gdmFsdWUgWzFdLg0KPiA+IA0KPiA+IFRoYXQgc2FpZCwgZ2l2
ZW4gdGhhdCB0aGlzIGZ1bmN0aW9uIGFscmVhZHkgZXhpc3RlZCBhbmQgd2FzIGp1c3QNCj4gPiBi
ZWluZyBtb3ZlZCwNCj4gPiBpdCB3b3VsZCd2ZSBiZWVuIGNsZWFuZXIgdG8gbWFrZSB0aGlzIGNo
YW5nZSBpbiBhIHNlcGFyYXRlIGNvbW1pdC4NCj4gPiANCj4gDQo+IFdvdWxkIGhhdmUgYmVlbiBi
ZXR0ZXIsIGJ1dCB3ZSBjYW4gbGVhdmUgaXQgYXMgaXQuDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0
aGlhcw0KPiANCg0KRG8geW91IG1lYW4gdG8ga2VlcCBvcmlnaW5hbCBvbmUgKDEpLCBvciBrZWVw
IHRoaXMgKDIpID8NCg0KICAxLiB0bXAgPSAodG1wICYgfm1hc2spIHwgdmFsOyANCiAgMi4gdG1w
ID0gKHRtcCAmIH5tYXNrKSB8ICh2YWwgJiBtYXNrKTsNCg0KDQpSZWdhcmRzLA0KTmFuY3kNCg0K
PiA+IFsxXSANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJzL2Jhc2UvcmVnbWFwL3JlZ21h
cC5jKkwzMTIyX187SXchIUNUUk5LQTl3TWcwQVJidyF4U3Y1eGJZNmN2LU1nLTF4REdPZjNvVlo5
M3V5cmN2NHR0ODdES2x4NWVtam13dWZqZjJEaklPTjdHaU5BYUpCJA0KPiA+ICANCj4gPiANCj4g
PiBUaGFua3MsDQo+ID4gTsOtY29sYXMNCj4gPiANCj4gPiA+IA0KPiA+ID4gUmVnYXJkcywNCj4g
PiA+IE1hdHRoaWFzDQo+ID4gPiANCj4gPiA+ID4gKwl3cml0ZWxfcmVsYXhlZCh0bXAsIG1tc3lz
LT5yZWdzICsgb2Zmc2V0KTsNCj4gPiA+ID4gK30NCj4gPiANCj4gPiBbLi5dDQo+ID4gPiA+IC1z
dGF0aWMgdm9pZCBtdGtfbW1zeXNfdXBkYXRlX2JpdHMoc3RydWN0IG10a19tbXN5cyAqbW1zeXMs
IHUzMg0KPiA+ID4gPiBvZmZzZXQsIHUzMiBtYXNrLCB1MzIgdmFsKQ0KPiA+ID4gPiAtew0KPiA+
ID4gPiAtCXUzMiB0bXA7DQo+ID4gPiA+IC0NCj4gPiA+ID4gLQl0bXAgPSByZWFkbF9yZWxheGVk
KG1tc3lzLT5yZWdzICsgb2Zmc2V0KTsNCj4gPiA+ID4gLQl0bXAgPSAodG1wICYgfm1hc2spIHwg
dmFsOw0KPiA+ID4gPiAtCXdyaXRlbF9yZWxheGVkKHRtcCwgbW1zeXMtPnJlZ3MgKyBvZmZzZXQp
Ow0KPiA+ID4gPiAtfQ0KPiA+ID4gPiAtDQo+ID4gDQo+ID4gWy4uXQ0KPiANCj4gDQo=
