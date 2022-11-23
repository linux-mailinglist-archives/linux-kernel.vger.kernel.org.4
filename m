Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CB3635AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbiKWK7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbiKWK6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:58:42 -0500
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9E9BC90
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669200733;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IGXRa8X25n4XL4b0elOIM5eE8xWKepBBYafXDXSc+bE=;
  b=EtY5Isz5gWCjnGej+5YNpMV4H4lxrGEuQ2cxYFwtwOQ3mOV7AwpwJyjc
   u4Ez0N7VEdGKismctAL2HukWsQkHOnkyE+yk/uU7RGkk+K8w9nQkDYdTz
   q1Wl1tRKrF6TQNRcnT/9UiaH4icV+qJGYjq+GpPBKK/MHjTUQV+bvQdMR
   o=;
X-IronPort-RemoteIP: 104.47.58.169
X-IronPort-MID: 85405011
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:IibV3KtNRpwUFe2BevLldCvWf+fnVBNeMUV32f8akzHdYApBsoF/q
 tZmKWrUbPjYZWf9f9okO47koE8EvJPTztVgHAI/r380FyMa+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg0HVU/IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4bKj5lv0gnRkPaoR5QaEzCFPZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwKzNXSBy9nuyP5I3jRONDuetkCdS1FdZK0p1g5Wmx4fcOZ7nmGvyPz/kImTA6i4ZJAOrUY
 NcfZXx3dhPcbhZTO1ARTpUjgOOvgXq5eDpdwL6XjfNvvy6Pk0osgP60bou9lt+iHK25mm6xo
 G7c8nu/KRYdLNGFkhKO8262h/+JliT+MG4XPO3lqqY32ATKroAVICQOcVGKqvzisROBCpUDE
 Ggp1A8okIFnoSRHSfG4BXVUukWsphMAVsBCO+w85huExqfd70CeHGdsZjxZb90jvsg7bT8nz
 FmEm5XuHzMHmKWcVHaY/bS8rj6oPyURa2gYakcsVgUfy9Lqpot1hw/SQZBkCqHzh8CdMTXxx
 S2a6SsznbMeieYV2Kihu1PKmTShot7OVAFdzgfYRGW+9StieZWoIYev7DDz9u1cJYyUSl2Au
 nksmMWE6u0KS5aXm0SlSuIXHarv4O2ZKjrCml1+N547/j+p9jioeoU4yCFzIgJlP9gJfRftY
 VTPokVB6ZlLJnyoYKRrJYWrBKwXIbPIEN3kUrXeaIpIa50oLQufpngwNAiXwnznl1UqnecnI
 5CHfM2wDHEcT6N60D6xQORb2rgurswj+V7uqVnA50zP+dKjiLS9E9/p7HPmgjgF0Z65
IronPort-HdrOrdr: A9a23:f7eyU67gZgQBaNMp4APXweCCI+orL9Y04lQ7vn2ZFiY5TiXIra
 qTdaogviMc0AxhI03Jmbi7Scq9qeu1z+853WBjB8bZYOCAghrlEGgC1/qp/9SEIUHDH4FmpM
 BdmsRFaeEYSGIK9foSgzPIXOrIouP3lpxA7N22pxgCcegpUdAY0+4TMHf4LqQCfngjOXNPLu
 v42iMonVqdUEVSSv7+KmgOXuDFqdGOvJX6YSQeDxpixBiSgSiu4LvaFQHd+hsFSTtAzZor7G
 CAymXCl+SemsD+7iWZ+37Y7pxQltek4txfBPaUgsxQBiTwhh2ubIFBXaTHmDwuuumg5Hsjjd
 GJiRY9OMZY7W/XYwiO0FXQ8jil9Axrx27pyFeej3emi9f+XigGB81Igp8cWgfF6mI71esMk5
 5j7ia8jd56HBnAlCPy65zjTBdxjHe5pnIkjKo6k2Ffa40Dc7VcxLZvvn+9Ua1wWR4S2rpXV9
 WGP/usosq+tmnqNkwxi1MfhOBEmE5DRituDHJy4fB9mAIm4UyRh3FouPD32E1wtK7VAqM0md
 gteM5T5c5zZ95TYqRnCOgbR8yrTmTLXBLXKWqXZU/qDacdJhv22tfKCZgOlZaXkaYzve0PsY
 WEVEkduX85ekroB8HL1JpX8grVSGH4WTj20MlR65Vwp7W5HdPQQGa+YUFrl9Hlr+QUA8XdVf
 r2MJVKA+X7JW+rHYpSxQXxV5RbNHFbWswIvdQwXU6Iv6vwW8XXn/2edOyWKKvmED4iVG+6Cn
 wfXCLrLMEF9UyvUm+QummkZ5osQD2LwXtdKtmowwFI8vl9CmRliHlktX2poseWNDZFrqs6OE
 NjPbKPqNLImVWL
