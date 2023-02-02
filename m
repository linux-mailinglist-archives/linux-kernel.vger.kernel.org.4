Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418D8688AC5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjBBX0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjBBXZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:25:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3218B402E0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:25:51 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDptT011682;
        Thu, 2 Feb 2023 23:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=NVI9n3wRMTF3PwKDZPp029bLGiu+10kh9Uu4OdPW4rY=;
 b=t8AzcrewjwtPJ+QoyyASuneLQ71/otkRHCGBG5WNAG2awiqYlc1PS4d5p958L91WPKP9
 2JFZ2KnhKB559j1852l6vWld+ZFcBjvHLFiNl5vza8HMAO4I/N9ycOXB1E7icUABEvE5
 +LmqqY5HQo6ilHaUJvaAPjplZmxnvConPUufUeMU52hCZSElCx+5CtsibfTxKPgJXr40
 iQjzB474EDy8F5mnARbpjxmezRs53u4j7toRaiFb2582oNT535mmvpWKbeqM/FGA9Dae
 dJvbyBWaUwGJt+prW9Lo556Oh5ZV2OZtS46cJPN/V88XKYOGM4MKWAlriZmE7FsWxktw PA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfkd1vmsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312NIACp034228;
        Thu, 2 Feb 2023 23:25:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5gbb22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFgA8H5+ok70VbnDHOTecoTO9WtJtjpj7WzxqfW3fI+GHzmfpkBEWLrkvfOop8PebB2qY5E0HIYt7uyOqVZZFRoWh5qI6qbep0wODyRbY3bGxh3KL/QTUIxpxH7wFSkW4e0T062TNGhPdpPm2bRN+RzCs6M7NheKlFvmT01ljD+1MmyIZUSx/HMl/HFMmOQSDuStgfyFpo/2pzQZd6CVl064XtIQt7W5BLaUKiH+9KE2UF1NgnfSTvT7/ynZYPglJEZTaAS7UzPcb34o7J6BnXs3TeaTU/vo6ISghnQTPa/yV6NNKklv9INoWtFI8slRagLxU++vpZweLWFlJqJP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVI9n3wRMTF3PwKDZPp029bLGiu+10kh9Uu4OdPW4rY=;
 b=bcDN7HIufDyRtUNzCbj/Ql3jtfY1zmLeH2djv+6lmNwThn7g6bxugCTJ//XrifcIV5k4Oe4mejSpFOuMcDBKud1YQcCB05DQeej7HL+qEQdKdX3AWlT+9JKw8UNTbnksB9z3ptja/qrrz5yulqPioRTYQurbrTyFeikBPrb6dloxewhL1PCdBG97mqBxgX7wgt3e2CjM/LKkUZGyC6ypYKFYES2xDZFB98RkfqRx4euPzzFtCBlSFTlkzAwRDlW1KBf1xRLs3ZK7myH+Q2OCqldmA4ClgbuiOEQOTrrM1604EKr2IkOTzpoZKD9EfMns8YZWDTzB2NyorJSNpDRlCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVI9n3wRMTF3PwKDZPp029bLGiu+10kh9Uu4OdPW4rY=;
 b=NrD60xszBsiOtGGSJwheXRDlLTxKFe8K4Ad3dzLgDVJYqgFoL2uDM5cezhvpQVm6ptmnSVR1s783QaNnG33zzgtOGiifkva0MwH505QHoT21Ah9Z+Zi4TN3/Nqpz84OOKkKmRU4STMt0i4mIZaysr7oJPXBjd0hsqC/Kl7ZkaM0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN7PR10MB6643.namprd10.prod.outlook.com (2603:10b6:806:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 23:25:36 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6086.008; Thu, 2 Feb 2023
 23:25:36 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Date:   Thu,  2 Feb 2023 17:25:17 -0600
Message-Id: <20230202232517.8695-9-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202232517.8695-1-michael.christie@oracle.com>
References: <20230202232517.8695-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0029.namprd19.prod.outlook.com
 (2603:10b6:610:4d::39) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|SN7PR10MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 186fe998-3031-47a7-9cc5-08db0574c9bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0DncmRRvlaEBs8txXpfwEUh+48/+gH2f2Uu0TpoMQIkWNf6D0UyHaODTnEEC9TE8VNdTHh6Z+hDePJKFFyUax+Cq/ekp0SotKAunkYin2bSLNzj5Lb+1A2JSHIPwQ8jo3jfBoeAlDdt7ao+T69GyMc9YPFu1ztcRPXpWb31E8/uM0MZPFgyzh7/waxzSuyxH3DHwro4w68kjUdiGX4TIMNWq1oQdWXQihs1hPjMCTOWh7GTS8wOCMlQ+gO5CjShGiewvbw3iwh5SaKPNqZsshMNWv6XHIvIURRmwRpr/ddy5A5LUwraOb+875KALUXg5VPhhuUWDJMFCnRk9q0DkP0C/xDFjqd+4weepgeC2VzECMVhvv7JCHQiyS/p0gfd5x4zzLAvMiZPvqsQwsLZiS1/L79Wf8GX0TfPUvpo9/yKlz0D9+FKk+4bSan+74AlWblXz0uSg39FJKAnhL+SYhTU3bwL2WOkmQ7ykzRwQdmEKN++RGJgDMZo5NwuLNheR67gZyJqpku/TsDwdENMXtca9N7cHemV0xNYp+J/tZCXzbGBSoMIMptCc774FZKDd3qaMcctqY36Ig48dU50DwrpJz4/Ko9VzMn6DLKc2e4di7CGkl8QWzscec4NzH085nY+1Jnonfrt1jyKEO7yxIFhg+tC+2iRPyd6o0V7YNVtj0EZduRn9G5MvneoB0m9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(2906002)(38100700002)(36756003)(83380400001)(316002)(6666004)(107886003)(186003)(6506007)(26005)(6486002)(8676002)(478600001)(6512007)(66556008)(4326008)(921005)(8936002)(41300700001)(7416002)(5660300002)(86362001)(1076003)(66476007)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2UwPNPecdO8QanTo99gPAFatO+G0TbjWcHLpNGo3X7BGKi01wsFf0R5N4E1r?=
 =?us-ascii?Q?rLVkxVHBR2RWSfqEicu3s7BekcnJvWkjUsiR0afJ2iyr1sZw1Im+B5Y459LE?=
 =?us-ascii?Q?iCpEYctijOiHry0K/lOEZuBrrFFVJVI8+U8BJkCCi37d3B/uGoqekiL0agmb?=
 =?us-ascii?Q?R56kCLXJ1YQ4joVPJvEB6cSp2mxcLeKcbwtd0OPc1GdXJ2GKT94wo22bbVY3?=
 =?us-ascii?Q?oKnhlQh7e6p5JxvuLXzN3YS6sEl9IojL9WmzHzAfZqDy8hh04S/l3ZhYvJuf?=
 =?us-ascii?Q?2opowtcHojdiTbeXWVnJ7SobgSWydfN6f6hTfthcF60v5g2jllR77nFr1J01?=
 =?us-ascii?Q?LQ/8oJVAgYhrTYcmAK1TANvTLXfV5PpxiqVyStIkbe5liXHOxSfIVj3587K6?=
 =?us-ascii?Q?PUb74nv5XR09qd6DfPX+cx0NWwuUZvP03IygWHaHklieHPCr+/v20pDYkcqN?=
 =?us-ascii?Q?M7Q5M02eRXj4xaOSW3I36iNNyh70IoE2OyDAApI78bFRAWtOQyuP2XraJ1LJ?=
 =?us-ascii?Q?k421g6YAE21WZ/xJyfZZzV2P5bS6dcTOTpbnaYYbXWnBacXWQAAMGPwdbzvw?=
 =?us-ascii?Q?aWQou48UiJw+hJRDqs5RClfMK9B4XcImPdeXIfXPPhrz7jc5Op5fHnkdZ9qL?=
 =?us-ascii?Q?GXdt4jMw8BHVwZOgFLggxotHb8HyGkb5AL0TBFrog2sI2xRxh4fD1lVqotPE?=
 =?us-ascii?Q?PiTAK2nAxpb9jsJTYfUQ+VQpOo6FG1PisESZyHecYLQFJcCAoh+jXP4T/kjD?=
 =?us-ascii?Q?vuY6/YpJuE5ViJ7U4hLW1C9Df0UOtxXgHHZoXO04whA1YF0lsWAjkVIobuVV?=
 =?us-ascii?Q?q/n644XVn+flA5pbjh7rtD+V1F+6goaSL4ytNrVDG5ymycJoQrxUKKhuS5e/?=
 =?us-ascii?Q?KJmqMDz899H865AXxr8dq+VvlsjqlAc5x7ZHWLmX3/I7tKCM8/cRvPw9FjaC?=
 =?us-ascii?Q?wi2qAiI9PfXWtQ282iyfr+ZNn+INZk/EYanJaPAvAjQPZTRRbAo4vE60hIGO?=
 =?us-ascii?Q?2zaxWuhwdd8xuDj5vPCttd2Kx16rVsr0H9NP52JB6W2L4HZ4z0/QUlPFfrQe?=
 =?us-ascii?Q?SZGaGodazyKZHbjGJccOKEX4fkvn4kFagYo068oPX6bV68YG0raq2jkRpR/v?=
 =?us-ascii?Q?wehAuEB1acVKosiFODjjBhKVGMrX3o47v2ucPgly+7uapkVLueJK16wW+ByG?=
 =?us-ascii?Q?6a+E9nxcb1hRgrRmJt6zd5S7UVbtsmQmshO9D0OorOG3aCuQzHE1wDLeQFGM?=
 =?us-ascii?Q?Ge8UHT2DOhyeS1pruPDCFaanhiM1Ud3T0JT8qhEWw0vNY55OQ3G3yxpLd5Rg?=
 =?us-ascii?Q?SmwSe/Amyacyg/MHXVvfz7jUB8ul67LUTl/buvHqjdZ0mufcYeGLxRuQojU2?=
 =?us-ascii?Q?29L1o9Fj35zOpZIjHaec3vMCoggXJ6iBYiaiN2rfWhEVXtPPNLDknrJmhpOC?=
 =?us-ascii?Q?xA0I9QI1in7WFXH0kII144sUHW166jEIQOFgu+I/oEUPJxAI2mBMh+6IFMEx?=
 =?us-ascii?Q?JRAnTFVH5AcTILegeYatBfNXTMMtm+5vsRuK2PC3hjSJn/wcirndyt7K3Dnt?=
 =?us-ascii?Q?8nr1NhSmEviEoCgHqD3n2odydC2a6GkKQ3TgtNwIgld3hVfQsT9cNmzP5iGV?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?IGLyCxv7KBFeDX5Bh1zhSxeNsd2foa/xxN3cdj41ZKGVHxGcT+PHhnB16oq/?=
 =?us-ascii?Q?y6OUgaTTdPWf4IMgzIh9y3Vl5XtbJaGwoT5RaT+soG2i2zH8c9zBOqp+XNP3?=
 =?us-ascii?Q?8iB8Y0jWm2ZoWYB9PEHQVe3yUesr8Pq71CIMeYwpuPPJ/jBv0ntA6kB5bhbb?=
 =?us-ascii?Q?363vEMZmGTAPhwGL02vdtKOnU4KEKMDM6h27UF5UTBguQWRd8YxJ9RheOqBS?=
 =?us-ascii?Q?HdTjMmC5tnQmEp+ufAJ13IvdeqeBtbshZK8/fjTuwI7MBiJPuYWZoBYpO4Qt?=
 =?us-ascii?Q?bg4Tp4L58qAXIRlvahjnfb2dp5liJK5Hj6UvpXbVlbKjKT+vfItvuczm4fMU?=
 =?us-ascii?Q?6sjhC3h7igpjKd+7hgQ4nPs+hZIkOlkyPP32KAK5giO6VpLaaoA6wYCKqjuB?=
 =?us-ascii?Q?7qWPf4ANSzE3WeskcFDEwRIJYzRrtqBd10sty3ATZwEmKAG8SpusksJYdTxD?=
 =?us-ascii?Q?iReiMtklZOhq0NfWMF2b+SenCbcf1mbDSjiCF5xEFeGIKd4xYPCVXkfgASbN?=
 =?us-ascii?Q?kKO9J50pV2FwowVXab3akZXBYrnzAqO3zKb2SEj/m/J92hBFQJPTYaVtwPZZ?=
 =?us-ascii?Q?w5nfcqdO5u7h/Q+3G7CTE/3blrnEcwLH4HSI58t/MhZnjf6+PLb5Gk8oFWSy?=
 =?us-ascii?Q?xoeZvWICXFOIwN0lMtqCTxklAmwMmLQ2frdje8aFzycGezErVHOkssLlcU33?=
 =?us-ascii?Q?8JXLYvyg9zB170Oy3Y3FAUWaXOtGKpvPmd1DT1JBRxpF8Gp4Hky4v0/HsS9k?=
 =?us-ascii?Q?PaEn6/3Os8wPgKNQg3o9ERYboTmM/0pM+CSHFgWZj2DVBgg0l0+B43i885+Q?=
 =?us-ascii?Q?eI+0M/OgsX15jCb6zHIwn6sMAqfzTgyP5mohH2kSNJafvs2xGWGBjxIqiPf4?=
 =?us-ascii?Q?kxBigj+yNjK43yNYLTPfBJ9Ci0EOjczsT+tp7sWgHhSm1kGhCTyQZ3Uu/fV0?=
 =?us-ascii?Q?kun+0U8Owc1jg7+FNRHsOUC5SPnTxhfsTi19pFQLA6wDmqbd2faz1jKkMQo1?=
 =?us-ascii?Q?KtmrQ8DAckwhTyrzP5zM/RPSJA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186fe998-3031-47a7-9cc5-08db0574c9bf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:25:36.4367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d59ARM9QZDPseBV2Ld5k6D0V0XdZAbVqSJoUqp1DahTkGVQSS5lb5PZryCrUKMdLSwsBMlWZeckrKwNZ0nJ4keTXxlBuJSyCc40w1nd4Uto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020207
X-Proofpoint-GUID: 1tG0nRXXwVRiYu2ys9edu7pgk75BL95z
X-Proofpoint-ORIG-GUID: 1tG0nRXXwVRiYu2ys9edu7pgk75BL95z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For vhost workers we use the kthread API which inherit's its values from
and checks against the kthreadd thread. This results in the wrong RLIMITs
being checked, so while tools like libvirt try to control the number of
threads based on the nproc rlimit setting we can end up creating more
threads than the user wanted.

This patch has us use the vhost_task helpers which will inherit its
values/checks from the thread that owns the device similar to if we did
a clone in userspace. The vhost threads will now be counted in the nproc
rlimits. And we get features like cgroups and mm sharing automatically,
so we can remove those calls.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 58 ++++++++-----------------------------------
 drivers/vhost/vhost.h |  4 +--
 2 files changed, 13 insertions(+), 49 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 74378d241f8d..d3c7c37b69a7 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -22,11 +22,11 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/kthread.h>
-#include <linux/cgroup.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/vhost_task.h>
 #include <linux/interval_tree_generic.h>
 #include <linux/nospec.h>
 #include <linux/kcov.h>
@@ -256,7 +256,7 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &dev->worker->work_list);
-		wake_up_process(dev->worker->task);
+		wake_up_process(dev->worker->vtsk->task);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -336,17 +336,14 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 static int vhost_worker(void *data)
 {
 	struct vhost_worker *worker = data;
-	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
-	kthread_use_mm(dev->mm);
-
 	for (;;) {
 		/* mb paired w/ kthread_stop */
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (kthread_should_stop()) {
+		if (vhost_task_should_stop(worker->vtsk)) {
 			__set_current_state(TASK_RUNNING);
 			break;
 		}
@@ -368,7 +365,7 @@ static int vhost_worker(void *data)
 				schedule();
 		}
 	}
-	kthread_unuse_mm(dev->mm);
+
 	return 0;
 }
 
