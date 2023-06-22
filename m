Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC5973A16A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjFVNFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjFVNFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:05:30 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50691BD7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1687439129;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CYj/Fl3w/CU2qB4bAdSs4LJeUAWNjkVkGe8fLSy92i8=;
  b=YfwhUIjzkSoC83E+nh+ZNQyLfMPyVHVxMmcwEtkRkxmIM9+QBaG5x/Wm
   8PEk/sRvaWlO/PaVgL9/VItVcOkPL1yeAWUNU20tqddEZOxVg8XIepKPh
   uMdT8sph6x58PO3+lNbZwJZEfnp+ofK6dK+A5iM2WlH4gbjvm2pWSd7em
   w=;
X-IronPort-RemoteIP: 104.47.55.102
X-IronPort-MID: 113063750
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:aaeOIq7GQEeIdEReyD8t2AxRtDvHchMFZxGqfqrLsTDasY5as4F+v
 jQdXD3XPviOZWb8L4sibtnk9kNQ75KAmoNlHQBlpHtgHi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9lU35JwehBtC5gZlPa4R5geE/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5mp
 fNbDwIsfhC5juO13quKZLNjgsUxBZy+VG8fkikIITDxK98DGMiGZpqQoNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6OkUooiOKF3Nn9I7RmQe18mEqCq
 32A1GP+GhwAb/SUyCaf82LqjejK9c/+cNtLT+XmraE32DV/wEQZGiNMVErmjsWIyV7hZu1ZM
 3JP0DgH+P1aGEuDC4OVsweDiGaJohMGSfJRFeMg4Q2Aw6aS5ByWbkAGQSRGc8cOr9ItSHoh0
 Vrht9f0GTtHs7CPT3+ZsLCOoluaJScRPUcGZCkZUREC5djz5o0+5jrKT9BsF4avg9H1EC22y
 DePxAA0n50aic8G0fX98V2vqz6luJWPTgcz/QjRdmak6B5pIo+je4Gsr1Pc6J5oPNbHZlqMp
 n4Jn46Z9u9mJZGVnQSfUfkKBvei4PPtGCbHnVdlEp0l9jKs032uZ4Zd5Hd5PkgBGsEAdDzya
 UnfozRN9YRTN3una6xwS4+pAsFsxq/lffzhV/bJfp9Nb4J3eQuv4i5jfwiT0nrrnUxqlrswU
 b+LfMDpAXsEBKBPyDutW/xbwbIt3jo5x27YWdb81RvP7FaFTHucSLNANUTUaOk8tfuAuF+Mq
 4wZMNaWwRJCVuG4ejPQ7YMYMVENKz48GIzyrMtUMOWEJ2KKBV0cNhMY+pt5E6QNokifvr6gE
 q2VMqOA9GfCuA==
IronPort-HdrOrdr: A9a23:VDHAyqBMOa5stMHlHemr55DYdb4zR+YMi2TDtnoBLyC9F/bz+v
 xG88576faZslYssQgb9+xoW5PwJk80l6QFhLX5VI3KNGLbUQ2TXeJfBOPZrwEIcBeOktK1u5
 0QEZSX17XLYmST6q7BkXCFL+o=
X-Talos-CUID: =?us-ascii?q?9a23=3Ar9SKa2r/l9Jc9/7+bK7lSt3mUZAqMVrv7WfQGUa?=
 =?us-ascii?q?5CnhweZPPRluR6ooxxg=3D=3D?=
