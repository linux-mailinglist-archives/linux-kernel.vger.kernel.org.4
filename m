Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0B0699D25
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 20:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBPTrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 14:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjBPTrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 14:47:02 -0500
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6735034E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 11:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1676576819;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TCRQcZRZ7Ua5eAd3BDPD+hDqFi+gKwPur3OXltXTHuU=;
  b=Q92FosZnahZof6vIFnLIrzYa/+0XxJU4OUBh0v8nqiiErQD5mya3FNQQ
   XRQBgINYKPkuooBFcjHFJ47bv1UiuYhb8CriRtdAoVhIjaciJnwxUe2xE
   dv0rX8omD+owpT2rawinZGjNUI+/FFQAXDmRi4pQuMfo7PlRN1v4XODew
   A=;
X-IronPort-RemoteIP: 104.47.73.175
X-IronPort-MID: 96207302
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:cevFY6hp0rw5/Ovw+55Cun1VX161CBAKZh0ujC45NGQN5FlHY01je
 htvUG6DPP3eY2H8co93PYiz9EpSsZ+DztJkHgNrrS4wEnsb9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsy+qWt0N8klgZmP6sT5gaAzyN94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tRHCykJURWjwN6o45WebcRg3NscIJfkadZ3VnFIlVk1DN4AaLWbH+Dv2oUd2z09wMdTAfzZe
 swVLyJ1awjNaAFOPVFRD48imOCvhT/0dDgwRFC9/PJrpTSMilMqluGybbI5efTTLSlRtm+eq
 njL4CLSBRYCOcbE4TGE7mitlqnEmiaTtIc6RePirqEx2Af7Kmo7FjlLeXSiuuCCmmW9ApFfJ
 WoEvXsKov1nnKCsZpynN/Gim1aHvwQdX94WCO0n9AyIzbT85wefG3hCTzhdZdhgv8gzLRQm3
 0GE2dPgAyditpWUT26Q8vGfqjbaESINBWYGZCICHU0J7rHLu4gvjgPGSN95Gb+8iNTzXzLt2
 yiXtzc3gqQ7ic8NyrX9/FbbjjbqrZ/MJiYp6QHHdmak6B5lfomjZpzu5VWzxfdbJYWECEiIu
 XEEktSXxOEIEZyJ0ieKRY0lDOH3z/WIKjvRhRhoBZZJ3zCs/WOzOItX6zZWIEZyLt1CfT7vf
 V+VtQ5PjLdQMWunZodzYpmtEIIry6b6HNjoX/ySacBBCrB1dQma7GRtaFSW0mTFjkchi+c8N
 I2dfMLqCmwVYZmL1xKzTuYZlLo0nCY3wDuPQYihlkv6l72DeHSSVLEJdkOUafw057+FpwOT9
 MtDM8yNyFNUV+iWjjTrzLP/5GsidRATba0aYeQOHgJfCmKKwF0cNsI=
IronPort-HdrOrdr: A9a23:Ode076nmzuf5lWsgD/9zMmGYBT3pDfIW3DAbv31ZSRFFG/Fwwf
 re+8jzsiWE6wr5OUtBpTnuAsK9qB/nn6KdgrNxAV7BZmbbUTCTXeVfBOLZqlXd8kvFm9K1vp
 0PT0ERMrHN5fcRt7ed3OEVeexQouVuUcqT9ILj80s=
X-IronPort-AV: E=Sophos;i="5.97,302,1669093200"; 
   d="scan'208";a="96207302"
