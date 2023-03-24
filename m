Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69296C884C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCXWY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjCXWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:24:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EE51024F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679696673; x=1711232673;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s/0oDFAmsPjZhv1j2dwpaK1YlPReHHG7NzO1+w8qihQ=;
  b=HU4nfX5ByCBzfjku20oP0UO78eIb8J9iecVTHm5RiWJQO1cnkG38Zqo/
   9gr9hjtADuHwuCCcuG8kGb5a3+4XJeKL2z710smqmLMvZesvopZiMfWYa
   7+8zEDTkaz4LTEUk1C4m8y0byv7eAAhoTHTdsgGGL93R7BRYg9Wl0f6Is
   WVzhSZoDgOKFZA0mtXTChVueY4sPPQlu07dfyTvloGds4vrB8YMZ8FEIR
   UW2vCPNnUlq0bmfzThxXiCtICdIOiGrAX6443WxlkL/3OBaf25c6IpQS6
   ZgL/yRDzEgGrYCLXyD017z1l2FV7htRz7Kgjuo+YfQ6s72IkDsfGlfCkS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="341467777"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="341467777"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 15:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="857029990"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="857029990"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2023 15:24:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 15:24:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 15:24:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 15:24:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b80rJgsVuJgyfGnEfe/RCqtOCZjIMDvh0V8eZh+CX0VOuWMBaRf5SejXyxys+a9Brjbp0CzAsV3LZ2EDzIy0/FYOewO6eotXAfBlj2YvWzOXl3/IG+0q2QRJvhjr1SOrTjrU91v7epJxEIlt33dMbSUy1Gph12WIRRYDLNtw1iliuGUx/Lsne+OFjlObV+lrARNH5Hf2rOdz9BZI3o8IHhDYWWIljSayaJO8w5o/PS8gOT0g9sjQjpYG7SVe2fyXA3817sSXNmk398u+zVJDSPWDjjBG2LJ1SdUdXV9c289QdWSr6s1qhvoe7FZOOrKZpPdjm5QLWbx3PzkU+PDM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nfdm2kDC2W1snrG4JMUJilBLVT6XGkF6EFzy/jr+o7g=;
 b=grhJI2pTiTgV2XlwIqGmHUnIzqZuwm4Qcwp9KpfNMe7UejeHT3SW0QM1cViHtbUWMCSaVKYxHorOTdeQXw2W+WBkTfXW5eXQaSb4MlfMmvkOzyO2H4J/N4nbpuykGId8euAZkzzHMEUqX28hVpa7jWpBS4CbpfJFMhoEXIkEbddrpy/GQzIoHR6nZWhHES4rNTAZmuzFs8ocg3xeWoWqVBt9azI21szKYEol4OUhqbWRHtjv7UmrVut09klx9mtJdUqsYa/E5/LHJn+eWvOX+pjL4QBFWuheQgtAy3GKDoZyGlvcwEgt7LgIZlnsiHnZS5VLZ4ggMUMMMgeyeGumtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 22:24:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 22:24:30 +0000
