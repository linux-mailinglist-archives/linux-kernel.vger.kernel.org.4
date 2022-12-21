Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB12652A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiLUAQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiLUAQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:16:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B10209BC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:15:04 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL0EcG0008541;
        Wed, 21 Dec 2022 00:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aaNejDVrPkaDF0InE/AjE5ExLDW+gDK9sUVe5kaO9ps=;
 b=yacTJN8Vl/mj31u8GT2S7/ffXm1fcYcqV4AryXdbFMUnRXotPHBPtnKcRwz43XEydSIO
 sTXHNw4uFfjFZmewETZgYPw7Wbzk0Ag1WMllXQmylpHG/aiCLIdw6THw5H0YAuq1GfsX
 17YlWtapERH6sK+FToX1vr/T3Dcw9uyVjiMnx26EsHUPub/QltyPiYCqUjtQ0XAlCg1X
 7itdMlVx0GCYHfxu77UfPfgR5sC1VMZU5hZ9L8StkJC22N1XagjjpCPVaPdFd9xvJ5fB
 TZEloURkFxX26Qukg10/3zfBNjwfzNXpkVJTO29jVYNaCiwb7oChP1gVNsdOsJ0v2ohw Zw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tpqhk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 00:14:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BKNPtUY027657;
        Wed, 21 Dec 2022 00:14:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh475ue1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 00:14:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKG/7o5cONqwY6qBKcqqz+FztySjOfqzp93xjdTw6QCFJYDtTmqEJKvq+RqiA9JHBk50FB9K2K3iwFSPnrcHcnQt7Y8B+W/B7jqSlHPi2v1UOfh1QgMOoP5H0NMSUbyP1f6pOQp0+yqy16gl+89Cc2dJUOIqu7ecqm4rTq2RI/tEPf0g+XvjjU+Q9UWPcaLiW8lrOJJbW/C9drVY0XrbZsjmcC+IZ5U0urrLN0MlPl/ZJzvl3L7NbXjgPleZISfHVJSGo33atzVrJ/4koRS3xpDqE3NbxnY76xyrngGpyrnFcvIfby/FtsTwEoZyizjV5ezVD+AJVsVQICdOyZQFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaNejDVrPkaDF0InE/AjE5ExLDW+gDK9sUVe5kaO9ps=;
 b=Ay2nkkaIa9tlXBb6CdC7b9u95DDAYYBlsy3RZ/63PKYLVuT4+re25XMIHQVb6bHi/BrwnyYnkNaoHklYVKKIxNAQ3lZoLcQ2R5EX7wNrWU8wZmT0rKJasOJ3e53sEqmysdTx6cdUakkosFP7QbXCMQmr2Rnc/t0a/dQSpNKEYFVpjqbaWoYBzopxUsWg99yUVTxuXDzhVEFiUjG6i7wG5AvqjeBAN09601McnCv+xCBhxfYAbtO0BUZBe6kmjS93VKHDUPoDnCKWyQWfLLGelHaMCdcM/n+elGVl0fkGRAjOCC02laXphm78YHCyOtKuJGgbEt1s41nAyofO9pfVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaNejDVrPkaDF0InE/AjE5ExLDW+gDK9sUVe5kaO9ps=;
 b=WetT7u4hkCFrEk6+cuMwPJ1QTEvasc6kcPJuaqW/XaWocZB+ucWyzDyAWUOdwv/GnTEIzqabrSYkGKlHPV/fAcjxRJpWKJcsmWEYDB1ZFfpnhQqTQ9cehegPjVQi0NjcMqQOjyb6cDGO8as70bK3NqKOSjwZhub/NooFoqwqqZw=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BN0PR10MB5237.namprd10.prod.outlook.com (2603:10b6:408:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 00:14:55 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::cd0e:bbf4:4b15:308b%8]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 00:14:54 +0000
Message-ID: <1700f5a6-f055-713e-e87b-9f39a68848d2@oracle.com>
Date:   Tue, 20 Dec 2022 16:14:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        parav@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
 <5b9efa3a-8a82-4bd1-a5b4-b9ca5b15b51a@oracle.com>
 <CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com>
 <25a18d7a-ebae-3647-32f0-14ad733118be@oracle.com>
 <38b9648b-8795-5b41-b06c-d13a1a6d5d3f@redhat.com>
 <ab5d903e-f78f-d304-24fb-de7ed73f1c55@oracle.com>
 <CACGkMEvJGfYRY5kF1WWKfT9irGLt8jfVK42g1Bp0UJWdMo_RAQ@mail.gmail.com>
 <e8cccd09-e0f2-b166-54af-96a17c57855c@oracle.com>
 <20221219012917-mutt-send-email-mst@kernel.org>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20221219012917-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR08CA0042.namprd08.prod.outlook.com
 (2603:10b6:4:60::31) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BN0PR10MB5237:EE_
