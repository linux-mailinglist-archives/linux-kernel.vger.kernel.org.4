Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A21C727EAF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjFHL0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjFHLZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:25:59 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4856226B2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1686223558;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3HpXlT5p+p9wQEdmXcaNisbfGFOOgV9W5DwRdRC/guQ=;
  b=JtjukSxuMSJsJG46K3PwukTqgOyym1zOnWaBULAnxdhzvkc4xvoyetU/
   Tp0Un9nm71wabgu0LE5mRnN4iMoPvob53yWhPK+jhmKseYAfdAnHZSq4+
   v8Kh16gJ8luyNBxrgnvCqasMvRPKrInNjIQ8NeTl8BwtOeidWcLwhTaLU
   I=;
X-IronPort-RemoteIP: 104.47.56.44
X-IronPort-MID: 114565318
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:PqwCn6CpkRgS1xVW/83iw5YqxClBgxIJ4kV8jS/XYbTApDwh1mdVy
 2dKW2uHafzZYTDxLd12YNu39UJX7J7WyN9jQQY4rX1jcSlH+JHPbTi7wuUcHAvJd5GeExg3h
 yk6QoOdRCzhZiaE/n9BCpC48T8nk/nOHuGmYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbCRMs8pvlDs15K6p4G1A7gRnDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIw198pRkJsz
 t8hCikcSjCRhuDr26yEVbw57igjBJGD0II3nFhFlWucIdN9BJfJTuPN+MNS2yo2ioZWB/HCa
 sEFaD1pKhPdfxlIPVRRA5U79AuqriCnL3sE9xTI++xrvwA/zyQouFTpGPPTdsaHWoN+mUGAq
 3id12/4HgsbJJqUzj/tHneE37aTwH2mA9tCfFG+3t0wjHePyEIoMz45RGuZj6Cno2iYY+sKf
 iT4/QJr98De7neDUtb5TzW8oXiZogQbXdtAVeE3gCmLy6mS6QGDB3MDUBZadccr8sQxQFQCx
 g/Xt9DkHzpitPuSU3313rOVqy6ifCsYN2kPYQcaQgYfpdruuoc+ilTIVNkLOKu1idb2Hhnr3
 iuH6iM5gt07j9UP3q+q1UvamD/qrYqhc+IuzgDeX2bg4gYiYoegP9as8QKDsaoGK5uFRF6cu
 nRCg9KZ8O0FEZCKkmqKXfkJG7aqof2CNVUwnGJSInXozBz1k1bLQGyayGsWyJtBWircRQLUX
 Q==
IronPort-HdrOrdr: A9a23:bLhSH6+XVnFAaIMVChduk+G+dr1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYVYqN03IV+rwXpVoMkmsjaKdhrNhQItKPTOWwldASbsP0WKM+UyCJ8STzJ856U
 4kSdkENDSSNykFsS+Z2mmF+r8bqbHokZxAx92utkuFJTsaFJ2IhD0JbjpzfHcGIzWuSaBJdq
 Z1saF81kadkDksH42GL0hAe9KGi8zAlZrgbxJDLxk76DOWhTftxK/mHwOe1hI+VSoK5bs562
 DKnyHw+63m6piAu1Lh/l6Wy64TtMrqy9NFCsDJos8JKg/0ggLtSJV9V6aEtDUVpvjqzFoxit
 HDrzopIsw2wXLMeWOepwfrxmDboXwTwk6n7WXdrWrooMT/Sj5/I81dhbhBeh+cz0Y7ptlz3I
 9Cwmrc7vNsfFj9tRW4w+KNewBhl0Kyr3ZnuekPj0ZHWY9bTLNKt4QQ8G5cDZ9FNiPn74IMFv
 VoEajnlb5rWGLfS0qcknhkwdSqUHh2NhCaQnIassjQ6DRSlGAR9Tpt+OUv2lM7sL4tQZhN4O
 rJdo5ykqtVc8MQZaVhQM8cXMqeEAX2MFPxGVPXBW6iOLAMOnrLpZKyyq4y/vuWdJsBy4Z3sI
 jdUWlfqXU5dyvVeIOzNaVwg1PwqViGLHbQIpk03ek9hlS8fsulDcS7ciFvryP6yM9vRvEyWJ
 6ISedr6rHYXCzT8L1yrn7DsqlpWAgjufIuy6YGsnK107X2w97Rx5rmWceWAobROhAZfU66Kk
 c/fVHIVbd9BwaQKzPFvCQ=
