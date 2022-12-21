Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD536653441
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 17:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiLUQn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 11:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLUQnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:43:55 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225E41B1C3;
        Wed, 21 Dec 2022 08:43:54 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a19so16271035ljk.0;
        Wed, 21 Dec 2022 08:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oULZCgNbfWj4m4caq/a2lcpegq9TrbPJmjWNoed3b4c=;
        b=ckXHwxcWGvFJKFJLqgwogTI0tRtuokJ4jc0TkxVUcwbJdle/YLQSB+m6Nx7uKmF55t
         OX4N4uD7MSidYOHOFbOj/u7RCpyUJplJcignTSq590QrxQsDQoW+gQigUTm0efCidrol
         ZJmgznmK3zsH5HEjm1aNOYEECaxRAitOT+g3qob14vx8f6BdelScV6dRRPoD4vrLrbyr
         DXTVYHyH/4EhVnmEHY57vxTwLaKmwOM7XlswzKsGP2TmMTyVS6L/4J83GmN0PT0TciO+
         Nd3L4TIVpFq7ix4SyY7RU82XQ+NtzIlgLn3CrFg4Ousfmrg5dSbb1B8mvgwtlPmRjS2W
         n7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oULZCgNbfWj4m4caq/a2lcpegq9TrbPJmjWNoed3b4c=;
        b=b8GHjwtwveeodTL/BTNLWJJ8Eq4HFBLwdzYfKGZrdl7lO0xaC7y0ttjQosKVWFuYg7
         5AsOUWq/+Y5EQ7P6XOu/GTSYNG8JQuyBRkDs10+FgSHv5Y6Uiyou05H+quDhakmU5v9+
         rj9wwn2mGnbnigwvEYs3MVcsSrJty6EsuQ/iLgmIIqoYQmagOwvBlBdoA/x9ZqjCd8OF
         dcOs63QJlwhBnrC9XDypLDQjMjl3NaE7q7+ox5vl30lZLnCdVq11Sp0yrEOcyZ/tdQ7m
         btvUBjTNuASjNDZfouR2SM4Vh4Vgki3ub2DUceL41OHroNcZcfYvzo14LaW5HpnhguN+
         PBew==
X-Gm-Message-State: AFqh2kpmDf/DIRl2/8uHf+/AC2GPQJhHu6YFi8My7SC/7+0b4jnHNGh8
        NESZXTlBsP4QQPea3COBUsc=
X-Google-Smtp-Source: AMrXdXueErfqKFW+4DkNSwLM3/joF4A+AhmFUIqWH4pitUGqS/JT46+9Aan6tuSebT77hEiNlFD75Q==
X-Received: by 2002:a05:651c:19a8:b0:277:edc:d288 with SMTP id bx40-20020a05651c19a800b002770edcd288mr2713181ljb.1.1671641032414;
        Wed, 21 Dec 2022 08:43:52 -0800 (PST)
Received: from [192.168.2.145] (109-252-113-89.nat.spd-mgts.ru. [109.252.113.89])
        by smtp.googlemail.com with ESMTPSA id h3-20020a05651c124300b00279cf45a02asm1382048ljh.132.2022.12.21.08.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 08:43:51 -0800 (PST)
Message-ID: <d2c4c6fc-c432-d122-1e90-3e3ef96eed72@gmail.com>
Date:   Wed, 21 Dec 2022 19:43:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 01/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        krzysztof.kozlowski@linaro.org, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, rafael@kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-2-sumitg@nvidia.com>
 <4d562b75-854d-1997-8969-e7ef222e4e37@gmail.com>
 <298fcaca-c708-5d68-95d6-51673f7a2174@nvidia.com>
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <298fcaca-c708-5d68-95d6-51673f7a2174@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.12.2022 12:35, Sumit Gupta пишет:
> 
> 
> On 20/12/22 23:40, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 20.12.2022 19:02, Sumit Gupta пишет:
>>> +static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32
>>> *avg, u32 *peak)
>>> +{
>>> +     *avg = 0;
>>> +     *peak = 0;
>>> +
>>> +     return 0;
>>> +}
>>
>> Looks wrong, you should add ICC support to all the drivers first and
>> only then enable ICC. I think you added this init_bw() to work around
>> the fact that ICC isn't supported by T234 drivers.
> 
> If get_bw hook is not added then max freq is set due to 'INT_MAX' below.
> 
>  void icc_node_add(struct icc_node *node, struct icc_provider *provider)
>  {
>    ....
>    /* get the initial bandwidth values and sync them with hardware */
>    if (provider->get_bw) {
>          provider->get_bw(node, &node->init_avg, &node->init_peak);
>    } else {
>          node->init_avg = INT_MAX;
>          node->init_peak = INT_MAX;
>  }
> 
> So, will have to add the empty functions at least.
> 
>  static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32 *avg,
> u32 *peak)
>  {
> -       *avg = 0;
> -       *peak = 0;
> -
>         return 0;
>  }
> 
> Support to all the client drivers can't be added at once as there are
> many drivers all with different requirements and handling. This patch
> series is the beginning to add the basic interconnect support in new
> Tegra SoC's. Support for more clients will be added later one by one or
> in batch.

This means that bandwidth management isn't working properly. You should
leave the freq to INT_MAX and fix the missing integer overflows in the
code if any, or read out the BW from FW.

Once you'll enable ICC for all drivers, it will start working.

