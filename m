Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6FF6071AC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJUIGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJUIGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:06:19 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D240224988B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1666339576;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oBBXKcPklp326C9bkH7mVNGCsVSdgT3RZmSK1wEZp14=;
  b=XlSSxqhQLUiBQsXEASgrmUK6ZwnDrOX+vTN1W86XlHlFNrqeEKKaCp0E
   8kP0n+WbfUVgEjIXApXm2lZHCNAdUE/0m2ZqyFbjGKC9LC2cOpraY+tf8
   MJm4EqDbnPsWrZP+cxKk3rDk2cYK0GDXPQb8wUiGP5cqeTgGkMpSvdx2f
   M=;
X-IronPort-RemoteIP: 104.47.58.103
X-IronPort-MID: 82849266
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:pm5NUq6ExJp9NEP1qoqnkAxRtGjHchMFZxGqfqrLsTDasY5as4F+v
 mMeDWuFb66NNGGmetl+Po7j/BkB7cXVztAyQQZl+3wyHi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvymTras1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpJrfPewP9TlK6q4mlB5gZnPakjUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5aXCJsr
 NMSFQxUYz6Cmuuag52ccuJV05FLwMnDZOvzu1lG5BSAVbMKZM6GRK/Ho9hFwD03m8ZCW+7EY
 NYUYiZuaxKGZABTPlAQC9Q1m+LAanvXKmUE7g7K4/dnpTGLl2Sd05C0WDbRUvWMSd9YgQCzo
 WXe8n6iKhobKMae2XyO9XfEaurnzXmrBNNISuPQGvhCm2bO4jU0OTgveGSG5tOC1GCeQ4NkJ
 BlBksYphe1onKCxdfH3RzWxpH+JuE5aV9c4O+818gaW0YLP/h2UQGMDS1ZpbN0gqd9zRjEw0
 FKNt83mCCYps7CPT3+ZsLCOoluaKXhLBWwPfykJSU0C+daLiIs0lBPUCNF4DLSykMb2CBn32
 TmBqCV4jLIW5eYX2KGr1VTGhS+wvJ/PTx5z6gi/dmek6Ax+TJSoa4yh9R7Q6vMoBIqQUFTHv
 HECgMWYxOQPC4yd0i2LXOgJWrqu4p6tMCXVqUx+A547sT+q/haLbY1WpT1zOkptGsIFYiPyJ
 l/evxtL451eN2fsarV4C6qpBtgn17rIFNLrTPnYY9NCJJ9re2e6EDpGYEeR2yXhlRYqmKRmY
 ZODK5/0VjAdFLhtyyewS6EFy7g3yysixGTVA5fm0xCg1rnYb3mQIVsYDGazgikCxPvsiG3oH
 xx3bqNmFz03vDXCXxTq
IronPort-HdrOrdr: A9a23:LoL846hBX6pYAe1qXO/U7LMD1nBQX3l13DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03IwerwQ5VpQRvnhP1ICRF4B8buYOCUghrTEGgE1/qv/9SAIVy1ygc578
 tdmsdFebrN5DRB7PoSpTPIa+rIo+P3v5xA592uqUuFJDsCA84P0+46MHfjLqQcfnglOXNNLu
 v52iMxnUvERZ14VKSGL0hAe9KGi8zAlZrgbxJDLQUg8hOygTSh76O/OwSE3z8FOgk/gIsKwC
 zgqUjU96+ju/a0xlv3zGnI9albn9Pn159qGNGMsM4IMT/h4zzYJLiJGofy/wzdktvfrWrCo+
 O85yvI+P4DrE85S1vF4ycFHTOQlgrGpUWSkGNwykGT3PARDAhKd/apw7gpPCcxonBQwu2Vms
 hwrh2knosSAhXakCvn4d/UExlsi0qvuHIn1fUelnpFTOIlGfZsRKEkjTRo+a07bVTHwZFiFP
 MrANDX5f5Qf1/fZ3fFvnN3yNjpWngoBB+JTkULp8TQilFt7TtE5lpdwNZakmYL9Zo7RZUB7+
 PYMr5wnLULSsMNd6pyCOoIXMPyAG3QRhDHNn6UPD3cZek6EmOIr4Sy7KQ+5emsdpBNxJwumI
 7ZWFcdrmI2c1KGM7z74HSKyGG5fIyQZ0Wf9igF3ekJhlTVfsuaDQSTDFYzjsCnv/ITRsXGRv
 fbAuMlP8Pe
