Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82112709790
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjESMuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjESMuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:50:08 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31473134
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1684500603;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9QpGMXHLf28yi25Yw8XWa19UktQ24AfX69lAVg6gM74=;
  b=UDuBsF9mh8x0oiYMy3ABJLoSnLO2iB0dZU47/c3aqK1ZGFNIN1YWUe4a
   PcdyfydUdpbnnkHWkNh8BbUcwYv4JO7TgBJbgjh0/mQ9QYc0YTr7sRbAD
   Y6gODq6apPw15mqK21k0oXn5KEhhaR/PTp1Mgr9ISPi2Y+DUQhZiCawwY
   g=;
X-IronPort-RemoteIP: 104.47.58.104
X-IronPort-MID: 112119261
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:a9gujK06ok6TcIRaQfbD5Qhxkn2cJEfYwER7XKvMYLTBsI5bpz0Ey
 WRKWzzXaP/Ya2akL4h1Pty1oR4B6JSAnNBhQVA5pC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK6ULWeUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8teTb8HuDgNyo4GlD5gFnNKgS1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfWmVXq
 6YSN2kxcgGf2Of1wpGBcfdCv5F2RCXrFNt3VnBI6xj8VK5jbbWdBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxqsy6KlFAZPLvFabI5fvSjQ8lPk1nej
 WXB52njWTkRNcCFyCrD+XWp7gPKtXqiAttLRefmr5aGhnWNxVYpOhxPD2HisKiG0kmVcY8GO
 2Mbr39GQa8asRbDosPGdx2zoFaApQJaV9c4O+w97QSQ4q7V+BqCQGwFSCNRLtArqqceVTEsk
 1OEgd7tLThuq6GOD2KQ8K+OqjG/MjRTKnUNDQcAXBYJ7vH5rY0zhw6JRdFmeIa2jtDvEyrs6
 yqHoCg3m/MYistj/6+g/l3IjCmEvJXFTgcpoA7QWwqN7htwTJy0e4uyr1Pc6J5oKIefU0nEv
 3UencWaxP4BAIvLlyGXRugJWraz6J6tIG2CqV1iBZ8s83Kq4XHLVYpIyDh6JUpvYoAIdFfBZ
 U7VtgR5/pJfPHK2K6RwZuqZF8su3YDkFNL4SurTaNteJJR8HCec5z1nb0OU22HrkWAvnLs5N
 JPddtyjZV4YBr5g1yGeXPoG3PkgwSVW7WbaX5Xy1Rmk+buYen+OSL0BPUeOb+Y296eNqkPe9
 NM3H8eD1RgZUOT4eSTR2YoSK00aa3k9GZ3y7cdQc4arJA17BmwoFtfVwKg9YMprhalYmurT/
 W26Qglf0lWXuJHcAQCDa3QmZLaxW5969Co/JXZ1ZQru3GU/a4Gy6qtZb4EwYbQs6O1ky7hzU
 uUBfMKDRP9IT1wr5gggUHU0l6Q6HDzDuO5EF3D9CNTjV/aMnzD0x+I=
