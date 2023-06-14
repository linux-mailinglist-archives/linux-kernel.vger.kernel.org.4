Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621037300DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbjFNNzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbjFNNzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:55:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6921106;
        Wed, 14 Jun 2023 06:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnGKSqbhOR124QoODwnI/hg/KATAUKwdOLHQbrESoJ11ALnrIyat9LpCfl7sFcrkt14Y6WoLuqCV33P8Kzq8Quf/nwvM0THUQ2FA1rIeX6+34wWzGu6XvzkbC5xubXJBR3vf1x2DDOG8Puy/hJNzpHP7wWl4qBnC5XdtQale6I8EU54WKF6Of8cbbObhXGQPqv1HmlnxjqAIdm7U3ogLGPy97z/Heg79KuhVWpnif3LIjNZ/SM0E118u+O1whIElBibfos2zzaH5EWIfiKbQlla0drG/I2x0QEfMu9ffz8kIccVAkpZdKqZK/+bwOyxkSedN8vhE7SzRSMPRREyuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5GO/WdcglvVNU0eaoYroE5WbwusWt433xgfo5bEcpE=;
 b=cenapdbzLMFow4nqOvIMSJAc2s5NGL7SnDwbve2aL8d/hUcheh/jO2b1iYldJ8aVoZt9XX9Dudy23KBm2XldC48TALC3tlerUILyD6BjE+g1QwCmNbFucSHIA24CxROcPx/LLNCmEgkneZkw61TFuoruUVYsuUuuy2600sZn5/l4YxYBgYMSelHV7NpRWvf0fklYwN9v4zwRvGnemZqseEalIVJX1e7F09MzamOHMtNce+AWtqWgnDHUFcJUpzSpqhaZCQz4oxANdCbjkuduLLdiWySEFenXgt63TcmmCzG/1vTmKuRkRqcHWI8oKRCD6kE+Jn/ZczO7aiLw8F+lMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5GO/WdcglvVNU0eaoYroE5WbwusWt433xgfo5bEcpE=;
 b=KlCqd+wFZddbGmABI7y9Qe5dOX/2yUIFXv+FU9phEVlrdSwFreUPWdU4LmyNpg9wsJ+MIaEsCAe02p2a+Ut4P2maun80H8vcovpGGUZY8EqrQlqfbjYZGxxh34sMoonaQuc4hdhiBENDROKGQunop3rAGZqTEVD7ta1IKfEAEz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1SPRMB0007.namprd12.prod.outlook.com (2603:10b6:208:39e::8)
 by CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 13:55:35 +0000
