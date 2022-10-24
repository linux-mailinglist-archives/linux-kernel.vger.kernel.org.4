Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E0060BD60
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiJXW3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiJXW2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:28:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638DA153804
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:48:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OI9dKl021695;
        Mon, 24 Oct 2022 19:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4cy2K+1CabXZ0C7cVn7bTZ7hEiuQ3xAWDkdeM2PQwfI=;
 b=qSy06LAodx26Bvu0sca6x4lKGbjFPNfLvyjuljwuuARzU8lqiHwKkfW6alSTrxUH09Az
 RwiMAuHVC9WKPOsB+B838EDkgs3CYJ0XxoUGZlnqYp0vEfQH+hO02Nh2s+lY/pIQdrl4
 K5krsuEMNQKnX/H4VpoxIDzNI5CBxlBiqsLYWmGeNsdkt7VEcSN4YB55FGD1xlSYiGYJ
 1N556H8qQvVzcIa5C2M7zDQI7/rE5upOD3W6UGnfyUy5t4czD/VF/TCKNn+cjONrQMa0
 Kj2EVb9yN5jjvTowmqZ86sJYuzTH+m83n5ri+24D7Bx1aqrSKnhqejincnb3EMKKkDSn tQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc9395064-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 19:14:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OGfhg9039855;
        Mon, 24 Oct 2022 19:14:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y9wgr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 19:14:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1zJX+ItbRCo3Gdi7xzh/MC8MxeplRrFJ84gqemJHsSo9k37UtxX2p0QtW8LY5fIWJ28VMkRooOhacOkEum/kHtZ/uB9zGd9CNVeHC02Kru3Kj5ekz8QqqrcltRHBVxNI4DiCqTPFsyrGX+cJN8hAN8MBA2gpeVXJf0hCZw8Ya2OmVP119WNHikLDoNTAjctF9dzl8QG7izA/DjeNNAxDNe2tGyUdXwKgpZMwwXyi/V858yehHxmZWNlDMHaT5Ilq0Y6Y17EgyCnXUsdMLedtyWYnVvujUNRbiwjyH51EK4BQKENw0F74kj8oowFaI9QjAmDXbA1uPLVgKvmAJkufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cy2K+1CabXZ0C7cVn7bTZ7hEiuQ3xAWDkdeM2PQwfI=;
 b=m4U9zT5rfLs2nOvVuWnBsfGvogJQ4Z2/lm4NAdsgCajiQF9riMCp2u1GBNPiQn6N4KImfNqrzwqXG9M+4jEGOR80R4yGTqd0Pl3YHIt2EQwIoMrvKGazupNzYllQfiX3pXCraAUrzCml028UCM1KIei0IOEBSEcJ/k8Tppvcu+TX1eoqYJuv29HuuTDZTggwnPJE7ui/W+WO3UFhuqqS6NGH+I+g9Xz5eQin9txhe5/7r+B+AdiTS5azyvS9I50agfWZps0YLucppBbXtgAgq1oZD2MRokJqpIbW1AkWYMlxvxvRBZnbfJ63ft/7eYJUK3YvX+sP+H4Jt1TX4Avkyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cy2K+1CabXZ0C7cVn7bTZ7hEiuQ3xAWDkdeM2PQwfI=;
 b=hWL9DJ56vZpb7A/SfxtCZT75UuZI1vZpJA/KOdTbLz09GCK6sbq9soTdEJdhYqIBOU6Vc+8I7w1fL1PBNkqQ6+a92qC21yxMqiQg+MiWgJCtegLeRErLbJ2fZZmdDHQbD0EzusAwsPvIEkJnxB5pM84GxU1CZCKq63KkwDj1wmw=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CO1PR10MB4401.namprd10.prod.outlook.com (2603:10b6:303:94::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 19:14:30 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%5]) with mapi id 15.20.5723.032; Mon, 24 Oct 2022
 19:14:30 +0000
