Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB62062D0A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiKQBab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiKQBa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:30:27 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40245EFA3;
        Wed, 16 Nov 2022 17:30:22 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGMhoY4025204;
        Thu, 17 Nov 2022 01:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=iCZ/dh5tj/4YHQqldS766p/BQG9e07Ck2fkWIsQSsdk=;
 b=xzIj6tbhbata9fj6qg8RXVJFS0tFj1nnjlTw2vKa+tlrXcA2CJgC2rgrRrcjPF+kw0m5
 5f2xlgyg0DVCuWRyFrg2qqISyXJy/G4uNHPtwkza4PKMPmrkr8jaFlv5mrI55xxHgGGJ
 JJXiFxfwq9rc+8t2rB/CQOaJSQZ02LmZY8RiZaayLijKOlny0p8tRHnhNhLO4Bs5Q9KD
 gJDCNxbUz4igLYBHLF+mp/a/sAqsArKume1UA7hiLEtbEOR2YqbwmdAW5F8gUoi0EMUN
 qgTQgAQg41SOVQsAM8ofyHIe5uYWygrnTVM8a3Kv7tUvyw4oYUXm6x9Qz3Rt9pkKdEr6 yQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3n1780n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 01:30:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AH1KFvO027198;
        Thu, 17 Nov 2022 01:28:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x8afy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 01:28:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWOsjmX+Gj4Vwg/VFVdRw+zbirlxb7iBZj9E7oL1DSRgOk+MflrA4Hsv3SQJdrPWQcMAGozsvsKBSbf/eV/xtWcNI4PmoFZBCzVTlvLXI8FFybR73QKZWq9qQmZkMnfHYAsdRxW4LUSmgtayBC1VR3kEg+8r1kSJ+xsTnudVRb7aCseOd4oeG7GMb1JbzcK9Lfu3fAYmax84OjSPa+N+hSD4zwkib9Ze3zximD5wPhiZs5/aHohjkdydQVi4Y+o5zT3YDv1OdXCclm0KYbSWYDlTEjCbhTBdDfZFUsSaYV1zHqGUTJc0WhgyOOAf1XEx/qVFZNJXq+L782Ob34KT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCZ/dh5tj/4YHQqldS766p/BQG9e07Ck2fkWIsQSsdk=;
 b=KhNQGQYjdofAXiG/dY2s8zGaJlRugl2RBebypAuoU/KbrQ1AmVdCeEGPCQo2iO/7nqIcXxKyfk8XCKSi5/bI+NuQqQkR3oTN9iHkEROzCSPa00srwaXVCymOZkqIfv7EeA44TxwzD90gZjV09xkJ53CzC87ChccBZEeS5mysPLwPKSOz/HIZUvrRR64lXVmw3/DrjOy6WTDobHVEn5ynJd0TA+IHVRY9erQpfu5ZnXt93rJcImx2avp/BDifRemwiSgjIiKXzKyVDGjrxEPJRyZopFmkf+eZastDJFaEPcUCso3TmfMTVPu+95gK9Bjt+oQU2utfmoBw5jPoM31gQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCZ/dh5tj/4YHQqldS766p/BQG9e07Ck2fkWIsQSsdk=;
 b=Y4BBUUTKjf1ZFJDpOkv24rJMHVs8Hnccfj5RBdRVRqgltV7kgzvo5v28qnM/NdL8N+ZHsHpn3h/6/wxMbmA8lXA0qgrUiizSyDgCq5qXXRqdA4WDWFwmheI2oNEMC0AMSbnH6lC80qam0Szr2hAW+43A6FupMx1Z1T1jVrE/2dU=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by CY5PR10MB5961.namprd10.prod.outlook.com (2603:10b6:930:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 17 Nov
 2022 01:28:05 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::8127:f9d4:2c92:c253]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::8127:f9d4:2c92:c253%7]) with mapi id 15.20.5813.014; Thu, 17 Nov 2022
 01:28:05 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH] padata: Fix list iterator in padata_do_serial()
