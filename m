Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8926EF881
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjDZQdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjDZQdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:33:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E19D769A;
        Wed, 26 Apr 2023 09:33:18 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QEiRog015505;
        Wed, 26 Apr 2023 16:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1Aruc4nCfo6bnmsHLjgtUA7t2mgwMdJb9XOj0kiv6DE=;
 b=3mWmbXFQcHb636xZArlb6WcTkJXsI4jVDoQl3lbvpLezICkotVF4BRbLLGt4gxkSpts4
 RFGwqSIJVjXk1gs2FzkfUCBsH/HoV1LuMn3CRDP9GveAaxujf3VqnrzHjFaPBp1wL6aq
 hbbDplwcLx7IcHCQHt5EOCTSWUDUafFaxxVmi/A+2ESSnKc2faowJV7naWOTZJf8TSaJ
 3y2jE6C2PnDnF61+l2VpKU9vKI5xqx+K5eZ9wJ5AeTBx1y9FE8oiYKgV5gnJL9x9YiXg
 EZLoI/8z2AideAH0QYA7hUGoF9hb+L9GY1k4dC1xWuwHlAujPOofRk5pXgEIQa6HlC9X Og== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q47fasubp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 16:32:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QFOf98008754;
        Wed, 26 Apr 2023 16:32:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618d695-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 16:32:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyQhEjiW5Jzz5HLSDfVIe8PIxf/Hg1bnFpgxd27N0Zs+aiBKzM46qrrU/268rjv+afjve370nRKR/j6Nqn6eoPpR0wOMNDTD8LEe7iC+eAnYuLiwSHQk/ZMc7SVHP1tff2z7t4g+AmfgiU/w6McPzO2Jr7seHgIOhfKvhB5QFVxVmrzt3FZGa8HssXhxcefRrWZtI9uWGtikdCbpvBOFs7mE/QRHw56Yz60t7oCOjIrIZtYlQN+Sz7nuNtH882V8PiNw2sDL+Zk/AC4ZyTi9aBM1tGMB49/0bH7LrdQ4os0KE36Af8nkhE/qokviytANumsCYz6+J+ZVNXsRwYWHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Aruc4nCfo6bnmsHLjgtUA7t2mgwMdJb9XOj0kiv6DE=;
 b=T57X0An+rXKILTFXoRCwHHUmOFia7Jzx6Nz586lDU3DmDc2vpsSc/K+xux05qx53Yc8EQfZJ8T7Wa3wAza1WK2m1JC+21BLAmIqxOMytI2BRne/+Lh3HV1n601Nzr/89SMHUyebufqb8fmzkuEgDWH09YYI55Bb7TLPKITgjjvjDxJboXw2rGH8y29P2aPVkLvOnxDDFF+5KUjJPq3tBpc8PrmwgrbsH6NigC1otrhqXeG5yoVvuQBHOMi+PiyapSlFEVqj9MjMF3NUZB3oIG8zierSVTNYy3mjzvqjrhIIZGQrjn2dGG0arQuKNFH9ML4KuLGUSZYBrQbTNXvuqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Aruc4nCfo6bnmsHLjgtUA7t2mgwMdJb9XOj0kiv6DE=;
 b=CamAeQHoGMTxz0TsTUpyCkP7NTMbpcI4TxXXXThMfprdWVJ7TfDPV/I/Yqv6u/LFxl8QFSFZVgVb4OKAfUD59DQ71dN7vDzLAHkZnZ9Di00wKgeHs+xCVDRhHgPY1p0irRMFLOXuixZMVWC3WrMEoyv+CNO3nHD3W7OQRyYabEg=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by SJ1PR10MB6003.namprd10.prod.outlook.com (2603:10b6:a03:45e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 16:32:56 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4a9d:b42c:57c7:b53c%5]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 16:32:56 +0000
Message-ID: <6300a33a-9d3d-42a2-d332-81e02d52d310@oracle.com>
Date:   Wed, 26 Apr 2023 09:32:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH V4 2/2] blktrace: allow access trace file in lockdown mode
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-block@vger.kernel.org
Cc:     paul@paul-moore.com, nathanl@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, konrad.wilk@oracle.com, joe.jin@oracle.com
References: <20230420215331.88326-1-junxiao.bi@oracle.com>
 <20230420215331.88326-2-junxiao.bi@oracle.com>
 <05b3eebd-7a3f-13d5-1fe9-8f4ab3080521@oracle.com>
 <30ab7555-8f36-cfb7-9101-0ebb92af3c2f@kernel.dk>
