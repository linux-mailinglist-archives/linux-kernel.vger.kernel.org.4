Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969B868CA78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 00:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjBFXWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 18:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBFXWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 18:22:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10FC24103
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:22:22 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316KDri5003911;
        Mon, 6 Feb 2023 23:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DVGTgIslpVk+8+mtyafuwfPXZ9VaGXgQC+3VT7dVeCc=;
 b=B2kJSm/cR1En9LQ1uLHbGirY2Rr2MFYjFI1LmMh5FIhD1P2tBIvSC4MboIJAAnsl0kIf
 mD0Sg4YHqhMHx4t+fWc14cnBpmU/YV6rnKTtuesHTimCc1GeJTSsDTNlXFavytmjCcBH
 jm/jdKVi4V0YtL1fhn5mOWfCYPvCbtlMkeYJRelEPgr9VssSsRSeCBkawB9FxY5vmHpD
 Hbr6OFeo6DX0FGF8zNd13DhSL+JA0utGS/Gukk7gbETQRt4mvlkLH4XhHesWggZii8zk
 5f4J8lapQ7qBRFyrub6IgQZI3703xItWYmCoPbw4AA96+GjROAJTRlSb92jO6MyTp9sI sg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheytv8qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 23:22:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 316LXujl011611;
        Mon, 6 Feb 2023 23:22:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt59gy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 23:22:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9Ew4pJLfdwG/iiehSv3j4F/su4JWRbozN9NfsTWixyZvj8G7gmGe5W17kp2k0uH+an3KSB1s2EYWnzrqQfl+zDZEYIqRSh1Bwf7u4MLdXIa4JK70ORvzV1g/GFs2SD9HnpmmZ2osLKGq8pBbi3jJFfUip7EdmicTacaMsRp/+0/hCR/40HOPJ7rlxLyM1wSugl+1vrRs0e9KaGXkNHhE/SdHEwC0VZRjYcsSltNdsj+5EXA5mPGayDwKxHxByB8E7TJpJSocYbDndkFaa5oVnVuQZ15q80Yw9GNhG4zxYyRJnjgGgnQsNvFIJqUeDZoVzytu2/fzi2TEJQNqAvaJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVGTgIslpVk+8+mtyafuwfPXZ9VaGXgQC+3VT7dVeCc=;
 b=XXLTH3pHD5BF7q8RLStS5hnvF35PYtB5KsyvG5wKZdYRG04w+aLLdUoWW6Ej+7bLvoEkHIoA69WNB/p0O2bNWiFuGB1/lvcf3XVaCqsQ1JGSU9ryrjnNDjFWidhti1r+4COCGmqkfuzGVmASt+iCKbViIUaLzvSpvsy7u9wqX307eyqcnHcT/RqwhUEBRLV19umcU84ovrkyFYJ89limTmaKeLdJXXgMGUMU+Q5avbnR7QR6lfMIpqjx3VUJLBdcGSvMfmnyQBuKmZVnkcWIz8q5rD9C7bLkwJkV7O3cBYobp9+FVl3vdkjc7BmpFl1waHNM0uV4YJ+W7qE1I7m8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVGTgIslpVk+8+mtyafuwfPXZ9VaGXgQC+3VT7dVeCc=;
 b=NljiVOdxh58YlbARODTFc3EBtm5nMIXM7KmJsdAQvaZ9z98vXDugvzaSfYl1CERKKLrGeiAREICLKsLyFBg3EU18AEY2Hofh6XrYvsoenUISz4eevIOGMFnt79dRvfbn/1HwHQPr2dxbXTETuMyYTz5GpUxyvZ2u4NpbgFQyvw8=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DM6PR10MB4395.namprd10.prod.outlook.com (2603:10b6:5:211::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7; Mon, 6 Feb
 2023 23:22:14 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%6]) with mapi id 15.20.6086.009; Mon, 6 Feb 2023
 23:22:14 +0000
