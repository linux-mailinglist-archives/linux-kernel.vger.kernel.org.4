Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD8E6F6165
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjECWnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjECWnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:43:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D85493F1
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:42:50 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HosBH016626;
        Wed, 3 May 2023 22:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=bMpFfL660RmRGt9oa4pscrj4Gs/dqd6VgnJgCSKGmpM=;
 b=w2Yd7SmNJz2GaxVHYgeJEI5Q/bsOhly9d5wrFdFeYh9BaDijAZ16nAUDDoUZLEZ41OKR
 FvYgvYahBXoXtUwfKIfha13AEZUa3fdVRTz+gSdMmk2SDZE69i3GpfPjHvPY1agj308w
 z8+8JXWgb4O0Pl03qKEP5tuO5ligxsbA1FGEHx723Goyt2988fJNhRB3wimhBRl0TmVd
 vmYGOc8RYTw3E4U5iiLDKCev19Mrj4EzzIKa3fANjtB3P2Ys7U5j2l75yQKA1R3ZPHzv
 KKsQ/fNtfsyd0ezBptGUWa4KfmMzM8yx8+PQF5nDFkbxKF9TEn/t6A8Qdax5SzjKbFFm WQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5frj89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:42:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343LBq43026812;
        Wed, 3 May 2023 22:42:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spe10ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 22:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0V1mhmR2uXo2ybh0MQs97SJmT2h/ZmYiZh79xTQFOBjoLwBQgYzG+sBvMXYQQpMgF2ATKq1npiWYmhstrX81ghrjvER7jpztJReeI/tsiiomD/nenD7NYK0ZtebjtAy2TayAU+QqkIAn0PyBJvDyTDRyP/gMsvf3uPZg5QnWUmFke8FRD0Lgrw4rHL6qkcxtscVpdYMynlFnZRld5tnFpKqt37DIV9PhFdZF8UaP6bDLBVB2eCTMWBQdprHMnH2hzU2xQ0YGNMzW0OqKKZDPjzrsB0/Em3v6NdvKjgdoOQHyHIxBFEv0IcWD6YwDKhtv4GAGV3bJhjSQ4/9t7QHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMpFfL660RmRGt9oa4pscrj4Gs/dqd6VgnJgCSKGmpM=;
 b=Ss9CJW6/kKnb4jMRHnv3GtV4q4RsDBmsC8vMjboXVrs2ws/+wrrPSytfDX6/ttB8kXYjkdbiP2G+f8ZkEUmbFYkp/eo1o/MEoVHXdFyrnZQbxBXTqS+couDQWJjoWYT7QhL4IYSOKO1sNuAXfy6Vu2PWFcLaqte66+oPr8vH5qmlOjD5O90p2wYeDQRaRaQpSBwWwejPVsIPzRkRntvknpq3vDmF0eeZwQgkfBI9XgnKHQAJEDMRdKaVIzvF8f1DzwtmfuIePD3Pxbt4Z4mYySgHOPXzuvb9OxgdYtJkuhIF2z+f7UBMQaDNW0q5d7Q9jRsZL1XJkyd9N/LeQ3AzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMpFfL660RmRGt9oa4pscrj4Gs/dqd6VgnJgCSKGmpM=;
 b=YBhq0dQ+Nfky+xYWWv2PEMQiH24C8B6K/iNYcveKtpfDIy6hVx0FIzuy5LsyWgUCgqFX3kMdRuHHKOgVZo2LfVk16VAy+gVeXYTIYc4RW3lWoQnlN5evH/4MoFO1GWW0KuDJEnnMUa2N6Du7iNmOD3My4z8MgeR2YvjyxywVD1c=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4132.namprd10.prod.outlook.com (2603:10b6:a03:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 22:42:14 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 22:42:14 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v22 8/8] x86/crash: optimize CPU changes
