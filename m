Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3259631D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiKUJob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiKUJo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:44:28 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD066174
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:44:26 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j4so18041910lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9hqrMS9B+nvH/yEhygH31S4BoEMDHz7FeZlY6dMGmQ=;
        b=VUSTo/HzQH5ydBMBXPZPqSolTwbWJC6N28ctQs+ZlNU3Pqu6zay8zMB7aPaywL9Nwr
         atrgGKkrZlriMzthYQl8OwGjifv+dH8cHrjt8iCKoqCWUqzWWFlykSbjodgnlN0N3OAA
         z5nMs6xBIB/MiV3BSOd0ZDJE5YKklp+o43j/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9hqrMS9B+nvH/yEhygH31S4BoEMDHz7FeZlY6dMGmQ=;
        b=JOwxszBXBTBSSHtYZHqXG2yWFVCCvODOisZk9gtjQdvGSDeMAeqywDNuK9lvShIlcj
         9jyB5l5UCwO7OjgtHNSFAXlTugUE79yMOdaqq7nWl/wbDsEEf9D+o7VzpZxeWZBSpOEB
         gIrfOFvJnCqTlt92lX1VhpTUsJoOfIc+sSJrtlGdEwDPd3Nhauy9c5ZCagTwD0NPtVVp
         tQxOum8nd67Sk7icrsrZHw7G8VtYo1j+E5xMOyVU2zew6gz3vcevn6AWqnYzVcNGfxPW
         2WbjR/pIX956IOHJwKNIjSVUT/gcfuAHmU0GdA7S7SSys0iWkfIb5JClJWxkj5NdnDs6
         oO1Q==
X-Gm-Message-State: ANoB5pl5cdZ1OBCeHZ3Qiu1u2/v+QO7tIl71zIZPrQ2WAm7/ntbne8mI
        uBPN6tebIF1BKfHrH17uKQgeAg==
X-Google-Smtp-Source: AA0mqf5eG/YVXKD4OF1GjHxnjooe0zcDcbGGAKkf6ZqAp6gR4SpZxH6weCfEGxvO+NCFeZyyW6naEA==
X-Received: by 2002:ac2:46f0:0:b0:4b4:c0c:89a3 with SMTP id q16-20020ac246f0000000b004b40c0c89a3mr5361997lfo.129.1669023865281;
        Mon, 21 Nov 2022 01:44:25 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id v1-20020a05651203a100b004a2386b8cf5sm1949893lfp.215.2022.11.21.01.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:44:24 -0800 (PST)
Message-ID: <8cce4dae-c653-515b-1a5d-024986afbabf@rasmusvillemoes.dk>
Date:   Mon, 21 Nov 2022 10:44:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] clk: imx8mp: register driver at arch_initcall time
Content-Language: en-US, da
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220928124108.500369-1-linux@rasmusvillemoes.dk>
 <CAOMZO5BPtEU6VCZXRk5FTHXDad6cegF=+oHTTA0wgjBuoh9-rQ@mail.gmail.com>
 <09611b2d-096e-058b-5349-627684e3a13c@rasmusvillemoes.dk>
 <CAOMZO5AXSSkHpeuHNRQ6qkFoe2uiFLVxndz1u7_y7s9cLD9ppw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAOMZO5AXSSkHpeuHNRQ6qkFoe2uiFLVxndz1u7_y7s9cLD9ppw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2022 23.02, Fabio Estevam wrote:
> On Sat, Nov 19, 2022 at 6:57 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> 
>> Sorry, I don't follow. Before this patch, the driver also implicitly had
>> a module_exit() doing exactly this platform_driver_unregister(), it was
>> just hidden inside the module_platform_driver() macro. And I think
>> that's necessary if one wants to test that the module can be loaded and
>> unloaded (I don't think it's ever useful or even possible to have it be
>> a module on an actual imx8mp board).
> 
> You cannot load/unload it due to .suppress_bind_attrs = true, being passed.

That doesn't seem to be true. To test, I just built the imx8mq clk
driver as a module, and I could certainly both load and unload that on
my imx8mp platform. Sure, no "bind" attribute shows up in the
/sys/bus/platform/drivers/imx8mq-ccm/ directory, which is exactly what
one expects, but the module can be loaded just fine. And since it can be
loaded, it should also have a proper __exit call for deregistering the
driver on unload.

Rasmus

