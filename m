Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD35B6880D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBBO5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjBBO5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:57:35 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B16A92198;
        Thu,  2 Feb 2023 06:57:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHiucHVZKh0PfJRJQx+vV226gPQOfaGLYbnP4hb7dHICGb6OwC4Rbjz73F9wTsVyVz4HIOF4ce4CzpLlR6Kpzep7e4NOoP3CJWYY1PQ54uYn24cogwD4L4vdJePu6e51FWIXVilgXxOyFc4aWXkVjLRNXvo7bIDAS7eixJ3wCLRSVrgYhziNmgmVvCwhXR9QSKGLM0rcMfnlhtrw+NssNRKghBEbQ05H3WIQkRysGpmFMV5jYgM0Cao1Q/hLmVxWfBj9z8UyOA8dzz9dub62T1IfItmfjC8i/dkZlxitmUbo/DorZGZru3C/qXh1nStmBiVGJnjErUncLkS40Z881g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xENAZHn5XxLMJQeX9EDJaaWD14D+UkL8l2eC6ixZVuY=;
 b=d2yg7etjxKUW/5wB9jFBTvJ0F52c4xD0rbolAUm4MhbVqKDT15trfikq1z5PkME/WqF95/3qPAhx3gruZ1upLlvokgeRuhp6+BWEkq9MHrmbtlUjfL+ilnDm76XcYBYKuIvCJ+Dp8XkcqCox5VolxFmEnF2if2GwIhQ6iLngZ+DOy16uN3aWn0Clv+thPQcBetg17libvH1Id5V003u7EfggatsFNY/cBixcChZ87KnOPIpZbm4xhf55ps8XsZ20Ktdxr+qKkWK3pm1SvqJO6gfXbwOYIFtQW3rm7xMTQnBOyCzHFlCCYZX/5+rZcxO4jXnzWqfSyHC1SnYgB9XWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xENAZHn5XxLMJQeX9EDJaaWD14D+UkL8l2eC6ixZVuY=;
 b=WF+1dwbyykGmANI6honqTdu+1lxVAqq3b/sswrCujfgxpnG/pQffW1JjgK1DLLzsBHsSufWwk3itgwk1GWR9ZmrkyY9yuYRWiuae39nmvOvsetHO40fBjS3DA/WuO4UuE5xZFSnqQkDljET35JJIm7ZZHNXv49h33aI5HL75ahY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 14:57:20 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::f29:b74e:c400:b24]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::f29:b74e:c400:b24%6]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 14:57:20 +0000
