Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E291360F053
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiJ0GcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ0Gbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:31:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2758163398
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:31:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R4tvLM032715;
        Thu, 27 Oct 2022 06:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QHQvHiN8bK2iIZXZ024B86ANrnhfWv0QPxO+D1daW4w=;
 b=WiyTr2mUWB6yLW8t/CRK6gn29MOR4hUPwT+QWcbqhDTkyW/cQdtPhKLy94MdeliImOm7
 PalQ/hE+sAeYaBjn9VB320fH1ES0SeXWUJRe+yv9ZwIN9/hOdNF89zIjlOO+D/7N1Pma
 SBFsDN/0LM/CI3GEkmpvKyYR7OpMeZnCSssL8duC66z8uS8F6HvD9R8tCJzZ9+OVMula
 zTreAG0nEVldBRTTqU/DKTrIwTH3/s12wG8QzZKHMhGLVZj/ys0AIQnejM8e0REI0z0D
 WrRGr3OHw13lPfixZaqZTtufvTRHF/ikPDNedRi41wHTxIb63tAWWZi/KeWx45KImL/E AQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv14qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 06:31:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29R3qLk6017521;
        Thu, 27 Oct 2022 06:31:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagg5ce7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 06:31:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqLcz62NPZr9StM+Bh4Pz0Xs77P949f8RfgtHWngQTxV2+CqYosSx5phfmalyt3jj6bledkE4qhtHBi9xRZqAx2ZixZgECmAnzcvOs0T/MTHHKYlqpE0QZ4Tn6Mp0eys2jXEtQMSD3357xydUQMzUSEmvj8OdWrVKBz5hBBAfq7/pws2EcltA3xB6CvOOO+b+L8L28k7MuS4LpAbw81R0W8yaGy+jd9KyqnmIE0gvHPgNv3eRku7MbNQ4mnv3VUPd2NbHsrSto5EaPE7Kcn9j5r8EzZCKe5OMS67B6sDDiXarlWLv6uHWi8YV6amafD1SbyUDdVpe+c457Q8cvNAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHQvHiN8bK2iIZXZ024B86ANrnhfWv0QPxO+D1daW4w=;
 b=jjZLgNXDqtv6Xxmg9mgU+AAmzo2jxOOrNn8+WcX05XYQ8OGmnGa6drMS2AFKLfVALRMln4Xkg4TTG1nFEyS08S7RWnC7+QKfSZMVWXQgoU/3aCCxdwJn5VQpZZ85P9zOSMJYU4bQ/i5V+/uFiANU8ye7HzvdNWFDp6ZuMuXyHfAuGuwBtDRgaMjoxxyW7R2VWcveaTkbund4ujQXUgJeMAtOra+cWYmaz2/MPkF7r75d0O+G+LZT8jLZVx551gctIJfmzhP2YzSIKYK7S/KVcIlkAzgrK92MGLm2n05LEp4M77Dsyyj0PIGfYERx1TIXI1G5yXK6GnROvipZZKmOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHQvHiN8bK2iIZXZ024B86ANrnhfWv0QPxO+D1daW4w=;
 b=rcUurkYR2OizDjuqV43MZdcLZj+xo2qHnn4fDXgHExXaDyP0N8rRiHtfEsJroEr9DcEFP04sUh1DnmUMtvQOkkgAbVOG/GGzczhGo90frjo5ZHSig6cuHMT+e+1CLDJBy9mRIZvDG0KxrxiTUrHrTfMKj8b2MX3FfCr/9bdObG4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BLAPR10MB5090.namprd10.prod.outlook.com (2603:10b6:208:322::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 27 Oct
 2022 06:31:14 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Thu, 27 Oct 2022
 06:31:13 +0000
Message-ID: <ab5d903e-f78f-d304-24fb-de7ed73f1c55@oracle.com>
Date:   Wed, 26 Oct 2022 23:31:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
 <5b9efa3a-8a82-4bd1-a5b4-b9ca5b15b51a@oracle.com>
 <CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com>
 <25a18d7a-ebae-3647-32f0-14ad733118be@oracle.com>
 <38b9648b-8795-5b41-b06c-d13a1a6d5d3f@redhat.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <38b9648b-8795-5b41-b06c-d13a1a6d5d3f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::13) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BLAPR10MB5090:EE_
