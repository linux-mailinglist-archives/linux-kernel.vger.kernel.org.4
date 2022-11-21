Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35358631970
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 06:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKUFSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 00:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKUFRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 00:17:55 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F362729;
        Sun, 20 Nov 2022 21:17:53 -0800 (PST)
X-UUID: ee1691c748dc440a90e1da25bb888629-20221121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uF0ScyvOBpiY9YAKzcqGr0KqQT5GvMWeCmYPP/8ypBI=;
        b=FCpdxsfEsomGZY4F/Pt/WvASLZ5R9yJI0ZGi+ptVfdPbNFFU2ddyfEaSeJFMHWyP3yjLnBoqYvdl4Z+/o+bDX7tf4RxGpItR6PONpnNicZi6BzqNVqutUq6cdxR7LS5rxRPSTdMXSvYO7ewjRnyD59QJ5u9xfhy+p77ezw9pV+4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:15b28468-0a31-46b6-a040-a34393f5eaf8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d12e911,CLOUDID:2411d2f8-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ee1691c748dc440a90e1da25bb888629-20221121
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 987478069; Mon, 21 Nov 2022 13:17:50 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 21 Nov 2022 13:17:50 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 21 Nov 2022 13:17:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoqAjI3xT3k3DZyr65+il5ZsDA3gPVl9W1ZvPE9GflGroco/0kHLpilblRE6xLYiQXbBt4WO1W/3xOoF8z+NlxqpLtlv4GxicFElpFLP5dTy8LH1crjG/2Ejl5b51JgKBGoVmuxStI59Uc0nFLpRjSlHrEeiwKyJrqYUVsGA4wGpU9cRusMDgFkDmB6LvtDN+hKcwCDdyXtzgsukdvgKe0i/iqXqU/VDLnxbZjVLJa6HlePkWvzm6YTLKc7+Tth4wo2pY33AJFE7cN3GmlAlpHw9JyU1sMkWN/uOULY1QBLdMqhg4Vi6rAD/apDusV52LnEItLEhC8Gn0tMcfdH0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uF0ScyvOBpiY9YAKzcqGr0KqQT5GvMWeCmYPP/8ypBI=;
 b=OR4RltpI3LvlvjpzaGkA2R9ejg1jDr+M0tKsStvjjL7UikctQUW7BLqH+NwLSaSKhPO9uNZB8ZJgBimASXhprUOmDRK0WRUxwT2dYaxwKXFkSukXBDYL8wfV582AGC3c0WHHP0FPFzFLzn+S8cxXPxK3CsI8NJNb1LHzbg2qchWftSlew2osIv8gup6PP/Qlk039zC3CuCozXeW/hq6DQWo7gFwmHvwVj6FI6oYvSYCTuqtKl0F9jmPNQU5rHaNRsk3cg7RTf1gwXl+BZRIoVF8f/L1x0NdeeRyD/pkCIvXFwBpDlzpsVv5jA0fg5YaxBydwSbgnDptEDJhssOGBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uF0ScyvOBpiY9YAKzcqGr0KqQT5GvMWeCmYPP/8ypBI=;
 b=GVptVheUEN5q1TOmxNJNOymsReFgWkYuHYsAKPaVPSlBf5Ja4rS9lKwMK/UAXwQ/C3iVHZZgLRwYeLtbWfgI0hIlewybZE//AsC9Q/RoEBo45DV8apU+oBNzUg2T+GeRAgiyfEXVTXsS140Vf/kml+GDftP9SkRaj5fcZ4bZzD0=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SEYPR03MB6603.apcprd03.prod.outlook.com (2603:1096:101:85::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Mon, 21 Nov 2022 05:17:47 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::be04:b90a:e582:9b0b]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::be04:b90a:e582:9b0b%3]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 05:17:47 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] iommu/mediatek: Add enable IOMMU SMC command for
 INFRA master
Thread-Topic: [PATCH v4 3/4] iommu/mediatek: Add enable IOMMU SMC command for
 INFRA master
Thread-Index: AQHY4r0dQlSJyQCUy0+VaUhNz566qa5JC7WA
Date:   Mon, 21 Nov 2022 05:17:47 +0000
Message-ID: <759482a88de83be39f507b25a9f060ed7cdd89e5.camel@mediatek.com>
References: <20221018064239.13391-1-chengci.xu@mediatek.com>
         <20221018064239.13391-4-chengci.xu@mediatek.com>
