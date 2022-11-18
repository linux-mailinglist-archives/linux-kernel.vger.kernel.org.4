Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900D462FE62
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbiKRTyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiKRTxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:53:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8BE167E0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:53:35 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIIu8He020978;
        Fri, 18 Nov 2022 19:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=zOay+mDVbczpwL85zEj6q67Y3cnqh3yOWMR8dLlMCN4=;
 b=CtFkYOsPOPlK4LIP7aedu88IRlVdFK/6BU2P8M0b6TuFIHSERDQjzCvJpQ+qISIT1FCS
 RcMqmTOQZw1lBb7ResxEIXsRw/C3VhX/aHE/UlXV8WISu/91KNN6MLRE4CANzJvNMReR
 Atyr802Eszeeg3KZ01X5YjWjbvCeXpcSnQsxDwpLfnU3o/7epvc/7Lt0jvAvy+iE1jot
 w0UXpy6pWj31vDS4nUK3XHiVMkqQkJ6m3KFmm0DV4ggU304SLlzKW0OZxgZkq51wLL00
 idnjNMGUTStOLxFSxpse2amNlg1+wnlHguQWQXMFMTS7ulLH4gp9eXVDfBEISlOvANBF cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kx7kjhq8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 19:52:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIIACVF030343;
        Fri, 18 Nov 2022 19:52:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kuk21uq4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 19:52:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8pLWyHlIpV/RWRR64aOO33+ooR4oclIvbevbaC7/1TFqxd9z66TIrPyTDpVBD9/Tba52Y6/C88mk2SHY3gP5DJL2M53v00CHrTXGSo+xlUwIChtj77qgn8UMfNoIM25OB8VKr05w9WSSwPImU+zKysDy2xMTXHhghh5y1uvbgpF+IO8sZUkoT/c99KgAC/iXnS+ggc2sWeh7Irx1PYa6JRkJ6D2h7a03WlkGqDsBRoFxA6cPIX5lArn+4yFgeVdOpZDQ6DXhDp56Bk8AH5tX5N+Y+W+4ABkIKw9AaRPMqSNrA6fv4SqbDxzE8TmWMJGvnRw+CmZlbLKYcABGorUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOay+mDVbczpwL85zEj6q67Y3cnqh3yOWMR8dLlMCN4=;
 b=T4KgyzBatkWXwHCHMFAIsNtKc7XI/W9ZDAqcXD+P0S3knRbwd0nC/pib0LF8yMcuP7fS2kmBa5RoFyiDbvyh2s8ezdJ5gKiS80r8yHpVq51B2f1uUAnMNgU96wBGtQluWot+fvmgrr0SiK9zgUav5O5HGsUJEPkOIwkSXuj8GrHEg/1fuGAgl9XIJsJZCGVSAwcIfkPhXUa8P/qwq6/l90r7xODT1ZVtvYziijQ6EGYITYv1Tk9grgFpILoZxPtFPW1rgHQcv6byJGhnVKFP1uw7veikVjEcvJ0OMVf7uYJsEJburHeGDhxTJ/83YsSWJ5CgopDCgnytpZJOLZ3dvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOay+mDVbczpwL85zEj6q67Y3cnqh3yOWMR8dLlMCN4=;
 b=ua/v2EBVbo0gAlUqGa31fHK3msMlnQ3LirPE818gT7cCncG4msrgiCQAIT3rwNforkOfCayVrbrBDTyB5+zm+Rdk51YVoMVrVYEfhaEZKHSAhfOG5/GGz+Nbse8pdF1AdsTOSikyHShnkoISoqpuABXCCM6QGOKDY4aFVflxJCw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4434.namprd10.prod.outlook.com (2603:10b6:303:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 19:52:56 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 19:52:56 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Vlastimil Babka <vbabka@kernel.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] hugetlb: Fix __prep_compound_gigantic_page page flag setting
