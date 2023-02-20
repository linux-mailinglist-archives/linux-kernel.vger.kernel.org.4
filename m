Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C7F69D45E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBTT5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjBTT5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:57:40 -0500
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B1B1DB9E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1676923058;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+4j0qYjE5ACobqntXCEKVy1ii6VK0RadWIpCTtHlPME=;
  b=Lcgx5GSH2BXo5ghAj81Zo36rDNlLY7SFdhPW3NfszeD06ARHPewS7KSw
   NdEjEFCo7JIdhVe2kTLz6lOImbgLxs/Q1dKNwTGdKnyzQZPhKvGUdTjly
   3D3LUPraNJHsbSmrSmYQhhIBhU8egFwTLhkt185yooxtlCb5zzApOzmFl
   o=;
X-IronPort-RemoteIP: 104.47.57.41
X-IronPort-MID: 97797752
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:qc+xwqDG9syVphVW/5Ljw5YqxClBgxIJ4kV8jS/XYbTApDt2gjRSz
 TQaWj+CO6veMTTxKdt+YNm3/RtVvcDTmN9rQQY4rX1jcSlH+JHPbTi7wuUcHAvJd5GeExg3h
 yk6QoOdRCzhZiaE/n9BCpC48T8nk/nOHuGmYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbyRFtMpvlDs15K6p4GlC5gRkDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIwpv9KJltpx
 9EkCiE/TTKJocWu4ZC9c7w57igjBJGD0II3nFhFlWucNtB/BJfJTuPN+MNS2yo2ioZWB/HCa
 sEFaD1pKhPdfxlIPVRRA5U79AuqriCnL3sE9xTI+uxrugA/zyQouFTpGPPTdsaHWoN+mUGAq
 3id12/4HgsbJJqUzj/tHneE17CQzHykBdh6+LuQ2q9KiUORzzwoFxwvW3C4uvSIt36+cocKQ
 6AT0m90xUQoz2ShVvH0Wxy1pi7CshN0c8BXH/c75walyafO5QudBmEPTT9HZ5ots8pebT4tz
 VKNmNfoGzFuqrTMEFqS876VqXW5Pi19BWMLYy4JSU0e5dTvrIY1phbOSMtzVq+zktDxXzr3x
 liipSwzl7wVgdQGka679ErbmT+EoYLARQo4oA7QWwqN7QJ8IpalZois6EDAxf9FIMCSSVzpl
 GANhMGYquMTCJiX0iOQWPkENLWo4euVdjzanVNrWZIm8lyF43O/cJpCyDB4Kl1gPssNdXnue
 kC7kQNJ7bdBLWetd+l8ZIfZI80n1qHIGtPiWfTZKNFJZ/BZZF/Z1CJjf0id2ybqikdEuaQ+P
 5icWdyhAXYTFeJsyz/eb/sS1a8DwiE42H/JQpb631Kr3NK2aWCTYbgCN1SKY6Yy66bsiB3X7
 /5QMMyFzxgZW+r7CgHT8IgOPRUJIGI9CJTetcNabKiALxBgFWVnDOXeqZsjY4tkmq5Sm8/L8
 2u7V0sez0Dw7VXLIBuHLHBqbqjiW75+q242OWonOlPA83s7eoep46c3dJYte7Qjsut5wpZcQ
 /AbdoOAC/JURzLv/zUbcIm7rYp+eRDtjgWLVwKnZTEjY4VnQSTG/djregap/y4LZhdbruM7q
 rykkxjdGJwKQlw4CN6MMK72iVSsoXIaheR+GVPSJcVec1nt944sLDHtivgwIIcHLhCrKiam6
 jt6yCww/YHly7LZOvGQ7UxYh+9Fy9dDI3c=
IronPort-HdrOrdr: A9a23:O/0Oj6k7Tg1QRRnGQE2+QdV52d3pDfLr3DAbv31ZSRFFG/Fxl6
 iV7ZImPH7P6Ar5PUtKpTnuAsi9qB/nhPtICOoqTM6ftWvdyROVxehZhOOMrQEIcxeOjdK1vp
 0QF5SWZueAamRSvILW2iT9NfAKqePqzEmvv43j5kYody1RL4tHyChYJDqhOnBXYi4DP7YFfa
 DshfZvln6ueXEadMSpCmNtZYX+jtfWjo/hZRIcJzNP0njtsQ+V
