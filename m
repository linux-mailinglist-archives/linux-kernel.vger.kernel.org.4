Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25A75B8718
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiINLPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiINLPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:15:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B5E1146D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:15:07 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EAx9ps032403;
        Wed, 14 Sep 2022 11:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IYTkPP14eqvfD3BTzmXyBO8b2Q0SWnxvww8y+0/4QKk=;
 b=Mtq24ET3t4XUAbjuvZ1qYbv1RC1BVNsurQ6EWF0oh13k0mBAMTbWsXfzyJVGeSHY44YS
 Gug+JK5RzvAQnpW/qqUhDOy/kK4Kki8rHG83W9gvLTIqYAoEfx0+vv9RU11Co83NGS1v
 jHjuc/EZ7VbmVuXZGvXLeJjnCP8+5UQGCuy8i3o5ENw184LdIjrF2TxCcfFAY7Un84Xw
 HjmpjvUYnOQUrXwTaLxZOZbk5jvaB3gBCYwQc4ndcb09ULK3b2AN0Qi4kU6Qba9VTsKd
 nqewv8klYNmwiHeSCe/EaPfIvVb7RY3oqNC0ZQIb3PvBBXL/id0+25zYheh3sO79fs6+ bQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyr1yqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 11:15:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28E8ivsv023883;
        Wed, 14 Sep 2022 11:15:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyeh3y0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 11:15:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt9gJolzvunMvPFQWLzPgfJXdp3LT+bi7OFoRXgPeQ4jf9Hdujn4OotVY8QTuQtpKpDIDG7US1bCgF8TIci/+q3nDoIayYFS3wINK6/hEop8PagOOMNw31HVleK/HqaVKxFw37/7R76sJV76PMLmuUe+wWQ799Babiy7an0HWeNs2r/YvWml0BJWCxi+DKq+2HjE1WYBhKOVFqQ7vy7RmbV5zuxbn4jGSiuvUbUcPh+9IfJm4wKVN1SNehl+SFGXvKC4/eJMLRHUO38zegAQttt75dAp+WgB8KieZv3FjLjdnX48ZqF9APfNeLa3++Q5jrNbm4y2Co3Pp/6XB3Ct5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYTkPP14eqvfD3BTzmXyBO8b2Q0SWnxvww8y+0/4QKk=;
 b=IGxLx6RjktaNca0NhAWK4oEfcTkuUf5clD5vbYq8pkFgHB6jn7VIXjc591UFV1bAhioLnZlM5pohYwR83mG0S4tW9sdXiPKmUD2a2ZAYycvQto13h0B4QExRLdgyQSG96WHnc1yJvyJW+Ug02ukwgjST4E6QnMm/EWHsUfx1isyQMrcyTusoxB/ITHks41Y2Abv3GWoz8TlpWpwLJu83HAcJ+OtmJvh7cvhROAm/uV9VYZ6oxKMTJAQa1YVHbnDFQhIUc9EPyn6J5p3KWZANNLGekpYUSrEFQJUvnztiEZHy1PI2dsYazwDliAD861KL3Y9a8Au0i7e1WOWIBTRNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYTkPP14eqvfD3BTzmXyBO8b2Q0SWnxvww8y+0/4QKk=;
 b=K6p12+UN4VVNebnq4f9QcjfV3EfJVlyauoQmDS8G7ckEaSvhe8qfukuqXe6WmgHo0XziPMyKdNtf8+VQ4xlSdmO5J85pKlJkcC/dMjtM+6JL5+P0h1fCo/v2wLlL6dbFQXiIp7rhnzmFHTIKd7IZdf43HukuarkQraW/1JikLS8=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DS0PR10MB6799.namprd10.prod.outlook.com (2603:10b6:8:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 11:14:58 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::f87e:a65f:758e:688b]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::f87e:a65f:758e:688b%5]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 11:14:58 +0000
