Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E4269736A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBOBUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjBOBUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:20:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D548D728E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:20:29 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EL43WM027174;
        Wed, 15 Feb 2023 01:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=sDKqaUwXT1wcGY62Cfv0WQkVvVtB9V4etjyorc3AOJg=;
 b=uks5A1rUYQjk71inOfBYSv0xwoTwUk/Qxi8rkQ+AzqIT9zBDAEy3J/4oERRUQmrfm1ez
 XmYHiR1KZMbhpVa5g0kPwkEB92oct0WrFQUX9UMPgigDCqvlZSupTJcYG/a2O4YrCuFf
 hSxIqgYjwlpRz2BrkjVUk+3ijxz6vGaYnPLqv5R4XBJNQldgdjWvSnU+qZTtFULU+tQF
 6d/KR8Ti66gaiN1RVqayzI1Nixgnx7PI7OHVYf7wIvJb5mF9PVr9Xttiqlz3Ra4pyC4M
 eZPIPa1sOMkkyRBm9T9qcbyWMs6K7IH2krlCqOa7hA/raZ5ctTl5o06oEs5PlT5jXCA1 7Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1xb71rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 01:20:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31F07jv9024588;
        Wed, 15 Feb 2023 01:20:20 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f6we8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 01:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqoGQPIXG2ZCwF7dyMz5t8GmZTa4COvlVjYe9jI5JBpumyLsf95vvCBO/HvCmiW5iuQrYmXNzJZYZYsvAytNRD7LwoO3Tidq+vL8JJg2kNpitgYEvkFmMmC0K365TPrdDNbuvUApn3mMv40E7shGvVpj8sDh4uH4wRApMLp/7HPgvHibPdJVnV6+6t33i17TAUz//rMIzsgxVRsbNhemWp0cVVWYVj7HrP4DIFhmv5dbYx+nsZrivKmpDzThpR4HUVPZRRmv1cq/FqA/2ocitsMXTISAeEnbR14RLF89TP57uIFoD+zezfmg1QVYxhHEq0oEXx5LsG9mh0U96wUKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDKqaUwXT1wcGY62Cfv0WQkVvVtB9V4etjyorc3AOJg=;
 b=NNh32UEeDZvnO/cYalnHb0oACM5pA4XWn6HcgIabdcplgHUSB+WkRd+d8zfoqZStOo3kyl57G+1Dci/hZyAJUGYwz9+yvN4WHf/XLIa5NdYgMC3d7Z70KHsgcbPYwojL0JIHSUFf7f1Q+KLsTlYS802jh5HSEIFxEHQjvNxOFIO0k9QtIJtZNiCyHjKOws3UKoZI/B/AMDF+Y46V6a9wkvQQDie95sjKJpI72X8iu4saIu2BtkVwZgRXLko0cHPaj/mS9QblQzNAh+QDSvOWgougGeJJqx31EMtJ203W7Y4zA8aW7DjpG01pTSbRksaxXzhTf4LjLYqjw5LqNUZQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDKqaUwXT1wcGY62Cfv0WQkVvVtB9V4etjyorc3AOJg=;
 b=W1/KJWURy94Ib89X/Gr6AmLu88dysDTYCJLSM2KRg13zOv+dsyiUQGq7+Oxw3oyNDs2Ckx6gY0PgxchimyFD7LIkZ7H3SrijUpPs4d4YWWN+x6KYNfQP12LxB2G6AYRppDZjThEP3NUqNgKSZVc0sZPfMpWvGQTzU+IWnZ9CV5E=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BN0PR10MB5333.namprd10.prod.outlook.com (2603:10b6:408:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Wed, 15 Feb
 2023 01:20:18 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::25da:8594:cf75:8ef3%9]) with mapi id 15.20.6111.010; Wed, 15 Feb 2023
 01:20:17 +0000
