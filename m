Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7E6AF655
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjCGUDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCGUDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:03:06 -0500
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CD510F5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1678219334;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uCeS/QKbAspTYSV89Dr6trOebpnHLAMRVYcduUZFHRE=;
  b=BCQ9V5jEBKaj9PrcOBP0a83NIV6ALksrqpjpnU/zPqWNxGYRC2Kz/SEz
   jPqX7KddCZVWhfLoST73nGMB24VN49O6EuZcVJVFiTKYp3ggCYs03TW2C
   xEGd/DbPgY8WCeuFkzL4fFNnSlA+Y/WDErZVGMfm5rw8nVQr97UkY4eap
   s=;
X-IronPort-RemoteIP: 104.47.70.104
X-IronPort-MID: 100299072
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:MiWzp6o6Z0fpN3btX1fY1YfuHzpeBmKAZBIvgKrLsJaIsI4StFCzt
 garIBmHPKuMMDD0eIh+Pou/9RlSuJ/cy4VqSwdqqHwzQy1D85uZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKm06WNwUmAWP6gR5weFzyZNVvrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXAA0MZUzfxNyc+5icTdRtv/lgHPb7GpxK7xmMzRmBZRonabbqZvySoPV+g3I3jM0IGuvCb
 c0EbzYpdA7HfxBEJlYQDtQ5gfusgX78NTZfrTp5p4JuuzSVkFM3j+CraYKJEjCJbZw9ckKwj
 2TK5WnmRDodM8SS02Gt+XOwnO7f2yj8Xer+EZXhrqYw0QzLmTZ75Bs+Xmqprtrjj0WHZtdxe
 mJNyBULsbgR+xn+JjX6d1jiyJKehTYWQ/JZF+w37lHLxqe8ywKYAHUUCz1MctorsOcoSjEwk
 FyEhdXkAXpoqrL9YW6U6LaPqhu9PCEUKSkJYipsZRcK58nLpIA1kw7VSdBiAOi5g7XdHDD2z
 DeitiUyh7wPy8UM0s2T8VnZjnSsr57SQwgd4gTRQ3Lj7wVlaYrjbIutgXDLvahoL4uDSFSF+
 n8elKC27PgHJYOciCuXBu4KGdmB7vOCNjTfhkBHHoI57T22vWS+Fb28+xl7LUZtd8wCJjngZ
 RaLvRsLvccPeny3caVwfoS9TdwwyrTtHsjkUfaSacdSZp92d0mM+yQGiVOs4l0BWXMEyckXU
 ap3u+78ZZrGIcyLFAaLeto=
IronPort-HdrOrdr: A9a23:xnl/ZaHNqty5GBPtpLqEEseALOsnbusQ8zAXPiBKJCC9vPb5qy
 nOpoV+6faQslwssR4b9uxoVJPvfZq+z+8R3WByB8bAYOCOggLBQL2KhbGI/9SKIVydygcy78
 Zdm6gVMqyMMbB55/yKnDVRxbwbsaa6GKPDv5ah8590JzsaDJ2Jd21Ce32m+ksdfnghObMJUK
 Cyy+BgvDSadXEefq2AdwM4t7iqnayzqHr+CyR2fyIa1A==
