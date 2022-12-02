Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4354640AF0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiLBQhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiLBQh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:37:27 -0500
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D479AFCD0;
        Fri,  2 Dec 2022 08:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669999045;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rcUVaCNQzmRD7Obzfp8CZjUyVvi7eG6zAuEaD05LcTk=;
  b=hWuWdSwTOzRCw5SNvzmwn+Mym+UvopPtPhyMy6l1AAV6cKc4m2KEOHf9
   y0Kn1u05yt55VtDIbtX1k4hG20c5N13rwiHdfEeY2AWdw7JIXhi5PKJQb
   hdsmx8fQjbyemJO0S+8k3h3ZNvjZy9JOPm5EMXEZ86MPr+flmqTBNsNza
   E=;
X-IronPort-RemoteIP: 104.47.70.102
X-IronPort-MID: 86308774
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:v32OU6tvkjBbHq58ww6l0xuoS+fnVJdeMUV32f8akzHdYApBsoF/q
 tZmKTrXb/uDYjPzKN4gOoq0/EME6J6EzNFkTABk/HwzEyob+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg0HVU/IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4bKj5lv0gnRkPaoR5QWGzSFPZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwLiwmMUuAif2Kz+i1aNNznpkzN8KyFdZK0p1g5Wmx4fcOZ7nmGv2Pz/kHmTA6i4ZJAOrUY
 NcfZXx3dhPcbhZTO1ARTpUjgOOvgXq5eDpdwL6XjfNvvy6Pk0ouiP60aIC9lt+iHK25mm6Co
 W3L5SLhCwwyP92D0zuVtHmrg4cjmAurBtlKROLnqpaGhnXJxnUrWFpMUGCSgtK2km3lY/h6J
 0sLr39GQa8asRbDosPGdxGxvnPCvhcaQNdWO+w89AyJjKHT5m6xHGEKRzNFQN8rrsk7QXotz
 FDht9foAyF/9b6YU3SQ8p+Koj6ofysYN2kPYWkDVwRty8nupsQ/gwzCSv5nEbWplZvlFDfo2
 TeIoSMiwbIJgqYj1aqh+kvcqymxvZWPRQkwji3dWXik9UV+f5K/YJKz6knz6uxJJ4KUCFKGu
 RAsh8ea/MgKDJeQiDaKRuQdWr2kj96AMTvThnZ1EpUh/ijr8HmmFaha+Bl3IEZkNJZCdTKBS
 EPapw4X5JZVJ3asRat2ZZ+hTcUs0aXkU9/iU5j8fooQSpt8bgmK+Gdpf0H492D1mWA+gL04I
 9GQdsPEJXIXD65PzzesQeoZl7gxyUgWzGjTRJn9wDynyfyVY3v9YakINliHcu0i7OWcqQHR8
 s5WO8qiyhNDXem4aS7SmaYXLFYXPT0yDoj3g9JYe/TFIQd8HmwlTfjLztscl5dNmq1UkqLC+
 C67U0oBkF7n3ySfc0ONd2xpb67pUdBnt3UnMCcwPFGunX8+fYKo66RZfJwyFVU6yNFeITdPZ
 6FtU6297j5nEFwrJxx1gUHBkbFf
IronPort-HdrOrdr: A9a23:Vw+RC6GscJThW+VRpLqE+ceALOsnbusQ8zAXPiFKOH9om6mj/K
 qTdZsguCMc9wxhOk3I9ertBEDiexPhHPxOj7X5VI3KNDUO01HIEGgN1+TfKjTbakjDytI=
