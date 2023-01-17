Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5231866D46C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjAQCh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbjAQCfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:35:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10982CC67
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:38 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09XGC006403;
        Tue, 17 Jan 2023 02:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=H4D8RYTypKrdv93jbY2120D0AsVBIu7vInjpLpjxPZg=;
 b=0LIB3o1cNZkiVIyaO+s5APahVOOusf6s1lJfQyLCNTpnsXErso5e0Aqmkx4kZlVedYWE
 4yeprgUOglP8qQHtot+m98gHzNJn7YxGb+EXapCzYdV3OSXPcsrh/mTtmvrtuGlJCcGv
 5sHapLtz7KPRfL4REqelbRSVbSmS8/0ACRAlGLBMj9JrNSh/pDGOEpGPfESUjfPmcP5g
 6UpyjB8Ry33Rc236RHzGJm/YgMSRo3uTx53Oc70dYyZbmtmfwJwmf32giwM3zMd8jsMi
 wlc+ZmI4UoUjnbzSLVPI0pfzb7VEfMUQrgvg7G3a/C7o+uhgu06nbz0k4lgQFbbkSxgU fg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaabrjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30H1b4BW028327;
        Tue, 17 Jan 2023 02:34:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfxqn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIGXErrgn+xK39WIz5CVd4b5gFWQFmLZwpIhmx+QedYo1HHXCfnW4KS7o6ZWtsm1vIwkWsMcgveGyu+kClITwNddipO1GetAkO/58wt4gL3bd6eoG9gnIqvrNHBaC66571fUEH9wGyynDQX3kFDujXGkdrvZi3NgBCWWBh/vj+WxG7fkRbAncSVlFlT/c9hFhid6bLG0kP4+4Phy1W+jVJ8QhROpsBqCfsIOqK0Z8qOzDh+tuZsMsOrUDVGfWvvwxkGEuUQnS4tZO0Ga1EJQXKd+2bJaSFcb6xofJJ7aJnSkkA8ld37g8xRUdDKHYVBNCY/gzJUlsX/Ad5raBi/scw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4D8RYTypKrdv93jbY2120D0AsVBIu7vInjpLpjxPZg=;
 b=S0zpcGCmfNPiFej3rFnIRnkj1gT4Hf5ujmjjPS8d72n5MAfTOhSZy439/cZkS2XY7+ljedtisZFSHE/5j9TeGM/XEN1+Ov6bgB3rpFD/IE/yR5SQHw8f/PHyx3g64pGKVE3IOaDS1xlJnRut+Hm2TDgCaY7jFAl+XJb3OCwXzPlzyiS+IKMAAZVHpW5zfPqJo5p7RYaXh81V1bBVaHLN0XZvXtjlqSsrVQUU4NniWsEPGxPDs1op3KTJ4hMLS6XD5yNIrR6a5crUVv3+DUXPXmhA1YH4KyNd4hSr/blnrza7oOsavvwPYdxfRDANmQV4TaLlBB8VrQEC07wNDT/H/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4D8RYTypKrdv93jbY2120D0AsVBIu7vInjpLpjxPZg=;
 b=o9L+FGLF+7EUX7rN0TLmUyZsw4Ld53SmwYWYY2TfoXBMfEwBVQVHOuJssoDnM1IqpPt5xydGW34XkfQR861shhBoX4yGISvHx2nOej9ljSd+oX6QpUiKLqCwszvOoLS9vo4ah21OD4N31lR+2X/Fhj9mMXBiDVVZr1o7xcGm+1A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 29/48] mm: Switch vma_merge(), split_vma(), and __split_vma
 to vma iterator
Thread-Topic: [PATCH v3 29/48] mm: Switch vma_merge(), split_vma(), and
 __split_vma to vma iterator
