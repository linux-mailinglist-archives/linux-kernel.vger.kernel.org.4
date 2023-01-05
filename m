Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F68C65F457
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjAETWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbjAETUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:20:32 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93F76F942
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:17:58 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305ISmZm001337;
        Thu, 5 Jan 2023 19:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=eh5UlXV7hjFyyF0mhfN12WYE0aWYs7buLsoJ1xB7wXA=;
 b=uUCEuLbeSbXKg+dfr8eNLmhWP8+YvlNo5vsd/G3XpI9A3V1FRWfOTjsL3983tWYfNVI5
 a9yzxeoU4Lg053R2GS4q6pY3TFE2j2DcJVAQaDEtgvm5OuGgDuhf9IeEjjgtrkE0i16L
 z4SYCFkZMArnO0GZ9Lu2S5wbJ/bD4yBDEAIILuVylGWSydIzTv/FEvpblKSqF+/WZfzg
 n20NAFzyhF5a+a8Vwfh0CqWiCwlknpkup1G143bUeYIzd3fosqc/2DgPiARtkgcpxhXg
 Iiq1dsIHAsptxsFadLb/YvCECEJokUsPeZWZIOGeXMfnQ+rDc8lvWWc26dIOZbxLtbU7 1g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c9r16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I1EPj033688;
        Thu, 5 Jan 2023 19:16:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwxkf7u5p-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kb0vNC3+LykOoZzEXVFAahBSpbLbxw9tZY03b0XflX4R6KM6RU3iWTkmQuldqCJ6QBEYxiib0ryiVNhkeqyVWXNCIhoBOXMa3eLsQm66uUBJUT+MpkxOuZAqKv/53HWGxKE5UeGliMQMdtv9fTvMRI1Lna7khcG6Giop1GmsmJ5dOvK3/Nu77gm6dvSwhJoaPNXSZoynC29o2PZ1K5q7IzEigRoJtMZpf7jX20V2/XuSS21IejzNNfk+/XfN5fbWyS/mOXU7wbhdhyODwv2JcOrKUuIlfBm380rtMN24RPHpADpYZ29pQrtyBiZpbSW939Pu+u93HEUobIG9n8MnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh5UlXV7hjFyyF0mhfN12WYE0aWYs7buLsoJ1xB7wXA=;
 b=nme5qLCfXSFNnXyiE5V09WcBtQ/kHxSGnGRV2uZQY9xAmyrkHB1GF/YpRFnpay6wmf926BUlSk0JiH9Oph9EzmX8asJPsQXgsbeL0QW4MHqoU872DZP+FI9ySadvvPM6A01C2bioo7A4xvr2lm/vtHXyHXME1bN/qImEhlVXvDBhCGskndQVYJrkIJNiWlhwmfswjyBvXVSe0ZnwWjNARsRpSAgJtigQziNev+nb7ykFlV3V052ftVEog69Gd0saxawoNH320MPYq2mCPkMZXIf28Pkji0GrTwgR573LSxfIvhYteWyCp1+vy295GlIoPIWCrVGhG2uUUjQYK9xiiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh5UlXV7hjFyyF0mhfN12WYE0aWYs7buLsoJ1xB7wXA=;
 b=MT6YldWqtpU6qENoHZjaxNkKBMzdRor3P/AEpYZK3eVpz9jZP2WA2/L1n3XOXkv5OArllRMT5AquAh+X/q1CdobVjbcMIYRuO4yJjUMsS0bjYyMYcuY7HerTg9a7QWYgHcp+tDUC+/shNJzwh5PGExMXLJirBSCvHcI0l3kL/JI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Li Zetao <lizetao1@huawei.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 33/44] mmap: Clean up mmap_region() unrolling
