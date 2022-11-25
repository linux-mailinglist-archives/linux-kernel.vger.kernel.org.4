Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B7B638DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiKYPuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKYPut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:50:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF45222B0;
        Fri, 25 Nov 2022 07:50:47 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2APEUMbV016703;
        Fri, 25 Nov 2022 15:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=CtyT5DG6mbTb28iTrrpkw9aXh8aRaGfyAgnwVqQRssA=;
 b=VO6h4VRU12Y1EPp9uByjx8k3txAEE3jmObRIgeKPkplVec4vhN7PzCMUgnndisKZd5YH
 cXBf2zzoXYF5hBzRBD6f+wcchjbWkNlumx4Fk7yLvn0hp9SivKCJYaCRr+tQcidA/uo2
 0AEFK155NbFudr5HrsIPZwwvmyN1kG+gHfymFkJNE8SMdsk54v/YOTANMBeK4MLNNiv1
 FyzXA5J+Yfea9UzL9PP0gWQDrhKX4tk0uD+BFboj7pGyIgV22I36ey2t/VKaAREdZeJt
 oZCuJDii3QgnRQb0X7n/Muf2YzaNMKgQ9aJK0N15dMRmM7OOiwwmybvwuVEN8qLoveP7 Ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1p5fmxmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Nov 2022 15:50:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2APDk8oc008508;
        Fri, 25 Nov 2022 15:50:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkfx2ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Nov 2022 15:50:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvKhw0hs9KMcA/4ikhlI1+lRwSEiK+Tb38pNSdE4QjpYU1jY/Z0/eTnCB9b/EIFenXpvX8eTTe8yWSGyswbbkOljXAiPplPL3deALLd6x1PW2zNIWBTxKDx4QjYvpqRaxyFDWFDiPtMJ4Oygzee8xcaNXCCa/ApOGrczN25s6BkUvxJI1Hkf7muj3b+58HTl998Bhlx6G3HZq3xA2SRSQWzBdLnnEm5DL3QpFDoR4kkdZqjmDqlkTl12skwoMrjBWwJKzz2o1YbawwTrWtzVXPltpwf4NzHUHUjn02Tty1BPWpBmge/kno1fsxqS6kxkyyqkPboaB6v/nTtSVtvK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtyT5DG6mbTb28iTrrpkw9aXh8aRaGfyAgnwVqQRssA=;
 b=EVCmkmpBgPo639UP//9EnvPpHy2roYKs74GSKl4iXFLefbaia2yCWUW1lcZOczm4dtqNVFf7M6POzfBCMY5f5EyzzQv/m3Ipzl9Zjf/DBeecb+SoJUTR78gLdG+BqJax064y8bLwmOgnPRtbdS0zsmEFwJdL3bXJTFTvkFX2GBJ5A3Kz+7ta+zr/g9JIMAZGMSaeDr2uYSn3kwMHPmTYmVnufWY7yD9kzkiCHl4pTCxxk5UOWb73h5D8E3yW81KNQKBzK7toVumAesZdZuuwPPaUmHVB9dTk+5/Mm51jGSYCUeIjDHmVukmLS8sOkahFKHDZAP3KO8cXxH3CGVlZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtyT5DG6mbTb28iTrrpkw9aXh8aRaGfyAgnwVqQRssA=;
 b=Rebkc+NzXg/3vJo1sqauR67yf26IlFlATYA0Vte+zDs3x5YmXu/nmvyLxJkpdV3BhK9isdK6Z7AtchwJ1Fi4fqE5TZdwNYpqy1+j8ajjia4UA9B/m0fbtcmPigY0WpIEoK3b6/dW4hdpLnE8CPkzjxS1xo/cjTN6AuiRRavr4v0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW5PR10MB5827.namprd10.prod.outlook.com (2603:10b6:303:19c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 15:50:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5857.020; Fri, 25 Nov 2022
 15:50:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] tools: Rename __fallthrough to fallthrough
