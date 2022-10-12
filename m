Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4893B5FC9DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJLRX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJLRX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:23:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73EA33A08
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665595404; x=1697131404;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RaWevsD+bk7aAJ+C0x84ZW0FxplPezr3VshUGmPQNSk=;
  b=QhXhV8K0TpAqL2CeZ5lvF+X9l1s3IjHujutnlKRff+4JPQKW9GW8+Vb6
   nJiT2Y8qE5t+PckpLAn8SRSzoY4YrsFq/dIp0K9tbkCNhSqiSrHN59ere
   4mVQwSWp0Xc3ahPP8A3DRICS+khY5uDeXey5hoKuXqyIQg8W+3LsouVj2
   f62AtB0spMZ8+3wbkkuDHZALIuXhyLLrXxT6Y1GGczJp3MAnKv/64Mvsn
   P75VO//rE7pR4+OXlo4bLULIO0deDFZ8/uAwWdKYodqUF+CzBcnWSC/vA
   knSmfB5p4eejehtkN+PXQMXVstELIMxm3ayBvCUBqH6adkqLgzDRSf04K
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="366857710"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="366857710"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 10:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="871994000"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="871994000"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 12 Oct 2022 10:23:21 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 10:23:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 12 Oct 2022 10:23:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 12 Oct 2022 10:23:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGrlQRvojQ3vPplEk9CezWmDwdOMHVQIJUeXjjfRJXUUl5PYYSgqoopNWfU4Cat2Y5rx0i7zk4v0J4ed/rA72bKlUCN7fQY69Q/Kg6lQRaQ1RBECQFkMXTOtE+AiSIGfrihrKhrCtrxrU/2BrgJD40yqNxk9al4sze6DOeF8U3V8Dx5dmrV6dN1SG8+2pdYJ9BAgwZeWp7V8BmuKvkaAGyUpQt6/ZJm75Kvhe28VGwg4x7P9yf8i7YXThYGd7A6hswHI0jE/KIoRluI2TvaXCPQUOAO643JYdibn5wtuiIOIdSczLw0QZOi9svxVQtinZ7Ab7++vmYJ582qjmqI3vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQETq5vRx6J5SejdPE+XiA/RgtmioS1gj3oL/Li6DzY=;
 b=JNZKZ2xKePol/IdhGJoRvcGXuChyInROcsBkvgKfkk5rDvJmp/VQlGQkqw/LBWLkJr7IuydbJmOGFjhKTEzybrnfUET9uQp87Z+E0v4XgHc18K0S4eDFNjNTMSLz8DOIWKysJ8Ou9dmRIGdbteFDBk95VUqOQnE55Ff+722Fz736xrMK72zidb43DOoJriWJMnq3kY7/cEfckuVPzTXj/wR/xuu5OmgZDq2spXsF3yNZg/hlU569sN1EP4vEY+K5igegZHSVGR4g9+WRwi83vNgufRwp5l7pMK0VX6/0ExKO4JK5KR7U5v4kEyifOjeAb5ljCIo++6NGNURnKM0uaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB7058.namprd11.prod.outlook.com (2603:10b6:930:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Wed, 12 Oct
 2022 17:23:19 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5709.021; Wed, 12 Oct
 2022 17:23:19 +0000
Message-ID: <7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com>
Date:   Wed, 12 Oct 2022 10:23:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.2
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "James Morse" <james.morse@arm.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::39) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 7421e545-1807-478f-8f4b-08daac7674dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYPazJ4Zdx8IwXtS0FTUkfxPl+BnUycHpAEinl+h3BcadRRJ1HSoeEmRvEjiOARL2or18AhqRZrtMXwiH8ueMyetkS27dZhfzrmeLXltnfJbulfAWOOhtxvPAKnTma0VeGcotbrihmxd+iN6cm3SxLhOR3iaOPFCCNue/wSXKpCm/7k50hy9B0aPGeMULI983hQdHAxHmn/KU3y4JjPdeL21GuN7+0x3imv+sC/QjG3/Jlku8WY4Imo18rGMLFY1cpy+sf34iuhVl6FQz4LHdKkg7MQIX0uvIq5tv90sibqTnlW/PSF2Xg07vSpJRLjtxDXDw+iPerO9e6Omm0RZnejvrP/xfjCeWnsoOoCs1tH0LVv293nifUQnE7DAIrsgQb5EaLiTtzD7dI14TISRUiVtOZw05GGwifT4Hyim4vUEG9tQ9N0SbhlUQ7tT1wGuLAoWLUpYDsNbbasOrpNVhAY8Gzo2/mxDKnf4O8SE2rf08GvQBO5d7rO6pR+snxs7A+IhiHbtiZNLgfv0g6QMr1tChD9T/9wIuOxl0/rJECFhVbajKZxok6jWU9uDz0VcbP/OoLD1yI6MxpnMWVcJT2DPHHhCWAfjxTsukm/Qh1Jp5d4btep6U04rnKkM0bfhOsQ1fVzBQYqx9J3q70lSAQkaZi4SFwM8JUSDpQKGFC67X0yIwcZqJBHenfGjBZbWRfC/MTM9u4n4uvs7TLqiO4ggooESSVTmEfP92FisdsVjNiSHCOcVtPYet3zzbn0he63kH+BGfJM609J/1495IfRVGOO6cfBhxz8YABLJ2vU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199015)(31696002)(83380400001)(6486002)(478600001)(86362001)(31686004)(6916009)(54906003)(8936002)(316002)(82960400001)(38100700002)(6506007)(66946007)(66556008)(66476007)(41300700001)(53546011)(36756003)(44832011)(186003)(26005)(6512007)(2906002)(6666004)(4326008)(8676002)(2616005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UytWMUJXaWdyRWVtMkJ2eTJVdXVOemwzb2xueGYwSVdJRnJMd2dlS2s5TWhP?=
 =?utf-8?B?T1hSeDBpM09TcjhxVHRYSG1sam1Dc2Q1WEtPRlVTSU1LcEdGRDZmRUJKYVd2?=
 =?utf-8?B?WUdTVDIvZ2F2QXF6cTFKSTdhK0hSQUFCSW1JM2xieG1OdmdUMlhiYStsRjBq?=
 =?utf-8?B?RU5TVjlFNnFGdWRKMForVXJJWHZDak5IZE5heG83N1ZVQXBlNXNHS3M2ejZa?=
 =?utf-8?B?dE94bWQ0MGd0bHRMRENJYVRZT2Y5Q1B0T2l3WUFQVlhqcVpCZktMQ2FySWxq?=
 =?utf-8?B?RXFuWXErQUVuNUtQWERKc2JEblBFMW41R1B6NGE1NUtRQmI2c0plZ2J4SjJh?=
 =?utf-8?B?Z2ZPa3owWnFkaTdzUTR4SGVLYS9qUkhqS2FaRDdyMGJVd0tmK0tZZUhFMnA5?=
 =?utf-8?B?V3VPV1ZFeW9XMUpYbXVubUlrWVhmT1A0Qmo1NkhlNk55bndFV2s5K01sZ2Q0?=
 =?utf-8?B?L0hGZ1RObER3OXl2U2dEdkduVHRWSisrU1VOaDFyNkEybHBDbUhWNUFFbmV2?=
 =?utf-8?B?cmlrV3BpWldFdlNrZElxRTBsZFNzUWtQblVpKzFCZnZjbHpoZjRtVXVxdUM3?=
 =?utf-8?B?dlR2VTV2L1dXTTUrNXBmQnZmNEtZeEdrUmtJajMrdXFLWXBHVWIyMkY4bHpa?=
 =?utf-8?B?OFJSbWZMMDdhekI2a1V6T001RVkraXB3QWMzYVMxUjBrSGFuWkRhSTBab1BJ?=
 =?utf-8?B?eXNhMjE0bjRMSDNWT01WeWdCMENYcTAvMG94SEk3WHdvWHl6cmtuVERacW1Y?=
 =?utf-8?B?SU9pcmIvVjhvV1FpbllQdWRwVHN5U3FXYzRpcEZHUUxjem1iMWZzQXBhUUVv?=
 =?utf-8?B?bzJsa0hvc0h1MTBZNEFkc3pYbmlGTzU3ZFc5akhhc0NJVlZUazNScDhNWTYr?=
 =?utf-8?B?eWdqak9OdjhjWWFxYmw4Z1phYnc2U3JLVGxVdGJSL2IwUlo1VWliQklDOGZY?=
 =?utf-8?B?ZTJJUllTMnV0TkN3bWxmQS9HM0s5NXBoM0RTNkFpcTduOExDbnh1K2VzTU14?=
 =?utf-8?B?aGphTWFQbzVNb2FiUjBjNTNnUXB1WHpueDhVRW9qL2poS3orTkh2WFUybnRW?=
 =?utf-8?B?cE9KblZvWlJkVDZzZzNveHRET2Yxc21GbE54eTBtR0JkcGlOOWpTN2hiVWxF?=
 =?utf-8?B?UTlyd0tXeGMvMXA3SitQNjZVUm9TNis4dVpZcEh4bFg1V3NTWERoWGFwa2hl?=
 =?utf-8?B?UjZCUnlWSnVGbEppSUZyQVRhMURzMzVZWXdLbFZXaGl3R2pHcHEzSEVISC96?=
 =?utf-8?B?bnpLclpvcDcwc2NSZG4vdEp0eWZhUEZ6ejZxY1JNdkl3bVZoQ0RSWlJpSmdx?=
 =?utf-8?B?ZVdKbHY4bzV5T2lEdTQ1cEp1S2VHV1lOK1d6bUtiSTVjSDdPOXFMTnpYUHFs?=
 =?utf-8?B?WFQzK3k0QkxNa3paRE1CYk52ZkpMK2h6bWhIOXF0UzBROUJOMVNaL2FEUHli?=
 =?utf-8?B?dXRXK0JKOWFTdjk0RmdtditEOVZXSk1qK1IvTy9pY3FkS0J0TXN3elV1dWIv?=
 =?utf-8?B?QURHcDBkOFZSNm5zOGhiQkMwT1prQzZlcFNZUHU1ZTh6V2svdWhrajZTRE42?=
 =?utf-8?B?Vk9aQytUbEtPT0pIeWJXZUcwVkMyYkJON0NmZ1VobWJWcVJRRTFsT0FIS0t6?=
 =?utf-8?B?ODBnOFdZNnd2NExkRjVSK3hpZDNjdEtwWkIrcHFyMG16RzlpVlhPWTNPUjRG?=
 =?utf-8?B?UkVNUDRjUzNKRHBzVWNpVlhTZS9XNzhjYkVPZE9GWXFCR0xwWHNaWTk5Nzc3?=
 =?utf-8?B?YXJtTitmN0czWlhuZzlYYzZNaFlQclJnQ0FZREttMHE4M0ROUE1vRGRqS2RJ?=
 =?utf-8?B?bWlvdy94bU5yQm1xaDJsNFFNd1JiL0cyU0s1eXlFc2ppeFRPN0RvakpNUUJv?=
 =?utf-8?B?NkkrdWU3dWRKSEVHWVo0a3U1WWIyUkVoczZ2RXZyV3FnWnFWcDQwaThzM3Vq?=
 =?utf-8?B?MlI3bnJPN0twV0Y2eVMxS1hlMlNZMXZBTVJJRGdkNWFoQnpncEZRZFdvLzFH?=
 =?utf-8?B?aFgxMVFBV2VSNytmWTExOFpHdTI4VTBrQ0UzM2J4REhvVXNzZUE4MVNXZ09m?=
 =?utf-8?B?QjIzS2VJcVBId25SMWFYc0orbXhwandaZ2JZWlU5ams0WTRRV1JpWG9QUEU1?=
 =?utf-8?B?WmYybWVxTkJkN3JqKytSa1BRUnhQTmU3bXVmVEdXYmZtdi9hSkJvSXdvbjlG?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7421e545-1807-478f-8f4b-08daac7674dc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 17:23:19.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpoU2AOYVZWb6EK+gkQUmwinoRwH8xMteFAwhJ4VYIIag0+Ao+Ucc1q9vpvmAssfZ8FaebtQKc7oI7GsF/dC15oECCv83ki3wh7DfjnJo08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7058
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10/12/2022 4:21 AM, Peter Newman wrote:
> [Adding Gaurang to CC]
> 
> On Tue, Oct 11, 2022 at 1:35 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> On 10/7/2022 10:28 AM, Tony Luck wrote:
>>> I don't know how complex it would for the kernel to implement this. Or
>>> whether it would meet Google's needs.
>>>
>>
>> How about moving monitor groups from one control group to another?
>>
>> Based on the initial description I got the impression that there is
>> already a monitor group for every container. (Please correct me if I am
>> wrong). If this is the case then it may be possible to create an interface
>> that could move an entire monitor group to another control group. This would
>> keep the benefit of usage counts remaining intact, tasks get a new closid, but
>> keep their rmid. There would be no need for the user to specify process-ids.
> 
> Yes, Stephane also pointed out the importance of maintaining RMID assignments
> as well and I don't believe I put enough emphasis on it during my
> original email.
> 
> We need to maintain accurate memory bandwidth usage counts on all
> containers, so it's important to be able to maintain an RMID assignment
> and its event counts across a CoS downgrade. The solutions Tony
> suggested do solve the races in moving the tasks, but the container
> would need to temporarily join the default MON group in the new CTRL_MON
> group before it can be moved to its replacement MON group.
> 
> Being able to re-parent a MON group would allow us to change the CLOSID
> independently of the RMID in a container and would address the issue.

What if resctrl adds support to rdtgroup_kf_syscall_ops for
the .rename callback?

It seems like doing so could enable users to do something like:
mv /sys/fs/resctrl/groupA/mon_groups/containerA /sys/fs/resctrl/groupB/mon_groups/

Such a user request would trigger the "containerA" monitor group
to be moved to another control group. All tasks within it could be moved to
the new control group (their CLOSIDs are changed) while their RMIDs
remain intact.

I just read James's response and I do not know how this could be made to
work with the Arm monitoring when it arrives. Potentially there
could be an architecture specific "move monitor group" call.

> The only other point I can think of to differentiate it from the
> automatic CLOSID management solution is whether the 1:1 CTRL_MON:CLOSID
> approach will become too limiting going forward. For example, if there
> are configurations where one resource has far fewer CLOSIDs than others
> and we want to start assigning CLOSIDs on-demand, per-resource to avoid
> wasting other resources' available CLOSID spaces. If we can foresee this
> becoming a concern, then automatic CLOSID management would be
> inevitable.

I think Fenghua answered this well.

Reinette
