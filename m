Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F33656812
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 08:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiL0H6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 02:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiL0H6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 02:58:08 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B66E659D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:58:05 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id f20so13034135lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+G/BwEPrVr7kfmXq62oK9q5XBGcDyHuv32x7f8Pzz0=;
        b=TdMOqT/WbdxTC0C3myt7u6Vzj07cRGNtTV5MhtkEDtv8Vv28iOoZrFpR4Ih9GGlxnb
         UNtlb9kRgKh27VqVsnrtzE+9BofIPAZfE9wX4dLbrgFQkixGsBfFt2pPG6H/uLEJLzMI
         b1uJXEMX9fpQL5jtX+jI7UnCgoNElREap3EecJroFBpa9gAK3s2Q1Yf7WxJAot/AmiKy
         JdOj73K5I8n5aohgk1UHH6qsWdxQ1VU933YJyq4jbH8PNhXAwze35Nmm/M/QMB6iKOSv
         mVWqKelmPaac2E1mQd2FzTK0JPlfllKUN1jGBZLW03l1l0hUr3LpkdtnIea4hSJihCpm
         /t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+G/BwEPrVr7kfmXq62oK9q5XBGcDyHuv32x7f8Pzz0=;
        b=qtrij4RIN/q+nH/woMOOiJ2nPyAzfSal+aHEc1mCgZz28B2z3qPEbdB55QEXqkAGlw
         dL+EQVUQjbt7NJkcjtXNABVGPySDk8SjBj4r8FZ5RSPwpxU2H0iUwCYPYM9zlqCo5UEs
         Hm2HPE1bxdiwdhZJgvOYqodQZmMkAdewPoR5Ln70OGmKetxUPcfr4C6/niaMqGULz6Cf
         grRlERATxSWwT4ZwZB76IwQKt8zcBBiXijQ9Xchb6dUoSy/Nm6aYHfAQAnQrPbbAyJDv
         Ns0NfozhBkO+9oz2at8iAuWX6Xq6VERLnsFQMnB7Kczhv7XqfooHF91XTUxI+5VBZds4
         H8Ig==
X-Gm-Message-State: AFqh2kq0D9nH5HJA4dXyJteI5eNOyJdHKcH4/S1jOp09afb8AkQ+CmaS
        hn/+JVtcqIVSB4W0grnfOTcMsg==
X-Google-Smtp-Source: AMrXdXuHCaNuAEieKb4FdTEY/qPfC0zFtnG1so9DeugSmsD70B2SP0LyMVbYvK/Oo5RCW08JI0AhKA==
X-Received: by 2002:a05:651c:510:b0:27f:bc6c:c4f4 with SMTP id o16-20020a05651c051000b0027fbc6cc4f4mr2144837ljp.9.1672127883564;
        Mon, 26 Dec 2022 23:58:03 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r26-20020a2e80da000000b0027fbc128189sm677945ljg.131.2022.12.26.23.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 23:58:03 -0800 (PST)
Message-ID: <7cc1078e-744a-c68f-98d2-6c68d2784df2@linaro.org>
Date:   Tue, 27 Dec 2022 08:58:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/7] Basic device tree support for StarFive JH7110
 RISC-V SoC
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <Y6on34WC2u3PSBHl@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y6on34WC2u3PSBHl@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2022 00:01, Conor Dooley wrote:
> On Tue, Dec 20, 2022 at 09:12:40AM +0800, Hal Feng wrote:
> The DT is waiting for the clock/reset & pinctrl binding headers anyway,

Which were sent with build warnings/errors...

Best regards,
Krzysztof