From:   Junxiao Bi <junxiao.bi@oracle.com>
In-Reply-To: <30ab7555-8f36-cfb7-9101-0ebb92af3c2f@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::32) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|SJ1PR10MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee2a7f3-4aaf-4e9e-9ee3-08db4673e3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SggnYtAX6RXF1YfeWq/EANx7eS0kNRZpKMKKSMqVhM/34rXN23eeIgVpE9UmEIHPjZLmKB0GAnHpKE1vbxlX2T7WB7hQp+uWy5bNN4OkQxNVWPxOs9k+areDIqu1pbteg+KPi7rio2VuafakOFgxvOoKUObz8pO52DJjLH8vthz9y9h9PMInakL4HhgxEIuN84HvilpESF6d22shczS9QO/8lOuPwLbJRE+tHTqNdWaegVmP35YNzTp5G93j6WPytXUiyewgShHotxoF146u6mRqZEEfUdgffHGBjgDyUIcA8kak2A+0/y2AGw92Owr2smxP4qgWpyVS9A8xQNGomHavce+wmQDdzeu36dyqq5ENGZkhl/p2amy/6ZdWv1mzy7/YOgLV6iM8eDFmKsrbCFMOv1CCgCSLPFVBpF6g8r9bMZQDorpAJeO80ymJLSWUEyJ/lofJajKtgb2UkUJ42v1kDb7SH3zKUy+2/ZFbrYT8fdKJqCx6c5KMYwP0QgsD3MaeLR91W9f4PsnyfvQui1dqSmmahSBaYBQJNlRaEjZmUIQKVBAv2482Dfh7Q0XWhb72TYovf1MIEB2woHzC0yQAbpntV8B5Ya6dm9byRouDh2VlvkOjxUJ57huYe4igdlU4VPf7o6N+ieG3InBZ6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(6506007)(26005)(6512007)(53546011)(186003)(478600001)(8936002)(5660300002)(8676002)(6486002)(36756003)(44832011)(41300700001)(2906002)(31696002)(4326008)(66476007)(316002)(86362001)(66556008)(66946007)(38100700002)(107886003)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU9paUp0SjlDeVVSajFwVGlhQUFnTEkwUkF5UlRrQ0NyQ2tDUEJualArYktN?=
 =?utf-8?B?VURPR3k3R1JzalVRYnc3V3cyRUVPUEdBOTV4RGFvaWxZenhrN0ZscnJPSFpm?=
 =?utf-8?B?NDI1SlFaWEhHenZiZURYZVM5V3FyRjZHWGZZUS9ZTktpOXVLNnF3cHd4WE5J?=
 =?utf-8?B?S1poMlZOZ1M5UTkzcHc2R0lKVEF6Snh2R3RmekEzUHZtZWxobXJXWElGZlFr?=
 =?utf-8?B?YkVRZTl1RFFWdk83QnE1TWdrUkxMUlNzYW1WNitnRlAxazlIT2dPYzBvOWh4?=
 =?utf-8?B?VXg0aUZ4ZUdtUEQxVittby9walNFcnhkODVzNU56STYxTS9qcnUxdktZL0Js?=
 =?utf-8?B?clhWNDlEd0RGbE5kblozbmFqRC95VWxlMEtTWmxHSUMza3VkME9IbElITlFN?=
 =?utf-8?B?SDJvbm1FdUtLcmVtN2pISTJtZ01XSmlzSWdvSFVKbytGOExtZ05Oa3FEV0RX?=
 =?utf-8?B?WTgxMVN6NVBBdTdFNjR6Rk1uRk1FZDB4QW4vc29oVERrYzY5YkpoeGFRbkhu?=
 =?utf-8?B?QktRdjRKNndybmdsV0N2NU5adnJXbnllamQzcmtSSU5EZGpJMTU1SHhyQTE0?=
 =?utf-8?B?YXRkUytNUDNySmtYWW9aUzhFcGVPZ3dTL2ZsSjcvWnJUNGdOWTlDZm4wUkhE?=
 =?utf-8?B?WXd5eGpWMEx3M1NjNTkzdE1ld3JEKzE3QmdBeWptQWxoa09sUGZqM28wNVhl?=
 =?utf-8?B?dkNtQjVtOGRBL0V2eWxMWitwTWovTkxkaDRDeE94NmNQRXpLQWNnUGtqdmFl?=
 =?utf-8?B?aGZuNlpja1h0UWRZeERkdEVpbUdXNSswd2U0cytJZUVwR0JLSTNUdnNsbXgy?=
 =?utf-8?B?T2tPOTlJVmtOZXRkdkpha1ZJNElIVTZnZE5DeFFtZUhzMVVHV3AvempWclZx?=
 =?utf-8?B?Z2VRYU9NK0g5RExWTzl0WktnaXg2VGQyUmVUZm81dWJYTFgvc2E2MG05bDFI?=
 =?utf-8?B?RmFyVlNmUjE1RWxKYmpCMVZVenRCZUU3OUdTT0JIR1NiUHdya21BM053LzVm?=
 =?utf-8?B?M040Q0pNaGM4V01BTkx3UUN4QnVZRnBSM2tCYTJtK0lPWHl0a3pWT2xMVjRQ?=
 =?utf-8?B?WFcyQTV4T2k2NXJ2ZWljWDgxUHIrRTA5N2w2NmdRcDFGVXl2L2lkZXVTeFJp?=
 =?utf-8?B?WXlFOFNkVUt5NUNjd0VvWVg5V1RHSkJ6Q2Fsak0rRHlSbCtwSUs5THVSdUw0?=
 =?utf-8?B?S00wRkc5a1U2VUJFM09KWFJESU53SVdJVVB0ME0rVTNBR3RrTzVBcU9ubVN0?=
 =?utf-8?B?cC9oWVhNMkRxWG9Qd3d0RWdiM2tUTXdtR2JNUmMvQWdsY2ZqcDFybVN0N2Jh?=
 =?utf-8?B?WllaV3g3THhVbEhieW5ZcytyN3FHazB3TUtHVC9zenU3VTlxZU9GRWNiWTJJ?=
 =?utf-8?B?UzhKd002T0JkOENuejZJc2pPWTBEUFZMb0EySzg4SE1EOXZFbGpCLzJEeXpJ?=
 =?utf-8?B?Vjg4K2IwdW1WMHIrNFNyZkNENXNwMk5WSW9UYlZaY2w4NUR2cStycnhkMlA4?=
 =?utf-8?B?dHU5cUllemgvQTRSWENzZ2NVQkdteFQ1Zm8wWlpsT3F4QmpWcVZnOS9ZSnpj?=
 =?utf-8?B?QW84UVowM3E0T1lEN3Z2Nk1qVXFDV0R0RDN5c1dNazllMFI0TG5TRXMxbDVO?=
 =?utf-8?B?cWV4MldDdWRPWEFKUm1UQ01nQkdiZFk1bUQ1NDhYbk4yU1BHNUtWTHRVWXZH?=
 =?utf-8?B?b29HbFhPdUVjdlAzOWNyWjJmV1hFejNlMDNVcWdmVWRTY2VudDJmZ0pnZGt5?=
 =?utf-8?B?WE9UemZHTVRvRlFwekxmUVJDWEJ4WDlyVkJrRG9OMnFFMC9LekNhcEExbnJo?=
 =?utf-8?B?eUhKQjYxTlZjY3Z5UGVCb1R6WTh1bGhTRXQ4K0lDOXZMN2JzeEgxQkwwZlJx?=
 =?utf-8?B?K2FrR0FXUHhJOVFNdjB1dnNOY3EzQkYxWTF1amdwaHlzNU9vTVBYaVh1dG94?=
 =?utf-8?B?dXN1UWpiM3VsNWRPOTFJWnRXc1M4c1dLNWZ3bW10am8rQ1dFOVFNNXhidkln?=
 =?utf-8?B?eWRDc3ZsWVRlbzV6SHI1UW05dE5uRkRkY0xiencwU1AyT1RTWEVudzRoOS8v?=
 =?utf-8?B?RUhhMWlURHlvclVpc0pDd0pzYjZCNFhSZ0M4dFAyR3VRNUR6Yjg3cFlaM21J?=
 =?utf-8?Q?XNW88ayxmJ8fswv0XwhCqJT4K?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S50RSrk8KVuJNeRBsPSMqY5MkmfSw9ug8lQ1yhB+BUgOQ8rYhexAmAExsmTgDXrm7Ysw90fjgrh32b3bpkCY57LP/D6GiHUSum3HWKjCSgzLIMiXUbI7pr9Bk/eofgemfqPMHU5xWsaMseMyUX5c3nKXstxeYZ131OOlhX36SJ8E+ou/jJIhOJE3aFPmh2vNHGTaCBrst06qpa8LCCLFXg2S/rM5zSEwROwrMmy5xmPGu+ZRzJM0DTP3mNctSEeCZlgbjTgGvoR/K0+BRdRvMCAXoGkKqIQz23LMngIcT8qo7cYSmPb4gVRYCsRgn3zZNAVX3/ysuAYC/yNP8nZ/yAu+qJpMHKDg5wibGnITOQNnpJRiTbgwCfmqY0ujMhuZ+qG8OdvbBI/Ur2EdRIJbHYY8Spnz8tY0OzXUiInAZ7fG3khpSHSDhJngmzYkc9uFrS34dtDuUwr7s8ye3W2Y4V4P+BLCwuXfFlpApLNzAjJBbRVi8ljSxMTkqC6jWpVA9gQ2QWxPMa9t3xWPkSgEu1O1JvgrMuNDmornYa+CJSrKimGxGPGo7c1UMBNuerL0G2mF64xAYXBMd4ExjMi7R/DgS7DE9NO+Xg7s5cYlUPV1cGCvDtqT7JbLA1xKwAa5FhmeM0bLqKFmDL4z8MfK4wCuaYfo5qu3Vj12H6IfGQdj2xCY3P9lENCtjNvslSgrEZcy6Ch8zTiURhCB7c1Zo4Ql2IJC0mIMlYPdWw/GZVz/5a3KJ8gWdU1SjY45ykhqSLPt5j4JJ+44lO90tIfXUEXmwBp4JG8+P48MoEbT76FSWDQGgQFYL5lWLm4OUABts7J6CWlN0E/MNxs2OojbxiUI0Qa0aVclVPjpzPPpXOFg2WwYIPqSuGmwJ//PjBhh1cducCoqDgFvtf4nk6wJ9ZpcU+tAQ3S0RY7G5/+oCX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee2a7f3-4aaf-4e9e-9ee3-08db4673e3f7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:32:56.4803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2FgmgJQft4tqiPhcyZmCIvB75V7am7foZAjPNguGbdN7bMXXBwlMO2Gzhlkg2e3EUX3ry2js4dQ/hfETo7k4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_08,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=678 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260145
