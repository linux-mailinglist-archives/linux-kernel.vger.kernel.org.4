Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A21A7122BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbjEZIyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242730AbjEZIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:54:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0981189
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:54:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30ab87a1897so241245f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685091246; x=1687683246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=euKZ+WSAhXyrVn0AyoceS6rsEoXdp7CnlhslJOnii3c=;
        b=4Mm7af47pTxR8J3orNP08NtPkDhpbxyDPcERzqr+7U/N9u+uMixl2dJYKKbuHTmR86
         v+NDc0vAa6NNFOVw9ScYMGioN8DydRKZet4zZpk1nABJI/PzJUJYmzc8VyZ4sk+cdY9k
         JrI/McdCRlBbQ4IBhRNJTN7gx1AnDEPBuMmc/6F5+TQe2F1k5hHesJ4mwbQ3EzHwulUM
         9jCKozEpuyi5ofzSyhMQ2skTuXInpgS48bPPKQKdCnYCm/MFtiWZtT467tQkswk5Zm2R
         LSOgP+ah4r5PtfHCF7IGnCUE5ef/rDost6+fU+ioS34Z1vl8fbABqWdc5Z1zA2y6Kr94
         IrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685091246; x=1687683246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euKZ+WSAhXyrVn0AyoceS6rsEoXdp7CnlhslJOnii3c=;
        b=NaalmqSQuo2TTojgIVFmIC75UNA/71vEBHiv8u3QykxPoY9yfPVjH1rQMy+AgDxsr5
         6EPR2O8p3WweVvJGmwzfFEqUPAZqC/cAq6F8r7oLdSY6jg2nzfCpgIW8+udyB2T/hMzf
         iYzPIMw4AUkiK/7OwW7dNu+rsNk0TE6Rhn0HYYhPbN1kfL6JssrIk9KO6cQMEiBRvuvk
         tpZbexWUy8Mh9zMo+eFzSG2mbVn9Pu4Ep/pyJrww9cLzkzbYn6UaHw8qTtfwwQWDiRVU
         5TnSHYNAsd5EpG8p87o/qv81SYmbJu5sI4r3RxYYcGS7sntKzc8/aESY3tSYyu6F8Rzf
         jtDg==
X-Gm-Message-State: AC+VfDyBAa1wvdc5L2v2X4aRHzvT1//IC88Hn5dpM9HYLmsKMkJhnNDp
        8Cr5Tr9v9AYOW8HeE1iQr5rfXA==
X-Google-Smtp-Source: ACHHUZ7d59AY8hMyzp5lhJ8jqZmAoLniSNjqiPcXwIZvvpqz+lxlM0eOFDwJJVHGsHbG8WD1qsPlyQ==
X-Received: by 2002:a05:6000:9:b0:306:4125:5f61 with SMTP id h9-20020a056000000900b0030641255f61mr971698wrx.44.1685091246156;
        Fri, 26 May 2023 01:54:06 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id l21-20020a1c7915000000b003f603b8eb5asm4564045wme.7.2023.05.26.01.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 01:54:05 -0700 (PDT)
Message-ID: <c1e706f3-9d80-3dd5-eeab-c24830f9ef03@baylibre.com>
Date:   Fri, 26 May 2023 10:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: mediatek: replace unusable
 clock
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230517-fix-clk-index-v2-0-1b686cefcb7e@baylibre.com>
 <20230517-fix-clk-index-v2-1-1b686cefcb7e@baylibre.com>
 <20230525-snuggle-twine-ed1bfc2aee51@spud>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230525-snuggle-twine-ed1bfc2aee51@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2023 19:51, Conor Dooley wrote:
> On Thu, May 25, 2023 at 04:50:27PM +0200, Alexandre Mergnat wrote:
>> The “mcu_pm_bclk_ck_cg” clock is used by co-processors and should not be
>> added to the kernel driver, otherwise the CPU just halt and the board is
>> rebooted by the wathdog.
>>
>> Instead, add the "aes_top0_bclk_ck_cg" missing clock to prevent
>> re-shuffling index and then preserve the ABI.
> 
> How does this preserve the ABI exactly? Please describe exactly what you
> mean by that.

I mean that reduce the impact of the change compared to the v1 where 
I've changed the index of the following defines to be clean.

> Also, what about any other users of these definitions, outside of Linux?

The clock driver and bindings are only a couple of kernel versions old, 
I'm pretty sure no one is using it. Also, if someone use 
CLK_IFR_MCU_PM_BK define, I'm wondering how his CPU is working since 
Mediatek told me that shouldn't be used, and after some try, I confirm.

I've a question: If something is wrong in the binding, you don't fix it 
to avoid ABI change ?

TBH, I just try to clean the binding. I can fix the driver index issue 
(patch 2/2) without fixing the binding if you prefer. But IMHO, keep an 
unusable define isn't great...

-- 
Regards,
Alexandre

