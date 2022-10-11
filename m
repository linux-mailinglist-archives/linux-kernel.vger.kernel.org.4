Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088805FBB91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJKTvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJKTu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:50:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20177969E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:50:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k2so33760212ejr.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqLX/cHLeCd3S+HbW8lS6SU+seQ/9WfCD+VYS7kKpIU=;
        b=NgAJYwcfalbJNnRuL7jrfkwsS5GJVYzJg/sYi24QMhEgWYfytdwKIUXJY22xBH5c6r
         tbTawDjoAd0he+vCAR/oEuAH5HF/mXpeuoDfYJNQ+jIpokQ80f+ubVH20jJL4JzB+gj7
         X0ATZA9uqdCRLalPuN7w8M+z5gHs55+XjCzoZw7PhcIutp1kFeBQRbJrOTrS/evOirqp
         j6CmwR5iYXF/e1NonaIIE2/OKK0qOstU6KbcExA4ZJrZj1PBBg0WA6/AmDmBPyKNskdl
         2uhg6myWZp+w2+Qd6NkcBjxQ/Oa0Sj2wu5J3/pJFyCAPMtnRyQWAnyi8yFKOv5+pZ/Mx
         XxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqLX/cHLeCd3S+HbW8lS6SU+seQ/9WfCD+VYS7kKpIU=;
        b=My2NB9e3OQE/6C9E2mgSCvpcLntY2UvBckxkjlu0kMS8YFuv/tzIlbdo35kWidVZaD
         ywuqim8AcG27N2kKmP0vT8iB75n3wysYUdNiYa6mhluh/7VBul20xetm6wJsEfa8oQE3
         p1HgltmgFZ/UqADA3GGHnCPBjb4Be4txbIACsd2nKq/gQwguHfdUW2gF97DlGqRv+x5V
         S9cUwZwhmH715fhBdFB2zJ34GBB3U644wbzR4EII1ax9SQ1XVngvyPrPupPCb8P1QG6s
         G3vShh0ALQ3N69GAqeXipVJhde7gPCBKT7Vou4EJ0fET2Neyd3UAxWS0pG0PBmBqifaF
         2g/Q==
X-Gm-Message-State: ACrzQf3m9uUi8TVBt9QnZ4N2BZ0fn9LQextvFk1tDGvZkRRHG6Amdn9p
        H9G4pb4XoUEM6sXlH0Fp2/A=
X-Google-Smtp-Source: AMsMyM6baT0521/j/DAYSV/7ZMytgY5v+QR2PAPG2ggq1Lu5BkPo9r8Q1WxpXKF7hto4bRV6qqYUOQ==
X-Received: by 2002:a17:906:8479:b0:78d:cf17:2d70 with SMTP id hx25-20020a170906847900b0078dcf172d70mr5338745ejc.319.1665517853171;
        Tue, 11 Oct 2022 12:50:53 -0700 (PDT)
Received: from [192.168.1.102] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id q20-20020a1709064c9400b007829fb46a0esm145779eju.142.2022.10.11.12.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 12:50:52 -0700 (PDT)
Message-ID: <a9ee121b-7494-db5b-a5d8-58a8ef8a7d31@gmail.com>
Date:   Tue, 11 Oct 2022 21:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] staging: r8192e: Rename macro defined in rtl_dm.h
Content-Language: en-US
To:     Dragan Cvetic <dragan.m.cvetic@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221010190439.13131-1-dragan.m.cvetic@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221010190439.13131-1-dragan.m.cvetic@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 21:04, Dragan Cvetic wrote:
> Rename macro definitions to avoid CamelCase which is not accepted by
> checkpatch.
> 
> No test performed on HW, just build.
> 
> Dragan Cvetic (3):
>    staging: rtl8192e: Rename RateAdapt..., RxPath...TH_low, RxPath..._TH
>    staging: rtl8192e: Rename RateAdap...20M, RateAdap...40M, VeryLowRSSI
>    staging: rtl8192e: Rename WAIotTHVal, RegC38_TH
> 
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 14 ++++++------
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 22 +++++++++----------
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.h    | 16 +++++++-------
>   3 files changed, 26 insertions(+), 26 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
