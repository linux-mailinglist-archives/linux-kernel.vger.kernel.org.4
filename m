Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D0D70E744
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbjEWVVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238468AbjEWVVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:21:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0069111A;
        Tue, 23 May 2023 14:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lC7wDwmFvNldPqST658nLww2GG6e5/ragGRjpDnukjeN4ZrW7iDSoQufRYW92ST5r45X50YA49f2ItnZ5MzPy+q5vi0fg2FNKnBl87l4qObGhAtfLQg2fr92ETTgm7nLeOJ2BMJBKTKLA0U5L+FZ5MjO2O37IZAy1MyaIqXyZwWlXwwKWew7Ky7xsT+0Bw4QK1i0+2ilTT/78D3afNTTZpdKXtbBwssZkvFxVyU26XLqPGns/38xW3TV/He0CBkLPSI1MAnJSaH1ujV4+WHkdErUvo/3/WTVzegZEded6+k/ur7We2GVvc8G3UiG67WsqgQ3IA/3KzGIuAKLWxlC7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXZ6ljlI+9kv2vWomvcXOkRsxwfiP0gmRlaZiXjPj+E=;
 b=d8+9gZXjDnXhhe6fGfZwa7nz6A6oyVE7DLrRGJs1pEhxIf2v82fDuDentc3ra2Oik0V4AmGwN0yTsfHWSH7fUafXHGPqLThsJ1mqni3Q/aUC6f4iJQiNvC1uKVuRQH+KH+TelAUXdd7IDuTG6TejTEpqHYhwUi1Ax7baGyoBmIGVidcmdxZInZkWRrpoToQZLtxj2w72hcRBDIM7EmUEaPG0lIQXco482GndopRd4fBfPcDGUA5tszNu2NPKSi8nWzuC7tvVCu1iJtm11SAFxA6alozH2BeOftxlzZtknVlpSuY6t0XsTDKsagDe0b3J6/aCIxWO+q6F7FBxSasB1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXZ6ljlI+9kv2vWomvcXOkRsxwfiP0gmRlaZiXjPj+E=;
 b=3/5Ky9vVzbdFn0PsGs9ys0lEAevG1SbSXTVLQr96zq28mmMwZ5Jf97Q7HhrRu/2j7z1+YDllYfB1Ut02rpgf4HoOA/aMCkumJFtbDnNJObQdz6YjHW+c+YPPNd6xJXxUI3ukCBA3kc3n8eKNLh2k7C8jUqqtD+1nHtjILgyxyWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
 by BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 21:21:34 +0000
