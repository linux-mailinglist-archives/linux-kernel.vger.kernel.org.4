Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F00F6DF3BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjDLLdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjDLLdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:33:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0724C9764
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:32:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l18so10478271wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681299067; x=1683891067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Z58+wPfvD+p5o+S8VNFwtMScQl8aprQpHWJgZ+U3OU=;
        b=eZkhcF/dOhz0Ckpw8NVz22GvTv1jD58LCeC9mw+5xVc0C/55+80j6Lse/9B0XfQCh1
         ZAz5SyRPfGXPLI2DGYaDdu08TzUKJridhzZ6Siwg5jyiFlWk6zbA4DWSxjAVR/Kqlb8c
         p7lDnz08aHx4hHPqetaMGWEyv12sR9fx/vdagFvXcbQfHaaMPEIYc4/PAOdhJHOaonZ+
         J79ANEk2ue6AmIv7XtfrHpWyuiYuGyf4hLJutlcvDBMA6ofE+1oI+Mrk9jyErOcH8Pk6
         yl0vckOq7JlZlT3g8rtc2u1iQqE49HGcEYwK7L36+3CHB90f0rOi1PU99LFYsR6crJd0
         VABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681299067; x=1683891067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Z58+wPfvD+p5o+S8VNFwtMScQl8aprQpHWJgZ+U3OU=;
        b=i26YwH+NRfhlwFZilF8/tjFGD3g7204roNS7wB9oHEwMkTDyxPT2CY5cmvkiBFWfbc
         c/6CqdCr7iG1uYM2u4VbOZ1isnNkUT8Mbp8o4T/XgA7xXVqoMnf6zOnWGJrju1bmKMIg
         kM/9JZz9tAe1dZMLSbL5c8MysSdZ33gAQ75bdIW8H40Bg6PP0LWuO60ukXjF9gecdsBg
         wGwuewrK6WxwzfeqtKPPFCTSVSHHFZTrawBF6aF4xkQnoWsUP0Yga9Xl61bum2S/7nDV
         n42KKYaTHLnmkBEdh2Nvbih63/7ataUGDxL/ofHx3vHSfbWSha021z/yioIfRtxVsygY
         EMhw==
X-Gm-Message-State: AAQBX9di2SRQGQlapuwBaoIySeXKWKLcjMOejLDpqVE9X+NBXnA0SJaB
        5W6edeCzH/TKU+riaPAxkVSRBA==
X-Google-Smtp-Source: AKy350bIGqULzJb+NuqzNZkYn8IMQuLSq75kr/CLxhxUaQyoTp0R9xpzeez3e/fZqs0Dak6+rMNNDg==
X-Received: by 2002:a05:6000:181:b0:2f0:2de5:c56d with SMTP id p1-20020a056000018100b002f02de5c56dmr9229374wrx.42.1681299067521;
        Wed, 12 Apr 2023 04:31:07 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id z14-20020adfd0ce000000b002c55306f6edsm16935813wrh.54.2023.04.12.04.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 04:31:07 -0700 (PDT)
Message-ID: <d2667a9d-20bf-bda2-9d69-4f5000db1633@baylibre.com>
Date:   Wed, 12 Apr 2023 13:31:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] iio: adc: mt6370: Fix ibus and ibat scaling value of
 some specific vendor ID chips
Content-Language: en-US
To:     ChiaEn Wu <chiaen_wu@richtek.com>, jic23@kernel.org,
        lars@metafoo.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, peterwu.pub@gmail.com,
        cy_huang@richtek.com
References: <1681122862-1994-1-git-send-email-chiaen_wu@richtek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <1681122862-1994-1-git-send-email-chiaen_wu@richtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 12:34, ChiaEn Wu wrote:
> The scale value of ibus and ibat on the datasheet is incorrect due to the
> customer report after the experimentation with some specific vendor ID
> chips.
> 
> Fixes: c1404d1b659f ("iio: adc: mt6370: Add MediaTek MT6370 support")
> Signed-off-by: ChiaEn Wu<chiaen_wu@richtek.com>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

