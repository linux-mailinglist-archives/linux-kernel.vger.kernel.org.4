Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D8465AE82
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjABI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjABI7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:59:45 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBF72AD8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:59:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD5ta/QOkuFwQ55oJuK8MCJhJhxC+ga8Nx2AswjIXQDuMIiTKj/XpGIHr9Qr7pGrq6jgcNNK87nI/TBNhNtmhRtp8Ki0LRmPKU6Shm/HRlOnEnsJ43s+gg5ysMW1ExthnQ+F6U2HBTZqsuShcsK6+rxSqi67IB2tF9kLzJZjeSLsJbNrmh2JsVMOMwoYAi2u5fUPBOCTMl85bZo/3fo8zVGijnE/lhrmXYApUJpPl4evnYnBFG8yKIo7Se4hbuzlplOePZnRXe9lO93/GdwWaeonn2UmJA4z06pRH/83rgUYiDI+hTKZZ6Q5of6HSsGYsLqg02++OGWnr7Es15jEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yQO9CkSXuDNWPgm44saOjrxuSCYC7ppkInySjTUk+g=;
 b=FluqwkPrYUmwcWO7Jwm8VeZ7/wcxvFiIuCT31bsOgt2Fz0iQiKWnsz8zFb+Lw8s7N6pLEmJn/RpYFYBqvEGtxhCk8Q4As0iSdu1XOR7Tcw+JFAL1OAZOMQWY0+iAC417ZA+qm2fi3SLwL2I+FFKCzwPgqEaFZKHHGq7oheRmpuZZCX/x/qzsrw2rooNlRJhZKSq3Ui0mkQMDYyz77UxlIbvGakwSEmB1H22qTOKHO0URszMB43pAnK2SpNNmhm4UpRy7+OG8N5sChlK19U+OLOR+PXUtc3Tc0PKrm4X7xTtrstLTay1hcMQ9RiKwwgyTzuYkPd4f0oghDlSvbvwwEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yQO9CkSXuDNWPgm44saOjrxuSCYC7ppkInySjTUk+g=;
 b=N4FgIqc4g2+jgLGTXjFAAzO0fMqG5eLq+Q27FwVUsQKFuvh/DGk0sos1RXmd3cps/EKV5TCdceB/9nxPU9wKnDUlr1leRAYc7/hCCLG5iPdlt8bYn9XkyDfT35OyPw3e0okZnLo2AXqwQWqfYNXIIn3VYppdqdzGn96feoQS0meDy5i4tXytS4IjFkJYLLT9+H91dfag2r+W3YNTJ/02ZhZnuGaMbJb/m8dXe1tq3XAwP3QMlvwX68+Jvv59Q5InNA6Ff1Cl6qrfwZPMaExA2pFL/XYUBLahRnvrBUNM3J1wnTpRXA94xkLB2JFktaCHC/4aJxGQ2gwplQjiDHL2ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7805.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:632::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 08:59:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 08:59:38 +0000
Message-ID: <16280f8e-31c9-7b0b-b0c1-4d180c4d0045@siemens.com>
Date:   Mon, 2 Jan 2023 09:59:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] scripts/gdb: add mm introspection utils
Content-Language: en-US
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>, rppt@kernel.org
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        kbingham@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mingo@redhat.com, vbabka@suse.cz,
        x86@kernel.org
