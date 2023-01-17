Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BEA66D466
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjAQCgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbjAQCfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:35:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284802BEDF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:34 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H091K1006726;
        Tue, 17 Jan 2023 02:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=22Z6OpYufdBtzxSvf9B3LFJ2NyY1sjKM0+x62TTuiWc=;
 b=ZeBs5WE3oKePIPk+/trU3lIjTUWvpAVVg/tgQK6EyKFY9GuXDARDnyz8IEaDudcAFVie
 s6coOXFJxBvUkIINm5F/KCDhfsSZnHopjGZdLtrXQBqkTpQfdLFqAFviOsWhm9OPPUMK
 STCNJQoNLlEM0/bCrbW6I1HnXLOJDO56hcyWs6zz4xJ9GAtpYk1Mr5JpohdajDTT/Pt/
 UcTWY7UMJ7ZSB2DPk3cQTuiAtwN6OACrF5SEu2Ask5RdFgDYjKiPZ6+75z7aHC4VcxlV
 m2lwwTI/c9nbtjVbdJbzTqIQW4Hiov4pWb2TnG0Ktnht2uc1KuX/L9EhcffKxSuhes0X Ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0tkp09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GNUM0b004833;
        Tue, 17 Jan 2023 02:34:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyy10f0-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg0VYQ4n59oQA1i5Z7yYynHaV6itRWtvpKyApOr7v6//KcTES3gTjTM8Vjrt4+Ivb3KpA3IJpLDxNcdE0BHsKUcvpvz/TFHxmxKN2ghzUlKd2CRCDa0VJClQA9fTx1MWXkxZERA4sKkLVn7aXGN5qUbEx0ggZR33ydzxXJE1YiOMOMzZBMvKV+iF1QSG9OC5yr85S5fhhv8mvORB3uvz0teCpmCOokfZVtH0q4kUNFiWSlnlQk1SeIURQkeDax9bR71Y1Khgl1IqkSLvhxF/91Qa7RVY9jdNauA7MZ9SREkabvwRfbIA8J1qOeryATlm9zBupw7bzFDGNFEyvFTo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22Z6OpYufdBtzxSvf9B3LFJ2NyY1sjKM0+x62TTuiWc=;
 b=DG26DmxrXFhz/xylmPppM6DYWCjrxzzUnJrrqOpXv0whHhQ2dnD2x6kvaNU3/RqsJ2MaAD2eYnXz3n4jCMAtXC5DmrqEtaKTeLM1mSoIGxtPtsfQbtV2MNq8KHyFdWVBR32T3RLsHmurxdZf3ScxwUQqRZ00B6Ffk+OPhK7bB+IVE9pft6QqTzAVpQVDcXYyJZnKLR/3xEcDEy2bPTk6a1JknLQ0lD2dfvzSlcZUs//635T3BewP1yOYP4b4LIZSanfH0jMBHbiUCY2WVklhalAqwz33zPi9P4HmCTQp+tdxUw3ijBuvOGwJkT02r3/mwn1/f+E2yiNkkd9917WLAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22Z6OpYufdBtzxSvf9B3LFJ2NyY1sjKM0+x62TTuiWc=;
 b=rdfqa2yFcxvfHMzqczMMWtMubw/LfSzb5dYWqDKqya2sT7EI1qxvDTp9jXGNO+D2ZQrsG6arRxVwygzl14CuYxvq/AuKx68U9QmVuI8JlwFlYZ9GInPgob3Tira3dWFpF/qqKf8B5G6Vr+kPxomUyy3Kuwx3pvtEswSUTKmq82Y=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 26/48] mm/mremap: Use vmi version of vma_merge()
