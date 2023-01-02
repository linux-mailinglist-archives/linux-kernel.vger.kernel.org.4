Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F6B65AE84
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjABJBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjABJBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:01:43 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF2AB0A
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:01:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cg72R58Tz5vsxuORyHWQOprjTQWRBe6BqBEPIJJ40cY/NUhJpPvO50h3Y/myoISGAWNr7Q5eXlbutkr0BjrmsgvN4a54sHFweTjCWmIZWqbT7DEK6rw76b8NMfMV5F6Jqcon7OrxYQR0LlVsy5AgPZnflAtr4rlhIQ7cpan0yp4NmTSrJOL4XY3O4c2uMlyKe311jnYZG19lNjqW3ArUDyFQWRNR9y9wEha9j3PZphgapfuUEkBwT0uGC8rXehhUxlvmiFo+/Sm55ayEpWKOkHIwMPpiR2ctaZ4dGOe4nsGy5CsVeAK/eyvQH3lHD3iRdKtTI3AmXy8wsFBqFmvRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sAl43VBKwRD9ZV/OfIfQd70D44S45aet9CAsO7Xye8=;
 b=e3cK72bpoN5kxKhUAoNocgawGU7bzjhIUyBhR4IACHH5/A948eF4SqejSpHMk0s4C5REY/w6tkPvGIkuht6K1AJnViKLN2vVC8ogrUiWAaDRg1RZevZDOE8j25ZqObhdaHbRs9IcEC8+ySxOSo3TLSa2hw4CCnBVEExGz09M3mgeTeENRY+LgYM6iki1PkI1aXFKDTmVWBah9NgyMPsYkaezRnY+/kdi8x6Ma5iS2bZwUhJF0DR321o8bDBbyF4hJUwZB/0pz90e2mdhGbHd47jy3mW0V8rlCTyuEIXS7gjBWLoZj0/wKCrr1LkNg4lBDPh9RbyV5ZySbp81gcShAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sAl43VBKwRD9ZV/OfIfQd70D44S45aet9CAsO7Xye8=;
 b=u6Eg9jra6rzqUDYaCIsdfK3is2mDoLPPRAgCFJ0OqUZLSoc/lQb48mRVjml7PWd4wLQzttjy0IcQvil7O7+g3mqVYnPPPJe69TWTBOobbnbFAI6cwkYG2KdsWzEhlMai724gFAQ2h2Qz8D4m8ExahzJKlIUrP05iWMtVjmtO2DiwyA3g9l97GDvKTUbbcn1U4BVMgl2ZJ2I1RI6rmxDz5VD9zUI6pDrz2m/DoibhYTziL574zWeTwFMQ8codR6Lv5Xm0KpjR/t2PCq1CcHDCczqt+UOkfEHYv2ds0JnBZQ14fgNgBIoCIGHkpZVOzUZafIAP8J0A5AA5MK8cHpoW1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7647.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 09:01:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 09:01:40 +0000
