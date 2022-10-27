Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923846103FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiJ0VGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbiJ0VGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:06:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D7E437F0;
        Thu, 27 Oct 2022 14:02:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RKH2AY001409;
        Thu, 27 Oct 2022 21:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8DNyFb//RDaX/nadeH2e9aQbI25vikOBu9Z/9j8L1xU=;
 b=HKQlbqm7WK3Xx4L93sVkXtIdcFTbhMnQES80p7dvP7JteGu1itQYvFE8A8OmSu2E5lxU
 Ze3HakboSdP/uK3G+zD3vJxWxxYYqY4YVJnAmIHQ0+OFsxCDxHQS4uf7sY5IK8219ckZ
 sm/+7av6AFQZIn2zXzv+jwtJWHQ1rEmv3qgvOETmP0n1USIb6yoZ6DYzkSdzM892kNnt
 dap9yrXpWYmdfRif3b+Zv6Jm5gBEDymg2hXkrk2Wf8YjiJ/1K0K64NkeiPEoBzVh4Eom
 0yOzH7Q7jEHJqt5SOY8lR+N5SPRxjndEDXO1gGjcX+CLbW5F7VMobL0n7wr9tbPKjzDS wA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawrue3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 21:02:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIogY3009549;
        Thu, 27 Oct 2022 21:02:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagfd63h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 21:02:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMpnRlBFOjdO6xR098L4YA5aeTKOQll2agnpm2OTtWXLCDXmcj+BOLgiNZxgjlYdXr9rrQXEQ288T8EEUdQym1HP82RlnSbYW3RwxOe2Jf5f7GPEJqOrhWyvMKlLv08rjtRypAi+2H9R+e1JOqof7GS4koKmpUqzPlD0tAMOxa/u7LxYBtJ7zJqDEKDT9cOMkhgV3kg7Y8Hvv1AFeIZGEIffBSYMnB24sYUflaNRabHP068PMi7GxhOVeIkk7JsO3xR7qeUU389OM0tNeIAbWMCoujj1OKxoV3xEJ+5vGBk2C9HuWna69XZc6X87lEIVI2fBM8k1iFIcFBPBf1iZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DNyFb//RDaX/nadeH2e9aQbI25vikOBu9Z/9j8L1xU=;
 b=aDslfheQihPOtNx5/uf09NG4p/xNUaE5q25I1DBfs8Yhum+KHoGME+niNCiEmKc3xlztahRB6XHMlmObKjx3bnTX16NBtlM+pdBIyYG/hMPdyJi5GrWCtMysGwrg0W5j829AwVN1MczjuQOiQuBpk0hoOf9+fsEB1rgODxAAqkLiO/Ec22S3VVTVkHEsnUNpo7jGt5mG+KgDd4A71eSK0MYPGQzbStd5CVWb7of799FcFpee/3EG7qrFs5XFFUDbaHrF8Wno5o7dnM6vAEo98FUWeV4zdkwtohoWE4+WYTTdgPA6JvtDPZ64wDtvB8+jkZ2K6Ktn1PJJhz8XYYEz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DNyFb//RDaX/nadeH2e9aQbI25vikOBu9Z/9j8L1xU=;
 b=pNmknPbP+Ql7uhFHkplvGaLrwqFFeoLkJq1IEPhVayS/mJ1YKhnqTCzsQ8ALz0X/EgMtSxdgLBQeaf+oIM97tl3QJx82x9FAtQmti4Q7UwscXjMf4eWrVmNA2Uf9+Q1A2ud+S657MiY/KuyGL18f4qvQCy4zxmBkMw/2U7YoyR0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BN0PR10MB4886.namprd10.prod.outlook.com (2603:10b6:408:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 21:02:28 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 21:02:28 +0000
Message-ID: <cc9faad6-223f-23b2-2fcc-4b58916d13f0@oracle.com>
Date:   Thu, 27 Oct 2022 16:02:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steffen Maier <maier@linux.ibm.com>, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
References: <20221028020026.2870104-1-haowenchao@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221028020026.2870104-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0046.namprd14.prod.outlook.com
 (2603:10b6:610:56::26) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|BN0PR10MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad4b58b-9c18-4a9a-2110-08dab85e8e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agqE397uYNUbNMPAQupnwojubS7qHsnOFVrDLnNSDu3iL/i8+nDFbE43tg+T/ZtjxNPVip5RFIkFvYitjymvJwsvvkeYIo1GoBAawainqD3fmE7Hs/o/dUxixh39jDKC498Dh8Ow31X3JX/AO6/w//QHhTRSYj8BnpsmaFLbEdqyupppsCcCQS6Rzt5uMlSCiMMG3tum2IXEuwUzmgVBD2etbRNP7joXEuJ3eGxiGS0I1lGF2tOP1qlyEPYO6pH1/JayJyvnayQpIRLDX1gWfyAn/uXLaUOd3At6190MRLc3MhNP6nFQ2YoxmtansjC88DTScz9hQQdV6E3+SOPa0fqqD019y3YquqC7wStVh2W/fEl3a5CLDLE/Sryd6wf1IQ8ZazaQ14ONi/Vdlr2lYJ1Vcw2RRM6qSDQ3p9NfHsmlHWkgxQTdSXQVJFROz4MCbqJKFn03f4L9eUkgHmaZ6hQHW1jsdvSn/vchn3h/bcCr0DbWWVrVgTYutq8S0wyyGAogNqEDUyDmPiFsmqOlfOExXQK4maWlKnqRidwEaJczYUHDz4PcsJ0MjX/27XtA3g9YrJ9HsqlnxuUpWa3ncPXdxYKdInzWwT3WBMBT6YzOrYtwPO/xM0Gcv1p+V/+CVW0U7zWoUFRPRp7+FIY3oieWviL5BoMFqslKC5Ng6Bfqu6LGrcWqo3u8q7yZGafrFlj44vUXpmFLk5VxEqPVxMU5Sk2MKs7/y0mfeZSvzofUVuSoEPN0Y9c3xRLaFXARU1EQ1J9plXxmgPSYF8mufMP7GJ2Jqx7pNNVlPKoF618=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199015)(86362001)(41300700001)(8936002)(5660300002)(26005)(38100700002)(6512007)(186003)(2906002)(31696002)(2616005)(83380400001)(31686004)(36756003)(6486002)(478600001)(110136005)(66556008)(66476007)(8676002)(4326008)(66946007)(53546011)(316002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkRiZ1FrVS9tcmkvSTJLY0FOUTZILzg0UUpXUXRhbmQxbktCdzlJRTBnU3RB?=
 =?utf-8?B?ck40R2tBWjBGMjFRVHV2MWZ6WG1lZEt5VXJJYUJuNURFcUZTNFZBYVIxbGxo?=
 =?utf-8?B?KzBjUWt2OVR4TXJVODNHbFhXeVdwZmFid21xTGxsbDJqblRhYkE1ZFFSQlBH?=
 =?utf-8?B?ZEhwc0hkYzhCaTFNWHY2U0s1R1JGTWFUd0V5Yy81cmFCenJhRkxaNTVLTVdT?=
 =?utf-8?B?bVJ6RHY3WFRSMDEyUFZZa01zNXR5a1BVc2tpNTVtY3lCWlZQbkFHcWlubHRB?=
 =?utf-8?B?dHdPVzFkR3JQdzRyV2hZUlZyRUZVNlhLV0RINjVtK2VhVzN4WDByb2M4N3Fu?=
 =?utf-8?B?S3lOdW1ETmVMTXR2WlZyRlJzRzJpbzNmalVRK1dHdHBIMDNITXIvcENud3Rt?=
 =?utf-8?B?dERYZTlhVnNicWM2TDE2NS9tRFphK3RYenRTWEpYcXhlenp0cndONUx1Ujdk?=
 =?utf-8?B?SzBldGYvM2NEVlViRHl3M3dxUU5YQ3lNZjBZaHR3OXVLVjhYeU5pWVl3WG1W?=
 =?utf-8?B?Ui9xdXFUOEU4K3k3bHhiVm5ZSUxaZGluYjhManlVR2pXbElZVFhVcGUzM3dh?=
 =?utf-8?B?SHZuL3k1U0c0UnBtU1RmeXo1ejVpcmxsQ3dhT3FLbC92R2RBSnRRdFpBbFF3?=
 =?utf-8?B?TkNYaGNuOEo4ZzlTMElUbHRtcnU5aTRnVGoweVBRT3pzdUZSSDJiSEdPK05t?=
 =?utf-8?B?U2djd1dYOFk2YWtRZlY1VVlkT1BwTGVEUjRYSnpFdVIxUEl4K2dwN2k3QUxs?=
 =?utf-8?B?bUVtbGJLTytSdTZqRDlKNUw3ejcvZFdZY04wMnkyMG1BdkhlWjFVUFFQcFdW?=
 =?utf-8?B?U3dkbkltWXFVY21tRkM0UkdqS0R0SVpGK2I3bWRpR2xMK2RXd3BaUkJjNnRs?=
 =?utf-8?B?TmtOam5Qc0ZHajV5ZkZtZG9TY3RlSVZUb0Y5YVdnUXBPbEJlV2xDNHQzbnU1?=
 =?utf-8?B?RVdKcGZCWVVsRnB5ZGJqaUEwZHU5QjV5c1NyV1lFY21ITUFmeWZuRVNFWjJT?=
 =?utf-8?B?WnYrbjMwWXVSYUhZSktPNll4TTFtTXJ0cGJoSHQyd1NMaVRxMEdwb0ZIOTZ5?=
 =?utf-8?B?ekI3YklWZi92OXIzN3NqWUhYcnMxOHg4VXN3bStDVXVZMzdKZVJqZkxVbUZz?=
 =?utf-8?B?SWUwR3c2UjQ1R3dkYWkwTU5xOVJXaTZ3UEc2Z25aOHV2b0Rvbkt5RlQzRFRp?=
 =?utf-8?B?UVhORGl4VndkSHkzZkFwWmRCVENwWVpGempPNTV4YmpQMS9xL00wcTdyY05s?=
 =?utf-8?B?U0grNnZvd01paXNrTFFNekl1aXVZUi9ENkdDSXRJWGh3OWtrNVpMeUZHVzJT?=
 =?utf-8?B?REtXczVVNlNnUkdrUitkNWh2MG5YdUF5c3M5bnhtOS8rNUdObWRrUENjY01m?=
 =?utf-8?B?azZlSXpiWmZrYXBJNWFEY3ZnQ2tFU25ZRzJjQWYwV3BmR2N2dy9lZ21lSjM3?=
 =?utf-8?B?V2V3QllFcHB4UG9BSi80ZGhJekU4R1lPR3NGcmdXZ1VRRUEwcDlXWm9ianM0?=
 =?utf-8?B?cXRZWWY1eWxSMXYzU3dWT3J0NFUvWUlIUGVBTjJBc1UvRUxmV3oxRUMyVVNX?=
 =?utf-8?B?aU5hQ0p1TnlkQmdKdW9WeG1zOVVXcmRQMWlYWXJkNXBMc0NxRE1QRHdybkEr?=
 =?utf-8?B?K2hESFlhTG80dFd6ZmVaYm1DMkxyMmNPOUVYSUdHV3VLR3VlWjFNcGJ6aG5a?=
 =?utf-8?B?SC9UcEdvM0JDS2xkLzlzUVJxa0d0M2lDNkF3NHI2U1FDN1FVVkhGYWlMdG13?=
 =?utf-8?B?R0dGYmlNaytBOWo3TWFBeFZkdjFWUEhzbGthcjVIZUhGZ0d6ancxTk1vN2NJ?=
 =?utf-8?B?UjArVUdtZVhianppUEsreEViVURkSzBsdjlha1Jncmx2VmpJaWpYdjRoZEtk?=
 =?utf-8?B?R1U3dlh4TTEvRTBOb2NXSEFKRGdIY29zeWJ2YWswb21ZQzgxL0t3T0dOamJF?=
 =?utf-8?B?ZjAvc0RIZ1YxY3BEVUNzUUlqelo3MnNmNGRuSXhtT3JZb3p3VU02YVpVNWUz?=
 =?utf-8?B?VVVUN3JkYnluMmF5MHdTQU5oeWNYVkE4eGZGbXJpYXNFc2M0aW9odjQ1T282?=
 =?utf-8?B?OTFYak9qUXhwdWR6bmFBamd1c2hlN1NJWmVCTjNQaVBTWGJFc1h5MUF4Zk5a?=
 =?utf-8?B?N0I2ZVJZRU9TWVFEUHdNVllBaSsrcWJTNWZMZWlsNGozMk5wdm1DRzNFTkV0?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad4b58b-9c18-4a9a-2110-08dab85e8e6d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 21:02:28.6205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jp6MUZEwFnoiYzQi7WyW4qjlP3Z2I6y7XIa+jds+6agj45a8npGxRjHEwjb0k53eQjzgXgf3WPUu2pRh1/uJm+ooYAhvlUgudm3i0z9JQkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4886
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270118
X-Proofpoint-ORIG-GUID: Lq-enJPh4m9FYvDd7IZvUaHnMKZHJ6fq
X-Proofpoint-GUID: Lq-enJPh4m9FYvDd7IZvUaHnMKZHJ6fq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 9:00 PM, Wenchao Hao wrote:
> @@ -1779,6 +1803,7 @@ static int iscsi_user_scan_session(struct device *dev, void *data)
>  		goto user_scan_exit;
>  	}
>  	id = session->target_id;
> +	session->target_state = ISCSI_SESSION_TARGET_BOUND;
>  	spin_unlock_irqrestore(&session->lock, flags);
>  
>  	if (id != ISCSI_MAX_TARGET) {
> @@ -1899,6 +1924,7 @@ static void __iscsi_unblock_session(struct work_struct *work)
>  	cancel_delayed_work_sync(&session->recovery_work);
>  	spin_lock_irqsave(&session->lock, flags);
>  	session->state = ISCSI_SESSION_LOGGED_IN;
> +	session->target_state = ISCSI_SESSION_TARGET_ALLOCATED;

I think there are 2 issues with setting this to ISCSI_SESSION_TARGET_ALLOCATED
here.

1. We allocated the target_id in iscsi_add_session so it's weird to set
the state late above.
2. We call the above function when we relogin, so it overwrites 
ISCSI_SESSION_TARGET_BOUND.

I think we can just do:

@@ -1785,7 +1785,12 @@ static int iscsi_user_scan_session(struct device *dev, void *data)
 		if ((scan_data->channel == SCAN_WILD_CARD ||
 		     scan_data->channel == 0) &&
 		    (scan_data->id == SCAN_WILD_CARD ||
-		     scan_data->id == id))
+		     scan_data->id == id)) {
+
+			spin_lock_irqsave(&session->lock, flags);
+			session->target_state = ISCSI_SESSION_TARGET_SCANNED;
+			spin_unlock_irqsave(&session->lock, flags);
+
 			scsi_scan_target(&session->dev, 0, id,
 					 scan_data->lun, scan_data->rescan);
 	}
