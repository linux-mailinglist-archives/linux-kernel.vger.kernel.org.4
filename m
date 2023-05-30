Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF5271709C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjE3WTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjE3WT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:19:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D4693;
        Tue, 30 May 2023 15:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685485167; x=1717021167;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=sF+nBJTmMK/dEsLpdnnMiT2FiolJrKZxKb1UxPKyR+c=;
  b=W8YZakodnhSujTBXmS4xDhzEULMJxC9R3iq9qqKsCrz99QcHV/o97dMz
   6ILD0FSoH8hRO/ptLBwPfBCD4+tTni0MZBYUYonURDpeK1Xu2iwluw2jz
   IbOEejGxtW5f+ymuM1quEEBWGwhORKjeSXLOEB92KREkF9HdQt5AovQb6
   b4rsbX0L5YIEUSTOvO0c/FxhTPk30z73aM0TABDtjvptl4KE6JwuW57O6
   6rNvqqhwMM8/cDvvSya9GebXm6Gd4syUVZvEtpegDmioKlFjIjBfRu5FZ
   Rh/s8XS9EzUsEHkcZeONAWxxCB25AH+s6o5rJPifVFf+jHSgs1H3fKA05
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="339651871"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="339651871"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 15:19:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="657046356"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="657046356"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 30 May 2023 15:19:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 15:19:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 15:19:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 15:19:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt7FBYa+XTC5c6hDCCoG3IDHoba+4Re5uTuh2GLWArTitAUTsFr0vw5WNFHWYuc1iJfNeKERUKl4pXBKRjbyhXVKh8oVYZiVz1MQxOx/lcnlKsr7OYytQqFl/iNofzCrYkpOgUZpazEPvG8JlW0oIqu5sHJqFa2+NZLf084afiAtcKmL4KWmSfCUBmSmJo3QAWvRvcTQ3Huzn5+IRU5rRcyHuZPAx3dT0ZQ0yr87edd0JoIduQKM7KBpamsnleAq1w6Kw/Vnvfl+HjAfckGQZna6hElDmsbTRnvBKKGUm85sPUf1f441Q3ojW6j425zNvXt5EV1ckuhnV1wENSSSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjB+j6m4CkO/6NI2kgCdtjFLBoa2NGyBMj6iJDz/6RI=;
 b=SuJIdMAgIuOakXh7JdiGVnaE4hx0XsMf0G7pu/ezDNZEyg0g7Z90VRixhv+Dkxtm2497of3/QYBSylQdNVkdv4jlpewE3ydh8K8/hCEeiEz8jCVjhJrZ4NCiwL5QtspCFclakb90IOpayn5a53rPXjK3LtquDp6eKmQJa0HWMP0malb0CH3BtZiKlKHpe3me+gbGu5PKNcC6owZs0DkXhb5lnXm8SbijIoq1DXQm1Hpj3fPzx2zrCjUBiXprlklnFnASsjbBwKpmdkUR3W72j5rn+uFDw2AqKlgka72qNIpM7O/kab04Yf9PoClz2iyV0k3exINSeVscGJGN7VcnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6409.namprd11.prod.outlook.com (2603:10b6:208:3b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 22:19:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 22:19:23 +0000
Date:   Tue, 30 May 2023 15:19:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Sedat Dilek <sedat.dilek@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <mcgrof@kernel.org>
Subject: Re: Revert "module: error out early on concurrent load of the same
 module file"
Message-ID: <64767669744d4_168e29489@dwillia2-xfh.jf.intel.com.notmuch>
References: <CA+icZUVZSBx-=Sm8ZM12dWY4hmpnfDdhmg6UwXsR4OLSgPXY2w@mail.gmail.com>
 <64766df07f013_e067a29410@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=whWJFw8+HP=0-ZaQYq2VVPtv1StFhUxgiJW1_FWdtgJSA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whWJFw8+HP=0-ZaQYq2VVPtv1StFhUxgiJW1_FWdtgJSA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ea0020-8fbf-4822-19f4-08db615bec22
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESEvEnPEYt8lbFJz1+jIjUesExq1sjHUqgIMVE/9PFy5OMVrk/pjNzpdAu9qYBX9mllYNCxDxXOmooZQYVk+qQoHB3DfAJVLLjcolUNYd1wYM6lp9XxRvAwFr7I6knksNRbSujh1ZYnJe8hThmf93LO0GFhJyLSlwUPlH6n6S/ogIqiy0OjTK1JDvK2fr5KkO/xTrloj19Z/8oe85ZvaJjNMJYcbZ7P0WOidBXp5l9+90oabXDBXT0yxwH5KGVo10eQvglRu/LgpV7ye5lI5P9fKTUvJHRCBCkK25yhhw70NX64SYUwz83D/dxO70wF5Wd8rvUtCDuMIfM8A0+/I5hpkLxIazQYZ9pxIbl4YtiD1CTniibtloTZjy+zu7QSPm4jiCqtFXEV1cIbnCrJ/+8L9WSPzDaIxB2MEC3rCHbqehZ23n9PedemBaqSU+46FxGSKSt5lATqzW8wpDJ/B6aCR8dQy4SnmnkCgfuhT9oY92hzcnnIdbsfE0Mlr6Hwos6GEGT+RSBj2CMFmgoSGHSiFUyIJ+kCBFSTJu+NOpgckIKUWrYcUhHZq/faxkrT9pSnJpN9nrxz/GaAPQWfEqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(966005)(186003)(38100700002)(41300700001)(83380400001)(53546011)(9686003)(6512007)(26005)(6506007)(6486002)(478600001)(8676002)(54906003)(110136005)(66946007)(66476007)(4326008)(82960400001)(316002)(8936002)(66556008)(5660300002)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekI1QU55bVVlZWlGUzRHT1JZdnI0UjN1UHFZTU1yMDRmU2txMHdhKzBrTUFn?=
 =?utf-8?B?Tm9wdlNaTCsrZW1SYzJyTXU1R2c3Qm16b1F6dEZoR2RSa2pYbTRheGNlYXZQ?=
 =?utf-8?B?RXVqTlBkZlZZYVgxMWVXdUU4dWx2WENyMGo1QS95VGZVbmZaaHE5QmxTTFh2?=
 =?utf-8?B?NHdkc3RtMGo4TmJIOVhteU5aaGJhYXdEUEI0ZUJHMkt4c0NSMEZPTmF4K2ZG?=
 =?utf-8?B?MTNKRWFNWTJkMGZkMXl4c2tGN2RWNXFOOFA5d1oxYWs3bkYrNGhNcVFySVRY?=
 =?utf-8?B?ekRYNDluanF2SUprSUxwbkhZT2JkMUhEWkFUZDVHRDE1Y3E3K0ZPUTN5RS91?=
 =?utf-8?B?U3FUWXRGR2Yxd3VFU3FPQkU1UDVVaWQ1TExWUFdQdm1vV3QwT21WMXZQdHN4?=
 =?utf-8?B?UkU5TDArMS9IWm93K0hvdGtLSU9YMit0RVk2NWt5eU1GKy80b3RmaG9YYkVi?=
 =?utf-8?B?Zm5CVnhnSCtlMTJnWXV5ejdJU3lGOGthMU5maG1vKy9XZDk5NzJOTUhHL0g0?=
 =?utf-8?B?N1B3K21tblRCYi9ZSFk0SXRpMDlyTXdZY0RpQ25lQXgvVDBMYW9BWGwrWERt?=
 =?utf-8?B?eFpiWFBNdDJpRS94SVRFK1FFL01xaUZHaWlnSWpuWDNPWnFsYk9tb2lycWRD?=
 =?utf-8?B?L3ZjZnRkME5KRDF3ejNidjZwSjJXNjVBanRNWENmejNuZGQ5VjlDa3RMSjZB?=
 =?utf-8?B?cGRMMVpGbHA2YXZJU0hnM3J1TFhWcTRyVHNLR29iZFJIeU1rK0NiV0h1Wi9C?=
 =?utf-8?B?cW5NdTBlVzl1RjJ6MUxuVGJLREM3dDBQYTg1VU83cUdQd3diUUpjSDNQK0Z3?=
 =?utf-8?B?cS9IM2NPZEdGYStWOTRHUExTb0JNTk9OdGFjK0FnMnh2MnRGMGlNNnkydkFv?=
 =?utf-8?B?ckM1Ui94MlVWMjJTWUc4Vk15NHU1OHFvTUdYZS8raW9IeEI3b1h2NG9nMlRH?=
 =?utf-8?B?b0VydWVDck04UFZ0R2tzOHN3UkgxbDJQM041MVROOUE2MGtJbzRVUWdWVURh?=
 =?utf-8?B?aStlY2JlektkMHoxS0x1dG5vRnFmd3dqV2RCYzRscUFVZnlSTGNjclBBakxN?=
 =?utf-8?B?RkF3eWdnMWExWlkyMlFQMTcvVllBY3dZSWJGbUdNcGE0TFduenpVd2ZBUGwx?=
 =?utf-8?B?TDFKb2RZYlRxTVRQc0QrcGtHclJjNWpENXcycWZKUGhrTHFMaXBVeENnbTJM?=
 =?utf-8?B?ZWZsbzBWdnQ3OFRwQUlzdXJwMmpTL09STTduc05xdEh3T055azFkUmdIbWJC?=
 =?utf-8?B?UktBTVZWa0hzY2k2REt0VFljRmZEcy9XV1R0VlUrQlB4d3hpT1g2UWlIK0c5?=
 =?utf-8?B?YnJsV3F4eHJlUGd2aHkxYlpDWFpHUGE1Vmg2WVVlQ0xXS2E3VE1iU1VIWDRB?=
 =?utf-8?B?cmtyY1NFNkM1RytteXhaQ1JyUzk5V3I3eXUzRnVrZ0t3ang2bVl3eXNseXNm?=
 =?utf-8?B?ZUMxcDUrcDcrOFRRengzUmk2eGJwbEJTS2V2ZXpGZ0ZEOFN5M0tmajFWaUFx?=
 =?utf-8?B?V1d3dWV4MDlJOWxxS1NjUHc2N3Zoei9TNWMzWENodGxoeENTaTIyVHVZM3Q4?=
 =?utf-8?B?WWdxeFpvdmhBTWJ5eDdEVkxhbnhyUGlQTEphaXBSZSs1KzB6bmpMSEN4V3ln?=
 =?utf-8?B?Nm9XTWlveXpOZHpLMklmT3MrV21ZeUdoYUpTbVl2MVFuZDVsclFESFF5OUtV?=
 =?utf-8?B?TURaR1YyRFdDVk1jcE5rUjhBWCtiWkFNTTd5cmYwMjFlZzF6SDR5UVRZblo1?=
 =?utf-8?B?RFV4dkRMTG1oaWliMUJQeVpybFN5ZmhEZ1k2RUVuL0Ryei84RFNaWmlHYnJP?=
 =?utf-8?B?SU43b0tmNUg0R250T2k1YjVONTBCazk4bkRsUU8vM0hMcTlqUTFBclRTdUQz?=
 =?utf-8?B?bjFQU2N1ZWZMeHJWMlRUTnhMQ0JqQVAxcEw1ZVhkTFBzTGZRa1ZQdnlsVUxh?=
 =?utf-8?B?SjZ6NFZ1UmVwQmVSRTFvTFlwRUVGaWdrajJveUlZRmhEMHc0aXo0TUo5dUFO?=
 =?utf-8?B?MXVBZ1BNOHROcnNrY0E4T0Z4aFA1R1JtM0JFaXpiQjB6YWMzWXR5R3grZmVy?=
 =?utf-8?B?eisxVGw3TEtkQ0RFUityN3JDWVUxOFRSUDlMTnBOajZlakRwaUZtSEhvN0lZ?=
 =?utf-8?B?aHpBNnRlUHB6VTdEZmJMMGRXdG5kMTV5Q2xYKytUcWxOK3ZFa0s3UFlJL1lP?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ea0020-8fbf-4822-19f4-08db615bec22
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 22:19:23.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plseVweChUBlR1AWzJFqA+jOzrrPLH8dJfI5KtLMK/uPcsZ1VLgsDbyE/rspkXfW85sGL+lPQk2jycFEYRewRbgcc51fVURPeb9C9tfzLMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6409
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Tue, May 30, 2023 at 5:43 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > [ add linux-cxl ]
> >
> > Sedat Dilek wrote:
> > > Hi,
> > >
> > > after building Linux v6.4-rc4 I can NOT boot into my Debian GNU/Linux
> > > AMD64 system with root-ext4 (/dev/sdc2 - of course using UUID in
> > > /etc/fstab).
> >
> > I did not find a mailing-list thread for "9828ed3f695a module: error out early
> > on concurrent load of the same module file", so replying here.
> 
> It is this thread:
> 
>    https://lore.kernel.org/lkml/20230524213620.3509138-1-mcgrof@kernel.org/
> 
> which initially proposed a different solution, then that "just reject
> concurrent loads", and after that caused problems, there's yet another
> proposal at
> 
>    https://lore.kernel.org/lkml/CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com/
> 
> although if you want to try out that approach, Johan pointed out a
> missing initialization of a spinlock in that patch in a reply there.
> 
> > Just wanted to highlight this a test case for the next attempt at this
> > fix.
> 
> See above: the next attempt won't be until 6.5, but if you saw the
> failure on your test-cases, it might be a good idea to check out that
> next attempt early..

Thanks, will check those out.

I know that the "Link:" for "mailing-list thread where patch originated"
is mostly useless information [1], but when it comes to quickly reporting
test results on the output of "git bisect", it comes in handy.

[1]: https://lore.kernel.org/all/CAHk-=wgzRUT1fBpuz3xcN+YdsX0SxqOzHWRtj0ReHpUBb5TKbA@mail.gmail.com/