Thread-Topic: [PATCH] tools: Rename __fallthrough to fallthrough
Thread-Index: AQHZAOWdKjCxagHIX0qde3eKVLF0eA==
Date:   Fri, 25 Nov 2022 15:50:16 +0000
Message-ID: <20221125154947.2163498-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|MW5PR10MB5827:EE_
x-ms-office365-filtering-correlation-id: 8d683d13-f1fa-49f5-a729-08dacefcbf93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+xPV2vS6JKBLVHVJVdejNxNSyZEmbPACY4AKTvr6mSb9PVV76+r8XOVlDxgiyMOSzxx9wn6VODMhgTI/bElEPgMIxZZAnq3F+aVrghtJKvMOwBuod8tofsGk+88TOBFaBwLHdDFh5+Mu4B7rc0BXQmy6IKUMx1YGcJeJo6vM14TyHksTb+vqKrwo1NEXytmGDSig7d2sM5uE1CLZHg8QLh63xf0Gg/zvNoltoSQyDSGdikGsfeDjBILVBF/N9F/a8nZyub8ID6JtRvVOPjzAz876DFbFz6NzilShmsuDfQQP/MJDbeEGXdfOw5rIU7+4tfSeDJO7Gsnzn2sFIlIU0Dh7iyz2gS2Rq6A3p+V+D3RDty6zTSb8hHOC9B9ChCBfsAfrWpN0XAfjJFohaOmaVNiojuYPaeNr2ta3av/qVS2BqUEaVoOn/Hz+gRbrQ/m4Mi/2NO+uy6uyE3+XJ6nKG3XOuSP7bVgIsnjSFWtpUTprhe18UCZ11TMqByGo2Psz+ziLYO96FXQYSntNMZJCRst4zzjZS2Z8ec9jNU7T59VxLbVzVr9HRgFUj7aLvJlDPHouYTIelkUI1Jdz1UADOTUi6T8iryIg/aya/aYR/T5gKKQdYafVZpyEItr3/8xIzvvUVB1yiJLLZ6w5LpwHNWpUClv+/4FjkLOchRxcPLCDaF65+tt75bfJ3P30vHbETvRWsPQD2kMXHGFdjOsJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199015)(316002)(110136005)(86362001)(54906003)(41300700001)(8936002)(66946007)(4326008)(8676002)(91956017)(76116006)(66446008)(66476007)(83380400001)(64756008)(36756003)(66556008)(186003)(2616005)(1076003)(122000001)(38100700002)(71200400001)(478600001)(6486002)(6512007)(38070700005)(26005)(6506007)(44832011)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H8aU0gsnw9AZ/tu6T5fXrqCW8EClF3m/YGs1hRau33OQ+PwHRD73Bipzcp?=
 =?iso-8859-1?Q?vcEhUCV1pPkCGZ0YTU+KjeP+2QqM0MSU9PyEW3jV0QI3n/KeYjFkLAXvrH?=
 =?iso-8859-1?Q?C7sogCs4bPG/uQCv33wLouTwMbr4g/Ug2xC7Y11wO5iu4pG+KoocKjmRs6?=
 =?iso-8859-1?Q?ytYgT7Pzz9lOhxj2LNA80RZoq4ObCCoyq+NSa7d/CAbquQ9T5wh/Ho+z4X?=
 =?iso-8859-1?Q?8L5De0J8p3dCbPT8945Jh904b93eKgdXMEAJgjmxDBLNIqAI5puljymw5E?=
 =?iso-8859-1?Q?eboGwmbQ5yTGslwxL0PojXErAMAfVhkTYjBbtUV2LJ7BVK31Am76dhogAN?=
 =?iso-8859-1?Q?3EPVDuAqDknnlCOpwU+FIKBtYRxR1OgGr5WJJcCxE0+a6b27rMrKJ/DewK?=
 =?iso-8859-1?Q?CQu+LyhESfxjy9F7Hg6ASY33jNWy99CuD07L/5eMPENPPEZF7+3We6U5lK?=
 =?iso-8859-1?Q?bIO+F2Ki0UNXFzwS9MXPGCvvyKtUHbz11qcZHeHtgTTgtgtqZoHHgoY7Pr?=
 =?iso-8859-1?Q?7p78grND0KkprD5y3mlwHwSyhkZ2MZDndCkEu3Swkg+QgjdlJkDXYP/Hav?=
 =?iso-8859-1?Q?XpL1BGHAeWl/sPT5d4QIkMFWS4HlMVuemU3L84+946LHU61KuP1vX/sj3Z?=
 =?iso-8859-1?Q?/gQlfH59uvnts3wHhlDBp25evt1B2MMYrvMsTNr6Ie5U9FX8+e2O2pXr6n?=
 =?iso-8859-1?Q?U5awCu+wOnkgN4SL+xG8Lfh3M4A33NzITqeAt/KUM8+5wsF1jVVHrPUfEp?=
 =?iso-8859-1?Q?c2VKE/AqVeSsLv/8DS0jELSRa0vvQFeNkccPMQv7cJ6lzhjfFWLj9q4qM4?=
 =?iso-8859-1?Q?qdVb4hganb+BS27rJqRAlwt6jK3IvM4zNNlrZa4lAc+/H8oHwSKHzz2L5x?=
 =?iso-8859-1?Q?HoVWf7YTpWb8jpFmQwYFXfXxrO6tanAdD+g4d6kR16ciB/G/aJPzkpEIy3?=
 =?iso-8859-1?Q?styF+s6uYxUHIxN60jcp/FYX4kR/TYNcRHOgjgeE7UY4lqZUO/SNL60v9F?=
 =?iso-8859-1?Q?+7lNLOcghxW2O/RV0KSTWrn5ou2a4E8tl3T+p0GhCTJ+Z7ML4OEB0iiu2c?=
 =?iso-8859-1?Q?jChbGmj2azFj9/PsGqV5lTSTanXGUEN844C/pLVr4oeq9BuljlFECfpR06?=
 =?iso-8859-1?Q?/3dVHnBvK0yDhQqti73VlScC2QUgO0uW8n/fdsL2P8q/gQEKQ41hLUsYlS?=
 =?iso-8859-1?Q?AzEsHlXs+Bj7wipaN2b3o0NGWDkLkteLe1UjvffqKTPIxT78Tga4/sCLV/?=
 =?iso-8859-1?Q?TbJBLbp2v8dfMtVS1RP5lrgJOXRz7rAb//IBpLmDBfVZkvJtNV6xf78Mws?=
 =?iso-8859-1?Q?ROfW0IPPL5hj1F5fjlgLSG8H+fd52d2bM4RTBFEyPiqprqmQ2Sp/8QLgdz?=
 =?iso-8859-1?Q?BVWlrisjay3Im86w0HmKdirTpbObe9vfiIQvgMDIcdfbjsBRzmG2Fg+XWu?=
 =?iso-8859-1?Q?R39+DX7upucC3PBK4LkIUWN641A5lC/xA9CvcXUQgpzzeoJPaY0j9kMRwd?=
 =?iso-8859-1?Q?0lTcq7XKOsxeKdNpzPpDgNM83r5tFw0B4fFKxEx8aFeQGAp5eIhhnvDnJJ?=
 =?iso-8859-1?Q?ZIybHSCW0btd2dg1LfcnDFlPipuXWDjareUNul1sfFPwkitYExvfZMjs4e?=
 =?iso-8859-1?Q?jkXD0pdanhPAqFAUL4z0Si7WJY2ywg4zJbA7oBL1AFtCjE7vmMvnDUGg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?KTl9s5IIayzCD2e/3c0kTy6pw3E3iCn+19PReLg0/wfCEhthDIEg6CDn7a?=
 =?iso-8859-1?Q?hUCivVB7lgLOfTpzXy+OebvWh1e4kPKh3qdpt0iGxl8HmvVl8sbZ8s0Ac3?=
 =?iso-8859-1?Q?+X91yJNNapEtfPEVj3KcREVab3KxEaOkVqVhB9vTs4zSk4yCWVLn0iDzJp?=
 =?iso-8859-1?Q?vKrD2ApILXbakSXkFTJjCLVluFGIwqWLc/EIh2U5dJXPF/J8H3INU5ctGv?=
 =?iso-8859-1?Q?9USRvPvu7E3aQ9/TQenxs/NwUlH5z+iw/dAvAgxyiCgJd+Fr/DPlp4cf3Z?=
 =?iso-8859-1?Q?dUzHGlVpYfLdAaO4qFv4vHqGOADivBmjWts7XmMhZl1JDHbn/0dQN5J1r7?=
 =?iso-8859-1?Q?Bm0Fcu6vSwmW2PzXwWguglf4X7DhBIys0z2kN6J8R1n6nniabT3HeLbK07?=
 =?iso-8859-1?Q?mUuxYkt7ssQYohQDUVSdb9ec/PkaIj1ZtQuChcXyhOk+0iiKir5DtTvBeg?=
 =?iso-8859-1?Q?aU4Jx6RMk2GAPDHb/QdNzOe76cUGvwtxFQVMpAAk61V2m/UVlmJoA1O7n2?=
 =?iso-8859-1?Q?TF2KjA0JF5WbZ5qo+gLfXnMn3eeZOxSJ3VNje2g+nyCfzl3Ovuqc0hfA0F?=
 =?iso-8859-1?Q?eKF6BBDCoMl4x8a5BD2n873MLDINxAboLIdxbpPLHuug11BWrGfwzr5o7q?=
 =?iso-8859-1?Q?iOzJAi/MyjdtRfclHH37lNWAVSe8Pvda8zlyDPleEVxH5JsuN1ZJAIsmTo?=
 =?iso-8859-1?Q?MnGE4lxhevVGS+5+7hSXlvINqnILq4f/M5r6oZVzLh4LQlDr6E/iaeTj2Z?=
 =?iso-8859-1?Q?AYkCH82gsLymShoxt9k1YbgjQKaDUBC1b9Pfp+3E+JixSd435EgOPA5G+H?=
 =?iso-8859-1?Q?uRg572CSv5bM4pUa25iJzR0heRek9/qDNv0NVRkoh5J78M3beKJKhaSgqc?=
 =?iso-8859-1?Q?VKpwJZeVvKyTRbtefL9M5h1k0pYI7pPYDSo9GiT9XnSjpmxHoA1XAoatyC?=
 =?iso-8859-1?Q?1ANaKo0gZscwIMISq6fJ7D3RDXJmi/Cptcppo94bM8Juekt4zf5FL6TE13?=
 =?iso-8859-1?Q?MNc5NOp7ctE4JZJHKc/mvyuJbN/D//Ray0LhTn/bXG/rtT6m9SETCAL3hT?=
 =?iso-8859-1?Q?7BIZJXjVIbiN1zmYZ62JZTrhF7Mss/IP+iRLlcBD/UkX8ta5KXgY0A3Fig?=
 =?iso-8859-1?Q?au7c+zGDl4LXDinLhw2EaRbeSGk04aMCpDKgVfyAl6/Vkh4rIMbBXGgDYQ?=
 =?iso-8859-1?Q?mbrlN4ve8MoZE9J9erFBPh/a5WK5ozDYKlc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d683d13-f1fa-49f5-a729-08dacefcbf93
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 15:50:16.7239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bj9YD6/5B5sBBJpSBVZDGkkxvgNAyAuxg6q7PF9U/ry0xRJv8gkIbGKsTKWCGzh+3jZnpZpMUiY13NNnY8I5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_07,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211250124
X-Proofpoint-ORIG-GUID: LhRgk31jUpRjtolzSMN5IWTSs-A-cffT
X-Proofpoint-GUID: LhRgk31jUpRjtolzSMN5IWTSs-A-cffT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the fallthrough attribute to better align with the kernel
version.  Copy the definition from include/linux/compiler_attributes.h
including the #else clause.  Adding the #else clause allows the tools
compiler.h header to drop the check for a definition entirely and keeps
both definitions together.