Received: from BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::3409:b766:c6ed:2518]) by BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::3409:b766:c6ed:2518%7]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 21:21:34 +0000
Message-ID: <1eb283a5-4b4d-216e-0c02-413c94ae9eb5@amd.com>
Date:   Tue, 23 May 2023 16:21:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 04/10] crypto: ccp: move setting PSP master to earlier
 in the init
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     John Allen <john.allen@amd.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230519032448.94279-1-mario.limonciello@amd.com>
 <20230519032448.94279-5-mario.limonciello@amd.com>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230519032448.94279-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0193.namprd04.prod.outlook.com
 (2603:10b6:806:126::18) To BL1PR12MB5221.namprd12.prod.outlook.com
 (2603:10b6:208:30b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5221:EE_|BL0PR12MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de410ce-6596-4c33-e304-08db5bd3af29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCOs3OJ+6lOjtbjfG5/ab5EPO4AtpMATG0ov6ikhnkgwLImUyVApk8bDC9LqJF/2kWR7pod11JluvVePsiwQxvG8fnghpQ7JPVSdqApX2OUnEqYw92KsSWhLR1fYdf+yC1b7ZGmDxd5VNBuf4Up5JmttaWORcBI3FQ+z27LmvWYzV4ONHI4XWaIg3GSZhYYQVHEWc0KSs5cMuiad8CQwbsFSQ+p6ucaHtwAMKXeqkNWaIViFCxTmKYlrXnJHkjw5lsRAlae0569hgbe2CBKzN2wdpuTJRU2cQoFnrKbEmaXzGNGDaGL+KwgXE0nXpe3ToPAkHMb9JIR9t6f+VbJNDQfY3bitM6qzno8xllNRMYF6G1tAHQnOc29NCeTYEaeuv+jwF+dgst609B4bsmGEvrVVBYjsFqePP0FCDTpZA0G0xh1dhbUIJguUk6KESV3SjREvbXibEu8WVEVRrTqTo0uDjPmYvAx3/rMoCjBu1x9ugKiXhSbe8nRBYCinoyEpqXkMWbQ9u6SdWG4stILEap3cHLaZtI6YXfgS4K+6aue94Nnim1sffmklDILL5i04Jyy8S3QJRBs5nrLqR3GUuuY3OYeW4y4cSkprB/KIFv4ImmlTkSyiyJBEvEbnGk5JG7sSi5XGzdf1cM+cN4dZvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5221.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(478600001)(66476007)(66946007)(66556008)(4326008)(31686004)(31696002)(6486002)(110136005)(41300700001)(6666004)(316002)(5660300002)(8936002)(8676002)(86362001)(38100700002)(26005)(6506007)(6512007)(186003)(53546011)(83380400001)(2906002)(2616005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWxOVkRXRTFWSSthd0lwRmJEdkhHc1huNWVNUU5Nc3laR3FzMCtjZCs5b1JV?=
 =?utf-8?B?MTNvcDlOMWJYa3JreHF6RGozRjhUd2hqNENieEV0cXRRS3R5YmYzOFdZazV3?=
 =?utf-8?B?eWdIMlh5YmtjNnpsTTRjRWxHdkdpKyttRGZsUEdOeFRIZ0hDbndrcjdGTmx4?=
 =?utf-8?B?bjEwMlZGNVFOZXA0aERaUWpuWng5dGNaTzJ2RHgvWWxGVmdCQUZpdktaUzB0?=
 =?utf-8?B?MjZvQnc1Y3FwNXR5VVJobytJc0VuaTFMNEEwb3FOREdKTVRUWHY0cTV1eW96?=
 =?utf-8?B?akJ1NG0rRlNjMkJOSnBCMkVucUF3Wm80ZWRnY1U2Q0xOV05tWk02WnRFemo0?=
 =?utf-8?B?RFdSTGQxY0pLcHhzQ3R2MGVjOVJyT3NWSGxpUW8yUU1jYVplbldNS0U2bjgr?=
 =?utf-8?B?UFQ2UTg0MGo3Mm9NZW1OS21sNU5HeUFKcndMaFJrcnE0WUt4Zk45MXNMS1N5?=
 =?utf-8?B?d2ZOek1ZUW1IZ3pXOGdHaWY1Y200YkFSSkg0b3RIalFPNFBMeFRHWUxFeSt4?=
 =?utf-8?B?TXhjRGREa3p0RE9MVmdPZXptaE5NR01GVUZzWXhsNmY3OGVpRk1lOUcxaGJ0?=
 =?utf-8?B?eHZxcmRpWnR5dTR3SFJZQU03N29VV3VrVjA5MWdDUko1VEJtSFJlOFl1RVJ3?=
 =?utf-8?B?eGZ1UnFReUZPdVdYbm5zaHZsQkRjYjNtQU42U3lZbGhjcUg5eVFPYVlkUkRh?=
 =?utf-8?B?WG85U3BKMEt2Y28rT1FBSEpsN2FTU3UrZHlNYnNDSFd4eThEanBLL1k3YkJM?=
 =?utf-8?B?SUJFWUdFOHlSRnV1RHRIWVAxTFIwVXBlNEx5SlZjWXpnd1N6Z1o0TGh2dGl3?=
 =?utf-8?B?V0lraEJGOUN5a3B2UzV4Zml2clZOVlFXU21kZ0xKSkpSL2pydE9DeHMrc0R0?=
 =?utf-8?B?Zk9WWk12VE55OUdZU3NhL1ZwQytkRjdxR1BKSmU2QVFvT2lwQXBvdHRaOWVo?=
 =?utf-8?B?SjVTT1Q1VStPSHJGaXh4R2I0ZzhNNVE2bDVNYU00V3JaVVpoVW9rSzFHSi9M?=
 =?utf-8?B?VnEvMHdRK09tRHN2RE1Yc1BHV0hwZUpRS3d4TE9vS2ptMlduSXZBNUw1UW1O?=
 =?utf-8?B?anhFYzRKd1dZMnA2QjMrWHJ5UG8xbnR5THIrQ0dkbHRtL2pVdmlJaWdmRWxZ?=
 =?utf-8?B?OHc5RUthWmVDS2M2SzEvbUZERTM5YmdtWk56b1YxTWVzek9DZHB3VzNJM0FN?=
 =?utf-8?B?L1VsSnhPVnRvanZtSkV1Qk04dEFhYVFtVWhwQU9VMFhxZUVDbnhXUUtSd0Rs?=
 =?utf-8?B?RVlaTXFhbzVqZFJmM1pmL3dCNFlESTVtSHJvY1IzLzd4V0lZSnhwL21FbGJo?=
 =?utf-8?B?ZE5La1lmTFlDV0xlekVaZndlTWJyVDdPblQvelhseE1sbjU4cGc2bnlYVzI3?=
 =?utf-8?B?YitiR2VYR29sVFk1aWJPeEplWlFYTG5ETmU0UWxIRXNGdmJ4ZElheDJ0SlBI?=
 =?utf-8?B?dVUrVWMrRzhZRW02aE50Q1N4VjdqV2hGRnRJL2MrKzYybm1ESjJxWDIvMk4z?=
 =?utf-8?B?L2RVS0FuZVBxY01xZng5TCtaQkNJYlE1WTdLV2RBSklKTlA0UjJHVUhJQ2sz?=
 =?utf-8?B?Qkcza1h6MUQ0eloxeDRMZ3diY1BwbVg5U3h2dTZCbm9UaGpnMXlRYjJCV1dZ?=
 =?utf-8?B?Q1ZKSkk3Zm9YWGFIQUtyRVBJMWVRQXRuaWhXcGkxbXNmQk8wQVV2VWhuM3dN?=
 =?utf-8?B?MWZGcklYQkxBcU9uMURZczdkd3dQdVVNM2VWZmNKSGVPVHdDb25hMUVLekNK?=
 =?utf-8?B?Y0dqR2xsanpDRXJGSDN1WVVHYmV4Q1dWT1MxbkZxU1FFWEgwRXpnT1R3ellx?=
 =?utf-8?B?a1FwWDNjelFJWTBQeDdLTFJabTFlalk4WjZaZ3VKTXFEcENvbTIvMTdKblVG?=
 =?utf-8?B?NGpmeW85aGVUTnpxOUl4QlBaK1FScy9YK2Z1K2s1Nk1NcU5hcEIreHFjY0JB?=
 =?utf-8?B?dExXL056ODBONndHWGdBSGdER0tIWkpaSzFwQ1NKTnhpaVJFNTFlOEZlTlcx?=
 =?utf-8?B?R0dVeXNqc1psS3lmdXZyLzdsaGVHcGFOK2VvaFp4TlVueVpMSnRpZkU3blZU?=
 =?utf-8?B?U2ZadFRycU4wc1k0NXVQaEtwS0EyN0RBVXY5SVZrdzU3ZnJxVFIyZ1Iyd01n?=
 =?utf-8?Q?iPgbnpgCzCbkepVXhQINUqWx1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de410ce-6596-4c33-e304-08db5bd3af29
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 21:21:34.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czzGGa75N341lDBReemLjqeNw+an72ubUUVZk2FsZ40sBICefvd0MSRYB4dOrvInN9aCzbDO2inKVJ0na503CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
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

On 5/18/23 22:24, Mario Limonciello wrote:
> Dynamic boost control needs to use platform access symbols
> that look for the PSP master as part of initialization.
> 
> So move the PSP master before psp_init() so that dynamic boost
> control can be initialized properly.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> v2->v3:
>   * Clean up master device if psp_init() failed
> ---
>   drivers/crypto/ccp/psp-dev.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
> index e3d6955d3265..3390f0bd6408 100644
> --- a/drivers/crypto/ccp/psp-dev.c
> +++ b/drivers/crypto/ccp/psp-dev.c
> @@ -173,13 +173,14 @@ int psp_dev_init(struct sp_device *sp)
>   		goto e_err;
>   	}
>   
> +	/* master device must be set for platform access */
> +	if (psp->sp->set_psp_master_device)
> +		psp->sp->set_psp_master_device(psp->sp);
> +
>   	ret = psp_init(psp);
>   	if (ret)
>   		goto e_irq;
>   
> -	if (sp->set_psp_master_device)
> -		sp->set_psp_master_device(sp);
> -
>   	/* Enable interrupt */
>   	iowrite32(-1, psp->io_regs + psp->vdata->inten_reg);
>   
> @@ -188,6 +189,9 @@ int psp_dev_init(struct sp_device *sp)
>   	return 0;
>   
>   e_irq:
> +	if (sp->clear_psp_master_device)
> +		sp->clear_psp_master_device(sp);
> +
>   	sp_free_psp_irq(psp->sp, psp);
>   e_err:
>   	sp->psp_data = NULL;
