Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9A37259B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbjFGJLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbjFGJL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:11:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFB21721;
        Wed,  7 Jun 2023 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686129024; x=1717665024;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=YnMwPEm/rUF2+0Jby6+PZMeXSxC+XfHpvoO6OEfrodc=;
  b=Z+aklqBg8RBwsvjhv5lvtcqrBXhnHv+DLjc/VdVw0iHEo9GlZfG2JOG2
   IAbjayq3ifDxC2Js/ndRjx86H3rTsPICXkbX/dZUN++elYUgBjzfUVkIv
   sDQzD+ggONnE1+QY2O7Zs36XdHhPose7WrqfMWG304V+I1gibH8nOUVtY
   jSZU8B7I4/JwhtGMhWTegg3pxXCvQqOkYu+VxAZmGT3fUShAtuat+p4w2
   jptId/6qh1cwCqSm4arS7qiL1glXzpe0hIaQAUAZsHgfxOCfL1vwKhmvv
   pCWm2gah4RWICKWaWS5zY80z6NFQIbamDwpmwm/zTVnGKdWsIZgsrFXOb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="443300146"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="443300146"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 02:10:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="822029370"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="822029370"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2023 02:10:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 02:10:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 02:10:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 02:10:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us6UeZfI3Z/9kMrtPKR/5F8rz41mdWE3ObW8jcCz2TJaOkhmyLRFvo7dPX7QtNdipW7eBCTMFWFtxkK0AtLgL12Jm1kXM1vgreEy553/QbLdRTnAqsNziAmexnjtzOmQtzDspTY4QKNlAlk8sd7pjCsJa2Dn1fJ3Fgy0cvYSKf/I6KpTD/PpJI7FV65uR72P9DV4IxXugT9BVednoRsa8KXki4jKYbZUWc4Zgdw+aZVX4GcBHT30UcmOOVSlLfvr9Iufu+U2SxNqz7rd7giiMdGX9bTLkg6sQ12n2fb/1kbbgYuW3xTi/7gxpmZVrpymZKrI68c+GmGOgQndxnR9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEDFRgApjImX+I5MvwRh0DJcEzLVKcQFzgBeMyJlBNc=;
 b=N9XcTzstFOsF0EHhMmqt1LoKZ/xT+pn4dfVvA+5Wu0izN8JQwdByjWfpfRHjPYQLnrK612kpMTwyBKYmWkvqlpzU/WLITQqtQPJjiI81DgoJHCImNmUgFdIuq3ZucInWLYK9LDOPg9c0J4MIxrMhEYc49Ef6h8BvAcp7Hv542tw2fkhdonleE5FKkEnO80DixddVLbEKDpunON30MY0qqKAItwwGR2Q48tj0tzG7dWl7Jfu0CqryH4Ti3pFtHfLBX2X20qQLQfUhOv44b+hTogBY4YEGb0PAh4NWObHuMnnjCxKBbZO64ALLG6KDlQRPdPwObkwrFgDLhzgq3UxOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SN7PR11MB6874.namprd11.prod.outlook.com (2603:10b6:806:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 09:10:14 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d549:ec18:45ca:2786]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d549:ec18:45ca:2786%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 09:10:13 +0000
Date:   Wed, 7 Jun 2023 17:10:01 +0800
From:   Philip Li <philip.li@intel.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        "Maxim Krasnyansky" <maxk@qti.qualcomm.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: Reported-by/Closes tag for uncommitted issues (was: Re: [PATCH
 v2] uml: Replace strlcpy with strscpy)
