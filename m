Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18600693057
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjBKLeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBKLeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:34:13 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CBB1EBC4;
        Sat, 11 Feb 2023 03:34:10 -0800 (PST)
X-UUID: fdd015cea9ff11eda06fc9ecc4dadd91-20230211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bJudrZ8Yl7Ga9G97uVaZhOEbOeCRxP2SYFqOaFcwXU4=;
        b=JwAR7HlfTt2BQnm5abNH117SRw6CrNH36NEmMflfWHKmTkxFqcMfBvK+JH59Ky+fePXkSdfj5Qjg0rxd10/dYBuBhkUEiQpCzNSWuErsfZCSqNHb7HRHFZAph03o2n//O3qKTcg3SWNM3rMTkM7nwI6gl5phX5bUaeFcFLie0S8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:328f18ed-6732-4655-a6cb-9850d0261e7a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.19,REQID:328f18ed-6732-4655-a6cb-9850d0261e7a,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:885ddb2,CLOUDID:3acd938e-8530-4eff-9f77-222cf6e2895b,B
        ulkID:230211193407FIBLDEI5,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: fdd015cea9ff11eda06fc9ecc4dadd91-20230211
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1170638742; Sat, 11 Feb 2023 19:34:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 11 Feb 2023 19:34:04 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 11 Feb 2023 19:34:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TALKMB2IPDPopgj80HhKEMhrWz9dqolZ0nPWPN/m+42YnIQzzPKC3igMWAZ2Vyt2FwxbCICIMmuNcNO/tGJ+b5byGTHOhps2/guI64BtIYusn4/8/idYLtVGdxmHTS6Rq/ACVZkrqwcPzSg+EWk64fU5ZSK1HkjWInHWs13bQz5fkMo+Viti+kpzeth8/xhnomFmXGUKdMsFSjq4ETrilEaaKlyTbNDbbaAgglRrW/nDd6K/Ez18td1DRa3JD3tDfqk+XkrQAJa0amtclOXvPabGvkVQpufk8bex82VWe3ADECKe1Ohlpb+wvM1hIjBUOu0JBhTu8Dlw9UeVFi/2og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJudrZ8Yl7Ga9G97uVaZhOEbOeCRxP2SYFqOaFcwXU4=;
 b=iSaxBIQV/HXenZqK1Pf/tf+IKxgvMzNrv2+DKMrE50NfWxJ9GgXcQN1+3Ziw8ySekb7mE8cK4MJMjjGn8c858rC9vRVsEEzAeR2JK/FPgm1dFnjm3prCDhhKvkFWhS6Kf013Aisp9EvjcluVJiFQQi6HwmwIDw41QjtxX4jBQ/JqBlXLWtj7omu3T6oyN/TfezrpX2c/5klDBIkOHMjaWZZNGzx1+S5Dpzyo5Sb8fs3ztG/gqO/PfIRmtlLV8hAhUnqf0mnrlrHlofPLWgRjbBBzWxFLnbtSTbYV7/UTA6KSIuGQNU23SdqA2kE1XsURve30dV//dPrNXKUeijuSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJudrZ8Yl7Ga9G97uVaZhOEbOeCRxP2SYFqOaFcwXU4=;
 b=hMQT6EHC1+pzPO4PXTqWNd0ucFp3LNr+3sUfW2102INa0MTm+g/OLakaSg7crhdpzVUZduItYl5pVk9V6Wl12gaI04nHUqGyHvxK6C4u4DXQe1hvVOaZJ2OuNIj/Zx5EJZ3ZF31Ey7HsFsQaoTp1Y/J7MwUSQBGL7OW6bKf9opo=
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com (2603:1096:4:26::14) by
 PSAPR03MB5639.apcprd03.prod.outlook.com (2603:1096:301:66::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.22; Sat, 11 Feb 2023 11:34:02 +0000
Received: from SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::39b4:279c:45f5:a591]) by SG2PR03MB3434.apcprd03.prod.outlook.com
 ([fe80::39b4:279c:45f5:a591%7]) with mapi id 15.20.6086.018; Sat, 11 Feb 2023
 11:34:02 +0000