X-Talos-CUID: 9a23:WyJfAm0/vbsDWE4C7bVGiLxfN/l7NV7/91TpAVapLUZ7Sb/IUkGv5/Yx
X-Talos-MUID: 9a23:HnJXlQs+pWzeM1GhM82np2tuHttmzZ+VK28cobco4tetEwpIAmLI
X-IronPort-AV: E=Sophos;i="6.00,226,1681185600"; 
   d="scan'208";a="114565318"
Received: from mail-dm3nam02lp2044.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2023 07:25:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBQVKR4LtSEaVTWGYd747DG32leNvH+84y2pwlwYQ5KP27BLqaOYimG2bNhf8FiixxQdPqWAiixwBezvPKW5EiY7JF1fjLLfw6IAxl3tsGJjqvNJHJ4OEMEXXgWrRt/NvL52PF7Ou6FllJUnpW0Cqqb/Et3vgNNNTdnkr2kvCs91RaYwpVg85f1esddRHBJY7vnVQaUXsP8twQ9GjFGcNA68rRiWKK/rd/eUr+6Qc99TsoxT5wILTGYsB3tVzLpeI4cWNvkG5HJwoy3ak/le+tTD+vNZBwY8YUv1RnZ5uKanj3d5lghzQgxCDOdqou56ppKz03YcmVnIJFPdyXLnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HpXlT5p+p9wQEdmXcaNisbfGFOOgV9W5DwRdRC/guQ=;
 b=cIxy9GbWyxLTQDptMy3XTdS+GXZFRRXc1yyvI/W/+Jpe8UtxmBz6OBNtYGO+7nJbpVF9WYQKwjtq+GbWXfmNNSAQNgn7v8AlWIRDBnTxIBYovbGSi7gEbY4zCDzL/uIOIv9Ig3PICd5RgFxS+lMC5I14KJamEgSX+NkkgZQid8KDz4H7317FOcncLAGqPKMS5RsjbJ31GHHl+VTg5/+QXcubQawj0CNvLByEfliEPzPH4XX5TRvNAWZHQHcAQXxkm12LS7seFpYdpv0y6Qh5wn79LCziOwXQ0XT4vZKBBaZNqRbsYNSIvkwCA/XUhHeSWuvRKkCdonVJdluDDjodKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HpXlT5p+p9wQEdmXcaNisbfGFOOgV9W5DwRdRC/guQ=;
 b=K4y0SDcdf1QPMLu4dpE/kZr+g1L3cH9GcHPnFaS6vwr4scwlO1xbswUfaZ6yKYnRbI2+4Lx443Vj7S4tkYzHXqJUB36Gqj07xqvE9AGOxG+ZiWdYER7ws9aL4Fq+L3P5O5+QxmqnuBVG6ZTRiGp3OWDE/BXW0OtRzcJ/uRQev7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH0PR03MB5733.namprd03.prod.outlook.com (2603:10b6:510:39::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 11:25:52 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd96:913a:c06c:d606]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::bd96:913a:c06c:d606%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 11:25:51 +0000
Message-ID: <455418fb-8050-3985-5c6c-8b2068702286@citrix.com>
Date:   Thu, 8 Jun 2023 12:25:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 3/3] x86: Disable running 32bit processes if ia32_disabled
 is passed
To:     Thomas Gleixner <tglx@linutronix.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-4-nik.borisov@suse.com> <87legvjxat.ffs@tglx>
 <80f2045b-f276-e127-8e46-87fb6994fb41@suse.com> <87fs73juwa.ffs@tglx>
 <ba15bccd-9580-c20e-ae9c-b8d60f49fa07@suse.com> <87a5xbjpk2.ffs@tglx>
 <875d0ab7-4470-25e2-6c01-72e231aae515@citrix.com> <874jnjj5z2.ffs@tglx>
 <278d7231-ee27-602f-4ba7-45d45d6772b3@citrix.com> <871qimkdft.ffs@tglx>
