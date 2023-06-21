Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE13738217
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjFUJnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjFUJnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:43:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2C9BC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:42:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so12716163a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687340576; x=1689932576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z5GBcmLnyO9lS4NBr/8rAccCIiKtu5RR66Ulq/RkkiE=;
        b=EouuDPxL4n9lFO0cBiaRzm24jdgt8Emsx7GfOcSfY2YFPsMJosdkWq9hlFPRuOn3He
         w8nioFV+AlRQ2LvHIraP/glAQq8e0GYoiIYjamoYGmn5dFCuWtU49aUtrmqIUDh4jD3u
         xfnKQgjeIg8TfhWl2xv32/X9+C8P9S5eqrNfG9RppPcMM+n1NvUA7RtQYF2yD0dJCk9c
         5jESXhsd+yX6jZ55IoEFveSuMpoEoccgvaPC9DJY9KA5P5SwQVNi/fvLLPHqDR22xbar
         4YNrJeBg/ojC8fi7wqJYNqZlve7kITWALxlASb+3UGAedc8dD8kyfvU7e1Zprkjo5PSW
         02Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687340576; x=1689932576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5GBcmLnyO9lS4NBr/8rAccCIiKtu5RR66Ulq/RkkiE=;
        b=kZpQGD8VTIzwyzfzIF07hZpbnKJ1tP7/6b5hh6yc9yjNIEXZIAoMfWhhqTtTLycMdi
         cjpB5LHCW1Lh2OmNqVscKNRuSVlRbJtFm6yvwCe6Ctmmch7Ao6RKosajom/JVR8rbdEu
         xWdbXBFVxJVtjBqDz7l7Y/TTTQCOXpq+Z39bhGE+SUQoZpMS/YeI2mUFz3Y+tinwLRWj
         tZP3Q6mW8rsCHzI/irKsAh/Go8SRfYda66P0mx687eAB0Y/r1OiDEQ1id09dqeRng19p
         WYa8T3msMpN6QdAj9sFXrRqnQr/o+xZbUtF3rDploAdag+RdyzyCFupzz0jC1QMjupyO
         Q1pA==
X-Gm-Message-State: AC+VfDwzn0efRlTmVi6tjax9eeX9ISavdDeSH+sfqkTVn+T8UCTGlQiu
        U+91D0wqCxAkVHCIUrmd0KxeVw==
X-Google-Smtp-Source: ACHHUZ5iOhly3GaJctJp5PPZl6BWmLQfk2mo+Y68nqZxEzWI8KUTqCHxqDZrW0/HUoNmJ0E4OEPQLg==
X-Received: by 2002:a05:6402:270d:b0:51a:4451:564d with SMTP id y13-20020a056402270d00b0051a4451564dmr11134073edd.18.1687340576011;
        Wed, 21 Jun 2023 02:42:56 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id f10-20020a50ee8a000000b0051823c1a10bsm2340226edr.54.2023.06.21.02.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 02:42:55 -0700 (PDT)
Message-ID: <a6bcad96-6d77-b50a-6b69-5fb6757b424f@baylibre.com>
Date:   Wed, 21 Jun 2023 11:42:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] linux-firmware: update firmware for MT7921 WiFi
 device
Content-Language: en-US
To:     Deren Wu <Deren.Wu@mediatek.com>, jwboyer@kernel.org,
        dwmw2@infradead.org, ben@decadent.org.uk,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        linux-firmware <linux-firmware@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5d30a2ec441a1364a2548c007a94f6f3337b6eb0.1685603641.git.deren.wu@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <5d30a2ec441a1364a2548c007a94f6f3337b6eb0.1685603641.git.deren.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 09:36, Deren Wu wrote:
> Update binary firmware for MT7921 WiFi devices
> 
> File: mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin
> Version: 20230526130917a
> File: mediatek/WIFI_RAM_CODE_MT7961_1.bin
> Version: 20230526130958

Hi Deren,

Can you provide details (fix, improvement, new feature) for these 
updated binaries please ?

-- 
Regards,
Alexandre

