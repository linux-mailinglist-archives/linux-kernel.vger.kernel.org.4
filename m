Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC6D6DD16B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDKFMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDKFMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:12:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443F0E50;
        Mon, 10 Apr 2023 22:12:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d7so19967607lfj.3;
        Mon, 10 Apr 2023 22:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681189956; x=1683781956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yca4zCL2vEcciEKMbn7Tp+QqyjObsV8lWyK4Yr1PQQU=;
        b=b1cNQZMcjynuzi6Xs4VdXdj7sNodwjDReRwXhU+WeqOaVBzlLLJukdvDfxppJ3roUI
         D791pDzjE6hztriWo/ag6k98lGK+OBHVEgF1JzpKjBiuxnNxyGgYutnnnfknfYVGLvcQ
         xzDy8ZQ1S1j+I8KP/H/TUL6x4dtLPyvXR/NZe5WNBWr//ATJ+Yl3zfq9FMmQjvHgLxoj
         7/q4UsKszPqwZhv577Sf8Iz91+90MStHyuhIOCH+QIZ1+I8OgHg9i4W3GWkWoA2AUOE7
         BUG/0T67PWXoq2dx0NPUrE6NtWNdEtkEdF4272fAWsOmanLfxp3E16y+aUgGQWNZpxBU
         G9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681189956; x=1683781956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yca4zCL2vEcciEKMbn7Tp+QqyjObsV8lWyK4Yr1PQQU=;
        b=1bJaFgJMJafyt3+sGWk1NfALtL2R/uGB8A+EV6vZxf2L60qZPPQ+5JKC67u3GY3NIj
         Q1W8n4lLh6t4M8V6eczHiVkYhu1s/AwM9s1TIQaiPpJZJNvqabsKx6p2rOuTb7h6bGLi
         UDoo7lhKOP6Ixx1cPDkdRYlK54H/fnR6RMCiVhDV1X56bQFUSjExm+Kv+70jAELiOq8m
         0qtJdkPmvFwkMegC+Ui5UPx2nIvQB6c61Dthp0J8+pExw56cIlURcryrLmMjBMDBg8HF
         ZN3xi8Lbdp0MQ0Ba3tKeXPlXFbpUiEYh4aVqq9pamIeRJZTs7quu5V4JIARpDFYtpj1g
         bfNA==
X-Gm-Message-State: AAQBX9cgf9kYwcNQfHuldJPFrjG+lcPouJB1ou+Mfqt4m+xqyE27ru5P
        qr735rH62PHXuTLXWnvPIQqggecjC4A=
X-Google-Smtp-Source: AKy350ZgQ2+UGsz7W+lWin+vzdlveJLj/FjrruEXucecUM1zHBbcj74shxj2Ad5gFzrJRrw8Vham6w==
X-Received: by 2002:a05:6512:218e:b0:4ec:63e6:526e with SMTP id b14-20020a056512218e00b004ec63e6526emr3057880lft.65.1681189956238;
        Mon, 10 Apr 2023 22:12:36 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id f23-20020a19ae17000000b004eb12329053sm2404451lfc.256.2023.04.10.22.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:12:35 -0700 (PDT)
Date:   Tue, 11 Apr 2023 08:12:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joy Chakraborty <joychakr@google.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com
Subject: Re: [PATCH v5 0/2] spi: dw: DW SPI DMA Driver updates
Message-ID: <20230411051233.aps5g2eq4qt4iumt@mobilestation>
References: <20230330063450.2289058-1-joychakr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330063450.2289058-1-joychakr@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc+=Andy

On Thu, Mar 30, 2023 at 06:34:48AM +0000, Joy Chakraborty wrote:
> This Patch series adds support for 32 bits per word trasfers using DMA
> and some defensive checks around dma controller capabilities.
> ---
> V1 Changes : Add support for AxSize=4 bytes to support 32bits/word.
> ---
> V1->V2 Changes : Add dma capability check to make sure address widths
> are supported.
> ---
> V2->V3 Changes : Split changes , add DMA direction check and other
> cosmetic chnages.
> ---
> V3->V4 Changes : Fix Sparce Warning
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303270715.w9sMJhIh-lkp@intel.com/
> ---
> V4->V5 Changes : Preserve reverse xmas Tree order, move direction
> check before initalisation of further capabilities, remove zero
> initialisations, remove error OR'ing.

The series looks good to me now. Though if I were you I would have
split up the last patch into two ones.

Anyway I tested the patchset on Baikal-T1 SoC with DW APB SSI 3.22b +
DW DMAC 2.18b and looped back SPI-interface. So feel free to add:
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

@Andy, anything to add from your side?
@Mark, if you are ok with the series content please merge in.

-Serge(y)

> ---
> 
> Joy Chakraborty (2):
>   spi: dw: Add 32 bpw support to DW DMA Controller
>   spi: dw: Add dma controller capability checks
> 
>  drivers/spi/spi-dw-dma.c | 70 ++++++++++++++++++++++++++++++++--------
>  drivers/spi/spi-dw.h     |  1 +
>  2 files changed, 57 insertions(+), 14 deletions(-)
> 
> -- 
> 2.40.0.423.gd6c402a77b-goog
> 
