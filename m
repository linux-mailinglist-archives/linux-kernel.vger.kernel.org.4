Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A421B72AF99
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 00:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjFJWvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 18:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFJWvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 18:51:44 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202BB35A9;
        Sat, 10 Jun 2023 15:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686437503;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FqlR9MC0+JwBTU3LYaBKWlf2cmR8jSePKt3Vavd4kWE=;
  b=UHoI2HLp6vxB4w7H41XRrOyKacf4KJAMVOM1x9vc7/SjiNDQq9D1USTG
   CwG9dEHwdtph9U1POtJGCIqDTMCiiq3BVtuX/nQ0HnI+A+p4bZbA9t3gl
   Xcb7VSHpQ+yhRB/hfmdO74RuJdD6RoCekGlVldmpQRo04mEElGqduU6HB
   c=;
X-IronPort-RemoteIP: 104.47.55.177
X-IronPort-MID: 114844557
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:grn/zqqaF28t+qIox6iaz4oaV5o6eYIsimQD101hICG9E/b0qy
 nKpp9w6faaslYssQ4b6LK90cW7Lk80lqQY3WByB8bAYOCOggLBEGgI1+rfKlPbdREW/9QtsJ
 tdTw==
X-Talos-CUID: =?us-ascii?q?9a23=3AS26j6WrVnsLK1PYOLa5MEM3mUcMHLCL7j0vIGh+?=
 =?us-ascii?q?xUTpWapTPYl3Xpbwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3APR9ZBQ5Z1Ot+wqvMJcWXe0NhxoxXxKiCKVs9jak?=
 =?us-ascii?q?Yoo6NHitXJBWgqSieF9o=3D?=
X-IronPort-AV: E=Sophos;i="6.00,233,1681185600"; 
   d="scan'208";a="114844557"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jun 2023 18:51:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQ7pABnP7PnnvnWBc4GJOw/4vmA4cqqfThlF/oe0ZCySzeEHm75t1gVotvU556ku3KEic3nn5NyTSW0p/LeVrYOVfdYkVbiUok7/MC58deUI9ikugca+ePBRNm6r6qD1gufW3gEjrQCLOJ3uXeWnC0YfP1t2mSbX+qF7PWBBg3iX3T3KQx0zI0C6MgU3T9Yb/+PsAlXvY9N1c+/KR1pJcSgY0ZlsZkdQBGBuxYT3Gp2H609vCcNqmzSg6Nkn6gJIRKr+IGq/jkP4oTrD32QAYGqFyN0QypXHQOhuDOqCusbpzGDHfXXaBg1ZGtX6BkOTFP/u+zEY00pOFwIqDq8gMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqlR9MC0+JwBTU3LYaBKWlf2cmR8jSePKt3Vavd4kWE=;
 b=kAUTqLQiiiKf42eh/zj9XBGROLjPRLLisoN4K7BBHZdOeUMLNoFmdbesPAil5MXAgXhPrAIq2L7HV+x+dzJrWI9WWtPifIUYTghRZfICJxD31H0OUv2c8fAlosrc9DSQCNPUxktbOzsCkdu9/lPZ105cSzvC/vmSQOL3HVhG5L598/TIM+hPYKTOV2NtUFldPrXAa9g3WvsXqjKB1lA3ElRaTjcqQ8DIHhjQkKp0ZVmqd6QrpKYEK9EOOReETD/f/8MuDz0skZSPsCvnTnHz7hC2R8MXGrRCvnG+URphZG63T5yNOS+uFhieADzUyQQDcq7FmYQk/K8nXZy+nDqtOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqlR9MC0+JwBTU3LYaBKWlf2cmR8jSePKt3Vavd4kWE=;
 b=U+uhZFKCTNwELFtdNQZr3xjdH7u7CkhGWTC/IJkACj0wAFpxDCxkfpgYulAwf6Kuoe8YELJ06k3iiRbng5ju1d6hmrqdCa3n+cNpouUwjP88LVEhrI3olyLqAqLNT8mJEIduWe/0O10e5GIFkfECqCMjVAMrRs/+yKqvYenL5KE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DM4PR03MB6094.namprd03.prod.outlook.com (2603:10b6:5:395::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Sat, 10 Jun
 2023 22:51:34 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd96:913a:c06c:d606]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd96:913a:c06c:d606%4]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 22:51:34 +0000