Change any __fallthrough statements to fallthrough anywhere it was used
within perf.

This allows other tools to use the same key word as the kernel.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Signed-off-by: Liam Howlett <Liam.Howlett@oracle.com>
---
 tools/include/linux/compiler-gcc.h                      | 6 ++++--
 tools/include/linux/compiler.h                          | 4 ----
 tools/perf/builtin-probe.c                              | 2 +-
 tools/perf/builtin-stat.c                               | 2 +-
 tools/perf/builtin-top.c                                | 2 +-
 tools/perf/util/callchain.c                             | 4 ++--
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c     | 6 +++---
 tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c | 2 +-
 tools/perf/util/ordered-events.c                        | 2 +-
 tools/perf/util/strfilter.c                             | 2 +-
 tools/perf/util/string.c                                | 2 +-
 11 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compi=
ler-gcc.h
index 8816f06fc6c7..62e7c901ac28 100644
--- a/tools/include/linux/compiler-gcc.h
+++ b/tools/include/linux/compiler-gcc.h
@@ -12,8 +12,10 @@
 		     + __GNUC_PATCHLEVEL__)
 #endif
=20
-#if GCC_VERSION >=3D 70000 && !defined(__CHECKER__)
-# define __fallthrough __attribute__ ((fallthrough))
+#if __has_attribute(__fallthrough__)
+# define fallthrough                    __attribute__((__fallthrough__))
+#else
+# define fallthrough                    do {} while (0)  /* fallthrough */
 #endif