Date:   Fri, 24 Mar 2023 15:24:27 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        <outreachy@lists.linux.dev>
CC:     Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        "Christian Gromm" <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] staging: most: fix line ending with '(' in dim2/
Message-ID: <641e231b9862e_325e1f294e3@iweiny-mobl.notmuch>
References: <ZByu29jb1mE3KOsn@khadija-virtual-machine>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZByu29jb1mE3KOsn@khadija-virtual-machine>
X-ClientProxiedBy: BY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4767:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d44f753-5afd-433d-8a22-08db2cb6898a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqDB0dD/S0IfvGQV5zmfGd/wBy4T94QxxfE06l3qGAqhfcrUfE8GN40oen2HnpEW2BqcN625ttQ68v97VoczwFnPhIiKvptJNfsqpbLWPyCyuS4yZbI9FomJJ9xCy+1RkTp/eNolYZZ/ELjla0Kgpz695OHW9w1UptRCXoeb8nBQ8eDq1LnGXPRc2cw7e8LDgsxyRYGADoVtOBwERddgZaW0tuZkTHKNXVdwNgSsmNWEjTHCXLcvD4niyiCX8UTuWt+7HWFLw0MRV/wPlpODg3ht/H7DzOfi3cLnWvS/akujpPcMl9G5AN9ERFXjeeD84JB0CAavk363fPqmVCfVP2KAgVx+IDq5Tn/xBv5hiuSbIx5htHfCZ1dgeEI8Vuv9hvFbb22Fh7ma2zqzaQ6vrxq5/vmo92DK3Mx+ckK9N+uSSkiM4UGDD63iQcUhnsRU7Q0UTKkzlQkRqKfMsXhAKKwEb4OT6A0LmDTRnv9uKjasvaTlnN9oeejcKlHVSRdtycyyvfpsbqLWUwN6aKZ9z18wnnYKTXzULTJn5kJ8nETMCwwnyH/AQO/r1ZyC1PsC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(6486002)(8676002)(83380400001)(4326008)(6666004)(26005)(6512007)(6506007)(8936002)(186003)(66476007)(478600001)(9686003)(86362001)(66556008)(66946007)(54906003)(2906002)(38100700002)(82960400001)(316002)(44832011)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+L4UlgZZSfo4vJtSBWgQp6dgahzXnX9Rt0zINrZTKPNFWe2sdZKYO3/TkHYx?=
 =?us-ascii?Q?9dti9jdmrJ8N9995FlLMSVzInFN32IdR0iuQyxS3/Fu7jB5MZXX84ZfG0v2J?=
 =?us-ascii?Q?md4GbKCe6Szbvdf8ZcmhOsTNlrMI9aGvvsn4O5aesEdjnLzBE6MpDVhDIIG/?=
 =?us-ascii?Q?/2BdWaIFEjOeJNfzSw7TYcfNj2gAA1fBG3lZyxT7fDq/R7xFGWcZN+F9IAx3?=
 =?us-ascii?Q?+yYdF7yAGHo3YyT6cDtzGExI0hA0S0azWR/KxL/FmOOGX/5WFG9BGaIJCmBj?=
 =?us-ascii?Q?IK/TkGyEATquILcIHrytkun4r527/i6RrQZVYQpRnLw2gWDmv8Nre5N3oxn7?=
 =?us-ascii?Q?QvbiD3Y1kH/yLXNFDFVCDA/w4vumZB5WBo/pC6rZ359JaUjrFblxfl7JAa4E?=
 =?us-ascii?Q?TMi2XY+i7GA6B+ztv7BxcwnUxEr5NDl2fPcu2+aPbK/iCSzpFeCCWDizlwZw?=
 =?us-ascii?Q?r96DMctt/nYYY26TUYEsbVbpMNHE7rFaZySw5HGcrxHDyaP9cDTmc2MY8UY3?=
 =?us-ascii?Q?WGtvur/kjjpGIzS6KNoimbbmYugP+YTUkhxucI/eALBph3cgyjKtvIfIGTwR?=
 =?us-ascii?Q?Z6wZpPT8cMzckKMTgoUKa5+rprGYXlShkEStoOBP/O1y5FGpgICiQJ6AIeDu?=
 =?us-ascii?Q?zYhglhboc8icvo0Z78+EG7uc0P7FkSWgDjBTLz34tRvnsyoCRpMHf888XCqP?=
 =?us-ascii?Q?ilyZT/m/zs/5JwEAo5MbjW/6W0cKc6ne0gkiREvqzhXql6nmb7epahE+9iav?=
 =?us-ascii?Q?SnzqydsDdC4NKwWKdt6YrUP8awjog8X6kdLlGTZr0k82Vf6TXRQ5cBC07k6t?=
 =?us-ascii?Q?1zvfG22ri7lHCZjlD1R7Sg/xNeA0nuuVHiYrOG6JR5NucYN24bFNreZgRT0g?=
 =?us-ascii?Q?J5fCZjnTf1HqqCY8VQBhmrGvKMAy2fXZ3l6alHHKNe+20L2BIrMHFHXoZTIz?=
 =?us-ascii?Q?z2q4ESj2PdWMUzHiZGZvEqCq/XD+hqIsTxsV8FI+tlmXn/MLcecrJAiJ5KMx?=
 =?us-ascii?Q?vu9aKnMTrafF/nNkgqtqH8ixJt6Uib4zmGSWLpJfewtaW2uxHcAZHP42y7dr?=
 =?us-ascii?Q?HIdy3WewznmA78KGrIEdS37pV6D/BVffbMFTdzQgutSHTs76XI3wXUwWmYT5?=
 =?us-ascii?Q?QCDf+teS5Z9oI58s5G/8LKqSwt2MV+PPVYAV/VoQkz3IEb5Bfl/GfEhDPElA?=
 =?us-ascii?Q?4sJIjtzkWh0ck6C37+SvMkLuPd5fl9C037PIXttadJW/TM2UrcqNr5ZJdbGE?=
 =?us-ascii?Q?RgnTQrQNqF+h2trSQoeM8ymIFb96klQSbrak7hx9J6C7wme7+6OdgncqIiYp?=
 =?us-ascii?Q?jp47XPC228JxkWzAooBhO/oIKdM165lnyVPErWQ4aF/7ZGaK/EOSgQQWmGic?=
 =?us-ascii?Q?FOF5I5QS89fGIg9Fdwp6Rf77HKOk4Wy976jHWQsPPKBUSzCn0Az/WVPkELRG?=
 =?us-ascii?Q?swNu9RBqFt0YoQDMMzeGlQi93viWnTT/3sLMRA4suAl0TkaIpGjQgnP5fF/H?=
 =?us-ascii?Q?TZK3dAYc2SuJspBrIqUHh8oK49oNsEc6HpeHGgjXJKhqg5tNkwzd1ROhUzTM?=
 =?us-ascii?Q?nMMRwjnGN+ynVm7ZcqvWx2oBRPJneS44xQxAR/Tb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d44f753-5afd-433d-8a22-08db2cb6898a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 22:24:30.8316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2afp0qdsYPYfZaPHTv9PnEZwBXTlRYzVKD8X0e5mls3IjKcet/GV4E8rfAie2XWD89mdYREyPU0ezdtxQbDBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khadija Kamran wrote:
> Splitting function header to multiple lines because of 80 characters per
> line limit, results in ending the function call line with '('.
> This leads to CHECK reported by checkpatch.pl
> 
> Move the function parameters right after the '(' in the function call
> line. Align the rest of the parameters to the opening parenthesis.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
> 
> Changes in v3:
>  - Changed the subject because another patch for 'most/' with the same
>    name was causing confusion.
> 
> Changes in v2:
>  - Changed the description
> 
>  drivers/staging/most/dim2/hal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/most/dim2/hal.c b/drivers/staging/most/dim2/hal.c
> index a5d40b5b138a..6abe3ab2b2cf 100644
> --- a/drivers/staging/most/dim2/hal.c
> +++ b/drivers/staging/most/dim2/hal.c
> @@ -346,9 +346,8 @@ static void dim2_clear_ctram(void)
>  		dim2_clear_ctr(ctr_addr);
>  }
>  
> -static void dim2_configure_channel(
> -	u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address, u16 hw_buffer_size,
> -	u16 packet_length)
> +static void dim2_configure_channel(u8 ch_addr, u8 type, u8 is_tx, u16 dbr_address,
> +				   u16 hw_buffer_size, u16 packet_length)

Same comment as the previous version I saw.

Ira

>  {
>  	dim2_configure_cdt(ch_addr, dbr_address, hw_buffer_size, packet_length);
>  	dim2_configure_cat(MLB_CAT, ch_addr, type, is_tx ? 1 : 0);
> -- 
> 2.34.1
> 
> 