X-IronPort-AV: E=Sophos;i="5.96,187,1665460800"; 
   d="scan'208";a="85405011"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 05:52:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiR8x7jtux8s5yTJhIdE69sC+31LaR+XIAtEfYod+c0ChD1rNQGb2Y6WX/kLWARIE7sHRLDeuHyNaevec+xLkcGiHkN8eR5YK+7F4ySuSM8ccVVUUNWMh1dyAQADByUiAs+1f5jczHkg045Op86DgSescAUROTau8XV6KHcvwlFqdnQVJ73PWGcNEyK0k38Ulemx5Uev07XkrXsSBv7WkYlVrzcrhRwd/uoNNdAiJ8edX90G57A5S+eucz7WUt2TkPwwpxI2I7sYohEfmgMz2VD8DP5DdOGwfK4IqLUx4MGpP67a1DGSFI1E9NF9g9GcLHPH6Se+epVy6UKI84k7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGXRa8X25n4XL4b0elOIM5eE8xWKepBBYafXDXSc+bE=;
 b=i4EdGBPzFKWdho6FqLe8gY+JC+wz7vtuA312zmJZ3v1BpKuwDpoUPrWg9A4dqEU+prr5hlXRT7gEPPf5V5VmCKOsyK54t/Jklkwz2knSz2p4nR+8iYtMYhJ36nPgfw8KfDlmKTWVi72VP0HYFeXIiWMujx9SKpKpxH9RvnyA1ad8cIFOm96fBqqYKHKnXk779s3JnHWwqyy0+Nqart+VR21/qz9YTw8202qSINSMxkk6AnsOwvO7TLlXC9PKHHNb0H88yhlrubxgIMtxvFM6i+qICr0ksZH1+mvcBLdNGu4kmypMb+4m4q8HnLUbGCkZa29DoeuPwzIHLXcD945y5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGXRa8X25n4XL4b0elOIM5eE8xWKepBBYafXDXSc+bE=;
 b=A5tvfmKLbcEGDwb39tqAEJtCfEbLNP35kaXvQ3UKjI8FiRIzmwSd3emlTbppy2W6l9b+euqLoNW/LtvOa1w5IKBMnkfwk6OFHrhz/w8rTaFaqjR1h4ZJ0idCp1l0s+Vt4iiJTd1Fmn9cjoYmQgBs3azkKtrmIwWMoBjjX2vdosw=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DM4PR03MB6142.namprd03.prod.outlook.com (2603:10b6:5:395::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Wed, 23 Nov
 2022 10:52:09 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19%6]) with mapi id 15.20.5857.018; Wed, 23 Nov 2022
 10:52:09 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: objtool warning for next-20221118
Thread-Topic: objtool warning for next-20221118
Thread-Index: AQHY/xmtDBdsZRBv3UKvUqFDgKSI5K5MVQ6A
Date:   Wed, 23 Nov 2022 10:52:09 +0000
Message-ID: <2255c45f-d8ba-3f32-9d99-737ad3040dd7@citrix.com>
References: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
 <Y3thrQxfcvZSXFlr@hirez.programming.kicks-ass.net>
 <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
 <20221123012350.kelmmadh65lyswqz@treble>
 <Y33gAiFP2IpVdxJu@hirez.programming.kicks-ass.net>
