Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C50639298
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiKZATX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiKZATV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:19:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF84B51C05;
        Fri, 25 Nov 2022 16:19:17 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2APNmH7L024262;
        Sat, 26 Nov 2022 00:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Vc9TEjtiMP+WdIZnA/nRrg7zIcgV9ne+0W0RMTiag64=;
 b=eZMo4cb+t5/GEhnSA+Nk1fSd2O5VZJfAkFi+eRUmDxnNmoaIyhQSkNKq1+r/2wqyKpzx
 btF+VRmQL8drX5k0lhPjDjZ65fVg0nh2nTc7G9FtF1bYt8PJo5wt2oqkYILJMWHiPrCN
 OdnCh/fC5A2xIX8Cdpp7ilB2MqcoUBl+lTku5uLK9ZEf0nWWeXF1LEXQVg6WMuCvkLIO
 41A3wvq/Ffe0gsHx+hUB2wrrpU79jHhzOwo5hWiDf3fnzJzFNATFpXCBDAa83aJ/F9te
 btFMtY97jILl564sbdTOd3VE7aF4CD+3ydjrOAtgTSXqMKUunsJv4ZLhljaQRyKzxJGd Hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m35d8g4he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 00:19:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2APKeBjn027657;
        Sat, 26 Nov 2022 00:19:09 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m233yhbcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 00:19:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ht4sFzHf8VIhe7JeFskxcnhJ0Y3vlcnII3U6AKmEMFo5yKKn/0sJtOzQ/08wsLp/5Hfz2GIc2pw0p0A5pJb7Bu94iqS0pSOaYTGgLalEurSGhgVYmUiGR3syjLx9rHPuctBU3qS4TASoda0pAplm2PEtLnVEvL5qT18i0zB3KeOXDNJnhmTC8YSPT9qYYnfsgAwtPyt69UBDo0GJ3mOJluPnzR+2YfXO2VfHhdp/3KJE/TSALsnamZNqmdD7/mBn9J2o4lO7MwH9xj/Ct0jh406W8XSdceOXESzeASA2x08U3BDfHsT2YKFnb1HBntuRGh+1QVGoBAWxOc3E3AFXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vc9TEjtiMP+WdIZnA/nRrg7zIcgV9ne+0W0RMTiag64=;
 b=l+NFbLhlWYABODnIlW7BknINQLbU93MQ3/69QFthQR5/KIpMdXH8fCcNemU+NK1pTHuD7i8LT56o+YXTCF+01a6DlGTEIDUyKEtOtb56cDJPyMOTScgM2/7tA4bSMat6tqw6tIXGYezxrTqUNKN1AucRaKBm+vzzUA/LoFonOd90b5yAONxXZJGWVZUqr84tgdNJF3PD2W/ci5MltpXJfa/cRvkw4he7xss7nkcVvPL3G4/43cmwC6dcJizqrYTvvz18kIl8rmzyUUsP+SSdSxN5mXj1uGl11o96J1zXx96pFT+hk8PCWUxidnaUJeEXVMDP6nXFPzSf7GYhR4+S/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vc9TEjtiMP+WdIZnA/nRrg7zIcgV9ne+0W0RMTiag64=;
 b=kEyapOGjjphtA0M9W2mP99MKCUK3meZPadvSYe62SFuGgEphShn4nJdGwDb+3xgjSDl6imn0Qbz1BpM5YKJ5BgC+jZxruOYcSupQebFYXKXSNgokIdjgFOLw25UV2r0Mj13ngjC1jB9pMX2cFaXkqaZ/2RXdaLBm97dc7L6uNtM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA2PR10MB4522.namprd10.prod.outlook.com (2603:10b6:806:11b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Sat, 26 Nov
 2022 00:19:07 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 00:19:07 +0000
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        adrian.hunter@intel.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: core: Separate function name and message
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17czish3j.fsf@ca-mkp.ca.oracle.com>
References: <CGME20221111062158epcas1p1c3ef28f75c39a1c1dc4c473266462fc8@epcas1p1.samsung.com>
        <20221111062126.7307-1-cw9316.lee@samsung.com>
Date:   Fri, 25 Nov 2022 19:19:04 -0500
In-Reply-To: <20221111062126.7307-1-cw9316.lee@samsung.com> (Chanwoo Lee's
        message of "Fri, 11 Nov 2022 15:21:26 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA2PR10MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff510f6-0c8b-40d4-d122-08dacf43d50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFmloK43tnMNev4UxZ7LdIWjiOwtgmYyQefViJpYMQggLE4GWeSqyVlPEHYScI0+3X2t7dqjrqwS1ZjSgYr94n826lTvLWoUO8Fbh8wPbqwJMXITFaBX3DIqL2rPdC8x06R8D9+VqW6WlHDfC+hWyijLoREeLoEPXfGxmCEOtV/qXtRTMk/Aezt9huaM8ha4VOyzCINA5CgBXhDSF+jZecVbTqb281wmQIdKp4w1WuKDMAiVxG09Db07ThqxmKkrqBcHAvmO+ldAIBLmy+eyfD4eBEp3V/60+Je9KWxdZPjFXFUmIC6k+y3c2VBTygBkr35JdDrD7zejfgth4h62KOSf2r4tbn28mYNRSb070LvB4nvYC282gAbxAg9OVgwSst7IjF4KC7gEvHaauuKYCYDXYokQ57zkW+Z7A21gFD6+tbKBkCrd20cQGaG+Mra0HmG22wuZrq+rfjsbtec4kJSslAH8pHtHdfZsXjbhDRnH0tBKlgB7daHOihq2uogmKFslHtRktMYmZek+2G/TKDWO+WxCnmWskLwLMRbt4FsK5SSk+/P1OF9Lb9wpgPWr3dHYLP11IMhGxXP8Y4Kj1qoAmp/EIKzRqKrHbLnsJ85pkI40N6jSV65aSu/2p78Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199015)(2906002)(15650500001)(83380400001)(26005)(6916009)(6506007)(6512007)(8936002)(6666004)(316002)(186003)(5660300002)(66476007)(41300700001)(86362001)(478600001)(558084003)(38100700002)(8676002)(6486002)(66556008)(36916002)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sU/jpdydJQfh5T2XP2DUT8mBcCwDmDxc709VvJSxaNfqaBuI315IWV5c5wk8?=
 =?us-ascii?Q?vo8h1ry8aPKXYByrI+1UfR0ixPYTbkvWc6NHxv+xFm6e39GlQf20iB4bmtUg?=
 =?us-ascii?Q?Gse+TbNPbeC0/nUwz972s9ka/RKUNohCMh1Py6PZnKpiE2zKdHYmVDSgnN+I?=
 =?us-ascii?Q?y1Tc6PH/Sfez+nAFVmCVj4gOAMRfyRudRlxrMpjIEh27n87y4K0dmbWqSRyn?=
 =?us-ascii?Q?IslFxDc1ByV8abDNtjEU9+LWhHHS/yZnc10QXZISaai6xD3ctnmW2Yy8NHei?=
 =?us-ascii?Q?XMv/+TP0Jo3OWjNQOdoqz79iHkOr1phyS3Zmc0FahOms2RrHn7VllwahlcQv?=
 =?us-ascii?Q?X4rCUdF1NXCDVNMhA+fZJ4kTBLdFX/QzXaEVl7WU0kgtTLfiv8ct2ndy3FNr?=
 =?us-ascii?Q?Z2Oxc82StocXx7gRc0YV95HSS6FAAXS82x6odowhZ2RdlJMqp0LSxVIkow16?=
 =?us-ascii?Q?Po/xy8bP646sPds0pJh06FWoqqXub1C0KQrrn3AOkevGVqRQo1La4ZJQuK2u?=
 =?us-ascii?Q?K8+4kYOPSMj+KRsGaGG4jJR9XAuQ9qpuAdr/FHbmeR1HxoZRr7lCePhLewj6?=
 =?us-ascii?Q?Jn7qs9UQqSCshNiR5R0uBiwfgt1qoP1hwrhxakQSA8Q1LxI+odunVv8P24bc?=
 =?us-ascii?Q?OJPWZITEP3ojULX48ZfJFtayGUKoXQQP27drOflFjGze+2C+2ZuTUy68cQCp?=
 =?us-ascii?Q?vB0lyBZlNQaOPjZEyuYX2b4hdhofNcxRuMx7LXxnRUKk3bkLUJ9wX9pQwoe4?=
 =?us-ascii?Q?IpJfGXV1Wps9/5VfsCRVEVWbe0tsn/9M7lvq8t4bCasTf62iVVd0cvRVLYPF?=
 =?us-ascii?Q?cRYqzjgoogVTC3T0LZnOdk4O5biUO+VcoeMb0F3Dh/MUsBnQmwv0S7ZJeOIY?=
 =?us-ascii?Q?JyE6zw+E7OKlxK6mdugXCk006a13auQBTq9RRBK4d+0JMYXNtp9tfBUCj+M1?=
 =?us-ascii?Q?KjVKX4iYtTM94Tx3MVrwKL8zGX+qn9vPsNQjbKtvz/Z7ey7elfKBSIQDkEUX?=
 =?us-ascii?Q?xsQvizj2ORcd5ogNNXcBLlQCA/PozqUFKYY4aRIf6bGK8v3uYfYE16bSpXRQ?=
 =?us-ascii?Q?SHxWqBOXvx7uY09cmjcrfMIL00v8plRTNxGq2QaHRswbKG9geZJ1zyBfe2Jy?=
 =?us-ascii?Q?sYmif4NUkhMKIdkY/DfreN2s39M4973xNYH2Vv8s+cULDxgPJWrv5QHdkUVy?=
 =?us-ascii?Q?RIWH0IdGNIbeCkkVOiuguO1BGn8zJ2oP67Ou3GHMt5W1rvvn4pzNnzX0gkIT?=
 =?us-ascii?Q?4OP5bIzY3a39S2tI7qsZYbxQnWupFwoxwTMJW4bZ37Sb7X3hcFxv5Mc38jD2?=
 =?us-ascii?Q?xN7aRH3yOapPtISKgQnKzMNf0u9i9byguCW11dJCqErFXT1Vhjoz9Qw9GFlo?=
 =?us-ascii?Q?1m30WmWo1gvegTcc03oeEi31Owo1ZjNkpOfjAuVoZSA4pZYvS54EnDwIAVIF?=
 =?us-ascii?Q?Wrt4wFibTfeyjBQI6xgT8q0LTE9bqU4icf1450T0ssfEcKm8pfW5aBtAR5nc?=
 =?us-ascii?Q?okEJMmq7HK3UI4QuNdWZgjRPDbdnKM+W+yqGiStJIT+tMu+ledc2njjDdKfb?=
 =?us-ascii?Q?eDAJn7EED4MqF9tBncxyNclZxjuuGNg7h6vSMP+CJ4Niezqn+PZmfhVnACbT?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?f4FC8SMg13rNkXJzXIpcoNGSjrDbL8v3wkw1X4ESKsTlhKqPRupQhjsgu0j/?=
 =?us-ascii?Q?V3z0MDz7Q8/nu0EsFc1G4ZT4XmVJwL6zlKamzcjUT2KvkB8h60SCFwmfQBgn?=
 =?us-ascii?Q?FxFM20xIjXKZlNX0s6YxYnlWaUshp8r/h0WzgpX7h7F/64XezgzvJHpKpGd+?=
 =?us-ascii?Q?AdJ6v6hMypGr9+t4mS2H5ABCmbOg9mXu/mLZMbOnoh6ya0oD9P8DxNN0FuyS?=
 =?us-ascii?Q?Uj8FQgyyJWtzzJPInzjeGBriQ7c242NJnuQW3MFkzV+Lz26lxF7lvH0KFzUF?=
 =?us-ascii?Q?UzKpQ8w1VlaEPymMyr5lqDu+1UNhi1lNTlLd6MSet5ULHsYbx0vfvdke2AbG?=
 =?us-ascii?Q?gZLe/0WwXW48YM/V27Dt33HqrdjD1c383hyPKIMvs5nR1Vr5ZU9EYCEbC3dJ?=
 =?us-ascii?Q?2hmEHrngdK5peMWz4PPgedZGOzVF6lrlCCaoPyWlEaFc2lUN+IHXG3JKY+Sp?=
 =?us-ascii?Q?JFWKbBwP31P8rs4sRzfthRKMQ3RdBwfCoTRJY37BY9yvSiYtmS/6f7WCheyf?=
 =?us-ascii?Q?NpBO+0luC+q1NScDjbUuoymZDGy13YCKl1ecvvrVfHlhy/YeKl+t8530sxi2?=
 =?us-ascii?Q?u0zSYR6rzvfB6vLUQvb8UNQUlVyd3SqWAn3nMCzU+vUcB0INEaKYE5UUqONd?=
 =?us-ascii?Q?egLjBkAPp96FMJV3K63LgRNxFWGlWuh0VJ272M6mHmHURtJX7Yb5ZoNHGcRn?=
 =?us-ascii?Q?rQ8KvUPxPE4geyvVU2SJNjwBHtUrlTOGdqmkzz3IjN7Cb9hcYyIlapKKINQ+?=
 =?us-ascii?Q?JJj2NlgDmJDLnQHqXOnxOPGYumyO6kuivrDUpVLacB3PVMdI7Z+xh8E5cp5m?=
 =?us-ascii?Q?et/xKsXSkypRhJCZUwY99SMfKKqCXkdxK6zbiNUAXjD8ngk3UxdpD+c+DlfU?=
 =?us-ascii?Q?iOOl2cRMlIQC/OiTVO5H97p84dQs6srvnOrgP1XVIapnlbr8SLdw9eZujO7d?=
 =?us-ascii?Q?XSMV+qcRflMEecACwLOqOySoF9UOLzcNy/jXSG6qDUllwxfoOifN5ygVqPdx?=
 =?us-ascii?Q?87/H?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff510f6-0c8b-40d4-d122-08dacf43d50d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 00:19:07.3213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMX74XLCyMjH+lm2FtrEPsLF47UOfdb42gRYglWxEN3skHPH5WE38Hxl3JCuk+5Hu/DpV1GfF4jcw9XR7mlw6h+4ZqIC3mHovyblc9+mAGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4522
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_12,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=917 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211260000
X-Proofpoint-GUID: ksQir3cLKd-LH7jwPT2wekBezF8aCGiE
X-Proofpoint-ORIG-GUID: ksQir3cLKd-LH7jwPT2wekBezF8aCGiE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chanwoo,

> Separate the function name and message to make it easier to check the
> log.  Modify messages to fit the format of others.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
