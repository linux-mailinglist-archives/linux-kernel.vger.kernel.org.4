Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA0A675FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjATV3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjATV3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:29:37 -0500
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA0E73EC5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1674250174;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HwwbkxHG54FS3XmjYUmTxlpBtiiQRsXSyGK9pEOPask=;
  b=fc+yp78MUKaUN5KQnnTJHSFZkMfwCFo3/DUfkD8TJgh2835oYC/qKdT/
   sFy/YEqmLGEMZmpAWAaBAkLHZxusZ/ggw2TlLURo0zzBXJ8jrUgtLUkXT
   d4/f16G/UidE45OSabvYebf6SHaWaNGTNyGd0SMvWyNUJgxaVewWdFss8
   g=;
X-IronPort-RemoteIP: 104.47.70.104
X-IronPort-MID: 92482940
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:QxrTQKmOxGywIJBDdNPOyOro5gwyJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJKWTyPOa3ZY2bwKot+b4i0801SuJeEyd9jTwBqrCBgHiMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6U6icf3grHmeIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWfVSowFaYCEpNg064gE4p7auaVA8w5ARkPqgS5geGzBH5MbpETU2PByqgKmVrNrbSq
 9brlNmR4m7f9hExPdKp+p6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTbZLwXXx/mTSR9+2d/
 f0W3XCGpaXFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 eZFDSkWdkyPvL27/JKUeu5OieN/INa+aevzulk4pd3YJdAPZMmbBo/suppf1jp2gd1SF/HDY
 cZfcSBocBnLfxxIPBEQFY46m+CrwHL4dlW0qnrM/fZxvzeVk1Q3ieCxWDbWUoXiqcF9t0CUv
 G/ZuU/+BQkXLoe3wjuZ6HO8wOTImEsXXapDTuHorK822DV/wEQeMC8IRwuSpMWEqXaRRPV1F
 U83o3Ex+P1aGEuDC4OVsweDiH6ctzYOSsZXCasx7wTl4qbd/QvfBmECVTNHQN0gqMIyAzct0
 zehj9LvXnprsZWUT26Q8vGfqjbaETQaKX8qYS4CUBcf5N/isMc/g3rnS9dlH6mdlND5GTjsh
 TuNqUAWja07hMoK2qPru1zK6xq0q4TEVBwd5wPZRGup4wp1Iom/aOSA5VHF4LBAJYCCQ1+pu
 HkChtjY7eYSAJXLnyuIKM0dTO+B5PufNjDYx1l1EPEJ8zWr5m7mfo1K5jx6DFlmP9xCejLzZ
 kLX/wRL6/du0GCCaKZ2Z8e7DZssxK25TdD9DKmMMpxJf4R7cxKB8Gd2f0mM0mvxkU8q16YiJ
 ZOcdsXqBnEfYUh68AeLqy4m+edD7kgDKan7H/gXEzzPPWKiWUOo
IronPort-HdrOrdr: A9a23:aD2ASKv5iQLQi0ycI1PR97Yj7skCpIMji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJhAo6HnBEDkex/hHPFOkO0s1NuZLWvbUQiTXeJfBOnZskTd8kTFn4Yzu8
 ddmsBFeaXN5DNB/KHHCWeDYrMdKe28gduVbKrlvgRQZDAvT5slwxZyCw6dHEEzbA5aBaAhHJ
 7ZwsZcvTKvdVkec8z+XxA+Lp3+juyOsKijTQ8NBhYh5gXLpTS06ITiGxzd+hsFSTtAzZor7G
 CAuQ3k4aeIte2913bnph3uxqUTvOGk5spIBcSKhMRQAjLwijywbIAkYLGGtCBdmpDQ1L5/+u
 Osnz4Qe+BIr1/BdGC8phXgnyP61iw11nPkwViExVP+vM3QXlsBeoB8rLMcViGcx1srvdl63q
 4O9XmerYBrARTJmzm4z8TUVittilG/rRMZ4KUuZkRkIMYjgYJq3MUiFQJuYeE99RvBmfca+T
 xVfYnhDPU/SyLkU5mWhBgi/DWWZAVOIv63eDl+hiWr6UktoJlY9Tpo+CVNpAZxyHt6cegx29
 j5