Content-Language: en-GB
In-Reply-To: <871qimkdft.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::20) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|PH0PR03MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 9997aa86-3f9e-4953-dca2-08db68131d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W84/0gulavODLHecyDHYVI/PTUU2CN08uEk/E+vaki+SMPZj+ZRsAL1/T5AihiTQ2yKc5+j8Nqz1Ey3ff8uhGwRJvXcmn2yoCMPZpjvqH0NQ7uN4mr8ULYb+CmI0HoA2e2EmGVRL81t7sFMwuvHH0mwk+Yb3aSayzdzXJED8he6tgrYvEy4R5xXGQaDUVGFIKXb+Mh3vKcoNKeUrkKwqmnn3Odu3P91SaVmcSSnEqnmo6/P6z3rYRxe0jMIMRjkXumjoewi1RKeW90W/uilZxT2vww4/rpxM2DpDGIbbmZA3SvYqoDB3/tY34wx4ISJQKqZEUOOt0fs4DWQKyET+Vv5AbfQjGqOkuo854w1qj78MO+qmfLgb/wsCgaRyo0bLVAoh4caIxJYJ4qdip9fCZiICRINkFu7QQj76U94X2uhi8Uo4g8lQuLyOXTlxII2JehUFIpHz3CyK1MNyc/briNFAcV0O5lHte94vaMmgrRO6n5BccDH8+zLUphqHfTODwYvUWFyZ68xzHH6WoxjGk+oWjYlSyVKwnScuGksJLkdZ0DXzHWWJqHDjnefPmhzHeody2pHrhwV/VWAQtNRPicdDwTowGBBfntPNjBNmvePp/ImrpIx+S6Mw+BKumRtCfpQKDEqSuaPZ/6kJrBW/mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(66946007)(8936002)(8676002)(66476007)(4326008)(66556008)(316002)(110136005)(41300700001)(2906002)(478600001)(31686004)(5660300002)(6486002)(6512007)(53546011)(6506007)(26005)(186003)(83380400001)(6666004)(82960400001)(31696002)(86362001)(36756003)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEMxamN0bHF4Y29KREFIRzhmcHJUbTlPMkxZNzJ4VDFsZVFMcTV5TFV5aitv?=
 =?utf-8?B?NlhmREt3TERKekhOT3JVNXlBVXJXZzNHSWtyanRHMkpqVGluaUNJQmVGdTlV?=
 =?utf-8?B?Rk9QcUp5RkxrWlduWC9aemd2Q21TNWYwMlUybEFRMHdIaDhvN0dLcE13eW9k?=
 =?utf-8?B?M3RzUkkxQ0dzM1BNS2NQanRGM0FOODFGOW0ydlJXUnN6aWpLRTBVVGlxWEQ2?=
 =?utf-8?B?RXVMNlY0dklENVhkZ0hSTE1zUiswQnQra0tBZVpmRmFHRFNTYnlUb3NHMHBq?=
 =?utf-8?B?MFh5bjFocllUUURmSUdXZENLRktta0lHRFd4MUo1TWVkSEU4eGpmMlhWQlM5?=
 =?utf-8?B?aGNsYkRpdi9Hei80MWlyTjJ2bW1aanV2QkE1YWlKemYyRWh1bU5KUVZVTVN6?=
 =?utf-8?B?d2ZDRm1pZFpOODNPcXBIdG56V0Z3YWx0eGZDVnc5ZGN4MHBYc0I0L2Rjb0Rk?=
 =?utf-8?B?NG15NTBGRkg3MHFZMWh6SlgvZ3FYOVlhTHMzZ1hRdnJBdnBBT2NCTWVXNEFX?=
 =?utf-8?B?NUxVaGdnV0hraGZDcEdVUW5MQW9aSy91SkpkdDlvQ3hxcUFDRHRjbm83ME5W?=
 =?utf-8?B?cVhVbXdhZnlUc1EvM05OMkZ6N3ZqaGVLOFlEYVFHUEhVNCt3elJJVjIzaHo1?=
 =?utf-8?B?SFFtMjFNdkxqdkZxTHg0WG9IeHRaNVdiT3NvSkZzLzhMUkNyZ3FOY0NSVm8x?=
 =?utf-8?B?YWdKZ0Rrdy9tbGYzbmRyL0RjWE5sZTZ2UDZrWjZCY0RITEIwejBOOHl1eDhk?=
 =?utf-8?B?b3dTeWNnTkJEMnZKNlpiM1Q2QURlbVRDMGxieElxWWRjRzdnVFl6SDEzSmVp?=
 =?utf-8?B?d2hsSW44U3p4YnVnRWRNWG5FUVB2U0FqWHExek1mR3FOVXU4dmdDaUxsWTUz?=
 =?utf-8?B?T05SenhlcWh6MXN5dElwUHpLcEdhSFV3RngvR1hQdGhJRjVYaWNHZHpkWTVv?=
 =?utf-8?B?WWlPckNkZWJLVFVsL0pyKzQ0T0VheXJYUHZkckQzdDZYRC9JYjNWRkp0alI0?=
 =?utf-8?B?bnliVVN5OHR4ZG51RnFUakdCd0hmTmFvdjZsY0N4aDFtMzAxQmVmdXJUSW1E?=
 =?utf-8?B?blJXWEJscTVDYWprTEJyelhOSmM1YkdaMEJnVmdqRXhVVWsrU1JVQWZxOXpM?=
 =?utf-8?B?WTJXWDMrMmpUbURreE9qUW1tVWZjV2Q5NGtuYUY0NDRLV2xYdEVTKzJYZkV4?=
 =?utf-8?B?ZGxtV1FwMHY0MUpVakdvTTVuZGVoaGI3OUgvZ2RtOXBMZitWeFQxZGQyUUI1?=
 =?utf-8?B?c0dXdDk5WHNqQmEvbmRXVjVrRmRZaUx6MEdVb3dQNDhMNTE4OS9LaDJBVEli?=
 =?utf-8?B?TkpuL2hCQktyenplOVR3dGZ2ck5vMVpqNTlZM2c5bXU0MEtZelg1MG1sS2tj?=
 =?utf-8?B?V0M0ZFF0YVJLOHE1ektWazdOanppZlJaRHNWWHA0U1drUDh0SFRsTmdaMTBX?=
 =?utf-8?B?TXcyWUVoK3ZWZW1tMG05S0VXOVVvbTZxYkl2NjhrMkFqSGF0Rm1rdXJvZ1hn?=
 =?utf-8?B?c3plZXpjWWhtMTFtLzRNZjR1TzlxZVFBVy9saXEzL0EyWkNwY0xrYzQvazA5?=
 =?utf-8?B?emdTbFhkTWlTQVB3bGhQaHNHVUNhMkk4WFNmMmF5REFSUGREb3VUb1VTTVUr?=
 =?utf-8?B?aXhyaGRoVmp6UW4vMFZRWC9RS1BFaHlVcFVSaWRIN0dWL1ZoOUV0VXZ1Vm9r?=
 =?utf-8?B?V3hLeUphc0piK0JXSTE1S21NYnhhM1J4WSsrVHBtdFdHMFA2aFIzSDd0Wldp?=
 =?utf-8?B?ZlNlTlI1NzJLSTJVQlFYbisxYm9vMVZadnlWaW9xVnlIWHVubnBTYWtxY21I?=
 =?utf-8?B?N0hWampobjdOcjk3Vm1ib1k0aXUrYWppcjBuOEpGT0NwZzZFeGIySnZRMGtz?=
 =?utf-8?B?MnJSdDh6a1Ztd0dxb1E1eGNzSHFmMVRrV3VPN0cxbEw0NHErZTVzMWZVWHNW?=
 =?utf-8?B?bUxWTFl2QUdYTE5ocjhTeHoxVFFnK0VZWTYxUEh4a1dPdSt2bkE3RmlqR3FI?=
 =?utf-8?B?ZG5HRmhNTzhmb1lmdFBhSVlsM04wb3N0eTZkc3hYaGNTUVQrV0RwalZvc3hZ?=
 =?utf-8?B?T3VBVE1qclR0WnJxWlY3NUFXb1ZKajc3b1ptVWtBVU82UytrV0RqS01QVHVi?=
 =?utf-8?B?ZTVhUlR4THhzT05FRXBydWNwZmJ0MHlUZ0VzSW9tSlJkKzQ4VERWQ2o3RDFs?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lbPsJtkdbaRuenmoNGyG4modrJre5YOGo+sq1xRbDTNgOdq4Lcuz+mlg7RX/GPL5c0inCskOdJXSiOMx8w18Zx28OcgoaDJ6yJbij+iHR116Ft2JdEXNEjcvCwGbIk5Kh0KgXJVsIADoA5pHe7EPWFehOC46NvWizrfWMKShNWuH3bwbZLQxXXqZC+ZIsaRNABM2XfDzYQMVmBQA72vYhgjV9lLZXVIDX8g9w+RddLktQiMqF6KyXlisgApxwnK6v/ms/mipXrVY44F82D8JhyjcLbazSTRTJhsTHBU4ICKivglCcsu+qr4hKMdT6c4zT72vIRRyDkQF0x1exm/T/9lsuQjm+GFvMSUl4TicXQ4MZVNOwVbs691Ac/JaWqe40oyX2hg2y2S2BKv2q7y/1lJmDNWvfpAtYRZ07G8WEtOGjztK244SGBq0zarxIF64oGtKo2ijb4vn/40tBzRCRPkNTmXPgRq6mHzbnZYfGWllIuGU4IajqecG7UvcCRv45SRu62RdzP9QyIkoBR2XQb9NszFjXakNNHCfGnt0oi+yq7EUQJv+IgQ/wm6tzXLhMq9cS9vZGw/LcnPt8MdF3DKFEjl2od3ioIG1dZye4WCnurWQE2PkoBa/67LaGk3Xz9mXUPQ8NAQPv4JLFT1h6O7A7TIjDHQH4+1EM79OwDutqG4qVZnvqIMKjliEXC5U7rZPpmhzmvfiy0GcWz/nOVnpAH0WHKXoUWYPKGOGJINtb34GpbHhK+CpirFm1HbHwT14Ha7rWVjIFsMDd/3OTmwJGmUNdaBVSbGN86owKSxlWbyHAKugRfRXEMwsx4s1sTxE4RqTDaKtXca1D0l8oUr1I9ix9G6PZL1Eb7pftkt7l1L4hP5N2z3gBtZ6lsGh
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9997aa86-3f9e-4953-dca2-08db68131d8a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 11:25:51.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: io+F5RlYTX6S+eKJvMw4xXmWU/XdgrS6kjYZI/lk7lEACNIgV6h5so5LTQ78qphJ31pfjJqSP4akngdOC6R4BN7q4QnNwzwnNMhFpso0Kyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5733
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 1:25 am, Thomas Gleixner wrote:
> On Thu, Jun 08 2023 at 00:43, Andrew Cooper wrote:
>> And yes, wiring this into SIGSEGV/etc would be a sensible move.
> The only option is to wire it into die_hard_crash_and_burn(). There is
> no sane way to deliver a signal to the process which managed to run into
> this. Appropriate info to parent or ptracer will still be delivered.

