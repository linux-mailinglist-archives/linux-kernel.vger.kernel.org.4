Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E9A6A5FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjB1TjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjB1TjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:39:03 -0500
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D420E07E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1677613142;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9I29FQr43SIgx88XJePdnwBrwRxiIeBnk2vMNFa5MbE=;
  b=Dr20fPOqcKSFDE69DkKWwJyiEyMF/fZwh6/tS3bT4/NongZtMpp3T4ow
   MolAoE6hXgV07h9SOLgf3Vggx3G99xf/8Yx0Q1dsg6KrThM5tDbSIbrxm
   Ov3957eXheA4+WJ5znALlE4GhDo9p+DMXVJ50Ui4jTab/mIpYtCzTAoQ/
   E=;
X-IronPort-RemoteIP: 104.47.55.171
X-IronPort-MID: 97728652
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:8LlC8K4m9YCMlN/PQtFQ+wxRtPfGchMFZxGqfqrLsTDasY5as4F+v
 jYeC27QO/6JNmOjeIt3bNiyo0kCuZaGyYMwQQRl/HtgHi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9VU+7JwehBtC5gZlPaoR7AeE/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5m3
 vgqFh5RXDa5mPuLkLyYFa582pkCM5y+VG8fkikIITDxK98DGMqGaYOaoNhS0XE3m9xEGuvYa
 4wBcz1zYR/cYhpJfFAKFJY5m+TujX76G9FagAvN+exrvC6OkUooj+GF3Nn9I7RmQe18mEqCq
 32A1GP+GhwAb/SUyCaf82LqjejK9c/+cNNNS+foqKMw6LGV7mcyMAdGWlCemN2ghh+Ef9MCD
 nIb+BN7+MDe82TuFLERRSaQqXuDuBcfXMR4EvYi8giWjLDJiy6THkANSj9MboxguMJebSAjy
 F6SmPvmADVutPueTnf13rOVqy6ifCsYN2kPYQcaQgYfpdruuoc+ilTIVNkLOL7l0PX2FCv2z
 jTMqzIx74j/luYO3qS/uFrB0zSlo8GTShZvv1qOGGW48gl+eYipIZSy7kTW5upBK4DfSUSdu
 H8DmI6V6+Vm4YyxqRFhid4lRNmBj8tp+hWG6bKzN/HNLwiQxkM=
IronPort-HdrOrdr: A9a23:V6VYSaguxNMtdIqU+2ntUjUj8XBQX5913DAbv31ZSRFFG/Fw9v
 re6cjzsCWe5gr5N0tBpTn+Atj9fZqxz/9ICOoqTMSftXfdyQmVxehZhOOJ/9SKIVycygcy79
 YET0B0YOeAcmST5azBjDVReLwbr+VuP8qT6Nv2/jNVaUVPVokl1gF+D2+gYz9LrMstP+tGKH
 JZjPA31wZJvB4sH7WG7wI+Loz+juyOrovifRkFQzY/8WC1/EqVwY+/KQGcwhAdFxhSwbIumF
 K17jDR1+GYqvSmzR2Z8GfW4/1t6bzc4+oGPtWIls8WbhPzjQqyDb4RPYGqjXQOueSy71Rvqv
 ngyi1QR/hb2jfqZ2Sophmo4QX6zzo0zHfnxTaj8ADeiP28fis+F81Cwb1UaQHY7U1IhqAH7J
 52