In-Reply-To: <20221018064239.13391-4-chengci.xu@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SEYPR03MB6603:EE_
x-ms-office365-filtering-correlation-id: 7bbf0296-9588-40be-f7dc-08dacb7fba83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WHpPUsioSR77nCyyx8xNAl+mf00DIlp5s+DEJOxuS9x8j3LwJt913xcPZGjD5gFb5ppnEWH6dUHxTfjPKJdBL9AJ6Z4lzwYnZFese3YXkIXe23R8cZ/dQixiwHN69R6SFkRvctiqwQu5PL+eJbxCYjsUX4c4c8UO6LS8enggMnx49xgzFD3aeNFnnaLT1ip6PLh0cPrxGYWq5OhGs4GmJkQyaDPLWDjjVWBJgfhKT2rzDjVqqpR5fo+zFM78w461l/NnCsKZWVKWxRvxMPg4FKCDKoh8grlxHASnih5xd+7oNCN05ItfMZ0QSIJlkjTBmQXRT6bBA0s9j7RdBE3t255v4voP9AprJbLIT/6PlTC1key9fbcBGvd3FDHJIEFhcQh7XAUkKy8Zq0/2CE3iFcKUW1+Ff2uYV2eIdK1b2+f901Yk5l9RThM2bqsycTbCchWTfWTuWvNvhDYp+q2Qf2/8TCwrKOaq28s3UCiazI4zDPiKJgXvOtAbJYrEVkyKjf/VUVvegX/WglGlkhIJbLvfE2poMpQUK7Q+Sy6jNDxLJ0TaHCp/7hui9pozQayVN3eg2f9PLaGoq++PgXTQe/pq5ANJ4gD3WJcvo4FNKJ1mso0cb9Gss61aRpK5yLq51AFSSxGlql8qh3vsUyXCT7doY118XVhItqxH/g0XEBQsca1uRlxnYdjUCdic4MrurcKELBirhKHeWcpaHoHk3545911mKKR+xkQ4zpG22i0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(6512007)(8936002)(2616005)(85182001)(26005)(186003)(7416002)(5660300002)(4744005)(38100700002)(36756003)(316002)(478600001)(86362001)(6486002)(6506007)(71200400001)(38070700005)(54906003)(110136005)(122000001)(41300700001)(64756008)(66446008)(4326008)(66556008)(76116006)(66476007)(66946007)(8676002)(83380400001)(4001150100001)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME9PcmxNNG5uazFwYkNNUjdUSFRVRlJ0czU4eEhlYXloUktDeFdtb09kRHc4?=
 =?utf-8?B?a1BHQkFEZVh6aW02N2FIa3RLanNqVHVnUk5Lck85Y21LOHlOaVpYbEw5MnBx?=
 =?utf-8?B?b25Kb2RtN0hMTTRKd2s1MDZsVCtCUGtGZy9rSC9nbUV2d3hsRWk5eXAzUzFy?=
 =?utf-8?B?M2NKbTZXaUUrYTRZK3VobitVcm5OZ0VDc0x6d0tGOXdzTWExZjFpWDQzVFYz?=
 =?utf-8?B?cEd4Q1NYR21FTDI3R0phU2cwMlFLcGVqR01DQzltc3dJY2RDWFZ6U1RpMVd3?=
 =?utf-8?B?d1ozcjhzYi9PNk9iazM1RFFtc3BWMU12RVZTNnl4dkR1TXY3bnAvMjFLZUJU?=
 =?utf-8?B?eSsxTTZTU2NWUlozNkR2U0dZcmhFTDljbW44azUzZmNGOUlCaUtvbVFsNVJi?=
 =?utf-8?B?cmNWUThEMG1mZVYrUFlINUV2Vm15eW1lSmkyUXAzcS9aQjNiendmSEZSbWY2?=
 =?utf-8?B?UjRaVlY0VkRMSEJRTFZqMUNWUXNQYXNNUlV4eHhkMFlXS2hEMXlOenR5dkZa?=
 =?utf-8?B?TmlyRVNQYzBicWFyR05ZSXN6SENRSEQvZmtaUHZDUXZUYXZaTG1LZmpWOXVY?=
 =?utf-8?B?YXFBUjBkWkYwZ2R5d0orbmMzUEc4ZXJXaU91RG4xckFVeXNoT1NhTDA3d3o0?=
 =?utf-8?B?dTNuRFViNUZCZmpMQUJ4RW1xMXRaZlBrS29ieW9vU0Yzd05CSmY1ajlhejFy?=
 =?utf-8?B?MGZRWXZqZGRhMFpWUy9vK2hNc2NEZllxb290ZkVBaDRWNVcrKzVJb09XcmhD?=
 =?utf-8?B?QnBsK3JkS0lnMFoyL2tqY1VCRXVMVDY2clVqMVN6SVF3SHZEZmYzbm9qWm11?=
 =?utf-8?B?Mlkvcys5bmtNKzdBNktKczJTcDBQN0JuZ3pZNnUzcjhUOHc1djAwbzVja1Vv?=
 =?utf-8?B?U3dqRG9ZeXRQV2FndTNucUNZb2V6SlVxcjZGRnpCaDg1MzBzd0d2cTA3RTFR?=
 =?utf-8?B?R25wNjZCL3R3MURPV2ErSGJ5Y1k2dXBWdTAyeWVkRGxqTzE0SVRPUVJiditT?=
 =?utf-8?B?ZzVzaEZ5NkpPMzVFcnlxcXplYUhiNzZOQ2xic2dzMXJvc0RFWmpybTNBNzZW?=
 =?utf-8?B?aE4weWYxWEpUVWlSNDhQSFIxRlVQZFZIYkpnclJWSzEybVFJV1UyVzRPZEZh?=
 =?utf-8?B?ckhGbnlsYTZXUmpoYUVlcGxsWEtEd0QvdHBCY2hMVGpaS3MvUEdRZjBQMndT?=
 =?utf-8?B?NU1JWldGSWhObGprcmRhZDVLZWZXM0k4S0V2bldNMjNyMEN3WnlLSEhQUjZR?=
 =?utf-8?B?WWRyOWUyLzBDZ28vdi9EMVp1SFNyeFZVTTlMZmRSRlJFdDlkSXBQaHpnNFIy?=
 =?utf-8?B?bUFHSTZFZU1idGhmUUptQzFGeDJEeDNrNFQ3UkN5NmRHUDdmSlpVWkcvYjMv?=
 =?utf-8?B?V2dZcEYwZFdRZm8rRDhzbkhUSjI3U0RaWVhvcHkvWFVUQ1MrVXNZOFo5TElP?=
 =?utf-8?B?MThERUtVRWl4R2YrZERJb0s2UldITmx1enMzaXJHcUlnS0djb01SNVVaWnBK?=
 =?utf-8?B?TUcrTWFoVDVBUTVTRGRSejlkMmpHZFJ6VldsdXYvK1VOMy93MGI4K2NKT0tq?=
 =?utf-8?B?NTVUeW85bWszaXpSTW9BSkR2LzVwWStoaVVnZG42MisyRWtEbHlJaWwydk9a?=
 =?utf-8?B?aVBiUWwvWm1mVlE1Rk4wTW9WWmYzVmR5Zmx0Q2J5T2l5OWdYV1I2Vm8xM2ZL?=
 =?utf-8?B?SEMxUnRJTDlBRVRGNC8zdHhTNm9KUkRXbFp1OUxEZWY2RlR3MjNYOWNCaVpB?=
 =?utf-8?B?VVFibG5KS2NkUzVKVUhuL0lJZ0M4OVFoL0RsZ0o0R0tJdEJYU1VzL002cVBX?=
 =?utf-8?B?RURSWmZpcFFhMGhBSjJ2bmNuZ2RRSWllYTEvbzB6NjNYNml2dkJKN0lOaGVm?=
 =?utf-8?B?TlBwWDZRaC95Smg1VFNOYTdqSUR3T1hCR0lRTHNjQmJ3UjRrUDNVUjhVcHVr?=
 =?utf-8?B?S1VxTnVXTzhxcFZYbDBOZXIzRVBjZGlLVTRmd29pNlVoVi9ZZmcrWGJRVXYv?=
 =?utf-8?B?YndRZEZYL2VRMjIydFFFVWwyZ2dhUEgvUitaeEVsOHVIeGZXOXFTcG1BUDkx?=
 =?utf-8?B?QVVJVW9ubU9qT3M4WnNnK1RhRGlNT0xDNnBqS2NQMlJiVWFLMEtoNTh5R2Fx?=
 =?utf-8?B?Y1NUQWMvM2JsaitCNTFXNjBOZVdHblZueXVrcVpMOFJXOGFTWDJtNWljMk0w?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <588B2AACDB09B14AAD6D37F0B203C0FC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbf0296-9588-40be-f7dc-08dacb7fba83
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 05:17:47.6687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 786Rge+QUkAXShA2kFuqxxqiC+IlYQYpS3/lDzZwokeyivVpUDheuOGTlpDhsKOCF3zpZx33XTnaHlcOCQCixg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6603
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEwLTE4IGF0IDE0OjQyICswODAwLCBDaGVuZ2NpLlh1IHdyb3RlOg0KPiBU
aGUgcmVnaXN0ZXIgd2hpY2ggY2FuIGVuYWJsZSBJT01NVSBmb3IgSU5GUkEgbWFzdGVyIHNob3Vs
ZCBiZSBzZXR0ZWQNCj4gaW4gc2VjdXJlIHdvcmxkIGZvciBzZWN1cml0eSBjb25jZXJucy4gVGhl
cmVmb3JlLCB3ZSBhZGQgYSBTTUMNCj4gY29tbWFuZA0KPiBmb3IgSU5GUkEgbWFzdGVyIHRvIGVu
YWJsZS9kaXNhYmxlIElORlJBIElPTU1VIGluIEFURi4gVGhpcyBmdW5jdGlvbg0KPiBpcw0KPiBw
cmVwYXJlZCBmb3IgTVQ4MTg4Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hlbmdjaS5YdSA8Y2hl
bmdjaS54dUBtZWRpYXRlay5jb20+DQoNClJldmlld2VkLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1l
ZGlhdGVrLmNvbT4NCg0K
