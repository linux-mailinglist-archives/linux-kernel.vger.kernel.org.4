Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C513367FC48
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 03:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjA2CMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 21:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA2CMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 21:12:03 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EA82278E
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 18:11:59 -0800 (PST)
X-UUID: 4c30472e9f7a11ed945fc101203acc17-20230129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=30SSnO7qx6MnN6mfmHxwzljdfVMCUCxClCM7lh0+rJY=;
        b=TZbPYm4iHI3q0P8ChY2BXL7ZAWztDZEBNOBTf1OK30QiwAx3V9LRH9IZNtuVhyG/8qV5EoBt1JfZhyVYJUwBJ2go8Bx5A8QKpnu32WYk2rnBzrzLL6v9SxOHqs2/V43BKVk9PJWGy66ohv9yAlB5coswykPCkiihma0iXMvlw9E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:069314ab-76e2-4145-81aa-6741b4eb7a54,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:3ca2d6b,CLOUDID:589acaf6-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 4c30472e9f7a11ed945fc101203acc17-20230129
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 415328906; Sun, 29 Jan 2023 10:11:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 29 Jan 2023 10:11:51 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sun, 29 Jan 2023 10:11:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKWOTLOrt9ZHyBOSJ8XANP3X68TlonPsMHpFPjxBkS6D9R7oMU9n/ZWA4ooppr5yJSUhhXnudQbgjC0db66WwzlEpu/PrIF18A9sqC8V5FpywoKHW8KS0LFIqcVCepvz7I2+EOozXcTQrh6LC5Ciupzc5w+YnlV9OH2rfjz19CVUwd5dsdQvKzvn2vmxU9nJTB/bqDrSzg6kp2snq5xoMCsuwfbr5+JK8m/EIwg5+/WI5TtT/a20O3m5mghCZrHvrxVEKiXKhnTbECrVgOv658A/LEhq4upXBqZmhDhY2eQCMvGDawbyjqhA6kmMpKSoqHv1EBIgl/T28ZaPX/fC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30SSnO7qx6MnN6mfmHxwzljdfVMCUCxClCM7lh0+rJY=;
 b=T8NNZizi/cEtOYOqRroVfVadS3E0DMZZTzIiIrRNXSyEvhDRkTFYiXmLLCwzqnYSfYYylBsSD2lTE1a8LRVoOjMojqfeek7rPvSHkUf9KSBLLDcpbM/HCnylzJHvXQ4slo2lXgR2m+K8V/DhOD1kVczaYuwrm0TEWNYCa54Y6YwUTjqY6iVPSfYSnMjGtHdjQBxkRb9afV/55zGD75OHZp0h7bVus4nEyRes9atIdpIF/1M0RarS8ZDVYronWkKpM1aJLL4rId6WwkC+ux8ecHxupAt3YwMGumKVzmx+VXXHnLjts82qeKHUdrnsUjY/7xSoZ6rgODgXqv1C2ip4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30SSnO7qx6MnN6mfmHxwzljdfVMCUCxClCM7lh0+rJY=;
 b=trl6IIXPeE0xHHEl4+EaTw9ZR0Mq084EwXc4/aYowPgiN5X22wniSwIwblkUOT9YhUOYMugKq1HWtsSSywixu6ZVQRian+xFpscmGZdLBuY2OGVQ3uT4AStPIkVEDn0yH2cAyIaJf27WviJE/4YXmpGxC8xYR0Y0x/Ag2zjmnXw=
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com (2603:1096:301:b4::11)
 by TYZPR03MB6469.apcprd03.prod.outlook.com (2603:1096:400:1cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Sun, 29 Jan
 2023 02:11:49 +0000
Received: from PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::c43a:ce45:4a27:bd80]) by PUZPR03MB5964.apcprd03.prod.outlook.com
 ([fe80::c43a:ce45:4a27:bd80%5]) with mapi id 15.20.6043.031; Sun, 29 Jan 2023
 02:11:49 +0000
From:   =?utf-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>
To:     "andreyknvl@gmail.com" <andreyknvl@gmail.com>
CC:     "andreyknvl@google.com" <andreyknvl@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "glider@google.com" <glider@google.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3] kasan: infer allocation size by scanning metadata
Thread-Topic: [PATCH v3] kasan: infer allocation size by scanning metadata
Thread-Index: AQHZMylWg6CakGr5YUCWiMoGh+lg9660a+mAgAA72gA=
Date:   Sun, 29 Jan 2023 02:11:49 +0000
Message-ID: <60c63554d2acef7b93d589909f0df5f89d2deb45.camel@mediatek.com>
References: <20230128150025.14491-1-Kuan-Ying.Lee@mediatek.com>
         <CA+fCnZdSvTR=Ug3P9ZVxq9AG9Dh+TqLxDMRVOhvE8Sr1a2Oq4w@mail.gmail.com>
