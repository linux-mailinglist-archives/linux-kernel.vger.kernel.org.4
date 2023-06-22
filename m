Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCD173A84B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjFVSdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjFVSc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:32:56 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2EB2100
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7tzibPoWZMXJATfc9J27aK2rDEK83rl8AjGi5XvIDFui1ubMSVBsYMO0cN394twNz7y7ueguLDBdwnHQyFK5PMlbSRWsqVUmK2lU6iN2QNmzF1aTgjbw0PhdnM1Z4sgbItUkzHI4M3JYb5gkrp6ZteI6HJxmrRN4A4m2FkVV7UjKaWBaPav4iMtnSNrtkdg3obTrWBdnHgOPc7pgLPxpVp7ByNzW+PDGEEigX5fHqmsxE+8MAeKcitshlR0wDZbOdpgwrMTLnStrQMosA3gR+c8IyCTxi9DsxNBd455j6b8lysqQhf0ULuLT2FA1O1ws1miVG8YHxxNqAsAzJSRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yljaLYdfLNleSYQ7iqiWD+ssnvMq4+en1wztnbDAV00=;
 b=ULyUVAfAed1T8q1bcR8FVzM9gzNb40PTNLhggegRw5s/EbQC/epasow9PfXFp2Rw7wNqYyYZ8AFqq0LMPsiewZYxgCVTX+E21zMhP/EN4NP7Z7eEfUYKjHzESiKq769Msc3dkThvzvhctaajts05DgElH42vh1fiCaIgj9Vzbtd9V4t7Fn0JONt4bnEJZNVjidlD0c6lZXTa1gkw15btlTFwiEj60DTJa6oHhhNGGwAMz0ckfKtKd3TNHVveFVopnlv3D1jWtNGg5w03HnZnRKH/JwwukBHRT1xArFcOSHAJYusrazH3v6TXh3/gZg81tIxIyr5Wc5NUV5PMrRZvTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yljaLYdfLNleSYQ7iqiWD+ssnvMq4+en1wztnbDAV00=;
 b=KoS6uX98hwWKPYgjiBd86yHUlF2BNo8hLi5xFAKp1rEUXQYEnzXlzTN9hPgfcL/idJsgY29JXIwsZI8Cni1NCevTHccMPFG5Hbby3TJOscztY2ag+SGKqClf79vqL6YJntf17siqlZwo7b50hOzBzruxRqUYISVqzlyJELpUkGwKDPRjl9KmURgOu+SFZJaTG2l6F/NAcz9L7i9rPzPVjkMZVQV8PohL9hJyLpoW5MJdIcrFE4P2HdQKjlWkT2YDMfgwBBMKs5Sq92oVN2xMtIh8YbjgIYWtMqzZwbhQ5azxpekT3nefQSd4Y8wKaP/+C0DnZ2MIJC7L/TGILmyPcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 22 Jun
 2023 18:32:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 18:32:52 +0000
Message-ID: <65d010fa-c801-eb4f-352f-8bfb52a67c85@siemens.com>
Date:   Thu, 22 Jun 2023 20:32:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 0/4] introduce tee-based EFI Runtime Variable Service
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>
References: <20230622085112.1521-1-masahisa.kojima@linaro.org>
 <8ce9f761-347d-1e8c-17d7-241d88c82451@siemens.com>
 <CAC_iWjJ28uKVpz_FrJ6dcUjCkrV9w5UO4WRr9SQxYFPmtmj59w@mail.gmail.com>