Message-ID: <5b9efa3a-8a82-4bd1-a5b4-b9ca5b15b51a@oracle.com>
Date:   Mon, 24 Oct 2022 12:14:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0055.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::7) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CO1PR10MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a3471a-87a6-4222-9602-08dab5f3f9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ibpXm7aeq8FadaYEH9h60JdhYnFM301R9G8l4hFWQxH/v4JPs0YruGkgst5oQtAd05gU5tdynrK+wZQLY4gEJVyTmH8LwhxYRIouNkML0NhJhE6iD+akYHxIX4L8v5smKKUr6KwgKWHgLFP/bqqOZNFy3J9LYldOT4S4hWoicbIutJJCPJGHvUPcx/oyVw4gNt2iYPZIwWRvZbliqg9K59IenRqbBgn8IZYdL00w5WvJW+RIb7tLksp5hKCilh/iKsK1xXUPGa6p1saTgelpaDVwxTqbiiLZ0jXctpAGuWZRerWiWQclETIj0GhP/Tvtj28WEAsCQMW7Zn5On2i3dC6TElH+EnKr+3Ko6X8wqu/fDMmLPTSZAO4Pvb9NsNe1IZHmUO9M+UIrT57j1h1WUx8Ld7mfMopofSkbl4pFd1KJuZnvJazfoGlVcBouNZ+qWpOfLi84IuAQxSlF3taV0kgZ8yNhpmparCqiWtvFtqRt1PgkfKQbJVJ6sYjHUhKiF86kfnUuGQCwhkVmV37osygiQFLa7Hd3HrWAhUR9Og0MkrDMWVzzorLTjZoeHTKnrP0DKq8mDbI8XkHsqUJKzslkFAGpj5bWtS3DvHkh6jDAgb1Bdx7zI8zC3/1ZD8o4ujGOK623ubD0L05CEAEE7baEkY0foIMhSb6a3CAUL4Th6JmO7bALSrMoTJqs1FjGMAH23X0I8Gu8cJHNK+hRVJJNPsfku+1Cs8QslDZh1Gs8UuHjz+nuySI24SIyF8Xm7Xs6ev+6h/iy8ZL2cQodR+YT3xsUH9OWQJcxwvcHas=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(31696002)(83380400001)(86362001)(31686004)(6486002)(478600001)(66556008)(4326008)(8676002)(66476007)(66946007)(6916009)(6666004)(6506007)(53546011)(36756003)(5660300002)(36916002)(8936002)(6512007)(41300700001)(26005)(38100700002)(186003)(2616005)(2906002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmtvVEJSajFWaWpzYWdITnp6Q3cwaUtZR3hXZVFteWtUUDM3SHM0WXNyWlBR?=
 =?utf-8?B?V3d2Zkt3NllXM2l3cUlMMzhQUERmcXdYOVFaSEN6T29odjhFcEUybmhVbTJv?=
 =?utf-8?B?TjJTblNJV0RZYmorRmljNm9PamdXa2s4VUMwa1o3NkpGQ0hiNzEvTXNuR0NP?=
 =?utf-8?B?V3JiSlhObjN1cWJHakRzU0VmL3B5bEdpZ3RkcTBQQTZYT051VURLZ3plSURn?=
 =?utf-8?B?VzVueHRHVjY5M25LNlRiNTFwalVyWnY3aFpnVndHMnl1NXhIc0Zsck52V2ZC?=
 =?utf-8?B?UmQyM1pCb3dHcGg3MjhzbFlHdGpGMjNyUFZpWklOcEdJeTVtWUpmUnN4UDRw?=
 =?utf-8?B?UEw3S1V5Y1NrbDNIelkydjlidlRGaXlOVUgxek5JMUk3UENPbmZYd2xRUGlj?=
 =?utf-8?B?bEJSSytBWmhFRWdZS1VKVkZqcWczZXY1RFBqNllSdkZYcnJFcmxwRzVtbmJt?=
 =?utf-8?B?Z0FBR094bm5MUDlrZ0ozMXdudThRb3M2bEo0bnhLcEg3UklwYmRBeVFXYlFv?=
 =?utf-8?B?UmhraGl1UW81UThMM292MWltREU0OHlWQ01ScXVmSFl0aExwMjdlVHZQRkJk?=
 =?utf-8?B?MEZ2Z3ZvMS9WZVZ6cTZWTTFoVlZBOFk1QUsxRStzczh0bzhZR09qZ2gyMGQx?=
 =?utf-8?B?L0ozRGhYbUNTSkRBMVBxeW9Pb0YwY243VWYvK1V4YVVDNFVnZzB5eWRWWVhM?=
 =?utf-8?B?dGVINzFuQlVrd2hTd08vdThvNk5xS3BFWUtJVjlmMHZSaFRNejNDaEJWVXJ4?=
 =?utf-8?B?aUR2S25JOUUxc1F0VWtzTHhhTUl2cWdBRUJYeHNNUWdGWlJJWG9IY0tnZWNr?=
 =?utf-8?B?N21UcG4rOHdEQVk5M2gyMWJUVmRsbnBjSGJMQk04TEZPQklIbWhlWnVJYnpO?=
 =?utf-8?B?YzhKYmpLOUNJcllCbTR5Z2FHUFVuTm5aakR4TEJ3dmJLOWI0dHdTeDJrNFBI?=
 =?utf-8?B?UEs2OXRIcU55ODhYSDhTOG5rMlhNc0dTZGdGN3BFK1ZRVndIUmNZbEdYTnJ6?=
 =?utf-8?B?SFpzYnRGRG5TTnNCMm1WYTF2YlpUMVlYaEVJRDByaklaZzkvR2NWdE5kQ0RE?=
 =?utf-8?B?cURHdEdRVlliS3dkdFJVU2hQUFJ2SGxEN2FNT0hLaHNXbkFtdUFPdTRzV0JE?=
 =?utf-8?B?OURYWS9hWHUyZDR5VXhCUG1SNlRBRElrcUtXakE1bzRmTGNpeEh1ZlJXQWJs?=
 =?utf-8?B?NGVMZUR6RlphLzFucXZSbElYWFhUa0JUZGVuMDlJZ3lBbEo0akRnZlZMNVZX?=
 =?utf-8?B?QUFIeTVQSHNDY1RNNThBemtrOUd2M0VyR1M3YUpIc1FOMDJMbmdiNE0xMW1i?=
 =?utf-8?B?OXg0NEtPdzRYZ3NjTy85TnBoQ2ZTa3BFdGd4M2sxbGJGaHdMcDVwRFk4VDZj?=
 =?utf-8?B?LzhtL1dzRGJjZDVkZjA1MWNncTVmMHh1MXpFU3UzQ3VqaDVqVGgzMTVxTDN4?=
 =?utf-8?B?UTFzTTVOODdYQy8wVE5FSnNmUUhTUXhyeHBaTWN3cmJsMWFPdzBmeThtUGF5?=
 =?utf-8?B?NTNrNUM0RU9UTW84d2ljOHZibFBOQVlxK25pQmljUGpXK2t1bjkrb2xnY0ZP?=
 =?utf-8?B?UmZEMERNaDdEVk4xZlBqbzZGcTUreTlsWXhsUTBZblRPcmtRZlYvY1VnNS9o?=
 =?utf-8?B?MHpVNVN1dUpVYW5wSzVMOGpPcTYwYSs1NVY1bngzUmwybVJKYXFuWWhYS3Jx?=
 =?utf-8?B?dHdheTFMYW9yVjYxMEJHZ1pPL2tqM2FiVVlpSmZjTXVKVmxKRVBOeVVVekdD?=
 =?utf-8?B?MVBWQ240NFRDZWlHdFo0ZExpUnJyQ0tLRDAvSjA4by9zLzNKaDhPc1UvSDVp?=
 =?utf-8?B?djZIaUwrWWY0ZThla3BFSEUrS2lCYmRlR2RrTTZ6dit6YmZLeDZIOGpzUWFJ?=
 =?utf-8?B?RFVPQ1lqT3B0cU5IYW9OWXlxSmQ0VG5ZWXRZZFBZQVBOM00zVVF3QkJDWm1B?=
 =?utf-8?B?VlpyTll5MUZpUzRPTXhrNlVLSC9ObVVFUGVpaG9vMWQ4dkQyQXV4T0o0R0NH?=
 =?utf-8?B?K3ExLytkYkpITHpRbGdzMndkZTB1UmwyT1R4QmR1MDdvMlBnR0daSU5IYTFH?=
 =?utf-8?B?MlpCT2NlME5OTXBIbVpJb1NCU1ZFUDRhZlM0MkV5MVIxeWE0WWQ0UFU3eHV2?=
 =?utf-8?Q?XeTPp8fx1jgjefAPNvmO9UdsB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a3471a-87a6-4222-9602-08dab5f3f9ed
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 19:14:30.2842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvYl0OubD7X426Xpw9O/tkpsOrE9t9G0Q3FyubZwZV/v2lxUowKrRuM0nYxSUM+RYDppfPImmT76pDFyy5CVbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_07,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240116
X-Proofpoint-GUID: SVGfvUcSeBkrIeJQB95z99WQdmHSRD_V
X-Proofpoint-ORIG-GUID: SVGfvUcSeBkrIeJQB95z99WQdmHSRD_V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2022 1:40 AM, Jason Wang wrote:
> On Sat, Oct 22, 2022 at 7:49 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Live migration of vdpa would typically require re-instate vdpa
>> device with an idential set of configs on the destination node,
>> same way as how source node created the device in the first
>> place. In order to save orchestration software from memorizing
>> and keeping track of vdpa config, it will be helpful if the vdpa
>> tool provides the aids for exporting the initial configs as-is,
>> the way how vdpa device was created. The "vdpa dev show" command
>> seems to be the right vehicle for that. It is unlike the "vdpa dev
>> config show" command output which usually goes with the live value
>> in the device config space, and is not quite reliable subject to
>> the dynamics of feature negotiation or possible change by the
>> driver to the config space.
>>
>> Examples:
>>
>> 1) Create vDPA by default without any config attribute
>>
>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
>> $ vdpa dev show vdpa0
>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>> $ vdpa dev -jp show vdpa0
>> {
>>      "dev": {
>>          "vdpa0": {
>>              "type": "network",
>>              "mgmtdev": "pci/0000:41:04.2",
>>              "vendor_id": 5555,
>>              "max_vqs": 9,
>>              "max_vq_size": 256,
>>          }
>>      }
>> }
>>
>> 2) Create vDPA with config attribute(s) specified
>>
>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
>>      mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>> $ vdpa dev show
>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555 max_vqs 9 max_vq_size 256
>>    initial_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>> $ vdpa dev -jp show
>> {
>>      "dev": {
>>          "vdpa0": {
>>              "type": "network",
>>              "mgmtdev": "pci/0000:41:04.2",
>>              "vendor_id": 5555,
>>              "max_vqs": 9,
>>              "max_vq_size": 256,
>>              "initial_config": {
>>                  "mac": "e4:11:c6:d3:45:f0",
>>                  "max_vq_pairs": 4
>>              }
>>          }
>>      }
>> }
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index bebded6..bfb8f54 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -677,6 +677,41 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>>   }
>>
>>   static int
>> +vdpa_dev_initcfg_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 device_id)
>> +{
>> +       struct vdpa_dev_set_config *cfg = &vdev->init_cfg;
>> +       int err = -EMSGSIZE;
>> +
>> +       if (!cfg->mask)
>> +               return 0;
>> +
>> +       switch (device_id) {
>> +       case VIRTIO_ID_NET:
>> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &&
>> +                   nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
>> +                           sizeof(cfg->net.mac), cfg->net.mac))
>> +                       return err;
>> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) != 0 &&
>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, cfg->net.mtu))
>> +                       return err;
>> +               if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &&
>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
>> +                               cfg->net.max_vq_pairs))
>> +                       return err;
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
>> +           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
>> +                             cfg->device_features, VDPA_ATTR_PAD))
>> +               return err;
> A question: If any of those above attributes were not provisioned,
> should we show the ones that are inherited from the parent?
A simple answer would be yes, but the long answer is that I am not sure 
if there's any for the moment - there's no  default value for mtu, mac, 
and max_vqp that can be inherited from the parent (max_vqp by default 
being 1 is spec defined, not something inherited from the parent). And 
the device_features if inherited is displayed at 'vdpa dev config show' 
output. Can you remind me of a good example for inherited value that we 
may want to show here?


Thanks,
-Siwei


>
> Thanks
>
>> +
>> +       return 0;
>> +}
>> +
>> +static int
>>   vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
>>                int flags, struct netlink_ext_ack *extack)
>>   {
>> @@ -715,6 +750,10 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>>          if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
>>                  goto msg_err;
>>
>> +       err = vdpa_dev_initcfg_fill(vdev, msg, device_id);
>> +       if (err)
>> +               goto msg_err;
>> +
>>          genlmsg_end(msg, hdr);
>>          return 0;
>>
>> --
>> 1.8.3.1
>>