=20
 #if __has_attribute(__error__)
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.=
h
index 90ba44a99199..9d36c8ce1fe7 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -186,10 +186,6 @@ static __always_inline void __write_once_size(volatile=
 void *p, void *res, int s
 })
=20
=20
-#ifndef __fallthrough
-# define __fallthrough
-#endif
-
 /* Indirect macros required for expanded argument pasting, eg. __LINE__. *=
/
 #define ___PASTE(a, b) a##b
 #define __PASTE(a, b) ___PASTE(a, b)
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index f62298f5db3b..8539843d1909 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -706,7 +706,7 @@ __cmd_probe(int argc, const char **argv)
 			pr_err("  Error: --bootconfig doesn't support uprobes.\n");
 			return -EINVAL;
 		}
-		__fallthrough;
+		fallthrough;
 	case 'a':
=20
 		/* Ensure the last given target is used */
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 265b05157972..19b0278d496c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -616,7 +616,7 @@ static void process_evlist(struct evlist *evlist, unsig=
ned int interval)
 	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
 		switch (cmd) {
 		case EVLIST_CTL_CMD_ENABLE:
-			__fallthrough;
+			fallthrough;
 		case EVLIST_CTL_CMD_DISABLE:
 			if (interval)
 				process_interval();
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 4b3ff7687236..cfe1cde35528 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -707,7 +707,7 @@ static void *display_thread(void *arg)
 		case -1:
 			if (errno =3D=3D EINTR)
 				continue;
-			__fallthrough;
+			fallthrough;
 		default:
 			c =3D getc(stdin);
 			tcsetattr(0, TCSAFLUSH, &save);
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index a093a15f048f..588f86a84eaa 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -724,7 +724,7 @@ static enum match_result match_chain(struct callchain_c=
ursor_node *node,
 		if (match !=3D MATCH_ERROR)
 			break;
 		/* otherwise fall-back to symbol-based comparison below */
-		__fallthrough;
+		fallthrough;
 	case CCKEY_FUNCTION:
 		if (node->ms.sym && cnode->ms.sym) {
 			/*
@@ -745,7 +745,7 @@ static enum match_result match_chain(struct callchain_c=
ursor_node *node,
 			}
 		}
 		/* otherwise fall-back to IP-based comparison below */
-		__fallthrough;
+		fallthrough;
 	case CCKEY_ADDRESS:
 	default:
 		match =3D match_chain_dso_addresses(cnode->ms.map, cnode->ip, node->ms.m=
ap, node->ip);
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/pe=
rf/util/intel-pt-decoder/intel-pt-decoder.c
index 0ac860c8dd2b..57dea8074777 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -3544,7 +3544,7 @@ static int intel_pt_walk_psb(struct intel_pt_decoder =
*decoder)
 		switch (decoder->packet.type) {
 		case INTEL_PT_TIP_PGD:
 			decoder->continuous_period =3D false;
-			__fallthrough;
+			fallthrough;
 		case INTEL_PT_TIP_PGE:
 		case INTEL_PT_TIP:
 		case INTEL_PT_PTWRITE:
@@ -3614,7 +3614,7 @@ static int intel_pt_walk_psb(struct intel_pt_decoder =
*decoder)
 			decoder->pge =3D false;
 			decoder->continuous_period =3D false;
 			intel_pt_clear_tx_flags(decoder);
-			__fallthrough;
+			fallthrough;
=20
 		case INTEL_PT_TNT:
 			decoder->have_tma =3D false;
@@ -3978,7 +3978,7 @@ const struct intel_pt_state *intel_pt_decode(struct i=
ntel_pt_decoder *decoder)
 			decoder->have_last_ip =3D false;
 			decoder->last_ip =3D 0;
 			decoder->ip =3D 0;
-			__fallthrough;
+			fallthrough;
 		case INTEL_PT_STATE_ERR_RESYNC:
 			err =3D intel_pt_sync_ip(decoder);
 			break;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tool=
s/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index 18f97f43e01a..af9710622a1f 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -730,7 +730,7 @@ int intel_pt_pkt_desc(const struct intel_pt_pkt *packet=
, char *buf,
 	case INTEL_PT_FUP:
 		if (!(packet->count))
 			return snprintf(buf, buf_len, "%s no ip", name);
-		__fallthrough;
+		fallthrough;
 	case INTEL_PT_CYC:
 	case INTEL_PT_VMCS:
 	case INTEL_PT_MTC:
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-eve=
nts.c
index b887dfeea673..8c62611f10aa 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -284,7 +284,7 @@ static int __ordered_events__flush(struct ordered_event=
s *oe, enum oe_flush how,
 	switch (how) {
 	case OE_FLUSH__FINAL:
 		show_progress =3D true;
-		__fallthrough;
+		fallthrough;
 	case OE_FLUSH__TOP:
 		oe->next_flush =3D ULLONG_MAX;
 		break;
diff --git a/tools/perf/util/strfilter.c b/tools/perf/util/strfilter.c
index 78aa4c3b990d..02807b9d4122 100644
--- a/tools/perf/util/strfilter.c
+++ b/tools/perf/util/strfilter.c
@@ -274,7 +274,7 @@ static int strfilter_node__sprint(struct strfilter_node=
 *node, char *buf)
 		len =3D strfilter_node__sprint_pt(node->l, buf);
 		if (len < 0)
 			return len;
-		__fallthrough;
+		fallthrough;
 	case '!':
 		if (buf) {
 			*(buf + len++) =3D *node->p;
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index 4f12a96f33cc..cf05b0b56c57 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -35,7 +35,7 @@ s64 perf_atoll(const char *str)
 			if (*p)
 				goto out_err;
=20
-			__fallthrough;
+			fallthrough;
 		case '\0':
 			return length;
 		default:
--=20
2.35.1