X-IronPort-AV: E=Sophos;i="5.95,200,1661832000"; 
   d="scan'208";a="82849266"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2022 04:06:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPNGgz2deE7FY6Rf9LzkGjBk3JSbMRSCvJf/AnoIdhWpBEGvR16XNPmAB+8GrBx9uHUsuIzYuSo0BPuMCwdmknp50HmuEj42et0oXpEtVHNT9Le8eoy/pRkqpAIRSeohrXVpKCstQgAdJpGW8ogIWQrjncRJlhqjCklrpZbTrZvpH5Ok2zkjKRUR0N6FAF2gjdg5veiz7UQciw0WPAiXTxxW9YCfNe3RL/dYazLp2Kr+JETxj8E2hVAFQ9PmxjLdpuAQHQCOO2zNLcvcvSq0pumFFGSnqj9h3Jg3X0innwp7xwCgE6wfQNGWpm1DHj/0rwSQO3OyLeEJuYJOtQIRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBBXKcPklp326C9bkH7mVNGCsVSdgT3RZmSK1wEZp14=;
 b=CTwFINXPamva51jFdFtys3sJtBOdj9XIv3BxXZWM7ePd0CRr4wWJ04iJg9o8lfiLq+fVqzCsC53xzwNzXHs8FjhkJAx/g9XmqDoGIJTylGqhtP2GWeA9lm5z5PRYZecW6DvhkO9ipHUHhreIrKocCzBqjbpcBCSNcL8XZdjJKzhHm/8xOXk4KWKt4jWRAHFHDkQSpcfzIWwBaEAzFy8whk7KctFOQvSSxcbYQJxmrPUO28UFbP/4mkucMfp+TO7lfyluyRwGVmAxw6VjwWT8dbtoIyVk8vZe+7xwtgK/fGDM7Vy/OB8SOpEXCA5RUi3OEfxZntjBiOLsiS7RqmbaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBBXKcPklp326C9bkH7mVNGCsVSdgT3RZmSK1wEZp14=;
 b=l1PJ0/FpLC4LLKhAAWC2STBDMuHKg70zBAgmCjdcWl6lnjkXhhfJaf751qVXDexRkA1xaxUFXW6OMb7m8hUyYdPF4VZpiaSNV7M9HyYYEccEnyKnpPCJZbJRE04xwXMqqojqUbEB3qHC2JZXZ3y8X/cnOBJ5RjG6PiZZq1GE/2A=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BN8PR03MB4977.namprd03.prod.outlook.com (2603:10b6:408:de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 08:06:12 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44%3]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 08:06:11 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Borislav Petkov <bp@alien8.de>, Juergen Gross <jgross@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH] x86/xen: simplify sysenter and syscall setup
Thread-Topic: [PATCH] x86/xen: simplify sysenter and syscall setup
Thread-Index: AQHY5Hg6cWouKk4hAkKcpxKDANECg64XKDGAgAFW1YA=
Date:   Fri, 21 Oct 2022 08:06:11 +0000
Message-ID: <bd3e990b-e2a7-bbf0-7e2f-259e6a353393@citrix.com>
References: <20221020113619.17204-1-jgross@suse.com>
 <Y1EzXQP3/Pn3bme+@zn.tnic>