X-Talos-MUID: 9a23:qk5ybghfSYo/0/E3eyYkpsMpPtVWuaW/VW8xoNYW5PS7MzROYB2PpWHi
X-IronPort-AV: E=Sophos;i="6.00,263,1681185600"; 
   d="scan'208";a="113063750"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jun 2023 09:05:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtM+7V4YmdF3+rCk7G21N5tnY4qVsiDgVS249O6+h1deaONKQfmcfxY0QZ2GhhF4nkQZy698gUSrL+CqBRJGlbsLYPEZ0QQa1pBJSITKbiwGC5nXf2Gktqf+IA6haNQAk/+Qsgy7qZ2wEYMgHPED6NmOkyQAGCJBMiA98TDPSzxLLE+JklJlHSTiErHaS/9TYjcHgBKmZAhRv6cxpZ3l/l8/ZUtsgJcMjYo+Onx0nbL3CUbuqp0YQHwlpDQvJd8N/sC5cG8X/qgYdYKg2sZ9AoOE0Z4TjdXlIRhQbIGtogJdgOB/LuOqxFQFi/aMjD47VnxvCNobKpz+U13CkJqhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SejNFEGIpUrYNvrB53UHodRPuQldY5yxAEE23suo6wI=;
 b=bTR9YrIYYQ0kg0SzPRQV38MHE7aATI7cE7aPCdqejpMQafDvVSI4HMJdXYKoTzP82xaBWj2Ty9ZrOVimbYlkB+bvobnC9X9QMubIlUly2cdySn+fA53QkpmFLi5InOvaTLvFfVtnuP/lJ4cR/8itOnjGF7OFh4e6LB1QOQ5O7oCM8qOuoWQ0aY0qf1k2u7NHmsZYIc5pTT95mDYoZvuTeiWCJFV/EfwlW+r6jc3+e1vyAzOmqm18/im0yraCqAxonlOElXRv4u6bMvbmWRQHZ61wfMsAdADd8eWZVNsfdqvO0Ml0rhhCCVnWxg745BHR/ebWYPvrJWPI/aZlQWzyfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SejNFEGIpUrYNvrB53UHodRPuQldY5yxAEE23suo6wI=;
 b=Ea8JIx5B14oAIZmI7KpyRejPGygW+U69XCLvbueoQL+2/AQ2o/hJ6wX2vD6Dzvu6Gwz+jX87I+v4icYLabHwWruh9s/fW6+O9CDQR6HIbKPW6gXJOB8+79st/g9Qjfb6/DjXjboPTLPSwpqDNZ3hhnQLYlPdNsQlsi3trnMbUh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BL1PR03MB6168.namprd03.prod.outlook.com (2603:10b6:208:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 13:05:21 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd96:913a:c06c:d606]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd96:913a:c06c:d606%4]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 13:05:21 +0000
Message-ID: <e8f0d101-d803-8ccb-80a0-fc7c6c45ab77@citrix.com>
Date:   Thu, 22 Jun 2023 14:05:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Updates to Xen hypercall preemption
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>
Cc:     Per Bilse <Per.Bilse@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "open list:X86 ENTRY CODE" <linux-kernel@vger.kernel.org>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
References: <20230621151442.2152425-1-per.bilse@citrix.com>
 <20230621164038.GM2053369@hirez.programming.kicks-ass.net>
 <6523f3e2-8dfc-c2dd-6d14-9e0c3ac93cc8@citrix.com>
 <20230621200409.GC4253@hirez.programming.kicks-ass.net>
 <a8cd2788-a695-964a-3311-dbecb669bb72@suse.com>
 <20230622082607.GD4253@hirez.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <20230622082607.GD4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0042.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::30)
 To BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|BL1PR03MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f8d45a-68ad-4a69-06f2-08db73215531