Thread-Topic: [PATCH v3 26/48] mm/mremap: Use vmi version of vma_merge()
Thread-Index: AQHZKhwyqBBqRaD99UKZvitspif9gg==
Date:   Tue, 17 Jan 2023 02:34:18 +0000
Message-ID: <20230117023335.1690727-27-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: d86b8b50-c834-405c-6cd8-08daf833579f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0O+3gurT8Miuy0BMji3Cb8uJ+bPlgAPRgDagAlT6eUhq3yxm83F4FRuJIUYUkk9B8Uhv7Y7Eem5FVQxZdn52bf8QJ9YQufdCG+LXiuslDjsT1Jj3fZLTeATCUmM+bxE9F+R6fHOGyaC7oKbuBCHhpDn5TH9mJ98rnxmIDSbiRQJ/7neoHzuo2fuNf4+Bv/KshJeeHkDIcuuf/fOJxbbsVQ0a/kdUiwrOmJJJ0jBN+deE1o4NVWvBywe15ar8ZGiEsurdoBOr8MXKORjLAHqSOnQopU1RS4qjConsR3GGHGNIXrIozIf7c8V8GqYYa35x58+5pMbBfRXm8+Fpw0HFchjOXl3wqpj34HlFrVcJ4hbG1Oo/KzT8yK+SF2AxfSg2qje8xD3nXilwHXAUVXGkpBgRRL7RnNAMKXMeYc0d1RPOtb717WWqMRG0RMMHDnsDb9Ph1GIzNlCGeCZW+O1GRko5AM5BIWlBFvavAVfQ/rqtt7RLVXs1QAxuHQJLd4gwOM3COdfSW0CF/nlWUHZ+sBxKgdc5H8OS0B5IMLSdaQcshhYL3gnaH3wFJbmksuiQ5eLs/LKUNABiHp0fps7djt5x2nHei2bymH5Pr58oOnK1SNZZKADpowgiWE4qSQp1ckPPj7EJtjtIZ1L/dF/1xr0wDpxvX5m2rrH9Kd6ZlSWi3jamlfXrTui0MQ8pttIA1V39na1pVe7HRJW4Xzhx3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(54906003)(110136005)(107886003)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KyCX+3WYj1k1HFQc2JGXaGDlTfwrQwD+0uDdEJ7TFd9aJB7u/ePoo/JVwJ?=
 =?iso-8859-1?Q?yFQ4JsNuh1/TJAn/e28R0Aua5nDr1nFf6ZcJScRP1rHYjc+6pbxNwEK+zm?=
 =?iso-8859-1?Q?d4v5+fOz7KVFyYlEeYnvXRr8Dx/NDmVH6/VIxgifOqc0kHQTZT4EJRky3w?=
 =?iso-8859-1?Q?8R6ojWpy7/zXU903RnEeUk9V4tX/TYj1Tp3NaGkBTE4fPdAwrIPUqaI9Al?=
 =?iso-8859-1?Q?NYkq7DWLuhIba5jqJERABLgs4BPi232gwUOooPj01+BNuPaIEe5Ugodz+Y?=
 =?iso-8859-1?Q?49YXZo9B9d97URZZNmfpBOGl4YVhRbcePLJK21CCy2zsULuvPxKIsGfdaK?=
 =?iso-8859-1?Q?FXZtoY6YDrGtrk09KnBceirOqDQzGuKd4noCo8O1wslRFhaO9aSQDR4un8?=
 =?iso-8859-1?Q?P5cFyqOV5Lsukavfpgdyg6sqFcbrsfMdiboxseuPYOn00RUfFU73FVJPSc?=
 =?iso-8859-1?Q?Pa7ZDpA9XdnhD3+Bj+mb8mB5qN72G/ILxLPSgC52tB/Yk9pfAPbaxOVTSv?=
 =?iso-8859-1?Q?ddXAFHYewCOjpOtr2dd1Kh9e5DXK2vR0g6MlzCNS4NGVBDGHJzZIFZ/68D?=
 =?iso-8859-1?Q?F6wQTbo5+CU6BajobBgh/iorYurY0GEG2o6auCxgK6IphmA9yJJw1DMoT0?=
 =?iso-8859-1?Q?Uvo/5DTDpoA9ChkieKP5dJ+fW2ffHyftSjtUH5atGbr72GJbNVx4n1CPYj?=
 =?iso-8859-1?Q?wkdNA6FUBGPn1sz7w9FpF0NPIiBc1zs3MEnBOQvxIdAjivoMTf4Iv3qMw3?=
 =?iso-8859-1?Q?NTYzops0wRpEkwGh4fwf5kHLAQGofkjl4H0PT3A7blxZ9bnJ3eEH50sAHI?=
 =?iso-8859-1?Q?yefvH3tlJyZtpeXlj4KpCgUfe/oxYAQIDm1udf6yN8TMDp02SCwD3Zeas9?=
 =?iso-8859-1?Q?FpdyAS5a1oMgaOgynb4ZuSQL7BXvCC9BUOM9N1dA54YPykVcgvFVSDfMtl?=
 =?iso-8859-1?Q?2o7EE9YoapCZz3MYAd9pPIsNfYXdmbdzYex0G5Bf6DI68UZl8Bfn3tuUW6?=
 =?iso-8859-1?Q?3Orr/dQtw7rQnzr9OaB/vSxJOygL5prF+7xJgfGNdFP+RZ+a3IOV55uMUJ?=
 =?iso-8859-1?Q?cAKHOEAuo1MhdUpLH/l7WhGuznRHdB17/NfbqE5o+mhtSGQ94NNqaZR7XD?=
 =?iso-8859-1?Q?jqazznbNTbuubZZ/tpKtsj152SC5SGCa9wbrgZJnEdmU8anoCcqu2ovil2?=
 =?iso-8859-1?Q?bpR/eEXRi/GKaAM4BhGlxFqggwmknvRn9srVFPmOkKEjKIsHoZLzAgTkLr?=
 =?iso-8859-1?Q?SN+57IDYTZ7JJwxZ6TuDO0l8YR7eFztxjU+Im3gRewSPvU12GTNeo6UIGf?=
 =?iso-8859-1?Q?Mm9aqHdIc6BGvLujHV27GNqi2oirKGDaiMr6HdY0FWAvDpZj7Kh4Th0Mv7?=
 =?iso-8859-1?Q?2QVHoo2RmpTA2V4gYOOAtxsXVyLTwqUtauHAuOrWyWDojP1VikoKGtAK8C?=
 =?iso-8859-1?Q?QhpgHgqusIKEyk7HPoCzIz4FYUeJpZ7tD55pXOYkDuifJNzHOEcctXHUMm?=
 =?iso-8859-1?Q?9oRPwfJIwKowRySjJkw+kfXfIPp/DyiZX8nNwmyRxuaOuk6mGJiVTJJJmT?=
 =?iso-8859-1?Q?7fjtmsGqr1AZW2pW31RsvHQx6FKy5TgOkSba1IsZvBzyP2PUAdCyo4oy/g?=
 =?iso-8859-1?Q?+MCfaD0o8Che2lvBJ10hwS5YBZrZrvVR9swusnb1D1EzgDkM0X8jwi4w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s3dmyD8bam3LXn6FB4TTNgYBZoF8dqy0A8Chg+cPEr/bvRV/b+YFnrlJptmhgp0oB5/MaiGNHUz8WCm6NWZsHztfD/I8AwMb2yg0T6LSahBAjkibPaj10EC1u2K2uNf0yqIPhJot+9clfNX/Qv3/gDvrMZKmu39kjdKHzokOrcvaRcALyRbi4dniZNjKfD87llAgdSf7oGrA1v2JZj4eVEC2QXHUqcDvN/5KIlZ0fYrBtGT3lRQbEWYsMJq14YElLiRSGDO24MM1WX1ax7DLAJy1exaxFDreIgxZWdCDVf0n5zaBA7oEn0eBZ2Cw6lbUnT9wsKqHzWWdZYRU6n2LG9LrExzeCycmqQHEj4QwJVCfEQb+fOlDdGERUpQlz1Iu5oMESwladgBR9bwmM8bH5FigHixbg4WvAXqrLGtycVAZnbK2h+hHhugO8Obwt1fjG7vIHXPZQCRZXDx5HnfYw0v49VaptTt8i2mNPS6c4ZTUONjwiVK3qi7hMWo8zYQkuIJU4gCcwMCLrzjaW8cZStj3v4QCwltdgxHSptSGhcSGWG+U+fCDOPGseoKxE5ZaMaS4D+QRyZcgl3sneFMxev1+HreTpGZqWgnCn6bsg/6jP7DfKPPGRvkJa54oY/JjgqtNWNoro7327mVXGIYt0OtGAubahBy39XGaHVQ6ujIoeTHy3I9vTw+1xhUrYgCJMsZZTC0xXyJYBo51s/iV17ZgV73uLVJWtifa2J0iM3cLk5PKW4og7sM6n7JsYAJM8MwhQSiXK/OrRmmqS7m5X3Y5YybNuA92F8nvO3tyZPOUxtOdkU/QZxSnuHr8B3Vk5r/o/FJkaJSmCogfjfn0qfv7bF5ftaqr8uQE2ld6J+pkaRLcqMpTOR/fcgO79IGOgmSTm0iI8CxEki3TkJZkKQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86b8b50-c834-405c-6cd8-08daf833579f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:18.4060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9Eu2cHp4YheO6UZs9IN8n3kASvVVzhlryRTgz5ZdO6UXNLwkZXnwqd/Dt+TZlMRwq8+Lw69HgKOyGjYBFsbZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170017
