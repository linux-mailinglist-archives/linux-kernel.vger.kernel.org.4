Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF2169EB25
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjBUXV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBUXVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:21:53 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5D832CD0;
        Tue, 21 Feb 2023 15:21:42 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LMhrCL007448;
        Tue, 21 Feb 2023 23:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=zH/3gMMPjFam7P4LglTWiLWNm2FYzDFfANc42id4rt0=;
 b=jFHpemlR8mFQ/YuTAdVxqZ9HJtVl1doDosixjZYBW6MRSLZII26p9JM7yUV2KE/Ww0kI
 Dr/SOvzKRfMykDTXyVgzH9I40Kbd7MDv/GNa0jAL9VXdymBv/Z/uVxBjveM6hi3cUH0Z
 XiBKxiPPcGdFvXLzaRqESmlr2ESkChK5SgPpr+l7NIxKsu5Z5+aAMVFXN64Mm1ePkb4c
 OksR7X9VL72f67nuk/8NlYXMNn/LQo03pOYJPi4k7rxHwgK5osTb2vUx2HhwqCFzR5Su
 GPN03nQk4yv2ZLwRdlz2foAJQnFCsitGEss136HtAV68IE/HSz3K8HQyCPZGzZvmjIbe LQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dpmgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 23:21:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LLkAJ9012926;
        Tue, 21 Feb 2023 23:21:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4d51kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 23:21:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwFzfjrw7f61ltIMn3PnN4fnRQtgzOfRq/PlmbV92d7gpXkoAYAX1RlpKdWu8eGEKygSCSzYu4gZvPR+h6gBthzk/x47xRv2BdTeiLnSnHuZV4oTA7NHn+cttINCIqCICTCbOqyYlbieoAu5r+DagFPOk8mhYKmF8VkMNYsctrHOzO6YrTpyl/73RIr/38EHa2daQZg1NcTsRQJYH2YEgE3yTcJzR8SHgVf7D/KD8SxNe+WkeppotW7aE3D51Ty0jsICMbnglzFE+pXrjULGzbZTQksG1V0130XIpDHQhCYXRF//hxl5KOJTM9kRbSTR0L5xconXcNRSe6D33WPFMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zH/3gMMPjFam7P4LglTWiLWNm2FYzDFfANc42id4rt0=;
 b=iPwyY/dozhe71HzLJNCdfxhwU9rHI2bSWEdOUv+gttPkh2Ob1CoYw1MrBZOla9JKv9VfGj6AH8ZYVbg2UEbv7sZqQNA5XftilW3B7Vtvk3BVQGATdKdRcsvvUTQwdeb3PlQ0WdfXmJkTiKaXpQh3WdGUTulUlI5BBOS/WNBa828XUMEXDj/cWDowlV4v7XBDrOuapW+X7bU6rga5Bry+eepg8RGAwbxGkuP67VzwGo68JoV0eh5OdfJ3J4+Gs9Kk38mTKb6Rp951rPmocAyAlkcB65BKcRfzPy28DpblesR7VabakvQEdvFTljWx45AtAcISG0pKuXFFz7X/B007Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH/3gMMPjFam7P4LglTWiLWNm2FYzDFfANc42id4rt0=;
 b=U76zIKJt1miYhNTXzqeMhjkTFR93FFTwwS4KXSXpM/3215TJysPLB9xW5rbuHgJCFbsg8dPofNTlqwOIBPjj8VugZlI9iFD8xOgsgfyFZA8LEOT9mRIqoi0TaoC7bti6Wv4r7y2rTdn7cB3kpkznUTm9w9kamTyTJu9RrRWU/LM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7117.namprd10.prod.outlook.com (2603:10b6:610:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Tue, 21 Feb
 2023 23:21:21 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6134.017; Tue, 21 Feb 2023
 23:21:21 +0000
To:     Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] ufs: mcq: fix incorrectly set queue depth
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfeyr4ex.fsf@ca-mkp.ca.oracle.com>
References: <8840cea4a57b46dabce18acc39afc50ab826330f.1676567593.git.quic_asutoshd@quicinc.com>
Date:   Tue, 21 Feb 2023 18:21:18 -0500
In-Reply-To: <8840cea4a57b46dabce18acc39afc50ab826330f.1676567593.git.quic_asutoshd@quicinc.com>
        (Asutosh Das's message of "Thu, 16 Feb 2023 09:13:46 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 74989dc2-51ba-4a77-7cd4-08db14625782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0GnnAPrILFkGvTla+/E+vMyCxM0IXCeNVRBl1gl26t06FqgN1S8xVZw/b9snTEJ5LidXnINIFVTyyMddGrMOCV/cxUc65ADkHmszR/nB2FrueKk3WV/QzlEvqjIz/dzN5NFLmFVpL2kx4yZP7UgybTS2ZD1RoEAml55mvHPfJSBNgcvCXBjVoELVX3gQVgFFONM4jLVy6zuqM5dTyhWzyAC/OaB1rt9PPeDQa3PDzhGi/fLLps1UAmQ7rNl3A0tYkOqenYXqxOu367cVVY2NqQ2ORbNiddyvJvipTN6tUSYvCjSO1M/ZnFdaN7J7dfbvtRpMPxRfDoYDK5ApmZO0V2ATH2LlxgGQE8PCxopd1eHhgi8CSYedFZa08Ief4MJwI/l9mDyImjWgrWRZkmmOQ8KwEfqyEk9pgTc2BXM6V5b25dc+ncJb1UTnTaoyK8OA5vp/tVzLW2S4X55+tHk7E4qQxSfMKyewZZJikbQSh7FMWP6agKeOQ2Ptk2rvSslbOQ/c8tTGTyBQpoJW/W7plpKmNNe8JgjdKi3rWqQPBP0VM7EKn29V8aXXIsX5kPWMWvXb7lPZnEyxKE6oBoNbp6vdREhTv6Fo7LirOFccwFoCSS0dt2/r2iYAeLq2svTPPd5qInmvwOufdKiOccjPhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199018)(83380400001)(66946007)(38100700002)(6916009)(2906002)(8936002)(5660300002)(7416002)(558084003)(86362001)(6486002)(36916002)(478600001)(6506007)(6666004)(4326008)(66556008)(66476007)(6512007)(186003)(8676002)(316002)(26005)(54906003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ag5viERXawh7Z6o16mZ86Ppb/smjdWmVcR57AleAIIFb7AYxioIPmwv52DAx?=
 =?us-ascii?Q?i4jWIEjjYHoeZU9qvv+3FdXNpahNMrjnz+vdiVud3EI4fI2unHIb22pkheAZ?=
 =?us-ascii?Q?KZspan6jJy5E8YMgK/1FwGoOdAxl29VP0Q3BGYaCiMH6/bgjX3mhD6LFHTB2?=
 =?us-ascii?Q?ryu0sBPWXYLRAj+nWDv915X5Ro5WWr+foLfNqEIf+YAeQnPJWM5hlQuMUi56?=
 =?us-ascii?Q?1AVDtj88x3LkONP1mvlQfDHW5ro1n+Ia5zl6cEl90zXpByNvdZkb9beWlMdb?=
 =?us-ascii?Q?EILMNRa0aSJvOkoPKq0HajTL9UQmh4XUcF/TUdD5ooxOi/Xdl6qo04U5o83X?=
 =?us-ascii?Q?jAY35pvo7MX+d6m6PydGNi1nRqDcxiylSBj//KTWsGasKYE6/hoKPB7muo9e?=
 =?us-ascii?Q?lXFfQYBX6liOcOeB4ZRzrbRSIoVYkuyqCV3//jxmcKaq9ytQPcgQMVR/QzNn?=
 =?us-ascii?Q?zKqfZastLMtQQOem1jWMVA/ZmC9BUxeyKlJY1Ht9M2yHAt/IvIP1ZfCtkSYI?=
 =?us-ascii?Q?nq+wcfMCxY+FnumfNwL/L4uMZsAw78L3WYk5nKDVUteAEj6vKesclQx4IGeE?=
 =?us-ascii?Q?hEbpA9BxWxFKqVZPNBRZ/Lo3v0BQ50x6Y7dhTyq+63eH2oUv/xh8mBQ6QhrN?=
 =?us-ascii?Q?c9D29ZbivHpPIMIH0OGzu30AaawrUuulc0zKcyt8iSrHXm46gPWxmc5zgcow?=
 =?us-ascii?Q?4au1RVur6z5w9+f3NdtbeiMUe7G4l1G97z8UHPr5cmgbqbpUnRN37AvJ8iMG?=
 =?us-ascii?Q?0yAbNHOqS6CuMzV0HV5LeWb09rp4S7b5Cd3hvVKuBEKPB5gpPkL5xyA+KIR5?=
 =?us-ascii?Q?SjRrp/qF2h38tTNO+rAdJSwgbq8uBPEYOLKMrbTaO+p5DmfYFBe7LErGVBYS?=
 =?us-ascii?Q?CUu/AnpiT+IomKncEj+reX93/klgwNY9revFhogtvoBm4Gq0lNWW7x0DokFr?=
 =?us-ascii?Q?pRRHzc/XlJHLm+S1LawIW0sS8ep6Placnf2Z2Xl3NfCL4maN2KZPH12yKVKO?=
 =?us-ascii?Q?pfAZG9upic9i4ixEKvj1t6GDy3pSxpmAryGi5cndCR5udPh2Q5XTM4aqenO9?=
 =?us-ascii?Q?miDAVPe/4FoOMdxOjA26PvaxCycJVoXhYrrjrYfC8DnTBHP/6FHvjK0jqznt?=
 =?us-ascii?Q?Vsfhf7hs7iBamJubU+hhOtN8tdcMa0m/D/T+S+UeznIaeStoatrDeB+bqyl2?=
 =?us-ascii?Q?RQXlA5XTjKe11e22DtO8nZuHtzx9tFgy2KMF5lBDtBCnB95ON5VTZoL6xwaD?=
 =?us-ascii?Q?OyvZ5foUahstWftoVbVU3oCPRw/++62IXJ8fzo3Txp+IR4iWxg9DVyA2+Cs5?=
 =?us-ascii?Q?kRUFK/XYQVJSzhyfQv7QZ+Ja0pknOE4qwTXJNciguWhd24PGC2vpm9470qr/?=
 =?us-ascii?Q?gvKN0WFgAS6vjBmLLQvPujLJaE/IT95UiX44fC1qxfRxg8CbbSiLKS28fvB/?=
 =?us-ascii?Q?71Cmo3TKziN9HmyTAM5ifxOe/K7biQ+JqvpvvH1dlYwPLDJcfjsAqS3gIJ8P?=
 =?us-ascii?Q?zRgpGMn1XaTyXSy4goWgrEv3g9t0U4Z/CkjQWno67IedzKSrabj/G0OIzANX?=
 =?us-ascii?Q?eWJ5nXHNgJS7mLyG+eM6zI3Jxp4kPaSabDY2334vUUOaPX+Bvp9JEJNnsO40?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OjeKLlwC2qoNStU4DOwWzLlXPOomG6CgW5pcRbUEF27QcSLbXJbwKMqt5+JH?=
 =?us-ascii?Q?ioxU1ZqyE/cMq4WNEmar8bBansIvGpXvdOcjexJ/gdsnve6OTKcoAQg+ztgg?=
 =?us-ascii?Q?9JuymO6uq6gHAGSJJmOjY0fzRVW7l8XXydNEE4Gy0y1Go5s3/15tf+vf4TrT?=
 =?us-ascii?Q?nebarF6WbUtFejZvg0zM73qj30G7GpRYIOJgnrcC+7e8zzU894SbxDeDBMjB?=
 =?us-ascii?Q?eH1zHSVRnfNyCEuGL2DzgMjU1vVlz7PnF7gI7xAmmENLVBEi1MPqOvIs9gwA?=
 =?us-ascii?Q?z+az3iI1ICLY1+wzopw+kOZ0SxYmyM6c1xAv5Hda1FCK4U8R3G9/tQiZvFx5?=
 =?us-ascii?Q?EdQetE/ezyfvIqNu9J/RRsR84YuaywcWk7HYX81PPVxP8cPBevmtEnxEeVmE?=
 =?us-ascii?Q?apbRU+wros79wszXY1qb2xHedENyeM3JOMiYLqfGIYpJyycxDkuQ4zUORfwZ?=
 =?us-ascii?Q?W30vf8akv5SA5+kGKp72xlFPI37+O63JvzO/1QDBQVh52L36B3xyrz0zdpdh?=
 =?us-ascii?Q?6vPNQDwrODcSa+xxtQsOtKchACRqqJDySlkpO4XZAnZlL9sK0Ri/XX43Dj4b?=
 =?us-ascii?Q?VOeeguM7KhaV7N9ZTdkhTwdIA/JGTablUMfRPa0czwnWDpU8v36YRiNhLlMO?=
 =?us-ascii?Q?LGJQrRDJIfP3p5J43KEFRNaZ9coK1oLDadilihXPvtjcZOnmknzJLhQwOtoG?=
 =?us-ascii?Q?BwCM150VkXiyG0QEKLx0EwwltE1ENrtcsx6+1XuTCDOQF5DncYwyiavj+0pF?=
 =?us-ascii?Q?aXUctYRGL/M0I3URBlStvhtNt/sfSnFUjDsDBdIpyb92dtZUrn2ntKiCu31Y?=
 =?us-ascii?Q?+S+cEfS3Q0eDLrCabuvcJRJ8tZqHP3hU+0qMKKnfLoEwplaaIfgHkM1steGP?=
 =?us-ascii?Q?zydTyTMhUaetMnFB41cMl+lyCv6Z8tSOkjsNXzODVM8f5xPRf//ssjY3tG5l?=
 =?us-ascii?Q?LRrQOEkmc1ciVFa51YpZvC8hhOYtzS3UYoeQfNqxmjUpWadZfZ/vBar0QTsw?=
 =?us-ascii?Q?6rPOXZamW/fCeNfGkwPAPvKuXQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74989dc2-51ba-4a77-7cd4-08db14625782
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 23:21:21.2295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYBG2zui4PoalfgYtPd0bpBm4el0X6dqBc9O5tMnLTx74gn/CW9j4D8B3P9oTGvUr/Xm7HaAdU5wPdxT0FxyQG7vVFswU5fD4Kqtj17dvyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=845 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210200
X-Proofpoint-GUID: ixvP6dOyGoKXFB7szYEc7Bln1lwknyP-
X-Proofpoint-ORIG-GUID: ixvP6dOyGoKXFB7szYEc7Bln1lwknyP-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Asutosh,

> ufshcd_config_mcq() may change the can_queue value.  The current code
> invokes scsi_add_host() before ufshcd_config_mcq().  So the tags are
> limited to the old can_queue value.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
