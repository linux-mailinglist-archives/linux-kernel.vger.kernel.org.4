Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4506D7177FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjEaHXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjEaHWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:22:55 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2091.outbound.protection.outlook.com [40.107.6.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D138E5;
        Wed, 31 May 2023 00:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQek4SWHmw7Mn6I1xbsqlDCoDBg5eIQ02CzLX1tpDHggFd9EAvejpkVjEZHoSFZPWsbZyNkKBE99PgpcxeBO9bu8uwUDoWb15gWYWopv4a9ZObqv1DdWVGh2fQ3SezLqS5PZhJQjhnopUznqgDabz4w9ATGG2upl3p/fzFMVnDZITte2bPmN06ORyLWh3TUEBhmQ7l2lj1a6Bzry1JnOUEAMORwOwbE3uA9XFkhfHkVt/n8HMtPfSgkaLI0kWlH5/3wnW3alV98LG9qhGWQH+EnZFgJHNAOs/8+pxcn3URne2uvzw0FAtBJeIutDi+/ruIFNKUZd9hNUgwAWMbBqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZHeo4gU6t+F+3VyHichbOQsJ+9uhlGDn5sEB5YAczo=;
 b=mJxx0IwrcsGhhQJ9nCGwbZH8nhYK8hvmVc0Uow7cpbbCK8tsHEoIjn5aqlQ5rlCvXheaagxAwska5GQMtRG6z8gfPENrxIYKom9HYkQaYB0yVVBJfbzvVKJoR0470T5Hk1Yv6naJW2+j23z7zUIf/WsBUJdJ4UeBlOnlv6M7HBHqTR1OVGGa8IcFAkk9wBbhvRZ5VlbYvsLnUd6upXfUCmU7eCfCD95dXRI1QIODPMEeqQ5ClmzDz5qEpVPVEPFsgpFpdCUoQDLbhkkiiUM72KXmQHOL07v0RdEEYO8920s9vD/oYJDhfXAA9Jy4pECh9CUB/EDfPPkpBg2JZZNRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZHeo4gU6t+F+3VyHichbOQsJ+9uhlGDn5sEB5YAczo=;
 b=AXF/AMksP/hHw8e+rD5R0fJzm2Z90uU26L5taclgEexhpGQfRNwrdoRxHym8tWJbYn990iTTyDHzFlCyuscL6NRa2dmRPCjo+mGd5HdCiBMFbhmfepP8PVIyszQ5QAO6y/8PWx/XDnhPiRmoGK6B6P/NG/Nf5+KIjeg20gCNbWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS8PR10MB6947.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 07:22:49 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fe53:f0e3:72f4:6c80]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fe53:f0e3:72f4:6c80%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 07:22:49 +0000
Message-ID: <25e6d735-f191-68a1-84cc-d7e1ae4c3217@kontron.de>
Date:   Wed, 31 May 2023 09:22:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/3] dt-bindings: regulator: pca9450: add pca9451a
 support
