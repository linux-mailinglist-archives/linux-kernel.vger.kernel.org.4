Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245B769508E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjBMTXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjBMTXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:23:44 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C831BA5D1;
        Mon, 13 Feb 2023 11:23:41 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id y11-20020a05683009cb00b0068dbf908574so4061240ott.8;
        Mon, 13 Feb 2023 11:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmoh/QuBFlu1FdoKCZl6SAD4r0lCMITTHXNZLETeJJs=;
        b=hcFuqvGJo/0m7hWJNlAe7sPZRYXdPKNbDe9aVGVTHDu63KrXvDHiYl9U8av8VMolV0
         huyglOTXElujKSQpClA30RstJa1+0ZxC+mMYyYlwhojLDpkpjYYPNTPgHfIZb6KVjxL2
         ZZrob47gU3PM9gV6o+cD/e1ybLvnbySBsHXv7loheO9mO07HQsgWZjDSuh/ajz8S23w0
         IxWCTAtHB8PwPC0mKE4YWHah7UpFNIu1qgZRdEGvmQWblQm0r47bpUl0xn1BtHDWPtMG
         1YLJyvmffd7RXk9yQtYneK//oEtBA8ntWVCcYzuNjMs76hdV2zqU0D1A/+FVt3NmyXtX
         w6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmoh/QuBFlu1FdoKCZl6SAD4r0lCMITTHXNZLETeJJs=;
        b=LsxsJdV37Ll1/QVKZGNBjHVSgKGXN5M5YgVRgWtfcZ4rDZDtwvn/53ErqCrZitJVFV
         N2eWkVWYA3PsDGm1ClrbmnQbBzrb6QbV5Sg1I/DlsvbvJ42f+tP6UeR5UTzAIVg8oRr7
         iLR2GXKYEDEKx4XOOxyGHOlcq7VYxr9G2Ot7sf/hGyAcOiYBZvwBWE2+HkjtShP7Xqgi
         Ztz+7kpJTtkvHihrs1vNeFNmi9y6aCKGAi/UW2dB6Cp1E3t2ibmG2W5zOdoo1fvHgU6u
         eW6pYzdymtt2YK82pHxHCWn6WvqvLqaMM8YfHmgafoXrB6KvKxJjhAIIoMjEeSmfrL/y
         mEgQ==
X-Gm-Message-State: AO0yUKWPIQ0lNm9WJ6MLLnMGUk9KZlAc2rf+UpkMH+oXZDg7Hl/SaD7e
        D0xSkt/GdSq+HnT+eSLSi/4=
X-Google-Smtp-Source: AK7set+prrkpl8jaf/JB0miotc833QzVPI3jJX67wzSxS6YI6xxV0EJgZKmCK5VyUxYf6T0yZSBrqA==
X-Received: by 2002:a05:6830:2716:b0:68b:ae34:838d with SMTP id j22-20020a056830271600b0068bae34838dmr18379044otu.3.1676316220947;
        Mon, 13 Feb 2023 11:23:40 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:30ed:279e:4793:cabe? ([2600:1700:2442:6db0:30ed:279e:4793:cabe])
        by smtp.gmail.com with ESMTPSA id o20-20020a9d7654000000b0068bbf5f2e49sm5528689otl.37.2023.02.13.11.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 11:23:40 -0800 (PST)
Message-ID: <346e0239-0996-d10b-55b5-687cdb3ee755@gmail.com>
Date:   Mon, 13 Feb 2023 13:23:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/7] of: do not use "%pOF" printk format on node with
 refcount of zero
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230213185702.395776-1-frowand.list@gmail.com>
 <20230213185702.395776-6-frowand.list@gmail.com>
In-Reply-To: <20230213185702.395776-6-frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 12:57, Frank Rowand wrote:
> of_node_release() can not use the "%pOF" printk format to report
> the node name of a node when the node reference count is zero.
> This is because the formatter device_node_string() calls
> fwnode_full_name_string() which indirectly calls of_node_get().
> Calling of_node_get() on the node with a zero reference count
> results in a WARNING and stack trace.
> 
> When the reference count has been decremented to zero, this function
> is in the subsequent call path which frees memory related to the node.
> 
> This commit resolves the unittest EXPECT errors that were created in
> the previous commmit.
> 
> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> ---

