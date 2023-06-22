Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9281739465
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjFVBVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFVBU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:20:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D3310D;
        Wed, 21 Jun 2023 18:20:57 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LKJKXY002500;
        Thu, 22 Jun 2023 01:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=/1KsQ7RHf8BnaAMN+rEnCtjHcSvUndFadX9Te+QVqIM=;
 b=PKfUCCw030A6Wor+8hR7U/lPc7k+icdVjgyVVidEUz9/VNNWWd5U16MKyGw4fp5JhFJA
 Oy2wkwpXFRL7fjGlPeS8d0zZKWFeEH03TB4W5P2E3cDqFV5oyMRvr88x6VL3IhagoAbZ
 QDRU3sWcAi6D5bD9oU8B3bkRj73j/k9E1jiehv6tmDUKdci8MgwvNK1Uuuvensivpc7E
 ZVEj6W2PhiJbmQyDB8JWiQ5fsF5OIglZvIRqhzN8Ng8+NwON80tG2GlyVJEcgs8cphx3
 QHBbBTnzhWkUMMrRAYsUVf8KBdT4vwXrFwh5B7PEyM0aCh7Gc0x4gWNar+RVkLo8j1y6 yQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3rvx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:19:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35M10elB007190;
        Thu, 22 Jun 2023 01:19:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w175xcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 01:19:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTNkXe01z2ZzsBe5iILG/V6cCMHYFlKXodRmsI4DzO8t5ZheMN3mBomYaqX1TJwNACLyTVLUJtktt4p6rvxZ8Da/80bJ9igKKqxU4OZyO1bnxYJRc22d2BTMbGuMXTrCQ+Iv+fE+BzKpy2HhQSuJVXDRjb/PIHDxV2BOy5t/Ha2d9nG07+kmtqYatrdOMh7jJ7na//GvCGMsYsVoLfBwmvKuhJtudJAGTktYgduofii6ITpYtR+X09zqCJkMt0suun5BAFIXc7fKbyJkaW4GK1GwYWtzBeuxZ3o5BmjyzvtRAhHOZH329RWjH5vag3Sl4hCD2AEuYWI7qpQOJptalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1KsQ7RHf8BnaAMN+rEnCtjHcSvUndFadX9Te+QVqIM=;
 b=XhWm4kLQGaiKAbq1sxVsWOXs/McmmKYS73sPgI4Hj+14QNfMVVYL6MgWRgwNVEreGgn+LnmBC86yAcKrvcAtP2xCC78WpLVNuTyA4OczPpglyLVdVToHK/ILSCK0NTYxZEKJGCQpK5GvMe/Cb/uowW3BGu44L+DFc+RWlBU007q669MfYyy8xGYK8lLMJgbFuQjWS49bSzHostFcj2sXVS1EwShaLVdDlUwhSrnrxXhbB8UpRsh3o6BmF8cncPZHhp9uCbfo2ajAQxz1ws+NuUmlcf8e3DM/aLfWfhHzkEjGe6GTjB0QxjDgmO1WXhPOwEUWG5T3dAkLPppe4FiCLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1KsQ7RHf8BnaAMN+rEnCtjHcSvUndFadX9Te+QVqIM=;
 b=c65Sq+/fxTZEX6UZfDm2EqDmJhp9ngOfSm/p+wYuBcyM+2gtzrgYdWnwL/CsEhDG8s3YCGR701AhYRp2pVvCtbAMzzbUdmuhyMifm1RxpOqfgfYRDG35Ip1QJl5gREB8R4wPelfRXJCqwBGhGVDgleao3JDYFBJnd4xdTAmwOMA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB6348.namprd10.prod.outlook.com (2603:10b6:303:1ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 01:19:35 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%7]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 01:19:35 +0000
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: ufs: qcom: Add ICE phandle
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ilbgqoq6.fsf@ca-mkp.ca.oracle.com>
References: <20230408214041.533749-1-abel.vesa@linaro.org>
        <20230408214041.533749-2-abel.vesa@linaro.org>
        <4aadaf24-11f6-5cc1-4fbd-addbef4f891b@linaro.org>
