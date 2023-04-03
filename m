Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390486D551F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 01:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjDCXMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 19:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjDCXMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 19:12:53 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4871BFC;
        Mon,  3 Apr 2023 16:12:52 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 471A185C54;
        Tue,  4 Apr 2023 01:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1680563570;
        bh=ZUetAbCZ5vMdVE5GC+DuXDKD9WMm0kE2HOWJEVcf8cY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pg4jY0CUZUCCXwCPABFCmkrSCPlu4hqHZivTsP6g+CR8k74IUC9oFwkz0xG6p9JFB
         IcWhUah+k9P9OK25G17LrxvsmwvDNUJ82NU5k3Ip1bfBYK67fz9zHTuTG5GRosiXZF
         riQpQR46aEdlmuM2UIS9/ksz3ANXtvLE7dS7BdE8brDJ8r/RSq3gHZP4L8mHOOoK6G
         EpiBZLd5z0MLPiYot3jCzPpQtTFh5K7dZhSXMGPti4jsbsF9Ho4h2JV68INnzyFhL2
         +fs74wls1JdbbaUHixon8HfNSg35fRK5AZ72ImlJ3J2qjCDcl4lK5AOqX51opyMl+8
         eoss+WSv6dDeQ==
Message-ID: <e2b5efc4-1b2d-191f-e4ee-5ad7a64c63cd@denx.de>
Date:   Tue, 4 Apr 2023 01:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/2] dt-bindings: display: bridge: sn65dsi83: Add DSI
 video mode
To:     Francesco Dolcini <francesco@dolcini.it>,
        Rob Herring <robh@kernel.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20230330101752.429804-1-francesco@dolcini.it>
 <20230330101752.429804-2-francesco@dolcini.it>
 <20230403210622.GA1740065-robh@kernel.org>
 <ZCtB8Vu4Brm3G639@francesco-nb.int.toradex.com>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <ZCtB8Vu4Brm3G639@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 23:15, Francesco Dolcini wrote:
> On Mon, Apr 03, 2023 at 04:06:22PM -0500, Rob Herring wrote:
>> On Thu, Mar 30, 2023 at 12:17:51PM +0200, Francesco Dolcini wrote:
>>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>
>>> SN65DSI8[34] device supports burst video mode and non-burst video mode
>>> with sync events or with sync pulses packet transmission as described in
>>> the DSI specification.
>>>
>>> Add property to select the expected mode, this allows for example to
>>> select a mode that is compatible with the DSI host interface.
>>
>> Why does this need to be in DT?
> 
>> The source and sink drivers should know what their capabilities are
>> and pick the best common one.
> 
> Is there a best mode?

I think yes:
Burst (is better than) Sync Events (is better than) Sync Pulses

Burst is most energy efficient, Sync-Pulses is the simplest and least 
energy efficient and with most constraints.

> Isn't this a decision how do we want the 2 peers
> to communicate?

I don't think so, I believe the Host and nearest bridge should be able 
to negotiate their capabilities (mode, link rate, etc.) within the DRM 
subsystem.

> For the MIPI-DSI Linux/DRM experts: am I missing something? Is there
> another way to have a DSI video sink to ask for a specific mode?

I'm afraid this is not implemented yet, so ... plumbing needed.

[...]