Message-ID: <27fec483-e860-aea4-f2d6-3082d702f561@oracle.com>
Date:   Wed, 14 Sep 2022 12:14:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] vdpa/mlx5: Fix MQ to support non power of two num queues
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
        eperezma@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220912125019.833708-1-elic@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220912125019.833708-1-elic@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0101.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::16) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3287:EE_|DS0PR10MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 781da64f-2a0d-435b-dc72-08da96425beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6n9EGFZ2a5Bn0RSG5LEP/ZwlmGl4AvGwKT6q6MNbxKG5ecefzHnWRPI95eUfYQHqHP4g48wqVj/5lxS63VU0rR42JU2QJIL6RW4FSRIOPU1l5O7HzqLMQOOUo5hNdyFly7IhGuFJKCFilHk1ciNLbIjVBU0e6IN0DOU3w4zdPxfD4dcumBZ0mIo2mGXGUQMEby3jWkfobqmX+9OWRHq96O/8bpP3TUzJ7/y48NtCLl2n6bjzEeL++UmskeFEZfYbQH2ZTic2j5H7yKOXKtAmYArrxL9xTJOz1ju9O2W08hzziPuMEaO5Wt1xdvGjDDR58IMNnedwRXIrGduUQzEKj4su7ruDJOTSNv/DDnipvY+eYQlrp8YcShRmuCGFNBzYvtv1ANlEB/oPweU3LzWK3T1qYXJjgl548+eAefDH/E287BcQ4l8CdNg2BJe3YAM1CwTjgAEONyNVXRdCbmXxTJVQyv2KXPykI9Ay+Xmfhp8/rh62rqd/RPTDTdRbVselxPdOznC77hFwJdmXetbpXSL/rDH1WoWmYRpJvYho+O34A6g23KzzzmozKtCpTbYQ9dHoXU/HQQwpvuAnOjOYiHrxkLo5uXVGuUXTuDNqFcuSGiwBtWBClGT9qDo74he7jDp2qRXXuENNd7+c8R8t/lJ7ivQIrFpGKccPGsNeXORFVPFzXxJZpo0wk9fEHY3vdNjVxPYQJXcYZg4LVnNpHQ2XtKYJB1NjXaUtxIsmRlumNmtR35fO2aLSMa3rUM9VZ4E0WtwsgbmT6p3IbNUp+7aZADuhO1RCuDG7nzULNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(36916002)(66556008)(66476007)(5660300002)(8676002)(36756003)(38100700002)(66946007)(478600001)(31696002)(8936002)(86362001)(2616005)(6486002)(6666004)(186003)(6506007)(26005)(41300700001)(2906002)(316002)(83380400001)(6512007)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REZYWTRXci9tdlVpLzd3YTNmMUZjODQzN3VWdGlVMDRTK2U5cnlvaExCMmt6?=
 =?utf-8?B?VEFHdnZVOXcvMVV2d01VK0hNTThZWlliNmVWMnJLZWV2U3BCOGxrNDBPR0Zl?=
 =?utf-8?B?cXJqelRUN0MyVGF4b0h0dlpPRWtrQ0RBMUFvQXB6TjhseGk0bEl1UkkzbkdD?=
 =?utf-8?B?UFBheWNNL3RCb3ZlNSt3STlpelMyWGlnQWhvWDVlWHZVSm5Obm5Tb1JIRC8y?=
 =?utf-8?B?RkNIdVdRQkRLY0R1Mzh1ME0yWVJ5RDlHdmNIQXhnRTkzNDB3TTBHZ3Vpc2pC?=
 =?utf-8?B?ckR4N1ZYOUZKK0Y1QnZhMDVhY25GNENmVEl2NWNmSFc4Q2I3am9jYU5XSkVK?=
 =?utf-8?B?Zi9VSXBuVEs0YzRqU1Y4SlVQRjdkbk1kNithQ3dKTlAvYXovcVlXQkU4MDhn?=
 =?utf-8?B?TEtFdXRFelRRckNpTlFEWGJwYmNIU0hOSFBTdEFBUGYveFhyL3EycENuY2JN?=
 =?utf-8?B?MTdHYWRzOE9SRzZCd29tQjZPZ1lwZ25lYmtwUGVHalBjWkRaVFllK0dqSXBH?=
 =?utf-8?B?Ni9FVTY0OXJmYmthcldObFpkdnd6YU9QL1MxaEZUc2kwRGZydWNrWExTUG5T?=
 =?utf-8?B?eFdYaVhjWkNraUtrOXBnM1J0UW1sc3RjV2ptZ3RMZGZDZkdmemszelRhMDlH?=
 =?utf-8?B?MWtZVkFvb3ZBYytQNlgva3ZqNXVtazJ6MmYxY05vNjBYMSttd3kxNjNjeUFW?=
 =?utf-8?B?ZEhicUUxODhPbVZBQ05sTFEvTlBsc0VEN1g4UkVjR1FyQ0NacXB1NUVLbkZW?=
 =?utf-8?B?Qy8zOVFKTk5iZlEwdGErYkNaVkhPanpLYTNhdUNhdGcvT0JlTkR5WHlqeUxh?=
 =?utf-8?B?dzJJME9kbXdpelQ1S2NyZlllZHVNQmR1RTJwZ2N4M1cweGhMTGYzYkFFR0JE?=
 =?utf-8?B?dVY3cHpHeXc5aUluakszZitpN2szM2c1Rm4wclJUcXMwRmV6R290L1NrOVpE?=
 =?utf-8?B?Um4yWWRPWll4c0plU1RSZ1krMHdzVEkzT2E3SnZPTzdOWmRpVEZYZ1hPMFFI?=
 =?utf-8?B?dEVQaE5IRHRkYVpqTkt3QVM2QW1xNHZUejdLaGVEM0NMRk04S0VxazdUdWd2?=
 =?utf-8?B?RnBJOW1sbFZCV2dYWHZ0SUQ2eVJpU3JtSVhuMFduM2NQK3pZc25aOXRwUldG?=
 =?utf-8?B?NkFjdDNyb3JLNERUL2hIMFJwSW5UUVM4bHlRRXVNSWdQVDFKbFFCeEVUK21O?=
 =?utf-8?B?VWQxdWY2QnJURHdaMnRxa1NvSE5NVWV2VjhYaFVVYkp2bCtvcE1MakNYem1Q?=
 =?utf-8?B?aVJ5Y25ydHBvWWRmUy9Pd0R1aUkzZytpZG1mRzdXRWUzQy9zZUttL3RveEQ4?=
 =?utf-8?B?Mlo1K3Z2TE1abHhqWGk2MFpXZ0JoVVZFR2tIeERaNTVsS0MvSW1sNTRHK0l4?=
 =?utf-8?B?WE45dEZZSWpOZmxEMktzWllaUzZrUFY2YW42R1NwTWxEZE43Q3dxbnVZWUlm?=
 =?utf-8?B?RGlpdHNUelczZThoem1EaUZSUTRCbjBwQ0NTLy9IYTM0M3ZqWGlQUm1yTytB?=
 =?utf-8?B?VktRL2cxYWloeTl3eG8vaXJUcTNYYlhKd3Y2aHVJZkdwTHFSUHYxZXB5aElv?=
 =?utf-8?B?czZUK2d6Y3hLWjg0QkMrdmpzWWZMSkIweEVJeTNOek9BQzJISm42MC9ENHd4?=
 =?utf-8?B?ZTcwR1hUN0w0cTNnQWlvN0xMRHZjeWhmNGt4YlFlZ3R4aFI5bVhUUzZsL2Iy?=
 =?utf-8?B?d2RlTWVQRlR5VWlRdkJOdmhpbmE0UEpheThOVDFxeHphNmpvRXUzRVFOalAv?=
 =?utf-8?B?cWpna0ViTzNRdVFhcE5LV3JoTlptNTlzS0FwVjZlYVpOWWhMS3MyZDFhZGRV?=
 =?utf-8?B?aG15QU11R0F6aERCejFrZVEzZDFCTmc3MDlNNkd0eWNtRGZWSGtaYXRySWRl?=
 =?utf-8?B?Si9oZmx3OWhCM1RKbDhOVThXWDU2OXdBUHFyTmd0RlgwSWtwZTM2ZStOSFlo?=
 =?utf-8?B?RDFtYzAvNThwRUpWTExJK285UXhoSyszdHA5ZnRkajlOeVdlaUljcWU0MzdO?=
 =?utf-8?B?QTBEQXhwWVJ5ZjNIVndRUUxzaStZZjZvb1QzMFJ2aFhjOVVGd0ZXbTZtUUlN?=
 =?utf-8?B?Ymw1VVdDajR4cXVCZmt0b1VKMndvUndmZVNpZG01VFBmbjVSRExGWVZSUWdY?=
 =?utf-8?Q?7YTKVQKjKBay+9gIykiCPMWZy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781da64f-2a0d-435b-dc72-08da96425beb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 11:14:58.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OD3zl23HQh5bwyGyVxc/3WA2OvQuZNrFSZhpiAcnXn1kj/gOgoMSVLFS7ympxHbRCHjlapjtM5G9A6xlD4YuDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140055
