Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCE363C569
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbiK2Qo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiK2Qof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998065A6CD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:34 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGQ1w6012682;
        Tue, 29 Nov 2022 16:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5xSt577sJrGE35wg57zTEbehUeim3s8boc/TbUBInTU=;
 b=l/dpp3adRAn24Tci609cemCa3rVO5zVaNXhxo9sv1AtY6LGWf9shvvm3F9B3WiCFhLgt
 HBTYueXbM+624Qs0MfbS03Ax+4rQoBvJQeq5wK5o1diStvktebglMkrlhHNICg+e9CNI
 PHC7XPeooX7RN43rObGGmu65g9wV2gQhXqQsWxZovQODxpHMU8jpvO3LWjBrbiCwUCTC
 7OEVjlXdRI1shOTzsoiWjUjQ22VFtFrrUpl35ghWB9C6acSrK/x4I3EjTFzPnPgW8HNb
 cpSUyS9ZKoMGEx6Xcz8+l8MVuJMw05f4DOCbIRe78BkM7ZbzOSxT1zhf/kscWuNmNWRm eQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemdn8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATG7rBa030968;
        Tue, 29 Nov 2022 16:44:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398771pv-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFyoSXUz6njhhXl/+QJ/ZISu81pXvh7GyYFnlerrJTqwyFGFbdGF1hqt/83p+Zl2MFiycAimx5O+PZJlsngHlceBUo/FyR0/LqO6Dg5lSKuohqalpKIJxRqT5e7+H/yjwHpfyfC0xPjxr1LBeq9bR9S+gbnYMqrrlbxo7LLuXhXD0QI3kell2Q+D2vGXPudgWeh2q7JZ7/qJQfvgR1ygKTX1pww2dnfsNEPKCtmKLCgb6LLlrR7luRy7b+fzOcvVsyVS5yJ9oBFls7oOTdPrHumevYbsa9oE52yM2slulurfj2ggQSWmEXgcQU1qfL+aC3e3yf87PC98ebNUcb27LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xSt577sJrGE35wg57zTEbehUeim3s8boc/TbUBInTU=;
 b=QwOslEeb4w8GA1TnUzi7zmt+hQzzL1hfOdbJD5UAeJHRWSDkBwl5tvTZRmbD5XyMpGF0mqxod+lOIHFtRiAS+Xck3BwVG6GQDdbNAn3/aqxm8gdzvcTvDRLXg9J/4SnVbWzLt0XYeENqaYSyKKaEpgCK0ps1Pe/yfFGA6j9zfQ8Jsm4YmKfAo1fp0fDK2xeeCbQUrzqPBCFjX6x7hI8FmMHDoFN7ePk1i13AOpp4rgUOIQTsjNcNQxxF7c+XreZdCfE6cjpFVEOEXO/Zu7n0+pgMd4gLzPInEMUrykXGk765kin1dm0H3O5UP2HWxn/Xg2mUGxe13+wtocOAV7LtOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xSt577sJrGE35wg57zTEbehUeim3s8boc/TbUBInTU=;
 b=KIa9Efp/O+ccKs/OzhY32rTxZYpxxLNcBUqybkCgv+fIoK6EjO53tfs9o/6Cyv1Btzrg6pS0Z9dj4IzmzLbZktYjtZd1ee2TIyY6jdna5RDNRtIOolNCp6TuwREML1nsHF4iwrLOb34G9zwMFwtGHk3ceevsFIdIJQwN0yhXnZM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:44:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 08/43] mmap: Convert vma_link() vma iterator
