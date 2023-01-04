Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F335F65DBF7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbjADSP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjADSP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:15:26 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7697183B5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:15:25 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id f184so13112580vkh.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 10:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rr+CgNoV15xVUb1LBo4KkMmrUfW168Mgu739TvL181g=;
        b=HbPE8d5liDaWlzhv98ShL6Syf8CAHYuTkOuxU2C0x92Rg4DBBL6+OWmNNKTI4pSIYe
         C1RgEjn2Rjz5O5LF7Bp3gRm3Kgki9TibF3GpRKOVlM2AyHxwuIJV+nT1WyLjIZwG36Ay
         YMZb8aXXLVJEJj0Q2/vs9gZJ0gjbOKLKFnKyfsyxNcRdtkQMW7hlHdG0ONIjtMOE+FKZ
         Er6BaWV3LkvLkH80pC+i16eypYmH0EQjed3ErsFI7IlfbQ6RGBg9Dt3VNom1C0rVG7B3
         /yFQVMtbCdNuKwiC3P/G2aPoDcG4QJ/4RFJAasRxUHsl9taDB36MIdB4c0LsvAaU0uOv
         zhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rr+CgNoV15xVUb1LBo4KkMmrUfW168Mgu739TvL181g=;
        b=JOtnyK9y20/cruMQBeKFS54PU+5MLQL3WDLIC/8rGSBiH7Lf4yOd9G3n5RDeKG6UMP
         zZb3rSz4LJute6TYd9fh7VNg0lpAtseThmWEpx2RBGquAKrFGxlwTbj+zws7y6x8Yloy
         gr5EUQ+y8VHhrZ8kFIjhz01vyuK6LF8o8JAjKch0+JmkcTtPnob1QElP/ngtzSo//aHY
         6qbSQMj8s/ZCSSPFmVescBqyTn3n81D/MbGwOIsveH4pkY+FsL6d6C1iDyESX8o1n47P
         D8gWhgaANKqraQBUCyT8vWw5/fvaNu312tpPw730QhEoDGm7c810M0KFfWeQ6GJn/Zot
         M73Q==
X-Gm-Message-State: AFqh2krrksRHYTWOEU63OllXBJEBHD/CwhICkZQcNWnRx6AZ0d1NdNMv
        vFwihggMF5tzQYOWYSW3Wt7ASlpdra4=
X-Google-Smtp-Source: AMrXdXs8E7jniy6EfahzbnYsicWINbAhiaI6bmqQdsJxTE6VgSmBDrIUUO6f72qMuf1UFcSMenLSoQ==
X-Received: by 2002:a1f:3813:0:b0:3bd:488c:fd1c with SMTP id f19-20020a1f3813000000b003bd488cfd1cmr22428226vka.13.1672856124740;
        Wed, 04 Jan 2023 10:15:24 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id de10-20020a05620a370a00b00704c6263924sm24204321qkb.13.2023.01.04.10.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 10:15:24 -0800 (PST)
Message-ID: <b400f4dc-56ec-fb54-93aa-240c9ea62078@gmail.com>
Date:   Wed, 4 Jan 2023 10:15:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] coredump: Fix a compilation issue with
 CONFIG_VLYNQ_DEBUG=y
Content-Language: en-US
To:     xurui <xurui@kylinos.cn>
Cc:     trivial@kernel.org, linux-kernel@vger.kernel.org
References: <20230104073809.1095521-1-xurui@kylinos.cn>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230104073809.1095521-1-xurui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/23 23:38, xurui wrote:
> A compilation issue occurred when CONFIG_VLYNQ_DEBUG is set:
> drivers/vlynq/vlynq.c:82:13: error: ‘vlynq_dump_mem’ defined but not used [-Werror=unused-function]
> drivers/vlynq/vlynq.c:68:13: error: ‘vlynq_dump_regs’ defined but not used [-Werror=unused-function]
> 
> Signed-off-by: xurui <xurui@kylinos.cn>

The subject should be: vlynq: Fix a compilation with 
CONFIG_VLYNQ_DEBUG=y. I could fix that up while applying this for you.
-- 
Florian

