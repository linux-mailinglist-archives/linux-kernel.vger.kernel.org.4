Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6501862E049
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbiKQPtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiKQPtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:49:45 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A02C7019A;
        Thu, 17 Nov 2022 07:49:41 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BD412929;
        Thu, 17 Nov 2022 16:49:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668700179;
        bh=dCq7BZPM04IF4OeB3g2d9it3HFFw4GKBrkhYKw2JoRo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IB5dcSr96oKd9sKI0F7g5DLossoqeaf9tf9nTzk42f/d5Eb+BTxPEwRI99NIjQCtZ
         U5SdPo1Z2NG3RYLGpF9KcwnvNf9RYaWt4K5x7qTXmEj2kN1ge4QtUrO/gqes5oQG6r
         0x5PKybo+JmpOk1c9P8gqBYWSqFcUl8hM/M+NtRY=
Message-ID: <8d848493-24a8-4ffb-239e-9e7baa232a42@ideasonboard.com>
Date:   Thu, 17 Nov 2022 17:49:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 7/8] drm: rcar-du: dsi: Add r8A779g0 support
Content-Language: en-US
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
References: <20221117122547.809644-1-tomi.valkeinen@ideasonboard.com>
 <20221117122547.809644-8-tomi.valkeinen@ideasonboard.com>
 <166869996543.50677.17182739414507530884@Monstersaurus>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <166869996543.50677.17182739414507530884@Monstersaurus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 17:46, Kieran Bingham wrote:
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (setup_info->hsfreq <= MHZ(1000))
>> +               ret = WRITE_PHTW(0x01020100, 0x01910170, 0x01020171,
>> +                                0x01110172);
> The <=1Gbps reads:
> 
> <=1Gbps
> 
> Set PHTW=H’01020100
> Set PHTW=H’01010172
> Set PHTW=H’01570170
> Set PHTW=H’01060171
> Set PHTW=H’01110172
> 
> Is it clear why theres a difference here?

What doc is that? Mine (R19UH0172EJ0054 Rev.0.54) says:

Set PHTW=H’01020100
Set PHTW=H’01910170
Set PHTW=H’01020171
Set PHTW=H’01110172

  Tomi

