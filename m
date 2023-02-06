Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C1468C7AE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjBFUbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjBFUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:31:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BA729E2F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:31:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i5so4446807wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZGz/N+EtXFXjo58DVRXfyilGfBoD8ZSIHd32aC9uAk=;
        b=qVt6X7nK5L2aTBX3NzPXLdYxXaSBBHgcjYvq/eApTtZpLMf0tbHtNtxsMtBhw4MDwB
         divgFaZ6p21uIshKb24RzsHyyEcddqk7v07w1X+O98zHJ0qlHMNyzT8X/y9qQEdTL2uS
         GCGB+sIAmVoK0OhrgRs5OnwHHiMesOtiDpGLHWihKB1TIqkih2A2mH3gxY0vPItVoYYx
         9UoDjMHsrdrKZxoyqD8GEnOVHac79oOhoeSBazUbXzL9EPaynRy8YPdSjVdoFxYp3XX5
         4pWalI8IsrdBwHvjCCP2upLsXOsRJUE4JEy1nKh6C4gFIv7S35BY1gf1LAxAUc8AqXOl
         XZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZGz/N+EtXFXjo58DVRXfyilGfBoD8ZSIHd32aC9uAk=;
        b=gelUJUXj8cKqwLbgxsWPEZdPJ1Jd3xIKLk8Ml1nH+w4hzcH0VZ6GquVFzHg+faq06r
         VphxsumTp1p13ip2XlrWCorjU2mltaCJtNdSVBx4MMYdQvdJ0rJ2ckVIh4FBH8Kc1MG4
         eCuThry8M0M3TzfEV1cMhQ1BDDnsuMiek7Xp6JlGootYiVQnFi/3EkmD4vqWz21gr1ID
         wxh+eDs7ghrOpT28DtxObCrerA8Dw2hXTBSO31Og7kZ4asfCBH/XDUZwZH91Vc5y2cUh
         9bOxB7Y0A84JcoE9vldkYVI4nYSXSQSBQanaJXMaKel+sV5xwLRl6Ol7RB9K5heoPqX4
         FMng==
X-Gm-Message-State: AO0yUKUbdw4sokBAN0b2qqOML9yVMv2XqG6UYjb0k0H7RZCZxL4Zwmji
        FIjyYLrGgjStfZ2mH18oRSzxKQ==
X-Google-Smtp-Source: AK7set+FP1+I2Mhte/do++ECfuJE/LYx7mWnb91D5rDmAmd2fBjyJ11Jm+SPnGKVt2AkedbMQyBJPA==
X-Received: by 2002:adf:f288:0:b0:2bd:e87c:e831 with SMTP id k8-20020adff288000000b002bde87ce831mr200596wro.69.1675715508181;
        Mon, 06 Feb 2023 12:31:48 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id q12-20020adfdfcc000000b002c3ec35f360sm2356622wrn.56.2023.02.06.12.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 12:31:47 -0800 (PST)
Message-ID: <81a5c400-e671-fab3-732a-d615fa4242b3@linaro.org>
Date:   Mon, 6 Feb 2023 20:31:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 00/21] nvmem: core: introduce NVMEM layouts
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
References: <20221206200740.3567551-1-michael@walle.cc>
 <20230103163902.218cb5c7@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230103163902.218cb5c7@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael/Miquel,

I had to revert Layout patches due to comments from Greg about Making 
the layouts as built-in rather than modules, he is not ready to merge 
them as it is.

His original comment,

"Why are we going back to "custom-built" kernel configurations?  Why can
this not be a loadable module?  Distros are now forced to enable these
layout and all kernels will have this dead code in the tree without any
choice in the matter?

That's not ok, these need to be auto-loaded based on the hardware
representation like any other kernel module.  You can't force them to be
always present, sorry.
"

I have applied most of the patches except

nvmem: core: introduce NVMEM layouts
nvmem: core: add per-cell post processing
nvmem: core: allow to modify a cell before adding it
nvmem: imx-ocotp: replace global post processing with layouts
nvmem: cell: drop global cell_post_process
nvmem: core: provide own priv pointer in post process callback
nvmem: layouts: add sl28vpd layout
MAINTAINERS: add myself as sl28vpd nvmem layout driver
nvmem: layouts: Add ONIE tlv layout driver
MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer
nvmem: core: return -ENOENT if nvmem cell is not found
nvmem: layouts: Fix spelling mistake "platforn" -> "platform"
dt-bindings: nvmem: Fix spelling mistake "platforn" -> "platform"
nvmem: core: fix nvmem_layout_get_match_data()

Please rebase your patches on top of nvmem-next once layouts are 
converted to loadable modules.

thanks,
srini



On 03/01/2023 15:39, Miquel Raynal wrote:
> Hi Srinivas,
> 
> michael@walle.cc wrote on Tue,  6 Dec 2022 21:07:19 +0100:
> 
>> This is now the third attempt to fetch the MAC addresses from the VPD
>> for the Kontron sl28 boards. Previous discussions can be found here:
>> https://lore.kernel.org/lkml/20211228142549.1275412-1-michael@walle.cc/
>>
>>
>> NVMEM cells are typically added by board code or by the devicetree. But
>> as the cells get more complex, there is (valid) push back from the
>> devicetree maintainers to not put that handling in the devicetree.
>>
>> Therefore, introduce NVMEM layouts. They operate on the NVMEM device and
>> can add cells during runtime. That way it is possible to add more complex
>> cells than it is possible right now with the offset/length/bits
>> description in the device tree. For example, you can have post processing
>> for individual cells (think of endian swapping, or ethernet offset
>> handling).
>>
>> The imx-ocotp driver is the only user of the global post processing hook,
>> convert it to nvmem layouts and drop the global post pocessing hook.
>>
>> For now, the layouts are selected by the device tree. But the idea is
>> that also board files or other drivers could set a layout. Although no
>> code for that exists yet.
>>
>> Thanks to Miquel, the device tree bindings are already approved and merged.
>>
>> NVMEM layouts as modules?
>> While possible in principle, it doesn't make any sense because the NVMEM
>> core can't be compiled as a module. The layouts needs to be available at
>> probe time. (That is also the reason why they get registered with
>> subsys_initcall().) So if the NVMEM core would be a module, the layouts
>> could be modules, too.
> 
> I believe this series still applies even though -rc1 (and -rc2) are out
> now, may we know if you consider merging it anytime soon or if there
> are still discrepancies in the implementation you would like to
> discuss? Otherwise I would really like to see this laying in -next a
> few weeks before being sent out to Linus, just in case.
> 
> Thanks,
> Miquèl