Content-Language: en-US, de-DE
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joy Zou <joy.zou@nxp.com>, ping.bai@nxp.com,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230531065724.3671795-1-joy.zou@nxp.com>
 <20230531065724.3671795-2-joy.zou@nxp.com>
 <f343458e-519c-1e5c-e48f-acfed2c00ad7@linaro.org>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <f343458e-519c-1e5c-e48f-acfed2c00ad7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::14) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS8PR10MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d3d35d-f4ea-4685-9d58-08db61a7d693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmOdg6443l2mqSr5P7UCQhfIWD5JNf+54+ky36WNmguNRHb0zygeQFdw6U5ma+wpHgUDZO0eV1/W9AsOs8UTzjAVH3GIFthOOH7jDT2Q4lf0Jks1DsgrQNfsgxZBCTTzEpwX/FAOV+FcQEmX83vGWVxbKsaL2uvSEvXWHRK5K5sPci81XvwZEaPIFFcYFxZS+VCyUPKZpq7hrOjSP6ibjb3Vhkpu0RrDMHWWOfi3smqo5a7cWJm2MBV1q7TEX5GmkwznH9rzlVXzYXal7sZ5LyrpX61uP1EmteC5XSEob0gG+Qx+9WlGF+jW5rPfO4mHcxak0xZCVZKYV5A6WPIlT4BXkKsmgrdOATdn7m9pjomdi2puShQZyuAksIJ0ulj+LCRsTf8EuOJTluFM5gJaChvKJ+0Q9XNJcsLxogCL2g3drfud1iVCFeIjBFkBjv0kBncCLpkwfkSwSJQS+AM+6mq8AKB/iBCdLCtFtaBKIJ804GivMAQ/h0H/LpFo09Gk+Ef/xixWb7FjQNeBLLu980gnCkH1VWZSRCXynFkG4Y7GqlsLc0cUf+l5UkolO3W3xsIE76g0oSy0SW0OU9IHhUiMaj3Oqw4oTmb5h/JZlmCnm3el2NDSojI5UXJo+fSrvDH7X70BzaLrHHdH3GxW13nerRt93W39tIPOJ0+1Fcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199021)(186003)(2616005)(38100700002)(41300700001)(31686004)(83380400001)(53546011)(6506007)(26005)(6512007)(6486002)(6666004)(478600001)(110136005)(921005)(4326008)(66476007)(66556008)(66946007)(316002)(5660300002)(31696002)(8936002)(44832011)(8676002)(7416002)(2906002)(86362001)(4744005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckhoMTJEMmEzZmt0STgrM0tLT3FzSldncnZObnFFMnpTakQ1RWc5MXRXd1ZX?=
 =?utf-8?B?alNwNkc4YzlsdExsYUxuK1pUTC9TSVp6dHRYUVc5YjhOampNbmVLVFJwV3By?=
 =?utf-8?B?TTNjWkhveFRMdkM5U1BRVjlPaHJKR09JNWxBTzRYeHRYWW1XMjZXbGt3Mksy?=
 =?utf-8?B?SUpyYU5mSEtHRDBXZy8xQktIL09IWVVZRG1lMHVmWUhLRTV5K1c1TW8rS1RN?=
 =?utf-8?B?czdoemFndU50Y2VyK3JlcVdtWTYzVkhpSFBNY3hMUDdYZWdCQzk5SFNNdDJP?=
 =?utf-8?B?eEdxUndTWkF2Yyt1UmJzN25xNVF3Vkh3L1F5MnBmVkFRUEgwditMbnJRSjJ3?=
 =?utf-8?B?eXVINFUvcHpDUXVwSVhoeDNYWFYwNzRHL2VZbGJFNGdPaVo3VEJocDg0YnRq?=
 =?utf-8?B?STVkT0dQQ1ZOc0o0a3g1UTFadk9CU3lydVRDRkc0RmdCT3YrV2JzSTRvSXJa?=
 =?utf-8?B?bkVOWGlGU2ljY1FIRnpmTzZNNlZ0Rk9pbHM2ODFTUTg0MUppbjh6Umk1TzJH?=
 =?utf-8?B?NEdDNS9oVmprRkxMQkY0TEdObDlXdFo4ZStTSERRbDQySnJHaGEwTVBpYW9F?=
 =?utf-8?B?dHhYN21XWGJtS1hKMkhwS3dOSEFkMjJnZWxOaWVEV0ZlY3pyY0VTRUhOL3Jz?=
 =?utf-8?B?dWdQSkhJYUpqY1lYS1FveTF1QmlMeHFMMG0rYUNRcUcra2lxeTEwa2JHZXI2?=
 =?utf-8?B?WU4ydlhHM2k3ZFRHWXkvQS9iY2NPZHhIbGFHNi9sUC9EVHNSTWZaNWpxKytW?=
 =?utf-8?B?bVlPditGWDNBRmVBa1pTVnZNMkNlNU91VkNRcy9rTmJ2b0d6akRncDkvZTVQ?=
 =?utf-8?B?ZnlrbGVJWGZ3dTFLaXFRdW44a2RNNTEvRGprVXJGd1BpSW82SHhjN2lwd1Bi?=
 =?utf-8?B?dGphNHlLMExLcWxldEpKNDRHa21IamVFZW8wdEN6bUZDWXdyZDJHY0VnNkFR?=
 =?utf-8?B?MUV6dEVxRjVCc2R3UDFyU3BOZEovdWluODR2bERsZ1Fyc1cxSEU5cTJ1eWRE?=
 =?utf-8?B?cWRETHBINmRUTUs5Y0RUcERCUFJYYlk0RUZLVzVhMUsreGIvNDBOazRqbjFj?=
 =?utf-8?B?MWpNSjBTdFlDYVMvRXpNamxwL01pYUpaOVY1N0hKekJKNkU3RjBIdG5idS9R?=
 =?utf-8?B?Yk9GaUg1TFFqUHc0akVYbmJEay9DZVpreS91VnlJa3BBRGNXdW9oVU9VdEZI?=
 =?utf-8?B?dUpmWGZieGZnOVBCb0pqWEk0UFpmd245ZkpPNU1tcVU1bFpaNmUvdXhpMG1R?=
 =?utf-8?B?QWlISHo5N3pNc2VDaUxsTHREb3prVFFrQ29nWWxxN0ZuYmFGZ2VoZ01PZ2F3?=
 =?utf-8?B?ZG9lVEtJNWZwQkYxK0hDYVBhV1dSUnlrSEZ6cW5GQ1BzM2xHa1NTbkxKZVNn?=
 =?utf-8?B?SzYvSDR2SHMyRlZHekxwWE1HWlY1K2lpK0R1VEV3Z3BLd2hwaFZmdlFFTnZp?=
 =?utf-8?B?T2JBaXlST2owZWpRclZndk9YNmg2NmNmUlJ0UVFvUzRjYWlXdXcxbDhlaGNw?=
 =?utf-8?B?MFFWWk4wU01zTi82Z3pqSEp3YnplaURmcVBxKzRsY0JpQUlyL04vbEVCWmVY?=
 =?utf-8?B?ZGZnOEpxdDhvT0QwMGVQYTV6ZWJIRS91allNcWIrWjNHdmdBZmlzbWNaUTJL?=
 =?utf-8?B?eDJ3b0ZoNGVEbVVaekE2K1VCSEJwZlZpOUhLMktOMEU2VS9Fd2U1ZUZoMWRs?=
 =?utf-8?B?Wm1lUmRDMmFVZ0lWVS9DTjVxVTlUaGtaS0cvRzFVRE1xUEFlVmNxS2RpVlht?=
 =?utf-8?B?SUxPd2VWeEh2c0plUjJrV1U5c3ZUbXRqbVArN3RsdVdyNTh1bmlHNTRhcTFo?=
 =?utf-8?B?NHUxbnZKc083MXNZYUhtSmczYW1ZckJHWmRvRFdFQ2F2c2NsQWFyV1RUYUNC?=
 =?utf-8?B?NmE4ZXEvRmJLWDRsRzYrZEtGS3NweGJDRmVhVlA3L0VuUHdkd1RkRnM4a0c4?=
 =?utf-8?B?T3pRVE9VYU5ySFJtYU82UHYxc0d4dzI2dEtzYTFWOGhTME1VZGh0cExlZkxu?=
 =?utf-8?B?TFB5aDFWTXAwVmVkUGordWRlaGtPYlBpVS9YTTl1VmV4YXRuZW9Qd054Vkpv?=
 =?utf-8?B?dVpqV2YxbFpCVHZWMnQ5ejVFRitwemFjeU1mU3pJa2t6WVYzemN5bTNvT0RD?=
 =?utf-8?B?UnRBOFRNeWRuTWFRUDl6bnJnb2k5Tk1rcVI2NlIzMGpMaFkyWm5TTGh5NWZk?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d3d35d-f4ea-4685-9d58-08db61a7d693
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 07:22:49.2763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+fXUmStH1MvtpfGAOdkvC/yhRjoZmt/bOmVxVQ7mTeLadtgB8UPpdN6e07alUhH+1xYHcgiOP0nWeUrDfHQlmK72sDEXUMKh5V0aH+24BY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6947
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.23 08:56, Krzysztof Kozlowski wrote:
> On 31/05/2023 08:57, Joy Zou wrote:
>> Update pca9450 bindings.
>>
>> Signed-off-by: Joy Zou <joy.zou@nxp.com>
>> ---
> 
> Subject prefix is: regulator: dt-bindings: pca9450:

Is there some way to have this consistent for all subsystems? Most
subsystems seem to use:

  dt-bindings: [subsystem]:

But some use:

  [subsystem]: dt-bindings:

Casual contributors (like me) will very often get it wrong on the first
try. Examining the history is extra effort that could be avoided and
often doesn't provide a definite hint as you find both variations in the
past.

Can we standardize this and make checkpatch validate the subject line?
