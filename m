Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F8E6960D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjBNKdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjBNKda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:33:30 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943BA227BB;
        Tue, 14 Feb 2023 02:33:27 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id cf42so22858138lfb.1;
        Tue, 14 Feb 2023 02:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5KLJdcy6ykZCzGPMCBN9gC4v93vYkbHdnRlOMJCNb0=;
        b=dH3dtf5m0tK08ocqe/9CRa4KrTrVgWojqkD9en0KyhlXu5JZGwaEfKWCAYanDRY8+x
         2s8wt6QMM+DkxCvkkP19UewiZTclVZixnqkxy3QIeocpGSLCeJeoAPgUqKuHBiTLLz2M
         HorC1FOZvohEgaMqWss2brtVw2UnQA+pctslLCtoOsX9IYuJV90LBvpQz/Nalusxpiyc
         7BAnU+Vmb1Ungg1R8wBsgYx1DxSBTEimvnBnScKOpGOmSL9s8IG4L0p8MLCEkXbvV8dT
         23MFjl+7DP4HZ/Pxg/XDahKulbvUIhpL5nuR/RqhAq9dw3t1299uez0btcOIEj/6002H
         ZVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5KLJdcy6ykZCzGPMCBN9gC4v93vYkbHdnRlOMJCNb0=;
        b=3c9irBhqAUHgB5Q1mix//6PdHVIlhUzuPkB1vl6q5fnnJi5dyoNbx4CN2T1iG+fFqv
         Y+usiHgTzeVCEJka7p/oFEBEJQW3G+dlEAM+fMTrothpzX7cjZcCHU5hqUm09xUlaW6+
         /feKHgNIK1Sa3N6Srqp7p9fFPYz29SYPNXM4yiAnK23uh7fy4UCgtmg29BJKuJhzPWy5
         xGaNUpmdqVeOKeBKt7BNXzrtyP6RcYbXaj+7fNZ1jsxF/ojMCH8VJuylJC6EaQpNm0so
         meDVmdziQ+/u8LksSOih4ENtO7obYS/mU+fWPfiWE/TllWWCCsLpjvjYotRYR/D3mwye
         ZY6Q==
X-Gm-Message-State: AO0yUKXj6F9I3DSfotm1xMXVbzXl+FWtWqPMVjhgWr728jUXz/49SgSp
        /yHq80A/LukSKTMKFoxrx5N8Uhz4iCE=
X-Google-Smtp-Source: AK7set/XQFphRDI6LFsYjCz0934ovquKG4Eg3dZbC9z80GrCt3jPXZk7udPc0Qf9S0tnO32rABJ46w==
X-Received: by 2002:a05:6512:402:b0:4a4:68b8:f4f0 with SMTP id u2-20020a056512040200b004a468b8f4f0mr442536lfk.54.1676370805584;
        Tue, 14 Feb 2023 02:33:25 -0800 (PST)
Received: from [192.168.1.103] ([31.173.81.56])
        by smtp.gmail.com with ESMTPSA id q18-20020ac25292000000b004d783b0d310sm1058874lfm.307.2023.02.14.02.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 02:33:25 -0800 (PST)
Subject: Re: [PATCH] ata: pata_octeon_cf: drop kernel-doc notation
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-ide@vger.kernel.org
References: <20230213212549.29914-1-rdunlap@infradead.org>
 <51fb5b13-3e9c-785f-b96f-6f398389d434@gmail.com>
 <c67e4b38-7bec-0901-b13d-6390c1d51cd8@gmail.com>
 <dafa3a1f-3661-72d3-6423-22e8399b333f@opensource.wdc.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <7c2f9a86-fa86-c1e2-25f8-1dd7c2350f69@gmail.com>
Date:   Tue, 14 Feb 2023 13:33:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <dafa3a1f-3661-72d3-6423-22e8399b333f@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 12:27 PM, Damien Le Moal wrote:
[...]
>>>    Hm, why didn't you CC me?
>>>
>>> On 2/14/23 12:25 AM, Randy Dunlap wrote:
>>>
>>>> Fix a slew of kernel-doc warnings in pata_octeon_cf.c by changing
>>>> all "/**" comments to "/*" since they are not in kernel-doc format.
>>>>
>>>> Fixes: 3c929c6f5aa7 ("libata: New driver for OCTEON SOC Compact Flash interface (v7).")
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Link: https://lore.kernel.org/all/202302101722.5O56RClE-lkp@intel.com/
>>>> Cc: David Daney <ddaney@caviumnetworks.com>
>>>> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>>>> Cc: linux-ide@vger.kernel.org
>>>
>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>>    Oops, replied from a wrong account... :-/
>>    Damien, please let me know if you need this fixed...
> 
> Nope. That is fine. A review is a review :)
> I can fix it with your usual email if you prefer though.

   Well, the OMP's address is correct and listed in MAINTAINERS. It's the address
I replied from that was wrong. Some pepole (like GregKH) want From: and SoB to match...

MBR, Sergey
