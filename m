Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889376EF6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbjDZOy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjDZOyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:54:24 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2466A65
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1682520863;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R7v5BIe2O4clRWMHYEawx13M/Bq/XBaPikRawgUEvO4=;
  b=XfZ/Uwbs+J+c68t5t2acfIrMGSTkgjAZzkMQzxPwh+QUJhprvdPxXtci
   CX/dFfYT04JrX7DC2fe5ZhiHIQVpeEeZcI4pbIewJoQMMop4DfDN/ooEK
   8bdm9fIuFWpXEA3TOM3mZ6PEbZEmphuxCmjLBpw/W/diFLXbXF1XV+IjP
   w=;
X-IronPort-RemoteIP: 104.47.73.168
X-IronPort-MID: 109391150
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:xuNlJKq/a83cAaDit+UwGFxFY8ZeBmLSZBIvgKrLsJaIsI4StFCzt
 garIBmEbKzZa2L2etknPojjoB8DupPdz9c2TFFspS42ECIW9puZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKm06WJwUmAWP6gR5weCzSdNVvrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXAAkzdB6zmb6v/JyqZeky3f0JFfXWGpxK7xmMzRmBZRonabbqZv2WoPpnhnI3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3j+OraYSFEjCJbZw9ckKwj
 2TK5WnmRDodM8SS02Gt+XOwnO7f2yj8Xer+EZXhrq8x0QTKmzR75Bs+SwGYkeuyh2KFV/FPB
 XZO/3M3oesx3Rn+JjX6d1jiyJKehTYWQ/JZF+w37lHLxqe8yxqWAngsSj9HdcA8s8k3VXom2
 zehh971CCZ9mLyTR2iU+rqdoXW1Iyd9BX9SOwcHQBED7t2lp5s85jrLT9B+AOu2g8fzFDXY3
 T+Htm49iq8VgMpN0L+0lW0rmBqpr5nNCwsqvAPeWzr56hsjPdD1IYu19VLc8PBMap6DSUWMt
 2QFnM7Y6/0SCZaKl2qGR+Bl8KyV2stp+Qb02TZHd6TNPRzxk5J/Vei8OA1DGXo=
IronPort-HdrOrdr: A9a23:XsXxh6u8Y1T2w62sKTzra4cK7skDZ9V00zEX/kB9WHVpm62j+v
 xG+c5xvyMc5wxhO03I5urwWpVoLUmzyXcX2+Us1NWZPDUO0VHARL2KhrGM/9SPIUzDH+dmpM
 JdT5Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AC8bb7WhMg9ta+9jlbujEr6lN+TJuS0PHwkfOf1a?=
 =?us-ascii?q?EJ3dGSOPOcHWpxJ5CjJ87?=
X-Talos-MUID: 9a23:niUdKQsNKpby10t0ls2nmmtBBNVj7oiVBGMdv69cvpCdOW9zEmLI
X-IronPort-AV: E=Sophos;i="5.99,228,1677560400"; 
   d="scan'208";a="109391150"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2023 10:54:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5Nqd46QYYirl3BSw+4V9H2pVlw/2ITt08Rqm2ndT/gv4aIfVFIPIJoRdTE/13rQVCwTRM0gRUVbBi70waEgBiwo4usGju3z4uyA3ES9v3arkIrnj2WubiHE8q1Y/lFTL+w4D84R2FcUhHReczpdXPhAt5kE4f+AEF0Y9tFt336NyQW7+o1OHL7YFgbAsFKvBSfOV4ie7JUVN0QmNVlTuR9GBPVfmtLX0x8emNx/rqRRqVtGc0L7ci+1eXPHgonE7vMT8Ij2U3IZ66bb4rlSOV7q/FpabIuoNvx09MzKGsivngSHOBJ10OurRO6evXhrSK3x031YqnEBr648Q9GreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7v5BIe2O4clRWMHYEawx13M/Bq/XBaPikRawgUEvO4=;
 b=fG8k1JlimM+eLnNvkoi8i724dOcfA3T325rWugLgzVWUY84aghdISuAZQINMBofUT5xEeJ3CztUdDnRi3WAo/rc2sbqQ6PBGE3kYp6BdVeM0JCg8DqGdbtrhGD+k4aHOSWfXONOtjIfewXi0uXzCxzC/UInBq0wnnidpCrbQ4v3v6T9TyVs722wq8KrxuR47jvU8hWzJ7I3l3Ct08A/TCPf4vv+ehFFSotDyX6fjZXQa8tHy+uXjVA54j6upFDXLLYGU9yD3N2SK0y63HM/9C6UeEPBz8jAuLhhu/MXaosCjJR5qaKb6iMFU3qkdEyVI8msH2g09GNK+j7bEcL4HRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7v5BIe2O4clRWMHYEawx13M/Bq/XBaPikRawgUEvO4=;
 b=jVxSngl+JwGwR8K1mTtXb3uHccHoTzNUX/llT1pPI+zuPDehGo/7LX4QdnaG56QKXNFptLtR+FDJGlV3JFaYtX005646L7GlFv8VLZ6sY8Q1uAoTj+MCDjAnoq/T0PQYoYjy357r/xBn5ej9HZUHNSOnJ2ZILxIrV40IztBQGqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by LV8PR03MB7493.namprd03.prod.outlook.com (2603:10b6:408:185::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 14:54:20 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::a5a1:8cae:d45b:2030]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::a5a1:8cae:d45b:2030%4]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 14:54:19 +0000