X-IronPort-AV: E=Sophos;i="5.98,241,1673931600"; 
   d="scan'208";a="100299072"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 15:01:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLXOAEymW6uojTuWE1p/XwEcD8EuevLV4VtdFgi3axUv+CindiI6N5B92+pVjrpnF7pe2t1e+rxD+QvCpStFDc/f3JoK5HqEKpxxXiGri+PMjCRP2fVWllvk6BMxnFCGEq6Xjy6OWPJYi+w2VxhOCUOE44NNWKIk4KL4QuqUc92KuBXUqNDwTvMRDz674BxKuhuT8x3FD5xAtoq5HhM+JJHcWaFBIna4BcAp019xT9Z0kN8DgG9NI1CJgBKEiS3nF+/H38q0Lq8yLKa+pqMljLeO7hjpSdPBb/Xsez+9VFrnWvgAusLm7vNc9uo1Kx0XI01f5f8p/cFzXJcY8IupMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCeS/QKbAspTYSV89Dr6trOebpnHLAMRVYcduUZFHRE=;
 b=c/y9EYqbwsK5rpvCCYLiW3LafpUh4mfNqZSHAwPWT4WtoYyaBX39xARDXP28on1pMA3NkHVdIcJN6bEdALoFNgTnhcXikuPqAg+yAugZx6o8OlajkVDK+BTR/DM+g0+0jLRBmk/K66XcplJojBAqEod7jTvKqrVVgaimiao1h4V3zWKF7qS65YSf6JYbIktV5DhOwEj/fOwzHlCCA+P1l+ymP+CrASLTfl7LS8aSIAGgp4bKVtrLsHstn+g4pM2oPSS6wR7WQeFomE/ecFD6z9BKp/ZPI60ywdRKw4myIud2U3JqzsTK3mM1k2pR5+6SM/gts5Qg5NQF/NjsE3e9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCeS/QKbAspTYSV89Dr6trOebpnHLAMRVYcduUZFHRE=;
 b=PygkI/b/cNgP09iynycUrBidOwoaXnLgRBTtbHy1IdRxbucjvtmo7XQ5pgQMqlhssw6yD5loyY/T0u5q3HhjFG4ZyMKZYAH9iLYOZ8GJh3gEDIfHtBgAI0QLKuYYoUKvyidoHaCA/0KjrRy/l8NnU7ZtyysRMOszzV7YL55HhwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH0PR03MB6383.namprd03.prod.outlook.com (2603:10b6:510:a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 20:01:43 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 20:01:43 +0000
Message-ID: <ee866b3e-a53b-4c26-0272-20e798c0650d@citrix.com>
Date:   Tue, 7 Mar 2023 20:01:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH] x86/amd: Work around Erratum 1386 - XSAVES malfunction on
 context switch
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tavis Ormandy <taviso@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Monakov <amonakov@ispras.ru>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <20230307174643.1240184-1-andrew.cooper3@citrix.com>
 <20230307175050.GCZAd5eu0/Mk2fdLz5@fat_crate.local>
 <940596cc-a440-181a-a72a-36282a26dd0a@citrix.com>
 <20230307185632.GDZAeI4LwBDUU3/OP9@fat_crate.local>