IronPort-HdrOrdr: A9a23:kj++565iwlHNiOAkvwPXwa6CI+orL9Y04lQ7vn2ZFiY5TiXIra
 qTdaogviMc6Ax/ZJjvo6HnBEDyewK5yXcT2/htAV7CZnidhILMFu1fBOTZsl7d8kHFh5ZgPO
 JbAtND4b7LfCZHZKTBgDVQeuxIqLfnzEnrv5am854Ed3AUV0gK1XYdNu/0KDwQeOALP+taKH
 LKjfA32wZINE5nJ/iTNz0gZazuttfLnJXpbVovAAMm0hCHiXeF+aP3CB+R2zYZSndqza05+W
 bIvgTl7uH72svLhyP05iv21dB7idHhwtxMCIiljdUUECzljkKFdZlsQLqLuREyuaWK5EwxmN
 fBjh88N4BY6m/XfEuyvRzxsjOQmgoG2jvH8xu1kHHjqcv2SHYTDNdAv5tQdl/851A7tN9x/a
 pX1ybB3qAnRi/orWDY3ZzlRhtqnk27rT4LlvMStWVWVc87ZKVKpYIS0UtJGNMrHT786qogDO
 5yZfusrMp+QBe/VTT0r2NvyNujUjAaGQqHeFELvoiv3z1fjBlCvj8l7f1auk1F2IM2SpFC6e
 iBGL9vjqtyQsgfar84LPsdQOOsY1a9AC7kASa3GxDKBasHM3XCp9rc+7Mu/tynf5QO0d8bhI
 nBalVFrmQ/EnieR/Fm5Kc7sSwlfV/NHwgEkqpllt1EU/zHNfXW2BS4ORATe5DKmYRaPiXZM8
 zDTa6+TcWTalcGIrw5rDEWa6MiWEX2b/dlyurTe2j+1f4jebeawNDzQbL0GIfHNwoCdyfWPk
 YjNQKDVvmoqHrbFkPFvA==
X-Talos-CUID: =?us-ascii?q?9a23=3A6SHUIWtsWiikw30SlwbEfsjr6It+dmSDln3PenO?=
 =?us-ascii?q?kGHo2Tf6XamWr5o1dxp8=3D?=
X-Talos-MUID: 9a23:B5TiKAqLMonctFj1Wb0ezy9hDv1a4v30MhkcwKpevOKuaHVgFDjI2Q==
X-IronPort-AV: E=Sophos;i="6.00,176,1681185600"; 
   d="scan'208";a="112119261"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2023 08:49:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+6ZXVXyM/syUMNX9tfUX1QuZlCMIbSj1CdJWYBKw0N3vaHbq7dN3E0ln02q+dIRhKapwlQiMCfM2iFOiy6LJXjPpnH1F2ooa5EbiA+N5clY+FrEgzr+QUoIkz2Gb2mbV85kamBN+obcEYdTjPEOKYM+SSPTiTzTHJTU//DPLuwbG37UEYBQPdMb3T6w94v7GplTPhQNbeFggpj1GoKvIYjZ4r6qg/cdHc3mNB6mZwVvfZ0bY8tEI6JelruzqCMEiIs/STUwhCv2Gdwh6/W3xSF+8PDiC2/3b9mNtzL8/owptH4A8ixV9tzceESiK1iixp03utWfRo8aN0hbroSsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDQBl+uRnD5Rxb5ncMwm8f/5UoO1di+Yo3Jv2boMr5Q=;
 b=a/cbCsaquwgYn/k37srtbka6CKCrreEtFthMba7R9kchzLNoPF1gGs2X0+wLmAu4jO+9jFS/H/HCfA3wiXeVUYhpLU8QUBbe7iY3+46xoTwFqnE6GMqgPzFEBwyJrFAnkmLdttPv5dUm6y92Qj4YsjuUOXMyx7EYOB5B2CVyaLv/gcvHkxBkaihcymdw4CsZ8ki5Veovzl7P6fq1Vqa9+sM6XLDqKxbLU+44yODBpy2wJJ0CYBnj9iHMF7UpSX2GBgL501mgEcmLL6b2tUDPP7TzOBEKmp1Ip9G2J97JucvZ6kgqIFFIUcN4GbDKLtkrSGbdu+b594zpwxEymFOORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDQBl+uRnD5Rxb5ncMwm8f/5UoO1di+Yo3Jv2boMr5Q=;
 b=Gajfih0x2xIO0ginFwPb9cjRZyEE0Weyp1vzyAIKrXvzf189xttvuWbkpOxH5fMhHQ6OLu3RcyMmrdauv84MwHyRpq21BQy+9sqVihO/9RisaedLIJPIe/gXpR2EVBCjSi6/nr+r44O1QXG580qoNY2qM6BxtNVr/DHGe0LQVLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MN2PR03MB5295.namprd03.prod.outlook.com (2603:10b6:208:1e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 12:49:54 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::81d5:6cc1:5b52:3e0b]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::81d5:6cc1:5b52:3e0b%3]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 12:49:54 +0000
