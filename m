Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C227A5BED59
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiITTJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiITTJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:09:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199ED6F55F;
        Tue, 20 Sep 2022 12:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhjtIGuOSkleJ1s2fuH5WISRk2nM5KNdb1pA/IJFkZd0IyheUFRMApoLKjltogRYgMv3NVYLqRaGhLIDeB05OUdEwZ7rj8q651BagbPdfQVmHz65W3Iz2IzAogBDOEmukhAXIXqmTxqBHIJgyZALnmVOPhG/ttYhj/67oikLDlW4xmwo9qlTaa3WamnwDvIeZ5/CG92IGT5+6bpV42n9PU8HVCFPro68u6Dw5ZzeOaxk+xhdDN8gyBXRiPMkQZK8yt8ao1zOhOL2Lu8MSJ0YqrCNRBRkDrq+AsJZlVm24pDgyHrT9Yf9g/2PtX3mvpLsVM5LY/5rx/tIRBxj7zeY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIi1qZmeFF9TkSyTd9bE8y8+XquetUQcOyQGJspoRts=;
 b=a9rBtQacoJNaR1oVqeErbqNKVvxaVwwNi9Ttg3kyoQs4mwEQW52yvzZtfvEA+nIsQKWEYYN5T2dtj2F7vRjJfZ29V54oN/gl6EL0wkbUG5rLEJ0dK/9rLjKspoCcl8kg3QXvOAD+NXYrkKuwsd8qYdafkJw7I+OD5hZ2hzmNT+UnluKRc5B5kfHp2iRGWarCJXUoJ618AwLXrGc5tAUGgBqYrLP+uoT/25EepSpeo+/sC4nuZdSB49dZb/kF72WJRL3nhnVBzbyP0II8QEiVLiLGa5H63FUwiQzit2aYPUftUTjhIQdC6kIepVd+BCjLIQGauDoVOj2oICNPUy0Svw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIi1qZmeFF9TkSyTd9bE8y8+XquetUQcOyQGJspoRts=;
 b=FX0OmoGmSjohqDdbZZTsin7gB4k7rUV4lWyJRLdiJhrcprXwXZx3EFc8yY2iLercwxyz+dDHKWpVOUepOjjPSNH6zxKrcQGdy41p8fBkucyLiNR0Vlm4oM9z4Q6PIdl0lRajTQgE6Ze78/R19mtYLa0+/s34YlutbhafwwUB8PQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 19:09:12 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::297f:558e:dba9:9564]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::297f:558e:dba9:9564%6]) with mapi id 15.20.5632.015; Tue, 20 Sep 2022
 19:09:12 +0000
Message-ID: <e1d26e37-84d9-d746-7bfe-4d57eafa7056@amd.com>
Date:   Tue, 20 Sep 2022 14:09:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH linux-next] crypto: ccp: Remove the unneeded result
 variable