From:   =?utf-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>
To:     "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "drinkcat@google.com" <drinkcat@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>,
        =?utf-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>
Subject: Re: [PATCH v4 05/14] soc: mediatek: mtk-svs: use svs clk control APIs
Thread-Topic: [PATCH v4 05/14] soc: mediatek: mtk-svs: use svs clk control
 APIs
Thread-Index: AQHZJZDHI+SQIEhX8UKhJMQ/hdyBe664ohSAgAGESoCAAXDlgIAFu3kAgACp6oCAB9GxgA==
Date:   Sat, 11 Feb 2023 11:34:02 +0000
Message-ID: <1b6f52a1f7108a86a6bdb1ff8dd77454a215203b.camel@mediatek.com>
References: <20230111074528.29354-1-roger.lu@mediatek.com>
         <20230111074528.29354-6-roger.lu@mediatek.com>
         <5192bc94-12c7-dce4-c2e6-fa4b8c1ced9d@gmail.com>
         <546d7f2b3607310f0ebe11b3d4e0aac40ac44c7a.camel@mediatek.com>
         <68d19d2b-0613-f1b4-08ff-9d86f5021f9f@gmail.com>
         <615b406692504bb68bd781030023c0fa7b2bd11e.camel@mediatek.com>
         <f49ad56c-a5fd-5e51-f812-a2941b5681d6@gmail.com>
