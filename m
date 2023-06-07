Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E461E72733F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjFGXnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjFGXnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:43:19 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E205E210A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686181396;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QT1f5J74Q30Zjm3+kgP5KY4FRV/3OkO/waBUuTuo1Vs=;
  b=FNbdaKRimWG/3qbcq0+X6W2z+ceUXZVhoEJdTCWZvF4q0f9ZPaTb8Hag
   N6YxiiKRgyBdXcPt1Vnypoef7gQqxfy+IxeGWuASF9ZNqmSgu01U1DEPC
   NcDrNzBmEf/Og2lqTkk/jZh/WHui9iocLDFs8SkPmi3kUaUBD66RSlTOv
   Y=;
X-IronPort-RemoteIP: 104.47.57.172
X-IronPort-MID: 112401290
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:vNiOG62xKrF54jemJfbD5TRwkn2cJEfYwER7XKvMYLTBsI5bpzwGm
 mFMCmGOM//cM2b0fdEgPIXgp0JXvMSAndEwHFBqpC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK6ULWeUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8teTb8HuDgNyo4GlD5gJmOqgQ1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfPHoUx
 PE6LRw2RC+h29KbkOKHeNVBv5F2RCXrFNt3VnBI6xj8VK9jbbWdBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxqvC6Kk1YZPLvFabI5fvSjQ8lPk1nej
 WXB52njWTkRNcCFyCrD+XWp7gPKtXqiAt5KTefprpaGhnWXnDErETtLdmCGpNTjsUyvB957A
 mwbr39GQa8asRbDosPGdwG3pG6suh8aRsZKFOs7+EeBx8L85QeaQGIDVD9ab8IOr9ItSHoh0
 Vrht8O5WxRsvaeTRHbb8a2bxRu2OC4IPSoBaDUCQA8t/dbuuscwgwjJQ9IlF7S65vXwGTb7w
 DeitzUlivMYistj/6eg+VnNkhq3u4PECAUnjjg7RUqg5wJ9IYKgOYqh7AGC6e4addnDCF6co
 HIDhs6SqvgUCo2AnzCMR+NLG6y14/GCM3vXhlsH84QdyglBMkWLJeh4iAyS7m8wWirYUVcFu
 HPuhD4=
IronPort-HdrOrdr: A9a23:ZbHNw6HfXCsooTlfpLqExseALOsnbusQ8zAXPidKKSC9E/b4qy
 nKpp8mPHDP+VAssU8b6LK90cW7MBfhHP1Oj7X5Q43SOzUO0VHAROsOgbcK7AeQfhEWndQz6U
 4PSdkENPTASXR8kMbm8E2ZPr8bsaO6GdiT9ITjJq5WPHhXgndbnn9ENjo=
