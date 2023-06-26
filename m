Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93A773E643
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjFZRS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFZRSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:18:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2462D73;
        Mon, 26 Jun 2023 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687799757; x=1719335757;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=URgBwSz4SCx6Df1kIRMu0IALeQa/EfoPXYH2tl3MC6U=;
  b=ezDVKhlwPU8zvQKk9Uf6NghfrAsASb06v13JNYToBHSm0UkRRzEj52Eo
   x/hXxPsPz4C+zvad2oZwApxmZEZtDRcvJ9pF8xV/1NZCx3aqU83+0rZlN
   y9Q7rAeo3lGu8o4e25A+c0jgga1rojal+Q2rAsM5YipvlwOagZPwjg0nC
   QYzDdRiDYcgTqtZ0FRkgKTUnnsBwnM8pLCYrMcuedZFj5mEHY4WHzZGgR
   0p6PU50gPuieLsywbnh65B4K7uZHbh000SFli1xjkerzuDyYiK5Y4vpq3
   ZvW0AHN+kcCH2TTvMVsv3NXAiFabTlknqXIgk5Qspxm6hAqr0p7WdLe03
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="447716748"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="447716748"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 10:08:10 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="751190401"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="751190401"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 26 Jun 2023 10:08:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 10:08:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 10:08:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 10:08:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6haYjBxdqcqKeGrotW2LoJ+DdN16JRtGHTdgIm5JX9QSSeSiq0udxaWmTdkXTFROZR2+cW5c1sYblNrZ3hJgKa7sMh0R30cOITTvw7b8LKzB41MYXo8PYBcbseB+B1mVgjdaz5Ie1kQBgg0Xqejr8J93XDJq8vqhVRCkRm0DURRzLwd1Uyysz+MyuDTDbmSTUeFBifogNaiXpznyyRHbnUAcr8wy9rmka+cfMEHCh5m0px6CxEXOBiCreD5ZZlew11Kd2eH8v3nHEms4Cx2M5GSdxxmXOX3qdn7393PR/p0tk3mWuMSb7dKl4xLSoFVRU/UR3Ux+uQISG6FXjukfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxiOIsmLEP4KlN/qELiHC0nZrikb+1nr9gQMWD8Qn8I=;
 b=fcLzAj59WL8yvPafCSXK13txgZu1KPUNWduB5EixmzG037XuvmhPP+v9CqX6Tng9vE7FGYQd0Y7KW91DZ2KDU/BRPBK84pM5vr596pcICAtAy/cy4ux1++b1o00YrbrKZoylNlT4Qz8uK6i6qhO+yRlczdBplHTyqR23ejB3kN26no9GXfHlK1kIQttNuh3MM0WfeYmsKv8i9ps1NzDqyeUPZHo+GZxj1iOYQ9it1CHmpjicpKdddx4j3lxQMsiW7447pDLrJjl8CB7W+MnRysy9kZCeaynzvdFnPiKRZxm6UEVKyEPcPk5pZiWOiFyK3WsmlBP+lVP5O8FnxouxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MW6PR11MB8438.namprd11.prod.outlook.com (2603:10b6:303:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 17:08:07 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 17:08:07 +0000
Message-ID: <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com>
Date:   Mon, 26 Jun 2023 19:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
To:     Ian Kumlien <ian.kumlien@gmail.com>
CC:     intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
 <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com>
 <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MW6PR11MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: af176095-9cd8-441b-1e44-08db7667e91e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5w7DYXEf8Jim9VZ6pkb6ZPBWmF/HKMn+52gD+P6fhsE1gRQxuW4YjygLbWV0SqRPzPg7PQhQPQkxWca5Sv6cB7AyB+Mz2MI7CV8yt/3bRruDXmqwEoF+NFXotd05TjUNOl/uYvg8uckjQgdk3VJoouSrxRbkoPfo/Qw2nRxUX/RcrXYKI/GlEi9syZGYpFm/vsMk6YrXem/USrmVr7fALTAzLl4JfTrszY60x9T/j85VHIIPlcJgEPkKSTExBUbc/tt44TTHmOahfoGxldhOgUGTtjWkTt2Q3ugBvlYzFtu0rUi63HUUGWf/uTBjWvuFnBgKH1ZN8vYm02oiNr1c+EfGLgCY4m9lo3DB/adF2XXRHZzEp3W4RuexXeIC/+2s1bFwRF7473ajFYWC7xyJusUDC77/XUyCS656Dl2ANFdXk4/kC+jQkQrsTXw5/mzS9kmFU/Tn7F5g10xImn2DQms2kkZay9t4azLru/cfdLS6yDhpzlMgpwL0W9MWONQu4TgpCO+keGVEG0zJ4rC+EEeorFYxbMpfGchCjIAMstPxOXHns0TyxhP/LKr7d52KPWA1lLU+jTHx7joEcZTrAbG1bqjKuo2sLlQEfVwy1mZXPZXtgv+y+byvQ0tPS8wnnrGlyrh7SywPlI2RsALxTi6qtICohTq+HPoOM1Xc8Uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199021)(82960400001)(31686004)(6486002)(6666004)(478600001)(54906003)(2616005)(66574015)(36756003)(86362001)(31696002)(2906002)(66946007)(966005)(41300700001)(186003)(53546011)(6512007)(6506007)(26005)(38100700002)(66476007)(6916009)(4326008)(316002)(66556008)(5660300002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjR4QTBTaldCcVRpRXNtdG5jaHRjSDd2YVdBeU04UG1lM3UrZU9tbFVQSi9q?=
 =?utf-8?B?ZDBSQVdHUzZBWSs5dkYvcW1jNC9jSk4wbmV0Mm5iWi90cUtMRVZWWjNmYTQz?=
 =?utf-8?B?TkcyMEtCU3REeGlMcWFXaDNQdldCSytqTllSdS8wbkFzTmRpOE9yYmxwSUdH?=
 =?utf-8?B?a2x5SkZVdHJjbVVyRVJaYk1iSE5VVjlpTEZvSkhYclJPWDJ5eDZxSTlyTE1w?=
 =?utf-8?B?RWR6UmFHVXYwbTBSM0NVTHJQRVdmRTBJQ2VzK3p0ckZqUXRBUGRVMjVEd081?=
 =?utf-8?B?czF0dlE0NVpsQlc2ZGtuQmFNLzBycXRSakdmSEdMTlhQNDZsWjA1WFFDV01L?=
 =?utf-8?B?Y0FwSDJUZWpZd0o0NGQzVXYydWZQeUgxaWt1NTUwYUQxYkVIY2o0WmVRRzE1?=
 =?utf-8?B?RW9WSitjKzZRRzdPQkFjNmg3eHJQb0JENlRlTUtrNmEvYUxZaDZaV2pjcU41?=
 =?utf-8?B?WnB2YkZQU1pEZkgzbnp1NFEwRDF3U1NUbHlSSGVUblZ6RkNTYWxZVHNiY0hk?=
 =?utf-8?B?V013aGZyRWZOSDZ0R2xkZ21qZkRPOW84YkVjVUMwTC8xU2pXVzFnTnFjVUls?=
 =?utf-8?B?ck1VRy9iN2dPeFU1dTBvVHRJaWc5SGVjMWF0czh5S0NOTXcxK1Z4enVITHJs?=
 =?utf-8?B?MmdkcXo0QXozNmVQVGZrTXZmdXZjSjEwRGY1dVRxcEV6NWpnNTl4QStvSXQ3?=
 =?utf-8?B?Rmpvb2VFU2RnRnYvM2wwc01uUWFaNWErUGFLN09jR3EzWnk0MUNVdmdYREJP?=
 =?utf-8?B?WDRHeVFaUjAzd2hpTG91dUNRemI0WXlJeHNMMGtaUlE1TGR3SDAyMjJZenVT?=
 =?utf-8?B?ZGVuakVpZC9IOGdEb0QrUEw0Qm9objBhQkJEM1F1VFVPQWE3RjBaM2tSS1Vw?=
 =?utf-8?B?dFJCcjRMOEJrdFdUV1Rkb2s0bitpNzlFSVZGdEVoU0t6UVNNMDdsTm5EUUhX?=
 =?utf-8?B?c1NWc0ZjQ2ViK0JlMUV4aFptS1RGb0FGMWVCLzNVdXpIODZwMVB4VzM5M0F5?=
 =?utf-8?B?UmJ0YlgxdCs5ZWd1clFRdXArSXBHSVdzWnMzU0h6WWxOY0lqMFREVHlFejdF?=
 =?utf-8?B?a3VVVDdkaWM5RmFZSzBkKzVhcG1hMTBrMmtIdjdjcE5haURlL1U5MXV0c1cx?=
 =?utf-8?B?OUJZZWxleTRmRFhPOTV5Y1VSRmdPWlVWMUR1cm4vbTY1eDRrUnBqZzJmWUVl?=
 =?utf-8?B?WG5yWUNWcFc3aEVOLzBCU0s1NUdIb3JDSlhGVER2Z2JDN2pTRWp6VjVMdmgw?=
 =?utf-8?B?ZFJib29RRzZWOEI3a2pHd2lSWTMrNmVjbzRJQUc1a0loUmFlL1hOY3I3dkhn?=
 =?utf-8?B?UCtwQzRHNnVPUXlZY3BIZXFaTVZ6QTMrd0pCMFMrczhvcW9rVDYreTJ3VE91?=
 =?utf-8?B?TnU2Qm9tNW1DRVNxNUpLS3pudWRQNGo3TlNaS0p2cHMwcFlpRVRhdVpENjds?=
 =?utf-8?B?d0ZRN0JudU55R0VSZE1tRlBJcjc0MXBuZFBIMlUrSzkzTHZoVEtHQlRDeFR5?=
 =?utf-8?B?Zkd5TWJ0WXAwZTFLN1NUQ0xINERIaENoMlNOVjlFSWZzTE9QQ2tmODFIdEhi?=
 =?utf-8?B?dDVmQnQ0ZkF0OUVNMmxDcDNIejBLeXZVbVlpUTR6dmhPb2FIQ242cStHWWtW?=
 =?utf-8?B?b2ZmMlJyR1NzSGk1ckdtQzJEUHo3S29VdzVHL25sTTM1Tk1nTnhDTi9hRDJF?=
 =?utf-8?B?SDBpMTlhSzQ0b05peGFJemtMcDNmVzBFalpyT0VqUmh1S2pTaTV2dTZGNmZY?=
 =?utf-8?B?bnk0NkNaS1dTekVCdnQxWHYwSHgxc0l1SUtBck51b2NibkY3c1NNc3h6cE9P?=
 =?utf-8?B?WGtrMThwYjg2dlRhQTNOblV6R1hoN21HN2dtdjBHSzNJMDhselRTaWxZOEVp?=
 =?utf-8?B?YWZpNmRwNVZ6V1p5Mll6SjI2eE1jdEYyNTkzYXNJTTFZbCtHb0dYS1RYT3k5?=
 =?utf-8?B?bGxTUmZlV2poeVJCeVhkVkJtR2F3YWIwN1RzeWp1TGtCYUJvU3V1ZWhxbVMw?=
 =?utf-8?B?cU9yMWtNOXphZEo4QUtWNHRjbzBaZGxsNmF6OGpnQ05KZHBKem96MlUzVnds?=
 =?utf-8?B?QVFaNzlpQjJnQWR4ekxhdjJ1UGFaZU9lem01YXZINXUxbGNFSTB1cjBzMWVX?=
 =?utf-8?B?MTk1QnpPRkVxcXpYYlVWNkR3Rm9jTDUwemg3Um1aaXlGMWV1czlvMlc2Y0VM?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af176095-9cd8-441b-1e44-08db7667e91e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 17:08:07.0292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oT9MHVIj8JWbTSnfanUh12yhMd1m7O763haBKPn1d7+vBWOyWRotBTxGKtjLOnTUFw3ko98+VIUdsTci3ye6jk/SEj6a9AIpkKlsP7gIxc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8438
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

From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Mon, 26 Jun 2023 16:25:24 +0200

> On Mon, Jun 26, 2023 at 4:18 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Ian Kumlien <ian.kumlien@gmail.com>
>> Date: Sun, 25 Jun 2023 12:59:54 +0200
>>
>>> It could actually be that it's related to: rx-gro-list but
>>> rx-udp-gro-forwarding makes it trigger quicker...  I have yet to
>>> trigger it on igb
>>
>> Hi, the rx-udp-gro-forwarding author here.
>>
>> (good thing this appeared on IWL, which I read time to time, but please
>>  Cc netdev next time)
>> (thus +Cc Jakub, Eric, and netdev)
> 
> Well, two things, it seems like rx-udp-gro-forwarding accelerates it
> but the issue is actually in: rx-gro-list

Do you enable them simultaneously? I remember, when I was adding
gro-fwd, it was working (and working good) as follows:

1. gro-fwd on, gro-list off: gro-fwd
2. gro-fwd off, gro-list on: gro-list
3. gro-fwd on, gro-list on: gro-list

Note that their receive paths are independent[0]: skb_gro_receive_list()
vs skb_gro_receive(), thus I'm still not really sure how gro-fwd can
trigger gro-list's bug.

> 
> And since i've only been able to trigger it in ixgbe i thought it
> might be a driver issue =)

Your screenshot says "__udp_gso_segment", which means that the
problematic UDP GRO packet hits the Tx path. Rx is in general
driver-independent. Tx has separate netdev feature ("tx-gso-list"), but
it's not supported by any driver, just software stack. It might be that
your traffic goes through a bridge or tunnel or anything else that
triggers GSO and software segmentation then booms for some reason.
BTW, __udp_gso_segment() is one-liner when the passed skb was
gro-listed[1], so having it in the bug splat could mean the skb didn't
take that route. But hard to say with no full stacktrace.

[...]

>>>> But correlating that with the source is beyond me, it could be generic
>>>> but i thought i'd send it you first since it's part of the redhat
>>>> guide to speeding up udp traffic
>> [0]
>> https://lore.kernel.org/netdev/f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com
>>
>> Thanks,
>> Olek

[0]
https://elixir.bootlin.com/linux/latest/source/net/ipv4/udp_offload.c#L518
[1]
https://elixir.bootlin.com/linux/latest/source/net/ipv4/udp_offload.c#L277

Thanks,
Olek