X-IronPort-AV: E=Sophos;i="5.97,233,1669093200"; 
   d="scan'208";a="92482940"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jan 2023 16:29:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drwi3+f8nOjDshSzytszK6lvozHdyrUBTQD5v8Y3CuxxWZYUi5hh1/xJr0lvV6U5toJs+JOdSLNcAFr6CnRNgbBtpkVMYqTX52HWEn9a8S2Kl6Egbq2aLlFGI0lsv4R9FLVEIrPpQNpIzUeVLirXDmqm99PUxYifnbzOG7GJj6uXuVrNDS1I8FUruHlIIZuX4LmyHtsG9Nq09ovxI5j7g6GnaN2P3h0sh7KIqo8QzxHfYm1603a1Viv8NwCGF+w/eXVhFpLZMSJOlScUlXfDdYBPcLREK6lJGwfphY/HMhtG9LxsXgkWk74BkXwO6zW5KBLElPVm6kBrfNbn59fuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwwbkxHG54FS3XmjYUmTxlpBtiiQRsXSyGK9pEOPask=;
 b=eGFXl63Ql652wVwAh5tqK1kI3BSHLQWfdkQ9FcJOg+3OyKs7ZTM4vk8E3Tciuy+OPEtdDeZf8STczIBX5kh35AB9CgDURZUUAgZCXcdFMWkj15lo5cv3moqhP9swyv4pNewP4e0QQaXn/bo+vXI4R1WVyMglPG8mOPdcTf3VJPV9U+Te8eKbbIhBEKXbhTlFLO5YRXU5RFUPhYEHNBfYoWvFC8SrFb6J9oAMX9CJuzBTdtl1obRZZ5gwDZi6vBRbD7AanlzcAk39NpEW/oVfcU84GK74lRiul8PPb98b1v60mjxCLQPt4mf6OkkN235ZpOjKkXBOJmeZiNGqazSzgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwwbkxHG54FS3XmjYUmTxlpBtiiQRsXSyGK9pEOPask=;
 b=SFiBq1F2MphnB+DghS9WPd28ILlO8nmTE7iHZiJfRsSK8um9obmFTmTjNjIP41ndsmn485jgPD/u536T2GP1g5ATlWOOCnC8UzSj58JZU1kLweXOS2xmii11XvKf4g6vRZKDptBkiEMUMOIiwtvu8wHLBd4Yqho6KqdvGM/uApw=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MN2PR03MB5005.namprd03.prod.outlook.com (2603:10b6:208:1a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 21:29:30 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::c679:226f:52fa:4c19%6]) with mapi id 15.20.6002.024; Fri, 20 Jan 2023
 21:29:30 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Li, Xin3" <xin3.li@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: the x86 sysret_rip test fails on the Intel FRED architecture
Thread-Topic: the x86 sysret_rip test fails on the Intel FRED architecture
Thread-Index: AQHZLQBIyVP56rEBrUalKcRbIW7nK66nx8KAgAAFYwCAAAH1AIAAA3QA
Date:   Fri, 20 Jan 2023 21:29:30 +0000
Message-ID: <e1df7cdf-b265-4bb9-92d7-f20a656931fd@citrix.com>
References: <SA1PR11MB6734FA9139B9C9F6CC2ED123A8C59@SA1PR11MB6734.namprd11.prod.outlook.com>
 <5d4ad3e3-034f-c7da-d141-9c001c2343af@intel.com>
 <eb81f7f2-d266-d999-b41a-e6eae086e731@citrix.com>
 <A87231FB-5B5D-46B7-9888-5770039B7EA1@zytor.com>
 <bf1ef4eb-4cc1-c862-287f-25e9144e1291@citrix.com>
 <096C16C1-5139-4775-8B45-B5A33F1C6F6D@zytor.com>
