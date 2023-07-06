Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82FF74A269
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjGFQqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGFQqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:46:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF381996;
        Thu,  6 Jul 2023 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688662013; x=1720198013;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rBl9tNo3qNH+B5XIZB9nQhocsqIFpuDKZ1B8LED6034=;
  b=kIrAnEM2UrK/uL2p5SCiAt4dMoffj+/3+TT1UDCfoXZ72JjCG5nnCnI1
   12Tn+hMLJCZNZDOD6w8Q7QJr9PYjnjx2BAYVXrvJ73mN9UD9W3hKp2qRM
   mdx31jJM59/moc4BJy+3qMtmOTX8jN1HSBqDG4JFd9bhFEYyoxtaoSpMb
   CH85cLaXHuWFw3Hb9l207a1rvLZ++bGdA+oKyhkcA+9s6Ifw6mz1MW18b
   tMQK1czc78GZsWD2ooIpzqfExVNdZ7Lpkr1UsnkquAq+a8B1waPif0bT1
   7hecx2xE02276cHih+WuZ0Dxzo9fKYXmnJcxA9IJQUJFP0bymIPS+abr8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="367147060"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="367147060"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 09:46:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="722860803"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="722860803"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jul 2023 09:46:51 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 09:46:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 09:46:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 09:46:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3AoPmplOAkJEfR92gdFNuEREn5qsiNsZoZUnolJluvZbjldLmbUXtNJP1Lx4qZmnU5+vQGX33tIVLZ2WFQ8xB6kfuWZFFgE4dh6aBWhJjdXZLG+WsqbUeA3pLqkNrqn0D4ydPsQ/i7H/IbAM9Kh8/76+OEIz6EWVeUQiY1IrBcRec6If7zFRIvkoqgQg7zyPR+8dJX/a+rIIx0jVQ3/nvZjCbvFeAm+gRXJm6W8pPRL2h+O9SkFN9k7otnxafr6Ui3oNo+Jv83q60Rr6r+oO9KtC5o8OtfOe0328Jrn9XtVwqizUAR2BdtxP8MVLlXzi1rUuvmJPgOzPY/yUVTpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/0twT6znIc4rN24iHfqPSzn32EBDHqEqgleBOVbUrQ=;
 b=BsDR+qmVhex5CclAOwtg10oRMAc1ee0aPNnLfRcDxhphaNPi3CeULnJfyG+nEVmt6DGvkf8j4CtYnVEYTBJiSul4nt6kuRZbQaGbesoXshpf1xn+1srshgn49j5DjJ4I2ATRE1WV8HbTyyjk7yyRJ/oSeIWdWtfSL08P+iL9M+LRwJE38IHSBlClANjsrh+G34x6cpTzxLH+l4n60LfUS6+8f1S5TDG9O+X9yfAoY2K2ClAMvVvrYSF+lztBXeRypeRuC/amM5S8loHSGrFoKdp/A/fjqE2hgn0Fe8KS5vsh+eS9GDSGuhoDCY9rav+YoWwgKanXNzcRgbrlesqfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DS7PR11MB7930.namprd11.prod.outlook.com (2603:10b6:8:da::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 16:46:44 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 16:46:44 +0000
Message-ID: <6310c483-8c6e-8d34-763a-487157f6ff0c@intel.com>
Date:   Thu, 6 Jul 2023 18:45:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next v4 3/9] iavf: drop page
 splitting and recycling
