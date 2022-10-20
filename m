Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9E7605656
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 06:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJTEez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 00:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJTEeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 00:34:50 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E444D24D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:34:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so1934034pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NfwTq6KSXaTvBvDUTpDGop9SqmFDO5Fh0RvPOKiTWbI=;
        b=QKvBGCWBl1Jm4QBZJsY286lI5ke0f2NPknhECrH3GomakRardDXQWoS2XfjfLODLa4
         ndAwozX89v7hp3xuZtDpVQjZRuvr9GDSGmOVWaooVLtAX/owgw7OJIDB98GtYMbj3GGv
         fk5wrU1xayyLjMEloiaxV2S6Ybzww2ATFJJi3G+fd/btiKkjrqrLeq4Sz3SFS1AsXyor
         okQLzSGJaCoYAigpLcTZ4cCvurw03ql0lI5STxvpXSP+l2IwBTRctBTOqBDzQvCSlTEG
         ZI4DSxPFnB0hZCfoIhU8I2B/W/ZGmq269S+K7EVgKjCioa6z6hb02D1ZtOh2fRYTX0QC
         leXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfwTq6KSXaTvBvDUTpDGop9SqmFDO5Fh0RvPOKiTWbI=;
        b=D0T0BNhlkX3xvEIiIQH4w/MNgcnAxb5LZW+5boeeXeSjbJBTxyL448VeG+s0wePa5n
         tP2tNbmRU8z/yO6sMYCi9uRZPwBWyWg0OHNrhU4Ld2sXHNzXtskpu2O/IPdL6OSSjIZD
         8ww6csYwMaaHUvM6Vkzvf0yCb0zTCQmsnI0i1w7faFzUYF6BFRkXZMpQ+CLXhvJ3NZOf
         /Y7x5uMzvlM6sQfiBJxXDl7ftvVNem004/nlrknLV6w1narBelIDO3TUxx0jXXEmppBa
         vfVSAFE/5RZ6XwoeCflmOeW+sbEtrtEcpOHHly+FTnglSs1uiOXkeSz1WNGmdxl+MtDC
         QSbQ==
X-Gm-Message-State: ACrzQf1MLNGqywsXGVtciW6TjtFgi7XRtdReX9FPK8ZeiUOqcd+dTUXB
        d/0YGp4cbCvE6K4ywTn61pPNfw==
X-Google-Smtp-Source: AMsMyM6vcnMT++NWeov3vKwcKtr+Kuuvmsv8j4tn+2jkvG9WAcYV2d8+GgDtPrj1Zisu1OyLJH8vUQ==
X-Received: by 2002:a17:90a:708e:b0:212:4582:28e0 with SMTP id g14-20020a17090a708e00b00212458228e0mr838265pjk.72.1666240487411;
        Wed, 19 Oct 2022 21:34:47 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b00181e55d02dcsm11590235pla.139.2022.10.19.21.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 21:34:09 -0700 (PDT)
Date:   Thu, 20 Oct 2022 10:03:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 6/6] clk: spear: Fix SSP clock definition on SPEAr600
Message-ID: <20221020043354.y74why6vkvj3ccuo@vireshk-i7>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
 <20221019133208.319626-7-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019133208.319626-7-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-22, 15:32, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> There is no SPEAr600 device named "ssp-pl022.x". Instead, the description
> of the SSP (Synchronous Serial Port) was recently added to the Device Tree,
> and the device name is "xxx.spi", so we should associate the SSP gateable
> clock to these device names.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  drivers/clk/spear/spear6xx_clock.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
