Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77F763FC85
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiLBAIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiLBAIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:08:31 -0500
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E28D2651
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669939709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5x51En4gal3dcmCDOeOiVOisHhFbtJaX3ZkPBBa86tU=;
  b=TG/DWgAsvq4uqlF5CP+Qfiou/H47Kj7kwDSgnKY5udp6nvYVB9q2fsQ7
   bZcYeomNqYvLxi9OWMMSop0HwssqfxQqZ8omIzLYw2wytiOjeNo8Onex0
   alKcXu4VSNf9WqHy82RmKhZl4zRGGKqsknJ97B1sUmJV+kAk15qu405UK
   M=;
X-IronPort-RemoteIP: 104.47.59.170
X-IronPort-MID: 85186187
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:/9uY4KgidvPXxgjjLQ5sSDauX161EBAKZh0ujC45NGQN5FlHY01je
 htvD2GDOfeLZWv8ct9/aNy3p0NT7JTcnNFqTwdkqiwzQS4b9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmUpH1QMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsy+qWs0N8klgZmP6oS5geHzyJ94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQ6GAgucUmzhti1g7LkSOtFl4Mbb9bSadZ3VnFIlVk1DN4AaLWaGeDmwIEd2z09wMdTAfzZe
 swVLyJ1awjNaAFOPVFRD48imOCvhT/0dDgwRFC9/PJrpTSMilEgluGyaLI5efTTLSlRtm+eq
 njL4CLSBRYCOcbE4TGE7mitlqnEmiaTtIc6RODhpqAz0AL7Kmo7AgAuflegrf+DmmWZee0Be
 1cw5Sotov1nnKCsZpynN/Gim1afsxcaWdF4HOo95wWAjKHT5m6xGmcAXhZFado7qNUxQz06k
 FOE9/vsBDpgt5WPRH6d/6vSpjS3UQAfNUcLYS4JS1tD79SLiI06kB+JTt9lC6Ozptn0Hyzgh
 TGMsCU6wb4UiKYjx/Xl1VPKmTShot7OVAFdzgXPV0q3/x9+fsiuYInAwVza6+tQaYWUVF+Mu
 FAalMWEquMDF5eAkGqKWuplNL6x5v2ONzndqV9gFp0g/nKm/HvLVZ5T/SN4KVtyGtwJdT/gf
 AnYvgY5zIdZO324bKl2S5i8B8Qj0e7rEtGNfuzUad9Hed51eQmL9SptdGaZ2myrm08p+YkkJ
 Z6RdcuEE3kXE+JkwSCwSuN17FMw7iU3xGeWSZWlyR2iiOCafCTMFu9DN0aSZOck6q/CuB/S7
 9tUK8qNzVNYTfH6ZS7Ut4UUKDjmMEQGOHw/kOQPHsbrH+asMDhJ5yP5qV/5R7FYog==
IronPort-HdrOrdr: A9a23:D8AEbK+HikDkYV5zfdxuk+DsI+orL9Y04lQ7vn2ZKCYlFfBw8v
 rEoB1173HJYVoqOU3I5+rwWpVoMEmskaJdxpJUB7ukUU3NuWOuK41mhLGSpQEIcheWnoJgPM
 FbE5SWJ+eeMbEQt7ee3ODXKadC/DHOmJrDuQ+Vp00BcT1X
