Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7E63C595
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiK2QsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbiK2QrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:47:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDF26C73C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:45:22 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGOeuf005604;
        Tue, 29 Nov 2022 16:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XGmyq3cB/rLlWYlRNysOM7VIOIrvlGoPMWL5Np8VGjE=;
 b=Uv3z7awaUEQv+2NTZXNcxjDOyrbi6zwI8HgOjJNOkn0wCJM0SxlZqmg3L7uFMFS1KPTQ
 AHb6hiPKU5sNBK7TrviQ+ee1uuX6YD2bTMcBFMtUHJldMsElUY5TvVilpa9iR4bIm6eZ
 2wKi+KNdjIVeUM39AlLbgvgDqv3bTF6L0fFBCjQkCYGa2H2zYq130fLkmxXL5jTj7Bd1
 FBSDoeRKKTl4N2i0Bed3uh6pGQK1QJRhgY90UwJwsCfalhq5MYjAYr86V5q084Hy5i0p
 pEScVsIDGsqf9xuUS/yyBlPWaTwhRyAAYvIeVNjyGqvNf1FtdqcD519Iv4UK/fKo6eJe RQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2qfcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFkaTx026698;
        Tue, 29 Nov 2022 16:45:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c1vkkp0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuXQLIbWupqVyaR/7Q4EFgXnqleQ/a+tQDraGp3FkagldRaFBD2DraRIXfDJXUz2NbpJp47DHKDd5q/EOw//vORh7aii8dMjIizkCiVZjQoxOabZL4qkcGe6cWOIgfm0x9bgNiYSd1icE+kwurNokDrJHfua3jSZ4AHV5YVDS+PmprhX9eOoyGSdTz3eUehYaEgpxGLP+6F+rvrH1lnOliTIu4rK4r9h7T+0ZYNjCCQjWhcUGKeTBDNRVbAljhq0TnNMHcaI5YNwL093osk2eU8sAmUTpAkaH7YfLOdiY/EgfJxNnvQg5aDympMElxbEj0wFJYW/rwJMPFoQF+YUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGmyq3cB/rLlWYlRNysOM7VIOIrvlGoPMWL5Np8VGjE=;
 b=mRXxIsCORvOcAyJKYRf08lYwqS8+aKAw/phezbcwzPJvtrgI55KY5Eoo9Vr97qicsG3B9ofB7/gQtOies1avOuIQVVxh829LWebVRAxnUEcQnkJ/GS5H0w/Ml9yr9IWTMtBH6q7cw5J1oYL5nHSJ2SIAdLBXe517gQGR/j4hNa0dW2k4ZaNN2ApLS9T8CxXjOPMWoJhgdYgDuHcwKXeal5ifbD4ghzzt/xaNkNTxQKr75lZNOk2cV+OAVZHUGkhDDMwvcqqo1IA/DjCkKdsFRvuZpEXd5yza3vabfa7M8vBIIfyDhoyTSJGrV65qQcCGtxmX8uKljl3zBQx/3XRkag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGmyq3cB/rLlWYlRNysOM7VIOIrvlGoPMWL5Np8VGjE=;
 b=pGJo9oRUzKkvZSWQMpKr8fZ/WTHi39mONblzEo6UiecSrVc1ghBDz1hJ9mk1MGPWn2wT4UGxpj5F9QLVMTpm+MzAsNt2riPdVEYZQEmkrRPXDE+9ynnPcKJR0o5P8mW+KZkUpasfyNFt1bxy/EI0k2/xWLJ0uw6ayJcPolOTySI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4792.namprd10.prod.outlook.com (2603:10b6:510:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:45:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:45:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Li Zetao <lizetao1@huawei.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 32/43] mmap: Clean up mmap_region() unrolling
