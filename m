Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99CD610597
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiJ0WTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbiJ0WSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:18:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F24B14DF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 15:18:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RKSp6R030275;
        Thu, 27 Oct 2022 22:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gGavQv6wOz8eNQcEMoJMvq3XGaFRMEvMyhKKJdlxsBk=;
 b=cXZCqDG6DfFji8n34LxNBS0q3Dj8gRvvLU8JyEw08c46vhYWR+mQCylGAP1qQwgPVepx
 7wH1SUD7W/01mSX+LWuLWgk7XJc5knp4aHjIWO9mXApLgYKK4HfYYhPtKKNTYXjqH9OP
 5Ct+Twd3i6EgbFf7f6DKgxYZ2LkG1fYw2xRC7Hi/EU9jIhYfXeEK1w1UlWOyR8lqw7fX
 likUIZSV5suOexjZU7S/kmyF5/bxfDgZPNCUiKwzyweJCsP9FPd3j3M2B52sLDTfuYkH
 FK5FbqfsgarIwZM83mygGLJVrMUB30JM/oKNXxNOeaolS3GYT5wE2AX1UiHvz4mWpLxd iA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv3nut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 22:18:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RJ0ACF006671;
        Thu, 27 Oct 2022 22:18:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghemg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 22:18:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu93D3mZfddbQXEIJRgvs3ASVEJ+iLbwxqYL2u+FQcDaTKk5xXJvMYRs5omSm5emzViTwSEbAEKbEdbooPeDT3eTsjYM5qyNFQggMOIOWyT2O3ZZcaPUEmqLqaCqUyjb67qSka8KKHJvkqYawFTNRK+qLGCg7Ax91lLqmwQOHm+EFeWqidxic92NHhEXmfSSKfc+81ug290UMji+s0InZL4c90fdRQ2uUjCQJT1XSc7w/AoPdBBXu6QpQf/twwYLqVSNa+MNMoHt4ihcChrX12qfiM3qwoM2+7emuOos1ZYqlhPBfm01ncjNzbkp+DyEFtD9lyJVikAtRVmtf3BvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGavQv6wOz8eNQcEMoJMvq3XGaFRMEvMyhKKJdlxsBk=;
 b=RZ8oxi43IbEqhLkBxmxE+nMFjVVYDirHsufOJmrMkDcet0SonoTL823ntrli/CywgXkCWYeS+Gg3lwQMosfwh47xcbh/cmARET0NlYTOGqs/+89dn0zDHi9QhFFiAgwjYO/BTAC3kWfYBCeBYKO3uR//eZDVLNSPSfRusJYdQcKlXnCM8zoaCCzwI1IrFd7eopoEUNAOmiS+0EN+h9xs1n4LwlBHzvL8N6Fucc+AGPzG5hxpXgLuWVotvC29/cj6cqVjRXZclPmTeqrCYHxPivj/p2+6f0/yVuGecRXkfjJRBkogZ8UBGhhfxiHLSUIGcMsKeMMpa7rvVmAl1sAlxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGavQv6wOz8eNQcEMoJMvq3XGaFRMEvMyhKKJdlxsBk=;
 b=TjOxmO3sKPTnQWM3FSxAxayyd8ZBm4WDfjL9dBGxFXpKtuSunzgrG4nZNxF+FL65vorVqBKlSCRpa+gv0NmbfN9cdnhnBFq3ZYszB/YVvcKZcEjOvsBdERpduQIp+2wzXkq3QsIIazTAJm5eePumNODRF4eh2keJC0DRiaEMTkQ=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CH2PR10MB4311.namprd10.prod.outlook.com (2603:10b6:610:79::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 22:18:32 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::56fd:b251:fc9e:aee4%4]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 22:18:32 +0000
Message-ID: <63d4e019-8671-4f4c-f95d-acb8b2ab559b@oracle.com>
Date:   Thu, 27 Oct 2022 17:18:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] jfs: Fix fortify moan in symlink
Content-Language: en-US
To:     "Dr. David Alan Gilbert" <linux@treblig.org>,
        Kees Cook <keescook@chromium.org>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+5fc38b2ddbbca7f5c680@syzkaller.appspotmail.com
