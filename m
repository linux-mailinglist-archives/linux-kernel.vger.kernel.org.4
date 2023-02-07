Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD1E68DE72
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjBGRDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjBGRDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:03:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AD92720;
        Tue,  7 Feb 2023 09:03:35 -0800 (PST)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C934660208F;
        Tue,  7 Feb 2023 17:03:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675789413;
        bh=wXQQ9hKZcEEkrcDxicfFkwdm2d8cPyM0mRqhWTqAu6Y=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=N0cro9P2kAQnSsWLmuFFbK3gcDv0FZGpHvAI+aLTLUDMBB68kJrNayxCDhdlMmZz+
         yWCnkvqvSJKpky5rK2mwNKhHpEZzpFnpErscf4Yf0hC0deRzrz6x0d7K+aqvvmM9JX
         I5UunF0z12QtQUXu6KZoKF13rI9PUF/2uqN8LzwrzNh6TlRMzQ8LZEtEWv4eR8cXxT
         YrqLDoeFglAsx8Knhlgx5NCLPQclycuSG0rbHv+MA0oegwT52QEz4d0kfNMD/3nWKx
         hsY9NTzq8cN8Zz03fGGkU7Iz4OQ38hiCJw72phfM5rgmDXUNRwfS258FHjLSwTVN86
         kt+EUCcTrwRTw==
Message-ID: <e8aa571a-2d96-47da-34f0-47cc048dc655@collabora.com>
Date:   Tue, 7 Feb 2023 17:03:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   lucas.tanure@collabora.com
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] Documentation: cs35l41: Shared boost properties
References: <20230207104021.2842-1-lucas.tanure@collabora.com>
 <20230207104021.2842-3-lucas.tanure@collabora.com>
 <44faeca1-94c9-4423-d87a-03d80e286812@linaro.org>
 <e7257f9a-86c5-74e8-c538-6f6d2ba13274@collabora.com>
 <44c7274f-8a5e-0235-413a-6c3260018601@linaro.org>
 <4efe9796-6d3e-09d1-d5f7-cfb25a439061@collabora.com>
 <56ce2617-4fd1-d597-a4dc-918654cdd3f6@linaro.org>
In-Reply-To: <56ce2617-4fd1-d597-a4dc-918654cdd3f6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 4:48 PM, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> On 07/02/2023 17:34, Lucas Tanure wrote:
> > On 07-02-2023 16:13, Krzysztof Kozlowski wrote:
> >> On 07/02/2023 16:46, Lucas Tanure wrote:
> >>>>> +      Shared boost allows two amplifiers to share a single boost circuit by
> >>>>> +      communicating on the MDSYNC bus. The passive amplifier does not control
> >>>>> +      the boost and receives data from the active amplifier. GPIO1 should be
> >>>>> +      configured for Sync when shared boost is used. Shared boost is not
> >>>>> +      compatible with External boost. Active amplifier requires
> >>>>> +      boost-peak-milliamp, boost-ind-nanohenry and boost-cap-microfarad.
> >>>>>           0 = Internal Boost
> >>>>>           1 = External Boost
> >>>>> +      2 = Reserved
> >>>>
> >>>> How binding can be reserved? For what and why? Drop. 2 is shared active,
> >>>> 3 is shared passive.
> >>> 2 Is shared boost without VSPK switch, a mode not supported for new
> >>> system designs. But there is laptops using it, so we need to keep
> >>> supporting in the driver.
> >>
> >> That's not the answer. 2 is nothing here, so it cannot be reserved.
> >> Aren't you mixing now some register value with bindings?
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >>
> > I have added a new patch with propper documentation.
> > And I would like to use 3 and 4 for shared boost as
> > CS35L41_EXT_BOOST_NO_VSPK_SWITCH already exist as 2 and is used in the
> > current driver.
> 
> I don't see CS35L41_EXT_BOOST_NO_VSPK_SWITCH in the bindings.
> 
> > The laptop that uses CS35L41_EXT_BOOST_NO_VSPK_SWITCH doesn't have the
> > property "cirrus,boost-type", but to make everything consistent I would
> > prefer to use 3 and 4 for the new boost types.
> > Is that ok with you?
> 
> I don't see how it is related. The value does not exist, so whether
> laptop has that property or not, is not really related, right?
> 
> Best regards,
> Krzysztof
> 
> 
The value does exist in the code, but no device should have that in ACPI/DTB, so yes the value doesn't exist for ACPI/DTB purposes.
I can change CS35L41_EXT_BOOST_NO_VSPK_SWITCH to another value, like 99, and use 2 and 3 for shared boost.
I will re-submit that with v3.
Is that ok with you?

Thanks
Lucas