Thread-Topic: [PATCH v2 33/44] mmap: Clean up mmap_region() unrolling
Thread-Index: AQHZITomyNN/f3iGgESlRavw6FYYgA==
Date:   Thu, 5 Jan 2023 19:16:02 +0000
Message-ID: <20230105191517.3099082-34-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: cf2def9d-1fc7-4347-0324-08daef515eb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8PxIy7q1Q2Ez96F1evsZjkzTMePcrSBydHD1rOX5nBhXBOhdmScs7tOFHGmpjXZhySvJ+pfn6+RJKVXpanUzCDx6rd7KRDgZZuY/AVqDEWqP39VUpeEI/Y+T1+GicGbJl/NLjzOUDptiZ9mmG+CCLe7g02JOsHmqa/dkN5kKj2LkzPhediytI8KXvTkWyS27WQNvxsNMdTYyktep2PLEZuYkokx/dgOkXhAFzAsKutpaVFUk7FEOUdwSAoFasjZKr6YmO9mNL81MQNoWP2XnM4zarVSqY+rJI22bwxqsHOTy1hWsh+QA+pw0eMD7wTcWVYrbaQZelDfR0AsqrjCe2HiZwTqK6tM7w3nebkluY7vgiswhjMumtEkGvPRszZQIFtCyEi1cLIs9ZZrTeGUnMKR1PCZyDLQ78rzQUkafB8xOrmt/ZOE2uF7ycsYnNeF6+PxfQHFAmVti+bwUQbeZ2bJWQ5j+MvuZhzQOXmtcdbF8Z8wIvFqIdrsNLAkfKUXSt7LOAtpWw6sVnnGXcbHt1rprZ7k3efnWPkCea/nzrE0/b8n18ANk8AYocs89neXTgmUfS0I1qEkdobbTsTBtJnDcFdlzh7f29UgyzT03/wfFTGh6gBN5UtzfFChW1wCQJO0LqA4BzadZuS3iTbL9KRleaCZj4oahDW9rX0STxj6/pfV0qTLjXxZTXwXQnHGcNT2iEkjE6RL6odKnQGQ/bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(83380400001)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HU2wUGevViikhwi6FuDjcEyF2pqLEOSeIXYBSE0Z/6gxtr2vUrzGgxMngw?=
 =?iso-8859-1?Q?9fSZMOLVjKZo5NoJ78/cDCaeou+XhKuoGSkEILBo9tj1yCSi9Z1snK6Hro?=
 =?iso-8859-1?Q?ogfDhe7HJu4XX3ICFFuKZ9mfznyWofipLlcqsNo8AvLRp3ChYh/bRe84VJ?=
 =?iso-8859-1?Q?+0xBDbWKulSZlvRGwZZrwrg4ICmBTdmhra4VsmT4pOkKupcW5gCDy7ydvL?=
 =?iso-8859-1?Q?zvy+4CbtcHDhr+kGx2O5Dl71Cam7M+Npf5FIn79Wc/6BBEVJaCksPSR/Ve?=
 =?iso-8859-1?Q?RdTD0iemHEx/F72WUulk7Faxc/jlpi6DWQCXkcqjBDdkdi+A+iYAWaXJn3?=
 =?iso-8859-1?Q?TiMgfPmei5x/cA4imJgWEVXvjFS61D4D5yWlp6M+SQSJONl0AD2UXBMSiY?=
 =?iso-8859-1?Q?T2gDAjGFsAXNsKs6wYkMxs5frPJYXkFQJDOUVu+E6WadKFxsKtrBrRNFd/?=
 =?iso-8859-1?Q?6D2KodJ93PhO/47SBJ9CcDiKoWjLWfMxaGsCcyCIgPuBppukBY2ICANKHz?=
 =?iso-8859-1?Q?7FSW/eSa5/CuLPG6xMN4Doay9Plxx/U3POUu+H2vajUvDREgDytPRWOMAi?=
 =?iso-8859-1?Q?DOl42n0mxPi6jx/xvJP+dE0OwxI5TQLKI6j3zJDkpJJwkS/Ajm+WY/TP1z?=
 =?iso-8859-1?Q?zAxKTqcZEhKPEVQCKTw0sGDS5o31K+ZCC3kNenU9kuj9yv5IK4B+z+Rg9l?=
 =?iso-8859-1?Q?cAcinriuYpr4+QONQAvH7bJt0b1DmJ2m8xM+JmSjuOvc1uAfdZbOOZcFAs?=
 =?iso-8859-1?Q?KxLnD6RQN/l52ifoKp7FGgiJE7LkHxpJzJA+y9s5O+HUZ2jCpYEgPJtjju?=
 =?iso-8859-1?Q?u2smxMRsT0tBg9zUTUCplGnh00PCDn5vBeDNB2INtzhwUH8eL7rQcnCfbb?=
 =?iso-8859-1?Q?cWHVDZwVYxChHnYg9PBBM6cQceNwVTMB4nz27yVR8RXqHWkmGAKxspmWm/?=
 =?iso-8859-1?Q?gVF/ce6P5Mq3Z9R0QyQ6WUqch4KmwanGMzcXh2K9yx/227HsAH5QjPfy78?=
 =?iso-8859-1?Q?bGiKqhx0JFdb09S8OOHkck1t7GaXMaDE1ADaae7jQmJCH3Yz1Yh+N3ley9?=
 =?iso-8859-1?Q?jkOTr1XpKN1Q6RFtiOczJxvKX1xbZw4QTbB8QZXqEE8R/6Cjhu1pRvHP8b?=
 =?iso-8859-1?Q?A0WR5BNBARBUBjCTKsLNllMcgUt2KadGMo0I5aO9Q+rKvFZ9XDQwfcVdeZ?=
 =?iso-8859-1?Q?o0lMTuB4mCT1/QsNmR+ugJ8j+bSltFGAe8PiFU52SnTTQa6cm5kmroTWYw?=
 =?iso-8859-1?Q?e8SFgmRNXkG2Xewe3U+Qg0CiASWsVLcXjOpeamogSHjYuvPyn3GojUwcQ8?=
 =?iso-8859-1?Q?KXcOtA2MbX8mPEdLkpzBNCTCgOiwVJXo/VbOY2mZnzSM638lptu74iZNLt?=
 =?iso-8859-1?Q?TF/A6L8dPcjSAeB58WJeFuDLtA0U4Bkr0KBMHlDTKwnxpdcAN0X+cNSZl4?=
 =?iso-8859-1?Q?6HVBd57QgR0CjNcj/alz6jggSEq68uJi5Dpdidy8NY5K9nAuC8CntrHiyv?=
 =?iso-8859-1?Q?y1+5zE1q/VdhpU/sZ9/XRLZgugHtNICEgSlw+/12pww/i5HTLl01jeh8pw?=
 =?iso-8859-1?Q?PDf4bSTLose+ojKsINnSf/i4KaQYazh+ad67gXx7v1afMHeQ1Bev0iwJ3A?=
 =?iso-8859-1?Q?bIoolzkLcYucKU8VaHrz5fflZ1VJGZwq1O5pm8TbZsxX7C/Id3ltmJtA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3KsKPOHQJtHimdRZ6VGBFRynGdI42VO5AGNsyGSxLaEoJrOiBxu6ItSZPdU8vPlxJ9YYwfMOWJmrJcsVm2BQZroloetEB1kGhdz9bYUfQo6yXuYIzuglvZ1CNbvnd1CqNxBTdswbHIIox0AA0mm3jX6ICk5Qdh9QeQEhda+vzBMjh3wYzMBb8mO7zKbzqVzlFNK/6K3+qdHK+4qxtOX4s625hLhNBjZquGS7RktMURld7rXVbNpfmgru/gkodOpMTIQmph56GBCwZl/I2P42VhbptjDOEL3Y3mIpZMhXxdaDiA9jx3zOKlVvY80YulYdWV3VN8SJT0tH1msincosks4wSabVUVYe4YPv2d9r97OtJ9TDS7MzikkeS0s/fPiqJyfdhg6BpKESDj9iv+aKPn+NjVoT6ZBwuiPx3BUJvHFG7R4x0KKOig73AM09ZShojucqGEW7lk2agd3nzjJm/UuvEwjWApZALbXFaVNDELA0pwGrbATsfptnM8xfDIyKMSwBR0jtiB7ZhlJFvUvdrZc4T/IBjBL169pvLT/poOFOAv09jLjMYkVOD5kaENUY48JcQ/Kjg9+uKQ5pAgtfOPcR3lw+gPOURExuZDfb3FBeStmEzeDTDiyIxNaZ7/HBvok0a5JQ+hGq7MHD1YqfkVguYK4vcrv4p4Lq4IUfBqzGEZE+lshvYPRVimjKcQfFflwaNnsKsLbF2f1x0RN2kaPEIK0PWtPIUcHz9x4s2q3fAZ1F/oZJxExNZJAUZZOCUIletm63y7x976xXj/z7jyPikSa0KEl647m+63jdstemzQ2n7C/17Wj4iEvm1NFT83zUTxY7ZOLwMD7+mr1InQmu/XjRd2qI7Y3f3Q/xJDq74yuRrdqiWF32udanXq9yWKOpKeVk7vAsYk2F+HnTCP4GPP/ouAWPI98r8LRdGoc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2def9d-1fc7-4347-0324-08daef515eb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:02.7034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HidwpkmwvxjJbGwy5LgjxYrvM8O2yW1Y/29rYQ/MofzTJPXuf2q+FeLle9YTuEGgQA0anQIJS2Ii/ET702T/Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=759 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050152
X-Proofpoint-GUID: t1EQbkR0zvKz9OWLBy3ya6XhALDsT1im
X-Proofpoint-ORIG-GUID: t1EQbkR0zvKz9OWLBy3ya6XhALDsT1im
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
index d7530abdd7c0..99c94d49640b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2659,12 +2659,11 @@ unsigned long mmap_region(struct file *file, unsign=
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
@@ -2701,25 +2700,13 @@ unsigned long mmap_region(struct file *file, unsign=
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
@@ -2778,14 +2765,18 @@ unsigned long mmap_region(struct file *file, unsign=
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