@@ -1972,6 +1977,7 @@ static void __iscsi_unbind_session(struct work_struct *work)
 		goto unbind_session_exit;
 	}
 
+	session->target_state = ISCSI_SESSION_TARGET_UNBINDING;
 	target_id = session->target_id;
 	session->target_id = ISCSI_MAX_TARGET;
 	spin_unlock_irqrestore(&session->lock, flags);
@@ -1983,6 +1989,10 @@ static void __iscsi_unbind_session(struct work_struct *work)
 		ida_free(&iscsi_sess_ida, target_id);
 
 unbind_session_exit:
+	spin_lock_irqsave(&session->lock, flags);
+	session->target_state = ISCSI_SESSION_TARGET_UNBOUND;
+	spin_unlock_irqrestore(&session->lock, flags);
+
 	iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
 	ISCSI_DBG_TRANS_SESSION(session, "Completed target removal\n");
 }
@@ -2061,6 +2071,7 @@ int iscsi_add_session(struct iscsi_cls_session *session, unsigned int target_id)
 		session->ida_used = true;
 	} else
 		session->target_id = target_id;
+	session->target_state = ISCSI_SESSION_TARGET_ID_ALLOCATED;
 
 	dev_set_name(&session->dev, "session%u", session->sid);
 	err = device_add(&session->dev);


then in userspace we can do:

1. if have conn in sysfs
	if session->target_state == ISCSI_SESSION_TARGET_ID_ALLOCATED
		if conn->state == ISCSI_CONN_UP
			/*
			 * we did the initial login and did a ISCSI_UEVENT_START_CONN
			 * but crashed/restarted
			 * before we were able to scan.
			 */
			sync session and scan session
		else
			/*
			 * the initial login didn't happen so
			 * just cleanup the kernel. Note: we could also
			 * finish setting the conn up but it probably doesn't
			 * come up enough to do this.
			 */

	else if session->target_state == ISCSI_SESSION_TARGET_SCANNED
		do normal sync
	else if session->target_state == ISCSI_SESSION_TARGET_REMOVING
		wait for state to change to ISCSI_SESSION_TARGET_UNBOUND
		or setup session/conn in userspace so we can wait for
		ISCSI_KEVENT_UNBIND_SESSION then cleanup session/conn.
	else if session->target_state == ISCSI_SESSION_TARGET_UNBOUND
		cleanup session/conn based on their state and what's in sysfs

   if no conn in sysfs
	cleanup session


If we are in agreement, then you can take my code above and merge it into
your patch and resubmit in one patch.
