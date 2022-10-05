Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CB55F541D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiJEL7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiJEL7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:59:12 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D51C21265
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 04:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+s+MOfUo4oAXg+5q/naR3ZX4oTRr14HDLTaRRzzcD1LKcwkDUpZNsrSJ7Zd5OByDw8MsUQzsfUXNj1gxP7YnDZONarFF/4cC2bNflZmEI6a3uDoDNI0Hc+pt+P0Y3FZyA/Tc//HyzQLZ/v16G/N7uAnoB07KXH203RolSQn1An+dX4bQUIXiecvUVTT+vWO1FE7TO+x7MN3iyIkIK4JiStM2gXijkxI0ThutDQdpmpjm1K5FmGTbMERn+j0qYmmGfFxFwsgdm3FA8dr8/xHIDngOQk+vMbdVwLH4ILLFGjQ+0gqYy+sJg60XjMjD+6TlvCVBrtEWMcf4oAC5+dN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m34VbD0LfO236+78Hchg+01tMv+UJ+fRLDcHaGlqoP4=;
 b=FZXzu6rA9RltgMAiXbAoC1DYHIUZRQpWilMz8e6j5LpTzFNQ13g/ZA0oF9pqzB2j14AlQIv+nEupu+SwRbBy0d1351a2rkfVkqvFbLHp9t+RqGiPrm3vPKvnx0YrSGa473tx4otEHz//7/vYnsZRr8RZKE7LsPcRAx5Wi9y5D+C8OPtCHA3/XdcEgeahQz2/yZcfLwEO1ST6NQX2cLBu39/5Sokdw2vDL7ug0rakCYSVoXp3/GSi11WhtnYy3waKxrsA18qb6HBFVyHyMZ4qFkL816UQxGQslP9fouzlv7oPrQ+4BfZfCDGcse9cSJqL0+WtRmUXQBCAtq6QF81X4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m34VbD0LfO236+78Hchg+01tMv+UJ+fRLDcHaGlqoP4=;
 b=sMFCefN378vzg6o7U68bmrbtEZRafc11MONQwPbhCLH4IHzGDu+2MPOoxwuDDHWEokJ2SWW5mpnV4B5LmcbA4tLWhyVOC7Vg4+1z8VP4fsu3VEU6L6xr+Jn5557aV10fPRGUIx40jb2sUjv+CFO240GYjIFx1uPid8ApEtAKT2uvkfhj1MWMmVJt0w4yt3fGNSRuIlrRzPU07ETYesSkrgg4D9Q5m1PXSPnNIBOk9lz5SVLTatNttBn2K9gCdvfXB9zzW9DPXMrbckwGIh6YAR7HLJOpB78vn6QoSfDZ84SiD4hzMTsR2fkKU+P4wow166BRzsLGzoM8vBsFt0/sCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by PAXPR04MB8990.eurprd04.prod.outlook.com (2603:10a6:102:20d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 11:59:10 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a%7]) with mapi id 15.20.5676.031; Wed, 5 Oct 2022
 11:59:10 +0000