@@ -509,31 +506,6 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
 
-struct vhost_attach_cgroups_struct {
-	struct vhost_work work;
-	struct task_struct *owner;
-	int ret;
-};
-
-static void vhost_attach_cgroups_work(struct vhost_work *work)
-{
-	struct vhost_attach_cgroups_struct *s;
-
-	s = container_of(work, struct vhost_attach_cgroups_struct, work);
-	s->ret = cgroup_attach_task_all(s->owner, current);
-}
-
-static int vhost_attach_cgroups(struct vhost_dev *dev)
-{
-	struct vhost_attach_cgroups_struct attach;
-
-	attach.owner = current;
-	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
-	vhost_work_queue(dev, &attach.work);
-	vhost_dev_flush(dev);
-	return attach.ret;
-}
-
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
@@ -580,14 +552,14 @@ static void vhost_worker_free(struct vhost_dev *dev)
 
 	dev->worker = NULL;
 	WARN_ON(!llist_empty(&worker->work_list));
-	kthread_stop(worker->task);
+	vhost_task_stop(worker->vtsk);
 	kfree(worker);
 }
 
 static int vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
-	struct task_struct *task;
+	struct vhost_task *vtsk;
 	int ret;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
@@ -595,27 +567,19 @@ static int vhost_worker_create(struct vhost_dev *dev)
 		return -ENOMEM;
 
 	dev->worker = worker;
