Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FCA738D90
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjFURsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjFURsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:48:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADE11726
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:48:02 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDAqfH030147;
        Wed, 21 Jun 2023 17:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bCoTyS1s+ML1HZZlzl7eFH90WQTG+CBVCdZsEVnpYaM=;
 b=M9eUoWiaSEEp0+GoxfPTT9CkwsZVz0Jwhakn68fEUpMaMMWDgxT6TyaacaONr668PkwW
 2g8lc/a1PklgZI/4dG4qtj7hDWDBH56iKFKtSlBt8G6K9RT6ukjmwEo9L3Mp+rZXZFfF
 JMcARaB3RN3+5TzgxBULnw0nTdaAc2tlCNqeCDNqMKsLUIAs0eeTu/bRMrqoY8aWydr0
 d2lY45wkQs/oab1kOBbHZPV+dOZJEBSxkFhJtTEtVj0RK7Pgh1szrdhLk91yS+7W4idg
 D1lJiQS6qyIJ4NxsfhNIePSaEiJ8l1LpzNeSSzlaOu8lAxvlNk2nBLo7rDHoPDsAT75F fA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93rbr4pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 17:47:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35LHFBTr008459;
        Wed, 21 Jun 2023 17:47:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9396mwtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 17:47:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJIzh4ywqE51mToHezk99tsJlNdoIpoTKYH8zjl2U+6FN4RsW+C6PXqcBrdlFahlT/HgfMe0uEFCQwRF8eCtQQM//1qA8cmF+UQ7AVnfVYlHKYYxhK0XLTk+7F2fzasx5WqeqRA4sGWZ4OG0CVnfGaK5IuoacG0/qnC81etIIE1YcOzPJt6mtCyWbQA/FBwmEJL5zXipZH+SLZtp3zP9YYWdT0EtqLHih6nm0hVqnUkIrJFKDO6ugAxoj3FDmIJM3m64mmbjkzU5pgF5ZR2T4o5/RMTauygUdeCRs3Wvpb9xlniJl85leCxxvCqvtfniSQ0J60nWxoHFqoh6mTbtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCoTyS1s+ML1HZZlzl7eFH90WQTG+CBVCdZsEVnpYaM=;
 b=lxNwmhNYj8Gd/IYpA1vS/SSjnk3DR8DM4kL5dk+95HBSAKxI+kf1Szn4TgdDOzD2ytBAh+zYHjmMgMWUemmREyAC96QT5FyKHf7nA00QDU6eJ6hdpgfqdcGXV7CtUh2DXkI4TNh0aOXNTu0Mx/DR2jXzFKUVHUher2BPRdek5u3s8esZtAM+qwvdzcfn7USiHUl7R2UlQeVPcipybQNNB3if02REUFqfQ4zWWAn7dzfSjmY47bGowmCILZUBu1WtaPuAi2/m1vRDFke/oSJNKd5WEkDBY0bfsfvoIcUOCeCZY0Zf+thrQ3sGCdQmsGrYeW2QkNgPqDE0vzBhRS07Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCoTyS1s+ML1HZZlzl7eFH90WQTG+CBVCdZsEVnpYaM=;
 b=Cugqt6QKJ+QluzIbd2vI6t5IfHHP4ekYmfKw0gWOUgwdgPwsHWPd5KaBrlnGmZfVgHfirFMMgRo20Y02qEY20pMn/IT0X5dcMGtcBUgiEyujgNg95+B29nTugjstZXp0yEIJLgtHOgnQoMhTfu/HstnnWu2Zh27yhwcWzO7C768=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CH3PR10MB7714.namprd10.prod.outlook.com (2603:10b6:610:1ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 17:47:33 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 17:47:33 +0000
Message-ID: <de72aecf-f03b-35d1-0ee8-facee0af38a1@oracle.com>
Date:   Wed, 21 Jun 2023 12:47:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 42/79] jfs: switch to new ctime accessors
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-41-jlayton@kernel.org>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230621144735.55953-41-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:610:e5::32) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CH3PR10MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ccac88-efe7-4908-5a33-08db727f9767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hiKjRplNNSNcqRioV/j135yRUl9X5XT4SDkW6ptLVLFnQk3yd0jDee39iLxUl6S4rNNy9nWLdLRlZPJ65B8OKwXFzqoVXC75C5/9bAT7hHRRyvrH0vsuhF40eSTIYkTBFfaw2sMW3GJMaODT5QfLdxCgu1UfecoLPuTmk2qbRpJpwgdaRl1JZTUjYIlvNBarnwGdErW8lWZumjhFENxRWKkijZ1/GmWbFWqD7JSn+z0/6GvG9rKyzzXIeSz6++M6tFSlR0I5MDEsmjEg4xi6iUeiE2qym77JV76Hl5rGuPYOsf0omCqeWumlKPh8RwQUXIVzjEB/aqI58ukl4pROGdQJPwRY/XvDMggdz5FHwYca72b7AxBZePJrV8vXDd0UYKvVwLnIU1EnRw6Dzp8k21VD2ZTf1zQlZ+FCmQeFaA/5c6w3jV3fjeMTnhsMSdh8tdQdzPHQu9V5wwuUeOuPqxarJ3lgE5+FPS6LQ1K5vzgnc3cXiYq1Od2a9Ey16YbpURh2hQ2hBma39BMNZGdYkxrgpmBT+NMLmTSn2iulVF4D9CmfdsMTHYHfbaVhDkkoBITHH2+X3jAocbkcMwoSkb7WLSI7vAUznoVjcVGVMnw+DuEFt0ruwBYPwh0foGz3DHySwwvtpFLFdkURV3S95w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(2616005)(6512007)(83380400001)(6506007)(186003)(26005)(38100700002)(110136005)(6486002)(54906003)(478600001)(31686004)(36756003)(86362001)(31696002)(66556008)(66476007)(66946007)(8676002)(8936002)(4326008)(316002)(2906002)(41300700001)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkNwYkhmT1VoMHIzMUd1eHJhMWxTVDJiOWNmQjQ1U2xwYXpnMXorRjFITDlY?=
 =?utf-8?B?MmRmTWFlbEhPVU9Gb0QrVzlMbVYrcE1oall1VG9RVnd2TDJRZEVUeVRyMHV2?=
 =?utf-8?B?bFZ1M3RiSnB6WldnVEc4L0FYMXBQTGszQStRZkx6SXkvU2lXNHY0MkV3MEhk?=
 =?utf-8?B?VW1hL0EwdGNyV3lJOGttMkRkeWh5dEx3WWxTRGJQMEM5NTV1S0JZQ1ZFS3VK?=
 =?utf-8?B?QU0rZnBwMmdvK2FvU0RqUXNueGljQUovbmFNVUdreVV3ZnFzYnU4aUJTMlNy?=
 =?utf-8?B?Z3k1MG1NVGk5UVo3c2ozMWFHNVNyWUlhVWU3YkZVY0c1NVZpMEp2RURVU1N4?=
 =?utf-8?B?ZkR2djVFb2U2OGViakRVWG5sc254aXlTMDlmQ0xhd2hFRDVJdDZDSVdrRmI1?=
 =?utf-8?B?bktjUFE2eEo2THhFOGxxbmtkTWFYNzdVM1hRckhna0I1dWh1dFZkRE85YXdv?=
 =?utf-8?B?Z0FCK1FwN2ZtUXRzSnhCeGdOWTVwYUVQc3plYjdvQlJLUkl0ZTgvY2JmMTd1?=
 =?utf-8?B?OFp2VU1iMU5tNGJ4WTJIV1kzakxhMEtCWVhWdHhzT3docXJZYVJ1ZlFXNkEx?=
 =?utf-8?B?UURWMGFYYVo4U01lY3JoMnoreU9vczVCTmQ1QUUyZmV0S25uQThOVEVPTmpW?=
 =?utf-8?B?NjNjT3FwY3VXWjR4Rm5VM0dYNXI4bXhYd1BVbW94Vk81ZlJQcDRnNVJRUVpH?=
 =?utf-8?B?OUJ3TEJwNzVtYWNXTnd5ZkV5MjVWMER3NXo2eXB1d2hrREZ2MzhlNHlXY3A1?=
 =?utf-8?B?V2NwNWNtY1ZWZU5EWmJXMHVPV2ZUcyttTXlXMW8veDB4NmdrNHhBd1VMbTY3?=
 =?utf-8?B?YllpcU1ab1ZZOWxRUDMrUmdrZ3J3WmtrYThnM1VFM3NQVU93TlhKQ3BXZUs0?=
 =?utf-8?B?VjZmTGVYRFJIMVllWVg1Qk9tUTFXdDFYTS9uejR6NUdpMklpV21ta2l1dzM1?=
 =?utf-8?B?cmU4OGkvcW5mM1BQVTFJbThTMElEdERvbkRCam9wRUlEVUhNd2NDQzN3NWM4?=
 =?utf-8?B?Z043NHlxNi9lSityenVmNnVWcnV0VkxvNURpRWxkcGFRM2FqbFVkMlMydmFQ?=
 =?utf-8?B?cFBKRHV1RVk2ZFpMd0NUanRBV0VTWmFaRnpCL080cWFubVdnV3ZhVGVUR2xV?=
 =?utf-8?B?cVVVY2kyV2Fvc1VrNUdxOHJpNmJscFZoNkVaNzROZTNPSUVmMFl4NWRsK0tM?=
 =?utf-8?B?T2RlTGZIdldHVktscWltOEFFNVFKU1hORHIvQzRCRDVoTzRDY0dZaDQxT1VZ?=
 =?utf-8?B?Q0txWnpaQVljWjhIbUVtYkFSNm03NEpaU20yOVh4NkI5d3U1WWtSZ1hCL2I3?=
 =?utf-8?B?NzlWK0RQY1F1bmZYZkVaaUR1aGVDcTQyRWxuNndReW5DSHQyeVIrdW5PamlF?=
 =?utf-8?B?SWhDeUlMRXhDaHJvdEJ3aHI0ZEhsK2J6L2VIZEJ3VDJLVSt3WUE0VllCem9z?=
 =?utf-8?B?a0Y4ZTYyRGFFNUw3M04xZUsrWGpPeFRBaStNYmZPVFNHb0lYcHRzUkdPZ2tD?=
 =?utf-8?B?VUNZZk5KeFBLalpkS3B0QVNjaHBVRmcwb20vWG5rY2x4L0dZb29FZG1ZZlQy?=
 =?utf-8?B?RGY5VDhXWXdTYVdKbGZENUZEYTg5bGFPR2JBMHdvTFgyanJwZDQ0VFZRQTZ6?=
 =?utf-8?B?bTdPdHAwcWpseXN1OVl4MnExZEZId0RoS3FnTHZJaldKUlVHTGNCaW9jN0NF?=
 =?utf-8?B?aDJycnE5NkNxeFV6MHNBQnorVjQrVkFqamxaUzkxTWhUcVpjNnI0UkIzTEFm?=
 =?utf-8?B?RFZMNnZ0NjhOR083VzMzaEdkSHYrcEUxWi9LNTkvcnJsSVVhNTByVU1zNFhm?=
 =?utf-8?B?UytUYzBkV3Y2RmlXYWtHTVlOc0lOK0tkYk1qb1E0WkJnYW5Ocnd3YXZHd3g5?=
 =?utf-8?B?YjBOYkoyVFFiSnBuOFBidjZBa2hyTXAzOVIvSE1jazV6L0tvQmovNXNoZE9D?=
 =?utf-8?B?Zi9NN1hDbDB3N01sTnd1czFNVjBuKzZubUZ4bWRIU2xoWW1VNG80L2diT0ZZ?=
 =?utf-8?B?NTFRN0c0c0Mzdk1NTDVTb3k2cndYYkJYcytUQVlwRVVMdWhhZHRtQkpOMmNZ?=
 =?utf-8?B?NTM5OVNsRXo5bHdBVytyTXVYekgralRqOWxVZlVrMkZrVjBBU2JRb1B6QVBB?=
 =?utf-8?B?N1o2OGN1MkRFWnhtYkhGNUE5alp0MXE3aE9VTTV5SEswZjJ6TmgyZXFxamVL?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +zG9CgZ/d3QA+NnXSk99LJasZmwvqf+9TkCksSzGqE4svdaxkBB0dlgBD/SckkSPE8dLpIOtuXBOisvJBIQws2dwNO9OKU6lxyM3u4anccg5e9DUVOQGFN9KeZQkLYkyyLjW4u0/VTAkirVYuBoyg6ul5F+iSv4yZ1GAi+pyFU9qgRVIyn7WTzwVfbpD3BfcZbaF8n0XGcn+iUGacez9LWWkk7NX2iBmymr2P352s0895OSDoGrTEDEmzcq7sVXynmUoPnK+a5ybhzb5C9kofCpi4JPGEDt3k6YXVxxwJOSuen3oknmm9noV1m75BBX74BQJa9HhnX22zPWUxPT2zeL5zb0bfvLBgFiQw02zbMVg8ly29z0TYls06m/kMX2urgwr4HXP9+JIfYzQVRlJdVk7bR8REY1l7ckjfHV/PFda8Vit7qi7o7tjj+I8PDWz4tWlur9EFIXXFxvuIv3QI4EFFqjP5TbTDzrrPqU4KWlrKg+RTdX+KTCDOYXlGFy8hz3s1rQTTU42b1hjug2fgREBBbkAg0MI69Da7DZBh6wIg4FFapiN1bQy4t1inMBo/BK+tkW73Eg8qrmUGRwyuCvOIbNRKsANehxK/jlgYbZpNHG6/sNui58PG8VAbBvHrXY156jhfk9BJtl1xIQnQt1FPBDBHjmy1VbC0ZzsE4iXj7CXdkNEVQaRCfXptG2CDMVuJajtwE9GQkfDNcXsG20ACEsd7kIIutCHlRqTqoNRuGAYGYC4QBpd8e1Nl5CLFroUG2YxLpR7NHJUP0rnro3fEQHQ8Tcv+pKS8jATiPCAGbwjQ49CsIMQwfL7VhvactmFUmfnbIzJ7++RC3/mxHjG99E6RRpIdYs7DP+lrzu9F9T7KVrQaEjPs9CryVsG7UypC7r8lWwuUealisxgGi7fCRfQXKBKDNobZLlTmO4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ccac88-efe7-4908-5a33-08db727f9767
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:47:33.1476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjc4NxXGjGN0XOfF9N8eLMoECri0yBXjUug4Mc+BpzdMK6XnirkYPxvhQsn6aGMPvhF7PLmtvTvtDgiCzL/neSwyCIp0rUw070uw6CvGjrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_10,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210150
X-Proofpoint-ORIG-GUID: q_jGnauLzIQ_5fwEQtT-6iw5n3eYGxxN
X-Proofpoint-GUID: q_jGnauLzIQ_5fwEQtT-6iw5n3eYGxxN
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 9:45AM, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.