Message-ID: <ZIBJadzmheKWCErq@rli9-mobl>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
 <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
 <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
 <20230607042340.GA941@sol.localdomain>
 <57443d420183b7a0bcab8041c2dfe3ba44e054f4.camel@sipsolutions.net>
 <2092891129.3692555.1686126895090.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2092891129.3692555.1686126895090.JavaMail.zimbra@nod.at>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SN7PR11MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1712b2-1141-4251-7a55-08db67370094
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYdgJJF1NAujKbOXw+flECvLFG58JvwWCdPrRDwmAuKs1aqYl52AlXvICa0uWTpdP6dKLy1ZtynZIrIKWSaySycS3Cgy+IKlDObgT1KMOYqM7r+k0zv+71gykDo3kV/SYfKEsOYEFfJodhZFhzVlYvq+0Okwdao7W7CRpul8WVw5N9blvFv+guTy4x74BxeiDPZkbWttaLIPi5fbO6jWrGkjhbNwgdSTVItHXVG+CiKJh59nAP073BMirfYF8DrUEolx9kvUoC0bAWjpWf4KegvxJ7TvZ/MMBNeSGTRFGsG4Ds6CVZOZzgAURgZyYAFzwlrcdpQh1zjpWgZRWzladqw35cWBolHAz55VqzpqmYJEF8Ml/XmkmsjARG2biZGB7MJb50zxPyrXIhzZCWb8NOGTQS2kHTZdoTlm11G9mIe83hDYvb641cYT2Z6z2TWL+lxmQihb+T+kRjXJ5ikMY+5wpSkhvEHc8RtKoHk0GubJiiSYIR7SWA1cyKllDxJ3Kw9oZGibyZm0puw4yk73g2QU5Swn0dd+BnT7dQ3ztcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(66476007)(478600001)(66946007)(6916009)(316002)(2906002)(8936002)(41300700001)(4326008)(8676002)(44832011)(54906003)(66556008)(6666004)(6486002)(5660300002)(7416002)(26005)(6506007)(107886003)(9686003)(966005)(6512007)(33716001)(82960400001)(38100700002)(186003)(66574015)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?z5zTppJKX1SycvwQOu8XDTlrpbRIWmp1uCRtvjhoQIxvFnS8MZVlx+uJPr?=
 =?iso-8859-1?Q?lH6p0VwP4XeGwIDIVyqoDmOd7F+fKLysJIqCENgTfw4wRd8bkKU/4dPu+D?=
 =?iso-8859-1?Q?FSqYB27qA9/JsI8ZCPDHqFNqeVLsCtA/Dn+AWQ+HiTbkJQjF551mVV1MkI?=
 =?iso-8859-1?Q?9hAW3JfQU0vmXwt30MPNnPcWojTkOq2w1jQAJ17fbHczRCfdOFOmSEsUow?=
 =?iso-8859-1?Q?oj8p4wo6y6YdJlcn6w4NYAyUMFhq/GEfIoAOBnTejGvfGY7qjcWYXBUn7Y?=
 =?iso-8859-1?Q?Smd7De275lcmTg7Qp6MEgyLDIiOvDDa5T7E1s3snFd9mB1h/Kp5XR5aqGl?=
 =?iso-8859-1?Q?Wuop8aDpJI+R8fk8HwTze0/P9aD3TYD52Cktmg9us9PLa4V9fPxJ3P9rwu?=
 =?iso-8859-1?Q?D4h09sTwp6K5lI9WfdEaAK07cilfPYrTAkNvZn9EWROyfKXl429MLNDehI?=
 =?iso-8859-1?Q?pgYWZ1nvgbc9tM391oJfX9Z/EDtHmCPUcNE5KBO8iRZ0SHOsUl3KPseVg5?=
 =?iso-8859-1?Q?ZyGHGp6iKrEqCCTMcuxsIEwav1ZmP+gKFDiTZSRKskG2vW/m46ifMawTzr?=
 =?iso-8859-1?Q?l3Ks9vM8iwQYy7YyyMO/AYzT6bb5jt9awlvU2mGaVdoJbeWhyvVZCFogoc?=
 =?iso-8859-1?Q?1Eo10/EYsMiwQ9UfGuIQcn1CqZgMbW1uoZJ9P494rFb8TMnlLQn9Oma0Ih?=
 =?iso-8859-1?Q?x+nAClyNwME+rLIYrvUIBPiCxgdUNsbujyHkVNcrorXYbMkc8yRbfLmgmz?=
 =?iso-8859-1?Q?u0xqxlUAWgWj+klLrvb0TTv65j9Hpng2nRUxpGG2k7taz51LWsBN7pT+y6?=
 =?iso-8859-1?Q?DtLO8/RG7uasGKR+3cWcpep1p01l+IVYLGe8HYHoqVvV5l2jISknbP17GR?=
 =?iso-8859-1?Q?D9XqNImbMbIl2x0dAXUczE9uriA9xrzWONrm1FDOxFux1viXgLaqe6P89n?=
 =?iso-8859-1?Q?9R4cp8civcql/HgAYZdXIIAWnTNHczaqm2zydGMwX2TcWeDT0FH7eLRbjl?=
 =?iso-8859-1?Q?w6pN8RsDksVbvmnmu4e2235LwDf0XTvnus+0XbXaybwrfWdYY5MhoX85vj?=
 =?iso-8859-1?Q?s8Yhl9OwfHj5aEMIexObqVuOBzV6rMAkRl9d1n9berU3Ymei3Fvv3ddjCx?=
 =?iso-8859-1?Q?rCiznpLnokgHvCwXxENqoPfLCONs2ytavJ4HF/SXhUBN3kOTUlpLuZdXh5?=
 =?iso-8859-1?Q?IGLt2F2owRRghHcW6si7T38zUgy0tfhC9gfkNyfq+bHmczYtU2ELXWoRu7?=
 =?iso-8859-1?Q?9jwutIpsBTG/uC2iItNrZA4/0FbpHEy7C2UFMHwtUDcVnkl30UMfc/rYKh?=
 =?iso-8859-1?Q?RrYR1NlyYww3S/l+9pX5BLoy6RvyD8PIYomtLBBTNrqYtZ16GLZFzlSMV2?=
 =?iso-8859-1?Q?sv6sJ+tfe6CLEOFIEYgd59HQu3nSRrMiKeW9oCEB1aooNggzV0xwcJ/INd?=
 =?iso-8859-1?Q?KD+LI455OKIl0E8GKFTbu46QrXhxmpb/y1k4kcDayex56ZMky2tSxGEy2Z?=
 =?iso-8859-1?Q?7DbOzooWSCXd/Wd+uuMkd96V/NnId8lDpbcRzVmGfYuUvEH7T95ZFB9v1I?=
 =?iso-8859-1?Q?zaIiLGI6195FOHYjkPSXTS3xP4iAC4TKMbtxUTWexBxljrcLLNgc/6pKFv?=
 =?iso-8859-1?Q?8v35StvjQpr3pgOlZ/7dwKakZ18sJFFeUA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1712b2-1141-4251-7a55-08db67370094
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 09:10:13.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsCILSVXpIO8O2ygrRTsZmAv4QdASEkaVFWHVLAp064Xsodov8aB8ZtErIw0IudeAPYK6XD2T8/0JH0Z9Pg5bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6874
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:34:55AM +0200, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "Johannes Berg" <johannes@sipsolutions.net>
> > On Tue, 2023-06-06 at 21:23 -0700, Eric Biggers wrote:
> >> 
> >> > > > Reported-by: kernel test robot <lkp@intel.com>
> >> > > > Closes:
> >> > > > https://lore.kernel.org/oe-kbuild-all/202305311135.zGMT1gYR-lkp@intel.com/
> >> > > 
> >> > > Are you sure Reported-by and Closes make sense?
> >> > > AFAIK the report was only on your first patch and nothing against upstream.
> >> > > So stating this in the updated patch is in vain.
> >> > 
> >> > I left the metadata in only for the sake of posterity. If it's not
> >> > helpful, I'm ok with removing it.
> >> > 
> >> 
> >> IMO using Reported-by in cases like this is harmful, as it makes commits seem
> >> like bug fixes when they are not.
> > 
> > I've yet to see anyone disagree with that, and yet, the robot actively
> > asks for such tags to be included in patch resubmissions.
> > 
> > On the one hand, I can understand their desire to be recognised for
> > their efforts. At this point then we might suggest that we introduce a
> > different tag, say "Improved-by:" or "Issues-found-by:" or something.
> 
> Robots don't have feelings. No need to worry. ;-)
>  
> > On the other hand, I don't feel like we should give a robot more
> > recognition than we give _people_ reviewing, and we currently really
> > only recognise them by a Reviewed-by tag. Then again, that doesn't work
> > with the robot - it is pretty much looking at each patch and only
> > comments on a small fraction. We also really don't want it to comment on
> > each and every patch ...
> > 
> > 
> > So it seems we should ask the robot maintainers to just stop suggesting
> > those tags?
> 
> Agreed.

Thanks all for the feedback. We will carefully consider how to present the
suggestion clearly.

For now, because the bot covers both upstream and developer repos, there
can be various situations, such as the bug is found in upstream. So the bot
tries to let author decide how to apply the tags in appropriate way that
they feel comfortable.

In the report, we now uses phrases like below

	If you fix the issue, kindly add following tag where applicable
	| Reported-by: kernel test robot <lkp@intel.com>
	| Closes: https://lore.kernel.org/oe-kbuild-all/202305311135.zGMT1gYR-lkp@intel.com/

But this may be not clear enough or not the best way to suggest. We will
consider whether we can detect some situations (like RFC patch) which is
no need for such tags to avoid confusion.

> 
> Thanks,
> //richard