X-IronPort-AV: E=Sophos;i="5.98,222,1673931600"; 
   d="scan'208";a="97728652"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2023 14:39:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4G8mxaE40Jx4fC+wY3atqG/TTUZYItsjuB8xFGi+JfXtUVPSmgUsIWnF6IPB0HW06k++Lfy/6xd4/RwwCMEHhrS+nMwOtuz0hT0eenV7uSa0NCQNz/JJ+Is0SVHPE252jouh1+1opmzZNd7HLwYzFZJhSF/YrfIeTR+odemp3k58I2sg15z1adOmcqweqfzW/ElKfriGeffFEh0GphVRUYxPLnr3IbTB20Zcx6/Joe7iV3SPmQxz64YEX9FbEWBhK5xeq3LNeUy6pD+aDNY54/Pfdf+EfEBVZUbGbUbaBsoNKukPqAgfpr2scygUfU76kBs1bIy3T8X1GkabqkgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I29FQr43SIgx88XJePdnwBrwRxiIeBnk2vMNFa5MbE=;
 b=RKVtD6gpYBneTC9w2laLQZXGLwrhBfdMqTRjvmXCUe40bg3NjibdA1wic0PuJeXBCGj++Z99Kgc4tH9Lp22S27vm65/OhffKmxYAmGCgcplZ73p8uYYSG7ElGJgqjnBfv8rzhS0gTB5udy7inzCJk28lLKHud/GbI0Ly5OgtvVo1zDJeOJ6yWUyrOa5oRa3qrLoxABlSTA9hcOPY/dLAEqU47SGSOAdPUEcPgDVnE8f+U0flcnneZzAMbFDlzeaBeosspDnh5XHKlSxFSVAhR6fZ33aQio6xVHg65PBZVfrUq0x5p2Q42OAkF9iSB/gSFAS0N6GaF405KEpiGSN6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I29FQr43SIgx88XJePdnwBrwRxiIeBnk2vMNFa5MbE=;
 b=YusWBWAdqYdqeRoUj5SMuTq4CELNT30P1Hk0fYYJiXzG7J6xT/3voxgrZBnKf5UlXa3kaHyRkpN5tUquSaxrTYunsrGZQbpb2IQ37wiiToiFhdhBJqa2ersUXEtQofh5Ec3jx2WYcQYZA5BDhQ58e2UAQYBuVGaNI5lc4lo4FGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by CH2PR03MB5303.namprd03.prod.outlook.com (2603:10b6:610:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 19:38:58 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 19:38:58 +0000
Message-ID: <8eff0a18-7faa-1135-a558-40150f4443e5@citrix.com>
Date:   Tue, 28 Feb 2023 19:38:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: x86: AMD Zen2 ymm registers rolling back
Content-Language: en-GB
To:     Alexander Monakov <amonakov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>
Cc:     Tavis Ormandy <taviso@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <Y/XTT59OrLw2as4R@zn.tnic> <Y/Xc+yMzI83WZ4V1@zn.tnic>
 <0371ec3d-0899-f94a-7f21-21d805df2927@citrix.com> <Y/Xp73KJe3c/1jrn@zn.tnic>
 <4737f149-c5b7-8a51-7cc5-8bda6e98308b@ispras.ru> <Y/5T4ScbM/99DhgT@zn.tnic>
 <3d007f98-a42a-3c0e-8d6a-c86c5d0e25be@ispras.ru> <Y/5VIECduoyCJKP5@zn.tnic>
 <4d21fe93-7b77-bf5a-9ba8-645256ab0983@ispras.ru>
In-Reply-To: <4d21fe93-7b77-bf5a-9ba8-645256ab0983@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0217.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::6) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|CH2PR03MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: da9bf093-9eea-4990-5ede-08db19c36f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iXm0F7JrhbPMaPtZeLq96ieM07jhhOAiP4SXwd+RwEBd0aLMiXzPSbPmAzEf2V/9wexMd8KQGMifDlpHJ1K4EJBekQJ/C+nZV5fa4FHjudxndo4jZau42CZ/8WHime2iGooiODLngKJLIvjY5b1C0qVRuyem7r6/xk8vXIP07F1CjDCT+TUdUEiZDUuqE1Oz2LvmCJBMmd/GU7Rp0LXCLLwec/D51veVdpzzSdVejXC4ukRqVmWD9kvY9W6dU7h21jGV/SWh7kkKfNfXT/efG/imJIZBeI/QOsMp28y0ugGbwLiFBwrMFoe2/D7aMQmnvgdIg2qT6eYVHlH2wJykyere3/N/nRxnDUuib8/u/iD11ffLr54mq2NBuqpj2rh2Rv/hOTWrphrK7dmAKdj3aKVowI8LQQ6QGX/SzgUHLs5xXY2Fm+UyllFHco0yuiOa/uEvJhsl4OsX/XTvzd1a7MU1+jPsDhcvve3ZUQiLK6Mv/8MiacNw0j5JKS0VZWtowSTGvXUXZNzd9jnOnlAOs5jt0z5ij/piT1lOwEWfBd14TZa5cF3uslf/JoZnjBoly7s6cxto11G8UXbmeA5m/n8i8rxvJJA/NOS7X7ksDMlFqwgmWP9TR8k1l1KlxNTOm5W5ANRQo76d3VKdjU6W1jFNdorBKgn37T+2DMApTTkHLnVceOyvtraE817dedSuUWcSHYZzhanPT/NBPiBNNhGdFr7WCwjAr+IfEN7RbKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199018)(31686004)(110136005)(316002)(6512007)(36756003)(38100700002)(31696002)(66556008)(82960400001)(53546011)(83380400001)(6666004)(6506007)(4326008)(186003)(26005)(2616005)(2906002)(8936002)(6486002)(5660300002)(966005)(478600001)(86362001)(41300700001)(66476007)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW90VEpjMVZvZzdnRWpSN0Zhd2t5dnZiWEVycUtZOHEyK3RFeUpPTFhtMTF1?=
 =?utf-8?B?NWlCWUJCcUdwZllhQnZrMEdseEQxc25xc3RqZnVESjlKWkk4bEpRMWc5QURV?=
 =?utf-8?B?M2ZTNXRiQWtXS3VKczVYMFZRNUIvbVdmNFdKOWpHWUlaZ0VTcXk1N0x1RTVN?=
 =?utf-8?B?RzJwcDBjK084SDhDSmFFa2NFWGh0cnNkN1podHp3RUNhVGZLT1pNWTJkVWVy?=
 =?utf-8?B?b3Rjd2t5K3BmZE9CRXpvUHpGMWhrSWdtTmFsOHVjU09KMGY4M1ZIRW0yLzdo?=
 =?utf-8?B?NHNtVUdCN3hBS1Z5dSswVmEvQlhKRVpSN0o0eWxjWXpGbE1Rb1cxZXcvQkRr?=
 =?utf-8?B?enZqUUpueVJsU3dObTRSMFFiQ3FLQUhYcHhPb1hORzd4UEdzMzc1TFFhNTFW?=
 =?utf-8?B?QXVIa2l2bVUwWC9aWW90N21vNFlFVXptV1ZCak90N0tNMW9JcUhEa3hLV1ZP?=
 =?utf-8?B?YXQ0SlUwSWNtNUJOTllTNU45a29DUkJvZ1E0d2t1VnBuQ0hLeDVnQW93Rmgz?=
 =?utf-8?B?amhTTU5rbFFGYndjQWN6N1FiS1Q3QTZra25VUFhjaVBtNEM4akV0ZXRzRDdT?=
 =?utf-8?B?R0tIR3I2emphMjd3ZnRhTEtqdlN1dENVbDJHQm8rZHJ6NWZHMFhuMGlXVkFG?=
 =?utf-8?B?RUJsQU5wYUlFb042ZkZsK3AxN0JjTlE5TGtNYXZGQ3ByaEdHLzBjdEZYaFNC?=
 =?utf-8?B?MkpodEdCdEZiQmlYTnUyQ2RSbU9LaXRvSG5nWmRqblZ2Y2Zzd2I1alNrbXlL?=
 =?utf-8?B?bEY3dmtQdERhWlYzdDhKb1VEOGRpcGFHRTJ2ajJDWDdCN2VlV1NCODdCV0pR?=
 =?utf-8?B?QVNsT21CTGhidUZud1B4ZUVKQUpRRkZYeFRQUmhQNE5nUXpWMTNiM1NJS0I3?=
 =?utf-8?B?UWptcGRlbERObDFveUFTNDRBdXJjSFltNXZhQlBNeFR3UzVmTEtyKzFPYkdp?=
 =?utf-8?B?S0xzUiswQllHWHZ5aW4yWTR2MXdHckY4UGMyMVVJRUlCRW43cU9qTWJxRFJK?=
 =?utf-8?B?QlBSM2pZek95OGJQeFhlb29tWkk2Tlk3V2oycURkcFpsRU02UnhoRVllb0Q1?=
 =?utf-8?B?V0JLRWNRckJxbElBMWtzNkhnSk5pWUhVYmVYV1NiUDUwYlhHK1FySXBTYnhj?=
 =?utf-8?B?bithSjdTbDJ1YjhjNTh0RGwwZVhPZmlhYnhOcHEzMmZjaGxuRGI1ZWdabC9n?=
 =?utf-8?B?T2VWeG1RTllmMThoalJJUi80b3F4SkF2Wml0b1JDdVlETXBLTnF3NG5JVjQ3?=
 =?utf-8?B?Zzd3RWJEN09kQXZPTUlUdm1YblUzc0ZJalU0SWdLYm5ZVmVFNW5kT2hGbVNz?=
 =?utf-8?B?THE0cGVQNGwzdFJ3ZFlXWGExYkxSUEpyZmNxR1RsY3pQUzJTWmdzb1NMMmp1?=
 =?utf-8?B?bVVHdFVpMDZnK1ZZSFRWcmpwTTY0R2NibDM0bWk0R2pPaEFVallVNTIvT1lF?=
 =?utf-8?B?R3F2dTlEUWx4MTRVWU0vcW9iekJCb3ZhVHJTbmVObkNIRTdZbDNIUENOWm42?=
 =?utf-8?B?RzViK25EaHJXN3JjMSs5MjR0WDNBbm45Qi92bEZUWEp1STc3Skk3L3ZkM2FJ?=
 =?utf-8?B?K08wcnJSMGtDQW5xMHRRVmdTQWNmTzFRR3k1WnJuaHRoNkxiNDFZSnZJSWhp?=
 =?utf-8?B?YWFPbW4rdVZaTFRJMjY2V09qSyt3eXk1ekpGMUxsRzhTbU84TlVYWDYvNmtQ?=
 =?utf-8?B?YkI1Mmd2L2MwVWt1M2R6M2FhSTNoRGxKL1BTczJlV2gwcHFLL0QzZk5NK0Jv?=
 =?utf-8?B?SjA3NWVPejQ5YXF0RnZKb0dkaE5ha3JmRWdBMVZhM1B2UGlJdGdlem01aDdo?=
 =?utf-8?B?ZTlpb2pVVFQrQ3dwUytRQVUwQVNNTUlYekF1eVpjQ0o5Y0FXSEp2ME11U3No?=
 =?utf-8?B?U0tpYzNFUUZsTzdnREcwaHJxTG95cGJFRy9tODhUQVRtRHlOZktQTGxwdmFW?=
 =?utf-8?B?WklzQno4VlloQTdLOUVDOVZkRjY5V3ZFUE9WcExqc01xRmozREdLdkdEcW1a?=
 =?utf-8?B?VFBHUEFFMDFsN0tQTTcxcUk0cnUrengxcE9XMUNCbWdMemdLcmlYd240YTVO?=
 =?utf-8?B?SXpQM3dwa1E2QVc0dS8wU3lwQWl0ZWE0TjlCR1RZWjlCTzZTbTJubGt0dVZO?=
 =?utf-8?B?UCtIOEIyWDZSNEpNQ05nNmQ1dS9qTnVmdzlRbHliTldOQmRqVENjOHBWNFhU?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bC4HC6LBS1ttEQg8nO8toOwbd342svTnf4LAubiq6hMtiIx64KOwetQOO3ZdAV9EUc+urOPBJ4+82Lq7CaMvq7+xlb54UobK94rE0s0+IA8Y51phEwCrHq9ilCrXfi0s4TJxi1tGl5WjbyoaqmRcmHz251zt4MPTCh3T6s6kfDnOh0Dgmb4oz1s8dbsXPTdXDbbBAT2xdl+NR+pHpYKX5tOLMvcFWweFVttJiXQovasl+VTfGYdTxFOaz9wfp8HWNVCEuZNfM0X5ETokfYYSCWSIs9qqAoqXCQd8/qb/MPVKxF5LKPPBeH4AHZH5hyFSLDt72+KBU9qvOF60xQ031rAKt1YS1bIpnXOOzPazusVqfOEi/RmwjTNOF77ReJ5rwrqsvH/1jgMw19UsyiyHu3WdUQRmSj7zlqQabPlR34AHhG8ovFpoeNrbjSMwtInRx7FJA9SeG5LjoUnngDGYw9cW93DGwBEHzLHaoMBbRt3pnwGxt1x0l6BoRRn1d7onNJH5b10RIryRMgcuYS6NREArYCfb7u2w3F4wrQUaPOXFONdQdj4D/EpzaFbhQjzWQX0Ml2Xq/C0m2lrGcqQqFBAPdq734BQeX8VuTWUAZfzD2zB2FM7DS51GOtKI9LOK86GDBDhAu/IfNU2ZjW58Dr+4E4Z/ZVCwHi1v4n3MkcacmXBm/Jq6QTvUf2rADUf9AZlYEUtmOMnpZK0KaHymzCHtE29fwUzuq7muC3aNkrQqYh7aQIbz+r6QuNvohTSmNJhJHkhPjJtjoIxCmBygtI/Bw6oZ+8emvI5zXiFHKR8oaezND8t4h6Eprt9zzCvEWhQEBfy8TXmJbzGYwDgaxWJTALzUSx1deNQhhM/BMTIOI7hUZyQLFF4jSt2Zt22i
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9bf093-9eea-4990-5ede-08db19c36f85
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 19:38:58.6198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zu316M2Ol9/L3TEaxpSpdOQ+EeoAc/MJjEH8XlK9LFe1ghDMbu88vZzKDMuv/WAz8ZrEtpWNPXn0s6/hr4n8cbNmW5irVbvO7JkpfQRtUk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5303
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 7:29 pm, Alexander Monakov wrote:
> On Tue, 28 Feb 2023, Borislav Petkov wrote:
>
>> On Tue, Feb 28, 2023 at 10:24:40PM +0300, Alexander Monakov wrote:
>>> No, on the contrary, if there were no updates I would not be able to
>>> see microcode version increase after updating.
>> So what are you saying then?
> That I can reproduce the bug even with the latest BIOS, i.e. the microcode
> in the latest BIOS update does not have the fix, and the linux-firmware.git
> microcode does not have a patch for this CPU family at all.
>
> Hence the question how to get fixed microcode for this CPU family.