In-Reply-To: <Y1EzXQP3/Pn3bme+@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|BN8PR03MB4977:EE_
x-ms-office365-filtering-correlation-id: f5ae6c2b-07ca-4e78-1d0c-08dab33b1e10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wsT0uQx+PfonUVCQ3aNLODgNCReWAXKEb7UPVF5P7zUlbFRDSEKJ/IqUw1DKo7C7PjaSocmYS5Qa7r8yLKnaEj+5B/KxRSCWO9LOyuireZwxRh6LgN/OJXmRXTufNmcJkj/hRahiH+qRHjJOgbkKBgt5OFG1HFCfstxlSVvUkXHjTQ11ZXErcXGmmzz7CbO3SJlmRoDnLwCa54NkPT8mxzwoCby5euttz7vdFbKSCNaItLoI2IWQkIXZpMnoQtyXWGUbhL3H6Vtw006g+447B8pRiVovCnB+wwbTWD//elS9oswOgCqGTt339/uNk838UYXEJiP8LH+18O9OXKxOmtPCeeg3zxvy/mDx1L2Avwn9JxTDM1uvaTiEypvth3YQtC52oeYMUawEnRQujt2S6KSb/aiOoR1pTsHbgZ1h5aZHiD3IJQ5eZVJbh2U6HI41qNTK3t94Vm7zuqMc6du8fI2cbkMZhoo1kC398piytAsmfdlYYFjAwSJ5orzYAPCEIsu72q4Mm8GAH5RmIHAJrBa7R0ppj/H2OZgo1aw9BnTyBR2du5wO/ASpZNEugyd7pae0pC3YHvdrlybYBxd8WE06fm3yPcWU/v1iPfUD9JVsci/2ZcQ2fPY5p9vMGxpm1EnjlqJDCzn+Wnln76GER7179j8O0mkTEMFFuAcTKCYTDGOeITjry5SbLjjK39FLkcZBY1SByCF1Ph0jOWNAfqIGIJNsJWnF4IH+QWQa3DJKfbXLrUQUocj/gpdwhMXU6liURWbDcyipKGmNasWJAGGWbSxgOOp+4Ug4oISmdH/j7I/IXaCY6OXscvYTZ4Y/YKY5K0k23cuv4/kyHgwm7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199015)(6512007)(83380400001)(186003)(53546011)(6506007)(76116006)(2616005)(66946007)(64756008)(66446008)(26005)(8676002)(91956017)(8936002)(66476007)(4326008)(2906002)(7416002)(478600001)(5660300002)(54906003)(110136005)(316002)(41300700001)(6486002)(71200400001)(66556008)(122000001)(36756003)(31696002)(86362001)(82960400001)(38100700002)(38070700005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU02QjRwbFVDajJLL2d5QnVKVkt4dklrcXFQY3dUN3FBc1c5OGZ6YVY3V0E0?=
 =?utf-8?B?aS83OFM2T25zWHc0UkFrTEl4NzU1Y1ROK1dlRFdaR1k2REVZKzQ1UkFtN0FS?=
 =?utf-8?B?OFpxbWU4YmJEYkFaQTF4T1ZZWjh3Ukg2LzZtN25JZjBhZStDNHhJNjZuakda?=
 =?utf-8?B?b1E2ZFdLWmIyS2h3emRJQ2xaY2Jncndua0ZvQmZxRjk5WCs5S2JLSzhoS3Jm?=
 =?utf-8?B?bys5Q0pmS1k3dnRPVWdQRmd3S2k2T2V6TEpYUEpxd2p6RWFYRGJUY1dHS3hn?=
 =?utf-8?B?YVJZNTAvVi9URTc2ZWZaQzAyZThieTBpaTlxRUxyRDF6dmdNRng0SVcxZ3NJ?=
 =?utf-8?B?d283c2ExVU0yOVJrTjYreFB3eXVRbnBuSUZKWjJGbDdCblU1ZjM1eWIzNFRO?=
 =?utf-8?B?YlZQdFdjWG1oM0dETzF6azlCTXZDc0dPNmc2MGk0U0liMHhQd3cwTnNXdGZL?=
 =?utf-8?B?NWpOVzZtMVJTVHExSXNiVitqRVRkamU2T01KQ0xiSC9YcmhtUTdySWtRRWVX?=
 =?utf-8?B?SnFmSXF6bVBSSjM4V3RDTkEyNTRBOHVZbldZYm00blBHTUFXd3BFQktxL29x?=
 =?utf-8?B?cEhHKzJqOUhCY2c0YUFZSDBsRnBlRmE5M3RsWXp3RHlTTVhIdUVFT290Q2ZH?=
 =?utf-8?B?QWVHQlUrSHRVejVBbHk3b1ZqZ1VOYjQvRkZEdWxpSTdCUC9ZNGYxZTh5Zkht?=
 =?utf-8?B?bEV6SU1taUdveUQ0bFVUZzM4VUhQWEdNa0dXQkZYN0ZSZVppNDdNMEdvUUY0?=
 =?utf-8?B?UlhWZFdmMFR5SGE0UTJGQ0g0cGpSaHRtUnUvZmFBcWM2blM2QnNUQUJsMmgz?=
 =?utf-8?B?TUVMYWdmemlacll2YlZqZ29rYm9WWmROM25mNWdxOFJOTW5WOXQvQmlxR3JL?=
 =?utf-8?B?OWltN2tUdzFUb3B5aHoyemhXNktFSlB0cllrNGpCSmE2TjR2TGlKbWh2eTQ0?=
 =?utf-8?B?MWF0TGlEcGJrR3JISXp4cTJLdmlWYVllaUNkK01CNHN3WHNSN0N5ckp1SGt5?=
 =?utf-8?B?a1VqdWZoZWpidDcxT1hSRXh0d0pGRENWS0FLejVMUXJ2eFg1U0YveWh5ak5B?=
 =?utf-8?B?MlFYN2ZJUWxwRDZLUjhSd29yY2QvaURUWUNFQnpCNmNCMXVKMFdvaDZjaGNR?=
 =?utf-8?B?dm5RaGlCRUUzc25uVUdrOVpIc09UZ3B3S0ZiR2JYVkh5ZW9OM2NZWlF1NzN5?=
 =?utf-8?B?aDhvMURuQWpueldtcWd3Yjg5RkNCM09qdThwNUwvS21xbFFaQUJqNDBmaWtU?=
 =?utf-8?B?TDU2RFFsLzNiQlArYWE2SW1SNTZ0WkpkRnNnaDFiSUlyNGsvM2F5TnpxRG1U?=
 =?utf-8?B?ZTNYMFRGb2EzaEF4RjQ4MjcwWk1XYkZGcDZIQ2xXaTM2ekk2eXBMcEJKZ3pZ?=
 =?utf-8?B?bkpBbitidHlOV0svVk9TbWk2N2dXN0I2STg5ZFMyNmd0cnIyOEJBZUM3d2tx?=
 =?utf-8?B?WDAreFZaMEZ6OEJEWnY1a3poS2E0aGplc1g2VlBvWDRYRFUzYTZTa3NYMk1k?=
 =?utf-8?B?bTFIVUNIbGZiVCtHRkZVR0QrN01PT1BvUWxENlpXZkhpNm4ySDFqeHJ1SmZD?=
 =?utf-8?B?V3UwVm5MVm1aWGROcmlZUHR4angvaThlKzhzUHpTejFmSWhnU2lLN0dkOVoy?=
 =?utf-8?B?MUlmYmlveTBFblhDTFg1dEpGZXVpUTdwbVArV3BURDA1N214OHp3ZnFpZDdB?=
 =?utf-8?B?ZG1pemlsMVlLWHd4RE1NbUxCTkV0SGVRQnd0NEJTWFdUK3ZXbVNwWCtDc081?=
 =?utf-8?B?M09RelIzaXRqOTA5bkdPS1hVdElEc0dkeFR2MXZ2ckllSjFJQnRkV1hhT2sz?=
 =?utf-8?B?UFJJY3BudCtoUVhvYU9hb1pTMmV3S2pPZTIwTXYvcXozamd6ZkRISEhqZ3NF?=
 =?utf-8?B?M29wZjNHbXJXWk9yUkQ5czBYNW12SmpNMTQwSjI1aGUzV0dwSDhSQldMNkpZ?=
 =?utf-8?B?MHhkWlgrVEFIUFowR2d3Q3hSQWlMUXRURWFscjk5VU1abG9DMTJ5RUNoVXhX?=
 =?utf-8?B?RXkvRzNidFVPMkhLaDFqb3c3K3hueG5BZDZxNWhVb1JjMTVweEJtcVVOYVlR?=
 =?utf-8?B?K2R5MlRsQjlGNHVxMmZxSm41SzFXOXhXdER5UU1hdCtXRkVBeEpWZWh0dTlm?=
 =?utf-8?Q?WLzDVy1W6RWD8Uc5A5QahPBZC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC66E6DB72847C488FB88ABB5CB81418@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ae6c2b-07ca-4e78-1d0c-08dab33b1e10
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 08:06:11.4848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9W5pmHAXYfpBen5DniHkn6uYDodX6bJF8IjNbdy+CaeqPFF1K0DmyhaJyYXzFAw+ClEX/UK4Vdo2Q2tNcdact9RC95LfhpnnOxyhYr3gWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4977
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAvMTAvMjAyMiAxMjozOSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBUaHUsIE9j
dCAyMCwgMjAyMiBhdCAwMTozNjoxOVBNICswMjAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4g
eGVuX2VuYWJsZV9zeXNlbnRlcigpIGFuZCB4ZW5fZW5hYmxlX3N5c2NhbGwoKSBjYW4gYmUgc2lt
cGxpZmllZCBhIGxvdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jv
c3NAc3VzZS5jb20+DQo+PiAtLS0NCj4+ICBhcmNoL3g4Ni94ZW4vc2V0dXAuYyB8IDIzICsrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
MTcgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3hlbi9zZXR1cC5j
IGIvYXJjaC94ODYveGVuL3NldHVwLmMNCj4+IGluZGV4IGNmYTk5ZThmMDU0Yi4uMGYzM2VkNmQz
YTdiIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYveGVuL3NldHVwLmMNCj4+ICsrKyBiL2FyY2gv
eDg2L3hlbi9zZXR1cC5jDQo+PiBAQCAtOTEwLDE3ICs5MTAsOSBAQCBzdGF0aWMgaW50IHJlZ2lz
dGVyX2NhbGxiYWNrKHVuc2lnbmVkIHR5cGUsIGNvbnN0IHZvaWQgKmZ1bmMpDQo+PiAgDQo+PiAg
dm9pZCB4ZW5fZW5hYmxlX3N5c2VudGVyKHZvaWQpDQo+PiAgew0KPj4gLQlpbnQgcmV0Ow0KPj4g
LQl1bnNpZ25lZCBzeXNlbnRlcl9mZWF0dXJlOw0KPj4gLQ0KPj4gLQlzeXNlbnRlcl9mZWF0dXJl
ID0gWDg2X0ZFQVRVUkVfU1lTRU5URVIzMjsNCj4+IC0NCj4+IC0JaWYgKCFib290X2NwdV9oYXMo
c3lzZW50ZXJfZmVhdHVyZSkpDQo+PiAtCQlyZXR1cm47DQo+PiAtDQo+PiAtCXJldCA9IHJlZ2lz
dGVyX2NhbGxiYWNrKENBTExCQUNLVFlQRV9zeXNlbnRlciwgeGVuX2VudHJ5X1NZU0VOVEVSX2Nv
bXBhdCk7DQo+PiAtCWlmKHJldCAhPSAwKQ0KPj4gLQkJc2V0dXBfY2xlYXJfY3B1X2NhcChzeXNl
bnRlcl9mZWF0dXJlKTsNCj4+ICsJaWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9TWVNFTlRF
UjMyKSAmJg0KPiBDYW4geW91IHN3aXRjaCB0aGF0IGFuZCBiZWxvdyB0byBjcHVfZmVhdHVyZV9l
bmFibGVkKCkgd2hpbGUgYXQgaXQsIHBscz8NCg0KV2h5Pw0KDQpUaGlzIGZ1bmN0aW9uIChzaG91
bGQpIGJlIGNhbGxlZCBvbiB0aGUgQlNQIG9ubHkgKGJlY2F1c2UgWGVuJ3MgQVBJIGxldHMNCnRo
aXMgYmUgc3BlY2lmaWVkIHdoZW4gc3RhcnRpbmcgQVBzKS4NCg0KV2hldGhlciBpdCdzIG9uY2Us
IG9yIG9uZSBwZXIgY3B1LCBpdCBkb2Vzbid0IG1hdHRlci4NCg0KY3B1X2ZlYXR1cmVfZW5hYmxl
ZCgpIHB1dHMgaW4gYW4gb3V0LW9mLWxpbmUgdGh1bmsgKHdoaWNoIGlzIHdoYXQNCmFjdHVhbGx5
IGdldHMgdXNlZCksIGFuZCBhIHBhdGNoYWJsZSBjb2RlIHNlY3Rpb24uDQoNClRleHQgcGF0Y2hp
bmcgd2lsbCBoYXBwZW4gYXQgbGVhc3Qgb25jZSB0byBvcnBoYW4gdGhlIG91dC1vZi1saW5lIHRo
dW5rLA0KcHJvYmFibHkgYWZ0ZXIgdGhlIGxhc3QgdGltZSBpdCBnZXRzIHVzZWQsIHRoZW4gdGhl
biBtYXliZSBhZ2FpbiBsYXRlcg0KdG8gY2xlYXIgdGhlIGZlYXR1cmUuwqAgRXZlbiBpZiB5b3Ug
aGFkIHNldmVyYWwgbWlsbGlvbiBDUFVzLCB0aGVyZSdzIG5vDQp3YXkgdGhlIG92ZXJoZWFkIG9m
IGNwdV9mZWF0dXJlX2VuYWJsZWQoKSBpcyB3b3J0aCBpdCBoZXJlLg0KDQp+QW5kcmV3DQo=
