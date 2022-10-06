Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD295F6A36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiJFPFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJFPFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:05:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D003C144
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665068731; x=1696604731;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4yC03hMgqizW4i/OpvYzztgfeuWxHgactHIM2NhMBJw=;
  b=UnT+AyYaGMUJfZ6OBkPAmk8oUafEPBfYqpjQeI9tTWoFKFTkIhm4s8kw
   XidLTvIcZf5cv0PS0LArG2xneJWjx8D01x9aUjyIuuAOoFmMp/mQ6o5GN
   45RrdQAYPR9RQNoCwaShZGZawGMvpsbdRF0NPwGDT6mwq6QcPvt5RHYsn
   3PIdK+gioGOwShpo4mwwN+RolvmQAN4TlxPM1k1it5hSxquFQBqYqVFnL
   MGZw6B9FILkeK7uIdUIm0I3n3YiWTYfVrX07H52c9IMu+ZB5gXyZt9N66
   D/X9SddOgxZFEjpsKGynrQBg7c0TSl2YFDaGY7EpheGZDB+7qfrLn+Itv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="301067320"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="301067320"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 08:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="713874292"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="713874292"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Oct 2022 08:05:20 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 08:05:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 6 Oct 2022 08:05:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 6 Oct 2022 08:05:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGISWjqyA09zmSVhSBXlp21L8nR1pTyzEZ28dhfLqps6ZNpF6jIqn0/qTKmgx0OoO07NW3uY1oWytkaH9KEQIs61OKKhLu7tuTvI+5afzswUnCPNZObDLXPA6RhlKgUDRuvEU2cFHqI5woI/zFw8rg3TzxcZc/vyQzTqbKXyIEOprhrfZAltO/+SDNJ6xsAfvMinRqEb5h9i0VPImHRxVYeEbHYQOhWIycfjNvcDXX+wlS5XZ4QHEH9tqT8rOx7UPL+C6t5g/P+g3VwVMbhskBlyjho+M0nuoZNBi4UYW3YOLlOdexPHkR2L68PMQqtlD1XLWe/Gni7HDI5fltaAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50OcBoB+SToWXSwk4A/IK8mvPrggx4c4dDkEGsw5zOk=;
 b=AXeY0Ip5675JvOMefbt5HTlamNU9p99SXhFrJx+MBlzPpesuanGCn1a5tZLaimZaAS0l99LAm1fXi7m7UQKyvbQma2ehjdx2copqLI12GaDGDDQUnPiq/qUSDnwuLELSOolBW0v91W5mI5XMtUEa/gqtqem1vYDdvE2RuyHDZ59R8k8MAMCiMq3JwxsjTUswC9ZgDpoepdbwArh8tzGhamubyx2XbV7RhND4XKJVNDFTIaTSL2ZgN5jZf3ekT7T8lJb+JDTVvyzSXsMJc1F/Mq3waPF5eaGCc3DzxsGWnBnRylyKZS9eJCqXNCGbN3vFh+K3FLfvnT8DK090liDaBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6010.namprd11.prod.outlook.com (2603:10b6:208:371::11)
 by CY8PR11MB7084.namprd11.prod.outlook.com (2603:10b6:930:50::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 15:05:18 +0000
Received: from MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::2802:edac:287:5a8f]) by MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::2802:edac:287:5a8f%9]) with mapi id 15.20.5676.028; Thu, 6 Oct 2022
 15:05:18 +0000
From:   "Brown, Len" <len.brown@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
CC:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>
Subject: RE: [RFC PATCH 15/23] thermal: intel: hfi: Report per-cpu
 class-specific performance scores
Thread-Topic: [RFC PATCH 15/23] thermal: intel: hfi: Report per-cpu
 class-specific performance scores
Thread-Index: AQHYxKDUc3JEsG82W0yE7e4mOYxGrq3zR9+AgA1cBYCAAJS4AIAABlSAgABXljA=
Date:   Thu, 6 Oct 2022 15:05:18 +0000
Message-ID: <MN0PR11MB601075B47DC7626876CC91DAE05C9@MN0PR11MB6010.namprd11.prod.outlook.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-16-ricardo.neri-calderon@linux.intel.com>
 <YzLlk8NL5qkOOxzX@hirez.programming.kicks-ass.net>
 <20221005235959.GB29251@ranerica-svr.sc.intel.com>
 <Yz6XQHafjIpfkyyY@hirez.programming.kicks-ass.net>
 <Yz6cjzrmu8HNPhhy@hirez.programming.kicks-ass.net>
