Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF1F7123FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbjEZJrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243128AbjEZJrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:47:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D241E64
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:46:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30a8c4afa46so467548f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685094411; x=1687686411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nat2dXg+UOzIavY+WSMDfeXKleU0IIvcUkgX31+SwQ0=;
        b=QClPu3uwppIpWhb4E3uBUouUHuGMdCDCap+TS3E6hGmLnA4VjA4bKSBHIHelGx0ccW
         FEr0tengi50fv5JkQcvgU1KTRffYujLtgVjvOOvZFIGz7/sclzkeUoKurDBYRU7U4O+E
         SqZapO1awa/OnzqqYNJX4m6EBvNJHwiV0MmIk2Fg6KECJgzQiaRlFOAckqdKWBEhO/rr
         Zw2s3DnpcD0f9Xqt48cK4kdPbfgP6+ls3uZmqN3D0SfZahD/EwRw0v+HDDU6oOj8wjYV
         Acdo8a+1fB2+ZoPrSuE8Lf6gCE7iWPqS8QXsj3t50cBRwpqKw4Lme7PRmLQwPNJLszhT
         KLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685094411; x=1687686411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nat2dXg+UOzIavY+WSMDfeXKleU0IIvcUkgX31+SwQ0=;
        b=SGeGtFKop9ohyCUq22DgcymIGDAcLPvgcH8+Qs0hcQlZdfH+tQYjOZr7f8ZnQgVyhR
         TbdD2h903HDNC/RbhE9TkwJhykckqsIKMrBfdwJwTYC7yRLMqWg92rT3MKu2yvNtjvZa
         QSbTTqY22i8Bh49Wqk1yHXcyLGPtMpOPvjSrvLCJQaIQr8VIS6QpYgSstrdw0dKmDNab
         F4bO600+lMNo7yN1ICTFvOsIibA+lgS+IEiE8FUsTHOj7MWuDmWusetgFosxQzifCEQo
         43PHNdcokfBZ3xmVEoHd4jMXvJ/d5ul0ZcCukZD9k4y39ugS8HUyd2Brn5DxSQL9M9W8
         e2Tw==
X-Gm-Message-State: AC+VfDzuPavyiV6PHEEBoGOyVkBx6mHbr8p7zEbBSrzh7lS64fIkSGxG
        J/Le4pgPKqEG54iD7YZ3BUrMcw==
X-Google-Smtp-Source: ACHHUZ7zzzPEEncZvQtOFznUC+/7QoK+Qxxmiu8AfkXUIs6gj8Ym6jXeyUI0v0C9XmNiOfMiKm+5OQ==
X-Received: by 2002:a5d:5506:0:b0:309:491b:39ca with SMTP id b6-20020a5d5506000000b00309491b39camr1037698wrv.33.1685094410926;
        Fri, 26 May 2023 02:46:50 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id u10-20020a5d514a000000b00307b5376b2csm4463662wrt.90.2023.05.26.02.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 02:46:50 -0700 (PDT)
Message-ID: <160d8ea5-81bd-ece6-a4a6-b93a62b4d749@baylibre.com>
Date:   Fri, 26 May 2023 11:46:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: mediatek: replace unusable
 clock
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230517-fix-clk-index-v2-0-1b686cefcb7e@baylibre.com>
 <20230517-fix-clk-index-v2-1-1b686cefcb7e@baylibre.com>
 <f3f7df94-74f1-dd41-00d7-0ab4fa2e4d61@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <f3f7df94-74f1-dd41-00d7-0ab4fa2e4d61@collabora.com>
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

On 26/05/2023 10:30, AngeloGioacchino Del Regno wrote:
> Il 25/05/23 16:50, Alexandre Mergnat ha scritto:
>> The “mcu_pm_bclk_ck_cg” clock is used by co-processors and should not be
>> added to the kernel driver, otherwise the CPU just halt and the board is
>> rebooted by the wathdog.
>>
>> Instead, add the "aes_top0_bclk_ck_cg" missing clock to prevent
>> re-shuffling index and then preserve the ABI.
> 
> It's still a breakage. Besides, have you tried to add it as 
> CLK_IS_CRITICAL? :-)

As I said to Conor, I can fix the driver index issue (patch 2/2) without 
fixing the binding (using CLK_IGNORE_UNUSED but CLK_IS_CRITICAL works too).

-- 
Regards,
Alexandre