< snip >

After applying this commit, the output of unittests, as processed by
scripts/dtc/of_unittest_expect, including the new lifecycle tests is:




<< pre-test console output deleted >>

-> ### dt-test ### start of unittest - you will see error messages
   l16: Bringing 0uV into 2700000-2700000uV
ok Duplicate name in testcase-data, renamed to "duplicate-name#1"
   l17: Bringing 0uV into 2700000-2700000uV
   l18: Bringing 0uV into 2850000-2850000uV
   ### dt-test ### pass of_unittest_check_tree_linkage():270
   l19: Bringing 0uV into 3300000-3300000uV
   ### dt-test ### pass of_unittest_check_tree_linkage():271
   sdhci_msm f98a4900.mmc: Got CD GPIO
   ### dt-test ### pass of_unittest_check_phandles():379
   l20: Bringing 0uV into 2950000-2950000uV
   ### dt-test ### pass of_unittest_find_node_by_name():80
   sdhci_msm f98a4900.mmc: Got CD GPIO
   ### dt-test ### pass of_unittest_find_node_by_name():87
   l21: Bringing 0uV into 2950000-2950000uV
   ### dt-test ### pass of_unittest_find_node_by_name():91
   l22: Bringing 0uV into 3000000-3000000uV
   sdhci_msm f98a4900.mmc: Got CD GPIO
   l23: Bringing 0uV into 3000000-3000000uV
   ### dt-test ### pass of_unittest_find_node_by_name():98
   l24: Bringing 0uV into 3075000-3075000uV
   ### dt-test ### pass of_unittest_find_node_by_name():105
   ### dt-test ### pass of_unittest_find_node_by_name():109
   ### dt-test ### pass of_unittest_find_node_by_name():115
   ### dt-test ### pass of_unittest_find_node_by_name():119
   ### dt-test ### pass of_unittest_find_node_by_name():123
   ### dt-test ### pass of_unittest_find_node_by_name():127
   mmc0: SDHCI controller on f9824900.mmc [f9824900.mmc] using ADMA
   ### dt-test ### pass of_unittest_find_node_by_name():132
   ### dt-test ### pass of_unittest_find_node_by_name():137
   ### dt-test ### pass of_unittest_find_node_by_name():142
   ### dt-test ### pass of_unittest_find_node_by_name():147
   ### dt-test ### pass of_unittest_find_node_by_name():153
   mmc1: SDHCI controller on f98a4900.mmc [f98a4900.mmc] using ADMA
   ### dt-test ### pass of_unittest_find_node_by_name():158
   ### dt-test ### pass of_unittest_find_node_by_name():163
   ### dt-test ### pass of_unittest_find_node_by_name():168
   ### dt-test ### pass of_unittest_dynamic():194
   ### dt-test ### pass of_unittest_dynamic():201
   ### dt-test ### pass of_unittest_dynamic():207
   mmc0: new HS200 MMC card at address 0001
   ### dt-test ### pass of_unittest_dynamic():215
   ### dt-test ### pass of_unittest_dynamic():219
   mmcblk0: mmc0:0001 SEM16G 14.7 GiB 
   ### dt-test ### pass of_unittest_dynamic():227
   mmc1: new ultra high speed DDR50 SDHC card at address aaaa
   ### dt-test ### pass of_unittest_dynamic():229
   ### dt-test ### pass of_unittest_parse_phandle_with_args():402
   mmcblk1: mmc1:aaaa SU16G 14.8 GiB 
   ### dt-test ### pass of_unittest_parse_phandle_with_args():456
    mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20
   ### dt-test ### pass of_unittest_parse_phandle_with_args():456
    mmcblk1: p1
   ### dt-test ### pass of_unittest_parse_phandle_with_args():456
   ### dt-test ### pass of_unittest_parse_phandle_with_args():456
   ### dt-test ### pass of_unittest_parse_phandle_with_args():456
   ### dt-test ### pass of_unittest_parse_phandle_with_args():456
   ### dt-test ### pass of_unittest_parse_phandle_with_args():456
   ### dt-test ### pass of_unittest_parse_phandle_with_args():456
   ### dt-test ### pass of_unittest_parse_phandle_with_args():464
   ### dt-test ### pass of_unittest_parse_phandle_with_args():467