In-Reply-To: <096C16C1-5139-4775-8B45-B5A33F1C6F6D@zytor.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|MN2PR03MB5005:EE_
x-ms-office365-filtering-correlation-id: 26d90845-d34d-48cd-cabf-08dafb2d6aa4
x-ld-processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F6wKwJZN+VjI7Kd4IjXgG3HcTr1Lgy0FI6qYEcxs3E2xn63Su7dBMvk1FX8eE9q/ZDfB8D4hjIa1Vq8E9VE2oPDMlwTtmbNRNOZ/13bE+EC1LmlsTXGxN/PaYfyluq59NOvYfUgNgbdkLCw2fUcGdqG8Aw0SscM4keKpmahy4xn7cd/oWqlvysmnzVxTY99tM0xgdfOPP7yVV2b9WjAIUYcGT2GUsfonBnxsFiMIm4PFA7Mk5UvHW/HghJszse2rHM+jyWSeuzHTSCVFsgRiri6Lmz28K3LSyEYiOG3nDwCQQLuJgKUSD7lntIrCstcKxPFL6+ZEbVHTqUjqTjf28BN7Rb8gJJ4BDOlHW0pQGP0AvKES5w0OLnrKPIJV9jCrQhKUAQ52TSNbeHtzC+GlPQf9TDB/d4MtsHWCIikqXvjWhUzFJ8fm1IfIsx6sY4iwDeIDngkcbdHU/mOeSA1v6hcj0/eLukVYSWH7A3BgC+Qf06IJ/c5GXcnVpP9Rq3K7TJqMxmTmAHDd7aatSxqo5lc4Ot2Yco4TL5pVYWcoa97Xv9Tps8YsPhlw60J9EMb3/F3jBMDgiuElghCBCv/m4WqavVHOmhiItwsE7RcXvym3kJ0iEGowqCNDt8R15AjORDgvhH2hT9eH1H0Zbgo+pm5US7Ce8dR0W82J6ZvBM243ph+mxcEDU/769PNplKWP2IrInamCHqE91TTeDO383APZ6Y1VdBaH3SFOQeomEJ0RsdGHeKKHCG6k+7ffrJiszjR2BPIN9yDE2PTr9KDbVB6Xfl13gMKTNs2b4RQHNdk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(31696002)(54906003)(2906002)(6506007)(478600001)(71200400001)(53546011)(110136005)(5660300002)(26005)(7416002)(186003)(6512007)(41300700001)(38070700005)(6486002)(64756008)(86362001)(66556008)(8676002)(66446008)(38100700002)(4326008)(8936002)(921005)(66476007)(91956017)(66946007)(316002)(2616005)(122000001)(82960400001)(76116006)(31686004)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW40YnlNTC9jYzNXMHBsQUNzbGNFVFNRMGtxZXhhK214SkFlWFl5WnNtSFln?=
 =?utf-8?B?TVd2a25HQmQwYnhCVy91bzVZWUExWVNGeTE5dHlTNSt6VHZ5eTU0OG5YbFNX?=
 =?utf-8?B?M1FzdFcrQjlpVlJUbEZva2hsKzNZZXpjaDRUMWczVTZMcVhxYXh6ZEc3cW41?=
 =?utf-8?B?eXljdklyeGlFeHIyN25PbkY0Z1NXUUsxcnArY2hHRzAzektYNXdLSjR4OEhP?=
 =?utf-8?B?SkxmWkM5OXhVMFF1aVkyTFBNcDF3bXU4UnFxdzFuRGx0R0dJbXpTL2svMjBj?=
 =?utf-8?B?Q0habU5yVThtREwrdngvTnllREhsQkcyNHJFUFNrZkxFMWpvSU8vdW1wZmx1?=
 =?utf-8?B?VnJDWlNodWJqNi9MRHkrZzlGWklTNDR6dG95S2VHK2RPRzNVNGRDWmtETTdV?=
 =?utf-8?B?blk1eEZvbHV4THdzUHdlMnNoWmZBd214cXZzWnYwaTgzZ3lTTkdReVdHeXVT?=
 =?utf-8?B?MVowMllMWmhvU0FyOXhkODIyK0hKMitnNkVTYlljY2dnaHhacFE2UmJkN0Jq?=
 =?utf-8?B?WlNDVjc4RzNGS1JOdjFsTkIxVlZ2ZU9zdFdReXk1M3pxTnZvNEJhaW40cncy?=
 =?utf-8?B?aWJJS2k5VmxTVHJGZkszRm1yVlRDbG9ZMDNjTEpWVzdkaWErMVVIRUVzRkRk?=
 =?utf-8?B?aElKUXBMdXVxVHFySGFDSmhBcldMV21WUnc5b0JMRWtCTitCS2JSSjdnY3Fr?=
 =?utf-8?B?Z1BTcUtGa0d2dFJkN0t5KzdkWm1ObUo4TmJvMzZpMTZPVE4vRlMxa0tEUFJs?=
 =?utf-8?B?OGhRcU04YzRKcm9Wc2ZkTWxBTjJKNENrRUp0ZVdBTkRvdWJmbkUyVVRNWUpX?=
 =?utf-8?B?WlIvRitiaDZhdFFhRXNCNytrZnpoV20xbUFTV0g2bTlsSEJ6aHZzRDQ5YitN?=
 =?utf-8?B?NnpzcXRKZHV6QWNaUUhPVGpPSDlROUZaRzR1dE5yc0JYd00xd2phVTZmbTVP?=
 =?utf-8?B?YktMNHVERFMwR1JzdHM3TmhTb0FLY3FkK2h5SU5mWk9oYXlaQytkNEFiVmV5?=
 =?utf-8?B?QW9NL1dUMlZ5bytHZFJaVEhxR1hhY1FJWjl0RGhxN01DclVKUGx2bFFPL3gz?=
 =?utf-8?B?b1JlOUlHdkZWZXZtcHZWUUZUallaaURBcTBVaGxudWJndHpOV0ZFbDNYMTlB?=
 =?utf-8?B?aW5UT25JajFhY1RzeENDZmVxRTdoRVU3UlM3b0ZJVlBBZDlWWHhwNVl1bTlu?=
 =?utf-8?B?S25wenl6L3NnS0xSR2o2ODB6dXVtL3JrbUxpMzEweW9PR3ZpR2F3bndqT0RU?=
 =?utf-8?B?dXlFQ0NwR3pqdlZGN2dCYVhVN3p2NUxIbmxOV05PSVJIVGN3dzRkaUtKMDdM?=
 =?utf-8?B?T25Yam5zQ2ZnN3BzdG1yajJ0WmVualRscTI2cUw3WWdxL1ZOR3BCMklRU2ZJ?=
 =?utf-8?B?MUVyRUFmYllGdmpGRUtaODdhb3VvSS84YnBKa0k0S2lrVmtpOVNjZzVJNUNa?=
 =?utf-8?B?enBFc0ZVM3d0V21BbmJJV2xVeWNnQ0hoc1RGcUhGK1dNcUt0dlAwWDY1c3BJ?=
 =?utf-8?B?L256TWJCR284ejFsWkJDdVhWSklNZXNGMXFaaXZ0SDZsUFFvN3VjZWF4VWlN?=
 =?utf-8?B?WHhaY0p2S3BIcDdBTHZURHhFbjI3TzFVUk1pQmpqdmtLL1lEbjlHRkJrNTRZ?=
 =?utf-8?B?QnJmOTdURW5vWUt1WHZldHBabTZkelZGeGVhQW1TNTRvSFREVXRKeEx6NUtp?=
 =?utf-8?B?Zi9jUzNSVXZPMnVjdVNyOFlnOGhoa0dmaHo2aGY1Y2dZUytPZHZPMG5lN0V5?=
 =?utf-8?B?c0krVGY5KzNvMzNCdHcvOWxsUVlpaDZDMGtxN1ErY2JMd2F0YURhcXpEWGxp?=
 =?utf-8?B?dURlYlhoaHhQK3BsV0RHaEhBaUNyeHFoL05BUGR0ckNqd3l0YnhVdlB5TFJM?=
 =?utf-8?B?aEd1cWxxQ0huQ3NqVzVVNkpuODgzcUZFaFpjdHpiUzFMV0padEY0TW54cGpG?=
 =?utf-8?B?UURneFdROHdVQThxQ3dkaGxSaE11M2ZFQXd3aDJSalBuYXAyLy9MSzVoTHU5?=
 =?utf-8?B?ZGxGcmo1cC9CZVdzUlF4VEhrTDlSMk1NTzhVUVdPRUhYRFhUdWdIaXZuUnJ1?=
 =?utf-8?B?eEs5K0ZOOElYMXRxc3NnUFNiTksrVTJ6dkd1emd4NlZSOTNITVZodUFFMlI5?=
 =?utf-8?B?N0Yzc2NsVURKbWNiZTRTU2NRZjJ5MzY4dHQxSkh0L29IZnQxdXhNMTJBcXlR?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA891D1088926C4DB1EB94351361B825@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VUQwM004ajFtbGJqV3gyN0I2WHRSZ1VRcHI1ZFFIalA2QURNVllyR0tmU3Er?=
 =?utf-8?B?NWhLTWV1a0xoSkoxRDEzaGFUaEVuckZSUGlXN0lJZzU0RVppalhZcDFOVFVR?=
 =?utf-8?B?N3RXbXZleDI3OWFjWWxZV1VIc01HNDYwUzZzYmhyL25hcXBvTHJRZkxFYjBt?=
 =?utf-8?B?Mnh3Mkc0dHV4WHo0N05UMkpuSjc0a3NjeWJzTzd2ck9wL2dYLzIzRU0xbWRn?=
 =?utf-8?B?RGN0QXhyVmFxcWI5VW5jTndJUXdzNDNSakhxcjdsRWVQall3aksxcUkwN0Zj?=
 =?utf-8?B?RVUyNnplQjBSWVNzV042VTc0WWx6N1FLV3NvQmp6d1NjRXJpd1F0YTFLMmxM?=
 =?utf-8?B?d05MZlhRNzJ6aytsdGZQOHRFWXNOTUkxZ3hIQ29kTFNrTDM5Q0dicFBnUVM5?=
 =?utf-8?B?LzBSUStZVGVZUTQ3MXRKY0k3R003MUpDZ1FSNFFzMTd4SXZvMVFBNTR4LzdR?=
 =?utf-8?B?Q3VYRzlkbkVMUjVKQVZxaFhvU2VpcW84UC84dWhBdTREY0k2alZzKy9TbW8z?=
 =?utf-8?B?d09uRk1od3VFNHhMNml3SFBMQ0VIYUV3M3ROQjEzUTB0RmhmM0Y5TkVTWVc3?=
 =?utf-8?B?RnRwSDJEL0FrQ0lYWGsvYjc3T3BzdGd6eG5YN1FUN2s3bmFORnNUc3RnYzEv?=
 =?utf-8?B?RUJ3Wk4ySmUvVjlaa1AzRHRJMFFvdlk1RjErVU5jdm9Yb3VjOEpNdEpYenp1?=
 =?utf-8?B?QjFUVG1DY1BDT2lvTHlpWkc5Ums5WitmRGRCaFRXQmFpWmZBeGpFRFp6dkIy?=
 =?utf-8?B?NCtPckVWKzN2cjRrdkt4a0d1VjBPRlJ3NHhsS08xYm1GL0ovNzZvSG9iRUlI?=
 =?utf-8?B?cmpuUUJHVDZ2dTlzUzhObGF5bk5oR0V1cnlNemNkcmp2dVlRWC9Wb3E3dTY0?=
 =?utf-8?B?SEFyZXJLVXRzbEc2L1FCZnFXOGtxdlU2TDNPUGpNSDl3Q3h1MXRIaVdVK2pV?=
 =?utf-8?B?YmlRL0FNREUrRzRFSjllWnIzL0FSUm00QmxYZzI5UitBS2dkbTZrdnMraTQw?=
 =?utf-8?B?cENTd3NwSXBQc0x3ZW0xM3JFNFBLZWhjNXhPVHpVQXk4YnBmdTdTSXdSQSsz?=
 =?utf-8?B?eDhiVHJPTmpKUWV2UnEwS1E4VTY4ekRtbzJ3QkNpYkJKR3NsalJsT0U3aWdp?=
 =?utf-8?B?S3YxSTZmaVlZNTRuNnd5N1d1bVhVSzJVcmlPc2l3Ym03V3JLMVR3MHNrTFJN?=
 =?utf-8?B?YkFPbGszc3dOOVpwdmFWRnhJVEcvMGY4YmdIMkoxMGpTaHpQZjBHTHkzc1hE?=
 =?utf-8?B?ZHdWdjdTSjhORjNwaHo5Yk0xbStHMitrZEtFRVN2T1p6cjczbWRRUDlLdW13?=
 =?utf-8?B?VzNYU0xjTEhhMEZYWFVoV0JRRVNoY2QyakVKejlEZHh6NkltbEVaVGRKNkUv?=
 =?utf-8?B?Nks1Rk5IdjhoSnc9PQ==?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d90845-d34d-48cd-cabf-08dafb2d6aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 21:29:30.7475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zk47CRq+Tk5rCkKEYywtO4FTdgvql2n4bwKpdUsJ1dRFj2VxVLM5KIwp+MJIC/8dKvAA9MYnPUv0BXiry++APtkrENsvb9knfn5Z5jaPI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5005
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAvMDEvMjAyMyA5OjE3IHBtLCBILiBQZXRlciBBbnZpbiB3cm90ZToNCj4gT24gSmFudWFy
eSAyMCwgMjAyMyAxOjEwOjA5IFBNIFBTVCwgQW5kcmV3IENvb3BlciA8QW5kcmV3LkNvb3BlcjNA
Y2l0cml4LmNvbT4gd3JvdGU6DQo+PiBPbiAyMC8wMS8yMDIzIDg6NTAgcG0sIEguIFBldGVyIEFu
dmluIHdyb3RlOg0KPj4+IE9uIEphbnVhcnkgMjAsIDIwMjMgMTA6NTI6MDIgQU0gUFNULCBBbmRy
ZXcgQ29vcGVyIDxBbmRyZXcuQ29vcGVyM0BjaXRyaXguY29tPiB3cm90ZToNCj4+Pj4gT24gMjAv
MDEvMjAyMyA1OjQ1IHBtLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4+Pj4+IE9uIDEvMTkvMjMgMjM6
NDksIExpLCBYaW4zIHdyb3RlOg0KPj4+Pj4+IFRoZSB4ODYgc3lzcmV0X3JpcCB0ZXN0IGhhcyB0
aGUgZm9sbG93aW5nIGFzc2VydGlvbjoNCj4+Pj4+Pg0KPj4+Pj4+ICAgICAgICAgLyogUjExIGFu
ZCBFRkxBR1Mgc2hvdWxkIGFscmVhZHkgbWF0Y2guICovDQo+Pj4+Pj4gICAgICAgICBhc3NlcnQo
Y3R4LT51Y19tY29udGV4dC5ncmVnc1tSRUdfRUZMXSA9PQ0KPj4+Pj4+ICAgICAgICAgICAgICAg
IGN0eC0+dWNfbWNvbnRleHQuZ3JlZ3NbUkVHX1IxMV0pOw0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyBp
cyBiZWluZyB0ZXN0ZWQgdG8gYXZvaWQga2VybmVsIHN0YXRlIGxlYWsgZHVlIHRvIHN5c3JldCB2
cyBpcmV0LA0KPj4+Pj4+IGJ1dCB0aGF0IG9uIEZSRUQgcjExIGlzICphbHdheXMqIHByZXNlcnZl
ZCwgYW5kIHRoZSB0ZXN0IGp1c3QgZmFpbHMuDQo+Pj4+PiBMZXQncyBmaWd1cmUgb3V0IHRoZSBy
ZWFzb24gdGhhdCBGUkVEIGFjdHMgZGlmZmVyZW50bHksIGZpcnN0LiAgUmlnaHQNCj4+Pj4+IG5v
dywgdGhlIFNETSBzYXlzOg0KPj4+Pj4NCj4+Pj4+IAlTWVNDQUxMIGFsc28gc2F2ZXMgUkZMQUdT
IGludG8gUjExDQo+Pj4+Pg0KPj4+Pj4gc28gdGhhdCBiZWhhdmlvciBvZiBTWVNDQUxMIF9sb29r
c18gYXJjaGl0ZWN0dXJhbCB0byBtZS4gIFdhcyB0aGlzDQo+Pj4+PiBjaGFuZ2UgaW4gU1lTQ0FM
TCBiZWhhdmlvciB3aXRoIEZSRUQgaW50ZW50aW9uYWw/DQo+Pj4+IEZSRUQgMy4wIFNlY3Rpb24g
Ny40IHNheXMgdGhlIG9ubHkgY2hhbmdlcyBmb3IgdGhlIFNZU0NBTEwgYW5kIFNZU0VOVEVSDQo+
Pj4+IGluc3RydWN0aW9ucyBhcmUgdGhlIGVuYWJsZW1lbnQgY29uZGl0aW9ucy7CoCBOb3doZXJl
IGVsc2UgaXMgdGhlcmUNCj4+Pj4gbWVudGlvbiBvZiBhIEZSRUQgT1MgbmVlZGluZyB0byBlbXVs
YXRlIGxlZ2FjeSBzeXNjYWxsIGJlaGF2aW91ciBieQ0KPj4+PiBhZGp1c3RpbmcgJXIxMS8lcmN4
DQo+Pj4+DQo+Pj4+IEhvd2V2ZXIsIEVSRVRVIGRvZXMgaGFuZGxlIGZsYWdzIGRpZmZlcmVudCB0
byBTWVNSRVQgKGluIHBhcnRpY3VsYXIsIEkNCj4+Pj4gdGhpbmsgeW91IGNhbiBlc3RhYmxpc2gg
VEYgb24gdGhlIGluc3RydWN0aW9uIGJvdW5kYXJ5IGFmdGVyIFNZU0NBTEwNCj4+Pj4gbm93KS7C
oCBXaGF0IGFyZSB0aGUgcmF3IHZhbHVlcyBvZiBSRUdfRUZMIGFuZCBSRUdfUjExID8NCj4+Pj4N
Cj4+Pj4gfkFuZHJldw0KPj4+Pg0KPj4+IEp1c3QgdG8gYXZvaWQgYW55IGNvbmZ1c2lvbjoNCj4+
Pg0KPj4+IFN5c2NhbGwgYW5kIHN5c2VudGVyIGluIGEgRlJFRCBzeXN0ZW0gYXJlIHRyZWF0ZWQg
ZXF1aXZhbGVudGx5IHRvIHNvZnR3YXJlIGludGVycnVwdHMsIGUuZy4gSU5UIDB4ODAuIFRoZXkg
ZG8gbm90IG1vZGlmeSBhbnkgcmVnaXN0ZXJzLg0KPj4gSW4gd2hpY2ggY2FzZSBjYW4gSW50ZWwg
cGxlYXNlIHB1Ymxpc2ggYSB2NCBzcGVjIHdoaWNoIGFjdHVhbGx5IHNheXMgdGhpcz8NCj4+DQo+
PiBJIGNhbid0IHNlZSBhbnl0aGluZyBpbiB0aGUgdjMgc3BlYyB3aGljaCBtZW50aW9ucyBhIGNo
YW5nZSBpbiByZWdpc3Rlcg0KPj4gYmVoYXZpb3VyIGZvciBTWVNDQUxMLg0KPj4NCj4+IH5BbmRy
ZXcNCj4+DQo+IEknbGwgbWFrZSBzdXJlIGl0IG1ha2VzIGl0IGludG8gdGhlIG5leHQgdXBkYXRl
Lg0KDQpUaGFua3lvdSENCg0KfkFuZHJldw0K