X-Proofpoint-ORIG-GUID: aySIAbyJT9IntZ06Jz51zvhqEp9M0Pqs
X-Proofpoint-GUID: aySIAbyJT9IntZ06Jz51zvhqEp9M0Pqs
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 12:12 PM, Jens Axboe wrote:

> On 4/25/23 11:55?AM, Junxiao Bi wrote:
>> Any IO folks can help review this patch?
>>
>> Paul needs a confirm from you that the information blktrace exporting
>> to userspace through the relay files are safe, not leaking information
>> that userspace shouldn't know in lockdown mode.
> I don't know anything about what lockdown is, but in terms of blktrace,
> it is a way to trace meta data associated with IO. It'll tell you things
> like "task T wants to {read,write} on device D, at offset X, and of size
> Y". For passthrough IO, it'll also dump the CDB. There's never any
> actual data traced.

Thanks Jens. Lockdown is a security feature which is trying to limit 
user's(including root) capability to access security sensitive 
information inside kernel, there are two modes, read-only access is 
allowed in "integrity" mode while both read and write access are 
disabled in "confidentiality" mode.


Paul,  do you have any other concerns regarding blktrace? As Jens 
mentioned, blktrace just exported IO metadata to Userspace, those were 
not security sensitive information.

Thanks,

Junxiao.

