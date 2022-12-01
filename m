Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1167D63FAD1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiLAWqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiLAWqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:46:36 -0500
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9510BEE3B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669934795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cJ8Y4BhnpQ95og1EiMYaB/wfy9JJYQ6faMXYn5Kx0W4=;
  b=g8gZZiRLNySBjKhhMnuuXlh9g7WV+66x6zWt+UCekqlIJF2rE/wkIGFh
   5nQLifGm4aVtG+HK9XZHWXNkj4HmcTe98yApNX9iiBTSLTw8sbdu8Yb7e
   HpgxOVvtRCDz0aqlGbx7aiuvenfPj45+I/66wjPq9Nwe49a/XTq88tK5c
   A=;
X-IronPort-RemoteIP: 104.47.56.46
X-IronPort-MID: 86162459
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:ArRXOqwoGk3Ma0DfY1d6t+dHxirEfRIJ4+MujC+fZmUNrF6WrkVWm
 2AcDzrSOfuCMGXze9snao7kp0sFv8DTztU3SgE6/yAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTbaeYUidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw//F+U0HUMja4mtC5AVkPakT5zcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KTtn9
 MInFS4qUhuCxPjoy4CFG802nP12eaEHPKtH0p1h5RfwKK58BLzmGODN79Ie2yosjMdTG/qYf
 9AedTdkcBXHZVtIJ0sTD5U92uyvgxETcRUB8A7T+fVxvjaVkFIZPLvFabI5fvSjQ8lPk1nej
 WXB52njWTkRNcCFyCrD+XWp7gPKtXOlAdxISODpnhJsqEy+/UU+NkY2b2WApqWftkOde9FUJ
 1NBr0LCqoB3riRHVOLVRBCxpnyPlhEbXNVUHqsx7wTl4rbb5xaxAmkCUyJbb9onpIk6SFQC0
 16PkNTBHzFjsLSJD3ma89+8pyuaMCwUIGlSIyMJJSMJ6sfu5oE6iAnCSP5nEaionpv0Hy39x
 3aBqy1Wr6VD0+YI2r+98FSBhCijzrDJVgcd9BTLWXjj5QR8DKahZoq1+R3Y4OxGIYKxUFaMp
 j4HltKY4eRICouC/ASCWOQGF7at5t6EPzTYgFcpFJ4knxyz+GOxe41M+xlkKUtpO9pCcjjsC
 GfLswRX9p5VPVOwYKN3ap73AMMvpYD8FdPgX+uSatdIbpF6dx6v9SRiI0WX2gjFi1Qlm6UyE
 YmUfNzqDnsAD6ljpAdaXM8Y2L4vgyw7nmXaQMihywz9iebAInmIVb0CLV2CKPgj67+JqxnU9
 NAZMNaWzxJYU6v1ZSy/HZMvEG3m5EMTXfjew/G7vMbZemKKxElJ5yft/I4c
IronPort-HdrOrdr: A9a23:hKos7K+6Pwxjc2f+Unxuk+AiI+orL9Y04lQ7vn2ZKSY5TiVXra
 CTdZUgpHvJYVMqMk3I9uruBEDtex3hHP1OkOws1NWZLWrbUQKTRekP0WKL+Vbd8kbFh4xgPM
 lbEpSXCLfLfCVHZcSR2njFLz73quP3j5xBho3lvglQpRkBUdAG0+/gYDzraXGfQmN9dPwEPa
 vZ3OVrjRy6d08aa8yqb0N1JdQq97Xw5evbiQdtPW9e1DWz
X-IronPort-AV: E=Sophos;i="5.96,210,1665460800"; 
   d="scan'208";a="86162459"