Thread-Index: AQHZKhwzZQA5yPY7LE290alK6jq4DQ==
Date:   Tue, 17 Jan 2023 02:34:19 +0000
Message-ID: <20230117023335.1690727-30-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: e1229a5d-3709-4224-d3cd-08daf833588d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GL4CghYpdC5kZIU4D+1RDLzr4OloQibvKJi8lMtG1NSc2A/h5wiH8Er7G2VrtNxXjvtB8OUEKAnwfDRONk0WBRXzOI1a6An3qG/MW94XJfBRAM0AQtbiU75mND24XwtYCWzVHnu1fM/CppigB/arW8RjL9x/DmJny7lvOjaxFhBnhu1GmFTzesZL5M9y3DqgctU8pnRw33VOJe4x76aIkT2UCkogV5LOiqqHvpLHk2NTP81L9GT8ifXEs4lnugqXNq7Hjb47zQrgkgNFVyBJkyWE0g04U7xvvpSaNCFv30+Gc+iD5f7NWByK4qMkJUoadNcwv9neEeewKDHahdwemp66wXXfQ7C4BkDFyPBrk8vNm/eLU7r1TMKA1KYGf1suKB5or7w6BssX5zXVFfssCJAI3WnkykoUG8KUXB7c4n5sv7tpTQDO4ja2GxQnlsiOTn8p6NGOZXs11/tim9GgcbrEvXVjYdDKe1Z3tuQLRgaAOKAeJAfFxPIl2zZ9kSQiZ8kGsgH8UZT9apDV6aobhb/k01vCwhv2vgr8c4cNKOZzN0b55LsJq3paC/V4kTWhYa3amnB99v45qkHUQ9IAclHhq9Y/Mo+mDLrVsU65ZThj8kk7+UWm6XTcrKlcc/A74Xi3wAg0SKKHdYed2ii5S4d6/8IgsMY59Yx7QxMUTxuTdyqyE3Sr4qiO2ua3nTcwpwPrERpNd9W6J/9Hqe+4EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(6486002)(44832011)(30864003)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8cbqtFHOCPSw+zdh6BEGFSXVnkXV2/cK5+FOi4ipAkYrksZaPtksNriiC9?=
 =?iso-8859-1?Q?PV2qDF15QO7d3VcUr2F7kabO7wRxDxyaH6WPp+LogoWdWqtRiewoDS7cbH?=
 =?iso-8859-1?Q?BHtFbM0u+NbWBpI6Z15BH82Nm9dNb6qFgCJ1szdI08INyM5WgRK2W4yOWo?=
 =?iso-8859-1?Q?XxtA1zv5yYcGU/cdhtt7sxrD1bJW9XZ3dH08bevkxiZfkxiEW/jAI0SM94?=
 =?iso-8859-1?Q?bcXXZ23k6N0aow/7+DYEAwWDPsUOn2Wzn1DQONm89WzrEeZ91Ju3RT3HOP?=
 =?iso-8859-1?Q?EZh2P+rdQNVSmcq+a7pNKb7hMDTsepdiznivYlZUG8Wn4D9cuy/kKKgy2f?=
 =?iso-8859-1?Q?53KGnPt2EfgN6UxNfruCFdxjPnDfP50gHPuvVyVcEfMZCVVG83IzVKa43U?=
 =?iso-8859-1?Q?0sC5wuUnSzghwSvHzx82VmmE07zRcGK9zvJ5d0IAbpE5SbDImKZEMH6QQq?=
 =?iso-8859-1?Q?1Rta7mFXzNyO25LJ5i/7X/U5pYwYrhL4mF8nPoZ/xjlPJ6IMJIDxw0W3W4?=
 =?iso-8859-1?Q?h++WY+0BHpP9BWw0w1uvuQ1GhR7tIa0cqfT8+kVnFwVzsmuSpK+t1mMGYZ?=
 =?iso-8859-1?Q?EvmEDRA/d4TegjDm1LiUH9Rq96U9mSUilvxNZlKmIJ32Ce69N+/kNDIlD5?=
 =?iso-8859-1?Q?GwDDw2P1x+EBEsNVm2Lb6EhTAFnpMjCvrscPOygGeD8fcnq0R4zDX05R2h?=
 =?iso-8859-1?Q?yqQpSuZl1NSxbb4dGYQsv5HJZtIZLw6XD0Ptqnjaq4WUuiceRe+7CJBB4Z?=
 =?iso-8859-1?Q?eolnt9P2s2mx0OtFKn5NYEX6tGskyl5FWYDOk+UayiFpzZUZqigHkfSkTd?=
 =?iso-8859-1?Q?nD61R4TGJSyJZv04UFKydg86WqpooGTMhn4661siFUNzvZEXsuSWDr7zHM?=
 =?iso-8859-1?Q?9mOpMzs13I1eOgAgay6yPUwMqwkvp1/W1SGywjXNcBtZk9sVT0NDBL1Jqc?=
 =?iso-8859-1?Q?28x0rVaOdPl/V0KnM9+yg2rwdVpYzQj1CiKFl3X9FWT1BbYmLlge7/Srin?=
 =?iso-8859-1?Q?UyDK1J91fp5g8Q07zwprWFYQsKsN9lTAx4GUDbjrjuCQPRObTBqmauSIsp?=
 =?iso-8859-1?Q?poiGSJ+xUAmnWqqmHkU3HqCLsZb/0XxN5MPdUkmKxWNsh9J6F5TSzIjjrn?=
 =?iso-8859-1?Q?cfpYeP5fEvm/VY2P/in2B70/R/r3/IWf724QWWzNb0dxa5ycbY5PBtqNAr?=
 =?iso-8859-1?Q?EFB3ePRxqAX/zq2uC480HjxqnLP+FoirNOGpyKQXIH5p8pis23AZK1cPiq?=
 =?iso-8859-1?Q?Yl4WJSGZ+8tIwAbdMFDO3uckyK14lpDRRRvOwfLB9ObaiDalX0wX2l0xtT?=
 =?iso-8859-1?Q?NSynXLFQKV0JV3FrygT/x++xOdvIfGKwGlgG/ZSd3093LuZJV16B1kd3EG?=
 =?iso-8859-1?Q?BP0RQHEsSc2CUmOmNu/WUfMgcbCB9QZPZZz8Oc9JKe6M6o5IwWsvw3nm3y?=
 =?iso-8859-1?Q?bvS9ZNnO+K7M8LFVc+/8AF5J2pfyNQlpjxfzzqrbD68eol6DmfkHZcWaD+?=
 =?iso-8859-1?Q?RALFR3OQjX87TYfH/F6kVCPXp73DBa0XLX0UCkf5DVev6g4/GrLBZhKfVT?=
 =?iso-8859-1?Q?Z0cARHyC7mc8ZtjxRSGH6N7EVtj4px8h1Kp367RQeGB/hWQY6z4euSzAXK?=
 =?iso-8859-1?Q?Aew0PNhW3YZ4wf8SRRQGWnWzbHS9AmDFxCZgmVhkYmqKf2KNYAE+yPcg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +Zxdob4c9dL7LzZ5WnX/8ji+UyMwqymDqSmgXqo7bqblZ1DlrrqLrkic7lHnDv4fNqZ1MeQuYT/jbWILC92BShqj40r1kT1gA2H/uBMiCM87OKlU04zZSXce9AB58OWNyqPu5kYcpLyxm2MYohIUJ/EsnoXagvBBItMapyuWvXkwv9PaSyuyt1rzaVPXnATL+8Wc2MdXvUREjYXvjzQzNs5iSoakGh5By679PwgXXTD61jXETIwvj4yI8ot8VAY/mwiyut7EKULjWSzvwiOQkfX2ZX5K7rYc0yQvEtPLrAAY2oiTXfUUIStc/yx8azGl2JX5uZzabP75kEg6ZSaayumvNk0NBUY6y+5f/Y3pNvbo4KGxAr1skbDqjgTNrGan9tQ1G7k6tOxNwYy4S4NTEqYbXzbGcgMClnv8BKj3IaM45dlWnZckSTlo5Ju5uVpF341BtlX4x1xvh9+UI4Qi7WduQlabf3id6gO7EzKDQaP7M75AmwxkEP2wxMF9TfZNeCnOAh2L1Wr+11pT1/3r31vtkQ6FKZstutnlCPAsuMo0NXsr1+wu0jfLF3LfmQC4B/IOyzhJyvLi3xG3V2dwMnxw3rBvqPP91adDk0bqf9Dg/8NWcJCnewF8zk9HxkU0cYlW1Mjjb6nGSkWiimwUn6mF8As2DqbBpOs1nobKhsRVGV/ZNZmgsE/CXjCsSiXc/YCoCubnd4/A8+O/7LBhcRHYo0nJ8NOf8uxxQWHI7sfj9X7lzftV3it+eD+4jVJ7effelz2wnloC7uTMmhqNSgijEWHiTX/Jdk6RYnLaAc1SkDNF5bm55i+POxkAhQ8Lvrl6wNmvmSN/K01O8R+B32eYJ19KN9WSYNEy+hyukKj/WnekJmH6LW0+rtB2sEZ7PkghoCYOKwkaLjC8mCvgDQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1229a5d-3709-4224-d3cd-08daf833588d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:19.3278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMRtSZdOrHgNx7SI+SoEDrOhm24gaD5g32cQ8s4wAtJ7LADGwMd27mEXXK9wzccYDxxBek/CIIExUsBn9jqlJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-GUID: rBfFhrlAQcQH4SQnGc8lOeJvBGhOZtFP