Received: from BL1SPRMB0007.namprd12.prod.outlook.com
 ([fe80::3404:aab:eb6f:8754]) by BL1SPRMB0007.namprd12.prod.outlook.com
 ([fe80::3404:aab:eb6f:8754%6]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 13:55:35 +0000
Message-ID: <902093e0-dd44-d542-363d-06367a533fce@amd.com>
Date:   Wed, 14 Jun 2023 08:55:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
To:     Randy Dunlap <rdunlap@infradead.org>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ardb@kernel.org, kraxel@redhat.com, dovmurik@linux.ibm.com,
        elena.reshetova@intel.com, dave.hansen@linux.intel.com,
        Dhaval.Giani@amd.com, michael.day@amd.com,
        pavankumar.paluri@amd.com, David.Kaplan@amd.com,
        Reshma.Lal@amd.com, Jeremy.Powell@amd.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        alexander.shishkin@linux.intel.com, thomas.lendacky@amd.com,
        tglx@linutronix.de, dgilbert@redhat.com,
        gregkh@linuxfoundation.org, dinechin@redhat.com,
        linux-coco@lists.linux.dev, berrange@redhat.com, mst@redhat.com,
        tytso@mit.edu, jikos@kernel.org, joro@8bytes.org, leon@kernel.org,
        richard.weinberger@gmail.com, lukas@wunner.de, jejb@linux.ibm.com,
        cdupontd@redhat.com, jasowang@redhat.com, sameo@rivosinc.com,
        bp@alien8.de, seanjc@google.com, security@kernel.org,
        Larry Dewey <larry.dewey@amd.com>
References: <20230612164727.3935657-1-carlos.bilbao@amd.com>
 <82f5bcec-103b-f449-281e-ff82e2f27efe@infradead.org>
Content-Language: en-US
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <82f5bcec-103b-f449-281e-ff82e2f27efe@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::26) To BL1SPRMB0007.namprd12.prod.outlook.com
 (2603:10b6:208:39e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1SPRMB0007:EE_|CH0PR12MB5331:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e8c41d-f601-49e5-af9d-08db6cdf0694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XE3k+hBOThZVTksLkg4tCRb08aVP9RZOb76JL6DSjDoDIg19KO1yx2HrewImYs/b35F91/jBnqnMQdchSWeFmNqotGxSroAKwuO2GVzZcbHnHS89GaiJ3EFWEnHg27Nhj+24TCe6BFF7Tz4FF3hRHk5YPXP7yTTjTB6608Gk8HX4BN1woaT6zHQ8USEqe+04oNogbn09Ijav7u1XpA0MCDbJt8bSxliT/oYj0jU1qnVx9dTzGB4AhLyB84a82qN3NORGDjfSnIJ7EPI9wSJwOiBH89GOPl41xEMrej+s0UQIfQwbrSvWWnnYdYCElm90hYn3g1064VBrQ/rAUgvoGQfgUGPyIygqRem5btWA+McPZhS9Zq45eybs99pixhKsMaupZ/QkK2veGJkEU8wN5LBZtVSNcUnaY5nv1U1ZkWAZyFaTdiHlMCytMsyDVNDlQbXIpso2wNvnOhL25VdH8i/c6krY2a5hi0M19WE4oNWncWWp1K8kI393G273fPg8x9SmB71gR6+CRkE62C0ryfmBschf81tK43gq6mfU76ogkMckH6oFA8tBZnKDK8FNP7/aR9yyiwTt/NuU+T5z30Ltogca1VXL/vXk8eaLHa/m7JJCdOAx0MNoX0hxCDhqa9TtXRGLrNQn0zuSKaP3GFdICFK+XBQ/Yc55yGMFrgGIxIbQ1Z/+UcU4HopS12M2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1SPRMB0007.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(6486002)(6666004)(966005)(2616005)(36756003)(83380400001)(86362001)(38100700002)(31696002)(6506007)(53546011)(26005)(6512007)(2906002)(30864003)(15650500001)(66476007)(44832011)(186003)(66556008)(7416002)(316002)(4326008)(41300700001)(31686004)(7406005)(5660300002)(478600001)(66946007)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkJxSmROZWdDaFdmakV4R2o2enFHSjgxSFVaR3krZlhxN3RJcjR0WGNsTXN1?=
 =?utf-8?B?MGV2Y0RVR3ArSkd0bkYzNlhxSC9OdXRxSGo1dGMvNXluQldiL2pyTFg0RXhm?=
 =?utf-8?B?b2s2U285Vkp6Z3h3L2Y2U1Bla2VFeC9MV2tiOVR3dFo5WitQTU5DN3RmYkV0?=
 =?utf-8?B?UmdadGRuSFdETGlKQ1ozeGZvSHpHRGwzNDRYU2tCVVpXTnpnUFFoTURIM3Ey?=
 =?utf-8?B?Rnp4WjR6RlY1ZGExLzZLL3U1WmpxbFozeVVKRCs2aGk0OU9ndDB1dlBOS3Nl?=
 =?utf-8?B?azdVdmFjMVRKOUkrYzJLT3U1VHhVSGJlNnFuejZWUG9oWnI0bUlHNy9jQjdy?=
 =?utf-8?B?bmhKYWZYeDludk9ya0crUkVacnV1SXJpUlRrcWZjVEY5TmE0Qzl3d1VabnJi?=
 =?utf-8?B?Y2ZFcEVudU83TzZ2WEM5MU1lU3JEZVM5bitMRVhkYkEyL3JOQUZEa0E4bDNz?=
 =?utf-8?B?UXMzNHdZdC9rZTNGWnFVVlBBWGx2K25qd1h3d3djbWRUNU0rbklCelNRSjN3?=
 =?utf-8?B?eGhDLzhkQ084UjBLNnIvSjViVkpLRW12NmhWZ2FncnVYUkg3dyt4M2NJZGNC?=
 =?utf-8?B?ckkwM3Y0RTVwU0NQUGxoL092elJVRU84dlpXai85THAvbDlHeklDVk16V3Zq?=
 =?utf-8?B?UU03cU9TejJDS2lINHJrc3JWbExFN1Y1TmZJNFBlcElwZ2kwM0RUcVM1TFor?=
 =?utf-8?B?WWphTktEZ0dnNkMvN2h3K1hjQjF4Y1EwNVlKaHhLdzdJSERqd3cvTXQ4TlpU?=
 =?utf-8?B?bzBmeEg3WURvbmp1Z3VUMXZKZWZlWkxNY0xHTDhzV0RMQzBlcnR4M3lmcUhU?=
 =?utf-8?B?a1pjRkh3WTZBUWg4T0JDOHdSMlRhRi9sODBuNVFUQzBUcnJLTEpCeGRDdllq?=
 =?utf-8?B?VUdFbW9TZ1ljVndIcGpmVTkyMTVQNmk3WXE3ckg3ZjlZTnlhRWVIUFFrbTl3?=
 =?utf-8?B?N2JZTUJvWXRiUUVHMjhPTGRXOHBFWnRXTmErZ0RzZUtlbEdxMkI4RHVacWVR?=
 =?utf-8?B?WmVLYVpDbjZEeGw2d0tYMzZSZXlvekpqQlF3czZneW9EUWdYQU9EOGpFeWI5?=
 =?utf-8?B?R2tlZWtNb2ppNXVFT3U0dXM2RWlYcHcwUmxzMFl2MjJDWGhEb1FONDNjYkpK?=
 =?utf-8?B?NklMZDlvc3FVa3BuV0VqVDQzWjIwb1JWaHdLTkhURldTb2FFcGRROFdTQXB6?=
 =?utf-8?B?TXFHMGRaMW9nVkRoSnp2WjI0NmZHSERiU1RLdDYwZGtlUUE5Y3BOQlBnN01h?=
 =?utf-8?B?Y2JMbHc4N3Z0OUZzWXVHSG9wSDZNbzdvQ0x5b1ZoeFFIY1poZFJnRVM2NVZF?=
 =?utf-8?B?VHpkZm1XZGhkVFJZdGZHUHlCRnhQcEpUQVJ0dDJwR3BoY3BOQkxab1hUZUVD?=
 =?utf-8?B?SzArdHhBcnFwYzZaYjhLL09tZmZGYU41RndnYno3QVdMT3BRajRKVzdoQVU4?=
 =?utf-8?B?Q3dIeGcvbkZudlVMa0F6d3RjWGhQV0Y3eFRReDc0M2kzWjcraExVZ0JGUjF6?=
 =?utf-8?B?MVpQbzFxVDlJZ0ZCKzhNRUZGQTZGL1Vra2FmSng5WHlKL2RQUWNaR3J3L2NX?=
 =?utf-8?B?a3RXL2FaalYxV1F1RDhjMUNZU2MzcFYwMEFoZVdPb3liN1JGeDJEUlJIRGJu?=
 =?utf-8?B?QUx2Vi83RjNUZ3Qrb1MvNlRlOWhpNnYyZDRKdXNib0l0MnFVUVk4R1owditi?=
 =?utf-8?B?Rkp2eTJsOThVa3Q4a3dwTmhuSEE4RXVLOUFtUEpyR3FWUHJPYzF6bzZwNlk0?=
 =?utf-8?B?S1ViblBhaWdzYUFqcjcyNXlOcG93dERQcjJlR0s0UUk5Q0NFeFJzMFNhZGc0?=
 =?utf-8?B?aEl2NkxXN1dueHFTbmZBQmd5ZkhQVlZhMUdZM3AxRnFabVh4dEVtbndWalc1?=
 =?utf-8?B?blFqajFQZmx3NERxZEY2cDl0dldIWERqTUo3ME1tZ0hmS0NWRkFFZGtWdHJN?=
 =?utf-8?B?OFppNnIzSDhFeHBqM3QrQmVSdHF4bWEzTlhnRW5vNTVTeWx0UHNpOFh2b3pC?=
 =?utf-8?B?bWc4QVVaaTJsbWtCZjJWOGFIQjZMYS9vTG85MzdvUUtYOVk0ZWE3NlYremJT?=
 =?utf-8?B?c1FtR0xweEZWTFp2cmdiQkhlcmNIYks5YmplaFdEYlJLNlpUajY5LzlSWGNX?=
 =?utf-8?Q?VsRwL9WSbS6EEO3yvvB1g2UzP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e8c41d-f601-49e5-af9d-08db6cdf0694
X-MS-Exchange-CrossTenant-AuthSource: BL1SPRMB0007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 13:55:34.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXlGJKteqS6reEfZIwAkJuF4pXuiwJ6dV6fSA3G4kxdT6s6xLXnHzbjuRhcbL7EfuIcZV5Ofd5t9whEzf//JIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,

On 6/12/23 17:43, Randy Dunlap wrote:
> Hi--
> 
> On 6/12/23 09:47, Carlos Bilbao wrote:
>> Kernel developers working on confidential computing for virtualized
>> environments in x86 operate under a set of assumptions regarding the Linux
>> kernel threat model that differs from the traditional view. Historically,
>> the Linux threat model acknowledges attackers residing in userspace, as
>> well as a limited set of external attackers that are able to interact with
>> the kernel through networking or limited HW-specific exposed interfaces
>> (e.g. USB, thunderbolt). The goal of this document is to explain additional
>> attack vectors that arise in the virtualized confidential computing space
>> and discuss the proposed protection mechanisms for the Linux kernel.
>>
>> Reviewed-by: Larry Dewey <larry.dewey@amd.com>
>> Reviewed-by: David Kaplan <david.kaplan@amd.com>
>> Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
>> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>
>> V1 can be found in:
>>   
>> https://lore.kernel.org/lkml/20230327141816.2648615-1-carlos.bilbao@amd.com/
>> Changes since v1:
>>
>> - Apply feedback from first version of the patch
>> - Clarify that the document applies only to a particular angle of
>>    confidential computing, namely confidential computing for virtualized
>>    environments. Also, state that the document is specific to x86 and
>>    that the main goal is to discuss the emerging threats.
>> - Change commit message and file name accordingly
>> - Replace AMD's link to AMD SEV SNP white paper
>> - Minor tweaking and clarifications
>>
>> ---
>>   Documentation/security/index.rst              |   1 +
>>   .../security/x86-confidential-computing.rst   | 298 ++++++++++++++++++
>>   MAINTAINERS                                   |   6 +
>>   3 files changed, 305 insertions(+)
>>   create mode 100644 Documentation/security/x86-confidential-computing.rst
>>
>> diff --git a/Documentation/security/index.rst 
>> b/Documentation/security/index.rst
>> index 6ed8d2fa6f9e..bda919aecb37 100644
>> --- a/Documentation/security/index.rst
>> +++ b/Documentation/security/index.rst
>> @@ -6,6 +6,7 @@ Security Documentation
>>      :maxdepth: 1
>>      credentials
>> +   x86-confidential-computing
> 
> Does the new entry align with the others?

Yes, I believe so.

> 
>>      IMA-templates
>>      keys/index
>>      lsm
>> diff --git a/Documentation/security/x86-confidential-computing.rst 
>> b/Documentation/security/x86-confidential-computing.rst
>> new file mode 100644
>> index 000000000000..5c52b8888089
>> --- /dev/null
>> +++ b/Documentation/security/x86-confidential-computing.rst
>> @@ -0,0 +1,298 @@
>> +======================================================
>> +Confidential Computing in Linux for x86 virtualization
>> +======================================================
>> +
>> +.. contents:: :local:
>> +
>> +By: Elena Reshetova <elena.reshetova@intel.com> and Carlos Bilbao 
>> <carlos.bilbao@amd.com>
>> +
>> +Motivation
>> +==========
>> +
>> +Kernel developers working on confidential computing for virtualized
>> +environments in x86 operate under a set of assumptions regarding the Linux
>> +kernel threat model that differ from the traditional view. Historically,
>> +the Linux threat model acknowledges attackers residing in userspace, as
>> +well as a limited set of external attackers that are able to interact with
>> +the kernel through various networking or limited HW-specific exposed
>> +interfaces (USB, thunderbolt). The goal of this document is to explain
>> +additional attack vectors that arise in the confidential computing space
>> +and discuss the proposed protection mechanisms for the Linux kernel.
>> +
>> +Overview and terminology
>> +========================
>> +
>> +Confidential Computing (CoCo) is a broad term covering a wide range of
>> +security technologies that aim to protect the confidentiality and integrity
>> +of data in use (vs. data at rest or data in transit). At its core, CoCo
>> +solutions provide a Trusted Execution Environment (TEE), where secure data
>> +processing can be performed and, as a result, they are typically further
>> +classified into different subtypes depending on the SW that is intended
>> +to be run in TEE. This document focuses on a subclass of CoCo technologies
>> +that are targeting virtualized environments and allow running Virtual
>> +Machines (VM) inside TEE. From now on in this document will be referring
>> +to this subclass of CoCo as 'Confidential Computing (CoCo) for the
>> +virtualized environments (VE)'.
>> +
>> +CoCo, in the virtualization context, refers to a set of HW and/or SW
>> +technologies that allow for stronger security guarantees for the SW running
>> +inside a CoCo VM. Namely, confidential computing allows its users to
>> +confirm the trustworthiness of all SW pieces to include in its reduced
>> +Trusted Computing Base (TCB) given its ability to attest the state of these
>> +trusted components.
>> +
>> +While the concrete implementation details differ between technologies, all
>> +available mechanisms aim to provide increased confidentiality and
>> +integrity for the VM's guest memory and execution state (vCPU registers),
>> +more tightly controlled guest interrupt injection, as well as some
>> +additional mechanisms to control guest-host page mapping. More details on
>> +the x86-specific solutions can be found in
>> +:doc:`Intel Trust Domain Extensions (TDX) </arch/x86/tdx>` and
> 
> <Documentation/arch/x86/tdx>
> or does it work without the leading subdir?

It works like this.

> 
>> +`AMD Memory Encryption 
>> <https://www.amd.com/system/files/techdocs/sev-snp-strengthening-vm-isolation-with-integrity-protection-and-more.pdf>`_.
>> +
>> +The basic CoCo guest layout includes the host, guest, the interfaces that
>> +communicate guest and host, a platform capable of supporting CoCo VMs, and
>> +a trusted intermediary between the guest VM and the underlying platform
>> +that acts as a security manager. The host-side virtual machine monitor
>> +(VMM) typically consists of a subset of traditional VMM features and
>> +is still in charge of the guest lifecycle, i.e. create or destroy a CoCo
>> +VM, manage its access to system resources, etc. However, since it
>> +typically stays out of CoCo VM TCB, its access is limited to preserve the
> 
>                                                         to preserving the
> ?

I think that using "preserving" and "preserve" here may result in two
different interpretations:

"limited to preserve the security objectives" suggests that the limited
access is enforced to preserve the security guarantees. In other words, the
act of limiting access itself, particularly from the VMM, helps to maintain
the security objectives. This is what we want to say.

"limited to preserving the security objectives" suggests that the access of
the VMM is limited to the components that allow the VMM to preserve the
security objectives.

Hope that makes sense?

> 
>> +security objectives.
>> +
>> +In the following diagram, the "<--->" lines represent bi-directional
>> +communication channels or interfaces between the CoCo security manager and
>> +the rest of the components (data flow for guest, host, hardware) ::
>> +
>> +    +-------------------+      +-----------------------+
>> +    | CoCo guest VM     |<---->|                       |
>> +    +-------------------+      |                       |
>> +      | Interfaces |           | CoCo security manager |
>> +    +-------------------+      |                       |
>> +    | Host VMM          |<---->|                       |
>> +    +-------------------+      |                       |
>> +                               |                       |
>> +    +--------------------+     |                       |
>> +    | CoCo platform      |<--->|                       |
>> +    +--------------------+     +-----------------------+
>> +
>> +The specific details of the CoCo security manager vastly diverge between
>> +technologies. For example, in some cases, it will be implemented in HW
>> +while in others it may be pure SW. In some cases, such as for the
>> +`Protected kernel-based virtual machine (pKVM) 
>> <https://github.com/intel-staging/pKVM-IA>`,
>> +the CoCo security manager is a small, isolated and highly privileged
>> +(compared to the rest of SW running on the host) part of a traditional
>> +VMM.
>> +
>> +Existing Linux kernel threat model
>> +==================================
>> +
>> +The overall components of the current Linux kernel threat model are::
>> +
>> +     +-----------------------+      +-------------------+
>> +     |                       |<---->| Userspace         |
>> +     |                       |      +-------------------+
>> +     |   External attack     |         | Interfaces |
>> +     |       vectors         |      +-------------------+
>> +     |                       |<---->| Linux Kernel      |
>> +     |                       |      +-------------------+
>> +     +-----------------------+      +-------------------+
>> +                                    | Bootloader/BIOS   |
>> +                                    +-------------------+
>> +                                    +-------------------+
>> +                                    | HW platform       |
>> +                                    +-------------------+
>> +
>> +There is also communication between the bootloader and the kernel during
>> +the boot process, but this diagram does not represent it explicitly. The
>> +"Interfaces" box represents the various interfaces that allow
>> +communication between kernel and userspace. This includes system calls,
>> +kernel APIs, device drivers, etc.
>> +
>> +The existing Linux kernel threat model typically assumes execution on a
>> +trusted HW platform with all of the firmware and bootloaders included on
>> +its TCB. The primary attacker resides in the userspace, and all of the data
>> +coming from there is generally considered untrusted, unless userspace is
>> +privileged enough to perform trusted actions. In addition, external
>> +attackers are typically considered, including those with access to enabled
>> +external networks (e.g. Ethernet, Wireless, Bluetooth), exposed hardware
>> +interfaces (e.g. USB, Thunderbolt), and the ability to modify the contents
>> +of disks offline.
>> +
>> +Regarding external attack vectors, it is interesting to note that in most
>> +cases external attackers will try to exploit vulnerabilities in userspace
>> +first, but that it is possible for an attacker to directly target the
>> +kernel; particularly if the host has physical access. Examples of direct
>> +kernel attacks include the vulnerabilities CVE-2019-19524, CVE-2022-0435
>> +and CVE-2020-24490.
>> +
>> +Confidential Computing threat model and its security objectives
>> +===============================================================
>> +
>> +Confidential Computing adds a new type of attacker to the above list: a
>> +potentially misbehaving host (which can also include some part of a
>> +traditional VMM or all of it), which is typically placed outside of the
>> +CoCo VM TCB due to its large SW attack surface. It is important to note
>> +that this doesn’t imply that the host or VMM are intentionally
>> +malicious, but that there exists a security value in having a small CoCo
>> +VM TCB. This new type of adversary may be viewed as a more powerful type
>> +of external attacker, as it resides locally on the same physical machine
>> +-in contrast to a remote network attacker- and has control over the guest
> 
> Hyphens (dashes) are not normally used for a parenthetical phrase AFAIK.

Yes, parentheses would be more appropriate.

> 
>> +kernel communication with most of the HW::
> 
> I would prefer to capitalize "kernel" above.

I'm not sure I follow, we don't capitalize kernel elsewhere, why here?

> 
>> +
>> +                                 +------------------------+
>> +                                 |    CoCo guest VM       |
>> +   +-----------------------+     |  +-------------------+ |
>> +   |                       |<--->|  | Userspace         | |
>> +   |                       |     |  +-------------------+ |
>> +   |   External attack     |     |     | Interfaces |     |
>> +   |       vectors         |     |  +-------------------+ |
>> +   |                       |<--->|  | Linux Kernel      | |
>> +   |                       |     |  +-------------------+ |
>> +   +-----------------------+     |  +-------------------+ |
>> +                                 |  | Bootloader/BIOS   | |
>> +   +-----------------------+     |  +-------------------+ |
>> +   |                       |<--->+------------------------+
>> +   |                       |          | Interfaces |
>> +   |                       |     +------------------------+
>> +   |     CoCo security     |<--->| Host/Host-side VMM |
>> +   |      manager          |     +------------------------+
>> +   |                       |     +------------------------+
>> +   |                       |<--->|   CoCo platform        |
>> +   +-----------------------+     +------------------------+
>> +
>> +While traditionally the host has unlimited access to guest data and can
>> +leverage this access to attack the guest, the CoCo systems mitigate such
>> +attacks by adding security features like guest data confidentiality and
>> +integrity protection. This threat model assumes that those features are
>> +available and intact.
>> +
>> +The **Linux kernel CoCo VM security objectives** can be summarized as 
>> follows:
>> +
>> +1. Preserve the confidentiality and integrity of CoCo guest's private
>> +memory and registers.
>> +
>> +2. Prevent privileged escalation from a host into a CoCo guest Linux 
>> kernel.
>> +While it is true that the host (and host-side VMM) requires some level of
>> +privilege to create, destroy, or pause the guest, part of the goal of
>> +preventing privileged escalation is to ensure that these operations do not
>> +provide a pathway for attackers to gain access to the guest's kernel.
>> +
>> +The above security objectives result in two primary **Linux kernel CoCo
>> +VM assets**:
>> +
>> +1. Guest kernel execution context.
>> +2. Guest kernel private memory.
>> +
>> +The host retains full control over the CoCo guest resources, and can deny
>> +access to them at any time. Examples of resources include CPU time, memory
>> +that the guest can consume, network bandwidth, etc. Because of this, the
>> +host Denial of Service (DoS) attacks against CoCo guests are beyond the
>> +scope of this threat model.
>> +
>> +The **Linux CoCo VM attack surface** is any interface exposed from a CoCo
>> +guest Linux kernel towards an untrusted host that is not covered by the
>> +CoCo technology SW/HW protection. This includes any possible
>> +side-channels, as well as transient execution side channels. Examples of
>> +explicit (not side-channel) interfaces include accesses to port I/O, MMIO
>> +and DMA interfaces, access to PCI configuration space, VMM-specific
>> +hypercalls (towards Host-side VMM), access to shared memory pages,
>> +interrupts allowed to be injected into the guest kernel by the host, as
>> +well as CoCo technology specific hypercalls, if present. Additionally, the
> 
>                  technology-specific

True!

> 
>> +host in a CoCo system typically controls the process of creating a CoCo
>> +guest: it has a method to load into a guest the firmware and bootloader
>> +images, the kernel image together with the kernel command line. All of this
>> +data should also be considered untrusted until its integrity and
>> +authenticity is established via attestation.
>> +
>> +The table below shows a threat matrix for the CoCo guest Linux kernel with
>> +the potential mitigation strategies. The matrix refers to CoCo-specific
>> +versions of the guest, host and platform.
>> +
>> +.. list-table:: CoCo Linux guest kernel threat matrix
>> +   :widths: auto
>> +   :align: center
>> +   :header-rows: 1
>> +
>> +   * - Threat name
>> +     - Threat description
>> +     - Mitigation strategies
>> +
>> +   * - Guest malicious configuration
>> +     - A misbehaving host modifies one of the following guest's
>> +       configuration:
>> +
>> +       1. Guest firmware or bootloader
>> +
>> +       2. Guest kernel or module binaries
>> +
>> +       3. Guest command line parameters
>> +
>> +       This allows the host to break the integrity of the code running
>> +       inside a CoCo guest, and violates the CoCo security objectives.
>> +     - The integrity of the guest's configuration passed via untrusted host
>> +       must be ensured by methods such as remote attestation and signing.
>> +       This should be largely transparent to the guest kernel, and would
>> +       allow it to assume a trusted state at the time of boot.
>> +
>> +   * - CoCo guest data attacks
>> +     - A misbehaving host retains full control of the CoCo guest's data
>> +       in-transit between the guest and the host-managed physical or
>> +       virtual devices. This allows any attack against confidentiality,
>> +       integrity or freshness of such data.
>> +     - The CoCo guest is responsible for ensuring the confidentiality,
>> +       integrity and freshness of such data using well-established
>> +       security mechanisms. For example, for any guest external network
>> +       communications passed via the untrusted host, an end-to-end
>> +       secure session must be established between a guest and a trusted
>> +       remote endpoint using well-known protocols such as TLS.
>> +       This requirement also applies to protection of the guest's disk
>> +       image.
>> +
>> +   * - Malformed runtime input
>> +     - A misbehaving host injects malformed input via any communication
>> +       interface used by the guest's kernel code. If the code is not
>> +       prepared to handle this input correctly, this can result in a host
>> +       --> guest kernel privilege escalation. This includes traditional
>> +       side-channel and/or transient execution attack vectors.
>> +     - The attestation or signing process cannot help to mitigate this
>> +       threat since this input is highly dynamic. Instead, a different set
>> +       of mechanisms is required:
>> +
>> +       1. *Limit the exposed attack surface*. Whenever possible, disable
>> +       complex kernel features and device drivers (not required for guest
>> +       operation) that actively use the communication interfaces between
>> +       the untrusted host and the guest. This is not a new concept for the
>> +       Linux kernel, since it already has mechanisms to disable external
>> +       interfaces, such as attacker's access via USB/Thunderbolt subsystem.
>> +
>> +       2. *Harden the exposed attack surface*. Any code that uses such
>> +       interfaces must treat the input from the untrusted host as 
>> malicious,
>> +       and do sanity checks before processing it. This can be ensured by
>> +       performing a code audit of such device drivers as well as employing
>> +       other standard techniques for testing the code robustness, such as
>> +       fuzzing. This is again a well-known concept for the Linux kernel,
>> +       since all its networking code has been previously analyzed under
>> +       presumption of processing malformed input from a network attacker.
>> +
>> +   * - Malicious runtime input
>> +     - A misbehaving host injects a specific input value via any
>> +       communication interface used by the guest's kernel code. The
>> +       difference with the previous attack vector (malformed runtime input)
>> +       is that this input is not malformed, but its value is crafted to
>> +       impact the guest's kernel security. Examples of such inputs include
>> +       providing a malicious time to the guest or the entropy to the guest
>> +       random number generator. Additionally, the timing of such events can
>> +       be an attack vector on its own, if it results in a particular guest
>> +       kernel action (i.e. processing of a host-injected interrupt).
>> +     - Similarly, as with the previous attack vector, it is not possible to
>> +       use attestation mechanisms to address this threat. Instead, such
>> +       attack vectors (i.e. interfaces) must be either disabled or made
>> +       resistant to supplied host input.
>> +
>> +As can be seen from the above table, the potential mitigation strategies
>> +to secure the CoCo Linux guest kernel vary, but can be roughly split into
>> +mechanisms that either require or do not require changes to the existing
>> +Linux kernel code. One main goal of the CoCo security architecture is to
>> +minimize changes to the Linux kernel code, while also providing usable
>> +and scalable means to facilitate the security of a CoCo guest kernel.
> 
> HTH.

Very helpful, thank you for the feedback.

> ~Randy
> 

Best,
Carlos
