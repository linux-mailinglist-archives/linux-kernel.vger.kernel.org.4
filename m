Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E8A6AE023
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjCGNQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjCGNQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:16:08 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74B77A90D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:14:40 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id t39so11323908ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678194871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3TZEErplZhG9mXFebMiilSX8989PvB3SCifcTfC0yrQ=;
        b=sJdnuWqTsUMrxN+40otQ3KKmJ6+lNnGM7kTZL/6nIc3T0ncP8Mj0MxcSITCadu+Ptn
         F76OgTs+PuiGOjyb3W5IXlLmbNOt41tPcpFQO5qBVi8KjMqfANeRNuIJu8buG7fWmmPW
         2SRsPmD7j4+S03LI2k/MJXFpHuEJ0z7BfcbdCTIK1ZbqLBPXxU3nGuuQT2UEnqubG88A
         sg1J8OmpIAfSWzb8yrFHEoJMo8kUB5CwJ5A4OgrFV/5TJrZ7FC6CE+o8dNaddGZNUnDM
         B1tr1jpyTGLtzSYPbQQ2ZzJniTpsIyNss69wN/1eft9WFwD8AgnbDG46H37Xr7wA863f
         Y2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TZEErplZhG9mXFebMiilSX8989PvB3SCifcTfC0yrQ=;
        b=tqu3nP+pzLDZj2YZKuwsRSxWSFmCkcbJby3YN37Pe/+MC0J0EXh2WrGh7unp4pCJHh
         IOI3aJqip/lvExSl6e1TeKK3aNig4rVCAUPP2U0UVYlK0gkkp5ZGk4ODVmr0v3Y4O5qp
         HxkqmclSMw7GluwE0JGIWadS00VHAykoKWyhVZDin1BQur+H9m7/NdlkCFl/v/t0vZuD
         M6uJKx69oWdTGmA97hH8spQkWLj2XO6FAR3cG59IYwRAsQAAVlSBK3E48/kG4XlJzAVc
         pyPzFKr9vRBHhX8SFGdYwYMGc6vHYirZc/AD1Xr6S82fqgAWag/myhce0Ty82Hls+yIu
         n+xw==
X-Gm-Message-State: AO0yUKXstDzf2xmVSCPGQvgY0yFdHNSciWOzYmwJFasTBJIVMaFmA5ms
        ZJ3e2UvdL/dL8ebPwh2MCfeNPIPZ+fDFOPO4x6KX1Q==
X-Google-Smtp-Source: AK7set9taom1EyeB5r1S4ut3DJIs/zUFEhhueQeMKifZ1rFc9YOs6IB40cy4EFihMMDFMy6DkaOW1BtURPmLoUxrYwc=
X-Received: by 2002:a5b:647:0:b0:932:8dcd:3a13 with SMTP id
 o7-20020a5b0647000000b009328dcd3a13mr8676973ybq.5.1678194871585; Tue, 07 Mar
 2023 05:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20230302110116.342486-1-claudiu.beznea@microchip.com>
In-Reply-To: <20230302110116.342486-1-claudiu.beznea@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Mar 2023 14:14:20 +0100
Message-ID: <CACRpkda+D-U37LXBd_326gfJhUs+5meOcRH55PsCOEfmFVhBhg@mail.gmail.com>
Subject: Re: [PATCH 0/4] pinctrl: at91-pio4: few cleanups
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 12:01 PM Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:

> Series contains few cleanups for pinctr-at91-pio4 driver.

Patches applied, thank you Caludiu!
I had to manually rebase patch 4 so check the result.

Yours,
Linus Walleij
