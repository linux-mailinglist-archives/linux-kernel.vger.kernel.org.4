Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BEA601DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiJQXfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJQXfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:35:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ED87962E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:35:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HNYXrj019054;
        Mon, 17 Oct 2022 23:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KaN1jFEJeIG2syTHMM6Hxhv/vBl/iOzTk1XYoJOajXU=;
 b=N8YwfASGibjKyqxnv6Wn4v0UBv8sfxGrZK7X669zPxUxXMJVMRzc1bWz0rj/NVIW07yN
 Zn1epAlNCUDPQtWpBdWkhJPbhVRWymopcxd4hnZGYBK1XHJbgFKuLZ6PeTV+0Op4ujxe
 p9exl9/+2gAtrN6qROk4SSSfJmQcWweWCQwCCqYJwZzSdBuL2tb9YtRnTsjs+o9hO7in
 5zgqYz273GLivu+nBRvhQeLJlqK9o3eQufwCVjABlr38Fb5Tm0Kb39iUGCAQ5layeKRM
 7H7gd+G62CzhND5P9fVn6CnpY/OKcdm3UB5kOt+KS19sgf99Mi66biLiWjDyLCHiSGq0 BQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7ndtdesn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 23:35:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29HJoJH3019373;
        Mon, 17 Oct 2022 23:35:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0psrhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 23:35:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Esu98/OXXQ1iSIZJxalRS25jSolXdpunsHOr1yp8X9G59eAr2tMV6xPqOoOpQtbSRVq1nkEaxxEHxNjc/9/6KS0UkD+IQCVmzkD+7zJX82TyNL+sH9hUu9Hojm/M3j4kEuSrHZCtP2FdgdFYcXTI2ltZCLZmsY/JVF1FOThyhFcXSfYhidgIfchBy14jef+rpEjRDi4stVFKTMar94ORKCDdsahznsHIEwmH812SNeYGfVxOA+syVq8I+qj5oGR2m+G/Iq4ymsOx7IMI87BbjbRol4nUV80JI9RdlphyvYAOsKeKHSB4CQis9VxCIY+1dOx3Xco8nGb51XQZ+PbNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaN1jFEJeIG2syTHMM6Hxhv/vBl/iOzTk1XYoJOajXU=;
 b=FD4tBWyWY1Porgvp5Cz4E8oXTLQXVULNm2XTuyuLxkS6emM/5lf44jAqkD2UC+wOrdL+UHOLWnDgngXPr/9bnxhw9G6F+6DGVTc4CUZivM/a5p7x4qELS435Yzqn5TGI/dK1j595MBJG4x7Zhp6ZBKrGSPnuwON2dhkPvIcDFsRGihv3L5uaC4ugHWz8fz9ezy1CZyBvzm9FQkI1RuD6BXeaw0kzhVSQUEONn5G18SLE8NtB2jyG6htL20TCZ6obaKdHQOdU7HHi66lP8fVjw6TYijgtKosTmXqJb8BA0rgqwairH6f2o6tBydscDduT12ufdhz6hZUwUzCArKlxIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaN1jFEJeIG2syTHMM6Hxhv/vBl/iOzTk1XYoJOajXU=;
 b=iyAbS6rI//6hZ/GlXRtPkCvitmHDMgxgWXzj2mrAIw6TJzeQPaHTWVW3XEh3vVLXY6nCMA/UQzDDkqZ2PUe5ObmF8XwPx3Bq9HlxnIeR7Rw70U6q7h418JpBDVlh2S8wz3OSBcNPkzaxZdGWr/YnbB2IOZPy5nghA3Xs8+sht5s=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by MN2PR10MB4224.namprd10.prod.outlook.com (2603:10b6:208:1d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 23:35:36 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 23:35:36 +0000
