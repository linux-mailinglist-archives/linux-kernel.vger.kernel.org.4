Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA571F211
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjFASdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFASdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:33:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69B5E66
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 11:33:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351E4l5W028868;
        Thu, 1 Jun 2023 18:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=SnpckDX4QjnGcMcAxJrrFmweczErJxOeuESW5p10IWs=;
 b=joYPGihOYrRLsRboU2fYucBDP8LcVsb6F1a2jNRWVaW4IQ+SjF0CQ3xWDpdTpvtSZzpO
 hXnvOMSHtantS9rL5SYoXgnQcb7eOkrJN/MVhrI8lMPsyyo96b20HNfnkqm4yoAstYCl
 zzyaAfZNBR5KmBqPc4ykgvUhTDW9fhNl2e3vmB8rg9nWEcQE+WF4m687K0OyiLBJzzs2
 xDHWevG1QyjCY1Ojp/aNujpoy3T9IT/KQqtScavhefgLm0iFZBK4elrQf3A6g2nXKyI4
 qbwE86ydhVvAeG6Lc+O4GeEuNTGaw9NZDMqSn2nE9ZzmNGdUMVtHbPghY0rzl824qZmV MA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjksge7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 18:32:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 351HBqUZ003684;
        Thu, 1 Jun 2023 18:32:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4yf7e3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jun 2023 18:32:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYWSq7oN0g81ejY/gb6FxF7Y4RTZkvf1r6IYbJPLNCqR1cTENXOCFkKUOWZR3vYlGR4MVIREmVphW9a55mw17mxgXyIt4YzVSFtoVcA2ivEhpm/o4ij3EuVgzjUHhEPo1AajPTy7lyP4qNXXvkwUWjsZ7qXJbkUZNoZ4pd1D1cqRC/ZXnr3fpBtQ6QR1cnBmU2TUQTBhyASTWE+KV8p9LFFJXe/zWWRfBrdWw0Wzt18Q0pbspP0LjRstU524bq7csa/WZZYE/ydP1BRER2Xh7OPG6jO9zd8NZUiJABa5fD0x3D7QjM+wARO3ehsr9PZ1OqS2eZ0L8F4LQ8xSkIDZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnpckDX4QjnGcMcAxJrrFmweczErJxOeuESW5p10IWs=;
 b=AtQLU/1gE/++iwraBa2c5Tg0bxPTC5uSZaqwI7ShNwgxtGTGDEcmoDbX5ig1EBOKGr0u9k6J5BHvxAzJT864Wmuo+zMnVREWTSv2RH7zGOiymLRh3r/GqwpWNq+Rsp4nN/aG4EJ+cbUt1a5ELoDbUq17v8da7q7cC+fDKSnpV2a4JFwGcGW/IWvRemiihAGeoLY5jO3rI61Ivo2u7jW3xJhmzPS17O2Icu3MJrFF4wO+vTp/mJtdij5SOzKZJ5qMNFel1/p0wn3WnSYheh6d9iRm5LClUp0g/Y3quDpW/xNoBj1PVr/5Jja3P7m/oWvCMMFH33HdIK3RtB0YmuoS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnpckDX4QjnGcMcAxJrrFmweczErJxOeuESW5p10IWs=;
 b=CaFbuhR9/tRlXcaYMURlYy4wDg1zghBNJZPxxuNb1AhsamAq0FZMixsO+KZF1SgHJhFo1aEUQR4O60nlicP/8nYG2HgQqev0FZy88gqfjTR+3/n88OG0W9AVeXw6U+kx/9LGo/ezyKB4wo6GEpo6ec7yvwF7WS9WjopXoF7CABE=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SJ2PR10MB6989.namprd10.prod.outlook.com (2603:10b6:a03:4cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 18:32:34 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 18:32:34 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 1/1] fork, vhost: Use CLONE_THREAD to fix freezer/ps regression