Message-ID: <821d07c7-35b5-cf8c-b9a9-09dabdb3c893@siemens.com>
Date:   Mon, 2 Jan 2023 10:01:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] scripts/gdb: fix 'lx-timerlist' on newer kernel
Content-Language: en-US
To:     Lin Ma <linma@zju.edu.cn>, kbingham@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230102074340.17459-1-linma@zju.edu.cn>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230102074340.17459-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 046e3b7f-418f-4c81-0b9b-08daec9ff646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7Eur9Mh7PqdwdsvT0EQ5vMDiClduFztEZi6jSPlO9AC1sIybiANKazWmBahWqBDakEDBDuvwoVGoQDRPUdOQs7GDdB2fTNUjNw56Qqs4H8UwMzYZFjqXPyFvB87ZwM70UOa059ekSHK2Kscd2YtHnKNWUmiq7sN5fctCGo1NesTl6WvpfwDQISeurFhhKq67nvJ1ISpHclp7+SZFZWmBS7QBjV4S08t3hV0dMml/JwliHXKGOJa8NK+CdbQIRIfvxGIQT1nbEGpWbcAvZbQGr+jBieujyoWhvmos4hLuECguUtLr4VDQtgdTfyF4vf/MAPEj7RAVOezdSNo0ip3IiqnbfcetEdFVMIbdjJaTRqtvCzUoRErJ6xKEkOolKlprj3mMmORx28w//SbHOymNgFYES4fbmsANC9l5I36c5detzoLHep6t0lKwXdlvPuhbHgUqCdekitBW5DPKDUArnN7GjElfDUeLkHh54YPIel75wKQgeVcKyrU30Icq6SwBRVAk9pItAl89jmX1tBsTOaMt6qSsiXj1xNzyRz6vU3868ionHP3iDomxRYaBIhXi6q3DbobJ23SG5X/Z9CqPcNmN7d0hjRdtiZuP80oV5wxko2u4jEmbnezm5MDtltvNHwOmLOrevnn2d+wRUFAFUzwhFvytmBCg4t0uNWR9bIwRZgHLaT4TzU74g8aWDpWHLgCT2OdyL2tEcquKTgEK36QP/7i2snHQo37kXsmxW5H+oS/dxo8Ww8ZDQBHkTeu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199015)(83380400001)(2616005)(31696002)(86362001)(38100700002)(82960400001)(36756003)(66476007)(8676002)(66556008)(8936002)(66946007)(2906002)(5660300002)(186003)(44832011)(6512007)(316002)(31686004)(53546011)(6506007)(6666004)(26005)(41300700001)(6486002)(478600001)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2R3cndTWUJyeFB2d1F2Vmh0eVBVcXdIdkVINnhxM1lkaXBRNDBjazNpcEVD?=
 =?utf-8?B?Qzl1ZW9CbEpKaXZ1NEtBSW5QRk5Ua1VkVytHU21SY0F5aFk2ZDFiV2pILzRW?=
 =?utf-8?B?R0J3L3d2S3NWR2ZVQlM5K2t0STBIdWVYM1dEQStjbFhDVnpxVnpWMHBockF4?=
 =?utf-8?B?RWJJS1oyK2FTd0g5OEV6VmttSGFhbWdCN1YyemlMUmEySWlhTTZ6MHo1Q1NK?=
 =?utf-8?B?alp3Y1E0ODJuQTlxWjgyZXN2UDh6Vk5RSlpZKzhoWi9ITEVEaHZZbUVKT2N0?=
 =?utf-8?B?c2tBV2xsS2ZhUG11Q2NEN214cHZvRlJZczlRMVZpMHRjOGxLMzNzMkVUOVFR?=
 =?utf-8?B?OUtZTFp2R05iVVMwTGZvZGVrS290cHpseGpMbnl0QWFCUHdqem9tRVAvdWF0?=
 =?utf-8?B?OGZOKzB2a3NTUWRPcmlUL3Uwc2N3blpWeGg2d05IbkFIdURnNDFPVTlBamxU?=
 =?utf-8?B?SXpVU3c1dnBzTjlwQWtOR25TcDN0ekk1TWd1Zlo2R2g0SjI4OHIxSFc3NmVi?=
 =?utf-8?B?WGFxejM3SWwyQTBXdWljWEoxRXEzM1dJZGE0aGlpK09uY05JSTNOS2p1L1Ni?=
 =?utf-8?B?S3cxMXB6SXVlSTBUMHlzS1hSbHdPcGdHb1M1b1ZxOVY5YzRTekZ1Z25WTEJF?=
 =?utf-8?B?Tmdvcm9Kend5enlYb1U4T1VvendyejFFSWpwS3h3SS9WTlZhU215RzExeENP?=
 =?utf-8?B?aHJYOW8vWlJ2dXBBdURGZC9ySnpDYWc1SFBybjVWYTZpSTdVblBVYzUreGxF?=
 =?utf-8?B?ODhhNmpqdU1BNThJSXlVWCt3aUV4K1VibU1MaTNudlFiK3ZudC9LWHVYSFJG?=
 =?utf-8?B?MWd2RzViVjEwcWhLeDFqTU1pTzZ3OUhGSE5GM3ZqaVJ5bUVIL2YyeTIrOXN3?=
 =?utf-8?B?cE41dXNpd0lURDhqM1NMcy82VEllb29ZUm5Jei91WlZwLzY5eTBKS0MxT2Vy?=
 =?utf-8?B?S1dQV1RCeGJMTXJEc2xjR2dDK3JadU5PSXovdTRKd09WNnVBT0tmQTVvZDI4?=
 =?utf-8?B?d2trL08yck5qeEFuWXdUMUljQjYwcG9Hd08xaXVYQ0hpbzBaRlBQWXFUaXdL?=
 =?utf-8?B?RzFrQmxaT2ZVcnljMlc0aWdoOGlXb29rZ0E4Rkl0RS9aV2lzZjlZSU5jRUtn?=
 =?utf-8?B?SldzVzJ1ZDMvZHFQbEJCZy9vMkVMdHQxSDRUdVdMYkQ4V1MxOUxhMEpTeC9I?=
 =?utf-8?B?MFpRREVST3cvc0VPN0dORE1zK010SnkrWjh2WVo4U2gxV0FSWjIyOEluTTF1?=
 =?utf-8?B?YnUzMEhnQ0tLRU8xbHpHeG5XOFkyWVpZd05HZVVqVUdmZk1YZ0lEbDZpeUlL?=
 =?utf-8?B?Z2thS3dGWkhmSnlZNWx6Z2VRYWg1NEtsdjBmMGZDNXVuems1S2xHZ0hWbGs0?=
 =?utf-8?B?NEJzVmxKazEyUU12WEpyQ1crT3EyWEtIRENSUEdTUnRlYWs3WDF6RklwNjNX?=
 =?utf-8?B?VkFRN1NnY2lURVFkS1gra2o0dkVyc29qR3NrZjk0QmtjWG5YSlRVa1poYVlU?=
 =?utf-8?B?cGx2UEV0TmRDQkUrV0JjY21IUjB3SExXUGs2QXErY2dVKzBmZllkdFdka3ZT?=
 =?utf-8?B?dHo0OENybWNwKzZpemlOSlRxeXNweEQvTnlaSGgyOE1wT0E3UklmVUpUWURD?=
 =?utf-8?B?S1lpcktiajJ3SE90OWdRb3gvc3VjVTlCUkRQbW9qMHdSRkhPWnYrSnYzMitW?=
 =?utf-8?B?WWFsODdBRnhYYitxL2JuUmxYYklUemp5MHhjL1kvUmlmME1mckNzVUMwMlB6?=
 =?utf-8?B?em5Yd2FoZ1JjTjB3T0dOdk12SitoTE5VWmpxUHZEUWkrZkFXUmFSdkl1YnJF?=
 =?utf-8?B?ZHBGeHc2T3ZLRldVVDR0UU90WnRmajlCZ0RlbWtKSjNEV0xIazQvUHd0aWpO?=
 =?utf-8?B?WkkwSHNWc3E1L2UwaHlJVFFHc2EyeVU4VEpPby93TWdEMEFDZTBWM2F2a2FK?=
 =?utf-8?B?a3VmdnNsZlNETmdYNUdObC9rdjByMFI5TXkwVzhEUGx6QmxtVndXcmMzK1JM?=
 =?utf-8?B?SnluY0xsd0QxanlLM2JKTzFrMTJIekIxbFMrRStRL2ErdnprZXdxbTEza2lV?=
 =?utf-8?B?T1QzSzBUUTJZbE1KMWNjV1FzeFVmbUEvTGRPSVpWeWFja2U5NnlyelM1UXVZ?=
 =?utf-8?B?SHNQYU1BdHJFdUNyVHUxaTQzTE9PNjFsSmhsMW1aTk5UaUZPUXFFT1hzVXRG?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046e3b7f-418f-4c81-0b9b-08daec9ff646
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 09:01:40.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Nfhoi3UcGxyYyEdrgl0Oxna2XpTcQEi+XCSADKWOKI+iqMMJ//P2/aqC7fiXxQ9y4aTPn1acEPJvOfFz23qBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7647
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.01.23 08:43, Lin Ma wrote:
> After commit 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for
> next timer"), the struct timerqueue_head changes internal field hence
> causes the old lx-timerlist command keeps reporting errors.
> 
> This fix addes a simple version comparison and necessary code for