Message-ID: <5887b71e-cef2-a7b9-133c-e4ba860bf24a@oracle.com>
Date:   Mon, 17 Oct 2022 16:35:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 0/4] vDPA: dev config export via "vdpa dev show" command
Content-Language: en-US
To:     Sean Mooney <smooney@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Daniel Berrange <berrange@redhat.com>
References: <1665793690-28120-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvaKnqS-0p7iqyHP_Wbbj1YdmPFA7ABfKK_8FbXMsZEkg@mail.gmail.com>
 <08d98212a355fdce5820d57bd0ffaf3ca0968531.camel@redhat.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <08d98212a355fdce5820d57bd0ffaf3ca0968531.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:805:66::23) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|MN2PR10MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 32911754-2a4e-49d6-286c-08dab0984a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPt4pp3LzYG58GdCele2dNZsGPXTE0FWe+niHlU+k6CcViiqme5erFp56oehmmCBvgZvikWnMTY9YP1B6UKBlnOB6xEss3cN/USSg4L/tCO9mbWOnkQuFi9l0aWd9Vm3pKRjp2uk+LAw0CC6eNbKRKa4gO7UMBAEPPm2iRt1R6ag2IwKulAFDJi/P0+VeV+i84lASFZiC1S8CnsscegHeNYjZQzrAmwf//MBmC1Ys68CBjlTGfeHkYHminVvatwnZfCOXnkuSvFhN0lF0k6bnc/4IffnIovuvApoFkMxmyowMlW0++m7PdfkICkOpwMgvWtkkopYNKjdIIEvuwOiv2kh3vr5A12Tkg7g+Q/hFgGWg6ai+zQ1nAsT2sPLu1+l0fOLmpwmAGTfi+tJeSFl2WovHWO3cBcv59Q3HT37qKzwYMH74//O9vNLThiXje6Xro5Teq/TvF03nbI5vWo7TEGUhrMo6Uu7g9s5DoiqjmkYmsbehCd5RcabB1r6JZoxR6g81+I/e2PMzh1Pe8hVTKFJCyq1VGs0kAOxUEPLnd6g8ZijMirYPpOnTfyD3Qzt4yuFWKAjPBy5ohvVl7eaCYeNnip5XnVglMzQdmyJWILQP3arwEJCb89AiAAg1Ichu3gsx8IY4S+NZ/CKP/az8L49SvMt1/LAFQL1+7Ggcr/LIlBmGeGM6IxlEDsGyK9gx4bt4tAOCJ1IDcVOODbTf6nPjVKAhJRKV3XmkdzERuW3wQchWprYv7rai+PRc6LLSMJkkJpEnD+49hiiNQNEvPD6FvzEYIUcoblNg4zGiIxgilPpYLRESM7QSfRJX2mVPNI+JEVgsO8636SmziH9HQZMN3Lhxgs1tKyANSrVf+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(66899015)(36756003)(31686004)(86362001)(31696002)(30864003)(2906002)(5660300002)(4001150100001)(38100700002)(2616005)(186003)(83380400001)(41300700001)(26005)(36916002)(53546011)(966005)(316002)(6506007)(478600001)(6512007)(110136005)(6486002)(66946007)(66476007)(66556008)(8936002)(4326008)(6666004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDJuLzF0M1JWMitra1AyckFUTWxrNlJiUVIvTHJxL3l4YWQ1eXU1b1JXd09z?=
 =?utf-8?B?bHdIeVFJYmQ5K0krcGRzTzh6QzAydDZGVTFPV2tJam9icTAwSnA4RHZPNXF0?=
 =?utf-8?B?bmh2c2I3K1NYLzhDT0xpZG15NnZOOStJTFR1Q0RrRk9OUUU4VVJSZGlDTlEy?=
 =?utf-8?B?dmZwbnppdUpUWVR2QWhFekR0Rk1sbVF1WXlsdlJBMUlQV1pxUHVFanFYTHYw?=
 =?utf-8?B?RDdWRGZQajFSSFgyS0dBd2llb2ViRFVLMDVLL1pibUlZU2xMa0QzV1VKM3pt?=
 =?utf-8?B?RVdpUkt3dlZjZU9IWW81K2YvVnZFNklpN0xhc3BvVFhkbkZ6OExBSGJWQ2Rj?=
 =?utf-8?B?NHpvekdvdWl2cVhFN3RFWTBNMmVNd1ZPMS9SRU5GcTlrVjR0TDhSSzBOTHB3?=
 =?utf-8?B?dTZ6N2ZpSFM5akdkUVNUQ0lDTXNWUVQzR2lyMUxXTWphTWR0aWVaVWdFbHBT?=
 =?utf-8?B?NFkxRjRTNlFIQUorV2hZSHlIZWNURzNDOEs2QXh6YXJkOEpOMVRvT1czUHBJ?=
 =?utf-8?B?TTRlS0FhTFNxMThnazlMakxtclNhbEovZTJ6Z2d0Z3pHWnh1NDJhNG42Tktw?=
 =?utf-8?B?SHpSN3Y5RUdXa3ptcmRDVXUwTnF4Vjh3eVpRblIwMWFtQmZVRnVod3BENHlJ?=
 =?utf-8?B?ejlOK0N6b2thdU95YXJDaW8rMm8xK3RPY1YyeVY1UWhuUTlUdWsySzV0dmNu?=
 =?utf-8?B?TllxdXhiL0F3S0hrWXMxMDcvNTdWOEUvMHRkNDZVSzRYM2JMdVFlRUo5Skdh?=
 =?utf-8?B?TEljWTZTdXZwTnZhN011dWRLck1nVGJybFBlOUx3UjBiVjRrNTZQRGRmK01s?=
 =?utf-8?B?dlFGakFZRldBZDF5Tk1BTGp1Q3R1bEg5d1hRNzFZOXNvdkRXQ0I5Rnd2OFho?=
 =?utf-8?B?ZUgrYVUrbzJxb25xS0hlWU1rL0I4QkZZUnhQWCtSMURuNzlhclQvTkovSmQ4?=
 =?utf-8?B?VktINHFxTGw2a2hyOUc0ZHRxc2VRSVVKYTlPNTNwMk50TnV2MXZUQkNOMEZn?=
 =?utf-8?B?N1AvOEl4aklnZ253ZWFzbWJ2ZGkwVDFHbkNYb2owVUVQaFhEREF3UU5OdzZ4?=
 =?utf-8?B?L1VlMU1YMm9OTEo5UmhGRXhZYWhCTkh4QkNCa1IxVjh0RWg1bzdzZkJVbnVa?=
 =?utf-8?B?T0RYMFFKaXB5NFRUYnUxem9LTzg2clg0WnBEMWdObWQ5NkNJZDYvYytvWDQw?=
 =?utf-8?B?aExsZjdaMlhYUFlYcm1kZ2RIM2srck1SalowYW01akVTd1Z5akRWMDQyc0pn?=
 =?utf-8?B?azYvenl0ckdJbEJFU2NkNlRQRnB5MkJFVnBacnhxN1RGTnRTeWd5UGJFcUFZ?=
 =?utf-8?B?a3QwUzFURkdZc0VTTDVOUFgrOFJ6dnN4SG9uc3Y1MDgyL0t2L0NiQVBlTitM?=
 =?utf-8?B?ZzhiaTlXNWJjdkVPbmdFWm82SDB0WHMrSFQ2QWhoTW5lL0taR2RBYkRvMHNL?=
 =?utf-8?B?R1JhOWtVYi83dHFtdFlQNG8wc0s1cWt6TjZISTF4UDhUOEwycTdBdjdtNnlM?=
 =?utf-8?B?d1ZkL2JqYWpGbURjNG9oK2VSWTJsVDBSUU50RDVHaExRcUVoYURPaFFoalZL?=
 =?utf-8?B?UVNpWW5rMXVZai9ZdlduQk1FdldGLzJHLzRwZVR5bU5UYnBLZGJpU2JvSytB?=
 =?utf-8?B?S011OHBaSjJIS0NXbHZWamM4RXM3VzlOZ0grN0ZlR0VNY2hvYWxIRmlzczBS?=
 =?utf-8?B?M2s0TzVqUWliTWVOSklTbDhTaTN1U1lYazAvYzdneWJPZVVjL2ppTktKT09i?=
 =?utf-8?B?U0R2U3ZDY0wyenE3b1VUbjlSbVJUWXJDVEVnRVdLL3BUcGlsd21tZDlPQTQ3?=
 =?utf-8?B?YWlYeHRkem1LUHpSRW9tdmNOMTlRR2oyVEZkVmVOQVF5Smg3ME5IRmtFQ2c5?=
 =?utf-8?B?UTFOcUdRMWF2dlNYS09HWENJVkpmWkRaRUhYdFNmNGFxdGNqSG1WenRFRHN1?=
 =?utf-8?B?Vmlrd2FVUHowMmlKbUprMEIvNU9iWExlUkM5Y3U0TnJZMFAyYmgzVjFPNUtj?=
 =?utf-8?B?THNaZ29wd1RNcW5UNHRXVm9WQVhxWGNUOHlWdTNBMVArSXVRU05SRmNIVlRJ?=
 =?utf-8?B?LzZrTkd3ZElxVjJwSURYUXJQYVZpeWpwc3M2ek9QeDlDeWNuc2l2cXpDMitI?=
 =?utf-8?Q?D4Yy7dNQtbm/wWJDGu7rXygYw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32911754-2a4e-49d6-286c-08dab0984a90
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 23:35:36.0856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0Y1Zp1SFxlFsYGRlCd0wKym4lEHcKSsUDl5GBKqazyE8g3CjnpWRkuiZ8JgD77dv4uC0BwepKplOfGXzV9bgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170134
X-Proofpoint-ORIG-GUID: _KWS_QNTT21D6B1Yx8jo_cUx9RU3NmNS
X-Proofpoint-GUID: _KWS_QNTT21D6B1Yx8jo_cUx9RU3NmNS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2022 5:28 AM, Sean Mooney wrote:
> On Mon, 2022-10-17 at 15:08 +0800, Jason Wang wrote:
>> Adding Sean and Daniel for more thoughts.
>>
>> On Sat, Oct 15, 2022 at 9:33 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>> Live migration of vdpa would typically require re-instate vdpa
>>> device with an idential set of configs on the destination node,
>>> same way as how source node created the device in the first place.
>>>
>>> In order to allow live migration orchestration software to export the
>>> initial set of vdpa attributes with which the device was created, it
>>> will be useful if the vdpa tool can report the config on demand with
>>> simple query.
>> For live migration, I think the management layer should have this
>> knowledge and they can communicate directly without bothering the vdpa
>> tool on the source. If I was not wrong this is the way libvirt is
>> doing now.
> At least form a openstack(nova) perspective we are not expecting to do any vdpa device configuration
> at the openstack level. To use a vdpa device in openstack the oeprator when installing openstack
> need to create a udev/systemd script to precreatre the vdpa devices.
This seems to correlate vdpa device creation with the static allocation 
of SR-IOV VF devices. Perhaps OpenStack doesn't have a plan to support 
dynamic vdpa creation, but conceptionally vdpa creation can be on demand 
for e.g. over Mellanox SubFunction or Intel Scalable IOV device.

