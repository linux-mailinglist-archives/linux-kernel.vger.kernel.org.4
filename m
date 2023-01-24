Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE5667A625
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjAXWsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjAXWsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:48:09 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4E5F77B;
        Tue, 24 Jan 2023 14:48:08 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c6so16236398pls.4;
        Tue, 24 Jan 2023 14:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljbfFNf3c5+431C9MZedE05IPhLzBlosPA/WbN7IbTw=;
        b=jJPccqomucXFRBgFMNdzPyiA6uAu7e/AyemaVw7i9B0rxK7s+ecKyuIekhaUZS+GWe
         ns42PjDpsPFjiQGgz7oCQ5OszPxJRxMDe8cR82+jrRVDMVQXtlO3Vq8iAIl7pevRutI7
         tOV0KxaynAO8+trfZ1oSWoyvRpnoNteZVuKzifX81JLV+NAqRj5BsjiOpE0kvuaaOS8C
         w51nTJK2ykmpDPEXp7bAMb4tk5MYL9Go3UUj+G1ayOV0UrI2tt6jZRTbop9X9xCjPoWo
         EGYwAachbOrDl2FD0rTtByT3iWICOZ7xFK71fiSKsCX+yS8IKRNQ82qSgvpcW1tu33Sy
         A8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljbfFNf3c5+431C9MZedE05IPhLzBlosPA/WbN7IbTw=;
        b=LeqMP0TEHDKgrx5MmCVWy09ciGu8WYCSeIjh9C5eS3gKLkp+bvtT+SjD8071vXBV5G
         DB0Pmumooe1A3iUrCcreN6L+P5xA2juQlok66q/+Rxfw2ZXDWRAqUA1+fqvDtUhLuKki
         KJKlLqi+x1oVkCAYNTGUQDTgGj52Yughc56gGdmk3POVj47EOsnSknw5Ldmb12pH+r5R
         lYIWaYyrPW/ak1V+gXPw2bux2usUwZj4GiKe37MUFumKtpZiXI/5hVzlb3GuZM2iKu3G
         LvT5UiQ/KT9bWzBDb0oWv/F4Vcb27zGxLnHYIJ4CNn5Bt/jPtVJkZW1QcQkissWfh6Pu
         VxFQ==
X-Gm-Message-State: AFqh2koy6XtoemKZeokdzK1wC7ujEcmcyujISmaBD+k0rlQ+f6e6O3Ie
        mD4aMosR54T+9Y5PeL5Mo5A=
X-Google-Smtp-Source: AMrXdXsd5E1SwCMQBwGNBrFQBZ8UF+tJQ+LrLHkyarMJXuFNuLUgiWm6ZuhPFes9ViE8vfWtmn+3kA==
X-Received: by 2002:a17:90a:1285:b0:229:679b:bf9c with SMTP id g5-20020a17090a128500b00229679bbf9cmr31664481pja.9.1674600488145;
        Tue, 24 Jan 2023 14:48:08 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j3-20020a17090a3e0300b002263faf8431sm63137pjc.17.2023.01.24.14.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 14:48:07 -0800 (PST)
Message-ID: <383503db-c6cd-3b31-4847-f5d0f6a07b04@gmail.com>
Date:   Tue, 24 Jan 2023 14:48:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 06/14] spi: bcm63xx-hsspi: Endianness fix for ARM based
 SoC
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20230124221218.341511-1-william.zhang@broadcom.com>
 <20230124221218.341511-7-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230124221218.341511-7-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 14:12, William Zhang wrote:
> HSSPI controller uses big endian for the opcode in the message to the
> controller ping pong buffer. Use cpu_to_be16 to properly handle the
> endianness for both big and little endian host.
> 
> Fixes: 142168eba9dc ("spi: bcm63xx-hsspi: add bcm63xx HSSPI driver")
> Signed-off-by: Kursad Oney <kursad.oney@broadcom.com>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

