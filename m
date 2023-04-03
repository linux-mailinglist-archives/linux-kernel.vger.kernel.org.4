Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09416D51AF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjDCT7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjDCT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:59:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D855DD7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 12:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELhOs1JCC0bWXUJqCzoAItOX/YVAwVMa9aOz2wPltTOgfaX6UtRRrNMjvf0M0UXC64ztMg5yHzntmV3fCMJqRZInl3pj60B6Da7I6ncEerqLv8CuleFzhwNcNmwE9uW/vZ8qz4JA4H493WeVpkb6vFiP9u2E9kaHTvdA1YRNQxP1QvVMraKTdF8/6Tp8sxj1GrekR1w7tiNSxXch9JTe9bWEVQUPNpeP42jM29N8fzmm+My62X6qU/CR3tzbUPNBQ6dZXwqIJQVtlKhClHWrRx3vbSyPZFYBSQPRiNaCOSevVV0SWWUGzq0MIRuOCKKZ8lRpAbFbi9MoBX3hLAnb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGJ7cusfiHKEnhV2jgv/O9/mwi5mdywAGk0ehG72LHQ=;
 b=RjwGHeOp26SV6oT4odYAC4W4wyLPIDeE5Gf230+w16jGKd9vfnqnlfo1q2R2zI2uzwvOtVTKZu0GzOdzUyLew143vr4oZOpdBW+VP26HmUD6hmeM7j1fZETRQYMDlVEY72us7M55GqOUb3S85WUiWMUiROc6ZwxjVfjLXZ7MMSZwpyxoOGOh23DfWulpGd3DwBHpj7Mgc2LfRvs0HBsh+yND58RymeCobsnYJopN1srNKLPKJwFTWH9b+Oaui7dA5g6Az7szpZv9k6Ln1LbpSHDGnVbYktT+JzRnxrDyEptpC9fWDamXoSrVwccoNrqaXDMPPn+kz/LmerOHr7Yc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGJ7cusfiHKEnhV2jgv/O9/mwi5mdywAGk0ehG72LHQ=;
 b=lLMQurLqKkuUbZL+dr7NTjpIvkLqnigoumMtwHg6cZtisgk2moo/em2Ve4isQ0xPltqFvOX4XaQrZo3J1bS8Ov0tbrFtcDRxi4be69eu9g/QeCdy1s7HjvSbY0FTD57hCipFNmz+kzClmzQmsxknA5clgndGe8X85IY3wvRXr9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 19:59:02 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 19:59:02 +0000