>
> nova will query libvirt for the list avaiable vdpa devices at start up and record them in our database.
> when schudling we select a host that has a free vdpa device and on that host we generate a xml snipit
> that refernce the vdpa device and proivde that to libvirt and it will in turn program the mac.
>
> """
> <interface type="vdpa">
>      <mac address="b5:bc:2e:e7:51:ee"/>
>      <source dev="/dev/vhost-vdpa-3"/>
> </interface>
> """
>
> when live migrating the workflow is similar. we ask our schduler for a host that should have enough avaiable
> resouces, then we make an rpc call "pre_live_migrate" which makes a number of assterions such as cpu compatiablity
> but also computes cpu pinning and device passthough asignemnts. i.e. in pre_live_migate we select wich cpu cores, pcie
> devices and in this case vdpa devices to use on the destination host
In the case of vdpa, does it (the pre_live_migrate rpc) now just selects 
the parent mgmtdev for creating vdpa in later phase, or it ends up with 
a vdpa device being created? Be noted by now there's only a few 
properties for vdpa creation e.g. mtu and mac, that it doesn't need 
special reservation of resources for creating a vdpa device. But that 
may well change in the future.

> and return that in our rpc result.
>
> we then use that information to udpate the libvirt domain xml with the new host specific information and start
> the migration at the libvirt level.
>
> today in openstack we use a hack i came up with to workaroudn that fact that you cant migrate with sriov/pci passthough
> devices to support live migration with vdpa. basically before we call libvirt to live migrate we hot unplug the vdpa nic
> form the guest and add them back after the migration is complte. if you dont bound the vdpa nics wiht a transparently migratable
> nic in the guest that obvioulsy result in a loss of network connectivity while the migration is happenign which is not ideal
> so a normal virtio-net interface on ovs is what we recommend as the fallback interface for the bound.
Do you need to preserve the mac address when falling back to the normal 
virtio-net interface, and similarly any other network config/state? 
Basically vDPA doesn't support live migration for the moment. This 
doesn't like to be a technically correct solution for it to work.
>
> obviouly when vdpa supprot transparent live migration we can just skip this workaround which woudl be a very nice ux improvement.
> one of the sideeffct of the hack however is you can start with an intel nic and end up with a melonox nic becasue we dont need
> to preserve the device capablies sicne we are hotplugging.
Exactly. This is the issue.
>
> with vdpa we will at least have a virtaul virtio-net-pci frontend in qemu to provide some level of abstraction.
> i guess the point you are raising is that for live migration we cant start with 4 queue paris and vq_size=256
> and select a device with 2 queue pairs and vq_size of 512 and expect that to just work.
Not exactly, the vq_size comes from QEMU that has nothing to do with 
vDPA tool. And live migrating from 4 queue pairs to 2 queue pairs won't 
work for the guest driver. Change of queue pair numbers would need 
device reset which  won't happen transparently during live migration. 
Basically libvirt has to match the exact queue pair number and queue 
length on destination node.