X-Proofpoint-ORIG-GUID: rBfFhrlAQcQH4SQnGc8lOeJvBGhOZtFP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Drop the vmi_* functions and transition all users to use the vma
iterator directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/userfaultfd.c   | 14 ++++----
 include/linux/mm.h | 18 +++--------
 mm/madvise.c       |  6 ++--
 mm/mempolicy.c     |  6 ++--
 mm/mlock.c         |  6 ++--
 mm/mmap.c          | 79 +++++++++++++---------------------------------
 mm/mprotect.c      |  6 ++--
 mm/mremap.c        |  2 +-
 mm/nommu.c         |  8 +++--
 9 files changed, 52 insertions(+), 93 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 8aba0afb9b43..55f3af6689b8 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -883,7 +883,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 			continue;
 		}
 		new_flags =3D vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev =3D vmi_vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
+		prev =3D vma_merge(&vmi, mm, prev, vma->vm_start, vma->vm_end,
 				 new_flags, vma->anon_vma,
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
@@ -1426,7 +1426,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 		vma_end =3D min(end, vma->vm_end);
=20
 		new_flags =3D (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		prev =3D vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
+		prev =3D vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 ((struct vm_userfaultfd_ctx){ ctx }),
@@ -1437,12 +1437,12 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret =3D vmi_split_vma(&vmi, mm, vma, start, 1);
+			ret =3D split_vma(&vmi, vma, start, 1);
 			if (ret)
 				break;
 		}
 		if (vma->vm_end > end) {
-			ret =3D vmi_split_vma(&vmi, mm, vma, end, 0);
+			ret =3D split_vma(&vmi, vma, end, 0);
 			if (ret)
 				break;
 		}
@@ -1606,7 +1606,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 			uffd_wp_range(mm, vma, start, vma_end - start, false);
=20
 		new_flags =3D vma->vm_flags & ~__VM_UFFD_FLAGS;
-		prev =3D vmi_vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
+		prev =3D vma_merge(&vmi, mm, prev, start, vma_end, new_flags,
 				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
@@ -1615,12 +1615,12 @@ static int userfaultfd_unregister(struct userfaultf=
d_ctx *ctx,
 			goto next;
 		}
 		if (vma->vm_start < start) {
-			ret =3D vmi_split_vma(&vmi, mm, vma, start, 1);
+			ret =3D split_vma(&vmi, vma, start, 1);
 			if (ret)
 				break;
 		}
 		if (vma->vm_end > end) {
-			ret =3D vmi_split_vma(&vmi, mm, vma, end, 0);
+			ret =3D split_vma(&vmi, vma, end, 0);
 			if (ret)
 				break;
 		}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bed33b5f285f..71474615b4ab 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2830,24 +2830,16 @@ static inline int vma_adjust(struct vm_area_struct =
*vma, unsigned long start,
 {
 	return __vma_adjust(vma, start, end, pgoff, insert, NULL);
 }
-extern struct vm_area_struct *vma_merge(struct mm_struct *,
-	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
-	unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
-	struct mempolicy *, struct vm_userfaultfd_ctx, struct anon_vma_name *);
-extern struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
+extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
 	unsigned long end, unsigned long vm_flags, struct anon_vma *,
 	struct file *, pgoff_t, struct mempolicy *, struct vm_userfaultfd_ctx,
 	struct anon_vma_name *);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
-extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
-			       unsigned long addr, int new_below);
-extern int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *,
-	struct vm_area_struct *, unsigned long addr, int new_below);
-extern int split_vma(struct mm_struct *, struct vm_area_struct *,
-	unsigned long addr, int new_below);
-extern int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *,
-		struct vm_area_struct *, unsigned long addr, int new_below);
+extern int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
+		       unsigned long addr, int new_below);
+extern int split_vma(struct vma_iterator *vmi, struct vm_area_struct *,
+			 unsigned long addr, int new_below);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
diff --git a/mm/madvise.c b/mm/madvise.c
index 4ee85b85806a..4115516f58dd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -150,7 +150,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	}
=20
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev =3D vmi_vma_merge(&vmi, mm, *prev, start, end, new_flags,
+	*prev =3D vma_merge(&vmi, mm, *prev, start, end, new_flags,
 			  vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			  vma->vm_userfaultfd_ctx, anon_name);
 	if (*prev) {
@@ -163,7 +163,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	if (start !=3D vma->vm_start) {
 		if (unlikely(mm->map_count >=3D sysctl_max_map_count))
 			return -ENOMEM;
-		error =3D vmi__split_vma(&vmi, mm, vma, start, 1);
+		error =3D __split_vma(&vmi, vma, start, 1);
 		if (error)
 			return error;
 	}
@@ -171,7 +171,7 @@ static int madvise_update_vma(struct vm_area_struct *vm=
a,
 	if (end !=3D vma->vm_end) {
 		if (unlikely(mm->map_count >=3D sysctl_max_map_count))
 			return -ENOMEM;
-		error =3D vmi__split_vma(&vmi, mm, vma, end, 0);
+		error =3D __split_vma(&vmi, vma, end, 0);
 		if (error)
 			return error;
 	}
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6f41a30c24d5..171525b0c7a8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -810,7 +810,7 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
-		prev =3D vmi_vma_merge(&vmi, mm, prev, vmstart, vmend, vma->vm_flags,
+		prev =3D vma_merge(&vmi, mm, prev, vmstart, vmend, vma->vm_flags,
 				 vma->anon_vma, vma->vm_file, pgoff,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 anon_vma_name(vma));
@@ -819,12 +819,12 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
 			goto replace;
 		}
 		if (vma->vm_start !=3D vmstart) {
-			err =3D vmi_split_vma(&vmi, vma->vm_mm, vma, vmstart, 1);
+			err =3D split_vma(&vmi, vma, vmstart, 1);
 			if (err)
 				goto out;
 		}
 		if (vma->vm_end !=3D vmend) {
-			err =3D vmi_split_vma(&vmi, vma->vm_mm, vma, vmend, 0);
+			err =3D split_vma(&vmi, vma, vmend, 0);
 			if (err)
 				goto out;
 		}
diff --git a/mm/mlock.c b/mm/mlock.c
index 35764a4f0575..bedad71ee069 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -418,7 +418,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 		goto out;
=20
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev =3D vmi_vma_merge(vmi, mm, *prev, start, end, newflags,
+	*prev =3D vma_merge(vmi, mm, *prev, start, end, newflags,
 			vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*prev) {
@@ -427,13 +427,13 @@ static int mlock_fixup(struct vma_iterator *vmi, stru=
ct vm_area_struct *vma,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		ret =3D vmi_split_vma(vmi, mm, vma, start, 1);
+		ret =3D split_vma(vmi, vma, start, 1);
 		if (ret)
 			goto out;
 	}
=20
 	if (end !=3D vma->vm_end) {
-		ret =3D vmi_split_vma(vmi, mm, vma, end, 0);
+		ret =3D split_vma(vmi, vma, end, 0);
 		if (ret)
 			goto out;
 	}
diff --git a/mm/mmap.c b/mm/mmap.c
index 8e83e174c1e0..61d04930e897 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1013,7 +1013,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsig=
ned long vm_flags,
  * parameter) may establish ptes with the wrong permissions of NNNN
  * instead of the right permissions of XXXX.
  */
-struct vm_area_struct *vma_merge(struct mm_struct *mm,
+struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struc=
t *mm,
 			struct vm_area_struct *prev, unsigned long addr,
 			unsigned long end, unsigned long vm_flags,
 			struct anon_vma *anon_vma, struct file *file,
@@ -1022,7 +1022,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 			struct anon_vma_name *anon_name)
 {
 	pgoff_t pglen =3D (end - addr) >> PAGE_SHIFT;
-	struct vm_area_struct *mid, *next, *res;
+	struct vm_area_struct *mid, *next, *res =3D NULL;
 	int err =3D -1;
 	bool merge_prev =3D false;
 	bool merge_next =3D false;
@@ -1088,26 +1088,11 @@ struct vm_area_struct *vma_merge(struct mm_struct *=
mm,
 	if (err)
 		return NULL;
 	khugepaged_enter_vma(res, vm_flags);
-	return res;
-}
=20
-struct vm_area_struct *vmi_vma_merge(struct vma_iterator *vmi,
-			struct mm_struct *mm,
-			struct vm_area_struct *prev, unsigned long addr,
-			unsigned long end, unsigned long vm_flags,
-			struct anon_vma *anon_vma, struct file *file,
-			pgoff_t pgoff, struct mempolicy *policy,
-			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
-			struct anon_vma_name *anon_name)
-{
-	struct vm_area_struct *tmp;
-
-	tmp =3D vma_merge(mm, prev, addr, end, vm_flags, anon_vma, file, pgoff,
-			policy, vm_userfaultfd_ctx, anon_name);
-	if (tmp)
+	if (res)
 		vma_iter_set(vmi, end);
=20
-	return tmp;
+	return res;
 }
=20
 /*
@@ -2227,12 +2212,14 @@ static void unmap_region(struct mm_struct *mm, stru=
ct maple_tree *mt,
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
  */
-int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
+int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, int new_below)
 {
 	struct vm_area_struct *new;
 	int err;
-	validate_mm_mt(mm);
+	unsigned long end =3D vma->vm_end;
+
+	validate_mm_mt(vma->vm_mm);
=20
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err =3D vma->vm_ops->may_split(vma, addr);
@@ -2272,8 +2259,10 @@ int __split_vma(struct mm_struct *mm, struct vm_area=
_struct *vma,
 		err =3D vma_adjust(vma, vma->vm_start, addr, vma->vm_pgoff, new);
=20
 	/* Success. */
-	if (!err)
+	if (!err) {
+		vma_iter_set(vmi, end);
 		return 0;
+	}
=20
 	/* Avoid vm accounting in close() operation */
 	new->vm_start =3D new->vm_end;
@@ -2288,46 +2277,21 @@ int __split_vma(struct mm_struct *mm, struct vm_are=
a_struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
-	validate_mm_mt(mm);
+	validate_mm_mt(vma->vm_mm);
 	return err;
 }
-int vmi__split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
-		   struct vm_area_struct *vma, unsigned long addr, int new_below)
-{
-	int ret;
-	unsigned long end =3D vma->vm_end;
-
-	ret =3D __split_vma(mm, vma, addr, new_below);
-	if (!ret)
-		vma_iter_set(vmi, end);
-
-	return ret;
-}
=20
 /*
  * Split a vma into two pieces at address 'addr', a new vma is allocated
  * either for the first part or the tail.
  */
-int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
+int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	      unsigned long addr, int new_below)
 {
-	if (mm->map_count >=3D sysctl_max_map_count)
+	if (vma->vm_mm->map_count >=3D sysctl_max_map_count)
 		return -ENOMEM;
=20
-	return __split_vma(mm, vma, addr, new_below);
-}
-
-int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
-		  struct vm_area_struct *vma, unsigned long addr, int new_below)
-{
-	int ret;
-	unsigned long end =3D vma->vm_end;
-
-	ret =3D split_vma(mm, vma, addr, new_below);
-	if (!ret)
-		vma_iter_set(vmi, end);
-
-	return ret;
+	return __split_vma(vmi, vma, addr, new_below);
 }
=20
 static inline int munmap_sidetree(struct vm_area_struct *vma,
@@ -2387,7 +2351,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
 			goto map_count_exceeded;
=20
-		error =3D vmi__split_vma(vmi, mm, vma, start, 0);
+		error =3D __split_vma(vmi, vma, start, 0);
 		if (error)
 			goto start_split_failed;
=20
@@ -2408,7 +2372,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		if (next->vm_end > end) {
 			struct vm_area_struct *split;
=20
-			error =3D vmi__split_vma(vmi, mm, next, end, 1);
+			error =3D __split_vma(vmi, next, end, 1);
 			if (error)
 				goto end_split_failed;
=20
@@ -2689,9 +2653,10 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vmi_vma_merge(&vmi, mm, prev, vma->vm_start,
-				vma->vm_end, vma->vm_flags, NULL, vma->vm_file,
-				vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			merge =3D vma_merge(&vmi, mm, prev, vma->vm_start,
+				    vma->vm_end, vma->vm_flags, NULL,
+				    vma->vm_file, vma->vm_pgoff, NULL,
+				    NULL_VM_UFFD_CTX, NULL);
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -3237,7 +3202,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
=20
-	new_vma =3D vmi_vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags=
,
+	new_vma =3D vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (new_vma) {
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 7e6cb2165000..057b7e3e93bb 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -605,7 +605,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gat=
her *tlb,
 	 * First try to merge with previous and/or next vma.
 	 */
 	pgoff =3D vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*pprev =3D vmi_vma_merge(vmi, mm, *pprev, start, end, newflags,
+	*pprev =3D vma_merge(vmi, mm, *pprev, start, end, newflags,
 			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (*pprev) {
@@ -617,13 +617,13 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_g=
ather *tlb,
 	*pprev =3D vma;
=20
 	if (start !=3D vma->vm_start) {
-		error =3D vmi_split_vma(vmi, mm, vma, start, 1);
+		error =3D split_vma(vmi, vma, start, 1);
 		if (error)
 			goto fail;
 	}
=20
 	if (end !=3D vma->vm_end) {
-		error =3D vmi_split_vma(vmi, mm, vma, end, 0);
+		error =3D split_vma(vmi, vma, end, 0);
 		if (error)
 			goto fail;
 	}
diff --git a/mm/mremap.c b/mm/mremap.c
index 4364daaf0e83..00845aec5441 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1034,7 +1034,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 			 * with the next vma if it becomes adjacent to the expanded vma and
 			 * otherwise compatible.
 			 */
-			vma =3D vmi_vma_merge(&vmi, mm, vma, extension_start,
+			vma =3D vma_merge(&vmi, mm, vma, extension_start,
 				extension_end, vma->vm_flags, vma->anon_vma,
 				vma->vm_file, extension_pgoff, vma_policy(vma),
 				vma->vm_userfaultfd_ctx, anon_vma_name(vma));
diff --git a/mm/nommu.c b/mm/nommu.c
index f892af0a6ca3..f04979004a29 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1287,18 +1287,20 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __=
user *, arg)
  * split a vma into two pieces at address 'addr', a new vma is allocated e=
ither
  * for the first part or the tail.
  */
-int vmi_split_vma(struct vma_iterator *vmi, struct mm_struct *mm,
-		  struct vm_area_struct *vma, unsigned long addr, int new_below)
+int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	      unsigned long addr, int new_below)
 {
 	struct vm_area_struct *new;
 	struct vm_region *region;
 	unsigned long npages;
+	struct mm_struct *mm;
=20
 	/* we're only permitted to split anonymous regions (these should have
 	 * only a single usage on the region) */
 	if (vma->vm_file)
 		return -ENOMEM;
=20
+	mm =3D vma->vm_mm;
 	if (mm->map_count >=3D sysctl_max_map_count)
 		return -ENOMEM;
=20
@@ -1455,7 +1457,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 		if (end !=3D vma->vm_end && offset_in_page(end))
 			return -EINVAL;
 		if (start !=3D vma->vm_start && end !=3D vma->vm_end) {
-			ret =3D vmi_split_vma(&vmi, mm, vma, start, 1);
+			ret =3D split_vma(&vmi, vma, start, 1);
 			if (ret < 0)
 				return ret;
 		}
--=20
2.35.1