Content-Language: en-US
To:     cgel.zte@gmail.com, herbert@gondor.apana.org.au
Cc:     thomas.lendacky@amd.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220920063252.215144-1-ye.xingchen@zte.com.cn>
From:   John Allen <john.allen@amd.com>
In-Reply-To: <20220920063252.215144-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0017.namprd18.prod.outlook.com
 (2603:10b6:208:23c::22) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: b29f0d4f-2c41-4ab8-a5be-08da9b3b9a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZEjBsj3NFcpFm4yZ1iH7Y+d8sEG/eyXEI20Mbi07/b4zw5EgTBCUhgL3vFcTJKmXUMM/iWIAS3k/tT+CPwBs1YXMEAKH9mnmP1pzW16BR4jY5JG2asdT9rNcyhEdw98FBb0zK4jmuN1pwkPDfik8veZc1pLYUGHb4VPcgWJBVUWWYYqMBM5UY8fSEe/9ITRJxUCgT7Q2TSgZ/5PymOaPkbfUyp/zmW+YmoagZ8cyGOy82aSfvzNxV9hYAA9Hx3V/qX9nXTy1Oww0WK8oBo80PghiZ4dKzyB9fOVO/K1qFysPZ3+/CZ1b0PrT6c1wh90Rw27GGgADWABy/mcbkOmPLr8ZuYQzNfFVDI5punFY2lEyAtVi52r0iFPhNOnxyLtAUaDXq+9fc5MvfOJNSXTXemVOtL8cLUYFpiJ2q23me+kBOOwZVwK/lZwTRNBddmUsNRc82SRW6QjimfH7C6uJxXpKBpmW2622QFb6oC5ODHwAqA42QOMH71ahG5Z0iapUOAcRBEICXQqaqhILo3g+tULrLbjLdVj13I1zZVI+q+lq0Ew7wDO8hk1R+GH72kzOoWU60EaPHIMCHzO4vRWBTFhEfYwz53fTykRtxbroy0mh5pdt6oC65zbxQ9oNVYPJZVodF9MuqEJtCJ6GDKRVs0LW5yFWFCFMwDNk5bHLUA7vA40tAesg/kFmjugCMOG6cczLt57NTI61JOuWBnDM2sq95hplkEEt0CksevFmC3xgw/xRVvXwUihNX4Wd0FG/MzimY/ypi1RvfWDw5jaFPDt4Gd9VoCimNMbFovf7tzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199015)(2906002)(8936002)(5660300002)(4326008)(8676002)(66476007)(66556008)(36756003)(44832011)(41300700001)(66946007)(54906003)(478600001)(6486002)(6666004)(6512007)(26005)(316002)(6506007)(53546011)(31686004)(38100700002)(86362001)(31696002)(186003)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkIrS001U0dKT2ZtaVZYWk9lYTdzMmNYOWRWT2ZwcmNwSTNlTmp1cTkxWVFG?=
 =?utf-8?B?Snp6cEZkL3hOZ0JFd1pkSGFZSzJ5R1JoZE5abUxzTmpxeFFKVUt1YU9wUThh?=
 =?utf-8?B?TjhwSE1la2Z4NnZUOGJYVHVvZzlxdzlWQUp1Mk9WcDBDc1FXQm1CRUJ5dUdn?=
 =?utf-8?B?N0FRNTBwbWwxL3dubkhYODQvRTdrcWJqNk8zWFZIUE1VTU9xRWh6TzRaODRm?=
 =?utf-8?B?V1lpcXBjTTlURXpNcnFyT3R5d0c4ZTFCSFlMa3o1bUNOOHpyWVVVQUNtVGR6?=
 =?utf-8?B?YnFkS3BmZER2WG4yMUhqVTdBdmp3Qzhsd0ZPd3hoa00vT2d1azQ2SHNIU1VI?=
 =?utf-8?B?dDh0SlRlWEQ2aWtMa3g3N2FjbnJhRmM3bVBITlpLNC90a0pxemlBS1Z2Si8y?=
 =?utf-8?B?amdxTVVzR2h2enBSS2lOU2ZLOXZralRUdnZkcXpWVFJCOTZxVnM3WWxBak1x?=
 =?utf-8?B?YlJJMXRxb1IrdTFIcitBYU9kSkRVMlpDcUkvaVQ1RXJocVEzNlpJY2dXcEQv?=
 =?utf-8?B?elN2RnZGSHJZSGdycEE4WWc0OTJrTjBLTUFmeVFXdGdaRzJSZkh0ZXFXY295?=
 =?utf-8?B?QmNqeHMxUDBEUkF0SDFNK1dBbitxL2dLbE5lRmpsTmVvR0hId2Urc1crZDVZ?=
 =?utf-8?B?eFBRSGlOK0d2d2x2VTRCUVRIdFo0dHpYUGsyeUpKamRad2JRT3dhbWkycXlv?=
 =?utf-8?B?WEFNTFg2UVBvdGo2ZjY4SXJYMWRLV2ViSm5hVmpneW00Y0tMZ2Q1NVp6TStm?=
 =?utf-8?B?RExXZ3drNGdaVE50ZkpWbG56SXV2QnBCTzRwcGM0MjZBQWhmUUgxOUE3VjFJ?=
 =?utf-8?B?UHJXcEw0NlQ3R2tNeDVTRHVIWGNTeTZQY3lvWFZVVEY4RWZXeFBtcEZGRGlX?=
 =?utf-8?B?WWJEZlhjMUpFcU1HaEU3UTZHUENybDFDMWp6ak9xZXlLaTMvdk1rMVZ3VkhL?=
 =?utf-8?B?SDhDSzFZZHVKNzFReU5uZ2FBVWEvc0JucXdFL2UzSkE3eWxVNERaUU9pRENR?=
 =?utf-8?B?Y01mRWZoNVRLRjg0RHZWMGhPa2dYRGtJcGVkdXBaMDN4dGpqUTFHZnAvaXRS?=
 =?utf-8?B?V29wM2dDakJjUUNPUUpPTnk2L2tpUzkrREFUcWhzRmtZY0FYNVcwNWwydVVD?=
 =?utf-8?B?KzIyOFhpcXdqYjZtdkdtTVpOa0JvMVpOZGNoWjM4ZFluWVp0d0ZlVmhyWU1y?=
 =?utf-8?B?RkxhOVNrRFo1TWdNUGQ5Nll4bWV5cHRDTXZCZkZCSjZOeEpHTFMvLzlpQ0tV?=
 =?utf-8?B?SjVqQXNRRGlmVEtHa3pzamFVOENjeWlOM2RTZUJjOEV6K29lVDJuTktJTERs?=
 =?utf-8?B?U1UyTCtkODdoWHMveDNldUs4cGNYNXpsMHNDay9TT0E3TENiV1QwdGVmcWRi?=
 =?utf-8?B?QWwxRnFDZitmdjFnM2NFTmlxTlk4UGVsWnFNRlpjODg2RkwzcU9wNDBybE5s?=
 =?utf-8?B?SmphbWU4VmRpUisxNFhFR0Y5U0JFS2hVelM4TXVCMmNaeEEvYU9KNGhSN3lZ?=
 =?utf-8?B?K1krYlBOc0Q3L3puUzBQL1pmYXN0blRNamxSZWYyNmRCNnMzNkpPYlIvYzYv?=
 =?utf-8?B?anp1aFM0NE1RYUdkUmxqaXplaGZ5UXhvamp6cjdjblR3WkZRQmdVcjM0Ymc3?=
 =?utf-8?B?c1dZWlFIMjRsZXJKY3RoREsvejZXSDlMUThRT2lnVkZEdGZnbmlmZW1WNDkw?=
 =?utf-8?B?UVRPZFl4NGFIa0dQUjg0VzN0YzgrczRVaXlpNGxtaVdBcTZFRmIzU3NmKytB?=
 =?utf-8?B?SStPaVp2UUdMd0ZlazVZMWdKblNlQ3E4N0Vaeis3aEdwcGNFd1ByZTl2emNu?=
 =?utf-8?B?ZUppdkZsUVFsaG40OE5VWGd4R3JRZ2o2N0p1cWJRMmIvcjg2NmtqMVlmUGVr?=
 =?utf-8?B?RTNxYWkxN0huUHExRTV2cWhCOVYwN284OWNIVStidzFETmg5QXIzNmoyUzR6?=
 =?utf-8?B?Rm5seVRMN3h3aXVGVGtiNVhSbG9OSTdQNFcySFFSaWkzRUNxQzgvUm9IMm1W?=
 =?utf-8?B?Z0haVnlFREdSWlhMSkhRdTRWcXdaYlk1UVMwV0k0cTVzc3NQV0QvM0ltcGwx?=
 =?utf-8?B?WnZEMVFyUVhvUlV4d09PejRhcFRUdXo0VTcrSkhlV2RBY1hxeFM0cUduUkxm?=
 =?utf-8?Q?8cOr+OIIsgnFW4rT6+5aokTG7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29f0d4f-2c41-4ab8-a5be-08da9b3b9a50
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 19:09:12.2261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cOcweM/+zoXiaulLPirQtLLLB9Jrv4AbIVMikemp7XFs3C4cLJlsMCBfhVDaDlhAI2nxnsdv9urrIJo7t/5XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 1:32 AM, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value ccp_crypto_enqueue_request() directly instead of storing
> it in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/crypto/ccp/ccp-crypto-des3.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/ccp-crypto-des3.c b/drivers/crypto/ccp/ccp-crypto-des3.c
> index ec97daf0fcb7..278636ed251a 100644
> --- a/drivers/crypto/ccp/ccp-crypto-des3.c
> +++ b/drivers/crypto/ccp/ccp-crypto-des3.c
> @@ -64,7 +64,6 @@ static int ccp_des3_crypt(struct skcipher_request *req, bool encrypt)
>  	struct ccp_des3_req_ctx *rctx = skcipher_request_ctx(req);
>  	struct scatterlist *iv_sg = NULL;
>  	unsigned int iv_len = 0;
> -	int ret;
>  
>  	if (!ctx->u.des3.key_len)
>  		return -EINVAL;
> @@ -100,9 +99,7 @@ static int ccp_des3_crypt(struct skcipher_request *req, bool encrypt)
>  	rctx->cmd.u.des3.src_len = req->cryptlen;
>  	rctx->cmd.u.des3.dst = req->dst;
>  
> -	ret = ccp_crypto_enqueue_request(&req->base, &rctx->cmd);
> -
> -	return ret;
> +	return ccp_crypto_enqueue_request(&req->base, &rctx->cmd);
>  }
>  
>  static int ccp_des3_encrypt(struct skcipher_request *req)

Acked-by: John Allen <john.allen@amd.com>