>
> There are two ways to adress that. 1 we can start recording this infor in our db and schdule only ot hosts with the same
> configuration values, or 2 we can record the capablities i.e. the max vaulues that are support by a devcice and schdule to a host
> where its >= the current value and rely on libvirt to reconfigure the device.
>
> libvirt required very little input today to consume a vdpa interface
> https://libvirt.org/formatdomain.html#vdpa-devices
> there are some generic virtio device optiosn we could set https://libvirt.org/formatdomain.html#virtio-related-options
> and some generic options like the mtu that the interface element supportr
>
> but the miniumal valide xml snipit is litrally just the source dev path.
>
> <devices>
>    <interface type='vdpa'>
>      <source dev='/dev/vhost-vdpa-0'/>
>    </interface>
> </devices>
>
> nova only add the mac address and MTU today although i have some untested code that will try to also set the vq size.
> https://github.com/openstack/nova/blob/11cb31258fa5b429ea9881c92b2d745fd127cdaf/nova/virt/libvirt/designer.py#L154-L167
>
> The basic supprot we have today assumes however that the vq_size is either the same on all host or it does not matter because we do
> not support transparent live migration today so its ok for it to change form host to host.
> in any case we do not track the vq_size or vq count today so we cant schdule based on it or comunicate it to libvirt via our
> pre_live_migration rpc result. that means libvirt shoudl check if the dest device has the same cofnig or update it if posible
> before starting the destination qemu instance and begining the migration.
>
>>> This will ease the orchestration software implementation
>>> so that it doesn't have to keep track of vdpa config change, or have
>>> to persist vdpa attributes across failure and recovery, in fear of
>>> being killed due to accidental software error.
> the vdpa device config is not somethign we do today so this woudl make our lives more complex
It's regarding use case whether to support or not. These configs well 
exist before my change.