Message-ID: <9c5670f3-a3de-a5ed-b458-c52a1c25641a@citrix.com>
Date:   Wed, 26 Apr 2023 15:54:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH] x86/CPU/AMD: Rename the spectral chicken
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230425195024.17808-1-bp@alien8.de>
 <20230425205944.GB1350354@hirez.programming.kicks-ass.net>
 <20230425211522.GGZEhC6nkdsOapSxVL@fat_crate.local> <87cz3ryph7.ffs@tglx>
 <20230426092106.GAZEjtAusEmYTgr1Hh@fat_crate.local>
In-Reply-To: <20230426092106.GAZEjtAusEmYTgr1Hh@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::6) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|LV8PR03MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0ece4b-cf21-4523-34c4-08db46661d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLWUyv0nhAFlP86RKxk9udUtUyeMho2nV5JGFDRazBoV129jMmm3v/J4HZB866ORz1poMkMNgXqFp9IBrFEFj4+WZCDy76pRk730q+zjaBot3YnafSDVTAtRpOtVD/D8tqOV226n3Mngs87mvHlg3VXTPfCKgjc9OUL+Kny9RQfogokZsOHp7QMFW0blw5V9sjPManXw8HSrW2tqO+/wFmS04vyhq4KFRsOkYozydXryqS9E+uyUqsdgkDB26OtCKAagy54Uc09HBsKQ1pMKGgZLaQ+k3tW9fJJdykTwfuBSANU3ZazWYPL28kbDbAXqsUpKHnlqTfNTPz1+vYR/nTk8/G6VUn5w5HK/pLS0b6YdUCEPTfXHXkjeQPzEJkZK0tfu1rm0L1nMA0xbUkygYW5XfmbduIz3x4EZ31+RVm513d0Ky2oWAJ0Yuz4/GMbxprahflXWJEKIKoPl2i+yPK/O9BUwUyww7f3jkz6lc/CytTObY+r0pCleX5tEaMQJB6mU0ul/RZe2mDZ/A3XC2hR66v+ulNJsMwckNDo5UKSz8SOYz0yrs0gXWlp3LrPiCwOgXIZqCF1f5udGQxNCn5j9tc8FN24Sd0BYh5vnCC1TByA/2mPKwXhzPXT1b9lMGGyNzMN+W9cc/zUIE2YLgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(558084003)(110136005)(54906003)(478600001)(82960400001)(38100700002)(5660300002)(8676002)(8936002)(86362001)(36756003)(2906002)(31696002)(4326008)(316002)(41300700001)(186003)(31686004)(2616005)(26005)(66556008)(66946007)(6506007)(6512007)(53546011)(66476007)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG54dFdXTDYxT0lVVUFlK0dXOWRpT2dtVmIxRmZkSXprZEdCLzNpTm9sc0Rp?=
 =?utf-8?B?bmJEQjlwM3FtcWdIelB5eUxrVlN3ZlVDK3kyeHN0YmpTdWlvd3daVXEzbDQv?=
 =?utf-8?B?ZDk4NnJmQjVzOFpZMHJhYzB0TWJPQzlidmdNM1B4T0ZRRFV5VmpBbUtsRGZG?=
 =?utf-8?B?bkFrbm9kUGozZVNNWS9tSXZORDQ2elZBZiswN0o1QW1JTk42dThRc3lzaDg5?=
 =?utf-8?B?OXVlaW1uZWNhK3ZlcUFLckNlbzBmYlc2aWNKSEpJZm5pdXJ5OXBEK0FQVGFI?=
 =?utf-8?B?ak1MMVhNUWdHaXdMZDhzL1UyVGN6TGNZdWdEMUNtMEZ2enlVbklHa3g5Q3pQ?=
 =?utf-8?B?UWQ2cklMTlpobDlReUNHWkhTVlEyYXB2eWs5bzRNYlBqRlkySWhkTU5YM3RZ?=
 =?utf-8?B?dmwxSmtqZVhkcytTdGJiNmRMSUl6djJsdjdtVzE4WFdPdWtuS2MwWGo5UzlI?=
 =?utf-8?B?b3RYa3JvcElWdEJHQUwxTE1mYnU3VElJazVIamhxaDl3RC9rWDRrYm5UWUtB?=
 =?utf-8?B?N3VSRzFzZ1JrTURLWXYyU0xqdWtUN2lIdFJpN0twR2h6bU1Gdlh0OHVHOTVh?=
 =?utf-8?B?OWg5Q1h3cHNSNXhYNXVTK0Y2ZHNyMVdIT1NXbDZQUDBValZ1QlJZYnRsUWtk?=
 =?utf-8?B?dDlRTjFOUVp5eHVFRW9aK2ROR1lTQjdnSmZHeElsZTlFQ0dUWlM0dU9uY3Vi?=
 =?utf-8?B?OEx4YUNuRmE5SktaeXNxVk1PeWdpV09MUGdsN3FUekNTWGV5TzIyVllsS3RB?=
 =?utf-8?B?aC9BSk5XTWtqaVdqSEMrR1JCOTFQZFpjV0wvSFNkc05rYUdmV0hmOXY4Tmdu?=
 =?utf-8?B?aXFXUkFCQkQzY3h1MTJUdk9MdGJiVHQ4QmZ6ZW1wdHNNOGtqaFYzaHR3emxZ?=
 =?utf-8?B?Nm1objJJcXFEMkNjMitWcFBNbUo5QVlwdG9hdXJEY1FGcElpZ0M4NktFRkdJ?=
 =?utf-8?B?NVdDeTlFUEdVMjdocVMrUFlvY3dlVnBhRjk2SGFyc3pXODk1dlhVNW82SkNR?=
 =?utf-8?B?TXIxNHBrMEJJbkRxQUgrZkF1U1FMTXJUdGMzTHlxaUNXUnBsVUhjYzVtR2Nw?=
 =?utf-8?B?WjhyNHZxSmRKcjFqQU9vWlRnVEgyOFFjYzhwVFRxUXdZK0Rmdms2clZiWkdJ?=
 =?utf-8?B?Z1JvV1R6WmtRcFV6SDhtYXM3ZHV2VmxLQ1R0RjUxd3BNTXBMc3hzYWszS2Ri?=
 =?utf-8?B?U05pNFdzRStpRC9oTGRLZ0VBNUQyWjRmNlVJS0tTa29BTmFuLzdlQ0ZsdGoy?=
 =?utf-8?B?VW1jb0tldTNqZXJITXk1VHZLdDh5NHc1VGF6aTd2M1hLN1ZPc3M1a0djL2xT?=
 =?utf-8?B?M21ZR3RKQk00c2x2UGQ3Y3Nja3dOanIvRWl0QzdSZUxoVFQvVDkyc3NKS3dH?=
 =?utf-8?B?TU8wRjY1NkNRWTFzUWxKTUR6ejVhNVArVHY4U3EvYkc0aVh2c3d5K0VEV0k5?=
 =?utf-8?B?N3JGS0pkZG1GWHk2NTRRV0wrcDVOQWloWGJoSkg5SVp0Um5xZW4wWDUwVnF5?=
 =?utf-8?B?bnZLSSs0WjZaOFBMUDk3T1p0U1JRY05qOHU2QlZEdGRNQUxzZ2dOK2VQaDB2?=
 =?utf-8?B?YTNkbzdHdDlFcjZueXdWbnBjQUpZOVY1STVuUUZqWkcrbkU3WlNhcnJ3R0dt?=
 =?utf-8?B?TEFOUlpjUjhISTErRHo4WG1nSXB5MHd4WkNTSDAwOTltbDhWK1NOaWMzRk1N?=
 =?utf-8?B?WFZLTTV4dklIdVJiR0VUM2VoSUpQelRXM2NLOVloN29IZTQ3TExjMzlPR2NJ?=
 =?utf-8?B?YWZpWVlJeTIyMHI5SlBsb3oweCsyWC9DWEoraklranhWMFpYcUpybFZ5K3Ny?=
 =?utf-8?B?SGx1K0dUTFV2bFZoYWZsRlp2NTJNaWg3VysyTVZYRXpJMmNzVmN0ZjZPa2Zk?=
 =?utf-8?B?TTRkZFk4ZmZtdUlaSG5jYkRVSFhTQVpUZW9BT1R3ekxZcjJ6cTBEZGhTeU5Q?=
 =?utf-8?B?WWxWLzB4RTByVmVLdVhEaUhmMnA5NW5ONmhneWR4R2g3dHlxc1JEVWkrUE1k?=
 =?utf-8?B?SUphVitBNU9RU09QekFBdURqSVNZbUxMZnNLTEpXbklIc0wzNldhcHk0VzlL?=
 =?utf-8?B?bENRK0oxRmN6WTI3cTFIWXp1R05PUk1BbjZObVphenJjU01YdDVQZ1Q0OHlH?=
 =?utf-8?B?aUhLSXg4N2FReG5EQlFIWDFwZG45cytLLzNWYWhRdHRKYi9ydkVKV0Y2Qm44?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8GDAQdOjaWVmO1xeibEpJ4QnZ4I6nLnt1kumIMoyhjkicNAT7DgwQKzhd4p6l0G/nd8XPVJQF+YZVIvFBosTCeKqSorfh8dTf7mtrr40N9+Kr5bSqPHU3/RJv96c+VeQ7wYxi8frv9vToINSwjeoI56EFrLlyLsRl9JRcqJVVQuxXAINna5LXufCKC0Y+IGs5X8UyymP44BRI0R6lHyreGPxf/DwTx3CNuqdf/Orb8M99jYSO9P1JMj0FPCgL+f6fHTFOaBIdyPWubtUaDBF2sFEKjajDKEMNglyO+ynEiq7yMqM6pn0qRSGZR4ij8ijStPdw5AKheKCgqKfuD22/Iv7mrtvRfSl/6Xvj4yjZIMsiAnODrePIX9s0ZU7E0oAbIBOxbatJEd8Hn94LFeVul7Ftz13ACeeqsm5f/g2bl9EH5pBaFumqNQBHFGKU2BSNSKmVwcnF/BGmfc4P8AyQ6fUZwoTZ7F+TtP51UKuGUouyxTEQ/eUgZulGeShvyaouish+lmzpBR35BkZnd3mLMIPlDrKXyqYqn6Fb2Vc8enqU3cgdsnTyGxU5kj31PEkMqwByBmQ+dT78ku/kildP3tKjZZW/t/a1xGm1ehjPJ3vuuynkcp3+V9SzVuTK4zO+Dn7V2I9p61mQf/+4SCOXt1pBG/DI3FLaIqLQqjD027Gnu28hbXABPisIpWYjXGE07Lh6GufLtDOmHcvIPNhUFxAGx1udWK3N5EUqAqDeKjC7NZOE7NqAOJt+axui3H+XpdMvs5otVhlhMHx/ksq4O+ycw1LT0HlVw633yc1w7TFySfUyMbe77nqzqYR8urX5i8mK2BMHYCKvBuhVx3AaWqZAXP9cLf0nRmWBPmBqkMbCGExl/xhMdBhQP8hWYK01hgKNNYhlzID5NdkGXda0g==
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0ece4b-cf21-4523-34c4-08db46661d32
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 14:54:19.7382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNyTJkNfWmjHZF4jLQansFIH3bYznCYeiKS9NQ2GFh6gR/uEmMfTxDB/+h+2hr+3VNsvfUvlwh7ChsUFCMvuBXf8puIfwZb1E8nZihmZvyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7493
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2023 10:21 am, Borislav Petkov wrote:
> On Wed, Apr 26, 2023 at 11:14:44AM +0200, Thomas Gleixner wrote:
>> That's a purely speculative assumption.
> No, it's not.

Until you retire, I'm not sure you can make that guarantee...

/me ducks.