Thread-Topic: [PATCH 32/43] mmap: Clean up mmap_region() unrolling
Thread-Index: AQHZBBHcwoih5czY/UCS4h9Cleh56w==
Date:   Tue, 29 Nov 2022 16:44:34 +0000
Message-ID: <20221129164352.3374638-33-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4792:EE_
x-ms-office365-filtering-correlation-id: 64dabe37-894d-42f4-cc5a-08dad229130e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9JXqyakU7fFFabESP1BhDPfaP9L0GMFERNbKdCvKieR5VWFmILpQ7ZtjQW+4jN7Lf4PugjqSxLP3OmYNzBOtioEXT66/5PYnJpd0RZUWVmu3pekWuwwfIyeAGGdbZ4n59D5DOQXwWuvu1opqQ51LRlYPNXNzySi4nH1jCEHL+Yx+5La0V9WPiu2LqQ4Ny6uWAi6xoBpWdx+w1K5GK74edSNNu3Iw3anFugnvyJ1yLGWZDwayDL/d49jBDnoN8o6BeSDlZl5UkQDb7pjpCgAyBBbblk9LTq7n9ZK6c2h1jgNWOEKtNBnE7MPYjWyCkBS8gzZAPiifAjsxvlwu9WF4CZa5QGGgcZvlmE91nRyrH6kGrSejAiYskXOb/JZ6yNzzfYQvn2Xg5uQYN7ovrPbJLJBFTdNVqzNss/089u3GII+mfmqmJfH1ZEaGOPfvyvqupE19uHKO8y0lOFJnfWN66E7kG4oC0mhzUruyZA9vUhYAZDLMJEmq52SK0tnFIplTXmssDI6GiLmaYzsL/2AeuOuOkyYJynJ6tBrYBhe6kFrm3gDkLN4tZ4wkaigX+3uEEHz7HXYvjh6Z51rR5g8C3PskUksf2+gfbuh7lsyqMKOGrwQLfd2Y6e53e31P3v44ZjT0BW7FCXx5JCmT4BGu/npdyKlhqIq7i5OrKxfC4EK7jPuc+HV2I8qJbeLOBU7CwQamcBy7KwaJajqHRt//7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(38070700005)(2906002)(36756003)(86362001)(6666004)(6486002)(71200400001)(107886003)(478600001)(44832011)(41300700001)(316002)(76116006)(66556008)(66946007)(91956017)(5660300002)(66476007)(26005)(110136005)(66446008)(4326008)(54906003)(8936002)(8676002)(64756008)(6506007)(6512007)(186003)(122000001)(2616005)(38100700002)(1076003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?usnnlj476qc2QXoxVGATX1hipZgOtAQrzZqqeQIEW5K3fiVefYrgGbQ4gQ?=
 =?iso-8859-1?Q?/rAQCmp/gcRVYJ4oE0jAPIysImxvnF2LcS1y3/m7/t4ZnIInKBEY5VkQbT?=
 =?iso-8859-1?Q?qMC/vaTxZ6wvoZIpdDPg8uN1Sd9hFTwPHxV0JS43VYPJ0aRHep4b1HN/P+?=
 =?iso-8859-1?Q?xrmEZz8NXjkPkvfWrSI1cc7jOhax5oh8p0kbQb6JarQ2sWSR51fmc6U6g1?=
 =?iso-8859-1?Q?arWLaOeBt6DOyjN3HROR+NEy5hUp/R4etGM3h+uHjjoe7N7jteRHkPxbAa?=
 =?iso-8859-1?Q?AnqODAUb39i8KjVuV8Jl94HUsfiUhkwQoXmXIubu+yGZgN0DhMIqFIFDd2?=
 =?iso-8859-1?Q?G3yhjkMKGSDWOAvLXMvrBNVOdmAiesGKWrnWlXeIMY++ihB0m6NCGekAJn?=
 =?iso-8859-1?Q?V9oQ4O1DJG39pVvwHMuWUJtdVFERjucZHo5CFAVsPW1VeHQYDa4XFYwsuw?=
 =?iso-8859-1?Q?hscX8XnwPj78M3vfM3kLgOsDyKNrKjT3UDBWjeNB4IypYAiExcFrrZUXBv?=
 =?iso-8859-1?Q?lFNvR8GkerXHpZfujej4hZnOjjjZ7cYLJkOW5iarNXos5rhBJXii8u3IY4?=
 =?iso-8859-1?Q?R9ddAtMJ9rZvlQt/hV4X1cbgMdSLKRvcgV1ZIV7L8/XRIANHtK7F+bvYnZ?=
 =?iso-8859-1?Q?9VHuMabA8rDTW2zyLyPg6Ugk03koyFEk6H1mZmlt3yK7LRO3EqaIprLGOS?=
 =?iso-8859-1?Q?9N8+kZB05XinwSLqDiPIYy3FWFV9P3VEZGe+1DO+fWqcQWQUgE0XuYv3Ct?=
 =?iso-8859-1?Q?pV5nQNMFhqikYYroiH3KtF5SDw6NB/RVvVQNuE5QFGth8Gx0yfZLqzydok?=
 =?iso-8859-1?Q?QCixVXXoEHUhn0JHIQMrWRmjOQQYDCwRppMw1B3XLbhXMMfg+BVlWYQvNI?=
 =?iso-8859-1?Q?qCrKrkuF0uGOd6aQshJvJtc4k86AfbsHnSiFgi8U4F9RFSAW7I6TJ8EsFe?=
 =?iso-8859-1?Q?iwuMBlbelICxsp1TnJQveI20cD0nM/GzzbbXMwd+rBJJQgPOZi3Dz+Efwh?=
 =?iso-8859-1?Q?XwsQX/eroH1BBkbdzko+89dfLpYz8HCpd1JvDOvDyQMT9jVPgcgOlTSGN9?=
 =?iso-8859-1?Q?271vFLM2G8ILpOrb31moEvDkj3/024nadIjD46vhJmhQbuRAqPVmcn7nXT?=
 =?iso-8859-1?Q?g1GcjGn29pB4WH79iPLCtU8NlFyoe766bPZSudJd+W2RaeICOyaCoDn+JA?=
 =?iso-8859-1?Q?gz8/Xm92mMpFfCFs+FpYQnVCUj1IUsHd/CeOGtF2G5fkkq5p5MiO0193ca?=
 =?iso-8859-1?Q?cx02aKpX6Ek8J+CvIsHXLasWW46RYcU0/1nh59aYYP/wklsR2Xn7mruvqv?=
 =?iso-8859-1?Q?pEfWLVFhHn8jlqxDwrmL/QFzD82O+f2P999HMqgCiXeIT7OOgIn9erLc1F?=
 =?iso-8859-1?Q?STTsML+t7QmSf1aW06cVFCOQAo9+hVK88lNBslGr8EGGu/dXXMd/wKgNJ1?=
 =?iso-8859-1?Q?BN9Gcz16cIS1mfcHMQytQiOW3/16qjZi5dsvjUkyEdIGtZCr1MTZtFOYKF?=
 =?iso-8859-1?Q?Jd+7adokE6dEpMMQvsnboejHtOmh7L44SPg2qddZxd9kBB9xMfD1Kd056h?=
 =?iso-8859-1?Q?k2Ya6nPPwjOI6/xmHXZofgKLp4Fy9EN/l2vyXTfjKKiF0m5OM2DCf4Bz7+?=
 =?iso-8859-1?Q?GATx4IH5RtUC98+cTOnXVoqSTyCLH6KtwnLJaTOKak2zLgKOiCuHwdBw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kUUiTvEheQ3j7M0bbE5edT4AYGkVUQAjDXHLgexS74igO0WAh9cbtxHacssXpoynGgoADCY62WbeEXe5CLQIOOaacTlxtY5hZcUIDbqXB6vzCqm3q6o2AjEVLUfd4nG4RcA+vtbfmjFLaXAWb0rWc8hoKcTYN4UcDoS3y90KvfYLK+5X0+ZJ8jl7WAzfjBmk9mtped7JjTolMrOYLSenXvAqUN++goesnNhVIt7X5ME9nzhfuNQQhokl2oZaIWLK7o5k6OnpkiezI75VzHKSRuw1CBeLHrbhc5yalNsT4ofA6DhxCd+Pa5gilxpOu7zcAG9A2WJ8b+YljQHqY9uk9kF6XlM9+wojELRISTugXmBsxB/eBfuuyqasBhPBTAwLwodH+qOO54T83ukL+4qPhvE8W32ABTL1hPWSLnvqxy6nbztjjhDQvkzeMl4iA/8+KQsoV5tWnJSLrsBCguVeB3UarwkGdL5STzbd0QEapF7MvLIM6/mnHfQJqGHK6B2oHogH76t4IK7Q1BuuTD9Lb2FKDkJNW0ZL9aCfpBB3EnU/L4GflKtle6DMjF2yz0LzzKjKOpXJwKy2ITC0ENsIvRgg9pYk7Qo3E71KLHo5NWS+01nDhvACUKzJVKjnxmfKyiApENaXlH1wQjPwEQHCuneZpofWUvLbNIdfBNfCYDFGoFUITVLZZfbzfHx75heRKlZfaifw6WMWeA4xb+KPxv8GIY/wCe3DUb8g5FEFvdCvnfnamv4497K3noZYDICwQawI1UPgATfDxAMWKowsd9SfAEbnn/tTl48gNKCnu37sFQa/PHYkK2rBuDP0YrJLf9nfw+aB0SIe3E7bi2ywShitsgOqZITnmmbwg/dpxnnYBojGws6RENHkMpUIxxymtSPMqkKFKAsheqhIpu3omXLhdTEAf3LMKWq6bDPoewg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dabe37-894d-42f4-cc5a-08dad229130e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:34.4723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utYxDYz+mrsR0Iu7HR464uAQNN79l+gA4/a8y6xjO1QldmtE7tBKpccR6YX5YvPTNXZyhv3wUC3ssivYaL35Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=781 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-GUID: 12fzLJIFI-E5w8L4VZimEcp_HIreA-Hm
