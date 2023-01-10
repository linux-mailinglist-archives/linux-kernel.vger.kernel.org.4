Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262026646EB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjAJRDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjAJRDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:03:15 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5792A643C;
        Tue, 10 Jan 2023 09:03:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6FgeTSmu5gWcxjb1517nk4hWBW60a5okPkhiXsA/njV6Mq9zYT4D7tKIgC9tvxTx3HzdywUykonR5kUbEgUFFPvFm5z1H58b++cIwM12iEeJWOyzJdPOabPVVq2CfNp6bm00JHj7rOA+pZTRFHp5ocJ2sfYomxXju1g+WVBdVE0f7qjUs7z7sTk9/XOMg6wyr3om/SboCQocJFC9o27kALXqEkjm1KZ6cSXNC02YQfew7XUzG4qm5fw1dhXb7X5NpjsvUCvxmCTJm8rH8Jug8qXsaozwnWkjbpHXH/1PtPqfiSB57S7WKTK8Y0oXHOQK4o4nqLzEmSnVrfYUll6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=828WwowqFCaUyEGoK/R6MLMq1q04LC7qtCJjEW87mes=;
 b=GR8padpZQM+j3rwmLrOCSerWPZk5Oyw2cwhIuQJwSPX915/2gTGewZiOEzAypR14V5hRilzd8wgJHz5yUhD4xQ008wB9VgXp8ZGPuXbYSeqmigpv0F+posv/R111I1JSkE+/fa0XtQ3BfrZHF7y+rcBZdFDR2VURwelRloxv3tMOfgcuRbGlQGwRKvynNLgonJ1m4cpye60leX1kINXFHZth67W5gJ6i1YpugL3n1lCoQxm06+KXudQJ30xlT7j1Fr/FcQt6RhpTxi3O8vfL7pzXBFCfJRCEqZDqApxM88fj5/X1CEqiz2LTNy51DQ275Wwmt0B4/tZK4CBgAev/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=828WwowqFCaUyEGoK/R6MLMq1q04LC7qtCJjEW87mes=;
 b=NGbGnqUctnzakeRmg/H7yV34Zn5J8RiR/VIaIzahTsufgTJKMAbtO/IXrKF4684lXUXXOdA8yZFh8KYvxd3tFUzSukNEepU87HW/wCenq6NOu49ZcuSrVNiw9qYaB4Ck06KUf7bf0c0V0oqKb4E48hKSU5XK28J6IwETAOi0oI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 17:03:11 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 17:03:11 +0000
