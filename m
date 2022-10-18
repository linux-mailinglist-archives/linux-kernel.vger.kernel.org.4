Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DE960334D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJRTUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJRTUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:20:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFF312AE0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:20:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IIEDMf020296;
        Tue, 18 Oct 2022 19:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=b3tYj3skZCor3XG/ynojitmqrFuuxVHsjauHGWDLS+w=;
 b=OBqvaJ/xStrZJZwTgkm7oz+GT3mxBK7Lg2llFqFTCHlLghG+PK8B4Xm7Btv2Z1rKWyBN
 zca9f/JlHFzBj+ZFy5l1Kbz7IMeDa3UHxNArDObNTSiOemN8Ak4/eC/FiuSdOl9P/Ulm
 0j+f2606mbYaw/k1xUJ/rN4AFKXmTIl78hQ5BdCxprBOgSavkZ0lBd/vLWLRUJh0tt85
 WPDKUpW4bpUBvq+SqROOL8s+PLzR1yZ+VMsBWiBmjgJ3AUAvoiUzu4AckJ3gnMrAAKMQ
 GBcIQG/sW1ohWTKbLzR4jfOf90fqDlMXyHUF/mkPsf2wsN30GQt9qcLrZFfsgfzQP/jC kA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9aww3exr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 19:20:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29IHAZuS028841;
        Tue, 18 Oct 2022 19:20:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr067tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 19:20:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6GpXUJFq+0ZSncdIh8lYpJeUMcOE1e2cogOohlraDIbljyPzMSg5vQEEM0njnC/eZE8poh8Bv2OfUePjFmhGKlORPMCTfSceNcEm4tUu3Yn53FHTU/STus85Jpozd51zccKmMra1ifOsEE5XewM2i+QvPmilF/CduoFafApgRFTnqyMZ2KNQAXSyJPvIoodHD2CQIpty4cYZ9dlw6E69oz82xxT6fKYmooY5U7Tt2XxzCFmC6iwYX1Hn5LeMQ7yhUBBhx890xWpCXThDpJCXyqbe2JmkOarijY6WB/ZogCUUbzG82A4ijaMQVniQV5pfPh61qsyh+wBEugkeYhGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3tYj3skZCor3XG/ynojitmqrFuuxVHsjauHGWDLS+w=;
 b=FnO+gHrVnvcssfwrz2KCs0mN3Vo79Jh/4edrBQ3tfTz0NKj4ZScROMsGU36TGeOWr6GRzeFrA0xay8TghLquidG23tzgoega9kxL40U93aACKohLYmRL9mVdN8uQHTuMvS3ZD6YC8avvEfXSlr6f9noVRRDbxiOZH/wHdbbqcEQnWT92sJYLj9zy4wMaYVW/BNw4TlMD+sihWKHeEiYHgaiqAmAX3V3mLt9txTi7LIvRACSENL/J9KDoogcnEDDwGFA0OQVl/ydSlIZ056D1HFR/VCoz42KTaxEEYlBHqH/bYgy2BIKzRPoGEB6J1eI4oxN7WMxqv3VYmIqG+qLrVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3tYj3skZCor3XG/ynojitmqrFuuxVHsjauHGWDLS+w=;
 b=k2kVsSPxqyuwoE8z0YsfbLV0L0mRebWif6v6IA505bK/H1wHJEpjKoMswUbo/JhQusJW4H+ZVtaVQO9ekR5bBCd4LaOc3AKxv+st/qElGYvG6Jjt/tmTpBSNtTG/bFtFt7DTW9xwb7zl+s4T7v4vaOHBTgJ1Csu9vTG0Qd6Hb/U=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DM4PR10MB6231.namprd10.prod.outlook.com (2603:10b6:8:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 19:20:41 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 19:20:41 +0000
Message-ID: <7eceaaf2-753a-8ff8-4014-39314b31d47a@oracle.com>
Date:   Tue, 18 Oct 2022 12:20:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/4] vdpa/mlx5: Fix rule forwarding VLAN to TIR
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     eperezma@redhat.com, lulu@redhat.com
References: <20221018111232.4021-1-elic@nvidia.com>
 <20221018111232.4021-2-elic@nvidia.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20221018111232.4021-2-elic@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DM4PR10MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd2741c-a937-4563-cb39-08dab13dd893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1N5v21i/SYA/60rIfEEb3nt82+Ozv6DkmssU6BufkF/ECOKx+ipf05KdT+UWEix8+2/3bMni+GcjwXi2fyYAtYLHA6IYCzAiX9D3sAiBt+apy9E+xjwM2Lz4WkmXw4YipLdk0tjWIcxZmKPrJOg/eD4OjfvvjwnHya0rntL/DghjU2q+JzF/5Tel9omWsuOwfrMewMcnYeuhIIbuk2edeWie7o2qu/p59915X9au/cVJmsFd/kqglo8txQzEnwcwwZAINM/5I3KRtXndNpMHJl45f6rb2gzEYhrsy0KWIVoqu1MFAOvSlEuTHT8I0adI5zPaCAZekJoAcq0CyRw7Eh7UZ/Zfyp668y05mIEp42nkcg3b83ASG7AVqMBQWoHBMTO8u7tx7HzTjPcjJGfd42VPUreTu0FoKpxy4d4XeVlxVzUKIGdOK9o1W17buOoXa7gRoCiYyxZDoqeTdvWo75H+GmuJg0/loFi7VEpMgDIoWJ5MV08jYTGAHx72ld0IObBl+PgKrZjx6i7EoJ/CpeCieKfjPq3XYaYiD6WsesWfz+1ukOZqBLXSPJF6RcOfXGftDvZ2s/T8rAJQL5Ip40gbgshFnLT3DnJMOoXeErpVHOmuZ1Ntb25q3QtrpNpTEgoS7TNeY3jE+ZZWuAaAWmJ8QMr+igjp89n/1fnWU8fhRu0XwDONxiv5LWjLXH6BDbo0V8aBOdY9Ohy5h85bZprwSVF2IzZds5nAzzFFjqGzbqQXolwyjk9poTFSc25GZTSMFuBASUT7107dAtDSVt3EhDy7nzkjsIiDmRSa8xMugKsy+8xr0h25zB533O6a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(6666004)(31696002)(4326008)(8676002)(66476007)(66556008)(66946007)(83380400001)(41300700001)(36916002)(6506007)(36756003)(86362001)(53546011)(5660300002)(8936002)(26005)(316002)(6512007)(2616005)(31686004)(2906002)(186003)(38100700002)(966005)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUpSQ2YvcUdZSkhMWFFjSzhUQnhTUzRhRkVqSW9jK09MTjZpSFo0YzIwR3RW?=
 =?utf-8?B?VmlCUkhrZElSa2UweFB2WkFsVWlMQ1JZa2FaREt2QzJmRjZEMEFYQmVpQkZi?=
 =?utf-8?B?cE00amk4ZHN4RW4xTG42czJCZzlPdldEcGRmSjU1ekZ5ZnhIcWZzdzFHOFZU?=
 =?utf-8?B?T2ZDbG4rQlpxV3owaHFRVC8xTTNia3N5aGRFdEJPNmdiMjE1dWJWVk5aM28w?=
 =?utf-8?B?US96bjRvNXJ0MGpGUWlkQ25sMXFyTXBVcUJEUHpNckx0cElsSi9TSytwWVZZ?=
 =?utf-8?B?dWpkUERsN0NKSUZlSTZzdFBlVlY4WS9jcEJRbXYwNDA4cjdLaXVpaDQvdlZJ?=
 =?utf-8?B?alRYSTlyN2huR3UrWkxSQ09LMjBWN296Z0lyMGNwUVZaVmhKRmU5aVViYUtn?=
 =?utf-8?B?QW10L0JUbFlXOE03WUVVVU1GN3BZY0sybkRqb3R2ZVdZUVZYUG00TzZwMU9D?=
 =?utf-8?B?czZJSmE5ZUZuNXdlVWY0ZmpJUmNKTEhkeElqWUVtU2RTTEtiekszSVkrS05P?=
 =?utf-8?B?WXFOUmwxZVN0UC9nRkhJTHQ3TEl6eUVEUFVObWZzd3NCZ1dhSlNleVFPRWU0?=
 =?utf-8?B?SHpGK1F3aVpUTmhyMXJrcmRMS3RTSkdMbDFraHlnbUhyUFF5cytNTWwvbnQ2?=
 =?utf-8?B?YSt1STJTcC8xVWVyRnZrM0RxVzlrdUJLK2NWYzhuaFAzZHlWTGo4T3FJeUpn?=
 =?utf-8?B?NU9XaWRwZzlGbksyQlFqc1pROGtnYUJGdjNHZ0NOMldTRnByRDQvSnRHRW9Y?=
 =?utf-8?B?Zk5PbXdocVVrSkdKTmZsSm9lZSthMjFVVlZiTUxqS01lN0swODlYeHZFTlUx?=
 =?utf-8?B?dFV5S2ZlREpleUkyMXo4dGhxNlArbXhrY1l6ZEY1Z3p5dDBqWXZYYW1BcmJp?=
 =?utf-8?B?cEZnSmlCNnFpN0dSZ2pwVU1wclF4RkRtL0dZQWkvajRoOFRWOXVTaXNEamZz?=
 =?utf-8?B?RDJXVUI0NlhiekMrdVlUQVVxdG0vbjVnd0ZBZ1FmT29Da2lKZC9nV0lGTXlY?=
 =?utf-8?B?SHVkZy9UUzVnUTdwd2phKzAwcU9tay9FNXR1eFpMeHpqbUFnZ0dHbllXM05K?=
 =?utf-8?B?dU54QWRjaVNZcE54Q0N5aDU4MTJlVk1XdlcyTFhmMTJVRlJyWWh6Yi9YdEM4?=
 =?utf-8?B?Z2J2N0FGNVRYTmxCM1NtQzQ2czNNZ3g3SmZ6VSt6NU9pbkRkWWE3c294MVBi?=
 =?utf-8?B?UmczUkxiK3hGeXFub0x0bVVZZFdrZWtNV2E0b2cxcjFiK25ZMDJXMVlQSmtK?=
 =?utf-8?B?eVIrRmdlcy8zSndOS0cvUWw3dm4rNFMvWVdUdHNaNTF6RnU1Zi8vUm16UWdz?=
 =?utf-8?B?Q2FRRU5MTjZ6bEc1dTVNRm44SUNnUE4yVmdTUUhZdGFmbnZ3ZXRtNURaOFJy?=
 =?utf-8?B?ZzcvcmZ4ZHFROWFOdktzK0tDVXNPTWhONHNaRTN6ZW5iREdLTC91RUk2YmxY?=
 =?utf-8?B?cU1SazV2YXpGeXF1SWFFMnJyWDJ2VXQ3Z0JQNUFVU1AyZXdtQkZ1KzkyRndG?=
 =?utf-8?B?Z05WZUJIc1kvNGZsMzd4NE1sT3RNOUp4RE1Ma0FlcVkrZUxSOWlicStuRUtF?=
 =?utf-8?B?M1VNdThZR2VBdDZTYTFwVTZzNzhWRjJwak8yaEMzempBSUxnVFprS3VNZ2NY?=
 =?utf-8?B?TVMvSkMzME03QnFvUCtlT3djR1ZqS1NuK0ozd0Y3R2tQaFhSZTlpTXlWeGE4?=
 =?utf-8?B?WXBvcUc1NXVjdkhxQWxWR3RqMnRleFl4eWdjNm5PNGxSM3dkUElMTGozaUUx?=
 =?utf-8?B?Wis1TEsybkxJRU12RDgyOUxsc2JiYkdNYVpWQ09ucGZNUENxaVdPZHRmeXJ4?=
 =?utf-8?B?VUY1MlZ5VXJSMEFwRjNFWkJ4S0IxYkFrek1uaHNGZkJXZWM2ak5QTHRaV0Jt?=
 =?utf-8?B?emlOZVZJa2JIaEg4dkxVZkkvWU9CR3YwdnhRbXVyMVc5L3l1bE9vZ1Jtek52?=
 =?utf-8?B?WTE2WHFPUGh4SHF5VzFyS1FTeVl4YkpzU3cyNUNBSEZ0TVZVUHpDZHZhaVM0?=
 =?utf-8?B?dW5oRzRQTmNqRUUwcW0xZkYzSUt0QmxhUlhydS9mRW9zb0dQeFJYT0N0OXZ4?=
 =?utf-8?B?Z3Ircm00UlhhQWdlWjBBd1UxalprVUVPSUJ1NUNJeUNXU0JGeUlFSlVlczNu?=
 =?utf-8?Q?SSALmMZAVZJvT1883ImReXwo8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd2741c-a937-4563-cb39-08dab13dd893
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 19:20:41.2594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvhGN7fyJeCEcbkPceKck2nh3cuj0DYhHjQ0F7HECOiOD/jaPbFDxhnP8vkVVdrMLLw0zFWZgeZMMaAS65SxyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180109
X-Proofpoint-GUID: IOa6YcQfSfnbzgblPw-3I6FiB8tjC-CU
X-Proofpoint-ORIG-GUID: IOa6YcQfSfnbzgblPw-3I6FiB8tjC-CU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eli,

