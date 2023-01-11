Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB5B666602
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjAKWIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjAKWIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:08:05 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Jan 2023 14:08:02 PST
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB881CCA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 14:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1673474882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3WC4I1sq6pRJvzk9BQhg0ICzYteAkwLRJ6tfwfxFB0A=;
  b=VJUkVnaxMzUQ0aDeQLJkLlBeqN87LK5qaLndwaZRCZgma1mmBB0cRyHd
   3/naHKz5Hz/C7OJWo7pbxlKrHinUeokP6lEmLB8xitVjUsTrvIxpMXPwb
   yBbyeQiiAi9FyCqfYgH5Pc5WqpTO6hwTbjrxelyeGe/mPZEv+NtNJKhM8
   g=;
X-IronPort-RemoteIP: 104.47.59.177
X-IronPort-MID: 92247221
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:XRDpJKhxB9pCb10JH+qNxXm2X1611REKZh0ujC45NGQN5FlHY01je
 htvXmqEa6yJZWOjLdh0PYuwpkoAvsSEm9UyTlA6/Hg9ESob9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmUpH1QMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsy+qWs0N8klgZmP6sT5QaHzyJ94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQGLgIvbzyN2tuqg5CxG8ZrtJ4DMu/CadZ3VnFIlVk1DN4AaLWaGeDmwIEd2z09wMdTAfzZe
 swVLyJ1awjNaAFOPVFRD48imOCvhT/0dDgwRFC9/PJrpTSMilEgluGyb7I5efTTLSlRtm+eq
 njL4CLSBRYCOcbE4TGE7mitlqnEmiaTtIc6RefiqqEw2gT7Kmo7UzwyZVym/OGFjE+/e41ed
 2ob6zUtov1nnKCsZpynN/Gim1aGtBMBX9tbE8Uh9RqAjKHT5m6xAmkCUy4Ea9E8ssIybSIl2
 0XPnN7zAzFr9rqPRhq15ufKhTC/Iy4YKSkFfyBsZRcK58nLpIA1kw7VSdBiAOi5g7XdGz7qx
 CuRhDMjnLhVhskOv42h9F7OjjaEpZXTSAMxoALNUQqN/g5/IYKoeYGswVza9upbapaUSEGbu
 3oJkNTY6/oBZbmVmTCAWvclHben/f+JPTTQx1l1EPEJ9TOk/XS5YI9N7St3IW9mN88FfXniZ
 0q7hO9KzJpaPX/vYaopZYu0Up4u1fK5SoujUe3IZN1TZJQ3bBWA4CxleU+X2SbqjVQolqY8f
 5ycdK5AEEonNEiu9xLuL8917FPh7nlWKb/7LXwj8yma7A==
IronPort-HdrOrdr: A9a23:S9kQEqvz0wktzuBfuHU4OIwz7skDeNV00zEX/kB9WHVpm62j+/
 xG+c5x6faaslkssR0b9+xoWpPhfZqsz/9ICOAqVN/JMTUO01HYT72Kg7GSpgHIKmnT8fNcyL
 clU4UWMqyVMbGit7eZ3DWF