X-Talos-CUID: 9a23:qDMnaGFju+nV2FslqmJa7xQlF+IgXkb381WME2LoWVpbdJCsHAo=
X-Talos-MUID: 9a23:MpGURwtxyZSe4Pz3UM2ngGs/DN5OvoeVNUUgy64EqpWIEQVQNGLI
X-IronPort-AV: E=Sophos;i="6.00,225,1681185600"; 
   d="scan'208";a="112401290"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jun 2023 19:43:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9OVooSRMqxK2dlG+hxAM6OSRpnEnWbeUptqc86fbDgMm9uU4oh9Tq8iILUZGy5u/Ok9LC9VEpiIuuFs7TImOxrxTFQICIsqeXvpo+rVJWjeaj8mVFlvj5s7iSWUdRS2LaGhzjXfjZHbj0aI6jPUhiMm5wjvpbvOuCRUV1WI/r1g0ea6N9jn8yOUF2bJft6H5hOtU0CK3FEErAURfnyeBDNODJKcJARU2XJ5NqM5MwUnyZhAZU1zM78wcNXIQQgNjucYnBjS/is28RdVcfo2QLUvFVP+oCAFuL5+P8XDIwrAut5Dauby5pjuLy9DQ+Acfyo8es2bvkHKALB/U8HUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQvQit3ndxQn2lb4HlMC5iA7ytaSkwSfJ+Y+ARk7Obk=;
 b=C657vzBpcmLseR9GaA5vfS2AKFLtp8wfBzLabim5v7E4xMw0LS+B8s3AG9bKzerqZ7U0VJpS/7xx+0mLeml2aaED3h77AHGew96uQmhcb+SxG4qivwUFS78frajZ77aHZehzNGMWM5BabkGDVJWJ7ggLmf5GSLXy4OIiJplMvO8JLa4TAFE7weAPHCdK52F0/scyFlIVw3KtTxrhdvSTkFR8gDIZLMzL/6x38UuWID5gZdTrPDxS5QYrKYakGa0m3Yv6vat/bJv0lXPTRQh0MnbjI5n6DQCeHc45e6eve0sXTGtXBMB8RSLq+QtpiSP0WXtGMVMpOMN+ALzmM3XjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQvQit3ndxQn2lb4HlMC5iA7ytaSkwSfJ+Y+ARk7Obk=;
 b=LsA/qcOsgI9mnyr/ZzFk7EjsKvfdPSaNWKaL/9z/xQiPRAOGdcpSzW5IfonQ8pU9CBTIaFxSX571i4APZWVt5FAa/4QQjfjBRCWhmvAk1YFjwVwPZ0GgC9a7eKgX6E7zpfL3dJyZ8SN2uNiUl1KmTSQO26Zxzb7e7VIzZynG0rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MW4PR03MB6945.namprd03.prod.outlook.com (2603:10b6:303:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 23:43:13 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd96:913a:c06c:d606]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd96:913a:c06c:d606%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 23:43:13 +0000
Message-ID: <278d7231-ee27-602f-4ba7-45d45d6772b3@citrix.com>
Date:   Thu, 8 Jun 2023 00:43:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if ia32_disabled
 is passed
Content-Language: en-GB
To:     Thomas Gleixner <tglx@linutronix.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com> <87fs73juwa.ffs@tglx>
 <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com> <87a5xbjpk2.ffs@tglx>
 <875d0ab7-4470-25e2-6c01-72e231aae515@citrix.com> <874jnjj5z2.ffs@tglx>