Message-ID: <6333ee51-dfe5-9742-54b4-377bbc73120e@citrix.com>
Date:   Sat, 10 Jun 2023 23:51:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   'Andrew Cooper' <andrew.cooper3@citrix.com>
Subject: Re: [patch] x86/realmode: Make stack lock work in trampoline_compat()
Content-Language: en-GB
To:     David Laight <David.Laight@ACULAB.COM>,
        Yunhong Jiang <yunhong.jiang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230508181633.089804905@linutronix.de>
 <20230508185218.962208640@linutronix.de>
 <20230524204818.3tjlwah2euncxzmh@box.shutemov.name> <87y1lbl7r6.ffs@tglx>
 <87sfbhlwp9.ffs@tglx> <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name>
 <87bki3kkfi.ffs@tglx> <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <87h6rujdvl.ffs@tglx> <20230608233402.GA3430@yjiang5-mobl.amr.corp.intel.com>
 <a56a06c2-73fd-5295-3f6c-922ccb078488@citrix.com>
 <67f939e112cc4578833ca74123bee402@AcuMS.aculab.com>
In-Reply-To: <67f939e112cc4578833ca74123bee402@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::7) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|DM4PR03MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: c451994d-4add-45a2-0deb-08db6a053cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +sP2qbbpBxAN/cQULVSp73si9jgp4NE8SMr5uJ+Ubgc8noQE6SQzdTWK2xS5lkC1AMrVA8+OLton7073Rnkc5PHWItDo2BBkGLq3yTYYjs3t3Ue0StbDupID2/o84a6ZPl0olry1UlDRToRBZDovWAJtj7tbs94NPX44oM2KmqkPvh8c8JGX4O0HRmdxorMelqG1rUAHuw0L1fvHcFnMQM0aY6OJPEyplG7tf0e7TrpVvRnxGpFTkfIyrrCsPTweoR0cXhTQVlnhWp3WHB8booal5Ps1OshxwiYhIaGkuWBmkdRR4Mz77qHz43BFP+T0xaG/iArAhEKk+1O+NhhjHQDzAie0O8d4otZ7TbHR1vDL2hvmIWrGLAbGc7A4K0nBynMvjqKmiUit11bYzEYFJOXPAdT6jZK3i5sNL8iknxDt0JYOFkyVTvRBK3MBCm2HCA/jiasAXdwVNUG2pcpF4ljaPdjEv4dxv0wPgNplxi+M2vA+HBJtX0J0qZcThGNE7H+EasQA+PIU55fVMOpHPjO26nKHuouaeBC00scLY1T9qzePFxObOPKC51oURndE65jH7E+m3dBunMPu6tsxbaAydct1IImMm8rgOSFnlM8q01mxjV3OQYkV4aKX/7hqbuKTBexyin8svqmXdT+whg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(4326008)(66556008)(66476007)(66946007)(31686004)(4744005)(2906002)(186003)(82960400001)(38100700002)(6512007)(7406005)(8676002)(86362001)(5660300002)(36756003)(316002)(6486002)(8936002)(6666004)(54906003)(7416002)(31696002)(41300700001)(110136005)(2616005)(478600001)(26005)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OStRbmQ5dGtOWjZZK2V5NEJWakprZzNJd1B1d1J3MHJpNTltd1Y5TUp3WDRv?=
 =?utf-8?B?YVRrajdxMzFsSFR6NXRlRC8vV01sQW1nN3ByOW5uejY4UG83Zys5M3BpcUlh?=
 =?utf-8?B?TGRKcTdZK1FoUjdtbU5jVjY0TU5nQnpNczIrOEUrQU5rOGlXakxOYU9iRk1q?=
 =?utf-8?B?TWxybWwwNC92NE5nWFErY1crRmtWcFFhZ1VueUcyMWdqWllxbTllT1IwQWdP?=
 =?utf-8?B?QWx2RTVmK2VMM2VvTi9PYUZBQkFiK05QOG1zKzMrL2xjcHFNeTFVMmJVVGxj?=
 =?utf-8?B?a2ZJTHM2V0tUeVZEZ0dmU0QxQk1nU3NWVzJSNmovSFhnd3dvTVRvWlQrUjRE?=
 =?utf-8?B?U2F4WUs3OUlFbW1GRDRQb0VTL0NMdjRzUXNoeXBFQ25ranB6elRLZ2lDM2FW?=
 =?utf-8?B?ZmxuUEwvbDYvVnE5NDRyR2w4TjdhR1dHeTZrRUpTRWhaWDF3THpleGZSamRM?=
 =?utf-8?B?QjdwLzd5d2FWU0RiTlpzN0FIalNadU81TXl0bDdYdFpBejNmQ3lkUXlMKytO?=
 =?utf-8?B?T3B5a3JsMHVIWTZiQXhLZjhtWER0WWVld3NWRHRCZWtlZm1ObU8wV2Y5MHJr?=
 =?utf-8?B?bDlJWitqbytGNUN0R2JXZVl5V1NrNGxpYlNXMjlzaWxkRGJLQm5KVi94UnFP?=
 =?utf-8?B?cjYyWW5KVXREZ0U1bDUzdjgwTUVnQzRTNE1pQ2FsV0ovbmtISVFCTHp0N1RH?=
 =?utf-8?B?dlBPSXYvOERSNXRjR21uVXU3S3IrRytLZXNqZGVFcG1YZjVFZEV2dVZ4UFpK?=
 =?utf-8?B?TjN5YkIrdFBYeWRYTkttRUJYOURpY1dUTXJrVWoveHFETGo5NDQvS1BRbzdt?=
 =?utf-8?B?Q2VhU1JlRERzREpWaTgxSFV1MTBmeGJzbG1zc0YzL1JrOUFtdTFmeHRGWm9v?=
 =?utf-8?B?Qi9hWXVSdDRvRituRXBaN1l4Si9OUTFWajlFTC9ibk9CVEdkK1JyVUdVQWcy?=
 =?utf-8?B?T1hjbTM4RkdUaUloOEFwbFR6Qk10UHRLVS9sQlJXYXBZaGlEbnoxY05zb3Ji?=
 =?utf-8?B?TnZzQzlnbk9lazVIWnhFSjlhNTRXdEZKTy9XdVA1TFMxS1E2eWp5a3lod0ty?=
 =?utf-8?B?blpHUXlrUE55ZTE3LzBMSWNQSXRDbXhzRVdUZ3Uzem9tSVFqcVlRNmZoK3JP?=
 =?utf-8?B?WWFJSzNsZHlyZVRKdFRiRWlGdy9ENjFJVmNuMWlXbXo1U01ORm1naHAzOW9F?=
 =?utf-8?B?UW9Fd0J4YXY0bWZueUltRGt6Z3ZGSkRSWGRRSXQ5QnhXQ1VwMlV2YXMwZFE5?=
 =?utf-8?B?NUcyT1FIMnJlbDhzSHJJYm9NTDFvWGJHOFZwSTJhUUpFRWVlMXM1OVdkSDFq?=
 =?utf-8?B?Z2JBYXF6M2pRazlXQlNQM2hKajYrZlZNZk9lN3NVck9pQWNpVnJHU2NHTWxj?=
 =?utf-8?B?cndCQnZwb1hwVGlsL2RHMWtrcE9HaWFSQWxCbmFTeEI1bjNNUnFaUmN5MUJB?=
 =?utf-8?B?cG4zRk4vNVhndnhyOVdEeGtUTXJjUzlFYWtlQW0vd1d6TXlmNTZJd1NGbFRY?=
 =?utf-8?B?aFYrQ24zWWdIdXlMTnZobHYwQVRCK0FwQjJ5Zk1PejRac1lxeVZXbGE2Qktz?=
 =?utf-8?B?WUtqQ05DR1ozeGtKZ0lFU3dYbDNlU1YvZ0xhUzVaTGRxU1o4aElzRUo2T3Zk?=
 =?utf-8?B?V2lwOVV1bzF5elgvTldLK2JJTk15eERIYlNhVEFJQkxtaEpRVzVrYy9yVE5R?=
 =?utf-8?B?dFN2MGd6OWF6RUU5MHRUZlhLdFEvT2tVQk1Rd25Bbzh6QU5neSthS2lRZHF3?=
 =?utf-8?B?aExpZXBZWVV1cTFCRHZITHZ1Y0dLdDgzSUtLeWg3cFQ5NmduM1h2SjNTaFZQ?=
 =?utf-8?B?bFFiUElWRk1OcE9xUmlCM3FKeWlHSVRrZXcyN3BPQm45MWJTRi9sMlIzVlFH?=
 =?utf-8?B?UkN1MExwMElmZ3UvQ3AxQU9STS9SVU5mV1JtdCtTV0Q1ci8rUDQrZ0g2UjE1?=
 =?utf-8?B?TGdMajZzM095cVA2ekp3bm5Hc1dTODdWYnp4WTg4NHVwaWlGeTlEbVZNZC9v?=
 =?utf-8?B?b25CSXJRUG1vQ3pTRFpwZVZvQzRlN0VPNXhWb0tKY28xSjFFcWZnWkx5ZE9P?=
 =?utf-8?B?ZkQrak9nTWJCNzZGbFp0OE1wbnp3U2xPc1l1ZGVrdEQvYnZKSjdObExGdWoy?=
 =?utf-8?B?WDhWd0lPK2l4SEtwVFl3MlBhazd6d1dhc1Y3YmlucXN6d2puRUo1OWwrTGxD?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aEViU3NvZmFvMkxqQXpseS8wb0RWcndIMW1jZVlEUEVRaWowWXlCb1RWdjhr?=
 =?utf-8?B?R1FBT2pjZS9GQVFTS3EyTVY2alJTRExUVVpoTjBnWnNROEEwcFVWWWpqTENX?=
 =?utf-8?B?bSttRFRjamJ0b0I2cjh3YVZQZ0xLUVEweStsZGpjRGNPODdmSTFCTytPbTlL?=
 =?utf-8?B?T2Z4NlVrVXNOZFlCdEhZSnJKbFBTdVpwOE45cDg1ZTBiTHVQQzZPQmYvRm9E?=
 =?utf-8?B?QUlpaS9HdFlFTDF4bHFmVVFOaHdlaXcvTDdRYWsvQ0JlSTAydVdNRXRXSzlt?=
 =?utf-8?B?TnM5T1hOZFBTWWw1NGRyYldTTVpkbFZnd21CWmVLVHdjeGdqVTRTNWx3cWlH?=
 =?utf-8?B?QlRJOG5GVWJUN1pVTnFuZWtjN0hwR05JUVFPM1N4SGR4UmZmR2Q5Q1NLY2V4?=
 =?utf-8?B?aDZldVIwaDNpVUUrQnRvMWtETk9CYlB3b0dBaWhUUjNUdWlHR1RWZ1dHNXpi?=
 =?utf-8?B?ZUdLa3I0MFVUV25PMlRxSWdGblZIRU5FZkZzVXFaKzB0bjUrYkxiZzhnMUNo?=
 =?utf-8?B?NlZDam11VURMYmtDZmx0UHJzaXNXWkZMZ3BIK29tZzdOa0p5N0JoV1RDd0Zl?=
 =?utf-8?B?NzFOZzZkNWcyQzlwZ0hpcGpwVGRDWjNQRWMvb3ZyWm92YW1rSHppdy9zcFJo?=
 =?utf-8?B?Zjk1YndERlNPRkJyYjh5ejk1ZWQvWjFnL1Z2bTlidEpWWVZHM0x2SVhhcjBm?=
 =?utf-8?B?aklwR0FWZENMNExDNk84ci9zdmJGZHBnUGJNQTczNDZKRXdza0JhcDNrcENk?=
 =?utf-8?B?Q0h0T1dycTk0RnR2S3ArZGhHcTltNkxHdkF2N0xjSmIwSzZlWlJSZDQ0ZE5M?=
 =?utf-8?B?dnp4NHhHc2xSSUxJckV2eE9aU1dnbElzV083UTA0ekc5VktvNVQ4cVVKUWVZ?=
 =?utf-8?B?eXJGbXIxU0lRb0tzekJoVDJ4T05LUjMzaEkxTG81cWw5TnRYTGFWZDh1dS9s?=
 =?utf-8?B?RW1QS2JvYTlOdjVBNkttZkNZZlF0bFJJdnZ2a3NBUDM0RVhRK3RCSU16K0Qv?=
 =?utf-8?B?bkx1K1dTOEhjOWNPTDd1MExPWlRVbDBHNWZLUit4bmIvYzhUZmRIVk5ZYU5l?=
 =?utf-8?B?MzFKeWE1eHV3dmNUWjFKY1dXYjN3bjBrQ1k4YmZIcmk4Lzk0L0g1Y3k1OE1T?=
 =?utf-8?B?RDlKYXhUVElXc2lJL2RZNFRLYVY1dFNFYlpKMnlFWmgvVkwwRFRLYjNiR2h1?=
 =?utf-8?B?MHVNQVk1Z1Z5RlNTSzF3dHpkeVRuOVkzOFhPdVlxMU92VXBwZ3NOQ3ZHaWhh?=
 =?utf-8?B?YnlwN0U3cXpLZTBUNWhUUWI3dUEyUjZLNnR0d0Y0UXhQNFR4d2RxNm9uUjls?=
 =?utf-8?B?cXF4WWFDWjFGREI2d3VoYkdEb3NmdlV0K0Z5d0R4NVBZc1pESHB1OENCVVBp?=
 =?utf-8?B?Zk9Pa1E5NzZyamZ2ckV1cnp2UGMya09ZbDh0dXpsRFd1YkY5Y3BtbmoyeWpT?=
 =?utf-8?B?WHV0MHFiQkM1bmZXRG9OK283L0tKQUNNVUZiZm9VN2R6V0tKeVRTRzNidmJH?=
 =?utf-8?B?eUNNUUdiSnR3RHBtaWZlTjhwV240VUxwaTFESTdnRTdlVDNGLy9PSmhBTWU3?=
 =?utf-8?B?ZTZiMlRmUVR5SnMyN2JZOUkrVWNURzkvZUJpazV1Y25GajBGcVRxMVNZUUxw?=
 =?utf-8?B?YVpjU1NZMEZKNG1WbkhzNllwZXIyNnBOUU0yenlqdGtNdnB0eElKK1JwaEJp?=
 =?utf-8?B?SXVMbUVvTzcvWm1VYWE4YndlRWVzMnlXUEVCWWM0K2E1SmxKc1dhUUhjd1JO?=
 =?utf-8?B?RktKa3BNczNXdCtJQ0VrcFIxUGlwSFNnTjN3aitCVGZWdDBqWlFyU0t1dGtv?=
 =?utf-8?B?K3dXUnFRK0h3bGlIb0ZNeGJqN2hKZjN1YU05MFFvWklxaWVENUtJM3NuTXUz?=
 =?utf-8?B?OE5yTlVYSTZEQVMxb3BhNWVHUjgrTFlkZEg5ZDZXUElPRFlBanNBUjNkSjho?=
 =?utf-8?B?VkJnQXk4UGljTHp1Q3pSNGxLaVRmNjNSR21pNTNYbmY3aDRXbWZpcVR2Q0FX?=
 =?utf-8?B?Tm9Lei95UVVpQ1FKNkl6VHh4M1BWTUpOL0tnaFVTMXMxTGtCQUU4RzhYZ0o4?=
 =?utf-8?B?YWd2cGlaVklDK1I1NXhHblZjSGpRc0thWkRzVnBhOFhuUGlWdnB6QURXTHNI?=
 =?utf-8?B?djRBVG1BU3FQZHpQOWhjRGlUa1NMUkdmNy9NMDN6aXVkN0MwNVFoMkxsditn?=
 =?utf-8?B?TXh2SmZ2UWI4NDNZNW5RSGV3TXUyV2VBSlBITGpoakJrd1VGNVBvWjU3TXVq?=
 =?utf-8?B?Nm80Y1E5Q2V1V3RlTE44SUdXb0l5bXgxelg2RFJpY2JqcHZqTnZOdFUxcFlS?=
 =?utf-8?B?Y2Q0eXNUZ0t5dXo1cWRKcTRrVWFNU2RCSWNiNzVMeDZZU1AvWS96UT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c451994d-4add-45a2-0deb-08db6a053cfa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 22:51:33.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/x+GL309VYkBXFox8LCJu8QWRQgAbL83tU0cNKheWagoGQSbDE/DlArKIhtnWMM2xAgMF6FqHuQEjg8z1iq5V0nnZfYHo336JjHkr9R87g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6094
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2023 8:50 pm, David Laight wrote:
> From: Andrew Cooper
>> Sent: 09 June 2023 00:58
>>
> ...
>> The important point is the l suffix on btsl, which forces it to be long
>> (32bit) irrespective of the default operand size.
> Does that matter at all?

Yes, or I wouldn't have wasted everyone's time saying otherwise.

I recommend educating yourself with the instruction manual, rather than
presenting a set of statements which are all wrong.

~Andrew