X-Proofpoint-ORIG-GUID: 12fzLJIFI-E5w8L4VZimEcp_HIreA-Hm
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

Move logic of unrolling to the error path as apposed to duplicating it
within the function body.  This reduces the potential of missing an
update to one path when making changes.

Cc: Li Zetao <lizetao1@huawei.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 45 ++++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6b05e1dbf705..af611f805776 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2660,12 +2660,11 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 * Expansion is handled above, merging is handled below.
 		 * Drivers should not alter the address of the VMA.
 		 */
-		if (WARN_ON((addr !=3D vma->vm_start))) {
-			error =3D -EINVAL;
+		error =3D -EINVAL;
+		if (WARN_ON((addr !=3D vma->vm_start)))
 			goto close_and_free_vma;
-		}
-		vma_iter_set(&vmi, addr);
=20
+		vma_iter_set(&vmi, addr);
 		/*
 		 * If vm_flags changed after call_mmap(), we should try merge
 		 * vma again as we may succeed this time.
@@ -2702,25 +2701,13 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 	}
=20
 	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error =3D -EINVAL;
-		if (file)
-			goto close_and_free_vma;
-		else if (vma->vm_file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
+	error =3D -EINVAL;
+	if (!arch_validate_flags(vma->vm_flags))
+		goto close_and_free_vma;
=20
-	if (vma_iter_prealloc(&vmi, vma)) {
-		error =3D -ENOMEM;
-		if (file)
-			goto close_and_free_vma;
-		else if (vma->vm_file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
+	error =3D -ENOMEM;
+	if (vma_iter_prealloc(&vmi, vma))
+		goto close_and_free_vma;
=20
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
@@ -2779,14 +2766,18 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 	return addr;
=20
 close_and_free_vma:
-	if (vma->vm_ops && vma->vm_ops->close)
+	if (file && vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
+
+	if (file || vma->vm_file) {
 unmap_and_free_vma:
-	fput(vma->vm_file);
-	vma->vm_file =3D NULL;
+		fput(vma->vm_file);
+		vma->vm_file =3D NULL;
=20
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, &mm->mm_mt, vma, prev, next, vma->vm_start, vma->vm_end)=
;
+		/* Undo any partial mapping done by a device driver. */
+		unmap_region(mm, &mm->mm_mt, vma, prev, next, vma->vm_start,
+			     vma->vm_end);
+	}
 	if (file && (vm_flags & VM_SHARED))
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
--=20
2.35.1
