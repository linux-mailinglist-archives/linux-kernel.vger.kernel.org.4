Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3956BCD66
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCPLBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCPLA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:00:59 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABC414985;
        Thu, 16 Mar 2023 04:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1678964457;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R9aDqR6x1yeEr+4LdWb+Yws5rH6kb5nC3tm5CKc6JiU=;
  b=NL6YLFoqigKkjjaOAC1vAPvrSuzJc5si1HTaTuLQO0XeGQubmCgHZPqP
   nILRsMp7BDyLimnwZRAi3HwzLmMHRg5Ahit57Xl27LTCBfF0uqK4XLKaN
   Xx1eflo4V6EhOddargjA+uwJpwAmdKSI7o/0D5pIlkqV6tUsFmrLwQb3y
   U=;
X-IronPort-RemoteIP: 104.47.59.173
X-IronPort-MID: 100464054
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:fjicyKiMAhuYineKChZYmCVeX1616RAKZh0ujC45NGQN5FlHY01je
 htvDWCGaPmJMTPyeoh1aYrjo08B78SDmN9lG1Fvqno0Qyob9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsy+qWi0N8klgZmP6sT5waAzyd94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQ+LQkJay/epN6r3YjlT7N33uU6Pcj0adZ3VnFIlVk1DN4AaLWaGeDmwIEd2z09wMdTAfzZe
 swVLyJ1awjNaAFOPVFRD48imOCvhT/0dDgwRFC9/PJrpTSMilEgluGya7I5efTTLSlRtlyfq
 W/cuXzwHzkRNcCFyCrD+XWp7gPKtXqjAN5MSOXlqpaGhnXM4F4sDxIddWek4vDpkROGR/JiC
 x0tr39GQa8asRbDosPGdx+yrWOAvxUcc8FNCOB84waIooLd6AaYD24LZj5ZLtchsaceWzEs1
 VaVksjpQyRmtLmUUXuR95+Vqy+/PW4eKmpqTSgAQAge6t/vurYvnwnPRdZuFq2yptDtEDS2y
 DePxAAlnKkah8MP06S9/HjEjiiqq5yPSRQ6ji3TU2SvxgB0foioY8qv81ezxexJIo+USnGCs
 WIClszY6/oBZbmNjCWlUvQRG6vv7PGAWBXYgFhyD9wo/Cys02CscJoW4zxkIkptdMEedlfBc
 B+NkQBc/pleOD2td6AfS4ipI80uzKXmRZLpW5j8a9tIbZ9ZbgKL/ChyI0WX2gjFjEcogYk7O
 JGGbdyrC3cKT6hqpBK8QP0cyvks3Twkwn3IRoHTyA6u2r6TInWSTN8tMlSUafsixLiZuwiT+
 NFaX+OIzA5SXsX5biTN9YcVIRYRIBATFZ3w7sBaaOOHCg5nA306Te/cx6s7fI5olLgTkf3Hl
 lmxU1FVjlr2g2bKLy2Oa3Z+ePXuW4pyqTQwOilEFVKp3WUzJIWi9qESc7MpcrQ9su9u1/h5S
 78CYcroPxhUYjHO+jBYYZyjqoVnLU6vnVjXYHHjZyUjdZl9QQCP4sXjYgbk6CgJCGywqNc6p
 LqjkAjcRPLvWjhfMSofU9r3p3vZgJTXsLgiN6cUCrG/oHnRzbU=
