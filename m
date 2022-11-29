Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDC863C497
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiK2QEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiK2QDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:03:51 -0500
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550C3697EC;
        Tue, 29 Nov 2022 08:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669737722;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=PrFm27z1zc0OwMZsL9ZXCzX0i1AqS6Wt1aNcTR+jTwA=;
  b=K35lKhrYUs8BQ5OB0wLDWpyaAhw5UBJV12Mxzs01A+bF15KpAlJSA3Ni
   Ks6AbOsbetFVtyGRByooPyDsxOjAQ+9bBBAtmHknK+P8lJM1FUaZxibyh
   I2EuDEb8n5FM7VQGuZgtN3XuQ5V0Qa/80y1SDMpL/3yOBda7C8IKRv54c
   8=;
X-IronPort-RemoteIP: 104.47.74.46
X-IronPort-MID: 84821706
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:GIHtg6jyEbRef41DEIXJ1eMDX161SRAKZh0ujC45NGQN5FlHY01je
 htvDDjXO6yINDDyeI93bIWy9RlV6pCHnN83QAZkqC1mRCMb9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmUpH1QMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsy+qWs0N8klgZmP6oS5QWPzyJ94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQBcjRRfyDdoNmq0ZehVsY0i+YYdNbSadZ3VnFIlVk1DN4AaLWbH+Dgw48d2z09wMdTAfzZe
 swVLyJ1awjNaAFOPVFRD48imOCvhT/0dDgwRFC9/PJrpTSMilMtluSzWDbWUoXiqcF9hEGXq
 3iA523kKhobKMae2XyO9XfEaurnzX+rAttNTOPQGvhCsG2W4Wc/MEQtV2CVqOurjxaye9RHN
 BlBksYphe1onKCxdfH5XhulsDuHswQaVt54DeI38keOx7DS7gLfAXILJhZRZdpjuMIoSDgC0
 l6Sg8ivFTFpqKeSS3+W6vGTtzzaESoaN2gZfgcfUBAIpdLkpekbhBXVT80lF7WplNrrAjLh6
 zeQpSM6ivMYistj/7m0+UDvhzOqu4TTSQg09kPbUwqN6wJ/a4mNfYGk6VHHq/1HKe6xREGpt
 XwFls7OquwDZbmBnTKABuUEGqqk4d6BMTvBkRhuGYUs83Km/HvLVZAAvhl9KV1vP8JCfiXmC
 GfToQp59o5PO2HsZqhyC6qrAsojwKzIFtn/UP3QKN1UbfBZcAKB9gltaFSW0mSrl1Ij+Yk2M
 peaeMCjJXYCT69gyVKeWeob0rY3yzs+g3vaQZT61x2r0JKfYmKYTfEON17mRuQ46r6U5Qze6
 9d3KcSH0VNcXff4by2R9pQcRW3mNlA+DJHy7sZRJuiKJ1I6HHl7U6OPh7Q8Z4ZigqJZ0P/S+
 W2wUVNZz1y5gmDbLQKNaTZob7aHsYtDkE/X9BcEZT6As0XPq671hEvDX/PbpYUaydE=
IronPort-HdrOrdr: A9a23:Cwpd36zQCMi0drvUTPQWKrPxTOgkLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9wYh4dcB67Scy9qFfnhOZICO4qTMyftWjdyRKVxeRZgbcKrAeBJ8STzJ8/6U
 4kSdkFNDSSNykEsS+Z2njeLz9I+rDunsGVbKXlvhFQpGlRGt1dBmxCe2Km+yNNNWt77c1TLu
 vg2iMLnUvXRV0nKuCAQlUVVenKoNPG0LrgfB49HhYirCWekD+y77b+Mh6AmjMTSSlGz7sO+X
 XM11WR3NToj9iLjjvnk0PD5ZVfn9XsjvNFGcy3k8AQbhn8lwqyY4xlerua+BQ4uvum5loGmM
 TF5z0gI8NwwXXMeXzdm2qn5yDQlBIVr1Pyw16RhnXu5eT/WTIBEsJEwaZUaAHQ5UYMtMx1lP
 sj5RPQi7NnSTf72Ajt7dnBUB9n0mKyvHoZiOYWy1hSS5EXZrN9pZEWuGlVDJADNiTn751PKp
 gmMOjsoNJtNX+KZXHQuWdihPSqQ3QIBx+DBnMPv8SEugIm6UxR/g89/ogyj30A/JUyR91v/O
 LfKJllk7lIU4s/cb99LP1pe7r4NkX9BTb3dE6CK1XuE68Kf1jXrYTs3bkz7Oa2PLQV0ZoJno
 jbWl8wjx98R6vXM7zP4HR3yGGPfI3kNg6diP22pqIJ9oEUfYCbcBFqEzsV4o6dS/Z2OLyoZx
 /8AuMTPxbZFxqfJW945XyBZ3BsEwhubCQ0gKdOZ7vcmLO9FqTa8srmTd30GJ3BVR4ZZ0KXOA
 pxYNG0HrQM0nyW