ok OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
   mmcblk0boot0: mmc0:0001 SEM16G 4.00 MiB 
   ### dt-test ### pass of_unittest_parse_phandle_with_args():481
   mmcblk0boot1: mmc0:0001 SEM16G 4.00 MiB 
ok OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
   mmcblk0rpmb: mmc0:0001 SEM16G 4.00 MiB, chardev (241:0)
   ### dt-test ### pass of_unittest_parse_phandle_with_args():492
ok OF: /testcase-data/phandle-tests/consumer-a: could not find phandle 12345678
   ### dt-test ### pass of_unittest_parse_phandle_with_args():506
ok OF: /testcase-data/phandle-tests/consumer-a: could not find phandle 12345678
   ### dt-test ### pass of_unittest_parse_phandle_with_args():517
ok OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1
   ### dt-test ### pass of_unittest_parse_phandle_with_args():531
ok OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found 1
   ### dt-test ### pass of_unittest_parse_phandle_with_args():542
   ### dt-test ### pass of_unittest_parse_phandle_with_args_map():582
   ### dt-test ### pass of_unittest_parse_phandle_with_args_map():640
   ### dt-test ### pass of_unittest_parse_phandle_with_args_map():640
   ### dt-test ### pass of_unittest_parse_phandle_with_args_map():640
   ### dt-test ### pass of_unittest_parse_phandle_with_args_map():640
   ### dt-test ### pass of_unittest_parse_phandle_with_args_map():640
   ### dt-test ### pass of_unittest_parse_phandle_with_args_map():640
   ### dt-test ### pass of_unittest_parse_phandle_with_args_map():640
   ### dt-test ### pass of_unittest_parse_phandle_with_args_map():640
   ### dt-test ### pass of_unittest_parse_phandle_with_args_map():648
ok OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1
   ### dt-test ### pass of_unittest_parse_phandle_with_args_map():661
ok OF: /testcase-data/phandle-tests/consumer-b: could not find phandle 12345678
   ### dt-test ### pass of_unittest_parse_phandle_with_args_map():674
