Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62616D5926
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjDDHG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjDDHGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:06:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942F4268C;
        Tue,  4 Apr 2023 00:06:22 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D4BA76603157;
        Tue,  4 Apr 2023 08:06:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680591980;
        bh=gUi49HxcibXURy7ru7avIXwC6889apHBnBbYdOtrg2k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mcmBCL9ctN+gY4WIy7tzjD50vo57Ignj2I1azKQWs0Q0duZRxhHIgkiGgk4eN8xvh
         4J59+U0pH//LqFqLzlcovuiAWikY9Lpm0HyIrJkNo1Z6nW2HHPXafCgZ600BdgBeCS
         FZTA1FkttFOyqkKuduaXfNV0MtYCqDWWOJ04afN2mQGuYXx2ZgONluHwc8sFWsoZk/
         QGIHt+YEh7B16p7SlH96kMw/+BCtHrs2NfMgV1K5j/4GT+BLHGQpGELuABoOBtJ0gL
         XTM0vXvrnDOHk7xVrIhTNrA5Qgd4zLsOGJA0tUPouIwWsnuIMw6GO2WfetsZf0rR73
         e+bMXGpawGMsA==
Message-ID: <a4385349-1776-85af-5dda-7d846ac2dd18@collabora.com>
Date:   Tue, 4 Apr 2023 10:06:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rk3588-rock-5b: Add pwm-fan
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Chris Morgan <macroalpha82@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20230403105052.426135-1-cristian.ciocaltea@collabora.com>
 <20230403105052.426135-3-cristian.ciocaltea@collabora.com>
 <642b134c.4a0a0220.1d01a.5990@mx.google.com> <4981873.LvFx2qVVIh@diego>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <4981873.LvFx2qVVIh@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 00:55, Heiko Stübner wrote:
> Am Montag, 3. April 2023, 19:56:26 CEST schrieb Chris Morgan:
>> On Mon, Apr 03, 2023 at 01:50:52PM +0300, Cristian Ciocaltea wrote:
>>> Add the necessary DT changes for the Rock 5B board to enable support for
>>> the PWM controlled heat sink fan.
>>
>> Honest question, but should we be adding this to the board file if not
>> every device has a PWM fan (they all have the socket for the fan, but
>> not the fan)? For example I have a passively cooled case that doesn't
>> include a fan.
> 
> We also set up the sdmmc host without knowing if the user will plug in
> an sd-card ;-) .
> 
> So especially in the case where there is a dedicated socket for it,
> as you write, we should definitly add it for the board.
> 
> By the way, am I correct in thinking that patch 1 and 2 are actually
> independent of each other? So I'd just pick patch2 for the Rockchip tree
> (as we do have a text-binding) and you can handle the yaml conversion
> in a followup or whatever?

Yes, the bindings conversion can be handled independently.

Thanks,
Cristian
