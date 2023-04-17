Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1626E45FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjDQLDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjDQLDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:03:33 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57371FDA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1681729362;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fW9Y+j+jGHx3UA4FbuEAPpQFY3f0K+SKfdS7u4XCBz8=;
  b=MZ39XI+EibV40Pg7eRdNwswyrT0w8NeEKNdOaLmHyjFBPp818GQckcrC
   /xOS13puTjwHSRVXnmsX810iDQ1hpGW4cbjDyOmxfFy71fl0+NGHvIfU6
   E7wTz/26Azblk6qeaH4MM6FdXxxSwdd1s2/06QQN2Pcm+fmjvOrHCxtTk
   M=;
X-IronPort-RemoteIP: 104.47.51.47
X-IronPort-MID: 105692443
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:BK+A+aDHYggiWRVW//Xlw5YqxClBgxIJ4kV8jS/XYbTApD8rhDZWz
 zQfXjqGbP+CMTCkKY8gady3pkxXvsSHzoA2QQY4rX1jcSlH+JHPbTi7wuUcHAvJd5GeExg3h
 yk6QoOdRCzhZiaE/n9BCpC48T8nk/nOHuGmYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbyRFuspvlDs15K6p4G9B4ARkDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIw+utsLm1u+
 f8jAz1Ra0qFm8mf7Le2Y7w57igjBJGD0II3nFhFlWucJ9B/BJfJTuPN+MNS2yo2ioZWB/HCa
 sEFaD1pKhPdfxlIPVRRA5U79AuqriCnL3sE9xTI/OxrvAA/zyQouFTpGPPTdsaHWoN+mUGAq
 3id12/4HgsbJJqUzj/tHneE37eSw3KhBN5JfFG+3qA3unq83WY8MiExUUax+qfppGe9Zc0Kf
 iT4/QJr98De7neDVtThUgeqiH+CsAQVV9dZH6s98g7l4q7V5RuJLmEeSzpAbsE28sgsSno31
 TehlsnvCRRmqruZQzSR+9+8qTK0JDhQJHUHICwJVw0I5/HnoZovlVTOSNh5GaK4h9GzHiv/q
 xiBpTQ3g7QVy8sCzaS99Evviiip4JPOS2Yd+QTTWkqm4xl/aYrjYJangXDU8PFaIYCxTVSbu
 nUA3c+E44gmCZCLiTzIS/4ODZm36Pufdj7Rm1hiG98m7TvF02K4d4df7TdyDE5tKsYNPzHza
 UnQtAUX6JI7FH+ra7JnJoewE98C06ftD5LmW+rSY94IZYJ+HCel9SRjfgi62Hzxl00onLAXO
 Z6dasuqFX8AFaJq1iG2Rv9b2rgurggyyGfXSIrTwBG3l7aTDFaRSLEYIB6WZ/o496isvgrY6
 ZBcOtGMxhEZV/fxCgHP+JMXa08DKX0gAZ3ng9dWeO+dL0xtH2RJI+fYxbYsYaRplq5fm+PUu
 Hq6XydwzFv5mG2CMwSRYW5LbLL0QY05rHQ1JyUgMF+knX85bu6H/KoZMpc6Y7Qj3Ohi1uJvC
 ekIfd2aBfZCQSiB/C4SBbH4pZZhMg62mQaHOSaNaSI6OZVnQmTh8Nj+fxCp8zISFC2prsgvi
 7q63wjfTNwIQAEKJNvNYfemiVqrvHY1kvNuUkfBJNJePk7r9eBCNyP1ntczIscRNQ/EwDqKk
 QqbaT8cpO/Qs8o2/cPPiKSssYikCa19E1BcEm2d6qy5XQHKrjSLwoJaVuuMOzfHWwvc9Lqne
 r99zvfyKvQLkV9G9Y1mHN5Dx7gx6sH0u5dVyw1lGDPAaFHDIrp6IHCA9c1OsLBdgL5fpQayH
 EmI/7FyIb+OPtHkFl85Pgcpbu2fk/oTn1H69f0oJEDx5wd08aCBXEEUOAOD4ARBLLxwOZhjx
 eontMcd6B2Xgx8mdN2Bi0h87GmFKH4Le6ogsZ4eDcngjQ9D4lZGbJ/HAyn6+rmJYslFNkQsI
 TjSgqPHitx03k/PdWg+EVDI2u5SiJJIvQhFilMPT3yGgtvOjfgz3TVQ/j0zTw0TxRJCu8p3J
 2NpPkszIbiF/T5ug9ZrUGWlGgUHDxqckmT91F4WvGTcRluvUCrGKysgOo6l/k8D9HlHViNG5
 7zew2HgOR7xdcvr1zM7X2ZsrvXxSto3/QrH8P1LBOyAFpg+JDDj26mnYDJSrwO9WZ9uwkrau
 eNt4eB8L7XhMjIdqLE6DI/c0qkMTBeDJypJRvQJEL41IFwwsQqagVCmQ31dsOsWTxAW2SdU0
 /BTG/8=
