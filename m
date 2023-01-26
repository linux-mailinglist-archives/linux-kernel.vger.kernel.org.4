Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA17D67CAD4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbjAZMXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjAZMXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:23:00 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CD11A97E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:22:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h12so1570689wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9jCz8bwI5R+LQKVyG5YB8yhLEVXKjuwf/nVOd+B04Jw=;
        b=IbkRAASlFsaYc62Nt/6beskwtWXG2NfZ7awVSs47E9IGwdyP1x+OtreME+vVLF5X1M
         IdCYtdJZuM8vrss97L+UnsmcWBkxoPkETqkatwl3Aavg/ezq1ndECOchyS0Is/NJIlGN
         tEk0mvwSxPVVaQyB5dK/pQd5ffbckyxPIr8XcanOQcKTvEishFqB3SzECyCGHXiz4fDx
         IJRIG9eVxgmppOUb7LWV/QG1DL/07/Cxe4gKigXZzka9mn6TjOnI8StUsjEWkBVdN5mI
         PnjKiRAnKjjRJFOaU2n/9BGOy0wm1q3eZg9VO2P3RrkX2Q2hTcSYxpLSpXegvgEhPtsN
         +QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jCz8bwI5R+LQKVyG5YB8yhLEVXKjuwf/nVOd+B04Jw=;
        b=ftvUfiOtvGmXVpZrkPdLu5fvc3xFe9l13K6K4cEJpkdsgUDapdVmcSK7PVUhkr2QtA
         7VCglMQQAgKwLco234f8HNAuslfQBmZJwbZ8BDmWOvz9x9pLp1nJ8zb9jyAy1C+/E/9f
         JuFnsM7gMJCXMvm3h6lpMaa4O36/2JrUWH2dJ049XN7URM6w77fZXDRqbUwd5GN5EdgH
         bXEqityoEe0DW363aUt3YLFQ2VD7wDhjOEHBIc9g2uW6uexpecr7EAjRnG776peSvL4h
         jJUDEuOG5jL9X74nRWnt/CyW1MWCdsKA52qWZ5BY/4MOirdmnBt6jIJUqRe8hMW00GSn
         uAYg==
X-Gm-Message-State: AFqh2krTdfbeu6Yu6Ha/yT32i+NYW99x/EgCWdl8wjERlkETuD77Tja6
        9770aB8sl50KvxrURr4CjDGEIlOL8c6Vk0jN
X-Google-Smtp-Source: AMrXdXvuKEX1GUGVtQAv3Ko7/x0Bcn30b3FvII6BuHI99hRl10j2heoqamHq8cyNF9Vg7swYnAXoNA==
X-Received: by 2002:a5d:6202:0:b0:2bd:bb5f:6a9f with SMTP id y2-20020a5d6202000000b002bdbb5f6a9fmr29136888wru.67.1674735777007;
        Thu, 26 Jan 2023 04:22:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b002bdd8f12effsm1196384wrt.30.2023.01.26.04.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 04:22:56 -0800 (PST)
Message-ID: <0807a4ab-c544-2695-67d4-df9a3b1de4cf@linaro.org>
Date:   Thu, 26 Jan 2023 13:22:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 0/6] ARM: dts: add mmc aliases for Exynos devices
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230126103828.481441-1-henrik@grimler.se>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126103828.481441-1-henrik@grimler.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 11:38, Henrik Grimler wrote:
> It is convenient to have fixed mmcblk numbering of the eMMC and
> sdcard, and with these aliases all Exynos 4 and 5 devices (and
> probably Exynos 3, but I do not have one of those boards so cannot
> verify) will have the eMMC as mmc0 and sdcard as mmc2.
> 
> I also removed sdhc aliases, as they should not be needed after [1] as
> I understand it.
> 
> [1] https://lkml.kernel.org/lkml/20211124184603.3897245-1-john@metanate.com/

Marek sent the same in the past:
https://lore.kernel.org/all/?q=%22exynos%3A+Use+fixed+index+for+the+MMC+devices%22

The patches are fine for me except, that these actually do not belong to
DTSI. Aliases for board or user-exposable interfaces are actually board
specific and each board should customize the ones it uses.

Best regards,
Krzysztof