Message-ID: <5326ca23-e81f-9e7f-8c84-3974f6537d6f@amd.com>
Date:   Thu, 2 Feb 2023 08:57:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] docs/sp_SP: Add process magic-number translation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu
References: <20230125181840.3007341-1-carlos.bilbao@amd.com>
 <878rhi2xor.fsf@meer.lwn.net> <87357q2x8w.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87357q2x8w.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0041.namprd04.prod.outlook.com
 (2603:10b6:610:77::16) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: eefc8470-f7c6-4002-1f34-08db052dc88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1+YEvF1CEF7lksVVpPSAzACnUaVrp6U7fJPRllNGlAsW9e9cZZwNwy5OrF3sbEJ7vRrazJcI0bsTlPikp5Qqs6iVP9eEAMNjIFyL653lVq6A4zxtrA085roTtHZQNs3HyWHVPp1WD9nnhdt4c561opHv70MgJg0bvNwCmchxtkRuGVAtatgfBHUar5oHAI1vd8gV0l8x4mZBBWk5UJc4eXRQG/sQNz4KXSfUvxD9hq2zkyIyf9P5EwaEkByAjtkYsCoOfNy8lSo6Nu+srAzO8ZNwrbgXGhre1wKY4AM7CWebks9npBtag+fyVUz3oJmQhF6BRrjvc00aBA4Mjjbme/8qbUGwanKUquJxX/x0ULX8SKMNsRLNUrRan9iNu209YNQmqU4BAvfEOa9MD7wx2iOEea/vW/+i6NNd6NoMEcUUI7ods9nHeS+/iW+hfK2ye2Fd8UVeq/rVnKVZ9UJb1/3IVWxnUYlZ8tga8YOWCHBcAsGxqJJKLQQyRJr/+YDUUtxQZ8J+qGbiwM62YdFr3/rpYRs/JQHxkgSPekq/FdQV2mFCaSf36CeyZx1JnFVjO3r4i9EIDZoPsRPiWXaYOrdAby3UqBdadOj8mgVip+JL/tqMRhHkfnZULba3bS2lcV19myCaJzQ6UQYdgrYORPlymgiDYKpIe6NFQbjDq7+3hJKHMUoTEygiBxjd4d3ciQ98PHIoryFJjqzoIMUzd1GhzGvYgJgW7ayNSGsp1UY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199018)(2906002)(44832011)(83380400001)(4744005)(31686004)(6506007)(5660300002)(53546011)(6512007)(478600001)(31696002)(186003)(2616005)(26005)(8936002)(36756003)(66556008)(6486002)(41300700001)(8676002)(86362001)(4326008)(66476007)(316002)(6916009)(66946007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm4rcEVtQnRxMyt3bjg0YWx3bTIyYVNOZWtNM2JsQVk0VE94cFZuVjN2US9Z?=
 =?utf-8?B?MHdaS3pLMHozVHh4VU45MXNPTlgyNE42T3ZmZFR1YmMvT3BlOUZ4bUh4UWgw?=
 =?utf-8?B?Y0xGSGMyeWY3dENoZURmWDdIME9DQjM2N293MlRXa3gyaWx6bU1mUU1kYXQ3?=
 =?utf-8?B?MWhiMml1M2xQNVQ5U1BycWpXYkV1R2lBRGZocks2YUVqcHlsdWU4M2ZoQ1Nq?=
 =?utf-8?B?eS9zRG83U29tQmQ4dmE3ZDdZdjV0S0ZTNWw4TkJ1Kys3WWEyYW9rMDVmRnpE?=
 =?utf-8?B?TG80akhrcWN4R1VqMVkzY1dhRUZQcUd0eC91dmM2MWU5OWxxcEkwMkpUQzYr?=
 =?utf-8?B?S2w0TG4yU3dzNHR3T1NLOElML3FMZi9nckRsSHczZUtvcjZqVDVhNXdyQ2J6?=
 =?utf-8?B?c3pMY3F0TDE2elBKeVNLZEtpMXQyQUpqc0hSbmpKOUlFRFBRNWQxWHhiZXl5?=
 =?utf-8?B?ejZyRWs2dExkZnVPMGJIeFlXS2xyRGR5ZDRUVVUrbkUzZlk4UUNzZ0ROTjNT?=
 =?utf-8?B?RzI3cFB6ZmxTclRBSVArRmEvaU02STJRMTEzcFhmaWl4a1pma2lpakgxb1JE?=
 =?utf-8?B?blhVZ3Fob3BLbVQwYVhkRVFWejJlYVRRV2hTbUZBdEhCUDhkd0NrM1ZSNGNq?=
 =?utf-8?B?ZFJiZk4zdUNHNEhNaDM4WldvNno5bGtLUllKMHRqMTM0SzkzVi9oYVRPSHRu?=
 =?utf-8?B?WEJyUnJUQWFoSjc1VDBJUVYrQmZNejlSN21pQXlsUyswdVk1bThFOEFqUnpH?=
 =?utf-8?B?KzY3R1JwWkxYV1VoUHhKMUtsNGNtb2Y1Q3lPTTIvbmhzcHovRUFOeXFSN0Ra?=
 =?utf-8?B?bXh4Z3RPTEV1c3RuTk1LU0dRNG9qUXByTGZiL25XNjIxVTU3Z25Cek92TFNH?=
 =?utf-8?B?QkRHZEV3cGNORWx6a3ArL21LYTNtZlc1ZkpxdzFBcmNWdWJ5ODBHbW1rdkRp?=
 =?utf-8?B?UjZncnlCd1pVZ1lmMWRmS0F5eGJyaTdkNHZNRVpycVVqR3FWTjZxcmhVRzYx?=
 =?utf-8?B?N1VDTldhNWdVc2laL0gxVmVNY3UyQzFMcktYb3BvaHhEelRSa0pRY3VlY3BM?=
 =?utf-8?B?MVVUWmgvZW5rODhuSWFQQStPcUNGMGFZWXMwVEt6djlBMXpEU2tUWjVqajVw?=
 =?utf-8?B?NXc2T2RJdmJsbS9TSHpwWngxLzBodCsrbk9BZThiS2VxQ3Y1L1NGcktkRER4?=
 =?utf-8?B?WkN3bDFDOGlXQUkxNGVLY0EyNGtxRzVLWWJMK05nWjVWNGF3QXYxRzdUMkFV?=
 =?utf-8?B?YW9DZ09tbEhZZWtseHhrZzBPZUNsdDBPNUxkeVVZT1ZUYkZzVFRVMWVyVFIz?=
 =?utf-8?B?aDZNTnNtRW51ckRDOEljRXB5MFZnM2NBaC9qNWJyLzVDRmNTcmRmaDlHMW1R?=
 =?utf-8?B?eDRhMWZzLzk0S2ttS0d4ZFQwYVlDVDgwdmV6ajU1YVprcWdsVGZBNEd3R1Np?=
 =?utf-8?B?VFgwd29UV1BxemMwU0gxMUdTWlhyaW9KVDJNTStlclAvSVVPNGQ5QUpiTmh4?=
 =?utf-8?B?L0dNVGlMbVNHSlZGdHJHMmlXcWl1QWVkU1VCVkc4cG5HcmxmRUtHRUxNT200?=
 =?utf-8?B?WGZhWHBUS296NUZSclNKMURZbTBTeXJTZzBERGNPU3RORWN0bllCMG9wMnV0?=
 =?utf-8?B?Vkw1eEN5N0padnZ2Zm92Y0ZwWWsrK0dhQU16c0pNL3pkaFcvZWI0eGFvN3hh?=
 =?utf-8?B?aG16QXZZQWlQbjRkdktlekRwcUdjSDZ4bS9jSysrcjU1R3k0Ym5tU0FhRW5z?=
 =?utf-8?B?STVRRWYrOUdzZ3pianRqY0JEallvaGJqMjhyUVVYdXk1RTVQNW0wMzkxQy9k?=
 =?utf-8?B?blkvTWQ4YXVGVXhXT1JDeUxQems0YmtyU1loQjgzTGZmS296N0ZMU3ZlVmRo?=
 =?utf-8?B?TVZIN3FmVTJ2d1RLaHVSVzhucFB1djQyRDBKWWttTUF1MWtBcWREdU9yNTBq?=
 =?utf-8?B?UG45eFUvYU55bFdXbU5Ud0dZRWp1N0Y4U2tJT0tERHhBOUw1YUx1cFBIMkpE?=
 =?utf-8?B?QmhSNDBoVXZLZmlwNEJidSswN0JId0JudWVvZHA3a1NEc3V6c0xSamdHZElD?=
 =?utf-8?B?S2o2Ykp1dFJuUW5KWWVNLzArS3V3RHAxVXhIVXFpbGVVUlMrWTA2K2Q4dDEy?=
 =?utf-8?Q?FAvYMY5S16tAV0fTaN8BbIdWT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefc8470-f7c6-4002-1f34-08db052dc88f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 14:57:20.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z41x37yPTfEgdH+v7Q6RnlCkefrl4WruV/L3zQmNLPj6gsr5Rz9vUpjDj648Zk6RNOcLT9jqbm3n8+AUcRK8ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/23 15:46, Jonathan Corbet wrote:

> Jonathan Corbet <corbet@lwn.net> writes:
>
>> Carlos Bilbao <carlos.bilbao@amd.com> writes:
>>
>>> Translate the following document into Spanish:
>>>
>>> - process/magic-number.rst
>>>
>>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>>> ---
>>>   .../translations/sp_SP/process/index.rst      |  1 +
>>>   .../sp_SP/process/magic-number.rst            | 90 +++++++++++++++++++
>>>   2 files changed, 91 insertions(+)
>>>   create mode 100644 Documentation/translations/sp_SP/process/magic-number.rst
>> I've gone ahead and applied this; if magic-number.rst goes, this one can
>> too :)
> ...of course, the robot already pointed out this new warning:
>
>    Documentation/translations/sp_SP/process/magic-number.rst:16: WARNING: Inline emphasis start-string without end-string.
>
> I took the liberty of changing "void *" to "void \*" to make that go
> away.


Thanks for handling that, didn't catch that warning in my system.


>
> jon

Thanks,
Carlos



