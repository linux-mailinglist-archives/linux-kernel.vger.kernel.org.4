Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB3568FC78
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjBIBLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjBIBLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:11:36 -0500
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C484623868
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 17:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1675905087;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cKqj03wCE5M0nclAILYeDxA5NrUu8IkKwbQN/pY2EIw=;
  b=RfTOHUnt0jIAg22j8Ew0U7k6bTp6KZkl1XZDiQ4WYk90YOZU9z1rv2tL
   dBKC7Z68Xju0YETgJoCr3KdpqQUieCix7oEcTN4U5e0i9zJtlGptrAYFo
   azei02FOPiS6o+p+Gl980trLIZ2HNEXxrBTjC/WtsmQB6Yer96IFh81Ns
   M=;
X-IronPort-RemoteIP: 104.47.51.41
X-IronPort-MID: 96193938
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:i3n3L6DMJ7PCDBVW/9riw5YqxClBgxIJ4kV8jS/XYbTApDp31TJRz
 moYXzqGPfrYZ2f3LtF2a9+ypkMAvMPWnIBiQQY4rX1jcSlH+JHPbTi7wuUcHAvJd5GeExg3h
 yk6QoOdRCzhZiaE/n9BCpC48T8nk/nOHuGmYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbyRFtMpvlDs15K6p4GlA7gRlDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIw6OhXI0Nwx
 NckDD0VUBzA2uCum7u9Y7w57igjBJGD0II3nFhFlWucJ9B/BJfJTuPN+MNS2yo2ioZWB/HCa
 sEFaD1pKhPdfxlIPVRRA5U79AuqriCnL3sE9xTI/OxrugA/zyQouFTpGPPTdsaHWoN+mUGAq
 3id12/4HgsbJJqUzj/tHneE17GWzHiqA9J6+LuQruBBxwTI9DQqJ146bwefit2Xtl6QYocKQ
 6AT0m90xUQoz2SzQ8XwRQ+QoXiKpBcQVtNcVeog52ml2vqKywWUHG4JSnhGctNOnMs3QyE6k
 1yEhdXkARRxv7CPD3GQ7LGZqXW1Iyd9BWoCZDUNSAIZy9ruuoc+ilTIVNkLOK20lNzxHXfrw
 y2WoS05mZ0XjMgWx+O6+0zKh3SnoZ2hZgwt4QTSVGWoxhl0aI6se8qj7l2z0BpbBIOQT13Et
 n5dncGbtLoKFcvVyHXLR/gRFra04frDKCfbnVNkA5gm8XKq5mKneodTpjp5IS+FL/o5RNMgW
 2eL0Ss52XOZFCLCgXNfC25pN/kX8A==
IronPort-HdrOrdr: A9a23:fSHE0qiSb71ToXaS+8adc5k0b3BQXisji2hC6mlwRA09TyXPrb
 HJoB17726XtN91YhpLpTnuAtj5fZqiz+8P3WB8B9qftUzd2FdAT7sSiLcKoQeAJ8SWzIc06U
 4jSdkcNDSXNzRHZK3BjjVQfexO/DCPytHTuc7ui01pRQtpL41m8gtjEx2aCEEzZCQuP+tcKL
 OsovBDrzCjPVAadN6yCHVAf8WrnayzqLvWJSQCDxQkrDSDhTftyJOSKWn+4isj
X-IronPort-AV: E=Sophos;i="5.97,281,1669093200"; 
   d="scan'208";a="96193938"