X-MS-Office365-Filtering-Correlation-Id: 386a6642-df98-49f8-d296-08dab7e4d853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vsY/0rqjPuTBesQEjF6rYEOR71bcxqsF1yOWAsZjW21bQHJyTIHgcKd6wAAV9hYvzmDxOZ9kVok4NCUcNYc64UB2GeqEiE0BwPwpddvYyIAAr+oVnwcB2K346e42fJInNzk0HEE8qE/LbgV3YejIpCNHhOSt3KTIZapi7fqomOhEf755s9E+RWNkSuSOR0R1aRBw8EPBt4Am8T6OaVdifnagnklox2HP8XvKnJKgfv+tnW7azAcGbG4AnL28rpAC/nEaRpiXC2h3Xq2+x7WwlLfTKdcIvpNq7UPfkVein/c1+J1pBmgJters10OKtTnNYhzr0fztHpRzjRBF+VOEqMRmd56pkU9cPNwBC2ZD7QYF5Rq7OW88fhmrGh1TrUsB6ZICo1FjS3zbjJiiOO/e15ufrv7XRZTU2iuuhDZ57JTBpsjRUJkEbG6ymSzcEA1UJztXdcAUWbgPt6PHrQ+9R1yjOtxWWUxoKr1Oe6ynKgat5aS9eGkC/9l83fiH0pQ1Nf5CnqwcyXPSzUXWM3Uxlg1vWiqGD8L/XYy0t8LpOBAHQxBSf19Yp/oXE4VIQAaWf17mLmCKHudPFqvBGIwuloG2jlH7DIw/osO6adeofVi+YfeGZnApmJy6Nf/x/Hz7qsyMHqxkcGPGL/zTrL3SaDenctsmFZYJvzsOf1ow6u8nEkLUc3KX1KAXDkZJLWDrzbqCYiTm9DEypmDMEmkFijmAgmlk3qgzNnCxFT9AarzrqTZLtTyJa5fF/ykt7m4Cv/0T3jH6HSVTR0/NQ2rH0gbOBO9ccFRNzaXG3TN24E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(478600001)(6506007)(6486002)(53546011)(36916002)(38100700002)(30864003)(316002)(6512007)(36756003)(6916009)(26005)(186003)(83380400001)(86362001)(2906002)(2616005)(31696002)(8936002)(66946007)(66476007)(41300700001)(4326008)(31686004)(5660300002)(66556008)(66899015)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWNZc1VEQkRDMzhxZW1jbUZNWVBXMDBaRWsvc3ZMVjIvSUdaQ3F2MU84MWFI?=
 =?utf-8?B?M2lmSE9hdVFqbFVqUnFtQUNsTjgwYk8xSlM4ZmJWdFZEU2JvV3ZQWkZzM0hE?=
 =?utf-8?B?OHdLWnBwaWNkUldDcnQ4S1YwcmlDNVQ3eXRMTVpYVFNnMFFmUXJkYXVkUHFW?=
 =?utf-8?B?TUxUYXdKZjY1eFFPeTd5Y01aSU9iRnBMcTA4b0JVYTJoSXRwVGpicFBIQm5Y?=
 =?utf-8?B?a0JKN3VhdXpIRk1NbUhhT0hMaWZtOWdGdDBjSGZIbDc3bVE4RWw0MGtPN0M5?=
 =?utf-8?B?ZFJBOVVCNElUMzk0UXdYNHY2TW5tVDhXc05rU21zOEJYOThnSVZScFhRNVBH?=
 =?utf-8?B?d01wS3g1aFFWREp6SEdOSWpTa3BDZjU3Z3p3MDFZbnR0TkJOZUVwT25jSlRw?=
 =?utf-8?B?Q3Bxd3dHZjI2ZWlQcjJVWFJKTEtWdzlJV1dFQTVIeDZCKzJBNm5QZkFqVWh5?=
 =?utf-8?B?VEx2eHdnelNTNGpWZlVhSTBGUDBwVStxN1J2a2thaXFBelc0TWdVTGRYWVFs?=
 =?utf-8?B?eHNrWkFxTnNHOVg1YUNDV1BEUkxMam9Yakh4YVpuK1U2bTdCVDVGMVJzdm9X?=
 =?utf-8?B?VHFhN3dqTWo5Qnc4TEVRbk9jZUJnb3FGMzk0WmFjbjNDTlRMNFlnQVN1eExM?=
 =?utf-8?B?Wk41ay9pNnBwNG9wQTlTMHFRbVN1NElGL1gwZlc1OUF1dzRrcXB3NGdSZXRC?=
 =?utf-8?B?YlRtM04rZDJhRVZwbzhKWEZ0MzhXZlc4VTVQTERrMXFObGNNRWZ5bXl5UEVt?=
 =?utf-8?B?WkpkakxpbjFQa1QxSVpuM2x0bGZuV0h6alNWY0R2Qi8zUjFRWWRsSXVOUWlq?=
 =?utf-8?B?eVVFeTUvdmpOc2ZoeW5LWE9rUUhPYzVkdmtWY0NjcGg0R2RqWk1FNFF1TCtH?=
 =?utf-8?B?WE9VZmRubnlnTzF1MURLeHVNWFFLZHFJOC9QTzBQVXp1M2dGbEFrZzRyMEUv?=
 =?utf-8?B?UVhGVVFFbms1Q2FVcW1IZ0ttenlPYmlNMDY5ZzYvVG1yTlNPajRON0VYVldI?=
 =?utf-8?B?QnJBbnZlMGJCV3pVc1Q2SE53MU1obFZuWWpCNU1iSm43NjZmenRFamJ5Ykx3?=
 =?utf-8?B?WXphbk1JR1NjUC9QVUtLUU5WbWpQTW1acmFUVEtoc09iQ0ZrOWhmV2JVckRm?=
 =?utf-8?B?RmdMQlBDVXZReFB4dWhVNGkzamdJSTVBWlJPTkFaN2RPZERkSDRyeFcrb1Z3?=
 =?utf-8?B?NndHaDFhYzY3V1R3OUZYU0JiV3NLOFc5c2hrRHJENFYxNk1WOTVlRVdmWmVr?=
 =?utf-8?B?ckFmT2toNXpONGxWNlMyc1U0WHpIanEweTl2dUtBMmVyMWZEaGpKOFdoRk9h?=
 =?utf-8?B?QzhtOWZNRm5tM2R6c3VXd001bGU1ZVI2THFUbkM0SHduSGV6bVlVdll6dHpa?=
 =?utf-8?B?eXpqYjlhRlAwY2JmUkZIYmhWZkJobC9WVTNDWWxuL2hpUllUUGdoNXN6S0sr?=
 =?utf-8?B?SzQ3a0JqbzYrajBIbWVETmw1SlJoUTkyTXJPZnIxQ0w1Z29GVmVqZ3pCbmVv?=
 =?utf-8?B?L0JZbUFkTWg4SjZkL3hXcWRyWVhsbFVUZEhQMjdMb1BFbUdId3JscGdKQjI5?=
 =?utf-8?B?TmRTUS9ITzBpSnFnamFsSXlMMm9nakx2OWZzelVFNjBaUmRBdjBMN1hZZWJX?=
 =?utf-8?B?Zm90a0lIbmtYQ3h2N0JabUMvOXJvekU4Y1dXNjMyZ3VoRG9zNWk0V29SWkd6?=
 =?utf-8?B?VmpLcVBOUklFcStSbUwzVnEyMnpHRTM1dS8zRnA3R1gyaUJrczFUV3VHVERr?=
 =?utf-8?B?d3dGVUwxMW9ObzB5RXNvUUFDZEkwY1pJSDljdWozb05acmtXN2x0c3ZScmVk?=
 =?utf-8?B?a3ByejdFdW54UkZURThqbGNBY1k5NjVZVDB1SnViSC9kWWpQYUcvU3RUdUYz?=
 =?utf-8?B?ODBuOC9vd2h1Y2RyVkdlVFJwaG55V2REc2trVEphT0YzcW9GS1p5bm9uaHBl?=
 =?utf-8?B?TGRuRDcwRVdybzUzREhkM2ZWUTNKaWtlQks0aDl1WVRISWE5SnJSazR4bmZx?=
 =?utf-8?B?bCsxZU8xaDRWbU5aMUdSMldqdnRRZEl2TnVyYmthM0NXdzFGVHhiRVltSTlY?=
 =?utf-8?B?NGRlWTN6ajNPb0JjUS96ME1XSzJqZGxLY1NVS281NWZ2cWJmbjdlVDFrRE5q?=
 =?utf-8?Q?Av++pDhOtLswB9DaEYguuix/s?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386a6642-df98-49f8-d296-08dab7e4d853
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 06:31:13.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gx9DemwSafBwM04FqNCfL34yl3JH+y1k7cwb/cFHbFBZdIrUomI8QNbefj2lIkZYvd3FLxM3Q7bNzOu6vrs+ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_02,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270036
X-Proofpoint-ORIG-GUID: wmLoQ8O2REDqXEtUYWwxNvPQHJAuzvLP
X-Proofpoint-GUID: wmLoQ8O2REDqXEtUYWwxNvPQHJAuzvLP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2022 9:44 PM, Jason Wang wrote:
>
> 在 2022/10/26 09:10, Si-Wei Liu 写道:
>>
>>
>> On 10/24/2022 7:24 PM, Jason Wang wrote:
>>> On Tue, Oct 25, 2022 at 3:14 AM Si-Wei Liu<si-wei.liu@oracle.com>  
>>> wrote:
>>>> On 10/24/2022 1:40 AM, Jason Wang wrote:
>>>>> On Sat, Oct 22, 2022 at 7:49 AM Si-Wei Liu<si-wei.liu@oracle.com>  
>>>>> wrote:
>>>>>> Live migration of vdpa would typically require re-instate vdpa
>>>>>> device with an idential set of configs on the destination node,
>>>>>> same way as how source node created the device in the first
>>>>>> place. In order to save orchestration software from memorizing
>>>>>> and keeping track of vdpa config, it will be helpful if the vdpa
>>>>>> tool provides the aids for exporting the initial configs as-is,
>>>>>> the way how vdpa device was created. The "vdpa dev show" command
>>>>>> seems to be the right vehicle for that. It is unlike the "vdpa dev
>>>>>> config show" command output which usually goes with the live value
>>>>>> in the device config space, and is not quite reliable subject to
>>>>>> the dynamics of feature negotiation or possible change by the
>>>>>> driver to the config space.
>>>>>>
>>>>>> Examples:
>>>>>>
>>>>>> 1) Create vDPA by default without any config attribute
>>>>>>
>>>>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
>>>>>> $ vdpa dev show vdpa0
>>>>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 
>>>>>> max_vqs 9 max_vq_size 256
>>>>>> $ vdpa dev -jp show vdpa0
>>>>>> {
>>>>>>       "dev": {
>>>>>>           "vdpa0": {
>>>>>>               "type": "network",
>>>>>>               "mgmtdev": "pci/0000:41:04.2",
>>>>>>               "vendor_id": 5555,
>>>>>>               "max_vqs": 9,
>>>>>>               "max_vq_size": 256,
>>>>>>           }
>>>>>>       }
>>>>>> }
>>>>>>
>>>>>> 2) Create vDPA with config attribute(s) specified
>>>>>>
>>>>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
>>>>>>       mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>>>>>> $ vdpa dev show
>>>>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 
>>>>>> max_vqs 9 max_vq_size 256
>>>>>>     initial_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>>>>>> $ vdpa dev -jp show
>>>>>> {
>>>>>>       "dev": {
>>>>>>           "vdpa0": {
>>>>>>               "type": "network",
>>>>>>               "mgmtdev": "pci/0000:41:04.2",
>>>>>>               "vendor_id": 5555,
>>>>>>               "max_vqs": 9,
>>>>>>               "max_vq_size": 256,
>>>>>>               "initial_config": {
>>>>>>                   "mac": "e4:11:c6:d3:45:f0",
>>>>>>                   "max_vq_pairs": 4
>>>>>>               }
>>>>>>           }
>>>>>>       }
>>>>>> }
>>>>>>
>>>>>> Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
>>>>>> ---
>>>>>>    drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
>>>>>>    1 file changed, 39 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>>>>> index bebded6..bfb8f54 100644
>>>>>> --- a/drivers/vdpa/vdpa.c
>>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>>> @@ -677,6 +677,41 @@ static int 
>>>>>> vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct 
>>>>>> genl_info *i
>>>>>>    }
>>>>>>
>>>>>>    static int
>>>>>> +vdpa_dev_initcfg_fill(struct vdpa_device *vdev, struct sk_buff 
>>>>>> *msg, u32 device_id)
>>>>>> +{
>>>>>> +       struct vdpa_dev_set_config *cfg = &vdev->init_cfg;
>>>>>> +       int err = -EMSGSIZE;
>>>>>> +
>>>>>> +       if (!cfg->mask)
>>>>>> +               return 0;
>>>>>> +
>>>>>> +       switch (device_id) {
>>>>>> +       case VIRTIO_ID_NET:
>>>>>> +               if ((cfg->mask & 
>>>>>> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &&
>>>>>> +                   nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
>>>>>> +                           sizeof(cfg->net.mac), cfg->net.mac))
>>>>>> +                       return err;
>>>>>> +               if ((cfg->mask & 
>>>>>> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) != 0 &&
>>>>>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, 
>>>>>> cfg->net.mtu))
>>>>>> +                       return err;
>>>>>> +               if ((cfg->mask & 
>>>>>> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &&
>>>>>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
>>>>>> + cfg->net.max_vq_pairs))
>>>>>> +                       return err;
>>>>>> +               break;
>>>>>> +       default:
>>>>>> +               break;
>>>>>> +       }
>>>>>> +
>>>>>> +       if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
>>>>>> +           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
>>>>>> +                             cfg->device_features, VDPA_ATTR_PAD))
>>>>>> +               return err;
>>>>> A question: If any of those above attributes were not provisioned,
>>>>> should we show the ones that are inherited from the parent?
>>>> A simple answer would be yes, but the long answer is that I am not 
>>>> sure
>>>> if there's any for the moment - there's no  default value for mtu, 
>>>> mac,
>>>> and max_vqp that can be inherited from the parent (max_vqp by default
>>>> being 1 is spec defined, not something inherited from the parent).
>>> Note that it is by default from driver level that if _F_MQ is not
>>> negotiated. But I think we are talking about something different that
>>> is out of the spec here, what if:
>>>
>>> vDPA inherit _F_MQ but mqx_vqp is not provisioned via netlink.
>>>
>>> Or is it not allowed?
>> My understanding is that this is not allowed any more since the 
>> introduction of max_vqp attribute. Noted, currently we don't have a 
>> way for vendor driver to report the default value for mqx_vqp, 
>
>
> I think it can be reported in this patch?
Yes, we can add, but I am not sure whether or not this will be 
practically useful, for e.g. the same command without max_vqp specified 
may render different number of queues across different devices, or 
different revisions of the same vendor's devices. Does it complicate the 
mgmt software even more, I'm not sure.... Could we instead mandate 
max_vqp to be 1 from vdpa core level if user doesn't explicitly specify 
the value? That way it is more consistent in terms of the resulting 
number of queue pairs (=1) with the case where parent device does not 
offer the _F_MQ feature.