Date:   Wed, 21 Jun 2023 21:19:32 -0400
In-Reply-To: <4aadaf24-11f6-5cc1-4fbd-addbef4f891b@linaro.org> (Krzysztof
        Kozlowski's message of "Sun, 18 Jun 2023 10:53:50 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:806:d3::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c6e529-51c6-49cc-9bf2-08db72bebd8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frG4c3ArPOJP/XqDtYNjL2/AhG6VuvqEZzpn2f3lRb5hFJVK8uZnRfbnm2Es3/HJ3FGaPvx49Q7QcaJ5FB8YiP/EF5vjlWgZhu/I7F+gNh6x4wN8bBm1znPrCK3MOk3HW1R3Xr49/M7ShZD3tGsEwo/5vqjJ5eu7u177eVIfNIL7kJD9aGNCeMEpLThqaH6psqwd+CedF+um1OxA0XuxNgLpEtv1QyqhhbZUNFbN/YQ4CAqUWeQUZHTKDpZy6oXhRxpFhETJFjgwrN10xu0FRQNA2lfLMGzgVU8H6BiiXLUKIXlOMH5KEpSRLFx7punkBfKjZNTAY4UiVq+kKwe0Szi6DaVeg8CHg5IfQ/MQNVhdiAfHWo9GEjzYhjTwgYItVMtuvqKjl31lh0Z4dYDmiSRjkoKesQpWN9DaJ1ZQ78qiQAUUi9rU/RuMXL3ZKVQIPP/WZDotTp3gyhhaYwxml2+XjyCbcOExHRdy9qy8ffwGSUNEmntqeeZiCMQRS+V4ieV09MaRkc2j9swvWnTmSap0JI4YrBmbAdEehZDXJLnz5z8EgCiMY3JiCzSUwQI4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(4744005)(5660300002)(7416002)(2906002)(6506007)(6512007)(41300700001)(8936002)(186003)(8676002)(26005)(478600001)(38100700002)(36916002)(83380400001)(66946007)(6916009)(66476007)(66556008)(4326008)(86362001)(54906003)(6666004)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l1lW9fpCebjJRoj32+vVl83iQl03x9xYwP01t4uFLLZbeBsfBCIdNPYElaSD?=
 =?us-ascii?Q?QQBiRfa1sVi4WCRweMmIeecBhrICkkZ5vkzsw5/k185sirHIw1PdRCJpz/Ql?=
 =?us-ascii?Q?G4U29xgXhQB3KE54tXyk3Fkr7w37I0hs/HV0L49lTrLIwoii513ofJ5WENq8?=
 =?us-ascii?Q?Hhiv/fJq1t/DetB+r8myazSc/K8e9mflNQgDopkZi9sJL9uW29iyB1euDrKt?=
 =?us-ascii?Q?7uKUa+nRQGLrSZjn7XJvW+GZom870JuLELFfvMRHdXzZCUDU6sjutwjnwvsa?=
 =?us-ascii?Q?K/Ettlg3thl0UAwiC6xaQ0JMLKN7FvZ/qStMPWXwpdSVLRtRVHXtkYSo/bTJ?=
 =?us-ascii?Q?UMdzfQ2F/s2KRgcHMGuz01TQgB8Bndwuu1MidaAEe73HiXpRq/aSXni2XCl+?=
 =?us-ascii?Q?4QKMN6XxPtVJosrRu1OE1zpXU39JLrxWbb+fPEOIhGmZkWtrDdYbRROgk9rV?=
 =?us-ascii?Q?SUb7CcOMxd8go2PeqBLAIos/WOFTiHCDrgJit4t2zYD+CWtexSSml3nCQ07I?=
 =?us-ascii?Q?NwUAfCzfGWVBzELo+o3YHOeob6f731n5t/6BFeIjSNt7uQpRDomKeHgfzvUi?=
 =?us-ascii?Q?8vL3CjLUqL70tQVc6BnJHhlCJVcDqKlCoU70KzX+0hzASYUbSgJQPDRKKOjE?=
 =?us-ascii?Q?IiSJAzELTY9x0Dv3zgaARQp65gGX+jvLvWu4nYfjGdwx+fzHEn35ePI8yEsn?=
 =?us-ascii?Q?EKbj8BiuK7YdeAy+vT6EydOCCZZIYCNH/FXFdbJbc3PWytXf9IFjjfUZogNR?=
 =?us-ascii?Q?4Y/7WN/pqHz/6cCLHmG1NMc/fq0OVMHkNOSNFw8vc4hHiDfn8Gmbul3By8Dz?=
 =?us-ascii?Q?qKkwiNYFUj5XtY1djQ5/MTV4SGORpHJ6XKys8uavaZn49FzbczYV0sjYBpyc?=
 =?us-ascii?Q?d4wbnppS6FnZO7DhmEXcev78p2xQ0IoglZzW0XgN7N/tEadRIsEZFDU7NGlp?=
 =?us-ascii?Q?ZbCWGfExllv3/MperfVxTM2ZYSNIVd3Uk/3Hb9jXz1tNKUtUJd98b4/yI2oX?=
 =?us-ascii?Q?bRkGsQiO20opMFPeh4KTBJlPuFInZH18TomqN72/xW9q5SaCJscI3ysaPv4s?=
 =?us-ascii?Q?M/lEMud9+CLIS1W2rrE3fEgu4JblCK2oOz1TF8ihdWSbCS4I2vtTsXLmZ4+s?=
 =?us-ascii?Q?xnBE/b4e8jYz79DOSybwUrC8sYgue1uutMGrwN52MS8LUtKV1Fj/bQz0KbPc?=
 =?us-ascii?Q?NZDb47yGvfZ90fMIYMJQkIVKgjg0qQ6PWxXQsdQDES/P+QM7J3bh0kw9U6ty?=
 =?us-ascii?Q?mSf9nPic+gBeHGhwCqFuW4ZE49wrOE+Aonav83iVItT0RzWQiI2PUAwsJgDd?=
 =?us-ascii?Q?71m9mgONRNYpuVrZ/DPJFW07KEQQAxpM8xaXXcPmmSTLykd/h6+iKmMbj4Ep?=
 =?us-ascii?Q?FEZ70LwbpuRse+W/Bve3AWN+asaF0loPu6VcodWjThbEETxkJfxRu9MniPJn?=
 =?us-ascii?Q?0cPkNgFfkjaYXlp5W7Gg4pUDpQxKxzbV5Bqoy7C+i/V4xsW+41fodEEAoU0X?=
 =?us-ascii?Q?NBj7R1SOLs5ucEFvWFZkeHaz9g9UlxmdZLVJess6PhwOu1f+PRwxIdbBlbqe?=
 =?us-ascii?Q?y6Tj8X64RMnvXDQgjnyRqECNtGhRR6vLvF3SHE0vmdob3X3iI/1dWYBsMdRS?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?7vXOixt7509sKxaW9STU/n1UWkhYbyoUeoWbEajaQzQtxqrJFsfa4r5aPjcu?=
 =?us-ascii?Q?4Ym053leUb1O9J2pi/yTTX7zJOMKN38HAT9dPXWc3C75tuJbK8yAFPswxPZP?=
 =?us-ascii?Q?ymRK0iGgTpDZxlS1QGi8DlDNaoU7J6nSMSxrsZgeRIGks1V0HO4N7MS6vO+c?=
 =?us-ascii?Q?EDYCUTQNJaC+PRIKxSOMl6rPZVKLunM+t0Y8k1Uw/3PXyoq0Tz+df23sJWoN?=
 =?us-ascii?Q?FB/6FyeriqlsIyKGIXP6xlv596LSWgEPDzw9AwaleZYbyEOefkjwaxnX5teB?=
 =?us-ascii?Q?0bpPjlXsSVHIqev/W3NjdiAeo+YRTpQRsVbhPwpL+8WJFLtm4ZOkUsemzXnM?=
 =?us-ascii?Q?CY0HfsA0YwHKPJBHVwdNWP4MniDgiiwR/ybDn4vKC2HmrCj8VkmcOMs+i2FE?=
 =?us-ascii?Q?3CHhLCEVpAsB005+EIsT1W/CqlyoCsLyrOMPcJpGk8U8Pn4VV0L5wiLQUMwF?=
 =?us-ascii?Q?oFm0bfqFVLXplh6GQsn66wj6+LJW6jgz0ecJevJ72w1RGkl5N/un5KDXUIwj?=
 =?us-ascii?Q?tksyATA0ciFaTt868NOcUHBlPhlHkqc+yRH7x9GGEPbGzXXdNbzfMYUj4QE8?=
 =?us-ascii?Q?XwFs0YWe4uZl74TH2wbQ42uwg5L1hElo9HGhFRdHU073nRGdQW/rrYl0b1tT?=
 =?us-ascii?Q?lmLcDFBX7UZ/SRLUtDfi2cHmpTezvVJ5MAt6b8noxJjVnKYlzRq+baWOPDBo?=
 =?us-ascii?Q?7F8cMBH2UGuFRGNCApnczxbn3RC3chRGogx64HosBzAnhqIMnEy2d+BvO/J5?=
 =?us-ascii?Q?xx7l5Ex05F8Eel2+XQV5sTD4SqTnN40nCUvR8KT/YEDbPlMHtb78oFbjd8u+?=
 =?us-ascii?Q?t1xClin5i/GzyhVkfjnw6RU1rxfS1FmCPh1QUepgVq2Zib3aEPENyRpaiDy3?=
 =?us-ascii?Q?yTlAu/1nAOGtO9a/R78r2MQbERnghndP+/C2OLK+UNIyKg1ZqyUK7DIqUE5H?=
 =?us-ascii?Q?KTQhfiOoCAT/nY9wS4BAGIT/HBH9WjD0jrREcq9M2zsuJ6t3Trix5upgEiN7?=
 =?us-ascii?Q?9LxVHEqP7dLI3asPGLHP/k+i3YVA4x/l3FWudKgyNSogQF8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c6e529-51c6-49cc-9bf2-08db72bebd8c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 01:19:35.3584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4hiVC1GVdWDHPxL498AVdaT2HYLjZQBeuko/i3w35fZZUiUeoVWJmrGnZbmRrrlAXaR3kxmGoD7MKXTw7tTq/Vq8YnjHX/Zy2dXH5Tl28w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=947 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220007
X-Proofpoint-GUID: 04TZD15CS6oNIaqtoCJStOEudwnO_W9o
X-Proofpoint-ORIG-GUID: 04TZD15CS6oNIaqtoCJStOEudwnO_W9o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Abel,

> Un-reviewed. This is broken and was never tested. After applying this
> patch, I can see many new warnings in all DTBs (so it is easy to spot
> that it was not actually tested).
>
> Your probably meant here:
>   if:
>     required:

Please provide a fix for this. I don't want to rebase this late in the
cycle.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
