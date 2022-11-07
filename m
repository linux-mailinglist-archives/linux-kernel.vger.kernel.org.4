Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579B761EFD6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiKGKCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiKGKCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:02:08 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F802186E4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:02:07 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 136so6147344pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hLNYp+9EJxn0NrngK9OId1WhBrnceXYO/38qlXmZRJA=;
        b=NBlpevsllqlINLnMCPOgfYg8KJl7XozYj0SwKtc2424//yAXEXFOEQtP40QxHqXcRU
         sBYepgVI7YIHVr3AnMtQImMejx7sGXnIzfInL7h0fUeL6V1wfw8McKm24nwRopQ3XFIG
         jsPQnVYOdF9RH+r9QdPTLbcNFep++pvuDwCEa0t816G/LEdVpxoyWPe7L6N+tnGeD8ED
         dcuDjogvM8AtD4Alonqyl5CyJPdgTpuzYQDykIQ8zBvhOtmyTm0DITQI+4X6ZLPdZt87
         /0JiTkM4SfP7wCeoMartm2Meba21ZL6OSAy4Kwqi6uMALIM6G5BDptsGEltQPnFOnnlh
         dEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLNYp+9EJxn0NrngK9OId1WhBrnceXYO/38qlXmZRJA=;
        b=vcJEOYmYkTNvq7OpQqmJ/VFCXjlepL4zGh8Ocdf4i8JLPnG8L7bJAMlC1Vmz+xm0iK
         RGEoYkIkGxlALTn/LC1iUeWorFl4/n+AyxmKwAZAvw6Ozwy+lkmLv9BRj/p5xCxzh9c+
         rLH6EoCMWuodwNGxpnC/121iIcmVkJeDqRB2/rU1XYRH+OMzk03+CtcYDWyGYj9ZEBuI
         P5q/zjq4HwppkFJ7OXfAfriOMAzkojGYe3K5SqfmgLZcpM0eUQa2HbqpPDrYyWmORhaN
         5BC7MCrYnVeU7s/iCyQJ7vrA55hInPJ/SX2bng8JOVVMCREf4P9kAr1kus6jTXpLzd0y
         0b5Q==
X-Gm-Message-State: ACrzQf18s3KZw15oM7PDC/F2DFaB/HoKIpypYMW3juiDy6Am/9u21raK
        wZO6ss6LLXdostYdpa6QM4aeDQ==
X-Google-Smtp-Source: AMsMyM40bpJpZbywPpKVL48y6aqSA6xQjDEJWlfn+atk7gJPoJkt/LO8evFJ5aoRwfxrLhTo2z7CJQ==
X-Received: by 2002:a63:ce43:0:b0:45b:d6ed:6c2 with SMTP id r3-20020a63ce43000000b0045bd6ed06c2mr42229873pgi.406.1667815327009;
        Mon, 07 Nov 2022 02:02:07 -0800 (PST)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id y188-20020a6232c5000000b0056ded8d5918sm4071905pfy.134.2022.11.07.02.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 02:02:06 -0800 (PST)
Date:   Mon, 7 Nov 2022 15:32:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vibhore Vardhan <vibhore@ti.com>
Cc:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH RESEND 0/5] cpufreq: ti-cpufreq: Enable AM625 CPUFreq
Message-ID: <20221107100204.7dm6shvaew6zmi34@vireshk-i7>
References: <20221101180935.139268-1-vibhore@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101180935.139268-1-vibhore@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-11-22, 13:09, Vibhore Vardhan wrote:
> Apologies, resending because I botched the label in previous series.
> Please reply to this series rather than the one sent previously.
> 
> Hi,
> This series enables CPUFreq for AM625. This version is a fixup and
> rebase of the patch series by Dave Gerlach on v6.1-rc3 [1].
> 
> It updates the ti-cpufreq driver to support parsing of the speed grade
> value out of the JTAG_USER_ID register and adds necessary support code
> to use cpufreq-dt.
> 
> The operating-points table that gets added support 200,400,600,800 for
> all variants and then 1GHz for the S Speed grade only and 1.25 for the T
> Speed grade only. 1.4GHz has been added in board specific dts file as it
> requires VDD_CORE to be at 0.85V.
> 
> The latency between pre and post frequency transition was measured in
> CPUFreq driver for all combinations of OPP changes. The average value
> was selected as overall clock-latency.
> 
> Tested on am62-sk board using manual frequency changes and then reading
> back frequency with k3conf, and this shows matching frequency to what
> was set.
> 
> This should not impact existing K3 platforms that do not have operating
> points table defined.

Applied. Thanks.

-- 
viresh