>
>
>> if not otherwise specified in the CLI. Without getting the default 
>> value reported in 'vdpa mgmtdev show' level, it'd just confuse mgmt 
>> software even more.
>
>
> Yes, this is something that we need to fix. And what's more in order 
> to support dynamic provisioning, we need a way to report the number of 
> available instances that could be used for vDPA device provisioning.
Wouldn't it be possible to achieve that by simply checking how many 
parent mgmtdev instances don't have vdpa device provisioned yet? e.g.

inuse=$(vdpa dev show | grep mgmtdev | wc -l)
total=$(vdpa mgmtdev show  | grep "supported_classes" | wc -l )
echo $((total - inuse))

>
>
>>
>>>    At least some time in the past, mlx5 were
>>> enabled with MQ with 8 queue pairs by default.
>> That was the situation when there's no max_vqp attribute support from 
>> vdpa netlink API level. I think now every driver honors the vdpa core 
>> disposition to get a single queue pair if max_vqp config is missing.
>
> So we have:
>
> int vdpa_register_device(struct vdpa_device *vdev, int nvqs)
>
> This means technically, parent can allocate a multiqueue devices with 
> _F_MQ features if max_vqp and device_features is not provisioned. And 
> what's more, what happens if _F_MQ is provisioned by max_vqp is not 
> specified?
>
> The question is:
>
> When a attribute is not specificed/provisioned via net link, what's 
> the default value? The answer should be consistent: if device_features 
> is determined by the parent, we should do the same for mqx_vqp. 
OK I got your point.