X-IronPort-AV: E=Sophos;i="5.96,210,1665460800"; 
   d="scan'208";a="85186187"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Dec 2022 19:08:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hf2GLHsbwKuZNYR0l4TskuVf/Jg+E4BP4kSzI4pOHJmPD2k4L1CIAYwQ//nUJZFidGxj5iVbgs8A0HnJmZWe+UYoyuBVO5BNgJooCwreagxmVd+t77taiCHM27dAKP9TFyV6kPC7M3dfX+HN7UU8g6izq6QHVV/7Q/1unmIxmwvTQCTmoRUsi5Hnq8yYdncTuihRN956FIQesvyCvaOPj2xgBgRACAIQvMsamZKTjxkLN6vfkWTrRzv2uSgCmlVSmCqCxwkwzpY7tiFJNJePU+rRCYA6wJfqSPFB1Eu6EuMsizAHGhvVyKpdC0vHgGiLS6DZ8XSr+Xn56bprzkzrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5x51En4gal3dcmCDOeOiVOisHhFbtJaX3ZkPBBa86tU=;
 b=cxM+5fPt3dmKqGgiC7czx8tTiFSufUwQFmxYfRIiKZGqC1+AAlTPDht6e774XSJNyqbownxLcEgTIH4Ra/HkiS0zwuepiqYy4ougqqK9nAlUJWV/uRyApqb8QJBKdGUJ4M2iB8D26u3qX8CM4XrclTDpWuEl9yTo4e4DQdTtMvw125TCPSOlpKUO7e+rSUUVzMbfApBVC8En1t/sa02XTsxdvqgUJlgppd4CuwMmr1vpmHUbLZ4USSMgR/Js0n/MeFytNdH6my8M1nCRDXv8wFNVCUNz9X+gfBFteR/WCB110bJ10DQwOxR/eD/QYBN/N548gsQnn+krYDCytts7SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x51En4gal3dcmCDOeOiVOisHhFbtJaX3ZkPBBa86tU=;
 b=d4siaZnMZeFDS4f5zhaKwmpG/adfOLWrEkiEtd3Jz/dPf0S44Z4fEv9kGsq7WeOQvF+t9DsvY3yA+/rAZwRnYk9yWmuS2jDi4imxrVFw8wOCXwg+0sYg2lx7WUbyXOfvDK4pj+So9deW40x2kF/+BVik1vu9k1rRNYrYw/A441I=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BY5PR03MB5249.namprd03.prod.outlook.com (2603:10b6:a03:21b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 00:08:23 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19%6]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 00:08:22 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "stable@vger.kernel" <stable@vger.kernel>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH v4 2/4] x86/virt: Force GIF=1 prior to disabling SVM (for
 reboot flows)
Thread-Topic: [PATCH v4 2/4] x86/virt: Force GIF=1 prior to disabling SVM (for
 reboot flows)
Thread-Index: AQHZBRSlQ6ziLMSnBECHQCRKgANk165Zo1EAgAAE8gCAABH0AA==
Date:   Fri, 2 Dec 2022 00:08:22 +0000
Message-ID: <e3016964-f1d5-f064-134e-d9e00531bdce@citrix.com>
References: <20221130233650.1404148-1-seanjc@google.com>
 <20221130233650.1404148-3-seanjc@google.com>
 <eb226c49-9da3-ae11-071b-5474c2b64364@citrix.com>
 <Y4ky5hFWvSc8Km78@google.com>