X-Proofpoint-GUID: BokTgCxyuqBM0xJasse7bo8kNTChXCeU
X-Proofpoint-ORIG-GUID: BokTgCxyuqBM0xJasse7bo8kNTChXCeU
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

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mremap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 94d2590f0871..4364daaf0e83 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1018,6 +1018,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 			unsigned long extension_end =3D addr + new_len;
 			pgoff_t extension_pgoff =3D vma->vm_pgoff +
 				((extension_start - vma->vm_start) >> PAGE_SHIFT);
+			VMA_ITERATOR(vmi, mm, extension_start);
=20
 			if (vma->vm_flags & VM_ACCOUNT) {
 				if (security_vm_enough_memory_mm(mm, pages)) {
@@ -1033,10 +1034,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsign=
ed long, old_len,
 			 * with the next vma if it becomes adjacent to the expanded vma and
 			 * otherwise compatible.
 			 */
-			vma =3D vma_merge(mm, vma, extension_start, extension_end,
-					vma->vm_flags, vma->anon_vma, vma->vm_file,
-					extension_pgoff, vma_policy(vma),
-					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+			vma =3D vmi_vma_merge(&vmi, mm, vma, extension_start,
+				extension_end, vma->vm_flags, vma->anon_vma,
+				vma->vm_file, extension_pgoff, vma_policy(vma),
+				vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 			if (!vma) {
 				vm_unacct_memory(pages);
 				ret =3D -ENOMEM;
--=20
2.35.1
