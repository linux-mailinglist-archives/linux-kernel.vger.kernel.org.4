Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF06AD425
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 02:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCGBmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 20:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjCGBmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:42:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38276A9F7;
        Mon,  6 Mar 2023 17:42:34 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326NwwUM007534;
        Tue, 7 Mar 2023 01:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=dheGVBR1b2bLDQnmZSa4bSK4LolNGt/JUlqQmK8BdM4=;
 b=E3oyH/OXvIUVouqFCTGGDTYATjbnmep46jP5pqdZd7P1yAf69RhAc4jJWOcMPg49RLnI
 EDtf+D/a0JCwyh5P58TzNBCinpcvLYWldEOIg/6crcud7YtjayzP4FdPpxJcHq13k5pm
 2lLfyy9VA8qwY5ZBbs3d1Q7/hmsmUqQLBfjJxVRWwxLCyc9bJAiOUTciuho+xAclcuSU
 +txUDdJREy9bV4NWJ++OepsJXDK4Z2bKCwKbEZV78mdC7/58GnrVvVFehyyEKHY1ycHd
 vtOZ7b/7QCRQLDFBeOhgIfV0rWBM/rN3sPsstLSZOhnYH5gkeS61aYTLf2rlsKRpb4Wx NA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4168mdus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 01:42:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326NPjOb009186;
        Tue, 7 Mar 2023 01:42:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u2h3da5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 01:42:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pqys5XSmoAaVihOQsFX6dIFL4BL3rfcwpRBCuFw3WGwmZmCR6BF4H8V0EoKB8wGY+1vxU8Ix5oMk/B0ob9MVsCj/qw4WM1AHQJYbM11tuRGiiTbH8qEV9cXiJqL6mfPKJem4r57z8xOhFM6GJoP2ActihX0+8J6NLztzgXpjlWQU3Z7co+G/buFiPWnMfea4PmoBmgG+P1p1sui4h6p37zIFDCpAkGzWxKXH85SG3swF/AjzY1EjnCGwhOFQB/uXeTLnOahbEfQm8YXjko/vQtE2isSZZbnr0CvIE/EXMyz1bQrWd6DrS219kVNEMIOHqc5ragIBG3YxGZBmNwU+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dheGVBR1b2bLDQnmZSa4bSK4LolNGt/JUlqQmK8BdM4=;
 b=Cm6wXqvk0MSvUkI5LSVlbuRpO2u+FuCooop3+sdxnOV1QaOGq1SDtkfwS5jCd0VcocMGC/Jwq5j1CF+s/p37RJcDSGpOLjoBy8hq3Ux4ej4kUhOPvXigkD3w3qA5FAyATaeR9egvi2c8uxaRcAulCINovVvsZSkafkpspvvmDm5ossrjF8ZggKtxNnpvSlp+kIWPHcyREvKC+EwxbiHajoY5un4q3/s4ST/unzTuk3ek5HzVIZ7AtZnYF2bTix3eJI+FH1uCOTaxAzpz9cYcNUT418uHr0KoBEesYGfZdUt7O5PNakDWehXx6Eb91Sv3Z30WvJvONOMJNlbyeQ1H9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dheGVBR1b2bLDQnmZSa4bSK4LolNGt/JUlqQmK8BdM4=;
 b=if9vj5OWgNgNw8oGXsJnlLKQFNZ6HCljT8Y1F6vLd5l6Tb/XE+UTu8v7/UTIzzIei5EF4+F/vdNHAdRFKGioTIyqnSsmchIA/6KebEOG7zbsYmJGLiACUtWubzHTjMj05IkPo0IolauWTewzfEaIrdX/hnCyPX7mCeCbwcQuGLo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 01:42:17 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 01:42:17 +0000
To:     Ranjan Kumar <ranjan.kumar@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     Wenchao Hao <haowenchao2@huawei.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <MPT-FusionLinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>
Subject: Re: [PATCH] scsi: mpt3sas: fix NULL pointer access in
 mpt3sas_transport_port_add()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mt4pmj8g.fsf@ca-mkp.ca.oracle.com>