ok OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found 1
   ### dt-test ### pass of_unittest_parse_phandle_with_args_map():687
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():294
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_printf_one():304
   ### dt-test ### pass of_unittest_property_string():703
   ### dt-test ### pass of_unittest_property_string():705
   ### dt-test ### pass of_unittest_property_string():707
   ### dt-test ### pass of_unittest_property_string():709
   ### dt-test ### pass of_unittest_property_string():711
   ### dt-test ### pass of_unittest_property_string():713
   ### dt-test ### pass of_unittest_property_string():715
   ### dt-test ### pass of_unittest_property_string():719
   ### dt-test ### pass of_unittest_property_string():721
   ### dt-test ### pass of_unittest_property_string():723
   ### dt-test ### pass of_unittest_property_string():725
   ### dt-test ### pass of_unittest_property_string():729
   ### dt-test ### pass of_unittest_property_string():732
   ### dt-test ### pass of_unittest_property_string():734
   ### dt-test ### pass of_unittest_property_string():736
   ### dt-test ### pass of_unittest_property_string():738
   ### dt-test ### pass of_unittest_property_string():741
   ### dt-test ### pass of_unittest_property_string():744
   ### dt-test ### pass of_unittest_property_string():746
   ### dt-test ### pass of_unittest_property_string():749
   ### dt-test ### pass of_unittest_property_string():754
   ### dt-test ### pass of_unittest_property_string():756
   ### dt-test ### pass of_unittest_property_string():758
   ### dt-test ### pass of_unittest_property_string():761
   ### dt-test ### pass of_unittest_property_string():765
   ### dt-test ### pass of_unittest_property_string():768
   ### dt-test ### pass of_unittest_property_copy():783
   ### dt-test ### pass of_unittest_property_copy():789
   ### dt-test ### pass of_unittest_changeset():809
   ### dt-test ### pass of_unittest_changeset():812
   ### dt-test ### pass of_unittest_changeset():815
   ### dt-test ### pass of_unittest_changeset():819
   ### dt-test ### pass of_unittest_changeset():822
   ### dt-test ### pass of_unittest_changeset():825
   ### dt-test ### pass of_unittest_changeset():828
   ### dt-test ### pass of_unittest_changeset():831
   ### dt-test ### pass of_unittest_changeset():834
   ### dt-test ### pass of_unittest_changeset():842
   ### dt-test ### pass of_unittest_changeset():846
   ### dt-test ### pass of_unittest_changeset():847
   ### dt-test ### pass of_unittest_changeset():849
   ### dt-test ### pass of_unittest_changeset():850
   ### dt-test ### pass of_unittest_changeset():852
   ### dt-test ### pass of_unittest_changeset():853
   ### dt-test ### pass of_unittest_changeset():855
   ### dt-test ### pass of_unittest_changeset():857
   ### dt-test ### pass of_unittest_changeset():858
   ### dt-test ### pass of_unittest_changeset():859
   ### dt-test ### pass of_unittest_changeset():861
   ### dt-test ### pass of_unittest_changeset():866
   ### dt-test ### pass of_unittest_changeset():870
   ### dt-test ### pass of_unittest_parse_interrupts():1036
   ### dt-test ### pass of_unittest_parse_interrupts():1036
   ### dt-test ### pass of_unittest_parse_interrupts():1036
   ### dt-test ### pass of_unittest_parse_interrupts():1036
   ### dt-test ### pass of_unittest_parse_interrupts():1082
   ### dt-test ### pass of_unittest_parse_interrupts():1082
   ### dt-test ### pass of_unittest_parse_interrupts():1082
   ### dt-test ### pass of_unittest_parse_interrupts():1082
   ### dt-test ### pass of_unittest_parse_interrupts_extended():1162
   ### dt-test ### pass of_unittest_parse_interrupts_extended():1162
   ### dt-test ### pass of_unittest_parse_interrupts_extended():1162
   ### dt-test ### pass of_unittest_parse_interrupts_extended():1162
   ### dt-test ### pass of_unittest_parse_interrupts_extended():1162
   ### dt-test ### pass of_unittest_parse_interrupts_extended():1162
   ### dt-test ### pass of_unittest_parse_interrupts_extended():1162
   ### dt-test ### pass of_unittest_dma_get_max_cpu_address():895
   ### dt-test ### pass of_unittest_dma_ranges_one():916
   ### dt-test ### pass of_unittest_dma_ranges_one():934
   ### dt-test ### pass of_unittest_dma_ranges_one():937
   ### dt-test ### pass of_unittest_dma_ranges_one():916
   ### dt-test ### pass of_unittest_dma_ranges_one():934
   ### dt-test ### pass of_unittest_dma_ranges_one():937
   ### dt-test ### pass of_unittest_pci_dma_ranges():985
   ### dt-test ### pass of_unittest_pci_dma_ranges():988
   ### dt-test ### pass of_unittest_pci_dma_ranges():991
   ### dt-test ### pass of_unittest_pci_dma_ranges():995
   ### dt-test ### pass of_unittest_pci_dma_ranges():998
   ### dt-test ### pass of_unittest_pci_dma_ranges():1001
   ### dt-test ### pass of_unittest_match_node():1230
   ### dt-test ### pass of_unittest_match_node():1230
   ### dt-test ### pass of_unittest_match_node():1230
   ### dt-test ### pass of_unittest_match_node():1230
   ### dt-test ### pass of_unittest_match_node():1230
   ### dt-test ### pass of_unittest_match_node():1230
   ### dt-test ### pass of_unittest_match_node():1230
   ### dt-test ### pass of_unittest_match_node():1230
   ### dt-test ### pass of_unittest_match_node():1230
   ### dt-test ### pass of_unittest_match_node():1230
   ### dt-test ### pass of_unittest_match_node():1230
   ### dt-test ### pass of_unittest_match_node():1230
   ### dt-test ### pass of_unittest_platform_populate():1254
   ### dt-test ### pass of_unittest_platform_populate():1258
   ### dt-test ### pass of_unittest_platform_populate():1264
