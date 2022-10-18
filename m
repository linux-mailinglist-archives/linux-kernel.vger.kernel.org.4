Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876616036D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 01:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJRX7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 19:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJRX7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:59:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108DBBECF3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 16:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666137555; x=1697673555;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5IQpCu6MJ5XKmggd5jq4opDYe3Fs7imdAsu/CVVYq4s=;
  b=hmMduDY5O8bJULoHpmTnjaCCJLyX4YE/l7bHMYKbLf48y5Ci4pIyoD/9
   AHuSQ3dyxzJfgzOUSP3uuhK9yEaEITdj6VD7FNxDbWalRFtTd5y8+tLSF
   w1XVuyK2nj0YRY1npyZ8kPnWs3YM5iJjADsvI7F0qh4DeNo0luBf1bYu9
   6STYk27uTP9Uv28XM6nXnuC4zoXxhFVXq6NdIrTVs3av5r1vZg/OpdL8N
   azR8hU0B3XEH5nZH5XpYyrqkWzSxkqTj85Fw2uT+QUTIT97oJbOvqCfT6
   9NSWDFxuvbbJg55Y6tFxz8ccNW+LMwPiuLsnKReWkevr28tg8t0xFl5+U
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332809765"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="332809765"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 16:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="628972448"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="628972448"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 18 Oct 2022 16:59:14 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 16:59:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 16:59:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 16:59:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2oO9W99adds7Ais7F34E5a+mE0uclLYdG60zZA5YgfIp+JMgvsLD5HBDWhxcQbkIgxatWswkENW7R0fcjoVJClyaDg3A78tSRj/9ke4svw/Y6A0stREKy6kDGg8xQQ/rOrKgiDOdOvHeTVcBUu+rj7Sh+2hCoN64oHPTfApJ+wMDwe1sxwq4SsMd1TEnIofoYZ1N87sa6SCbShPpe+eiDnPg7FygLcKiWDHx1UY1HgRTHtGHKzEu94h/JrM8VJk4RBtor4mOd9klG5RVqZs7xelOHz4PsiFD67WN3CQe6SeiaJL1jlDNcH30XZxZSzU7f6GqzNovHSEdPdwkYIqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RC4M+hrbAVYC3mzHteh4Ij351XuWxz4AKVrP2vs7G4=;
 b=EzeY8QuLwP2QnW+r+EqLkntBqiizIcB8/Pbrkjtw8id2K4FTEPb5xqVE1Ff7FgqTd5CegL1W5fNPmWdYSZR6s9Kf8Qip1Mq0hIuVkJKO+GJ9rkcPBGdkS6EjgFKmX8hr0UEGVd3OhtSJ0ZW1KicgdD0doc7P61HGnrZClovSL+6Ed+nVYrxk4TOdVFEjCjgttmvJU2h4lR6I0TJCbtguK5RBHuJppJwfbVXVwp3ag1Gfd+XHjFbB8eYVmxxtiACPW8eD/kxYzj341QOM7/ddEr0PMj6aA4zK1/tGiAR93rE2FUF2u3/JifCMA8yIpeKP8iiufAxK+yerZxjiR1mE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CH0PR11MB5298.namprd11.prod.outlook.com (2603:10b6:610:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 23:59:10 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 23:59:09 +0000
Date:   Tue, 18 Oct 2022 16:59:03 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Bharata B Rao" <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCHv10 10/15] x86/mm, iommu/sva: Make LAM and SVM mutually
 exclusive
Message-ID: <Y089x212wn0KMPAx@a4bf019067fa.jf.intel.com>
References: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
 <20221018113358.7833-11-kirill.shutemov@linux.intel.com>
 <Y08HgXqvNSpTUgWe@a4bf019067fa.jf.intel.com>
 <20221018223537.7bmhuknclkboqgnk@box.shutemov.name>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018223537.7bmhuknclkboqgnk@box.shutemov.name>
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CH0PR11MB5298:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d562536-b0b4-45b3-8e95-08dab164bfbd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmPC6ID1CCb8jYJ5bd7nSLpvrl6GPwoRLP/L5y/nenGYeCdbfy0UXZA5ujdj8ZUKPD6yJlRzS4wmkvD1wxQLEOzXqDM9nhXZzHthtqw5rw+dgkuyEHH/MwpIVjBy+jszgO0MIZNxTtInLEcp0H8y8nuIGlZGD6g0/K3bNNMmpMrW1LAfIyIccXeuVMb+zYaPkq9wIbigZrNWPSzYrW9NDzymOI+DvdHcVLqpFiesTw990ObDIg0q2Ib190fkbksJfZ7QUWTtQESQJ4UzzZ02tTpBVoTLbr6XAdIE18veRZdN3Vu2CAYKIeI+mHvK8wLPYbwuiXHgVo5WD6oOmDF+4tFeAoObKBLkinu2brqx5M/qrs4YAeej3FQiOFtcVwIqCjPxQnUP2Rr6xN2f/eEddE5DRwrZ568QAMHO7w0VMK6ukJKTWha/UlWJwv+AyyJCWLdNzOjH0J87w4rmFs44ydbO+olKhrcYnG0T0H1QS2kTo6dA0cxdqIclZJcGB0cSsznx/E67wyPMnbExiEdHOOARj0pp7s8X1iVae2kcZg9CEm9FtzOx6QXk62fejlaxDV27Nhn+bloEMjgJZU23tThpfm2N4beDmpLE0qGFuEsaGxuCZklHEV2xlVzBcSRCXYJpnAJ5KCg7gXJLBpbhrMGu6S2ab7FIdSA9wNUTO7x9gPb6Bi+PUidJ05LaCYxWZm/xaBtR4G638hUN4k9v9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199015)(26005)(4744005)(41300700001)(6512007)(66946007)(44832011)(186003)(478600001)(2906002)(6666004)(6506007)(7416002)(8936002)(4326008)(5660300002)(86362001)(38100700002)(82960400001)(6916009)(316002)(54906003)(6486002)(8676002)(66476007)(83380400001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eWWovijoMXOh3fVITmfhVGAP0pb5AvHbLJjuqWQOaK+0qbWZsM9S9qM6hp0D?=
 =?us-ascii?Q?ZCEvddkKDZakKKiZBE0yAVm6XrsByZW+zDhk6za71V0x84Rcrakij+JCAeKO?=
 =?us-ascii?Q?CJnbzGuuejbo69GDtr5f8O+NEaGAMHVwur7RskfSR5wIumkDtxQxyPeT2rf9?=
 =?us-ascii?Q?kq1BrxATZz+CBCaR6FPwhDt4G88hiBA5HC1O4ErSqamgOuBlbZ/FC5aQNEXH?=
 =?us-ascii?Q?VVkBiK4FjjcqYW9tGv7ua/+Us7bZQNEkbpjGfreTu07uaMoNl6J9E7A0IKST?=
 =?us-ascii?Q?LVyVEB5e+471bI6iii+e44pYXx9DAtxl/dfdy40B32cVKjXbQNbKgK8rYdBL?=
 =?us-ascii?Q?T08RCcVqxWay4jC0ZDtvpXMI7/YU7CvBMxwT2ERNUflPq+WaVSKMawlj6Rtq?=
 =?us-ascii?Q?c8wguN7q5wwBXa8Wn7arCXMZP5cJ072jZgYhvY0MPe7H6Kaxb0fX9uQ1ZZT7?=
 =?us-ascii?Q?sLUZ2izsLjxQvRNtv3vIcm1yj4HX17Okh3b7nr2MYGAP/SRf9VVqg3sD1uFd?=
 =?us-ascii?Q?GZHGc8MxiImGzyg+EWJIPSae5eKYLegYEOf6vHmyFbL4hD6bIOXVI+QQTOfj?=
 =?us-ascii?Q?AhmfPx3AJX83yHh7H3P/UWc0AX8wGXJgV4C4XLyHrWaczzM+2NjcxBxMKAxU?=
 =?us-ascii?Q?0KMc1OzPdfuRrHlXbwC6j5a5XUMdjhTTWEH4URRN4Ms16DUzfogl45L1hp4S?=
 =?us-ascii?Q?50gWlVnfheXJG1BOvBgJ5G51LwamCcLH2+tVDAkgI9dlNSFLioHlJAH2zvqx?=
 =?us-ascii?Q?D036EASP4JgTtY2OwTYY8Yus7kQUet8xPxmmfnSk4hi9kiQYph6lytwv34IU?=
 =?us-ascii?Q?wqpZBPFPAwNHvxAmnEdo5HJd8XrERvGdwrouAy0i9sxmBdyY3z2Th8hoq86I?=
 =?us-ascii?Q?2dBjEDdpgnJ2BU5F8LdhliQxVRqPF17Qz96ht4ss9ij8e3myEltkYNs9tkuZ?=
 =?us-ascii?Q?sJVVVhY9fM0jOiwxcbDi1h+DUB1yNXVBGSRkfjZP5OoG2ciNwMNd/WY8W32Z?=
 =?us-ascii?Q?nmYmBRH/xFrSWN1E5hZOZA3WqMMM2u24tOF2McgPmDlZqjYR8n+jjr3y560r?=
 =?us-ascii?Q?nZ3WSf+bV1nYsutC39zorHKeR6Yim9cK3oLjv9fIWyNSGqXyaN494rSYCGMT?=
 =?us-ascii?Q?1Q37m4AtEuoXQ65SV7owBrKOxhZNrCtdMu0qNoP7TEQ15K6gn/J/sLRR24De?=
 =?us-ascii?Q?QbxOMXzw52d4eyRtOyelOiJU+v96O+D6wnsaCXuNyetBtR8D1SZNd5ZjTXVq?=
 =?us-ascii?Q?5zBNfiaglSwfSxYCIe9oJi4qA06SdndzimNV8pjsftqBOs6zZrOkxMIvgbdk?=
 =?us-ascii?Q?9H5DZWVGA4dzlKSm0NXIdKEkav/9YB4m0xP+5TybRIHbdnIsDYZyk82dRhmr?=
 =?us-ascii?Q?mLqxJzdmRh1uTASRB/DDnvFUBN/JoFK8MOOWWrRFyeIf0OEv0Dt5hBwRhHj5?=
 =?us-ascii?Q?GOxrRXz7rlGtRZj24anhz6WXrCwYv2FHwpPn3BvveqjxIVt4mG55itlqMhwT?=
 =?us-ascii?Q?G4Nr9ZMU/xaVVU4MzV0FCrHppoYI5yiRJrJvkqRi3uonwrblz8VOMB1tLT6G?=
 =?us-ascii?Q?V1Iz2HoW9xlTtubUv+xoEzzjLuKj/1M3JS3NXyX8kAEZT6SGV5kaPejNztRM?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d562536-b0b4-45b3-8e95-08dab164bfbd
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 23:59:09.9001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VLfu1Q+CeqjLIrhbYM/gVO3sOkXaqaKTetLHCd3ySRkJsX/8XZ0xBH9rJWZ/UyecaouKAMHKHilF3kDleapLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5298
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 01:35:37AM +0300, Kirill A. Shutemov wrote:
> > >  
> > >  /* Uprobes on this MM assume 32-bit code */
> > > -#define MM_CONTEXT_UPROBE_IA32	BIT(0)
> > > +#define MM_CONTEXT_UPROBE_IA32		BIT(0)
> > >  /* vsyscall page is accessible on this MM */
> > > -#define MM_CONTEXT_HAS_VSYSCALL	BIT(1)
> > > +#define MM_CONTEXT_HAS_VSYSCALL		BIT(1)
> > 
> > Nit: Looks like the two above format changes got in here :-)
> 
> That's side effect of keeping the new longer flag aligned to the rest.
> 
> A separate patch looks like an overkill, no?

Agree, just thought i'll flag it, but I don't think a new patch is
required.
