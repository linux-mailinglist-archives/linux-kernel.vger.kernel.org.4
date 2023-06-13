Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0491272E56C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbjFMOMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240668AbjFMOMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:12:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC45E7D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:11:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DDO9Ai016389;
        Tue, 13 Jun 2023 14:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=xW5fQHbXoqhlpaPaDt6pJfvLqmQYqdiWufhrsFtAGOM=;
 b=3vCl/TOEi1AUJyhJyxO8NCOnQ4XKJzL5G47El1tzAfSNbr2YEILrkixPCpfrujdriC0/
 dJtdNJR00Q4N8Aifw0NzAwdi4tVQPocvwL8AZkAGDs9v85nLhPPhodgc5ZEDfJe17joA
 7TxeV0eHzwp1AX21s+FjleSw5bpDJmnJttS07oloWSLJLCP7B0Xe0kjuDzDX06cJvwgS
 f4o1JNtssIcZYlz9TH48mJrIjhxLPVxQgj98t4vm7fcLKEiTBrSMu+tXjaYQ7EOIcLbD
 SeNgsckyRA5JxvpywF4MDsG4HksrccemgvLMfRBEy6l71fm0VP+p0rbXnl86moMn4V3Y 8Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdn8ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 14:11:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DD1H6J014058;
        Tue, 13 Jun 2023 14:11:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3y1ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 14:11:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBZwkdmiCOJ2sNVujddWauVrq/eZcGqkDTNr2euD/ZJb69LX5gh3agT5L61v++Yh6Pvz5knNDoXrhtWSq5RS07/j3htq1LlSTJ6he37zFin5wTCcQ5KnzB61p5qFW8ufGF/A26xX+LKm7w+KiTAwxx5IfYB0lDGcBVRaFGPKP6JmjFrs0Z+N4z003kCe2hhV4QEeVr9bCUMpZBrt9cuCl07hEMDf+sSE6weK/yVQKozMFxGcOpyENgDYdsJYeoFtgm3Ritf0dHCRwT7GYPBYZIK3AksFD9VgG9d0ejyXebjFEopg54EZ+mvPkHRxsT9n4zqS+WvOGRAqMljbK7BS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW5fQHbXoqhlpaPaDt6pJfvLqmQYqdiWufhrsFtAGOM=;
 b=YtLroEga7njBR5uVqsERhxpz1BcAcn5Lh7lOE1Iny5nLQanN6YltzyZ5Ne+YNI5DgsGzsP0VVeplq7ckSIYDpg6fWIxGakD5txdcl4xgTXP3Lbxame9y7yjQ8+RxiPB9YdKHZJ7rTjxuHf2I4ZA7yvom3subAnku+kpGerrCCtO3LLDAgb36v0AJ5ujWN7XgG0McGyMZf75LIkpc7uo19RjELeVehfMJrTCqdM/i+aVPQU6Mj7j2F43MGzRrriawsFx3wER/E65UijRC4r/UIbv6navIfQUcvH7KfL9mp57naABDxlUjl2q2E4PgxEVgD6GMAIbIBUwHnfngBgRkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW5fQHbXoqhlpaPaDt6pJfvLqmQYqdiWufhrsFtAGOM=;
 b=shxD2eMM/Mj2flodFxQruNmpxpPH5HbNfPgVr5OJWbDYeVUY6KIBHMlYPttrW5GlHiDXOQ64WZ87wiTdsTD38hiJlwdUOMiHs7r6VNrKDDkvm96zZQEjiJ+mw8yHLFTH5llf8OGYDhOcSRRXVSI+wwDfeph99etBK01URBZiiYI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4484.namprd10.prod.outlook.com (2603:10b6:303:90::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Tue, 13 Jun
 2023 14:11:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 14:11:17 +0000
Date:   Tue, 13 Jun 2023 10:11:14 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= 
        <Andrew.Yang@mediatek.com>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>
Subject: Re: [BUG] trigger BUG_ON in mas_store_prealloc when low memory
Message-ID: <20230613141114.bwbnqsdazqbmyj3u@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Yang =?utf-8?B?KOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= <chinwen.chang@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= <Kuan-Ying.Lee@mediatek.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yuzhao@google.com" <yuzhao@google.com>
References: <9cb8c599b1d7f9c1c300d1a334d5eb70ec4d7357.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9cb8c599b1d7f9c1c300d1a334d5eb70ec4d7357.camel@mediatek.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0173.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO1PR10MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4c0013-1bf3-40aa-5fc2-08db6c180e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZFEcskzrRG5Wfu/nyIkdGJy3VCo1Xx5UsziCKVRCxQU/Ah2Vm4oxH/LtdQPfkNOzOr3DCpZzLsF9WSSdcKCo42CnLss0Vdd3+09JbQqanPybVlLmcDOS8YMs3J+EghsIjcuK/R8EXG9HVtRV50Ppbud88vgkcF2I9jY78ttNlsVVbkqHsV/cu4Uf3ptmg3yHBtTZc4V/hHgt0mGSDSzb3gTIe+irZ2GnT2Bz0U/pV+9O8fGP1BM/U9qNYRR9Qri2a+Uxu6+SRS1aBMOIp5+qJcWsgDiWlnh5JFZDg+Uql1ClG6u0vBWDrvrpH0rNr/VE5k5wj/GwiRq9iulI/1h9fnPK+q9vJ/tE4Lcgcpqy/pY8kedU3MiLP8tpB8S6pcAmxQWx3aFYfKTPKFiCQgDKFOJSY1IVTlrvpnttUpD/n9TCFcyR9X3wl4u3/SQVUkt1H25MVx2PhdtccTfoKdyzhferSKH47RBUiIlIDrME8voB7wACUHJdtUlXOzwiXtWOZgvfQ+tyxXJIIATz38oPfsW6kvre/ldvCmK8ulv6CrOEzRITILAIm9WGc1PFdIWk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(7416002)(83380400001)(54906003)(478600001)(8676002)(8936002)(41300700001)(38100700002)(6486002)(66946007)(66556008)(316002)(66476007)(6916009)(4326008)(86362001)(5660300002)(6666004)(2906002)(1076003)(9686003)(6512007)(6506007)(26005)(33716001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVJWmNuQnllbTQ5WUNzbllsNEprcWxCcUUvYlVPbU1TdHhvVGlsbGdOL1JO?=
 =?utf-8?B?dkNKL1Q4N2pXV3dYM2N0VmRFVlZDcEFxWE14bjJQNUJzaVBscXpUVForY0Jh?=
 =?utf-8?B?R1VJM29NNjRlM2o5QVlNMmRxTzRCMjZmaGV0UzZwRXpKa0xmQ3BVYnlId1h0?=
 =?utf-8?B?OGdrb2FtY29sWUVPMjBOcVl0ejFtYUZqamNIOFM5Sm83QnFzZHIwZS9haGx1?=
 =?utf-8?B?U1lxd09rNU9KNG1YOTBXejNZOUJDcWowbDlJamRuSDJsV0NGVk5YVnlFbkdh?=
 =?utf-8?B?STBQdkxPbjVMbXFLNjM2WFUwa2k2bVpQUktVaTF1WDdWUTBTMmY5UWdDZDdj?=
 =?utf-8?B?QjRQVHRDMEZBR1licFlLa1hSLzczYmZ1dEEyQkxDZHBibUNPV3pKQzVDemdL?=
 =?utf-8?B?VFIrbGw3SzRJUTY1NStxMDFMMUhYLzhmcFc1Rjg0cys2NU5MaWpvRnozMDk4?=
 =?utf-8?B?MGlRTFlIUDQ4ODB1RTh3ME5BQlBjMjVwQU01NXlTbXJSRnAwZnBmYWkwZ0Rs?=
 =?utf-8?B?UjFYZjVXbmROR1BZcGpLK0x4RDl6OEgrQXRlenF4TzN3Q1pXWGU3eGY3ZWpH?=
 =?utf-8?B?UHQrdHU5YkF1OFdxcUtJUTdnT25vempkaWpKeHVpYW5udnJ6R0l2OXhrR1g2?=
 =?utf-8?B?eFRQUDZWYVhuSGJaT29BVkloUHUyRTRlU3NTcHRGTGtMUDdzSjUzSDZvN3RL?=
 =?utf-8?B?bU9ZZVpTTkp6TTVMTElsSnlvNWd2eEIrb2thMC9rS3orL2w0RUZVMEpudmw0?=
 =?utf-8?B?eWdGbFZCd3BwM3NSVUFyblJXbER0Qk1INDhrNDRGUG1raUVEWkoxK2Z3dnpC?=
 =?utf-8?B?UzZIMU1aTmRoNHZBbmVwQUtWMTZ6c3hOdDJUZjBqS0h5N3R6T1dlcDg4bUhU?=
 =?utf-8?B?S3BrSjh2WmZlSUpZeFJDcDJXSGFHY0M4cVJmeGR6bUNoSE5icVpnOFRKU0lT?=
 =?utf-8?B?MFFvMUh4VHU2YXM5YjlBNU1XWGU2Nk1WdGdaaDV1WHRscUVGanRJME9McDVi?=
 =?utf-8?B?eUJmY21ZQndsVzFhY0FleXdnRFhxSW96NHo1ZTB2dkZ4QVJQMktmdzlNN3Nh?=
 =?utf-8?B?dTg0YktIUkxvMGkrcHhnU0V3cmxSQW9XS3V1cWRtN2UyZ0QxWmpDc3J1VHpD?=
 =?utf-8?B?TnNPd2lTeWtQR21jVDRPM0JVK1EyTFJyMkdzT05YOTVidVErcW9xRUx1cTFv?=
 =?utf-8?B?VXVOQk9tWjdWNXNLOGVPWHJQMU9uU2ptY2Z2NlFxdXR5U21rWHZGNHQ0T3Jz?=
 =?utf-8?B?WStZQ2lkdDN3MFRnZmRxcy9BSTZ6VHpqVldGcW5xY3ErcTFEMGhRNGFhNVY1?=
 =?utf-8?B?RTNGa3hOcjI0bVROR3VJM0RSK1FsLytrZHVlL0VIZjY2LzZwSzk1YjZkZmQz?=
 =?utf-8?B?elFJQlBPczBYMjlXTWdrNGd2OWVFeVVEaDUwaDAvZVBBZGttRldnNTBFUHNH?=
 =?utf-8?B?akVtZk1NNmZuOUFkS1hnZE92ek9hMWN1eDNpNEVGWnRZMDdVUjg4UTF5cTBI?=
 =?utf-8?B?TzdHKzM0ZXQzRFdENTk1N3JPM21MZjg2STh1bjdTVC9VZ1M2emxlWHM1ZVJT?=
 =?utf-8?B?WmZlbjVuRC85b1BJN0ZqWEZDVXBVZ3pDbEhhcTdWT0pBZVZSc0RCRUt5eU5p?=
 =?utf-8?B?c3grU2FERjl1OXNCbUQrYnpGRnhaOThKRjBSVCtaU1NtZzlTNHBUNDN6eXJh?=
 =?utf-8?B?dXR2OXNFeUlUL2gyMFFOVWJjWVk2TzlHOXRTYUN4bjhHSUh3dE9saU5mMy9m?=
 =?utf-8?B?UkM5eTdBOWpVc0xRbGhWZytzZnhQcVRFM3pnTVNtTlZHSy9FYUZIbU4zc0l1?=
 =?utf-8?B?ZGI0Zlcrb0J2VGVHNDd6eGRMS1FkYWtYWUtLOHBCZXBtZFMySkJkb3dRTHR4?=
 =?utf-8?B?QXJlc1gxQ3hucUV2d2d2UlJjOUJtbVhldDNQdk1UZ3p1N1dMWjJjZG5YQkoz?=
 =?utf-8?B?OTdxVWFqOVBMM3NBZTBtQ0NMME5YemNxOW1mL3Erc3NZMEZSbll5amw1Y2Q1?=
 =?utf-8?B?TGd2U1lhNWF4Ulh2NGpEQlU4SS9PUXRPMHpqbitMbkI2a2RUYXhrS2Jvc25w?=
 =?utf-8?B?RWtpcG4rZkhYT2pzcHdyeTRLSG9ROE9sMHZObDgzUmNzandjUVMzVjYxTjdw?=
 =?utf-8?B?OENzREk2bzNWVUZ1UFZkbmViRjNVWmdRcGYxK2pUZVpWbkRPZ05TVXk5c3NC?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UGJUaW1QbDQ5eCtLOGVDWnVDMGxkYjFnU3RaU1FKNkNadStKL2ZhZmJWTllk?=
 =?utf-8?B?cFVOVTByRERwUWZWaFMxRUU0aWF1Z1lENmR4VXEybHVuOWxoRm1hSlNJMHdm?=
 =?utf-8?B?L3hjb1hPQXljRFcwNUYwOW4wZGY1cHhKVU4wUXpyR3RkVmZ0MG5ZaGNLbExS?=
 =?utf-8?B?bEJscW1pY3FzdzkxeUlGVVRZcm5XZ3BudnVtZFdsK2pCY1JhcXJGc0FNS1Jt?=
 =?utf-8?B?dFFDMVZ1aGVyRlhSR1g3dTZCVFdmcHNnTlNkVEtBRWY5Mk44Rmd2ekZMcE95?=
 =?utf-8?B?K2xsTnlFUHY2S3c3T1ZQdHIxeE4vVjNna0VBNmhuNm9jeWdGMkwzMlgwaUZs?=
 =?utf-8?B?RWREQW9reXk5NGIvZEpjTE9kc2NpTGl1K00yazZPTnBCTWFHMkJ6V1pGUW9h?=
 =?utf-8?B?UUZ4TXlGaXJQUXkvM1g2TDFUTUlRVFhibUt5V216OFozNks4U3JvMWJUSnlH?=
 =?utf-8?B?T05ueldLRzdncnVLSVF5VUxPZjZWVC9OTUZLSTFNVy9ERmE0Y25uOTRTUTZV?=
 =?utf-8?B?aDBsejYvM1BYZnFqUmwvTE8rZGllRWFaUkg0b1VVdjlOSW1GUGhocmszMTdX?=
 =?utf-8?B?WFp0UkhOektTUFYrVkFDdXRIQytTR1Bsak5jQTF4cGRzU1luM0FNUGtNUlMy?=
 =?utf-8?B?NWlVdHMzSlArYzFXQ0R3NEZrdmxndTR0MmFPUjAxc0RzdVdOV2ZTZjUzNGNj?=
 =?utf-8?B?YWQ3bTNCc0pjMFoydTRaUlV1Q2hPclZDOVVGUmk1d0lGZ3g2a1pwOFpvbVhZ?=
 =?utf-8?B?TituNmo0RVB2bERPbzNGandEcWg5c0lZVWpzRjI4L0JnQVh4ZExDK2txTGdB?=
 =?utf-8?B?eFdRZFMwUEgrZ3huMjlXMWRGZmplbERnditYZEtMbXdjcnVpdTVNL1pDS2xv?=
 =?utf-8?B?c1BKTVE4UHYrajBTTTRhcUVtdHFvNDlpMkVjZzE5aUdDUUExYnFtQzFJR0Z4?=
 =?utf-8?B?RVNFUVc3TmZvR1JYQU9lMlVKbEZ5TGNVa0t2Q1Q5MXRoUFc2eXdYRklTcXVZ?=
 =?utf-8?B?YXl1ZlRhU2xPN051N3dGWE1NZHE4TXRoSmtlWEpQdXBvZWQxNFRld2ZBb3dW?=
 =?utf-8?B?Skl4N21PdDhDbHJSSFlDalVvTnhXSHM0TFlnQXozZnNlUHdjNW94WkxlUFU1?=
 =?utf-8?B?cVdkT1FYb0dFZzhCMFcrWlRXZ3hCMTh6cDJ3dklIbkdtLzBJU2Q5MmRBaWc4?=
 =?utf-8?B?bUxaZE9SdzNzalQrcXBhUU43bnkrdWxNSHI4cE0yQ0NUcEZtaGx5TU5EcEZT?=
 =?utf-8?B?dkVoKy9FU05jZ3FObWI3WFFCWEhGSnFPNGJaWUFvODhaRVREdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4c0013-1bf3-40aa-5fc2-08db6c180e2f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:11:17.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5hHbCEcfz+lTNO9AopKL+QG/3cR1gyAowX6/QFFa+4coFBSWuMk+GqugS+fA5/AcLuIwiHM0HxXryBZBN5rLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130124
X-Proofpoint-ORIG-GUID: 1INIGoKGFK3TnqMZtVfHBQmWN__X7DIm
X-Proofpoint-GUID: 1INIGoKGFK3TnqMZtVfHBQmWN__X7DIm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* John Hsu (=E8=A8=B1=E6=B0=B8=E7=BF=B0) <John.Hsu@mediatek.com> [230609 04=
:37]:
> Hi reviewers and author liam.howlett@oracle.com,
> Kindly ping.
>=20

Hello!

Thanks for reporting this issue.

> We met BUG_ON in mas_store_prealloc with kernel-6.1 stress testing
> environment.

version 6.1 or 6.1.x?  Which exact version (git id or version number)

> According to coredump, BUG_ON is triggered by mas->node with error
> number -ENOMEM(0xffffffffffffffd2).
> There are some mas_node_count functions in mas_wr_store_entry, and it
> seems that mas->node may be set to error node with -ENOMEM if there was
> no enough memory spcace for maple tree operations.
> We think that return -ENOMEM instead of directly triggering BUG_ON when
> memory is not available is suitable,

This BUG_ON() is necessary since this function should _never_ run out of
memory; this function does not return an error code. mas_preallocate()
should have gotten you the memory necessary (or returned an -ENOMEM)
prior to the call to mas_store_prealloc(), so this is probably an
internal tree problem.

>because in reality the tree
> operation shouldn't be performed in this situation.

There is a tree operation being performed here.  mprotect is merging a
vma by the looks of the call stack.  Why do you think no tree operation
is necessary?

>=20
> following are the backtrace:
> mas_store_prealloc+0x23c/0x484
> vma_mas_store+0xe4/0x2d0
> __vma_adjust+0xab0/0x1470
> vma_merge+0x5b8/0x5d4
> mprotect_fixup+0x1f4/0x478
> __arm64_sys_mprotect+0x6b0/0x8f0
> invoke_syscall+0x84/0x264
> el0_svc_common+0x118/0x1f0
> do_el0_svc+0x5c/0x184
> el0_svc+0x38/0x98

I see this is arm64.  Do you have a reproducer?  If you don't have a
reproducer, I can try stress-ng on amr64 to simulate your workload using
mprotect, but I need to know the exact kernel version as this issue may
have been fixed in a later stable release.

Thanks,
Liam