In-Reply-To: <Y4ky5hFWvSc8Km78@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|BY5PR03MB5249:EE_
x-ms-office365-filtering-correlation-id: d279b440-1abd-41cc-274d-08dad3f95388
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73vFgOoEk9tZis6URO7wCzsHV2oqNVz7cfNZ+nj2F9OzyjiLWb1ysRhiVV3oaxGG1+2qty8lsblpFhzDJiNKaeslptWphSorDyw0H37hQa4A071/zrvYhA95VvWup6Eh76lkEBUjgCROgU5aJ90ZkR0c8pPCvJQH7mzdaYRyj4V7zYEnGHdjHlXCgjv6kv7AYv8AxYBrsQaUxjvukMZegYEXMYrcY4CNuiqEOOjTzVXqM5ewb/U0rwZf9mNRCmZWKcL/kdykOpMKHkeqhQ5xY7XTfSmlHASNx4kZKeRF10iekN8eujUhX6MlHc9HNAnqJiAnCMZhXzk6J/2xQOvX172/FDeoEHuij4iqwrY6A1AU0ihwKyaKqKig9Un9nFwYuthSdJZYLmlB4E3XnrBRsSZEPA7NJ5lAtvmRa5HucfTMnYEH1dgibNmDDtBuJqP83aCfEWITyCYm2+p5MDvBVW6yRYuGET2y40ItREzOelUTxVUwBOWo/X1Oyn2t6Bh/64jgzQoNC4GDwiLqT4Yz9sj1vnvV/JuRzUZvbFJxESUABz8YYJeTmKGF+jlHHsq4Ix6xqhmIR3Bh+DzHdh06a1xFi7hFkVocTHI79xz6lEe0fBi3K1hLEUA6xn4PL/igo6ij2qfAb6ELfsgO57xPEmZCRc0kiYmrl8yk6UfcJxlFnkEtcVdVs5qpRZVmXuVOdrEGDyRdNI/11QyNchfBchdJbs0z1OLvxm+fGuwXIuk6cIejEuLzHNgOMoMUJnTLxvA1BAmNdZx6OUlhedzX4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(478600001)(38070700005)(31686004)(107886003)(38100700002)(31696002)(71200400001)(82960400001)(6506007)(6486002)(86362001)(53546011)(6916009)(2906002)(54906003)(8936002)(316002)(6512007)(26005)(122000001)(186003)(36756003)(41300700001)(66899015)(76116006)(66446008)(66946007)(66556008)(4326008)(64756008)(8676002)(66476007)(2616005)(7416002)(91956017)(5660300002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVBaZDU4bnFCNTEwRlkxYlIyNnk1MnJTL3hnQXNXcFV1OFhQRktEUW94RHpq?=
 =?utf-8?B?eERSajN5SFh0RFF5VTV2aWMzMTJWa3IyS1dqclp4UmQ0dUxQcHFpRXE2djlz?=
 =?utf-8?B?NlhsR1pQeVBsdHppblFlaEJIWkJ5Tm1wdC94N3ZXaFd1MVhUUFJvaEEwdDI2?=
 =?utf-8?B?NU43dzEwa0JMWEpaSGduNER4Um40YitUQ2d2Q0lOSlk1NUpLWVhmOEJGTlR5?=
 =?utf-8?B?WTNHYlhlSVR0azVYNkNxaW5VMGRlWVRleEFBeXRaelk4SkJZZmpOTHBnV0ty?=
 =?utf-8?B?S0xrYzZtc0hsT3hJMDdsQkJlNVdYZGg0SXVFRTgrQjV0TnAzK0xsb1IyemVs?=
 =?utf-8?B?VEpKdHdURUpWenpHdTVUU1lSTEhwTDJjTThQYURKMFdWclN6S1FRZjRWeGZT?=
 =?utf-8?B?aHdoZVhLZDdsQW10ejhaRm5uVmJqREVQcFlFblhicHhGcWFWVmlyTTZmSWNv?=
 =?utf-8?B?aHlwRzNwRDFPelQxVW5DSXl2Y1FneisyaEFSTHAzVFZrZTc1N1pMbTRLeWdN?=
 =?utf-8?B?aE1zQnhKdk9ZZ0JzZWJGQitiR3NKMGJNM2M5TFZIQndNdGlXMUhYbSs5bFJ2?=
 =?utf-8?B?bkJqb2JOY1FBWEVSQzl2SEdqMFBCU1k3ZzN4VzF1Tkc5RmZpRkNvVDRZRE5y?=
 =?utf-8?B?UTFPQXM5bW5MRVZYMmhCM0l0RFZMcGFLOVZBbWVDdUYrRjN4eXNDWk5SRGN3?=
 =?utf-8?B?UHJ1eUJpWTJaWGljOExMNzBkVmhGN2xVczl4SGZSVW5PcXZtcjRrU2NUZ2hv?=
 =?utf-8?B?bGhXWG1EaW5nNFhwaUVqSGdTUFJGbStRMm1YL3dET1NSWkhLRlpzbmd6djRH?=
 =?utf-8?B?WjJsK3BPWHVSMWFPT1NwNmVTU0xhU09TOHVTMTY5dmxUNkJxQXRleitML0Mw?=
 =?utf-8?B?YXpMRWt4M3YwK3FYazdMQk9meUlCTGYrNHNVcDE1djdFaWdCVVdESjVvVGpj?=
 =?utf-8?B?ZmpidE9tVkt5cEE5Rk83RHlEQWRuOHhWVkUvVEd6YW1VZkxQY1BXbjZCREZr?=
 =?utf-8?B?VmNwSzJGSE4xbUNGUGxSN2tHc05wVXZVNSt0VGJjNG5kSHVzT095c2VReUFw?=
 =?utf-8?B?RGpzRExWb0tIdDBZOC84S1dlaVQzSkY3VUFlYytLSGwxbE1YTE51OTBvMlBS?=
 =?utf-8?B?eS8wY1hQNGF3bGZNN2VNcEVBMWpld2I0YlV2OElOVis2TkxRRFdWYlJCQ3RK?=
 =?utf-8?B?ZWdPVFJLdzRLdC9HVjFWTUhTTWxWOGpmK1hIQ1FOMXQzQzRZNy93OXNRaElZ?=
 =?utf-8?B?REpuTmM4RExXUFJub0VZTXA2d2tVSUtOdHBlcllYQ3lTQmJQU3g4R0ozZ0Vo?=
 =?utf-8?B?dFFXYUFjNFhJbnhISVRKRGorQUFudmxvbUJGNllFdjlmNG4zMHd0RnJidXlO?=
 =?utf-8?B?OHBOeHI0TG11WWNXUDRNQnZpYXptWEFSNC82RkxJbjlYa2poM3dmZTIyRnJ5?=
 =?utf-8?B?bDA5akxyOWpUaUtIYXhaWEhpam96YUZtblIxeVZMQThmU1ZTaHhXcDZndExo?=
 =?utf-8?B?cjYrRDdWZXV4c0t1NnoxeXNPaHZNNk80bmdHbGRNak1uS3VNK29oQmZTdkNF?=
 =?utf-8?B?bjJWeDJLc2ZFSTl1ditoQXZ4M1lBdU1QREhDRjQ1ZmthdGpjc0hGRkRsS3dk?=
 =?utf-8?B?T0pJbVg3MVUyUmVpTE1PT1Y5QmVra3YxWlhVOUpHN3BFb01UZmJ5YWd3YXc5?=
 =?utf-8?B?Y0tYbThhMnB3MlVvaGFDZUdhK09OMm9hZ0M4bFZ1Q3FBWFF1VHlWT1ZSVDc5?=
 =?utf-8?B?K3djdEg2R1I3b1dIM0Nob09iUW9FaFJ5Mk00cENZeEErSkJuZFNpWFNSYjc3?=
 =?utf-8?B?TStsRUVYeDlZdDdRZlNPWVJOcHZSSGk5emxNUk5qd1oxNGlqbENJZWdieVAw?=
 =?utf-8?B?dmRZNTZ0NTNqQ0NQbEh1MkUvbFNhT1BoblgvLzk0b2JPWFlzelA2bXhRSVJ3?=
 =?utf-8?B?bUpuaGdTUEkzZkRyQzFmV2NiR01SMm1FN29Rc2dDTVBSbVdNaTJiaW9QYWpt?=
 =?utf-8?B?S2lDa1dyVTJ2Nm1CdnI4eGdxNjYrcjc4bzN1VjNoSDdVVDB3ZE41Qlc3bW9C?=
 =?utf-8?B?aHkwODVsL1Brd0J5ay9PRzZIcm15T3NpZm5pN3BsRW5ndlIrcVhOUms5UWFB?=
 =?utf-8?Q?WAfuBmeF+VTT3oaVsYYMrojWq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F0BA12F1AE5E546B606AE415C73C24D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZTJDL09kdXpkQTNmNDI2dGU5bDQ3RHRxc1BKRUFzN0RrbVBiQ1pESTd6UlJp?=
 =?utf-8?B?enlHMUVGbGY2b3JNaFY1U3IzLzYydUtHMG9XOVpicTdGeHNlZmtSLzQ5WS9j?=
 =?utf-8?B?M0h1bzk3eG0weTAxT25hTXNoZUY2Y1BnMm9TUjJ0Y1doQUVBNkVqUldodFFq?=
 =?utf-8?B?MDBRdGNEZFFKbDE0QkZrelVZbzJLTGpxa1J2MmtReVowUmk2UVVhbEdsNHZz?=
 =?utf-8?B?eGFKMEI5TUtuQ1p1TStPNDNRYVpJNXhFd1Q3Sm5VTHpBM3J0cS9QTWdVeDZZ?=
 =?utf-8?B?YW9iVW9xWGhwM1NGRjlUeklscDdwdFVZeVRwdWgvSmYzWlVCRjN5aFRPbitQ?=
 =?utf-8?B?OGc1dDBsWlZ6Slp6ZjBDLzRjcmkxUnNoSm43TWV2b0lsbWxUdWdoeDlib0dJ?=
 =?utf-8?B?VTVxZDdPenNMWHMrSjNLWEUvd3JPUzRsbDdDempua2VzZThqRXl2UXkxUUxP?=
 =?utf-8?B?Q2g2SjBBMHgvTFRGS0JkYnA3SWRZZXROWDJzZ3E0cnE0Ti9RSm1ON1hyZTBs?=
 =?utf-8?B?N1grTTNxa24weXYvVmlYbHZ0RCtSVFdyeEpEKzM5L3lLZ1RoVmMwYmNkOEc3?=
 =?utf-8?B?cUlTZDM2cTMyTVFuVnZISUg3RThxb0VuekZpaEtmdTFLL2tpL3BxUGNscWVY?=
 =?utf-8?B?d3c5dDBYSU04WGRYa2RMK25lOU5Kc3FMMVNnbjVjcHF0bWV5S3pUbXlxTENh?=
 =?utf-8?B?RlJXQno1TFpBR2tZbGcvV2NVWm00L1ZOWVdkbjVKczNpeVBtNU5za096ZG1l?=
 =?utf-8?B?R3hyR2pkV0FxRVFRWVNrcGhNYkNsLzZUVGxsNE81dGFuWVpqUVJqa21zbml4?=
 =?utf-8?B?V0ZxMVdJbmJuaktObE5sYWYrclRLeHByTTNmYk1nRTdlRG92M2lqVysxYmJU?=
 =?utf-8?B?WDIwRi9xNEtxRERiTVh1NGphMnlaclpFQXFZRFNxRUY3cmErNVk1cWxWWDJv?=
 =?utf-8?B?WDJUY0Ywc3lDZ2NnV3d3aW5tRWlFM1JEdEtMbFNUVTBOUVlTMlpURWFDY2VN?=
 =?utf-8?B?K2JYNkdMMWhyU0Q1WlY0MmV2N3FmYmxjQlRkMlJ1aGNzTVFNZ3pvKzVITXhW?=
 =?utf-8?B?alBHV2lkU3JwR0Vab3I4U1NOTXdVMkFnZ0VNbTNmOUZjTExIbFJ5aWR6dTNm?=
 =?utf-8?B?azJPV3J4SHJkTmovMnZMLzRzSHlWZCtSQ29VWCtvNmQzMzJnTVR3R2NsWFRa?=
 =?utf-8?B?S1NJcy8wZzJPMStVUzJQUld5ak8rUUlBc3pFOFRvVXI2Z3ExUzkvRlNhaXUw?=
 =?utf-8?B?NTVsbE00Ylo1RFpKQmp2SHNMc0lZc1lyaEVGemVNUmhqeXJoVjVhVU1XR2Zn?=
 =?utf-8?B?VXNnTkdiMHc1RkRYanBLeDdMTDVtdFJ1UGRxLzVPaFdleEJQc2tvSjVhUzhs?=
 =?utf-8?B?VkV5R05jOEUrS0IrZ1lYc1djbHRhL0M5YTRYdVZPcTdNczZPaldPQnRrV0Vj?=
 =?utf-8?B?ZjJTQ3RZYlFWbkFCM1U5a1gxWFg1bkFqYkF1cTVna1hzMGh5QjBlc2Z1TXF4?=
 =?utf-8?Q?VljPMzjbbuhueCII8WTQUMuLY50?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d279b440-1abd-41cc-274d-08dad3f95388
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 00:08:22.7627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQ0ImKzTa8Hdc1vUeoJ+ncKNOI1xjSG0s7MdzvI69dhUxPwO4vESDpkoHBY4mf5Zt1760dz5saPbganwDREDLlAUiJ4pkMJrKFD//cv48Xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5249
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMTIvMjAyMiAyMzowNCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToNCj4gT24gVGh1
LCBEZWMgMDEsIDIwMjIsIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+PiBPbiAzMC8xMS8yMDIyIDIz
OjM2LCBTZWFuIENocmlzdG9waGVyc29uIHdyb3RlOg0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS92aXJ0ZXh0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92aXJ0ZXh0LmgN
Cj4+PiBpbmRleCA4NzU3MDc4ZDQ0NDIuLjBhY2IxNDgwNmE3NCAxMDA2NDQNCj4+PiAtLS0gYS9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS92aXJ0ZXh0LmgNCj4+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS92aXJ0ZXh0LmgNCj4+PiBAQCAtMTI2LDcgKzEyNiwxOCBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgY3B1X3N2bV9kaXNhYmxlKHZvaWQpDQo+Pj4gIA0KPj4+ICAJd3Jtc3JsKE1TUl9WTV9IU0FW
RV9QQSwgMCk7DQo+Pj4gIAlyZG1zcmwoTVNSX0VGRVIsIGVmZXIpOw0KPj4+IC0Jd3Jtc3JsKE1T
Ul9FRkVSLCBlZmVyICYgfkVGRVJfU1ZNRSk7DQo+Pj4gKwlpZiAoZWZlciAmIEVGRVJfU1ZNRSkg
ew0KPj4+ICsJCS8qDQo+Pj4gKwkJICogRm9yY2UgR0lGPTEgcHJpb3IgdG8gZGlzYWJsaW5nIFNW
TSwgZS5nLiB0byBlbnN1cmUgSU5JVCBhbmQNCj4+PiArCQkgKiBOTUkgYXJlbid0IGJsb2NrZWQu
ICBFYXQgZmF1bHRzIG9uIFNUR0ksIGFzIGl0ICNVRHMgaWYgU1ZNDQo+Pj4gKwkJICogaXNuJ3Qg
ZW5hYmxlZCBhbmQgU1ZNIGNhbiBiZSBkaXNhYmxlZCBieSBhbiBOTUkgY2FsbGJhY2suDQo+PiBJ
J2QgYmUgdGVtcHRlZCB0byB0d2VhayB0aGlzIGZvciBjbGFyaXR5Lg0KPj4NCj4+IEhvdyBhYm91
dCAiV2UgZG9uJ3Qga25vdyB0aGUgc3RhdGUgb2YgR0lGLCBhbmQgaWYgTk1JcyBhcmUgZW5hYmxl
ZCwNCj4+IHRoZXJlIGlzIGEgcmFjZSBjb25kaXRpb24gd2hlcmUgRUZFUi5TVk1FIGNhbiBiZSBj
bGVhcmVkIGJlaGluZCBvdXINCj4+IGJhY2suwqAgSWdub3JlICNVRCwgYW5kIGZvcmNlIEdJRj0x
IGluIGNhc2UgSU5JVC9OTUkgYXJlIGN1cnJlbnRseQ0KPj4gYmxvY2tlZC4iwqAgPw0KPj4NCj4+
IFRoZSBTVEdJIGNhbid0IGFjdHVhbGx5ICNVRCBvbiByZWFsIGhhcmR3YXJlLCBiZWNhdXNlIFNL
SU5JVCBhbmQgU1ZNDQo+PiBleGlzdCBpbiBpZGVudGljYWwgc2V0cyBvZiBwYXJ0cywgYnV0IGl0
IGNhbiAjVUQgaW4gcHJpbmNpcGxlIGluIGEgVk0NCj4+IHdoaWNoIGRvZXNuJ3Qgb2ZmZXIgZW11
bGF0ZSBTS0lOSVQuDQo+IEFoLCByaWdodCwgIm1heSAjVUQiLCBub3QgIndpbGwgI1VEIi4gIEFu
ZCBkZXNwaXRlIHdyaXRpbmcgdGhpcywgSSBhbHNvIGtlZXANCj4gZm9yZ2V0dGluZyB3aHkgZm9y
Y2luZyBHSUYgaXMgZXZlbiBuZWNlc3NhcnkuICBIb3cgYWJvdXQ/DQo+DQo+IAkJLyoNCj4gCQkg
KiBGb3JjZSBHSUY9MSBwcmlvciB0byBkaXNhYmxpbmcgU1ZNIHRvIGVuc3VyZSBJTklUIGFuZCBO
TUkNCj4gCQkgKiBhcmVuJ3QgYmxvY2tlZCwgZS5nLiBpZiBhIGZhdGFsIGVycm9yIG9jY3VycmVk
IGJldHdlZW4gQ0xHSQ0KPiAJCSAqIGFuZCBTVEdJLiAgTm90ZSwgU1RHSSBtYXkgI1VEIGlmIFNW
TSBpcyBkaXNhYmxlZCBmcm9tIE5NSQ0KPiAJCSAqIGNvbnRleHQgYmV0d2VlbiByZWFkaW5nIEVG
RVIgYW5kIGV4ZWN1dGluZyBTVEdJLiAgSW4gdGhhdA0KPiAJCSAqIGNhc2UsIEdJRiBtdXN0IGFs
cmVhZHkgYmUgc2V0LCBvdGhlcndpc2UgdGhlIE5NSSB3b3VsZCBoYXZlDQo+IAkJICogYmVlbiBi
bG9ja2VkLCBzbyBqdXN0IGVhdCB0aGUgZmF1bHQuDQo+IAkJICovDQoNCkxHVE0uDQoNCn5BbmRy
ZXcNCg==
