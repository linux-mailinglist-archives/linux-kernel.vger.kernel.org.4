Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848836C2D46
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjCUI6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCUI5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:57:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC2C4740B;
        Tue, 21 Mar 2023 01:56:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 13C3666030D5;
        Tue, 21 Mar 2023 08:55:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679388939;
        bh=0ekjo5nMc8NxHpvolEsvhky3PM6gq3HIZIVq67wsqrA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TlSedSI7TwYWON33HGI22cJ3b9NT1kNDMPLt/7jwSvxu1yymyMCtzV0csrbZ9HjBQ
         lODVQ7mBB4G6NWNFX9IEUcwrv560Je2K/o91drzoXNQMhUrlURIMmaG8PUoXMF/Ryi
         bxV3zIJCnpOlC0hf3Z/ZzUyHq0HqSUe+f351Lu/yTlH0EiVel0fhyveGkKQw/+jTn4
         N66Zz6ZaYzusNuYOjfj3FPo6b8vFFbseM0//jucfSOoJBQ3qPPlgcLKl4F/S1jxHRB
         6q7/L7qMarMwGwOOBibGCSR8Mhbhhq8lYYH4NunGm90ggjHsjw0p9hl7uQ/flC3v0K
         kLXNxdh0zJ2JA==
Message-ID: <98c0a46d-05da-7863-1a30-51727c20da23@collabora.com>
Date:   Tue, 21 Mar 2023 09:55:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] clk: mediatek: Remove unused configs with
 COMMON_CLK_MT6765 prefix
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230321042641.21592-1-lukas.bulwahn@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230321042641.21592-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/03/23 05:26, Lukas Bulwahn ha scritto:
> Commit 1aca9939bf72 ("clk: mediatek: Add MT6765 clock support") adds
> fourteen configs with COMMON_CLK_MT6765 prefix, but only uses seven of them
> to configure inclusion of drivers.
> 
> Remove the seven unused COMMON_CLK_MT6765 configs.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Please add the required Fixes tag (you even reference the commit to fix already!),
then you'll get my R-b at v2 :-)

Regards,
Angelo