typo: "adds"

> traversing timerqueue on a newer kernel. Moreover, it fixes some
> python 3.X compatibility bugs.

The gdb scripts are in lock-step with the kernel version they can
inspect. So just move the logic to the current kernel and drop support
for older versions.

Jan

> 
> Test with python 2.7 and python 3.6
> Test with 
> * commit 442284a89a65 ("scripts/gdb: add a timer list command") and 
> * commit 88603b6dc419 ("Linux 6.2-rc2") kernel
> 
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
>  scripts/gdb/linux/timerlist.py | 41 ++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
> index 071d0dd5a634..65d035df253d 100644
> --- a/scripts/gdb/linux/timerlist.py
> +++ b/scripts/gdb/linux/timerlist.py
> @@ -4,6 +4,7 @@
>  
>  import binascii
>  import gdb
> +import re
>  
>  from linux import constants
>  from linux import cpus
> @@ -42,9 +43,15 @@ def print_timer(rb_node, idx):
>      return text
>  
>  
> -def print_active_timers(base):
> -    curr = base['active']['next']['node']
> -    curr = curr.address.cast(rbtree.rb_node_type.get_type().pointer())
> +def print_active_timers(base, oldver):
> +    # 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for next timer")
> +    if oldver:
> +        curr = base['active']['next']['node']
> +        curr = curr.address.cast(rbtree.rb_node_type.get_type().pointer())
> +    else:
> +        leftmost = base['active']['rb_root']['rb_leftmost']
> +        curr = leftmost.cast(rbtree.rb_node_type.get_type().pointer())
> +
>      idx = 0
>      while curr:
>          yield print_timer(curr, idx)
> @@ -52,7 +59,7 @@ def print_active_timers(base):
>          idx += 1
>  
>  
> -def print_base(base):
> +def print_base(base, oldver):
>      text = " .base:       {}\n".format(base.address)
>      text += " .index:      {}\n".format(base['index'])
>  
> @@ -62,21 +69,20 @@ def print_base(base):
>      if constants.LX_CONFIG_HIGH_RES_TIMERS:
>          text += "  .offset:     {} nsecs\n".format(base['offset'])
>      text += "active timers:\n"
> -    text += "".join([x for x in print_active_timers(base)])
> +    text += "".join([x for x in print_active_timers(base, oldver)])
>      return text
>  
>  
> -def print_cpu(hrtimer_bases, cpu, max_clock_bases):
> +def print_cpu(hrtimer_bases, cpu, max_clock_bases, oldver):
>      cpu_base = cpus.per_cpu(hrtimer_bases, cpu)
>      jiffies = gdb.parse_and_eval("jiffies_64")
>      tick_sched_ptr = gdb.parse_and_eval("&tick_cpu_sched")
>      ts = cpus.per_cpu(tick_sched_ptr, cpu)
>  
>      text = "cpu: {}\n".format(cpu)
> -    for i in xrange(max_clock_bases):
> +    for i in range(max_clock_bases):
>          text += " clock {}:\n".format(i)
> -        text += print_base(cpu_base['clock_base'][i])
> -
> +        text += print_base(cpu_base['clock_base'][i], oldver)
>          if constants.LX_CONFIG_HIGH_RES_TIMERS:
>              fmts = [("  .{}   : {} nsecs", 'expires_next'),
>                      ("  .{}    : {}", 'hres_active'),
> @@ -165,7 +171,7 @@ def pr_cpumask(mask):
>          i -= 1
>          start = i * 2
>          end = start + 2
> -        chunks.append(buf[start:end])
> +        chunks.append(str(buf[start:end]))
>          if i != 0 and i % 4 == 0:
>              chunks.append(',')
>  
> @@ -184,14 +190,21 @@ class LxTimerList(gdb.Command):
>  
>      def invoke(self, arg, from_tty):
>          hrtimer_bases = gdb.parse_and_eval("&hrtimer_bases")
> -        max_clock_bases = gdb.parse_and_eval("HRTIMER_MAX_CLOCK_BASES")
> -
> -        text = "Timer List Version: gdb scripts\n"
> +        max_clock_bases = gdb.parse_and_eval("(int)HRTIMER_MAX_CLOCK_BASES")
> +        banner = gdb.parse_and_eval("(char *)linux_banner").string()
> +        r = re.match(r"^Linux version (.+) \(.*@.*$", banner)
> +        if not r:
> +            gdb.write("failed to load image version")
> +            return
> +        lver = r.group(1)
> +        oldver = lver < '5.3.0-rc1'
> +
> +        text = "Timer List Version: gdb scripts, old version: {}\n".format(oldver)
>          text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(max_clock_bases)
>          text += "now at {} nsecs\n".format(ktime_get())
>  
>          for cpu in cpus.each_online_cpu():
> -            text += print_cpu(hrtimer_bases, cpu, max_clock_bases)
> +            text += print_cpu(hrtimer_bases, cpu, max_clock_bases, oldver)
>  
>          if constants.LX_CONFIG_GENERIC_CLOCKEVENTS:
>              if constants.LX_CONFIG_GENERIC_CLOCKEVENTS_BROADCAST:

-- 
Siemens AG, Technology
Competence Center Embedded Linux