I shouldn't be recommending this, but I've begged AMD many times to be
better at publishing microcode...

https://github.com/platomav/CPUMicrocodes

and you'll need

---8<---
#!/usr/bin/env python3
# -*- coding:utf-8 -*-

import sys
from pathlib import Path
from struct import pack

fout = sys.stdout

def stream_write(_):
    """Write to the output"""
    return fout.buffer.write(_)

blobs = []
for ucode in sorted(sys.argv[1:]):

    # cpu00xx0Fxx_
    fm = int(ucode[3:11], 16)

    eq = int("".join([ucode[5], ucode[6], ucode[9], ucode[10]]), 16)
    sz = Path(ucode).stat().st_size

    print("%08x, %s => %04x" % (fm, ucode[3:11], eq), file=sys.stderr)

    blobs.append((fm, eq, sz, open(ucode, "rb").read()))

equiv = []
for x in blobs:
    equiv.append(pack(b"=IIIHH", x[0], 0, 0, x[1], 0))
equiv.append(pack("=IIIHH", 0, 0, 0, 0, 0))

stream_write(pack("I", 0x00414d44)) # Magic

equiv_bin = b"".join(equiv)

stream_write(pack("II", 0, len(equiv_bin))) # Equiv table
stream_write(equiv_bin)

for blob in blobs:
    stream_write(pack("II", 1, len(blob[3])))
    stream_write(blob[3])
---8<---

to wrap the blob(s) from that git repo into the container format that
Linux and others know how to parse.

~Andrew
