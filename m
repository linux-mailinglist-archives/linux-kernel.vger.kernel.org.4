Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FFA62A24E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiKOT6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKOT6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:58:40 -0500
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9DC13DF5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1668542318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J/H3jwZaX6Ossc7F37/9onHEdQi90kReutJVxvpr6og=;
  b=QzHk5Gjv4vqBJhbEFlFnuuFGGu6gceCs8BQXJWc0bMwYYc79oeATxJGo
   k7T+m83ecsab59EZJJG3z4wtq+pR+KwwD4hSRbkIwo3J0lE4WFTjZsg0u
   dHOLp7fM9Nu3ciB1fwl+t/kOLln8xV+ESMvDsl6F+ZunUPma+wxH8cbiU
   M=;
X-IronPort-RemoteIP: 104.47.73.48
X-IronPort-MID: 85312496
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:GkRp4a20PAt+A005zPbD5bZxkn2cJEfYwER7XKvMYLTBsI5bp2MPn
 TMXDTqHMvfbMWb2e9giOti390sHv8SGy98yTQI9pC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK5ULSfUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8tuTS9nuDgNyo4GlC5wVnOKgR1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfIXFts
 vxIcRk3YRW8u+KsmrOYFOJ3mZF2RCXrFNt3VnBI6xj8VapjbbWdBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxouC6PnGSd05C0WDbRUvWMSd9YgQCzo
 WXe8n6iKhobKMae2XyO9XfEaurnzX6gAdhORePQGvhCkBrQzUgUNjQtS1adpeLnm3G1VehzE
 hlBksYphe1onKCxdfHmUhS+onWssRkbVN5dVeY97Wml1qXQ8y6dB24ZUiRGbt028sM7LRQv1
 1mGmPvzCDBvuaHTQnWYnp+etRu7PSkYKz9EaSJsZQcM/dSloIg1lR/JZtJiFrOlyNzzBTz0h
 TuNqUAWl+VNpc0GzaO2+RbAmT3EjpjRRyYn9xnQRCSu6QYRTIqkYZG4rFvW9/BNKK6HQVSb+
 nsJgc6T6KYJF57lvCOVQe4GG7Woz/eKOTndiBhkGJxJ3yqu5mylcJxLyCtzKEdgLoAPfjqBS
 FfZvgVD5ZlSFGGnYa9+f8S6DMFC5bTgEtHsTbbQY9xCa5NyZSeO+S0obkmVt10Bi2ApmKA7f
 JueL8ClCC5GDbw9lGbmAeAAzbUs2yYyg3vJQoz2xAim1rzYY2OJTbACMx2FaeVRAL64nTg5O
 u13b6OioyizmsWnCsUL2eb/9Ww3EEU=
IronPort-HdrOrdr: A9a23:9p6JWqkUvK+eX8fnaPsSR+WOO1rpDfLa3DAbv31ZSRFFG/Fw9/
 rCoB3U73/JYVcqKRcdcLW7UpVoLkmyyXcY2+cs1PKZLWvbUQiTXeZfBOnZsl7d8kTFn4Yw6U
 4jSdkaNDSZNzNHZK3BkW2F+rgboeVu8MqT9JjjJ3UGd3AVV0m3hT0JezpyESdNNXl77YJSLu
 vk2iLezQDQBEj+aK6AdwE4dtmGnfLnvrT8byULAhY2gTP+8Q9BuNbBYmOlNg51aUI0/Ysf
X-IronPort-AV: E=Sophos;i="5.96,166,1665460800"; 
   d="scan'208";a="85312496"