Message-ID: <ed377c8c-95c3-8386-cfa2-51ae9b8add67@suse.com>
Date:   Wed, 5 Oct 2022 13:59:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 2/4] xen/pv: fix vendor checks for pmu emulation
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20221005110302.13455-1-jgross@suse.com>
 <20221005110302.13455-3-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20221005110302.13455-3-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR07CA0015.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::19) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|PAXPR04MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbc3d14-30c1-42f1-0a7e-08daa6c9032f
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVEz3quXCOrB/ToFVMO4435Zl0VY47lRmERLNThZeyJcVvDFc7dXwBrkYS1TbkPS+gxbcF56w8OYGtmz585lL+aeUm5dH4By0agw5BMooF8ejEN3MC9aMUrQeHId1wgbhr0xElyJBgBbgfwEcB8ogUWJyEUYFbKI5Aig23Qgr+uscinQJU/kT7itx5GJfeEC+zySsU1oAJV+a6kGHJH2MB2LS6zgPp5HvL/XAjwF0hbPR6hFQCWp0o1GqPwCqKrQVf32/vZaY7qChqMJheK83JQOV695A+kGHYmopy65O5y7sQ8oipwaZ74Mouq38ENl3bgXdy7bE0tM2l826hfpaSN5HagbMX1dQ924tnBCchjbpu8TjT7H/AbWeH6R8feERG6jVaeM3KedMYUdYyrsitadS1IME0vQGQrp3w+xzgLO9OQXnIEUb7z2aIVHoy1+zHQTrf5UBjcv92kxq3AC4lccpZeEA4jCjsCYBRwAJcGGnuHVWEKuE0+vQszRn3qEczuW9Q4AJhMnUv3oCKofEqYwWQh+ZT2nEs5wmTRRvCPjfh7jbngqNXAVSawsSwz3qYkBiCynr/dr/l/O/XHQGygd3Pvg+H6dRReYI1IbuQgMelfDa8xvXtyy3hJbgytgWI0bfXpHTBdQ3zCyOlj5s17pEnYBtWvQRcVI6A6gN45vwWCoZOx19w60HE9VLcRuUrJTit508A85r4h8JA6CjzPMdunXKgjBwQq/90Efc2ugzL1pcpbLqvrH4+LLgWWfvseKjn/3fVRAmHytyuxWrqXZfA3xy120RNZqC+mNpVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199015)(54906003)(83380400001)(186003)(2616005)(4744005)(38100700002)(5660300002)(6862004)(41300700001)(2906002)(8936002)(6486002)(53546011)(478600001)(26005)(6512007)(6506007)(6666004)(8676002)(66476007)(4326008)(316002)(66946007)(66556008)(37006003)(6636002)(31686004)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SittcHFTdjNrTzN4NWM2SzRCdVpQU0paTVZlbGpNT3BBb3EwSnVtYUxhM1Ew?=
 =?utf-8?B?NFRkZkorM256MDdCVThSVzhwSHZpTVJKUmpveFRhNEozd2VuMG5qN25xUXZH?=
 =?utf-8?B?ajBBbHc0Q0c1dmliSnlRcXJDUFVGOHplMy9PbDNYeDRSYUJZWC9kUmxSdllj?=
 =?utf-8?B?d21UVWNVU2N5RkdWeGRVNy81VXVXeHpQbTdBZ2Vwa2ovWTQzTmtrZGpaU0tx?=
 =?utf-8?B?dHV3QVMzMWZlbHU5a1BJbWNYUmYzNlROYjRybU9kcnJPUjd4d3F4aTJidnBs?=
 =?utf-8?B?NEdpb0VCUy93N0dmbjNFK09Nb3NoMUhKUVRWZE9vVm1YM3NocExiNXpxUzBz?=
 =?utf-8?B?ZGRyY3dCazh6dmQ0OHhubytuWHVidExwNU9JeEYzUkZVTFhwZlk5SGgwdmdn?=
 =?utf-8?B?c082clBFakFoVUIzVmxrVndPRHh3ai9TM1kyTUN5bzhaM2pWYnRqQWVsbnNh?=
 =?utf-8?B?UjJZc1hjejg3bk53ZnE3RGFmcThISGNBbWFLSnhFWEZCNWdqb1k3b1JqQkts?=
 =?utf-8?B?U0hqUmdteEFiNHhsb3M4MGxPcS9iY2ZaSTJ3a0UyYVpzWGd2RTkwbnVFR2Vl?=
 =?utf-8?B?OC9hQk4yOFBiYUpGMDdac0pVbjYvSEtUbnd6ZkpFU3RkV0Y0REZGUFg0aXBo?=
 =?utf-8?B?OVEvdFFKbjNZdzBqcGVoVWhmeWVMRmVOQ0VhOHRhRmMveTFhQ3JHc1ZCY0hr?=
 =?utf-8?B?TlNDVUJHVldSNnBndTFXNmpweEtQanBhOWplUGhsVTVYZlh4RXYvcFNKOTJv?=
 =?utf-8?B?VVNySElLeHR4QW9aVnBLa3NMU2pCY0p6b0F3QVlpeVFXVU9wMThXSjMzcFJt?=
 =?utf-8?B?RWYzWHlOUDl5czVvT1ZVcVM0cFdYZGJtN25BTlRkODRpQnBTSzRxUFlnRkhQ?=
 =?utf-8?B?S29oRVU0UFJVV245KzJIMzdHVkZrYlQ4L1VqdWxqTW1aTjhTSGJCZUlsb2xq?=
 =?utf-8?B?dlkwWlUwRDlsMCtSWjdqeXZ1RGJpZHhTeitxRTRHVUdZbTVaTVF6UUFjREVI?=
 =?utf-8?B?aFFqd0tRdHZjZkhob0YxMUtiSmxUUVI1b21hMkpnb053TS8raHRVYTI3V3NC?=
 =?utf-8?B?VHFvR3hWVlBrakRpZ2NNcGZudEl3dFhoVmdMb2g2bGwrRThiVEIzTkd6U1V6?=
 =?utf-8?B?Snh6YU5tancrMWFTVVNaVVZFQk5Ra0haZHNsaTZxRE96V09sRFBkelVTVDA5?=
 =?utf-8?B?dkNVeWVYd3JwanFhOEVVejh3aE1pUENVR3B6Wk9JUmIwcmxXckJUNHhWeE1i?=
 =?utf-8?B?eVpZWTVGOWRGK1pDUVp3OU5JTVE0SzJsVkhuMjhYZS81YTE1RzVXYzZXcjFr?=
 =?utf-8?B?dFpZT25aQ3FCRWpaaXpoMnExWld4ZkQ5SXVlTDhMOXBTMFVGWFBrdjM5d1VH?=
 =?utf-8?B?OXN4cE0ybXlSanFDWFpHVVZFa3FoRGtCeUwrTWhYVjZqakt4cEVRWmlaMXdr?=
 =?utf-8?B?bS83ZlAzMmRvdGRzOGNZd3NGSWdVQ3JIRnFSejdzVnYxYkd4aEp6NFhTRHR3?=
 =?utf-8?B?dlVUYWUvR2pwU2U5VHFSNVp1RGY4SnU3WUE1V1l3ZkpKQzcyck41Qyt5Sk0x?=
 =?utf-8?B?NjlsTnlDUmk3VlJFNjVIb3VtY3lEZWVURXVNVG1uNDBSVkg5dEpDU0pRMUM1?=
 =?utf-8?B?VXF6MkRNUUJZZU5aN3I4M0xVTi83L3NHS0dJU0JWMEZiSnBpeWlBbW5TRHVY?=
 =?utf-8?B?VXRTMGdtYXlqdHFFVmRDdzIxUDJ3dmdpZHR3T0hRWkI0QytMV0dycHNkQ25O?=
 =?utf-8?B?amluMVR5Ry9BZDJGalRhcTBac2JzS0taZEtNTGU0MnArN01NckY1M3FCUHFH?=
 =?utf-8?B?TGJVeFo1T01IZkZPS1ZHeG5mblRJM2lLdzZ1NnRtWTlFSU90SGZucGcwRkdK?=
 =?utf-8?B?M3orNjg3S08rZ25CRWlKZFdTUkhVRXlxSmdqclYySyt1dVltaDdDb0NxRjhO?=
 =?utf-8?B?d1lpdnpFL21wOWhFRGtXdHc1TkJjeEUxMkQzMm1SWURDRTlEeXMzSzhGSHBZ?=
 =?utf-8?B?U3NCb3hUaW55ZkM4MjFaYzJEZUl0VFpPZHNNemx2WmU5Q0ZJU0d2RFZKbFp3?=
 =?utf-8?B?WVVtQytnSzFqTE1aVmZEY2dPUTBwOEFzc2Q5a2F1bWoyUXl5b2ZmVWtnZzV4?=
 =?utf-8?Q?KzweMSAkR2S0wRroAxpVSi6Fp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbc3d14-30c1-42f1-0a7e-08daa6c9032f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 11:59:09.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43WgoQXW1umiXh5+TY33DZyu6FF8pS7hjHervpf35+eYLsK5l/hCz2FnMsQ9mwAlqBsAwIyasBqxB3HiM2LBjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8990
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.10.2022 13:03, Juergen Gross wrote:
> The CPU vendor checks for pmu emulation are rather limited today, as
> the assumption seems to be that only Intel and AMD are existing and/or
> supported vendors.
> 
> Fix that by handling Centaur and Zhaoxin CPUs the same way as Intel,
> and Hygon the same way as AMD.
> 
> While at it fix the return type of is_intel_pmu_msr().
> 
> Suggested-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>


