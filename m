Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3CD714390
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjE2FFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjE2FFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:05:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E19910DD
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 22:04:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d41763796so2096519b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 22:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685336689; x=1687928689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOFWTFkk4SKxYHlUqAq7J1c+lpLs5WOB6FRNfH9nXJo=;
        b=iVYw4lCM/2Qu8g105LxQBGkfe4xT8aBzNIWp4igMCOe2C8ScPtCI80Rg6jeX6FVxC4
         MfmKMV2GXJBcINE9w8oMvlihD3XdFI+3FHAQtlrIDveUHCCBIeU4HaLtc99NY/M2ccCL
         XcMBUp4A1IsVr4qFwC0njvhTFBMtfRgnMQfUcAIlBXYaj28UMHoLLcHcRuLhugmP5R4M
         ms+Y88655cFAbgMnAofBke2Hla20HA49t6FSiwVxt+Ixj02DZZAyKL9AuWVph43oyrXO
         tKb+nOVIG6ewdEUFhP2N+Mme+qZoOCUDcqCLGCMbzwguECiuAyTavhiROOYrfa6URdyc
         I2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685336689; x=1687928689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOFWTFkk4SKxYHlUqAq7J1c+lpLs5WOB6FRNfH9nXJo=;
        b=gNqefQGA/ge4Sg3zRdkhXV/7rux7O0kl4RSPaNTSZoVx44ZdSXAJ9GP858dOLKFnl4
         QtLO2dtzmK+oTNYn5U5wBY9C0z/I5/CFClgu+1KlUvPfipTLY0g0ntU8TVXar/1/3ZxU
         SmBYq3Bp0pAbTrSHr/5l/EeL0RGjHL3pSAdttpjabsRqum3d3l7U47dEnAi5AhGxbzi5
         hIJSMIK8YOoCHxFmLJ+JjlA77VDjZEgnSPP3zEuA++eicQUeE94zHRh8/hKNBNt4cOkc
         UU29W2vbSmRfvpyiVtWI3TWJKPpIcxXt8NrNabi3dPPQBiVk7WTZM3FqM1u10YnTw9es
         nZMA==
X-Gm-Message-State: AC+VfDwHsDhXygF6W/sG4JJZpBDiJpGxpHGaqgwbFQ3PT1kfj12f05bw
        d2LimtOk8NdizCA5it6RnYijiA==
X-Google-Smtp-Source: ACHHUZ5jfYa3+t66dq7oO6dlAu6iaa1Op31sk1qeJzIjGFTJ3p9l76ZI2e0Ja+VRKl7wjdJboknNPg==
X-Received: by 2002:a05:6a00:218f:b0:64e:bada:2411 with SMTP id h15-20020a056a00218f00b0064ebada2411mr14027159pfi.25.1685336688728;
        Sun, 28 May 2023 22:04:48 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id b9-20020aa78109000000b0063d46ec5777sm789897pfi.158.2023.05.28.22.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 22:04:48 -0700 (PDT)
Date:   Mon, 29 May 2023 10:34:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vibhore Vardhan <vibhore@ti.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, d-gole@ti.com
Subject: Re: [PATCH 0/2] cpufreq: ti-cpufreq: Enable AM62A7 CPUFreq
Message-ID: <20230529050446.ur2wvqirksy5ko2r@vireshk-i7>
References: <20230526144354.38478-1-vibhore@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526144354.38478-1-vibhore@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-05-23, 09:43, Vibhore Vardhan wrote:
> Hi,
> 
> This series adds cpufreq support for TI AM62A7 SoC.
> 
> AM62A7 has the same A53 and efuse configuration as AM625. Thus, soc_data
> from AM625 is reused. This series adds compatible string for AM62A7 to
> ti-cpufreq and cpufreq-dt-platdev drivers respectively.
> 
> Tested on am62a-sk board using manual frequency changes and then reading
> back frequency with k3conf, and this shows matching frequency to what
> was set. 
> 
> Link to the complete series including the DT patches:
> https://github.com/DhruvaG2000/v-linux/commits/am62a_cpufreq_2023
> 
> Based on patch series for AM625 by Dave Gerlach.

Applied. Thanks.

-- 
viresh
