Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F259360D13B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiJYQCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiJYQCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:02:40 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CCD190458
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:02:37 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id s17so8342589qkj.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pGkJc93t4XHow6PfRqMAHBDJ4RPCkSR1Pf3xadIrCU=;
        b=SIe8n72+y1kEIAoch9h1uTh83dmjyrtwUDXwR49pPtgKaa8fiocc+xDxIeuNNF1xGy
         J4cAQ/I4jr8DUXLZyJ92bDYWfayqzdRNuJrZK6lJSpxDKrFfbXdz4FjPuW1RG9smqVG4
         9q218uQkBOAvI/wYNnJcmTRdlTO0dLDTevZSACp7aznSNuiZRKIvveeYCIfzIQ7SZmXV
         PwpOVXPzSnI7GCjVcg/IJ83YD/K7rrwvfPmqRK/qXDdE5/kpnTNbdzJTT5TcmqUckKam
         BdEMfSsDFNH9Xhmyv6s5OCiaUoFDYSmBXF28UU5UMLadV5osVNB4nB/JsubNeBLbXSPh
         L2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pGkJc93t4XHow6PfRqMAHBDJ4RPCkSR1Pf3xadIrCU=;
        b=2foejKMWdHFjom8QOTOA5B8OnrzN2gT/YMa8FTDp9JRPnBg2zGRJkiurMRzVTTnY8l
         hmw/6MMso3ZKj/CxgoTLzu82j4DbNgSdpztRY4tEgLZu6m3y/2thAkNS4arXTNqdYlCu
         X7gOB9nMnHS1EMfmwLqztoZ/Afrzr6vJlGoIdvQqNw0jzJH9bzePijYBzmL3TaMeAOpR
         sBKNMUps5loX5fTDr7kSEIcyI5Rg2ST1d7CWXtQhcPR5w7Pnp6l3LTdW6GfsTZzFw36i
         39evFY3CkLsg1vFO30qzWG9lkzI+DuigoPMP3iAxLo1/aIBGrOuaieE0p1yu8rJj4IX+
         aiNg==
X-Gm-Message-State: ACrzQf0TNctkh/eK/W43/v9Ro1xowLIiiF7SDSswS0coyt9fpPmbKbsE
        grVH6Nx4OTwSDx7gu298Pr1cno5Sz15X9A==
X-Google-Smtp-Source: AMsMyM6pX7Eil0FyKEI9e8Ft2/z18UKFTF36FYyYjt8eQKd6AWyFYhXNIbzd6/rZfO6ndBKWu9Wzjg==
X-Received: by 2002:a05:620a:1212:b0:6ee:a8ec:c07f with SMTP id u18-20020a05620a121200b006eea8ecc07fmr28121292qkj.334.1666713756708;
        Tue, 25 Oct 2022 09:02:36 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id h2-20020ac81382000000b0038b684a1642sm1809136qtj.32.2022.10.25.09.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 09:02:35 -0700 (PDT)
Message-ID: <9b21fb34-4035-c43e-0e4e-896c2d7ba218@linaro.org>
Date:   Tue, 25 Oct 2022 12:02:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 5/5] arm64: dts: apple: Add CPU topology & cpufreq
 nodes for t8103
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024043925.25379-1-marcan@marcan.st>
 <20221024043925.25379-6-marcan@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024043925.25379-6-marcan@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 00:39, Hector Martin wrote:
> Add the missing CPU topology/capacity information and the cpufreq nodes,
> so we can have CPU frequency scaling and the scheduler has the
> information it needs to make the correct decisions.
> 

Thank you for your patch. There is something to discuss/improve.

> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupt-parent = <&aic>;
> @@ -124,6 +298,18 @@ soc {
>  		ranges;
>  		nonposted-mmio;
>  
> +		cpufreq_e: cpufreq@210e20000 {

Node name: performance-controller

> +			compatible = "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
> +			reg = <0x2 0x10e20000 0 0x1000>;
> +			#performance-domain-cells = <0>;
> +		};
> +
> +		cpufreq_p: cpufreq@211e20000 {

Ditto

> +			compatible = "apple,t8103-cluster-cpufreq", "apple,cluster-cpufreq";
> +			reg = <0x2 0x11e20000 0 0x1000>;
> +			#performance-domain-cells = <0>;
> +		};
> +
Krzysztof

