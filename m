Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29498719AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjFALYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjFALYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:24:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AC6128;
        Thu,  1 Jun 2023 04:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685618661; x=1717154661;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Lvtcjp/7Sb4rVakX7WbfNbwPxxhPIMBIkYXsHELCkk8=;
  b=YoD+atw2MyEN1LVmq02+k7uKfdabAMP7MYnuNm2jFLOIFXhNL+tvuVkX
   eqgqXo1Qm/LNG/KKoOyJXy1HEVigyKEIXCComa5cmCu4uoZE+GuNYyHkw
   5uQqBd/cnBkVDn9BLmJ97ewSTW4MB515QsxubFjErW9MScAw6ND2xN0to
   IcT6QUfuBwPoAxaL6nWMPA4AV51njnCfbbtO/4bJuWV2dHpMvl8TOk2EN
   Z8hiGBn55bIbpaElts05hd01+fmx5AUCJulg5SEgLh2KMgmMJwbk12Y6Y
   K1+NMl5e64NOckyH4pr1cMp93tdwCleMYjQfvqmCsKb+4wgtBQnxWEQH3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="441890871"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="441890871"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 04:24:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="819725285"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="819725285"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2023 04:24:10 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 04:24:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 04:24:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 04:24:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnqMxeZs2gZNnEH4thFL2zF+TagtXG+5ThzKjAzXIKmPI5vLKlghIOPcUXEoCMLwbng5xIVonOO3+Bnmfci4GVmm6KkPVBsYGLB9a4SyPVOmcIsIyxr5RnN23gQrJPJXg1/sjsrzaj4dKWgUkKGM75LgCUJrtVYjIqgSwTTIlukjVWDQr5JG3OQllRSCiBlGKBLxzxu8EJyluW3FgX7D6CbGzubEUo07NdBEJvVyEbjjxvHSFYPlBbz6urifFM06/gfO1boS8vHNp7zhLXp//U6hEcDfjFi7QFDXmTXUbPzyEAyynYCVoyt1T2IU7UTm9pnFd8JyIgHnRdYvxcgxVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxP9FsgR5e7iEIkhcPpoKeqxHnLf+2ZuwzGy3LEmDOA=;
 b=QDdBSfvosKkp4nqsyCSY07ytMUBqALN4EWENdqepjMmj+7xl8KYJawamBO8kleJZER6zi5KjWy3+BQU0zHY8bP+GAD7xgXFdz6bhGslrODI+pyuh9637g+NUmvj/n4S8FjSxb+Q8vof795XMXv4U+6Nl99iPcqQJOOiOUy8fYAVWVjOQHxnvLVhdS4iS2/P55rbGoekTajVo6iGeVvoyPfu7om4fMsTnVKU3ZQ9O5hy2Et7jys9W84UcjJQYKoPFoHp3DNiFTUX0X9NzgNNS1JyDJDuD9lDcCau2yGffCI4u4QkPi8xQRKg4hWiSxKMqK9Wn3NfB+dxNtjgRWVTDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH8PR11MB7069.namprd11.prod.outlook.com (2603:10b6:510:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 11:24:07 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::db49:ca8a:d7b0:8714]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::db49:ca8a:d7b0:8714%7]) with mapi id 15.20.6433.018; Thu, 1 Jun 2023
 11:24:07 +0000
Date:   Thu, 1 Jun 2023 12:23:58 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Eric Biggers <ebiggers@kernel.org>,
        "meenakshi.aggarwal@nxp.com" <meenakshi.aggarwal@nxp.com>,
        "horia.geanta@nxp.com" <horia.geanta@nxp.com>,
        "V.sethi@nxp.com" <V.sethi@nxp.com>,
        "pankaj.gupta@nxp.com" <pankaj.gupta@nxp.com>,
        "gaurav.jain@nxp.com" <gaurav.jain@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iuliana.prodan@nxp.com" <iuliana.prodan@nxp.com>,
        <lucas.segarra.fernandez@intel.com>