References: <20230225100135.2109330-1-haowenchao2@huawei.com>
Date:   Mon, 06 Mar 2023 20:42:14 -0500
In-Reply-To: <20230225100135.2109330-1-haowenchao2@huawei.com> (Wenchao Hao's
        message of "Sat, 25 Feb 2023 18:01:36 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0006.namprd05.prod.outlook.com
 (2603:10b6:803:40::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de70991-9852-4f36-ab76-08db1ead2f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+CebTcKzAwG/ZSxWoTVX5DPHld6v6mB4BFmfjugV+e7mSKPcZob6YDWl6O3CFqL7NT5PoUAOXQSbtM/BN3Z9CH/GRn3YGjEBNL8FTbAhRYmI4z2VBvGTUB3Xrsf1UbZeyuzqEGnM0zI5Qi5rq9TOwa61wFECTVn9F29IHncdd44Bm3j6bSj0lDpqk9gTiYDhVfV8YxOZepMTtkiFHOaRi46rbBLDiTIn2MZmMpB76zSXws47Tg79VmQtZZ89FibEXzZ8oaemI88tHVgeSfetz2Py1cS4ijOK1z6NDNOXxBMJyr9ovTaoGRywXzQKDdMSNF4EHnD1qOQqom1VxKOxrcX0Pvi30YwR/CiIIBcevSYNjpdtf+thNzDc9UXKYwxAD1EzOath8gkbyFSfG9XzbkRUJjC7OL/cAxZjKClbDa70SBqejoOPT1EPd7Hku+mbpJ8dtnO3rutl8LpISZwP18r3uB2c43PP5I3N62eJ87i/t5JNI4vXz/pW44hQu63Fze9LAsOFRnkpWQvM4HRG4iXH044wrc/DpCm2RJDM+ygN25sVFYkS6h+lEOw0j3daKS3GWWrWUwgDVyJ9WVkHO8pU506hcPrp415cNLG6TlqM0UlvmK0O3TtXmAU7ZfhKIjinOq7YEtNT7GwfT6PaR4+aHfwx/I55vc5x/PVlFoiQPLElSz+xR6uEiwQI38X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199018)(4326008)(7416002)(41300700001)(66556008)(8676002)(8936002)(4744005)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(36916002)(6666004)(6486002)(478600001)(110136005)(54906003)(316002)(83380400001)(6512007)(6506007)(186003)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/GyvHyoutPExHFBwU+uS2otmcyXgoq1RzaUlrooC1fx44/vbjhAC6JBu2zOY?=
 =?us-ascii?Q?vNf42//k83dJUMg2/GgcpuNYqQTxeFE+ig1DjrTSTH0UZgjjn+YEmRqZsZPZ?=
 =?us-ascii?Q?DzGKXJllbbnV9XOumANXX1UPNMT6H1gMyUNNGrTky1b0z89GkcmUAwdYADa2?=
 =?us-ascii?Q?tA2YESM6Jq5JxD4ThzIWgx679OgiHPrRtWKF+qs5h2lnEA4Y2UU3p0mbpNFf?=
 =?us-ascii?Q?dRmyrdu+c7H6oxrqwhS4lkQupvO/pp3ODdFEzf6COldrFSupyzTdRQqZQh8Q?=
 =?us-ascii?Q?0tXI4hWe2a+VdrokIQQKdr9NQgrEuXzzDBs2gFhxQ5O3X+Nl13FPGcDl/MDb?=
 =?us-ascii?Q?v2HVf+bcyd6u6LkNfYkjQ/9Qeq/d/1WtVEl1995qZ0sNX6FeTFhUDirYNbNW?=
 =?us-ascii?Q?0w6HBWCDIE+AqYFeNhRej4BXLJmJK/1m3SPaW2i7MOlktYHxKTvxFC9pMFKx?=
 =?us-ascii?Q?NtIYvDnelriU1B8CYPJkBX8MXIfWKkIdaKzTU022oaoqAIfmYN20gJHJwryk?=
 =?us-ascii?Q?IcrcKYRTTaMQs0XIq6y4IfOgosLS3eLUZolDfHSCHMJ+lqSuglxMIbNv9u8f?=
 =?us-ascii?Q?2RgREN+D2fRjQi2G+pA1kEFclCEJL4e67GdgAki+B4R4Y6aZVgRc5YNkQeFl?=
 =?us-ascii?Q?ApziiaEbLZ29AsdUqyxvHTnins+O3TbEqkFG2dJK41Twe8gse+8Xq2bH8CbG?=
 =?us-ascii?Q?bowjvSP23dlFu4UKVyHh/JwUTiSCZ3NTyQnOOlViP9LRpX08lM45H3NILFhu?=
 =?us-ascii?Q?crzj+3KYRuNZ+i28LJrOqFWddN61FNPWmAQuEtNShtQEMGa8J0lZSAsvpRnS?=
 =?us-ascii?Q?E7YFA/GkzH17d2h4+9dC35cB+9cfxO4FQrY/1D06qi+42R2A3oKbM1uWNf5M?=
 =?us-ascii?Q?Ku/osvMwe0ljPO/juraeglM8kVhQvlMZ+nGX78xSMsPAjOv2QMM2rvESPRGH?=
 =?us-ascii?Q?WsK8uJ75ClCG9D+gi3iSYKefGwhwHuGVdM/hXHdd50QCOAottHsfzcWUeQTg?=
 =?us-ascii?Q?GApTgqdRpLa4ONszf60v/DfP5NQBsQBaPx83W4e+IIyiF3sYy9yO4/UYA4ix?=
 =?us-ascii?Q?6z3WKWJx/TBJjzf/blUs7c/GBnTuQxENIUrkitsIXFrLic4Iflcpt8ntjLnE?=
 =?us-ascii?Q?dWHSFWseVGgQo6yjjTO9uVXsOacju+zd1wUD1+rKuD0pqcOW2250EAPesLWv?=
 =?us-ascii?Q?DV55CWZZbqv4eqHMf7JGegr+xsm22HJRwfDM/JvsyF1zF7HZkciBmqZ+D1/G?=
 =?us-ascii?Q?rkBuzWdyzlH/N2QNUDDCKlud6QTwoGdhNVmHpcDfwCE/YwvVKOOQyib686ma?=
 =?us-ascii?Q?na2u3qKOTOXUdjqnNlytDljpzXrpNfkMlAeU7X4zPeo6MEzRGuSQrFGD6Oy0?=
 =?us-ascii?Q?9xlJ1uFHap/Vl5DayYxtTGNv4mN0dgzKfazUFEMsWB78PqX7fqdhzIDVAggj?=
 =?us-ascii?Q?ac/sBXLgCuy+agXsrNoI5WeCEWalg8iy4rKtiJ0CheuZLgVeisqNrr23zo2C?=
 =?us-ascii?Q?X5RNVx1+/J2ga0iJNqrWrPAdthvvEO8UBZLMiyIrTcaglYawVBfMj5qYV3rF?=
 =?us-ascii?Q?XFjjxtA9IYhyBHb5H1JUGY2CUazIgiO7YWgEGgN/lQE9LHkP2HbtUIQ5BvmM?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8p9d/m3S0ysD05dB54ew6JeMmWvlU3DXV9zlx5PghttJIWJB4OiIeJxcmiGYgkFvO3IRLRQFDMQf8R6WVA1bYUZ8mlzY3W8QheJxhAo7D1OQfZ80TVDH1MB/PFukwpVWXLZ7kGV+E8DtUXZU4B1s0+DkWXsrrEWgIH7SAWI2JDtudPZk8wO+Fjq6QT0hMN9SHWUx2+7Tfhgy4H2fvAkozMlk/xiov6XSQ7xt/l7l/RHlMHDty0+qZGU9qYmdS0h2MkEHvzO4CrPrroTNzca30l5GXdQ+hD/sRObaXRTD5zbPwP8CBHtRhjoIFBo9OnUFGWtqj6+mlylRRVQ9gQphNdcp3dLWK40DXkFmv0ipPBs7ZWd+I5evMjGBxQa/jlLBbIIjwJjlOIlQLliecGm/fkSG3k7OSU+1+Iv1Wnjtr+bYySMcbpqM1dTt5n1zjCRQOsKNQDcjaxTAMpfnu7ih/ceknKRS0okXDFRbtm82xkYtxMk/Oanqu5gsUeZTA3W+7d2pq+RSl2cnVq7LMuhXiydJ2ZhI0+w+1O4N4wi7XwkEN/L28Ocp0OBgvUrlm0Ie8qkPFmsZR7N0fbYoEaBri9GshC+2GllUMQs6QPo7iDru6trZCTh3uQAhfsJVg0umsU5DVmrUWoesceFdxD+krwre9NUIhC5akUytOoXHroKVCtOCVcc5SM4Q4bLlXRaKEswLZvAvjKQygieFt9ahI5HedbS1s1tF6mSkNnQ3sWXXOnBR/wVL2GaocKLMa8Sv0ZcWoIBF9PzqdVOi3+qVijAvm0kQF5PLZQdle8lJXwOw+oI3o4wht1aP7A8Gw+uOAi1lbZ5zDjhYsnOMZYDyWiv+qQse8Bnp7XjqDs+tnEM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de70991-9852-4f36-ab76-08db1ead2f3c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 01:42:17.4986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH3zgIyi7RrT5xk+Dlgxy4L1lcU9IofYCiLWaZl7NEE2o5jLC1fmbN7CV5Oux/NxhZAhHPg6L1ntmOv3dxVt5ljQMbF6tnjZNfwszNDdta4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070014
X-Proofpoint-GUID: v6RdGBOl5IY_SAFIZQN3fPUu7YpUFELr
X-Proofpoint-ORIG-GUID: v6RdGBOl5IY_SAFIZQN3fPUu7YpUFELr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ranjan/Sreekanth,

> port is allocated by sas_port_alloc_num() and rphy is allocated by
> sas_end_device_alloc() or sas_expander_alloc() which may return NULL,
> so we need to check the rphy to avoid possible NULL pointer access.
>
> If sas_rphy_add() called with failure rphy is set to NULL, we would
> access the rphy in next lines which would also result NULL pointer
> access.
>
> Fix commit 78316e9dfc24 ("scsi: mpt3sas: Fix possible resource leaks
> in mpt3sas_transport_port_add()")

Please review!

-- 
Martin K. Petersen	Oracle Linux Engineering