Message-ID: <417def2e-dc9b-231f-bc49-52e4b8952c6b@oracle.com>
Date:   Mon, 6 Feb 2023 15:22:10 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 0/6] features provisioning fixes and mlx5_vdpa support
Content-Language: en-US
To:     mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        elic@nvidia.com
References: <1675724880-7216-1-git-send-email-si-wei.liu@oracle.com>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1675724880-7216-1-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::27) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DM6PR10MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 84af539a-876c-4000-5d31-08db0898fad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSXoZCglFu6EIaININkJaYZbBJvn2NluSeX0T7TCgX6zDcXaPa66Eoe0OFYH6KwvtxiqpTDu+OHCOpNKsH64bpucKL+umB1bovc4cMpc/m/mNT+lKYjKKeLnyYRUUkC0aw98uoq0L2ewJEUmZdDk30k7G5WnaBeWPhtmq8DEzQLAOaFJlfcaO+l0U00cfKlFRfaWYFLCq1pKz11ztn9lVEPeYJpG9Fz5GHRNFqocibvq8IACpV+IvT8LOuJdHdsTUiFVCx2P7EQHPCgWxRFVL4fdd+ZgRVt+GjgLinBc8wDKE5N/aHua8ZmwYwE6Dmzpf5qsufWsVM2W1ud1qgvFtYMmZaweKknGb7VrYpQomhIJcdfYNbWX5ks6SPca6vmfX0vbeLXGe99xpBHtzF0NnhUcJ43z4sc037LwWscyGf0GLOL3Rn02HGKDSJSJlgpe5E3/6uUj0r0NVCPgTbGWInLx37XSouRao1/mpYFYAx1qWggiU2U4ZJZeiXFXZcikEmutzhPIeTJEEfScFdUSteWi4TqWrfmjb/SQPU11E3K7DwLXsIr5soLSq59tANb92JhIAVVDFTeAewC0XySQ4BCc93BYDcsfKy/H64W6SUroxyWrH3UjYnN8tWjZvTLDCYwuEPToYGL+dSYf8uzXDND4iip4Y9tFNM1NVSmsF4xHhkjuzn5LtJrzGrDlt9H3VXk3otZByZApcYC4adKkhqTwrJ7KsKU7GIhs6ripDserkiUzuMKEIMwhjciutI9F5hGWcQMY3EPBKIIFYTsdQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199018)(41300700001)(8936002)(83380400001)(4326008)(8676002)(66556008)(66946007)(66476007)(36756003)(86362001)(31696002)(38100700002)(5660300002)(2906002)(53546011)(966005)(2616005)(36916002)(6486002)(6506007)(6512007)(26005)(478600001)(6666004)(316002)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHpyVkpiUndHTS9WeUpSZUZFeDJTbFhPZXV3SVBReFEwbW9ZdkN5dmMwazNt?=
 =?utf-8?B?Y2VCLzdEOEZPMWxrVEhrV2Q4VDh1cURuamE4SGtGSDhwUUc2aDVEVE9UR2po?=
 =?utf-8?B?ZDFLMkRTMHhtcjBpU2R4VStLL05oSjNqQks1OU80QkFFcHhCOGZvOWtDOHlE?=
 =?utf-8?B?VHJONVpFMFlLZlhBdUlwMkRSWnQrTlBkL25YOGlRT3NiYVp3UW9WUlRZSG5r?=
 =?utf-8?B?eFoxRzkzcmwxUEFWOThtMHMrcU9xVjZpZE5XWnpVT1IySU4vWjVnMGdRVlp4?=
 =?utf-8?B?YWg1YXJIQnBWRVkwWkwrZzlvL0Z2OXpJQ2YwT1lRMFNwZk4xR0NkSkFZaDFr?=
 =?utf-8?B?a2FPaVRBbkVUYVRSZk9nNTF0Z3lQRFpjRlNkUkNkeDdERzV5Yk82NmFnWURw?=
 =?utf-8?B?QjNKbGlKNER3R3RiMkd0UE9LOHBhYzAyRkZ1M0k5K1M4YlVGbjl2RjU3ckdX?=
 =?utf-8?B?elhuSWpDbGRkNWhxNng2WUhqQnVKN2dEMlVRUVBTVVNuT0poSTV0dWI4TGtG?=
 =?utf-8?B?VEtDZkpjTTYxZm5uSFUwQWQxelhVQ1g5NU5uaFU2R0ZidE9uMURyUnlNRjNP?=
 =?utf-8?B?akV5ZHdaRjR3aUh6MjlZbEliWklMRFJyeC9iaXpjd0kxcHhwTU5XWHlKK2tL?=
 =?utf-8?B?NnpQQ3VzZUtldExqeENzYm9DbnEyc0NRMXRSZG0rRk8xQnp2YWFVcDZQNGMz?=
 =?utf-8?B?ZHpLZmhRSENha2d1eFUwMktrckY4SHRmbE5YWTVjYlpMcVNIc0FqdldQeDgz?=
 =?utf-8?B?V090MVNBYmZXVFZiMmhpMU1hTE1xUHRCeEJicEpDbFpUdmJQVjlJNEkzNHJu?=
 =?utf-8?B?U1hlL0U1UVdPZWRzWE9TTHltTkJuMFhrR0Q2MEtSYWRtaENGblBUaW9BeUhm?=
 =?utf-8?B?dlFkN2d1OFJlK2xDQmRzK0kycEpCOTZ3WjU3MDBpTDV2cUU1WVJHdlBURUpP?=
 =?utf-8?B?ZWhwWHVKVzU3N0JvOWhUaUlVL2luN1J5NkNSeVZFeDFleHY4S3hLU1RqTi96?=
 =?utf-8?B?bXkzbUZrSmhkc3Z4d2x6a0dvTHJTeVdXVk9LbjZNbndLMkJIMWpxL2xqYUxZ?=
 =?utf-8?B?NEdSeGR0WkJKdzJBaUNFMHBESEV4ODJEUDR3Nmdvb1kzdGhzcWtlaDFIM1FY?=
 =?utf-8?B?WkpXWE9KMzdIcTFrSnBxOFRWbXUydEFwKzlyOUpQQTI4N3BLRGFjYWJBaWV4?=
 =?utf-8?B?RmU1U01zRWVvTDhybWpFZ2ZlU1YxVmdvTXZOUWUyYXBxSTV5NnJWSVFFajJw?=
 =?utf-8?B?MW1vTXJqTmJKbFdiNTIvejhqZUc0bVhjV2tpVGZ5RllLWW9ZYUkrODU3akZ0?=
 =?utf-8?B?dVM2V2phR1ZzVTQvemo0b3I3MTVQUVREMTdxYmRWS3Vpb2FBK3A0UlBRQ3BB?=
 =?utf-8?B?eEs5S1lVUUVURkNIc1ZYajRhMnBPeFBuakszSGsrdEREODhYL3dPVUVRWGp5?=
 =?utf-8?B?bTFEdFZkQWc3UmNrR0l6ZjBibW8zNFp5cVlvcWNldWNMY09raFdFbCtiaCtw?=
 =?utf-8?B?VjkvRWVQWGR6UWZFS2J2bXRaamdvZXFpRmxQa09xWXhoSnZBcnhLNjljL2Fk?=
 =?utf-8?B?NnFkTENOei9DZnpHRXFpNStGQWNZc05vaUVXWWdpaTQrc0h2NitUbGdmQk9P?=
 =?utf-8?B?N3Rwb25QQitya1l0cVJpaUpkMkhSeVZXV2JqRk9zNU02ejlxcG5YVkVUWEZa?=
 =?utf-8?B?TnU2aXYvdU0yVE84aFdkV2x6Qkxxcll4aGJraWhER2pBM1NNMnN2V3Q0aHpK?=
 =?utf-8?B?ZmJjNXpZbUtTa1dkUHhkc1J4d0VWWUdnMEtPVHlrUnlySU5jcjZjUmdTK2I5?=
 =?utf-8?B?bkx6ajZqQlIrVWZFVUV3bkpUYXVsSUlyZTZMUEY2aUxjaHNFUlZ1NlYxdm9P?=
 =?utf-8?B?endZWitoNTJObVdWUlg1U0RDVHU5WWs5cjNMbm5nM0kzZDZhN3Bzc2xSUFYr?=
 =?utf-8?B?WEpJUzhUVlQzRnRacEpDUGxLZ0VsT0VTaE90MjBEVDd4SjJ4c0s3ckZ3ZmV3?=
 =?utf-8?B?QThxM09yLzFBOGhZekNTaWIzcHJFSzQyRjQxbDRPcW9xVVJaUHY0QUVZSHhi?=
 =?utf-8?B?c1FQTDlKZHRmUys1cFlTcjRSTmFLQWdlbzE3bkpRdHppa2lkaElPdEJTemtR?=
 =?utf-8?Q?lKJVquhGAfoxG9zQow0h7evrm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QXSa5+TbQkdx5/GOu6jXeZ6DOSvootBoEGLH//f8RqGLvPLJj4+ZYbuKp+EIwt1Fca9eHB+iRpxJqtYAykLdMnHgFDGZkVBdtA1FMB40E9RdcUBTNmuFYdkPQq6TJJ+9886lZI0p3C8oexCvr/SSM/KjElX1Rpokxf6uJAtRSczEB/Wo/46w60whWAM0HfkdxvnTbMuGg616O+uYdxzfUdEpjHbjd6NoGaxd9vDWi3INxXQ1xHrSOqfr7w+dELtzx+lfB2Nz+vWQKbejPscD/X+6RfPf8C5kAk8I3obuFxKKdFmYIPKQwobfxtr/g1LOG817ohZykLuFsA5GE+UK9+ABabmoR1lyfaD6togWv8BdxR5sXIrf9/EqEPUpbItECDeHW+m/uqGjSVtMFpnhE4Rf6uGW4xXMtavZrr5cxQkXNwK9A48gsveOT6Orc4cbieKBSqvfrMTck81oBNAe+wcDl5OsiY4HFB54xiKDg9OPDe7yjgc6v8Jvwxi3Ho7lPj8DBw4szI8ev/7aD1UZor88N7GzdBoO5IIhkzF2aw3czNDIBUBBLYHOSci8bKqCxrQ7xHd2USU2SRudcDPtIC+JhfUMDM5zLD1tUVjHUw/ir3nb5FxvtAZzpEWp6iLqYshea28KyaiOwYTpMmm+m36AavgTEPnUQXXLuFKKGkT06eV3r9SBLn1WkZV4lGHoj2loAoH3o2HkSGz8kUD9G05sJyehSG485EKShYOpMiAMW1asQ05QvyQ+OzaoSV3elq8O+OdRcVZMNT1aYTpJpTH7yA78xBo8vNX/H4A1Djv91M+1QDI9BkbrIcZ/D1TLOgrkMlBi88jW8ayHpAwSivoLlGYoljUzuYcr4U5clM4JHREioU6VWI3km+77A7m5kWr9PCVs46OgXnJW3PZY6g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84af539a-876c-4000-5d31-08db0898fad5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 23:22:14.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lRLaxN3K2PGSmSEAQcfWXnDUFH/XVaDwLDPC+U9D5yoZCDYEdr3Rp3poBB1o8NtUz/BtKSbl/T3tnIEHUjCxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060202
