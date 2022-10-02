Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8065F234B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 15:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJBNNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 09:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJBNNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 09:13:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0776343171;
        Sun,  2 Oct 2022 06:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5A45B80D2D;
        Sun,  2 Oct 2022 13:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076A3C433D6;
        Sun,  2 Oct 2022 13:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664716409;
        bh=ZF54sPi8wwHaRezUqs1aEqP1f3WrsCJNCa6/1k3KbJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BVWwnl1yuwE1wHDh0UXUYYaa3V603uWJpOP3w8+vqPoDm189oHHh2jgNnycC7pnn/
         vEHd1OgHiAuLMsiwgxqajQ4dM2uRSQC95l8sjNDXOiAXzSAf0gG6gN3rVgbqa0N0tO
         UeqqiI9v840KZdneKPIr5yRSq0pumlldWHx75L2GqT6l3D5DI3EIko3PnMbdMC30Nc
         IA4GMzZA24ONzZV6+YzYxPAmqjMRa1F7G++44E+SELCW/FORjGc2N0IOFZCl/5o87P
         D60/YhJGntBJs63124MQHRf9jesxKIqm8kHP1nvnAWy2VP5nJzHcwEvObkz+5tSESZ
         x+qRVLlNRdVXA==
Date:   Sun, 2 Oct 2022 14:13:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] iio: adc: add max11410 adc driver
Message-ID: <20221002141344.19b0622d@jic23-huawei>
In-Reply-To: <20220927141851.279-2-Ibrahim.Tilki@analog.com>
References: <20220927141851.279-1-Ibrahim.Tilki@analog.com>
        <20220927141851.279-2-Ibrahim.Tilki@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 17:18:49 +0300
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> Adding support for max11410 24-bit, 1.9ksps delta-sigma adc which
> has 3 differential reference and 10 differential channel inputs.
> Inputs and references can be buffered internally. Inputs can also
> be amplified with internal PGA.
> 
> Device has four digital filter modes: FIR50/60, FIR50, FIR60 and SINC4.
> FIR 50Hz and 60Hz rejections can be enabled/disabled separately.
> Digital filter selection affects sampling frequency range so driver
> has to consider the configured filter when configuring sampling frequency.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>

Hi Ibrahim,

Other than the obvious (form the build bug report) missing
#include <asm/unaligned.h>

this looks good to me.  I may of course spot something on v7, but hopefully
we can get the binding issues resolved and get this queued up.

Thanks,

Jonathan