Received: from mail-dm6nam04lp2048.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.48])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2022 14:58:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDAEfZ4Omae20LmQpoH+/oWABXaibwO5EYC1IsqiRR5iledvKUUQCWek5X0jQBTs/hZRt449cb5xR+uA61cioKXu7x8RJuqgejyDDNd6JJS1Y0yI8oRxsNRKEo3rLZeLLiK+j1+iQidUb0NNxyrHAV0B92is/Z9woJjVF0L8LThqTNI7cGOXIpdICVgxKdB8C6ojNfj02/6YTUsit1SspAW/ApOiUJYmFdaUJwodhuAkrJEhkuWU6EVFcl7B/MRJsdtENrjFRBROU8GvCrxMetcpSiH99tqbY6jbKswYaKjJV+bdZVSx8cHFwwqDiu3FuK7OVrnULuplknN69bqlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/H3jwZaX6Ossc7F37/9onHEdQi90kReutJVxvpr6og=;
 b=K7bOuR0enOeuiAKahodWthmrE5tLAp/wphuHvM2UAaBbjmz3+CXMq5u4wEx6VCi6fi6bMOCdf/CL+leAEC/WQmdsiOYNa8+qDJNuYRPzEdGRQpHhBPBDtJpOP2MfpftqSyxLFQyWy16AL5IviIVlr3nwzfVP3kgKDxxCPXGbdxog1iZ7VYYdsXhQBVH2igc0tbx/7q4XLmbA+h4sgOdxkFDNMf6Ku2LdApRV60s3xKrMOwgChmMbLhasDxnDgsZWfFx6MFwYGD4XE3QzBoSuNMGGK27naeYW2Z0cgG2crJOM+TuwUqcAjuA+9mVlfLYA0uR+RlN+Uy4SDBNF52TD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/H3jwZaX6Ossc7F37/9onHEdQi90kReutJVxvpr6og=;
 b=QMGBsMp6zXKk7XP8A5uh1Vy4ZU+3wNav0xYree29GVsoukNgC+WGmZrHuX/zYxGw1Gtpm18B0ew68ggO9rQFOA8SKVDbT7cITBOteLfhzs82rLdVysTOIVz2wjU7JofUj9s/sAPfrC7cc9Mh2AJ6+eloMxSmgM9eAKchjlgZIzw=
