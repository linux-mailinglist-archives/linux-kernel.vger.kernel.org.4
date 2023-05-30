Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A40F71713B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjE3XFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjE3XF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:05:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3BEE5;
        Tue, 30 May 2023 16:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685487927; x=1717023927;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2dybCHIzJJVlteAuqTW5D12IqD5bq+0ZVcluM38xDTk=;
  b=H0BHRqoPqfBzfDkBk+sE5HBjwQLzI4dAyJgwQ9NaiZFpfn3NP9ra5TPd
   JvO6vcjqxlu+RAmnp8x8t/zYQmwUFLogka/7eMlWlLJgNuZ9xWkUtrmeg
   CLe9Jkg/nmJVk+5O7sT2qgy1VkGptDqS75liqjy/LRn+XPRcM9Yqft7rD
   rnRy3IjrsHTKg554CJF0Rs8kxCR0JAPQpSeGN9XdSFRLzsz8vszNs7xvp
   3WhTRPDBOpdoXJspLUdWMPoSsDel5313e9A49cBmtOARjbmgoLtZ22/O1
   40/QovFI7y2+E4G3FVhFAKs4a9nZcAcU5lxFKNom5EqBzbSsSWZpFTHsu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="418557384"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="418557384"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 16:04:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="771749659"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="771749659"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 30 May 2023 16:04:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 16:04:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 16:04:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 16:04:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JN+BJww9Wp11f87+lmq16DSy8FpMeNixZQcmkIRPIGzJhwSQ3cIR4LTBdx2y69XwrC/VC4SoPeCKkIKeGxuGz0qPk1Yhq26f2FhhtGpb7qcQ5rSv/9Bg3DEgrpZxUGozcQCf95/QtM8RGOKmiGLk2++P7/XXJX9Bw43a1+Wmvo5WH1ZFPwynRA/7hZQlXC8t6xYOI47aqKIz0iyPS3HK7nTkuPiuw6ooGf/ENfiImCmZVoI4v5f3OyjeIwN9raTaGamdpj1zsaxhQhvvP+BFo7T/BYVnw92emT8D1YYE7FmudyI+Iln4rZWVyUo83cO08+nKRazjtTSH/GKJDJX0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncU1VQsbvJxC/531n/BrHWHzJeuOp/dDtrLPcjvGN/k=;
 b=flYd6j64JoZbFz1JPqjGrml+hJ8DYLRAEfSWT7pEm9jR6k5DRFoFVhRrDcq70UNwvvKeviGwAGjrDZgsDso0Gpe9k1dYiKMKRK0ZTjL6QXtGrXXmbn2JkbcYQXEfNiH+i/owTBwHOi7LLU4jLc4+A/GOIWDn+hDkJOsNEzA8M5Ld0PwiLrqq/Yk680RwbThYFVJDdTXN5k/hpmLpDOnJ4QWVtbDve0JE/8IEu3FMyu2Y1SOm8UQj542JA0YPQB79tavnbXf9Sng02CIxaM1W9NxbT+n0LrvgkYtz84kPmh4OSV85yuJH3UBaefUkK2fxJeQ1JEjEHPfQ3mFGEwLiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 23:04:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 23:04:13 +0000
Date:   Tue, 30 May 2023 16:04:11 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Sedat Dilek <sedat.dilek@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <mcgrof@kernel.org>
Subject: Re: Revert "module: error out early on concurrent load of the same
 module file"