References: <Y7E7fEBm6p0Q2djI@kernel.org>
 <20230101172312.21452-1-dmitrii.bundin.a@gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230101172312.21452-1-dmitrii.bundin.a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: c898fce8-ca8e-4d4b-a578-08daec9fad4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANFjOvUf/pX/1F3fktiRyucT6vg3rAEX+eZrPw5c3VpiUHQ9nLBvTJfwh2UKE3KBI/R24cxDC1qa0zuCbJGwhLt/xiWoiunT77IuknWvfECMjjTIl4qkBPSxET6RVTAbIqw/M7Rz+Q1yTgRkrhHgyCAOomR/BvjABgR2MPRnb2gJxZH3CiGXlQ67Vq5fTQXle6NFCAPdUB65xdjP3lMxzFvgOzfshWoL4lrk3/VIgEUrKGN2/ZBFv9Kxqli0ml1OWXo2MhL9htd+Jg0mVTjnXY/eZn+0DSnSXWYtrjtssISyi6fpPUh8RJflLt4FqgfeL3XSy7HJf4sAgK86r10IxubvqjABjJWUteFzFs4PNbUIQEEd8DbLCAfrnmE0YnjhimcXwAIycKbeTN6wgNr1ljkSoZUhfjzFu3K/9FtjIWD3oQrI5iAtxtyAZPzIPDkaHfvcxCEVuseoaAljGHvVN1MJNMHV0J1JdhBaSqd5KVyw53+fW4Ws6Rbps1e61y3u1uXnHvHVpeS/ElBC+AS2MwBjrQQeOJy8XEYyaMy0jyzf7kfvuoTfGzQfH05DslQvMPsEXtfY/33CKbNnYpiVOTUVu0A4dkGkxnJvJuu4zvM4Q4o19USK3Yijn74AaZ5U0bfzXCPXf8KD6ThFxwpuY1NW/3HvKVN2+EtcdnYUmgN713GOYO6pDfuzqlrOOCofbHDrqKPLAaLZ3ppOjW/6qGMFgLkvCHLkp73nBM/UkzrRTD6vwSoyaLiYBJXoDcd+kZ1Lbwvvg2Ebiwk7PTyqrSApEJxAOcgcPGMFR5IahsPySgQQ8zKY8wXKnudiXC4eCo5zmpUreF1XqoZqIk2zfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199015)(6512007)(82960400001)(44832011)(478600001)(966005)(6486002)(5660300002)(7416002)(36756003)(2616005)(38100700002)(8936002)(30864003)(6506007)(31686004)(66476007)(66556008)(66946007)(4326008)(8676002)(41300700001)(53546011)(316002)(6666004)(83380400001)(26005)(31696002)(86362001)(186003)(2906002)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWZHWGYzT2JJQzBPaExTOTlSOXYwY2g3Uml4TWZhNGYyUVUvVXRnKytkRjNl?=
 =?utf-8?B?YWtsODcrcnk2QzRSK0RUVjBybElOUWlXTDBWbDVxL09BSFhpejcxanN6SXFN?=
 =?utf-8?B?R1o0d0lWRmVGWk10OGFreUljOWx2em1RYU8vWTV5Z25RUTNsQThFVCt4QU1K?=
 =?utf-8?B?bU5jeHBFbkpwVytBOUhTTnpzakdOdWtvelhwQU9jeEg0bUdwNFJ4azgwaFZH?=
 =?utf-8?B?KzVjYmQ5REEyNytkUjVpY2dCczBmcmpEQmVlWVdkdGdybWlBVzBWckljUUxO?=
 =?utf-8?B?YVAzS21CWW1mYitNNnVOcStqcmh5VVFqWGlxeWczU1N3VngxVk55TUQrZVV4?=
 =?utf-8?B?MHI3ZnZyOG82eFdnNUdoVU0zTEIrTWlxRUlrdGo1SVJFQTQvUEw3WUd3ckZ5?=
 =?utf-8?B?VHk4VUZlb3ZUdzRhUDdGSFVxUlVyT0RDeHFaRmpXOXJxK2VNZjdIakdtcWpD?=
 =?utf-8?B?c0JTZkFmelozcHZPVm1ISkprc1VXcnpweFliN2ZobVIyWXNPZStINGZ2UCto?=
 =?utf-8?B?MUhrMDJFZ2J5S21xVERkY2FaUWhTamlBWDljNGN6RCtIc1Q3d2xRTTN5OHJO?=
 =?utf-8?B?ZDFUT3JkYldUSDB0d0pJVzhOUHd4QnYyd1JCTXFBYm16RG02R0R3Q2VaTG9J?=
 =?utf-8?B?NExUaDNIZEhzNUZYK1lGRDR0bjlHQTZqUWY4clAvZ2lSRWZpeVp4NHl5NnJB?=
 =?utf-8?B?Uy9wTDY0NTBBS3FpajUyems0SWFCZzZJZVpVRVdFMUs2cmNFd2xialphYWt4?=
 =?utf-8?B?cVJiWEZDT3RtZXNCQWFjQm1HcGJxUGlIYytWdEdiTEM4M1VSclZ6d3JreGxP?=
 =?utf-8?B?cjdCUmswT1FGeHd6WFZrR2d2U29mUnR5M3BUd09Lcm9qbHlWVWFhUFRLK09T?=
 =?utf-8?B?ZkRWampzc2djQjJvQks4QmFnaHl6TjkzbDZVK2N5Z0NjUlFCb0EzbnJ6Z005?=
 =?utf-8?B?eEI0YzYvbEJMb2p5MVg3OGx3ZUFTaWxYZzltRDN6M2FZcVM2cnhaVHh1LzZR?=
 =?utf-8?B?dnNLOHZXRjUyckdlNE85NHR0OWxiT0JTL29nbTZXd0grdVMwL3JrRkp4N25Z?=
 =?utf-8?B?bGV0dHlWRDFWOXB2SkJqekR2YlZ6ZlZmdkFJS2U0VlZjdWR4L3VLeGNvRnVU?=
 =?utf-8?B?UVEwZHhjZ0JHdXFTd3JOZ2N5RHltc1BaLzBzS1VuVDVVZEZLaTBQd29iRTlV?=
 =?utf-8?B?UG5FWEVpRDFQWi9ZcElqb24vSmZ0WkV5SWg2MjQ1K3RjdGgvbXdtS2RETnFr?=
 =?utf-8?B?OGxleU5kY3JRZ2YwRTliajBLRnFkWFNTOWRqQTdtdzdrWTJubldVWWJ4OTRl?=
 =?utf-8?B?TVFsWU9VM0ZsMk1FZ25WcXJJclptc2ZIOHhJQnZxaGtxa29UejYySmR2K2U5?=
 =?utf-8?B?WXdsZmNXaGVqbGVoczU5bDlnaEZmV2NaQ0x3RjR0TVYzRThwTDVJOGRuZCtH?=
 =?utf-8?B?QXdqNlBhR1VtcHpDM3JrZ1NHTHVsUlhxdGx6ZGRVd01Fbnc4UXlLWDRQTnJH?=
 =?utf-8?B?K201ZWVIWDVBUjVVSUR3eHdXU3lRVTFwbWQ5cktWK3owcDU5ZnlNSllxdDlz?=
 =?utf-8?B?MGdwc0FwU0lBNGpXanhUcHdCem1JTG14UzliNlZHZzlpSjYxeFhkVFZwRklE?=
 =?utf-8?B?bGhHSG9selE1UlpudlVxeVlnZG1zSjB4MmNNM0hpY1cybzJreCs1c3d1dmNn?=
 =?utf-8?B?dlNQTEV4ZFZxOEh0bUlnWUIwMEJqZWFiVUpUek51d2hIUkcwRWdmTS94SG1y?=
 =?utf-8?B?QWJNU200SGxld1RjN3JiUytFWEJtSHcyWk1qSDA0bXQ5dExKNk54bEw0TGNY?=
 =?utf-8?B?QUVYbDVWMHJHd0lOYm0vcUZkVzh0ODJzZVJwcFlZaGRpS1FsNjVPbGp6bXA2?=
 =?utf-8?B?dXFFNkpqMXYvUkF4dlN6enVUdlAyblhCZU1uM0VsSFlaQ09SME1XSm1DcnRO?=
 =?utf-8?B?MExPMzRCaVZrV2s4dXZSMXpRQUU3QVIzTG43ajhib1VlZ0QwdThIQ3o0dE54?=
 =?utf-8?B?ZlNpL29PVGNNeTVaWHFyU1YzUmNKZFhWcXRCL2dGenpjS09aM1VXZ0tnS2ZO?=
 =?utf-8?B?d0kxSzE3NEpnc0x6LzFQN3JobWlmTmZIN0YyWmdZM1VXUk1tN3FIMGJFaFpD?=
 =?utf-8?B?ZldhUTB2UW02bUpjWDVzSGlXTE1LaVIwQm1RRnFEWDhNekQwc1Y3a3pJTFFX?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c898fce8-ca8e-4d4b-a578-08daec9fad4f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2023 08:59:37.9854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1G1iNGs4gT7XTfuSJKXqorTWsOr3wdiEzuqH92B5nO3iQm/qWwcsurodtZV90ngwTzckzjmWjScXsM7on2BCZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7805
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.01.23 18:23, Dmitrii Bundin wrote:
> This command provides a way to traverse the entire page hierarchy by a
> given virtual address on x86. In addition to qemu's commands info
> tlb/info mem it provides the complete information about the paging
> structure for an arbitrary virtual address. It supports 4KB/2MB/1GB and
> 5 level paging.
> 
> Here is an example output for 2MB success translation:
> 
> (gdb) translate-vm address
> cr3:
>     cr3 binary data                0x10a1f8004
>     next entry physicall address   0x10a1f8000
>     ---
>     bit  3          page level write through       False
>     bit  4          page level cache disabled      False
> level 4:
>     entry address                  0xffff88810a1f87f0
>     page entry binary data         0x8000000109042067
>     next entry physicall address   0x109042000
>     ---
>     bit  0          entry present                  True
>     bit  1          read/write access allowed      True
>     bit  2          user access allowed            True
>     bit  3          page level write through       False
>     bit  4          page level cache disabled      False
>     bit  5          entry has been accessed        True
>     bit  7          page size                      False
>     bit  11         restart to ordinary            False
>     bit  63         execute disable                True
> level 3:
>     entry address                  0xffff888109042e40
>     page entry binary data         0x10ec93067
>     next entry physicall address   0x10ec93000
>     ---
>     bit  0          entry present                  True
>     bit  1          read/write access allowed      True
>     bit  2          user access allowed            True
>     bit  3          page level write through       False
>     bit  4          page level cache disabled      False
>     bit  5          entry has been accessed        True
>     bit  7          page size                      False
>     bit  11         restart to ordinary            False
>     bit  63         execute disable                False
> level 2:
>     entry address                  0xffff88810ec939a8
>     page entry binary data         0x800000012b6008e7
>     page size                      2MB
>     page physicall address         0x12b600000
>     ---
>     bit  0          entry present                  True
>     bit  1          read/write access allowed      True
>     bit  2          user access allowed            True
>     bit  3          page level write through       False
>     bit  4          page level cache disabled      False
>     bit  5          entry has been accessed        True
>     bit  6          page dirty                     True
>     bit  7          page size                      True
>     bit  8          global translation             False
>     bit  11         restart to ordinary            True
>     bit  12         pat                            False
>     bits (59, 62)   protection key                 0
>     bit  63         execute disable                True
> 
> Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> ---
> 
> Changes in v2: https://lore.kernel.org/all/20221230163512.23736-1-dmitrii.bundin.a@gmail.com/
>     - Fix commit message to mention x86 explicitly
>     - Assign page_offset_base to a constant in case
>       CONFIG_DYNAMIC_MEMORY_LAYOUT is disabled
> 
> Changes in v3: https://lore.kernel.org/all/20221231171258.7907-1-dmitrii.bundin.a@gmail.com/
>     - Make debug output lower case and column aligned
> 
>  scripts/gdb/linux/mm.py    | 223 +++++++++++++++++++++++++++++++++++++
>  scripts/gdb/vmlinux-gdb.py |   1 +
>  2 files changed, 224 insertions(+)
>  create mode 100644 scripts/gdb/linux/mm.py
> 
> diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
> new file mode 100644
> index 000000000000..7bfe39f32b7c
> --- /dev/null
> +++ b/scripts/gdb/linux/mm.py
> @@ -0,0 +1,223 @@
> +#
> +# gdb helper commands and functions for Linux kernel debugging
> +#
> +#  routines to introspect page table
> +#
> +# Authors:
> +#  Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
> +#
> +# This work is licensed under the terms of the GNU GPL version 2.
> +#
> +
> +import gdb
> +
> +from linux import utils
> +
> +PHYSICAL_ADDRESS_MASK = gdb.parse_and_eval('0xfffffffffffff')
> +
> +
> +def page_mask(level=1):
> +    # 4KB
> +    if level == 1:
> +        return gdb.parse_and_eval('(u64) ~0xfff')
> +    # 2MB
> +    elif level == 2:
> +        return gdb.parse_and_eval('(u64) ~0x1fffff')
> +    # 1GB
> +    elif level == 3:
> +        return gdb.parse_and_eval('(u64) ~0x3fffffff')
> +    else:
> +        raise Exception(f'Unknown page level: {level}')
> +
> +
> +#page_offset_base in case CONFIG_DYNAMIC_MEMORY_LAYOUT is disabled
> +POB_NO_DYNAMIC_MEM_LAYOUT = '0xffff888000000000'
> +def _page_offset_base():
> +    pob_symbol = gdb.lookup_global_symbol('page_offset_base')
> +    pob = pob_symbol.name if pob_symbol else POB_NO_DYNAMIC_MEM_LAYOUT
> +    return gdb.parse_and_eval(pob)
> +
> +
> +def is_bit_defined_tupled(data, offset):
> +    return offset, bool(data >> offset & 1)
> +
> +def content_tupled(data, bit_start, bit_end):
> +    return (bit_start, bit_end), data >> bit_start & ((1 << (1 + bit_end - bit_start)) - 1)
> +
> +def entry_va(level, phys_addr, translating_va):
> +        def start_bit(level):
> +            if level == 5:
> +                return 48
> +            elif level == 4:
> +                return 39
> +            elif level == 3:
> +                return 30
> +            elif level == 2:
> +                return 21
> +            elif level == 1:
> +                return 12
> +            else:
> +                raise Exception(f'Unknown level {level}')
> +
> +        entry_offset =  ((translating_va >> start_bit(level)) & 511) * 8
> +        entry_va = _page_offset_base() + phys_addr + entry_offset
> +        return entry_va
> +
> +class Cr3():
> +    def __init__(self, cr3, page_levels):
> +        self.cr3 = cr3
> +        self.page_levels = page_levels
> +        self.page_level_write_through = is_bit_defined_tupled(cr3, 3)
> +        self.page_level_cache_disabled = is_bit_defined_tupled(cr3, 4)
> +        self.next_entry_physical_address = cr3 & PHYSICAL_ADDRESS_MASK & page_mask()
> +
> +    def next_entry(self, va):
> +        next_level = self.page_levels
> +        return PageHierarchyEntry(entry_va(next_level, self.next_entry_physical_address, va), next_level)
> +
> +    def mk_string(self):
> +            return f"""\
> +cr3:
> +    {'cr3 binary data': <30} {hex(self.cr3)}
> +    {'next entry physicall address': <30} {hex(self.next_entry_physical_address)}
> +    ---
> +    {'bit' : <4} {self.page_level_write_through[0]: <10} {'page level write through': <30} {self.page_level_write_through[1]}
> +    {'bit' : <4} {self.page_level_cache_disabled[0]: <10} {'page level cache disabled': <30} {self.page_level_cache_disabled[1]}
> +"""
> +
> +
> +class PageHierarchyEntry():
> +    def __init__(self, address, level):
> +        data = int.from_bytes(
> +            memoryview(gdb.selected_inferior().read_memory(address, 8)),
> +            "little"
> +        )
> +        if level == 1:
> +            self.is_page = True
> +            self.entry_present = is_bit_defined_tupled(data, 0)
> +            self.read_write = is_bit_defined_tupled(data, 1)
> +            self.user_access_allowed = is_bit_defined_tupled(data, 2)
> +            self.page_level_write_through = is_bit_defined_tupled(data, 3)
> +            self.page_level_cache_disabled = is_bit_defined_tupled(data, 4)
> +            self.entry_was_accessed = is_bit_defined_tupled(data, 5)
> +            self.dirty = is_bit_defined_tupled(data, 6)
> +            self.pat = is_bit_defined_tupled(data, 7)
> +            self.global_translation = is_bit_defined_tupled(data, 8)
> +            self.page_physical_address = data & PHYSICAL_ADDRESS_MASK & page_mask(level)
> +            self.next_entry_physical_address = None
> +            self.hlat_restart_with_ordinary = is_bit_defined_tupled(data, 11)
> +            self.protection_key = content_tupled(data, 59, 62)
> +            self.executed_disable = is_bit_defined_tupled(data, 63)
> +        else:
> +            page_size = is_bit_defined_tupled(data, 7)
> +            page_size_bit = page_size[1]
> +            self.is_page = page_size_bit
> +            self.entry_present = is_bit_defined_tupled(data, 0)
> +            self.read_write = is_bit_defined_tupled(data, 1)
> +            self.user_access_allowed = is_bit_defined_tupled(data, 2)
> +            self.page_level_write_through = is_bit_defined_tupled(data, 3)
> +            self.page_level_cache_disabled = is_bit_defined_tupled(data, 4)
> +            self.entry_was_accessed = is_bit_defined_tupled(data, 5)
> +            self.page_size = page_size
> +            self.dirty = is_bit_defined_tupled(
> +                data, 6) if page_size_bit else None
> +            self.global_translation = is_bit_defined_tupled(
> +                data, 8) if page_size_bit else None
> +            self.pat = is_bit_defined_tupled(
> +                data, 12) if page_size_bit else None
> +            self.page_physical_address = data & PHYSICAL_ADDRESS_MASK & page_mask(level) if page_size_bit else None
> +            self.next_entry_physical_address = None if page_size_bit else data & PHYSICAL_ADDRESS_MASK & page_mask()
> +            self.hlat_restart_with_ordinary = is_bit_defined_tupled(data, 11)
> +            self.protection_key = content_tupled(data, 59, 62) if page_size_bit else None
> +            self.executed_disable = is_bit_defined_tupled(data, 63)
> +        self.address = address
> +        self.page_entry_binary_data = data
> +        self.page_hierarchy_level = level
> +
> +    def next_entry(self, va):
> +        if self.is_page or not self.entry_present[1]:
> +            return None
> +
> +        next_level = self.page_hierarchy_level - 1
> +        return PageHierarchyEntry(entry_va(next_level, self.next_entry_physical_address, va), next_level)
> +
> +
> +    def mk_string(self):
> +        if not self.entry_present[1]:
> +            return f"""\
> +level {self.page_hierarchy_level}:
> +    {'entry address': <30} {hex(self.address)}
> +    {'page entry binary data': <30} {hex(self.page_entry_binary_data)}
> +    ---
> +    PAGE ENTRY IS NOT PRESENT!
> +"""
> +        elif self.is_page:
> +            def page_size_line(ps_bit, ps, level):
> +                return "" if level == 1 else f"{'bit': <3} {ps_bit: <5} {'page size': <30} {ps}"
> +
> +            return f"""\
> +level {self.page_hierarchy_level}:
> +    {'entry address': <30} {hex(self.address)}
> +    {'page entry binary data': <30} {hex(self.page_entry_binary_data)}
> +    {'page size': <30} {'1GB' if self.page_hierarchy_level == 3 else '2MB' if self.page_hierarchy_level == 2 else '4KB' if self.page_hierarchy_level == 1 else 'Unknown page size for level:' + self.page_hierarchy_level}
> +    {'page physicall address': <30} {hex(self.page_physical_address)}
> +    ---
> +    {'bit': <4} {self.entry_present[0]: <10} {'entry present': <30} {self.entry_present[1]}
> +    {'bit': <4} {self.read_write[0]: <10} {'read/write access allowed': <30} {self.read_write[1]}
> +    {'bit': <4} {self.user_access_allowed[0]: <10} {'user access allowed': <30} {self.user_access_allowed[1]}
> +    {'bit': <4} {self.page_level_write_through[0]: <10} {'page level write through': <30} {self.page_level_write_through[1]}
> +    {'bit': <4} {self.page_level_cache_disabled[0]: <10} {'page level cache disabled': <30} {self.page_level_cache_disabled[1]}
> +    {'bit': <4} {self.entry_was_accessed[0]: <10} {'entry has been accessed': <30} {self.entry_was_accessed[1]}
> +    {"" if self.page_hierarchy_level == 1 else f"{'bit': <4} {self.page_size[0]: <10} {'page size': <30} {self.page_size[1]}"}
> +    {'bit': <4} {self.dirty[0]: <10} {'page dirty': <30} {self.dirty[1]}
> +    {'bit': <4} {self.global_translation[0]: <10} {'global translation': <30} {self.global_translation[1]}
> +    {'bit': <4} {self.hlat_restart_with_ordinary[0]: <10} {'restart to ordinary': <30} {self.hlat_restart_with_ordinary[1]}
> +    {'bit': <4} {self.pat[0]: <10} {'pat': <30} {self.pat[1]}
> +    {'bits': <4} {str(self.protection_key[0]): <10} {'protection key': <30} {self.protection_key[1]}
> +    {'bit': <4} {self.executed_disable[0]: <10} {'execute disable': <30} {self.executed_disable[1]}
> +"""
> +        else:
> +            return f"""\
> +level {self.page_hierarchy_level}:
> +    {'entry address': <30} {hex(self.address)}
> +    {'page entry binary data': <30} {hex(self.page_entry_binary_data)}
> +    {'next entry physicall address': <30} {hex(self.next_entry_physical_address)}
> +    ---
> +    {'bit': <4} {self.entry_present[0]: <10} {'entry present': <30} {self.entry_present[1]}
> +    {'bit': <4} {self.read_write[0]: <10} {'read/write access allowed': <30} {self.read_write[1]}
> +    {'bit': <4} {self.user_access_allowed[0]: <10} {'user access allowed': <30} {self.user_access_allowed[1]}
> +    {'bit': <4} {self.page_level_write_through[0]: <10} {'page level write through': <30} {self.page_level_write_through[1]}
> +    {'bit': <4} {self.page_level_cache_disabled[0]: <10} {'page level cache disabled': <30} {self.page_level_cache_disabled[1]}
> +    {'bit': <4} {self.entry_was_accessed[0]: <10} {'entry has been accessed': <30} {self.entry_was_accessed[1]}
> +    {'bit': <4} {self.page_size[0]: <10} {'page size': <30} {self.page_size[1]}
> +    {'bit': <4} {self.hlat_restart_with_ordinary[0]: <10} {'restart to ordinary': <30} {self.hlat_restart_with_ordinary[1]}
> +    {'bit': <4} {self.executed_disable[0]: <10} {'execute disable': <30} {self.executed_disable[1]}
> +"""
> +
> +
> +class TranslateVM(gdb.Command):
> +    """Prints the entire paging structure used to translate a given virtual address.
> +
> +Having an address space of the currently executed process translates the virtual address
> +and prints detailed information of all paging structure levels used for the transaltion."""
> +