Date:   Fri, 18 Nov 2022 11:52:49 -0800
Message-Id: <20221118195249.178319-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:303:85::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9d111f-4c0b-46b9-3868-08dac99e7caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JewTvVjKKeaXdzsEvVf0Bno0VZ4mrEnYfQuDakrEr9aLOxd+sSc3p9Xly4Z3NjTiAczNh9SMl8+c7TkacW2NMYE4SMm9DBjIkVB/NrmutYlcvv85hfuXQRQheso1jKeShPgpHFB2DBK+baRzJy9J7fyKXzjFzUz++f+NYPfvytU9eKpQZsQd4yglH/9mSjR8vMBGPMGcKrSt5O9IFlzQ5Fc5dQA/zZGTlP9z+Fb71hIsXgG+gdMSVISJ6bNz9WCSk9EB0EbFrDorGX8lIs9iL7D1Utbbx/mOJcHIdxI2DXqfvFXpX55cLMLWB4FERW8+4nEbVfeBtmMwwuS7+FO/yu2xIk4jjiw0bBMsB49My1IaMAzyy6mYw0P7rjyeM1jWKJWN4WMbceLKlsThtXziX+4JY9pxrevVf1buepQNHApWnNmqhIRt+uFTS11U32yzjFa6ParvaOGycdgeEXg8L3R8CR3reLC7mItJKyNbh4cp74h4R27XG6my/VMx56yvB4ZZ4cC5MJu1p1EIYAjQXfL9ennoupuhSMR88M3GdGVQtAQPra+Opb7254eJXGkeWyV2yZWecR5l9V2g2t36yxrU4F7B6AI2wohsHOiVOanQ5Z2FWH8Tsuz08271zFfrKSH7st8DsviG9O0TEjdjJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(36756003)(86362001)(38100700002)(44832011)(5660300002)(8936002)(7416002)(2906002)(186003)(2616005)(83380400001)(1076003)(41300700001)(6916009)(54906003)(66946007)(478600001)(66556008)(316002)(6512007)(4326008)(66476007)(6666004)(8676002)(6506007)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SfVZoPUlBbAqmvouTOhUvEzRpTAZzpCfAV6Kdz/k7Fi8GK222go2/ONscc9a?=
 =?us-ascii?Q?0QofgwObF2mLcBqqE85y3tdheZ1AynTIEoiV1o8E3lIgFZt2hRuJtB1M+old?=
 =?us-ascii?Q?F3nWYuJCTb5fNlOxXtlWaB6HZ9KvN4Xhz0fgTSbPR9qGEAguNbRbhNs7vwDc?=
 =?us-ascii?Q?hL1LuvjH8R9Y5NOqyyRYVfQjOTUicPgFbBBH5dSt+suWKTQCh/O9fLqFTmsa?=
 =?us-ascii?Q?YEtIuXGfS2tWMUifFXC9DtIoA7Y5C9A1p7FiG7f7DO1sRak646kiMqceyMWZ?=
 =?us-ascii?Q?cDO/DJPkXMLmaDJ2lRDY2CX+1Su4hL8Q9QyH++J/yJ0Lzncb2n9V+aQ7vu64?=
 =?us-ascii?Q?KcroG7cLFaly7+JFYxMNdK5dY6oh6itIdw3s+s5qU9FlqNya8LchRdO91FYC?=
 =?us-ascii?Q?nLlaFoNNgCf+KKiDKL32rg2OZ+A6mXXvp/godHimW9tk+fZSaqkLr9yWSQnw?=
 =?us-ascii?Q?lZMllc5Yv+lNXTFWxPkboj9WWJWJwLSjzXRVWohyWOF+915Gi9D/HER6hdPx?=
 =?us-ascii?Q?HX5/gO1NDq44cH2zp0neNukGtvek3kxLusOj/oQpMtrkGAx64wJ7/2V/S/Hk?=
 =?us-ascii?Q?YwSs29qtQyrw8TgFYWLkU4BNsto3o5qHSbHwao5+bJfsDun7YY2oJgK4wZWE?=
 =?us-ascii?Q?gGuYtYTBTBJYnLT8ldgglsLZgTw+RFcqHz92njeGQ4WWD1p9RiRCnpe2w/7q?=
 =?us-ascii?Q?z726yljZqskLxPQT4KeVejGQOwduHc9/Mk36Xv4qxaLGAFmY4Gn523SMV8lL?=
 =?us-ascii?Q?L3ekMBRbRuT39CcPp7YteFcCKvi2dfF1LsifvD9lNDFnD5dVh3J+lfEknNpe?=
 =?us-ascii?Q?p2iNW+sHOSlBOle+etdVAPPuqd50z1KgI7zD/xY1GqH9JwH26boT9QvnYD/x?=
 =?us-ascii?Q?IXF3IdY2Q66RQV7f+c5Uvu/2eHOklLopAeOFaeEk2yLx8+RbrKCzEAAjwe/e?=
 =?us-ascii?Q?CPaBl3QOISLPSE/kafnYNCoW7kUHE8BWf7pi4wDV5e5pbJV72PRbOlLyND3Y?=
 =?us-ascii?Q?ykSmWEUYsoRckT5pLBGp7EtxPRX1YGBwsuJDtBuFMNzHPBfF+OXlXEP7l8u4?=
 =?us-ascii?Q?xW9nEnZ/kg/LItbWq1/YNgjQ5zoWrCGZyh4mxsPtYuRR8dEzU4eS3LGu5Dj4?=
 =?us-ascii?Q?92lAUiVK6drw1wP91L5i8s6TtWT0Kv4X66maO0ugP8PU4VsWHst+RUoqwz+t?=
 =?us-ascii?Q?Wlj6D2lmeuVKWkLY2V9ukwsSKq/L8ppIfyBRW1QmxYoD90OICJ3SJwcppM0S?=
 =?us-ascii?Q?3SJHUe68+KA34car8Sp2+iPfmjHfyQW7ghVjHUwlruzk0UyewupATAtuv4uq?=
 =?us-ascii?Q?kalTM7cEINGy0zNVhyhjvkE3LQkbEnhYbVAtpRmeaAM18USGBSlsG2Ma7J9W?=
 =?us-ascii?Q?dCO+4Yb+LdU93WoUsqkmNOk3u5/SDxlA2H+di6HTaPfVEJmYrAMQGBiV+I23?=
 =?us-ascii?Q?VdNwHiPlk2i/hhHnDg6aDwj3tH+Gomwmg2HzD6haTubM/u1DTkkSKEiU3J6V?=
 =?us-ascii?Q?OvbfyG8SsWLLqOEMmNNUgZtKk+pHeY7I8UzOSiS5prTrSWAzv1a825we3Qux?=
 =?us-ascii?Q?uCveAG/TfSo3aKE5ANklP0I2e7YdprFc5RQUivFNCAcg64ke2dIA8XwsZSgi?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OtRA2sNvVCO92UWO5C1BUp6buNN1Rd4Oqg3DE9YBzrrXcb40f9Hlv4gTi52/?=
 =?us-ascii?Q?+mTlyI4uNSeNVYycR3wuNk1Z4n5y5q6UquBCrUqcMtPryeL++JeRkCd5m1pv?=
 =?us-ascii?Q?/6WPcRHUJpNmkGzCzmOaw3LvEHxUO/yvxkvtG16M8KK1L+1cfEJQ8mX9dh6G?=
 =?us-ascii?Q?gYaVUtJuzTWF7gU22FRh1wfiCblCW/IqzutgC3aze/mhzqR56KxNcCPAMJ2c?=
 =?us-ascii?Q?0XQrDyeXOJZblFEhItEtSx+sr5SMK1hzl9upnJm6UsXIbZDNchXy0oBGxFdQ?=
 =?us-ascii?Q?OUgMNgVPiAHaWxdD+3dFuqFkNuFEuhf/Kc+NSV6hb8aypuLiJ59Y5aSTAVeT?=
 =?us-ascii?Q?u1thqKz8qNYFqDDbJIEOK484sOyyy/d83cLLXMQp/KpL8U9KRfKI+HBqtWmK?=
 =?us-ascii?Q?gNg2RGCxHCPiYE7CsF9omjBY6aQ/ld2+pYc4+cB11T1yV41t5aLn6NPzQSdu?=
 =?us-ascii?Q?yP6xD2qvWVvLkwru3Jp//s78X4fxpo+NAOBbrRhipFnK3UIth24aqQjPlJUw?=
 =?us-ascii?Q?2NINHIOcUMhxfTktVjAFMXfMeg5YOSp1lIaPZsBY7xh6PMq4uiKP3KJoEso+?=
 =?us-ascii?Q?f7mlXwSYc+4c2671A3eRd2BO3FaJONb7SzntgdClUvLkcPPRWRuyYyupbcxk?=
 =?us-ascii?Q?M8DjqgQRe7EHnF6LrWA4q/LJ2Ze1cE/YaGnbqnxEWmZDyE1wcveA+Sq/K5dK?=
 =?us-ascii?Q?aKYAKQoNpr0AskPzshMVNNCgHxOMeqQKL5r85DdbAIrf5xIaIy+QneTZedCg?=
 =?us-ascii?Q?CR2r8rRJuCxkBtIi3RZANwgl5k5QMlSUvPE0nbLOpyMof7agyJfq0LsHHhf5?=
 =?us-ascii?Q?aZnv7OkTlEnhmd5NFskY51CnMsu+xfE0Lz6e1utSgpRE7XtwFAu4lewdoUly?=
 =?us-ascii?Q?ldA3nPNvWntZv2eb5788OYvpQme96qXcAqGi++4Fodm1JXWtn6nTZxQQU3pJ?=
 =?us-ascii?Q?ozFy3AI31GhH1TH0OpavYgYEa0x70KU990VVG4NMYMKzQIxhIrCd/E+ZOeX1?=
 =?us-ascii?Q?5FXItj0zO6W9/8QWvh3kp1Rk+xukDOTAl+YNAPnTkYptH8r0fheD81ntDYNe?=
 =?us-ascii?Q?/KILZU+fkRwGuPC17PHxMe/ScBo43Mj8gd7t4W5mQytz8iX0Bg4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9d111f-4c0b-46b9-3868-08dac99e7caa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 19:52:56.1298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIQl78e+xMLWQ8YDTA0rEmpCEjeEVm27cQb6ky9OZTlC45OvEQLuAQUtfnVB8HrrtfmrJZI70InpmXQuHsAkLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4434
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211180118
X-Proofpoint-GUID: RGNoDk4MaqG9hRay7QuU2Rla3_M_H_7T
X-Proofpoint-ORIG-GUID: RGNoDk4MaqG9hRay7QuU2Rla3_M_H_7T
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2b21624fc232 ("hugetlb: freeze allocated pages before creating
hugetlb pages") changed the order page flags were cleared and set in the
head page.  It moved the __ClearPageReserved after __SetPageHead.
However, there is a check to make sure __ClearPageReserved is never
done on a head page.  If CONFIG_DEBUG_VM_PGFLAGS is enabled, the
following BUG will be hit when creating a hugetlb gigantic page:

    page dumped because: VM_BUG_ON_PAGE(1 && PageCompound(page))
    ------------[ cut here ]------------
    kernel BUG at include/linux/page-flags.h:500!
    Call Trace will differ depending on whether hugetlb page is created
    at boot time or run time.

Make sure to __ClearPageReserved BEFORE __SetPageHead.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Fixes: 2b21624fc232 ("hugetlb: freeze allocated pages before creating hugetlb pages")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e48f8ef45b17..f1385c3b6c96 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1800,6 +1800,7 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 
 	/* we rely on prep_new_huge_page to set the destructor */
 	set_compound_order(page, order);
+	__ClearPageReserved(page);
 	__SetPageHead(page);
 	for (i = 0; i < nr_pages; i++) {
 		p = nth_page(page, i);
@@ -1816,7 +1817,8 @@ static bool __prep_compound_gigantic_page(struct page *page, unsigned int order,
 		 * on the head page when they need know if put_page() is needed
 		 * after get_user_pages().
 		 */
-		__ClearPageReserved(p);
+		if (i != 0)	/* head page cleared above */
+			__ClearPageReserved(p);
 		/*
 		 * Subtle and very unlikely
 		 *
-- 
2.38.1

