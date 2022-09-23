Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CA15E82EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiIWULw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiIWULr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:11:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081E8122045
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 13:11:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NJElKS002135;
        Fri, 23 Sep 2022 20:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GikWTFEMrHO+HKUomi5rGVnSECQZ9M7mNcoKODOp7ew=;
 b=Oiec4yZs41ONM7TOssw/4tPLKuRJbmcKhv4FR16skDzKOwRq7jqoGxUoUsAxyTKykK5O
 9feU/G+Oq07tnOayP4Ms58LQxg6UG4McweYPL5UoyzEs7uaX6WMTy7y1Fvyy8qy3KDN8
 X1zcygW2O95f9K2OLMewLObCp8orp0t9RvYQ35hi2uQ8S2AqeJ45gKnb9IVV/eKTx3Aj
 8LVGgXJiAZUsL+KSodPgQzCQ0rviKmJ4NyuTNmNsj2ubGeBLOTpbSOUOUUg28yN4DLFF
 f96xW6LxQ/kUF6AzWAWwgBnim5nDKvV6ya3o6NGGC074rsXlsK1WTtEIVNMrXCEGr2jW Kw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6f0s3qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 20:11:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28NIN1SI010209;
        Fri, 23 Sep 2022 20:11:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3ccphdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 20:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnlxnESNI8F6iovxkHXcYOWc6ebYXVK5feo4VTJn/MXz5Ug1N+LZq7Lp/wPRbXkyQHCldnNnd8XNPsanFUXzKvBGBbwqYYF9OQABhfSTXQxbJl/oDDkMYYIn4cCn3UIhFy2YUd9gwz/NqPPyOL2Y/WTuCX8QSUG2y9DtTSxZxbdFTxge/0DCR9lidS3rXumUyBjJaX+y6K3ezm9g3rK3s/bvGc8W71Qf3hBbeur064ZEMG2+Axxb4WwDzY2MJI0JcIUQIosU08cpfHtIKV8dUUJH/eISQ+Ap0Gkw+UFGorzdN8i8QQOmicQJ5N1Y6cBPMBe7wLLhiAKYufbsWIm/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GikWTFEMrHO+HKUomi5rGVnSECQZ9M7mNcoKODOp7ew=;
 b=ACZ3pNcjEVVFoQkqoFEBivqYzXZLkdxdC2TZAvoTDz9Im4PGY0Vz3vYTDGiEgtfE9Fux/PWKkJ+Uu9LPZ8nxVvdyUVcM3llSTAcNGH3NQpczTrgFRNO4MLm6cFKvgU36BtVk0S67irgyR06bc9k1fY+PvvE1TvvUCIU5YMBNxZxkqJzKim3v7TXhcWRkWSC9EdSKJWLzrIG4trco+mkkfR72m0SCUeizc+UPXW0G+dd/u71Mf7XqDK77HHw8PVInFQ4EmLZSPiJ8pdvYEnTjLqgUWM0gVjSYBAV01J2CuxZBmsQgectMdg5Q0BX/d47ni/n3VJ/G/p/YbgC0MFFBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GikWTFEMrHO+HKUomi5rGVnSECQZ9M7mNcoKODOp7ew=;
 b=IIpZY30c6FhkIqppL7JlofLIS9aAcoHsg4kPNgJviRHslIJppjGjRCMoCEWlS2admncS+ChyLbV6Wwtbsc8QDvkgCSKfApD9ccn1idRcK59TThDm95CnrBisjgszcpBvwIdkAoldy6X153dcTOY9S3lQNq6KoRIX6XYP6ZFFiRA=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SJ0PR10MB4672.namprd10.prod.outlook.com (2603:10b6:a03:2af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Fri, 23 Sep
 2022 20:11:34 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::8096:7cf2:829f:fa13]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::8096:7cf2:829f:fa13%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 20:11:34 +0000
