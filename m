Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B1B6336E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiKVIUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiKVIUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:20:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CE425C5F;
        Tue, 22 Nov 2022 00:20:32 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9D7562D9;
        Tue, 22 Nov 2022 09:20:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669105230;
        bh=LbhkI5gTxUpZ5zOH7qkzXvnWyaWWN/TtRQOMEKSf+Ek=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BIn+/o9sLB4fhpniMBPR5FGDY6rMZv8mtuV3Zhg9sZYYRJC43TVHcxpbcR1B3ecSo
         MPTi0cfj4bWfL6C6lh4e5h8RJV+bEkmqIxqzyQYjCNpGZR6cfhcJc5+N3O7d9k3Lc7
         veSkg2Un1xdQOnXuaM/p7zpM694sNw7KVlv1ix7I=
Message-ID: <f5df3cb8-d315-b06b-aa04-f0b4af64a1c2@ideasonboard.com>
Date:   Tue, 22 Nov 2022 10:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/8] dt-bindings: display: bridge: renesas,dsi-csi2-tx:
 Add r8a779g0
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
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
References: <20221117122547.809644-1-tomi.valkeinen@ideasonboard.com>
 <20221117122547.809644-3-tomi.valkeinen@ideasonboard.com>
 <CAMuHMdWUvLzCtFRXvUpCxczpkpaunb==gjBMwdniXY4UBVuMUw@mail.gmail.com>
Content-Language: en-US
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <CAMuHMdWUvLzCtFRXvUpCxczpkpaunb==gjBMwdniXY4UBVuMUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 17:14, Geert Uytterhoeven wrote:
> Hi Tomi,
> 
> On Thu, Nov 17, 2022 at 1:26 PM Tomi Valkeinen
> <tomi.valkeinen@ideasonboard.com> wrote:
>> From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>>
>> Extend the Renesas DSI display bindings to support the r8a779g0 V4H.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>> ---
>>   .../bindings/display/bridge/renesas,dsi-csi2-tx.yaml           | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
>> index afeeb967393d..bc3101f77e5a 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
>> +++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
>> @@ -11,13 +11,14 @@ maintainers:
>>
>>   description: |
>>     This binding describes the MIPI DSI/CSI-2 encoder embedded in the Renesas
>> -  R-Car V3U SoC. The encoder can operate in either DSI or CSI-2 mode, with up
>> +  R-Car V3U/V4H SoC. The encoder can operate in either DSI or CSI-2 mode, with up
> 
> Perhaps "R-Car Gen4 SoCs", so we stay within 80 chars, and don't have
> to update this when the next member of the family is around the block?

Is V3U gen 4? Or do you mean "R-Car V3U and Gen 4 SoCs"?

> Is there anything that might be SoC-specific?
> If not, perhaps the time is ripe for a family-specific compatible value?

At least v3u and v4h DSIs are slightly different. Well, the DSI IP block 
itself looks the same, but the PLL and PHY are different.

  Tomi