Subject: Re: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
Message-ID: <ZHh/zqNu7XzwJTl5@gcabiddu-mobl1.ger.corp.intel.com>
References: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
 <20230523165503.GA864814@google.com>
 <ZHh0DF4meU2ze+g7@gondor.apana.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZHh0DF4meU2ze+g7@gondor.apana.org.au>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: LO2P265CA0512.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::19) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|PH8PR11MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 7391c023-7b55-4ad7-24a3-08db6292b690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iadOoLp+p6HRifeLZtgt/lKOiK5MPkiMd19vD98EukaW9HBL0268ppZSHZZ5+pwTnVALtxQDYndzPtdkc+/SjNqKUvWWXJxSPyU5nG/7ZSXd4+HWQ/6ie6b5hAsNyfQ4XIgzZ9gV/FcngH9zuEyNDyYvABBUJJslv30qX2O6yQ/C/X6fQCV7PcB8049i/0RPtVfe/MGLk27gWg5s3KEGrPnHBduWPgryvseC3EvZcBjo12GMLkhZaOHcQPW/nJq1B1HeOluvjo/G/EBi4cHE5w9uMqpV7cTanlbPg2236my89VGsZv1XveQt9VvFUwv/4A+G8xMT7cc5O8Yrv4Bss/0hMIwwMx/8MGarpM6XSWRpq1E9zbrjqy47zlu6RIx3xlCZm8OnbvVxnMuYFos4qx7tGQIozRefjgxpp/BAFCCmwk5yPBZh9nGm7dfy4naGXY2iLy+1xB3U0YmcbH4HjoWfkAb2QSt3bs41xDZhzWit8RzgUdJSO6K+UwEBlUbK4Ksifqb1gOoH3I7++cvWgGGDX7WZzSzaz7WVIJH1lNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(36916002)(6486002)(966005)(478600001)(6666004)(83380400001)(186003)(86362001)(38100700002)(6512007)(82960400001)(26005)(6506007)(107886003)(316002)(41300700001)(4326008)(6916009)(66946007)(66556008)(66476007)(44832011)(7416002)(8676002)(5660300002)(2906002)(54906003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tG0JOQQ7eEX0gz1ZQt9b7vZLRwNbiKUS0GmEnno0aidtmls7iNCMr7TlwRr1?=
 =?us-ascii?Q?S7m2oNUTupo3MrO5QrNaM8VO/p2q1m/05vq+9Qt9IcAnlU/FtWlEGYvsfB5t?=
 =?us-ascii?Q?EosDrp2mQlirDnwm+rg5LWG6QaX+ubZ7B64GbVA4c11HBZKE03TlVX8BP/yg?=
 =?us-ascii?Q?Bn5o42kItAfoxh+R0NSuv+inL+U2KR9WwRr8uhvJGkjyKSoidcfIN/34uowB?=
 =?us-ascii?Q?dHDKPyzpFhPd7MyL7pxP3dsXXFSdKMyV+isJexdOncqcpfrSlfFEL9TqvMaE?=
 =?us-ascii?Q?ZkbMPCd49oLrhGtjFPj7updckFIgDHqPnoLgFDGA0ngmK0A7vZXoiQAsZSQ+?=
 =?us-ascii?Q?AwEHGp4BMC6/dWyHIgNDTDRprCgpQzLnZOajn5mXZoil5Sc5EOaNfEHNUkLn?=
 =?us-ascii?Q?QXthMmHSnWiNZnK8Ldj7F8fxWVsidaXCIIda6Xr+98adFnpy8t8txhiNqH9A?=
 =?us-ascii?Q?nR/vJ5/CNV4VC4u+xZ1lBnKjmhwKHyOB5BnqUkBuL4hOZBoe6DJuYwpkSkvH?=
 =?us-ascii?Q?s6c25R6wMZ15WKPbtQCSYsOowpBOmdJhAXMgbbQQeekVfa4fVPzHIYu48Ku2?=
 =?us-ascii?Q?ivNFwTXk/G5lFcKYEmf1QZShOexdeVbc9hNOdWuCo3f/x87MWNZJJaUY38fx?=
 =?us-ascii?Q?Aj9MuBIAg63jGyLIywthQ4SFtOdGKGicOjwMvTLz+G9BcvV3sMU/ceShci6j?=
 =?us-ascii?Q?MpHIXZVMtwUFzBteNYKSW5s5OHm3G5sLKJmK+ZS9oJG0oxJBDRxWQ3Sg53Uy?=
 =?us-ascii?Q?kXEs/bIdt+q+uR0QZs+RpyrBN+s2BUoIkj4sz3juJkg+kUAFBWWM2a88TVJ7?=
 =?us-ascii?Q?Um7P61L//rXoeYA8HNdHF7kFch4z/zmVczGnClKxfzeu9XQpUGu98TM8RQBl?=
 =?us-ascii?Q?LwuIW6QhWuuNN4Hvm2oc4tcDncumsQls4c7/jB3eJ4sPAthBPa8usFRjX3W9?=
 =?us-ascii?Q?sR3Gk69TvL7DVZEPUijQv1t75iLPCAdCS7KytlIp1cwO2oOPeedcfXbFsjKO?=
 =?us-ascii?Q?TaG3Yok5F4ZRCotAnfkqTPDw1L2tf+hvUcURsvoQPSbB8JvhABXEiPRXn8Uc?=
 =?us-ascii?Q?7wz21VxVBNqu6N9cXeXrKpdgcKtjbbXP1/vjlq9aU6ppWfwSLovaAldvAIW0?=
 =?us-ascii?Q?Ja8fWdjUmZyUNDbw0LBXgC5DbQzNAmZCi1tcHhoyjmmaS9/anfOBptvyHFXf?=
 =?us-ascii?Q?tsACBnBclp2KsqxxIrX8ud3yKtVY1TXQTDuOjJ6j7s+SC0ie8rHYCAVETahD?=
 =?us-ascii?Q?IkuzlfOw59K9OjLz/QiWaGfYa3WI5AdsaihwzKwR7wuxfO1YAhxl8Wp/7Q1x?=
 =?us-ascii?Q?WaCD71Ej5k7TWDIzzTnHKFTA0npeH7Fe6GT4mawSJbPRDJUIqGLwxM+Kx9cZ?=
 =?us-ascii?Q?WvZaxsXza+t0PT09puuvyi8Je/X1soA0x86R0ASJ5IwVNG3HZkskBV88Cqks?=
 =?us-ascii?Q?2xF+J+mU1IQcF+Prs9LXVGhSLJidbgk0yZPaALZ+whCnNMdohW70ajvSnrs0?=
 =?us-ascii?Q?fPC7KMEoI9x5J5f7Cgf53RMXrTzS6rWQXA9bfgB7ycG668Jl9H0A1UVk/S6W?=
 =?us-ascii?Q?mGzJvWNNUlUqy+CmhFRboklyibkFN38PMWJtQ0AojXIg3ed6CkKmLPupUBjr?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7391c023-7b55-4ad7-24a3-08db6292b690
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 11:24:07.2480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hd5XmUD0Efz2IJ4q9m96tuYjWePCNYomNdn0cuJM9t+j36Kl6kKn6iETuTFswo36h9EfI4ukDGyTnt4aEIzpo+k79PIgKaDjuSY6EOw/AdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7069
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 11:33:48AM +0100, Herbert Xu wrote:
> On Tue, May 23, 2023 at 04:55:03PM +0000, Eric Biggers wrote:
> >
> > This isn't mentioned in the documentation for CRYPTO_ALG_ALLOCATES_MEMORY.  So
> > it's not part of the contract of CRYPTO_ALG_ALLOCATES_MEMORY currently.
> >
> > Please don't make this change without updating the documentation.
> >
> > If you'd like to make this change, please update the documentation for
> > CRYPTO_ALG_ALLOCATES_MEMORY to mention this additional exception.
> 
> Agreed.  We talked about this at the time of the original patch-set,
> but never made any changes in this direction.
> 
> Apparently the users are still the same so it should be possible
> but it has to be done in the right order as Eric suggested.
BTW, some time ago we did an assessment of the users of
!CRYPTO_ALG_ALLOCATES_MEMORY and we came to the conclusion that we
cannot just update the documentation.
dm-crypt uses scatterlists with at most 4 entries. dm-integrity,
instead, might allocate memory for scatterlists with an arbitrary number
of entries.

https://www.spinics.net/lists/linux-crypto/msg65282.html

Any suggestion on how to move forward for drivers that allocate memory?

Regards,

-- 
Giovanni