> And it looks to me all of those belongs to the initial config 
> (self-contained)
Right. I wonder if we can have vdpa core define the default value (for 
e.g. max_vqp=1) for those unspecified attribute (esp. when the 
corresponding device feature is offered and provisioned) whenever 
possible. Which I think it'll be more consistent for the same command to 
get to the same result between different vendor drivers. While we still 
keep the possibility for future extension to allow driver override the 
vdpa core disposition if the real use case emerges. What do you think?

>
>
>> And the mlx5_vdpa driver with 8 queue pairs in the wild days is just 
>> irrelevant to be manageable by mgmt software, regardless of live 
>> migration.
>>>> And
>>>> the device_features if inherited is displayed at 'vdpa dev config 
>>>> show'
>>>> output. Can you remind me of a good example for inherited value 
>>>> that we
>>>> may want to show here?
>>> Some other cases:
>>>
>>> 1) MTU: there should be something that the device needs to report if
>>> _F_MTU is negotiated even if it is not provisioned from netlink.
>> I am not sure I understand the ask here. Noted the QEMU argument has 
>> to offer host_mtu=X with the maximum MTU value for guest to use (and 
>> applied as the initial MTU config during virtio-net probing for Linux 
>> driver), 
>
>
> Adding Cindy.
>
> I think it's a known issue that we need to do sanity check to make 
> sure cli parameters matches what is provisioned from netlink.
Right. How's the plan for QEMU to get to the mtu provisioned by netlink, 
via a new vhost-vdpa ioctl call? If so, will  QEMU be able to read it 
directly from kernel when it comes to the vhost-vdpa backend, without 
having user to specify host_mtu from CLI?
>
>
>> and the way to get the parent device MTU and whether that's relevant 
>> to vdpa device's MTU is very vendor specific.
>
>
> So I think the max MTU of parent should be equal to the max MTU of the 
> vDPA.
Noted here the parent might not be necessarily the mgmtdev where vdpa 
gets created over. It may well end up with the MTU on the PF (uplink 
port) which the mgmt software has to concern with. My point is the 
utility and tool chain able to derive the maximal MTU effectively 
allowed for vDPA device may live out of vDPA's realm. It's a rare or 
even invalid configuration to have vDPA configured with a bigger value 
than the MTU on the uplink port or parent device. It's more common when 
MTU config is involved, it has to be consistently configured across all 
the network links along, from parent device (uplink port) down to the 
switchdev representor port, vdpa device, and QEMU virtio-net object.