X-IronPort-AV: E=Sophos;i="5.96,203,1665460800"; 
   d="scan'208";a="84821706"
Received: from mail-bn8nam04lp2046.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.46])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2022 11:02:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvrwkeU1KKLrFVtFRShazNzuIgbpps74tarsGUo077rULOhYrgG/BDp8JUTGAAHwi5yonEOFET6w6agBRsV02D+UvlgBwOB7tuFfqQs6JBNokZVez8dOEEMxNaELvsLlfStlj/PMz+LwJcAJwRf+r9Au9afZqKKkf1OSz+1uiGzvaerHpAkxOFnOXQoUGhvewjjOyNbmCgRTCU5ZvI1Ajfe+vmDFcNGAreNo6eP5snzHb+J9ZsvBuVWPvKcRDPVSBqdMipJk9D6xhdR4I6VEbL9hAtCZGZGws0Wmrc+bwyoh8AuNPI05aoyF+rJenpzYB36WM2eNIuXnStxaZ3s2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq9Yk9+XavfdcBteaeRI2vnuzqi1nZvTGG84xVpeLXA=;
 b=UHiKlXVv4fd9PQbkvFkPvdwPUT7wzN0xi5FsJVF1nBy782GjEUsvilikqzEgcvXl+ACVxDmsz5gGlbn6b2tMiG8wy6UolxnE4Xlz9SNeK8vUR6+lnUWX6+x/rqCiODnZJfBKRbZmWIGloxLwCzmnybqPAGd/TjrQzSTDn8h1qZZeiCf1whRpRgjhPQSBhZ6igujcP8ksX94OV3+HJr3U4i6apWg1k7rWBL5N3F72aOwJ1dAYW3+eAu8QUQSn3h03pELVAU1UEyWkvxBjrhgGnygxkAhBnbkYXykvDxQl99J9bSphItgcH8U08Pu8NdJADaUPtk50eAr8spnSBwt+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq9Yk9+XavfdcBteaeRI2vnuzqi1nZvTGG84xVpeLXA=;
 b=cF1luohJt9+4TSL4IMn2mQDBseoyg1NliDTMG7tTJ5K/hPAmD7MT2vaRDON3E3aki5dhldmtOTKJsrK066j/HxkwvqoeFhh6ddt05a4WlJYuLyYqO6bg6kOWi5yNCI6vreRjiVBT5JnGD+p+n+2Jf9eEAm8kBokChkAQpyvxKig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by DM6PR03MB5244.namprd03.prod.outlook.com (2603:10b6:5:249::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:01:55 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1%9]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 16:01:55 +0000