In-Reply-To: <20230307185632.GDZAeI4LwBDUU3/OP9@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0466.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::22) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|PH0PR03MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: f3eb08c2-5dd8-4d14-90a4-08db1f46c5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: inf6T7V25tb7m66l2Qjws6Odc0U1Q1W7X/ID+M4+jFTZOssiVi4zdqUnuGggGo9pjYBnrArgrh1FKiAkO4WIOZM5R9h8Usw4NavoJOTEr3SYfSl/rT7zMaK7W6/e6xAmTb3b4xQUObkI0HHm83IFr08Ch9gCWoAN63GHZMVNYGCT4PAmnPraasjNg7YJcZV+LLrC1uMV3ddMyphz54epI8SmxGmN7DBGieo7q2OSq9mcCvZuJdVpX4TpzxknMjgjSbMWhNxxvsCejCjsFa3N8aSPNwoKXLhgtGUp65Upra/wRvq62SEX6kfZUSiAGjzn4cBMfgs/veK/68sa+9exK69+4DHSDBKefpt0zixYZRvTtHwV7oejltemd5S0mbvU814AJPjDEz/27lWZfj/V7km1gpPXzsyg1snaJFUaoFyLZScCiApgTrMKp67hwevEn6bXIQPJRFCwX3RXyfeelujhRBvlOkzpwPyGvcLB3QPfoPrG3QLJyp8hePsmKWul0S1pUEabR7bRfnjWtWrOictXloCf3d2C7U9Ae9T9gY6bU5hMGOW6kuU3fB3oOCim2tZkdCYAh3bWZ9da/8LX+8+zs1le5rxG5vXMiahirQehBrt47hm9Q+uEoQnmOBBHOE4oYUZHszzNHIpq5gpaHE48739bcdZk3Z/L6gK0E7aNCaqAXYe9Cxu/iQvQGGs6gh1fgvRzYej/s5GI5599ZcAyf8TEeKEW9fi3L1MGSb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199018)(86362001)(82960400001)(31696002)(8936002)(41300700001)(38100700002)(66476007)(36756003)(66556008)(2906002)(4744005)(66946007)(4326008)(6916009)(5660300002)(8676002)(2616005)(186003)(53546011)(478600001)(6506007)(54906003)(6486002)(6512007)(316002)(26005)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDZhcnRFMTZyOHIya2xJYjdLSytPVmprNjhyTHlHTnNqOEwrMFFHYXBvSmdq?=
 =?utf-8?B?WlExV1BRSFBpRm40L2IyZnl5QnB6akt1WWozZEZFV3RMWG4zN1RRRlhhTGV3?=
 =?utf-8?B?b21NOGRaS1JpeU9SYXZiRFpPeFZyL2IvNDUrU1VTY2x2YkJqWnBKNDNja2Nr?=
 =?utf-8?B?YS9reE5zTmhkMTJPWTR5NmpmNC9iQjFxaW5LNmVCMlNVSlhMQ3R4Y3MzV1li?=
 =?utf-8?B?a2Nodlp2UGdoYlpCM1ArWlRSQityaklvbkh5RnM5dXRQNmVRYy9KL0RRbzY0?=
 =?utf-8?B?ZzlJeTYvYVZJVWErcEZUQlBQYnBvNVAwcFZRK2Z4Z01DUXFDcUptQUUwV09r?=
 =?utf-8?B?ZnZxOGZWS3hpcjJ2a0wralRtQWtjS1ZyZEFJemVvNjhOeFFwdzZVYStRR0g0?=
 =?utf-8?B?UVoxVGNWMUNTUWl0d3VVMzIrR2w5bmpSRi8vbHJtM25SaDdlb2J5NmJQSXdw?=
 =?utf-8?B?YTFqaVpuU2dlTzMrZkpteEJ3VUFwVjZFckJBYkJyejkwdXV6QWo4ZWdWYkIx?=
 =?utf-8?B?N2lxMXRnMEdRcHlRUWh4bGgvSEQzc1BhR2hvZXl3SGlCdHgrWmdUelZkL2ps?=
 =?utf-8?B?NzBzR2Q3RzBkSDQ4SzE5a0orWHQ3eGZVMWZWcHkvSCtEUTNHWFhpaGRsTGxV?=
 =?utf-8?B?K1RXTzZvYW14dVQxaERuL0FyL3ZZY2JwVjBuVDh5N2NVZWRqNVdaWlY5REZO?=
 =?utf-8?B?SUN0NVpicVhuVVJ6R01obzhuWnUwTXUrQy9LUXU4bEFGeWlqZGlLRmFhd1dM?=
 =?utf-8?B?SjBHRnVGRkpUNDFYcno5WHNtcWtpWk9XOUhZR1FsaFNDcDhBM0FkbytBSDVY?=
 =?utf-8?B?TnZ1YUdWcUFUekhsRk5zOXRxYWx0UURzVU83a20yNlR4Q2d3NktkeGpzQXNj?=
 =?utf-8?B?a3JPZGxrNWIyYUphMjd2USsrYVp3TlN4WEQvZm9YZzVCdEhoU2ZrT1ljMlNh?=
 =?utf-8?B?aFJqUWd0Y1V4Z0F1WExrdWNncEN6MExoOGN1dkE0VU84YVJLaGIrWFRNcWtX?=
 =?utf-8?B?TXlheVZNTWs2eWNVT1JQeVZRcWozK2lOU2RnMmFQZkxxdk9JVzlMb1JNeEpV?=
 =?utf-8?B?dlB4TVhGZ0VpSUZUVXB3eS9IQm52VEJxa1dkY2NKMWhVRlZOTG03V2NhMnJV?=
 =?utf-8?B?T1BQcldJa0NFWVBwY21Pd3VvSjJnOXJ4d2lBSlEzQWRMZ0d1NjI5Q1JlVzQ0?=
 =?utf-8?B?M0JPbFB4VFlVbEpyM2JWaU9Bd3VkcDBpRUtJSUdVZmtvRk8yVFV2c1FqdEEw?=
 =?utf-8?B?QWFkYXhWTHIyVVFDTTBNSzlKalRzbVBSTFh4OWhGcmhEQXlHOFA3U255V3kr?=
 =?utf-8?B?bjEvMTJibngxZ2lQTlhsRVlGMzRQd1BhUTFEd290aDZBS0xvNVVGNW02YzNt?=
 =?utf-8?B?UEhjcW92YUd3N1lrVURVQkJITXpwMFRoSlk2Um9QVmU4Z052Y2NGbXB6eVZu?=
 =?utf-8?B?NHBJWUwrTm1qZzlmdjBoek14OGZpYWdwYk5XdDVYWi9XTEU2dDY0VlN2UDhs?=
 =?utf-8?B?eDhqZ2NTMWZ3d01WQ0dIS0FSREZLN2U3M2ZWNWpXMG9JYUt4cC9CbWJuS0h2?=
 =?utf-8?B?V1NWaGpLcVk0NTFwWVIybUNaZjdLRVZNWlMyMm5VRmc2WFV4b09mTWE5eHQ1?=
 =?utf-8?B?Z2pTZk0rS2dYQU1lVHZYdkw4T08wVWdhVUYwNFVHVTNnTkVQN3BleG5uRC9v?=
 =?utf-8?B?SnpvZ0VJZWNGaFJNVDR5cDhNSzgwRVkwU3JQMXNWUFpuOUpLSC8yT0hkd2NN?=
 =?utf-8?B?b1FjNk9TNTVtTmM5MzN6MHQ0YTU3YnJzRGhhcWZzdm9MSWpIRitWYTZvMkh2?=
 =?utf-8?B?UEI2dURuSjlmcWRmRmxSWDhwa3p0K3VGZ3puQW9GNDZMK0JocHJLU08rRTlv?=
 =?utf-8?B?WDc1aS9Nc2V2OTRLWXRmR0wrYmFtSU90QndPK3dEQUNqYm13c3dRdE5mTENr?=
 =?utf-8?B?d1QxcVlUR2JtQitrTVFSSlQ3aDNwS2dSVXRIZy85WkEzYUlqMWZsbHBPdFcw?=
 =?utf-8?B?bGZmWCsvYU1zZzdNcjN5V0NqeEJTdzFLNktTeXlycDFKaHVORFpwUHRHcVlD?=
 =?utf-8?B?eEVNK3VXRlJUcEM0Wkk4bzJXNk82MHRTaW5vWkd6V0cxbHFFV0VLM1VYOExp?=
 =?utf-8?B?ZTREaWJYT2dVZDc4Q0V1bWU3aEN1ZE1UWFNFMFRmYkc1aGgwb3p6NzR5eEZk?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YUdMeGFmWGRLQlpQbjBpMzQrSWlIRFJpRUhFdEZTWnZCZFZLQWdXVmY1aTJS?=
 =?utf-8?B?ck9KeHFHU0pQMURkclBmTVZZckloOFdpMldLT3F2bm9heEJoTDVnVTBjOE5R?=
 =?utf-8?B?dnRBOU5BU2hYejFiM0VrcXVueWIxNmUxVnZRd2ZFb3g0aDRVaG93T0lNSjQv?=
 =?utf-8?B?WXQzOHg2YlYzWW5qcnVBWmMxSHNWdjhVditxZFFJU2wweEloTEdwWWhya24x?=
 =?utf-8?B?eDA1c2dJaDZWaHg2Q2F0QzVKaDRYWmppb3RLcHZNd3N3VmxvTjgzR2VnMjg4?=
 =?utf-8?B?SVMrZjFuMmo2SFBiU0dLcTJNNmhSeWc5MEFzTk5BRGl6WjNkS0hSUjJoUDBa?=
 =?utf-8?B?dUhITXVIRTZNQ1lMalNkTG9tYXVaanFSZy81dW5Lck45aElBU09DMThPc3po?=
 =?utf-8?B?WWZXWEtwaEtQS1NvQ0dhaVNnZGZiVUVpQ0g3UmJrYlVKYWZ6TXFWeHNIZDJZ?=
 =?utf-8?B?NkdXUi9MakQvQWtDVnhZK0lNU1RwYzhOSzhOeTl5OHlndjRHaWxpNGZRTitB?=
 =?utf-8?B?NzVDcEZBOHhGSmpFUVJCeVAwSGVFMTBuT0Y3TDgxSE5RaHZlSDUrZkl4VkE1?=
 =?utf-8?B?cy9qdklHYy9LWXJVTkVpNUJ2cG5QUEEwK0RwQXVVMEFpOUFtYkh3anQzNUFG?=
 =?utf-8?B?ZHdRQ0xpRFhrVTFGd2ZOWFhyMFN0TzZqcURtZkNiL1Fvd0ExUWRnQUNkamo4?=
 =?utf-8?B?WDhQVXZ1MzFOdUdQZ0swY3U1WlJzbU9DVHY0UitmVXhSRW1Penk3WGhaMHFr?=
 =?utf-8?B?TlpHeFJGK3dCNllLRW9WdnVlQjEzQTVFUEF0TkFqdWtzU0RGZnFpeit6Q2R1?=
 =?utf-8?B?dUVDNnBMb2xWZXowWk9sWTNQMGN5Uk51SHh0Mk1LL2VwTHlsOE1SRXNhMEpm?=
 =?utf-8?B?em1MNkZqUG9vOWlYNnA0ajRsaklVQm9rQTNrUk5tTm5ndld4TnAvWlBQd2FF?=
 =?utf-8?B?U1RENzIzbmtXZ1RZMUw1bzZTb2JQMEpaOEgzQWtXVnNpWDE1ZnRIR1Vmdzlr?=
 =?utf-8?B?T1hMTEpsS2xvZ3UybWNjakphQmZCTnNraGRiL0pqQkdmOUwrZjMrd0R5c2tM?=
 =?utf-8?B?YWNiQTZTT0QvbDU3UllrWndnZG1hcitTanpkSEdBSS83RE1SVldZb2dzVGhk?=
 =?utf-8?B?ZHk1YzVZM2IxbzZkYWZyNnh6cTByN2RnT0VvVkVlKzFLUUxBa1hHcUpSSDcw?=
 =?utf-8?B?N3JLNnMyQWFGbElLUWwyV2hXTHVJcWFsMDdERjJDb1Izcjd0eTlEamhMSlVZ?=
 =?utf-8?B?MnF3Z1pTVFNjQTJCTmViOURkcXFZV28xMzZOM0Q5dEU0SW1nclYyL2ZQMGFh?=
 =?utf-8?Q?b60hNxjTyvXK26qELPJXfpsMe4NJmB4nYG?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3eb08c2-5dd8-4d14-90a4-08db1f46c5d0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 20:01:43.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +t5Nc3JI2o7c0i48Gp75TjvvQfE9Pa2CPF9H0PhOkhVlP/4O3wEi4l420oawImstMX8qXKNUJBhHmrvghAd8jRo3+EfCyK7pvV8agCnX+YE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6383
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 6:56 pm, Borislav Petkov wrote:
> On Tue, Mar 07, 2023 at 06:22:01PM +0000, Andrew Cooper wrote:
>> Well yes - more and more reports of impacted systems.
>>
>> Having the full list of affected models is great and all, but how is it
>> going to change this patch as a workaround ?
> We don't have to clear the feature flag on those systems which have
> a fix.

Sure, but why is that helpful?

XSAVES and XSAVEC are functionally identical on Zen1/2 because these
CPUs don't advertise any supervisor XSAVE states.

It is only Zen3 where XSAVES starts doing more than XSAVEC (and even
then, only after the CET series actually gets merged...)

~Andrew