Message-ID: <649cf77d-849b-1ed1-e804-3abab9e339d1@oracle.com>
Date:   Fri, 23 Sep 2022 13:11:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH V2 3/3] vp_vdpa: support feature provisioning
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com
Cc:     elic@nvidia.com, parav@nvidia.com, wuzongyong@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com,
        lingshan.zhu@intel.com, gdawar@xilinx.com, lulu@redhat.com,
        xieyongji@bytedance.com
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-4-jasowang@redhat.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220922024305.1718-4-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::21) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SJ0PR10MB4672:EE_
X-MS-Office365-Filtering-Correlation-Id: e4528130-cd0d-4449-5904-08da9d9fcfe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQhgGUAMFu8l4+p/zbYtkj6EH1eF4DnC0E/kzpGV08+9lt6KdvOsYoU78Z5nl9KhNfW1R2Dcd5FpOs3dSk0p12PSuOP7GG74GlrMMqhQnlDkK8ojF/AdljCskj6pVYAnxLXg7cGNo6f926LcfrOEqBYlR8cjQ1b8D7Z29FrKTLcx4fOcQeyvSegPzRKQcv59W8x2+aIRIktL0Dm7KW79p3h2dTiCPOODIvcolyK7Rkgc8Ogk5GInszCz1maNNKewaXbJ2vy9+YqanWaKfmtWYv9AscapYvjRqyDCl/FgMLFlEIF5g7/+q1L383qfF6BobUnLTu8SM4rEmW+pg3TEn8yv/HtIWyxiFKZFPzbnfZJxMtJW4/9ver6JCUcvFlhuazqmq/CXqUfbKvQkbBEBAWLcYG95aJKTfkuNSG7vlHufVwculNcJeuzM23pvLwtsz6iLDhHuNaEycESoTAKkP2wtS9nAWGxr3T7HCR5XxDgOLkfl9LE2P69hK9Cv/zY2GVcQXXM7WwcrIsjZHfFDNUNHE74UoEii0+6au7JmqwngqbLw7I+VJBKZxBdrXbmkdqyRDDvMA/PKJBNP4FmNUkjGtJ91jp5XRk+1ex4+xWBhlibDBAuaUuhSNdfCVKMz4abkLCq76VTxmRkopRIczRL2I7/lUZ4y2h0BeE5vpt9I2UUZ80Z2+TPBMu8ygS4yx1gS1i1fXXInf8YZtGkYcpTO9ybVFP+eqwi2obw8hpGassayeP7OtKG5MrQiWX7L2ydwjm4l5ax821eGZXpUlPahhuq27XPu2zafJW+V2XQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(36756003)(6666004)(31696002)(86362001)(38100700002)(6506007)(8936002)(41300700001)(36916002)(7416002)(5660300002)(53546011)(316002)(4326008)(478600001)(66946007)(8676002)(6486002)(66476007)(66556008)(2906002)(6512007)(83380400001)(26005)(2616005)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3lyTzZQNTVDb0cvbGZQampINGxjemJqVTlaSSt6bnlHNmt0ZkZJMDIvZUlq?=
 =?utf-8?B?K3JHUlhFSWxrUjloUW5aSkk3UXk1LzBJOWs3QzlBTGdzZzFsc0UydEE4TEhY?=
 =?utf-8?B?N1JRUzBpR0QvbFZGMVAxYms2cXc5Qnp1STVveWc5aHlVR2I5b2FkeVZ3Q3h2?=
 =?utf-8?B?bHRPdC9hTFZZamo2SUhIcTNiNnFpRXZyem81QUQrbzk1MGtVY1NCYzhNRlNP?=
 =?utf-8?B?K09ySk9mNTN2TU9WN1BBUm1FMzQyeHVGeldVOXpaa3NaRW9jWjNTNE9FT2hN?=
 =?utf-8?B?RHAzMzR3WWRSNXdIR2Zhem5zOUtTN2IrcmZ5VWxMSHBxTG9JUXl1ZXVFUzFj?=
 =?utf-8?B?Q3dJVytSYWd1ZWQzOHlWZDJCT2xLV01yc2xuOFNRc3MvdHJZZ2FlUTRYbnNN?=
 =?utf-8?B?NEFPMEJNVFk3NzdOQTcwWk95b1VrUnlMelB4WWJIUnFIUngrVklWemFzRmxq?=
 =?utf-8?B?OWFrN094Z0IxaENsMys4MVlrcjZZTGhOOGc4cGQ2eWpITkZnSWtSeGxHcURi?=
 =?utf-8?B?V3FON2dBYXB3M2ZkL1J6d1hzTUtzRWc3UDZCMHA1UkNWcWhPN0w3VWpoMXRo?=
 =?utf-8?B?VDFqNHlMdmpNTTAxRk1nbjByRVg1YzlJK0hhRC80SXg1YkpkUlZrVTZvaWdP?=
 =?utf-8?B?K1F4eDhNYTZncWgrS1dmUW8wZUtjRkJVZVIzMnNnaGxpTEhtbzdUaVp0b2pF?=
 =?utf-8?B?QWVKdEpIZFkyRExrT3lpdW9BUko0dFRtMDA1RzVLamxUT3Jzb1Z2dnVubndX?=
 =?utf-8?B?b2pTVnNzaU9kd2RTb1NVa2dUaDNXUmR4VkorR2FBMmFRZ2hqb2RrcXE4dXpT?=
 =?utf-8?B?SEtDL3QwelRQL2RRK2J0SWNCajVadFVicmQ3ODlpUmpnaTRMTHlxbmU1WFNt?=
 =?utf-8?B?R3RNdHhQN1dzenI3ZmdIL3BXVEZpcWhRdWNsd1FDSUNWSVA0U01mY0FzekJh?=
 =?utf-8?B?SndERkJCZlJ1Tk9yM3RRRXJ2TExFYm1JME14R045bHBiU2pWUk14ZGhoZG1X?=
 =?utf-8?B?Y0xZckpvckZZWmYwZytqNjBPSytSbHpGZ2NKR28welJQSnpUaTZmWFQ4Qzhs?=
 =?utf-8?B?U3ZiZ255QlcyVStSNXI1RXpHbnRxZGtJeHVXSW9tS2ZoM2E0aFRDNUQ5ZVJi?=
 =?utf-8?B?YVJiUVBpS2JZbU15N1VJbnRyQ0ZhOFRiNmJjZm91enlKMXMzUHJoc3liT2dm?=
 =?utf-8?B?VDJYNWFzYWZzQ3RnZDQ3ZGRId3prVHRTdXF0eXZyMS9mL0xNMTJVRU5aeG96?=
 =?utf-8?B?bnZrelo1YU40RS9WMVArRVc2RFN6UHkxWiszNDVSQXprVEVDVG8vWEZaaUJY?=
 =?utf-8?B?c3lYdzlyQ1k4UDM1Y1gvS28rVFY0OCtrMlpMenlmYnVCZ1RobWt4eXR6K3Bw?=
 =?utf-8?B?aFFyZjl2TXNGYlNuRFdSZGRZdjhlYUxxdmtxWVpBU1ZUQWc2ZVpYNlhOYWhO?=
 =?utf-8?B?dEU2T3EvTXhLb25GV1dPWTJsZ3pGU1VmRHB4L1VKWnQ4ejRBMTl5SUtUQkJq?=
 =?utf-8?B?N0xqVGdDSWs4dzB2cWlUNHBMSG91bDdKb01XWUxhcjV6dklGd0U0OVFqYTY5?=
 =?utf-8?B?bUJROWNRWmFGZmJJd29Wc2hNNVFkMTRJSDBza1k4cXZ0TG1QRlNJUkdXL0p1?=
 =?utf-8?B?RithRElHS3dxL1ZuYnlPYjE5eVhubjVVT1pOeUoyaDVNS01Ed0lZZGdoRHFV?=
 =?utf-8?B?dlFMTzRFdHM2MWk3VlY3TWhkcTRQMjNtN0RZOGZDTTMrL2xYSkVjNkx4WjNC?=
 =?utf-8?B?R3gzWnZva1pLa2VqS3p0K2swdEd0TTVSZW1XRjYzbEN3bTh5Wld0TFFvdVZj?=
 =?utf-8?B?ZXA5aDNEdU5ZS3FJVlRBNEJwRUMxMmdWbWFFclVDUk5zb1JBS2RiWVQ2TUVV?=
 =?utf-8?B?TzBpVnZDeDRJUzRVaCs5TTNJeDR1TlZqRGFLMDJpWDc3WmpJNFdFM2lQZnNW?=
 =?utf-8?B?QW1PVmkwMW9MS2NuMGNRcSsxOVZ6MWpEYkRtU1cyM2RjZ1FXbTJDOEZMVFJS?=
 =?utf-8?B?YUUwMDc3alhlNzVrQjJJeU1hQ2VpY255bVFZeXZxNkxZb0ZpVCtCTHgwYldp?=
 =?utf-8?B?dGpRQ29EMXkyaWpFdUx2dlg3SzM5SDFLNWZPdWRORUVvVWV6NmhhNXYvcWlQ?=
 =?utf-8?Q?bvfjR7I3OqKkEgigQzqS28x7w?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4528130-cd0d-4449-5904-08da9d9fcfe9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 20:11:34.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfNmzvNjIZUCXUgTu1GVytfkn8gas+5dR5rTH3LiarNR74bEsIZwrUS5zYmQ1pld0a2kXjcSNoqacRoWYFToWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_08,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209230131