Either the help text should make clear which archs are supported...

> +    def __init__(self):
> +        super(TranslateVM, self).__init__('translate-vm', gdb.COMMAND_USER)

...or you do not even add the command for unsupported ones.

> +
> +    def invoke(self, arg, from_tty):
> +        if utils.is_target_arch("x86"):
> +            vm_address = gdb.parse_and_eval(f'{arg}')
> +            cr3_data = gdb.parse_and_eval('$cr3')
> +            cr4 = gdb.parse_and_eval('$cr4')
> +            page_levels = 5 if cr4 & (1 << 12) else 4
> +            page_entry = Cr3(cr3_data, page_levels)
> +            while page_entry:
> +                gdb.write(page_entry.mk_string())
> +                page_entry = page_entry.next_entry(vm_address)
> +        else:
> +            gdb.GdbError("Virtual address translation is not"
> +                         "supported for this arch")
> +
> +
> +

One blank line too much, I would say.

> +TranslateVM()
> diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
> index 4136dc2c59df..27bd7339bccc 100644
> --- a/scripts/gdb/vmlinux-gdb.py
> +++ b/scripts/gdb/vmlinux-gdb.py
> @@ -37,3 +37,4 @@ else:
>      import linux.clk
>      import linux.genpd
>      import linux.device
> +    import linux.mm

Looks indeed useful, and I suspect support for other archs will follow.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