Date:   Tue, 29 Nov 2022 17:01:48 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Alex Chiang <achiang@hp.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Message-ID: <Y4Ys7NCpeCrNtS/p@Air-de-Roger>
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-2-roger.pau@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221121102113.41893-2-roger.pau@citrix.com>
X-ClientProxiedBy: LO4P123CA0182.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::7) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|DM6PR03MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e615bd-9e8c-4010-1658-08dad223086d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HA7T8Wf1gDv3CN1nCTK4aKrdsbWF1i1yhBe7W3Opy97CmL+qqhFEpakYySBryLqPe2b2m2b7T0+UXTndNuuoIDFiwihyZYrvXXD2U4PgXLtD9uDwJsnApY9BqubhElQ3Uqq8DTwlF31NJE9VauFnKBxMfZmeU4EdjI/oAWiUVmqsSI00mHEisdWj1mZhfiwV2kp3A54HZDOAxpR/3JtUBHEX+lIJsU6JTzRLNp0yoM5W5Wxeh9XsuEScMe4qJU+RDEmhBqcVS8IDn8vHIeORzQxUH9qsKMQD1ZwS0R58/+BmuBihsLYnfdaAbKqHLVcKUx4ZKlrZWjc5Z8x0fKQw6Iuoi+e8jwC/PC2v8KRsvw9d4DK30UsLoHNlpzGFpjV6ero/Q+fOHKWQgmVXEMIZU5vTYSQbPBDn0p9AJ+9ADp8afIvKv27tz7dK0caLyEIZUZSC9fQj5eXVA895Mi8XHZPxNimsBWCLD439l1K+z+NSgFU9377EhtBaGdl/AuS/zv7DDUapYGBngbx4lFLAhuYyWhkGDTfLC39hQAL6sI+mnAyitFPjxKs+XV+Wr/MyfRIhV2rVG13PT8q2lB+jAMyE8dw3RFwfyfwaQ6nHKHmaXaEeDJ+nG5O18MhNmgSxrEl4ETGfh4t1d8+V8QwFJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199015)(6506007)(82960400001)(38100700002)(85182001)(2906002)(6666004)(41300700001)(33716001)(8936002)(66556008)(66476007)(8676002)(4326008)(6916009)(54906003)(6512007)(9686003)(66946007)(83380400001)(478600001)(316002)(7416002)(6486002)(26005)(5660300002)(66899015)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UytGS1V2OU0yMS9hZmtKaFVTczlIOUZsNVp3Z2VabUVpQ0p3ZkxXU0dvb1N4?=
 =?utf-8?B?ZWpBUmpBaEpKN1V6Y3I1QmRpOFdyZ3VQZTJlYTBSVlRDL0FsR1ZwZjZHd0dB?=
 =?utf-8?B?cUlqY2luSzdTaGwvZTMrTVhjOUJ2cU80Q3VudStSL04vMStCOWJJTklmU3VC?=
 =?utf-8?B?SlZrTXBnS2lOTkdWVnhpdDBvNlh0RnRxMDRIcDVLSjRKWExYNFJmcFhrR08z?=
 =?utf-8?B?c3E0YjBMcThXZzlqdjJyQWJ0MmRzcWZrN0xnanU5UjB4bVhMQmswbmJGeGNP?=
 =?utf-8?B?c2M0V0JoYlRGeTg4Tnc0dG4wMVN0d0NWRUVPQTVIbkxhdjViblY2NEg0Ymhz?=
 =?utf-8?B?T0tpQ1Z2a3liVHhPeC9RLzJVZzlaSnVuVkFDRlh2THNjdk0wRFhzeGh4YWpS?=
 =?utf-8?B?UUNCR0NWOUtyUXFTTGxtekVjTGdHc0FkR21MZi9GNkMwckp2bjU5bkNxWnZZ?=
 =?utf-8?B?UU1OTVBnRFArZmVCNmo5T1BkRTh0aXVmTmhucHVHa3hnT2pyOFd5STV0TTZM?=
 =?utf-8?B?Q3pHWFlwLzQrUVZOT241eHo1dERPWGI4RVBEMElWY1FabzhWdGYxV1FzTWp0?=
 =?utf-8?B?aXM3Zk5wMHJnLzZvY1hKOElVZUEzbWxnRlFOOER4YmtHc1Y4WGdrYXFjMWJN?=
 =?utf-8?B?bnhDM0pVWGd0aEJQNm01SHNYMlVqMHArT3BHNTNndnpqbFRJdXprczdwVDFD?=
 =?utf-8?B?dU5UeXpkRmJ3M25DNU5FVG9uQjRzUnJiMXRYdC9PbU1udHE3UXVlWFdoZC96?=
 =?utf-8?B?dHU4SHBBQmlwRXg3Nk5Wemx0TzlxSmZ5Mm9UMFpyQURrT0xDYUM4eGN5OWFi?=
 =?utf-8?B?cFdpTWdWQzU1OHRjWDU5dm42L2xrQkJBNFBlSGs0azRCZWdZZFB5eHUvSWk3?=
 =?utf-8?B?dFBORkgwTzd5NnE4WVNCc29aanZZeUJOTkUvdmhHOXd4YTI0cnlhRVI1WDJa?=
 =?utf-8?B?VHFNUkVsSkFleE5QellpZXY5aUhjN1J4V2QvcndJQTNCbE5sLzFUclozWXlD?=
 =?utf-8?B?bnJPUVpYMnppNGU2TnpkdHlRdGJTLzdiUzhYb0RRbWdGQ0swa3Z6MEhYdmJl?=
 =?utf-8?B?TmM0OFN1T0VTeEhJTFFiUy9qbjFPbWZqOUdud0FJNy9HOXZZU0k0dlF1ZXdm?=
 =?utf-8?B?K2tYK3RPVDMzdU9Gc25TQUZoNDhkby84MWNFOWFwM0tML0V6WDRDcWtJbkFB?=
 =?utf-8?B?RmJXeG5JUndqbzNRbCtUaEExNmZuSUFPTEVYeGR2RkpUd1R4ek94Q1RuYmFk?=
 =?utf-8?B?RDB4L1JKalgwdlcrZmJMRllrVHFoTDl6QjVDdlE2QXFYQWxUdEhWY013Lzdi?=
 =?utf-8?B?WWxXSjhramJneGh4RXJJTksvd1FQaHpQeDh0T3ZwYXhSTjdMMFZqd3lNRDgy?=
 =?utf-8?B?YWtOR1NaN1IvT0NiYlRhdmhaNlVQakloSy9PQm0vOSs1T1pzYXM1ajMvUkNC?=
 =?utf-8?B?Sk1lakpzVGlkU09DQ2lyMi9ReTFpQnZmZzhiWE8xaUZXeEFPeExBRXNSUm9r?=
 =?utf-8?B?L3hmUkhsekR0QzBwdi9WTGdvWldWeUl6UDhlNFdvZzM3UDB1OTVFSEtmK0Fs?=
 =?utf-8?B?OHVJRnVPcEZBWXViSHluN2pDZ0VwM3NLWmR3T0U3bjlQTGdaZytjVk4xd1Bk?=
 =?utf-8?B?cTlmOUtPM0h6Sm9tMmMzS05NSndDU0QyVnF0czVhMU9lUUU1cDJxSnZ0MnYz?=
 =?utf-8?B?eHVwdi9vb2plMW1DdXBWdXpzWm9KZVhxWlhvNjhlb1BHUlRlWXlxVDUxT2FM?=
 =?utf-8?B?ZzAzeDJqYmtjN2VUQ2ZLcS9yZnZtQkxXWDV1UmRUTm1RNVQ2cVJZRm5XcWhr?=
 =?utf-8?B?L3hyRHpoa3lQUDJrL3hhK3RIOVR4R0cxUzVudjN5Tkk5NHl2a294MTl2UVd0?=
 =?utf-8?B?SkROZmltQ0N4QnJGRCtNSzlOdUQ5bm5YNmJld0ovTEhWSGFMeHFNMUVwUGhO?=
 =?utf-8?B?bi9oUEpoZkFSYlJ3MlNpYWhXT1M5a3dnR3ppNmcxM1M3UU80NUVRVkpCTFVN?=
 =?utf-8?B?VkFaSnZSYXhJeFU3dzhRT3pRckRBVVR4VmxnZHN1YVh1aGdraVRZanpPQ0U0?=
 =?utf-8?B?Mmd6NWlrMnBYSGl3N2hTTlhPT3FGbkxwVmZaMHZ6Y2ExQlFmQStSczJIeW1Z?=
 =?utf-8?Q?9ne2cgVqjQRCRBBaK3tyRaFqS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aWJ6dUIyckhtV2hJdTM3ZmxUWTBWaTRXelcwNGhVdXVjZlpiOFhiYzZTemlH?=
 =?utf-8?B?a2VhQTJTUzViNU5WMGFkYTNHM3JIVThxNnhkelhtbDhvcHYraUszbE0wVkZ2?=
 =?utf-8?B?Z09uOUpGSWh6Q2FjVG5SSTJCTjU5V0lpMFJFN2NYS29sb2NuSklKcndlaE5K?=
 =?utf-8?B?RTNpNzR1NU5jVGtpM2tUYmN1ckdIRXlXRTBKb0F4QUp0Zk1reXczNFI2eXFP?=
 =?utf-8?B?M3NwK0lNV0VtbTk1RWx1TDVkV2lvMUJKUTZwOXF4RVBnQVhjcWtNOTZ5TzhN?=
 =?utf-8?B?ZnpQMlFTSExselhZdk5HNVJlam01cDQ2cE5EZDRabHJNSDJWZkd1MmhKNmcw?=
 =?utf-8?B?enQ5WklDT0t6WE1PM1AyMFphYnhod3JHaDNvVmVlNk1IK0QxKy8zSndVRU8v?=
 =?utf-8?B?bDNoOEZ2WS9XblJsNGFkcmZwSVIvSWhKMXFaNzB1aG8zRXpVZjlQQ01nZ1lN?=
 =?utf-8?B?YWlEMjFTckVxVHNQZ3hxaXJEQlFBeDlUMVN2QWJzK3gyZDZkNzVKejd1Qncw?=
 =?utf-8?B?VjhSWld3NHdjMjZLWEFHU21tQ0RYSG11cHdMNHcvM1hGMXIyTUdPMW9YYThB?=
 =?utf-8?B?NEZ6SlcyMWxRcGRvakMrUEkycWkvbjNGVUlhS05FNXlMZmRQY1BJbCs4TkVS?=
 =?utf-8?B?amNBN0R6ekpFU0N3cS9NTEFwZ2VvWTQ4Y3RyZzFsd05paW83TU8vamlzVEpY?=
 =?utf-8?B?b1RjZUgwN1Z3WElleGt3b210bnROZHNIR0lKbDFNQ2xSNFZPZWlRK3FNTEZo?=
 =?utf-8?B?RXZza3o3M0VPd0VEMlJsYng4M2hkbThuMGlSQVRYTlZDcXN4a0tTNkphcjI5?=
 =?utf-8?B?ekNsMXVBTjl2UmlaZ1p1T1VtcWpZcG9aemF0RnJUbk51NysycmczcitMRGVE?=
 =?utf-8?B?b2N5NlVCVlF3UlZVanNydzRkUnJQY3lQa0tFVTluZVFvc0pXallibU1rT3l4?=
 =?utf-8?B?Y1R0ZlZzRnJwcXRDeGZ0MXhRL1JWandibU4xczlqRmdya1AzT3dyNTFxRkVl?=
 =?utf-8?B?R1FrS25ZMCtkOXBURnZuMkFxbWx5YUloYUpXb0hHQVFSZjBTMXVDNHVtaEc3?=
 =?utf-8?B?N3AwY1hCTjQ2c01MLys3cFVSdkg1dXZMKy9WTVA1L3FyWURpREM4N2lVZzB6?=
 =?utf-8?B?aUtxRmE4bmV5elNpWC9SNUtubEE1VVpWbW44REcva1FiY1ZzaVpGVngyaWV6?=
 =?utf-8?B?WEQ1eWhUWGlZTVp6YjJUT0FxaTBiV2xZVmkvUUpQL2EveVRwSXNycFNVODZK?=
 =?utf-8?B?SGlNZWNSb1QzeW5xMWwxSWhyYUl3ZERnMmZCY2t4Q1RHdVRXYkVNZ3F6ellp?=
 =?utf-8?B?dE80b0RaWW05YUZZRDVFOE92ZjVSeVEyUUxGaWhXRSsvUjNNZjJQN2JycGZl?=
 =?utf-8?B?OTVObGpOZlBzTTcyVWJBeHBMNzlQbzhJU0FTWW04Sy9kMlhHaU1mUHZUd0cw?=
 =?utf-8?B?bzNiUnZMZy83clRIOWI2a2lEYTRSQ1V5NUp4RWJPSVBUTXdTbnVIb0FXdEVa?=
 =?utf-8?B?U25GNUNRSm5QcXlzZ1NVcXdQTy9wMjRGUjBQWmkzNnF2M056ekdCS1BBcm9V?=
 =?utf-8?B?RUFrb0N0RXZNd0Z4RTdacUVRVVhhMFZNVWs3V3YxMEFwUnY0TS9oaVRScWI3?=
 =?utf-8?B?eXdRajNzcHZia2l1bC9SZVlzL0NmUkE9PQ==?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e615bd-9e8c-4010-1658-08dad223086d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 16:01:55.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+Ohft/lEiLlv+nC2UdjGvYOB2wWA8CbPqEAGiEhOf+0iPtPXy+DqnzhyyKr7H588AEViNl1oGKx3ttKH8fpUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5244
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