ok platform testcase-data:testcase-device2: error -ENXIO: IRQ index 0 not found
   ### dt-test ### pass of_unittest_platform_populate():1274
   ### dt-test ### pass of_unittest_platform_populate():1279
   ### dt-test ### pass of_unittest_platform_populate():1285
   ### dt-test ### pass of_unittest_platform_populate():1305
   ### dt-test ### pass of_unittest_platform_populate():1305
   ### dt-test ### pass of_unittest_platform_populate():1315
   ### dt-test ### pass of_unittest_platform_populate():1315
   ### dt-test ### pass of_unittest_overlay():2968
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest0/status
   ### dt-test ### pass of_unittest_overlay_0():2099
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest1/status
   ### dt-test ### pass of_unittest_overlay_1():2119
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest2/status
   ### dt-test ### pass of_unittest_overlay_2():2139
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest3/status
   ### dt-test ### pass of_unittest_overlay_3():2159
   ### dt-test ### pass of_unittest_overlay_4():2169
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest5/status
   ### dt-test ### pass of_unittest_overlay_5():2189
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest6/status
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest7/status
   ### dt-test ### pass of_unittest_overlay_6():2290
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/status
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/property-foo
ok OF: overlay: node_overlaps_later_cs: #6 overlaps with #7 @/testcase-data/overlay-node/test-bus/test-unittest8
ok OF: overlay: overlay #6 is not topmost
   ### dt-test ### pass of_unittest_overlay_8():2383
   ### dt-test ### pass of_unittest_overlay_10():2395
   ### dt-test ### pass of_unittest_overlay_10():2401
   ### dt-test ### pass of_unittest_overlay_10():2407
   ### dt-test ### pass of_unittest_overlay_11():2419
   ### dt-test ### pass of_unittest_overlay_i2c_init():2640
   ### dt-test ### pass of_unittest_overlay_i2c_init():2646
ok i2c i2c-1: Added multiplexed i2c bus 2
   ### dt-test ### pass of_unittest_overlay_i2c_init():2660
   ### dt-test ### pass of_unittest_overlay():2984
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest12/status
   ### dt-test ### pass of_unittest_overlay_i2c_12():2693
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest13/status
   ### dt-test ### pass of_unittest_overlay_i2c_13():2713
ok i2c i2c-1: Added multiplexed i2c bus 3
   ### dt-test ### pass of_unittest_overlay_i2c_15():2737
   ### dt-test ### pass of_unittest_overlay_gpio():1698
   ### dt-test ### pass of_unittest_overlay_gpio():1701
   ### dt-test ### pass of_unittest_overlay_gpio():1704
ok gpio-708 (line-B-input): hogged as input
   ### dt-test ### pass unittest_gpio_probe():1621
ok gpio-712 (line-A-input): hogged as input
   ### dt-test ### pass unittest_gpio_probe():1621
   ### dt-test ### pass of_unittest_overlay_gpio():1719
   ### dt-test ### pass of_unittest_overlay_gpio():1727
   ### dt-test ### pass of_unittest_overlay_gpio():1730
ok gpio-720 (line-D-input): hogged as input
   ### dt-test ### pass unittest_gpio_probe():1621
   ### dt-test ### pass of_unittest_overlay_gpio():1756
   ### dt-test ### pass of_unittest_overlay_gpio():1762
   ### dt-test ### pass of_unittest_overlay_gpio():1765
   ### dt-test ### pass unittest_gpio_probe():1621
   ### dt-test ### pass of_unittest_overlay_gpio():1783
   ### dt-test ### pass of_unittest_overlay_gpio():1786
ok gpio-724 (line-C-input): hogged as input
   ### dt-test ### pass of_unittest_overlay_gpio():1803
   ### dt-test ### pass of_unittest_overlay_gpio():1809
   ### dt-test ### pass of_unittest_overlay_notify():2825
ok OF: overlay: overlay changeset pre-apply notifier error -16, target: /testcase-data/overlay-node/test-bus
   ### dt-test ### pass of_unittest_overlay_notify():2846
   ### dt-test ### pass of_unittest_overlay_notify():2851
ok OF: overlay: overlay changeset post-apply notifier error -17, target: /testcase-data/overlay-node/test-bus
   ### dt-test ### pass of_unittest_overlay_notify():2857
   ### dt-test ### pass of_unittest_overlay_notify():2862
   ### dt-test ### pass of_unittest_overlay_notify():2866
   ### dt-test ### pass of_unittest_overlay_notify():2872
   ### dt-test ### pass of_unittest_overlay_notify():2875