Looks good to me.

> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> ---
>   fs/jfs/acl.c       |  2 +-
>   fs/jfs/inode.c     |  2 +-
>   fs/jfs/ioctl.c     |  2 +-
>   fs/jfs/jfs_imap.c  |  8 ++++----
>   fs/jfs/jfs_inode.c |  4 ++--
>   fs/jfs/namei.c     | 25 +++++++++++++------------
>   fs/jfs/super.c     |  2 +-
>   fs/jfs/xattr.c     |  2 +-
>   8 files changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/jfs/acl.c b/fs/jfs/acl.c
> index fb96f872d207..3cd6eb00d881 100644
> --- a/fs/jfs/acl.c
> +++ b/fs/jfs/acl.c
> @@ -116,7 +116,7 @@ int jfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>   	if (!rc) {
>   		if (update_mode) {
>   			inode->i_mode = mode;
> -			inode->i_ctime = current_time(inode);
> +			inode_ctime_set_current(inode);
>   			mark_inode_dirty(inode);
>   		}
>   		rc = txCommit(tid, 1, &inode, 0);
> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
> index 8ac10e396050..d9f708fc6439 100644
> --- a/fs/jfs/inode.c
> +++ b/fs/jfs/inode.c
> @@ -393,7 +393,7 @@ void jfs_truncate_nolock(struct inode *ip, loff_t length)
>   			break;
>   		}
>   
> -		ip->i_mtime = ip->i_ctime = current_time(ip);
> +		ip->i_mtime = inode_ctime_set_current(ip);
>   		mark_inode_dirty(ip);
>   
>   		txCommit(tid, 1, &ip, 0);
> diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
> index ed7989bc2db1..db22929938a2 100644
> --- a/fs/jfs/ioctl.c
> +++ b/fs/jfs/ioctl.c
> @@ -96,7 +96,7 @@ int jfs_fileattr_set(struct mnt_idmap *idmap,
>   	jfs_inode->mode2 = flags;
>   
>   	jfs_set_inode_flags(inode);
> -	inode->i_ctime = current_time(inode);
> +	inode_ctime_set_current(inode);
>   	mark_inode_dirty(inode);
>   
>   	return 0;
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 390cbfce391f..f32fb967d360 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -3064,8 +3064,8 @@ static int copy_from_dinode(struct dinode * dip, struct inode *ip)
>   	ip->i_atime.tv_nsec = le32_to_cpu(dip->di_atime.tv_nsec);
>   	ip->i_mtime.tv_sec = le32_to_cpu(dip->di_mtime.tv_sec);
>   	ip->i_mtime.tv_nsec = le32_to_cpu(dip->di_mtime.tv_nsec);
> -	ip->i_ctime.tv_sec = le32_to_cpu(dip->di_ctime.tv_sec);
> -	ip->i_ctime.tv_nsec = le32_to_cpu(dip->di_ctime.tv_nsec);
> +	inode_ctime_set_sec(ip, le32_to_cpu(dip->di_ctime.tv_sec));
> +	inode_ctime_set_nsec(ip, le32_to_cpu(dip->di_ctime.tv_nsec));
>   	ip->i_blocks = LBLK2PBLK(ip->i_sb, le64_to_cpu(dip->di_nblocks));
>   	ip->i_generation = le32_to_cpu(dip->di_gen);
>   
> @@ -3139,8 +3139,8 @@ static void copy_to_dinode(struct dinode * dip, struct inode *ip)
>   
>   	dip->di_atime.tv_sec = cpu_to_le32(ip->i_atime.tv_sec);
>   	dip->di_atime.tv_nsec = cpu_to_le32(ip->i_atime.tv_nsec);
> -	dip->di_ctime.tv_sec = cpu_to_le32(ip->i_ctime.tv_sec);
> -	dip->di_ctime.tv_nsec = cpu_to_le32(ip->i_ctime.tv_nsec);
> +	dip->di_ctime.tv_sec = cpu_to_le32(inode_ctime_peek(ip).tv_sec);
> +	dip->di_ctime.tv_nsec = cpu_to_le32(inode_ctime_peek(ip).tv_nsec);
>   	dip->di_mtime.tv_sec = cpu_to_le32(ip->i_mtime.tv_sec);
>   	dip->di_mtime.tv_nsec = cpu_to_le32(ip->i_mtime.tv_nsec);
>   	dip->di_ixpxd = jfs_ip->ixpxd;	/* in-memory pxd's are little-endian */
> diff --git a/fs/jfs/jfs_inode.c b/fs/jfs/jfs_inode.c
> index 9e1f02767201..5bbae1ff5129 100644
> --- a/fs/jfs/jfs_inode.c
> +++ b/fs/jfs/jfs_inode.c
> @@ -97,8 +97,8 @@ struct inode *ialloc(struct inode *parent, umode_t mode)
>   	jfs_inode->mode2 |= inode->i_mode;
>   
>   	inode->i_blocks = 0;
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> -	jfs_inode->otime = inode->i_ctime.tv_sec;
> +	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
> +	jfs_inode->otime = inode_ctime_peek(inode).tv_sec;
>   	inode->i_generation = JFS_SBI(sb)->gengen++;
>   
>   	jfs_inode->cflag = 0;
> diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> index 494b9f4043cf..405b4790b916 100644
> --- a/fs/jfs/namei.c
> +++ b/fs/jfs/namei.c
> @@ -149,7 +149,7 @@ static int jfs_create(struct mnt_idmap *idmap, struct inode *dip,
>   
>   	mark_inode_dirty(ip);
>   
> -	dip->i_ctime = dip->i_mtime = current_time(dip);
> +	dip->i_mtime = inode_ctime_set_current(dip);
>   
>   	mark_inode_dirty(dip);
>   
> @@ -284,7 +284,7 @@ static int jfs_mkdir(struct mnt_idmap *idmap, struct inode *dip,
>   
>   	/* update parent directory inode */
>   	inc_nlink(dip);		/* for '..' from child directory */
> -	dip->i_ctime = dip->i_mtime = current_time(dip);
> +	dip->i_mtime = inode_ctime_set_current(dip);
>   	mark_inode_dirty(dip);
>   
>   	rc = txCommit(tid, 2, &iplist[0], 0);
> @@ -390,7 +390,7 @@ static int jfs_rmdir(struct inode *dip, struct dentry *dentry)
>   	/* update parent directory's link count corresponding
>   	 * to ".." entry of the target directory deleted
>   	 */
> -	dip->i_ctime = dip->i_mtime = current_time(dip);
> +	dip->i_mtime = inode_ctime_set_current(dip);
>   	inode_dec_link_count(dip);
>   
>   	/*
> @@ -512,7 +512,8 @@ static int jfs_unlink(struct inode *dip, struct dentry *dentry)
>   
>   	ASSERT(ip->i_nlink);
>   
> -	ip->i_ctime = dip->i_ctime = dip->i_mtime = current_time(ip);
> +	dip->i_mtime = inode_ctime_set_current(ip);
> +	inode_ctime_set(dip, dip->i_mtime);
>   	mark_inode_dirty(dip);
>   
>   	/* update target's inode */
> @@ -822,8 +823,8 @@ static int jfs_link(struct dentry *old_dentry,
>   
>   	/* update object inode */
>   	inc_nlink(ip);		/* for new link */
> -	ip->i_ctime = current_time(ip);
> -	dir->i_ctime = dir->i_mtime = current_time(dir);
> +	inode_ctime_set_current(ip);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>   	mark_inode_dirty(dir);
>   	ihold(ip);
>   
> @@ -1023,7 +1024,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
>   
>   	mark_inode_dirty(ip);
>   
> -	dip->i_ctime = dip->i_mtime = current_time(dip);
> +	dip->i_mtime = inode_ctime_set_current(dip);
>   	mark_inode_dirty(dip);
>   	/*
>   	 * commit update of parent directory and link object
> @@ -1200,7 +1201,7 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>   			tblk->xflag |= COMMIT_DELETE;
>   			tblk->u.ip = new_ip;
>   		} else {
> -			new_ip->i_ctime = current_time(new_ip);
> +			inode_ctime_set_current(new_ip);
>   			mark_inode_dirty(new_ip);
>   		}
>   	} else {
> @@ -1263,10 +1264,10 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>   	/*
>   	 * Update ctime on changed/moved inodes & mark dirty
>   	 */
> -	old_ip->i_ctime = current_time(old_ip);
> +	inode_ctime_set_current(old_ip);
>   	mark_inode_dirty(old_ip);
>   
> -	new_dir->i_ctime = new_dir->i_mtime = current_time(new_dir);
> +	new_dir->i_mtime = inode_ctime_set_current(new_dir);
>   	mark_inode_dirty(new_dir);
>   
>   	/* Build list of inodes modified by this transaction */
> @@ -1278,7 +1279,7 @@ static int jfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>   
>   	if (old_dir != new_dir) {
>   		iplist[ipcount++] = new_dir;
> -		old_dir->i_ctime = old_dir->i_mtime = current_time(old_dir);
> +		old_dir->i_mtime = inode_ctime_set_current(old_dir);
>   		mark_inode_dirty(old_dir);
>   	}
>   
> @@ -1411,7 +1412,7 @@ static int jfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>   
>   	mark_inode_dirty(ip);
>   
> -	dir->i_ctime = dir->i_mtime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>   
>   	mark_inode_dirty(dir);
>   
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index d2f82cb7db1b..c810b98254dd 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -818,7 +818,7 @@ static ssize_t jfs_quota_write(struct super_block *sb, int type,
>   	}
>   	if (inode->i_size < off+len-towrite)
>   		i_size_write(inode, off+len-towrite);
> -	inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode_ctime_set_current(inode);
>   	mark_inode_dirty(inode);
>   	inode_unlock(inode);
>   	return len - towrite;
> diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
> index 931e50018f88..71f005bbe486 100644
> --- a/fs/jfs/xattr.c
> +++ b/fs/jfs/xattr.c
> @@ -647,7 +647,7 @@ static int ea_put(tid_t tid, struct inode *inode, struct ea_buffer *ea_buf,
>   	if (old_blocks)
>   		dquot_free_block(inode, old_blocks);
>   
> -	inode->i_ctime = current_time(inode);
> +	inode_ctime_set_current(inode);
>   
>   	return 0;
>   }