Received: from mail-dm3nam02lp2046.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.46])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Dec 2022 17:46:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOWu6idxtqTuQL+tyryZyvCgqqYExvlbGTG79LkkLwdKhwAq4NX/TSuq7IcIT9BcGEy0PDMjHd+AwCfFKpDZxFNujkvWIVntTxi4jxA3XQ+p5qMuz+lXJ3XU3Ykyg/RLaYVTU3wg5f82WY6JHng9clAwNS3w4WHO+Qyj13Fj197ENrnDQcGP6cg+kY+pY2yKrd2QMylI3IU5ExzLNQ4gSoVfjmhiiOFcZb6Ks0WehT8Vfqp6JpsgEF/FoukFTbStAx3syJ/Eb4cXAIdNuPECnKx6jYU34vrMxcBPv9NsbUeDzRMJlTLzu8g3PTUSFoukDJY+0jVdt9+Ouww1nD5lhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJ8Y4BhnpQ95og1EiMYaB/wfy9JJYQ6faMXYn5Kx0W4=;
 b=MNJXrp9V+urJccCESqxo//irbLopgdwfcKrpOLYbgM+87GX6uG9c8bbn7KXdIpT33XdXL+Gj6kpARpOZW7z+EuJin/XgkhJ8YT5m9BWKbROoyGa0ufq5qf83kE+BRVxwlFm6IlwXAgvBMQI9dBhOWuAHeYr/WZrAA+jS2uqbsjBuFTZeY/e5lgtyhFl/YrQnX2WLjhHejtslGKhbofmkyBhwkloDpTBM90jn/o2zpwFxygrT736Ey1/B5EZ3O0aWq0Ic9qZ9AUzY0lo0kqAZiwt09CrjHFYyaE4ozMAbButRs8VhUxtXYiScXHyhpC1/z3HrWbOI89+2M7SWA7xzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJ8Y4BhnpQ95og1EiMYaB/wfy9JJYQ6faMXYn5Kx0W4=;
 b=KqDhzqEcmjEIx/EgxAve+pUYB2RPLSpAqchARQQdx5jw6f8l2pDXE77X9Z0oZEx6LmwK1PFQBoLJJv7HVRCNGAOpU96cqN70gjUrgfwcTXrboSd7b3Yf1Iaen+e1QN+h51craOSsNZ5bBToG1mSI6UBM2qKcjCKuhNkT5npQPSs=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MW4PR03MB6867.namprd03.prod.outlook.com (2603:10b6:303:1b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 22:46:24 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19%6]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 22:46:24 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "H. Peter Anvin" <hpa@zytor.com>,
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
Thread-Index: AQHZBRSlQ6ziLMSnBECHQCRKgANk165Zo1EA
Date:   Thu, 1 Dec 2022 22:46:24 +0000
Message-ID: <eb226c49-9da3-ae11-071b-5474c2b64364@citrix.com>
References: <20221130233650.1404148-1-seanjc@google.com>
 <20221130233650.1404148-3-seanjc@google.com>