IronPort-HdrOrdr: A9a23:TMWksKEvznihJ0iwpLqFgpLXdLJyesId70hD6qkvc3Fom52j/f
 xGws5x6faVslkssb8b6LW90Y27MAvhHP9OkPAs1NKZMDUO11HJEGgP1/qA/9SkIVyEygc/79
 YdT0EdMqyWMbESt6+TjmiF+pQbsb+6GciT9JrjJhxWPGVXgs9bnmVE4lHxKDwNeOAKP+tPKL
 Osou584xawc3Ueacq2QlEDQuj4vtXO0L72fBIcABYjyQ+WyRel8qTzHRS01goXF2on+8ZozU
 H11yjCoomzufCyzRHRk0fV8pRtgdPkjvdTGcCWjcARCzP0ziKlfp5oVbGutC085Muv9FEput
 /RpApIBbU611rhOkWO5Tf90Qjp1zgjr1fk1F+jmHPm5ej0XigzBcZtjZ9QNkKx0TtogPhMlI
 Zwm06JvZteCh3N2Az7+tjzThlv0m65u2Arn+I/h2FWFaEedLhSh4oC+149KuZ3IAvKrKQcVM
 V+BsDV4/hbNXuccnDip2FqhOehW3widy32MHQqi4iw6Xx7jXp5x0wXyIg0hXEb7q8wTJFC+q
 DtLrlovKsmdL5YUYtNQMM6BeenAG3ERhzBdEiIJ078Ka0BM3XR77bq/bQO4v2wcpBg9up/pH
 34aiIYiYcOQTOvNSXXt6c7sSwlAV/NEAgF8/suqaSQ4dbHNfjW2S7qciFcryLvmYRbPiThYY
 fDBHtnOY6dEYLQI/c24+TfYegmFZBMarxghv8LH3Szn+nsFqrG8sTmTde7HsucLd9jYBK0Pk
 c+
X-IronPort-AV: E=Sophos;i="5.98,265,1673931600"; 
   d="scan'208";a="100464054"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Mar 2023 07:00:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0PXmie7j6JFeM+zFhNlsoxNACoyIkS9AR0t79CtMYe9dcIzJFgCX181VEe9dQH9eDu/511Lbco1f+zNsNBB82qKGv8j8FDp6Ma3yBCK05PdR1Mbl9x+IlHokY0vx7HK7TtQ4MUBtnzvajQTDFsTeeXLccLYZ7emoT59aBeC43STnE6+iN0d+q5UTx7Ux/NFInSYqmtAtFIiuqXYWUWddB1S7y1FPIaSbpokztqHDwhFahT+5Z16W3k8tdIhy/w8vn3rGFJbeiuQZUaljWQdzqCjNaoVoeh7Xvwp+gOOLcGEcqubMl7khojBmJH0kGt11q7rPwdUc6fAU72CaQmXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KwU61Fv+SUsRa3WilRxDBLF5gU0HjmIPKbQs9ZdDDo=;
 b=c4kr+hcvZFMggN0SbKsfquQ/rJDri24OUH7TMpNtLB1vyVDgJer1nTm2nBcrsedzmYXaUMN7nypvP8WY3moGs5riFZITcnHX/exZHWfZf7A50kyIDzD0NYTJbiiEw/7hBD4NmgeiOnJztuOIuAHg9lrmPGlX4Cas/jjnpydw9tqRBsWKG8/DaB0Dgr2RJqnwxgQsT9SmTstJhSSn03HLMj1lRiowoSpYRCgMQHpidPpvaA/34GXqdLnoWOHq87ZiAx2/9jhRyX1US4qip5Oi++zxKZq/eWr0H4sxB1L/oCOx1AQJWY7g/rn4JMirN5hmxAvnwVRG9O1TDfC0BEaW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KwU61Fv+SUsRa3WilRxDBLF5gU0HjmIPKbQs9ZdDDo=;
 b=hrAZuFboyn/2UOrN5OdhjNecQY090Ute+qgmJ22+9HvZdp8TkcP32G1/a5BhJks0/BjKHIbumboszT3rvpkMRBfYfIHTz1i+RNl+/1y+NpaOcPWytVVjsnSdJHSJGBcm+fUXwHNxkN/lBKVYQN3azej4c6+qywWT5m0g+Fi3Dco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by BLAPR03MB5394.namprd03.prod.outlook.com (2603:10b6:208:294::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 11:00:32 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::48a7:d1ab:897:acda%6]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 11:00:32 +0000
