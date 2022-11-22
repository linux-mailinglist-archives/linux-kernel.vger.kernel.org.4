Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527AA633205
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiKVBNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKVBNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:13:17 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FCA6403
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:13:10 -0800 (PST)
X-UUID: 410a1ea19ec04942b6db47a0c62184b6-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YrExqotUYwTm+BLDHjjpJee19BsVzDaeKVUo+YaRGYY=;
        b=lJVjkSyFgn1rXQOMQah7Vvl7bziRGDLbVbFQg+UobWmyvqcUCIBefTEx6hgpselG6bPjltzV8pvcm3DrYdnhfnsqbr/ssOr3tkJP21+CccS68+SucPgdinu+vEO2GRHnxaE8HdSqneNsvJqPvk+q2hE6UmO3xgM2tQb5Il/ocL0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:7bd371c5-659d-44b1-b93d-043c33b878f2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.13,REQID:7bd371c5-659d-44b1-b93d-043c33b878f2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:d12e911,CLOUDID:9893e8f8-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:2211220913067J9BB6NU,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 410a1ea19ec04942b6db47a0c62184b6-20221122
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 281895857; Tue, 22 Nov 2022 09:13:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 22 Nov 2022 09:13:03 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 22 Nov 2022 09:13:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtJbQp4YuROvofz+kb/ij3Yth6N41XKL0WwlrJqeKFmx5ShTJ5F9fqK2jF3ugkiMrP9xBObuuER4NuYbNkoOyy1LNO8bh97jP/B6TcNdtikN+k0gzX829+R7poh8rAKWgdZB6+JsKARSIsX3LTRuMRcoM7j0KTj3DICae5fJ2V/d+Wd2wLd+zNvp4NT8bhuuGlC+hfN8iiD9VmuBXd/7/rJ3rgU2g3UnLHwJqbUd2rCPDm/Ymy4ZRz9MGL3XgNHgFcuihg8Xeq3A5ansspcyPo85Ysj2Cg8/f+mpmuS0j2vy9V/K0uUBFAJ6vkkujlW5P0DTKlme6b1HZMMn2T+1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrExqotUYwTm+BLDHjjpJee19BsVzDaeKVUo+YaRGYY=;
 b=hR4kyMRXaci75bi/REwMHcSWkEXSKChCsvlfvJx2lMXWlDvlXzGiDgW31fnLF5FW0JbrUHxbAz6sdwW05JngTcaZR/tFTeoO/Pmvcrx8eLvKam1+FL3YnQNagprr7Ynjkjo8/L5nRA5y/pkTo2tvi1x3/MR4qXvT3D+bBTAaCFxKq+E8Yobh43huk4XhuDgIR/YypCCVa8DSNrKwZ5k9jWfvqIuaS8bXYQIQsWgN3VzrbVmJtzxW72ro45uHi4hQJYwd5f6bwV34yyXGKTv/VM8Ak22FqmF11Dx4NUiTHRJ1Z+qz1k5kp4Gyded3auwF06oxv8wBqLSDgAWbjlj1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrExqotUYwTm+BLDHjjpJee19BsVzDaeKVUo+YaRGYY=;
 b=UVYOTfWH/z8P1COoiMdstIF9MKi/Cp7mlLmmlrq/EDL6aWcH0RCj60qg90hEhPHHDYr9a/6qQ5RjeZ/U2dDh6I6WwExja85X/t3Jl8wDklnkfr1eSbXyzdsiIi3uLzJ3CBBYuc1KMqvobKUklViubKHPwaOCCdzAym2fCH4i/Cs=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 PSAPR03MB5269.apcprd03.prod.outlook.com (2603:1096:301:49::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Tue, 22 Nov 2022 01:13:01 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::be04:b90a:e582:9b0b]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::be04:b90a:e582:9b0b%3]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 01:13:01 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "joro@8bytes.org" <joro@8bytes.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        =?utf-8?B?TGlibyBLYW5nICjlurfliKnms6Ip?= <Libo.Kang@mediatek.com>,
        =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        =?utf-8?B?WHVlcWkgWmhhbmcgKOW8oOmbqueQpik=?= 
        <Xueqi.Zhang@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v7 0/6] iommu/mediatek: Improve safety from invalid dts
 input
Thread-Topic: [PATCH v7 0/6] iommu/mediatek: Improve safety from invalid dts
 input
