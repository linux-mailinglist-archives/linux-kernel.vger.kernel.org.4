Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39324649AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiLLJJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiLLJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:08:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D35DD2;
        Mon, 12 Dec 2022 01:08:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65A42B80A4A;
        Mon, 12 Dec 2022 09:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63287C433EF;
        Mon, 12 Dec 2022 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670836132;
        bh=+syCpe53ksZ1wk/P+ti6joXMTLfEgJsQad42fqKxD3g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NSC7eTO0arSVlDUtvmnWkmHX8oKugfq1mHlKbrZuU/v1ILMrnZ5E++3Mpa3Hc9fuI
         /dbB8VZSGb89vmfi9DfHkC7EIhEetA5vvbQZHdCUkC87ddQhd9pGHa3mboMXsTysOT
         XgPzcRlO2WqYieGyv8jZJPL0XcnZvcsbsW1kOW9YzOOh4zRXk/Nah0HMLxTuu/0Txo
         Tgv41hTvIY0aMCYyHr+NC0xyLlO4UwtIn2ZZlXbBWP/Kbb/KEwP2Su2GoCcXASjuLN
         9B2UNexqwTGaca0T3dLRP3M4sf8XPFryN/rdmEOBaFZ7EoaWikTcpAFikcBpcoEUte
         KfpjN9KykJUEg==
Message-ID: <0a42d725-ce95-216f-6078-877590be1d09@kernel.org>
Date:   Mon, 12 Dec 2022 11:08:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] memory: omap-gpmc: fix wait pin validation
Content-Language: en-US
To:     "B. Niedermayr" <benedikt.niedermayr@siemens.com>,
        linux-next@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OMAP GENERAL PURPOSE MEMORY CONTROLLER SUPPORT" 
        <linux-omap@vger.kernel.org>,
        "open list:MEMORY CONTROLLER DRIVERS" <linux-kernel@vger.kernel.org>
References: <20221209123147.591982-1-benedikt.niedermayr@siemens.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20221209123147.591982-1-benedikt.niedermayr@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/2022 14:31, B. Niedermayr wrote:
> From: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
> 
> This bug has been introduced after switching from -1 to UINT_MAX
> for GPMC_WAITPIN_INVALID.
> 
> The bug leads to an error when the optional gpmc,wait-pin
> dt-property is not used:
> 
> ...
> gpmc_cs_program_settings: invalid wait-pin (-1)
> ...
> 
> Signed-off-by: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
> Fixes: 8dd7e4af5853 ("memory: omap-gpmc: fix coverity issue "Control flow issues"")
> Cc: Rob Herring <robh+dt@kernel.org>

Acked-by: Roger Quadros <rogerq@kernel.org>
