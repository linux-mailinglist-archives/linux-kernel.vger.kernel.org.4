Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352196CC6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjC1Ppt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjC1Pp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:45:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D787B1;
        Tue, 28 Mar 2023 08:45:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m2so12715129wrh.6;
        Tue, 28 Mar 2023 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680018304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YShaIEE2n1AP/XmAoZ6cI2525vmt3gMFMVbfTPWkEG4=;
        b=op44MGXiytPNzHsMY8Qa562tKDkt6Zljv8o6X1578ufXQvVmLmWObICRLSanQNz/nK
         L1njb3ISzi3LQnOF8trNxGLUfKP/VqwxKM9wpVkann+GFOQacxxiSH+aCQGP6o8QzCuf
         A3vhh6TWd/wIsfmjFtEornFz4wGmErpHb1BAbMbeD09k6sMjn1g10IAUAYYvZ7DR8FNT
         csr+XAieBMFXDw4H3lHd2TdOd7hBJyyo2q2IHy0/5M8fS9JRm/YJNzzB8MGMbZZruIin
         Z6rqGAHXJZYfZlWNGhdKaTM1Uq9nsBAVQp0KVsbgQTY9GcODbP84gD+rrwVim53Di9A3
         zPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680018304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YShaIEE2n1AP/XmAoZ6cI2525vmt3gMFMVbfTPWkEG4=;
        b=0N35uUR7knAOFcsqPFFhurxYWm7/jFdC0h5Ty/ZxtlZ2JWZzHQ5vLAaB/Kjs05GuwK
         uUh+yz51xs/nh4koK3+XCI1X8VfAGIV+Y5jTNpyFnCkHs7qcdrucNe3FDVezMfI9gVD9
         K98ga/2e3P782pLr7XlblX+iaNNkjeCsx3ZEPiTWMRBR2gefd2fHNppBQQtwWqC3Ppkb
         CMDmpxFGVBKkPotHWKwBlSUnse9hDm0L/ktU7tF8NL918/9HqKorXQQ1LpJO+O9QzWYB
         3MWWqj0KzImKq2yiv7q7jHGCBb+qNx1af3zTZEbeO+qpNoI2U0ANlCwhFSiiHcb8iPpc
         CT0g==
X-Gm-Message-State: AAQBX9fUzpbyI6xygEnwq++plBBE12FxLbZmlmh2jhe9tgTuZ4WnGdeA
        aLltCFZXWCjtsn92JvLGezo=
X-Google-Smtp-Source: AKy350YJdoctHDsWO4ux7IHFatibNdv13QqeV0dtJJ2n415kxQijkrneQ55rqEfPfo7vXPQEfgxX1A==
X-Received: by 2002:a5d:424a:0:b0:2d2:39d3:ce7c with SMTP id s10-20020a5d424a000000b002d239d3ce7cmr12517738wrr.70.1680018304116;
        Tue, 28 Mar 2023 08:45:04 -0700 (PDT)
Received: from [192.168.42.225] ([81.95.8.244])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d4d83000000b002dfca33ba36sm6440301wru.8.2023.03.28.08.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 08:45:02 -0700 (PDT)
Message-ID: <78a6478d-b8c3-e46f-e995-c4813b6e76f7@gmail.com>
Date:   Tue, 28 Mar 2023 17:45:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] clk: mediatek: Remove unused configs with
 COMMON_CLK_MT6765 prefix
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230321042641.21592-1-lukas.bulwahn@gmail.com>
 <98c0a46d-05da-7863-1a30-51727c20da23@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <98c0a46d-05da-7863-1a30-51727c20da23@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/23 09:55, AngeloGioacchino Del Regno wrote:
> Il 21/03/23 05:26, Lukas Bulwahn ha scritto:
>> Commit 1aca9939bf72 ("clk: mediatek: Add MT6765 clock support") adds
>> fourteen configs with COMMON_CLK_MT6765 prefix, but only uses seven of 
>> them
>> to configure inclusion of drivers.
>>
>> Remove the seven unused COMMON_CLK_MT6765 configs.
>>
>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> Please add the required Fixes tag (you even reference the commit to fix 
> already!),
> then you'll get my R-b at v2 :-)
> 

What bug get's fixed by this? This is just a code clean-up, no bug get's 
fixed with it. So there is no reason to be backported to any stable or 
distribution kernels.

Regards,
Matthias
