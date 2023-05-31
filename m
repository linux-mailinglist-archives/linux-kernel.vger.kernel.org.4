Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDDD7186B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjEaPuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjEaPuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:50:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF1F8E;
        Wed, 31 May 2023 08:50:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VERRQg027640;
        Wed, 31 May 2023 15:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=T7Fr9VaaSLbC8y9pJLKCnHBp+LAc0uLjASgCoAM8OJo=;
 b=ZJDowzM15mNVKzw60NozQLbWbWn4Gff+m+7nFA2l/ioprxtvhXvQCFjB+O2t1cUL3yhH
 IvICKrBu5Zdl+qRaPR+2lTK4D8S8YNH2pbjMP8/6MXgE4btheft/B6AtTK3JmyFhjJVC
 WED2Vtb4PYAXG2+CMeGwZjvOpDtjI5cV9ba7R3VtZQRcKlIa2Smb4gQ1pAM95TDLqhk8
 5VTQTsiN4m2CvmuTsRsH22MaYv+DSLaDbKKwhTFCvFEka0MrqEj1slU/o2YQfVMwSL4+
 LPNdeKBjDkbq7Bqo0nhzOFwr3fgua7Sk3VQbkqh4rBFnNmS9CIZP7Qon1F4oV0eH3P5t Ig== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhwwe4xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 15:49:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VFgOkX030083;
        Wed, 31 May 2023 15:49:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6h1a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 15:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzhIOjXEmxGHdRrroF5a501DrJGxfyR6gS4KGmJzFAGTU1wByJtASN5ivUq2QVAkl7NlWiZ7knDry6e8QxuG0J/odALK9TtlClfV05fU9X/GbPeYBxUwsHI52tb+jekp8wc0Vnr0zTZ2BibjI0ZZMcM+mSU/u3MwLWhKS8yTST0JqJ3HHBemnpLUS9jZt8vDO+Pur1aCKeDN435Ety/xXEk75FVws5AsPdIPuBz/K9XeqgLf+rXDXzufbeCOBZlzqcryIAKw2HtTZRQrDWFut3AlkmYoXqXBNsYhQKYRFfLdx6BHKtfnPoTZI9rKgyjLD7NgBV2Plbzc7cBak0zwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7Fr9VaaSLbC8y9pJLKCnHBp+LAc0uLjASgCoAM8OJo=;
 b=Iwyn8u/uhTIEOlym+JkKqLvozZuAIBeJQ+03Cg1kBQRR6ZLr5pxNGMhx0u8Ud+ygUN1BBLLZMWX28ZtbuNYVP/Hzce0p0D2Sf67GM6MzTTY6A1pjf1m0ujmDXMWD8Myx6Ra/3LE6cVa8izHR4y0NtGbalZu2aEAWIMt6+VW5UMOUJYEQX4Y5P/IFZfIIX0GiEx9uNNEJBakWNDD97HqLWrRUdZaGhj4SwfNDtxKjzRiS8PFoSoj+jPCEdbbLH1LALWowle75XxJczgQnozXAEvWLkG7/Vqs6f50sSzZC5+rx2dak07EP6Ox1kLmqVEKIBbEWtoAtl2JqauZpUcAwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7Fr9VaaSLbC8y9pJLKCnHBp+LAc0uLjASgCoAM8OJo=;
 b=rGQuNSVwZvbxAZEYNaekOn2uHWZtVbyBe2ETu+ylm6EbD20PIAo03GCPdWxuOE5AcSvfd0fLtBbkz3ZklgPVdNcuSL1tHYgq95Wi/lOxu1rzz8IKnCVLZpz3C1I/jPksjt6sAwEcDU+/NB9pw2c9u9xtnzJn8e9yNph9eY4OC4o=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB7461.namprd10.prod.outlook.com (2603:10b6:610:18d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 15:49:46 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 15:49:46 +0000
To:     Avri Altman <avri.altman@wdc.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keoseong Park <keosung.park@samsung.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: Re: [PATCH v3] scsi: ufs: core: Do not open code SZ_x
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14jnsfqlt.fsf@ca-mkp.ca.oracle.com>
References: <20230531070009.4593-1-avri.altman@wdc.com>
Date:   Wed, 31 May 2023 11:49:43 -0400
In-Reply-To: <20230531070009.4593-1-avri.altman@wdc.com> (Avri Altman's
        message of "Wed, 31 May 2023 10:00:09 +0300")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0056.prod.exchangelabs.com (2603:10b6:a03:94::33)
 To PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e735a05-d95d-40d4-b904-08db61eea867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HscRQKnoheoipWwOQYc4ePH9/38kJNybJ4ifdqfBvYYPNzV8w15t23ip/TF3vhQQPtU8QDR7Sato8Ie5Nq/GVZ+Kmqw++1HmXCyNWrqocT2q98pXWAc5V+H/82SSxZmCwwXDHJuIdQ8NgdEesAMXm32t1JXRS+Md4oZGsfaioAfXPb7EDejI9o1uTRhud5mgKXM1rOJvINVBLQZsjne8COhmhrwfKvRmCLfUpHPaLeIbmq6QocvEIRW6A2apXQb+gC3O28H7s+VLKvxjDDFOdLIvU+6LE63n9Pilnoibe0lyLR006P3N4HwEvtzyTZNwGVJkkj5ARXk/rcmLTzzxcBZleYKC/YCDF81Tgr5eglv9a9KgzeibFE2BrUQCtem3zC8EHUURW2Enr9+UUAmDGiA42qz/mx8SOFI7kItg/H2Z3hfVaF9q289OzIyhELrY6tC8jZZNlxo5OfQuhpvHvaWiApq1okbK1RjNqM2UYoQjpHjDOmQs+33sUP4zWixiEhiXQwK+oXLOHnaG3XgT/R/JwDyORCEeIa2BzCS67MdRYcT2UlVwjLM1aKQndpK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(316002)(36916002)(6666004)(66476007)(66556008)(558084003)(66946007)(5660300002)(4326008)(6916009)(41300700001)(38100700002)(8676002)(8936002)(6486002)(86362001)(6512007)(54906003)(2906002)(186003)(6506007)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?enO81J405TM+a7p+pv83KzqbtFSej70vrDPeUqgoV4Q31JpKTcqRu0AUL3hW?=
 =?us-ascii?Q?wv8IGep2wyBBgv6S9NH+Zh1otKnhmNdRCYW23+W7By6FRsLOJ6r1kFdznwB4?=
 =?us-ascii?Q?ynvAC3SSYSPp2L5Tk9/mFLsnGtJMm2H9soGj4kEm5dGTccGx2Z0rz6r3TpdE?=
 =?us-ascii?Q?ClUUp+y72/FrUyi4Lg5IV1bRO52jep5FIxOXcQ4nGPVfZpESYB4xieEGxKuc?=
 =?us-ascii?Q?69H/RzgZHWn3hHd/2y+C9OyPI0l8jcOvixFgRCMTBKbEkdbddRjOcq9HzN1n?=
 =?us-ascii?Q?pN5wiVmpv4cWZNc+Z6FPzFplzTRydRS2FOasQ0msMEdibF0wy80tvwh6jiib?=
 =?us-ascii?Q?JaYGZrnuTzHYsvLDsjOaX47526PjX0x0Zou0jwpNkUVtUKB3xXTG/GAWMPZG?=
 =?us-ascii?Q?Kw9B0QzcWgQgxL++r++pRZ4TZqZxDz4TtgxNESNI9IZ5QAtoi3uPsCcxSTkH?=
 =?us-ascii?Q?c2xf/7LoeI1IVnIR/SlycjBts4O5C4p2xNz5MfRj1gT6qlbXRwMfFaUa7kpr?=
 =?us-ascii?Q?9vdrqnKU1S/W2fwz10m2Vh0V6MLHJLMHAG4NEunwZDG2Eo9LA0wBehC9ljE1?=
 =?us-ascii?Q?lI9T4aUp3LF+LOJmLQmSAfu9oDxsmJdydkZ/S9jItNsZVIdgQHu0P+nTcSY8?=
 =?us-ascii?Q?TqwC5OUgbOM0AbmJdSP/WFLhnn6L1X4vb/DbGo9do4CSSHAoIsIVTKidGfFC?=
 =?us-ascii?Q?U60rwVB+QCfVRcnPSl2COwl3OinHz/b7YL5C5+SVzW24pNcMQDobQCwGbKpU?=
 =?us-ascii?Q?hMBlnb4NKyITwvJpUavmhbbGKDbkyKIvX5a1pv3ck8p6hxxOncEssqt48oVD?=
 =?us-ascii?Q?0GdqBMQuEF6djbtwpcinwQ/FNZX/qrpVtTIUVehNaSoZLZl5Cdht96l3+JS5?=
 =?us-ascii?Q?FFBhzEUs5LCX7NJVzC11VHKzqOm+RUABST7bxM9ElkqvXyGR4s9TUl7eBZiq?=
 =?us-ascii?Q?UUc9mIzoMPpsqVIIlnO9E30sQHKr9Qa5eILzKz5fDDeR0qiWPQMbxjHnOUTh?=
 =?us-ascii?Q?SaiofXA5tw/51FzUpEM6TT5kmmkoBjTHhs05965FodfIW56xC0SNL6yJXi6o?=
 =?us-ascii?Q?oVyO+UtGnKZ8tXqCLnGxSXAar5A3aw8s377forATkMvD/qRT3moRfOVOcc7e?=
 =?us-ascii?Q?8d1nG91+zPx+eTh5R+8XULggRDLLYaOTwgP+Llna83TTeIHQ4elhO/2lYVC4?=
 =?us-ascii?Q?JNpata0Ks0KQSKW6F9P9+zt2CL74sFsTru6CclXDZQv1uYNfbJI54+7W84hf?=
 =?us-ascii?Q?BHtEJmRHIJ1moRHchlZt/adJsw2WlPq80+/kroxwZdCue7A19sc2EmF6jut2?=
 =?us-ascii?Q?6yfvzUrFNjACYEtoEeLos6SKVx7Fy3L/FRlg9OcaS9FaY6xGnX2/T3WYrYYr?=
 =?us-ascii?Q?Hsvw+N9l1YjiwArUVWk7sJNO1cYJ85qrk8sjoyklJdYElPVW3sNJP4x7QKXr?=
 =?us-ascii?Q?SbVUIENd2eODFfk0FcJQSr/nOrCAW5K8YaGroxrRt7p5qMXRiwh13T3zepHE?=
 =?us-ascii?Q?B9CvfTigbu+Ne/ntgOUGe6OJI6mn1EncnyLoyhWyOQ9aroqBQFQ3nI1ZQOAL?=
 =?us-ascii?Q?w+WN86cdAJMhAltm7Z0lC+BGRVNy2nQLqrxB9uglocfIfJNRlQreMsPErhKm?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lTUFgN/+aFIiTgh736F4zg0YMKlMgXV7Djxv+SwmbzJZUQ7fkd/Awx0lAV+/?=
 =?us-ascii?Q?DUbqCbvZhDkdhJKj/ME6D6WBEQXQPlaoAhdh9tbkEf0M4EOfCE618iOlHHg2?=
 =?us-ascii?Q?27S2lDb2lLzgOuVuKil6YdisQRLvy73bgZaDCATsk6BiQoq3njA8eUXPiHVU?=
 =?us-ascii?Q?0FtPI6WAugifduwbvqsGakjm4Y/fc0oKPtaAVHyTHgYle4HA1Xt6yBRB830R?=
 =?us-ascii?Q?3rg+gIeMsxo8wmk8K+pci86ka4YoZyQ2cmC3xThqyZ2YT8uj0p391ZwZY1WL?=
 =?us-ascii?Q?2jurQtbcOgQGBE3PrAcgL1LU0cO3qakxHaqNNRFyTAQt4k97LtflHP1yldRc?=
 =?us-ascii?Q?Dwi1RFAaplcwoN2f7Dm2aWlSzD0/IyyPXVczZkTzGBGVTJVg1CZfAxiRf55j?=
 =?us-ascii?Q?pQH9k+plijq0hyIyqJ0COEk9vDZUnL8XKJ3QRRUSfsX1Ssf5vhFYJqXiqDMp?=
 =?us-ascii?Q?E5T9Anu0F5G3iDHTBS5rQC8U+Y4zW3hi0YyX3o/MGQlMdmcHs81dftUDZhZr?=
 =?us-ascii?Q?V4GsaltAQmaJBG1H8ZLu1usMR98QbjYM8LBnFXp+SVC9MegXTs0hjx4hvX05?=
 =?us-ascii?Q?oFhRUKtgVBECGPirPi23EkSPvx0/d82ji6fhuDo5Yju7aS084TGUQzwh9Wea?=
 =?us-ascii?Q?EBSajZ2sNFN9QSn1HgVBxZQbVMdz0sXAEzzf8UOC5rIxgMsNbY8tZk4Ofm0Z?=
 =?us-ascii?Q?p8nbNJnCx6kf6cZINum5sj4FfDZ5IPnjSOVL81qDgZumxxOH6a4nKjS3MeaN?=
 =?us-ascii?Q?Rd2HMgeH5nyDXD/NYyWPAgBmBncIWU28YbrHWpKFo0geqveAH0gOE1x13N5C?=
 =?us-ascii?Q?k6xGrxoBTihCd/+hY5C9yPU9VKrY31Hdooo69eArKLulPxYTjWaJ3MyrNDeo?=
 =?us-ascii?Q?kIUc0DdoEbHK6lr8WgonocQ2vCUzK+oKGF2xX/Dx9NPDThMrbkE68ZNknTfA?=
 =?us-ascii?Q?IkfOF2Kq5ZSM8LafRlluHA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e735a05-d95d-40d4-b904-08db61eea867
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 15:49:46.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mq3DCsTkTr7p9pfmzajKKXEd5Isd+4DJNRf8go4ht4WP66lVuafxT1K8wl2zq0eKGwxH2DtWzNHsQwRRnxYnOR/KeCfc4lFSbcVSF6q86v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7461
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_10,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=771 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310135
X-Proofpoint-ORIG-GUID: eTMsq6bh8O9nVeNvdITntDso8P-76foQ
X-Proofpoint-GUID: eTMsq6bh8O9nVeNvdITntDso8P-76foQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Avri,

> v2 -> v3: few more
> v1 -> v2: Attend UTMRD as well
>
> A tad cleanup - No functional change.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