Message-ID: <647680eb675cb_1c5f629485@dwillia2-xfh.jf.intel.com.notmuch>
References: <CA+icZUVZSBx-=Sm8ZM12dWY4hmpnfDdhmg6UwXsR4OLSgPXY2w@mail.gmail.com>
 <64766df07f013_e067a29410@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=whWJFw8+HP=0-ZaQYq2VVPtv1StFhUxgiJW1_FWdtgJSA@mail.gmail.com>
 <64767669744d4_168e29489@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=whHjT-KWPjQK8iSaHJa7WX_LuKgZt_iX+jDxRxDD2Zjdg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whHjT-KWPjQK8iSaHJa7WX_LuKgZt_iX+jDxRxDD2Zjdg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0207.namprd05.prod.outlook.com
 (2603:10b6:a03:330::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4904:EE_
X-MS-Office365-Filtering-Correlation-Id: 7139efc0-ab8d-42c0-4688-08db61622f8a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPJaHGkiaWhswMj6u83tzkkeq2grWz/dNKON5Dxy7Tbb+g48SyESjxudmU2YkIHCWljncfM51UscslzZlD+AVniQv7Q/7I3wWiHV/EwL/u64oWVtAuQED0jOlJ53i73GoNsPmzTOTa/LzsU09PMHOom5VmpDKRcpQZ3kaSzMSLgKCb+ODFHtMU6FO0DvS1xCnjvD+iLjX87UoIkpdkyO4Z8fntnZbQ6UqUWhsl6RxAOi+q/4RP45hR/+ZzdQDjl6P1UrAvoP7TVsp7HGJsIA4kIXhxZMUCTmxyp27tT5MHnPwz74dyJIgFVaaj5FBXyVpMux9aIZrYo3s1Qzft/T79SBRcG3Z5Y8Z9Kxdr+NHiQpTXru6XMhaQrr2Fuf9H6cro3+IOQ01fOVSugsbCUOwsExBqZD44/0dUDigWTj6WU1oa2jEYKZlh6/sKVW3S0Xf7OknliTn/232ATXP9MnhNVlacPML89eVlq6EnjK75W5XOcD53zKs3TUOuLRyCO7aUNjIA1XOXLh/J0CzqDy3YssP8cgANe+uFHiXRe/ASQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(186003)(26005)(9686003)(53546011)(6486002)(316002)(6506007)(6512007)(4744005)(2906002)(5660300002)(41300700001)(8676002)(8936002)(966005)(478600001)(82960400001)(38100700002)(4326008)(110136005)(54906003)(86362001)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1Q1aTczOFBmQmZaRGFIYTZWMkREL2hENHoxOU0yM0cwT0JQbitsTG0wd0t0?=
 =?utf-8?B?eFY4SDcrcStUb2tPWkRHcElNckkwWVdqMEpLN1lNNXd6TGloL3dvLzBGUEFD?=
 =?utf-8?B?dWFaNGpibnRrbGhnNy9yK0ZHd3phbUpvb2lPVGpYWVcwNWh2WlRFUi91cEZ4?=
 =?utf-8?B?QnhrSkY5VXdMem5GNTNtRkl4WGdpeTJOY0wzNUo0b1JjY3M1VzRkdGVhcm5D?=
 =?utf-8?B?TENEUHN4Q29oOXRKR0t4bzRHZFBXVlBPT1JhQ0N5bHNrcUhJd2NmNlgrdXA1?=
 =?utf-8?B?T0pidWVZZlVoZVJPM0twZ2YzUnloZ0pqUTl1dHZqNkI0dlJtT1dJY0doSDFW?=
 =?utf-8?B?T1puUzBCZkM1Tys2a3NESDFVeDNvWHYydXJoSDIrUHdKRWdCa1JLQ0JJb3g0?=
 =?utf-8?B?UHFHdmtNb2dwdFBKdnBBaWxvOWE4L01HaEdEZ2o1VTYxYy9kS2RLeENpL1R1?=
 =?utf-8?B?NzU3bEo2RjVkZG1XZko3MHp5M2JXSTFzUVlFMTdRdURXS2dzQlMrSDRER0Qw?=
 =?utf-8?B?VEx6YzZ4WkxESnJQSjJaM29NMnJ2ejExTWtTbWh1cEV2NytQZG91bkl0SU1x?=
 =?utf-8?B?c1Q2WHlPR0hvMm9rQnB2TzlaY0ZZUTBYS1Irb3RKQWpMQ2NVeG5FZ3hmL21P?=
 =?utf-8?B?OFZmVGNZd3JWU3VjSkp3dWlMVGtKaGFrREdtWW5vUDNiSFF3d2JqdW9GMk1j?=
 =?utf-8?B?OTV6aC90ZUFvUWNkclkySkQ1N1hVU3Y5OGJsdFBQamVvTFhpQlZQbkNobFpl?=
 =?utf-8?B?djcwVWtaanhvY0ZVdGo1Z3A1VktuYWdZZndYOVJtWktWSnBtT0FyQ3dYaFNt?=
 =?utf-8?B?SndQWjEyN0d4dFZQd2gxcU0vTVltVHR0Sld1V1Z6Nm04Mi8xQ3NPZnExek1G?=
 =?utf-8?B?OVBiT2Y4N3VzTGZzcGdGZ1FTKzdONXRyZGhJNml0SUpQb0p3cDZqT05pM1No?=
 =?utf-8?B?OGlyWkxranF3VkEzTTZ6dWN0emlpeFlUbjNJclI5cmFwdE5taEdtakdDNWpu?=
 =?utf-8?B?amY1eUFRTG1WS2Z5bk50ckRMR25CcElNQXNMMENUR21nS0NTVE1raHNvWHRN?=
 =?utf-8?B?cHFhNTFtZVoxY0ovQWJFamUzQkhGbmZIbExEcWpRWUFQYVdRNVNGTzZPZTdl?=
 =?utf-8?B?MGdkdmtKQkkvRjNmdTdHYndwaVByTlBHYjRWd3VSZ0tFQi9Ud1Jhci8wWk03?=
 =?utf-8?B?UWRKdVUwOW5zVEJoazl6a1BSU0NXLytoS3VNbGJidUdyNkxrN3laZmc1TUQ0?=
 =?utf-8?B?dkRGcTdMbGM4WG9vVm5EWDE5c2l0dFZzL3phZWVyckVnZkJEQ3A2WVMycWEz?=
 =?utf-8?B?UjJqRDJwbTEvUHJGVFB2MkhsWVhWTzhzZWsxWGREenlaQ1ZEYTRXQXAvVlVl?=
 =?utf-8?B?OFU5MVZWTnhDN0Urd2pqdjRSWHowRjdGelRLcFZpMm5SZTZlNW4ycEZlSkc0?=
 =?utf-8?B?ZjFqNFB1ZlhwbHA5QW9NeTZrdFVqQXhsdHh1bDJwY2p0cVovL3JURTNzb1Ft?=
 =?utf-8?B?dURvOE5TTnhpRzNYaXBSQ2g2eFRNQXlFKzFpQkg1T2ltRUxPWGhLbzk2Yis2?=
 =?utf-8?B?L3BFZk1GaHhTVzRRaDd3b2o5V3hmOVJDYXZ2NzVJbS8vazJ4cStmWU5PK04w?=
 =?utf-8?B?YWdYZ1lBcjFYVTI3eDBnZ1p3SjVVakd2N1d0MjA1MkpPemxXZExBNThzb2NF?=
 =?utf-8?B?YXV0OCsrRjZIb1BXcDdTUzdlNy9MMm8wdDNwcENiWUVidjlPb2xLRmNRV0Vq?=
 =?utf-8?B?aC9naDBSUVZoeHUvb0Y0a0cva3pSTGpKQzlCT3BhMEREdDliUzRuWTBzdUdz?=
 =?utf-8?B?MHJPMWJGaGE3S2NWd2V2MEZpbXlWa1RPWkN4cXZyZ01OcFUwdzAvQ1BXa05P?=
 =?utf-8?B?UzkwSTlGLzdVU3MwVGJZMXk4M2xwQTFwN2R3LzhLMnZxZUE1cExWN0ozSy95?=
 =?utf-8?B?eEpYS2RQSXYzbVAzZDV6MDFEVlJtRmFKRnFqenZseGYvTnRwUU1qQlFPeXg0?=
 =?utf-8?B?cEhJQzBKR3R4cTFsQjZPQjNRaUZYSWVJTnlmWkNnKzVEV0NaOEVSOGZWNFE2?=
 =?utf-8?B?T1J1R1dHckkwNEY1aElYYUc0amV6RDkyaTRnYjlMb2R5QlVxRG9kUWhxRzhw?=
 =?utf-8?B?SklrYkcreGRoaE1DaklzeE9JQ2c4WWZXZlFmNFdFY0tZamhLdHRRdkRrVXpM?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7139efc0-ab8d-42c0-4688-08db61622f8a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 23:04:13.8043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZgDAMUFcdqov0/qQmV4Y5ehLMN1GsDRCl6cNhjDmspGfXLIk3MpBrRa8DnLzeMqJZu3h52+5MSCwr35uAitXBXx0lS6etUy/S6nxoUT2Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4904
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Tue, May 30, 2023 at 6:19 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > I know that the "Link:" for "mailing-list thread where patch originated"
> > is mostly useless information [1], but when it comes to quickly reporting
> > test results on the output of "git bisect", it comes in handy.
> 
> It was literally there in this case. We had multiple links, and you
> may just have been overwhelmed by the pure cornucopia of links.
> 
> In this case is was the third one:
> 
>     Link: https://lore.kernel.org/lkml/ZG%2Fa+nrt4%2FAAUi5z@bombadil.infradead.org/
> [3]
> 
> which linked to that thread.
> 
> It's the links to pure patch submissions that are useless (ie the
> "this is where I sent the patch"). Those lore can find for you
> automatically.
> 
> Links to actual threads with background and test commentary are
> useful, and I add those myself. There were several of them.

Yes, my bad, I was lost in the cornucopia of that thread.