Message-ID: <403cacf7-2694-d60d-1079-b8a3efcaebed@amd.com>
Date:   Mon, 3 Apr 2023 14:59:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 03/11] virt: sev-guest: Add snp_guest_req structure
Content-Language: en-US
To:     Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-4-nikunj@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230326144701.3039598-4-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:610:4e::27) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d3d72c-d82a-49e9-8b0d-08db347ddf2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4pzIH6g4iq9vXETed+cwvMwpJ1yz527vbRFVmn9PI0RheAdyZX0SdMQXZOlJ+xQKDT7KMDjE/ChEL5izeXmSUyMkcFaUsVLioelCQAFWw+ugTX9G3LXCXAHSI9syhHN25TFQ6TiM/eTZTcodng4drFmWba7nkWC2zOgzkdWct2NcLVMZfz53/MZPxH1WRk/OGJxiCs5bcDxS18Sjz+iuHmurzcsHr/iji5yokeNOMbCBCLX9krftmKGXsjYG8LSzgchSo+xmMWSf+HW4b9TRLf2/ZTfOHReV/4x1oY/Ul0s55k4IYSncq9zn4IBQwX8MZtkdcvuA1cuXWgpHN21m2srwclufIfJnKaLmhcctybELe3ZjaFafbZKMWgt8vWuUMxsjsdKM1XJus7o2ej9HRtYCxTDdgWKoIaMphuoU/GXsbgejlq29OJqxfKUbaMPvtxE4qzvg90BV92Qfw6MJ2llzA3lxHbr94+NTWhqJ8AKGOcgBzL0RTXtI9vsZtGrHd+WlWaPjdNdwXsLwhDS5pBUTQZ+2Ll3MDnErRLLERfp48KV6x1UlqF0pAopN8/2SN1iJOwRchVdUIxJsOLteCVTV9SPWgJJ5A6Di4Y6+6GyQWopooPKfUOnegRs1QRMzdQkVQheia7p9F3bsFPOkpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(31686004)(186003)(26005)(53546011)(2906002)(5660300002)(31696002)(86362001)(8936002)(478600001)(66946007)(66476007)(6512007)(316002)(4326008)(6506007)(83380400001)(2616005)(41300700001)(36756003)(38100700002)(8676002)(66556008)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0htbzJ0SEpkYUd0MGRETDJOTzNlQUJ6aWhpSFlrNGVDeURjRGgwdEtJMTRS?=
 =?utf-8?B?TnE5cTVoV3NXWTAxTExLalpjdnRuRDQvcWxHOTB3VklFSFdENFdsdGpvVGgz?=
 =?utf-8?B?b2FwbFI0MS9aeTlaQ3BkMGNLTnFKVFdyaEpJY0Yzek5KYk9KZ3pwcDBHVUNh?=
 =?utf-8?B?MzdITWtDQWdKTkZBNDB1dDJEWHJXRzg1Z09ZNUtZL2FtbmxTUmF3ME8wV2M1?=
 =?utf-8?B?VVFDaXhVeVBaOGhzQTU0QkQ5bzF1SVRURFRaTkhkTjV1aFZWUGVvNlZIVUkz?=
 =?utf-8?B?bnVnSGNSWDFvekRZKzhvcXlUdXRGaFUwMWhLTXZNTDlmaWRSME90TGxGd3ZU?=
 =?utf-8?B?emFuUFpaK0RDazgveE1zcXhkV2lVYVdTMnY1VnZFRzgzYlFGaHRGMHV2bXZO?=
 =?utf-8?B?Wmd3MFFya2h6Y1Bxa2V0OTVyRGJyd1NWZWxicTdKVHFoK0JHak93RVZWdUZz?=
 =?utf-8?B?R3VqMXFKcTJuVjQ0cXZLdCtRUzV4MC8vVXV1RFdnQXZHNWYxTXAySEJmcGd2?=
 =?utf-8?B?cGJYRExTRnZmdm9YZUZST2p0bGNiQUdsTkZFdzl1Z0xmNlBqWVVxL0xVV2xs?=
 =?utf-8?B?V0NjQ1kzTnRQb2NRUmlqZjJ3V0M3T1g0dnAwRStXanBNaytPQkV1WVVlNGFM?=
 =?utf-8?B?QUJMMzk1c0hGZEw1bTBCMmJvR0ZLeTdFQXlQRjQ1M3BBSG1uL21yTTRHb3lp?=
 =?utf-8?B?OUlaUWw2Um83WXJyUjg0NzEwYml5SEdVUVRoTm9USkZkS1JibWNLK1ZXVWZr?=
 =?utf-8?B?WW1laWxsbmpMK1piMklrcURHaUQwdWV0cUFGTUpWRnhuR1dPQk53TzVaNDk0?=
 =?utf-8?B?SGVLSU9NQ1RXTDFOY0hmckJ4SWVxenoxdENnUkxCVEgwNlJ3L1kvQWlucnFH?=
 =?utf-8?B?WWRiM040dEVjb3FydVc2K2x6WUtFZ3V5dzEvVkVoVW1tZEdjTzhpTzlwS1hy?=
 =?utf-8?B?L1pwcWNUZkdhUm9CRlhWbkpiVGt3WFVXeDJ2SCtvVWZ4OGQyRHlyUFpGOXNq?=
 =?utf-8?B?SGRjeEpxY242bkZHeFJEeS9keFFFKzZ3SXZ3YzFOM3ZVMHVqRDNoWnZMYlpt?=
 =?utf-8?B?cloxM05EY2FoUC83a0pTSU9hdmRhZEJud1NKOWRRNGROT2taRG9jQkhmQmJp?=
 =?utf-8?B?MFJQMStoYlFyd2pnbUx3QzA2MmlBZUFBTjhDUVNLbFhSTm9BRTluRFZiajAv?=
 =?utf-8?B?eUlhSklUcjl5ZS9RT2dxcnVIU3JibU9vRVJKK0RxcytTMFc5MStWTUdYSGxx?=
 =?utf-8?B?dStwL0pSL201a0xEdVJwM1M4aW5OeFV5Q0ZTcEF1RXNYazVuZ1JqRFJSVkFv?=
 =?utf-8?B?N2dSL3h6cVYvQko5TmtldUd4cDRLSmtCQUp2Yis3aW1FNUxDZWQ2dkpwTzRP?=
 =?utf-8?B?TlVvL2VLcDhnNjJkWGhkazAreVFWcnlXRmpZMm5QWGEzQ3V5S3ZFWThuRlU3?=
 =?utf-8?B?eFFCbUFiVkdGVVlMcFdWODNEVnRINzlRSERCMktjZ3ljQkd5VmNoalR3RFY2?=
 =?utf-8?B?L2RXQ25RRVNRUkNDWnVQdG9tOUpsbnhVQnZRVkhaT1BtQlBzcUlqc08rVTRP?=
 =?utf-8?B?YlVpMXhieFoxNjIxcFhxZWx5SUdnaDdTdjY1WFVmUEp6bVV0dzVNUVpqelB6?=
 =?utf-8?B?dTFIS1JoaXVDM3V0UTFqWGhhQ20vMU9IZlFTMnJlRlNGUnR1OTBVd2dCeDFt?=
 =?utf-8?B?Q29iTEdqc1NYa2dwR1A0S0lLK0JBQUpZelhjZ3RWcEY5VVFhaWJLSEk1ZXpF?=
 =?utf-8?B?c3MxcjBLdU1DaEdGUzdkK284SUpSamIvaTZqNm9oL292Q1VtMjhTalBiS01s?=
 =?utf-8?B?YTZrbmpQT0NCQmNHTFk0Q3VXVUJlUGg0MEtPekcrNU5KVUFoT0lydXhtV2c3?=
 =?utf-8?B?WFgrVmNXQ21pSlJSMVNTNGlYQUFpUjhOd1hRYTBzd1dOZGxLN1RiNmwxQU4z?=
 =?utf-8?B?WEpHaDZzSE01VnFQVmhnSVBjTGNyNkZvejQzTGRaUVpEeGJ6RXd3T1BFUTdy?=
 =?utf-8?B?NURVVzFubmtmbW5CbnhKbThSMlg3aHJoVUpSWFp1OGlHcFhyNlJxUEh6YWor?=
 =?utf-8?B?R2ZBODh6TDhvOW1xcFJRRnR0Yk1yanNEQ2JEUFY3OUJuYUlQM3BhREJKem91?=
 =?utf-8?Q?9lv4b09V06/Pt1OlAuDmzqpr7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d3d72c-d82a-49e9-8b0d-08db347ddf2f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 19:59:02.4616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bA25dNpxiDm/mrPwyMQq8+y9q7C1d0ZAQBwNxOp7kgcc6XgDtyO3ZQ7gP6yizaxBXX7Nmd9fMGzEPYnT6zlQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/23 09:46, Nikunj A Dadhania wrote:
> Add a snp_guest_req structure to simplify the function arguments. The
> structure will be used to call the SNP Guest message request API
> instead of passing a long list of parameters.
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 87 ++++++++++++++-----------
>   drivers/virt/coco/sev-guest/sev-guest.h | 19 ++++++
>   2 files changed, 68 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 6ae197b57644..ec93dee330f2 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -60,16 +60,6 @@ static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
>   	return 0;
>   }
>   
> -static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
> -{
> -	char zero_key[VMPCK_KEY_LEN] = {0};
> -
> -	if (snp_dev->vmpck)
> -		return !memcmp(snp_dev->vmpck, zero_key, VMPCK_KEY_LEN);
> -
> -	return true;
> -}
> -

This change seems separate from the changes for snp_guest_req.

>   /*
>    * If an error is received from the host or AMD Secure Processor (ASP) there
>    * are two options. Either retry the exact same encrypted request or discontinue
> @@ -198,8 +188,9 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
>   	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
>   	struct aesgcm_ctx *ctx = snp_dev->ctx;
>   
> -	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
> -		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
> +	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
> +		 resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version,
> +		 resp_hdr->msg_sz);

Again, not related to the purpose of this patch.

>   
>   	/* Verify that the sequence counter is incremented by 1 */
>   	if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
> @@ -221,34 +212,34 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload,
>   	return dec_payload(ctx, resp, payload, resp_hdr->msg_sz);
>   }
>   
> -static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
> -			void *payload, size_t sz)
> +static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno,
> +		       struct snp_guest_req *req, u8 __vmpck_id)