Date:   Thu,  1 Jun 2023 13:32:32 -0500
Message-Id: <20230601183232.8384-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0117.namprd07.prod.outlook.com
 (2603:10b6:5:330::32) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SJ2PR10MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: f2679d32-6ab6-4f60-b27e-08db62ce9150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDlSIC9/DXJpP2v+aYuLwygdVnlGTjnRfcZUZ48BAR7tI56lKOguwry6+DI5KoxA7WnT82hugW09xGd2DRW2FE8YrXCJf4EDCorHaKybvAx36MhwFtMW82+YlkckS4VssYiztOwtQ9QRFJt89uPqkPTFewCAJKrLcY8va2wMJZ/wfp4r9tf9oTCdHNy2BBsT94I6Cj/tybE5NH2tYYMazYXZ9TQmLG1fGhqSrgmmnl0KkyV5rmU/5eizLd/K53e3EFyNWORvFDu+WQq5pZ9oy3UIhy3zA+iXrl3Qh3rTLVz3pb10JL5QE/dqiPGLxVEecPF+wMFxpc4qxnBe95QWtV7a7QRbuCJnkktTTLuiBK1P2yPuncNtJB+z0sUXBu10a0w6aYWz2j3aoz3H2qZXywg/qmFjI/wgYEA8Ml2dEPO+tE5652mnsDgZVs5n11OB+iDTz4mr3AC21qodSAvPJkbXI3L/YVpl4S4HsrtE+iNlDQ2fcooL6Y1jTRTxt97t/ozrN+qY9BE0/2+tMGppWz1dzPrLqhA2N8ZxxR4mEw7+p19ofC74cYz1iggT3cmH9czS8A3LyyGGVwGjwC5jiQOIULSaKEZKHCavkeTcKh3HPDxbSYO0Wkhnn9hd2/ma
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(4326008)(8676002)(5660300002)(66556008)(8936002)(66946007)(66476007)(921005)(41300700001)(38100700002)(316002)(7416002)(2906002)(86362001)(30864003)(107886003)(186003)(6512007)(26005)(1076003)(6506007)(83380400001)(6486002)(36756003)(2616005)(478600001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8wDDKgNO75hda+sdYi+k8PwVly94tSumSvv7XiclIohlw3NZQ9aAPPqHTKoq?=
 =?us-ascii?Q?DJDs8w1CWMGJGtrXhMlAVEAE1nqlO7bh4koXLRgmeK4wETS4kuThU/bb1IHV?=
 =?us-ascii?Q?tc6FO7qVYyq1ro2odBoTkPxzDbj8gPGAAUFM1zWv3wqyi2CYfZhDLd96YnmB?=
 =?us-ascii?Q?Bef+/vn2LOP5EYz329MwrDoITAjJfiPKttKSLxuAmjWaxK9+tkLo1df+GRUK?=
 =?us-ascii?Q?gzK4dYBgEDtGwTE5CRuB/PWaMVbc1dME3t6lR5ptK8BHkZPCsrkndiVNgZ9X?=
 =?us-ascii?Q?RRw7bwxm6VTBm0XKeD4M5y0UKb9jY9/AXFHp+T7CdbytABhDiVrvr/l56gNp?=
 =?us-ascii?Q?TI0rsV/YN0iyrT/VZ83ugmDC5s61a3J/Aom84+ClkIGkbYl8YNyPtyo9kkjE?=
 =?us-ascii?Q?DbcNaJFi2s6CjtFH++hNeKGbIBQaT7OZPDcdK+6kk/Z0qjTnRZ/n0nHJJyDK?=
 =?us-ascii?Q?+2qNzOszUzrl63bXlUIYnMYsnfjHcLT0YUzhNMERfgGzE04FWx/D8MfgUgBz?=
 =?us-ascii?Q?feRuzBjfnvYNOcSi0lnuGHo0EFlgWReqKb3NpvOjJbFOQJO9n/eDS3we4L6p?=
 =?us-ascii?Q?20cB0Yvq/UMAoCo5HqOhCDoqjr2vUr7LEUWLb+u7nK442+qybg1v5V3BwKEj?=
 =?us-ascii?Q?c3Xoj/reaQXL/1hT4tylTYdbU1INZOtxISLAURr1jTHZM7DW9kUqHfUfBdR9?=
 =?us-ascii?Q?4ZMd/nBHQS3XhJ5FiZdM+yhImf+4S40TPoXLl84e5Rvvt8jdCgawsYJijCd8?=
 =?us-ascii?Q?SmMhYLUS6dmf3D2bTWTlUZc3RLBg/bOWpAz+fmsNUvGgKuJWJUsK+B8mlhCh?=
 =?us-ascii?Q?1UwbaXJwEHvO5V/uQjvfvT9ci2R5kZrTHWtljcT7jazOuQ4Dr+MPMbkiRIA+?=
 =?us-ascii?Q?McrTUWoD2/M1WBz9QfXuUh9EdfMn9UJTmYsR8M2lX+rdjYdG3ZW6ID0JMs5Q?=
 =?us-ascii?Q?PUsAcqYysnlnHpCuPMa89wEVOb9UD+YVhkrxM7Us9R7kiVNbGqiEr2H2/IcL?=
 =?us-ascii?Q?RRzC2x6u8gP2H+tyqGtrPKn9LDBLbMghoZtvgJmhDfZdGvH7Q+vAWBLdwCHt?=
 =?us-ascii?Q?ewRdtKTUj+dfoEbVAp8n1dh32QUTPJAVVEW3zl6eeob+M4rYsnLhhkDTS3dd?=
 =?us-ascii?Q?Qiw6G5A3sv0emPVbeUCvBC8ctfyel9fIu2D4Um8Yh89TIzspZpZH7/paMwaK?=
 =?us-ascii?Q?D3dWhhhaazaiv81agdwBTmXktpQ08u72XVZLZD928i3RfTDm38IV5o12sO5E?=
 =?us-ascii?Q?9GCotK5EYO/4O+FrrVwvohLH4SmavLfyZWWnFMvPPrCMpjkvx3tBPAfiBaXc?=
 =?us-ascii?Q?qowpKtcd9wpDlxoLFUTVlo3tIbRsp1OFHknygfkakdi3fwfpqrifN9AExpsM?=
 =?us-ascii?Q?9JzpQKkJNLVQCAaN1wwcdcE4Gvk9G3IvrVYUHSYmkDyvwP3qwsfVYFuilxb3?=
 =?us-ascii?Q?EfIWxUz6A+e00/HcYEmfgowRTsscZfn9T69EPVptuTfj4OSxt87TFmntpZ9S?=
 =?us-ascii?Q?y7mnvhtWiG6rSuwoGwS7KVS7xjkt1A9WPSgzNTV8aQPKkpc9hVY/aqPvR6t6?=
 =?us-ascii?Q?woY0Tg9PXajhOSzF+BYix3hHcoQE+eDc3mXjsKNd2TX01Evu+77Qq0+KmJia?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?idOoFeOsaxBNb5Ez68pxeRSFz9og1ICrbVQg2lxM1oWQLkST/cNJfhVBmir1?=
 =?us-ascii?Q?gxO96Ra8qX/Pu49DcQKulC0ONuzGj7f5OadbT7+PTGxG71tgSKvhwMYoMg2n?=
 =?us-ascii?Q?ADnIEoH2W7nJb05PavcvD9uoyv/gfzKNMzJC8eEjGmnllxygsf3JMyCQaWR3?=
 =?us-ascii?Q?rhM8xRW8MzgF68zAUeuOWkv/TJ7IhPeSD2XZyCS38riy6eP+rYp6XTOoZQbG?=
 =?us-ascii?Q?PCA8/SZqGLZubO7s3UekovVXh2qA1BtgxL6MAKNICGqr9R2V03+9F87LwE1G?=
 =?us-ascii?Q?GhYdxCwb5PS/QhnDvqbckuX6eaLgdyKPzCHkfav0yD2i0koizwBhv4Pc9Gq7?=
 =?us-ascii?Q?5KK0kvjjZ8aq9zdUk+XFSUHj4Hj73WNogdYyVWm0da4CU+8js8oZ3jsJagi3?=
 =?us-ascii?Q?Sl24DkN+WQ+OdCvd0JWtmo99jsuIQzqOhuQ55YZzXKeSewlNqRU5xN3iKqOW?=
 =?us-ascii?Q?csmoO4LKSbwj8MaZesPR96OgyWGJXCVlIcwgPhKjXOBoB1e8MwbWrUiLH9Sa?=
 =?us-ascii?Q?0TJrkOJpxZAQ811bQBPphUjHANjvly5SWSk3476tN6YopUS8UD8x5CoafOxc?=
 =?us-ascii?Q?SZ6TtjM+s84d9IwsprsKm8to+stAPWR62bsYX6JgeIzzoEncylJ6Aqrt13PW?=
 =?us-ascii?Q?/Nc3EA+ygmNEPVvBAClICYC0beOcOy6khjEEalfovQCegNIT4wuoNKi//tSC?=
 =?us-ascii?Q?idRi1N0J434U/y2jquiUiqSLu3oyaz9FwQL07TorB7n5di/ic48qmBj18Vw1?=
 =?us-ascii?Q?YQFwE8UooU2tjS4gdmtj3tsZ8Mq89IHj8EZ/QeqYiXpYfe78lVM37rKpa2Eb?=
 =?us-ascii?Q?eNXdTp4d+9nQDHAli3wJ6bdRiSSr0FYvW4jONnnrtG21Poo3XwCbNJkfGBjv?=
 =?us-ascii?Q?YADlWVsMnF8CHp5kLLx2Ge/Amz2W1MnLVkmoxxR6nA43fxDQGT7gslmiNeez?=
 =?us-ascii?Q?GxNrQqgw6yLSzpcqVQ+kfS7qRJtVYRzbZIak7QHBHCltfq+Q6rhucHOlHOAd?=
 =?us-ascii?Q?8ov1rVUTKAumd6VHbdNVgOb38TDCBFiFwO5yLd2EtQinK02SEdDMS1OzfQgS?=
 =?us-ascii?Q?FYPN2Q82?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2679d32-6ab6-4f60-b27e-08db62ce9150
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 18:32:34.5337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whBoagM18/A4QHVEcy9/AP8HqboA+WKTgx6Tavfr+aGGWzH6lqz3/RgB8edrC4Y7qBD/K4FrbN73bqSXOYn6cagg4C3k8/mOMA/nsWFbKiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010160
X-Proofpoint-ORIG-GUID: KEbAaqt9Py-MEJHQAL6k76NGbzvntTx9
X-Proofpoint-GUID: KEbAaqt9Py-MEJHQAL6k76NGbzvntTx9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching from kthreads to vhost_tasks two bugs were added:
1. The vhost worker tasks's now show up as processes so scripts doing
ps or ps a would not incorrectly detect the vhost task as another
process.  2. kthreads disabled freeze by setting PF_NOFREEZE, but
vhost tasks's didn't disable or add support for them.

To fix both bugs, this switches the vhost task to be thread in the
process that does the VHOST_SET_OWNER ioctl, and has vhost_worker call
get_signal to support SIGKILL/SIGSTOP and freeze signals. Note that
SIGKILL/STOP support is required because CLONE_THREAD requires
CLONE_SIGHAND which requires those 2 signals to be supported.

This is a modified version of the patch written by Mike Christie
<michael.christie@oracle.com> which was a modified version of patch
originally written by Linus.

Much of what depended upon PF_IO_WORKER now depends on PF_USER_WORKER.
Including ignoring signals, setting up the register state, and having
get_signal return instead of calling do_group_exit.

Tidied up the vhost_task abstraction so that the definition of
vhost_task only needs to be visible inside of vhost_task.c.  Making
it easier to review the code and tell what needs to be done where.
As part of this the main loop has been moved from vhost_worker into
vhost_task_fn.  vhost_worker now returns true if work was done.

The main loop has been updated to call get_signal which handles
SIGSTOP, freezing, and collects the message that tells the thread to
exit as part of process exit.  This collection clears
__fatal_signal_pending.  This collection is not guaranteed to
clear signal_pending() so clear that explicitly so the schedule()
sleeps.

For now the vhost thread continues to exist and run work until the
last file descriptor is closed and the release function is called as
part of freeing struct file.  To avoid hangs in the coredump
rendezvous and when killing threads in a multi-threaded exec.  The
coredump code and de_thread have been modified to ignore vhost threads.

Remvoing the special case for exec appears to require teaching
vhost_dev_flush how to directly complete transactions in case
the vhost thread is no longer running.

Removing the special case for coredump rendezvous requires either the
above fix needed for exec or moving the coredump rendezvous into
get_signal.

Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Co-developed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 arch/x86/include/asm/fpu/sched.h |  2 +-
 arch/x86/kernel/fpu/context.h    |  2 +-
 arch/x86/kernel/fpu/core.c       |  2 +-
 drivers/vhost/vhost.c            | 22 ++------
 fs/coredump.c                    |  4 +-
 include/linux/sched/task.h       |  1 -
 include/linux/sched/vhost_task.h | 15 ++----
 kernel/exit.c                    |  5 +-
 kernel/fork.c                    | 13 ++---
 kernel/signal.c                  |  8 +--
 kernel/vhost_task.c              | 92 +++++++++++++++++++++-----------
 11 files changed, 89 insertions(+), 77 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index c2d6cd78ed0c..78fcde7b1f07 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -39,7 +39,7 @@ extern void fpu_flush_thread(void);
 static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
 {
 	if (cpu_feature_enabled(X86_FEATURE_FPU) &&
-	    !(current->flags & (PF_KTHREAD | PF_IO_WORKER))) {
+	    !(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		save_fpregs_to_fpstate(old_fpu);
 		/*
 		 * The save operation preserved register state, so the
diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index 9fcfa5c4dad7..af5cbdd9bd29 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -57,7 +57,7 @@ static inline void fpregs_restore_userregs(void)
 	struct fpu *fpu = &current->thread.fpu;
 	int cpu = smp_processor_id();
 
-	if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_IO_WORKER)))
+	if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_USER_WORKER)))
 		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index caf33486dc5e..1015af1ae562 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -426,7 +426,7 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 
 	this_cpu_write(in_kernel_fpu, true);
 
-	if (!(current->flags & (PF_KTHREAD | PF_IO_WORKER)) &&
+	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 		save_fpregs_to_fpstate(&current->thread.fpu);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a92af08e7864..074273020849 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -256,7 +256,7 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &dev->worker->work_list);
-		wake_up_process(dev->worker->vtsk->task);
+		vhost_task_wake(dev->worker->vtsk);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -333,31 +333,19 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	__vhost_vq_meta_reset(vq);
 }
 
-static int vhost_worker(void *data)
+static bool vhost_worker(void *data)
 {
 	struct vhost_worker *worker = data;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
-	for (;;) {
-		/* mb paired w/ kthread_stop */
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		if (vhost_task_should_stop(worker->vtsk)) {
-			__set_current_state(TASK_RUNNING);
-			break;
-		}
-
-		node = llist_del_all(&worker->work_list);
-		if (!node)
-			schedule();
-
+	node = llist_del_all(&worker->work_list);
+	if (node) {
 		node = llist_reverse_order(node);
 		/* make sure flag is seen after deletion */
 		smp_wmb();
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
-			__set_current_state(TASK_RUNNING);
 			kcov_remote_start_common(worker->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
@@ -365,7 +353,7 @@ static int vhost_worker(void *data)
 		}
 	}
 
-	return 0;
+	return !!node;
 }
 
 static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
diff --git a/fs/coredump.c b/fs/coredump.c
index ece7badf701b..88740c51b942 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -371,7 +371,9 @@ static int zap_process(struct task_struct *start, int exit_code)
 		if (t != current && !(t->flags & PF_POSTCOREDUMP)) {
 			sigaddset(&t->pending.signal, SIGKILL);
 			signal_wake_up(t, 1);
-			nr++;
+			/* The vhost_worker does not particpate in coredumps */
+			if ((t->flags & (PF_USER_WORKER | PF_IO_WORKER)) != PF_USER_WORKER)
+				nr++;
 		}
 	}
 
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 537cbf9a2ade..e0f5ac90a228 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -29,7 +29,6 @@ struct kernel_clone_args {
 	u32 io_thread:1;
 	u32 user_worker:1;
 	u32 no_files:1;
-	u32 ignore_signals:1;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
diff --git a/include/linux/sched/vhost_task.h b/include/linux/sched/vhost_task.h
index 6123c10b99cf..837a23624a66 100644
--- a/include/linux/sched/vhost_task.h
+++ b/include/linux/sched/vhost_task.h
@@ -2,22 +2,13 @@
 #ifndef _LINUX_VHOST_TASK_H
 #define _LINUX_VHOST_TASK_H
 
-#include <linux/completion.h>
 
-struct task_struct;
+struct vhost_task;
 
-struct vhost_task {
-	int (*fn)(void *data);
-	void *data;
-	struct completion exited;
-	unsigned long flags;
-	struct task_struct *task;
-};
-
-struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
+struct vhost_task *vhost_task_create(bool (*fn)(void *), void *arg,
 				     const char *name);
 void vhost_task_start(struct vhost_task *vtsk);
 void vhost_task_stop(struct vhost_task *vtsk);
-bool vhost_task_should_stop(struct vhost_task *vtsk);
+void vhost_task_wake(struct vhost_task *vtsk);
 
 #endif
diff --git a/kernel/exit.c b/kernel/exit.c
index 34b90e2e7cf7..edb50b4c9972 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -411,7 +411,10 @@ static void coredump_task_exit(struct task_struct *tsk)
 	tsk->flags |= PF_POSTCOREDUMP;
 	core_state = tsk->signal->core_state;
 	spin_unlock_irq(&tsk->sighand->siglock);
-	if (core_state) {
+
+	/* The vhost_worker does not particpate in coredumps */
+	if (core_state &&
+	    ((tsk->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)) {
 		struct core_thread self;
 
 		self.task = current;
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..81cba91f30bb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2336,16 +2336,16 @@ __latent_entropy struct task_struct *copy_process(
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
-	if (args->user_worker)
-		p->flags |= PF_USER_WORKER;
-	if (args->io_thread) {
+	if (args->user_worker) {
 		/*
-		 * Mark us an IO worker, and block any signal that isn't
+		 * Mark us a user worker, and block any signal that isn't
 		 * fatal or STOP
 		 */
-		p->flags |= PF_IO_WORKER;
+		p->flags |= PF_USER_WORKER;
 		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
 	}
+	if (args->io_thread)
+		p->flags |= PF_IO_WORKER;
 
 	if (args->name)
 		strscpy_pad(p->comm, args->name, sizeof(p->comm));
@@ -2517,9 +2517,6 @@ __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
-	if (args->ignore_signals)
-		ignore_signals(p);
-
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
diff --git a/kernel/signal.c b/kernel/signal.c
index 8f6330f0e9ca..2547fa73bde5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1368,7 +1368,9 @@ int zap_other_threads(struct task_struct *p)
 
 	while_each_thread(p, t) {
 		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
-		count++;
+		/* Don't require de_thread to wait for the vhost_worker */
+		if ((t->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)
+			count++;
 
 		/* Don't bother with already dead threads */
 		if (t->exit_state)
@@ -2861,11 +2863,11 @@ bool get_signal(struct ksignal *ksig)
 		}
 
 		/*
-		 * PF_IO_WORKER threads will catch and exit on fatal signals
+		 * PF_USER_WORKER threads will catch and exit on fatal signals
 		 * themselves. They have cleanup that must be performed, so
 		 * we cannot call do_exit() on their behalf.
 		 */
-		if (current->flags & PF_IO_WORKER)
+		if (current->flags & PF_USER_WORKER)
 			goto out;
 
 		/*
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index b7cbd66f889e..f80d5c51ae67 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -12,58 +12,88 @@ enum vhost_task_flags {
 	VHOST_TASK_FLAGS_STOP,
 };
 
+struct vhost_task {
+	bool (*fn)(void *data);
+	void *data;
+	struct completion exited;
+	unsigned long flags;
+	struct task_struct *task;
+};
+
 static int vhost_task_fn(void *data)
 {
 	struct vhost_task *vtsk = data;
-	int ret;
+	bool dead = false;
+
+	for (;;) {
+		bool did_work;
+
+		/* mb paired w/ vhost_task_stop */
+		if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags))
+			break;
+
+		if (!dead && signal_pending(current)) {
+			struct ksignal ksig;
+			/*
+			 * Calling get_signal will block in SIGSTOP,
+			 * or clear fatal_signal_pending, but remember
+			 * what was set.
+			 *
+			 * This thread won't actually exit until all
+			 * of the file descriptors are closed, and
+			 * the release function is called.
+			 */
+			dead = get_signal(&ksig);
+			if (dead)
+				clear_thread_flag(TIF_SIGPENDING);
+		}
+
+		did_work = vtsk->fn(vtsk->data);
+		if (!did_work) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule();
+		}
+	}
 
-	ret = vtsk->fn(vtsk->data);
 	complete(&vtsk->exited);
-	do_exit(ret);
+	do_exit(0);
+}
+
+/**
+ * vhost_task_wake - wakeup the vhost_task
+ * @vtsk: vhost_task to wake
+ *
+ * wake up the vhost_task worker thread
+ */
+void vhost_task_wake(struct vhost_task *vtsk)
+{
+	wake_up_process(vtsk->task);
 }
+EXPORT_SYMBOL_GPL(vhost_task_wake);
 
 /**
  * vhost_task_stop - stop a vhost_task
  * @vtsk: vhost_task to stop
  *
- * Callers must call vhost_task_should_stop and return from their worker
- * function when it returns true;
+ * vhost_task_fn ensures the worker thread exits after
+ * VHOST_TASK_FLAGS_SOP becomes true.
  */
 void vhost_task_stop(struct vhost_task *vtsk)
 {
-	pid_t pid = vtsk->task->pid;
-
 	set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
-	wake_up_process(vtsk->task);
+	vhost_task_wake(vtsk);
 	/*
 	 * Make sure vhost_task_fn is no longer accessing the vhost_task before
-	 * freeing it below. If userspace crashed or exited without closing,
-	 * then the vhost_task->task could already be marked dead so
-	 * kernel_wait will return early.
+	 * freeing it below.
 	 */
 	wait_for_completion(&vtsk->exited);
-	/*
-	 * If we are just closing/removing a device and the parent process is
-	 * not exiting then reap the task.
-	 */
-	kernel_wait4(pid, NULL, __WCLONE, NULL);
 	kfree(vtsk);
 }
 EXPORT_SYMBOL_GPL(vhost_task_stop);
 
 /**
- * vhost_task_should_stop - should the vhost task return from the work function
- * @vtsk: vhost_task to stop
- */
-bool vhost_task_should_stop(struct vhost_task *vtsk)
-{
-	return test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
-}
-EXPORT_SYMBOL_GPL(vhost_task_should_stop);
-
-/**
- * vhost_task_create - create a copy of a process to be used by the kernel
- * @fn: thread stack
+ * vhost_task_create - create a copy of a task to be used by the kernel
+ * @fn: vhost worker function
  * @arg: data to be passed to fn
  * @name: the thread's name
  *
@@ -71,17 +101,17 @@ EXPORT_SYMBOL_GPL(vhost_task_should_stop);
  * failure. The returned task is inactive, and the caller must fire it up
  * through vhost_task_start().
  */
-struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
+struct vhost_task *vhost_task_create(bool (*fn)(void *), void *arg,
 				     const char *name)
 {
 	struct kernel_clone_args args = {
-		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM,
+		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM |
+				  CLONE_THREAD | CLONE_SIGHAND,
 		.exit_signal	= 0,
 		.fn		= vhost_task_fn,
 		.name		= name,
 		.user_worker	= 1,
 		.no_files	= 1,
-		.ignore_signals	= 1,
 	};
 	struct vhost_task *vtsk;
 	struct task_struct *tsk;
-- 
2.25.1