In-Reply-To: <20221130233650.1404148-3-seanjc@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|MW4PR03MB6867:EE_
x-ms-office365-filtering-correlation-id: 61f07d26-c88a-413e-d469-08dad3ede01b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VRzi7RKgDFqYOF6OeAEf56auJ79O7il+0E+aLgNOgWbsOnhVMsdMVtr0wmDH4sANJeuGW4/bvanQYdmcf2pzC6szHQ0m+X04PJKrpLgt/POMfo8hhl6CzqGgZSpBCIkKRbxhtKnNlIQogocfwmz2fJtOjtmafm5YP07BVpoz+DCl9gIU5SAY3w7Ddux3sNjqDjiCRZjO1a+YVS+GVjnhpEdzaX2xM5qJ6MZijAYQA9Vxhxch9b0pNFQgcx6X1ZMFynlDxw9/kDMr9MPsEh/T1v1k3fu5v2SRHT1eT3B1w8ZK+7RNoQqx8BvwEStX3zWA1Acyn2R2/CxJ5cBX+wgxw2wVZ4xDjWtxOipLICSeLkQAM751hT3eIP4LFs3aWE0k9q2qHPBCjycb3Am7t6EnsgD8cbcBwYLxCmPpENeQknojYEpMaYmfx4uUGvTi2ci6FxRSDZwSrZTmi3C1qWi8sMz5j3yNdbiDRGKo71iF/z+xb0xo/AuERv81fQygAlEuuNhjbovTNVKLEuizh/15kI6yAqkRYAceibC/IJgvjMj7BuXalYGA4yer0hU66K4V8mN3YWOoALq/tPa6K1WR3GRuwpvEeMyrHtqXKJDJwSYSX1O61m0XXB61iWM1mR6QtdwrpbJmS+eBFRrol/gg0zZK6FR8vK7s8iL0QmAQzOnLyJjDXCjXgxewrAdsD5Molfwi4ALolJ+L3Pockt7EXjuWHeikx9EivaE5ofCb8nUskMuiN8Qb8+A965UyF4PLkO+rd7UWOeQCW358qneNTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199015)(66899015)(31686004)(36756003)(82960400001)(31696002)(122000001)(6486002)(38070700005)(7416002)(478600001)(8936002)(110136005)(38100700002)(83380400001)(107886003)(86362001)(54906003)(91956017)(53546011)(66946007)(66556008)(316002)(66446008)(66476007)(2616005)(71200400001)(6506007)(64756008)(76116006)(41300700001)(5660300002)(26005)(4326008)(6512007)(8676002)(186003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TldoQnFYSHhkRkNxV01DRnc0YlliU0dFZ25xWExESkd2dG5OTFlNQ2htTWtI?=
 =?utf-8?B?c3BlZ3VQMnpyTDcwdEhyd0JSNDduKzgxR0lkZGluTHo2eDczN2JaYkFTaDF4?=
 =?utf-8?B?OTlSWVF6RktHZ3RhTmRza3lXcHFheTJNb1RKODNVbU1DZTFBQkh4TjJZZndI?=
 =?utf-8?B?Zk1MZVRrZmpTVnZQZFI0Uk95QTJBVTNHSFN4TjBoYVY0bkQvZEhUWDVrSE9T?=
 =?utf-8?B?WGZsRzJYYkF2RXNWeTZPK2w1bUVRVEhNSDcvU1BQL2c4M2xpZUhQK0F4VlEz?=
 =?utf-8?B?ZUxhbGVxUS9hamdIT3Z0NldRRFROeElUbWJyRDBUalptSzZmU0pYUzI1ckdq?=
 =?utf-8?B?NXI3d0FEMXErQi9ORU13ajlVM1ZTa0E4NXhSQUVVTjhXT0p3YWFrc3RSbzdn?=
 =?utf-8?B?bDFXLzBvV09VMHBnYXNPYXROOHlua1g1SUFTeHdkdmxWcTlUblNpYzcrcU1k?=
 =?utf-8?B?WS95Q2ZvQnY0RURWNGhjY1RpaWs4NlJGdjFiQStIUXgrN0hPSWt5a1FBa0RC?=
 =?utf-8?B?Y0VJVkoyc2QxN2FGZ1RpRW15cW0xbUFpTUh2MXVnUGhzMzNJcGg0UmNzWWxi?=
 =?utf-8?B?VHY0VGVPR011b3hWZGxnSThwUVh3cWkzUmE4RFh0anRlTGJxaVY0dEwxbThP?=
 =?utf-8?B?TUcrb3NlNUJRU1ErMzVpc3FOamhEZElWb2tsby9qSHBwVE8rekVwTFNyWStm?=
 =?utf-8?B?Yzdsa3YwMFBnSVhURWVkc3RVUWFFanJ1SzlxemJqeHFFUW9zUkFSajBxQ0tl?=
 =?utf-8?B?dTlRNmNoY3BrZ2x0aFNhc05tN1dPZ3pZamhwNk9uY2dTR0toNUlyWUZsRWJ3?=
 =?utf-8?B?MUZQTk9lT0lIYTNtUTN6YXFRWmV1WnJYUm9tN2dvd3RJSCtaL0N4c21iMDBC?=
 =?utf-8?B?Q1VOL01nOERNV2FiUEtnWFF4cVVwMUFVSG5jUTRQc0JFRzZFN1pOVytUVWlR?=
 =?utf-8?B?alhaVDVjL2pydi8yTTdIYkl5MXZKaGpmU3BzSHYwY3NCM0cxeFBaUy9IWmFU?=
 =?utf-8?B?a1ZXMHpsZFE0QWF1eFRLMTFWajJBZk1DSmpHcm4yWjNsVldwT1IzR3JSTnYv?=
 =?utf-8?B?NExtMHZVTFVkRncxaUpHTDlzYytBc0pCclRtL3NVK3V5WU05c3N5Q1lQaGhL?=
 =?utf-8?B?Qm5heHNCM0FUN3J4SGJIYmlYSDlZWWhLMjdZSnc1N1dXRndxd3c4b25GY0Fx?=
 =?utf-8?B?a0huNlBKZlE2VGkzZDh1bEFXemRZRTVVWDFUSkF0VW9nVmc5ak1rbVFpNlRS?=
 =?utf-8?B?Y2p4VGNyNnZURjZaSWx2dWN4em11azdCMDB6NUV0QW44eVpReEFTR2Fwd2Rl?=
 =?utf-8?B?NHFFd0JxSC81eW1STDNOSkRVaDJtMGNmQ0VtcmJWdVFTaXEreXdqYVppd0Vw?=
 =?utf-8?B?WEFPUGs4ajE3V25ZSFFZamY1ZmpqL0I1cnNzSzErUEQzcGNDQnltK3lYVVFS?=
 =?utf-8?B?dFRSbHRtTVZ5VU9JMWJFMHFrWGdZYjJId3FkamdyMmJvWlRJZnk1UTQ4MmN1?=
 =?utf-8?B?K3dpTURmRWRwZWVOYUJiQUI2bXFxVk9ldWh1WUw5b20wNzhCZ2xnZ0FZNmYy?=
 =?utf-8?B?eVE0c0QrZGZ6NzJZQXVDVlZoTFRUYXF4WkRraytQMzk0ZDRFRytrUU1oRnpw?=
 =?utf-8?B?S2M4ZUszdm9kYVJSNUx1RkJzWjRBN3l4RkJTVTBQRVBwOHlCU0hlZ1dNcEln?=
 =?utf-8?B?cktoVDkxR1lDQ2x6UFVnZHJ3ZEVBalBRUXhqQ2RMWjZvbm53YjZMbjh2RXJk?=
 =?utf-8?B?M0pzYlBlcW9GcG11UGZhV3FaYmxQMU5sNlJIYkVIcGExZHAvK1pYNURhTEk0?=
 =?utf-8?B?dHhOTnBqWnYyeTc4bVgvTXphUmZMUkRWTHIwTTQ1U0FsOVZBMTB0dW9QbEla?=
 =?utf-8?B?cVM2Z1ZUMm9xd3JmWWdTS0Y2QlZlMWxWTmZZNEJRMSt5SExuYk1wMnM1QjVD?=
 =?utf-8?B?NFpSRkJWY3d2SjE3Z1dCUU9kOHZVZm5oamJibjJSSlFjbXpHU0RIV1ZDMEl6?=
 =?utf-8?B?OWlITlAyam5ldklDSWRUeXlVdmsvVC9EYzNyRkpRT2trRlhOQlUzc1VockU0?=
 =?utf-8?B?eUhYNFkxU2laTGlhUC9FSkxyWjMwVStsaFY0c3UzcURDbDRoTWVaeVBhYnBW?=
 =?utf-8?B?eWZqYlRGSkJaNmlOdENCbklyNksxZENneUlweGcvY2lST3ZhejFWS05lS01y?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B20850F013A54744952C96B8E8850A3E@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dHZtaFRWTHZkbEtxVktPVkhIbytiWVFQYmdIdDVYcURxaU4vZHFZRDJrYldD?=
 =?utf-8?B?NC90TFpib0g5dS9wdlc3UmJMeFBvQ0gzcFdhZUl2SFAyMkxLOERGMWNhM25P?=
 =?utf-8?B?VXhJdGhla3E4N2NXOGZpeXd3ZUtuRUg4WW1GMitzQ2JZeTRXeGplRHYrRHda?=
 =?utf-8?B?TmJVMmRoYzZkb2tRZXpQeVZJMG40WkIwQjFqTkJaOHlVVkNhWkZPcGI5TUNm?=
 =?utf-8?B?bjJpRWt5Ylo1Q0h4MTlnR1lkZTZwT0NPUjBuOUNEMklaaHlJWWd0VnI2ZXlP?=
 =?utf-8?B?SjZYQ3dsT1R0YXlLR3Z1amh5SlU5cG13bWJjYSt1SnJjVU93TTVmMElsejRz?=
 =?utf-8?B?YUZOc2c5ZjVMVUdIRzM5NGRVNmx5VmJkbTN3cjllZzR5cVoyWDFYQ3E2ek9K?=
 =?utf-8?B?UzVZdmNxT1VWckVhWVNrbXRpUC9nZERBdlpxb0tWSGlTQkQwS0J1ZkI0RW5U?=
 =?utf-8?B?bjFHUWJDRExkZFZzNVVuMWhCQXZoYUt2a25YaklvMWREcDd1Ny81Y0xZL3dw?=
 =?utf-8?B?RURQcmcyREo2ejBQRHBzcjYzd3dVLzl0RlIwVkZXdnIvMlgvZGsweE81SmZa?=
 =?utf-8?B?RlVlV1RSeFNmTHBlVkMzNHl3TlpmQXRDbnZpdHJkZGQvQkNKbzM1ZEJPNVAx?=
 =?utf-8?B?dk9zTWhERFp3eFVNSGp5dzVzQzVHd0NLcCtMTmxSSTgzUnJNYjZrazZuOWZr?=
 =?utf-8?B?c3RjbDJ5VHBleml2NEZhTlRNU0FWQkFWN3puWkJ2NWg3TVJBMk85UHdUVUFq?=
 =?utf-8?B?NTBzUDUrb3Z3VVEzQzIrRThPbmtPYmpYUHVEbzRhQm91Witwdm4zajh6OGNG?=
 =?utf-8?B?ZGk5SHZxQ3NFcnB3TlhGWnE5Nkk2WDBQbUdyMkZidTI4aFYzZHl5MW8wV3Na?=
 =?utf-8?B?OGw1ZktUNTNHL3JzT0x2bDFZc1hSekRkeGlvQXJ1NGFLYXBlUmdsQVZhYy84?=
 =?utf-8?B?cjVrT25LY2lTa29XZlNhSm43ejFOa0hJWTJuenN4NVJiNmtCSDFBY1V5dk0y?=
 =?utf-8?B?YnRSdUxzRWVtNUhHaW5VUjFKSCtCYTdGQ0ozNnpnR0lneDhWalg0ZEROWEhy?=
 =?utf-8?B?cU9FUXZTcGFLOGZlNHZtYXJjS3dUNkpjMnVKV2lHK1g0K3F3bUE5MFVGL1pL?=
 =?utf-8?B?aUE2WFMvTW80L1hFdTEwZWxTckcydGpsQ0hKRHJTWVVUK0QxNHFkWmJjT0FE?=
 =?utf-8?B?N3ZqYmVyOTdTTXQrN29id3BPM0d2V1JYVnpjcXRsTE5ManlBaFFta3FpUm80?=
 =?utf-8?B?YTRKemxNdGx1cGxtSmFZMVlVbkRsem92c1hPMHA3TGNqOXVKWVFpYTZTMmUy?=
 =?utf-8?B?bVIrdyswSlJZLzNsaitEd2FnVFVldDlWLzFZNFpROEZRcHFVbk1FdEdSYmV4?=
 =?utf-8?B?enJRTThMRTRobVJSSStMK2NQbVczcVhhd2xnTTI0ZEtJN2swWHVnWkQrOTVC?=
 =?utf-8?B?MmVFbmRwMnFaakhwUi93Mml5ZEZQMXdYNVAwN2NtcGkxaVJsY0JGZWZ2TWJn?=
 =?utf-8?Q?r+G4cRw5fyl9rDJjCIXZ1kZ6IBx?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f07d26-c88a-413e-d469-08dad3ede01b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 22:46:24.6820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Um5kPxMz/vFbZAU4RnUOlO0fTZnm2YQ0vNf+rgimqSjaUGKPLp6RDMBmnnodqRVsWp5GMCVr8jI+3kc5lZOefPKHQBjF9hz1N1Evk6hp5I8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6867
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMTEvMjAyMiAyMzozNiwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToNCj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZpcnRleHQuaCBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3ZpcnRleHQuaA0KPiBpbmRleCA4NzU3MDc4ZDQ0NDIuLjBhY2IxNDgwNmE3NCAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdmlydGV4dC5oDQo+ICsrKyBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3ZpcnRleHQuaA0KPiBAQCAtMTI2LDcgKzEyNiwxOCBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgY3B1X3N2bV9kaXNhYmxlKHZvaWQpDQo+ICANCj4gIAl3cm1zcmwoTVNSX1ZNX0hT
QVZFX1BBLCAwKTsNCj4gIAlyZG1zcmwoTVNSX0VGRVIsIGVmZXIpOw0KPiAtCXdybXNybChNU1Jf
RUZFUiwgZWZlciAmIH5FRkVSX1NWTUUpOw0KPiArCWlmIChlZmVyICYgRUZFUl9TVk1FKSB7DQo+
ICsJCS8qDQo+ICsJCSAqIEZvcmNlIEdJRj0xIHByaW9yIHRvIGRpc2FibGluZyBTVk0sIGUuZy4g
dG8gZW5zdXJlIElOSVQgYW5kDQo+ICsJCSAqIE5NSSBhcmVuJ3QgYmxvY2tlZC4gIEVhdCBmYXVs
dHMgb24gU1RHSSwgYXMgaXQgI1VEcyBpZiBTVk0NCj4gKwkJICogaXNuJ3QgZW5hYmxlZCBhbmQg
U1ZNIGNhbiBiZSBkaXNhYmxlZCBieSBhbiBOTUkgY2FsbGJhY2suDQoNCkknZCBiZSB0ZW1wdGVk
IHRvIHR3ZWFrIHRoaXMgZm9yIGNsYXJpdHkuDQoNCkhvdyBhYm91dCAiV2UgZG9uJ3Qga25vdyB0
aGUgc3RhdGUgb2YgR0lGLCBhbmQgaWYgTk1JcyBhcmUgZW5hYmxlZCwNCnRoZXJlIGlzIGEgcmFj
ZSBjb25kaXRpb24gd2hlcmUgRUZFUi5TVk1FIGNhbiBiZSBjbGVhcmVkIGJlaGluZCBvdXINCmJh
Y2suwqAgSWdub3JlICNVRCwgYW5kIGZvcmNlIEdJRj0xIGluIGNhc2UgSU5JVC9OTUkgYXJlIGN1
cnJlbnRseQ0KYmxvY2tlZC4iwqAgPw0KDQpUaGUgU1RHSSBjYW4ndCBhY3R1YWxseSAjVUQgb24g
cmVhbCBoYXJkd2FyZSwgYmVjYXVzZSBTS0lOSVQgYW5kIFNWTQ0KZXhpc3QgaW4gaWRlbnRpY2Fs
IHNldHMgb2YgcGFydHMsIGJ1dCBpdCBjYW4gI1VEIGluIHByaW5jaXBsZSBpbiBhIFZNDQp3aGlj
aCBkb2Vzbid0IG9mZmVyIGVtdWxhdGUgU0tJTklULg0KDQpHaXZlbiB0aGF0IHdlIGFyZSBpbiBj
cHVfc3ZtX2Rpc2FibGUoKSwgdGhlcmUncyBhbHNvDQpNU1JfVk1fQ1IuSU5JVF9SRURJUkVDVElP
TiB0byBjb25zaWRlciwgYnV0IHBlcmhhcHMgdGhhdCdzIGJldHRlciBsZWZ0DQp0byB0aGUgc2Vy
aWVzIHdoaWNoIGFkZHMgU0tJTklUIHN1cHBvcnQuDQoNCn5BbmRyZXcNCg==