X-IronPort-AV: E=Sophos;i="5.97,313,1669093200"; 
   d="scan'208";a="97797752"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2023 14:57:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyzB/dVTSnYCvp9xHtTIiKNfMBmEXe/tR7Vx7NHSFO5W5DJg2lGqZilHipB6ynKIExeH7LMhvVy9O2XPa35LReEzEMWYUo5abD3NSatV4V8E16VwTOo4c2S0l2oIcidSRGKPERvrgQjKitK0jAbv2YHI/5uLFSXCqEsVfgi+IDGMaZb2Z0wW9NgWoXbI4op2xDY6OiIZ6ytNNzIFWG+8c+dxwck4a5gxjIniyOyNGdA7EHUXnlGi3YbvbCq9OsRKw90gNvDQHG2PowVxUY/TTE0FQOzca6W5nc2IyF0RH5b4mUYlEDPxe5EHAhA8jgIif7VcSPqDhAg90mE/k9wPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THeAvxxeHi4KQbpunRQ/pptGZ6NujxLJfw1a5vIpRu4=;
 b=LqNLYfrj2tPI7deybXES6Ks6ey3ISAubN5XBSSEjAMNNcQzda2OXVQvwxgENxpkDImWTLYuY2nodDcCrxfD95c16VQ49gViy3lsgaOuVjGnOw5C2luLu/K0iKIuMXIZofkvNTYMH0sYnzwiy3SzvgPNHgLtsfWe8Y5jgsoF+eDwIOQipMfa8owrFewwkOCefF6CkA3ed1yQ/MzIIbfKODt1Q4ITo80IAbojvniUz+vNzcSavj6Cj6RFfWv2C44BVy2omAG7QQFa3DpdFraT2mZSgZX3+Mv15n8GVDe799xzIimg8dfllFFAjAz88HYdRUwfD5t19mqC4epyNNDZwGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THeAvxxeHi4KQbpunRQ/pptGZ6NujxLJfw1a5vIpRu4=;
 b=FD/4FRjPLJ/UvZ616/xesFmaZy3cu4PWoo9Zl9E5s+VS8nh1p0YJUQYpfJOtNseEkecwZ6uRRVmUE5uCRp4y+1e9MQK9UyvPnBFAmBVbm/g5eask/rqsVsGTLl3ywYvRUQ7FcdoBynfvlMveN1asyUH2ltVZlHz5hK4gT2PecNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB5775.namprd03.prod.outlook.com (2603:10b6:a03:2d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 19:57:34 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 19:57:34 +0000
Message-ID: <3a65d18f-b218-60e7-4748-f1609eb76fd5@citrix.com>
Date:   Mon, 20 Feb 2023 19:57:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH RESEND] x86/speculation: Fix user-mode spectre-v2
 protection with KERNEL_IBRS
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>, KP Singh <kpsingh@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
        pjt@google.com, evn@google.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        =?UTF-8?Q?Jos=c3=a9_Oliveira?= <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
References: <20230220120127.1975241-1-kpsingh@kernel.org>
 <20230220121350.aidsipw3kd4rsyss@treble>
 <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <Y/OETPFTJbGtCADM@zn.tnic>