X-LD-Processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZWBULJErpGhjWcCpQwVY+G9XGnvWa9JhWq3qmZRDN9ht6Jtsutsw2wv2WPYmwlZ0lELoDREhdgn6AiW1A6ih7hQ85ZzazT4F7HISxfBji4PsOufn7mDnNufIzU/OTUaj2e31O1E3S6L+ny3MKmMnsFrUp/z9nlxUoGlOBnFa5cxxUNUI53Cfo2dPVeAA0Axlzo5e/nsi/dizbuhnmzpQgyHd3SWD7Kt803fQYBv3IJFpr9LFv4BJu/hCqclgENsws7ELWXZ7dWSxaZK9zH2tzWsTjU1QDd8WkoWDQZAsNXdG9UMXhOjv812Yl/ksbcD6r6x7UGs8/4IteWS+92eJISIbQRFyxIu2pQCCOJcBwY3TlxSfjztahGUE8rwyakOxPgWn+svitzH9ZNjgr42abXPAz1AXuZTy+Ig8ZzFEuuZfSEMiNiCNjVu9+KI+WCMgVRS/36VNH/RmYvOidnYnhheWJhJO9Sga4dTOnRmbZlDDk0oEFh+C2d577sNFrwHkHIx1LdWTR5rIWbiDrfuvb2oNPXkNMsFufHMNsyU8abHFiSgDnhjaBQO4W+V1U1T61WjVOCB1fJNfNHgtSm1YpUXdRKr9MtsQwDjV/DkkNySqU44cEXQ4HZqB6IE5Me2f0MtxA5i6iOe4/pUS9gbfXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199021)(53546011)(186003)(26005)(6512007)(6506007)(31686004)(478600001)(2906002)(86362001)(82960400001)(31696002)(41300700001)(8936002)(8676002)(7416002)(110136005)(2616005)(36756003)(38100700002)(54906003)(4326008)(316002)(6486002)(6666004)(5660300002)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0NlRkgzT09UelRzaG1XaE5oT1V3eU9vU1dxdUVWSEp4ak9sUytYbVBrMmVW?=
 =?utf-8?B?VzZYK3VQOFZQTjJqem9tRUtFMUQ2RkI3TGkyZHBLRExJTXBBd2VETERYb1RG?=
 =?utf-8?B?c1Z5RUx4eGNZeCtaSTFybDE3QWpUTEVwb0x1dVo3TjZXQnFjRGs2cU56QWdJ?=
 =?utf-8?B?MTFsN0FrUXRlS3ZhNzEyOW5uNGxGVUJUVFBqVFFPZnZSZWFJR25DaTZuc09p?=
 =?utf-8?B?ZGFXNHB4NHJpMjBRMTBUbkk2Q3N1alZxZFpvMUVhbWozcHF1bHk2S0F0YUNU?=
 =?utf-8?B?TzlqWkJzN0VqMW1XbkVxT0t5S3I1Kytyd0hoenhpMGwwcko0b3NBS00ycXht?=
 =?utf-8?B?Q29GOHVZbXI3dW1hOC9rRWMvdFdQdHlQVTZYblJSSXlsamxBb3U2WklVM2Nn?=
 =?utf-8?B?aWJxcGxsczBlTjJpMG0zU3pmcVpSYW1uZURvMFUzeTB0bmRFek5ocUhsLzdI?=
 =?utf-8?B?UlZIT3VkR2s0NTV4aWV5SkV1UXFRSVkvSy9MSGcwbFdOeEZHR2V2Yk1HMFF3?=
 =?utf-8?B?WGp0RVZXVGhCbW05UWJwNHF0MlErOHRCa2srZTY0Rnhwdi9kakMrUDVwNTd4?=
 =?utf-8?B?djArTlNqd3pUQWJQSWNyd1hxMk16MzRFcTQ4Qi84My9QRFBCbGlreEx3VXFX?=
 =?utf-8?B?R20xRTZGWVUrNjZJaUxLcmtzRW9oU1Jvc285OU9KdjJIRGZGK3lHZkVhQnZL?=
 =?utf-8?B?UmlBbXBHQTVjQUtpZTV2NytvMEFuNFhrZjVhck40K01CZlNyQ2M3aXU3Vmxa?=
 =?utf-8?B?QmpBTVJvMWlBMkxNSDEwUXJKVkg3WWt6eGcxRWVmY1VNdldmYkJlL1hLZWM1?=
 =?utf-8?B?R1d3YkEwOWNobzdhUFRSSmUrQWsvdmpYd0x5SFFZdjdNMStYWlpXZ1lrQ2RC?=
 =?utf-8?B?TnBrdVlKT1JlME56OGZvVEhjcHcrUkR5NVhobTBmSVhwTUliNkdtY3pUMWZt?=
 =?utf-8?B?Wnp6VmpmQk9BeVByQjBWN2dBYkExWEROL29rSlNkV1NCYUgyQkR2WmI5UHRR?=
 =?utf-8?B?VTdYckc4TklTeisxNU5mSmJReE9rYjRxYjd4UE5yaVBKY0FpRnZoKzZ5b2U5?=
 =?utf-8?B?VE5iNTREQmZKSkNiQlg5ZHJtdDJMTEdveW83R091UWthR0JmZmhuVkYwWFd2?=
 =?utf-8?B?cDJ0ai82VVNWUHIxQzZwQjBIOFM3NmFvM2FKenpyRlIvb21ZM2FUSU5Fc0VS?=
 =?utf-8?B?cHRPNXJOOENXUFViTGk3VERHVlR2VWVrTS8yeGtZQTZHTm1vangxdDdubE9o?=
 =?utf-8?B?c3lZK3MyMmwrRkpiUk9HbldVOE1PNkpnZFNWbzlpYXhPT0NQckhmbXVTMGtB?=
 =?utf-8?B?SFlibklEVHFzaFVTZDVDRUY2Unp5bkZwclRWSGNvOEMwS3Z3ZmpEVVhSYmdl?=
 =?utf-8?B?SXVkZGNLRTFSdGR2Q1ljTS9KSXQ1UXpwcUpOTGJIVCszZ0hUSjNYNG1vb3Zs?=
 =?utf-8?B?S2pqcVg4dGc5TlhMWHA1Zi9nbXZpbjFWY1FmbXVEc1NMUGY3SUFPcDM3V2R2?=
 =?utf-8?B?cEhmZGRXSlpYVVFiUTVZVzZtVHpyRm5CQ1RrRkxGaHBiQWZaK1h3VC82T1Y5?=
 =?utf-8?B?akV2M1dlMm1tWElNY3N1bExZK3J0MmR4YUIwMFozeDhvZlNsazBnUDk3aVVJ?=
 =?utf-8?B?TEg2MDNVcXAxYUFaL1pIdS96SUs3eFJLRjNNSXN3ZEZBYlFxQlprcER1cVd2?=
 =?utf-8?B?ek5VYm5wek1FVjJQWlVvdTIvT0tqb0t1R3ptbnVZU0NYZTVFQ1FFaDBzb1Uz?=
 =?utf-8?B?UElsMHU2SmVQZGZsOFdPMkQrR2wwZytPQ211QnFBZWdiR1dZbGJ1d2ZvL2NW?=
 =?utf-8?B?Q1UrdGFVa0hWakFDTFVoVlk0aUhCQ0VoWUJ1T3YrcXF1S3kvY0Qzc1lrNlpH?=
 =?utf-8?B?NHF2T2dQazBGbDArcVlKWnFveWx0YVpXMTdZMjlhZ3dPdlloRThKTjdPYlpV?=
 =?utf-8?B?QTlLdG5CU2NLQ3hxdkxld1haaHdIcGQrR2NJM1dDeS9FNmNXcW9EeVZtWm56?=
 =?utf-8?B?Uzl4M2VmRlNvckpJbTdOSzd5NFVEdmt3K3ZMN3FuRTVSTFBUY2p0VlZiYU5M?=
 =?utf-8?B?dXNNc2s2U1V1NHBuNGk2MkhUWXpwWWVsVURrR2ZKZUkwMDBrbE0vc1pOUkNZ?=
 =?utf-8?B?b1hYMExaY1RYUkkwa2lDTFZzN3gwNjFkdGdpMlNXZ2p2a3d4MXp2ODhoQk9u?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bFJhZ3RKQXZCdHpBcVVBVVMxUlRQOGFOWnpSanpVOTBheS9sTkJYSy9sZDBy?=
 =?utf-8?B?SHNSY3hxUlR0cm9sVXV5bldKaGpPQ3piL0ZUZlV3MVR0SkRrbE1VU3Z4SHBM?=
 =?utf-8?B?ejdMZFRLQXg5UGdKRnNmNHE3MDFSZmJncVdKVkVoWXpzM2F6RVVMcmhJcU5Q?=
 =?utf-8?B?Y3NqdFNwZ3I2cmpaTXc3b1JIWno0UWJkR0lzc3E4Q2FxYmQwUTBrOEJBWnJ5?=
 =?utf-8?B?dXJEVUVlYXBoYzY3Q29OSWEycitMUUREYUJBWXBwSmp5ellaMnFodENqSmJ2?=
 =?utf-8?B?Y0JZTWZ6eXhLNHlINGs5Ujl3L3c3cmNMQ2E0aXVVNkZ5VWg5OHVSaEtkSlNM?=
 =?utf-8?B?MlRHMmhIMVg1NnFpcS9sTGErdkI4V1FEamhGbXVJVXBoQnBLMEhlbUdhL3ZC?=
 =?utf-8?B?dVNFQkVVUUZvUDBBZG5JNERlWE1EYWZNeXpZOHJ6a0VlWStHNTZjRnIxOFFU?=
 =?utf-8?B?WWI3YWlSRnNqRFByUy9WRnJqV0RwNHovZ0ljZE5pQnpMK1VYRDFmTGtQSHpx?=
 =?utf-8?B?ZGhBaWNSYzcxMGxmSkd6K1Zldk12S0NPaUZBb2ZsU1RhNjY0QTJURDEwSzBC?=
 =?utf-8?B?Q1JSVzBiOUV2Z2hvSDhFTUxtdldzZ01rb1BDWSt5Qi9kMzJyVy9oM1FoUHBr?=
 =?utf-8?B?cTdUSy93WnoxUjZUaEQwQnRKbWdjOXkwSkdlajB6R3hBSGVuMmp1VkUvNmM5?=
 =?utf-8?B?cXZZekQ3Z1BVTEYxWjhKdGU5VGtqSjFRMlZZWVlCZHVxZi9LUFZtU0NnRTdM?=
 =?utf-8?B?MDQvTzE2dWUwMklUMWYwUDNZMUtSL0tkOFV3cGFEL2FNd094d29Pajk1UHVT?=
 =?utf-8?B?bzJ0Qi9MbjJnQ0Z0aithSTg4NVB1Zkcwbk8rb2ZIMnlkUUs2QmNucHk4V2ND?=
 =?utf-8?B?bUxHaHRPb0dQZ3BkTEFWWU5oUFR5YXhnZGJ6RTBjdTVqZlovcHNnV09GSVRC?=
 =?utf-8?B?bFpHMnoyNlJIdWU0QkVmRzdjRFNhVHBuMTlBaE9KNFlrRTRyTVZ5ZUZGeFEv?=
 =?utf-8?B?VzdXZ1Q5RnhHNzNSRE05L0xzeWNvSE80OTB3R0J5ZDNZZ2grLzl0Z29CTlI0?=
 =?utf-8?B?M016WVlXV0lreFFUNnZGanZ0VXVyeThZMGFjZXFMVjNWRDQydEJPSzFRZXlk?=
 =?utf-8?B?djZvR2FzYytUK2Vhc0xVRnE0eGR4NHJnQTNIcVFVK3VxR3I0UHBXcmFoeTlI?=
 =?utf-8?B?aWZYbnNjY1NzNmowQ0N6b2VTak0rQm9DUnBsSnQ4UVBZc1d4TTJaSjRrTHJU?=
 =?utf-8?B?djNBYU5LR0hMeU1UTjgrUHVWdG9NZVdtM3lWZmNtaGh5bVJNRjgvSGJIaUM2?=
 =?utf-8?B?MzM3NTdvK0NGMS81N3E2TWdQZ0kreEZ2bnhaaGpsb3RzOXZ2WFBCRjRlVEQ1?=
 =?utf-8?B?d1FMVTlvMUZXKy9sRUVINXMwdktVcUpCQ2VYS2pyMzBldkNxR2VWZHFtU0NC?=
 =?utf-8?B?c0NBSU01R1lxRWhURk1ialMrdWpZQmJUSURyYnZRPT0=?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f8d45a-68ad-4a69-06f2-08db73215531
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:05:20.7320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qVe/WZ2dulJW6Tyuv98CgRXrmfz+94hFGr5Hkm59rmaYvw5I01u+CpsUr7UkCR3CHRW+KEPE2UnAsLITHtqdEna3RVwwxfe60rcLrcg1ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6168
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 9:26 am, Peter Zijlstra wrote:
> On Thu, Jun 22, 2023 at 07:22:53AM +0200, Juergen Gross wrote:
>
>> The hypercalls we are talking of are synchronous ones. They are running
>> in the context of the vcpu doing the call (like a syscall from userland is
>> running in the process context).
> (so time actually passes from the guest's pov?)

Yes.  And in principle it's wired into stolen time.

>> The hypervisor will return to guest context from time to time by modifying
>> the registers such that the guest will do the hypercall again with different
>> input values for the hypervisor, resulting in a proper continuation of the
>> hypercall processing.
> Eeeuw.. that's pretty terrible. And changing this isn't in the cards,
> like at all?
>
> That is, why isn't this whole thing written like:
>
> 	for (;;) {
> 		ret = hypercall(foo);
> 		if (ret == -EAGAIN) {
> 			cond_resched();
> 			continue;
> 		}
> 		break;
> 	}

No, because that would have required the original authors to write a
coherent interface.

As example, I present "long hypercall_get_dr(int reg);" which returns a
full %dr, or -EINVAL.  But other hypercalls have completely disjoint
API/ABIs so even if you could tell Xen not subtract %rip to repeat the
SYSCALL/etc instruction, you still don't have any kind of way to spot a
continuation.

Making a new ABI/API which looks like that is specifically on the cards,
in some copious free time.

~Andrew