IronPort-HdrOrdr: A9a23:bCC1sqDd/L4CPQflHeg5sceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U8ssQIb6Ki90ci7MDrhHPtOjbX5Uo3SODUPNgGTXeZfBOfZogEIeBeOvtK1t5
 0QFZSWYeeYZTcVsS+Q2njaLz9U+qjjzEnev5a9854Cd2FXQpAlyz08JheQE0VwSgUDL4E+Do
 Cg6s1OoCflUWgLb+ygb0N1FdTrlpnurtbLcBQGDxko5E2lljWz8oP3FBCew1M3Ty5P+7E/6m
 LI+jaJq5lL8svLhiM05VWjoai+q+GRi+erw/b8yvT9Hw+cxTpAor4RGIFq8gpF4t1Ho2xa6+
 Uk6y1QRfibrUmhNV1d6CGdpzUJ3FsVmgLf4E7djn35rcPjQjUmT8JHmIJCaxPcr1Etpddmzc
 twrhakXrdsfGH9dR7Glq31fgAvklDxrWspkOYVgXAaWYwCaKVJpYha+E9OCp8PEC/z9YhiSY
 BVfbfhzecTdUnfY2HSv2FpztDpVnMvHg2eSkxHvsCOyTBZkH1w0kNdzs0CmXUL8o47VvB/lp
 P5G7UtkKsLQt4dbKp7CutEScyrCnbVSRaJK26WKUSPLtB1B5sMke+G3FwY3pDaRHVT9upMpH
 3oaiIniVIP
X-Talos-CUID: =?us-ascii?q?9a23=3AsCwjXGm6gHYYepYa4m7Gp5ak1bPXOX3Q11jcA0O?=
 =?us-ascii?q?7Mk1kFLjPT0O70Y9hnuM7zg=3D=3D?=
X-Talos-MUID: 9a23:8s48uwvO0NxVI/sIgs2n2mxYE+hz6YuUNGcJjJ9d5ZmqHC9OJGLI
X-IronPort-AV: E=Sophos;i="5.99,203,1677560400"; 
   d="scan'208";a="105692443"
Received: from mail-bn1nam02lp2047.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.47])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2023 06:44:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bemZVqoo06j/0liAU3QeQysHX6exlFmUOVkQDlFdrjEN02ijjjOIahYQjTlSEVGxFkWGN2ebzHzw+pO1cuBbgV7FpvmXf1U9SmRQf50ae1WaeWXWGhDgjKJfEbVTQfkZD1agUSw6+ByRc54rUh7RByF4x44FwjweZJ2R3WecPW8y9jVoVM3DF/Y6OMqH1RbDeuOpOchaDljmTgUSdrP6qXxL9nszl3h2kHw2hLMoP5cJ8wh5oTsqETWSE1FxPNgpcT3iKOwzVcuA9DckBub3hFVEPn+nHY0DfvtabQ5FGde8CRuEzvYlbzJSDNgfaN7DyKIc21hJfcb65MJBmrRVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuffgUis9cpulCJM35538EEjK3qLzbj/4QHfErdU/c8=;
 b=PzzerW5LkBUh+esbneENdCIChDwqTpooec28+LI/5jheHALkhOPiEOPsGvC/6IV2n4ZW00h+b8GCE/MMKe0OqCLTx8ntAI9tLSRm+qmxklgSxfNC7QFW/SDJETv0nsORDE9xLDqipOJLhtBckapEnC+U2T0Sc3beo2/a0P98nQOWZX4JaAFFo8ZudGkH0uuGCvBJmRY8pWM3O5oWinHexvTHWKcSnZgCNQkRUW1lP03C93KUsENowmv4QJYhUWn5Kh2SPrzl/GjFatiCDF2PX2I7N8ScUZdTHBedbb8GZTtPKWZEDaRL+qSvVb0jr4EMV9S+v7/Fb7K8c9baNrfLww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuffgUis9cpulCJM35538EEjK3qLzbj/4QHfErdU/c8=;
 b=kWTQjaXfy6kAVI4wPngH8cEAWeIOkH+ZA/DZHTx/4vJr1fEm1/HAy36AnlyMsXm2+FNy6c1mQ2ejeYZ6visLNvEJv8wZ/HF6bM6bbFJIGdywdxj4aU8D6MXSibjqcPmtxwJp4qV3F1Col65qKOd7gkBslHhaaxnEjCUkJzjsBlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MW4PR03MB6965.namprd03.prod.outlook.com (2603:10b6:303:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 10:44:18 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::a5a1:8cae:d45b:2030]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::a5a1:8cae:d45b:2030%3]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 10:44:17 +0000