In-Reply-To: <Yz6cjzrmu8HNPhhy@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6010:EE_|CY8PR11MB7084:EE_
x-ms-office365-filtering-correlation-id: a9bb619d-d3f3-49b1-a2b4-08daa7ac2e82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NUuhHiIu6aOHgR3CDl4yXg9VEJnnW6lIA6/1y+thR/sLhhW2epVhb2JczPk90lO86pEqVS4bDUx1+cdX9lMfmEpz/RSNbBb7gkltbn5o2byIHhLqo7iulhsASCkwxCb3ddWMsgMIi4x5HZ8S6WFsi6afclcj2x0DjXwrcOhXCsDaYyv8Fwxw7j3xepf3ov91wg5Lp6FNMJikykXajXhNIiwE/vo9J09dQjpURWvICHruzBI+jDBNoXiKq8onGjeZlIWtW6iL+XpPR4MBgQo/Q1i+kWjryLKLoduDevVNLRgOZJ2NU8q5hcbbgnD1Ck0Qho11UMxuCrR1EyTIHZEGS64P4suzbziTX4ph3D0Fx0mkA6as+egyvi+bFLBJ4eV57pC1aBNs2ffzvd/VliXhXQ2hRar1R0KwdmMjYA3jN81mbDtYpyOxOJUcfwdWY8TimSsPAC4ZJp60+1ea24krZPDWxEQY450oRe5Qpg6gH4R0Xakcad2ppddBdKbiAu2MAiy8LLIvF8W2r8QO3Ja7UOfoqCA/7Uue0ebw93eODMG0FTgxsSQ/KSmXKqqYiuq1PkqsxdAxcqz543uYFsvti81cZge6NedZgdGGu/+15tL42AysVBG2NTt+Oe8GSRE3DPRUwHAjOpZYTbSShg/430jbx4bkj07Rz7JGVlEAuYGswbRl8GHWlt587spVvK1iMhPslCb2nL/3z9lUvwN67k0XTXh70wszZuX3nVDw+aTKJTY/jbikxMSQMeIZYCQM3ZGpfuFtAU1u9PGpOkIa7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6010.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199015)(66556008)(64756008)(8676002)(66446008)(41300700001)(66476007)(38100700002)(66946007)(76116006)(86362001)(186003)(2906002)(55016003)(122000001)(38070700005)(33656002)(83380400001)(4326008)(7696005)(6506007)(26005)(52536014)(5660300002)(8936002)(9686003)(7416002)(82960400001)(316002)(71200400001)(54906003)(110136005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7iuU/yLa/KCf14pS68wqmentbh2JlGEcLMG00u50w36fan5bOe/9lyFTwsH8?=
 =?us-ascii?Q?Hl0jZMJ+M4mKKnqRTz2FG1n8fIHqIFrNkfdPCk13WoxNApnvKcyb3JSL5yiU?=
 =?us-ascii?Q?l2o1iU0hxQrf6j0UlSSAdTrjl+cDG06xEGuQRG4J8QQzxlYWAO0z5lBI1RFz?=
 =?us-ascii?Q?ZGL+YiGn1Q6b34mG3sTQT4ORXg+z0EeSbGGk1ExUtmVYi7rYkVRSlLBVHZSU?=
 =?us-ascii?Q?j53vuoMtz+sy/Tgt53RYVMt3HZv4IzDIRko4tW6PVUvY7cq+SOPu3SV499pr?=
 =?us-ascii?Q?hKggFxZceehfdKIlRJ/qUzcZe6uVkMVs1jNrJI2/lthc+Q5eC75NmppVimwO?=
 =?us-ascii?Q?2DHcn3PN2J/Y7uSs65ck2TUB03+3SYlZx4XcDWPldhjxMRZ9V1Za6xihFhgv?=
 =?us-ascii?Q?2OldCABBkUEUPO0okleKHWCFLHnv6kfIfXOEvtQVnMPEL/WswHGRBUZZVpRI?=
 =?us-ascii?Q?Ta39SENb72aiiJXjgzf5tWZGGeCemm2y+tAFKSWtUjTfIJX0r22S7A+kXQ1J?=
 =?us-ascii?Q?rRvf7Zqm7m52JiTLGceTxteMICVZwFi2UzhZ00ivrAn2lszeVLZrYYZ4lgGb?=
 =?us-ascii?Q?tjj+3Z0Ypq4sVRi2wa2Sx7E+t0XnUyS4CnK6ZNyrwfoE/wq/jLjk/HhDuYPr?=
 =?us-ascii?Q?vBeWG6Aj+4TjU00th5V++FFCE97klOME4HbUWVa/XU6+8kjZ8qE8bVlJm5pM?=
 =?us-ascii?Q?jdM9pcMKe/cZa361eZgIF/4aH+yNwdgyaBLcFdImEAPkPSX0+a5L86mjYuW+?=
 =?us-ascii?Q?XlRelfov9zE9u7LzZUrUXiyuodjFCyQGWk7bhcjvrH2VtyPLmD5aIm67PbwN?=
 =?us-ascii?Q?oVM37/7hsQRnc3/YKJyebeH/8ARujXZYIhRyO/nrb5AFeYeJqdhN+Lp38swO?=
 =?us-ascii?Q?TSd4FcXLh4Xp2hukbOdQCJaybVHaz/3jrtDbYkDUZ6iiL2SYiWwAR/sJMXw0?=
 =?us-ascii?Q?BtFVLfDz/3VMF5dwFgeohOa7fL3fBdPDFE4VEvUPDQzr3tBWCl92dKU6SGJq?=
 =?us-ascii?Q?CVH6EmVRIK0F3sYnTiBGNcWk+a5fvHeKK9pumd5IdBu/xHoRb1EI70go6/kP?=
 =?us-ascii?Q?JtDjvM8nHcX8M7oAiCH/ZnSLFopAi3GHUseI/1JDhzTCIdUvpiEWkhLQbPT+?=
 =?us-ascii?Q?5ZlDz7UEW83+jF75KnmA/pBlteW0AcwusJ9erVoMk00yLOmwPpBIZdsHumUK?=
 =?us-ascii?Q?S2kXLnIUX3YthR0axtx9PdoyU0GVV1beilSKUyp9qpJfE8RkPgf2IOxNdB+I?=
 =?us-ascii?Q?G38ihKx7B2K3pReowY6deR1wlOgtufZ/3+ucHfQIvkm5M74fDGDcJVXaL9wZ?=
 =?us-ascii?Q?8fSyQjLetciGWw0zo1JLCAQe1iirOo7GvXuXG1IiKsYDfFENDRZITyjN3w/o?=
 =?us-ascii?Q?71NC2SdW9FXLG2IjPlu9wCpAkQEJOiSVB8jlxqK5RZft+FNFZik8amD1S7lr?=
 =?us-ascii?Q?N2psYRHIjWHv7gx4pz7jO4taSlIK3U0RbOcDlGsYqKsM5xaHyGb5b3yZhsgT?=
 =?us-ascii?Q?tc8PzTXmMQcaDO7EUMGb9NkUc2pvRKWGNc/s1PyOyQReKIvpcPpCoBSvlifk?=
 =?us-ascii?Q?8m2jjRkI0VGkhJvZOfDODypXqRynHG5zjH0TjK+g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6010.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bb619d-d3f3-49b1-a2b4-08daa7ac2e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 15:05:18.2225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1tTK7SpN1CzdAhQsDVTs7+sQvKhFzxNA+vLFikBRrQZ8O+ON7FoznDnXyk6gk68tTZAokl6qo3CKbB/5qTgSeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7084
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Does any of that data actually ever change? Isn't the class score=20
> > > fixed per CPU type?

Depends on the chip.

As we described at LPC, the ADL chips shipping today update their tables in=
 response
to RAPL working to keep the system below PL1.  Linux or user-space can scri=
bble on PL1
at any time, so technically, this table update can happen at any time.

That said, it is true that, say, an ADL desktop part that operates with ple=
nty of power and cooling
will send the initial table and never have a need to update the table after=
 that.

Upcoming chips are smarter and will give us more dynamic information.
We expect the P-unit to send only "meaningful" changes, and that they
Shall not occur more often than every 10ms.

Re: class core fixed per CPU type
Usually (but not always) the class score for every CPU of a type will be th=
e same,
They can change, but likely will all change in concert.
However the scores for the different types can change relative to each othe=
r.

The not-always bit is because CPUs of the same type may not actually be ide=
ntical.
Recall that ITMT was originally implemented to favor some Pcores that are
Faster than other Pcores of the same type.  Similarly, I would expect that
Ecores within a module will be uniform, but some Ecore modules may
differ from modules -- and how they differ can change at run-time.

Cheers,
-Len