Content-Language: en-US
To:     Alexander Duyck <alexander.duyck@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        "David Christensen" <drc@linux.vnet.ibm.com>
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-4-aleksander.lobakin@intel.com>
 <CAKgT0Ue+VvnzNUuKiO1XFW6w3Ka9=SSfGBP_KpkbvR6uzqvg5A@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAKgT0Ue+VvnzNUuKiO1XFW6w3Ka9=SSfGBP_KpkbvR6uzqvg5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB3PR08CA0021.eurprd08.prod.outlook.com (2603:10a6:8::34)
 To DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DS7PR11MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb823cc-90f6-49b0-05fa-08db7e409475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0CkSKAjNCVJpTcwclIso0PpdQrklsHVxfFvmodXjjPddF+xYsdttwwoF4GqpvI+Z3PErybIzhyQTbAHu1wXFTyLPbe3lryQ65FTGBDgztk6FN/JWkkm1KpCvaW2uQpCsRb8yTrKJYksgoRN46qtoV2u4VPg8lVBuVn2Q8O2zEadXcNLpwlo1AcTrzeNLqydzqOuhfZVWRryBqAcYinSuZkeM/jrITcEYefhuFqWbsC0eQ0pn5IBeNBK7Nb73cL3NMOqxnG1oKkmk6Tr/N9YGW9PKo/Y/8ddw/rgK9hWbJWizdNP+KzKQG9dUuGZxeZKWodEnVFHqxqMk/w4zCaxKuNL+7UFYd2BpVNbwEESwm4RbtPO2/CzHUBWJYaxk6mGSqZ2AnEsgiZq2rQPWwlS/b2prnNhBfjFoDObgBHk86jlqj6nBkbC5zNosaEEwskay4+3BcDjQYP/XLXA863FYs+ZOMefqGPX+LummOpt+zgtFKWTcGGjLBCaTud36FtoemaHNnClQnBojwAv3Ad6h2uczwVP8SUcoC8/c7UQQ2/1r2qmqWaXT+WsMHR0Aa8UeaBZ/wkZ/W4x8EfiTGQfbYi6MnEko7MnI/9VBIWTKmf8JDdhgWEzdO5amEwRiJos/kPEqkb03Kt+8qK/0b62sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(31686004)(478600001)(6486002)(6666004)(54906003)(2616005)(6506007)(36756003)(31696002)(86362001)(2906002)(66556008)(53546011)(66946007)(186003)(26005)(6512007)(82960400001)(38100700002)(83380400001)(316002)(66476007)(6916009)(4326008)(5660300002)(41300700001)(7416002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHFURVkvazFxN1RwRHo4RGFPelFqWXZJdGg1a1d3MXh1VmlGVEliRE5FeSt0?=
 =?utf-8?B?cS9WdUR1ZHliQlZnVFd6akNDeXpxMDUvclA3VW5iU3l1eU9mL2prTE9waUJz?=
 =?utf-8?B?T0RDOVp1QllmcGt2aW9iYktUd0h2N3ZvTlp2ZXRDMFd0a1ZaZUtFaExDOWxK?=
 =?utf-8?B?TEZCRzlodFBUUUdySk1tRkQ2SE9iV0VPVDZvbytURVhOV1p5R2NDQkRjTXhp?=
 =?utf-8?B?MTRHQTdKanNNVGZLUWxzVlFUVHhnQnZjYW41VEtlYVNYQllUMW8xaUVCclNC?=
 =?utf-8?B?WnI0VVRwT1FlcVoraFRxbnYvd3FaaVlXVzJsRE0xZkZXZ1pYdEEzbHFFeS9S?=
 =?utf-8?B?Tk54NHc3TkxXaEw3QkNOM211dmJ2ZlBZTm5nckRsYThoR092RWZvL0FEVytZ?=
 =?utf-8?B?WmZWMEpPUHZtS1ZDUWJxbTY3dW1NcitBSFpld1ZGNEp6b1pCSjlSclIrTDBt?=
 =?utf-8?B?UmRRR2l4WE42bUNZb0Q1WGhmaXdMeVRMOGpHa0l0ZXROZzlodXI5YTFCSzlv?=
 =?utf-8?B?TVpIR2UrTWZvWTM3VkloOGE0ZVcySG9sZS9UK1MzeWRXUGlVRHdkVW1IN3Ew?=
 =?utf-8?B?WmVsdGh1ZlZKUzd6Tm5NeW1BeXRaR213SkIxNDBMWFVBcXRoYnF2QjhlOGt6?=
 =?utf-8?B?anVYNDlZZFNsWmloWEh5NTNiRW5CYVpheVAvTjNCVkNWVGxkblBtdVJDaXJI?=
 =?utf-8?B?OVJ4Yi85dnBlSU9BVUVnUUZ1Q2IzclVJL1NEQWNoS1drQm9WRkVhMkVvc1hU?=
 =?utf-8?B?ZHBvU3l3TW5wRXhZRWFObUhQd1l2MkJWcWltY1ZhSzJJTW5meXJSckVhOEZJ?=
 =?utf-8?B?UzV0ekJvTXozTStCS2J3Zi91b05WOGN1MEc1OUVvN0U4eW5oTFhLZ2V2d0ZK?=
 =?utf-8?B?dmh4ZFk1UlVQRDVwczBKR3ZnQzJ1QmgxZzZ2U3BJVUs1cVpDR2F0Z3pkdzdH?=
 =?utf-8?B?b1JwZGxpNGJlOWhZV0Q3MDV1NklFRnlodXJFd2dWOWR2Um9XWWpXS21TZmtR?=
 =?utf-8?B?WEVzZnVqalpLekRnb28wamZVamhUZlU0ZFZRMkxoYkhWUjZMRkx4dEx1RnZI?=
 =?utf-8?B?UnVsUS9BZnRKUUh6bkNRSlNrem0rZkJ6ZGNVcEpjNExKOUp5RzNIQmwrWG92?=
 =?utf-8?B?MXdWOWhKdHdhcUVMZEtPdkRQc2hYQ21NbTF6SW04aTVwaTZaalJqRUg0T1dp?=
 =?utf-8?B?YndVeHU5NXJXUHNOTnpmTVNlNEUwbDZzSmJ4eEhzb0xrcDkrbnJ3ME1XWnBQ?=
 =?utf-8?B?MUlGcWNyc3NHSjFrMWtocmR0cWFJZGIrL3RHRTFiaDhUbnFzOWh2RDFPQzhZ?=
 =?utf-8?B?NGsxcXVKdjNXR3U0ZlY4NDh6Mnc3TGpFbmlxVjRxaml3MTNpeXlHUkE5cmhH?=
 =?utf-8?B?eTJZbFFwK1ZnYzY0T3pxajY5Z2g1dXRtRXpHWkFUMDRheG1xcGIvd3hJdm5E?=
 =?utf-8?B?emk2blhWODBRTFlIUXlKUTc0YmFMSHF6WGp6Y2xYU1prY1VYQnVPd2tKckxa?=
 =?utf-8?B?MnJvb0U0WHg0Q2xPRURGS29yYldxQmdWcjMxV0JiajI0T0hSZmhjbG1TZWxM?=
 =?utf-8?B?WTZ3b2FJb01hbHgyM1NxS2hNMlZQazJBeHduekh0Rm5BaU04QXB5bEd6Lzdi?=
 =?utf-8?B?YStINUNUWHBIU1ZPVnhvak5WSG85cy9LQXJVKzJ6KzM5Qm9WeU1OSG9FTi9Q?=
 =?utf-8?B?Sjh4QVdoSVFQYkFFUk5mc3pGWWtsaHFUR0prKzMvUUlFMzRZSkdQRENrM3JR?=
 =?utf-8?B?SEo5ZmpkNDdEQm56THZjSFF5bXRrVGgzN3ZoT3NmMFJ2Zy9SSFNoancxaS91?=
 =?utf-8?B?SW9LUi81ZW05bU5xUXh0ZWYxNlVLTjR1UFh2Z3V6S2dBYXloUXkzU0VIMmRw?=
 =?utf-8?B?QUpaU1hPeXpPeHBlN0g2MEtySDRhSXgwajBHMnF5Zk1jWWtuWTl3V0JCWlZ2?=
 =?utf-8?B?Vlc3Tk5lODF4bFR6SVN6MGt3QVM4VTRZUHBiTW5wUXA3UnpTc1VrTEVKS1Ni?=
 =?utf-8?B?RXErSGllZFU2c0xFcTE2UVNINm1qbTNwSkJvM2Zpb3ZtNU5UQUVRNlRKR1pa?=
 =?utf-8?B?Snk3cmV3cVYvOEd6QlFsbEc1WUJZWFBMOWwzQWdhdGExM1RQRHY0NXJ5T0wv?=
 =?utf-8?B?U0ZzTWJVOHBXYWdQTXljYTJtcHUrRFVKOVpTMnZyZTc4a2gxbVc1NnE2UGZH?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb823cc-90f6-49b0-05fa-08db7e409475
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:46:44.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T85XFS/zc1T2fi1PIVHW1oiS047Bxilk3z/czMcr95RgwOc8HhD9VWZwvw3Wm0PKSDVjiu+ASR8ws+xALB6bja8KnuJ9/f0QfJtgvhXZ+N4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7930
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 6 Jul 2023 07:47:03 -0700

> On Wed, Jul 5, 2023 at 8:57 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> As an intermediate step, remove all page splitting/recyclig code. Just
> 
> Spelling issue: "recycling"

checkpatch w/codespell didn't catch this one =\

> 
>> always allocate a new page and don't touch its refcount, so that it gets
>> freed by the core stack later.
>> Same for the "in-place" recycling, i.e. when an unused buffer gets
>> assigned to a first needs-refilling descriptor. In some cases, this
>> was leading to moving up to 63 &iavf_rx_buf structures around the ring
>> on a per-field basis -- not something wanted on hotpath.
>> The change allows to greatly simplify certain parts of the code:

[...]

>> @@ -1317,21 +1200,10 @@ static void iavf_put_rx_buffer(struct iavf_ring *rx_ring,
>>         if (!rx_buffer)
>>                 return;
>>
>> -       if (iavf_can_reuse_rx_page(rx_buffer)) {
>> -               /* hand second half of page back to the ring */
>> -               iavf_reuse_rx_page(rx_ring, rx_buffer);
>> -               rx_ring->rx_stats.page_reuse_count++;
>> -       } else {
>> -               /* we are not reusing the buffer so unmap it */
>> -               dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
>> -                                    iavf_rx_pg_size(rx_ring),
>> -                                    DMA_FROM_DEVICE, IAVF_RX_DMA_ATTR);
>> -               __page_frag_cache_drain(rx_buffer->page,
>> -                                       rx_buffer->pagecnt_bias);
>> -       }
>> -
>> -       /* clear contents of buffer_info */
>> -       rx_buffer->page = NULL;
>> +       /* we are not reusing the buffer so unmap it */
>> +       dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
>> +                            iavf_rx_pg_size(rx_ring),
>> +                            DMA_FROM_DEVICE, IAVF_RX_DMA_ATTR);
> 
> Rather than reorder all this I would just do the dma_unmap_page_attrs
> and then leave the assignment of NULL to rx_buffer->page. It should
> make this a bit easier to clean up the code below.
> 
>>  }
>>
>>  /**
>> @@ -1431,15 +1303,18 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
>>                 else
>>                         skb = iavf_build_skb(rx_ring, rx_buffer, size);
>>
>> +               iavf_put_rx_buffer(rx_ring, rx_buffer);
>> +
> 
> This should stay below where it was.

Wait-wait-wait.

if (!skb) break breaks the loop. put_rx_buffer() unmaps the page.
So in order to do the first, you need to do the second to avoid leaks.
Or you meant "why unmapping and freeing if we fail, just leave it in
place"? To make it easier to switch to Page Pool.

> 
>>                 /* exit if we failed to retrieve a buffer */
>>                 if (!skb) {
>>                         rx_ring->rx_stats.alloc_buff_failed++;
>> -                       if (rx_buffer && size)
>> -                               rx_buffer->pagecnt_bias++;
>> +                       __free_pages(rx_buffer->page,
>> +                                    iavf_rx_pg_order(rx_ring));
>> +                       rx_buffer->page = NULL;
>>                         break;
>>                 }
> 
> This code was undoing the iavf_get_rx_buffer decrement of pagecnt_bias
> and then bailing since we have halted forward progress due to an skb
> allocation failure. As such we should just be removing the if
> statement and the increment of pagecnt_bias.
> 
>>
>> -               iavf_put_rx_buffer(rx_ring, rx_buffer);
>> +               rx_buffer->page = NULL;
>>                 cleaned_count++;
>>
>>                 if (iavf_is_non_eop(rx_ring, rx_desc, skb))
> 
> If iavf_put_rx_buffer just does the unmap and assignment of NULL then
> it could just be left here as is.

I guess those two are tied with the one above.

[...]

Thanks,
Olek
