Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D55460AE03
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiJXOp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiJXOpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:45:05 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7952FAA6F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:22:07 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id s3so5531964qtn.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6jCf/CbS4Ausj2wROnS6QLzmSsY7Fi0KDJ3zpPb3SGg=;
        b=yu4kVbpm5sjk0uyt4msUmiPwRnrzBrJXb+CwnL0ouXq7SePn/9fuNsiT8GD/ZgWFo3
         s5wuqPemURjhAYSIXWus7S7zJvwzCVhFW8HxmS+rV2cvns4vh0SqP5YNpSc476dJq3yb
         O1ox6mBHf1L3Mo0TapJeZ5r4BaaQTv+isWor/WRcAIipbWgApmtmXI9SnRrdTVz0MpYO
         +TSEMmMcNfCeEThilOJuKy7nukBTcJIQzdGAXdGImsRU/GlXgfgKZ7vNTJgTTVE65fTn
         lzgDyaN7Yy1tZYeplEVIBBwUPj4mJQPZ9Fyr2KrmIqglcVBtuRWIth/7otDAREHjEDl7
         4kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jCf/CbS4Ausj2wROnS6QLzmSsY7Fi0KDJ3zpPb3SGg=;
        b=n6noG10AARqb3vqCxSn/ziew9eBtOMe5U3ta/rQeY6iUmw4i1iQ6xH/tNk/MDYvvRU
         W+JrouPFmQ1L2lyBb0D3PlkWYmtz2ixCkJrt7AhIjFT1a8F9Uu6qWJNowxdkmJ56oGTz
         1z8L6AXIHoo4vKYrUB3SW/xnJu48uAoGBHsPiJXZac2YiHG2EQZ4q0L5giuo3TyAy7EI
         3dDuJXFJAlaPMpIyGVO+DSNNEQbOjjMUAQSaFwalsmLt6M3h4yi+WhOjrAa7mi7wgFnx
         thOenEmVGiDnX5r4iuBuqbxdy/Vy9mxHhSVrMIMeTYpur89IoL4oJxtuidsMJ0iXsECj
         QHvQ==
X-Gm-Message-State: ACrzQf0i7FTDy5VaqBNNGvk5rxTJcMAbRa4rQD7/yuzIOZ84tbmZi4kI
        aGj1iz3YEh+ewMtOlcMELUnIQ3Eh2KPuhQ==
X-Google-Smtp-Source: AMsMyM6tONSqnQie2CAY0VCT9/nEJoh4N5yZ/U3fumf9Qa2VnwON/dPLBe2dz6LDv9JldmqkG/kjmw==
X-Received: by 2002:ac8:5e0a:0:b0:39a:2960:d4a6 with SMTP id h10-20020ac85e0a000000b0039a2960d4a6mr26907024qtx.448.1666615800669;
        Mon, 24 Oct 2022 05:50:00 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id y13-20020a37f60d000000b006e2d087fd63sm14707240qkj.63.2022.10.24.05.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:50:00 -0700 (PDT)
Message-ID: <d3f9b680-9c37-4dca-8ab9-6a3375251f5a@linaro.org>
Date:   Mon, 24 Oct 2022 08:49:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 16/21] fbdev: remove s3c2410 framebuffer
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-16-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-16-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c24xx platform was removed, so the framebuffer driver is no longer
> needed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