-	worker->dev = dev;
 	worker->kcov_handle = kcov_common_handle();
 	init_llist_head(&worker->work_list);
 
-	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
-	if (IS_ERR(task)) {
-		ret = PTR_ERR(task);
+	vtsk = vhost_task_create(vhost_worker, worker, NUMA_NO_NODE);
+	if (!vtsk) {
+		ret = -ENOMEM;
 		goto free_worker;
 	}
 
-	worker->task = task;
-	wake_up_process(task); /* avoid contributing to loadavg */
-
-	ret = vhost_attach_cgroups(dev);
-	if (ret)
-		goto stop_worker;
-
+	worker->vtsk = vtsk;
+	vhost_task_start(vtsk, "vhost-%d", current->pid);
 	return 0;
 
-stop_worker:
-	kthread_stop(worker->task);
 free_worker:
 	kfree(worker);
 	dev->worker = NULL;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 2f6beab93784..3af59c65025e 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -16,6 +16,7 @@
 #include <linux/irqbypass.h>
 
 struct vhost_work;
+struct vhost_task;
 typedef void (*vhost_work_fn_t)(struct vhost_work *work);
 
 #define VHOST_WORK_QUEUED 1
@@ -26,9 +27,8 @@ struct vhost_work {
 };
 
 struct vhost_worker {
-	struct task_struct	*task;
+	struct vhost_task	*vtsk;
 	struct llist_head	work_list;
-	struct vhost_dev	*dev;
 	u64			kcov_handle;
 };
 
-- 
2.25.1