X-IronPort-AV: E=Sophos;i="5.96,212,1665460800"; 
   d="scan'208";a="86308774"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Dec 2022 11:37:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caS2SCo011j4JJK1VzRXMYcNXzdHExjbGK4N/B9lIowboI4M8BpGc7CSmIduRQr7tFUPcW41ugZ2UICqVmSWdU4XGex+eZy2Y/XlbVkrdIZWRiAVu6JXBIxfcosJIIFy5s8Grw0m3ah6xAQmAtIVWNVgGS/FiROz0Pk/jl4EW+AdP47UefxKlyOE5+FQUOrSowhYxVa9aw+6RbET9ccZ9n+P2soszKs9YS3Ii87Er7rF3c0Zsv+tGEn2q0oqaBlUKkfZKkOIkyLdRr82ceHWbctM1zPkEmseMDc2nDMltVEi21O9NuIlEy85PCoIR0F3zljKZgGElOCl2bs+liIbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8EMr9olxyvoIiovWcoqyTykRTu2mwAaFzeBdbGQj2c=;
 b=feOkvfP+qMRtPQJKa2tjT3w7RXNVC/suWkioQI/AfIx+Y5wW40mlG1wDCWzhymbYHopQP1HirohchJ5V61xcfFyOdw8CPop6WbIWKswYbnk4m799nMDxiHmuvdPsYzMyly4Ode6jl+X1xM0ndu9d6SxhOR/Ps/UWT/ogbrM0zg0tGSyM9x6Lel98GkCvOsH/ZsWIsmDfy8KLxlYwI4Nz0anq4YndG2LV1wgO2VkSUVZcaO3e44oLzGpNYqMHW0GoSRN8mxMPRVxpdwPGDlzz8McLsMHMf6Z0WgON9CQPp9f/lUWSSGzlCZELnIFqQvaFXxq+kRUZoQ4CVg1pmnzDcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8EMr9olxyvoIiovWcoqyTykRTu2mwAaFzeBdbGQj2c=;
 b=sv4Lcf7KBMWIUrHzhxKLeLw92NdKXihiaH4IjSHTbTW/5K9wdwrqm5ZH27U395DZSM2OeCgs6yvCSK0m/ntDZuLs9AwGAtcGUJ3il0BYaJ+kaNvvAGSySaeX+QXpE0Hf/01xeOfeQ18+3Ss7uEpPzYcKF8ojtRmtIayH/rq06zQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by DS7PR03MB5608.namprd03.prod.outlook.com (2603:10b6:5:2c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Fri, 2 Dec
 2022 16:37:17 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1%9]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 16:37:17 +0000
Date:   Fri, 2 Dec 2022 17:37:12 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>,
        Alex Chiang <achiang@hp.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Message-ID: <Y4opuLnLIT3v9Aa7@Air-de-Roger>
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-2-roger.pau@citrix.com>
 <6b212148-4e3f-3ef6-7922-901175746d44@intel.com>
 <Y4d8cm97hn5zuRQ1@Air-de-Roger>
 <4a0e9f91-8d8b-84bc-c9db-7265f5b65b63@intel.com>
 <Y4nugxKV1J/BqhBt@Air-de-Roger>
 <93fd7ed0-5311-d6db-4d8b-b992a8f78ada@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93fd7ed0-5311-d6db-4d8b-b992a8f78ada@intel.com>