Message-ID: <5f5c9395-f9e0-cb9c-4929-cc0134f9b895@citrix.com>
Date:   Mon, 17 Apr 2023 11:44:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [patch 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
References: <20230414225551.858160935@linutronix.de>
 <20230417103050.GF83892@hirez.programming.kicks-ass.net>
In-Reply-To: <20230417103050.GF83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::12) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|MW4PR03MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: feb5a54b-5717-4e4b-5c8f-08db3f30b146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQb4ILpVeJxZmYmUVkrWJAqPbKyRWmXfdTpblmGMcvmej/7ROZKjtVBclOLYM5D0vWZ9NKGUruLRJGncYDk4PAkhrhE6ghs/yI7x+KjTv6bPgheG0ciDBgVsoO01F88ocFLAdf3GCzy7QMMYTPVoerOMrWtvAlQnqnc1aynn+k6OkMs3DY4gFZZSaJbjWUKPWS5F0Z3UmbL7KF3SXMH5DumfZ1+swrpnSTwvvFjNXs6sIDQCnJidGJCQ8zwrmSakqzj2f7U0uQ8GbYPuWLCpQ4rzSjtD7QQc0uQAanxn2IU25CwCH4iDi3X5eQWMAKI8iLI9B9AE5houIcY/r+0pPUIzkp2Z8xH6Hmoq0oeEUSYAnYxwbspGMhlucPuTzaFWZzUCjJTBkf726pRJTIYiZxT7Lypfz1b8RZasolGUbbN9jvAa8WbEFViOHcUc7q4cF8KbF8IFgifTqRXQVWn+HCQ3lpVws3eG/8RAYr+3Gexa9BYHDUzPiK9RJ/lOed9sNr24D8BoiPbTJHBT+ovgiIBp4kSbXJPmb8nSMtspIROQ86dnPUh5Vcy0SMcw1M0zDJBtVt6lf3XMELMvVHLBN6rCcNSIq+XQ2iMPLSf28MLU5w5zl+Iigct81mI1kSve6C8cx0lZTl7SmFQCRqp7dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(8676002)(83380400001)(110136005)(2616005)(54906003)(478600001)(6486002)(6666004)(6512007)(6506007)(26005)(186003)(53546011)(7416002)(36756003)(38100700002)(7406005)(5660300002)(4326008)(316002)(66946007)(66476007)(66556008)(41300700001)(82960400001)(8936002)(86362001)(2906002)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0xBTjJaS1JLZ2ZPS1huZVI0RHV6cHBaeHFwVlpLakVBeGlNY0drV1B1UnFG?=
 =?utf-8?B?SXRVamNZWVdkSC9zUU1mMUNFVmlNUCtoWElBSmlvbHhJQ0pYNEFvakZ0dTB5?=
 =?utf-8?B?dXRiL0wxVUZSSGs3VUVGTFQ3b3E3R0dremtmU1c3SEl6dkR1QUIrRkJXaGdu?=
 =?utf-8?B?TTUvbXZsVjhWbXdQTkNWSHZ5NUFOK3AyeTlUVWxEQWZGS0hiT2VJZ2I5MGpQ?=
 =?utf-8?B?UlpaZ1dHVVNhSjNnSFAzeWpuQnp0STA3U0RGclJaRklOY2FuYWNaUi9UYWN4?=
 =?utf-8?B?V1JCUXdYcUsyYzgrTnYzNWJqT2JxdEZZNDZrUmV0QU9Jc0tRbUI2THQvdnlJ?=
 =?utf-8?B?VmtyTVRaU0dwbGF0a2lvR0kzcEJ1MFBUTzVVcFMrbElWNE0wOVc0TU1BQk56?=
 =?utf-8?B?WVc1V0c3R3pDWnovdVllakpjVXI1aDZaeDdZMEE1N0FkSkV1c2Uzc2hJRm5S?=
 =?utf-8?B?am5RSDU5Ujd4bmtCSnloNmlNd3NPZWVOVC8xeXVuUUIwV1o0aFNaazRGZGxY?=
 =?utf-8?B?Y1FwekJoQlFMUjlSOVhucVJpYkhMNjBMeFZ6UmNjcUpRbDNTYmo3V1dWSXRn?=
 =?utf-8?B?OURlSC9mV0pFQ05WQTZvazUvZzhNMmNMTVVkMUE2YUh6KytvNHd2RU1peGdn?=
 =?utf-8?B?aGZtdnRlOFJOVURTNTRPOTQ1S0FHSGhKMEN5WVR5aVZteEJLMjBZcTZpMVJP?=
 =?utf-8?B?RmJxWlhScWpLWk9XeU1ub3pxZm5XdjVTMmpFMjhWbzY0WlQ4SmJFVDJTT2tQ?=
 =?utf-8?B?ekxva1JNcmt5alV4YkFucWlVZWJBakdyVEpWUmdxaXhjQkpFdDFXNVdSeCtL?=
 =?utf-8?B?UXQ0K0xRcjY1ZTYwNG1TcnFTZDhSWWhSandEZ2hibDVGWXVqeFE1b1JuK0Ez?=
 =?utf-8?B?Y2hlRWlwbHp2a0ZHL21aVVJMTTVVUjJIU1dLdG1WUWJyZmZ2bWp4UFA2RHov?=
 =?utf-8?B?WldWQ3p6NTJvZ0MwRVlRcFBuMStOVzVySkh3NTIyd3NoNTd0SnVIMS9iWktZ?=
 =?utf-8?B?bkVOaWpDdThwbFNybkR4b2pTR2tqRXRuWWxOMDJRbkU5MzE0Z1gwVUx6SWU1?=
 =?utf-8?B?OTJJY0V1MFRJdkQxTjRHT3NKQU1JZGhna0lldmxzQUdsOEpSc3d5eHgvb2pi?=
 =?utf-8?B?bFhoeVg1cWg0bnpSNzJHMnovSlMwdjkrSGhuU0xuNU1LRnBQZU9WRWJGZW43?=
 =?utf-8?B?VGhoQ1ZKV0p3UkM5K2RSTkdpVUZOa1NCb29Lc3lBNGFHZWdaUFlQOFdIb0pM?=
 =?utf-8?B?ejNCeHhWbW1oZnF5Z25OZjVGME54WXUyVkJSWTBWeHRSdnFvbkdheXlTaU41?=
 =?utf-8?B?amNraTA5dVBYck5DMURiWVFJL2VMRlJUMVBTUENMOG5oL2U5UWNLZGdwWk51?=
 =?utf-8?B?Rm1kN2w5czU3MVZNamRVNWwvMGl5d2ZxOHpaQUlVa1pRZ3hlQ084aWt4L0xm?=
 =?utf-8?B?K0NZMnN3RkkwUlgrRkJRd0hnRHZiQmhnUFJ4YWIyL1RFd3A3MDdjYWdrZURM?=
 =?utf-8?B?MGlHcUdqdUpYMjRyMUdxVjg3L1dhVllGdEZ3Q2JkTGJhRjl1dXhUb095YjVY?=
 =?utf-8?B?cSs3OVFYN1lxT1VNdnVhazNRYkNvcmJnQ1kxWGo5a3pJMVMxQXRUQWRmWUFv?=
 =?utf-8?B?NkpYTk9XdWFPNTY5V212OFFZcU16Z3c4eGhpTzFvWUJMWGg4VG5JM0Vza1VH?=
 =?utf-8?B?QzBTdG9HWnJEVThOU1d4MzRHT2dHU1RYOUN0Rmt4MTdiVUM5TmV6OXdZbWtI?=
 =?utf-8?B?SllFRUhsWkJ0clN3bkN0RmZCNmFqb0ZOUWdXMmJRc2VBL2VLVlUrdEZuOHRT?=
 =?utf-8?B?dFFzQXNNeGd3N1RGNmRPVFYrUDFlRjRRdllvZFEwRGNYd1BnOEJseWJjbHZO?=
 =?utf-8?B?Qkk0Sk9YQWtSUzJsanVXdzB0Sk40L0hacUExaUJsdDVSTWJoc240S0F4c1BW?=
 =?utf-8?B?dXBkZjdUeHhGSVNLRENZeEM5U0tZRHo4N0xYazV2ZGJGeWJKdWtPMTFiYlRH?=
 =?utf-8?B?NHlITGpCSjUvVEduK1JNQzNjRk00VHYvb1JnUVJGSlpzallMTC9xaitrdzgv?=
 =?utf-8?B?K0lVZzVGUUVxQU5Sc3NjK1NFVzZ5cWRBSkE3THpGOGczcTMxMkxVRUJWNFNN?=
 =?utf-8?B?aVpUUjJTUUZaUG45Z2crUDM1MVNnNExQN3JpQjRsdXp6TnFFVnhZM2xEcEh3?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YlNrTnhRZ2VlSFp2VGgxTis2OWZ5OU5ZN09tREFqSjcxOE42T3dkRE9wSVpE?=
 =?utf-8?B?YVR1Q3VNS2hKRDBLeDZFVDhYaXFTRjYrd2hOaDFseXJSamJ2RSs1d3J5VHNU?=
 =?utf-8?B?bkgxWTF3S2ZETlYxMTZYNVhmZlVieWR5Q2Z2ekh0bzlQZDlwZERHckdXb2ZB?=
 =?utf-8?B?OU5TNTJZS3RxckdoQ2JGcHFPa0lhVEtCRW5DOUVWM3Y5ck54UXl3WlJLRkIw?=
 =?utf-8?B?bEFCaGQ3MkNGWnJIeEREdUdPYXp4d1BwZkNPaG5aeDlIMXp2bXIrWGpYZTg3?=
 =?utf-8?B?ZWliTjdrVTlOaEU3cVZlRXdlQks0dVo4cmF3UEc4U2lVQmE1MWM1YUcrMDJp?=
 =?utf-8?B?MVAxUmJha21JcUw1U0ZCMml3RHVkZ1FWdXJJSkF1Nml3aG9VWlNTUzNqOWw3?=
 =?utf-8?B?Um5td1h4YSs2dUI2YzdSR2hFRXJxTExMUUVaZm8zcSs2RmpxeHdRbHVVODBz?=
 =?utf-8?B?amJGelpRZVIxbkVEdTYrRGNTZnYyc09rRFZCQ2xuRVFteHNqSDdRdzNnOUdW?=
 =?utf-8?B?akNmYWk2M0U1c1pRTnZiV2lUMThkZmkwSmhoVkZsTHRVelM2VDA0azhMQ2Zr?=
 =?utf-8?B?OVpMSUU1UkY2SWV4Zzl1cE11ckJ5QXZuNk1mU0w0ZXA5YWQ0Z1ljdlFCanBm?=
 =?utf-8?B?RkJVYkZicmpVUGRDcFY4M3UwNm9aVEswWXBVVmJFNzQ0aFEyTjZKYUc5T3dL?=
 =?utf-8?B?aXJVMDNTUXplZVJZejlqZkF3UXZTUGQ5Q05SQXVRMVJKYks0cyt3OFNNNjUx?=
 =?utf-8?B?bll5Qnk4dkZQVDdOcnUrTWt6NGJBVzNKa29iaDBZSXlyalJnU0YzQmEwancv?=
 =?utf-8?B?SU1IZkl5WWg2andTNUJvUWZyam1HMG9zbTVGK0RXbzEwRmpqaDNuend3TkNY?=
 =?utf-8?B?NENQa29VV3h6MTdVSWZ6eUt6TnpHTDA0R1YyVkFwWVRkOGRRU1JMM3JsRG1r?=
 =?utf-8?B?NUJMMTdiYkJSbGdmK0c5ZjVCWE44VDJBQ2M1SU0ydHlDNm5YZEFHL1RmYWFt?=
 =?utf-8?B?L2pycU5POFhnL21NQ01HdGxjM0tSYlZ0bEM3QTVPMzRDUjgzSXgvRVZZN1Az?=
 =?utf-8?B?MW1odG1tdXZaRUpJN282TVp0NjZlbjUwRVh0VEZsTGdhWE1XUjl1SUs2ZFox?=
 =?utf-8?B?QjBZRDBBRzNMeW0zamlSK3crdDgrYUo3YVVuSitiNU5XOXJXQ0NMRFFhaVVh?=
 =?utf-8?B?dUxkZFpjd3RVdmtWL1k5eEthL2cwd0UwWlhmaG1rTDVsWVFJaWVGQjRjdVY4?=
 =?utf-8?B?NmE5ZGlzckdZNEpudnZ0STU1cDYvU0p5cEM0WnYxcVVFTEFJZlhJbWJRbzRw?=
 =?utf-8?B?K2tUajZhSVN6SVVnWWNxcWczejdWWXdpenY4Ky8vMnNaaW93clI2YW9zb2xz?=
 =?utf-8?B?bXdjL2dnWnpTTE5hT09ybXM2dlhiT3hjWkFza09pMUlxcUFLcDJMMU5ENitN?=
 =?utf-8?B?YUhlVElvQW00dHZQV0tjVlEwSXVzellnL3lhQ0FHTlprNk9Xc2VJQ2Z5NFNC?=
 =?utf-8?B?QXFYREczRG84M0E2am9MZ29VVDRwWEE4Vlo3NDNFdWlMQW9GZmtadTZwZ2tE?=
 =?utf-8?B?NndkZkx1SWxJM2F4T05YOFZIMm9rYzdONCtHOE1ESjhtZW04N2FHUE5BNWJj?=
 =?utf-8?B?dkpZakRZK1A2NmY1UzE0bWZjV2w1ZkMxYXVnU3JGTlM3aHRCWXZ6K2lTdkRF?=
 =?utf-8?B?NEU3bkgxSHZCbTNxVlhsR1dBQnhDYzFZZUU1OTduOXJtbjBDM1hvSjNxY1M4?=
 =?utf-8?B?RCtQRkZaVTZQOGhTd3k0c2ljMGpQTVlGZXNHYThtcE9QMXJZbWU3MjMrS3gw?=
 =?utf-8?B?WHgvdzM4OVNxU3Y5NlBma1FQeFdvV0l2S2hYWUZtR05IdExteHFzYzdocmxQ?=
 =?utf-8?B?N1B6bURJd2o2OUJVaFdSNUJsQ0pQV25MdDhjakM3Yml0T2JuNHFwVzFqWUxx?=
 =?utf-8?B?c01Nc3dlcHcwVm9pZnJDR3NyRVlCUnJLS1lRTThDa0RtT09reUdwMi84ZW9y?=
 =?utf-8?B?SitnVFlDc2lPME1DU2RKbnRkdCtHdkl4Yk5YSEd4Wk5SVWRZRXQrc0xrUzVj?=
 =?utf-8?B?TUQ3cDNXSGxQYmZmUEs4VFF4ZmlRS25jYXY4WnV2b3JxMFp0SitGVUhsdzNo?=
 =?utf-8?B?cDMyci9uZThFanZhZ09XMEptVFhlajRDVzVVRmNkdjM4SE1iMEVBQnhUZUlU?=
 =?utf-8?B?Y1RTZzRFMkg4TXFSOXY3aWJWMWNNcTZvSC9GbWxwQ0RVWXoxeEtPWnJjbUNC?=
 =?utf-8?B?NUNkMW42RTlZK2hiK0l3c0FiZld3PT0=?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb5a54b-5717-4e4b-5c8f-08db3f30b146
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 10:44:17.1596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ldWRWyeQvcXp+SQ326Q0yYhDi+YIShlClKP7BLXwzgBNdUIMXv6tumazU1npiyLmvDKoMz7cL0CQiBKLmdJ0tEcgxm2hjQlFgjIYHcgqH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6965
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 11:30 am, Peter Zijlstra wrote:
> On Sat, Apr 15, 2023 at 01:44:13AM +0200, Thomas Gleixner wrote:
>
>> Background
>> ----------
>>
>> The reason why people are interested in parallel bringup is to shorten
>> the (kexec) reboot time of cloud servers to reduce the downtime of the
>> VM tenants. There are obviously other interesting use cases for this
>> like VM startup time, embedded devices...
> ...
>
>>   There are two issue there:
>>
>>     a) The death by MCE broadcast problem
>>
>>        Quite some (contemporary) x86 CPU generations are affected by
>>        this:
>>
>>          - MCE can be broadcasted to all CPUs and not only issued locally
>>            to the CPU which triggered it.
>>
>>          - Any CPU which has CR4.MCE == 0, even if it sits in a wait
>>            for INIT/SIPI state, will cause an immediate shutdown of the
>>            machine if a broadcasted MCE is delivered.
> When doing kexec, CR4.MCE should already have been set to 1 by the prior
> kernel, no?

No(ish).  Purgatory can't take #MC, or NMIs for that matter.

It's cleaner to explicitly disable CR4.MCE and let the system reset
(with all the MC banks properly preserved), than it is to take #MC while
the IDT isn't in sync with the handlers, and wander off into the weeds.

~Andrew