Thread-Index: AQHY4ptbWT/UD2pWZE6JVP1uhM0JVa5KWeYA
Date:   Tue, 22 Nov 2022 01:13:01 +0000
Message-ID: <b20e6c79b989f0f26707f6e43b9f4aa0d1d8f02e.camel@mediatek.com>
References: <20221018024258.19073-1-yong.wu@mediatek.com>
In-Reply-To: <20221018024258.19073-1-yong.wu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|PSAPR03MB5269:EE_
x-ms-office365-filtering-correlation-id: 9a8c6bcb-9ee7-4670-b495-08dacc26b31d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B7eDh0+0r+4Fc2/1BmJr0iGs8gfYSWywIYh6MeAFzIFjVu7HY7/PqDoBnIfRGiGu8UFIQq1Ffp4FmAGmdEyVz6kVnjGM4aI8nlaNyvxpf2Avyw6qV2fZG7Ea417LspATHoeKE/Ar3HzdkK9WyIHRQ71j+mPJmGT2JvsoAnx3EmA5BXJYXx/NPy9IlYixdRDz/JOFEwIzP3RfhjN1osps3PeVXsTmqXFM13C/W5rT89fQcPc2vkIpUIMjJ0Iqhavy4OVn8kwAPvA3HxOnY9ht8SUF9B+DkiMVNHwAjlM0NEnLeUUS2Bp5fQSHUvW5aX1D8cgmkPpseh06fHhIQPZc2gViU36c8n87lJuHFsajKBb9Og3aNpjaDPJqNTa5CUHGc7ACadOeIvrYGUS9erAOrsOeyvFGhEWAWw+tyht7TgedwRsbFk6a4U3xoEhGdssCqZp/2BiTDR8OOukOFJZGCTKu4Pmp1TKcFabsA/XVLzyJM/miI9ycT/MwWxcSPOmEwh1OqANDjZ030SjbSOOVkxOHg0doKly9xuZECvB/Lif2QtkpQq1gByjU/JBg0LtUMhP1W0/JRdO0NX/u/3ME81YX1UaFXqh+sh8YdLI/0DSjODTGerTyLQJ+WzFyEkHVKisJekARB+dGnXuKhVkELATO7gLMKFOuSeA7qE34D+z2hBcQOXTQZHh3eN2BMXDhu1jbEq9rEOvmSwVQ9Ykri+rIZQrlXkqb6Q8IfXnB3Wk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199015)(7416002)(4326008)(6512007)(5660300002)(66556008)(54906003)(110136005)(316002)(6506007)(64756008)(8676002)(2616005)(4744005)(66476007)(66946007)(41300700001)(26005)(76116006)(36756003)(186003)(8936002)(85182001)(122000001)(38070700005)(2906002)(38100700002)(4001150100001)(86362001)(66446008)(71200400001)(6486002)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3Y3QzVwcTVCYjRmREJJbUtaR3Era1BXaU5aaXdZbEZwVm5BMFVCbDIwa3du?=
 =?utf-8?B?QXo3YzZiR25aNWx2bXlic3FxUzgyNU5SUnE2SmFOSUQrWVloQXVrdklvTGl6?=
 =?utf-8?B?c2NpQ1Y0bDAzM3hMcW45TGR1NzNNNEcra2Jqc3ZTOUwrQTVRQ29NRUFoL3Bx?=
 =?utf-8?B?WDZWTmRyUHpDNTJkdEJJUUVRdVZtQ2prVnBabTZ1OUpjaFA5Sjk3ejJkNWRN?=
 =?utf-8?B?RUhMRkQ5MTV1VUdtVGlRZG44TTQxdC9oRTBGZlBnYVN3d0lFcGtKVytQdEFj?=
 =?utf-8?B?dkx4OHAxSFd0eE0xN3FpQjFXUlQrNHlOQlBqbXorQ1RBbW0xbEVLNGprSUVh?=
 =?utf-8?B?dFpGRWhmUUR0OHQvTERTSTZKS1RJMmxoOFhaaFJpbE44M3J5WHlpSWttV2Ft?=
 =?utf-8?B?N3Q2QkZtMW84NTlOWnRqbWplMUFlK0p4a2EzL25tb1pHa1htazI1ZWxnaHZz?=
 =?utf-8?B?VDdNcEgxUU82N0dEc09LeVozTjdPeXpSR0Iwd0Q4VXBYMlp1d3ZqaGF1Q0s2?=
 =?utf-8?B?dCs4d3RKUzBWUzk3ZG1xcksxd0JjLzJFMzBDMU5RWm9hbHYxRWFXMkVvK3Nv?=
 =?utf-8?B?a0RlUmdKQlBIdVdWKzJpeVVXVzVpYlNUMlpHeVpQUEEzamZoSnUzczNTU0M5?=
 =?utf-8?B?WjBTc3N2V0tVUThkWUR2SFVJYmc4bzJxYUs1TlYrakxQeGtZR3NzaE5UOXpo?=
 =?utf-8?B?SGFML1hrQlkzaHRRNExKZkovK3pEeVhyeXM1a1poaDJxZUFON09Fd1BNaERB?=
 =?utf-8?B?SUhSaUNDK0lGd1h3WXhIRWlnQ29BRXBvNXZpL21BeTFHWmtNSUE4Qm5scHNG?=
 =?utf-8?B?anI2K09IUnltMVg5dUxHMkUvV1ZsQkU4MWRtZ0o4SkZJSkhhcGtRSzY3akMw?=
 =?utf-8?B?T2JoL0s2UUUzTmxBTEFLdTd1VEhFWXFJWThBN3U0V0Frb2NZaFhub04yMmVn?=
 =?utf-8?B?L2NJeFhoRTlZSlJUNURVcUduOFk1ZXg3c1BWWFo4S1lZd1NBcmhUQVRvTStY?=
 =?utf-8?B?bG1ST20xSG83bEFLZ2dYaTJiQi9WRlZMWE9Pc0QzYUJXcnl3WW9kakNyVS9l?=
 =?utf-8?B?YzMxVUJyYVlGdVFnSjVoRkZ3bVVpb3NBMHVrNU1mZEtaVzJZSWRmU3lEWkFP?=
 =?utf-8?B?M3ZPNjZtRnhybndLR3dHUFhRY3o4UWdWWDFqa0V5S3V0R2V1eS9jVzcyeVhZ?=
 =?utf-8?B?SndKTm9UMGluV2xPN0x4MGx2bWZ5ZkdodHJCVHVKUGVHUDZ6WTV4cGNZb3hY?=
 =?utf-8?B?N2FubUJWYnB2elQ3M0FyVkJET2xQVVB3MTI1V2x6ZVZ1WG93bS9CMUVqTzRX?=
 =?utf-8?B?eGVCY1hQejJFdUFRbWh3a3R1VWp1M05SeVNEbm9CU3NHUzhZOFE2am1Lckpr?=
 =?utf-8?B?aklPNnBqUEZVcCsvejJseWduYVdSaWRQOGQxWXBUa2RjTnBXc05iNDlFMHhZ?=
 =?utf-8?B?WWdsaWZEaDg2N0pJZEZGMGQ1bEwrc2pKWlhmV0RnUUNOYXQ2UlRZU1hFa3JE?=
 =?utf-8?B?cno5Mk1JaFFCZGYwZE1XakdPOE92V014MWxYd3JyL0pXRDVwMnBHQVNFd0Ns?=
 =?utf-8?B?eWJqbTQ5bTdINjR6blRqc2pWMmFiZnBCdTBJUDJCNFZVMVFJd21FK2dHbS9z?=
 =?utf-8?B?ZmNMWWYrc1VtQktLZFRZdkF1eHdKdmx0Zlh6aVZsRFhPdHkvZldTdmZIUUR2?=
 =?utf-8?B?dXV5Qlk5UzNHVDg2akJDTGcvSWFweWEyeHZSV213OFV5K053ZWFjT0F3S2JZ?=
 =?utf-8?B?bHIyRC8rT3I2ZC9DUFBWdkR1d1hMSll5NXVKdWlQTS9za1cwNzlPelFtWEJD?=
 =?utf-8?B?M2QzMVlnMHR1OFcyOFpLUWR2a2p2QWYyMzR2Y0YzUVlrejAvUGZQRXBNNVdE?=
 =?utf-8?B?RGl0SVZaZDdCRyt5UU0xNjVRQnlwOHNRMElFSkU3UGQvOFA3dGxGTUtoQ2J4?=
 =?utf-8?B?cG02d0UrVUR3cHp4elAzOUlTMm56aFVjc1VuZEtoOGduM2ZRMm9Da1RCQXhr?=
 =?utf-8?B?NDR0WjFFby92ZlVWWFcyZGNSVWdqWDZ3N2hqVWFobUd2SkxyM0ZjWFpEaHJN?=
 =?utf-8?B?VTVRa1dUMDdNY3NLVjBVc3o2MzVRWDBsdFFOWTZ5QVVQSmJ4N0dXaVRZRWhG?=
 =?utf-8?B?S1d5RC9TVVpMZWgwOE9GQ0VJN29DK3l1QVFLM0p5STZJRm1XZEIvcjdKYWJq?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB0EB8E5C6210C44B65F93EBD165AE59@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8c6bcb-9ee7-4670-b495-08dacc26b31d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 01:13:01.1613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qT+8pFhyo/yMOmRvk+4rEStM85UzrSAa8eI9QfioIjmxx0+uP6OFjngJCjgh3vsIn/owhNgL3/+uAl2Y1ijpcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5269
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTE4IGF0IDEwOjQyICswODAwLCBZb25nIFd1IHdyb3RlOg0KPiBUaGlz
IHBhdGNoc2V0IGNvbnRhaW5zIG1pc2MgaW1wcm92ZSBwYXRjaGVzLiBNYWlubHkgdG8gaW1wcm92
ZSBzYWZldHkNCj4gZnJvbSANCj4gaW52YWxpZCBkdHMgaW5wdXQuDQo+IA0KPiBDaGFuZ2Ugbm90
ZXM6DQo+IHY3OiBSZWJhc2Ugb24gdjYuMS1yYzEuIENoYW5nZSBub3RoaW5nLg0KDQpIaSBKb2Vy
ZywNCg0KR2VudGxlIHBpbmcgZm9yIHRoaXMuIENvdWxkIHlvdSBoZWxwIHJldmlldyBvciBhcHBs
eSB0aGlzIGlmIGl0IGlzIG9rDQpmb3IgeW91Pw0KDQpUaGFua3MsDQpZb25nDQo=
