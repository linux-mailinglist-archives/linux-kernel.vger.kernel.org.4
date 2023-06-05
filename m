Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4129722740
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjFENWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjFENV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:21:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A2AA6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:21:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so5535696e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685971315; x=1688563315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AAVo5XJBmcZ1CILHNv8SMdAaagpninriUMxTg11Co/E=;
        b=3l13dOF1IYsdmxWjy4gVBxm9mP0dSRgkbeDydZj89p6KSERrNBrlgUF9ZiLQsu8ZMO
         98veLuKCuihN2OluBxFYHCZOrQHvFcmSWlsu4AI2agA1zTprkYPIrXNNbnXtSsaWkLxH
         O3/l2/5D6iYmYs0L4o5wHlW3ohDgh9t+BqY3w1Hh1fKtmmPh9L791z7SKtOZ74tKd40P
         zxDFG+1ww5fWag616iq03kZ+TIre346llSOCOoHDNPjqa0HsCL1EzkpiszzgoLcIpuiB
         nCJvRpf26t/XE2dsdWozdG/uHYPfL1zXYJbUvG1qNMH2BmuOdX6D5spT+3/m81kMlgoX
         ys7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685971315; x=1688563315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAVo5XJBmcZ1CILHNv8SMdAaagpninriUMxTg11Co/E=;
        b=aEeUeBGlCEfzjdzhVuZCjpDwwy9/YOVIy3hKgCLkUc3JaqHnJPL+Q7XhWCqvQdxZgb
         wSU7jFSCYvC8e4AW32zbhVNkDAWN62H9wLUApUAKujJFEhje0gAZYO2qgiPECOYqUxjf
         lBKH6gydu0GEm3ZKOBsEroISvCA3Uh4HUAgNuHoNEd+2OqnEQVBs4sXDzS2L3n9HNzaW
         HXMj3qabla3QXZ7oqZyAW+02ldkn4L+P8tS90zX+EXYm5b4ibknvsZDp7PKU1kZHoOUE
         bquFyx1J9rfaQ7LgoyLlSQwDg+PGv1MI+U6+N1Hhgoq5yjs3kUE10/XZnL+aB4tCck9Y
         TGVA==
X-Gm-Message-State: AC+VfDzSXooVBQV8VOggJLpyG2M9Ks2hjGzXUqKuJZ6yD+aSXB79FeLy
        Oe/o+Bock1SeRJFk2lVXIYu/6oI5tmpMoBg4/Vk=
X-Google-Smtp-Source: ACHHUZ7Cp/Uhp6/Wpl9DeYjd1vvYra/v50oGeZW7mP1XrLzgq01OEH+9/gZgXDUd67xf7/rarGL7pw==
X-Received: by 2002:a19:7609:0:b0:4f4:ca61:82ba with SMTP id c9-20020a197609000000b004f4ca6182bamr5030485lff.67.1685971315388;
        Mon, 05 Jun 2023 06:21:55 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id l17-20020a1ced11000000b003f4266965fbsm14439285wmh.5.2023.06.05.06.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 06:21:54 -0700 (PDT)
Message-ID: <d94b5f07-aa37-f4ec-252b-ff1a96b89326@baylibre.com>
Date:   Mon, 5 Jun 2023 15:21:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] ASoC: mediatek: mt8188: fix use-after-free in
 driver remove path
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc:     dianders@chromium.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230601033318.10408-1-trevor.wu@mediatek.com>
 <20230601033318.10408-2-trevor.wu@mediatek.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230601033318.10408-2-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 05:33, Trevor Wu wrote:
> During mt8188_afe_init_clock(), mt8188_audsys_clk_register() was called
> followed by several other devm functions. The caller of
> mt8188_afe_init_clock() utilized devm_add_action_or_reset() to call
> mt8188_afe_deinit_clock(). However, the order was incorrect, causing a
> use-after-free issue during remove time.
> 
> At probe time, the order of calls was:
> 1. mt8188_audsys_clk_register
> 2. afe_priv->clk = devm_kcalloc
> 3. afe_priv->clk[i] = devm_clk_get
> 
> At remove time, the order of calls was:
> 1. mt8188_audsys_clk_unregister
> 3. free afe_priv->clk[i]
> 2. free afe_priv->clk
> 
> To resolve the problem, it's necessary to move devm_add_action_or_reset()
> to the appropriate position so that the remove order can be 3->2->1.

Sounds good

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