So far I've got some feedback from Jan which I've replied to, but I
haven't got any more feedback.

Both patches 1 and 2 are required in order for Xen dom0s to properly
handle ACPI Processor related data to the hypervisor. Patch 3 can be
deal with later.

Thanks, Roger.

On Mon, Nov 21, 2022 at 11:21:10AM +0100, Roger Pau Monne wrote:
> When running as a Xen dom0 the number of CPUs available to Linux can
> be different from the number of CPUs present on the system, but in
> order to properly fetch processor performance related data _PDC must
> be executed on all the physical CPUs online on the system.
> 
> The current checks in processor_physically_present() result in some
> processor objects not getting their _PDC methods evaluated when Linux
> is running as Xen dom0.  Fix this by introducing a custom function to
> use when running as Xen dom0 in order to check whether a processor
> object matches a CPU that's online.
> 
> Fixes: 5d554a7bb064 ('ACPI: processor: add internal processor_physically_present()')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
>  arch/x86/include/asm/xen/hypervisor.h | 10 ++++++++++
>  arch/x86/xen/enlighten.c              | 27 +++++++++++++++++++++++++++
>  drivers/acpi/processor_pdc.c          | 11 +++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
> index 16f548a661cf..b9f512138043 100644
> --- a/arch/x86/include/asm/xen/hypervisor.h
> +++ b/arch/x86/include/asm/xen/hypervisor.h
> @@ -61,4 +61,14 @@ void __init xen_pvh_init(struct boot_params *boot_params);
>  void __init mem_map_via_hcall(struct boot_params *boot_params_p);
>  #endif
>  
> +#ifdef CONFIG_XEN_DOM0
> +bool __init xen_processor_present(uint32_t acpi_id);
> +#else
> +static inline bool xen_processor_present(uint32_t acpi_id)
> +{
> +	BUG();
> +	return false;
> +}
> +#endif
> +
>  #endif /* _ASM_X86_XEN_HYPERVISOR_H */
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index b8db2148c07d..d4c44361a26c 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -346,3 +346,30 @@ void xen_arch_unregister_cpu(int num)
>  }
>  EXPORT_SYMBOL(xen_arch_unregister_cpu);
>  #endif
> +
> +#ifdef CONFIG_XEN_DOM0
> +bool __init xen_processor_present(uint32_t acpi_id)
> +{
> +	unsigned int i, maxid;
> +	struct xen_platform_op op = {
> +		.cmd = XENPF_get_cpuinfo,
> +		.interface_version = XENPF_INTERFACE_VERSION,
> +	};
> +	int ret = HYPERVISOR_platform_op(&op);
> +
> +	if (ret)
> +		return false;
> +
> +	maxid = op.u.pcpu_info.max_present;
> +	for (i = 0; i <= maxid; i++) {
> +		op.u.pcpu_info.xen_cpuid = i;
> +		ret = HYPERVISOR_platform_op(&op);
> +		if (ret)
> +			continue;
> +		if (op.u.pcpu_info.acpi_id == acpi_id)
> +			return op.u.pcpu_info.flags & XEN_PCPU_FLAGS_ONLINE;
> +	}
> +
> +	return false;
> +}
> +#endif
> diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
> index 8c3f82c9fff3..18fb04523f93 100644
> --- a/drivers/acpi/processor_pdc.c
> +++ b/drivers/acpi/processor_pdc.c
> @@ -14,6 +14,8 @@
>  #include <linux/acpi.h>
>  #include <acpi/processor.h>
>  
> +#include <xen/xen.h>
> +
>  #include "internal.h"
>  
>  static bool __init processor_physically_present(acpi_handle handle)
> @@ -47,6 +49,15 @@ static bool __init processor_physically_present(acpi_handle handle)
>  		return false;
>  	}
>  
> +	if (xen_initial_domain())
> +		/*
> +		 * When running as a Xen dom0 the number of processors Linux
> +		 * sees can be different from the real number of processors on
> +		 * the system, and we still need to execute _PDC for all of
> +		 * them.
> +		 */
> +		return xen_processor_present(acpi_id);
> +
>  	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
>  	cpuid = acpi_get_cpuid(handle, type, acpi_id);
>  
> -- 
> 2.37.3
> 