Date:   Wed, 16 Nov 2022 20:28:04 -0500
Message-Id: <20221117012804.62514-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0027.prod.exchangelabs.com
 (2603:10b6:207:18::40) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|CY5PR10MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba8b233-b30d-425b-bf2c-08dac83afa2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZeQWN/QnyVIEyAlluyh0W+BCgCtfDuRkDIxRsb5BI318HvCDyYIDZDS1d2r+mF6AmJ5MWozXV13WJjjfEjcOQkHpzOUZh6aZcGesKxU3XhCqZsZl0RN3tikkITiVmHrA1A8NkwSSatjKqHEC6avf59fvqB2WzVTN8L7Jti7FuReRIFotSuLAF4MCIaaCnzqhBjQa9y91XjlgNMafTVQ2yo4AY+k0wGPxEtgKo6iaNs2D2PuUBkN9/RnEkHJEAtaqIes8Im7GVqmHxK4T9ZTknixUw75YHAj6vTFSuZKlaZvfKmJo3cMeN/PzXKWqlq34YPWapNAjKYCHUZjRnT2aITNgN7cMccUr/zvWeSk6+RZduyYceEWGlP/87FJvn1IMX8+ezbrXG97Shueosb3D41eMyZNdcAw4oekxUf/FbYctDhkJKqw5WY2cAJoInVIJkDAGiVg3F9vcJ8eumS6nGHFYFllwgCQfxcIDzFhcYBqkPDLiWMzc5FfN4Z+RqUmuK7MQBFj/k0PoEo4FHLK5SVo0Nlv7qHxkSNeQHBBJw3pk5JfNRbfJaCvzTpPxy0B9EyQo95yAI5oLUo/egSUec/lJCbxzGH1rtta6bLGxXFwxqZkgZEeyeXWMbXI5sR1NHogGZe6WqoJFOaP5pwfiqhtWv10sScmhKSudF3/vl73oqNXeEJcjFmLfxADqD4x0V5GucQPoms9KunubXSlASQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199015)(6512007)(38100700002)(26005)(6506007)(1076003)(2616005)(186003)(83380400001)(5660300002)(2906002)(66476007)(6486002)(107886003)(8936002)(4326008)(8676002)(66946007)(66556008)(41300700001)(316002)(478600001)(110136005)(103116003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fRjtmJxU1UwQu0zL/fj8Qd5GdgCh4kBK7TZxXd28nbIwZDyVt3am1I5hePTr?=
 =?us-ascii?Q?JXMKysGO+AIanZhJwPqjZqjDTARb1PHUkRksFYdwPAtPL6rQDOipsDfF25FN?=
 =?us-ascii?Q?v8+Mhx+ypFs6X93T+IL3W9/Z1zCF39mkeEGB9SuvzMUi1koPE0KILaB39qDm?=
 =?us-ascii?Q?RuOESEyRF8yZlC2umGRNi6fhSIKQbaSuWbHgojXUkpwscM3QT371Apvhp3DN?=
 =?us-ascii?Q?TdeIu5PRGWWN3cujixARpJ5oPcppt+0XwPGlcKAYgDW+Q/mjkTzc4dML+X5n?=
 =?us-ascii?Q?CUmfbGXSCjO88iABkgNH/Lik6YXVr2mgcYtmrSwrFwjghgjb6hzyTNno9T5I?=
 =?us-ascii?Q?DSyJghY7DJZZpopf+GqPlyw0Cv+UT9Y5hSW911c6e2fJvZg33PhiEj7d0YWg?=
 =?us-ascii?Q?I4uB2BYxaSvcupxVEo9reXEUwg8CCXoX2Fykyvv0JWai1PSTZ2g3LMqPP2BC?=
 =?us-ascii?Q?qzEzYnysItJMDPLQ20g3JRRxlYi36DLrAPPmZZd/gGyRaEwXrRUEUPLWUnZG?=
 =?us-ascii?Q?dcCvsMLxUfQPG2TAitCNt+W0cT7OfbDhG8hZTTWGgKZrdzqFHZrbPjg1UB6X?=
 =?us-ascii?Q?Y3KnCVUc4/+GfOF2FKN7jLRVu/ofHBXe/1kq9KjSHR4EZvhXrsOUNtpQpNnK?=
 =?us-ascii?Q?qi+wLe3xPgpeGifViKTh90tzfx/GkRUSPRnAVhgX3zq2Cvvpbw8nBCXxsld5?=
 =?us-ascii?Q?AY5JC+yDo41OJLAGWNACZViugiMf+hc05hkFrJyAlrze8FG3SNhm1dh5EYio?=
 =?us-ascii?Q?2lsV1BQ8MCU7aa9t2JneqtdOxYqzjjrNmEHUdxKRiHe1yVleUK0/IxIE0WpA?=
 =?us-ascii?Q?GfqJJUFLNzM9emXjtAH0YN+kUnsyERDMm47oV8FZ4mHMSDvARPTm+zUnt/St?=
 =?us-ascii?Q?StQMcnTKk45EYAYicZj1iPzQXvC5inQfNfqIMr0kNmH+4H6H+zHHfFed277E?=
 =?us-ascii?Q?4lqbFOIufI8WgDavh7iGc3HiaLc3HceC3Rih4kuFlRxlZinKwCef+u4aCJWq?=
 =?us-ascii?Q?BbKQwZGlK0nlrIqwIbUSSCP3DKUfgjmL91I2qiBBnPyc4DR+7NmRIhpfA3MN?=
 =?us-ascii?Q?DPcwLzHTYBTHPSYqazGK2EfNZi7xemJGjPgw5NuOWWfF1F7u5ARm2D/aAcKT?=
 =?us-ascii?Q?skvpLEaicPlBpCaD6h1OvcDBpHAPGH8w0BeKF76fn76c7tAB3GCSPIXsJR61?=
 =?us-ascii?Q?BrT6VJqzBaWGrswDdXEvze2wrZvv/UB5HpJm9x57u4asCmHf16w4qq4B4Ted?=
 =?us-ascii?Q?n2CKb13hJ9ZWWaZd0IaGNnR2x2jjbr65ar2kW3clcXkvDWxy1+UozaSLJsZn?=
 =?us-ascii?Q?IQ1ItmuF0UDuSvQVJhwyQgrI9J5Sm6Oio9t7ITNBNU8ReMGnjXADeHVlCDnW?=
 =?us-ascii?Q?Ny1nySZV5Hh+9nbVxgjhJcg3nZ5hFWXVlJff0gVacmTdGNA/1+tUTIJWON7f?=
 =?us-ascii?Q?jVB/2j1wF0W4Rf7XZBopZGPzeluJ6WGEsUKuI3LL8F8lZeER85qoxnt1RkbY?=
 =?us-ascii?Q?yszsa5Nec0VN15oPIplyW3rU/FZQoorjeoAD9VpELGTF16527F3tlqSOeu9f?=
 =?us-ascii?Q?+4H2rB2UqysbKd75N00X844gShFFDiVJc1NNfvcCrdk/U+e9y89EvVQ2thiV?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r2zhuuo2Lw+Ke2hzC4nKUSBBgoNNj3U4fa8wUL+5l4iWNh5xPEKMM8FZPvvM6b365TtqJTu9Znh1b/jcfim4iYzQ9Evwm0e0txEbYBpe6gnlcLZ9tRoSJOQwHiA55cX/pYXcBqaA/KBv3AbkijjXsiJld+DrVSg598C6edjP/Dqi7wAEIJcn8mwCAqj2wa/KW3b9gxqXWyz44N7ysJ9n9SX9Z8GTkhl29VzJGV63DNXjEXwDz6+gvSyIATYihkdU4q/x2PwUo9LROqGV8omzxCEgMAWGuMjHH1Q6eeYdwG5Cx8CcGPaI9o57N4McglFPca9PymTCRSgcHwdgCghxUxBOEVd9+ENFckNC+3mgDfvmnIQ3Fv4Zk5sQcDJsL77O9HcWmy+I7LlEhmwC7h11PpUSXfeDEjaa9rTfXFBGaJJv8nfRVn9DYL+MUXEvbP3wIaDWW9O+vDk+8nrwX65gpRcTiE6AQHljQtQrrOiCvNjIRGDRHvc+Htd9u0bLkxFIYAP3JCOEbiqB5XbSXZYev6qAPPsHOYgYhWsJBDyjrBLS2vA6pnFDrldz83T+wBXBxcrXKoIVzjjd7dDGeDauMcOpoUlEXsZpWjQsNBWz7EyhRvpmPlcVqPmYGq9LC1bM+PAhfyzbaEINvT6YqQIJVWYx7KfnYNFjLE4k0lRl5vj3hsoLEIyCsl4QcVYDQxjGLyAUECsT1kw0NesT0UnlHQj2sOsSJabXuCsHK+zApiu41QMHL2eZ854q5cBKlvhZqyRuTki3zAnb5DSKGuEoqVDmB4giEeKHFyIexMqwrZbDY8ktohctxvzIOlQL5mlWfi4eC4Ds1jhZ/BAXij/V23PqYG3KF6enfSeil0q/+yPnIIHPtEBuotSxqKGHnm/P2EObe9SLFUUAm7E4372hrQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba8b233-b30d-425b-bf2c-08dac83afa2a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 01:28:05.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMzOpSLsJ3DX5DH876mQi2vU8eJBFJdquYMoL892hTOZq6Kre//gJjngoKYC78CN+xclZPDDGubjPf6ndNbNmk/3CcH8aqWLKXd7yuqt49c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170008
X-Proofpoint-GUID: 6mW0BrSA5Ms624XpoVGViB69W2uqfW8v
X-Proofpoint-ORIG-GUID: 6mW0BrSA5Ms624XpoVGViB69W2uqfW8v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

list_for_each_entry_reverse() assumes that the iterated list is nonempty
and that every list_head is embedded in the same type, but its use in
padata_do_serial() breaks both rules.

This doesn't cause any issues now because padata_priv and padata_list
happen to have their list fields at the same offset, but we really
shouldn't be relying on that.

Fixes: bfde23ce200e ("padata: unbind parallel jobs from specific CPUs")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 kernel/padata.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 97f51e0c1776..de90af5fcbe6 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -390,13 +390,16 @@ void padata_do_serial(struct padata_priv *padata)
 	int hashed_cpu = padata_cpu_hash(pd, padata->seq_nr);
 	struct padata_list *reorder = per_cpu_ptr(pd->reorder_list, hashed_cpu);
 	struct padata_priv *cur;
+	struct list_head *pos;
 
 	spin_lock(&reorder->lock);
 	/* Sort in ascending order of sequence number. */
-	list_for_each_entry_reverse(cur, &reorder->list, list)
+	list_for_each_prev(pos, &reorder->list) {
+		cur = list_entry(pos, struct padata_priv, list);
 		if (cur->seq_nr < padata->seq_nr)
 			break;
-	list_add(&padata->list, &cur->list);
+	}
+	list_add(&padata->list, pos);
 	spin_unlock(&reorder->lock);
 
 	/*
-- 
2.38.1