Date:   Thu, 16 Mar 2023 12:00:26 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     xen-devel@lists.xenproject.org, josef@oderland.se,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
Message-ID: <ZBL2yosC4LWGdjsn@Air-de-Roger>
References: <20230316103236.37102-1-roger.pau@citrix.com>
 <ba2d10ed-a1c0-2f35-3ffc-13637c83ed93@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba2d10ed-a1c0-2f35-3ffc-13637c83ed93@suse.com>
X-ClientProxiedBy: LO2P265CA0058.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::22) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|BLAPR03MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d045660-5092-4713-769b-08db260da942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkuyJbFmxpHqhos6+5c2fexVUXBpJRkY3qEp6OzIyM324KogcZfH4UOoJR/DXq1r44khHkxKJmswqULBMWlm8TQkKCx/G4yQlstQsCzEFuMueJBSmK2W1oOazZwQUIJ1uIxdZrDFe1HO7URRaOALnJ9yxpeC6vUwDwhkTTfotGUfIENSCW1cYXftt1ZGHYUWRqZIxbO1qHYZk5LIV198C09nW0cax8qHfVuUKcQIw8NL8g81VTqj0hNh39fo67mYWb+I7/BxkFEjOzPXoLmX3fHeXGmwFNm8NoFgtUlkJREB7UFQkyP0mz0l7mWZ0+nIVKG3d2i/8TtDwsz5dyYdZ/Mmcd8UU1z915lKgOGA1eI8AMFpz753fpzAVlJOX2Vl9sfuNlNvTxCJlLOtLRl4593Yv7Q7Fjl/Amo/IpuGn15xCx2uavOkFoabibV78+aAWjjRcip+dNupSfYETgxnsDVgi0DoP1E+DOIxUDaOpozZhI/Sc80Pail3nHzF5kOnPB6KZzHRFKPRljyJIWEGioSDUoFthl8jHPElYsny9bxpVTG+MtK12VuA8GSJmBrDJiRwQKXWJaASdIpwY5kHjBLL6a2KM9SiNE1sEMY1BGKNE5gJV+/6AjKJPuMBGQA4MyOTzCyQJzE32C4GNF09Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199018)(478600001)(41300700001)(66556008)(6666004)(66476007)(6916009)(8936002)(66946007)(5660300002)(9686003)(186003)(83380400001)(7416002)(8676002)(6486002)(26005)(6512007)(6506007)(316002)(85182001)(4326008)(54906003)(86362001)(33716001)(38100700002)(82960400001)(53546011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXV6RDgrTjM5R210Wlk1aW9yNm9MSndpVmYxTVZmUmNReDAyNkQxVU9vMVd4?=
 =?utf-8?B?ZVFSQWRrZjZ6SzJ5bXl2dEhRQklOa2J0eE9DSHBWUDVGRXNiUjBzTXJDM1Vh?=
 =?utf-8?B?RVJTLzJ6UStxL3J3YktaMjdyU2tPTkRYRmhzbXQ2eVUvRVp6bDN0YXlBQ3E4?=
 =?utf-8?B?c1Y0cjV0T0t3dytGakFadHdtR1lBUC9GY1cyU0djdlkyK08xN0JEYjk1ajVr?=
 =?utf-8?B?Nkp3NUJXTzZkdGRNV0ZCV3FzTytzdnBvRUtlaWorbTBEU0NmZ2FNcDMzR2h4?=
 =?utf-8?B?REVxYjBjVlcvekRGZUhiSG5sazJHTTIzWUJJeFhhdFRoUmpLTFZMQ3hrd0hS?=
 =?utf-8?B?NnNRUkgxSVAwT3F2QkpuYkdUSUFXRExWcnd2dFhLK3pUVldUL25mb0F1eDZz?=
 =?utf-8?B?VmI4TGpkRElmWGdlUEU4aitjSWF3RE1aWERHK2VvVDF2NExiUm56YlZ0b1Fm?=
 =?utf-8?B?M2l2VmhWLzZRZ1Erd25EVUZaZXovRFQxcmV6aG9IVUVHeGF4VjBHaUhDaGVm?=
 =?utf-8?B?bWVESjBDeFlOSWZEb3c1ZTJROWxpVytoQXYzOWw0Z2pjVnVmZktLVEFPUi8x?=
 =?utf-8?B?Kys5UU9wZXNZZVI0WW1mRkdGaWZ5Q0kwZW1hY1Q2OHBlU3ZPVUtVQkFUR21y?=
 =?utf-8?B?SzZIdUtob0xFN1psVDFCRE04VXFSdHowcFZYazdzNUZJV00xMjFNR2xqc1JD?=
 =?utf-8?B?WWV3SXRrZjNYMnhIcHNtMEp5aU9oNWNTRHRRMW1TUGIrUzV1WXFPV2ZqRi9G?=
 =?utf-8?B?VWtmYjZMMXVDWkJISUcwU29MSXlHYk8rbTFvb29QZ1dmVjlnb2xaU1JJQ2hj?=
 =?utf-8?B?VDVwcmZsUmlmd0UrdUhrWDBwWDNKbnV6RVl2TVBhT054NTVUcHRtajBRTk42?=
 =?utf-8?B?T2JpM0pNbklYZDcwMldRejJWNjh6TG1wWEREQjg5VXVVOUtwVko1bGhjTTFQ?=
 =?utf-8?B?Z0FFd0ljOEJpT2dyOXFFZDVIbU9LVG1RSkp6Zi93U094dTZIZE56bW5UbWRY?=
 =?utf-8?B?c0N0aEtCVWhTRmF5K2wzRDF4K2kzaW44ZHRLUFpUOVBrWWhucEhhS2hsWlh1?=
 =?utf-8?B?d1JzNHQ3M2VhdHJIeStScEFHSFc1ZVlKODJyZTRQeGNsL3dmYXRqMVF1MmRR?=
 =?utf-8?B?UGxtOWZEVnVPTnJZaTNjOFltRDNIdlFEU1A4M3VNMWRWelZmWVNoT3NJTm83?=
 =?utf-8?B?bXBEWHJ1WS9PYlZ5RHhMeFdDNjA3d2syc0hNNEhRWjlCUU1yK0VwS1NraUVx?=
 =?utf-8?B?R2k3YVVCL0psNG5ZWkJtaWpSSW5BSkFmbUw3Zkt5enhXSk5jU1NucWp6SVRY?=
 =?utf-8?B?NkNYUXFUQlhPK09jRFlOYlBkc2oxN1BxNmZIbXMrTjRjaFhicWc2U2FCeVU4?=
 =?utf-8?B?aXhNNWpzUWphNXFkNVRnenA3VGsxVFQwOXZPSC93SGJQTC9XYTBscnZtb2da?=
 =?utf-8?B?NzFTSmVmYlkvT0szcG5uY2ZCZmR6T1pDVWY2RWYxY2h1djFyZE9YbThINVRW?=
 =?utf-8?B?dVZBUk9tUytSbndOckEySnY1Um5BQzdVZ1ZUNEl4czJ5SW1lTVp1aElIMmtj?=
 =?utf-8?B?VEV4bzVBc3lqdWtoR3k5M3k4eHIwbktKSFN1Zk80Sis2T0w3ZUwzcjBBSXlq?=
 =?utf-8?B?eXM3d3JGb0RHTTJHTTFVdUhCLy8rWHFxT3FJQ3NURXRpUVpTL0RxREgya00z?=
 =?utf-8?B?YjZ5Z0x2cXRtVVpjRjZkSUU1WXhsYURMUFJsdFAzL2hMSytDcFF5RjNObVVR?=
 =?utf-8?B?bVJ4NzVPOW5KaVJpaHZpNHZ1d1hQdUZUUTNVOC9VNStZOTBlZkRUOFl0cFBY?=
 =?utf-8?B?VWswbjNqTE45WCtlbVVIOGp3ZDFwTFFRdDE2c1E5VkpjR1IwUkYvSGFUUnRr?=
 =?utf-8?B?a0VFakhidlBYZ2NCOVBjc1Y4TVNYT0l3Y2hMU0pHdWNSUFhQT3BnUStrVjdi?=
 =?utf-8?B?bVRUWFRUSlhZQndQLzYxNHJRUVF4Sm5Ob0Z4V0RORVdOR1NKd0F3Q0h0WEdo?=
 =?utf-8?B?SUNmeXhId3dTcGxib095cllnWWlaa05oeUV3L0huTURrc2hBY1dZVWFta01l?=
 =?utf-8?B?L1VCOVFONW03UTIvUkYrb3libExhU3FEeDJwQWd2NjRTdGszK2RtOWhncXRs?=
 =?utf-8?B?WWcyU296QTlZNGI2czk5d2tyeXdZK3RyMjlZVFprRTRBZElDdHFQUXcvZEhZ?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QnJVOUg5U3Mwa25OL3FPQzJmV2huU2ROaGEzOFJoU2twdDgxOVZ0UllDVGUr?=
 =?utf-8?B?NXNvTlIvZUd1TmZIMW1qbWZRWitxenBjZ3RoeGx2b1Blamc3aTIzNlNhSERq?=
 =?utf-8?B?bkREV1pqTld4SHV3VmJoZDZGa2VjbXZ6ZklsS1I4cXRRN2VDZmM3YjBlL0Vu?=
 =?utf-8?B?dG9OdHVDZTFmR1ZTdW9lK25aMVorSWxkZ3E1TnRZMUVKblNUSVJVOFFCbENF?=
 =?utf-8?B?MFBkd0w2QmRTWVpVNVpLVEVCMGFaN3R1d2ZZNmo5THp6M3FNdmRzWlJ3UjNE?=
 =?utf-8?B?ZEl0UUdKMkpWWW0rWW1UUXVWVnY2cFFIUy8vR0xWckpnUHlyMzRLZjZjNFds?=
 =?utf-8?B?clVDa3VsY0NycDB5di82RmttYTF1QXdMa0NlTmpBNlR6aFB6Q1RvclMrNHFv?=
 =?utf-8?B?WGhPSFh6aHJUVU5BaGRVd05IUUJCdEJCM1dCRTVQTVA5NDVRUGlQOGtYS2Vv?=
 =?utf-8?B?czZacFVOZWJsdWxsUkE1bVBkajVQOGtBalJXSHZobVZGWGd1ZmRHdVBvM3Ri?=
 =?utf-8?B?UnM2K3o2OUo2Rk1pcnl0ckJXVlowZ21hYVdUc0NJbnNnVFVSOW9GbXpETUs2?=
 =?utf-8?B?RGpsbmF5djltalNSNHR2Zm5OODBUMUQ1azViWFFBRzRpeU4wc3pzSkR6Mk05?=
 =?utf-8?B?SWxWZFBQcWlTK1JOS21GalgxNjI1OHVlYmt2VXJtQ21mbEwvZVpmT1V3ZUdh?=
 =?utf-8?B?Q3M4WUdZWC9VSytGaGE1bHBTaGc0TVlhVEovVFIyWXVmV3NmQUlsdU5DZWc1?=
 =?utf-8?B?ZEhFNEJHaDJFVlVVa0VMcnJhOVBPelFNMUVsL1BGL0JQNWdmMzZzTGhzTzha?=
 =?utf-8?B?K2QyNDJqT1VSRSs3Z1dKMWtnd0RuZi9LZE1Ud29NVzRNV2N0MFh2dndwemxI?=
 =?utf-8?B?V3Y1ekxmbm1EQjBKTXFxVVFobTY3SHBoMFV0dEtVNnhzeVVhUDIvV0FwdllM?=
 =?utf-8?B?R2RwZ0VGVlhoTlFLcFBzTkdpMHI0L0hpcVB3SWQ2TFB6STluUWhqSXdtVUcy?=
 =?utf-8?B?ODBaR1RUTG92dCtHaEw2dVhhZUxoTlp5MG9ML3pLb1BOMmpxQlF0WThJV1hz?=
 =?utf-8?B?eFY1SFkrdzlGUkw0MTdsMXl1ZmhKdG1iSXdSQ0pSb3lpT2NqMXIwS281Unha?=
 =?utf-8?B?aHd1b2NHS1BMQmM0bDhBUm4yYVVpZDUwdUxuR1UxQ0dJdElIRCtSa293dGxt?=
 =?utf-8?B?Q2NhanA1akw2czZsM2Vkai9BL05JZWVMelZ3VzYybVpkV0Y5aVp1eWl2dGNo?=
 =?utf-8?B?QWNrUElOUkQrTHZWUW15ZVR6MGhhOXM5ZFNWVytFZUkyZUlGNFA2NGJNSGpq?=
 =?utf-8?B?QitJb1IrZ2FYWTVTVmVzUWY0ZVRVcjhKNldkRWZDWjQxUVE5aE83Q00rd0VP?=
 =?utf-8?B?VVpCS1ZnbGIzczlRdW9oME0yUnFJK2U3L3FmR1ZoV3BNL3UyOVhZa2FFS0VV?=
 =?utf-8?B?d0tONU15SCtsWXl1OW5Wb2xGY0YwYUx1TjdzazgxVmlteFErTDRtdTZxd1Fu?=
 =?utf-8?B?aER3R2dLMHBuUTNFNHA0VDc5TktJMi8ybDh1TXNzUWtVdjFDWlFwTzV1dVNS?=
 =?utf-8?Q?eGTBTI4TScu3pQFlk7Zc+tcUI=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d045660-5092-4713-769b-08db260da942
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 11:00:32.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jY97s4KAxcs5Q2EqHzqZzebOHoSYnG39hARjL7ikZOMeVkVGO30Aoe+LAQjgRY/zirEHchmWSzQ0Plww1Tk1Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5394
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 11:45:47AM +0100, Jan Beulich wrote:
> On 16.03.2023 11:32, Roger Pau Monne wrote:
> > --- a/arch/x86/include/asm/xen/hypervisor.h
> > +++ b/arch/x86/include/asm/xen/hypervisor.h
> > @@ -63,4 +63,14 @@ void __init xen_pvh_init(struct boot_params *boot_params);
> >  void __init mem_map_via_hcall(struct boot_params *boot_params_p);
> >  #endif
> >  
> > +#ifdef CONFIG_XEN_DOM0
> 
> Shouldn't you also check CONFIG_X86 here, seeing the condition for when
> pcpu.c would be built?

It's in a x86 specific header, so that's enough I think? (note the
path of the header)

> Additionally CONFIG_ACPI may want checking, which
> - taken together - would amount to checking CONFIG_XEN_ACPI. (For which
> in turn I find odd that it will also be engaged when !DOM0.)

Hm, is it worth making the acpi_id field in struct pcpu or helper
conditional to CONFIG_ACPI? It's just data fetched from Xen so it
doesn't depend on any of the ACPI functionality in Linux.

IMO I don't think it's worth the extra ifdefs.

> > @@ -381,3 +383,20 @@ static int __init xen_pcpu_init(void)
> >  	return ret;
> >  }
> >  arch_initcall(xen_pcpu_init);
> > +
> > +bool __init xen_processor_present(uint32_t acpi_id)
> > +{
> > +	struct pcpu *pcpu;
> > +	bool online = false;
> > +
> > +	mutex_lock(&xen_pcpu_lock);
> > +	list_for_each_entry(pcpu, &xen_pcpus, list)
> > +		if (pcpu->acpi_id == acpi_id) {
> > +			online = pcpu->flags & XEN_PCPU_FLAGS_ONLINE;
> > +			break;
> > +		}
> > +
> > +	mutex_unlock(&xen_pcpu_lock);
> > +
> > +	return online;
> > +}
> 
> Since it is neither natural nor obvious that this function takes an
> ACPI ID as input (could in particular also be an APIC ID), would that
> perhaps better be expressed in its name?

I did wonder the same, but convinced myself that the parameter name
being `acpi_id` was enough of a hint that the function takes an ACPI
ID.

Thanks, Roger.
