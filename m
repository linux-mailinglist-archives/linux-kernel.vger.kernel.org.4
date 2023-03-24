Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37D46C7BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCXJlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjCXJlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:41:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B6335A7;
        Fri, 24 Mar 2023 02:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 56237CE20C8;
        Fri, 24 Mar 2023 09:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23F3C433D2;
        Fri, 24 Mar 2023 09:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679650878;
        bh=ugg+744kF+Sy2uuQwxj6DAdcJ4aARCHqjy7D3/aFdxM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SaW7dpIS8og6AvVMOJsekibS/hLVR/HxXc/KXIKAKRFayb0vsQH7zkDx66iraOOhC
         KeVYE3NWho5Na2TL3dCEMJhhw0+jfooXLpENiSo9gkp1A10bO+c19yiNhPYkH47vSH
         i5j5PvtXxxdom7pzzEiYnXKpwyHMmrBwrZ/T+EsB3dpyL3H9qMsLzsvH25XKltUczL
         nZ5N9/H+Lhnb8bNfbwJiX8QlRCkRU+UzWuQX0R1Z6qzhQY3di87bCoVh0ExR0gupsO
         HaTPg8njgfs03j7adawItfijJBHMTraiY+mdd3vkYdtK6xOLJlg85bcOAdzwA8uLfy
         cf2z2glHcESWw==
Message-ID: <2227040b-28fe-bab3-f964-665c92ab2816@kernel.org>
Date:   Fri, 24 Mar 2023 10:41:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/6] devicetree: input: cypress,tt21000: fix interrupt
 type in dts example
To:     Maximilian Weigand <mweigand@mweigand.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Alistair Francis <alistair@alistair23.me>
References: <20230323135205.1160879-1-mweigand@mweigand.net>
 <20230323135205.1160879-4-mweigand@mweigand.net>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230323135205.1160879-4-mweigand@mweigand.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 14:52, Maximilian Weigand wrote:
> Triggering the interrupt of the IRQ_TYPE_LEVEL_LOW type can lead to
> probing issues with the device for the current driver (encountered on
> the Pine64 PineNote). Basically the interrupt would be triggered before
> certain commands were sent to the device, leading to a race between the
> device responding fast enough and the irq handler fetching a data frame
> from it. Actually all devices currently using the driver already use a

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching). "dt-bindings", not "devicetree"

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> falling edge trigger.
> 
> Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
> Reviewed-by: Alistair Francis <alistair@alistair23.me>

Usually reviews are public.

Best regards,
Krzysztof

