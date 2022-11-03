Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0CA618A6E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiKCVTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCVTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:19:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05261D0F3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:19:19 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3LAaNx029259;
        Thu, 3 Nov 2022 21:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oz6A3gh5oBBuCsP5S0UTSt8NZc3E3l/x9346XFtEvzU=;
 b=plCdGDMMSZtmFXS6ubdiFcTPexvImOCwD5rVPRKp+XWUbdPn2SGaUrEMcS7xyyQH6rRb
 MvAzc4Hi8LeZOb7DJKiSP/r+K35/AfS6oGo+oQfK9pWIbsxRJ8fPCwbkjM5RFssd53bB
 PMTrrQ3e1PxqWIvEmA69zWgjwb+bfv+XIcAyED9WNLR3TZPk5Vze1HuwJ/4suruE0FpS
 EjrH7nvrd7IQonUrwarOQf3cg6HT8nRKsCcpLe8dySYOCAeLXfDlztX6IIOM5BqTrS6D
 ijCoXIZ8kLbVL1Q/FXqM0QlXzCTntrwBdu1Zk6kagK940Ngbde5MxYu8cC8wK/dJZabR GQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkddk1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 21:18:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3KVRrh027269;
        Thu, 3 Nov 2022 21:18:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm731kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Nov 2022 21:18:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGs6MldHxW2HGE3FJUCrp1/oB+5mt8E71GHUgniE/roIAaN6sTmAKi82JGbXl87wK02fILEZcVbSoeTdtb7X2JFK/y4aszO7Y+JNXsNwksBD6Z9EQWg+poeluKcrhgaHRzXsSmoRBrW4Y9h4tlnVZmPRIXB63hkqFbpWojAbl4SMMD97F7ppghzEpDNiczgqbjpcEYTj1tchHdc4pEbKaIo+ggiRq6rK/81mopxEJseXnk5khTyicFUttCukkjrYiLp5dDq7haBJ1Tq+j+QoXppELlRu3gBKAF6g/2zPQVYLD21YJf4nv0/TFT3/b4bAL67GG6xch+uXav77liz0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oz6A3gh5oBBuCsP5S0UTSt8NZc3E3l/x9346XFtEvzU=;
 b=mbKDMjeGKIx5NbHyTtUhbiff/Us91O6AzeLHHH3Nk8UDRMAvMlUV/TwCs5Joe+DOiPF93Gc/OX3A0mgievXKYMlf2YBqLb+Mvw4atYkyWTF+H9S7N7DXC715ZybEn4LdMrrIRw7wD9SWcaUzuxgsx7dM7E167ftmbbSQDFNk3rLdKVme0582GG1CcapTop+RC0Sp44ki+9f4Do1YNNn1Tkwf7Hw1LyP+/uSk42Bwpqse+ZyQsdGZkV7fbsRubTPlBQVjepfHAY//DtIlhhL8duOQKOvZvPk90/qCdt9TlNJXbx5+bqRWoZ91EPUeIzG2I42CU9aG2DBemNAffWX23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oz6A3gh5oBBuCsP5S0UTSt8NZc3E3l/x9346XFtEvzU=;
 b=rjSe1iSA9poEZtUC8NpCV/fHauDLH8aep+KVz6kaSlJW1FiabkTwrPcx4I3FLk6zUvTwzUNFwsCoYFYfgut74lOJrna82IA3+Bq8XZEmvNIGov1TdwnOwep4ej8UXFjFjadcSQDZAcI17qcbQ7jODrJ6qz1/Mex/pY9uXtXGJmg=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by MN2PR10MB4157.namprd10.prod.outlook.com (2603:10b6:208:1dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 21:18:48 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::3702:7db0:8917:9954%5]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 21:18:48 +0000