Can the vmpck_id be part of the snp_guest_req structure?

>   {
> -	struct snp_guest_msg *req = snp_dev->request;
> -	struct snp_guest_msg_hdr *hdr = &req->hdr;
> +	struct snp_guest_msg *msg = snp_dev->request;
> +	struct snp_guest_msg_hdr *hdr = &msg->hdr;
>   
> -	memset(req, 0, sizeof(*req));
> +	memset(msg, 0, sizeof(*msg));
>   
>   	hdr->algo = SNP_AEAD_AES_256_GCM;
>   	hdr->hdr_version = MSG_HDR_VER;
>   	hdr->hdr_sz = sizeof(*hdr);
> -	hdr->msg_type = type;
> -	hdr->msg_version = version;
> +	hdr->msg_type = req->msg_type;
> +	hdr->msg_version = req->msg_version;
>   	hdr->msg_seqno = seqno;
> -	hdr->msg_vmpck = vmpck_id;
> -	hdr->msg_sz = sz;
> +	hdr->msg_vmpck = __vmpck_id;
> +	hdr->msg_sz = req->req_sz;
>   
>   	/* Verify the sequence number is non-zero */
>   	if (!hdr->msg_seqno)
>   		return -ENOSR;
>   
> -	dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
> +	pr_debug("request [seqno %lld type %d version %d sz %d]\n",

Unrelated change.

>   		hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
>   
> -	return __enc_payload(snp_dev->ctx, req, payload, sz);
> +	return __enc_payload(snp_dev->ctx, msg, req->req_buf, req->req_sz);
>   }
>   
> -static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, __u64 *fw_err)
> +static int __handle_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req)
>   {
>   	unsigned long err = 0xff, override_err = 0;
>   	unsigned long req_start = jiffies;
> @@ -262,7 +253,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>   	 * sequence number must be incremented or the VMPCK must be deleted to
>   	 * prevent reuse of the IV.
>   	 */
> -	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> +	rc = snp_issue_guest_request(req->exit_code, &snp_dev->input, &err);
>   	switch (rc) {
>   	case -ENOSPC:
>   		/*
> @@ -273,7 +264,7 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>   		 * IV reuse.
>   		 */
>   		override_npages = snp_dev->input.data_npages;
> -		exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
> +		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
>   
>   		/*
>   		 * Override the error to inform callers the given extended
> @@ -314,8 +305,8 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>   	 */
>   	snp_inc_msg_seqno(snp_dev);
>   
> -	if (fw_err)
> -		*fw_err = override_err ?: err;
> +	if (req->fw_err)
> +		*req->fw_err = override_err ?: err;
>   
>   	if (override_npages)
>   		snp_dev->input.data_npages = override_npages;
> @@ -332,13 +323,14 @@ static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>   	return rc;
>   }
>   
> -static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
> -				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
> -				u32 resp_sz, __u64 *fw_err)
> +static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_guest_req *req)
>   {
>   	u64 seqno;
>   	int rc;
>   
> +	if (!snp_dev || !req)
> +		return -ENODEV;

This seems unrelated, at least the check for snp_dev. And looking at the 
only caller, a guest request is always provided. So this seems unnecessary 
- at least at this point in the series.

> +
>   	/* Get message sequence and verify that its a non-zero */
>   	seqno = snp_get_msg_seqno(snp_dev);
>   	if (!seqno)
> @@ -347,21 +339,22 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
>   
>   	/* Encrypt the userspace provided payload */
> -	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
> +	rc = enc_payload(snp_dev, seqno, req, vmpck_id);
>   	if (rc)
>   		return rc;
>   
> -	rc = __handle_guest_request(snp_dev, exit_code, fw_err);
> +	rc = __handle_guest_request(snp_dev, req);
>   	if (rc) {
> -		if (rc == -EIO && *fw_err == SNP_GUEST_REQ_INVALID_LEN)
> +		if (rc == -EIO && *req->fw_err == SNP_GUEST_REQ_INVALID_LEN)
>   			return rc;
>   
> -		dev_alert(snp_dev->dev, "Detected error from ASP request. rc: %d, fw_err: %llu\n", rc, *fw_err);
> +		dev_alert(snp_dev->dev, "Detected error from ASP request. rc: %d, fw_err: %llu\n",
> +			  rc, *req->fw_err);
>   		snp_disable_vmpck(snp_dev);
>   		return rc;
>   	}
>   
> -	rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
> +	rc = verify_and_dec_payload(snp_dev, req->resp_buf, req->resp_sz);

Can't you just pass req here?

>   	if (rc) {
>   		dev_alert(snp_dev->dev, "Detected unexpected decode failure from ASP. rc: %d\n", rc);
>   		snp_disable_vmpck(snp_dev);
> @@ -371,6 +364,24 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   	return 0;
>   }
>   
> +
> +static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, u8 msg_version,
> +				u8 msg_type, void *req_buf, size_t req_sz, void *resp_buf,
> +				u32 resp_sz, __u64 *fw_err)
> +{
> +	struct snp_guest_req guest_req = {
> +		.msg_version = msg_version,
> +		.msg_type = msg_type,
> +		.req_buf = req_buf,
> +		.req_sz = req_sz,
> +		.resp_buf = resp_buf,
> +		.resp_sz = resp_sz,
> +		.fw_err = fw_err,
> +		.exit_code = exit_code,
> +	};

Add a blank line here.

Thanks,
Tom

> +	return snp_send_guest_request(snp_dev, &guest_req);
> +}
> +
>   static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
>   {
>   	struct snp_report_resp *resp;
> @@ -544,7 +555,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   	mutex_lock(&snp_dev->cmd_mutex);
>   
>   	/* Check if the VMPCK is not empty */
> -	if (is_vmpck_empty(snp_dev)) {
> +	if (is_vmpck_empty(snp_dev->vmpck)) {
>   		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
>   		mutex_unlock(&snp_dev->cmd_mutex);
>   		return -ENOTTY;
> @@ -678,7 +689,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   	}
>   
>   	/* Verify that VMPCK is not zero. */
> -	if (is_vmpck_empty(snp_dev)) {
> +	if (is_vmpck_empty(snp_dev->vmpck)) {
>   		dev_err(dev, "vmpck id %d is null\n", vmpck_id);
>   		goto e_unmap;
>   	}
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.h b/drivers/virt/coco/sev-guest/sev-guest.h
> index ceb798a404d6..d245578d988e 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.h
> +++ b/drivers/virt/coco/sev-guest/sev-guest.h
> @@ -63,4 +63,23 @@ struct snp_guest_msg {
>   	u8 payload[4000];
>   } __packed;
>   
> +struct snp_guest_req {
> +	void *req_buf, *resp_buf;
> +	size_t req_sz, resp_sz;
> +	u64 exit_code;
> +	u64 *fw_err;
> +	u8 msg_version;
> +	u8 msg_type;
> +};
> +
> +static inline bool is_vmpck_empty(u8 *vmpck)
> +{
> +	char zero_key[VMPCK_KEY_LEN] = {0};
> +
> +	if (vmpck)
> +		return !memcmp(vmpck, zero_key, VMPCK_KEY_LEN);
> +
> +	return true;
> +}
> +
>   #endif /* __VIRT_SEVGUEST_H__ */