X-MS-Office365-Filtering-Correlation-Id: 179272d7-436e-4385-fae9-08dae2e862c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KeNqx8WZEHV9WAuucr7v1XHZWsROCjJwFY0w+5bXOeVaY2/kLqtA2vKVIUcn/KDXM7qKC3uREvMYBveoXA8+2H7rL8JQ6GjcQHkqbUommJ1jP0+5Repw3yoxgo3JEFF0MVHQIebe/lsdneLcl/yU9IpAwYsil32DbtnLN3XzL727n1zodw/h5ylArlW5sQy5HJXKZE5M5jsfqv/+R448FwjHzonSM5G/mzl1iDDTMEWPxvQG+d3Pith2h3OOOxz+KRUv76HvW7lQ9XK8xbgsPa5BCHfReetTzDmIGM14YqrCwBxqLUZ9WkdueyCtWTfS0fUYsOcGYpsced9FZhlW5IOc2SIeBMEi7i4gseg8HZyv0qGoh3cfuLVvMvWB/7xX/Ll2lWCCDfCJvZ/zIk0GwgT7RP8o+UCaYihlUn5rWRnKlpAn94FyUcGYhC7Qg6yBYsENWLg6IWtaEeWZ68hblV5U8znI/whqE03tGIqJHs9ad+z6P6bHk2JblIsro8N1r+Z2JzC7ZrVgXTJwUWb9raPr7NAfqxVCDRZwi2csxwoyUUodBbczDfNQs/6AxMCEmhuHEDUId3FCv+6WCxnc5tE8hLNdMvjTkJkex/8D4kQMzPxM98Z+kDT2yDsYSmAe5DSpzm1eoP467DvbjHNX+vc41xpP+TBKYCEmuRvxYJ9xhKjso5p1EniM/XJl3Xay+2SGteDXNq+4zijklf6AICo7qtxxEaAq7gtYS0HOSFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199015)(2616005)(31686004)(86362001)(38100700002)(6666004)(2906002)(186003)(6512007)(36916002)(26005)(36756003)(6506007)(478600001)(6486002)(8936002)(316002)(6916009)(54906003)(53546011)(66946007)(66556008)(4326008)(8676002)(66476007)(41300700001)(4744005)(5660300002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0NnVDYwLzYvWWZLVkU5LzJ6R2tTN0lDcTI5bXRHcjZhQUhaSEFJeEx1Y21N?=
 =?utf-8?B?SUNMS1Q4ZCtMYVpVQnhVVDlXdjBuN2RlcFVGbE05cW5wTXIwcjBGODI3VTAw?=
 =?utf-8?B?Q2pWcnBVRWRNVzdoNktWNlNabkh3MGd3MjlFU1NuUHdFeUU1WWlyNTRKUkxM?=
 =?utf-8?B?UG0yYjk0VGRpTzNyZzlNVzBKbTF4eG02aHBXSDljdzU0VUN3SE5pQlBpTzRP?=
 =?utf-8?B?S2E1b1JvV25nRU1EUndQVVZPWUZGL1A0bEgvN0N2MEgxNElQL255SnBqaEIx?=
 =?utf-8?B?VnZRYk02ZXc4Zjg4YzFDUndrWGlaN1AzU09NNFg3dEdqeHN0RTBwb2p6RExr?=
 =?utf-8?B?YzBDMkU3NWllVU5WOFJ1djFQeURXVkdoN2pJbU5TSzNXdmVpUzdoQ2VtRGVo?=
 =?utf-8?B?OWVKUGxyUXUxOTZDSDMySjUzSzFRYmtoMG4rdldmQXdMUE5BV0ExaUdXVVlj?=
 =?utf-8?B?b2I0YTEwZHdEYVhBRUNxQzc4ZXIrVHRyYldleGJRUmhsWE5LMEkzTWpPWDYz?=
 =?utf-8?B?QVhRalBxZHZTWHVIZWJRTEduanJUdFpJVy9DQmlCQ1JESDhvYjBRaFYzM3Mv?=
 =?utf-8?B?d2todTZiaUpJekJvc2tiNUdvbkl0LysxMHB5M2dVanhtYmNEM0JwQldHMGpa?=
 =?utf-8?B?YVlUVFhYTjhnb3ZaeXgweWo3YzJSQmd0MG5IbHBOa3dGS2YyNzFHUW90MDc4?=
 =?utf-8?B?VDU2TGZ1N3Zwa0xMK3gxS04ydzhTVHhGb3lrVG1GZHloeVZqWm5DeEI5NWJU?=
 =?utf-8?B?WUJ2ZStBd3UwZzh6eVBXV2dZTEFCTDBjdTRjMzBoMkV3Q3lxZlFpTG5laWU1?=
 =?utf-8?B?QkluNTBxcmNmYWthK2JLaW5iVzhFaitFbFU1MnBOanlVL2hFZ2c1ZFpZcFJ2?=
 =?utf-8?B?RFFOelFJaWlKVG14NG5rS1pyTTNUWEJkaE55RXd2WXZOdmZnUWdpWTlodFVM?=
 =?utf-8?B?RzZOakF5aGF5TFpMdGQ0VzBkZGZpOVZRMjM0d1BWRWYzM1U1Vm1wTkMwelVW?=
 =?utf-8?B?QVJaZWduUDladnd1YlBteWM1MFZKR09iVEVnWUF0dU13NUdWN2FvRUdmenB3?=
 =?utf-8?B?S2dJMkxrNVBEazcvVmtTMXVJSlpDKzNJQ1owaWhMa3JjbnRDSExqeWF6Nmk1?=
 =?utf-8?B?blRjRXFOUkxRRW92OHlxVUtRbjRQcEwvUFFWOW41M28yeFNUQXgwamJ3d2p1?=
 =?utf-8?B?MHgvQktZSWw2eXlJMC9ZZVdvNW9acFBBZGoxaDEvNE55bFZDWVBVY1Zna3lp?=
 =?utf-8?B?NFovb2VkVTk5REFHbStMT0VQdUJIcys4clgyOENpejROVEsrb3dsTEJiYWpD?=
 =?utf-8?B?V0RCRUY5aXdLZlU0TmNHbU55dUo3b1djMWs0eXZpWUZVMHJuZ0dhbjZTS0Fu?=
 =?utf-8?B?MFloams4ZlU3c3IwUng4SjQ0T2E3T0Z1anNaQURXU3B0UUF6WlJtNXBhSG1z?=
 =?utf-8?B?N0R6eFl3R0tzZW1pa3dSNXQ1RlV0a1NCS1BycTVqd0dSc3EvYURZTUU2eHpB?=
 =?utf-8?B?L1FpVzduMDAwYmpYV3c0emlmYTVVeU5TNDIxVnNsUXltQ3ljTnlJUVJleFFO?=
 =?utf-8?B?VjNzZFZZbGVVVTM4NC9Mb0dwcVNLN1RJVEVOUlhTeEFxM29PRWQ5TlZSUkxr?=
 =?utf-8?B?K1NWMnBXRk5RU3JxdmlLTjVOUExQL0dVZnN4cDJQalJ4TW5uT2pHOE5NYkJ4?=
 =?utf-8?B?cGFiZm1wV2cwTWhFd2NCUnFURjhqczY2SWdEUmNkT3FlbktsOURBNGVDT0pi?=
 =?utf-8?B?M05SaFRXRUpYYTg1SUpWVzFDS1VjVU9JalQveGMwWktTeXpMc0hVM2tVR2ti?=
 =?utf-8?B?b0Vqa0xROVFVSzMrbnJTL1l4UzJYOUpkQzN2em5TT01SNjBMZVZrRWl0QXNN?=
 =?utf-8?B?UHZlRHI5c2lSWUM0ZFRqZ0RMc0FSRVNQVEU2bldHMjYvMExUUTcrV09Wc2ZV?=
 =?utf-8?B?YmZEeWpZaWljYjVxYUVDeXR1ZWFhZVkwc1UxREpFTkZFa0JINGRjMGRTMFg3?=
 =?utf-8?B?cmNrVGJsU0hBVFpKS1d2ejFNWmZDS1RSL0lsOXMxM1dLMWp2bU5pdXdZV2VD?=
 =?utf-8?B?UDBzc0x6YlJlYVpCMHAwR21NOE1DUk9waXpmbUVzNDQ2RUNEaVhLdG1XSHFs?=
 =?utf-8?Q?g/A/PQmUBPUOR4Zar5zi/YDsy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179272d7-436e-4385-fae9-08dae2e862c8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 00:14:54.5693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orEkZK0hI7gE+nnFczC2o6/MnAi9XAgVKp8rzi34yL75x45mNvg/pxF1tKpJAjBESjUXaIcKCj7vyWmB2KCCgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_06,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=968
 spamscore=0 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200200
X-Proofpoint-ORIG-GUID: qQPrTSMloGijneplYdOgXgUZZVil2tZB
X-Proofpoint-GUID: qQPrTSMloGijneplYdOgXgUZZVil2tZB
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/18/2022 10:31 PM, Michael S. Tsirkin wrote:
> On Fri, Oct 28, 2022 at 04:23:49PM -0700, Si-Wei Liu wrote:
>> I can post a v3 that shows the code, it shouldn't be
>> too hard.
> I take it another version of this patchset is planned?
>
Yes, I saw you just merged "vdpa: merge functionally duplicated 
dev_features attributes". A v4 will be posted on top of that patch, stay 
tuned.

Thanks!
-Siwei