It's not for this patch but something related, so just a friendly 
heads-up. I haven't validated the VLAN tagging behavior yet for mlx5 
vdpa, but from my quick read of the code it doesn't seem it 
differentiates the case with and without VIRTIO_NET_F_CTRL_VLAN, to be 
compatible/compliant with what's been implemented in QEMU software (a 
spec addendum was filed as requested by Michael):

https://github.com/oasis-tcs/virtio-spec/issues/147

- when VIRTIO_NET_F_CTRL_VLAN is negotiated, the device starts with
all VLANs filtered (meaning only untagged traffic can be received,
and traffic with VLAN tag will be dropped).

- when VIRTIO_NET_F_CTRL_VLAN is not negotiated, all traffic including
untagged and tagged can be received.

Can you please help check if we need further fix in terms of VLAN tagging?

Thanks,
-Siwei


On 10/18/2022 4:12 AM, Eli Cohen wrote:
> Set the VLAN id to the header values field instead of overwriting the
> headers criteria field.
>
> Before this fix, VLAN filtering would not really work and tagged packets
> would be forwarded unfiltered to the TIR.
>
> Fixes: baf2ad3f6a98 ("vdpa/mlx5: Add RX MAC VLAN filter support")
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>

> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 90913365def4..dd29fdfc24ed 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1472,7 +1472,7 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>   	if (tagged) {
>   		MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
>   		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
> -		MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_vid, vid);
> +		MLX5_SET(fte_match_set_lyr_2_4, headers_v, first_vid, vid);
>   	}
>   	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
>   	dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;

