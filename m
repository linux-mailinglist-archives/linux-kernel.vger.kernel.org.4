Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AED614E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiKAPeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiKAPeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:34:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA62DDEE4;
        Tue,  1 Nov 2022 08:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F8461637;
        Tue,  1 Nov 2022 15:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB08AC433D6;
        Tue,  1 Nov 2022 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667316861;
        bh=qMkIVqVEWFZuwE65ZHG+MFl13mOX2Gs29/6OxtDWz3Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Eo2HJy/JTbLE5XD1A3dfBYlXniEQRt5waC7T/yvL9NBisyJE5yzaC7fPLncTz43X1
         xRuQyGmlmO3++24VXm0Ia+4MWMvQElWMcvLijmh3uFQw8fq7dVZk/NPe9Jl2jspeoY
         k6vqDNPkBUQfjjnS/dgafA4QqsfgDxwVUvgzVpPyXDv7lbJrdYb19kAUgCwpchZaGC
         nozTuUHA6vLbAkg1V6YLZGpIMPPUN1rnowZnH4fRPGGYNn4ZJVMwzSpJl77Qfll0RS
         5RRzYWYKS/7Y8303wFm8rawdMcsf/uhWxwX/ixXkiR5VbMMd0qcMrk640XOnkzj/P9
         rtprl7kMkragA==
Message-ID: <9d13da28-e7d5-f8d4-0e99-c89560d37833@kernel.org>
Date:   Tue, 1 Nov 2022 10:34:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCHv6 5/6] clk: socfpga: remove the setting of clk-phase for
 sdmmc_clk
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20221026141631.696863-1-dinguyen@kernel.org>
 <20221026141631.696863-5-dinguyen@kernel.org>
 <20221027213934.E9219C433C1@smtp.kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20221027213934.E9219C433C1@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/22 16:39, Stephen Boyd wrote:
> Quoting Dinh Nguyen (2022-10-26 07:16:30)
>> Now that the SDMMC driver supports setting the clk-phase, we can remove
>> the need to do it in the clock driver.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
> 
> Do you want to take this through mmc tree?

Yes, I'll do that.

> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Thanks!

Dinh