Received: from mail-bn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Feb 2023 20:11:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQCKqXi9ny/T1j8kjqnnoSdKSGx/KXo0Amq6RjYaLIDdP6rrzJagnlCpHJvNNiUbSwPQbTwn2wCUcOqNymSbzikX0BfLPZ/syqSGdblsNeMWe/5UkPbWEO1MnnEbetif3jJoRgUbSw4YYm0kKRMc4TUJvonlRGjMYb0vkiyv9n5M89v7tM/R2WiHKTKhkOB2PR6/EZ46jEZR9jiKJDsbZr3b1hw0cPNxfINgNUqCM/CNhZ6QVZD8ogLNoRt5MMEc+RwGgTnb4dscgTHc3fgVtqAzkSr/AKBk50HPcwoA+U48fx/cqQZ6ygVEnNFayTLvqQZwf9810kH1RF5E2hZXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmSjqk0pRJPC5ThAVU2ed3OoOi4CAv51mV8qTtpvyAg=;
 b=Abn9qR5ZdlJ6zWrpKBsmnXsJ3AsLml00czKQWyVOhL7YXwmtj2DYp65yFhQPweHrZx1egOxuWQq0FkHPgo/Qdh9u2XxNFQEgtUpRwiDeJi6PGRjQ4uTgtlaH1+sjkB6IxAw6aM7WD7cRdbypUsJlN0GMENM4KiqiZ5cJpt4lDbBIdLOXQQlmwwwjJMyJL1OF4MkrVkIuhKUaUSC7uLHnJQTKsOzuSxybR/0Hz8+FB0VKnx8xn1DQIlX1i3WuEdt/7ewebV8aNv/b2TQKNN1vN/qHquJX09YZNcLVTAKwCz/+qHe6eh+8aJKdpPqeElIzop8gNmGnRN+iJkDTdahrKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmSjqk0pRJPC5ThAVU2ed3OoOi4CAv51mV8qTtpvyAg=;
 b=kzfuerPIq3ctO2xzuuqHFrCpnwEsT5MeO37DxScgAD9QmdHIYY7lAlaS+wLNWsiJavITNa/OUo/RFUSuTT28eQjQ7qYUEfriUVeTxmly57QBIBsQuAKI3jRwWaidombTL3jk5Tqyy0Ilf9nGJucAHNgcak895+C/jgqfXDEGEgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB6962.namprd03.prod.outlook.com (2603:10b6:a03:430::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 01:11:24 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 01:11:23 +0000
Message-ID: <c23540da-5f73-dede-124f-529b01ce5273@citrix.com>
Date:   Thu, 9 Feb 2023 01:11:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Andrew.Cooper3@citrix.com
Subject: Re: [PATCH v3 3/4] x86/alternative: Rewrite optimize_nops() some
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        kirill.shutemov@linux.intel.com, jpoimboe@redhat.com
References: <20230208171050.490809180@infradead.org>
 <20230208171431.373412974@infradead.org>
 <f0b54521-26cf-ed38-d805-3a8eef3b3103@citrix.com>
 <Y+QGIiOupDKxlKKR@hirez.programming.kicks-ass.net>
 <Y+QHyF5K5hSN0ziP@hirez.programming.kicks-ass.net>
 <Y+QJlK637EYg/Zst@hirez.programming.kicks-ass.net>
 <Y+QPPFQ4DzSaJC3m@hirez.programming.kicks-ass.net>
 <Y+QSSFEfA5oXdKUS@hirez.programming.kicks-ass.net>
In-Reply-To: <Y+QSSFEfA5oXdKUS@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::28) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SJ0PR03MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bddf6f-1ca9-429e-3ca0-08db0a3a8f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fyIKo6LXq8W6sgq37PkVO8wEiLxNbqtjK6gndK3oOcEp//V6ydiD/h0kyAOoDlqf1dDQFR69TWsRCNDeZ9fdMHdLNYVRe8qIjwsKAns8VZ1Wy8OUOMniFYVq/W3VQdzPS9jhnX/E1QCzftnoLO7emTq6MNE1CoZpI5qkcKKbFHuaj7jd21uq3DvePCCo1nuDT8GwUxqN75FloShi1EMDl17htdinE8yf695JMHb168jq3TVVr3VPqwNWgeAx74QxfI5Yo1koKPjKeIEV7ucI2tShaXcmHppEp+DvFdeMYPIFtlNGLG0OcRko9Z95VCNOqbAFxRd0SiI5YdErbcFaJ6IbeshsF7wPB++RQj7gfBcIKdfZN7mz1vXLl23AKeu3/14YqsP8VJp8Kg4twrjLVQTt++HeFk7kSVif/3kzpkMtVicfjRzKlAnL4ZjtFrZgngHANZ1jlAADRI6b/0eF3GA1iMXU50SGS+CSMp9iawCGCHWtcBVoukrSoGpdoDX8/aW8hnDM1WusExl0PjtZ1d95WfGnv4ZDRjw0LN82UWhyDTZfifmxmTeoAp55hEBhRBE76yp5hFnC+e+jlqlDIWHQsOgio1x+Tu5aNn4yI+IpWCBRq33c/HLdEm6cMsk2D/7vuD9sljXSA9HxNjsdIeTx+smIAw2jwjuq9XAxAc0QaRfuIDhINZ3//QgfA4pDu2IPHi0BJxa0AvqNEaaTRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199018)(86362001)(2906002)(38100700002)(82960400001)(31686004)(2616005)(6486002)(53546011)(26005)(6512007)(9686003)(186003)(36756003)(31696002)(6506007)(66556008)(66476007)(316002)(66946007)(41300700001)(4326008)(6666004)(478600001)(8676002)(6916009)(5660300002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nng1b21UdGhnRll2TndVY2RvZ0M3YWszdEpzcnEvWDBtaUFmeUkwTFRQRzIz?=
 =?utf-8?B?RXhUK1Ezby9FakJZOE9hNVZPMkJ0VnRZUEI2b2tEMndrR2NBUlNqbXJuU3RE?=
 =?utf-8?B?U1JYQlFEZ1EyRGdXMjk0elM4c2FVNkpsVTZ5REt0cW91R1VnVXhvQktTdVBO?=
 =?utf-8?B?MndORm01K2x5NlFWSlFjNE5KVlc5M1dvOU1pb1dGK2hnMDFQM0lTYTdSSEN1?=
 =?utf-8?B?cUNkWEgvOUJxTWMzcXJHdEt2Nm0vdHJWRHhTSWZJZlU5UTExNy9Ub3RZQ1ZK?=
 =?utf-8?B?QlhZcEVNSCt1eFpyak4zTVNnZFZOdlRXejVxSHdZRDZ1dm5aczNZMmxlZ2FV?=
 =?utf-8?B?ZFE0RXFScVNpVVBOWGtWZUhmUFNQN09yYjVQZjBQRGZuLzZmcTFCZG5qUTl0?=
 =?utf-8?B?Q0hJNXNjaXR6cGNhN1dDQU54b3YyTTU1OXJkZmZITlFmN2IrYWk0b2Ivd3RT?=
 =?utf-8?B?ME9mUkNTUHNScUVJSnNCTEdxQUpTVjFtdnR0NlU3SzZkdkFab1ZRTVhLWDFL?=
 =?utf-8?B?Zmk4blc2b3RHa2tmN1RTemJleWo2b3lUb2F5dGE3ckFPVEN3N0NYQlU4TmRy?=
 =?utf-8?B?RzI3akxhcGVTR0hyWlBtRXE5NEw1UlBKUGNOa3U5T3UvUWZIeFBXVkFOdmdQ?=
 =?utf-8?B?OUFqU0c1d0x1Szd3NG9kQUhtUjBVcDg4d0NReWEzL3pnekszWStPRnh2Mk95?=
 =?utf-8?B?bEFXMmVoOGFTVDVNc21sczVLZWIrV0Z3RmVOSFdHZ2VvQzRRazY2S1cxa3dQ?=
 =?utf-8?B?V0hPbWhQSmdHWXg1SjhrY2pvZWdrVW02a1pTWVRNcTMwcXF1MFB3Lzl0eDVQ?=
 =?utf-8?B?VG4wQ3NhaHhRNEdGOXBrZjQwSGV2TzZQYkp5d2VMNWE0ODdaNnMyMEN2UzM0?=
 =?utf-8?B?TEhxc29qWkhwZDlVODFtR3IvbDhKVTdaY3lBTVh2T0xVenFKeVo2SDdkT29G?=
 =?utf-8?B?ZHVIei9ENkFpd1V5VmVaRStkTXJKV0tyVC9mMTFobmV6VHVnVFltZTQ5a3J6?=
 =?utf-8?B?WVU4VzRRWXEvMytsd2NRN2xUdndCa29zOFpVa3IrTHNDNUhKcWtEZ2Q4SFRG?=
 =?utf-8?B?TWxqb25BUzQxNkprMG40eXdzSnpkbVk0SnRsZzJkeVlyYWhpdDFhbVhMbG9h?=
 =?utf-8?B?akd0Q1g0eXlFTm9ETGVNZmxjVnl4OE5FOEtodGljNXBUUTI0VWE4emRYWnRv?=
 =?utf-8?B?TGwvY2QrMXVMZEhWWEIycUNxM2RheDRKSlQ0bFFjaW5GSjd4N3ljYnhtNC9x?=
 =?utf-8?B?WXUxRVVPMVBPNFFRZ1hzclI2WXVkUisxeWFnRWp4NFNheWRaQU50aUhoTWx5?=
 =?utf-8?B?S1NadThYZ200a3pGSHd1bGlxb2lrWVdOOFNwYTlpc2hwK1FSOE40T29tYlho?=
 =?utf-8?B?UlNST01Wekw2aEVjd2psN2VjZ3Mra0Y5WWcyVDlaT2hmaFZoNmRuNzBQOXJs?=
 =?utf-8?B?RzBLTlRHU0JVR1VMVitsYktGbTh3T3k0d0pyVEpzajBZb3ZVOEIvN0JXUVdt?=
 =?utf-8?B?Qk9BdWFBSFlRVHpHdHBqM1NQRDhqSVhFVG82S1dMTlZIcXNZWlBrdW9HVnpB?=
 =?utf-8?B?cUxVMFdERXlRckJ5VjVOZ2prMlNuYUhIQkFRaWE5dzNJS3g5N2hqeDhnRzlv?=
 =?utf-8?B?K3A2SEduY2RPQXE5SUpReXRVakRNQUtpcXVpMm5wTHF0UVZHMXpNNzBaSTZr?=
 =?utf-8?B?aFBEamt1U0pFbWZsMUxPNmVHdjk4aW52RUoyMCtpWHBqTWtoTkJjOXY0MEtu?=
 =?utf-8?B?VHRFMExQVUxlTm9zem1IUGJiVSt6TXg4TndVRkFrZ2hqeGg5TlRYN2Y4ekdS?=
 =?utf-8?B?d29VWVcvd1dSclRXZlp5NWJSWngxOUtSbEc0S0ZYMlVIVCt2cUhTeU1Cc3BF?=
 =?utf-8?B?bzFTdTU0V2NsR0xLN0JVK1JRMTZyU0tobityenUvc3Zsb04xc0dMeUxqOXZo?=
 =?utf-8?B?Z2tmeVIyb2YwOFVLRTZ0MUllSlBCRmRBMlhIc09ReHpHekwwc0ZNVVJjU2Vk?=
 =?utf-8?B?L0FPblR6N21wNS9YQlVqd01SZ1BrcGM4em9TcnM5ZGh4ZytRQWhhY0MvNFg5?=
 =?utf-8?B?ZGlxTm1LY1dUUXpqQ21mQThaREhkNURYWUhDS1VLWnV4OXdCb0ZVT3ZJU1Rt?=
 =?utf-8?B?cTRYZmFoSDJOemp4ai92a0hwcUNlWG1uY0ZQeWo5QjNSRkIvNXBNSGZnd1Y1?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kX2xAJwUXXPPAVX23q5xQUdcbacFHSF2ovXgINpOpuikmgwQaZA40W3fLHbnKLx+WoQVUucR1bTcKbXUdPTHxwZTvVVPNRhoOBBtWIvQIZ7AimzEZ92swfjADwc17KepUOsdZsg0cwOl1wDhs9dcgEjHLPEuiYO2lU/RFLP/84VUQveAEnxCQg9gyGN/ncA2JEHkx+pqmFoY/BUYjRGk+NUdV9p1Ftjv1wpANKwJs7MJfbDJQNlrtGn+P6zoMxBkJU2GtKZl0AFwGCZcA/Rfzos6Kv2Qz06KcxW7VCYmGwbXbEpQ1eUMgExWnbyWC7QuTSKuSuqrxXvl34BHk6KedPlHDetd9AV9OCvYn7C2CArrRdE08b/Trcb60MAjnT9Xk83pXD61CdRri/ShNrkdyQrIrKF5NBBdAFskYQe5EGGiZX5T8UdHYd7xfo7HmGXmWHGkxaS3T7E04WthBojTlje22tWVHDqt6YAjEPiMLkMzYTyqEbaFeQEcWuEmuhDF82LyQpn52hEdvZUGx5SZUmufqAd/ip8S1yLWG9MfyQGzYV8r8/KDNB1k68pmhyRXvxv6yWSKLYC1SIRzp12CaFe/Y9O6qCixPDSzaV8VA+o++o7UoLW+bpPfs3Uz7h+1ZlS0SGDBfvqfqZ2gu+4IkQGj5+6Wxng7UpZiOytN647jaxbn7++azcRFoBFuzo1QE6WQVvP8jJmOxokPV7rh6zQFIhaRq8mH1w+ge9qVhQPZ4vC7DYblYIefb6CGqAtwDttARQscKtsoHUtYFG2OFbIDkJ1MxBOOyeIn/Ohe2MMHk5M7j3sCVVf1iNLl4ya8QsNB4DjEHRlBzxq55RPVmvqrDVUwDrU9qFWnt/s37EGr5IU9Ktu7/VKwJ8AD5bQrg72lwBpjqNbXUdDA7aKy2Q==
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bddf6f-1ca9-429e-3ca0-08db0a3a8f66
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 01:11:23.5779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5E25xAXMlNk2sx7HlZxyVYKOkwEjdoYOU8dZhwM3hzNhpwNR1TS1GqF7bwNd+QjU1qbbttMAEiIvCH9UUNqQTu1TYW1wA+tNX8O4xBygGQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6962
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 9:21 pm, Peter Zijlstra wrote:
> On Wed, Feb 08, 2023 at 10:08:12PM +0100, Peter Zijlstra wrote:
>> On Wed, Feb 08, 2023 at 09:44:04PM +0100, Peter Zijlstra wrote:
>>
>>> [   11.584069] SMP alternatives: ffffffff82000095: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>>> [   11.590068] SMP alternatives: ffffffff820001f3: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>>> [   11.720069] SMP alternatives: ffffffff8200189f: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>>> [   11.731069] SMP alternatives: ffffffff820019ae: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>>> [   11.738069] SMP alternatives: ffffffff82001a4a: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>>> [   11.746069] SMP alternatives: ffffffff82001b2d: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>>> [   11.766069] SMP alternatives: ffffffff82001d14: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>>> [   11.770069] SMP alternatives: ffffffff82001dd5: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>>> [   11.779069] SMP alternatives: ffffffff82001f35: [0:20) optimized NOPs: eb 12 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>> UNTRAIN_RET -- specifically RESET_CALL_DEPTH
> 19:       48 c7 c0 80 00 00 00    mov    $0x80,%rax
> 20:       48 c1 e0 38             shl    $0x38,%rax
> 24:       65 48 89 04 25 00 00 00 00      mov    %rax,%gs:0x0     29: R_X86_64_32S        pcpu_hot+0x10
>
> Is ofc an atrocity.
>
> We can easily trim that by 5 bytes to:
>
> 0:   b0 80                   mov    $0x80,%al
> 2:   48 c1 e0 38             shl    $0x38,%rax
> 6:   65 48 89 04 25 00 00 00 00      mov    %rax,%gs:0x0
>
> Who cares about the top bytes, we're explicitly shifting them out
> anyway. But that's still 15 bytes or so.
>
> If it weren't for those pesky prefix penalties that would make exactly
> one instruction :-)

Yeah, but then you're taking a merge penalty instead.

Given that you can't reduce enough anyway, while only a 4 byte reduction
rather than 5, you're probably better off with:

0:   31 c0                   xor    %eax,%eax
2:   48 0f ba e8 3f          bts    $0x3f,%rax
7:   65 48 89 04 25 00 00 00 00      mov    %rax,%gs:0x0

because of the zeroing idiom splitting these 3 instructions away from
the previous operation on rax.

It's a shame that x86 doesn't have a mov $imm8, %d32 form, because
loading 1 into a register is an incredibly common operation to perform.

~Andrew
