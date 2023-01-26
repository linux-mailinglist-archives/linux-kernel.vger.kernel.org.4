Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496F867C99C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbjAZLSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237232AbjAZLSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:18:12 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DA33B0EE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:18:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso883543wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+3TvO79F7TEEj/cEI0PvElkjPOY6Ohmc660NweZRSU=;
        b=lkx9WMVEmqzIyivtlhzZ0ulR60zs1TzOH1UzIs5UvcAsoVJvATwYBchdRTOW8gGpba
         37W9viahXGpoZgEsxcsjp27xoRClpBDJhVrjCIvjVSlYNJ11TQHQWt2cyM749Iu5357C
         HVxLlWH6MFWlHAAY4dk4e/xNcyha5CuIDkUXEd73ZkFDXl9OpmXPRh6HSND10ZTaE6HF
         gYLgEPMyUPVXEMx/Aspl7xaEY1hni9l+vGrB/ZjR/sRTtJd07NFxxdJwVfVVZWxyWNtg
         j6beKYNQ8456Mw8Xqm58DedlTyFEPSvhKQvhtQgcW+rf+pJPWLKAoZqvuPdpog2K+y6Q
         jvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+3TvO79F7TEEj/cEI0PvElkjPOY6Ohmc660NweZRSU=;
        b=XUhfomUwxq4+nVGGF6X3TiemP+ZC3wRqyCnDAoGjZqU+bxGtFXNfOt8z1wJ7lKXPqP
         nUpg83rtALh2VZXNo3kKi2b5PDJGJJ/WJW91CrUd6fJVWDohTbiADY2n0roIkAuMcU6C
         MbGThuyjm46pwMxl3uey15FIuDST+we7wf1IAtH3e7E4Bl+QXOrpr7CWHeyWPp6LFeFg
         CwN4ERSeO7Isxxsem/xGtRwNZGnDEZn0uOthS/fwMyI2WB4PLn1hwvabLIxPK4fShZi/
         3C3jnZbDoD5emghftOFui8rF/IB66iig4g+8hO00PhWzxbbJR8t4r6nGlNZiaD0NU17W
         HSQw==
X-Gm-Message-State: AFqh2kqlJ4gWw25UxfAUWLGZphgERfdArZvBNci07gA4QReDqd2YXloO
        JoS/kdSBtsyZz0liG81btnZxGA==
X-Google-Smtp-Source: AMrXdXsjZN+5SOjisx2Bn0IQCFbL29bvC6rFJ4l0C6wRDdFAmemSF4Qcvr4XjxpJ5Gm5bqy3xnmyqA==
X-Received: by 2002:a05:600c:281:b0:3da:1132:4b63 with SMTP id 1-20020a05600c028100b003da11324b63mr35350886wmk.5.1674731887928;
        Thu, 26 Jan 2023 03:18:07 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z3-20020a05600c078300b003db12112fcfsm1160901wmo.4.2023.01.26.03.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 03:18:07 -0800 (PST)
Message-ID: <b766f862-b253-b2a7-7f43-87ebeb0a4263@linaro.org>
Date:   Thu, 26 Jan 2023 12:18:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] clocksource/drivers/riscv: Get rid of
 clocksource_arch_init() callback
Content-Language: en-US
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>
References: <20221229224601.103851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221229224601.103851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/2022 23:46, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Having a clocksource_arch_init() callback always sets vdso_clock_mode to
> VDSO_CLOCKMODE_ARCHTIMER if GENERIC_GETTIMEOFDAY is enabled, this is
> required for the riscv-timer.
> 
> This works for platforms where just riscv-timer clocksource is present.
> On platforms where other clock sources are available we want them to
> register with vdso_clock_mode set to VDSO_CLOCKMODE_NONE.
> 
> On the Renesas RZ/Five SoC OSTM block can be used as clocksource [0], to
> avoid multiple clock sources being registered as VDSO_CLOCKMODE_ARCHTIMER
> move setting of vdso_clock_mode in the riscv-timer driver instead of doing
> this in clocksource_arch_init() callback as done similarly for ARM/64
> architecture.
> 
> [0] drivers/clocksource/renesas-ostm.c
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Samuel Holland <samuel@sholland.org>
> ---

Applied, I had a trivial conflict which was fixed. Please have a look on 
the patch once it is push in the timers/next branch

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