Received: from mail-mw2nam04lp2175.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.175])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2023 14:46:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCbB27RCObTJMDzYh7fTYCPJS2rXI9VPa3xI+lscjuch3UNyveHx5gqdebq/HIamTJ9Ow5AlkAU1GJ9+KrP2QInobLPqFuQytsfLndOIa0EkcBy/+F2uTqh36+nzkyRw7T1loINEc3I+axYvV9pJN2PT5QPmBSa1uzdxObWkU2ZSY9qjZOOtWsjeEodhgWyljltcXoa/TEzAt/xFJxKgQsEcdy5hLFh4gakqLbOufWSuFRMrghjxbpwnHI8GB5qBkOHBUjoSQiJvuiFaLJvK1Wz27jQT6zqyS8NIybsDmNkw2NHagIgt2I1aiPas2ModE2I8Ge/C448VVlYvYqAZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCRQcZRZ7Ua5eAd3BDPD+hDqFi+gKwPur3OXltXTHuU=;
 b=bonWX60Q9OaAr/z7/Xc+gT+Vd+oep/Rc6p6SF/3J8viCT3aijJ+rt1fVAo10l798F82iSLEjDEzHWGxMxroNR6zTrtQmyopqrLz86KOyz0DrvD03eEfe/A06LTRgqT4nU5TgIeHbUs5AqEhbyrtDb4eluONFMPSi4EHJEU8nc6HVLaArjjxExWLFx9x3uZcSdqluTRaR3l+DDveFdV4BEHN917teGWYflU5BKE/6ed+SNetP2ijK0H4tTMFiNkWvvjuU3LHX7FJ+NfQFPU2+bG0kHuPiYhun8pCy4gHYYPMSe8qF8+CwN2gb9eJhsehikZIcbSKHSwBKC3KhUaeVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCRQcZRZ7Ua5eAd3BDPD+hDqFi+gKwPur3OXltXTHuU=;
 b=pvaxAhDuWvJdxEcOGISI3afIDzCXsh2+hlaQ2YwjScyYqitChuN4hORRRUuoCywChKNc2G089P/t5cjTHdG9tW8c0ye8bMzZ5LYzi67/KvU9wsJr/nq49GXSGIBPwBYeqmD2q6qDKQ8GapfyIZLRzMYsOoys+X/IkphWOSC8FgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH0PR03MB6398.namprd03.prod.outlook.com (2603:10b6:510:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 19:46:56 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 19:46:56 +0000
Message-ID: <1144340e-dd95-ee3b-dabb-579f9a65b3c7@citrix.com>
Date:   Thu, 16 Feb 2023 19:46:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] x86/kexec: Preserve CR4.MCE during kexec
Content-Language: en-GB
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230213234836.3683-1-kirill.shutemov@linux.intel.com>
 <20230213234836.3683-2-kirill.shutemov@linux.intel.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <20230213234836.3683-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::14) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|PH0PR03MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: fff599f7-d570-412b-4547-08db10568efc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDca0lYL6HV3c5gWwtAGx3McnSZOj/0lCwc/FEWr4f3sejF/tE4XNq3SjXpVcBtXP+HlXuKc+CoCHt4kRTlhefiIiDIvfqTBN20PSmJX7w0FN2pe5i/VHHEboC+duuyv6Q0ePDgTK9fBdIfGFWtw0lJreJwTq110eu+ARkRaO9F8yjHOILBubopQiA2IcBFpGbNHDoMPa9zrAnUl4yCr86m95EzVulCyEq18ICyRt4CUMCrqNXyktKOhpnKKiKlQOg4VJB/SU0aLJ1MJA0lvDjTJP1R4f6hOYZeX0VNVLB7uTVYwF6Unow9yGh3KoXsAxg29QXmvTUEsvj5Q4/b/il/saFsBq7f6Nvodyt2X/gjJocBQtafnc771ntNj+5E5ikKCJ55D4ozhUGc3T+uS83+zaZ1iZvFd6yyh2fHj4YTzs8v0RA7ntHVPzZjn7khj4THj8TaurrXXoBl5mPPwQwSEi0pr6tonlFiIhwdGpLeoTZV42RoI7cU1WGMB669lN6q7DUwFmZDai5D9D/GhG/HfYvmpVeUG0/+ySAxlk34r5gVYDpKcDZqZo9bibnekhJ5QNHz0U+6GkZnVIYk+8+dZNx2Q268ke3a6OBjs8QyxePU7WALJzh0vHJidRrRltBEwAoDHYjThTUPE/+HtEBYKC8UUYQF5s6OOodjK09z1QtVdasEUZ+aLdZQ3eUywSwgNcoNaQLGdbNetFTSkJYX9c6mCA9YaSghymvSOVuQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199018)(2906002)(478600001)(31696002)(86362001)(31686004)(6486002)(66899018)(6512007)(186003)(26005)(6666004)(7416002)(53546011)(6506007)(36756003)(4744005)(5660300002)(2616005)(8676002)(66556008)(66946007)(4326008)(66476007)(38100700002)(8936002)(41300700001)(316002)(82960400001)(110136005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTQ3b2d1UjZiNjJieWdJNGdsZmpGYlpEM2lBK05GbEFMeWdLNThLTTNKak5m?=
 =?utf-8?B?WlZQOTRVMUpNbER3ZU5ubC91OHE3SHMvVXlVNzJUeEszWVNJdTRSVFVjbk9V?=
 =?utf-8?B?aVdZYlNZZXdtckhqRmxuTklwNXRCeEx3cmlSUEtWVXZ0Rk1qOTVYMEw5MnFZ?=
 =?utf-8?B?c05ObXRiYlUvVHhHcWgwTlp5Ris0bkFWOStycDlHM2M1Tng1RWtOb3BuM0Rq?=
 =?utf-8?B?WUNzc1d6b3R1L2FmK3o2QXRNNCt6bXVzL1hZV0huWC9nczJkbVZxSGYwWFFO?=
 =?utf-8?B?eUdac0pQQkxKQnJrNVhxWk5GcUF0MUM2Z1lUaGZjbE9wbER2NkJOLzJiTVBu?=
 =?utf-8?B?c3dmWTBuWktWUUo4MzdoMVRucE5jYXNHMnRJZlRHb3VjcC9XMUNmSFlJQUta?=
 =?utf-8?B?bEFoVTdpVVRRcXRTZmc2cnBsbEtpSHVrUHM3R1BnYzdodjZJc044RzBJQVYw?=
 =?utf-8?B?QVdyQXVOQVFYYzF6aEhLTDBHbHlFcEJyQ1Z6enZLcHl1dGx0Z3YyYURDMmhF?=
 =?utf-8?B?c2hpTFJ4dElPR2xvRjV2MUZmSlpoS1dJQnIxbzM1NVFtVDFnUm92Zm5mVWJT?=
 =?utf-8?B?dWxPdUVLem1jeStIWGhqMFVFUHVYQkNSdHlQUHJnYjRlaUVjcDhxV3NSQ0pK?=
 =?utf-8?B?YktLL2NDUDVGc0Y2a29DTWRjeEtNWEEyTStEM0tONzFXVEdtR2RSR3VvaXRX?=
 =?utf-8?B?K0RNS0ZWMjArK1ZLdFJhZmRDc280VDBIUFA1ckgvc2hWVFNPUkJPekY5a2lW?=
 =?utf-8?B?ZHQvamNFaW15WGhKNytBUVVXYmNrSjFTVW91ZWZMa2VSQkV1K0djc2Q1NVBs?=
 =?utf-8?B?RnEvZzhMdTVrVDNERkdxckpYSitQZFlzQTV1ZEgwOFB0enc5Nmd0VFJLdkZG?=
 =?utf-8?B?aS9xRlN5OTczVUNoSkxIaW9HMzN2WTl5SGJOdllEQWtoWkJrb2xFa21ZVjVi?=
 =?utf-8?B?dFBMSjFLeGVSdC9DQTlwa1hmbHZSek5tbFVxTWlQZE5YWGJ3eTQzMkFsb3Y5?=
 =?utf-8?B?TmJjdlJrTGVOSFFlTUtOM0hJL0V3bVhvbjMzLzh5c3FjUnhyR2NCekMwQkpJ?=
 =?utf-8?B?STZ5WlpPdmM0RTlHWkZqa1N5ZFN4TXE1QlMyemZqSGJRQUZQaWpNYjJqTE5P?=
 =?utf-8?B?clB3RmlXUmdObUNhZGxjenE4UndvVTM2dlJQRk9oS0lDQ3JqM1pIbnVyd2E2?=
 =?utf-8?B?TkNnZlBORUxTMDNmSG8yNzFTMXR1ZzdDS3h2M3owNzlJNmI4K1FQRzFodFhZ?=
 =?utf-8?B?Qk9XVzRkbjI1NGREM2xyQTY4V1JHdkd0K0hKNzg3WkRKZ3ZRdDc3Y3NXalBX?=
 =?utf-8?B?Q3g5WktkeFVicllDeTBBN1FQdFlib2laYXZYN2VVNkc2aDV4cHJtOVQydXdT?=
 =?utf-8?B?ajBORU9nbzNBOW5mLzNNZVQ2dEg5cDVXZk5hUEtSK1l3VnFZZlVzQVRBbDdL?=
 =?utf-8?B?anN3ZGJrQnZIS25ZZ0NjWG9FblJzTkdTaFlLdGR5enJKcmNiRm9NT0xlWUhm?=
 =?utf-8?B?ZGUvUlRHZ040YzZQWFIydFBqOGtpMHFKZ3k0dFh0aWM1blhIRS9IampHV3FX?=
 =?utf-8?B?ZVcydUdSQnVUZ1JTa1p1VVJLNnRHRG5xVW9RWXVFSkhFNzhzS0hoSGJyWmRm?=
 =?utf-8?B?eTh0blJFNzZENnMzWnJ1ZVFER2k5WGMwOVhSTExEaVJ5dkJSbks0dTlsWTIr?=
 =?utf-8?B?NytwSXhBcTRBdEM4NVZJZi9FMk54TVRjZVJzdkRkZkM2L05NeUdvRlBYNU9j?=
 =?utf-8?B?emx4MXh2RlZNbkxvdW4xemgyTXhhdHFEZTZJN203MFdZUUgybGtFSkgzUlRM?=
 =?utf-8?B?b2Q1VGhrT21oRFg5T3FEdmZQSFY3TndaR3hkMTBHMmpOOXhmZ05teTJFWnNU?=
 =?utf-8?B?UmdjV2UreWc3bWxiSFhBZ211OGRZVFcxRVdpU3VVaTNqNm5xZzNlVnl4Q1pt?=
 =?utf-8?B?bXpraVROaldwOUVGUGtHYzlYZzdVbnk3MzVXMXFkY1phSW9DWXZkWTR5N3ZO?=
 =?utf-8?B?T1FKVU16eDIzbE1HSnNKbXVIYzlBckovMEh4SDNOem91aHBMeTgxZW1KeGsr?=
 =?utf-8?B?WnR6bTVyOTdSSXIxbWFGTVRnODl0RHgvc00xVEwzdmpVRVJFTzRoSTVESTIx?=
 =?utf-8?B?RkxiSGJwN0FyMlc1UG1vaEFHRnpKZ1BNbDgzRHNvWGgxVE53M3RZSURUTDQr?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MTd3TXVwUEg3b3BqNVJHd29ac0k5WEcxTUh5ZmxEVGtXS3pkQ0FpQ2JDOE1D?=
 =?utf-8?B?TU9BcGxhRTEzUlZhUmI5R2cwSEhpU2xrOHlCUXVJb1FkVWg1S0dNSkJzbFJW?=
 =?utf-8?B?bVg1RVJrRWxwTHZZd05XaXpUTk81TERBZkNFWUtxVnVvRW5VVmxMQUVPYzla?=
 =?utf-8?B?bms2VmlsMFZMdVN3MytoVUQ4RlhKS205N0k3TWZ5akJTbm5PWm8vNEo5S1Jp?=
 =?utf-8?B?aisvOWhDUnhBZWptRlIvTVMvc2cxdmV6MHFZQ0ZvNEgvdG5wbmI4QWl4YjRx?=
 =?utf-8?B?SFJicDZBMENncEloQ0NWN1AyeW42T0Y0RWRiYmRtOERiZDNBWjkxeXZ6Qk9o?=
 =?utf-8?B?NERKUUROalR1Yi84dHlMNXpDWUJjdVpJYmlWSmgzWDMvaWNkOGdNSjB2bWk4?=
 =?utf-8?B?a0RBRzBrTnpZNG9GVFlFdktLVitXRjlzQ1lTb0FaenBHbGdzbVZZSGVWVzdI?=
 =?utf-8?B?NDFubXM2Z1IybHFKc2xKMVBnamRPZGNUWFBxYndxWVoxamVNQ2lhek9aL014?=
 =?utf-8?B?UVB5dUg1U014QVpTSkQzZ09CVmh5ZUNUS3lZVzZ3QmREcHZCNlhXYUU3Y3Bh?=
 =?utf-8?B?SFUwenZmQ1M1WEZyUURpQTRrWWxzNTd4bmhTWk5FRHBEMzFSNStMZW5NMDlm?=
 =?utf-8?B?YUQ4QTk0WmlDZHVJeEx4cW1PcmhPZnpMeGR3eEsvWUR4U3BlVVczdG8yemM0?=
 =?utf-8?B?dXgyYi95UHVNekVGVGxQbzdmcWdLQk9XK0tReEkweUxnYTdEa3hDcy9rVGZL?=
 =?utf-8?B?bEhkUVY3L3VHdldOdXZML2V5Q2JxaW9mcEZaRHNOYkMvdEJjaEJNeDA3S0pF?=
 =?utf-8?B?bkdhVHc4cnJSNUdHZ1JvZm9hWnk0b3JoNXZjRGtGMFliLzVqZzRYUVVQVW45?=
 =?utf-8?B?UWlGd21id2VXOHl5cFFkdzhiTGlOUVBhdjRSZmNUdmdEd0hocHlITU9HM3RB?=
 =?utf-8?B?OUp3eWVxVStVOEtBbDljNmVEbzlDZHgvK2NiYW9pZHIvUEM4dmpURWphYVR0?=
 =?utf-8?B?dG95bTZSQzBHWHdBeEhESUVpM0RYVUxCSVRSRlFTNTBTd3lPempqSUFJNkZI?=
 =?utf-8?B?QmdlUk5jOGptTFBVQWlTdjhlbjZLY0tqQzdVaGtJRzI5RmpDSzdGNGd2ZnJD?=
 =?utf-8?B?dGhXalQzREdBNko2d0pGM1gxQ21VVEJCQWNFcHZOdDVzakFTTHZ0UUV0SWdE?=
 =?utf-8?B?dDVqZDY3TGJ5aFR1UkcyTnExZGhVT2RhK2hWL2hTcGFCZjJlZjNTeHBzeENY?=
 =?utf-8?B?ckc3WVJBS1RKQlQ5Nndvdi9uSVBxU2pobGt3dTNvek93enZjMWtJQnFxTUhy?=
 =?utf-8?B?cHRaeGE0NEY1K0lpT0pyN2JIMUtzM09nTnlGZjdOQ0tPNFBQdnpyK2o3OG5j?=
 =?utf-8?B?MkdHYURFY1k2Tmc9PQ==?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff599f7-d570-412b-4547-08db10568efc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 19:46:56.1279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXAySr9VLpe/IHRoBlUuoe74GKjQfULJ+73nKMeMWOyfmTu5H3ktYovpIWXN0xkV4akw9QyjmH2W19PGoFbpJ/A8rcDE1Zvoo/FlmAL/5RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6398
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 11:48 pm, Kirill A. Shutemov wrote:
> TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> to #VE.
>
> Preserve the flag during kexec.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

That's unfortunate for TDX, but in a non-TDX system you must never
maintain CR4.MCE into kexec.

Async events, including NMIs, cannot be taken between this point and the
target having set itself up into it's intended operating mode.  During
this period you get all kinds of fun with type confusion in the IDT/TSS
and/or not having a safe stack to service the event.

A clean shutdown from not having machine checks enabled is far
preferable to trying to deliver an #MC in purgatory.

That, or you're welcome to debug the next bug report I get where
(amazingly) an NMI managed to hit with a good stack in the new context,
but most of the old context (IDT, TSS and .text) still intact enough to
start emitting a very confused oops onto serial...

~Andrew