Hmm yeah.  Something has already gone seriously wrong to end up here, so
terminating it is probably best.

> I really wish that we could disable syscall32 reliably on AMD and make
> it raise #UD as it does on Intal.

You know that's changing in FRED, and will follow the AMD model?

The SYSCALL instruction is lower latency if it doesn't need to check %cs
to conditionally #UD.

>> Furthermore, despite CET-SS explicitly trying to account for and protect
>> against accidental mismatches, there are errata in some parts which let
>> userspace forge legal return addresses on the shadow stack by dropping
>> into 32bit mode because, there's a #GP check missing in a microflow.
> Didn't we assume that there are no CPU bugs? :)

Tell me, is such a CPU delivered with or without a complimentary unicorn? :)

>> For usecases where there ought not to be any 32bit code at all (and
>> there absolutely are), it would be lovely if this could be enforced,
>> rather than relying on blind hope that it doesn't happen.
> I think it's rather clear what needs to be done here to achieve that,
> but that's completely orthogonal to the intent of the patch series in
> question which aims to make CONFIG_IA32_EMULATION a boot time decision.

Fully inhibiting 32bit mode is stronger, because it impacts code which
would otherwise operate in CONFIG_IA32_EMULATION=n configuration.

Which is fine, but I agree that it doesn't want to be confused with
being a "runtime CONFIG_IA32_EMULATION" knob.

If the runtime form could also come with an equivalent Kconfig form,
that would be awesome too.

~Andrew
