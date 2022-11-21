Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85C0631A74
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiKUHkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiKUHk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:40:27 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C40F6C735
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:39:55 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y10so8658486plp.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eGNnPg4qR8iodffqAnabStv1epW424yoY3sdhIzyvq8=;
        b=Wm4nwRweHg8ft542EPEVdNFz06icI7cqsnHnm64Gx0AHwYEwNgT9NtHcvtOtP3SbPv
         1nVzrbq148A3fggruWDcKYSGelDuLW7xXPDG5U+aCOpY4TSnnFf2WimMIhuKK0FdazOd
         +Brxp+wC4n2nrcKk4715OqOi3hnZ9AK6Gagt2QIRgiWsNjyzDoEjwP6BEBWt9XVykdXz
         GPpJcVCloK4IeNUFIaHkzPiV0O3Y+/JM7Qz7D9U3sO/LWGLODeglcyj7Gdrb3Kyoap1S
         HaVsyziiKIHcU1LVAEeDr847FLXQT2B8L+kvjdAd2skFnhuI/7wNKRmV6WvXsLCWHyik
         UqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGNnPg4qR8iodffqAnabStv1epW424yoY3sdhIzyvq8=;
        b=taDfVg4QzNHSuSuB9AvfxgKgHzCTUR/QUaT/CenjWBhSaOlGlmYBGirmjItzVjDNfL
         fIfjwGUnJ+ICFiok9GuNqvQX9lreRy8XGk1vAprgtpsE9kwgWWDjK+0SCgoO9Ptu6d2U
         m2pBW3w2tLZ6hc+lciIrS0TOr8C0yY+UgRVUMgp6zdzXni/582u/Tn1hNFfgTYt22tgB
         uy5KDfu+/r+3VqJrEUXOeTiop7mP55TTEZdbZ3HMnQQlbd4n0LwaMgCWhxUPuDRXeCKO
         HEYl9lTqwAfePS6xMWb/ICN7P7nkKXlZRdFVwNPQx3Yf3fOKhJq1s9QF/sLYWtNxZIVt
         mpQQ==
X-Gm-Message-State: ANoB5pnwXTJJT3Fk53qRL5sqODKvfGuPiRXyuVHqBvvmWS0ErBe5/TUg
        TZTY02rpekhVoE7zk34tTbqc
X-Google-Smtp-Source: AA0mqf6YDKfllf5rHP7sIDrsdmi0cqKUkXFKc5JBhYUJcD+tSr648woEyMUpiPYml4VkaYWnqKG3QQ==
X-Received: by 2002:a17:902:e385:b0:178:7040:9917 with SMTP id g5-20020a170902e38500b0017870409917mr10600763ple.109.1669016395061;
        Sun, 20 Nov 2022 23:39:55 -0800 (PST)
Received: from thinkpad ([59.92.99.222])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b00186748fe6ccsm9014625plf.214.2022.11.20.23.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:39:53 -0800 (PST)
Date:   Mon, 21 Nov 2022 13:09:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <20221121073946.GE11945@thinkpad>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3snGQet8yc7HnJK@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 08:22:01AM +0100, Johan Hovold wrote:
> On Mon, Nov 21, 2022 at 12:27:48PM +0530, Viresh Kumar wrote:
> > This removes the special code added by the commit 2083da24eb56 ("OPP:
> > Allow multiple clocks for a device"), to make it work for Qcom SoC.
> > 
> > In qcom-cpufreq-hw driver, we want to skip clk configuration that
> > happens via dev_pm_opp_set_opp(), but still want the OPP core to parse
> > the "opp-hz" property so we can use the freq based OPP helpers.
> > 
> > The DT for Qcom SoCs is fixed now and contain a valid clk entry, and we
> > no longer need the special handling of the same in the OPP core.
> 
> Didn't this affect also sc8280xp? Perhaps you can hold off with applying
> this one for a bit until the needed devicetree changes are in linux-next
> for all the affected platforms.
> 
> (It looks like Mani's series only updated sm8450 and I guess Bjorn
> hasn't picked up that one up yet either.)
> 

That's right. I have proposed to do the similar change to other SoCs as well
once the series was completely merged. I thought of doing so for 6.3.

Btw, there seems to be one more candidate:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sm8250.dtsi#n2537

Looks like newer SoCs that has the GMU within the GPU block doesn't have clock
property. This is because, GMU is the one supplying clocks to the GPU unlike the
old SoCs where the clocks used to come from GCC itself.

But we do have a GMU devicetree node, so it should be a matter of adding the
clock provider support as done for cpufreq and represent it in devicetree.

I'll ping Rob Clark and see how to get it done.

Thanks,
Mani

> Johan

-- 
மணிவண்ணன் சதாசிவம்
