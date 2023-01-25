Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A4B67A993
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 05:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjAYEVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 23:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjAYEVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 23:21:51 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45E84A214
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 20:21:48 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso3109800pju.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 20:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PjzQ/T18GGXyjP1fr2tGkIhMBqL2k9JdVl3+iLMlvGE=;
        b=YGqqpWJQj1Juvi9aG1th2Jkyw65lcOA+FMDZ3sPR9TgDcqjELn7ge8gabdukkYupPH
         +ABtD5m6DNETMOCb4uGHraGpjAjRxA+ls80BwUnTfeGkYZUmJ7mjiVlDWNjX5Ub4qK9o
         Zet9N8OUEDFRaN7ZltG+ZADJDDoqy1Q8uUQHcSrDMBzP3OrZ0AWZgiX+fR26p3okBoC2
         BldJV3Mf8t9Hn9Dq48Kat3dnSnA4HsZEjVkLHGyCa21q7Hquy2T2//kaGxcCHkeQ4lmm
         3SGmq2tY5+G1WReAh0kZZvCLwKhgUzTMYkTmXWLfZlS/Lq/USawQoQeSKvqL6Q4fKayJ
         0oiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjzQ/T18GGXyjP1fr2tGkIhMBqL2k9JdVl3+iLMlvGE=;
        b=MsrzNi60Mpy1Hi4kOOfw+WyyY2cuzoyNJ/gastmjFKsibIWeqvPu02KquCNIm6BlsY
         m0SaYgfC5AoyKG/fYlI+x2a/6uC77b3FBh/04SuFV4iknrNvOSQKgqwzp1TzAAPTLB+V
         QJYSLnSI8xa7sEOAkQM7SYEDm2f4WFKYQ2cwmpWF2qiciQCDGO2Hw6DnHEBHxOyu7j1f
         sv+Bge8fJ3rGtYUfjrR0r7U+EaPJrg2aLUiH2ZBvpmtcKLm7wScrhjNPm0uZxoj5Bc/l
         YPAXfGYBjNmLXWYvJqnwugaTPQkrywlgolAs4tBBh4Ebt1Go26glcbLawUN+pWY42xHD
         J/UA==
X-Gm-Message-State: AFqh2krpDLD1I/D1b5WuftVj2/X+3ghcL9LrriwrLmEvkjJNFrZabf7z
        fYx2gbJNfJ9bk6TUaKOn3WJmDQ==
X-Google-Smtp-Source: AMrXdXstydjoWHHyfBEAiqN9oXn2N+8Ls6pgDtBMucEiLgGiwZu3fQSoawT5i2Uw5fJr/LcrEALlCg==
X-Received: by 2002:a05:6a21:99a7:b0:b5:d781:ca7 with SMTP id ve39-20020a056a2199a700b000b5d7810ca7mr42783771pzb.3.1674620508463;
        Tue, 24 Jan 2023 20:21:48 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id e26-20020a65689a000000b004774b5dc24dsm2235706pgt.12.2023.01.24.20.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:21:47 -0800 (PST)
Date:   Wed, 25 Jan 2023 09:51:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <20230125042145.hrjpnskywwqn7b6v@vireshk-i7>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
 <20221121073946.GE11945@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121073946.GE11945@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-22, 13:09, Manivannan Sadhasivam wrote:
> That's right. I have proposed to do the similar change to other SoCs as well
> once the series was completely merged. I thought of doing so for 6.3.
> 
> Btw, there seems to be one more candidate:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sm8250.dtsi#n2537
> 
> Looks like newer SoCs that has the GMU within the GPU block doesn't have clock
> property. This is because, GMU is the one supplying clocks to the GPU unlike the
> old SoCs where the clocks used to come from GCC itself.
> 
> But we do have a GMU devicetree node, so it should be a matter of adding the
> clock provider support as done for cpufreq and represent it in devicetree.
> 
> I'll ping Rob Clark and see how to get it done.

Any update on this Mani ? I want to get the hack removed if possible.

-- 
viresh
