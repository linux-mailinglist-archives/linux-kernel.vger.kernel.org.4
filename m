Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB236444D3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiLFNpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiLFNpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:45:00 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCBA29CA4;
        Tue,  6 Dec 2022 05:44:57 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2A7C5480;
        Tue,  6 Dec 2022 14:44:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1670334296;
        bh=IgFcqzfLNWLI38+FwMXHy3E7Ta2WF4GM2D9w3SZl+g0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rmx/AwY0HLpEMAlnzUGfV8+QIeyAtD5VZcBT9HPrSQHFYXZ6XnIrplTHyBJLhCdsD
         bHjbASatb2+BBxsf4TPhDt5T3TVQsBJsGYFGSXkJlBZD/Vj8Ng/kDhhWMgdyfozDB1
         qdGEnZhAPBVhN6FZET2j1B5qzfPHuuwiL2Qjs/Eg=
Message-ID: <b35d7cf0-99ef-86b7-41b3-0751abd4642a@ideasonboard.com>
Date:   Tue, 6 Dec 2022 15:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 5/7] arm64: dts: renesas: white-hawk-cpu: Add DP output
 support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20221201095631.89448-1-tomi.valkeinen+renesas@ideasonboard.com>
 <20221201095631.89448-6-tomi.valkeinen+renesas@ideasonboard.com>
 <CAMuHMdXXoNq0CxSqPLzZUPdVTNa+6u+DNhbm_pCSQOvTHf3EjQ@mail.gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
In-Reply-To: <CAMuHMdXXoNq0CxSqPLzZUPdVTNa+6u+DNhbm_pCSQOvTHf3EjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 12:10, Geert Uytterhoeven wrote:
> On Thu, Dec 1, 2022 at 10:56 AM Tomi Valkeinen
> <tomi.valkeinen+renesas@ideasonboard.com> wrote:
>>
>> Add DT nodes needed for the mini DP connector. The DP is driven by
>> sn65dsi86, which in turn gets the pixel data from the SoC via DSI.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> (same comments as v2)
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.3, with the mini-dp-con node
> moved up.

Ah, sorry, I had missed this change. I'll update my branch too.

  Tomi