Date:   Wed,  3 May 2023 18:41:45 -0400
Message-Id: <20230503224145.7405-9-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230503224145.7405-1-eric.devolder@oracle.com>
References: <20230503224145.7405-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:805:de::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BY5PR10MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be0d5eb-bdd6-4e5b-8215-08db4c27a3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBfD1A2i00nIRpUtq38KlZAqNFb/0S5+XtePr6Hkl1T3L11yN5Bdd9TyUFaW3zH0oR6nECIJD85q1JJcmG4WyWmF55ZlR1X6tOZquT3IP9s4lzzXPLyd6G2PXWssY3lPchhgn/LWKdSIh55DRIHeu5HrNQjDJnYIUk5y+JfvtdJcAp5TdvDRhcTgfZ6ydS9w8h8UjlgSOamyU2YAs/DPFD1PTVhxuBw8R7zSN2cbE/uQ4wh0YGtXtKMyLpsfCwwhTsSGKEHVdI3QaqUy5kfuh+IQRpShrfGxO45qsZgvytnMm4oB3aPK0XqZwm2mX+FqT0bHvM5g5hDUXZB2WvYuxpAo96bFD/5+UdadVaKMIVsX+WoWgpUotd7C7VSw45jWVmuAzR9Wf4zY5TUqPERn+lzbBi1NgVYePznGvOjwUlaghzo2pds03p0FrCGujWgoMd4mYGszoRIpfLGzAN3ZIgHCvQsknC39UvING2MTPJRtZ2WOzksbAPj9JFciZSj07J8P43usc+T+oJ7/AYA9kuNvzm0ykRHr6csg7H0GBmWnOJcYh8+riaTrWSkKs2Zr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(6486002)(4326008)(66946007)(66556008)(6666004)(478600001)(66476007)(316002)(36756003)(86362001)(83380400001)(107886003)(26005)(6506007)(6512007)(1076003)(2616005)(8936002)(8676002)(5660300002)(7416002)(41300700001)(2906002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d01wGIuVhby0ILFsqvLQBBYdgqly1GYIsJfSXu1APGPOHhdkPQ9z2+1zOoU6?=
 =?us-ascii?Q?NqaQrNHAiTA/qCi0Q0nC3UniXW4fz/fa6eI52AMZfW62TijUSt23lVC4inPS?=
 =?us-ascii?Q?bWcKFD+1TLQbmd5VjOHzfNdN42RbqxOqSaNfucmB/lq7cQGEQ/+J881FxWph?=
 =?us-ascii?Q?kHJGEEhOEeOhUb0ao3c7CnI7FUmw4xNx0qAolXo5iqbwTsw9uDoHcZmPv2iy?=
 =?us-ascii?Q?MdxcHdXV2fr4RcIBT+XZmqIvvP14odogs0mUkjmH1EXxD7XjgiQ7DmeU85Gt?=
 =?us-ascii?Q?1kvNXPZdRQqCaWBhfTE/GwYli4wl0qZhVV2zLhiyWmZ0Thqw1V2qzMOOSWqI?=
 =?us-ascii?Q?agdmunQYZHMf/RXC2UCXWYjg7q9K8mCZh+reiPXGDONxSsdiQB7Ofr7PKCuO?=
 =?us-ascii?Q?nUns+bZuPf3WtJ8soTUdfBGYmz3i4+2Iym1Qil6EQ/y99qGszPAficj1KmO2?=
 =?us-ascii?Q?wOI358dL9Pp4X6YHXcQ8Ryq7BkuFFByID0/wu+oRt21/bLF6d00dVbB1p84i?=
 =?us-ascii?Q?fWIIr2ut9jTZh3Gzv8waQsa45K9qI47xjT+kq8WGRoQex5SbE/1r2YylIw0O?=
 =?us-ascii?Q?ADDOMs5nVFyFsLwAeQIjzIlXDnkeejrthbVTciSXln2FuGVdqot6rjStisXA?=
 =?us-ascii?Q?r5jUy4XTIXfA4ot/yCzVzZHe3b7yxKYqFCgO9HyoSNxItqIdag6OoCnoS3Vi?=
 =?us-ascii?Q?nHiXVxLfmpJev6YtEqyy1LjmQUiJKAIEpNMQM7RsV+wmyEOcrLAdxse4bchu?=
 =?us-ascii?Q?QBp6TERXdURyxS16uk5od1ZHL+/yZ9CIvvoyBq9pSyQSp4mALPBep+iAEgqF?=
 =?us-ascii?Q?WWvytViP+BK6QZGbSsm55V3Mf7X+tOcr2skequQGl30AAD64VVM5l8k5RCpO?=
 =?us-ascii?Q?Klz05ULmhtwMJBKpAZQpci9FPzPB0O1yKRXr7GW8VcLHdq8QdONVeRBg+lqp?=
 =?us-ascii?Q?ppZowpnXZ8BTfrNXOro3jakDPUPe8/yQXa7QzF6NJWTAAmI+C/GzNuXUD1oa?=
 =?us-ascii?Q?e8GNpnHG8EVWCf3dbyUMF9O2yJftQUP7+7ebYF4lXFuN5dRRHgy7AvnSfLo8?=
 =?us-ascii?Q?nOvMpAeREoVOdgvM5RRhvr6V+cIWQHufAQllXcKJU6lHiwI/IJKn8YcB93Pd?=
 =?us-ascii?Q?hGoNqsMUGfDBYu7JNyxCSNYXts7Us2aUNfW/Zrvs9S5JtCL3UvMf395wWYlc?=
 =?us-ascii?Q?QL+oDuRBTEIS/qCxDCKO95eBy53TtT68uOZ+dWgxiVwcDVVdOUOlqZbds9Z2?=
 =?us-ascii?Q?tXmz4JhQANh4tk6IsAPr46sh3TTpZwrguuAdgTvbnn1tCLDeUrxa9ZitjQu+?=
 =?us-ascii?Q?YZsf0+DzVR4542BQ+zeRw+74DrYp0sd9YRwD2Qqt5sqWmTmpANrpna3+69hw?=
 =?us-ascii?Q?LOD7daKEjDIc7ctSTfPzXfy7pxxk6JWKu2avK5nSqmF8IXw/5Q/biCQ1YLF5?=
 =?us-ascii?Q?FzcbMJegfGLC2LfLvZOncZcQQD11LPRFic5zVyxQZ1pxVp6OGq5GYHgCNwgw?=
 =?us-ascii?Q?iqZwNwqFcqvcDW/WBaRgbJsfIg21n9YgEQhqYbV61+yFllyENt8rn9+lpPMA?=
 =?us-ascii?Q?Z2V2A3VVr1xpHGEIr3EZwYVIuzCRVY6cRZ2aWFxyyQsxVqcfSgjUXr2iYTrb?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3iXZLSkzi4lskQSfJBxbIXcz2qBPCLW9bomeN8+q/k4bEqaVZMvC0ybcDTCb?=
 =?us-ascii?Q?0S54seGw7sMK6etSEled6GqmcQ9aFccKCvXQBEL6wZ8H/b0hfCDBx2xQGoVj?=
 =?us-ascii?Q?RtQsCyKo3Je2sK4XOR+mwdS7AlBeZBmQi5z+X0Q+IqCTMSDL9praw4/G2j+W?=
 =?us-ascii?Q?ECGL8f7eRTDvfEK6FKHaL+fsbJPbIX88/Q5LEnGfbjMdhk8prkDabRUpFjQI?=
 =?us-ascii?Q?WKLoiQh9e3I2iIc83L6+e3cBDjTnkuJjxe2+SXTbE20KgQ5qwMwM45sKD7jQ?=
 =?us-ascii?Q?w0Wxgw5yOlR8QLTlZvKw1LUxlzUhA4cjJZlwhc7SQXcv1ox13XLnhDpx9VFv?=
 =?us-ascii?Q?k9hp0ZLLEPz5rlijzgZt9zIGzcT2livvRCcPeC5YJ1n8qJFLdkOOoft0HGHU?=
 =?us-ascii?Q?hONBdM0VHt58a8670bAGIGzxy4WBqzgj2IN8+eb5GTGFufGNKp1mrvGSeFzx?=
 =?us-ascii?Q?a+DEffp3ieHDG6HWOdoJjiVmZWrcoS53wZUQ3cr6X+x5oplFCEL7eKsd3cyo?=
 =?us-ascii?Q?na5r5w++RiUEzLvQ/NhX7pUFdhhFzGO/DumyuI8SmPhF9Kqukc19Q5BGByMz?=
 =?us-ascii?Q?AcgnKW5pfn5llg+XUP7kNNftOo6yqBtZ5mw4C7s0KRK6WIOmonBQyyVpV346?=
 =?us-ascii?Q?EOVR/worFJnThVFjrXU5veYG0uNYMUr9/Gspo35tx1rCAmyoQOvtofV4UBBG?=
 =?us-ascii?Q?Ql+J9PcpKn573WfQ9SLfSvFwE9K8A7uCCyGLIrzfBx9bwerkwyXs73FvYEkO?=
 =?us-ascii?Q?k+hHKm6m4bS3l+tEvLrSAeOBy4qzFp27Vkufv+D09Wx1AQUtDPPrPg08y3BU?=
 =?us-ascii?Q?8XlhItkjIjalcUxg6sj21VuQ8ncFijYf2QyxSH5V1ENTkK4zVkKbZva29fuS?=
 =?us-ascii?Q?vyqGiMKY/acZkv/QfwFgQIwwDBek2huMSX2uFaem1/7LbuXP/wxDWScuzjIK?=
 =?us-ascii?Q?bPVrM7SAcHVk0ySQdFgj/JzxbvifqsN3fk1/TvDJQctfNvA32FvdR18wjQb8?=
 =?us-ascii?Q?dHfETJ7N40VUG8xHEfK80AlchcxP/lEbn0vJhQYE8QrSbhc+4SvQMbUMOF1w?=
 =?us-ascii?Q?oRsyExxinTlrTe7zIiVViufQyrlh5uULZBN6vTSwUgkMq4+yHLP+z5ZGHP6I?=
 =?us-ascii?Q?wQucHJ/B9lnhsG+q0aQSngYxy6PEPSj0Iw5AtaOdZrMiOKLfMjVZJoE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be0d5eb-bdd6-4e5b-8215-08db4c27a3c0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 22:42:13.9606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcnmfpSDOsDWyOGoc6NmctjX2iWfD/ICBwgYRDCK9oasklMYk1C2HXvGb2lnPTqUS59Kjh6WVDkEvd6Z7JqAsHMjrs/i6tHULdaSyHjHw1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030195
X-Proofpoint-GUID: U4GJNtjxxsXBv4_BXR_TFws7zEx886c8
X-Proofpoint-ORIG-GUID: U4GJNtjxxsXBv4_BXR_TFws7zEx886c8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is dependent upon the patch 'crash: change
crash_prepare_elf64_headers() to for_each_possible_cpu()'. With that
patch, crash_prepare_elf64_headers() writes out an ELF CPU PT_NOTE
for all possible CPUs, thus further CPU changes to the elfcorehdr
are not needed.

This change works for kexec_file_load() and kexec_load() syscalls.
For kexec_file_load(), crash_prepare_elf64_headers() is utilized
directly and thus all ELF CPU PT_NOTEs are in the elfcorehdr already.
This is the kimage->file_mode term.
For kexec_load() syscall, one CPU or memory change will cause the
elfcorehdr to be updated via crash_prepare_elf64_headers() and at
that point all ELF CPU PT_NOTEs are in the elfcorehdr. This is the
kimage->elfcorehdr_updated term.

This code is intentionally *NOT* hoisted into
crash_handle_hotplug_event() as it would prevent the arch-specific
handler from running for CPU changes. This would break PPC, for
example, which needs to update other information besides the
elfcorehdr, on CPU changes.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 8064e65de6c0..3157e6068747 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -483,6 +483,16 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
 	unsigned long mem, memsz;
 	unsigned long elfsz = 0;
 
+	/* As crash_prepare_elf64_headers() has already described all
+	 * possible CPUs, there is no need to update the elfcorehdr
+	 * for additional CPU changes. This works for both kexec_load()
+	 * and kexec_file_load() syscalls.
+	 */
+	if ((image->file_mode || image->elfcorehdr_updated) &&
+		((image->hp_action == KEXEC_CRASH_HP_ADD_CPU) ||
+		(image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)))
+		return;
+
 	/*
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
-- 
2.31.1

