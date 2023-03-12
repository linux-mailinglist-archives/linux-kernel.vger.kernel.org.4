Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909966B6A00
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjCLSUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjCLSTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:19:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149F92749E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:12:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g10so11240676eda.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678644647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJbzQk4TLzSKDEe2jC8259R3RwrclYP4GOKv7WeR0Ww=;
        b=zZTr7VMDlWX4uf8nU8uN2z43yfKKSLyKBUDDEEcIbLNTgO/RqeA4Qo566pDmoA8+eX
         xqRexfSEe5rYovwnSRaE3jAZk/MolOON2aXotrZ5qvjJ2WYNFksIs3HX6XIPAlqxc+G6
         5JfKiZe7m7qxhTlslT8SzWB2Cu65qbpWGIcBUr/GPhP+y4Kuv9OLFmj+NyzBXtIxmgSr
         dbDwcH1oHiTKemOuZlcR4rZcK+cVT8JuoSlptdjlht9L+hPqRn5i8TqxemYxl9Pn/J1x
         OPm9U2xm9hVa93s8cEY4QHYoiFkesw84kkb5gyy1vG0Y0Qi05uATsnZ2xZjPLnDop6lx
         qHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678644647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJbzQk4TLzSKDEe2jC8259R3RwrclYP4GOKv7WeR0Ww=;
        b=y1kthW1zcxBZNbwoS4+nwYqejPVc/GnoL6601L0VVm0u6DhY72qMYQxEkXq0dQpxAT
         cE0+5uLMNDKJV19igf/Vn01aK6NN0yGUEVi0rs2tokwY2lo8QEKw68tihOkucbjkmg22
         KNCvoK4cijYievgzVZ07rR1Vxl7kGvw2WgCR8qMVFZ/yeTY1Erb79fSFp3EhkVfhDJYR
         YUVSvYYFE3Mygb31sOkR6uTS+0jfyCbHGPUpF+o4GAPG5e7N7gmTQwl/9X83PrNavZor
         SErJnIA0vwvsHe6fmk6xTeRCTBw+0nf2ktN74dCDYOTg7PiSjLZcKnq4PhuuUFE6uch6
         iKGA==
X-Gm-Message-State: AO0yUKWAwN50fIxbVcm4pf3++Gk7FZ0XSWEbzUrDVf1nPJljjyFRQzYk
        ZJIWx/wuPRtSPI/58NnknIb22Q==
X-Google-Smtp-Source: AK7set9brgC1i/ieyhjxBiLx9HBWqe3Fd1FsMtrCMQZRRFIISTpQPpLIbjDXETPymdO1F2gGMPajNg==
X-Received: by 2002:a17:907:6d1a:b0:8b1:238b:80ac with SMTP id sa26-20020a1709076d1a00b008b1238b80acmr41929936ejc.67.1678644647299;
        Sun, 12 Mar 2023 11:10:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id oq12-20020a170906cc8c00b008d68d018153sm2465874ejb.23.2023.03.12.11.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 11:10:46 -0700 (PDT)
Message-ID: <dd6aa950-b006-9cb6-a03d-a5e54c98ab9b@linaro.org>
Date:   Sun, 12 Mar 2023 19:10:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 0/3] mmc: dw_mmc: fix DW MMC cores with 32-bit bus on
 64-bit Linux systems
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <640e1428.c20a0220.f761b.1a1b@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <640e1428.c20a0220.f761b.1a1b@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 18:58, Sergey Lisov wrote:
> DesignWare MMC cores have a configurable data bus width of either 16, 32, or 64
> bytes. It is possible, and some vendors actually do it, to ship a DW MMC core
> configured for 32-bit data bus within a 64-bit SoC. In this case the kernel
> will attempt 64-bit (readq) accesses to certain 64-bit MMIO registers, while
> the core will expect pairs of 32-bit accesses.
> 
> It seems that currently the only register for which the kernel performs 64-bit
> accesses is the FIFO. The symptom is that the DW MMC core never receives a read
> on the second half of the register, does not register the datum as being read,
> and thus not advancing its internal FIFO pointer, breaking further reads. It
> also seems that this FIFO is only used for small (less than 16 bytes)
> transfers, which probably means that only some SDIO cards are affected.
> 
> Changelog:
> 
> v5:
> - rename "samsung,exynos78xx-dw-mshc" to "samsung,exynos7885-dw-mshc"
> - rename "samsung,exynos78xx-dw-mshc" to "samsung,exynos7885-dw-mshc"

So this is fifth version today? You need to wait before resending, to
gather other comments.

Also, something is wrong with your mailing. Threading is gone and all
patches arrive twice with different Message IDs.

Best regards,
Krzysztof