X-Proofpoint-GUID: _q-UakRCn8xdOzTlx1MfJRmerEORYR9h
X-Proofpoint-ORIG-GUID: _q-UakRCn8xdOzTlx1MfJRmerEORYR9h
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/2022 1:50 PM, Eli Cohen wrote:
> RQT objects require that a power of two value be configured for both
> rqt_max_size and rqt_actual size.
>
> For create_rqt, make sure to round up to the power of two the value of
> given by the user who created the vdpa device and given by
> ndev->rqt_size. The actual size is also rounded up to the power of two
> using the current number of VQs given by ndev->cur_num_vqs.
>
> Same goes with modify_rqt where we need to make sure act size is power
> of two based on the new number of QPs.
>
> Without this patch, attempt to create a device with non power of two QPs
> would result in error from firmware.

What kind of error would it end up with, is there explicit warning in 
dmesg or it's just implicit? And is there performance impact? It'd be 
nice to add such description that we can easily match the symptom just 
in case.

>
> Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Acked-by: Si-Wei Liu <si-wei.liu@oracle.com>

Thanks,
-Siwei
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ed100a35e596..90913365def4 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1320,6 +1320,8 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
>   
>   static int create_rqt(struct mlx5_vdpa_net *ndev)
>   {
> +	int rqt_table_size = roundup_pow_of_two(ndev->rqt_size);
> +	int act_sz = roundup_pow_of_two(ndev->cur_num_vqs / 2);
>   	__be32 *list;
>   	void *rqtc;
>   	int inlen;
> @@ -1327,7 +1329,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>   	int i, j;
>   	int err;
>   
> -	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
> +	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + rqt_table_size * MLX5_ST_SZ_BYTES(rq_num);
>   	in = kzalloc(inlen, GFP_KERNEL);
>   	if (!in)
>   		return -ENOMEM;
> @@ -1336,12 +1338,12 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>   	rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
>   
>   	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
> -	MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
> +	MLX5_SET(rqtc, rqtc, rqt_max_size, rqt_table_size);
>   	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
> +	for (i = 0, j = 0; i < act_sz; i++, j += 2)
>   		list[i] = cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id);
>   
> -	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> +	MLX5_SET(rqtc, rqtc, rqt_actual_size, act_sz);
>   	err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
>   	kfree(in);
>   	if (err)
> @@ -1354,6 +1356,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>   
>   static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>   {
> +	int act_sz = roundup_pow_of_two(num / 2);
>   	__be32 *list;
>   	void *rqtc;
>   	int inlen;
> @@ -1361,7 +1364,7 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>   	int i, j;
>   	int err;
>   
> -	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
> +	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + act_sz * MLX5_ST_SZ_BYTES(rq_num);
>   	in = kzalloc(inlen, GFP_KERNEL);
>   	if (!in)
>   		return -ENOMEM;
> @@ -1372,10 +1375,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>   	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>   
>   	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
> +	for (i = 0, j = 0; i < act_sz; i++, j = j + 2)
>   		list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
>   
> -	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> +	MLX5_SET(rqtc, rqtc, rqt_actual_size, act_sz);
>   	err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
>   	kfree(in);
>   	if (err)