In-Reply-To: <Y/OETPFTJbGtCADM@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0445.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::18) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SJ0PR03MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be72e16-0260-4158-cbeb-08db137cb501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +egAGk+yCapAnkLeZ31vq1pOS00Pqzgffp+TWcd3CDVr0ydkxMkxzn+LqwdpLSFUDFeWmtOCibdTzWBH2i0QM8p/JvoyD0Cq/NOwhEosITf/4zyZs4TkEGdDqGFWF1dPSuUljGbz21Lj2J91VeBS5Km8gQvwzfEjip+2DmNGiDU6iH2PS53s7FEKMAvOQ4qBPioQSB6QhgTr99/HUlsgOo//Z2mkO6lSmZZ0UXDZWqyMumYWSDwj6v/FVT/f5jv60uEqhUXLR5tVGfc/1p/njKEcEIuxp9AqV/n+9EtZnfeNUJ9/r9seG2uI2VsKxJtK43+eelkLAXFvqeNrRPilB+tzjO6ShupkEAf976WdGJ9wEAeoYd9P1WxvJYTKOLVmJdXg12OTWaMelOz8z6AyStFyeDU8NSHN6B9PnRgnbWsJuqEj1/bh1dfO+O6yPmAmFQd0GFMVL+B4R4nYpUBFHcb660oFlLkel5C2ZLGG/chXqienYvmLlYCIZ9UstD0AAuIw5m+0Wa1mQ5JSnWZNHWKDjZiy7NayHRy7ywK21xY10fxAfT44YNV5rqgXFjCwdk39l04D+KoJtJwxLDUx/GgGjNddELXD4NPQ8nQuWY3wpErQ2Pm9Zighm9yCEbNHkRiZaaCnCFUc9/6yMykbF8mzxewpdSYjI4FxQZOyASA20zHdqFsx22RWxqKa085SyG93Q3spoOU40U0HtGyMw9s7qFzCRhHs8Wvu0e26QIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199018)(8936002)(2616005)(7416002)(5660300002)(31686004)(478600001)(31696002)(4326008)(8676002)(86362001)(66946007)(66476007)(66556008)(110136005)(83380400001)(36756003)(54906003)(316002)(966005)(6486002)(41300700001)(6512007)(186003)(26005)(2906002)(38100700002)(82960400001)(53546011)(6506007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTAxc1N6WnlKODdnQXFKaGkzK1VxdVBZZ2JKR1hmMTFHQ3ZTbE5aTWt2OWd2?=
 =?utf-8?B?THBzV0p2WllQc2xnWU5GcWtvZTM5aUtIbHlBSGNDTUJhQ2dZdnppbkJQK2FF?=
 =?utf-8?B?OSsvN3FOVFFpczVNUkpHaUIyOHgrU3dySEVNMHFrdXg0eDJTZjBpTXAvVkVk?=
 =?utf-8?B?RDVRUS9HdnhUemRWaElGZXBQV08xYjVzOHhZMkpzZERjN1paY2EycEhhbC9v?=
 =?utf-8?B?T2IxMWsvN2h6dlViYm1JVVVtNEpmQXkyc0lrZjNtMFVxMEFJL3lEWTgzRlZN?=
 =?utf-8?B?TDg4cmdmM0srQUlTeVZieWZrOHJyUnpYR0JJSm1DRXQ0clU2anQ2L0NtNlMz?=
 =?utf-8?B?RHNHNE1Yd09ubkpXNmdaS0l2L2hSOWYrLzlkdnI5QU54MXh3MkVjUVFpOURG?=
 =?utf-8?B?czdwVm5GQUVIMlJKMFhVYXJPcEZrR29BUW80M1I2aVdacm5nK3RqYnhaSTY2?=
 =?utf-8?B?MHNEbkZ6NjlndXZieVptQ0lJWkNBV2QzS3BQTDl5TGtPMXNVQWsxZUZia2tm?=
 =?utf-8?B?WHNSR0tzNFhHWFE1YkgyQk9RU0diWEI4akc2Z1czbG1XT3prMVVPODI4K2FU?=
 =?utf-8?B?RjJ0VWpDa1lTbksyOVhuMUJQZ2Y0NGoxRlc2SjZLWlZjRVFDTmxlZDlnZHVT?=
 =?utf-8?B?UTV1emZVaHdBNDlFR3gvT0NlbDVzWjM0cnFuMFpBY1NIOUVtK3JFNjhZMlpM?=
 =?utf-8?B?Qi9KVnhMRnVtWXlOYzVLNjZKK0FXYk9PbXZzTWVrd0xmNTJjV24vWkx6N1Jy?=
 =?utf-8?B?YlcwRWlNSXE3akxEVlpHZndid2RBMVNVd0Zsc0FSc0pMemlZbXd2U3p3Nnlw?=
 =?utf-8?B?ZXU3ZS9DT1hiYkJFYmEzRW0xQWxhY0U4MGhUSHQvWlpwT0ZqSFIvMVVCQ1Zv?=
 =?utf-8?B?Q1VjQWN2Zm1veHVURGFYQXJ6NndGL1FOd1VIRFMvN1hVM25VTlpNaDBvaWE3?=
 =?utf-8?B?T0x5eDhsVEVsVzJNaXFPMnZBUktnQVQ3NTBQajR6MkM0MVhmc1lmeUx3WG90?=
 =?utf-8?B?eUlyY0ZCblBobDkrQ3FnZUYxQzgzREFUZzdtSnRJNVc5MEpnbm11MnBaVU9o?=
 =?utf-8?B?V21renoyNVJQV05YWkdoVTFsZEgrWUxoZkJMYjZLMExpOUZXZzg0RW1xTEND?=
 =?utf-8?B?aXovZjdMZ0gxRDdjWmJkRitqWEtHcFNJQVNjTlhvVzZIMUxOeU1oRjZGM1pJ?=
 =?utf-8?B?N3lLTTBnQzVDb1NJMHE3U2hxYUVCVjhKN2diQnlORFkyQ1lvRmRodVdnb0kv?=
 =?utf-8?B?SVgxR0I4V0owTGlLQUZxdE5obTRLWGdhUG5NcUpFdVFKVFFoTzRsUVlaQlJ4?=
 =?utf-8?B?ZlZDeU9VS05OV3FJbzZIRzdWdFZLTWszbEtnbjJoTUxEbWZPcW9iWmV0VzZP?=
 =?utf-8?B?TWk0aTBxSVNTRVhITjhYNzR3RWM0QWI3OUE4RjV0UXNZc1dUQzlqT1Q5MHRi?=
 =?utf-8?B?Zll0V2Z4YXBCK2dQd1BzYmRXWWw5aTNobUhqaEdQZFF3TklieGxSRnc0a3Vu?=
 =?utf-8?B?QUlWTEtLdEljSEMwMFQwU2NXSU81MW44RGJJRUovWFVCcVBtNFVyZ3pOdTJ3?=
 =?utf-8?B?M2lUTVhvdElvRHh4c0twY05jTzJFSW56Z2VDVkphbk50Ylg5SkRsMHFLRCsr?=
 =?utf-8?B?bGxoMWxHaTZ3Y0NOWEdUSXVma3JTUUZaMlEzWmdyaW1LcWo0WitFOTFxa1ZQ?=
 =?utf-8?B?bFlUY3pXdHo4WVZ6bVJDcWY0Y0JoNGVEUnFmSytXemRSZzh1UWh6Q3VhUldj?=
 =?utf-8?B?VGNYSm9CRzJIOUdqNXRpbXo5N0xhbVdhSk5hYW05M2NJVkRzeWtlNS85UEpB?=
 =?utf-8?B?UEFrd2FqL3d3aXVLbkRscFRRVUhrcUt4Y2ZteWd2SmR6L0FGZ2RIcU9UOXVU?=
 =?utf-8?B?eHFTSEV6a3VxMFN6Qjh1SDlxUmE4VXpnUTN2QTFiazJjWHB4YTIrUmhFeWk3?=
 =?utf-8?B?SzBqbEMxNnRWM2p2OEU2bm1LVTlpODBuUnpvanRJSUMwM3pTdFhydHIybk11?=
 =?utf-8?B?VTJrY2Q5MGVjRnUvbGxGU3plTHlOWWFGL2Nva1FjOWZNeFJPNUhPdWMydExM?=
 =?utf-8?B?Z29TS2xveVdnUkp5VXdUZDY2eVpjNFZBME93QkF6dnVlZGlRMnFBZFpFNU5R?=
 =?utf-8?B?aHhMdXlFSUlaNjZrOXhYR1FQNGRKb0VrSndrUXlHYXdjSnNJZWp5RHdnZ3pp?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NGQ4dWREeXlsb1ZGTnVsTHhRM1VMTlNtcWo1akM5YlV6RDVDLzVaWS81Vmlp?=
 =?utf-8?B?ekZ4RWxoNnhkZE1XNmhNbGN5ZjJYUjl0dHpnTGpRaC9GUDBFQm11b1JVRUZq?=
 =?utf-8?B?UGRIang4T1BiOFExbThOR1hVOE9ZeTZMckdQWXBkOTZMQldZTis0NUlqU1Nu?=
 =?utf-8?B?Z0ZCcWkrdDFvb3pud3VhTyt2UGkwSXBwcno0Q1gvTDEybEF3MUplaVBudFVS?=
 =?utf-8?B?UDdSVkhTUjVGalNmZEk1Tmdnb3RwN2tFMVdMekNURDVCMnFZSTM2RWFudWZk?=
 =?utf-8?B?Y2phSGdTZCtkeG91cFJMTlFlNnNJTzlRbWFvUFYxMHN1L2U2VkFVOEhTcXlR?=
 =?utf-8?B?Y2RrSE5od2RZb0FTdjBIQVJLVUFvQ0FVTWNoak55b2FxcXRLQXI2M2lULzNT?=
 =?utf-8?B?VU5QeG1XSjZ2TEZxRVZqU0c5cDBxdWpDdFFWamxLVzZYd0FQQ2VwQUVtdS96?=
 =?utf-8?B?TkZGZjgvZm1tMHd4RjdpMml3L2tWSG1TU2M1MTNJMmNSYy85NldWRmNuaitp?=
 =?utf-8?B?UDJYZmlES2Fva3pvRDhlVW1PdXNHQWJnektCS2tDbWFPd0pxUnJ5WnlEcU5D?=
 =?utf-8?B?OGVpN0pVa1NqaEJQUy9zRUZaTmhBU2VPaHJwdHFsQ2pTRGJjYXU3NXA1SEhG?=
 =?utf-8?B?MTU5Yzd1Zm1OcnVRTjZYZWZFUXZ6ckF5VFN6UnNxQmx3U2NoVHhsNnhtZHZq?=
 =?utf-8?B?cUcvNVY1c0x3OUhlRTN5Y0ROWHFER3FmR2Y5ZDMycnp0bkpKZXFnbWNxU0VJ?=
 =?utf-8?B?QnhHeWx2Q2J6R0wrdWh3T29sS2ZjQktPbkVFOGVzcGFBWk5Rb0xZZjlNcVgz?=
 =?utf-8?B?a2lZSERXQ01qZTltcTdwSjI2cTFvVkYycThUdW9KUjRnenNRQlFSMjN1U0tN?=
 =?utf-8?B?M04zOGNmWUNtZ1BoQXZlSmVERGt4aWNlRElidHpDekVnWVZ5M3Z0NUM2Z0w1?=
 =?utf-8?B?VE5VbTkwdkpLbjhCeFRJb1pSRE9wYUhGelhiK21uKzRqdlBmd29pMDNVYldZ?=
 =?utf-8?B?U2d6bzlYZ0RVNWdBNW8yQUxHUUdyaG9UMEVtUjgvSkM4cFJEWmxHUHgxaHYr?=
 =?utf-8?B?am81MVRjUlVldDluaGR1T29wUy9URU5ZTW9KWnRiWmxPcWlPMU9xVHVZMWoy?=
 =?utf-8?B?cklOYUxCaGJ4VjBVdC9IVmxBZ0xJS2NHcmpuVnhFdy9QNHc1MmtwQ3lWS3hL?=
 =?utf-8?B?UStBUkZuNEVSakhsaG9uaVoyYndGaEpqTzJ5NW9ucmFpdkF2VmlUWW9va2g1?=
 =?utf-8?B?UmV3Ny80VnM3TElXOE53emkyRE9Ld2tlR0VDaG82MHNaZmxXaWZnVHl5Rmhy?=
 =?utf-8?B?R0kwUnR6NTAwdUZzSmVOeTZVMVNzNDlCQTFITGE3eHJsWDdFd3hSVVl6dHRm?=
 =?utf-8?B?T1J5MHF3MTgrazFwNmJRTkhsdFVUR3lySDdBbTZlc3NtOGdtQnVYTlpsSklO?=
 =?utf-8?B?YTQ1ZkJjUjRHNDJ6SzMxTVJIcXZtNHg3ZE1CZ3NXTnlPZVk0QVJwVHhlalZI?=
 =?utf-8?B?UW0yQ2tBckxtdUhkQzdsYnRYVkNRbjlBVFV3ckxLNjN1REc2U0ZWRlo0SzZG?=
 =?utf-8?Q?guup3YwaQl42jyx+hUxR911Cg=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be72e16-0260-4158-cbeb-08db137cb501
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 19:57:34.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uN95YM+Sv2bVktIjL3VEYMYU3lJSx4EoZp9Mr6hDbHTwy3xzYQSFItBgjEAizPY0YpKsce47Ojfbk3fZPwTifIM3RnzT3nP2T5NsYbm/ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5775
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2023 2:31 pm, Borislav Petkov wrote:
> Drop stable@.
>
> On Mon, Feb 20, 2023 at 04:34:02AM -0800, KP Singh wrote:
>>>> On Mon, Feb 20, 2023 at 01:01:27PM +0100, KP Singh wrote:
>>>>> +static inline bool spectre_v2_user_no_stibp(enum spectre_v2_mitigation mode)
>>>>> +{
>>>>> +     /* When IBRS or enhanced IBRS is enabled, STIBP is not needed.
>>>>> +      *
>>>>> +      * However, With KERNEL_IBRS, the IBRS bit is cleared on return
>>>>> +      * to user and the user-mode code needs to be able to enable protection
>>>>> +      * from cross-thread training, either by always enabling STIBP or
>>>>> +      * by enabling it via prctl.
>>>>> +      */
>>>>> +     return (spectre_v2_in_ibrs_mode(mode) &&
>>>>> +             !cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS));
>>>>> +}
>>>> The comments and code confused me, they both seem to imply some
>>>> distinction between IBRS and KERNEL_IBRS, but in the kernel those are
>>>> functionally the same thing.  e.g., the kernel doesn't have a user IBRS
>>>> mode.
>>>>
>>>> And, unless I'm missing some subtlety here, it seems to be a convoluted
>>>> way of saying that eIBRS doesn't need STIBP in user space.
>> Actually, there is a subtlety, STIBP is not needed in IBRS and eIBRS
>> however, with KERNEL_IBRS we only enable IBRS (by setting and
>> unsetting the IBRS bit of SPEC_CTL) in the kernel context and this is
>> why we need to allow STIBP in userspace. If it were for pure IBRS, we
>> would not need it either (based on my reading). Now, with
>> spectre_v2_in_ibrs_mode, as per the current implementation implies
>> that KERNEL_IBRS is chosen, but this may change. Also, I would also
>> prefer to have it more readable in the sense that:
>>
>> "If the kernel decides to write 0 to the IBRS bit on returning to the
>> user, STIBP needs to to be allowed in user space"
> From:
>
> https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/indirect-branch-restricted-speculation.html
>
> "If IA32_SPEC_CTRL.IBRS is already 1 before a transition to a more
> privileged predictor mode, some processors may allow the predicted
> targets of indirect branches executed in that predictor mode to be
> controlled by software that executed before the transition. Software can
> avoid this by using WRMSR on the IA32_SPEC_CTRL MSR to set the IBRS bit
> to 1 after any such transition, regardless of the bit’s previous value.
> It is not necessary to clear the bit first; writing it with a value of
> 1 after the transition suffices, regardless of the bit’s original
> value."
>
> I'd love it if we could simplify our code by not caring of the IBRS bit
> when returning to user but I'm afraid that it ain't that simple.
>
> This above probably wants to say that you need to write 1 on CPL change
> because it has a flushing behavior of killing user prediction entries.
>
> Lemme add Andy and dhansen for clarification.
>

"When IBRS or enhanced IBRS is enabled, STIBP is not needed."

This is misleading, if not strictly wrong.  The IBRS bit being set
implies STIBP, which reads differently to "not needed".


Now - eIBRS is "set once at start of day" which ends up becoming a
global implicit STIBP.

I think we're discussing the legacy IBRS case here.  i.e. what was
retrofitted in microcode for existing parts?

The reason why it is "write 1 on each privilege increase, 0 on privilege
decrease" is because on some CPUs its an inhibit control, and on some
CPUs is a flush (i.e. its actually IBPB).

But these same CPUs don't actually have an ability to thread-tag the
indirect predictor nicely so STIBP is also horribly expensive under the
hood - so much so that we were firmly recommended to clear STIBP/IBRS
when going idle so as to reduce the impact on the sibling.


IMO the proper way to do this is to set STIBP uniformly depending on
whether you want it in userspace or not, and treat it logically
separately to IBRS.  It doesn't hurt (any more) to have both bits set.

~Andrew
