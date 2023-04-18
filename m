Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C40E6E5EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjDRK0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjDRKZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:25:32 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FA89779
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:25:18 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v10so8639268wmn.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681813517; x=1684405517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HRqUGTAUT3kQ+E6yNjWLD4fpiwu8oVq8M4urP2QVpno=;
        b=o2vFL8/ONjowdEfYbIyg6ASxTZ8DpDZrhA56l/nuCEIaWBSnH8fFn5Ar867nK4DrIS
         poVNqXS5Ib0b4eiCogZ5qviwEKwXDxNcVLXgNWgjgwroUN1ILZl6T3OyKrJba6JDTPWk
         QQhUb3Ta+zN/NVn19mrhREL7cOFEuNJkb69t1LIFCJUAWuzn7qv6A8e0ChA3xNiiNhTC
         RqAGa1ZhsQbuK/InYOAjMQI5IgOAL4UGRyb3g2M0mHXDhlKI3LDPpg82N4rls0rgP8RO
         ez3Uem+kWUMuWNkzCK6rYeb89rgM6X3thHmh3ggIXRn/jJHcoF+XfZJRr+nRyLoBLj2H
         qZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681813517; x=1684405517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRqUGTAUT3kQ+E6yNjWLD4fpiwu8oVq8M4urP2QVpno=;
        b=SRHBaMHuhaqIqYOG7Pub0SVupVuMIEv5tm3O4p9Cm4Ri2WSdbDSpDbzEYRGfIOvXSD
         tUsFL19iVReNhiO1kdDPye5x2wdbt5Krxap2Qlix5SZRvGBwUoyIRaiyt0hIq2rEV/n4
         G3D3WCfY27joZxcez+wDofJDbpusmqa7InBW0PemkHKzoVE4eE4v4v0GPU/Vx1XEIwbb
         dqr5rtC0ap3JxVtA0oadSZ/Ej0lYF7kLUUwhHMCZaJHO9p/qJSYKzKPjEVuJjkRk2kRQ
         Kc/aGaxW8DQNdoxpOCb65pNUvj3tpSXlEn6pu8Z369u4dSCKnVFdKVlORr8YsRvKcbv2
         CJVA==
X-Gm-Message-State: AAQBX9cIF0rMPB0bB7wiy9TrBQwZGQOtm4uXpSSLoNTl5V4gBP6BQ8oh
        BY0SAlyR2OrWoOvLlnSjZlyF1w==
X-Google-Smtp-Source: AKy350bDXZYjCfKhVSKYmNNuhmjzU+SC1gQXyto6PuTk5yAclQsn9JdMOQN+bjGZbtBsW3b3Vkhpmg==
X-Received: by 2002:a05:600c:364a:b0:3f1:7bb5:9d77 with SMTP id y10-20020a05600c364a00b003f17bb59d77mr248059wmq.38.1681813517389;
        Tue, 18 Apr 2023 03:25:17 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.230])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c155000b003f177cda5ebsm2423589wmg.33.2023.04.18.03.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 03:25:16 -0700 (PDT)
Message-ID: <0f769bb7-ed66-8399-657a-b0dd39334722@linaro.org>
Date:   Tue, 18 Apr 2023 11:25:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mtd: spi-nor: spansion: Rename method to
 cypress_nor_get_page_size
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     tkuw584924@gmail.com, Takahiro.Kuwano@infineon.com,
        pratyush@kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230405060456.48986-1-tudor.ambarus@linaro.org>
 <736b881c4dd3d0fb0522ab0d385798f5@walle.cc>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <736b881c4dd3d0fb0522ab0d385798f5@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/23 10:29, Michael Walle wrote:
> Am 2023-04-05 08:04, schrieb Tudor Ambarus:
>> The method queries SPINOR_REG_CYPRESS_CFR3V to determine the page size.
>> Rename the method accordingly, s/set/get.
> 
> I'm not sure about this one. There is also a
> cypress_nor_set_addr_mode_nbytes() which queries the flash and
> set the params->addr_nbytes and params->addr_mode_nbytes.
> 
> cypress_nor_set_page_size() also queries the flash and set
> params->page_size.
> 
> Secondly, if this function is called get_page_size() I'd assume it
> doesn't modify anything. But thats not true.
> 

Indeed. Maybe I should have returned the page_size instead or don't
change the name at all. I applied this patch as part of
https://lore.kernel.org/linux-mtd/168093614108.51189.3153773628255664983.b4-ty@linaro.org/

Feel free to send a patch on top of latest spi-nor branch, otherwise
I'll handle it after the merge window.

Cheers,
ta.
