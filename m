Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146B66BF17E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjCQTM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQTMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:12:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2B7497FC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:12:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HIjljo031151;
        Fri, 17 Mar 2023 19:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hGszEpxaB4TjAdOkpTnhYlv7P9fJaH+vwFc7ZE8rl0U=;
 b=YLKWtycuOt39DghUXqPc61AriywXvD0L5aF/hGoM7KInaoaA+e493u/ZIRxQn/iCO7ls
 og2EQQmxHtVrHKIcKnlut/MzYZsEMSgJ2RjrINe3I9R0LcHJm7QHxWU/3V5vTiEzAfOQ
 pzyeYws7MrfBuILlPytPbYITX/LCrmt86+kZcmBtYfJTp6TVw6Ht658suwg9bVgnA+aD
 xBnwS4bdy3aVtNsxAMWHpWEU9aZduH7MZ/GjABJJgeAXWU1jkkCr8x3nbPmY8hqH0WFa
 Gz81rpf64jkQXmMzsYcLEuocZaEvTmqfbJrGlcy4wMEVvqkywh5Xkuz5Zxm0Mi3F6uz+ YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2amp5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 19:12:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32HHOmgC015177;
        Fri, 17 Mar 2023 19:12:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pcu2u8430-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 19:12:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIR07b/SQX95nqKSKPgKkr37Ts1Hg48vC2vX/CF6oedmgRDzVJihz0EpqYlF7XUFrVk49MhOMffatVRU3B5XZ/K9wnWFPpOposwWxgkWC3BACeQcTZ+Sadc/R4hViLQLKQSaXPlAc3GsKtHidGGz964kTCrtzcNK6rI494+/QoWzoPQQflLfcP9TLXEy/MHF5M08UgE1a7+ge7kpJj2ng3M6lXt+2bef4WpfQG3zePcXohw3bZy0m9e+u1SL3BtnzVaEJruM7DNc3cPA3ciANsoN8LXLMxBx2R1fMfnr/0VVqQhQ/Ip7OdH+8FWaheCVk9yFq3HlPqFN8H3VXht4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGszEpxaB4TjAdOkpTnhYlv7P9fJaH+vwFc7ZE8rl0U=;
 b=dhRMwmttLlxqRa5v7baERO5yhgBEsGgr/ajyGCu9kuOH+sdbkdc66++rJ/npAG2N/CTQtflfldWrHcJObZEkWtPQRq/2axnd7dpVFOtk9rs/7FM0XX2IjfzND3en77R7ertmB8pjIFnKEyFQgtQvA9OLcjaO+D972Ya/+yAuq4CPSX9Zfkjlapz1T12BHpbW4M+UoRZfEnNcmbtwbcrMB5/NqWyidms198Jz9lAFEFhzeY/XDTgQrEnVpxw2rHHsXvjf0oIbb+wgJZbNFRKVwQiU6ThsH+gQliIKBJ6Qshn2SEgUd8+GIufMr1HqN6uSKQcNtNAt3SWwasjqITusxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGszEpxaB4TjAdOkpTnhYlv7P9fJaH+vwFc7ZE8rl0U=;
 b=pkOVf74tc3tCFCxkdmZTLgFoZOe2p1Fsds4stAniuH3qzAkji6nYPgdWqdpHex6ysMc+zlpxY0u+K2DxVZbIMdD7voSrQtjdYrYqiQDJMdgSjxXYhc2vMz/aEHwWRoOE9PbnVFcEPeeRZBiUhKDmwzoGNsjeYoNIJ8PQZL/lj/w=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 19:12:27 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 19:12:27 +0000