Message-ID: <2205411f-ba62-c673-8752-5c02fc04fe2d@amd.com>
Date:   Tue, 10 Jan 2023 11:03:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] crypto: ccp: initialize error
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, brijesh.singh@amd.com,
        john.allen@amd.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230110165316.2870300-1-trix@redhat.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230110165316.2870300-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:208:134::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 252bf009-ff90-463a-446c-08daf32c8dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7I6oKUDo0W2okfd3aCuWMYyN/q9BM6nqVn55c1HpYvoMNOSNOvZsoPi9GQ2bW/ZiAiKfdOqIkzTtM/FzSQJxH2xIUL8a3eB0O+xbnYxN4HQZpz0HbB+3r2jWMp7EkPZgwAosiMDmUDbBQo/VruqT6OfB40miTadEHKKYnU0N0rDSSuUGtUsdU9FN73QUpLFp+/HCwGIO2MIE7zL6132dCZ4S16yq35KrKtieqEdDX7wkLUnz+/jwKDNDl9pv0mxKY9pbBP2w3/Hwy97SYDvYrEmp959s6kudq9GeKOTFB4AD34Ntkj4G50K3vzu9q9VNzVIl4rmXh/5JVdq1sHoIrC3hpfBhuntvdYEDVXhXIQ7qhFuFs1EOHj0iScL9VYK6oWgPJuqDJ1hA3x+tgmhMxuJKBwOWQ+aRT49dl9Jd4P5cPh2adwre72UJJxznNHGN+koNxW0WH6B9w6n7NUvXRMmpDWRaxNFYwlZQdmOw63FQyuMOl/MO4LTxckO04sMhxN4cMQ1N1hgJa9gsCwiZ5ImsVIkY3/+s8mypk6nhrHK9Tiet72VTVhgyF6DXbZkCIHjAD68np3EgXaKqyBP8A45lEEro6ygBV4RCHe3hU10Wm9ldIJZm1mJBXvU7EAEYI0ywBwn4FpxZEXT7vTEzRBPQaSc7q43XDiZgatvAABLUDkuZ3ngvwOM1iAg51R9ORHSNp45wVANkDQFjcJvKu4DkN7pvSHSVDymXy55gms0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199015)(41300700001)(4326008)(2616005)(8676002)(66556008)(36756003)(316002)(66476007)(66946007)(86362001)(31696002)(8936002)(38100700002)(5660300002)(83380400001)(2906002)(31686004)(6506007)(53546011)(6486002)(26005)(6666004)(186003)(478600001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUVaMkN1MVZ0SVY2NkZ6MHBwcUoxQ3llRTlWSjd2UE9ZS0xUK0hzbTFVdE9R?=
 =?utf-8?B?Yyt4RWgrUTJDUHZWeS9EUFlCcTZOQlR5Y0pYeGdtM2xTMnh4c1lPampvdTJY?=
 =?utf-8?B?T1haMGlqeUVMOFY1aHdhZlBnaUJuUjVHMlR4bm9yQ0F4dlRtSmFrK28wZGp1?=
 =?utf-8?B?UTkyK1RvMEhEZkY0RVBJL0JXTkpyZ0tFa0ZJOCtzME0rSWlyYmpjUUkrNXMx?=
 =?utf-8?B?SDRIbkk2ZElOS09UZG00UGFpc2ZjWHF6eWVrYklIQW11WHlqSGlDRTFEcHhM?=
 =?utf-8?B?NTVsc3ROckk5MWNVUnFtR1VkN3lueUZhYVhPb0NmS0c2RVVENktldlhCaVUz?=
 =?utf-8?B?MExLUVRYL0tKSmF2cmUvdEc5RVpRQ0FCODhPSGxiamtXemJMa0hVRnZUTU81?=
 =?utf-8?B?MUFiU29ZT0JuUVU0UmF4TmpBL2N4ams3WTlpNGdCZVl4MlplZENraXE3UEVC?=
 =?utf-8?B?VExFeGFJS3dBazdIRHd3OXVzWnV3VzJFMmNDcUUxanE4bzI2UHovYjlQMjNZ?=
 =?utf-8?B?a01MdGFIcGEzdmtpSVZwcFZXWmJmaWdsLytoeTZlUWRVT2Uram55NExaT3dn?=
 =?utf-8?B?N2tMQmRiVWtTQ01RakUvNjY1NUVLQ0dvR0Y5NHVLSVdoZmtEcUpBK3REa1ZL?=
 =?utf-8?B?MDRSdlUrb1FVR1JGVER1bVBzK1o1R3p2UXQ2Y2xSSDhzYWVuMldSaXFzeGZC?=
 =?utf-8?B?cDBSeG0zZFVLZzNKOW5Fa0ttMWtXYW1IYkM3dWdicmVvNXpiRCs0Z0VsY29C?=
 =?utf-8?B?OHRGOVVGWFIreDI5Q0t0cHJqUElSc01teDlPVGhidGQrQnQ3N0RaSTlMS0pZ?=
 =?utf-8?B?TnZRL2NySGcwNjluaEo1U2tQZlFxOHNDZTljN1U1RXNoS2xxZkI4MTVWZmZv?=
 =?utf-8?B?ZzFRNVhVREo0SVZiQW1SN0l2L2MrR0VzU3A0TDMwbStnekRvZElSR3NITHBX?=
 =?utf-8?B?ajFlcWNXQ1JxZnF1TWRiSFZXUWZvMDBFbS93V2FtWnBVazUxT3lnNmtaOHlJ?=
 =?utf-8?B?WGM3cktoUndmdEYzdTFmSkRUUkcyZzJRK0tRRFFCa2JjRXN0YitpeFlZcGx6?=
 =?utf-8?B?eEdJU29pS2t1TUdoMzRGN3R2REtMRzlsVEkxeFNUcHUvRkJqQ1pNSGxKWU9M?=
 =?utf-8?B?QjhUYmdKSUhnd1ArY3NPRlpLOTkyUmdncTVjRGxpRmpIZ2Z4OEpNbE45VjFH?=
 =?utf-8?B?VG1VSmxNS1JZYzJsUkV3SngzclFTS1FIL08zNEtjV2NzY3lUQUxheWREZEgy?=
 =?utf-8?B?RENnTk50ekJQcmJLYmIrMWRyUVpjeHdCOGNvdTdJRTZGNjRhWnYzV05VZG51?=
 =?utf-8?B?ZHZoVjEwRmpreUQ0dGt5OXNIZE9WcHlPREZ5T0VUbG1nZ1poTnIxekJvNXFV?=
 =?utf-8?B?bmpMOWh1VnR3RHIxMkRnMHlhSElEZjJzTklIejBid2xYUi94cDlwSjh2MFov?=
 =?utf-8?B?VzQrcXpmc0dPZmlSRVE2OVVKMG9UbmxPUHdMWlJlVnhKbTV2UVFlOFRuUTA0?=
 =?utf-8?B?N3pZRVlTVEdZZXArd3d6MWtmMmdFcWducmhOck5oRlRUT2NGNGFWN2tpM2Rk?=
 =?utf-8?B?Nk1WZzhpNHVGaHV1bkM0Z0ZmNjF0QTN5M3pGTys3cndnSkR1a0RGNHVKTWVi?=
 =?utf-8?B?WkpCbzdsM1A5VytkMEhzNnBlM2FkVTFQSDYwSTloN0ZDcXFRYlA2RVl1aXVX?=
 =?utf-8?B?bUZXc0tsR1BieDIzTytLSTdkaGlVbHNhQzJ2blhORkxSS3ZZRDRqWllpRmxv?=
 =?utf-8?B?STZSSkFMaFJ4cTcybmc0SWZwODltQmtWS25jOWI2TGtaL0sxVVcvUjR1dWpV?=
 =?utf-8?B?SVljQUZMTURDeWVpc1Bockl6WnNkU3FKMUJOUWlqRFVrYXZ3Y29JelNiL2Ix?=
 =?utf-8?B?SS9aTExBQ3llTkRFZmNKenZmWkxWVnd3b2hDY1ozMHhZTzVwTmpBbWZocUpX?=
 =?utf-8?B?SDc2dDZwanRyMDJYczNqWW5OR0FReTJJUmhVSFppQmZVN25yTEwrMW9XbVdR?=
 =?utf-8?B?WGcrNkVYcWtxMDBSeGFkSGYwZDV5djdmTlRxVEhhQ0VwZ2Yvd0NzU2gzRjlR?=
 =?utf-8?B?VE9xNHB4WFlsV282aEZTcnNhMUVYSUp1bmdUaUdoYnRJNUtMVzJBWk92bnF3?=
 =?utf-8?Q?fWhtDJUchdAkEKhVne3IpWZXs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252bf009-ff90-463a-446c-08daf32c8dcd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 17:03:11.0759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hc5RtiMEKJav3zkIu1QTLyqHXyFlmq78oFsMTtk3eCwQXLDsTSDUoOmC2FGUBwML6uK30un0pyZVo1UhJOSzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 10:53, Tom Rix wrote:
> clang static analysis reports this problem

s/clang/Clang/

> drivers/crypto/ccp/sev-dev.c:1347:3: warning: 3rd function call
>    argument is an uninitialized value [core.CallAndMessage]
>      dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> __sev_platform_init_locked() can return without setting the
> error parameter, causing the dev_err() to report a garbage
> value.
> 
> Fixes: 200664d5237f ("crypto: ccp: Add Secure Encrypted Virtualization (SEV) command support")
> Signed-off-by: Tom Rix <trix@redhat.com>

The subject is pretty generic and confusing. A better subject would be:

crypto: ccp: Fix use of uninitialized variable

or something along that line.

Thanks,
Tom

> ---
> v2 : cleanup commit log
> ---
> drivers/crypto/ccp/sev-dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 56998bc579d6..643cccc06a0b 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1307,7 +1307,7 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
>   void sev_pci_init(void)
>   {
>   	struct sev_device *sev = psp_master->sev_data;
> -	int error, rc;
> +	int error = 0, rc;
>   
>   	if (!sev)
>   		return;