Thread-Topic: [PATCH 08/43] mmap: Convert vma_link() vma iterator
Thread-Index: AQHZBBHV/qxb8hfaW0mrYzN1uC2/SQ==
Date:   Tue, 29 Nov 2022 16:44:22 +0000
Message-ID: <20221129164352.3374638-9-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5321:EE_
x-ms-office365-filtering-correlation-id: 0b226934-9448-4338-5f0c-08dad228f913
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zdheizxuji+WFp9c94Pag54ZcZWAeia/J7+j2BERFnNGuZ2efw5cizY4XD36YlUqiJ7xVgYyPC0x4UaGpUIgoPcetk5858zXB943u4tnzPg4KtPKmCHT4nBkTWiJLbVxXUF/90qWFjsxc3iBB7BKbGWpFgPESsGU9SUo2YstVsGNCrOKq0QwcJUtYvVXdgwRAUNDWOnlUdBxMbkt1ePk3HjBCDZEJuIwiFf0R7q/BbamANlcI91uL2GhPMOYGEtHWqosMoK1l35KFGHNEOsKjAqcrelP/3pZeGyiMGeuM1ZUg4/yyGDeFGyyEDuaFNWb1L+TqPpVlcqZveYqzCyNgcj7n9u4gMu/AyOYP1to7Rcmk9Vgghu4QzhAjPkGayDgjEnxGRpkln4nRb7Fl3XHOwLKIqZNhuNkvGdUI1OIfnyQojf4KFmTGh6CACRsJNF7zdRbrFvcelHI2owmS4MslL9fUSLO2qzZgdNKzsIWAv0Y4sgnGeM35BFAPb4ghGF+oQQXboVuzFszm7HjQBBGCyhFBHNF+GVF3htBnT7zG+aR38PdxoQotLzxHvbEfi34XmT3nXgstm9va3KUiN8RfM6HTpuKu7UfJkcX9L00WUSLNrPghExw7qVho3jYLC2ef6V5YR3oQWWCLhj+JXMzrxav7GbXM45aKHl931rv0EtuUskPmK5ZS61RYofhXdT5eP4phpjIrahX9hW1Y/OxAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(83380400001)(54906003)(71200400001)(6506007)(107886003)(110136005)(6486002)(86362001)(36756003)(38070700005)(6512007)(38100700002)(122000001)(2616005)(26005)(1076003)(186003)(8936002)(5660300002)(66446008)(478600001)(44832011)(8676002)(66946007)(66556008)(64756008)(76116006)(4744005)(66476007)(41300700001)(4326008)(2906002)(91956017)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+0m6aSLuRWweLJ95mThtfJZVwpV2NxzaBvMgTQE+eu4/k8rnBlOIbqM7tS?=
 =?iso-8859-1?Q?ujnuJ6YOLq3V+wBNpbNuNJF2I+966h2FFBpiJlfEnImLmwUEbKbeP8aUXh?=
 =?iso-8859-1?Q?7zSTdf5OhPny4ZHrMmKU3SsZQBlr6vAstqHrWQQOpksOHAE8j+rkLwgHlx?=
 =?iso-8859-1?Q?08gU1MtY/EH3lmqEq/vL21lOmj9APC7uwkcEft0cP/LXqfolke3Inz4FEe?=
 =?iso-8859-1?Q?dhliWVo/+HqTs/NRaKLi43pMuEnC9wbhlDL3CipFOg+uXoGBXxsl+ZpHnu?=
 =?iso-8859-1?Q?X8WxoD7JYt0yqT3qoGFDNJqjfyn6vV1+j6xDifdMwl3ROVBQFJwRHpU3ze?=
 =?iso-8859-1?Q?RWrU6ZoLvV0xmrYuh2mVYYnphylM28A451rRTjoaYA1e1HUWkTbFSADAkN?=
 =?iso-8859-1?Q?SRvirvynt32Qk/IbLXxbT+ITj1oIMdFmQxkKdFmoNIdDxDFNamPHgME2dD?=
 =?iso-8859-1?Q?+mn6UGgyI47TrPzBhtkM/zLqh5hMpUmsRNQjLRhheOftVJkuOSc4+HvCV5?=
 =?iso-8859-1?Q?tuRRLY6DuVRQozXKGlREUh6Ox9vhIfsH8LxElogO82UsVYFmXMR22uUYNu?=
 =?iso-8859-1?Q?1Z5Pgjw7JvA7y5Pbbx/sz8cDYsrjG5F3mxzR6T3UVpFbGeBI9SBRkvowSV?=
 =?iso-8859-1?Q?lERTLxJO0J1Q2O0kdj/WjBfUWt4zAT6lF9xmWkLXtCXr+dNvBFGw5wmIdH?=
 =?iso-8859-1?Q?bsJeyCJ8PLUHra8+0WvAnrvudlEGeWVDkpuhoY3PvDHzdwpyGH9v0uxTGi?=
 =?iso-8859-1?Q?AdStTbrmiXk6b87a238vnyDHqaaUWOp1ibzVyHAk8HaudlebmUYEyVOIoF?=
 =?iso-8859-1?Q?CGN9d/tpqyNJzHzraTz3gMLTw3qOZ8CdqMBMGiH5XtvbzBH4YEThcMvn5j?=
 =?iso-8859-1?Q?z7oP8LnH+L+kdwpxgz7E22khy3UjiKVFxGdGHCoo+bMUJBGi/hEKRXhRTy?=
 =?iso-8859-1?Q?i926UzOM1iwXDt1Ru7Tw3zEXxeMiTroH5OaRRHuQd+cCXZMB7j+ZS9rBav?=
 =?iso-8859-1?Q?Yyh4SsBlXTeYl7eflG4yigs7lFMDcnqR7hKTMpPsxx/viwT8aJtFNONbDS?=
 =?iso-8859-1?Q?K2CRNhWyqKDYhNY9DhanaviKfB71w1ji3qWxOqojBUQgwXJhS5k78YOlAO?=
 =?iso-8859-1?Q?KeyQQNv7fCu9DCKO5BxxkMvG4yy5E7pBIdqwra0HV7yQzemi+dHxTLHVLm?=
 =?iso-8859-1?Q?iyUuTOORi186EH36sc0qXD9BBaVRe3lgpFgcKrgS/p8L7QfY94IG5UCJy0?=
 =?iso-8859-1?Q?wcKmyc7J4bXNMLlhnRml+7P++0yExuKNdNnuZFC/tn3ai5e8DNKvIjshNy?=
 =?iso-8859-1?Q?vIj+CO4Zf+5oUSM3DkeqM57tyfPyL8JDo/SVu4l1yBbHCVRTVeovw560Rn?=
 =?iso-8859-1?Q?9VtsC4MTyxBGG39dBD012UiW2PC3Thw8sYdAznD6+4bHFhBOHc/HidTrDx?=
 =?iso-8859-1?Q?TmO5ZJT4SKALz69NfGfrurWUmluD4gB1CKXRiwz9rVZ4xP39aqQgEceCbO?=
 =?iso-8859-1?Q?cgehqrp2vDFhdT1/9RCfONd0Jbl44a/DV4UEayQk+KSl1Ntjcunp+lNEoR?=
 =?iso-8859-1?Q?gtQFvztpC575YRw2NjdJBVo8Soj8eBi0lp6i7mkXUkHBHmXiUNUT2DO+iW?=
 =?iso-8859-1?Q?UEV1N2K7tOfQvQcbZfs3NHEdtN5VS4yOcs8VU9X5s3F5pzjTatISDSXw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o44Kz5LXSGMRP7vSHHRMM7cUEvCFcN5MY0Iw5TZnO14zqTZwD7zpFYdDT6LJGkv8FvGVutZir5KrxyABRj/KwM6tA4Qsi4b7lSXq+5KP2I5mdRgKCRv5v0D+82XNJoOnKU/tmOD5Zm7utCww71t9TFSwDQuZ5AidmeudLJdLDfzCT6JojUjNApbRV+KwwK5ByoL/lqnRnD0YLOBw0JXWuQ69wAMqJw59TeZhYrhdoX168AKRV6W5xyeRC7RZZ0gRNY3ex9tWG2LBoqGH9EeZjF5zSiKnYC8VquwiK8r89NApcgePnBTh6As59nRlahBvK91a8C5x3Xk6onKuv97ItXYBK9I2cu626LixNPKHaPBjUdR1HiV4hvirAf2iLz9epbLl+PUBj3jiHArsguvCN5IhQ9H9hF738bCWyOX1JdJ+L7fQTSuivIZXCNCzOM+dqL+MPanvRFxnZM7upZK6KkuKHsUmo8kUI840VB2Z2gfU/tu3fUdRUPPSS/VIkDfJbWMSio7Iw7A/6MKn+EXF2TC1Y6bEjFEShf3yHgP8WKN6/cu5rYeIdT7T63pTr+tx9cpQnEZptAgcw5PK/4i1MZFaVSIub4a22xNDwRkcY1nhPDP/Cgfuhjl1CkfdUWIS4zKEVTjb97ZElK6h4TGBmv+02OSG7g/CXKRUVPOV7TNKjcNuaRpa66hySaib4WhthmgLWwaXEwJb2+zuL/OCfnfVmuvh73qufPPBPBbPvIAjOYOg8Muqj9Lq/Gr7IKhlTU7fOlNQSQ8RxTR1gVYWwhxW2ibNf3yRViEPyQT+v70Zx7jBMTEhESpW0D0n0bTGI/1oqxeBzgeTjVSYR6yLrIHYolFycrxMEg1ewO/c6jTQ4tDeKxIxq2ofD+MdMtDeBEQuRZ39DKAQbUR/5Ai7mA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b226934-9448-4338-5f0c-08dad228f913
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:22.7231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jl/X0OtJaNV8+GsNB/ylK/8GDHpbTJhFYt499QpdlLLnmSAdiaiCgkjAbYJXUZ7d36afu9h5ePxFOJp0exZBpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: RYnL5ElEcVukgYrzWcFWq1T9vOPa7Wsf
X-Proofpoint-GUID: RYnL5ElEcVukgYrzWcFWq1T9vOPa7Wsf
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

Avoid using the maple tree interface directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 054dd3e8e1a4..f4568a25d2dd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -544,10 +544,10 @@ static inline void vma_mas_szero(struct ma_state *mas=
, unsigned long start,
=20
 static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 	struct address_space *mapping =3D NULL;
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (vma_iter_prealloc(&vmi, vma))
 		return -ENOMEM;
=20
 	if (vma->vm_file) {
@@ -555,7 +555,7 @@ static int vma_link(struct mm_struct *mm, struct vm_are=
a_struct *vma)
 		i_mmap_lock_write(mapping);
 	}
=20
-	vma_mas_store(vma, &mas);
+	vma_iter_store(&vmi, vma);
=20
 	if (mapping) {
 		__vma_link_file(vma, mapping);
--=20
2.35.1