In-Reply-To: <874jnjj5z2.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0100.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::15) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|MW4PR03MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 79515a12-b0cb-4873-3a11-08db67b0f521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O5SjPhwLNKeOIxzRoOizXIv+XmqCV5H54kyzJkSej+kinJA7MTdaXF6ZNEGjz918ohg8zQB1OmJdEEY4kP2oFnpz4TT7uB7I4y+qs7mnJobRE2kL6kCQ2KLEiJ54wcPWH0rd43L0fOJiGZX4LK27c91iL44nJRkYCLKf2NDLDg6Xx7eFtFeoy+pdrH/abqqaRz3z2Fc8yVhhKwg6FnYTO5RLUpQHMkutamkIsdodddSVS+IX71RcFXEeaxAHrG0z7ZdQd2u/oCHNhQKctrjREILOd0PALNc2ClT/Vxm9yCypTP0uvkeyo80CZZqD3CAfCJGwsny/yrtbKEixuXiDGfNmvUB8xSaOQ2BXKfnaokckJGdM4RzV6+B9/ILukf/8do9PBF9XAzyW1KnbXrfF5XxinwJa98rk+ddSWjWyh3JLPvukouX9wVgPoEWnrq3HDsKlfopGDibzPQ7wUiU6IdZrPRfL9CcLO6aoaqJx6RGhIvNtnKKGiPe1Vps6TRSQki9uS3ZOTdRgrhZoWaeiKnAzbK7dyXHBpg0cK0ssV8CsKhmlm0YgnMV8+JuF31j/uXyO/71vlCCEfQK26Vjyf+eOFFdWC/PDPFigt/UmvB/iuCOemyWCYQHZqXCcO1fNbZDekIbpNoT6OeT08DMp+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(186003)(2906002)(86362001)(66556008)(82960400001)(66476007)(66946007)(4326008)(110136005)(36756003)(2616005)(31696002)(83380400001)(66574015)(26005)(53546011)(6506007)(6512007)(31686004)(8936002)(8676002)(41300700001)(5660300002)(6486002)(478600001)(38100700002)(6666004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGpZWTlVeDN5bzZBaERNWVZ6cXB6TmdGbjQ5Z29QNEtENlI4UE50V0JEc3Bx?=
 =?utf-8?B?OE1oSXc1Wk5XOUp4eldhSElDZVJPMGRPUjVGS056UUx0N2NLR2xabm1nVFc1?=
 =?utf-8?B?VC9tRWpMSk1xLzNVcVNRYTY4ck1jdEFhMDJRdjZUdlprWjhMcVpjUzVLQVdY?=
 =?utf-8?B?U1ExeFJzc21LeWhyWlpESW9oUjluWmtOOCtpeGNRYWdoR0xsRXF3SHI1dXlq?=
 =?utf-8?B?aDczNVdWQ1JRaVNncmV5WmptbjIvdi9HcGhvMUtINEwvcTZiUm5zUGdoc0hM?=
 =?utf-8?B?R0k3WjdYODZlV1BiaWtTY0c0R25sN3hIRG4wL2F1QnY2aC9ncDloK2ZvZHl1?=
 =?utf-8?B?UmNhOERCKy9WamY2L3YrMERpZDhMUndzUnRhQnhFUnlJcDJpTkl0WXJMdXJh?=
 =?utf-8?B?ai8wOEhDOVZ1TTlwdjlWR2tOYk9PZXZQTmkvT1lSblZETEdKOExuVWlULzdV?=
 =?utf-8?B?OXRJRUJJQ0kwM0NEbHVlS25zRVVoZ3NzTVpURUVTdU1WOXhhNkp0YW1EUzIv?=
 =?utf-8?B?N3kra09sSXU1ZmE5dnpkNWUzQXVMeU9Wc0M5OXdhWVZCLzh1YTJqNWQyNzVE?=
 =?utf-8?B?OVNTalZMcWJPYk1CQmV3cGpIZWlZWkR4Z1R6OVoyM3FKdmthYm5sLytTR0Q4?=
 =?utf-8?B?RVFuMldwdE01ampZVDk1ZUpsUktBSjFkbXhqUXgwN2ZmcXk1WXFWcDZ1SVIr?=
 =?utf-8?B?ZkpkN0oxT0I4eFJSS3p3c20rSkdVMjZROVkvRFhDOWhGYzM0UmJrL1AySytX?=
 =?utf-8?B?TlE0VkVWLzJQWkpVejlFeEFhOCtKdFpaSDAreFdkTmhva2NiRS9iMHh4RlpI?=
 =?utf-8?B?TWlEdmNxSUxBOEUvaStycWR6dmFLdjVnYTVVY1JhSm1vMDN4aFRQczhpUnp3?=
 =?utf-8?B?MjZSTEJ5WnZSK3l3S3RCMXMrNjFYb052Q1A0Y1hweURHNHZoRitKRlVTaC9H?=
 =?utf-8?B?emRXUkZHM0dmenUxTGhmYU96OXpXWnZ4Ylp2aWZWcWxvT0JCNEtQU1lCaHJD?=
 =?utf-8?B?U1BacUVNK2JOQmcxa3dLRVM5RjdBQytsSjA3c0hHQUg1cjdPV2NSSFg4akxK?=
 =?utf-8?B?Z21Td05teFZ2eVArbHFQZlZJZENrelBHUWN3Sk1iNEJGWUJZdTdQelFxUURw?=
 =?utf-8?B?Mm1hMnIwL05YbDRVREZpL1N4UmI3SCtvK1lkY1hKS0NCWU81cENDY01yS25s?=
 =?utf-8?B?Mko3WHJOVS92czFwYWJORHFNR3Mwc2NkdEl0QXRyMWlQNC9JWm9OLzNLaG5p?=
 =?utf-8?B?OVhEdXl4cWlqZmdqV0wrTnNFY1ExOU5tUEZGb2VMUG9udXIwaFlvRFVWVEw5?=
 =?utf-8?B?MFZkRGUxTzZtRnIwYVdvVEdEVUtteElQemR2UUFPR1E4Ny9oMEZOZzhkeVkr?=
 =?utf-8?B?ZUwrU1Q4SjNGaGo0VzN3LzN6SG03QlpYbC9PSWwzT0pnZjlrQkpIdmVjaE1Q?=
 =?utf-8?B?WXU3ZkNDM01pT0llTVNmVTdPaHF4N2xoVXdscnVQVWpZZy81QW1LaDVFYjVQ?=
 =?utf-8?B?eGlXVXJRQ3ExN2lJeS8xMStncEQ2VU54TEs2YzliUitHOEFFMUdZcFpkK3NJ?=
 =?utf-8?B?WWo4TDdIRkhwT29BNGZsRVRNZHhRWEZUWnRBRy92YWNUeFliekhoU0RTQlFI?=
 =?utf-8?B?R0duRHhMMXZ1QzBqeGN4YnRVK2lzbGprL0ZqdnJpVzlHYllRN2Fldks3TURC?=
 =?utf-8?B?SGNwUGNiYUtoa0ZaemQyYnYwSmpuQURYYUFzRU84VDV1TGM4S3NWUVhSZk0x?=
 =?utf-8?B?cjBiZFJQUDA3ZGh2U3NMbE4rdmdSQzBOMkppd1JZZzJMTEhMeWRzd0V1TWpp?=
 =?utf-8?B?WE0yZllnbmMveGFjS3Q3MnhUeG43c3JXNG40amhTNW5wRVBEU1VmRXJPQ0JS?=
 =?utf-8?B?K2VKWTIyS1huQXpsdW9WUXRRdCtjczR3UGp2S3JPMk5BbklvczlMVTh2Znp6?=
 =?utf-8?B?c3FOTFVUV1VZZWRiR2ZGODFWczM5Um1LcDR5Y2Q1enJKbFNZNDBGekNyWXJL?=
 =?utf-8?B?ZGdBZlBJME9GekxFUURkS0VkUDlpZWRBT1A5YnYrUU92dUxaNlNaN0tPT1pi?=
 =?utf-8?B?ZUh6RkdXU1FrVUdhZ1hTWEU5cGlLN3Q1TFBHeldRMGViYXI4Vjl2RnB2UlpG?=
 =?utf-8?B?SEdqQnJUUmJMOU5SL2dZVWlrSENDeHQ3eUEyZWdSQ0k2NzVhTlV6REFNenZh?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xx8Ewsy4AGPid84PdtcwN1xRhioiOdfZPb6suC9KfEQJX1ioH358BfbsYke9Jq2Dxmlc2zLktJMFDqDOpfS+MKaaLYHkEb4zepWACGK2WKDX6B8GsbUbYGhUQPhoW8wNeqzt/h6ZQCL8GvEtAcQxNHyh+GWbz0na5DfEMgfpDLYeUX03vuj9MB5rctZV7pHFydJ2Ftwarc3ygXt5MEYv1Pzgaq/7Wjso1mr2k4j2qIdk6G8pd//seXJFVY6rxX6qM9iRKpgsB9kvX4niPiFOBHs/6h9kTuTWdITnMbCwSGmWji7M2+LFAVOwk5pr8XjBwt8qHqFck0lg7GeQZBGEyZFKr4AiI7govkVAhdtGdTU0E69eWIgYJ+Lsba6ARM31kElyPEjVAkc1I5cI5rcSsnHbmoCzwkeosnaSFKSogR6u3DMM4VY01ULWizctlX4Fd6l1c7CMtBfWwIH7faZu7RRH7WkJeSvXc9AtwV3R1XyhocL0aT4RdWUCcFfIdqyRU+NkHOSFXER7PMohf05KmCSI8sSET1jYMXoOV5xtM23wTgnRAqxA7nTMiD9JIGH7s5ycjtC2/kGx1dwUrdWUPudtrRAlR1xduZEN4xpmeec94NBG9ciHofPV7LhXdNx2i8JVJ29cTl4IY+eIvpnxAkswJwtAnrXBOxyX1xRs1O2sSq6qNZEvYw6lz1kbQyDsCQJ2PyZKeaxgRutr0B+Q8LuFn/9BXD6xdTMyMDf29scnhYszKSGCI0/DKt2caWZnRfQoNN1o+ZCQAxp04l1RTyfr0NC0rrBYdCB3LbADj2pwzXJ276u6ka1T4CyFme1ToP53geOWVEvsYVMXGCnhI18sK24uOvDqffH0u7hw6Xt84k76W76jDgBI3wXqkP6w
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79515a12-b0cb-4873-3a11-08db67b0f521
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 23:43:13.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOTZ1EppN4jXYBC1IvLH8B9bZXTDoq5im+6uVttKc2QUyPyZ0yEzStFQty5s/hb5vV1FbZX6HgQgdtXhGqcX+OWgXzLDTDHzKeGKWkyyEx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6945
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 10:52 pm, Thomas Gleixner wrote:
> On Wed, Jun 07 2023 at 18:25, Andrew Cooper wrote:
>> You also have to block Linux from taking any SYSRETL or SYSEXITL path
>> out of the kernel, as these will load fixed 32bit mode attributes into
>> %cs without reference to the GDT.
> That's non-trivial as there is no way to disable 32bit SYSCALL on AMD
> (Intel does not support 32bit syscall and you get #UD if CS.L != 1). So
> to be safe you'd need to make ignore_sysret() kill the process w/o
> returning to user space.

ignore_sysret() desperately needs renaming to entry_SYSCALL32_ignore()
or similar.

And yes, wiring this into SIGSEGV/etc would be a sensible move.

The same applies to 32bit SYSENTER if configured. (Linux doesn't, but
other OSes do.)

> Though arguably if GDT does not have USER32_CS and LDT is disabled (or
> the creation of code segments is blocked) then invoking SYSCALL from
> compat mode requires quite some advanced magic (assumed there are no CPU
> and kernel bugs), no?

Plenty of arcane magic exists.  Rowhammer the GDT, or exploit a VMM, SMM
or ACM bug (all 3 of which can load segments behind the kernel's back),
or Red-Unlock mode which can write the segments registers directly, or
you could play with the AVX512 brownout erratum some more - the
descriptor L bit is only a few bits along from DPL...

But if we're assuming no bugs, then no - I'm not aware of any way of
doing this.  There are only 4 instructions which can reduce privilege:
LRET, IRET, SYSEXIT and SYSRET.

>> And you need to prevent any userspace use of the LDT, which might be as
>> simple as just blocking SYS_modify_ldt, but it's been a while since I
>> last looked.
> CONFIG_MODIFY_LDT_SYSCALL=n is the only in kernel option right now, but
> that could be made boottime disabled trivially. Extending LDT to reject
> the creation of code segments is not rocket science either.
>
> Though the real question is:
>
>        What is the benefit of such a change?
>
> So far I haven't seen any argument for that. Maybe there is none :)

Hardening.  The general purpose distros definitely won't care, but
special purpose ones will.

An x86 bytestream is decoded differently in different modes, and malware
can hide in the differences.  Standard tooling can't cope with
multi-mode binaries, and if it happens by accident you tend get very
obscure crash to diagnose.

Furthermore, despite CET-SS explicitly trying to account for and protect
against accidental mismatches, there are errata in some parts which let
userspace forge legal return addresses on the shadow stack by dropping
into 32bit mode because, there's a #GP check missing in a microflow.

For usecases where there ought not to be any 32bit code at all (and
there absolutely are), it would be lovely if this could be enforced,
rather than relying on blind hope that it doesn't happen.

Thanks,

~Andrew