Message-ID: <cacf446e-4ad0-5a59-b118-1fc3632bd86a@oracle.com>
Date:   Tue, 14 Feb 2023 17:20:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] vdpa/mlx5: should not activate virtq object when
 suspended
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, elic@nvidia.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com
References: <1676328489-16842-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvCCNGeWb0DsExM+fxC23yGOwKuJ24auSujWTQpZEPw7A@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvCCNGeWb0DsExM+fxC23yGOwKuJ24auSujWTQpZEPw7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:5:333::35) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BN0PR10MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: aceb4d6a-23e9-4a1d-8b43-08db0ef2cc41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quFRTOVMbnANTO9W4xuaUfUeWyW+iw8jBfZtXSh0lMpAqloEQUfLjOP5+XDQ/j73ZE70XIn2Z7uyJl/dMo5pVBn50kQq/fq+RntNROuAcXKWj1kHmgruHcIz0/TTk+TIkUIaQYiFJ28ngdYIt/c7cwgVol4mpv6BRIF6TgSGrUw3JRYulgVKqR9wPq2OF5gL6l6RJyUPD59jzC8K2KnhsQPMYG/EIKJjb1+N2K6HQ0M3uKDQecH3/zkGHaNmIlzNyy64DzOpQfXF1SPlkR31onGPaxmNwL3yJEwW0+BjPlQlvL8Ot8pGd2gXEtRYsXBMMIoSyK7qXQXhev0BuymWbYZcB/AZGDS5satIUyXWFwb9ByjDaCo/nlrDTm6QhU8t9x6LLrEZzgKY76VxeDVJq/y3wonr68POpsXzURLOc0lC9Gv832I2xLTPZ43rUKoeYIHDGJ5Otw9jG+v9n4+0Aj1df+pkWu0M6HcN2FlxYfNnhVqgT/VnJdnuqFCuwoiG8IG00rMDZfP6twG3VXO4xVilflEfheo5TUZs8kgrzmsEjkGHQYyOdnVgcUT05Ruqpn8swaHcBoXu2tdo4HX2QxD6w8XlrEwSS/4loDZkoKpmXA4B1wlQsv//K5GIjqICXcivUJpMwjuvjpOJARmZeFxkXFta0FjviC7tJgVYs00wRK3QypY1tmN7QDR/fZi0XCFi0U5o+kRxT28jB6ZBpyxV2W3/dsruP9J5HoFpxBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199018)(31686004)(36756003)(86362001)(31696002)(6916009)(66946007)(66556008)(66476007)(15650500001)(41300700001)(5660300002)(8676002)(8936002)(4326008)(2906002)(38100700002)(36916002)(6486002)(478600001)(316002)(6512007)(2616005)(53546011)(6506007)(26005)(186003)(6666004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkdGZHo1Q1lUbGFEcEh6bjJlYi9oZ3hQY25na1kyanlJYWtLU3lrUlFVR3cy?=
 =?utf-8?B?S1RTMDdTWHZPRUFqRVlFWThmYVdXbHcyTXgwRjR1azBIU1k3TjJXZEd1cUZD?=
 =?utf-8?B?VTNXeHhrZUFjL1FZODV4QXlvdWJGV29jSGY0YmRqK2VsSEZCY0Zvd2dlVVVp?=
 =?utf-8?B?OVFmU2dKeEh6L0NXaXpaeHdaZWxIZ05vVnBMMEFIZEVac1phc0hySVZodnlt?=
 =?utf-8?B?dnVCQmhkU0VkbE5nbnJtRStTSVhjekxzRG9WK3BPQnlkb25UZ0xBeThKVHY2?=
 =?utf-8?B?K2F2dTVlaDV4TFJadGpVUjQ5QzBPdmtXUmluMlJCSmd3RkRqYmd5T0k4d2h6?=
 =?utf-8?B?MXRwdWNpTGprVUd4ZlhmRFI0WjRVdkRCYnVINHY1TXR6YW9vb1NRTDgvOWZM?=
 =?utf-8?B?Wk5mdVB3cXQzS0JMMkpEUUl3aXZBRS9Oa1R3QzArRmxNWE9OZjZMMHlzOGxv?=
 =?utf-8?B?RWZIeHoyN2FnU3N1S1BmRXdJMG1kV3luZFhrMGFOK1F2bkdNbDdRRkczemNH?=
 =?utf-8?B?b2JDWkhkbjhNUWNORDZjRXdFdGJGckJVOFFjQ252K0twbkdiMkJ0aTdMSkN1?=
 =?utf-8?B?c0l0YTAwbXFFNWNhU3JPVWF1S2JvZGs5WlNONk44STgrVWtwaUhnNXpUczNZ?=
 =?utf-8?B?QmdCN1liWkhLQ2xjL0F5TXl6RzJBNUgvQWZuMHJ6U1B3dDJoK3NIZDM4eFBH?=
 =?utf-8?B?SjJsdXQxOHpBeHdoL1VoSmNEZU04dTRaNEZoYkVlNTFLSmtjT01tRzQwWVpj?=
 =?utf-8?B?ci8wYkhpUmxaQVJZait2b3JPSDgycGZkeTBXNUhiNW0vV2NsOFN1b3dTYXZN?=
 =?utf-8?B?bERTNWhtN1BnaE9HaFhuTll0UU0zcjZITmhwb3paeFRPQitRK1FzYisrZW12?=
 =?utf-8?B?blhmYmQxNHNzM1YyYTlsYWZrTHBMeWx0SHNpUlFRdTlFZEh5bDFFL3N0ZGRp?=
 =?utf-8?B?L3hjSUZBZTY0Y0lFZjRtZlBXRkxHbkdHUXZSZ2g2Y1B1Y3BVcE9yL3ZMMFg2?=
 =?utf-8?B?Yk9Kbnh0dFZpY3crQzl1Mk9DU1dvamdDM01JTTlJazNaQjVmNkcrVlVpNHpB?=
 =?utf-8?B?WHc0ekZqL0syK3NMbkFXd2cyOU5BT25lTDNrZzlvUDBsQ2JiTzVCNml1ZWVy?=
 =?utf-8?B?bDhDMi9OdXJRMi81ZCt0Qk43K2YwL25qYW1zQVZnamdQWmkzYmR0bkJLWTFP?=
 =?utf-8?B?dUVQYTRmMFlRQkVMeVFjd1JNZXNDZG1scjVURmhwdlIrcEtvTHhTckhvR2pX?=
 =?utf-8?B?amNSblUzMG1TNmN6WklyWHVMVkFuS3M0VUlkb2V4UE54K1ZqRmplTWZKOWIv?=
 =?utf-8?B?T2FEU2V6NVZ1WXZ1NkFUMUFmYzFjVkYzUDNKakxJVDE0U1hncjJjZlp3Nm5s?=
 =?utf-8?B?OEVhQitpSHVTWnh5UlhySWxzUk56QWwzUTVrWU9XNmsrMlFWU3ZJMEVNWmpH?=
 =?utf-8?B?SGRBY21KUHdoNG1VQXVpeVIzMkttY01YaTVONHdWQjlYOHlxLzgwRjNDQ3NK?=
 =?utf-8?B?N1E0NmhuYldLVFRCbWxpZCtqdWIyWUUvb1l1RXgyTzgvL0ZpS2NxQnFwdTJq?=
 =?utf-8?B?ZGxOUFhaYytjYW84TUpKMU1OMXBjYTdpR0dvMldrV2pFY3Qvd25qTjlxSzVx?=
 =?utf-8?B?dng0ZUt5Y3J3TU5JcG5XYm1qQ1FuZzZ6MktIVHNGWEg1RVg2VFpocGcwSURh?=
 =?utf-8?B?YlBjOHFCS2NPM2hxV2g5ZnBNSlpNTll3eWd2czlQdFB2a3pla1VLZ3F5YzJs?=
 =?utf-8?B?L0NDMnlIdUFPTC9yTEVCQ1E1ckZ4UVdsdE9XRS9RbDBTSWhaSHViSWUvWGk2?=
 =?utf-8?B?dEpqbTZZMXh3TVJuOXMrck9IUStLaThrY2NJUFBPcHU2bmx3d01KZ0h4MHhU?=
 =?utf-8?B?RnRhaDRUSVFXSUZkMVBKRGVWdUNZYnVzbG9PQ2lKdnJnOGY2RC84WVdlbElW?=
 =?utf-8?B?MTViU2k1ZE41T2JRWVdDQmVZcitpNEVDT3BqWS9lcXpwdGQ3QWIrdVlobXJq?=
 =?utf-8?B?SjFhbHJhRlIvNDZXMWw0a1dmZ2g2OU1FaUtiWUgzc1MrWm9aQ25UV1FJM0NI?=
 =?utf-8?B?UUZrcENiaGtaNHlESWQrWE5leTVINjhEZnFMazdVUHFyTWs1dW9QSy9DRDZj?=
 =?utf-8?Q?vsWNY1klOL1gXRYPK4A4/RSwe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c32GDELoRcTyq5LXuVYwwP2FI8cdYYVR433HQ041b3JN7IRX791F7w+IDXcouEwdXVaeLErlcu0r4UdFb8o4lG5C1wQ95ynmUCnKPKBhMXj0d7bv65Z9RjKji6RzOHwkDG1I1lkBwGTGR9C6qSENxNKoCUO0xKeLk2ALZL0a5JMmT2wiGe35x/vVsCya0NRxdksD0dDcYrnhtQdKLsKU0hqOJAgQ6bt/+oo0488XW1xwaGERo/FOvpf0b4/DVXaFrY2aTJ9w/XIpUNagYAn+HcvPbyY2kmHtRiku0FvXAjGH1VNdFYP9G11zJjBlVBhM4MRs476bSz8VfRpHn2qk3qPhNT9OoyGKclqtyywkwh8HPURu/aLxmX0x4uw3ta2Y9MYxxcHQldWRKr/Hoz3ivXuGW/fQDNuZnrzb999gLkgy2NhF9ZgO3ExyQrACmV7nFfgCn5lMYLbXMSQIx5vABqZEKjUF7YwgnkM1YlLYZCcAkXM6vj9qNcs/Qa/j6Li8KBPRNmWW/oBOpRsw2qu9c9B9aKz5/TnVC3DliqedQPrW2wV3HuGG9SJc51j1diebd9j6LSUnITq1GRkfAxfIOt+2YI4l9QO4dZwcKJZeckfvBgssv3qh9VVfAFM9bWhDIKS6ny7S0bILRwwBo7B/kc9UWtF/Sf7gF6jj6BAkwaFIfGOgUKamQ1pq62UM1BFkR9rdIDvNRvHVrnz7GWb+j60+Tgez86HzCW/QbyGsu2X76n53QejUqw1y3AaF9X/OTl7PI2kDhJMN61+Q/iqumGATwSYCdCU5+bh/xPv/EnlJjRvBI2rRuMQVPoDkBQic7/Du0nEQ+gd2ZvPlqadRWCq0jFKPSNqWavM/ehcLhxTswlFeUn7fZ6VYnLJq9u4gOYop2Ya1ihfV7njDM+RfkQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aceb4d6a-23e9-4a1d-8b43-08db0ef2cc41
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 01:20:17.6341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nehM3/SpokpkhkbIMJDPmoRo2XJl3GtXR27Tc/gMS9rLECTbKQsugkvZQF5+4HE8VN8TmtNePkmaekUyDeDK1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_17,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302150010
X-Proofpoint-ORIG-GUID: msJckaLrQFUVVtZXF82GkgIvLT-kTPkV
X-Proofpoint-GUID: msJckaLrQFUVVtZXF82GkgIvLT-kTPkV
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/2023 10:20 PM, Jason Wang wrote:
> On Tue, Feb 14, 2023 at 6:48 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Otherwise the virtqueue object to instate could point to invalid address
>> that was unmapped from the MTT:
>>
>>    mlx5_core 0000:41:04.2: mlx5_cmd_out_err:782:(pid 8321):
>>    CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status
>>    bad parameter(0x3), syndrome (0x5fa1c), err(-22)
>>
>> Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
>> Cc: Eli Cohen <elic@nvidia.com>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>
>> ---
>> v2: removed the change for improving warning message
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 3a6dbbc6..d7e8ca0 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -165,6 +165,7 @@ struct mlx5_vdpa_net {
>>          u32 cur_num_vqs;
>>          u32 rqt_size;
>>          bool nb_registered;
>> +       bool suspended;
> Any reason we make this net specific? (or is it better to use
> mlx5_vdpa_dev structure?)
Yep, I can make this change, suspend should not be net specific.

>
>
>>          struct notifier_block nb;
>>          struct vdpa_callback config_cb;
>>          struct mlx5_vdpa_wq_ent cvq_ent;
>> @@ -2411,7 +2412,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
>>          if (err)
>>                  goto err_mr;
>>
>> -       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
>> +       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || ndev->suspended)
>>                  goto err_mr;
>>
>>          restore_channels_info(ndev);
>> @@ -2580,6 +2581,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>>          mlx5_vdpa_destroy_mr(&ndev->mvdev);
>>          ndev->mvdev.status = 0;
>>          ndev->cur_num_vqs = 0;
>> +       ndev->suspended = false;
>>          ndev->mvdev.cvq.received_desc = 0;
>>          ndev->mvdev.cvq.completed_desc = 0;
>>          memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>> @@ -2815,6 +2817,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>>          struct mlx5_vdpa_virtqueue *mvq;
>>          int i;
>>
>> +       mlx5_vdpa_info(mvdev, "suspending device\n");
>> +
> Is this better to show the info after the device has been suspended?
I'm not sure, the current convention of this driver (for e.g. 
mlx5_vdpa_reset) is to log info at the function entry to inform some 
action is about to happen, and log a warning if running into any 
failure; otherwise if no subsequent warning but other logs following the 
info notice, it means the action has been successfully done. I thought 
at least there's some value to log at the start of the function just in 
case it's getting stuck in the middle.

Thanks,
-Siwei

>
> Thanks
>
>>          down_write(&ndev->reslock);
>>          ndev->nb_registered = false;
>>          mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
>> @@ -2824,6 +2828,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>>                  suspend_vq(ndev, mvq);
>>          }
>>          mlx5_vdpa_cvq_suspend(mvdev);
>> +       ndev->suspended = true;
>>          up_write(&ndev->reslock);
>>          return 0;
>>   }
>> --
>> 1.8.3.1
>>