>
>
>> I think we would need new attribute(s) in the mgmtdev level to 
>> support what you want here?
>
>
> Not sure, but what I want to ask is consider we provision MTU feature 
> but without max MTU value, do we need to report the initial max MTU here?
Yep, maybe. I'm not very sure if this will be very useful to be honest, 
consider it's kinda a rare case to me were to provision MTU feature 
without a specific MTU value. If one cares about MTU, mgmt software 
should configure some mtu through "vdpa dev add ... mtu ...", no?

On the other hand, no mtu value specified may mean "go with what the 
uplink port or parent device has". I think this is a pretty useful case 
if the vendor's NIC supports updating MTU on the fly without having to 
tear down QEMU and reconfigure vdpa. I'm not sure if we end up with 
killing this use case by limiting initial max MTU to a fixed value.

>
>
>>
>>> 2) device_features: if device_features is not provisioned, we should
>>> still report it via netlink here
>> Not the way I expected it, but with Lingshan's series to expose 
>> fields out of FEATURES_OK, the device_features is now reported 
>> through 'vdpa dev config show' regardless being specified or not, if 
>> I am not mistaken?
>
>
> Yes.
Do you want me to relocate to 'vdpa dev show', or it's okay to leave it 
behind there?

>
>
>>
>> Currently we export the config attributes upon vdpa creation under 
>> the "initial_config" key. If we want to expose more default values 
>> inherited from mgmtdev, I think we can wrap up these default values 
>> under another key "inherited_config" to display in 'vdpa dev show' 
>> output. Does it fit what you have in mind?
>
>
> I wonder if it's better to merge those two, or is there any advantages 
> of splitting them?
I think for the most part "initial_config" will be sufficient for those 
config attributes with "vdpa dev add" equivalents, be it user specified, 
vdpa enforced default if missing user input, or default overridden by 
the parent device. "inherited_config" will be useful for the configs 
with no "vdpa dev add" equivalent or live out side of vdpa tool, but 
still important for mgmt software to replicate identical vdpa setup. 
Like max-supported-mtu (for the uplink port or parent device), 
effective-link-speed, effective-link-status et al. Let's see if there's 
more when we get there.