Message-ID: <bbf4110a-f0b8-65be-6cb1-9a61f5bafa06@oracle.com>
Date:   Fri, 17 Mar 2023 14:12:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v19 6/7] crash: change crash_prepare_elf64_headers() to
 for_each_possible_cpu()
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-7-eric.devolder@oracle.com>
 <c9db3d66-f74d-fcab-837e-bfcabae8bce7@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <c9db3d66-f74d-fcab-837e-bfcabae8bce7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::13) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MW4PR10MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fbab1a-a4a2-4e8a-e119-08db271b8c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L3vCh5hbdckIgSF4+HqSk23tktzBktRvN8R+3bMm78mj8ZquGf0XENpjqn3NjO9o3jEn0BUr+1fr/f04nLKNQPUE77IOAsTy9pcwmXKFnudC4+JWNv48RVd7Uljmtfw1klddSUYtCxW47VXZxIXnrn8iDHDw/VCIAOhKfzJtq3xNjKq5xEAyR/eyd0iOTL2M7c8o6zg5Ejy2uRR8b0SsTdOeixTdplMt3fQTb6K/6dyM3wtQn+fHH4nmAtKbwrruvdWUSnw17tncWpp1AUxbJVa4u5DboaA1xRqUICDrqqNMblPHHH7S1nQlZ7Cmkhz1RK6KTmoKcVHZKs03PmxAl8f2bU0/G1VSZqjhT+7dYfBWg7EaRoeVB/wSIf3HL22g1+XhBQ/OiuJvgJPbMmm//EPeo3a1hE16Y50bHMmR+zz6fZkinXSe+DFUbitpSyIYGTHDO0AkIulExaykoG1kqJMmn8XIQtmTQldN7uwA9WP2fi/0nT0aQQs/vg4cHKZsKsA/r9wX56QVoFKsPmUIigw6Q7G+iazWHtdoAwVGGrm49paVxddh5i43iNpD9kYWs6ZmYV6vDatXp0mfBIv1pidnb0nQsXVhWhSS/efbrP8c1bicjYMppFMO/YtRjUbSj9J6TbHX/4EmqLH/6wNrGLJsQUu367qMPNiLZB71+xyVAWbXZB3F5YYlSm04YdtbVVWLGs43bR5iQiADeOcP2snJ89PsLQOXzQ/jFNI5yvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(86362001)(8676002)(36756003)(186003)(8936002)(4326008)(5660300002)(6506007)(41300700001)(53546011)(2616005)(7416002)(83380400001)(316002)(66476007)(66556008)(478600001)(6486002)(31696002)(38100700002)(107886003)(2906002)(6512007)(66946007)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUpiS2pRT1crY29OVFZNMjlHQ3pvaU9PVnNONHFJN1dGeml1bWFFcG8rSkxa?=
 =?utf-8?B?NjcvUTFQc1U1VmlCTXgxUy9OczUrMHZKSzg4enRPRG53MGtyMDFuT1JKc1FR?=
 =?utf-8?B?VjJRdXJGRThTTlpTNldkM3ZFejJsclFidGhyNVNFYUx6emtTNzVxL0xhTmhK?=
 =?utf-8?B?aEdobmRQZFNZOHdDVmx1SktoVllwS2FwTTI3MzB2QkI0UGJubmNyRjU0b2gx?=
 =?utf-8?B?K2k3R3FaSlZUdjVIcWpjSGtlOFJOK3lZMDhSRklnZEJoVzB3d0Y2bnJpSml0?=
 =?utf-8?B?bkdFcGhUWnNmYXYyWHV2dFNCNFhUYmlZYUt1WS9QMm83TUdZSXF6dHZLRWNz?=
 =?utf-8?B?V2pOWDlKbXpPTnJKRlpVZkQxK3R2bzRQa3IrTjBxaXdhdzBreDdyeURsMU10?=
 =?utf-8?B?REpHb3BBNXFPMDN3ZjE2ejZhcWxqYjl0VW9jQTIyQmFrUnRaT0NVZnlTQ0Fj?=
 =?utf-8?B?a3VsdENNNmJrQmJ1Ly9HQVpXN1lzNkJiWUdlN3ZESDJuT0Y3c1dXTm1oNkpy?=
 =?utf-8?B?Q0M2MGxNRXFWYWNJM3l4UnFiRzZhT29HKzA1cXhJYlpGWTkwTWIyTldtdmlx?=
 =?utf-8?B?dytwaktEcFJPc21rSzBtMForM2IwazNYRnBpU2tUME03UU5WU2xnZlJRZWcv?=
 =?utf-8?B?SHV6cHlDOEhURmRsK0prdDkzQVQ2VEFpSElGaDJERG5idDQ4MWpGR1BaVWlF?=
 =?utf-8?B?d0d6VnM3RzQ0VkxhZXpoL29pRWNBUUttTHZlQkY1WFd2RC91YWpyK1I4U3Ev?=
 =?utf-8?B?anVUcWNtNFB0YWlQZVArUlRJL2Q2dVFpc2JiRUIzUmdUNHpPeS9QcU9HSllv?=
 =?utf-8?B?WWI5ZjFQY3E1RXZBMFFqRzVOa0c1TnZ4MFFoWVEwZ3doWVg4NmJSZWdZbWcx?=
 =?utf-8?B?aVR5REhQWW9udmR4cHJqYngvOFpxVlNFeWlkUWRJRlpXZ2pqOEZpU3RWN0tN?=
 =?utf-8?B?eDNLUXAyR1YyTUh2SlJFb1NPTFl5RVpwWHZYbmRiZHNWdUFVc2M3U0lYN2kv?=
 =?utf-8?B?NC9wa0ZZV1JuWHBxc2J5SU9FZWNTR0pqc0Vxc0ZIMFJqRWZ4SFg0Tm9ybTl2?=
 =?utf-8?B?Q2U0RUV5d1RGTGFjKy84S09TYnM0MnpDN1JjVHlQclh1Zk1sM2kvTXFzK2xj?=
 =?utf-8?B?SG54OGVKWWhMa2k5ekxVR3RZUlEzL3RhbHFQcDZUd3c3M21aem9nWk9ORWo4?=
 =?utf-8?B?RFlVTGpZY2svWWorR0ZJU2pGeVc2NGZ2clIrYmx2VWdZYnlQZFRHNUR1cjE0?=
 =?utf-8?B?OUQrVW1mRGVUNjN3UU5mY3AzQjFNREFoZ3MxYUVuYStXUW9Uald1ZmFIYlJa?=
 =?utf-8?B?cWs1K3RSN0xmSVpTbzdNZXVFbjdCdkFVdkJUUVljRUJvVVVyaDlPZUprWTN0?=
 =?utf-8?B?NVhEUmpQUzhTd0kxUXFFVzRkZWZtS3JYeHU1bk1IbDkyeXpYL0tER1VuMEZZ?=
 =?utf-8?B?ZUo3ZkwxdHpRdkl5Q2RsQngwQlZXek90L3ZVVTFIRXI3TmNqRkMxN0srWTVF?=
 =?utf-8?B?b0FKQmdZYVZ1MDNDbENMYy9BWWkvYnlQalFsZmtiNTdtZ2NqRU5FR29PSHJC?=
 =?utf-8?B?cG5TQUR6M1FkSGgrL3ZHRnpLc25WakNkVmoyY2N0TlJNckNuUlpzTEVVbDVM?=
 =?utf-8?B?UjFSWnN3R0srN213clF0a0FBOXJzRXlXTFBZVkVBbjhQVmdISmUwUXlYQlhw?=
 =?utf-8?B?MFlIOWtNbFp1SHAvL1E0dnlFMmpCSTlBN013UG1NNlp4anhmODNaK2xOcXly?=
 =?utf-8?B?c21sR1R6Zi9oV3hoaXk2NEhBRVlQazRsL1Q4ZzNONHJDdjg1eXZ5cmNpL1VY?=
 =?utf-8?B?VXRZSnJOVzhNdG9oeFcyYzVoR3ZpUmJTTzh2V2dxR25BQXI2NVFZK1NxdEx0?=
 =?utf-8?B?c0tEQjdhb2QvTFlLdTdKTFdFQU9jSS9lSUZvbDZLQkxESEhMTTk4KzVXZE1i?=
 =?utf-8?B?L2F0V1Znd3ZiSDFWaCtVdkpLZEZtOXVlYzZLakJRK2gxdGxiZFJJR0JaVUNX?=
 =?utf-8?B?VWtrNkRuQUVhaVJrRER3RUhRazZoZUU1NVRDSS9ESzZmSE45V3NiaFhCTE1V?=
 =?utf-8?B?aWkrU2J1bnYzb014ZEVZNXRVT3Z3a2FGRWU5QUQzU1J2UzFCYXZvaXd4N1ZK?=
 =?utf-8?B?TElneTNGQzRGUnN5dTkrTHkycWZUU0l4TmlsMkZBU2o2QXB2eTZWNG5Gby9L?=
 =?utf-8?Q?9Mng8Vhdh9Od3JbOr3DpjHs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Ryt2OXEya1dhZHEvUDAwRU9jR3RhWjRYTXk1UzlMcFFwd0NRd1c5eW11LzVo?=
 =?utf-8?B?a0ljdWtJSkFIRDQ2MkpsTlpUdUQ2M2t6MVdHSG9BZ3lmc1NDR3JDUXpTOS9h?=
 =?utf-8?B?K1ZsY3hTSEFSUWE3TWpaZTB2R29wa2xScVBwVlcvd2NLWkFvMEpqVkZvajNn?=
 =?utf-8?B?L0J6R3gxckJhMUE5NWNVM3N6RWFuVEIrazdPZHJiL2tzbW1nc0xpbnNPRzUr?=
 =?utf-8?B?YkViN1djcGpBZkZvY1BYblM5UjZWWWFMWmd0Q3d3anJ1ZVA3RmtJblEvRURv?=
 =?utf-8?B?MTZ1TlBkeU9BeExrUGNNYTVlanAvSlhKazIxOGx5eERkRStlaDBMaGJwcXNi?=
 =?utf-8?B?QVVjT1FGUHZteHF0TFdkNnY1UXAyMndQeHYrODMzM0xwa1ZwMzV0NTBVeXJi?=
 =?utf-8?B?NUdZSWlrS21CWmk5YkcxdzAwblhrZ1Z6cGVTV2VNTjJMbXBwa2VpcE5uQ1NU?=
 =?utf-8?B?ZmJZS0JhZzJWZGJtTkRCL0R2RGgweUlPaVovZ0Y5RkZPN1BVaGNtZEpRTU1h?=
 =?utf-8?B?eVpQbWJHQ1RhTk50b2xRTzd3STBkNUdXY3p4bTllOXJPbmdSRUJwUkl6NTlv?=
 =?utf-8?B?bWFNRVgvcFZxVEJKalpETnJEc0NEQjdZK3p5QW5pT1pKYmRYeEJhVnpQL2py?=
 =?utf-8?B?bDh5bHpxb3U4WWtMTDFYWW1Edk5HWWxxcklUOGl3emo0RjhuZ0FYNlhRSExz?=
 =?utf-8?B?alpqa2IwbGhqbnA5QzdlY25Cd3lmNXl5VmwyZVhDeTMyM3BUUzgvMTBtWlpJ?=
 =?utf-8?B?UE9NU0tXdDZaSlZyYy80NUpYbnhPL0dMaXFjdnZKeFZsQ2NqY1NtQmorb2Uv?=
 =?utf-8?B?djh6ajBCMWJiRWtHeHFoUm5LbnJzMXk5MHgxK1VFd0RJWk9Ra2hPb3hXcTQr?=
 =?utf-8?B?cVZWTnJ3dElVWUswdUtyK3FQQk1OdVY1eVRzM25ZandxVlBxTDhJeER0TDVV?=
 =?utf-8?B?Zy9vZ01Xa3RwSnpKVERSbmFlemVTNU44QVEwd25jeW9nTWcvTHU5NkRnWVdI?=
 =?utf-8?B?SjluVTlYcGt2ZzI0WWtmbjhjWEovM2pFUGhVcWxoeEtsZ1JPeXhlVGFjZHFC?=
 =?utf-8?B?UUthcWNxYmtybElTY1NWNURuc2pKaXpWak0xektBQ0t3MjBEL3Nkdk5abUhq?=
 =?utf-8?B?ZUZ3a2dwMW1wanBNcUN6NEhjd1ZuZlBINWF6eW1sUkJ4YytoeWsrWmJNbmUw?=
 =?utf-8?B?WHdyT2dnRk5vcjFDY2pwVlVFdXdSZnV1UzVZaGgvMVoxRFd5Wm5RU1ZKcTlO?=
 =?utf-8?B?aDYzcGpnZ1RJOGVaejZ4WUxmU2FoMmJGMm1kUktmaG5uNlJxWnFGZnc5Q0w5?=
 =?utf-8?B?YTg3UWtxVU5DOThkTGdvVzE0OFBmV3hOamkvZllZZTd0N05uOWtSMkZuK09R?=
 =?utf-8?B?TXZCZTF5N3JjVko0SUQ3cUEwT2J4elVMRlpyaDVEZVI0cjlQNEJEb0g1L2lC?=
 =?utf-8?B?bTFnQVE1c3N3WGM1N0FLRkVjZCtrTVJwbjkzMlNtOFRFRWlCc3pjNWtSU2dz?=
 =?utf-8?B?elIxeklZSXl2WlRGM3J2dWFrQnJpSHlCbkk1c2k3NDd0cXBlQnI1Z1FPeURW?=
 =?utf-8?Q?Ku5myrZ8RJn4bALY+AaLc/Mmk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fbab1a-a4a2-4e8a-e119-08db271b8c52
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 19:12:27.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 151kEJsQ31aEGkwl61RuM8dWqQU3oD0jfIeBmcegjWnVG1XV63h3aJCTQoc6aec6QU4YzDHNGAhP4i5PlI06uQhlZMzjWB28Ox7jTuPt1zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6535
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170132
X-Proofpoint-GUID: YhnVoMhfPVPYpoDwQrM4FBquCCrYZz_a
X-Proofpoint-ORIG-GUID: YhnVoMhfPVPYpoDwQrM4FBquCCrYZz_a
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/23 02:48, Sourabh Jain wrote:
> Hello Eric,
> 
> On 06/03/23 21:52, Eric DeVolder wrote:
>> The function crash_prepare_elf64_headers() generates the elfcorehdr
>> which describes the cpus and memory in the system for the crash kernel.
>> In particular, it writes out ELF PT_NOTEs for memory regions and the
>> cpus in the system.
>>
>> With respect to the cpus, the current implementation utilizes
>> for_each_present_cpu() which means that as cpus are added and removed,
>> the elfcorehdr must again be updated to reflect the new set of cpus.
>>
>> The reasoning behind the change to use for_each_possible_cpu(), is:
>>
>> - At kernel boot time, all percpu crash_notes are allocated for all
>>    possible cpus; that is, crash_notes are not allocated dynamically
>>    when cpus are plugged/unplugged. Thus the crash_notes for each
>>    possible cpu are always available.
>>
>> - The crash_prepare_elf64_headers() creates an ELF PT_NOTE per cpu.
>>    Changing to for_each_possible_cpu() is valid as the crash_notes
>>    pointed to by each cpu PT_NOTE are present and always valid.
>>
>> Furthermore, examining a common crash processing path of:
>>
>>   kernel panic -> crash kernel -> makedumpfile -> 'crash' analyzer
>>             elfcorehdr      /proc/vmcore     vmcore
>>
>> reveals how the ELF cpu PT_NOTEs are utilized:
>>
>> - Upon panic, each cpu is sent an IPI and shuts itself down, recording
>>   its state in its crash_notes. When all cpus are shutdown, the
>>   crash kernel is launched with a pointer to the elfcorehdr.
>>
>> - The crash kernel via linux/fs/proc/vmcore.c does not examine or
>>   use the contents of the PT_NOTEs, it exposes them via /proc/vmcore.
>>
>> - The makedumpfile utility uses /proc/vmcore and reads the cpu
>>   PT_NOTEs to craft a nr_cpus variable, which is reported in a
>>   header but otherwise generally unused. Makedumpfile creates the
>>   vmcore.
>>
>> - The 'crash' dump analyzer does not appear to reference the cpu
>>   PT_NOTEs. Instead it looks-up the cpu_[possible|present|onlin]_mask
>>   symbols and directly examines those structure contents from vmcore
>>   memory. From that information it is able to determine which cpus
>>   are present and online, and locate the corresponding crash_notes.
>>   Said differently, it appears that 'crash' analyzer does not rely
>>   on the ELF PT_NOTEs for cpus; rather it obtains the information
>>   directly via kernel symbols and the memory within the vmcore.
>>
>> (There maybe other vmcore generating and analysis tools that do use
>> these PT_NOTEs, but 'makedumpfile' and 'crash' seems to be the most
>> common solution.)
>>
>> This change results in the benefit of having all cpus described in
>> the elfcorehdr, and therefore reducing the need to re-generate the
>> elfcorehdr on cpu changes, at the small expense of an additional
>> 56 bytes per PT_NOTE for not-present-but-possible cpus.
>>
>> On systems where kexec_file_load() syscall is utilized, all the above
>> is valid. On systems where kexec_load() syscall is utilized, there
>> may be the need for the elfcorehdr to be regenerated once. The reason
>> being that some archs only populate the 'present' cpus in the
>> /sys/devices/system/cpus entries, which the userspace 'kexec' utility
>> uses to generate the userspace-supplied elfcorehdr. In this situation,
>> one memory or cpu change will rewrite the elfcorehdr via the
>> crash_prepare_elf64_headers() function and now all possible cpus will
>> be described, just as with kexec_file_load() syscall.
>>
>> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   kernel/crash_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index dba4b75f7541..537b199a8774 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -365,7 +365,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>>       ehdr->e_phentsize = sizeof(Elf64_Phdr);
>>       /* Prepare one phdr of type PT_NOTE for each present CPU */
> We need to change this comment as well.
Done, thanks!
eric

>> -    for_each_present_cpu(cpu) {
>> +    for_each_possible_cpu(cpu) {
> - Sourabh Jain