Received: from BN7PR03MB3618.namprd03.prod.outlook.com (2603:10b6:406:c3::27)
 by MW4PR03MB6866.namprd03.prod.outlook.com (2603:10b6:303:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 19:58:30 +0000
Received: from BN7PR03MB3618.namprd03.prod.outlook.com
 ([fe80::c98c:5b85:6d10:4860]) by BN7PR03MB3618.namprd03.prod.outlook.com
 ([fe80::c98c:5b85:6d10:4860%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 19:58:30 +0000
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
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH v3 0/3] x86/crash: Fix double NMI shootdown bug
Thread-Topic: [PATCH v3 0/3] x86/crash: Fix double NMI shootdown bug
Thread-Index: AQHY+Im7ciYkEgOFUE2qPpERc0b6Ba5ANViAgAAy2AA=
Date:   Tue, 15 Nov 2022 19:58:30 +0000
Message-ID: <df894605-d977-4ccd-ecff-7c0a8b369940@citrix.com>
References: <20221114233441.3895891-1-seanjc@google.com>
 <5b8787b8-16e9-13dc-7fca-0dc441d673f9@citrix.com>
 <Y3PEv9MmQ+y91Ir+@google.com>
In-Reply-To: <Y3PEv9MmQ+y91Ir+@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR03MB3618:EE_|MW4PR03MB6866:EE_
x-ms-office365-filtering-correlation-id: 8edddf56-b2a9-44f0-91a7-08dac743c4e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MwMuw4AOAhB/nT+TMJizSpTKhs3Q7Nj0wYv9hJQzwoF0oa3u09OLCtHEZfk6GEqfrLPqBpOEWPnAhEnFvd0piQwS5lgpIwL1RoZ9JDHndZc1noAKf/UYuYG2jKZmSN6hITGgZIxD+dTVdudkuTn5eT/8Hajdo/f3B3snxbJ3PYeUF4CIvGbwmnLJQJgpXaYV0Nvbd8KTIzFePmhfYHhEbWN35jk/LYI19KQn7BaUjGp7JiivXYH/1/OL/aJvzDzIqVJqmroG2mutz7i9ou4PZbnI5Bt3yzpgGi/Sc1s6yNDI/qPqAYiYgAqCuq9zJRCi8/UeX1mTvRIliPqpoNpBsaspTzk2TGl12LniHiLZyJOfwRki+8nFD2iidGp9PdBkIuDfDT2zGabYTZXqITLw1EFMKrvyF6pYyLPpqkGFfgixo6LRnKjL+3y2yGdIjIHjKloomXZyAwekuDB5w8Q6el/1iEMVZRz3U/j6pDHCuPmj6DtsJDzGg0hivJQcZrXoVAcs2V53zs6nsi85A/whBt2qax7bZ5nxc6VDX94XAvdaiaWcF5IA3NNbUpmyyqb29uc4HDtijkaG85Ioai5C+MGRPDbLoQqAPEt8+GhDYCtJa1ybre8k58D6APeImbB1hiM3rzgE5CR92XvDFSdhzI9WvLsS19vahglRCTg1tFIZBM+cplc4c2N0wBdC7cuYlg018fcr75Py1836qxo56+TPZVabLepCrZaMbQWtZM2A0Km01V4lLPMdFt0TWjIFi4+MsUJaIt2v4vBF5L8vSS5b4tUWRMRPVDCmUqQHo1NHfQTiv/TJ0y4xIDNOPmO8J8l+Kxs6AoVAOJpc0itDFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB3618.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(451199015)(66899015)(508600001)(26005)(2906002)(53546011)(6506007)(6512007)(31686004)(71200400001)(6486002)(107886003)(186003)(36756003)(91956017)(4326008)(8676002)(122000001)(66556008)(76116006)(66446008)(66946007)(66476007)(5660300002)(6916009)(54906003)(64756008)(7416002)(8936002)(83380400001)(86362001)(2616005)(31696002)(82960400001)(38070700005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cC92aEc2NW9JU3ZNWStwQ2F6S2tKVzNyWTN0bnZiVFVST3Zha0prMTVINWdv?=
 =?utf-8?B?TjJEaGVIVi9OejZJYWhDSXRlREpRT1QrdjIwRXFCWUUxSG1YMWZXOGp0b1hj?=
 =?utf-8?B?VUMzYy9DQU80WWR2cFZSTVlsKzBxbC9RWHFmeW8wcXpDaXF5bXIxbzdzMzFO?=
 =?utf-8?B?bUJ3eUkxUmlCWmNwaHBScU9RM21vMGFTNDNoRmNwU0dBU0JwMEg5RmgwbDNP?=
 =?utf-8?B?ZFZIWnQxWkNmVk5pd24xY3hseHZWU2xLN3RoN2pxS3l5RlRXaGk5N0x4MUN1?=
 =?utf-8?B?bUsrVHB6ZWFTMFNTNDVxRnlwQlhWdlRzM3cwWGlMczFvQkw2cGEzZmVyUU5O?=
 =?utf-8?B?a2UrZ1pYQTdkWFFVbncwZHl2ZnVrRUMydFBnditwMWN2UWZHRk1mVHcvcVhQ?=
 =?utf-8?B?MFBMSnlKME9pZWsvaDBpR1RwRVpiekRuMkpFQi9rcStDWTl1eXBqd2VnQk9y?=
 =?utf-8?B?WXFHaTlSK3ZNc1NzUFlDK1NHenFCQThMd3JqeFVJdGRhOUlJWkEvbDQ5cDFD?=
 =?utf-8?B?VUxqeTBEZkdXQ0FSQk9oYUpVb05tMjQ5OTZwc0RVd0Z0TXV4bytJMXhrb0tw?=
 =?utf-8?B?cFczTWJFRmlGQ05mZGxabVIva0x5Z1hVTXFYMEtIQU5BdjdULzl2cWxTL2Z4?=
 =?utf-8?B?UTcrdDkyendBOWFPVnNPOHd2ckZIdUN5M1BVZnk3V3czOXc2NWY3b0RTanR4?=
 =?utf-8?B?MHltem9samI3cGliZ1psQ0xzTHk4YitSS3RjWlIvV3BOMG1oWjBnNWpvK3dn?=
 =?utf-8?B?TXZGNHc1bUNBR0N6NHRMV1FJYmxTUFRKWDJzTDRVYW1Nb0VGRVduWEhydXM2?=
 =?utf-8?B?TWtNdjRBMW9vL2gzU003aGFtRjBibWhSZEdTZ0FOMFdqWXo4bkNDY2h4K0J2?=
 =?utf-8?B?SDVRVGlxc2hWL21aUWlGU3ROREZNZDBjMWZOdEJNN0hiT1BXMjNzbGFiSDVw?=
 =?utf-8?B?eUxKY09FbUNzSWRWMWxUbTFpd2l0REpvaEUyTG94ZVFZS0hWSGdGOFBpVCtK?=
 =?utf-8?B?MGdNVHNJSW5QM1Z2U1lOdU03ZVZ0RW5ESjFRSlgvMUZMTlRFdGZ4VlU3RzhY?=
 =?utf-8?B?Q3ZLdUxna282dkpjajEzL3BzYURoN3NHV1hyTE1XTFVpai96U1Bhb21Pandl?=
 =?utf-8?B?aUIveW5aQnZiMW5pUDRLOGJxNmpsQU9xUlhrNEVwdWxSWHBjWnFVNVQwN1Zy?=
 =?utf-8?B?bnA3MWFUTHZIWmF2bWR5RmFSSCtLNHQzbHppQUxIZExUdDdRekNrTjBQclF5?=
 =?utf-8?B?eWFza1RiOTZvZ2w0OVVlSFdQTm02WlVoZS80ZzkrVjQ0c3Q4eFpXOHJvYmN5?=
 =?utf-8?B?bFBVc2YzRDVNWjZodnh3c0pVWnJneXlYNnNYSGZweVFKSUJXVHRFNW84UnNI?=
 =?utf-8?B?akpTMWZzQkhPeDhLbEkwdFN6UWpCb21JWE9OaDBQU1pEdGc1ZXNCelZINUI0?=
 =?utf-8?B?L0JWemllS29JZlptWk9yemtSZkk0aXU3Y05FaWZJVGREQkk0amhmbjBhNkpW?=
 =?utf-8?B?bXRIWDJwSTJ2UlRLR0FEWHREdUxFOFE5OUozVUhxNVRTVUJSc3p6SzlGdzh0?=
 =?utf-8?B?Y1BzQmJyZ3YxQWNTYVFvSXo0SWZ2NlZOMzlpU3pTQ0I4M0NQV3pnNUp1WFhz?=
 =?utf-8?B?UStNWmx3VWlXRTNZNk82NE9yUUl4RnhUelBxRVVKQytJbkhHUWdJK2ZwdHV3?=
 =?utf-8?B?SG1JcXQ3UUNSSGNYSXdJU1MxVlk4ejQ1QWF1d2Y2UTF0UjE4NFFvUWlIRGhI?=
 =?utf-8?B?UEZiT3RCV0JZVWRyU0N6MW9Vd0lkQjB6YkNpSWtsQkk5cVpFeWY1MnlXWnVW?=
 =?utf-8?B?VUozUGRMTDNQRHlMUHFBNU4ySzB6bTZrNjN5RUJ1UFN3TEpWSk9Oa3YyeU1i?=
 =?utf-8?B?MzVsNFRLcDVnOXo0YnNvZGlsa1EwVDNjL0l4bUoyS0hMTmVYWVQrSXk3L0dC?=
 =?utf-8?B?VFYwUlY1ZThjNWVHY3M5b3NCY0JibGlaUC9DQTVOenlmYWQwa3Y2bFpJMWM4?=
 =?utf-8?B?OC9rd2xDdFh2SXdid24rUWdRUTBIdzF6V1JKTnlDUnZyL2tzaGhsMVFBR0w4?=
 =?utf-8?B?aEMwYXZtREpUTW9UU3BCM2Z5dktHTUVrdkQyQ2UyaVRkVHJPcXhPYlc0TE1S?=
 =?utf-8?Q?xdIRnSEeh9HPJlybM6z9mSVK0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08844BF7AC8A9743878BAC275640B7EE@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Mk1qUGF4RnBHZjZXN0RvUEZiR09jaW40KzVOYWUwQlZhUHFrVVE4MFVKazNH?=
 =?utf-8?B?Rmh3YWl3M1pLNHJCRC9xRjNDMFFwNXFwY3JDNmpvbXJoYXhCUjZXaE5rNGtL?=
 =?utf-8?B?ODRwTXQxTFBxMlpJWlJrOUN4VGxvTXF2eGd4UXNVN0tESUNHRDNvQVk1cmRS?=
 =?utf-8?B?WWFROGlmeUdOT2FHYVo2Zmp4WkN6VzZ0dC9UYlpPa0J4YXpvMWZIWms1STlj?=
 =?utf-8?B?czg4c09TQVFwWmdjUnZBNHpBeTVXUWpJMGZtNmdON3JFNnpMWHNzWndtZGNK?=
 =?utf-8?B?bFRUUlA4ZXZ2KzFnN1JxcUdKaHBjd0NSWERyV0k3eDlMckh6VGxCTnVENUZh?=
 =?utf-8?B?YTkweFNhdkhlblR4U0g5Z1VsRkNNbDE4d0haeXYyQzJzTEtHUkpKQTNrYnpP?=
 =?utf-8?B?Q0hKMXRrY2dSRzhEeE1LWm0vOThZeWJVdms5VHZaY2Rhc2RpajdzM0g4M1V2?=
 =?utf-8?B?b0RyR3haYmdaWW9RMzZOVVFaMk1hRHNFU1pkTWppbjB6c0U2bkJ3RzFJKzRV?=
 =?utf-8?B?VEJrQVV0U3J2TjRPUThoQ2VXZG0yazhLcGoybE5xeWpZL1BVWFV5Y0JXNkU4?=
 =?utf-8?B?N2FUQXpEU004czVqNldwTEw3UW9sTEFocDVzWVIxeWFMNFVhQ3lxaHptOEJQ?=
 =?utf-8?B?VzFlZFd2bmdBWUtxRVRteVJ2UmlGQjIvaUVGR1J2bGhFcFAxVFJ1QktCbGda?=
 =?utf-8?B?T1dYeU9mcmtQVlBzOWMxVXBFZHdTeDFZc2tzbFhMZ2d2Wk9QMnMvK1R3UXQr?=
 =?utf-8?B?aGU0SW1FenR2c2JuSW9SV241L1YxYTRkMm5BdU9zai9DSTg2KzNSazlxWmJF?=
 =?utf-8?B?NXJ1Y0x0VXc0TFNyRXdtejVTL2tXa2JteXAxSmk3RHFGTlByN1VsZUdhdkJG?=
 =?utf-8?B?WWNmemxQSmk1ZDAxUHRvUkxhM0VYc0FMaDk4LzZXWWpZNEZURVhqRm5wSTNZ?=
 =?utf-8?B?WWNnQ3oyUGNwdERTcmNsZHUwdE8rQjYvRHpTdElEZ0kvbWJBamdZYnNCNHo2?=
 =?utf-8?B?UjZSY2pGWG9GSWlkRmpDM1VsVFBEZTJPVXNqUVg1SG55MzBXc3lMN1dFYmdX?=
 =?utf-8?B?MTVnbWwrWWRWKzVpejRIQXE4d1Z4eVdQRlZ4U3lKdTdId3BIUDBaT2wzQ1dy?=
 =?utf-8?B?eWE3TzZLTHhyKytTL0lrZ2xycXAxQUxmVnQvZC9KL1kxWVlZS3FORWlMdTF5?=
 =?utf-8?B?OWJTUXliOHlrQWVyLzI3VlZjNXQ5akpXSzdQN1ZJZE1TbkRNU2lYamsvRnJm?=
 =?utf-8?B?SEE4VmNBdlFGaVhqVEwrSUlHMVFjVzAyZjZwOFpvcTlidDFtMlZsUWIrNlVS?=
 =?utf-8?B?R3VyQ2Fzdm5rNzdHQW5NSTZEODQ0OGorR1pCRmw5KzZ4TmdraU44TmpKYUgr?=
 =?utf-8?B?dVA1S3k1bk9hdUJhUGd5d25tNjhQeG5EN1J3YnBabTZLdWhrK2d5MDYwbytp?=
 =?utf-8?B?VlZBcnZvN0g0SGRxR3RBeld5RUtCTjV6cVh1RkNnPT0=?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3618.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edddf56-b2a9-44f0-91a7-08dac743c4e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 19:58:30.5731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKP9jAbv7MtElpxBZz0omtVbcZtCh6Fy/Ne/okO+Vtz+ZcBdxCPYUjZwkVqSy8eKmeDVIS4dpwlvsvp1CAKihcBXmXjTnQYQBBse8a+D8MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6866
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMTEvMjAyMiAxNjo1NiwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToNCj4gT24gVHVl
LCBOb3YgMTUsIDIwMjIsIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+PiBPbiAxNC8xMS8yMDIyIDIz
OjM0LCBTZWFuIENocmlzdG9waGVyc29uIHdyb3RlOg0KPj4+IFRvbSwNCj4+Pg0KPj4+IEkgQ2Mn
ZCB5b3UgdGhpcyB0aW1lIGFyb3VuZCBiZWNhdXNlIHRoZSBBUE0gZG9lc24ndCBleHBsaWNpdGx5
IHN0YXRlIHRoYXQNCj4+PiBHSUYgaXMgc2V0IHdoZW4gRUZFUi5TVk1FIGlzIGRpc2FibGVkLiAg
S1ZNJ3MgblNWTSBlbXVsYXRpb24gZG9lcyBzZXQgR0lGDQo+Pj4gaW4gdGhpcyBjYXNlLCBidXQg
aXQncyBub3QgY2xlYXIgd2hldGhlciBvciBub3QgS1ZNIGlzIG1ha2luZyB1cCBiZWhhdmlvci4N
Cj4+PiBJZiBjbGVhcmluZyBFRkVSLlNWTUUgZG9lc24ndCBzZXQgR0lGLCB0aGVuIHBhdGNoIDEg
bmVlZHMgdG8gYmUgbW9kaWZpZWQNCj4+PiB0byB0cnkgU1RHSSBiZWZvcmUgY2xlYXJpbmcgRUZF
Ui5TVk1FLCBlLmcuIGlmIGEgY3Jhc2ggaXMgaW5pdGlhdGVkIGZyb20NCj4+PiBLVk0gYmV0d2Vl
biBDTEdJIGFuZCBTVEdJLiAgUmVzcG9uZGluZyBDUFVzIGFyZSAic2FmZSIgYmVjYXVzZSBHSUY9
MCBhbHNvDQo+Pj4gYmxvY2tzIE5NSXMsIGJ1dCB0aGUgaW5pdGlhdGluZyBDUFUgbWlnaHQgbGVh
dmUgR0lGPTAgd2hlbiBqdW1waW5nIGludG8NCj4+PiB0aGUgbmV3IGtlcm5lbC4NCj4+IEdJRiBl
eGlzdHMgaW5kZXBlbmRlbnRseSBvZiBFRkVSLlNWTUUuDQo+Pg0KPj4gSXQgaXMgYWxzbyBnZXRz
IHNldCBieSB0aGUgU0tJTklUIGluc3RydWN0aW9uLCB3aGljaCBpcyB3aHkgdGhlcmUgaXMgYW4N
Cj4+IGFzeW1tZXRyeSBvbiB0aGUgI1VEIGNvbmRpdGlvbnMgb2YgU1RHSSBhbmQgQ0xHSS4NCj4+
DQo+PiBTVEdJIGlzIGFsc28gaW50ZW5kZWQgdG8gYmUgdXNlZCBieSB0aGUgRExNRSBvbmNlIGNy
aXRpY2FsDQo+PiBpbml0aWFsaXNhdGlvbiBpcyBkb25lLCBoZW5jZSB3aHkgaXQncyBkZXBlbmRl
bnQgb24gRUZFUi5TVk1FIHx8IFNLSU5JVC4NCj4gR2FoLCBzdHVwaWQgQVBNLiAgVGhlIHBzZXVk
b2NvZGUgc3RhdGVzICJFRkVSLlNWTUUgfHwgQ1BVSUQuU0tJTklUIiwgYnV0IHRoZQ0KPiBkZXNj
cmlwdGlvbiBhbmQgdGhlIGNvbW1lbnQgYm90aCBzYXkgdGhhdCBTVk0gbXVzdCBiZSBlbmFibGVk
IHRvIGV4ZWN1dGUgU0tJTklULA0KPiB3aGljaCBtYWRlIG1lIGhvcGUgdGhhdCBkaXNhYmxpbmcg
U1ZNIHdvdWxkIHJlc2V0IGV2ZXJ5dGhpbmcuDQo+DQo+ICAgVGhpcyBpbnN0cnVjdGlvbiBnZW5l
cmF0ZXMgYSAjVUQgZXhjZXB0aW9uIGlmIFNWTSBpcyBub3QgZW5hYmxlZC4gU2VlIOKAnEVuYWJs
aW5nDQo+ICAgU1ZN4oCdIGluIEFNRDY0IEFyY2hpdGVjdHVyZSBQcm9ncmFtbWVy4oCZcyBNYW51
YWwgVm9sdW1lIDI6IFN5c3RlbSBJbnN0cnVjdGlvbnMsDQo+ICAgb3JkZXIjIDI0NTkzLg0KPg0K
PiAuLi4NCj4NCj4gICBJRiAoKEVGRVIuU1ZNRSA9PSAwKSAmJiAhKENQVUlEIDgwMDBfMDAwMS5F
Q1hbU0tJTklUXSkgfHwgKCFQUk9URUNURURfTU9ERSkpDQo+ICAgICAgICAgICBFWENFUFRJT04g
WyNVRF0gIC8vIFRoaXMgaW5zdHJ1Y3Rpb24gY2FuIG9ubHkgYmUgZXhlY3V0ZWQNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgLy8gaW4gcHJvdGVjdGVkIG1vZGUgd2l0aCBTVk0gZW5hYmxl
ZA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF5eXl5eXl5eXl5eDQoNCi9zaWdoIC0gYW5kIHRoZXJlIG5lZWRzIHRvIGJlIG9uZSBleHRyYSBz
ZXQgb2YgYnJhY2tldHMgdG8gcmVtb3ZlIHRoZQ0KYW1iaWd1aXR5IGluIHRoYXQgcHNldWRvY29k
ZS4NCg0KDQpJIHRoaW5rIGl0J3MgdGllZCB1cCB3aXRoIHRoZSBjb21wbGV4aXR5IG9mIHRoZSBW
TU0gTE9DSyBmZWF0dXJlLsKgIEp1c3QNCmFzIHdpdGggSW50ZWwgYW5kIHRoZSBTTVggaW5zaWRl
L291dHNpZGUgVk1YIGJpdHMgaW4NCk1TUl9GRUFUVVJFX0NPTlRST0wsIHRoZXJlJ3MgYSByZXF1
aXJlbWVudCBzdGF0ZWQgaW4gdGhlIFBQUi9CS0RHIHRoYXQNCmZpcm13YXJlIG9mZmVycyB0aGUg
b3B0aW9uIHRvIGVuYWJsZSBvciBkaXNhYmxlIFNWTSwgd2hlcmUgZGlzYWJsZSBpcw0KYWN0dWFs
bHkgc2V0IHRoZSBsb2NrIGZpZWxkLg0KDQpWTV9DUi5TVk1fTE9DSyBjYW4gb25seSBiZSBjb25m
aWd1cmVkIHdoZW4gRUZFUi5TVk1FIGlzIGNsZWFyLCBhZnRlcg0Kd2hpY2ggU0tJTklUIChhbmQg
U1RHSSkgZm9yIERUUk0gaXMgc3RpbGwgdXNhYmxlLCB3aGlsZSBnZW5lcmFsIFNWTSBpc24ndC4N
Cg0KSW4gdGhpcyBjYXNlLCB0aGUgQ1BVIGlzIG9wZXJhdGluZyB3aXRoIEVGRVIuU1ZNRT0wIGFu
ZCBhIHdvcmtpbmcoaXNoKSBHSUYuDQoNCg0KSSBmaW5kIGl0IGN1cmlvdXMgdGhhdCBib3RoIElu
dGVsIGFuZCBBTUQgaGF2ZSBWTU0rRFRSTSB0ZWNobm9sb2d5IHRoYXQNCm92ZXJsYXAgKGZlYXR1
cmUgd2lzZSksIGFwcGVhcmVkIGF0IHRoZSBzYW1lIHRpbWUgaW4gc2lsaWNvbiwgKmFuZCogaGF2
ZQ0Kc2xpZ2h0bHkgd2VpcmQgd2F5cyBvZiBmb3JjZSBkaXNhYmxpbmcgVk1NIHdoaWxlIGtlZXBp
bmcgRFRSTQ0Kb3BlcmF0aW9uYWwuwqAgRnVubnkgaG93IHRoZXNlIHR3byBmZWF0dXJlcyBoYXZl
IHBsYXllZCBvdXQuDQoNCn5BbmRyZXcNCg==
