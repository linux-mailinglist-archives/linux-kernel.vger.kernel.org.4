Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAE96287D0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbiKNSEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238364AbiKNSEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:04:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E886D2F014
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668448985; x=1699984985;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FcajzJmq0Dssqt9P2VrDtVlQinYDVPMyZZqGuQ8kIow=;
  b=HqKqatAn0zBWjjfAJhPXXxUZI+0PLy4yxcjytokZ/nPawHyaT7ERaHff
   9hX3Pyb1UF0glfGfo2Vlrnz8TScr9hn2jsHMzKiTY47jT/DLaJfpB7xS4
   2zDVGIqqB8C0CemQyqErnQAv6AyixukizhBLpvFljVSM+7rWvH6c6CiDm
   fmmezhrrEDfVNk1zGWUVfoKA2WcW0JrwpBiLCST1p/s9VMdVLcL4YFCrV
   hDwU+1APCBuuUsZARXfxkj/d+qIFmUAE6Cj57lmroXI7vUNPLwyhuVlrv
   anZQSyxyi6WK0ERH846hhRtrWFQj2z7aKV1Hkn1JnG12MBNLKOdTspjQu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="309668025"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="309668025"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="671659504"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="671659504"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 14 Nov 2022 10:03:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 10:03:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 10:03:04 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 10:03:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QByUndgyjcp8TJaGoB+6v+mlBIVayyQX6xXwLbd7zPCoCG3AMKknOJflhjlQZQRJ1NqPUMhQeVhI6B/NB5wDPVgQOhYXRiniorK5ksvS5dNhG71PybDQku0+U7r5pbrxzJ6x4sDIwPJOZY21QGdFZrVYKjLR+6q7QbHmGCjql46i2YcgYZ9cqOqD02gf21oinE6PQZWa93j/RJK6ROLalbnqSgFCycgc2Q8UvbABn2vVorhq6BxOAK4TFsiU7Aly1yBZxzNp9VkfKlo/2PP7CQbp23cAGUPUkMCN0xRwNB+ubLtkc/PmvvmuhIcB67Sk+hxn51Dcbb65alpkpGxiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/22VvuvnP89zB8t4csaRnhQAvxZjx/AsXOwo7xSqMpk=;
 b=lcoWyOkg7QHonmhri4zlUweWh5TXdu9AtuvU46ubjNBXneXOjM347k9XSy/Qi9r3tG+umwKslKfP+uLg+KA2n1HJqcCMXmabuYgxuEJ52RSUzVYEdZAjVb8qeCCyL46JpJk10vVp3Ug2CF/gImGMlOcvr4gX42CS6jICUJDy1EK19o9e77VwkRYmKP3Cx8De+p8YclU6jTKpGW2ldKyBZvaU2TF5ffxc45KLHYBU1wZLHSJ4OhM2cReUi/G8U96R03ST8cMyjvqvMHPSmHJYMQxhTziL3d7PMFvzkyrizcq0oR4p19+DiBZcTr5/KFWPaSHdMzZcGeazajOuH+t+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH0PR11MB4967.namprd11.prod.outlook.com (2603:10b6:510:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 18:02:59 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5813.017; Mon, 14 Nov
 2022 18:02:58 +0000
Message-ID: <d412f235-c2c8-28bc-4b2e-fbf353cbf192@intel.com>
Date:   Mon, 14 Nov 2022 10:02:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     James Morse <james.morse@arm.com>,
        Peter Newman <peternewman@google.com>
CC:     Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Babu Moger" <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
 <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
 <09029c7a-489a-7054-1ab5-01fa879fb42f@intel.com>
 <f80299a4-7eaf-46a0-89e6-b9f5385f183c@arm.com>
 <c227a0df-7ac8-91f3-cada-0ca5ec047579@intel.com>
 <CALPaoCidd+WwGTyE3D74LhoL13ce+EvdTmOnyPrQN62j+zZ1fg@mail.gmail.com>
 <bd52ec90-52e4-32c5-132a-5d82304650a4@intel.com>
 <39fe80dc-713d-9ed2-a5aa-5c84376917f3@arm.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <39fe80dc-713d-9ed2-a5aa-5c84376917f3@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH0PR11MB4967:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b04d89-8ff3-42a7-4b2c-08dac66a7616
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sU8awtbaSyPx3LkMI6tmJW2TfjN5kezlbzANGBjDxuXh5BX+DuUrRDmbfUOEwZt5hsBZzGMYmoxIFm6mhsXA9ERXOAPS2KR4IJ9eP5a7nThWPFgWY1ApZMIrAyRSCcL/I66ifjPWjA9rsA1mbzEaXwzIvrHesz31zeo0d3NJg1yiUDp97zCebiohiCYoN7J7fJHH6l7kuHCRO5oGwcJHpsqIiwwi9DtyO+oo5P2lEhFVt2OtIaigFeLK74vGQp+IW8j1tT4ow0XKEljM0sZS56tDQ8Mel3sPeMEdEAV2r5scuzI13sRdBOJqD9KyLqjgwKWBP5BH1NcIUf4vXQ4dkNDmAnYZhdr2V3hgtArZYDKoeie+9BfKcgOndbqrgGPkYlR8frEWRO6lVBfukNdBXHY+rHnElY/ch0GD3qiLW7JGeSX1ON/jOMFLZXTCXxqU0mdyM21hHpRk1v9CRM96FmLK6JxbPo/lzhQ5NYrpJokXqO90DvElHG4G6xsrNQPg1/FpzvqleGBbJ5c348W0Sr2sqZXoWXIfzf/E72NgiWrXOdV1Vm17YMUfwOiHKnyId4gvIiApJ/yJC9OY+aMa3GOXhX68EWBcUKPR0pNqGufE6wqqIHurSORJply2kB8eW6rQkA21kzj4QdeQRV7Ac5tHpz+1cFG9u4SeIoOnT1vQbX+tpLndRDBXO10/sg/T+AFOJ/qX8L3Mo4ddlgsQFbWBF4pXb9Rf438KPPfVvqe6BiOsPLPjzIpq1VCw7nvUj3DnqFQeMcY9JnUhu0E10RxK3Kf//1ANtYOJoEJ4Vz776Z0kWTlTlFzCIvDd2GONjCEOO29P+Xog6EjlT3yg2yi8wxzCInMNToO7/xO52XxtwW+Riqs+Gfz9r8Xmq12t7S7Wjsped6VSfbeqSPIBkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(6486002)(966005)(6666004)(54906003)(110136005)(6506007)(478600001)(66899015)(31686004)(6512007)(44832011)(8936002)(36756003)(66946007)(66476007)(66556008)(4326008)(8676002)(2616005)(41300700001)(5660300002)(186003)(26005)(83380400001)(2906002)(31696002)(53546011)(316002)(38100700002)(82960400001)(86362001)(43740500002)(43620500001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzJNVVBJYTcrdUpiUndYTit0UGptRGJkbjI4WEFMRGViRGo3a3JkRW4wTHJj?=
 =?utf-8?B?VC9BZEJocWlLcmNOYnA5S2FnQk5oVGxMWFFwVlhOMC9uU25SNnFreWNKUy9m?=
 =?utf-8?B?bUdqd3kvMHB5RENkeDdMNDJOQ3JiRGw0QksycVFZMkRjN3g2K1VqaG4xZWlS?=
 =?utf-8?B?RitBdE5PUjdQaXBBYzZDSUVXVlZOT3Y5bm9Md2RFbUkySXFQdW1SRUN0NG5w?=
 =?utf-8?B?cGF6WGloNGhGZUIxRis3QzYxMFU0R21EaHFkZ0c4MDNOcXRNVXZmNHNPUUtB?=
 =?utf-8?B?aDlzVXRrU1M1ZWowQU8za3JKR3E4OVdvUUcvNE5CRzA4S09HaUFtM1l2KzhN?=
 =?utf-8?B?L3NOeHRJVElNTitLZjBFK1J3UWZSd2J5V0xBcnROL2FWYXFUSnFyeGZ3NkZ0?=
 =?utf-8?B?cjh2V08zV0d4SDErQ2NIdEpkNlcwRE13OHhXWmNqckx3aTZYQ2JQd3RJSTRk?=
 =?utf-8?B?eVRZTVNzYUgyS1YrTFlzbGlzK2E2WUh3TkRCOWQ3emxpaGtUSHQ5OU5MZmda?=
 =?utf-8?B?QmhveTNaVGVMWmI4Z1NIUU9LMFdqak9TNDdrVDhQYms5ek1CUmxpcEMzVFkr?=
 =?utf-8?B?ZXo1MkY1RmdwWDU4anRDRWw5Q0FUSHRhY0pHUXpNZ3VvR1phNFBiVUxkc1dk?=
 =?utf-8?B?cVd2bml5cGR4SGluZ0wxdFBESmFaamdES0F6Zy9wSmtSWTNvbkNOZUNPSndn?=
 =?utf-8?B?RzVjdUJQK1Vpekc3eEpmYlN5RWYxTHhmejVtZGtSSVZNTG5XZjlEN2VzR2tU?=
 =?utf-8?B?QWhSdnNGeXJuU0hvZncvbDlURXU2WmNCcmo1eE5pMFdpQ1Zkdm9ZNUdJTWM4?=
 =?utf-8?B?dEt2bFdTUk42cmN3OWtsTGxja3dVd3Qwa1Jkd2N3WVh0V2YzODI4T3E2eEpT?=
 =?utf-8?B?KzNGVHNLV0d2N2pxTzlGUWo5OU45MWpFVlhiSW5PM3k5Y0pWTjVKTS9vMTVK?=
 =?utf-8?B?eXYwN1hqSlJnNjZmYVJ5VTF2VG95VEY2VENQNWJPbSswZ1NhZnpLbEMzVElZ?=
 =?utf-8?B?aVZOcDJUUEpEdm1qekZla05VdG5CWDFkZmJzb2NpQmZ2Rlc3ZExlUWVvcU9Z?=
 =?utf-8?B?a3R5Ny9SQjRiYzFaRmJJVUlBSmo1MTJJR1djdTV6aU1acVRTYURQd1BoSGo0?=
 =?utf-8?B?Z2pkTmk4OEF5emhBa1ZyZGxzajlHTTkzUzNvdTBZbUJNM2Zxc0V4MjBZSWNo?=
 =?utf-8?B?dU9VSDlwTCtDOXgyZDdqcFZCSGRHb1NpNHJNZGdzeStickw0eDJLOUE1M1lW?=
 =?utf-8?B?MHFkWXYyOE1ydU5zMU1jd1I4Q3JhMVZKZi9tdW1oR1JyMHpCRmw5R0VrSVFy?=
 =?utf-8?B?b1Zmb1BnL3ErUjdtbGd0MHpQR2NwZVdORy9Rb2FEQWxiQjA3YStETyswNXdY?=
 =?utf-8?B?NUczamFVejNVblBMQ3RMRStYb0k5VVlpWElNOEl3ODFuL25SalRvTWZMR3kz?=
 =?utf-8?B?ZjNNVjFHTGE3WDZRQnFXWCt5QnU0L1dnV3pIVWJQbVdqS3RmYStjazdQOVZh?=
 =?utf-8?B?ZkRMRGNvUW5IcHNpWDl3WU40YjhHYmtjWGNsb21lRlQ3eGpOM0xieFp6b25Q?=
 =?utf-8?B?MUcwbml1MzdIOXNSbW12dTliWVVrdjlTb2xEZVdRbU9aRGNvdWJ2RjFHNmly?=
 =?utf-8?B?NkJzNDhGVXJxT1FmL2FQYjVVSWhVbWV1OEFFYmFoQWY5ZWVpVmJkeGpwTXE4?=
 =?utf-8?B?OXlMQnVSdVY2K2JxY0J2Y3BBQzVrcFFrMEUrZWI3UUc3R1N4bGdRUHdxMnZE?=
 =?utf-8?B?YjhXdzlab2lIcHFHRlg1Y1J1VWpSZ3U2V2xLZm84Z0I1aCtCbUNReXhhV1RL?=
 =?utf-8?B?NlVnVTJ2L0Mxa2Vmd29seENRdHdENFJjMVh1TWV5eVRRVXZyTU01Zm5OZyty?=
 =?utf-8?B?cHgzdXpWZkF2Z2tQcjJkemtvTFhGbUF4dm9KMVBYZWlndlcrbmcrMTliU3Ur?=
 =?utf-8?B?eEZMMFFiYXBYQ2FwK3ViNGJrYUxPckJHc0F4b0xWTFViSEJPZGR6ZFNMdTBJ?=
 =?utf-8?B?c3RsZCtieldZTnZIZFMzZFpMWUlDQ3NnOWRIMWIzRHM4Vk51UldHNlk5QzNz?=
 =?utf-8?B?WG5NYnN1OXRobUdYekg1ekVSdmQxcGlIZzFYaXB6b3lyNGNscTJPUW5Cektt?=
 =?utf-8?B?d0hQc3pXN21pUkRodnp6Sm9mNm9qSnZMTnlraGI4SW53NTUvUUZZQ1AyVzVU?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b04d89-8ff3-42a7-4b2c-08dac66a7616
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 18:02:58.8851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNswE4PghprIPOtvH3P+4u3EUhE2kzsmo785DwfnbyB4P5YZC6dBVEenwff9SgqI/fFo5kp4MUt0LaXzlQ+Fm8141i+Zk7zTgsEc8uAehPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4967
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James and Peter,

On 11/11/2022 10:38 AM, James Morse wrote:
> On 09/11/2022 19:11, Reinette Chatre wrote:
>> On 11/9/2022 1:50 AM, Peter Newman wrote:
>>> On Tue, Nov 8, 2022 at 10:28 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>> On 11/3/2022 10:06 AM, James Morse wrote:
>>>>> That is true. MPAM has an additional headache here as it needs to allocate a monitor in
>>>>> order to read the counters. If there are enough monitors for each CLOSID*RMID to have one,
>>>>> then MPAM can export the counter files in the same way RDT does.
>>>>>
>>>>> While there are systems that have enough monitors, I don't think this is going to be the
>>>>> norm. To allow systems that don't have a surfeit of monitors to use the counters, I plan
>>>>> to export the values from resctrl_arch_rmid_read() via perf. (but only for bandwidth counters)
>>>>
>>>> This sounds related to the way monitoring was done in earlier kernels. This was
>>>> long before I become involved with this work. Unfortunately I am not familiar with
>>>> all the history involved that ended in it being removed from the kernel. Looks like
>>>> this was around v4.6, here is a sample commit that may help point to what was done:
>>>
>>> Sort of related, this is a problem we have to work around on AMD
>>> implementations that I will be sharing a patch for soon.
>>>
>>> Note the second paragraph at the top of page 13:
>>>
>>> https://developer.amd.com/wp-content/resources/56375_1.00.pdf

Please note that there is a more recent version, v1.03, of the spec
available: 
https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions

> 
>>> AMD QoS often provides less counters than RMIDs, but the architecture
>>> promises there will be at least as many counters in a QoS domain as
>>> CPUs.
> 
> How do you know which RMIDs the hardware is tracking?
> 
> This reads like the counters are unreliable unless the task is running, and even then they
> might lose values when the task is switched out.
> 
> 
>>> Using this we can permanently pin RMIDs to CPUs and read the
>>> counters on every task switch to implement MBM RMIDs in software.
> 
>>> This has the caveats that evictions while one task is running could have
>>> resulted from a previous task on the current CPU, but will be counted
>>> against the new task's software-RMID, and that CMT doesn't work.
> 
> (Sounds like the best thing to do in a bad situation)
> 
> 
>>> I will propose making this available as a mount option for cloud container
>>> use cases which need to monitor a large number of tasks on B/W counter-poor
>>> systems, and of course don't need CMT.
> 
> Why does it need to be a mount option?
> 
> If this is the only way of using the counters on this platform, then the skid from the
> counters is just a property of the platform. It can be advertised to user-space via some
> file in 'info'.

It is not clear to me from the snippet in the spec if these platforms can easily
be identified. It sounds like the only way these platforms are different is that
they more often return "unavailable" when attempting to read a counter. If this
is the case, then knowing when to change the mechanism of counting does not seem
like a simple check.

> 
> Architecture specific mount options are a bad idea, platform specific ones are even worse!
> 
> 
>>>> [...]
>>>>
>>>>> I think the solution to all this is:
>>>>>  * Add rename support to move a monitor group between two control groups.
>>>>>  ** On x86, this is guaranteed to preserve the RMID, so the destination counter continues
>>>>> unaffected.
>>>>>  ** On arm64, the PARTID is also relevant to the monitors, so the old counters will
>>>>> continue to count.
>>>>
>>>> This looks like the solution to me also.
>>>>
>>>> The details of the arm64 support is not clear to me though. The destination
>>>> group may not have enough PMG to host the new group so failures need to be
>>>> handled. As you mention also, the old counters will continue to count.
>>>> I assume that you mean the hardware will still have a record of the occupancy
>>>> and that needs some time to dissipate? I assume this would fall under the
>>>> limbo handling so in some scenarios (for example the just moved monitor
>>>> group used the last PMG) it may take some time for the source control
>>>> group to allow a new monitor group? The new counters will also not
>>>> reflect the task's history.
>>>>
>>>> Moving an arm64  monitor group may thus have a few surprises for user
>>>> space while sounding complex to support. Would adding all this additional
>>>> support be worth it if the guidance to user space is to instead create many
>>>> control groups in such a control-group-rich environment?
>>>>
>>>>> Whether this old counters keep counting needs exposing to user-space so that it is aware.
>>>>
>>>> Could you please elaborate? Do old counters not always keep counting?
>>>
>>> Based on this, is it even worth it to allocate PMGs given that the
>>> systems James has seen so far only have a single PMG bit? All this will
>>> get us is the ability to create a single child mon_group in each control
>>> group. This seems too limiting for the feature to be useful.
> 
> It lets you exclude tasks, or only monitor a specific task. Its evidently enough for the
> markets those parts are manufactured for!
> 
> 
>> I'll mostly defer to James here. From my side I do not see motivation to
>> not support environments in which only one monitor group can be created.
>> My concern was the additional complexity involved to support
>> "mv" of monitor groups in such a constrained environment but I understand
>> from James (re. https://lore.kernel.org/lkml/8325a442-92c1-4170-1862-3bc891a8d6af@arm.com/)
>> that it is worth it.
> 
> I'm strongly against having parts of this interface work differently on different
> architectures or platforms. If it does, we may as well have completely different
> interfaces as user-space has to be architecture/platform aware.

The architectures respond differently though and software cannot hide that. For example,
resctrl can support "mv" for all but from what I understand there is no way to hide
different architecture behaviors. Users will notice that sometimes the counters
keep counting and sometimes they don't.

> Its perfectly possible for the filesystem bits of resctrl to support renaming monitor
> groups between control groups, with only a minimum of 'swap the RMID' that can be skipped
> if an architecture doesn't support it.

right

> 
> 'mv' should be supported on all architectures/platforms, and we should expose enough
> information to user-space for it to work out if its going to build a control/monitor group
> structure that relies on that.

Yes, I agree about supporting "mv". My concern is about the additional
complexity of attempting to have it behave ideally (eg. counters keep counting) while
users are not expected to use/rely on the complexity but instead use the additional exposed
information to build its control/monitor groups differently.   

Reinette
