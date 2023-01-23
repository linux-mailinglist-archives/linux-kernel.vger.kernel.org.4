Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F1B678624
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjAWTUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAWTUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:20:45 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515DB3C3D;
        Mon, 23 Jan 2023 11:20:43 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d16so10651184qtw.8;
        Mon, 23 Jan 2023 11:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFZbbqKBlddq6jCJAYLKtckQtwG+M6V9R/5WjgUkx0k=;
        b=g6qXglWQXc2E8nGog/cEId2wKB5FUNF1Vyh75qmdFsF3UyKzhQbXbPjkQ3JiyQm6qP
         76Sde4yvKuweNc/8A9HBlveFriSX5CK3SdGUnskTw/r3qogw/N1e+vOdI/BbrPhFrv55
         +V67lCueRyVLjCx7+HvyNkMzH3sAHv8gHC+j3H0BB+VeMhFJTlLhxFowkVjBA9Z2ADHd
         EQOn9Oqs9tD7m1KU3qD3cZ/vnzSxrlPEVnFQqLgEoPHF1IqcTnYlXkQdyTdbYt/PIgAG
         OZh31JXWz97/0Gjy9Ik4W3lOfHuUR02qZbuP7ggyxh5zxsppumUkJ0+B45ojXyFBTJ2p
         s0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFZbbqKBlddq6jCJAYLKtckQtwG+M6V9R/5WjgUkx0k=;
        b=vfWereNfEvlfeQaAiTiutX5RaHpGDvwMvgFgtcePlWTLG3a7Ko443i23+72KdNjBY4
         GZkNFCs5uohR9EFmY6UERG9OFAUAb6yelsmlDZFX4GYnsLJLPVvPsidpqzhfRQMyWVUd
         fVe/RdfeUC4omGkkiyXPLkwW3sSW1VTLLlTsXR/ttwdeOjFrQIDHjZ360tGNGpUZYiC5
         0vN0Zr8NDljh0bGfBMEUUXJie8ZT4phmWw6TsNx9PMlYpCZSJFC72Qs1TqdDqC6e8wXe
         ydJ7mmCgVXa5yUlCCEEGXMuU8OOSmobpIFhYEnmXaTLP86wgEgvroGLEd3EbAb8mBsg3
         Mybg==
X-Gm-Message-State: AFqh2koOQ8cuMiT2KLicd03TP+GEFwYSH0C+h9ONVvi4KgAeQJNGVgoD
        Ebi4qjCUljseT2YyXLb2Wp8=
X-Google-Smtp-Source: AMrXdXuA5NaJlPGW88pSVVPK2sCbRXDqEBL3qClA55DAUqbLwR+TX+SPtnfGD41y6XU1UBipmo/R7Q==
X-Received: by 2002:ac8:44c3:0:b0:3b6:2b07:27d8 with SMTP id b3-20020ac844c3000000b003b62b0727d8mr34205706qto.55.1674501642337;
        Mon, 23 Jan 2023 11:20:42 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m20-20020ac866d4000000b003a6a7a20575sm25242724qtp.73.2023.01.23.11.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 11:20:41 -0800 (PST)
Message-ID: <ac04708d-4d51-5090-d8c8-bb7cef0febb4@gmail.com>
Date:   Mon, 23 Jan 2023 11:20:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/6] rtc: brcmstb-waketimer: introduce WKTMR_ALARM_EVENT
 flag
Content-Language: en-US
To:     Doug Berger <opendmb@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230120190147.718976-1-opendmb@gmail.com>
 <20230120190147.718976-2-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230120190147.718976-2-opendmb@gmail.com>
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

On 1/20/23 11:01, Doug Berger wrote:
> This commit defines bit 0 as the bit of interest within the
> BRCMSTB_WKTMR_EVENT register to make the implementation more
> readable.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