In-Reply-To: <CA+fCnZdSvTR=Ug3P9ZVxq9AG9Dh+TqLxDMRVOhvE8Sr1a2Oq4w@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5964:EE_|TYZPR03MB6469:EE_
x-ms-office365-filtering-correlation-id: f9cb0e14-d616-4201-8d2d-08db019e2e5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ff6C0AgDvmNa2MeRZy0/rQnO3VXZokh55/pkVrXGry27D6AZVPRtLOhHu6Ntzo1jTWjD9WNwnCZ6TaAX8zXMCSVHkRaiq0FpxbA1cAGbs+c5IwdXr6iIe5Z2RfnG/6WTGfxKb6+7pic10gP1T4ysaAXOMZCwtik43bOz6wgKeJqnsvIpvzohUW5DbrjIxgrw3skoLby+PxW7mnys51EVH9sP3fgIY5IfpqMImUBaZgsyU1873wm4ZNURR+b/GRhqtVSxdpIkNypJKbWbtdLYWlyNw1WtTLqZx6WCRynW1VIOJOHPvD7NfrHi+J9gLPvq8q9ZQ0wQDMB5gu4HOPMxsw4FTVAYpMO/5QMBqMnbZS5ePOem/zA2abMbSBo1LFz0paX9QLnfAJ0PyT6jiB/vq+pA0H13ZPVXo+sayVq+37OBdG3NxUDTzu0Wl61VtDVJh8byWZZKYJWl+ceKLBuymTHZBsQ2+egx/HFcd+TrhVXn8RxZ+kA7Pa6KueiFZ/2P2BGlC6kQc7h3JpJ2eTWbI8E9ifOws1QwQpjp2DaEVTlGIOhPEXACLrwFOmswNmfDBjc6rGCgBnGD/bg95/bGmXp7eXREt/gYWJkZcX1UsrMZr89ePC3P4jyRMsQ9RDLvctcRuO5E828ryAyNZHXs+Nr2KuqTMz+WEtmFfO3bjIVc1Pq1hdFhKIScrkVtsmZr7mMsTBS0hscv96jd/UlNnAlD/NvSjDbGDr77SHs4KMqk98WY6/XR7z3tEpx+pg2XtKXJkPoH1F5Jgt5WsqaYfSkJBmaFXVJfXP8inFgy12o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5964.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199018)(38070700005)(38100700002)(122000001)(86362001)(85182001)(36756003)(2906002)(41300700001)(71200400001)(54906003)(478600001)(6486002)(966005)(7416002)(8936002)(5660300002)(66556008)(316002)(64756008)(8676002)(66946007)(66476007)(76116006)(6916009)(4326008)(91956017)(66446008)(83380400001)(6512007)(186003)(26005)(6506007)(2616005)(99106002)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGg0amlVSWZaZ2w4R01Ed3hCREh6M0xpTm5EMEVoMDBOOUpSUUFJQjR0a3Rn?=
 =?utf-8?B?VEswa1gyMnRVWW5rY2VLc1lKdmYyeUtkNnRmQXkvdWJ6UnBlM1EwbHpJeFNs?=
 =?utf-8?B?UGxwaDAxZHRCV1V0WklyRUhDWXp0TjhnWkllanZVNVVKKzhyV1hNYUtQTTBL?=
 =?utf-8?B?SjgrK1kxNkJza1J1b05UWUVxNER3MTJjNlFNNUNWL3RoZmdQL0gzd1BkWFZJ?=
 =?utf-8?B?aG5QWjN2dDNxWUQvbzJjd3JhL1QxZ2dPZGtIQy8yUDAwa1V5Rlo1bjEwQm93?=
 =?utf-8?B?eE1ZeDlqdi80bVRySjNBcXBsNlE1aUFwZ09XeFIvMTlmaE91UXZrVmVRYnJr?=
 =?utf-8?B?elpWMk4xUWZmSzN1TEpMRGF1cHhvem14L3IrS1Zzc054eTZRVmRwZXd1ai9h?=
 =?utf-8?B?NXorR0g0UDdrSzZ0d1BOdXRxeEpieEt6MUcvREZzWlpBZ3JEODB4bjhxT1Bv?=
 =?utf-8?B?ZndWaTZjVFZ6T1ZReCt0eitMUEpIZ3lTT25ER3NoaDZ4d0FEbEhOVUZyb2Rm?=
 =?utf-8?B?OFNHOU82ckhrZTNROE9FQk1RSU5nQjlwVXFmUk9QZENObUI5bEJJUFFNQzZq?=
 =?utf-8?B?S2lkWkJLYnJGdmFJcTZHUnpaWTJnQTg2QUtFQk5iSEU1SXpjcVAxKzV3QTc5?=
 =?utf-8?B?WGZIcjlnTE9GeWdpZCtzcTRaakZPSWVJNmVkdGZWVGx6M0FNb0NNZUNOR3FC?=
 =?utf-8?B?NWFXazA1WmJqV2tNLys0bVhqS3JPZDdtNFI0MEdKdGNwMzMvL1pGUi9JVDB4?=
 =?utf-8?B?MytpQy9BZ2hUUnpEOWgyOVRSSzNGK2I3bmc5aTI2YU1neUtGcFVmNmNlcGZR?=
 =?utf-8?B?UWhOS3JBejlIZ3Z2RE5jN0lBSEFSQzZCM0xuS3FLajBKcTdyTFVjRHI4S2pz?=
 =?utf-8?B?bUJjelhBQnF1Qk52QVREUHllUEgrK0c2MktIMHdOd01BSlRMMjNreVZNc2Jr?=
 =?utf-8?B?blRtZ095LzQ1dm9KVGJTd0JVNmZKSGRhT2trVENkT0svQVBvV3hZK3puOUNn?=
 =?utf-8?B?VE1mOGhvdUY1YUxMZ1YyTU1MM0ZDSmIxVWZjVU5ub0d4ZkIxZVBJVi9pZWI1?=
 =?utf-8?B?cHh4Sll3SVh0ZzlXSk5mMW56Wk1EeEVoMTBGdWRWVGJYN2M0MzNvV1Zxd1BG?=
 =?utf-8?B?ZkV1WDlhQXdOQkFWNFVBa29qbmhGVFdvYTV1NTlCU2J3NTJhUXpjbHVxN3Ra?=
 =?utf-8?B?NllEcWVPd3E5RFhiUFNPTGFXaGgvekZIMmkwS2VaT0ZTOXkxSlNVQXRUTSt4?=
 =?utf-8?B?VUZ1MVY3bmFRQUh1VnlNUmcyZ1llV25mSzdYTWJmYTNSNm1INzVQMmppaE83?=
 =?utf-8?B?Rzgvd3k4WG9nT01HQlFOcmJoT3dxWWZyZmtsbVQ0cWp0Qk54SGpXZnN0b2lJ?=
 =?utf-8?B?dEwzNHhTazZxdVZabjdYTnlTeUhZZFFVV0liRFRVR0hxZVlOTnRpb3phanlH?=
 =?utf-8?B?aHRJVC9sTlhncWh4dERucTlYK2d2ODYrbk5CTnkvNVFlNVJMWEU5RzBxc3k3?=
 =?utf-8?B?UCtuVFozNmpOTmkreGQrbHJMVnIvODhuWDZLby8xZkRHeHhNQjFSZnJRMXhv?=
 =?utf-8?B?WWtOMjJOS05NdldDRFhMSnVqeU93c3Q2QWRIMVhzck1DY0IvbXE5RkI2a3JW?=
 =?utf-8?B?TUphajR3UHJNN2FzSlhGSXRYajd4VVVCZmxkTGQ1Z0s4Y1JHUXBNQXpNUDZB?=
 =?utf-8?B?SjlVMkhjbzNQckQwY0xhSzJUeFh6ek4xMytEdjNMeFJqT1oxSFRpWG9aT3cw?=
 =?utf-8?B?Z0kwaVNNTzdxakZJRnhxM2xUNUdIbDFma3BjVEVubDI3NVZYb0J4N1Rka084?=
 =?utf-8?B?Nk9JVDdPS0NjU0ZDVm1DL2wvUlVqNzd2YTJNd0lHVG1uMGJyV3ZnQStuNnFv?=
 =?utf-8?B?SFN1dFY2aVRyQzVPRWg2NjJpczZOa1k0cVJUNjErT0VDQ1ZCRVJGVDZRQWw5?=
 =?utf-8?B?RXpyam8yMGNvTENuTkROcFZ3UzVNNE0zaTJDYi9aQlQrRGZzRzAwbm4ySExq?=
 =?utf-8?B?NzB3MTVObEpBb0FRMGdxTWlxWisxOGY5NkhybmQ1amdQR1ZPYXZ6K25kZzhF?=
 =?utf-8?B?MVgzMGNKK1lXbzNpTU5YZGdMSU9TeWR5TldmWkNKcU84SUxNUWdMR1pGdkFE?=
 =?utf-8?B?OVUyeG1jbEMxZ3lGL09nQXE0WmZhM2VsaFFQalAzdHoyc3k0bWRpZlBaL1NT?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0E6E644C662FB4B82B82CBD2FC2B8E1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5964.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cb0e14-d616-4201-8d2d-08db019e2e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2023 02:11:49.7113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+FqJODXFznoE/KQL0WC0fspEzgno0zAjDCfB35q94dtQ7vftMQQUpuz9q2XE0rHO3zvXyG2zSkb7AcTUiU0PJ8LHhxiPg32avVrarN0zrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6469
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTAxLTI4IGF0IDIzOjM3ICswMTAwLCBBbmRyZXkgS29ub3ZhbG92IHdyb3Rl
Og0KPiAvT24gU2F0LCBKYW4gMjgsIDIwMjMgYXQgNDowMCBQTSBLdWFuLVlpbmcgTGVlDQo+IDxL
dWFuLVlpbmcuTGVlQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gRnJvbTogQW5kcmV5
IEtvbm92YWxvdiA8YW5kcmV5a252bEBnb29nbGUuY29tPg0KPiANCj4gQWgsIEkgdGhpbmsgeW91
IG5lZWQgdG8gcmVzZXQgdGhlIGNvbW1pdCBhdXRob3IgYmVmb3JlIHNlbmRpbmcsIHNvDQo+IHRo
YXQgdGhlIHBhdGNoIGdldHMgcmVjb3JkZWQgYXMgYXV0aG9yZWQgYnkgeW91Lg0KDQpHb3QgaXQu
DQpXaWxsIGRvIGluIHY0Lg0KDQo+ID4gTWFrZSBLQVNBTiBzY2FuIG1ldGFkYXRhIHRvIGluZmVy
IHRoZSByZXF1ZXN0ZWQgYWxsb2NhdGlvbiBzaXplDQo+ID4gaW5zdGVhZCBvZg0KPiA+IHByaW50
aW5nIGNhY2hlLT5vYmplY3Rfc2l6ZS4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIGZpeGVzIGNvbmZ1
c2luZyBzbGFiLW91dC1vZi1ib3VuZHMgcmVwb3J0cyBhcyByZXBvcnRlZA0KPiA+IGluOg0KPiA+
IA0KPiA+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vYnVnemlsbGEua2Vy
bmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE2NDU3X187ISFDVFJOS0E5d01nMEFSYnchbVhXNFow
NWRYOVlYbkJZV3h3LU9PQll1dHFCTTBKRm9hQXBLNjFsRkNTbGRwdHNWaTBKRXRXTlNVOXVhU25Y
YkdxNW9pS0NCZnlITEZGdEVtWTV1RmdEbCTCoA0KPiA+ICANCj4gPiANCj4gPiBBcyBhbiBleGFt
cGxlIG9mIHRoZSBjb25mdXNpbmcgYmVoYXZpb3IsIHRoZSByZXBvcnQgYmVsb3cgaGludHMNCj4g
PiB0aGF0IHRoZQ0KPiA+IGFsbG9jYXRpb24gc2l6ZSB3YXMgMTkyLCB3aGlsZSB0aGUga2VybmVs
IGFjdHVhbGx5IGNhbGxlZA0KPiA+IGttYWxsb2MoMTg0KToNCj4gPiANCj4gPiA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4gPiBCVUc6IEtBU0FOOiBzbGFiLW91dC1vZi1ib3VuZHMgaW4gX2ZpbmRfbmV4dF9iaXQrMHgx
NDMvMHgxNjANCj4gPiBsaWIvZmluZF9iaXQuYzoxMDkNCj4gPiBSZWFkIG9mIHNpemUgOCBhdCBh
ZGRyIGZmZmY4ODgwMTc1NzY2YjggYnkgdGFzayBrd29ya2VyLzE6MS8yNg0KPiA+IC4uLg0KPiA+
IFRoZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8gdGhlIG9iamVjdCBhdCBmZmZmODg4MDE3NTc2
NjAwDQo+ID4gIHdoaWNoIGJlbG9uZ3MgdG8gdGhlIGNhY2hlIGttYWxsb2MtMTkyIG9mIHNpemUg
MTkyDQo+ID4gVGhlIGJ1Z2d5IGFkZHJlc3MgaXMgbG9jYXRlZCAxODQgYnl0ZXMgaW5zaWRlIG9m
DQo+ID4gIDE5Mi1ieXRlIHJlZ2lvbiBbZmZmZjg4ODAxNzU3NjYwMCwgZmZmZjg4ODAxNzU3NjZj
MCkNCj4gPiAuLi4NCj4gPiBNZW1vcnkgc3RhdGUgYXJvdW5kIHRoZSBidWdneSBhZGRyZXNzOg0K
PiA+ICBmZmZmODg4MDE3NTc2NTgwOiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYyBmYyBmYyBm
YyBmYyBmYyBmYyBmYw0KPiA+ICBmZmZmODg4MDE3NTc2NjAwOiAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KPiA+ID4gZmZmZjg4ODAxNzU3NjY4MDogMDAg
MDAgMDAgMDAgMDAgMDAgMDAgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMNCj4gPiANCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiA+ICBmZmZmODg4MDE3
NTc2NzAwOiBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYw0K
PiA+ICBmZmZmODg4MDE3NTc2NzgwOiBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBm
YyBmYyBmYyBmYyBmYw0KPiA+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+IA0KPiA+IFdpdGggdGhpcyBwYXRjaCwg
dGhlIHJlcG9ydCBzaG93czoNCj4gPiANCj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiAuLi4NCj4gPiBUaGUg
YnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBvYmplY3QgYXQgZmZmZjg4ODAxNzU3NjYwMA0K
PiA+ICB3aGljaCBiZWxvbmdzIHRvIHRoZSBjYWNoZSBrbWFsbG9jLTE5MiBvZiBzaXplIDE5Mg0K
PiA+IFRoZSBidWdneSBhZGRyZXNzIGlzIGxvY2F0ZWQgMCBieXRlcyB0byB0aGUgcmlnaHQgb2YN
Cj4gPiAgYWxsb2NhdGVkIDE4NC1ieXRlIHJlZ2lvbiBbZmZmZjg4ODAxNzU3NjYwMCwgZmZmZjg4
ODAxNzU3NjZiOCkNCj4gPiAuLi4NCj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiANCj4gPiBBbHNvIHJlcG9y
dCBzbGFiIHVzZS1hZnRlci1mcmVlIGJ1Z3MgYXMgInNsYWItdXNlLWFmdGVyLWZyZWUiIGFuZA0K
PiA+IHByaW50DQo+ID4gImZyZWVkIiBpbnN0ZWFkIG9mICJhbGxvY2F0ZWQiIGluIHRoZSByZXBv
cnQgd2hlbiBkZXNjcmliaW5nIHRoZQ0KPiA+IGFjY2Vzc2VkDQo+ID4gbWVtb3J5IHJlZ2lvbi4N
Cj4gPiANCj4gPiBBbHNvIGltcHJvdmUgdGhlIG1ldGFkYXRhLXJlbGF0ZWQgY29tbWVudCBpbg0K
PiA+IGthc2FuX2ZpbmRfZmlyc3RfYmFkX2FkZHINCj4gPiBhbmQgdXNlIGFkZHJfaGFzX21ldGFk
YXRhIGFjcm9zcyBLQVNBTiBjb2RlIGluc3RlYWQgb2Ygb3Blbi1jb2RpbmcNCj4gPiBLQVNBTl9T
SEFET1dfU1RBUlQgY2hlY2tzLg0KPiA+IA0KPiA+IExpbms6IA0KPiA+IGh0dHBzOi8vdXJsZGVm
ZW5zZS5jb20vdjMvX19odHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lk
PTIxNjQ1N19fOyEhQ1RSTktBOXdNZzBBUmJ3IW1YVzRaMDVkWDlZWG5CWVd4dy1PT0JZdXRxQk0w
SkZvYUFwSzYxbEZDU2xkcHRzVmkwSkV0V05TVTl1YVNuWGJHcTVvaUtDQmZ5SExGRnRFbVk1dUZn
RGwkwqANCj4gPiAgDQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBBbmRyZXkgS29ub3ZhbG92IDxhbmRy
ZXlrbnZsQGdtYWlsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLdWFuLVlpbmcgTGVlIDxLdWFu
LVlpbmcuTGVlQG1lZGlhdGVrLmNvbT4NCj4gDQo+IE9yIGNoYW5nZSB0aGUgQ28tZGV2ZWxvcGVk
LWJ5L1NpZ25lZC1vZmYtYnkgdGFncy4NCj4gDQo+IEkgZG9uJ3QgbWluZCBlaXRoZXIgYXBwcm9h
Y2guDQo+IA0KPiBUaGFua3MhDQo=