In-Reply-To: <f49ad56c-a5fd-5e51-f812-a2941b5681d6@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB3434:EE_|PSAPR03MB5639:EE_
x-ms-office365-filtering-correlation-id: 2aabc718-ef14-4821-42ac-08db0c23dfe1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i5Vi5GpXICvGU1osBaMbR109mSvivnkHXSFghwO7J3QluiqrTr5FRR0wVB2MxGIG1PdFlfp5aFloI7sIf/TaODGY5n51Q/FitPRrpgAjH6lQOwORWLEUdl0vFpZ2FCwhivdgBAzZjmqR+PpuG/+vZfi8mwKEjrXDcP68K9+XdxsC5THzRSTxPOzDT6+8a5sjoZNAcswFHttVrl4iC3kBII2hy5kFyXs8yRt+8sIKfTJn8uXFxWSCAQt9SbOXL3/9mnaWTdsV4PfiTE3iI75KBG+OalDI4kTCJTpttElF6juRH/aOj8S9lWvmKi4V+F0E4IJ9xQaVsnNADADBDrycvECFph0kREed396TaPpjuEej6RsD2ZrYTRbEk45e5BMtjQGirob55K4ESCzAd2nznjpXZY1rM85B+mLT1ynvyXgivoRLy+38G4yzj+Tybba+9WjfEclMyquFnRtnn4R4Bshg8iyx8TwfccLp6jHYM5B6UEmLEpnLRJk4kjfdBPRNxuDM3lOI8kfidHBzwsxmRDRXUIgMdyDCOLZuxpGQ8lBkqpOLkNk0owQ7ec6qO4nHB8sn5AD6peZP9lq4PLRl4uM/yqeKPaV7n9zM7V+NeU04WKHoY7CXo/SYZN0qgkJ+88k/2Df6tpVm84/HbRSsVXHPe0Gp72CpnKj/o0Q1JzBCeu5idvdkGM3BFjcu1C1i9aiKhdAu81YSIB2NHXv2JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB3434.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199018)(107886003)(41300700001)(316002)(38070700005)(76116006)(54906003)(110136005)(83380400001)(7416002)(8936002)(5660300002)(86362001)(64756008)(8676002)(66946007)(4326008)(66446008)(66476007)(66556008)(6486002)(478600001)(71200400001)(85182001)(36756003)(2906002)(53546011)(6506007)(38100700002)(186003)(6512007)(26005)(66899018)(122000001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3JrcE9CYnljZVhCK0RDWVRtRE5YZnJCbmxqSnhUSVZoeVJRbzU0c0cvMHR0?=
 =?utf-8?B?S1NmUXZxa3B6RHdUKzFiQS9EMXZaZDVDRXB1SUIxQnEySXo3ODBxOHdGUEVY?=
 =?utf-8?B?dWZiR1p1eXUzdExjM0Q5YjFEODFCR2VEMFVrcGFrOUdPQ1hzMmJhYWE0YXFt?=
 =?utf-8?B?anVVcjgyS2psT1FjYkRjeGlwakpsbVZaeFIxS0RpQzMxZ00rSm43ZlhFVWhm?=
 =?utf-8?B?RW00TklRRmkreTY4RW1qSUNDeEZqVjhrbngvOHUrTnZrUXMwVklsVXEzdHdO?=
 =?utf-8?B?MENad2pjdTlQRlNGMzRiZi9wOFdaUGY4aEM0Z2x4a2JVV21kajc3K1dsL0ZV?=
 =?utf-8?B?N0s2ZVM2bTlLN0hqbWtOU01YcjVOV0JUTlAyakt5SEMwYU5UZ3ZROWRVV2Mx?=
 =?utf-8?B?d2lCRCtiMDluckhqYTRiSUh1cmQ1S1VyZ2hsRHFwRTVOQ2cvZlljZTlLejA4?=
 =?utf-8?B?MlAySEZYZC9uQkxFSHIxMk5xR1d0amI0WXJuZW1vbHFxRzZMY1RPZ2JxckJn?=
 =?utf-8?B?RTJzQjhVV2RveXgwVXhydVZxQ0F4ZkNrbXRtL3ozRkVTSXgrZ24zd0xQYjc1?=
 =?utf-8?B?MHg4KzBsMDdWUUxhRkU0R1V5ZnJybDJiamRzNmVrWGwxdjUzRlZEZjR2UFRI?=
 =?utf-8?B?MHQvSXI4Z053YlZ0UHZ2UVhSditGRm5ha1NkM2hGMjVrbW0reUV2akZGdUZC?=
 =?utf-8?B?OFh6Y3ZPSVpnVVZsTWtGZzE2NXl6Q0FoQ3ZhVFo5M0YvTC82dDFQN2toeFcr?=
 =?utf-8?B?RFhzYTJpNWhlbFY3YjY2ZU1tVFRmdmVDUjlDZHRic3VremtPZ04zNUNzdXRk?=
 =?utf-8?B?c0w4azhacjh0V212NUxmM1ViZHU2WUZ4Z3lOd1NIWDBXVEQrMElvd0RqOHFa?=
 =?utf-8?B?VkpTSGRtZmNPa2xRZHIydXlSZFVzK00xSUJzWW1GamdxUytPdFVPYUNYY283?=
 =?utf-8?B?Mm5MN01ZSlN0a3A0eHMxMHV4Z0hpdjJNb0t3ciszdVF6amw2eGp3UlJNWldU?=
 =?utf-8?B?Z1pyd2Nmc1pKb21RTGJub2dIckQwNkU2RklUQmxPY2lrVTcrOThEeEtLdTUz?=
 =?utf-8?B?NW52R2VRSVRidXRHN291UVdIWHV1UHg1MVVnRmdCZy8yQm8vbWF5cFR0NXJD?=
 =?utf-8?B?WCtvVllMZW9xZllvT09rQzl3ODlFL3pROTFqajVwN3NZUlpvb0RrOUw1YTNY?=
 =?utf-8?B?TlI3dmpOa0dJa1J2QXdMQ2l4VXNERmtOMWcvY3BxMzhkczREUlVjZC9OMTVa?=
 =?utf-8?B?UmNGUFBMUXZaUjUrZXo2VWlMYUNKZVovMTJWRFRYRHluRm5EZlQ3bzFzM3ln?=
 =?utf-8?B?aGhrRVlpSkowZjhPMGlaV1R4dlRJdFhENldXTGZwNVFvN2xqZlFrV0tDL2Iz?=
 =?utf-8?B?RVRnY0VHVHBsVk1HUGRnZmlRTTAwRjNUTHpMV0xSeC9NS1JuTEs4b1ZtM3JV?=
 =?utf-8?B?eUJwMmRISlc5UW1qM1FHZHo0d0owYitzcjNjcjQva2JHWVY4ckxHZWNCbU1Y?=
 =?utf-8?B?cHQ2YjlLMGx0NEQ1TUZWTWFQRy9vZEtGOThjK1ZGRjFyZjBJM3lwVFBiVkpJ?=
 =?utf-8?B?SThPZUJXM1d4SEdqZ1hJTHJoU0d6cTZ0REI4MVRndUtnNkR1VXQ0SzZyK3pt?=
 =?utf-8?B?Y0FIVFFVcW5wZm1GWk94bFF0WGpLNHhpNEZxKzZ0UkFGMnpsdWxVNTF0eFFs?=
 =?utf-8?B?dXh1bFpHZUw2VjVRNG9NOXo1U29EdTl2aUw1eHpYMUV0QkdEL2ljUTFBMWlY?=
 =?utf-8?B?aFI5SWJ6Rlk4c1oyK212WUVrUCs2N2MzdDFxS0RCSXJkYXFEYUVRSGQrRWE3?=
 =?utf-8?B?Y3F3anhlMlRUcU5GUUdDMGZxZ25lNFdQUldEdWxHbWFULzdocEp6d1FZNkZK?=
 =?utf-8?B?U0NRQlMzcTZ0QjFjcjhrckxiaU5ReWE3ODhHRzFtREFFR0R5c2RoTS9rNEZw?=
 =?utf-8?B?QlVvNlQwYWluR2szL043dEJzTWdGVitaRDR5YzNKcWo4dHhBVWRvd0d6alRx?=
 =?utf-8?B?TllSdHp6WXIyMGFnaUdaU1ZpRHhIY3Y3WW5kT3gweXBBSzJZeThqaFNjL1Ev?=
 =?utf-8?B?NWNoY3dSeVZScjJ3ekFON3BEMTVkVFlrcUhWbHJOZTlrMDJWdzR1OXhCVUtY?=
 =?utf-8?B?clZVeUtBdWNUbFQ4dUQ5ZmN1a3R0ZjMzdXp5Uk1rWFVqYng0dU5HSjhIbkRG?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C1B95B903B0E148A1504250CF426A65@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB3434.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aabc718-ef14-4821-42ac-08db0c23dfe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 11:34:02.2215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3Ozf5BzP6otGJJIFVN7/ZaXc6iJK4ty4xu82c1g5pM4X0n+U53cGX5TabjjedcEvWKjZMmrNWp28j3rftP6jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5639
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMgU2lyLA0KDQpPbiBNb24sIDIwMjMtMDItMDYgYXQgMTM6MDkgKzAxMDAsIE1h
dHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+IA0KPiBPbiAwNi8wMi8yMDIzIDAzOjAxLCBSb2dlciBM
dSAo6Zm455Ge5YKRKSB3cm90ZToNCj4gPiBIaSBNYXR0aGlhcyBTaXIsDQo+ID4gDQo+ID4gDQo+
ID4gT24gVGh1LCAyMDIzLTAyLTAyIGF0IDExOjI5ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdy
b3RlOg0KPiA+ID4g5L2g5aW977yMDQo+ID4gDQo+ID4gSSBnb3Qgc2hvY2sgYW5kIHRob3VnaHQg
c29tZW9uZSB1c2VkIHlvdXIgbmFtZSB0byByZXBseS4gSG93ZXZlciwNCj4gPiB5b3VyIGVtYWls
IGFjY291bnQgaGVscHMgbWUgY2xlYXIgbXkgbWluZC4gSGFoYS4uIE5pY2UgYW5kIHdhcm0gdG8g
c2VlDQo+ID4gbWFuZGFyaW4NCj4gPiBvbiBwYXRjaHdvcmsuIEl0J3Mgc28gZnJlc2ggYW5kIGV4
Y2l0aW5nIDotKS4NCj4gPiANCj4gDQo+IOiwouiwouOAgiBJJ20gbGVhcm5pbmcgbWFpbmxhbmQg
Q2hpbmVzZSBmb3IgYSBmZXcgbW9udGggbm93LCBJIGFsc28gbGVhcm5lZCB0aGF0DQo+IHlvdSAN
Cj4gdXNlIGRpZmZlcmVudCBzeW1ib2xzIGluIFRhaXdhbiwgd2hpY2ggSSBkb24ndCBrbm93LiDl
r7nkuI3otbfjgIINCg0KSGEuIEJvdGggc3ltYm9scyBhcmUgd2VsY29tZSB0byBtZS4gIDotKQ0K
DQo+IA0KPiA+ID4gDQo+ID4gPiBPbiAwMS8wMi8yMDIzIDEzOjI4LCBSb2dlciBMdSAo6Zm455Ge
5YKRKSB3cm90ZToNCj4gPiA+ID4gSGkgTWF0dGhpYXMgU2lyLA0KPiA+ID4gPiANCj4gPiA+ID4g
T24gVHVlLCAyMDIzLTAxLTMxIGF0IDE0OjE5ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIDExLzAxLzIwMjMgMDg6NDUsIFJvZ2VyIEx1IHdy
b3RlOg0KPiA+ID4gPiA+ID4gSW4gTWVkaWFUZWsgSFcgZGVzaWduLCBzdnMgYW5kIHRoZXJtYWwg
Ym90aCB1c2UgdGhlIHNhbWUgY2xrIHNvdXJjZS4NCj4gPiA+ID4gPiA+IEl0IG1lYW5zIHRoYXQg
c3ZzIGNsayByZWZlcmVuY2UgY291bnQgZnJvbSBDQ0YgaW5jbHVkZXMgdGhlcm1hbA0KPiA+ID4g
PiA+ID4gY29udHJvbA0KPiA+ID4gPiA+ID4gY291bnRzLiBUaGF0IG1ha2VzIHN2cyBkcml2ZXIg
Y29uZnVzZSB3aGV0aGVyIGl0IGRpc2FibGVkIHN2cydzIG1haW4NCj4gPiA+ID4gPiA+IGNsaw0K
PiA+ID4gPiA+ID4gb3Igbm90IGZyb20gQ0NGJ3MgcGVyc3BlY3RpdmUgYW5kIGxlYWQgdG8gdHVy
biBvZmYgdGhlaXIgc2hhcmVkIGNsaw0KPiA+ID4gPiA+ID4gdW5leHBlY3RlZGx5LiBUaGVyZWZv
cmUsIHdlIGFkZCBzdnMgY2xrIGNvbnRyb2wgQVBJcyB0byBtYWtlIHN1cmUNCj4gPiA+ID4gPiA+
IHN2cydzDQo+ID4gPiA+ID4gPiBtYWluIGNsayBpcyBjb250cm9sbGVkIHdlbGwgYnkgc3ZzIGRy
aXZlciBpdHNlbGYuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEhlcmUgaXMgYSBORyBleGFt
cGxlLiBSZWx5IG9uIENDRidzIHJlZmVyZW5jZSBjb3VudCBhbmQgY2F1c2UNCj4gPiA+ID4gPiA+
IHByb2JsZW0uDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IHRoZXJtYWwgcHJvYmUgKGNsayBy
ZWYgPSAxKQ0KPiA+ID4gPiA+ID4gLT4gc3ZzIHByb2JlIChjbGsgcmVmID0gMikNCj4gPiA+ID4g
PiA+ICAgICAgIC0+IHN2cyBzdXNwZW5kIChjbGsgcmVmID0gMSkNCj4gPiA+ID4gPiA+ICAgICAg
ICAgIC0+IHRoZXJtYWwgc3VzcGVuZCAoY2xrIHJlZiA9IDApDQo+ID4gPiA+ID4gPiAgICAgICAg
ICAtPiB0aGVybWFsIHJlc3VtZSAoY2xrIHJlZiA9IDEpDQo+ID4gPiA+ID4gPiAgICAgICAtPiBz
dnMgcmVzdW1lIChlbmNvdW50ZXIgZXJyb3IsIGNsayByZWYgPSAxKQ0KPiA+ID4gPiA+ID4gICAg
ICAgLT4gc3ZzIHN1c3BlbmQgKGNsayByZWYgPSAwKQ0KPiA+ID4gPiA+ID4gICAgICAgICAgLT4g
dGhlcm1hbCBzdXNwZW5kIChGYWlsIGhlcmUsIHRoZXJtYWwgSFcgY29udHJvbCB3L28gY2xrKQ0K
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBGaXhlczogYTgyNWQ3MmY3NGEzICgic29jOiBtZWRp
YXRlazogZml4IG1pc3NpbmcNCj4gPiA+ID4gPiA+IGNsa19kaXNhYmxlX3VucHJlcGFyZSgpDQo+
ID4gPiA+ID4gPiBvbg0KPiA+ID4gPiA+ID4gZXJyIGluIHN2c19yZXN1bWUoKSIpDQo+ID4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBMdSA8cm9nZXIubHVAbWVkaWF0ZWsuY29tPg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IFRoYXQgbG9va3Mgd3JvbmcuIEFsdGhvdWdoIEkgZG9uJ3Qgb3V0
IG9mIG15IG1pbmQsIHRoZXJlIHNob3VsZCBiZSBhDQo+ID4gPiA+ID4gd2F5DQo+ID4gPiA+ID4g
dG8NCj4gPiA+ID4gPiB0ZWxsDQo+ID4gPiA+ID4gdGhlIGNsb2NrIGZyYW1ld29yayB0aGF0IHRo
aXMgY2xvY2sgaXMgc2hhcmVkIGJldHdlZW4gc2V2ZXJhbCBkZXZpY2VzLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IEkgd29uZGVyIGlmIHVzaW5nIGNsa19lbmFibGUgYW5kIGNsa19kaXNhYmxlIGlu
IHN2c19yZXN1bWUvc3VzcGVuZA0KPiA+ID4gPiA+IHdvdWxkbid0DQo+ID4gPiA+ID4gYmUNCj4g
PiA+ID4gPiBlbm91Z2guDQo+ID4gPiA+IA0KPiA+ID4gPiBPaCB5ZXMsIENvbW1vbiBDbG9jayBG
cmFtZXdvcmsgKENDRikga25vd3MgdGhlIGNsb2NrIHNoYXJlZCBiZXR3ZWVuDQo+ID4gPiA+IHNl
dmVyYWwNCj4gPiA+ID4gZGV2aWNlcyBhbmQgbWFpbnRhaW5zIGNsb2NrICJvbi9vZmYiIGJ5IHJl
ZmVyZW5jZSBjb3VudC4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFRoZSB0aGluZyBpcyBpZiB5
b3UgdXNlIGNsa19wcmVwYXJlX2VuYWJsZSB0aGVuIHRoZSBjbG9jayBmcmFtZXdvcmsNCj4gPiA+
IGNoZWNrJ3MNCj4gPiA+IGlmDQo+ID4gPiB0aGUgY2xvY2sgaXMgYWxyZWFkeSBwcmVwYXJlZCwg
d2hpY2ggY291bGQgaGFwcGVuIGxpa2UgeW91IGRlc2NyaWJlZCBpbg0KPiA+ID4gdGhlDQo+ID4g
PiBzdnNfcmVzdW1lIChlbmNvdW50IGVycm9yKSBjYXNlIGluIHRoZSBjb21taXQgbWVzc2FnZS4g
VGhlIHF1ZXN0aW9uIGlzLA0KPiA+ID4gY2FuJ3QNCj4gPiA+IHdlDQo+ID4gPiBqdXN0IHVzZSBj
bGtfZW5hYmxlIGFuZCBjbGtfZGlzYWJsZSBpbiByZXN1bWUvc3VzcGVuZCBhbmQgb25seSBwcmVw
YXJlIHRoZQ0KPiA+ID4gY2xvY2sNCj4gPiA+IGluIHRoZSBwcm9iZSBmdW5jdGlvbj8NCj4gPiAN
Cj4gPiBXZSdsbCB0aGluayBpZiB0aGlzIGNhbiBmaXggdGhlIHByb2JsZW0uIFRoYW5rcyBmb3Ig
dGhlIGFkdmljZSB2ZXJ5IG11Y2guDQo+ID4gDQo+ID4gPiANCj4gPiA+ID4gV2UgY29uY2VybiBo
b3cgdG8gc3RvcCBydW5uaW5nIHN2c19zdXNwZW5kKCkgd2hlbiBzdnMgY2xrIGlzIGFscmVhZHkN
Cj4gPiA+ID4gZGlzYWJsZWQgYnkNCj4gPiA+ID4gc3ZzX3Jlc3VtZSgpLiBUYWtlIGFuIGV4YW1w
bGUgYXMgYmVsb3csIGlmIHdlIHJlZmVycyB0bw0KPiA+ID4gPiBfX2Nsa19pc19lbmFibGVkKCkN
Cj4gPiA+ID4gcmVzdWx0IGZvciBrbm93aW5nIHN2cyBjbGsgc3RhdHVzLCBpdCB3aWxsIHJldHVy
biAidHJ1ZSIgYWxsIHRoZSB0aW1lDQo+ID4gPiA+IGJlY2F1c2UNCj4gPiA+ID4gdGhlcm1hbCBj
bGsgaXMgc3RpbGwgb24uIFRoaXMgY2F1c2VzIHRoZSBwcm9ibGVtIG1lbnRpb25lZCBpbiBjb21t
aXQNCj4gPiA+ID4gbWVzc2FnZS4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEkgd291bGQgZXhw
ZWN0IHRoYXQgdGhlIGtlcm5lbCB0YWtlcyBjYXJlIHRoYXQgd2UgY2FuJ3QgZW50ZXIgYSByZXN1
bWUNCj4gPiA+IHBhdGgNCj4gPiA+IGZvcg0KPiA+ID4gYSBkZXZpY2UgYmVmb3JlIHRoZSBzdXNw
ZW5kIHBhdGggaGFzIGZpbmlzaGVkLiBIb25lc3RseSBJIGRvbid0IHJlYWxseQ0KPiA+ID4gdW5k
ZXJzdGFuZCB0aGUgcHJvYmxlbSBoZXJlLiBJdCBzZWVtcyBzb21ldGhpbmcgZGlmZmVyZW50IHRo
ZW4gd2hhdCB5b3UNCj4gPiA+IGRlc2NyaWJlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+ID4g
PiANCj4gPiA+IFBsZWFzZSBoZWxwIG1lIHVuZGVyc3RhbmQgYmV0dGVyLg0KPiA+IA0KPiA+IEkg
c2VlLiBUaGlzIHBhdGNoIHRpdGxlIG5lZWRzIHRvIGJlIGNoYW5nZWQgdG8gImF2b2lkIHR1cm5p
bmcgb2ZmIHN2cyBjbGsNCj4gPiB0d2ljZQ0KPiA+IHVuZXhwZWN0ZWRseSIgZm9yIHBvaW50aW5n
IG91dCB0aGUgcHJvYmxlbSBwcmVjaXNlbHkuIFdlIHNhdyBhIGxvb3Bob2xlIHRoYXQNCj4gPiBz
dnMNCj4gPiBjbGsgbWlnaHQgYmUgdHVybmVkIG9mZiBpbiBzdnNfcmVzdW1lKCkgZmlyc3QgYW5k
IGluIHN2c19zdXNwZW5kKCkgYWdhaW4NCj4gPiB3aXRob3V0DQo+ID4gZW5hYmxpbmcgc3ZzIGNs
ayBkdXJpbmcgdGhlc2UgdGhlIHByb2Nlc3MuIFRoZXJlZm9yZSwgd2UgdHJ5IHRvIGZpeCBpdCBi
eQ0KPiA+IHRoaXMNCj4gPiBwYXRjaC4gQmVsb3cgaXMgb3VyIHRoaW5raW5nIHByb2Nlc3MgdG8g
ZXhwbGFpbiBob3cgd2UgZ290IGhlcmUuDQo+ID4gDQo+ID4gMS4gKGFiYW5kb25lZCkgV2UgYWRk
IF9fY2xrX2lzX2VuYWJsZWQoKSBjaGVjayBpbiBzdnNfc3VzcGVuZCgpIHRvIHByZXZlbnQNCj4g
PiBzdnMNCj4gPiBjbGsgZnJvbSBiZWluZyB0dXJuZWQgb2ZmIHR3aWNlIHdoZW4gc3ZzX3Jlc3Vt
ZSgpIHR1cm5lZCBvZmYgc3ZzIGNsayBpbiB0aGUNCj4gPiBlcnJvci1oYW5kbGluZyBwcm9jZXNz
LiBOb25ldGhlbGVzcywgd2UgbWV0IHRoZSBORyBjYXNlIGluIHRoZSBjb21taXQNCj4gPiBtZXNz
YWdlLg0KPiA+IDIuIChjdXJyZW50IHBhdGNoKSBXZSBhZGQgc3ZzIGNsayBjb250cm9sIGhpbnQg
dG8gdW5kZXJzdGFuZCBpZiB3ZSBuZWVkIHRvDQo+ID4gcnVuDQo+ID4gc3ZzX3N1c3BlbmQoKSBv
ciBub3QgaWYgc3ZzX3Jlc3VtZSgpIHR1cm5lZCBvZmYgc3ZzIGNsayBiZWZvcmUuDQo+ID4gDQo+
IA0KPiBEaWQgeW91IGhhZCBhIGxvb2sgb24gdGhlIGRldl9wbV9vcHPvvJ8gTWF5YmUgd2UgY2Fu
IHVzZSBzdXNwZW5kX2xhdGUsIA0KPiByZXN1bWVfZWFybHkgdG8gbWFrZSBzdXJlIHRoZXJlIGlz
IG5vIHJhY2UgY29uZGl0aW9uLiBJIHdvbmRlciBhbHNvIGlmIHdlDQo+IGNhbid0IA0KPiBtYWtl
IHN1cmUgdGhhdCB0aGlzIGRvZXMgbm90IGhhcHBlbiB1c2luZyBkZXZpY2UgbGlua3MuIFNvcnJ5
LCBJIGNhbid0IGdpdmUgDQo+IGJldHRlciBndWlkYW5jZSBvbiBob3cgdG8gdXNlIHRoaXMgdGVj
aG5vbG9naWVzLCBidXQgSSBoYXZlIHRoZSBmZWVsaW5nIHdlDQo+IGNhbiANCj4gZml4IHRoaXMg
d2l0aCBleGlzdGluZyBpbmZyYXN0cnVjdHVyZS4NCg0KTm8sIHdlIGRpZG4ndCBsb29rIG9uIGRl
dl9wbV9vcHMgYW5kIGl0IHNlZW1zIGxpa2UgYW5vdGhlciB3YXkgdG8gZml4IHRoaXMgaXNzdWUN
CndpdGggX19jbGtfaXNfZW5hYmxlZCgpIGNoZWNrIGluIHN2c19zdXNwZW5kKCkuIFRoYW5rcyBm
b3IgdGhlIGFkdmljZSBhZ2Fpbi4NCndlJ2xsIGtlZXAgbG9va2luZyBmb3IgYW55IHBvc3NpYmxl
IGFuc3dlcnMgdG8gdGhpcyBpc3N1ZS4NCg0KU2luY2VyZWx5LA0KUm9nZXIgTHUuDQoNCg==