Message-ID: <8617570c-6dc4-74f5-7418-98f04f7e0ece@citrix.com>
Date:   Fri, 19 May 2023 13:49:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] x86: always initialize xen-swiotlb when xen-pcifront
 is enabling
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
References: <20230518134253.909623-1-hch@lst.de>
 <20230518134253.909623-3-hch@lst.de> <ZGZr/xgbUmVqpOpN@mail-itl>
 <20230519040405.GA10818@lst.de> <ZGdLErBzi9MANL3i@mail-itl>
 <20230519124118.GA5869@lst.de>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <20230519124118.GA5869@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0093.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::8) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|MN2PR03MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc79e00-f35c-41d5-6b08-08db58678ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWsnDQcEn93kCxQ7xiRTxF9YgEbPHjuIGZI4ax04Svl3MgT+eQDSBHhuH84Z0KQS8hy42JzUY453JBe2ZxlbzFokUIZU31tZiKmFrVjOcNvotcPpSYdV33fZuIosD/sT/0vMx1XPOVGTcLd3RMjZ4N117oMix7oXb0b3cv4cUp+g61yqbn458cdt4fxzRno+IcAdoX4H+URcqGOIpmbPG+WVlGJWdRsZTJQIF6dtSCe7WisUXylHqO1r4tb8Tr+uVNgpwYdEtq4EZ9x20CMPYY4/C46xlADZD0cLt8N0SojD+zYGRIFatYSqC3VsnSLdtU+I8L1NxOVQrdi6OPtxcoDExtv7QTFEhAoWO+YjvNIBN0ReXeKLmH86TvMpm3mVYcyf8g286fwg2uN1sioPC8a2WVXWrwDWyoK0uXDeSOo0Fvlsv2sBcY37xMwCT1ze7Zf9FZixdkHTP5eoBOmoWq4B7olTYnqe/ZV6omxLdQ+4ATTJKKmFKRKYc93OjCvZj6EbCkBNJzCUrEslRMizm2Afion5D7Eww6Bqpu+6mnvLEHBH7Pwwi3fLoJIyqi97QkBzcLe0GnsJGbZ74fH/KaPshcxO11B83hTqmgjrNf6V6bTetB/USMkS9F/HFXJdihnx41L9ZCHaHBjDu5swGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(31686004)(4326008)(66556008)(66946007)(66476007)(478600001)(54906003)(316002)(110136005)(86362001)(31696002)(36756003)(83380400001)(26005)(2616005)(186003)(6506007)(6512007)(53546011)(5660300002)(41300700001)(8936002)(7416002)(8676002)(2906002)(6486002)(6666004)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODBIeGZtTTZUbTYrMEZPWXQxWEw1cThZWERWQXh0bHdOMXNpY0RQQU9ONzZM?=
 =?utf-8?B?dld0WHNFYjNOT1h3NXlYUmY4UTVrTGpuNFVOdDJsREdMb0EvRjFBdHVES1RP?=
 =?utf-8?B?Qlo1cElocFkyRjlaeTZYSjBxSi9JcUFUT2orenlEdlgwWWszZnZ6K2pUa2pp?=
 =?utf-8?B?cUVrRmV1aXNQbFp0VGRqN1NTSmVoUzJGcG00RmRHWHBMSHN1ZHNpRE81NXg0?=
 =?utf-8?B?VFJYN1ozNjJqcjkyVjVzRGxZVU1OSmFKNDRYVnBHYkF6SFNMbXVGd3d2T1Ji?=
 =?utf-8?B?N2M2R1V4b05URlpOU0pFV3hKczN1YWh3S2pJMFpETFNYMm9UT1lnLzNZNnhn?=
 =?utf-8?B?ZmhQMHBYeUJibm9PcnFER1J2MTM4TzZxc2tFQmdFOFFJanR5clNCZ29jMjJT?=
 =?utf-8?B?Wk92aUtVczE2Y05PeTBQS0lza2REQVZIRlAxRHNQMk1sV2tjZXhzYm1tM2h6?=
 =?utf-8?B?U0dXeXdGd3F1bWtTd1ZtOS9tQXNIMlloUnc3TDBZdExJUnZQOFhOWHA5N0ZK?=
 =?utf-8?B?dXRzV1VtdktsMVRvblo5dTEyaHpTWUxHMUVUM3NTVHkyZUJGaUpOSVJBZ0NC?=
 =?utf-8?B?OWNGVXVIWHFyV0Yra0tsUWhHcm1ZQjlTc3dFVjNkdnR6dDBPMGNpNTB6Sk93?=
 =?utf-8?B?ZGdDNTdsVWtNMy9TUDFudS9TanZva0V6THJ6Y1dPUlVPdXh2dmdQZEFjUVNz?=
 =?utf-8?B?T2hZdEw5L216MUFLRnk3Rk1uZUJURXBKRjNiL0Q2KzdrOWJSUG93b3FCZU5J?=
 =?utf-8?B?OUxHZkhvOEN1aXN0Y3RRUmpRUkdrZDJZWDFGbjRtSFlXRmtlcHQ4aitxWnBP?=
 =?utf-8?B?bW1Tc2s1cEgvMU95aHNPUlhITld6VmVVUnErYUV4d25heHBFQzlPWFY3VjZB?=
 =?utf-8?B?a25oZ2MwaU1YZ2NMTWRBQmFZdlBlZDBoM0wzM0dJRlBhL01vNlNXTndzM0Yw?=
 =?utf-8?B?S0xYNkc4WEFteDhqZ1dyeWpMYnp1OUhFbGswa0ovdHJ4RlkrcnRURHBwS0pa?=
 =?utf-8?B?NVJQcnd0dGdyVWdsM1dFSi9hQ3NpUEs0WlFFWHU1ckZKOWdVeWNKcGRvMFBZ?=
 =?utf-8?B?UFRydkhrSXJvdndDaGtoUmkwU2NPb1g0LzhIdWtDaHpndlZkRTNjSXBCb1R0?=
 =?utf-8?B?QmMyTHcrM1NqUjJpdzdpQ28xU3BLbHU1VXNCL29QNHFqSnJVd1pvUDlYZk9u?=
 =?utf-8?B?eENHbEd0RzN5NzBZQlRIcndsdU53TDBYeWg0Y0twY3Y0ZUZsT0NrdHdkYW1P?=
 =?utf-8?B?UVd0SlI3OXlHaVVMOTlpWFlIUmxXaU5EY3RTcTRuNFVCaWs1TCtWUEw2VXlr?=
 =?utf-8?B?MDFhMVRIa0Y0eXJSVk9rWTVhZHR4aTFhNzhBdExtRTVJWFJmTlZ5TlM1TVJH?=
 =?utf-8?B?K1dXUXZhNm9oQ2tpWkl6dXFUUnM2RXF3a3MxM3VueWZOU1o0dVcwRFBxeHRR?=
 =?utf-8?B?RUY1QzZHQnFTdXdhM0c2UjhEOEFnL3Brek9wNStPa2VXcG9CSDc1eWpuVWFw?=
 =?utf-8?B?bVFSSkVCODlvRXNkT0NOK0dkVXJDSnNjRTdBWmk2RUN3dmYzSG92VG83UUtu?=
 =?utf-8?B?dmRDRlA0QldYU1MyQ09NUXY0Vk05a0FMTnpSRVhDVHNDMTZOSFd2cVlHYmp5?=
 =?utf-8?B?VG9ZazUrNFdab1FVRkxFc2pSeWs4bGorMHAxN1c2NVpJdlQvM2oxUUk4ODVQ?=
 =?utf-8?B?YjZaQkZ0aXUvUzRaRzZZMlA3U2FVWXBwQ1ZPb0hpK1B4Q3VRZFc0UDNHb2M5?=
 =?utf-8?B?RCsyYS95MkVpVllIN3J6OHNPT3grQnFyOGxxVWRBTTliL0RmcnZoS09hOFZW?=
 =?utf-8?B?emZZSEFVdE9lUWo1dHFYeFVKVzVBMW43QWNQMmxkcFhGY0NCNk5kR1hmR09m?=
 =?utf-8?B?ZFFzYWR2V04yU25zNGpiSEN2VTlmK3hjQ3ExNFo0SkprQXVad1QyS1ZwZVND?=
 =?utf-8?B?NFVJdEllSDdGWDRndkh1NWZVaGxTNjFaSG4wLzd2Vlc4Z1ExV2tVWEV6bEIr?=
 =?utf-8?B?M0c3bk9lcDZ6T2JlZitFK3FnR1UrWU4vZzhMakRtSmcrWDNQMEV2aitsKzVi?=
 =?utf-8?B?ZTZEWEV1WjYxT1QxQXRZb1kxa2U3akNuZGdnV1JsSkRhYUt4TlY1QW1XMXMv?=
 =?utf-8?B?WEpvbzdzNHFpVXNxWHI1aGpTRm0vT0RLOERoYVJmV2t0UTJHQlpBcEQ3dUJ3?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b251L1l1QWM2K1hvanlaM0wvVDlHYjRvWko2V0YwM3d1MDFlZVZUekxGMG45?=
 =?utf-8?B?eGVhM1ZlekZZNUxVRk1GZEJUSDRtRjZlRUlwcUJWTFpwdkR2RmlvY09obVgw?=
 =?utf-8?B?K2J6QzJQa2lQNGNUMWRwYjFxa3V0MC9IRE5id2tyTzNtY0ZSMjFMY3hkU0J0?=
 =?utf-8?B?SDltL3NQNjIzVXhvZ1JlWEZHVXR5NjQ5K0dwNXNSQ3ZqMGJaZkI4L1Yvd3lE?=
 =?utf-8?B?aVdDc2tqeE0vNVFPMUNLZGZlS291RFh3dW8rejlabG1xNmJ3T2pHVG04aERk?=
 =?utf-8?B?dmtxSURhQnRhNVpUWjh1M0NZQWh4TkhldWxNYnRFWEF0L1BJL1ZUSUtsWFd6?=
 =?utf-8?B?VTVUMFhjWG9rc3BPazhWdG5kQ3BPQTNDQnY3MUxTbWcwZWIvMzdvWjVmQ3Nq?=
 =?utf-8?B?cFNIcVROZkVObU9xT2RIWWJVbXJiRFJRL3VsL2VCVTZaRFRLOHJpNUJiL29t?=
 =?utf-8?B?YUVMbnFaVjZVaHhnUlppTnJ2ZXJIV1V6aGhKSXYxekRsVjNpVGU5T3d2VGRO?=
 =?utf-8?B?MGhqSFlyb0p5bGRIaEhVaGZnek5LWS9ocVNNK2RQRkdwcGd2VVBCNWdQOENO?=
 =?utf-8?B?S3NGY285MFdMb2lhZmZSWWFSOURxM2RINFpKbnNDV0NCQW1QWW81SURWV3I5?=
 =?utf-8?B?a0VnUDN2UmVSYmxjWjVnZmZTazJoalFmaHN3eTBFUzhKeUV4SzJYWHcwZ1Ru?=
 =?utf-8?B?RkV6WWZQZ01sYXdhR1hoL2tva2hKaUt2RjJ5YUNmajIrVUZ4RFhCT3pyaVZj?=
 =?utf-8?B?NFJFS1psTmI2MitEalMyQ2loaUNzbXNRQXBiMGE1Vk5mWmlHVUVLdmdCVk1t?=
 =?utf-8?B?eDZHQjl5NTdTM2VlYks3amliRk5lMU94a1cvYVN2a09BWEIycXlqczIrSERD?=
 =?utf-8?B?Nk5ZVHhHOVdTQ3NrVDFQU2YxWFF2UkUxZ1lRUkx1dEVjNUJtSTR6Q1FOQUpX?=
 =?utf-8?B?bmdpZEpzTkJ3VERla1RaMkN1VnUzekpBeVNYNWQwTzdHYlpvVGRxMWpRaGtU?=
 =?utf-8?B?NmNNU2xhR21JeW9LK3F6TFVxOGZLS3RaR2gzVnByZTZKMXRtNEQ4d0NMeHlV?=
 =?utf-8?B?MVMrMHpwSVpTd3FCcU5hRWRKdUo4SGdpZzhnQkV5cTZ1eVVXS2dlZEJWR3pS?=
 =?utf-8?B?RmdqdlQzUG5Ra3MweEdwTHVaNWRXS2Zmd2hhc0xBTVkvQncxRTZJbW4vZ2Rv?=
 =?utf-8?B?eXRwUlhjWVRtREJCUFdrUmk3K2wvQVU4WTZ5djdhTmdvMG9XZUFZM1BqRzd6?=
 =?utf-8?B?bkNsSkx6RFg4MHFoeEtyT0NHQTNUbm92bUhsZmpGelRMY1UxT01tdW1vT1hv?=
 =?utf-8?B?Qm5BV1U5RnlLZldyNDJUb1BpQXhnL0FISXlWRlZndUpaZW16WlhSaGlMUUFK?=
 =?utf-8?B?cTBJcGZpWWRiYktENForM2ROc1g2ZWt0dnQwc3FTaitxLzZiVHQwcHN5endi?=
 =?utf-8?B?OGxka3FGZDQxYVNYdGFNUFFLa2d1eDdGeWc2OFpjeGs4NitiKzFZdU1qb0lz?=
 =?utf-8?B?NlMydjV1eWFEZXRnRWZPYkxGYzJEOFBrbmx0TUdoL2FwdVhFVjNkVmZ2Y3ls?=
 =?utf-8?B?VzMrOWk1TlFuVGlvcE55bUd5OWFMUVFYUEk2bnBkalNmZDd1eVZyeElTdC8v?=
 =?utf-8?B?bU9saUJOMU96aFRETTR2YVNITXNxeHc9PQ==?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc79e00-f35c-41d5-6b08-08db58678ae3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 12:49:54.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nb170M4+s1uheOmp+e5TioG2rQjxhz3jbSKB57FKIJh2ujuNPrazcw8OfmUPpkncEXT3zVqa1pdHiBrCcIicHJpQem5lb/SEKdf2g1Q4MOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5295
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2023 1:41 pm, Christoph Hellwig wrote:
> On Fri, May 19, 2023 at 12:10:26PM +0200, Marek Marczykowski-Górecki wrote:
>> While I would say PCI passthrough is not very common for PV guests, can
>> the decision about xen-swiotlb be delayed until you can enumerate
>> xenstore to check if there are any PCI devices connected (and not
>> allocate xen-swiotlb by default if there are none)? This would
>> still not cover the hotplug case (in which case, you'd need to force it
>> with a cmdline), but at least you wouldn't loose much memory just
>> because one of your VMs may use PCI passthrough (so, you have it enabled
>> in your kernel).
> How early can we query xenstore?  We'd need to do this before setting
> up DMA for any device.

Not that early.  One supported configuration has xenstore not starting
for an indefinite period of time after boot.

> The alternative would be to finally merge swiotlb-xen into swiotlb, in
> which case we might be able to do this later.  Let me see what I can
> do there.

If that is an option, it would be great to reduce the special-cashing.

~Andrew