X-IronPort-AV: E=Sophos;i="5.96,318,1665460800"; 
   d="scan'208";a="92247221"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jan 2023 17:06:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LByou3vqt3nfqWjejpteOkuKVGQOb7bcu6qohg2xuy/kmckJcEDU+UPzsSenHyH01lUYkv5zcJEOVZovtsx4A2DZZEt6cTUgZd4qg9ieOmlIW+FUJd8dq8fpdT2MT6y4HR57EDF14KZUkvUsjrtLYi/VcpJMVNCY/+v+OH+CgoauD7zoKQDaKGh3gcbaM4Nkdk5ozE0z0puU4nyxenE9lVkF0LLQINY5tmoamMNHr0WepHM3Ja601nnTpdlbLRA+ksw2CVr9Cg/0fFe6oNHFtuVOFuL8+yZVyZbMt4TypkkrwfG3GMqCkHec9VGKniSZkrIVR2wwkbDQMELNTNFFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WC4I1sq6pRJvzk9BQhg0ICzYteAkwLRJ6tfwfxFB0A=;
 b=NDWpxgGd9ja2Tc3bkeki8cQ4TQ3ncGqxnoIRUF8dID4KNrnHFhkzBMo0iSdSd/Bqy7uorNTb/xZ7FNAU0VF2HOBJoxNmHkC2YRXWt5jQXR26TUb9RSULPfq3htgnfQE6vt5LA95PiUMpfHU+ofqb68/Lpws5EM1lWmlFgbXzdPSH54iZ/70c/V1Hvd21JqIkWoBeVdlC742IlF24cDF1GJDgBkHXcakicALCl30p2+hhrJ3IVKuF0se/qt1Tj//ZPnSlwm6ViTxWiXIt0KZ2mBWhlVw1ETLyjEGaeZK64DFdDzjrCAbhtJqlGeerEbv+rrgD+oH3GHOS7kbxLw1WFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WC4I1sq6pRJvzk9BQhg0ICzYteAkwLRJ6tfwfxFB0A=;
 b=JE5gCUzYce+uFFP0xwEFi7rvp/F9RGhPjdj+Ug81GffsRQ2TSsO/BYNhWcRIUxu/HX2apnGzK4lzhv+JIu1Z6ZYXaxRbL2i4eEqAwMr4mvU+z3q5jYqHC5GQWXLsFNQZxq60b70q7/yMUm7z+4KXQcnPsBpFaVWxlNQkH38OVL0=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MW4PR03MB6555.namprd03.prod.outlook.com (2603:10b6:303:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 22:06:57 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19%6]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 22:06:57 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Jan Beulich <jbeulich@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joan Bruguera <joanbrugueram@gmail.com>
Subject: Re: Wake-up from suspend to RAM broken under `retbleed=stuff`
Thread-Topic: Wake-up from suspend to RAM broken under `retbleed=stuff`
Thread-Index: AQHZJa6+C7zgK+BmnkyxcC0/cTTk966ZF36AgAABmICAAK2VAA==
Date:   Wed, 11 Jan 2023 22:06:56 +0000
Message-ID: <cfe514f9-bf6c-292d-a481-48614aeb9dd6@citrix.com>
References: <20230108030748.158120-1-joanbrugueram@gmail.com>
 <20230109040531.7888-1-joanbrugueram@gmail.com>
 <Y76bbtJn+jIV3pOz@hirez.programming.kicks-ass.net>
 <aefed99b-6747-5dcc-65ec-6880f7c0d207@citrix.com>
 <f2c151af-b3ba-69e6-2878-3256971f5a9d@suse.com>