Message-ID: <5bd8a365-e2c5-a721-1257-81ec4ae0c626@oracle.com>
Date:   Thu, 3 Nov 2022 14:18:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/3] mm,hugetlb: use folio fields in second tail page
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Mina Almasry <almasrymina@google.com>,
        James Houghton <jthoughton@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <5f52de70-975-e94f-f141-543765736181@google.com>
 <3818cc9a-9999-d064-d778-9c94c5911e6@google.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <3818cc9a-9999-d064-d778-9c94c5911e6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::20) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|MN2PR10MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: 522dfff5-35d1-4364-7bbf-08dabde0ff80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qeejw2+HjmDas9zoOjfsx+Mk+XWNwVXgK6+98A6uzC//PKK6VDlUl4aPnsGzLXVpUaVvpJryNFt8mpq8BZbeESFSZKe3qaWutGihVTURIB9s0Kjg50qlZ+c+TQ2sR7k1GQTXLmrDPzaj6SnNvpkhclnyVdmMEcdSYqwrlIZpKAHwQjyiW4xCHFXMbgohwkY/VxF9veip02rHL5wlJgwuvqwKT6Mxi0y9jRoywY5T1N8rqnIWAy+Hv/5P77+pX/b+bym39vUQuj0kDZ0GxojvMxZX7a8a0XyIBiGZgsr1h1qZpfr/yyNvZYNyRCVgY6mUoBlvouRHssHGZRpPRrwcvJp3wVzUMcnvmRBaKX0RU1DXWyuky7NvRYQRMkFHdThraBgU9LDqz1T338wQlLoadbS1jNkRJrYiNJsUWeLPk7iXvr5k93tZFNm9GijP/UUdDxufMNFn8GvU++KBvJlISVwzHqJgGdHX069/GrFb0zlIVvexgG8C2DNxlA4EgsmHQY8B1U9+DGkoapW8zdaUFLtkpltKwDGVJEhbYv40kM8UgmEQnxDgK+Z3a5a35bbucxVx6zRTM5AxsTPGHsgmjKwDxPXTlijWn78mIjwHv+mDdhafC2v6Qi/vCZtTCulgmQsJwceBWxWmElzGTDoYAqCA3lTW8AruXRTUou6t4SPEupHmLDUWFYzby8iltGQN/jIHJq1EnE4yL71ZUH4ibrkFgx2cBq8fVz7yohK88Me68xD+upmIoHonxlBfmkGzNBZA05XVlGAbB6/GXCIyVGJzEGiwRIMAFMs2x1sJKvM/1+p9RowFRSms9ir5chwt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(53546011)(6486002)(31686004)(36756003)(31696002)(5660300002)(8936002)(7416002)(83380400001)(38100700002)(86362001)(6506007)(478600001)(8676002)(186003)(110136005)(6666004)(54906003)(6512007)(316002)(30864003)(2616005)(2906002)(66946007)(44832011)(4326008)(66476007)(66556008)(41300700001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUpQdTFIODQ0STNieHlvTmM4RXZYQmN2YXRySyticFlVVERnOTFpL0syaXdh?=
 =?utf-8?B?dWJ3MmxEL3lac1B4cGhTTThyY0IwMHZKK2t0aGg0cWtiL2dmaWFtMEh0UGF4?=
 =?utf-8?B?cVRrdEZuNlFXVk9ZYzRXek9udTkxdXdTVWQxbUhPUmJCN21rN0g3cG9jWHNj?=
 =?utf-8?B?b2QrQVFqa2F6VEhPSVRjRHZrWUF5eUVQd0JQcCtqdThqOW4vQ08wRWJMOVBZ?=
 =?utf-8?B?S0s2WENFUzJCb2k2QU4wYW13cUorNVlzWXF2T2JFcFJSb05sQXhwMElYUmVw?=
 =?utf-8?B?Z1ROa2YxS3dsRkpZZUwwQ0RxNG5EcGVqRkc5S0phYWZvN1lRQkdWemxuVWx1?=
 =?utf-8?B?SkplWjc0aXNpaHpLRHplU0RtdGJ2aFpTWi9wOVFwYWRvMUlzd3pxTXB0Y2Q0?=
 =?utf-8?B?TjMwSDlLNVdCbjgrcmNCL00ySEEzbU41eCt5Yi90a3Vkc1VMSW1IR0FxK1BH?=
 =?utf-8?B?UEg5Um5EQ2I5aWxtaStNd2EvdDE1bEpvNlpmbVN4YmdCakJ4b1RpcEpKWGQv?=
 =?utf-8?B?RngvL2k3aWRXZVJCUDg4VS9TamxTd2dmMEtzSnhJc3RNTUVMR2k4SmdFSzZV?=
 =?utf-8?B?T1VhSzZvMEw1T2VFVnJVNkhoMHBPcVdhalIyZ1BXbmlWNXV1RmtGMTVwT0w2?=
 =?utf-8?B?YzN4b0ljWmIwN0RNN3Bsc3dTZnIwQnYxSDhmMEc0TEY1MExnMEkvZHR4bVYx?=
 =?utf-8?B?TElGVGFzakc0QU00UDZaeFNRcjEyS3R6UDVqZWxQVFk4eTd3Ui9kY05tQ25h?=
 =?utf-8?B?ZGk5dXpKNWFuUXA2RjhoSTRvUXA0LytWUW9xdDdqUVZlc0IvZDZSQURFMXNK?=
 =?utf-8?B?MTVNQ2Ewd0p6OFhNMWVuWFB6dU9oWUpVWjc5QXQ2Ui9vVThnR3JjTHBIQUti?=
 =?utf-8?B?dTVzT2x4MXdPVE14MDNwUm1WU1hKTWJKeWJ6TGxxWm1XbDZSc3JvR3p5OFhT?=
 =?utf-8?B?c1lFU3NEQkRxR2wzVmt2cWQ4WUxOaHBmSE93b3pvdCtyRk1iTnJKWVRpT3RG?=
 =?utf-8?B?T1BzZUJmQzlsZmg5ZVRRVXZGaU9MWmdoVWlucTViYS9VM3ZtTmZVaXBxTTdQ?=
 =?utf-8?B?SzhXMm1wR0xNc3dCUWIxd09CS3paN1hic2k3dk1LNVpnZ2swcTNjU3hpRVNG?=
 =?utf-8?B?RWNVRGRuUUFtbitkMUt3RS80MUFGbUQxSVhvUXdrNGFVc2Y4ZTZaZUc3UkdE?=
 =?utf-8?B?SS9zVmhYYzlZdXpOMlRNemFkYU84cEE0UllBa2lXeGJ5dzdQR0tsaFA1ZHYz?=
 =?utf-8?B?aElNNkJrYWxSaEpGeTZWMklxWE5RMWFMeEl3TFVnUlpSNHBSMkJsa2pNa1FJ?=
 =?utf-8?B?TFI2R01EQzE1SU42U1RkOFVhREVKMDRrN0RBUTVkNnBLSURhRzU2anR3TldY?=
 =?utf-8?B?NkxaWVVUTzl2N3FCMkRuaUsreHJNakNQazhYMjJ3TGpPcm1LbDdmbG5BUzg0?=
 =?utf-8?B?VkpGUjBCd1IxNkFzazVCcXcxNU1ZcXJSSFI1emNTL1o0UFhZcTZyY3RsanhP?=
 =?utf-8?B?aWVLdkRzMHQ3dGVoWGxSbTRKa0N1dVcrZmlBdS9NOTZJa3FFemtwZkhVbnFJ?=
 =?utf-8?B?SmYvOS9DdTA0eEVlcXFIM0pFcFkzMzFwNjZBSnR3aUpDZzhFeFB1bEdKRW9w?=
 =?utf-8?B?N3EzNzBIWDVxaWFoYlk5S1JPTFZPaDRObitQMURjc0xIdVhnWXVyWlkzR1BO?=
 =?utf-8?B?bEpYd0NBaS9TbVB3Y294WGVNTDNFdlhEVENKK2czU1NkUnRvK3lvbGdqa0p5?=
 =?utf-8?B?V0c3cEM4RVBzWGhYcWswdlNJYWdnbUpqQTdMY0E1NDlUclRsbHNiYmkrYmxh?=
 =?utf-8?B?UVE1NXR3Q2h1SjRvejdZWWRYSGRIQ2lFSEJZeDUyeFZ6cWtLRlpJTUZTWlJa?=
 =?utf-8?B?ZGFsbkw3bVBSK0N1OHlCTXdhek5oS0UzRWFWR2g4VGV3QmhDbG5ZYjJoRlNV?=
 =?utf-8?B?eVJ4MG5nSkVQdDF1QUpmczlIaFQxbHVKRHNXM05VMk5CWHlRR3IrdHRFZ2Na?=
 =?utf-8?B?c29yZEIwM2N0QmxPMi9ja3d5RHZyZjcyZGJ4dENiQXE0NkpSYmJhblkrR0lm?=
 =?utf-8?B?UktPejRLcnpHT28zM3J5eTR1OGhlVTU4WWRnN1BwT0QxU0tOUUt6UGdtRDhD?=
 =?utf-8?B?d3dScjI1d1hoOStXK1JBRW9adkRSSGUzemUzNkN6clhWUzBoQ0JVa1RtNG02?=
 =?utf-8?B?MnZOMlNESm04TWJMUHlucWJXc21wQm1ESHBRS2xwM3FVQTFFZnVESENvODk3?=
 =?utf-8?B?TkV2NjJPcHhZL3FMV0VmTDgyOTN3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522dfff5-35d1-4364-7bbf-08dabde0ff80
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 21:18:48.5623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LL/4suhoJbFz8C8xv+LBK4lbLuTk/kzBegIJ2o97yXCwUZt4FpaAzwug+4Cr3gaoavo0lc1+xTIg3IEnT0BTzeMbJ1jnd/blCqBnuYtGMpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030146
X-Proofpoint-ORIG-GUID: kx0Baw3PC_l92A9oL7MubMdTfwJCikce
X-Proofpoint-GUID: kx0Baw3PC_l92A9oL7MubMdTfwJCikce
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/2/22 6:48 PM, Hugh Dickins wrote:
> We want to declare one more int in the first tail of a compound page:
> that first tail page being valuable property, since every compound page
> has a first tail, but perhaps no more than that.
>
> No problem on 64-bit: there is already space for it.  No problem with
> 32-bit THPs: 5.18 commit 5232c63f46fd ("mm: Make compound_pincount always
> available") kindly cleared the space for it, apparently not realizing
> that only 64-bit architectures enable CONFIG_THP_SWAP (whose use of tail
> page->private might conflict) - but make sure of that in its Kconfig.
>
> But hugetlb pages use tail page->private of the first tail page for a
> subpool pointer, which will conflict; and they also use page->private
> of the 2nd, 3rd and 4th tails.
>
> Undo "mm: add private field of first tail to struct page and struct
> folio"'s recent addition of private_1 to the folio tail: instead add
> hugetlb_subpool, hugetlb_cgroup, hugetlb_cgroup_rsvd, hugetlb_hwpoison
> to a second tail page of the folio: THP has long been using several
> fields of that tail, so make better use of it for hugetlb too.
> This is not how a generic folio should be declared in future,
> but it is an effective transitional way to make use of it.
>
> Delete the SUBPAGE_INDEX stuff, but keep __NR_USED_SUBPAGE: now 3.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>   include/linux/hugetlb.h        | 23 +++--------
>   include/linux/hugetlb_cgroup.h | 31 +++++----------
>   include/linux/mm_types.h       | 72 ++++++++++++++++++++++------------
>   mm/Kconfig                     |  2 +-
>   mm/memory-failure.c            |  5 +--
>   5 files changed, 65 insertions(+), 68 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 65ea34022aa2..03ecf1c5e46f 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -33,22 +33,9 @@ typedef struct { unsigned long pd; } hugepd_t;
>   /*
>    * For HugeTLB page, there are more metadata to save in the struct page. But
>    * the head struct page cannot meet our needs, so we have to abuse other tail
> - * struct page to store the metadata. In order to avoid conflicts caused by
> - * subsequent use of more tail struct pages, we gather these discrete indexes
> - * of tail struct page here.
> + * struct page to store the metadata.
>    */
> -enum {
> -	SUBPAGE_INDEX_SUBPOOL = 1,	/* reuse page->private */
> -#ifdef CONFIG_CGROUP_HUGETLB
> -	SUBPAGE_INDEX_CGROUP,		/* reuse page->private */
> -	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
> -	__MAX_CGROUP_SUBPAGE_INDEX = SUBPAGE_INDEX_CGROUP_RSVD,
> -#endif
> -#ifdef CONFIG_MEMORY_FAILURE
> -	SUBPAGE_INDEX_HWPOISON,
> -#endif
> -	__NR_USED_SUBPAGE,
> -};
> +#define __NR_USED_SUBPAGE 3
>   
>   struct hugepage_subpool {
>   	spinlock_t lock;
> @@ -722,11 +709,11 @@ extern unsigned int default_hstate_idx;
>   
>   static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio)
>   {
> -	return (void *)folio_get_private_1(folio);
> +	return folio->_hugetlb_subpool;
>   }
>   
>   /*
> - * hugetlb page subpool pointer located in hpage[1].private
> + * hugetlb page subpool pointer located in hpage[2].hugetlb_subpool
>    */
>   static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
>   {
> @@ -736,7 +723,7 @@ static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
>   static inline void hugetlb_set_folio_subpool(struct folio *folio,
>   					struct hugepage_subpool *subpool)
>   {
> -	folio_set_private_1(folio, (unsigned long)subpool);
> +	folio->_hugetlb_subpool = subpool;
>   }
>   
>   static inline void hugetlb_set_page_subpool(struct page *hpage,
> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> index c70f92fe493e..f706626a8063 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -24,12 +24,10 @@ struct file_region;
>   #ifdef CONFIG_CGROUP_HUGETLB
>   /*
>    * Minimum page order trackable by hugetlb cgroup.
> - * At least 4 pages are necessary for all the tracking information.
> - * The second tail page (hpage[SUBPAGE_INDEX_CGROUP]) is the fault
> - * usage cgroup. The third tail page (hpage[SUBPAGE_INDEX_CGROUP_RSVD])
> - * is the reservation usage cgroup.
> + * At least 3 pages are necessary for all the tracking information.
> + * The second tail page contains all of the hugetlb-specific fields.
>    */
> -#define HUGETLB_CGROUP_MIN_ORDER order_base_2(__MAX_CGROUP_SUBPAGE_INDEX + 1)
> +#define HUGETLB_CGROUP_MIN_ORDER order_base_2(__NR_USED_SUBPAGE)
>   
>   enum hugetlb_memory_event {
>   	HUGETLB_MAX,
> @@ -69,21 +67,13 @@ struct hugetlb_cgroup {
>   static inline struct hugetlb_cgroup *
>   __hugetlb_cgroup_from_folio(struct folio *folio, bool rsvd)
>   {
> -	struct page *tail;
> -
>   	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
>   	if (folio_order(folio) < HUGETLB_CGROUP_MIN_ORDER)
>   		return NULL;
> -
> -	if (rsvd) {
> -		tail = folio_page(folio, SUBPAGE_INDEX_CGROUP_RSVD);
> -		return (void *)page_private(tail);
> -	}
> -
> -	else {
> -		tail = folio_page(folio, SUBPAGE_INDEX_CGROUP);
> -		return (void *)page_private(tail);
> -	}
> +	if (rsvd)
> +		return folio->_hugetlb_cgroup_rsvd;
> +	else
> +		return folio->_hugetlb_cgroup;
>   }
>   
>   static inline struct hugetlb_cgroup *hugetlb_cgroup_from_folio(struct folio *folio)
> @@ -101,15 +91,12 @@ static inline void __set_hugetlb_cgroup(struct folio *folio,
>   				       struct hugetlb_cgroup *h_cg, bool rsvd)
>   {
>   	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
> -
>   	if (folio_order(folio) < HUGETLB_CGROUP_MIN_ORDER)
>   		return;
>   	if (rsvd)
> -		set_page_private(folio_page(folio, SUBPAGE_INDEX_CGROUP_RSVD),
> -				 (unsigned long)h_cg);
> +		folio->_hugetlb_cgroup_rsvd = h_cg;
>   	else
> -		set_page_private(folio_page(folio, SUBPAGE_INDEX_CGROUP),
> -				 (unsigned long)h_cg);
> +		folio->_hugetlb_cgroup = h_cg;
>   }
>   
>   static inline void set_hugetlb_cgroup(struct folio *folio,
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 834022721bc6..728eb6089bba 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -145,15 +145,22 @@ struct page {
>   			atomic_t compound_pincount;
>   #ifdef CONFIG_64BIT
>   			unsigned int compound_nr; /* 1 << compound_order */
> -			unsigned long _private_1;
>   #endif
>   		};
> -		struct {	/* Second tail page of compound page */
> +		struct {	/* Second tail page of transparent huge page */
>   			unsigned long _compound_pad_1;	/* compound_head */
>   			unsigned long _compound_pad_2;
>   			/* For both global and memcg */
>   			struct list_head deferred_list;
>   		};
> +		struct {	/* Second tail page of hugetlb page */
> +			unsigned long _hugetlb_pad_1;	/* compound_head */
> +			void *hugetlb_subpool;
> +			void *hugetlb_cgroup;
> +			void *hugetlb_cgroup_rsvd;
> +			void *hugetlb_hwpoison;
> +			/* No more space on 32-bit: use third tail if more */
> +		};
>   		struct {	/* Page table pages */
>   			unsigned long _pt_pad_1;	/* compound_head */
>   			pgtable_t pmd_huge_pte; /* protected by page->ptl */
> @@ -260,13 +267,16 @@ struct page {
>    *    to find how many references there are to this folio.
>    * @memcg_data: Memory Control Group data.
>    * @_flags_1: For large folios, additional page flags.
> - * @__head: Points to the folio.  Do not use.
> + * @_head_1: Points to the folio.  Do not use.

Changes to my original patch set look good, this seems to be a cleaner 
implementation.

Should the usage of page_1 and page_2 also be documented here?

Thanks,

Sidhartha Kumar

>    * @_folio_dtor: Which destructor to use for this folio.
>    * @_folio_order: Do not use directly, call folio_order().
>    * @_total_mapcount: Do not use directly, call folio_entire_mapcount().
>    * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
>    * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
> - * @_private_1: Do not use directly, call folio_get_private_1().
> + * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
> + * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgroup.h.
> + * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
> + * @_hugetlb_hwpoison: Do not use directly, call raw_hwp_list_head().
>    *
>    * A folio is a physically, virtually and logically contiguous set
>    * of bytes.  It is a power-of-two in size, and it is aligned to that
> @@ -305,16 +315,31 @@ struct folio {
>   		};
>   		struct page page;
>   	};
> -	unsigned long _flags_1;
> -	unsigned long __head;
> -	unsigned char _folio_dtor;
> -	unsigned char _folio_order;
> -	atomic_t _total_mapcount;
> -	atomic_t _pincount;
> +	union {
> +		struct {
> +			unsigned long _flags_1;
> +			unsigned long _head_1;
> +			unsigned char _folio_dtor;
> +			unsigned char _folio_order;
> +			atomic_t _total_mapcount;
> +			atomic_t _pincount;
>   #ifdef CONFIG_64BIT
> -	unsigned int _folio_nr_pages;
> +			unsigned int _folio_nr_pages;
>   #endif
> -	unsigned long _private_1;
> +		};
> +		struct page page_1;
> +	};
> +	union {
> +		struct {
> +			unsigned long _flags_2;
> +			unsigned long _head_2;
> +			void *_hugetlb_subpool;
> +			void *_hugetlb_cgroup;
> +			void *_hugetlb_cgroup_rsvd;
> +			void *_hugetlb_hwpoison;
> +		};
> +		struct page page_2;
> +	};
>   };
>   
>   #define FOLIO_MATCH(pg, fl)						\
> @@ -335,16 +360,25 @@ FOLIO_MATCH(memcg_data, memcg_data);
>   	static_assert(offsetof(struct folio, fl) ==			\
>   			offsetof(struct page, pg) + sizeof(struct page))
>   FOLIO_MATCH(flags, _flags_1);
> -FOLIO_MATCH(compound_head, __head);
> +FOLIO_MATCH(compound_head, _head_1);
>   FOLIO_MATCH(compound_dtor, _folio_dtor);
>   FOLIO_MATCH(compound_order, _folio_order);
>   FOLIO_MATCH(compound_mapcount, _total_mapcount);
>   FOLIO_MATCH(compound_pincount, _pincount);
>   #ifdef CONFIG_64BIT
>   FOLIO_MATCH(compound_nr, _folio_nr_pages);
> -FOLIO_MATCH(_private_1, _private_1);
>   #endif
>   #undef FOLIO_MATCH
> +#define FOLIO_MATCH(pg, fl)						\
> +	static_assert(offsetof(struct folio, fl) ==			\
> +			offsetof(struct page, pg) + 2 * sizeof(struct page))
> +FOLIO_MATCH(flags, _flags_2);
> +FOLIO_MATCH(compound_head, _head_2);
> +FOLIO_MATCH(hugetlb_subpool, _hugetlb_subpool);
> +FOLIO_MATCH(hugetlb_cgroup, _hugetlb_cgroup);
> +FOLIO_MATCH(hugetlb_cgroup_rsvd, _hugetlb_cgroup_rsvd);
> +FOLIO_MATCH(hugetlb_hwpoison, _hugetlb_hwpoison);
> +#undef FOLIO_MATCH
>   
>   static inline atomic_t *folio_mapcount_ptr(struct folio *folio)
>   {
> @@ -388,16 +422,6 @@ static inline void *folio_get_private(struct folio *folio)
>   	return folio->private;
>   }
>   
> -static inline void folio_set_private_1(struct folio *folio, unsigned long private)
> -{
> -	folio->_private_1 = private;
> -}
> -
> -static inline unsigned long folio_get_private_1(struct folio *folio)
> -{
> -	return folio->_private_1;
> -}
> -
>   struct page_frag_cache {
>   	void * va;
>   #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 57e1d8c5b505..bc7e7dacfcd5 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -775,7 +775,7 @@ endchoice
>   
>   config THP_SWAP
>   	def_bool y
> -	depends on TRANSPARENT_HUGEPAGE && ARCH_WANTS_THP_SWAP && SWAP
> +	depends on TRANSPARENT_HUGEPAGE && ARCH_WANTS_THP_SWAP && SWAP && 64BIT
>   	help
>   	  Swap transparent huge pages in one piece, without splitting.
>   	  XXX: For now, swap cluster backing transparent huge page
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 779a426d2cab..63d8501001c6 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1687,8 +1687,7 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
>   #ifdef CONFIG_HUGETLB_PAGE
>   /*
>    * Struct raw_hwp_page represents information about "raw error page",
> - * constructing singly linked list originated from ->private field of
> - * SUBPAGE_INDEX_HWPOISON-th tail page.
> + * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
>    */
>   struct raw_hwp_page {
>   	struct llist_node node;
> @@ -1697,7 +1696,7 @@ struct raw_hwp_page {
>   
>   static inline struct llist_head *raw_hwp_list_head(struct page *hpage)
>   {
> -	return (struct llist_head *)&page_private(hpage + SUBPAGE_INDEX_HWPOISON);
> +	return (struct llist_head *)&page_folio(hpage)->_hugetlb_hwpoison;
>   }
>   
>   static unsigned long __free_raw_hwp_pages(struct page *hpage, bool move_flag)