Content-Language: en-US
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAC_iWjJ28uKVpz_FrJ6dcUjCkrV9w5UO4WRr9SQxYFPmtmj59w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a71992c-d35c-4dec-2220-08db734f168e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0kTZxzO4yqISsPzPU9uXS/orJ68HGgNUX78/K3LMd33sd4bqMJO7Ky1VTFKic3Q1mLjcs6guIqD098Jo0JhJ3V0ui0qggoBgIyCS9YKTi1Z9MocrRxAErxueQlrCPsq3AB+QXj70CocjDl5BTywWN5ihAdTidURQn5Msv80KPLYzoDnH2VvAJN9ydyVCwliaFf8Ovpipg8UxY9NS4nB9bkWnHKOgG6jGx8hrEW5wjNWtvy6v6Whir9BOwOnCiT/FnEfjvdrPLOzlgfzcTmHvzIU/HKA+xhOrP3I+WjwGeFiKL849ngIpRMJywQEqUqAeqFzT23FgAlbFmVM10gnPhqt8WHYROTCAN7OcXDTUD6Ld2eamsBG5hyGItE66Htwa/yNM9qST7UeDWnKWlD3GUdSvD+m+9vsBA7L8jrR1gFpCCl+UjB0d2ViYnAOQmRA9pypZu0cBpYYDDvRSIFxk1tCmSdY7EWnHhkOazK1cbbIL0meQnLDNrKK4Wel3TRiOm3MGfA05m1szM6aj3Y2HIOgAxRmDC7T3I5UHStECL6/kXW1rAUVwKYHNuUruULhpDjOdk4KwfFrY7NBguuY9E46rKPSjH9Ak5gejlgSd8CpCQiArLAsvi7lXsPBaHoWU0oXgfELPQhfjMwm70H3/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(53546011)(54906003)(186003)(6512007)(26005)(6506007)(6486002)(6666004)(41300700001)(66899021)(31686004)(478600001)(66946007)(66556008)(66476007)(6916009)(316002)(4326008)(38100700002)(82960400001)(44832011)(5660300002)(8936002)(8676002)(86362001)(83380400001)(2906002)(2616005)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFRYN3gycHQ1bThtTkV6TEg3QWJEREQrMzJpWmRHVmwwRmVUdFNKRXBXVHZk?=
 =?utf-8?B?b0tVajRuOWRsb3NWRmdLSHBxK1ErNW9BQTd5WmZpeDcwMTNESU9ZeTUvbWFn?=
 =?utf-8?B?c1VLZTlodlFYSU5WaUFpSXlHekV0eUVVSHl4U0QxSi90cVNvTUlZcjUwZmNo?=
 =?utf-8?B?YUxOcExURURYUWVrUFJoOENMQWFTYmMzdmJHRFRmY056cWxZTlE4YlZKaFFD?=
 =?utf-8?B?RkVHLzhTTXJHelk0SVY5OTBaSzlzK09RbzhMOU41a25TRis2RFNZVGUzNzQ5?=
 =?utf-8?B?U2grT05HeFVXNkVzMlBMalNHTlo4cVMzTUwydUE3TW5adjU2VHR0T3ZVTmZi?=
 =?utf-8?B?ZFNmYVFFMGgzc2ZQVmtqZE15dUREZ21sVHltdUlRVW5la3RRRkd1SnNvS2NL?=
 =?utf-8?B?ZEtianZpaWZiU3pVN1VSaDVvbVZ2QXJZK00zSzMxb0haNjNSZnlIVzdkakk5?=
 =?utf-8?B?bWprbVoxMU92UG9Ccmc0WFpaQ1cyVW55Q3ZmaThoVWttL0d4eXBxaVJsSFh0?=
 =?utf-8?B?cnN0Uno3R25DcS85alFDZnZ3bmozeDN4N2dUNkRpekdHa0VISVlhaHlWLzdW?=
 =?utf-8?B?N1lpbUxxUVVYZkFNUWFyT1g3NE5ZaTNoUjZDa3RNbmJ1eHZEN25pNk9aQml4?=
 =?utf-8?B?SWhOekF4Tk5sV2NCN2hSZGxzK0tUOHFHd2x4ODZZaGtqSGVINzBuajlCQ1Rk?=
 =?utf-8?B?UE0vbFg3a3pGcjlocTdHZUVsWi9wVEVmUkQweFNjZVFYOHJ0RW8vSWlOdlhG?=
 =?utf-8?B?dFVtM3pGYkhNZ1ZPWUo3cklxd1kxQVVFbU9hV0hhYk9kR3hvS0ZQdTZhMjJn?=
 =?utf-8?B?N0djbENTSmkwRnhIVWRHOWlmWG1vN2krdXZwbG5EUzM0U0R3dzNFNW1jaHp6?=
 =?utf-8?B?a2tobHNaN0pPNlg4TEtUQlh4ZUI4MlRHQ2F4TjZueG14SnMvaGpqUXRUNklD?=
 =?utf-8?B?dHRaYzBXQ1ZmdE4rVlQzakE3aHBFREZlMGpRaHQyaG9Uc3JZM0NYU2tPZCti?=
 =?utf-8?B?aXBuK2dOS0VuNmw1V0xlQXhtYXFwZHNKb1dDZFIxRlhuaTZadDgweHRLT0JC?=
 =?utf-8?B?czRGVTh0VTZKWGFsV3dQY2NoOEo5YTFzeC9HQm4weVFYQlBuU1pTV1hWdFho?=
 =?utf-8?B?OU8xU05kTEd3L2k3ZjhZdWV4OThRTkV6YzVWWFhoVmVpWE43aVNCZTVJdzlp?=
 =?utf-8?B?d25NeTNvd3RrOFVuUktLMVRkemJ3bjBpTU84aGE5RFc0SEwycmcrc05JbGpU?=
 =?utf-8?B?czFYdVNWaExrNmJrZjArNmlORVBrNCtIcGFwWVdFd2EyVHBrdDc2ZVUyZjJa?=
 =?utf-8?B?QU9kVFlDM00xRXdhR21WMnpwTWVqSHJZSW5JM1hsbkJWeG9tbXJIMjFrQ1BP?=
 =?utf-8?B?TVR6eUlZRGMrcUdIN01BRzU1bDFsaC8zLzNpTmpzRFZMR0pIMnJMdGdlS2dm?=
 =?utf-8?B?MU56RW1XRzhsd2tPK211cDBtTkd0Y1JOWWt1VE43R2lyVWRjSytrZWo3VkZo?=
 =?utf-8?B?Y1MrSCtrQm5TM0QxSmRTdTJKckpZUFNMcy9qcjVqNnhZcE5WanllSWFJRkFw?=
 =?utf-8?B?N2phcWUxdTNuVld0TEtwbkxxZVdSZ0VaYS9ydFh0MXBYQW5jVWdoSU1CdDhq?=
 =?utf-8?B?U0hqc1p4TFRGU0pHYnVmSmRyYklvM0RQTmo3aHBZMjBUbjBRc2pyZDhZT0Jw?=
 =?utf-8?B?U0ZFRzM4akJPZS91VlcwNFAxd09HZzk0RHV6RW1wNTVBYjlMcHVRSTEzNjE4?=
 =?utf-8?B?MVZRbzcra1hOeW5BN2xKSDgzSk51NFFOQU53aExuSkUyejRydVkzcVZKTUg1?=
 =?utf-8?B?aVZNV0JFWUVkTUphajR2MDJuSkF2ZHhGQlpNQis3dkRLbFVEM2lTWUFBVWhy?=
 =?utf-8?B?SFYwMjVXNGU1L2pvS0NKWll5SThrR1VLYW1vYm1FL1JzWGZyY29sV3hnVnFD?=
 =?utf-8?B?cGZOMm5PaWxjakM0SEhnKzRORDR5TTFCL01neXRtY05VWHpDWU1VMEd3TTNC?=
 =?utf-8?B?MDFmdHVHSWhzKzFOVk81dVVzbllucnlucUdWVVMvU2NJazB2eWsvVE5xenVh?=
 =?utf-8?B?cHNLT0JuVGtndlp6blIxSGZHWEdmckd2ZzBZMzRWRzR6WksrS09GUmxBTEZ2?=
 =?utf-8?B?b2hBeXFZbkc5TmRiMFZlRXlrMXRhc1RLM1BsdkFrdkxpbWtYTDR0VGZ6aVpC?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a71992c-d35c-4dec-2220-08db734f168e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 18:32:52.2409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYgcEVl4NpIlPs5WGhy69Q2P7nhPDO5Nl12W0b9ay2JYv9ArAZn2D5n8OgJxxwWYyZ/awElGfRZ/n/m0chI+Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7198
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.23 17:04, Ilias Apalodimas wrote:
> Hi Jan,
> 
> On Thu, 22 Jun 2023 at 17:56, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 22.06.23 10:51, Masahisa Kojima wrote:
>>> This series introduces the tee based EFI Runtime Variable Service.
>>>
>>> The eMMC device is typically owned by the non-secure world(linux in
>>> this case). There is an existing solution utilizing eMMC RPMB partition
>>> for EFI Variables, it is implemented by interacting with
>>> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
>>> and tee-supplicant. The last piece is the tee-based variable access
>>> driver to interact with OP-TEE and StandaloneMM.
>>>
>>> Changelog:
>>> v5 -> v6
>>> - new patch #4 is added in this series, #1-#3 patches are unchanged.
>>>   automatically update super block flag when the efivarops support
>>>   SetVariable runtime service, so that user does not need to manually
>>>   remount the efivarfs as RW.
>>
>> But that is not yet resolving the architectural problem with that
>> userspace daemon dependency. What are the next steps for that now?
> 
> We are trying to find some cycles to work on that, however, I don't
> have a time estimate on that.  But the question is different here.
> Since this addresses the problems distros have wrt to SetVariableRT
> (even for a limited set of platforms) are we ok pulling this in?  I
> can't think of a technical reason we shouldn't.  The supplicant
> limitations are known and the firrmwareTPM has a similar set of
> problems.

It will not change we have to do on the distro side because we have to
deal not only with the startup issue and StMM but also with fTPM and
with shutdown. Only an in-kernel supplicant for RPMB would resolve that
according to my understanding.

But the question is fair if we can evolve from this stage here to an
in-kernel approach without causing breakages or other headache to
distros adopting it (too early). That's why I asked for the roadmap.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

