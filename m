Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736AD6663B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbjAKTYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbjAKTW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:22:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0421A399
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:22:56 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BIxTWE030993;
        Wed, 11 Jan 2023 19:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kRq0DC2KyWWss5uIrJ0QMG3sBLXMOhJX1FuTm5VK8iA=;
 b=w0v+lWi1HIUwwGSJJDfDdxF+QUINUhqv4bvUFucXoRMYh96w4N6s8n3Et5xkDs8NfCCn
 8rbKnZmyIZQok7K8ekAisiHhrqY9NDYBzwgf+8GfldqNfDB9eugSQAdmc8pfhz5TmTGr
 6sg4dwXfGAgFhIYrnQ913r5/EcyTciAaSrK/GZV4MFpXGObQ8yyCoLbO2uZehLTgwP7+
 qqVU3h2T5nYonyufOLOafUJ2188tOD4pjhU4lcIdeIMUzIISB954SQL/nypykmACCwYV
 9ES05fE+ObeqhKN0nnmdk9f+2ZxY0whMZNaiveQlK7mOGdqMUC+TViA5FvbeP7TtE+dq 4Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n22vm01mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 19:22:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30BIklMY007576;
        Wed, 11 Jan 2023 19:22:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4b6c7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 19:22:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHhN6JDtYUm+WGXmfpou++alrjxQM9x0Yc2YibGBCy37WJQQm7T1jBdtoe54z9X27gVYVKCT8LEYQ6kuf1NvACUZT7fcUaCPRgBBwAjo/K/rGd0a93keDI+ALE3z6svZmUsZEolMQfTZ2jnzNQbTJHWBWtdLDXzvXHo7PBLw8lrpIPjx8J8cYX06IKaHNlv/XL3fBgJkdp7ZQ2bsNPauXB1ZXZd3UgV8EVJcb05s31pcJ9QCrLidy0WpgHgQK17lyhPAhpdnbLhZwXS6dXuiWO9HkTB1ud2NUqtm1/EU54WU/TKSI5bxow4JMBCUTbRD3M1XL158jfSBa9pXKinccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRq0DC2KyWWss5uIrJ0QMG3sBLXMOhJX1FuTm5VK8iA=;
 b=CC0Y/9jgFxyDlsHnT5nOOWJEE6n9bJMcsrKeGsEw9HRCN7h3qKtTD9ITFPvp6s5ULyAR+UzoEG8TcWArVnJrHqH8XQHwzDY7OCyC7mEgDZ2mvg0oWLB9SNapG1X2ExQ2LSkToYPE+LqH9c1fb9ZHsy440gib+PF+UrlSs84d6vIE5+LFHsbWUOF7daArOSAW2vMJabvsnI944NJotvhRhcEZrA6Ru5p+H3ymKm4/yQJ4JFrC0knu+p095EV0mLyMIgazmD17Y2SjnMPgotTWOtVHEpUBoyIHE5z/2BPTxby7NUAlkN0iPGSvb0JceaZ0T2BushKbyEEOtyp1JsVFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRq0DC2KyWWss5uIrJ0QMG3sBLXMOhJX1FuTm5VK8iA=;
 b=KZpRGjtom/u4288t+HwEfwNF4vo7lMoHW4g0P4iiBGj3YIS+hjzD89YomrNJxumc3V/GQRBDIp1YVu4rONdPKCHzGFwA3V/0D/ibV+LltQP+9qq+eGTAWGpYpZ8v6UqFRrcNU1ljuxcu2id0+nWbm5+ZYphNtnSQhGe2tNNq0QQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5342.namprd10.prod.outlook.com (2603:10b6:5:3a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 11 Jan
 2023 19:22:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Wed, 11 Jan 2023
 19:22:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Amanieu d'Antras <amanieu@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: =?iso-8859-1?Q?Re:_[Regression]_Bug=A0216911_-_get=5Funmapped=5Farea_retu?=
 =?iso-8859-1?Q?rns_addresses_below_mmap=5Fmin=5Faddr?=
Thread-Topic: =?iso-8859-1?Q?[Regression]_Bug=A0216911_-_get=5Funmapped=5Farea_returns_?=
 =?iso-8859-1?Q?addresses_below_mmap=5Fmin=5Faddr?=
Thread-Index: AQHZJantokDx9m+x+kGCI6W5U5BfJK6ZCuKAgACN0oA=
Date:   Wed, 11 Jan 2023 19:22:26 +0000
Message-ID: <20230111192217.mgiliyxfh3jt2jvt@revolver>
References: <0b9f5425-08d4-8013-aa4c-e620c3b10bb2@leemhuis.info>
 <df59eaf6-ae77-adb7-295a-15997950f1f5@leemhuis.info>
In-Reply-To: <df59eaf6-ae77-adb7-295a-15997950f1f5@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DS7PR10MB5342:EE_
x-ms-office365-filtering-correlation-id: 14d2ca2b-e27b-4091-42cf-08daf4092cc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0f+eRaRUK+wiaS9hU4ceWF6xNl3sfh1NoLDztL9UggDBc9+/dZmgVc3fCWdiCYSANlFaEkFkw/tomSmAP14LGMTfInGb0Z3nEHcvyrDJrFWur3WBF8+XKgMRasQuPi8+EF+cHz3IgHZPwRlAZzAHNC8DIvJifbJarBODz8oIN13U8nRsX42MzRDQCWS7QixGkjiojITqm68MAuS31APzfxD+mtbGHiVaCxzqgaQfLiL6tGnLmxdiwFVORhSkRZ7G1yF1FIvwdwWQhPLfFbqYeCr5ABoc9ixYeBwRA9bgeknn6wiHKE2/LxqZhK98K/8kJlVhkYMlppAPNuPE31WFJT5nAkL3Ar9MuU6dLYU4u6hKKsSbYNDVkS/buxGeQGIKFXJESpN++Fd+bKVYeMC6h7QvBLOx3uU3SlWn2oC1VDgh0Ox1SzQbMNsGmoGJG6Z7KNyRzdbYzLJsGM13x4N26gykxkRburUoXojeqN1FLFotbTUBkNAzcFXbOIywKUsANSaAxszzVcxWhCyiOgzLLNHA02hMIAub9eFBDPgLHdzzuqreWSfjfDCX3CKFlN1/TzO7OUZ4qp0IrUgEb0riXfdwnRtSADYlDUBuXi7qc6G8ljlBF4QG4pWxjF03rl4UehfbQcifsyABQivx9B9hq3VuEFpOErUAi2yc5W3uDLwtcYTPpAYXjwiaz7k/z+xH04PkP5Sm4HFASxMxuyq/ZjAagd5QosF5KRPhiG75QoU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199015)(6506007)(2906002)(4326008)(66446008)(6916009)(64756008)(5660300002)(53546011)(83380400001)(8936002)(122000001)(44832011)(9686003)(38100700002)(6512007)(966005)(41300700001)(6486002)(478600001)(38070700005)(91956017)(33716001)(66946007)(26005)(66556008)(186003)(76116006)(66476007)(86362001)(1076003)(71200400001)(316002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PV9dvp4ulqMMljDcCHDyE37z5F/Bjog0oQRUziiPKv+SnaNzX1WF5Sj8/b?=
 =?iso-8859-1?Q?L0wf2wSm77fgfU9t7y6Agf/zqaVnhlRl3MxT17t6Bf/Qm2XjJy9cWteZST?=
 =?iso-8859-1?Q?PmsogpBVsiDXnkzOOcXwJJCPP5gLennf/fEZjlf0wgiEIMq6plCKpXESxI?=
 =?iso-8859-1?Q?kq0dcU8nLbqSdXz7414CxHs80Ja3wQohqQ20Iwl5JqjM1VfQlLs0O7TyP4?=
 =?iso-8859-1?Q?GZChKpuYLsM6tUoW8yiAru7SgemEHSBcpplcJ9EW5qPDV3l7EUVtmRp170?=
 =?iso-8859-1?Q?fjejDZuw/r167ijRLtVfio3Qs1L0YptAs1BieZuwypppR4+FGL8qnJK1Ec?=
 =?iso-8859-1?Q?mjXdnxW8XRKUHMbaY1tanwm5Bdep9oJzGIO3987IN/yx/JX+nqoEyjkiKn?=
 =?iso-8859-1?Q?vsNaetRKg5g7VoTsoOX3R2mTA26jpOTOQkJ8uce/bozyfradWFHaM95A8K?=
 =?iso-8859-1?Q?79F1TTtUktCy7uHFcov5maZ8EbQZ5Lx1kSm8K3XxSPpbmQ5uU7d5cuMdGl?=
 =?iso-8859-1?Q?KFKO97nxVsAMYrQ3s/7kAmNqEfo0wJ2ki4cv8QqHs8jkYnfb2OobmJ3SgD?=
 =?iso-8859-1?Q?ceXRHUez5CAOmA3uCpdqhALQPDLaX+R2n1h8MJaomuYszZwTXV3J+m4eyq?=
 =?iso-8859-1?Q?mRuu4iSl1L9I1rpWtCUSx8CjOlAwXBJAbopcGTneHJ4DJpHAtBsifiay+5?=
 =?iso-8859-1?Q?u7PqHhP+dV5GExjc9/6xe6fIF6lzsmi4es55nb+hWIp++r4xSK89ob+Nq7?=
 =?iso-8859-1?Q?QcLuL65xmIFCQ/tKp0jkCEGePJPFzuYKbcs3DXOG81lrKkb9xteYfadyA0?=
 =?iso-8859-1?Q?lQM8fhH4zzU/UnVBloSqkVa3UEkD3myZmPirccXvsol+QCRsTiWjOAFIi9?=
 =?iso-8859-1?Q?nkMvPl7bJfmiL9NoWzEkPzCS5YAl2Rt4tSx/AQYl6QXZCWEAg7INmDV/yc?=
 =?iso-8859-1?Q?9sVwW6udZGcumkMKT1SdzvbaIfpIf4nKBhQiVH5uoQL8uC1fOksPaqyMYD?=
 =?iso-8859-1?Q?pzmifaXDbZ12t76CDKSpX5hll3EqAK4gWFS10Z1sLnNJxQVvPycz2dQwFt?=
 =?iso-8859-1?Q?MeVoK8sPFj79bfbJj3V6/SHl8nrMFMyLAorFgGHXGSCpY2nRtcJtT+h8S3?=
 =?iso-8859-1?Q?NIJLYVsgJxx/r00NrgKBG8YUN3pLZ4HnHuArQPa15HDnjbLqV00zcO6TYX?=
 =?iso-8859-1?Q?wsLcwBKcVyc8Pw3CQ1p9RhkdTJkKJyT6rrjV9HVAhTb/EoWTyOVpvyWMtE?=
 =?iso-8859-1?Q?l3Hj//guXbjiHz/ktkth7BcycdpI5Ifwt1NlubK6zaAuxBnR1zsjYRc4zV?=
 =?iso-8859-1?Q?PMAMt3K3WauP3mufj+f/w7KjIEbW7A9pvdfCnZlIioJ2NR594sOUKtJsaP?=
 =?iso-8859-1?Q?O3iqdKmEhWOJxDCxnuwMZWtiNDUKeFrydR5F/L1Ji76Hg+qX4GrmVGBQci?=
 =?iso-8859-1?Q?g8T68dJs1T4yVBJk+yeQprZ4Kz3gAmX6H1dzjIvpSkD+EL/+ayjau1p9kQ?=
 =?iso-8859-1?Q?fmqg5bBzwwxttxYr9d7pEdItRrjc7pbCI98Di+K9DdmUmsZWPGqi833nz2?=
 =?iso-8859-1?Q?scDnwJGTOejxgqNSjs7siriKeYIP/fxGhZghl1DEzCUI6tnM3cbgW4AwDm?=
 =?iso-8859-1?Q?dhYIHkLFMnBXjTVFZk8J6EPj44XRhn4bgrIg3wgXpKa51v62CFudtVig?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <DF7F0B9A32C9B844BBBB2FC9B227163F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?lN8DYoggCAKZecjPTKPn2Yud/FEWUUGQD/gS3AHfIjvV7ppghIBsZc/C++?=
 =?iso-8859-1?Q?kCcZN4gLhNqKDmG6dnBvkFDkXTYKBK4+C7ukLweU3XVTB109X7bUpEWnAb?=
 =?iso-8859-1?Q?VSnV4FPbBItHVOG9KkyPKIQw2KF8OeN584+NvXOrXHJ8/cPMdi+F8VfCAA?=
 =?iso-8859-1?Q?pJa9+H8+8sfPXsH0bvy/BsmyeHyRw+s7BRw3cjeebn7XzWEVUS53oPXDn8?=
 =?iso-8859-1?Q?55INT1wTg0IfhMCNharmO8zSPKQnjI3D9+sCZbW8aQgG2j58GzbkOxu74c?=
 =?iso-8859-1?Q?znRR0VYBCMP22LhuLr8eBbfJCjbxwnOf2LXYnUwLM5LELamMoi9bzCDP1h?=
 =?iso-8859-1?Q?WowjpZkW5sthbBM5DxmGuOKsuJtLMsfDgOC3SiW1JHpJJ8tJq4EYEdqlB1?=
 =?iso-8859-1?Q?+lXsIovZy1PT0UUD7EgmObb1bN1VZhUkstnWewjiEmEO4lyFUcstTn8Dvm?=
 =?iso-8859-1?Q?XKaZpq/5lrfGJ+l1+9ZuoM6rqzkvDPytbsnv3BLV7N09xzqyyE/vQQAXde?=
 =?iso-8859-1?Q?SuLCTh74v8+jpxJPlR+z3sByHDiPARDZSzlB8cYAtimFwxkZvlZQY222j4?=
 =?iso-8859-1?Q?6k0MgGJHw75gNzJjIFohXJVsBSfXZiYM682tJvFccYZV6jVlK/8atSG4Jn?=
 =?iso-8859-1?Q?c4I0Zjx7tbqeg9zmi60fxTkoWXQjiwBtxngf12kyNIs1J1br2jntiCUQzM?=
 =?iso-8859-1?Q?F5ynYgyfDF2VEPXIruaoZBIoijjR5VVsHtdruXPPdhhArDDj4UylvNdBNV?=
 =?iso-8859-1?Q?Icq4R9tgm5qYzfYQJMIiwL0gAop8PVLlJgbcgsxcg/deX7nFs8Lhme1N3p?=
 =?iso-8859-1?Q?YNFaV53J9MlSSLFaHmTbl+Pq1B9LK/q6ISS4rPZGh09Iv4ksVwEk6/IZu9?=
 =?iso-8859-1?Q?Ur2YNeTUYupZLE/ZVAPDa29hTScz6B5upc5GibOM88zi79jIlFUTnywyCB?=
 =?iso-8859-1?Q?jH3/YQ8gaORd5MbJ43fTjbUIG4Tmtx7RNt1/hAFmGCm/2Sd/QF1s++zNBn?=
 =?iso-8859-1?Q?0Mg5CCWvtENi83aQM6m3C4HVIC0EypZodjrTB5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d2ca2b-e27b-4091-42cf-08daf4092cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 19:22:26.9082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyhjPvAYPJQz5rXpcWli/5B09vZX9RSIYbXx+E7z49fQhE6jnFfPqWVA4/9C8MFydq27+NDrcOVSBuYk7pabUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_08,2023-01-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=907 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301110142
X-Proofpoint-GUID: Q1P-g1GIdx_mmsM0ZEq1r8UAczxr833d
X-Proofpoint-ORIG-GUID: Q1P-g1GIdx_mmsM0ZEq1r8UAczxr833d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linux kernel regression tracking (Thorsten Leemhuis) <regressions@leemhui=
s.info> [230111 05:54]:
> [resent with akpm's proper email address (either me or my mailer did
> something stupid; sorry for the noise)]
>=20
> On 11.01.23 11:46, Linux kernel regression tracking (Thorsten Leemhuis)
> wrote:
> > Hi, I noticed a regression report in bugzilla.kernel.org. As many
> > (most?) kernel developer don't keep an eye on it, I decided to forward
> > it by mail. Quoting from
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D216911 :
> >=20
> >>  Amanieu d'Antras 2023-01-11 02:10:02 UTC
> >>
> >> Created attachment 303572 [details]
> >> Program which demonstrates this issue
> >>
> >> The vm_unmapped_area function doesn't seem to respect info.low_limit a=
nd will sometimes return an address below this limit. This can result in ad=
dresses below mmap_min_addr being returned.
> >>
> >> I bisected it down to this range of commits (I stopped since I was hit=
ting kernel crashes):
> >> 3499a13168da mm/mmap: use maple tree for unmapped_area{_topdown}
> >> 7fdbd37da5c6 mm/mmap: use the maple tree for find_vma_prev() instead o=
f the rbtree
> >> be8432e7166e mm/mmap: use the maple tree in find_vma() instead of the =
rbtree.
> >> 2e3af1db1744 mmap: use the VMA iterator in count_vma_pages_range()
> >> f39af05949a4 mm: add VMA iterator
> >> d4af56c5c7c6 mm: start tracking VMAs with maple tree
> >=20
> > [those are all from the Maple Tree introduction series]
> >=20
> >> I've attached a test program which attempts to allocate the entire add=
ress space. On affected kernels, this triggers one of the 2 assertions (dep=
ending on whether you are running as root):
> >> - NULL is returned, which means memory below mmap_min_addr was allocat=
ed.
> >> - EPERM is returned, which really shouldn't happen when MAP_FIXED is n=
ot used (ENOMEM should be returned instead).
> >=20
> > See the ticket for more details.

Thanks Thorsten.

I'm sure this is my bug.  I've not been careful enough around the lower
bound checking in the maple tree function, which has caused a return of
an invalid location for mmap.

I'll send out a patch shortly.


> >=20
> > BTW, let me use this mail to also add the report to the list of tracked
> > regressions to ensure it's doesn't fall through the cracks:
> >=20
> > #regzbot introduced: d4af56c5c7c6..3499a13168da
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D216911
> > #regzbot title: mm: get_unmapped_area returns addresses below mmap_min_=
addr
> > #regzbot ignore-activity

Just a note that the fixes tag will be outside the above introduced
range. It will be 54a611b60590 ("Maple Tree: add new data structure")

I hope this doesn't cause issues with the bots.

Cheers,
Liam=