X-Proofpoint-GUID: x4821si5IHLR0Q787BdDek3bSNcxWUsM
X-Proofpoint-ORIG-GUID: x4821si5IHLR0Q787BdDek3bSNcxWUsM
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies folks. Please ignore the patches posted with an incorrect 
"[PATCH v3 ...]" subject in this thread. I've resent the patch with 
subject line corrected:

Message-Id: 1675725124-7375-1-git-send-email-si-wei.liu@oracle.com

Sorry again,
-Siwei

On 2/6/2023 3:07 PM, Si-Wei Liu wrote:
> This patchset is pre-requisite to export and provision device
> config attributes and features for vdpa live migration, in a way
> backward and forward compatibility can be retained. The follow up
> work [1] will need to be built around the new feature provisioning
> uAPI, with which it's easier to formalize migration compatibility
> support at the driver level.
>
> Thanks,
> -Siwei
>
> [1] [PATCH v3 0/4] vDPA: initial config export via "vdpa dev show"
> https://lore.kernel.org/virtualization/1666392237-4042-1-git-send-email-si-wei.liu@oracle.com/
>
> ---
> v3 -> v4:
>    - rewrite while loop to a for loop per mst's call
>    - fix wording in the subject of patch
> v2 -> v3:
>    - fix incorrect reference of local variable in future patch
>    - prohibit per-device bitmask macro from exposure in uapi header
>    - add fixes tag
> v1 -> v2:
>    - include specific attribute info to error message
>    - move conditional feature presence in mlx5_vdpa config space
>      to a separate patch
>    - remove redundant check
> ---
>
> Si-Wei Liu (6):
>    vdpa: fix improper error message when adding vdpa dev
>    vdpa: conditionally read STATUS in config space
>    vdpa: validate provisioned device features against specified attribute
>    vdpa: validate device feature provisioning against supported class
>    vdpa/mlx5: make MTU/STATUS presence conditional on feature bits
>    vdpa/mlx5: support device features provisioning
>
>   drivers/vdpa/mlx5/net/mlx5_vnet.c |  71 ++++++++++++++++++++------
>   drivers/vdpa/vdpa.c               | 103 ++++++++++++++++++++++++++++++++------
>   2 files changed, 144 insertions(+), 30 deletions(-)
>