References: <20221022203913.264855-1-linux@treblig.org>
 <202210241021.6E9E1EF65@keescook> <Y1beLWto/J2W1Stu@gallifrey>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <Y1beLWto/J2W1Stu@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:610:58::15) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CH2PR10MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad96a2d-ccda-4074-4f74-08dab8692e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsmzxWf69Rqof2rrkIobURq0sKGx6s6GXpEB0oV9fS7bGrHFJhJf//XPM8+8XbNMDucGHUMqwSEoDIdvbMnMjzIqiV3/wyLiWQIc7XFTZM5f8E8wXyHwnx9h1kmQJMFK+ds/XtHOPRDDQzsj2ZZP1G+JR3JXo6AGaKhBkHjc1xvnYnlAK2sdXVVJ6n87kIUDJxj7uZdasj7Jn1zqwa2PqqmFUQWCk16dMC5PEuKXQ84UjVGuMjDYs3bhhd6aGzc3Cx/wjzaGmJWgYETiuQ46LR9++OsL/dywXeVjEEcVK6/QIaBDYFCbuGoDSsjfLC816/eA3DglQdWPG6MBO64cAUlrGcGxEYZNXmozUiM83R0Ut6ZJq50EIdCVF6teUcBfxXx1guYBAmefKGjsEXHUX+5rilGR5aI3pcZiTsBraDHWD3TLm2nx4puEboSLSxO0+iNpl+OW916DfhorjHroRgbYhjxDuqDJqcrcPYJNFKJFfuGgfJxq5e+il1nofKmJdfwVjRnqsAJZWqRMoB3ZphLhTubfxKMwoEg7S3Fhb/L3709TV5HZ5Cil1PlpbdsFpVikOsjAMpLXhT5nSdLP/xcslQbqUqG1x9RRSpB4f8q8OWo/yRgDaX+Mn6xuZSXSSIVTNrMjcjx8KaQeP46Cgqe8tGNZpqCOgSojutA8lzbqSTLC7QAcdHKwYYRl8TKM/Qhwbo3ifqhg6VA9qweBjqPxkYt0pqT+gDdScBJ4x+cSL8XYkblLNPFXwBIffmB91oKoRe5lR2r8N5Og1qc0xwY/YDoSZvpxp3i8ZbjgyawZTV6gwLoQiKKrPobEC5OZmgchbobTCyOyetV1o0lNNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(316002)(66946007)(6512007)(2906002)(66476007)(26005)(478600001)(41300700001)(36756003)(6666004)(6506007)(8676002)(4326008)(6486002)(38100700002)(31686004)(66556008)(110136005)(86362001)(31696002)(5660300002)(44832011)(8936002)(2616005)(83380400001)(186003)(28693001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlhzbVNLNm11dlA2b2J6dWFhOXFhZE1UU3Q2WE0xVHA5WStFZkwwTjRzY3No?=
 =?utf-8?B?eEovZG1USnRRVnhDbUpYM0F6aXRLSWtnMWlKN2JYWnFpaGJXcVVVeEZkNFk5?=
 =?utf-8?B?OFE1Y05jcW5VMURCdm83QmNqcW9zNUc1WWpCNWpJMzM2Nm4xSEIwZGJPWEZu?=
 =?utf-8?B?di9GakdONlNQVHBBNll4SXFaaXA0UDJnMzdjOVppeGl6aXBVVmhRY2kzVWZt?=
 =?utf-8?B?S1ZzN2hWdkc4TElVTVJQNmFncjhONW5TYmFUM3YwcGk1M2tnODExZHRQTEJX?=
 =?utf-8?B?N2tiMVFsYXlzMEJJcnBjNlI3Sm0vczBCVEMreU41VXRRZ2lUMG1KYzhzdCtp?=
 =?utf-8?B?UllndUhVUlZOczBRWVNFTkN3NkZFNWJmcnhZQkxVWFBJci9wTU12d2JxSHZs?=
 =?utf-8?B?RWlhbkRpSWhHSUZQejh3YWVIOURBMXRnZWlXSUl0WGpXMURmR2k0YWlXdU1C?=
 =?utf-8?B?dktRR3pWS1VYWEtOWjRMZDVBZTRWakpUamk1TytNMDU5TGpUb3dFcmRkNzRE?=
 =?utf-8?B?OHdlTmsvYmJzbXZmS3ROeW44MlNjb0xPYkFFUWhCdDROZ01sVExIRUppQWtT?=
 =?utf-8?B?UUpRUTBYL2Ria2lHZDQ3QXBVS3ZzV1YwRXpQSmNwaTFNOWNlZ2dyQlNuZ3VO?=
 =?utf-8?B?TG9oN1pZTDBDanNHaEY1NXlrSDBkcnlkQ3NQSytmOFIxNk5CV041SlF4YXhX?=
 =?utf-8?B?cUUzUHh2dllmeFZZczZuY1hYeTJBeTk2dy9TdTFhai84azcxcUlkK09QMUtx?=
 =?utf-8?B?NjU5VDNpbXpIY1d6WGc2UzRHTXhwdzVpdzlwazhKTmZCNTZoclY1ZXdEbXYx?=
 =?utf-8?B?UWdwSjhHSGs4d2V5eTIva2o3b1ZUZklYQ3lFcHFDd0UvQm5lQkx6S1gwY0Jk?=
 =?utf-8?B?SHQrTFFwd1N4RFQ1dGFvZUpxSVd2VndOSXlWUndaYUg2MWttRkJrYlV6OHgx?=
 =?utf-8?B?T2F2ektESVVvcDNxclhiMzFreFVLcEE0QTBENjRWd0NkNzcxNFQxcjFNa0dW?=
 =?utf-8?B?ODFKYVl6eVVOWGJSbEhxc09nM1ZRbWZxZkRBUGZKWi92WW01NDJHWERYRHZs?=
 =?utf-8?B?M21xdkNyMmFBVEoxaDhoVXphVUV6NUsxV012eWJOam92czdwbU9ob2kwTVNL?=
 =?utf-8?B?YklDbUhta0xtQUNTR0FHRHh2Wm9vT21EQ3JYQzc5aHlma3NCKyt3bGEyR25B?=
 =?utf-8?B?WnhzMy9vbUdWNDZaSGdCb0dYUDFYWVF3QXZMK09aRDBkSEpmM2xIQitoaDFM?=
 =?utf-8?B?SFBJcC9NTXNyN21RUjJ2NGxmSkpMZFFJWStqNnhZT1M4Z1ljbTE1QWZNSTBG?=
 =?utf-8?B?dGdiRE84eXdyb0JVaU54Qy9wYkdJb1krNFpYNk82NGQzcU84Q1QzYzc5WlBE?=
 =?utf-8?B?bUNMaXNqRDFLaUhtbEpPRFY4cVVyakdVSjNkMFNFSVcxaWxXSW13Ly90QSt2?=
 =?utf-8?B?SXdrdDBZRXk5b0VrVVI1RWZ2T095SkpSblBZYmZ1b2M0QUxxWHZmOW9ObkV1?=
 =?utf-8?B?OWhJeThvYUQwengxOHJ3eUg3TEZPK0Y2RUUvM1JlcFpmWGtpTEJsL0I3b0d2?=
 =?utf-8?B?Q0x4MnBxSUJNdFpzdWxLWGcvbS9tV1BqVUtscHRQeExJZXRUaXVZTXZURUFa?=
 =?utf-8?B?UGZmb0lHSWRPYWs4QURqak9HWkdwL211Lzk3SmZTZFNPTGwxUGd4bllaMHg5?=
 =?utf-8?B?M2hBVUZhU1p1UFZudUt4OG9kVnpYNEFFaDFSUmlhL25FZG9aQ2NnQm9QMzlM?=
 =?utf-8?B?TGRaMlc2MDhuWmJmZHh2dUxJSnVtSW5iTE9keFRqN3ZjNHo2L2NWODAyeHMw?=
 =?utf-8?B?bmZZNXRxUXFjd3EvMkJWQzk0Q3pIVFJlWUtQdStEMGpac0pXL3FKYmh2akdT?=
 =?utf-8?B?M0w3cVduc25adUdlbmhMNURjZUR2MmxVaU1YWjRPV2hYQ0R4Yi9UT3Uremhq?=
 =?utf-8?B?b2E0NXVUWTVVMmc3VWp5ODM0OWRsQXAwSWN2YUxiMVVTYzhnMG5PUnR5RlhB?=
 =?utf-8?B?M3JweHhLUktZazdaeC8xZHVCdGJGSTVkcHVlUXBuZlNVUTVHVU1OazRTWEov?=
 =?utf-8?B?T3R4OWxQTDRtWXc2MTFtZXhVZkVBd05nSGJOQk5HUVlJYkYyUzcvTXZxaE5n?=
 =?utf-8?B?dDNLa2taaFkxeGRTcE5xU0JMZllpRXpRQ010WGJNS3ZvaXZHUDZZTjhrZkxP?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad96a2d-ccda-4074-4f74-08dab8692e6d
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 22:18:31.9151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+J5D3Y/60RNzCF9qFRtror4zrcpGHCny8cdlyisJpNghRqkE2I8R7su6TOKg+wbZ4U2CnNSKHk5yn6gvoukQPM5ErN3+B932fVgRypkXgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270125
X-Proofpoint-ORIG-GUID: anhpPFzHrkIiRfBtg9NETKxLBLLez-JK
X-Proofpoint-GUID: anhpPFzHrkIiRfBtg9NETKxLBLLez-JK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.