In-Reply-To: <Y33gAiFP2IpVdxJu@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|DM4PR03MB6142:EE_
x-ms-office365-filtering-correlation-id: a68e4e03-c80a-4ff2-b70d-08dacd40c4e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xwWSu+KGOZ/2e9mINlinQqRty1Fmg+A+9nyM14ZbX2c5FMfpJ/bzQBeKf0iow3ixKhVhM6on8mXf+iOBoKNQzPmWcpJYEo3XN0pahd1JBCLxmZzvqMo7OVFyS88pxyLwO11u/KyoFvDywa2V5RXGLUqglVeGswEx3ka3LnbYjOcb5+3D7y11N5oJ6e9HQrGV7BoUPo2DVytoXFEpifd37jkNWh6PfpgBFNa+ER1+9djtKOoA6+y7urqPYkDnCxHsfRCv18hNhydhRc5N9eomNQNsjgEoLPJB0XfSXB21+GH66vct4hmLZ+T9EwWjfEi6C4A4D6ZFpNWV7vYYcMMKDUVBUfJjn2RPsT1E3C8KUPoWUEcBbn2LgMHJ3NXKteG9X+PWTPz5m4RQbuSqpE6BCNa9QU1eOF9rp7RfgyWJIf+cNkWVz9JiajtylKWjM6n3nMoPe9jIYcEovpzZ4NIgmZvsG+ZDS97MdiiGsewKxFUpyw9K9EO7QWltMN0Sef4cA7J9D4Mmn5E+r5xwr9W0vQJn0hBbTLgZnFfQe2f8EkG/iS6qs0V+Suh1ppW0KdhD10bsgGhvYOvC9P+4Fs4o+trVfFriG3DQjQQklWdzz/UazqsYBFKRIt4OcbD5NOk3cGn4nSqDBLrQM6OGQt1JZKqwvWDeCfv6lOqGhQrd9MFwDmPYBZYQycGOUZVCxTq1NSRzJmLppaz9reg2Xh5+w3KEX4REIOlQnBp/e3slXNaH6J9+NpYXuWY3TOgCUOQEbg655eljjamaqeQ4bc/9KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199015)(82960400001)(478600001)(31686004)(86362001)(38100700002)(6486002)(83380400001)(71200400001)(122000001)(6506007)(2616005)(186003)(36756003)(2906002)(316002)(110136005)(54906003)(26005)(53546011)(31696002)(91956017)(8936002)(41300700001)(76116006)(66946007)(8676002)(64756008)(6512007)(66556008)(66476007)(5660300002)(38070700005)(4326008)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGJ6dlpRUk90KzcyU3dGTGFtdzRDL3Exa3k5bUFLM2czcTRJMjJCOTQwYWo2?=
 =?utf-8?B?N0RKRlo4UFBSNzM5MThXOE92di9vU1c0NUJvSWdHb0dBUyswTW96Z0lJdnhG?=
 =?utf-8?B?c0gvMlM0Y3ZsSnF6S1pVa1dqbGo5Kzk1eGd4bXZuK1dWdER0ekxxdXI2dUpZ?=
 =?utf-8?B?SVRMdm96UXBtUzlXOU4xODlBamFOeXFhQUlQemZmbk1VWnFtcjVrV0t5QzRM?=
 =?utf-8?B?bFQyd2FhK0VVVG9DQnVPN2Nzc2kxNzB1RW1LdktoMVlmQTBmc0FDcEFKL0hE?=
 =?utf-8?B?UEc1LzQvcHdRdWw4TDdFRDRPOTRiV3J5bWI1Nmo5NmJyWmNJRmxTRmVRNGdK?=
 =?utf-8?B?T1l5bXpEVnpJNEVuNzZTcmF1Q3c2NEsxbXN0V3VwN3lveUZTOENvT0wrMFVM?=
 =?utf-8?B?ZXk1R043eUJwdXpRdDhhM0svQWtpSnhHaFNtalBIb29rbUo5SEdoeUtqS2sv?=
 =?utf-8?B?Nll4bWRNQm04YVpWbjg0c205SUpMTkZwdjRGOTl1N0JyWENLdHNGd0wyVFZJ?=
 =?utf-8?B?Z2pYN0RYcmQ5Uzd6NEhSNGN6RGovdDdxdDk3NWJQNm9rWTQxTklZTnAxOWhq?=
 =?utf-8?B?eE9VWlZNbzJ0Y2lISzlqdzBPVjVyUHhRbDJkdUtJbXpmVjE1QVRZVW1rZXJB?=
 =?utf-8?B?dnI4NklTSkpiWWFqWkhGWmcvVS9sWVpRN256SWE3QitEdS82Z3Z2Tk5mR1Qz?=
 =?utf-8?B?OWZLellhMUxXNFhyU2FiZGZJU0lvdk5JWkpUcUJvYWEvV2htbzN5UStwQThp?=
 =?utf-8?B?Zm5jQlRHMU1GTVN1eWFNTlhaUlQwQXc4eTdmb3NMNUIrck9iRjdudUY0dnp6?=
 =?utf-8?B?WklYZkEzcnYxRGNrZTBQajMxSmpnV01ib3hZbVRTYnZaY1cyeGswSlVXTGRa?=
 =?utf-8?B?dElUSnRSTUVDNHN0UkVieHd2NEVyZE1WUG1pV0d2YjJPeTVTQTBpTXluVUp2?=
 =?utf-8?B?anZvamh0SjAxaDBsZFZ6RXRuRlRtNU5uS3M3cjlMeThza0JjaEtKSkpvU24r?=
 =?utf-8?B?dWFFK0hFWDJLYUUxZWJKdS9udThZTHB6MUl5N2lGYVpPTlRGb2ttK0pXdnBR?=
 =?utf-8?B?UmpSeTBFVUk4VXdNdWdjdmpKVWNQT3Y0UThmWWwyWFhTc0c4U1huQ05NTEJB?=
 =?utf-8?B?NWZDNWhHN3dzQjlib1pFZWQ5UDhzOXo1Ky9mNTBtbkhSY2srajBhS1oxbmdi?=
 =?utf-8?B?aU1yTmVzdllTcVV5ekQ3TUFQVkNXeE1zSHBqM1Y3VUhSWXVCWmx3TlVlMmlr?=
 =?utf-8?B?QWlhM0x4ZEFMSVc0QzV3bE52aUNBL2xnNzBrSHdBMFpIMWwvUnY2ZHI1UjVY?=
 =?utf-8?B?UHliVk1aNUxoZjVpME9SNzEvWTFzRFlXVDdDTDZjSVBVTXpSVk9VUklLdkxi?=
 =?utf-8?B?TWg5L1JDaS9mdDJCK1JFdHAzdXY3TERrMEVoajNEMVFLZzE1THlkZGdCWHdU?=
 =?utf-8?B?c1REWDY0bFJ2aGVPTXFhaUZ6VjB3VitRbjc2TEozL3Rrb1ZXYm13OFdIRlRR?=
 =?utf-8?B?Y2lJcC81WWNMZHBETWxFQVhkSy9xNFZYS2NXQ2ZVRHh2aGF5cXJldlo1T1hM?=
 =?utf-8?B?ck4vNW0xQlF1SFgwL2lqeHpzeDdVV2dnam1aQmtObUk3dWdkV3BHTW9PUjhL?=
 =?utf-8?B?Q3FmVjZnbW8vbmN1ZTJWYmdGbUZKWGlWUGdmcmZYREZNUFkrK0JTS1lrNHdu?=
 =?utf-8?B?UHplWmlwM3BrLzNOWStWZ1lyNmRzd1dIR3ZSRnRPcXZ2R0Zzak1TWnpTcHZH?=
 =?utf-8?B?NmVQai9hbTZrajJDbUwza2pYQlJnK2Z5ZUpIS1ZkcVk1TEVqdnNoOFJGZU5h?=
 =?utf-8?B?T09rN3hpODRSVWNzeFhRUjN1RmdWYzRnL0JCNVJCUUxKMFZvMUZmU1NSTFJ5?=
 =?utf-8?B?dk4wZVc0Q2xybjVDSVU2am9EWEkyd2txRTMxb1BJYkQ2ZHlvR2x3TzVaMGdM?=
 =?utf-8?B?d3QzOGtvUXZ6a0RPK0VTa2diMkhMdlhwMjNVK2tsWnpTNmtIK3ZPNGE0RG1a?=
 =?utf-8?B?a3NJazlzOHpmb1J1c2FGVlFVZFd5MTR0MWZ1MjhJUXhDRk0rUDUrUVdYZzVt?=
 =?utf-8?B?RzhUblljVktuNVhjY2JCQWpUZEdlRkkvaTZQZ2FaTm93M3ZxQU9ERVdFU2FY?=
 =?utf-8?Q?hOcCbAiifv4U4pw0w1AxBA2bb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1629E2400D15104BBE4D2B692AEF143E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OUNERGkxdnlnMXIzTWwwZ3pWaDZZWUdFbDltTVIzYUgwU2pTR1pGSUhoakQw?=
 =?utf-8?B?L1gzV29CTVRRbXRDQWwzTHJ4N3MrVGpIK1lSc2ZIUWZUakhDQ0k4a0tYdW9q?=
 =?utf-8?B?SkpQRWJTWml6cGl4bktSL0h4RDdySmZNQXlTSERRUXNtZUltMllzWEl1ODR5?=
 =?utf-8?B?OG5OQmdubGMrdVRoZlJ4a3dCa2JXdWNnRHFmNjgrci9zZFA1QlcyMWFLSEtP?=
 =?utf-8?B?eWFKc1pLQXpLdnNTeXRzV2dhUWhJTWUzVnZUeGNpdm9UZ3JpV2F1cUJIelpn?=
 =?utf-8?B?c3RNbWNxSktmdGxqRU5WQWYweWlhbkxlQTZGcGkrTkl0Tmt4VThmU3ZvbXVy?=
 =?utf-8?B?UlBTV2Y0N2ZEaGdqQTlmOVpMb2NwMVg0a21VWitNUnRzYnNSUXZkWDBtUjdM?=
 =?utf-8?B?Rk1JMlo3UE9od2xUZWdpSGdjaUE5aGgzWm9OVVVCZE1tZS8wTkQzUlo1VFh4?=
 =?utf-8?B?L1QxUng4YmVkcjZ3dkdkYzNNRVlPS2lTeVRrTisvNU9nNGN0TG5JcUFmbHh1?=
 =?utf-8?B?WHpkMHA4eU5SekRjclRpdTdvaWxpMlR4WUU4T0ZWU0pyTTI0dU5jRkdqZlJT?=
 =?utf-8?B?RVcwdVMzc3FtZWd3RURQcGp6MTRLTXdZMldQT3I2aVRzM2Y1K0h6MCtSa3kr?=
 =?utf-8?B?eFZ0cXFSMXhYRUgrRGJCamV0QUlYVUhJTnJ2K2ZKRWQ3N0hSWURBRG1vaUJn?=
 =?utf-8?B?SWwvaCtSYXFNcHYxOXBjaUdnN29zaHFXNW5vYlZSK0dOY29SLzZPVlNtRWw0?=
 =?utf-8?B?QTBXanNJZU5TNHFYdHlkNWY4OW1tWStZbVZtZkZja2gxOFhDdXFQbDFlbmtC?=
 =?utf-8?B?Q245QmZDVTFnVmJNRnhuVkovQjZuNkZ5UnJCMHdTLzI1QnkyZ2xjYmVQSGxa?=
 =?utf-8?B?YUtuMG5DR3B1aFhUTXJldjBJWVlDaTJkQy9XanorYWFZTDE3c1pIZFBLeG1R?=
 =?utf-8?B?WE9YK254WXprVjduUTJrbGkxQjZUc1NXbTNzeExrcFpOM05RRERKWSszcUJh?=
 =?utf-8?B?Sk5BRy9uaGloOUZZeUVibWRyWTRDNk5EbTg4K3hPWjZ0QTlHZzNxS29CRnpV?=
 =?utf-8?B?ZTUrMUxlVEtKYlBEenhFT0UwYVdkeUxxWlhVd1RqK1B4QS9VYjdEcitmWkFQ?=
 =?utf-8?B?VkZ5RGZUTEttNkFlV2sydmNwQ0UwN1VkRmtFQmRYOVFYeWxxRkhDME05R2Nn?=
 =?utf-8?B?ZkdPQ0FJMTdHOUFiZ3dhUEZlTlE2OXZZOCtzT3Q3M0hPdGh2cmh2U0ZWSG5M?=
 =?utf-8?B?eXBDdlhNbHBvd2o1NElxSWxuQTR4OTFnWXdha2ovdndKOXh5S0NtV3h0Ynha?=
 =?utf-8?B?NVg5T3dkN1lWWSttSE5WRmpqK0VKRnloUnVhTGJqRjE0MnBsS3VKbmpXZTVt?=
 =?utf-8?Q?S7fxC6Iwb3CH3qFswjl8fBrLMvi+j09s=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68e4e03-c80a-4ff2-b70d-08dacd40c4e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 10:52:09.0514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jHQyuuteqTNjA6qi6V44RvRCWJSmUuDKCsRynlvFQzwlDMT6QLQYZjAVEaNePbYgsDBKoMqdoSCinedx5kBGywqVaLxiGB3++4UMpazT/cM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6142
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMvMTEvMjAyMiAwODo1NSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9uIFR1ZSwgTm92
IDIyLCAyMDIyIGF0IDA1OjIzOjUwUE0gLTA4MDAsIEpvc2ggUG9pbWJvZXVmIHdyb3RlOg0KPj4g
T24gVHVlLCBOb3YgMjIsIDIwMjIgYXQgMDk6MzU6MTdBTSArMDEwMCwgUGV0ZXIgWmlqbHN0cmEg
d3JvdGU6DQo+Pj4gT24gTW9uLCBOb3YgMjEsIDIwMjIgYXQgMDk6MTY6MDVQTSAtMDgwMCwgSm9z
aCBQb2ltYm9ldWYgd3JvdGU6DQo+Pj4NCj4+Pj4gSXQncyBjb21wbGFpbmluZyBhYm91dCBhbiB1
bnJlYWNoYWJsZSBpbnN0cnVjdGlvbiBhZnRlciBhIGNhbGwgdG8NCj4+Pj4gYXJjaF9jcHVfaWRs
ZV9kZWFkKCkuICBJbiB0aGlzIGNhc2Ugb2JqdG9vbCBkZXRlY3RzIHRoZSBmYWN0DQo+Pj4+IGFy
Y2hfY3B1X2lkbGVfZGVhZCgpIGRvZXNuJ3QgcmV0dXJuIGR1ZSB0byBpdHMgY2FsbCB0byB0aGUN
Cj4+Pj4gbm9uLUNPTkZJR19TTVAgdmVyc2lvbiBvZiBwbGF5X2RlYWQoKS4gIEJ1dCBHQ0MgaGFz
IG5vIHdheSBvZiBkZXRlY3RpbmcNCj4+Pj4gdGhhdCBiZWNhdXNlIHRoZSBjYWxsZXIgaXMgaW4g
YW5vdGhlciB0cmFuc2xhdGlvbiB1bml0Lg0KPj4+Pg0KPj4+PiBBcyBmYXIgYXMgSSBjYW4gdGVs
bCwgdGhhdCBmdW5jdGlvbiBzaG91bGQgbmV2ZXIgcmV0dXJuLiAgVGhvdWdoIGl0DQo+Pj4+IHNl
ZW1zIHRvIGhhdmUgc29tZSBkdWJpb3VzIHNlbWFudGljcyAoc2VlIHhlbl9wdl9wbGF5X2RlYWQo
KSBmb3INCj4+Pj4gZXhhbXBsZSwgd2hpY2ggKmRvZXMqIHNlZW0gdG8gcmV0dXJuPykuICBJJ20g
dGhpbmtpbmcgaXQgd291bGQgYmUgYW4NCj4+Pj4gaW1wcm92ZW1lbnQgdG8gZW5mb3JjZSB0aGF0
IG5vcmV0dXJuIGJlaGF2aW9yIGFjcm9zcyBhbGwgYXJjaGVzIGFuZA0KPj4+PiBwbGF0Zm9ybXMs
IHNwcmlua2xpbmcgX19ub3JldHVybiBhbmQgQlVHKCkgb24gYXJjaF9jcHVfaWRsZV9kZWFkKCkg
YW5kDQo+Pj4+IG1heWJlIHNvbWUgb2YgaXQgY2FsbGVlcywgd2hlcmUgbmVlZGVkLg0KPj4+Pg0K
Pj4+PiBQZXRlciwgd2hhdCBkbyB5b3UgdGhpbms/ICBJIGNvdWxkIGF0dGVtcHQgYSBwYXRjaC4N
Cj4+PiBJJ20gdGhpbmtpbmcgdGhlIFhlbiBjYXNlIG1ha2VzIGFsbCB0aGlzIHJlYWxseSByYXRo
ZXIgZGlmZmljdWx0IDovDQo+Pj4NCj4+PiBXaGlsZSBub3JtYWxseSBhIENQVSBpcyBicm91Z2h0
IHVwIHRocm91Z2ggYSB0cmFtcG9saW5lLCBYZW4gc2VlbXMgdG8NCj4+PiBoYXZlIGltcGxlbWVu
dGVkIGl0IGJ5IHNpbXBseSByZXR1cm5pbmcgZnJvbSBwbGF5X2RlYWQoKSwgYW5kIGFmYWljdA0K
Pj4+IHRoYXQgaXMgYWN0dWFsbHkgYSB2YWxpZCB3YXkgdG8gZ28gYWJvdXQgZG9pbmcgaXQuDQo+
PiBvX08NCj4+DQo+PiBIb3cgdGhlIEAjJCUgaXMgdGhhdCBhIHZhbGlkIHdheSBvZiBkb2luZyBp
dD8gIFdoeSBub3QganVzdCBkbyBpdCB0aGUNCj4+IG5vcm1hbCB3YXk/DQo+IFdlbGwsIGlmIHlv
dSByZXR1cm4gZnJvbSBhcmNoX2NwdV9pZGxlX2RlYWQoKSB5b3UncmUgYmFjayBpbiB0aGUgaWRs
ZQ0KPiBsb29wIC0tIGV4YWN0bHkgd2hlcmUgeW91IHdvdWxkIGJlIGlmIHlvdSB3ZXJlIHRvIGJv
b3RzdHJhcCB0aGUgd2hvbGUNCj4gQ1BVIC0tIHByb3ZpZGVkIHlvdSBoYXZlIGl0IHJlbWVtYmVy
IHRoZSB3aG9sZSBzdGF0ZSAoZWFzaWVyIHdpdGggYQ0KPiB2Q1BVKS4NCj4NCj4gQnV0IG1heWJl
IEknbSBtaXNzaW5nIHNvbWV0aGluZywgbGV0cyBhZGQgWGVuIGZvbGtzIG9uLg0KDQpDYWxsaW5n
IFZDUFVPUF9kb3duIG9uIG9uZXNlbGYgYWx3YXlzIHN1Y2NlZWRzLCBidXQgYWxsIGl0IGRvZXMg
aXMNCmRlc2NoZWR1bGUgdGhlIHZDUFUuDQoNCkl0IGNhbiBiZSB1bmRvbmUgYXQgYSBsYXRlciBw
b2ludCBieSBhIGRpZmZlcmVudCB2Y3B1IGlzc3VpbmcgVkNQVU9QX3VwDQphZ2FpbnN0IHRoZSBw
cmV2aW91c2x5LWRvd25lZCBDUFUsIGF0IHdoaWNoIHBvaW50IHRoZSB2Q1BVIGdldHMgcmVzY2hl
ZHVsZWQuDQoNClRoaXMgaXMgd2h5IHRoZSBWQ1BVT1BfZG93biBoeXBlcmNhbGwgcmV0dXJucyBu
b3JtYWxseS7CoCBBbGwgc3RhdGUNCnJlYWxseSBpcyBpbnRhY3QuDQoNCkFzIGZvciB3aGF0IExp
bnV4IGRvZXMsIHRoaXMgaXMgaG93IHhlbl9wdl9jcHVfdXAoKSBjdXJyZW50bHkgYmVoYXZlcy7C
oA0KSWYgeW91IHdhbnQgdG8gbWFrZSBYZW4gYmVoYXZlIG1vcmUgZXZlcnl0aGluZyBlbHNlLCB0
aGVuIGJ1ZyBhIEJVRygpDQphZnRlciBWQ1BVT1BfZG93biwgYW5kIGFkanVzdCB4ZW5fcHZfY3B1
X3VwKCkgdG8gc2tpcCBpdHMgaW5pdGlhbGlzZWQNCmNoZWNrIGFuZCBhbHdheXMgdXNlIFZDUFVP
UF9pbml0aWFsaXNlIHRvIGJyaW5nIHRoZSB2Q1BVIGJhY2sgb25saW5lLg0KDQp+QW5kcmV3DQo=