Thanks,
-Siwei

>
>
>>
>>> or do you mean the mgmt can assume it
>>> should be the same as mgmtdev. Anyhow if we don't show device_features
>>> if it is not provisioned, it will complicate the mgmt software.
>> Yes, as I said earlier, since the device_features attr getting added 
>> to the 'vdpa dev config show' command, this divergence started to 
>> complicate mgmt software already.
>>
>> Thanks,
>
>
> Thanks
>
>
>> -Siwei
>>> Thanks
>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>
>>>>> Thanks
>>>>>
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int
>>>>>>    vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, 
>>>>>> u32 portid, u32 seq,
>>>>>>                 int flags, struct netlink_ext_ack *extack)
>>>>>>    {
>>>>>> @@ -715,6 +750,10 @@ static int 
>>>>>> vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct 
>>>>>> genl_info *i
>>>>>>           if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, 
>>>>>> min_vq_size))
>>>>>>                   goto msg_err;
>>>>>>
>>>>>> +       err = vdpa_dev_initcfg_fill(vdev, msg, device_id);
>>>>>> +       if (err)
>>>>>> +               goto msg_err;
>>>>>> +
>>>>>>           genlmsg_end(msg, hdr);
>>>>>>           return 0;
>>>>>>
>>>>>> -- 
>>>>>> 1.8.3.1
>>>>>>
>>
>