Thanks,
Shaggy

On 10/24/22 1:49PM, Dr. David Alan Gilbert wrote:
> * Kees Cook (keescook@chromium.org) wrote:
>> On Sat, Oct 22, 2022 at 09:39:14PM +0100, linux@treblig.org wrote:
>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>
>>> JFS has in jfs_incore.h:
>>>
>>>        /* _inline may overflow into _inline_ea when needed */
>>>        /* _inline_ea may overlay the last part of
>>>         * file._xtroot if maxentry = XTROOTINITSLOT
>>>         */
>>>        union {
>>>          struct {
>>>            /* 128: inline symlink */
>>>            unchar _inline[128];
>>>            /* 128: inline extended attr */
>>>            unchar _inline_ea[128];
>>>          };
>>>          unchar _inline_all[256];
>>>
>>> and currently the symlink code copies into _inline;
>>> if this is larger than 128 bytes it triggers a fortify warning of the
>>> form:
>>>
>>>    memcpy: detected field-spanning write (size 132) of single field
>>>       "ip->i_link" at fs/jfs/namei.c:950 (size 18446744073709551615)
>>
>> Which compiler are you using for this build?
> 
> I think that report was the same on gcc on Fedora 37 and whatever
> syzkaller was running.
> 
>> This size report (SIZE_MAX)
>> should be impossible to reach. But also, the size is just wrong --
>> i_inline is 128 bytes, not SIZE_MAX. So, the detection is working
>> (132 > 128), but the report is broken, and I can't see how...
> 
> Yeh, and led me down a blind alley for a while thinking something had
> really managed to screwup the strlen somehow.
> 
>>
>>>
>>> when it's actually OK.
>>>
>>> Copy it into _inline_all instead.
>>>
>>> Reported-by: syzbot+5fc38b2ddbbca7f5c680@syzkaller.appspotmail.com
>>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>>> ---
>>>   fs/jfs/namei.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
>>> index 9db4f5789c0ec..4fbbf88435e69 100644
>>> --- a/fs/jfs/namei.c
>>> +++ b/fs/jfs/namei.c
>>> @@ -946,7 +946,7 @@ static int jfs_symlink(struct user_namespace *mnt_userns, struct inode *dip,
>>>   	if (ssize <= IDATASIZE) {
>>>   		ip->i_op = &jfs_fast_symlink_inode_operations;
>>>   
>>> -		ip->i_link = JFS_IP(ip)->i_inline;
>>> +		ip->i_link = JFS_IP(ip)->i_inline_all;
>>>   		memcpy(ip->i_link, name, ssize);
>>>   		ip->i_size = ssize - 1;
>>>   
>>
>> Regardless, the fix looks correct to me!
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Thanks!
> 
> Dave
> 
>> -- 
>> Kees Cook
