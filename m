Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B3F6B244B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCIMhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCIMhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:37:52 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C99C1F93B;
        Thu,  9 Mar 2023 04:37:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso3486766wmq.1;
        Thu, 09 Mar 2023 04:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678365470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Brecf3gTYVIGkh6Vg/ZrSy4fTcyL7LGy5CNuUxEbMY=;
        b=WFH43aWuAcfWvR7AbnsKHlunddYyHWanGNqukKJo3kCwmXlSpGw5huJoVS4aQMMBSK
         O1TJFj3ppdJL4xU0vncuCPluO4qFqKrfpqgoYiQzOKiZwPbxS4twYJO6TtWsu6BkexfD
         axhtX3UU+LjyopE6v7IjZN5HygXJxsXn1t6VDHaPrTwT55y7TXSQH8CCOV+R9898awTS
         uRro90lHSyg9r0zYjVSVgTSZQTRTAkzIaB3uTj93y8jhtjgei+d/SgMBK1Mov885YsPu
         3f/IZCZEz1eYxGg1ykFmuQ6EKnIkkGjWuNg8Psd9faoA+3QeRlz5b/l/DOfes6gWGjgY
         8nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678365470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Brecf3gTYVIGkh6Vg/ZrSy4fTcyL7LGy5CNuUxEbMY=;
        b=IAXfZPYE1F+J0i6PZVC7eEk+7bUew6uG7RjPKDup+RFaP7muBVlB6NppxYvTmEfehi
         Y3zkFSZhRuNi7vcwMHGoXS197L7sJs8rxQ4qTHSSEJG03ruwCQ1dOlc0e4NS53D9XFLA
         y1WKLw7C6GnL8y4bxBhsdQMpqz6Sy0y3lOuCXMQeKm3jNhqfPU0f9mDorepQTl4oi/fj
         s1SxH9QJxlL1uj9aXiVeQYwDh789J7i75WStwGOftFr3uQCv7pxcpFulUDTMKJc7SKwF
         EpbudfwNU9AhLyfZI1QYDr66qfmV+W1cjYp9evPUgKN7zPT/LPdDpPQQQaEpaiRB2wh4
         PRQw==
X-Gm-Message-State: AO0yUKVxoqewfCi6rO4UmX7oxDeqHd/Z/wLMUSLKPNYjzntBchE2TOOO
        L8jiqix9FvbtkD/o4fwpZuEr+pVcsyiGTNA2nVU=
X-Google-Smtp-Source: AK7set8NuLLf3gUjtL31iDhK+a+vkBokvjRYPtxUk4Gb8Fzx6wRvPgpR8tkyNxjgL9KSx+TamE6Crw==
X-Received: by 2002:a05:600c:444a:b0:3e0:6c4:6a38 with SMTP id v10-20020a05600c444a00b003e006c46a38mr11247542wmn.33.1678365469515;
        Thu, 09 Mar 2023 04:37:49 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u16-20020a5d5150000000b002c559843748sm17909147wrt.10.2023.03.09.04.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 04:37:48 -0800 (PST)
Date:   Thu, 9 Mar 2023 15:37:44 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     bchihi@baylibre.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: fix memcpy's
 number of bytes in lvts_calibration_init()
Message-ID: <58a1a694-8a9a-438b-a5cf-9299e7914973@kili.mountain>
References: <20230126161048.94089-1-bchihi@baylibre.com>
 <20230307134245.83599-1-bchihi@baylibre.com>
 <1af76fd0-ea27-da60-cd22-8a65a8ef369e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1af76fd0-ea27-da60-cd22-8a65a8ef369e@collabora.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 10:10:34AM +0100, AngeloGioacchino Del Regno wrote:
> Il 07/03/23 14:42, bchihi@baylibre.com ha scritto:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> > 
> > Replace memcpy 2 bytes by sizeof(int) bytes of LVTS calibration data.
> 
> sizeof(int) is architecture dependant...
> 

On Linux sizeof(int) is always 4.

I'm just so confused what you are talking about.  Are you thinking about
sizeof(long)?  Are you thinking about CPUs from the 1970s?  Linux wasn't
invented until the 90s so the old CPUs were already in museums at that
point.

> please use a fixed size type instead.

This is an unusual style opinion that I have not heard before.
Hopefully, you just got ints and longs confused so we can move on
without discussing it too much.  We're copying an int so sizeof(int) is
obviously correct.  It's hard to know how to respond.

> Also, shouldn't this be u16?!

What? Why would you think that?

regards,
dan carpenter