X-Proofpoint-GUID: zRJMBaWZKJjWGBgZ8_25vxaqclZGqEVc
X-Proofpoint-ORIG-GUID: zRJMBaWZKJjWGBgZ8_25vxaqclZGqEVc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/2022 7:43 PM, Jason Wang wrote:
> This patch allows the device features to be provisioned via
> netlink. This is done by:
>
> 1) validating the provisioned features to be a subset of the parent
>     features.
> 2) clearing the features that is not wanted by the userspace
>
> For example:
>
> # vdpa mgmtdev show
> pci/0000:02:00.0:
>    supported_classes net
>    max_supported_vqs 3
>    dev_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC GUEST_TSO4
>    GUEST_TSO6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6 HOST_ECN HOST_UFO
>    MRG_RXBUF STATUS CTRL_VQ CTRL_RX CTRL_VLAN CTRL_RX_EXTRA
>    GUEST_ANNOUNCE CTRL_MAC_ADDR RING_INDIRECT_DESC RING_EVENT_IDX
>    VERSION_1 ACCESS_PLATFORM
>
> 1) provision vDPA device with all features that are supported by the virtio-pci
>
> # vdpa dev add name dev1 mgmtdev pci/0000:02:00.0
> # vdpa dev config show
> dev1: mac 52:54:00:12:34:56 link up link_announce false mtu 65535
>    negotiated_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC
>    GUEST_TSO4 GUEST_TSO6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6
>    HOST_ECN HOST_UFO MRG_RXBUF STATUS CTRL_VQ CTRL_RX CTRL_VLAN
>    GUEST_ANNOUNCE CTRL_MAC_ADDR RING_INDIRECT_DESC RING_EVENT_IDX
>    VERSION_1 ACCESS_PLATFORM
>
> 2) provision vDPA device with a subset of the features
>
> # vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000
> # dev1: mac 52:54:00:12:34:56 link up link_announce false mtu 65535
>    negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>
> Reviewed-by: Eli Cohen <elic@nvidia.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   drivers/vdpa/virtio_pci/vp_vdpa.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 04522077735b..4b28e0c95ba2 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -17,6 +17,7 @@
>   #include <linux/virtio_ring.h>
>   #include <linux/virtio_pci.h>
>   #include <linux/virtio_pci_modern.h>
> +#include <uapi/linux/vdpa.h>
>   
>   #define VP_VDPA_QUEUE_MAX 256
>   #define VP_VDPA_DRIVER_NAME "vp_vdpa"
> @@ -35,6 +36,7 @@ struct vp_vdpa {
>   	struct virtio_pci_modern_device *mdev;
>   	struct vp_vring *vring;
>   	struct vdpa_callback config_cb;
> +	u64 device_features;
>   	char msix_name[VP_VDPA_NAME_SIZE];
>   	int config_irq;
>   	int queues;
> @@ -66,9 +68,9 @@ static struct virtio_pci_modern_device *vp_vdpa_to_mdev(struct vp_vdpa *vp_vdpa)
>   
>   static u64 vp_vdpa_get_device_features(struct vdpa_device *vdpa)
>   {
> -	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>   
> -	return vp_modern_get_features(mdev);
> +	return vp_vdpa->device_features;
>   }
>   
>   static int vp_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
> @@ -475,6 +477,7 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   	struct pci_dev *pdev = mdev->pci_dev;
>   	struct device *dev = &pdev->dev;
>   	struct vp_vdpa *vp_vdpa = NULL;
> +	u64 device_features;
>   	int ret, i;
>   
>   	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> @@ -491,6 +494,14 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
>   	vp_vdpa->mdev = mdev;
>   
> +	device_features = vp_modern_get_features(mdev);
> +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> +		if (add_config->device_features & ~device_features)
> +			return -EINVAL;
Should use "goto err" rather than direct return. Also, would be the best 
to tell user the reason why device creation is failing. In the other 
places of the same function, dev_err() or dev_warn() is used.

-Siwei

> +		device_features &= add_config->device_features;
> +	}
> +	vp_vdpa->device_features = device_features;
> +
>   	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
>   	if (ret) {
>   		dev_err(&pdev->dev,
> @@ -599,6 +610,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	mgtdev->id_table = mdev_id;
>   	mgtdev->max_supported_vqs = vp_modern_get_num_queues(mdev);
>   	mgtdev->supported_features = vp_modern_get_features(mdev);
> +	mgtdev->config_attr_mask = (1 << VDPA_ATTR_DEV_FEATURES);
>   	pci_set_master(pdev);
>   	pci_set_drvdata(pdev, vp_vdpa_mgtdev);
>   