ok OF: overlay: overlay changeset pre-remove notifier error -18, target: /testcase-data/overlay-node/test-bus
   ### dt-test ### pass of_unittest_overlay_notify():2886
   ### dt-test ### pass of_unittest_overlay_notify():2894
   ### dt-test ### pass of_unittest_overlay_notify():2898
   ### dt-test ### pass of_unittest_overlay_notify():2901
ok OF: overlay: overlay changeset post-remove notifier error -19, target: /testcase-data/overlay-node/test-bus
   ### dt-test ### pass of_unittest_overlay_notify():2908
   ### dt-test ### pass of_unittest_overlay_notify():2915
   ### dt-test ### pass of_unittest_overlay_notify():2920
   ### dt-test ### pass of_unittest_overlay_notify():2932
   ### dt-test ### pass of_unittest_lifecycle():3031
   ### dt-test ### pass of_unittest_lifecycle():3056
ok OF: ERROR: of_node_release() detected bad of_node_put() on /testcase-data/refcount-node
   ### dt-test ### pass of_unittest_lifecycle():3076
ok ------------[ cut here ]------------
ok WARNING: CPU: 1 PID: 1 at lib/refcount.c:28 of_unittest+0x25d0/0x2eb8
ok refcount_t: underflow; use-after-free.
   Modules linked in:
   CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                 N 6.2.0-rc1-00008-g0ad108551489 #23
   Hardware name: Generic DT based system
    unwind_backtrace from show_stack+0x10/0x14
    show_stack from dump_stack_lvl+0x40/0x4c
    dump_stack_lvl from __warn+0x7c/0x15c
    __warn from warn_slowpath_fmt+0x98/0xcc
    warn_slowpath_fmt from of_unittest+0x25d0/0x2eb8
    of_unittest from do_one_initcall+0x4c/0x268
    do_one_initcall from kernel_init_freeable+0x1b4/0x214
    kernel_init_freeable from kernel_init+0x18/0x130
    kernel_init from ret_from_fork+0x14/0x2c
   Exception stack(0xf0821fb0 to 0xf0821ff8)
   1fa0:                                     00000000 00000000 00000000 00000000
   1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
   1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
ok ---[ end trace 0000000000000000 ]---
   ### dt-test ### pass of_unittest_lifecycle():3093
   ### dt-test ### pass of_unittest_lifecycle():3119
   ### dt-test ### pass of_unittest_lifecycle():3120
   ### dt-test ### pass of_unittest_check_tree_linkage():270
   ### dt-test ### pass of_unittest_check_tree_linkage():271
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/status
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/status
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@30/incline-up
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@40/incline-up
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/status
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/color
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/rate
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/hvac_2
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_left
ok OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_right
   ### dt-test ### pass of_unittest_overlay_high_level():3552
ok OF: overlay: ERROR: multiple fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller
ok OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/controller/name
   ### dt-test ### pass of_unittest_overlay_high_level():3559
ok OF: overlay: ERROR: multiple fragments add and/or delete node /testcase-data-2/substation@100/motor-1/electric
ok OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/electric/rpm_avail
ok OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/electric/name
   ### dt-test ### pass of_unittest_overlay_high_level():3574
   ### dt-test ### pass of_unittest_overlay_high_level():3584
   ### dt-test ### pass of_unittest_overlay_high_level():3587
-> ### dt-test ### end of unittest - 276 passed, 0 failed


<< post-test console output deleted >>

   / # cat /proc/version
   Linux version 6.2.0-rc1-00008-g0ad108551489 (frowand@xps8900) (arm-linux-gnueabi-gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #23 SMP PREEMPT Mon Feb 13 12:52:35 CST 2023
   / # 

** EXPECT statistics:
**
**   non-zero values expected:
**
**     EXPECT found              :   55
**     EXPECT_NOT not found      :    4
**
**   zero values expected:
**
**     EXPECT not found          :    0
**     missing EXPECT begin      :    0
**     missing EXPECT end        :    0
**
**     EXPECT_NOT found          :    0
**     missing EXPECT_NOT begin  :    0
**     missing EXPECT_NOT end    :    0
**
**     unittest FAIL             :    0
**     internal error            :    0