X-ClientProxiedBy: BN0PR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:408:e5::31) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|DS7PR03MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 69382573-af91-4979-55aa-08dad4837984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIphfKsqlzvzVEVjtzci8DNEXFC3s0CYysf0tvugG5hJbZ1zIBG4HjEneGwJ8cK70GINwh6i3s/76BbFewJYOhOAq86cSF3paOyKrSoWuizeNkOYsZ6GcCnO4oZNqswCiccfqDNHjgE/MPqJZ7/moYpu7UzJP/5LcGzXHkLjz/onOInX53bh+8fyVL0C3EaOv83vaI8p19xKeWFar8AwPPbKwzzU5p+Ng3lX6tPV4PrcLS8YRAGIoODBt6FUWwqwwETFTH5JDgA7HNqekvuZjAJ9tSP8S6A5SSqLFoBGlaSDkeLjqPkqcBPwskoA9xSfZhqKw88SdVZdKpxWXGY90K6h9wJ4QM6NQEdhT6vLk/qfYx2sNXMxxBkyA8cYdGsvr1ow0e+CmeuX6R/YX3kYVw+Oe31JE+8uNIdPhzKbc/Og7pCjLAeynbIb5rmQFgWgVzE5vZWLIjaYcBYIxkF53bmeqzslsFnfuqdRyv0JDmQin5RrFIfpwndAe1UtKlFccZVGMAH7VznJvmt5YrPONwyajsa52PPCBxPcM3IhS+uwbr7CtHA9PmFZzTqyddSjDiH2jya+FG5D5OZ0OT8T3KSlG1Uur+zjtDofJ4mMLMrq2hGeJL008gbCJzrKnZOtjEFKH0cE+S0y9ZALSox5lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(85182001)(186003)(82960400001)(41300700001)(7416002)(86362001)(316002)(4744005)(6486002)(9686003)(38100700002)(66476007)(5660300002)(478600001)(2906002)(54906003)(110136005)(66946007)(66556008)(26005)(33716001)(53546011)(6506007)(6666004)(4326008)(8936002)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlliZnJsS0dVQTNxd2psUDJkMzBmdzhMUGRPbER1OTFLa1BDbUhSdVdVWFQv?=
 =?utf-8?B?VHAzR2xKbHJnaE02SS8vcUlmRlVvUWhIdmw4NzFsUVVhWmhDVkx0WjBPWmFQ?=
 =?utf-8?B?RGo1eVJ1b0RydEM3TXVIVTFHTWN2bnhaZTRLQS9DSlorSWpKSW4vaWdOUGdO?=
 =?utf-8?B?RHZwd3g4V3hQLyt2SXZ5ZVhvT1VZZDVMeEp1Q2V3R1VHZExObHM0RmNRSGh3?=
 =?utf-8?B?ZTBzM2ZVbVZnRmdRUnhMcXVXVVFCTUVTSUczM1AxOHQ1bXBVNGpKd0RuaHN3?=
 =?utf-8?B?L1RFcm9OMjBmOE1NdlNaMXViVWNKZ3ZpMzA1RjFhaUlCUGVEVnAxL0JiVGNP?=
 =?utf-8?B?cStTRXZLSFNnSW5wWXNqVGFZMFNGWEtYR0FCRXhlUmFLWDVqeHhVMzZwVmhB?=
 =?utf-8?B?QXU1QjZORzloRFl3VmFVb1hUT3RobU1GaGRQRVpXU1F1anhWeXNZc2hhZHZ6?=
 =?utf-8?B?MlQxTDkvV0JKOXkzcG9BVC9aUGNhWFVGRWQ5d0lnVW04czl6d0cvWStDRG00?=
 =?utf-8?B?SGZKYmk3d3J5aWZTdm16cEdsUGNBNW9jUVdZREJMWjh1Sk5maVhvK3JLaFlj?=
 =?utf-8?B?ZE5HMTJDdFQxaG9IbHBCdldQQi9ibmp0Skk4TlRKM09kTkpsVEF6d3FnTzlQ?=
 =?utf-8?B?U0x1NEI3czZITnVDWDVpTkpVNmhLVHlhckwyVkFxV1g0K1Jjbk12Vm8zeXls?=
 =?utf-8?B?cXhlUnA3S1N6K0Rna2RCY3VvZ0hYelE3Zmc3YXJnWXFiM3RVcEdGUkhreklV?=
 =?utf-8?B?aUx6ZktvMVNURnh4LzE4NWVjdktwYTgwcUQzT2N6bTRIWVJJc09RYXVpZk1q?=
 =?utf-8?B?SmhrSzl0R00wSzdhVUdHS2pmeC9xem1PWGpLY0c0ZjNPWmh3MDZZR0dQMzlu?=
 =?utf-8?B?QTFxdVViaTZJL0RTaTVrQkZGcVdPSURYVjY5T0dtSlJuVUtqMWpQVkxUdFBj?=
 =?utf-8?B?aWRnd3NEcVhSakJuZXJueEc1dWNjdnJJQzlWQy8rWWFoQ2pKU0dLY0xYS3lx?=
 =?utf-8?B?Zk42SmpJRVZtWVVQWDlVT0VzTGJwZThYYzU1eTBDRmVoQ3p0SXpnN2VEalB6?=
 =?utf-8?B?L012MSs0UzlwUnl4bkVzQXpCQU1qUGZ5ZVZTYXoyQklpeVNMS0xiWUVLU1ho?=
 =?utf-8?B?Sk1mUWl4cW4vQWt4VFFsZTBNUE14dkRpcUlRanRKZGhaN2VDQnYzQkQ3WEVi?=
 =?utf-8?B?VVJDRXhxMEtlcFRUbGdaUGZFNnNJTTlrbnFyMTNvcWR4UDBNbEtESnVINTdE?=
 =?utf-8?B?aHpIRjBSTkdFQmwrWnQyY05KazEycTVmbFlVWFVXMDUxUXV1MmpnUEFXRFJ4?=
 =?utf-8?B?WmlOQ283TVFyL3YzUGtlM0pLN3I3TTc2NEFNa2lSZ2dWUmE2ZStwMkNOR3pO?=
 =?utf-8?B?djlhbGhxV0pQa3ZkTXBlYWJrb2FFVXhONVJkL0RDU0sxb3J5TXBSYTVhSkRl?=
 =?utf-8?B?R0Z4bDNYWVVVV2VrQTd5Zjd1alBZQUdnNExyRkljN2NMR3NhZ0dBNEcvUFdR?=
 =?utf-8?B?YnJ6Z01GTjJFdlA0SkE2YUd1azN6anRvUFdZYUpWdDhzbDhVU0x0WnBsa1pD?=
 =?utf-8?B?OXlNcGZmTkN1dlZobEN5czFncUQ2dFZPYzFGVTZxSHpOWEpqMXVFMTRSNFFw?=
 =?utf-8?B?endKL3JxOWpQWFBDaUpKQ2crMXlJLy8vcW4rcVROQXFwVTVzU05lYTZwaEFl?=
 =?utf-8?B?VlBQb0R2WCttVExGRlQrSE1mV21WY3Y0bm1GU2tDcW5KWmU2Nnlla2lXaVhK?=
 =?utf-8?B?dGROUnVXSk1NUFBvNXFQRVR6cVJUVFZPL0hldkNGOCt3aERDNCtleW9WQU1z?=
 =?utf-8?B?RjhKa1FReGwzYjNYSUNta2tBd1VacU85azBJbFluUUtoVlR5QlNhMzkzc3Ux?=
 =?utf-8?B?eExwVTNDZk9DQkIrKzNsQVNUYmlQMUZuNTl3YXc2TVRnVXNNdTJUNUdpYklQ?=
 =?utf-8?B?cFMvUi80cG55eDYyR2NSTFl3RzJrbjZIVWd2NDZHSHBvOGdKUGllZnZmdWZG?=
 =?utf-8?B?bkN0NXRNOFhlYmEwaWE2RG9ZbnFFdWlZYlJIUnl6dVg2blhvVmc4V0NhSStX?=
 =?utf-8?B?SUxUVEdzMTNtNzVWTWw2WkhubkdpN3hEVGV4WTltM0ZZUTQvMy8vV3lLcFZh?=
 =?utf-8?Q?OzupA7G0okD7HTf7lsLNPfqTi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dXltcjdkTUhhRDRDSWRqSkNwSTZTaXc3S1lDMHBhNHMrSjR2MU9YOGRRZkdU?=
 =?utf-8?B?bUtzOEVUTGZncDcyQTdDYTdYSmZZK0hGZFN2RGNuTm1ubmpaRER4VlhuZE9h?=
 =?utf-8?B?UTF5Zm5JZnZJTkY0UlR4VEk3Zm81ZUlMV3plSU10K3BzSDFtczZpMElwR3Qx?=
 =?utf-8?B?UTdFTWxQeXRTZDJVWFdxZFhZVGYrN0J1WXZib0Z1OE5QV25mMmlTSGpNdVh3?=
 =?utf-8?B?Q2E3ckNkZXVCcld0TFBRaUJpNko1TUFWa1RRYit5Y2ZTNmZ5cUloM1NzcFJm?=
 =?utf-8?B?d0luSFZWRW1iRTFZaGtRS3ZkVXNmTXBVMFlsODZUNUxvYzRmYjlyM0VIaUpm?=
 =?utf-8?B?M3B0dGJhcHFEQjk3QXpIcjlvU2Z0UFpQZFhtY2pUWjZXZ2lTemlyVXBCNGlu?=
 =?utf-8?B?aklETS9EQTVNS0ZyQ0h2YWFNRUptZVlIMG8rWXVRNlphN09OU2ZFQ1NtNDlC?=
 =?utf-8?B?LzhxL05zTGh6dkRzNVhzTmxTV2RaOHJ4RkdBRjVVdTZjZ2ZUQlQrVE9jV0Zm?=
 =?utf-8?B?V296bjNmWUlNdFZqS2Nmc2VhTTlWVlpTR1hQUzZQYm5qR1ZSMnorNy9tU2x5?=
 =?utf-8?B?MUs0clV0S1VBM2RISHFpcFdMUHd0K1BWZU9FZFRZY05BVElMU1UyZ29JNExP?=
 =?utf-8?B?N1VacDQwdVFITTJ0bWd0VkJDRzJyVlBBeVVpMC91NHJocCtXRzBYM2FwYWNZ?=
 =?utf-8?B?TWp4a2p3bTFyVXR4dXRrYVAveWVrSWtGT0cwcUpuSitqS0xhSW9JZGNXYlB2?=
 =?utf-8?B?TTJ4V0JuWVk3TVNYc1h6R1BlMVZXYXBJZzJDZUtOSTE1WWtlUVQzQ0UwUkN1?=
 =?utf-8?B?YzhQRDRKSzFTTXM1OUZ1YmtXdnVGcUc3UW1SUzlOd28xQkxtWXlaQUNHaklX?=
 =?utf-8?B?USsrOVhWT1FHSlQvejJpaEo0N3Q3bXJMd2tzK2UwQjhkWHB1SUtmUi90cC9l?=
 =?utf-8?B?N0NKWVZ5NzE1cjlIcGFCaG1ab2c4bGR4a2VWK1B1U2JlTGtmMnZWY2R5cmVl?=
 =?utf-8?B?UjVJTWNUT3h5Z3V5R3hBS1dRUjJ2cXg0LzhJbSswTTI2TnE0RmRLUnNhTGRN?=
 =?utf-8?B?dXArdlk5YWVDa3piOEF1bDdUeUtoeDhyUWE1YzRrQzgxUGUyUld0ZndhdzBn?=
 =?utf-8?B?andPODVkMVVVblJ4a1FhYzhBaTdVU29yVHI3SG9FekdhclBiRFFoWmMwNmly?=
 =?utf-8?B?OXdPeWpQRnFab05PaFZuMGsxeFE3S3dzcEw2a3hLMENXL1ZjNnFyN2hUOHI4?=
 =?utf-8?B?MUZQZCtGZi8rdUVpcXpDUHdZRS9tQ0ZmeW1YQnpXK2JGY1BzNlczazhuNmJU?=
 =?utf-8?B?REQ2QVN0aTlOYWltMGlnWHUvQ3BwZEZjYUxQNHVhaVhrQm51Z2QzR0xPSk9P?=
 =?utf-8?B?WkoxWCtieUljSjArQUVsNW5LemJLSGo4dFdpZkp5VUt5Nm9ZWG10dTBGZjhz?=
 =?utf-8?B?Y0wrbTdWbUM1QXA4cWwzWFg3c3NmVmVoRm9NdmVDekxDN1pOMU1DK1ZscXRW?=
 =?utf-8?B?Q0R1eE1CczRTNkk3VlNERTZMNzRRd29yeWpDRGZybmJmdEU2VndranVyZE1r?=
 =?utf-8?B?Ni80Wi9MMVBsN1hkQjRnSzRjZ3Q5NjRqUXFEc2swdDZNTVo5VzFQWlhCVzRV?=
 =?utf-8?Q?R7d77dvri8LFerZ31+14udZ4kHM+jld0+Hu9CTLs+gb4=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69382573-af91-4979-55aa-08dad4837984
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 16:37:17.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDfpTnLUjuaX2fkbMxwUIrnCXNYgYmRwLDwVYIggutN9yBSsmO4DvPl9LQJKKoHqROTBrN64UaccrrqqBNNhTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5608
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 08:17:56AM -0800, Dave Hansen wrote:
> On 12/2/22 04:24, Roger Pau Monné wrote:
> > On the implementation side, is the proposed approach acceptable?
> > Mostly asking because it adds Xen conditionals to otherwise generic
> > ACPI code.
> 
> That's a good Rafael question.
> 
> But, how do other places in the ACPI code handle things like this?

Hm, I don't know of other places in the Xen case, the only resource
in ACPI AML tables managed by Xen are Processor objects/devices AFAIK.
The rest of devices are fully managed by the dom0 guest.

I think such special handling is very specific to Xen, but maybe I'm
wrong and there are similar existing cases in ACPI code already.

We could add some kind of hook (iow: a function pointer in some struct
that could be filled on a implementation basis?) but I didn't want
overengineering this if adding a conditional was deemed OK.

Thanks, Roger.