> depending on
> what that info is. at least in the case of nova we do not use the vdpa cli at all, we use libvirt as an indirection layer.
> so libvirt would need to support this interface, we would have to then add it to our db and modify our RPC interface
> to then update the libvirt xml with addtional info we dont need today.

Yes. You can follow libvirt when the corresponding support is done, but 
I think it's orthogonal with my changes. Basically my change won't 
affect libvirt's implementation at all.

Thanks,
-Siwei


>>> In this series, the initial device config for vdpa creation will be
>>> exported via the "vdpa dev show" command.
>>> This is unlike the "vdpa
>>> dev config show" command that usually goes with the live value in
>>> the device config space, which is not reliable subject to the dynamics
>>> of feature negotiation and possible change in device config space.
>>>
>>> Examples:
>>>
>>> 1) Create vDPA by default without any config attribute
>>>
>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
>>> $ vdpa dev show vdpa0
>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>>> $ vdpa dev -jp show vdpa0
>>> {
>>>      "dev": {
>>>          "vdpa0": {
>>>              "type": "network",
>>>              "mgmtdev": "pci/0000:41:04.2",
>>>              "vendor_id": 5555,
>>>              "max_vqs": 9,
>>>              "max_vq_size": 256,
>>>          }
>>>      }
>>> }
> This is how openstack works today. this step is done statically at boot time typiccly via a udev script or systemd servic file.
> the mac adress is udpate don the vdpa interface by libvirt when its asigined to the qemu process.
> if we wanted to suport multi queue or vq size configuration it would also happen at that time not during device creation.
>>> 2) Create vDPA with config attribute(s) specified
>>>
>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
>>>      mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>>> $ vdpa dev show
>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>>>    mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>>> $ vdpa dev -jp show
>>> {
>>>      "dev": {
>>>          "vdpa0": {
>>>              "type": "network",
>>>              "mgmtdev": "pci/0000:41:04.2",
>> So "mgmtdev" looks not necessary for live migration.
>>
>> Thanks
>>
>>>              "vendor_id": 5555,
>>>              "max_vqs": 9,
>>>              "max_vq_size": 256,
>>>              "mac": "e4:11:c6:d3:45:f0",
>>>              "max_vq_pairs": 4
>>>          }
>>>      }
>>> }
> dynmaicaly creating vdpa device at runtime while possible is not an approch we are plannign to supprot.
>
> currntly in nova we perefer to do allcoation of staticically provsioned resouces in nova.
> for persitent memory, sriov/pci passthorgh, dedciated cpus, hugepages and vdpa devices we manage inventories
> of resouce that the operator has configured on the platform.
>
> we have one excption to this static aproch which is semi dynmaic that is how we manage vifo mediated devices.
> for reasons that are not important we currrnly track the partent devices that are capable of providing MDEVs
> and we directlly write to /sys/... to create teh mdev instance  of a requested mdev on demand.
>
> This has proven ot be quite problematic as we have encountered caching bugs due to the delay between device
> creation and when the /sys interface expost the direcotry stucture for the mdev. This has lead ot libvirt and as a result
> nova getting out of sync with the actual state of the host. There are also issue with host reboots.
>
> while we do see the advantage of beign able to create vdpa interface on demad espicaly if we can do finer grained resouce
> partioning by allcoating one mdev with 4 vqs adn another with 8 ectra, or experice with dynmic mdev management gives us
> pause. we can and will fix our bugs with mdevs but we have found that most of our customers that use feature  like this
> are telcos or other similar industries that typiclly have very static wrokloads. while there is  some interest in making
> there clouds more dynmaic they typically file a host and run the same worklaod on that host form months to years at a
> time and plan there hardware and acordingly so they are well seved by the static usecase "1) Create vDPA by default without any config attribute".
>
>>> ---
>>>
>>> Si-Wei Liu (4):
>>>    vdpa: save vdpa_dev_set_config in struct vdpa_device
>>>    vdpa: pass initial config to _vdpa_register_device()
>>>    vdpa: show dev config as-is in "vdpa dev show" output
>>>    vdpa: fix improper error message when adding vdpa dev
>>>
>>>   drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
>>>   drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
>>>   drivers/vdpa/vdpa.c                  | 63 +++++++++++++++++++++++++++++++++---
>>>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
>>>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
>>>   drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
>>>   drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 +-
>>>   include/linux/vdpa.h                 | 26 ++++++++-------
>>>   8 files changed, 80 insertions(+), 22 deletions(-)
>>>
>>> --
>>> 1.8.3.1
>>>