In-Reply-To: <f2c151af-b3ba-69e6-2878-3256971f5a9d@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|MW4PR03MB6555:EE_
x-ms-office365-filtering-correlation-id: 2a83e043-1f44-4f5d-1227-08daf42027c6
x-ld-processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EEnmCcgekWAKjbIUQU1PSMdoNxaVfi5td86HLQzVmWXn/rCsfU+3093Di6zA6lh+Bd8Lbudy3k7I2oyMqr2GlI4O7C/e/cVXrJ8pvu4ZXj8yYNYwLDJLJjED6xWox97Wmh+kq35015Z2lnVNrlU7sbBUFdUNHFyWEer8DDvjPU2e790bAiHAtBeDjX9fE5Wa9b0vvX4CyW65AvWkeK88RJVAfWN6+PpUPpj2/mIp2M/UVwdhs4WMP4AT4uMch9FnpXBWsF3NnjSkHSJGYY7bBljeAYTNSB9xp+Drj57Rk/iQ183/qgxm7dg35jshcKIwiRbAm2fT3B16ZOodNIoN4NkawZ+uZSKdpsOQtF+/iOyhNYV/lUf5a49p0OQXEuZ8v70wgsxt/G2qiq2DlpKForAVuX/dLh/4BNneqOuV7SqXtvrku7flphGjEJn31XpYasDnaMU6GYvDJpG+j3IIACKAJ8JafAOq9rpYTEt6P2W3qCqQxBVc1ogkZfg5wJU2dLBlFqcl8voYlZxECOYfrp8rvG1c0x/ESwxE4k6tTxe5WQgXYZm92TmYl7ye2VoL29ECvjF6Ldaby+C88MB59/RxsW5nUUVtNtOFzMCIw6MucTuNncvOLUKLaa7r6RdtYK6fMJEjM1TWyxEd2j2s+yoJ7w933LQjuG+FKLBpOpmsXhdqT1t1Xbm4vcaqs8JdoLfQLNz8NnrHwaxxLpp8DpeezJsjj3phesF+R+2Jhd04VkukGkVU/BNBwcpnym6pCdMCvn3bAECJe+T1+Q+AgZz8pAGs3mIfbQu+A3gudHE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199015)(82960400001)(508600001)(38070700005)(6486002)(41300700001)(38100700002)(6512007)(31696002)(86362001)(71200400001)(316002)(54906003)(2616005)(91956017)(66556008)(66946007)(26005)(186003)(66476007)(76116006)(4326008)(66446008)(6916009)(64756008)(36756003)(5660300002)(53546011)(15650500001)(7416002)(6506007)(2906002)(31686004)(4744005)(8676002)(8936002)(83380400001)(122000001)(81973001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXRhVlgzZVpYaGljRkxMK0U3SzA5Q0h2ZEdmUjZsT2l5eDMrOGpSbGtXTDd5?=
 =?utf-8?B?QXQ3MzR5TUJRaE8zZ3FuMnRFLzV6cVN0L3dud29rQ2g2dlRRK0wvd21vT0E3?=
 =?utf-8?B?ZHVoMWFhSWtpeDNZaVlpSlBOQlovcmpaQjlsQ3J4Sk1RckFoN1htZVU0Tktq?=
 =?utf-8?B?TjEvNitXOW9DeTNYSThQMzg3ZUppMXhMU3JMVG8xcldtc3dmR1YwVUZyMkdW?=
 =?utf-8?B?NE1oYWRsa0Rpa21QRVM0SkswZUdwa2tmYXM1NXI5L3BuWFlORzJCV2NmVkNr?=
 =?utf-8?B?b2Zqd2hEVGtkSVJRVmJzS2dzbHE2UTBuSURHV2NqMXVBNHQ4YzAzVXhRbXN2?=
 =?utf-8?B?clJIK1REL2NTMDlwS1BnL0R1TzVGclJFZXlGTHptakZiVFVpVUh1Qk9nZUtT?=
 =?utf-8?B?UkorT2t6UDZ6NGo3bE5va3IrelFLOGVIK2J4bjM3dVh3cW8rN00xSlBmdE83?=
 =?utf-8?B?TitOYW9BdytHbXk5VjFoWWZ2MjhpN2hnN1YrTWRkRDgxTmNOb016N2JlUXJV?=
 =?utf-8?B?dlh4UDVCaUpQeisrd3J6WUtpckhRb1pIdE5WMktVL25ESlRGaC9lYWU1U3Ux?=
 =?utf-8?B?V1dSMnBRYXphN1dTNmYxRlRQRjlwWmhNeEc5YmJhUzNXa3llN2NXMGlVZUJR?=
 =?utf-8?B?Wm4xK0FSU3FTWEsyY3lmS0o3UEpIUkFRVVFwMDNIMk5nY2Nxb2tBOUtJYU92?=
 =?utf-8?B?LzlzekVyM2pqWUdxbndwSjAwTGR2SitPSG41QmVtZGcxbFo3VTl3RmNMRmFy?=
 =?utf-8?B?Z3plQnZUaGwxazczVHFFSko2azdhRS9OT0MvUS9TVkx2UlVSa1ArVU1OVzNB?=
 =?utf-8?B?eWdUamJ5eTJqbDhBUXRVQ2pCVHgxL3lMQkV6d3hlRzFQOVJxbWZVNWRiaWNF?=
 =?utf-8?B?dTZnZU9OZUN0NTVCU084OUNyZGRwV3ZhRXphMkdvbzhQZ0QraTVEM0hKS1pa?=
 =?utf-8?B?RkkrTjgyaW5mWmxzSEgvdVREKzRlUkdGMnB0SzFFQk9oeWJNVWJOWForSnBD?=
 =?utf-8?B?clZBcnh4M0lDdXhZSGVDampGWUM1YytOc0VoZnppeFhKbkJ5TUI2ZnZlNFJT?=
 =?utf-8?B?QXZ3b1VYUVFZVHE0aDRTN0pTcFMrVEJmc3Y2NUlFRis0SzRENnhhc1NHYVRa?=
 =?utf-8?B?Nlg5eVZERW5hTkE0QjBsVU1nVmMxTFZjYXUzWTB1RGhNMVVESXlrQ2RwUzlG?=
 =?utf-8?B?bk5randvVWtvZGNIQnA1TDdyU0kxR1FhYVZPNmQ2TlkrUVlZaW9FT3Y3SXJw?=
 =?utf-8?B?S1lxQnRPdi9zUjV4eHJ1cDVxSHNsZUpod1J6Q2RzSE81bUtoVXNBTzF4Q3ZW?=
 =?utf-8?B?MTRDOWNCQTVFek5iQ04zSWdQaElINWF1c1hONTkxald3QjBrUkdCRnhHbDdK?=
 =?utf-8?B?MFNlcmRGWTNaLzY0Si9DR1A2SWxwaDVEczhEZUxaUjE3WEdBeFd1cjdDQzBD?=
 =?utf-8?B?OWNGNTlBK0ZqVEtuamhTVXpwK0VyaGRRQzZ3cHUwSDVkY0JRa1k1Y24zd2Nk?=
 =?utf-8?B?TnNnay94R3lsUEl0U2VWRW5ONmdEWVI5aTNiZGdtL2JqcS9aVWRpTXlsZndr?=
 =?utf-8?B?NHFKQldEQWxESm1rN0IvZjcvUWRCcnRpZ2dYMjR6a3QzS0k4bkhMcHYvUFNN?=
 =?utf-8?B?VzJEd1VhVHFHM1JDYnV4RTM3R0JyY2NjVVFkVForcHBCazZjdnF4VDI2Rnhr?=
 =?utf-8?B?ZXBDWUltbU9wSnlnMVVmNWgweGF2cGNpd285WVZjNHppVndSUnlYMnVFa0or?=
 =?utf-8?B?UEs4ZUxhMzBsR2lMejBBOGt2T2FvenM2NnZ1ZThGV0ZwdUQ5RFhyKzhQVHV2?=
 =?utf-8?B?SU5Zd2puQ1lTa3RtTnBqUjNVZE5SVnZScTBGNjBKS2xLY3oxWVo1eTZzYmFX?=
 =?utf-8?B?KzFjekRjb1V4Zko2M0JqcndZUUJUQjhndzVGenpDT0VKWU4zd0NtV2ErRlgw?=
 =?utf-8?B?VUFuUXZKZkVqejJtV0FObUMrU3VLWjRuU1FEaWwxYmUwUmUvV1NlQ3ExMWtQ?=
 =?utf-8?B?VTJrMENrRTdRSUdvTjk3Q1prbUl5MUU0anNuMWdpaDZIQ3pranlFRndQVXJM?=
 =?utf-8?B?bDBvU1FnRkR5THNObm9zRStWOXoxZkppOUU4THVRUW5PMjNrbHNYU3FJMDNk?=
 =?utf-8?Q?xvhhYi9YTJuY6pq30mC9iuD1U?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A8DB20C8A814C47B6867826EF244D2A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OG5NUUxGY0JTVlhLU0ZtVzl6REwxVWVNL25DZ2FEMWdzL0tOd1hsc0tYZmlh?=
 =?utf-8?B?YThzN3E5TFhDQXdtanlFVExFS2NHbmUyTTJFYUY4RXA0NkJhRm1KVnBQMS9i?=
 =?utf-8?B?SFd2NW81SVI0L1orKzNKcjRMaytBQjNVN1V5WTlJY3ljY1pwN0tIaVMyUDJ3?=
 =?utf-8?B?MHZCRUgrWkhtZkdIRmNEQnp4VHJqTkw0bXVVSExLVUprWHEvSjJnUmZOZ0xT?=
 =?utf-8?B?M3ZUNktOTXlVZHRzOVQ5T0hBN21ZYU9iUzZjeVd4VmEySnRWR2xMVEMvRkI0?=
 =?utf-8?B?TDZWWlNqb3RPWnlLVTd3VDRHelROUnRzZms0YlpUZ0ljR1Q0Ym5DbUxDczNS?=
 =?utf-8?B?TnE2UEFBa1hxWkhxanc0RmtjSERnWjRhQ3hibzE3MWg3dWVuQ3VqWjhHMkFz?=
 =?utf-8?B?NHNFbVpkWU1yUE5Ba3JlbEtSa01Fc2hJc0JtRW52cFk0eUkwNWhhUkUrMGFW?=
 =?utf-8?B?RkFreDlRT2RkTnJZS3R3R0NQNS9qL0xNMUw0SFUyYVhnNjlTMUFYWHdNdlIv?=
 =?utf-8?B?OFpQS3RvekFBVWRWRzAvcGwyN0I1ZTVkOTk0RXBJYTFpRGY5MGdBbklDNzUx?=
 =?utf-8?B?MldlMUE5WVE3L1Z5NGtOU2RLZmUzU1BHVjZvb1hseUdobUFzU3VBZHVmR2pC?=
 =?utf-8?B?bnI0dlhac2VCYTlkQ0RWbTV0L2hNRzFyUWRBZVNTbU5JdThzcWZmdnRudG9J?=
 =?utf-8?B?U3FDZHlWNFZqWlVRL1oyeS9mZS9PYUhLczN2UHczbW9LU0IyU1pPazZNZ0s2?=
 =?utf-8?B?VXRqcG9wenA1N3o2K2xZTTlubjZtcWZtbkl1UnlUQjF1cW1XRzhmNnZ3Mm5j?=
 =?utf-8?B?ekdCei9UcEllZjJDNUY0ZEhyYnJSTGc1VzFabG5wR3cyNFg4eWNCV2N0QlF1?=
 =?utf-8?B?ckdUYXkzLy9oWW5ndEFxWmI4U2VXRkF5RkowSHlkMWpqNzZERlRtQjNMalRm?=
 =?utf-8?B?UlhScENENlR6UktDc0huL3RhbmE1K3lWWm5TMkFOd3g5QnNkSElwKzVGLzcz?=
 =?utf-8?B?YnlpdExsWVJLUklyQ1dEMGlrcllvZzFvOVZnVEtoN0UwM0lmL1JDanNJR1VO?=
 =?utf-8?B?ME5kcGcxbUhka3JyZGY0VVVNbEZocmduYnJHQnJJNnFMSGlpTVE4UlhndFpk?=
 =?utf-8?B?ZCtPWFRqb1VTdTlTd0FRUWFBU21XSE5zenU5bUU0ajM5M3VwOHkxRzAvbUNs?=
 =?utf-8?B?RlRZZlJRdklwMysvaU03SFBwdmdWOHVwLy9BS1VxYmF3WDIvWGNWYUdtMU1a?=
 =?utf-8?B?Znh3cjBSZklGMG1jRDZxWFhaeHAxVWRucllEY2RiV29ZRmFacnlDOEtkVzRL?=
 =?utf-8?Q?suAZcQ/vXM+R4=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a83e043-1f44-4f5d-1227-08daf42027c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 22:06:56.9613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnDzG0Exna6WsGLecBjljQYrZJ0ZJVJ2dlSHkohMWfm+t4EhZpxHUz6DMdiUFJnzhyADGq0Qdh/c/GnsB2G+JfllvaRJ1hc5jlHxba7hOoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6555
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMDEvMjAyMyAxMTo0NSBhbSwgSmFuIEJldWxpY2ggd3JvdGU6DQo+IE9uIDExLjAxLjIw
MjMgMTI6MzksIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+PiBUaGUgYmlnZ2VyIGlzc3VlIHdpdGgg
c3R1ZmYgYWNjb3VudGluZyBpcyB0aGF0IG5vdGhpbmcgQUZBSUNUIGFjY291bnRzDQo+PiBmb3Ig
dGhlIGZhY3QgdGhhdCBhbnkgaHlwZXJjYWxsIHBvdGVudGlhbGx5IGVtcHRpZXMgdGhlIFJTQiBp
biBvdGhlcndpc2UNCj4+IHN5bmNocm9ub3VzIHByb2dyYW0gZmxvdy4NCj4gQnV0IHRoYXQncyBu
b3QganVzdCBhdCBoeXBlcmNhbGwgYm91bmRhcmllcywgYnV0IGVmZmVjdGl2ZWx5IGFueXdoZXJl
DQo+IChpLmUuIHdoZW5ldmVyIHRoZSBoeXBlcnZpc29yIGRlY2lkZXMgdG8gZGUtc2NoZWR1bGUg
dGhlIHZDUFUpPw0KDQpDb3JyZWN0LCBidXQgaXQncyBvbmx5IHRoZSBSRVQgaW5zdHJ1Y3Rpb25z
IHRoYXQgcmVsaWFibHkgdW5kZXJmbG93IHRoZQ0KUlNCIHdoaWNoIGNhbiBiZSB1c2VmdWxseSBh
dHRhY2tlZC4NCg0KVGhlICVyaXAgYXQgd2hpY2ggWGVuIGRlY2lkZXMgdG8gZGUtc2NoZWR1bGUg
YSB2Q1BVIGFyZSByYW5kb20gZnJvbSB0aGUNCnBvaW50IG9mIHZpZXcgb2YgYW4gYXR0YWNrZXIu
DQoNCn5BbmRyZXcNCg==
