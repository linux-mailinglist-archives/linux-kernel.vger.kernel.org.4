Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0476B745C30
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGCM1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjGCM1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:27:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74208109
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:27:44 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9AF026606F62;
        Mon,  3 Jul 2023 13:27:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688387263;
        bh=IYmaR1gBv2Z6QkDpfBcedcjRv/kOAondXl4MM4fFhuA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=euJkwVk9pVBuvYPXT553LlXbUOV0xnScSibtSeZtd4z3vvdxQqfYaj0nn6j6d6Jd+
         6C4TudC+AKmUpJ0VpLKdNXep6r5kzS70XnpkUO0RhzmOtVwLyIt5WU9LFfrLoKROik
         CMDMlJgC4OYJfZQroYoDW6G/exl2oSTs4ajBCJgHp5jUS6Xt1PKkdsCezh97+4ZViW
         xkAA+v03YAVHKL/so+eOfakM/uvyy/UBioeG1fT5i3YjmaD8oOjsYXLf2QgZppkOHT
         aW/pTKRkG3DgL+NX31ZMt8lx6vqCdfeACC/MbxXOJIE3zrQFPQUlVxfcC6ceW7kUxS
         wDIxUsbdllGaA==
Message-ID: <8b576880-1c78-84d7-ee46-641c65cdf35d@collabora.com>
Date:   Mon, 3 Jul 2023 14:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ASoC: mediatek: mt8188: add constraints for PCM
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <20230629075910.21982-1-trevor.wu@mediatek.com>
 <5995e77b-ea8e-4e88-8ca2-f716df9c9579@sirena.org.uk>
 <0e8b5ca298a01b16da0419928a30af6371e923ca.camel@mediatek.com>
 <6cda3265-7444-46a1-8b2e-75706a839670@sirena.org.uk>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6cda3265-7444-46a1-8b2e-75706a839670@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/06/23 13:00, Mark Brown ha scritto:
> On Fri, Jun 30, 2023 at 05:29:23AM +0000, Trevor Wu (吳文良) wrote:
>> On Thu, 2023-06-29 at 16:06 +0100, Mark Brown wrote:
> 
>>> This commit message isn't entirely clear.  The effect of the commit
>>> is
>>> to restrict the configurations supported when using a nau8825 but
>>> it's
>>> not clear what a nau8825 has to do with this or why we're doing this
>>> in
>>> general.  What exactly do you mean when saying that "only a limited
>>> number of parameters are necessary" and what makes this the case?
> 
>> For instance, some userspace frameworks only support specific sampling
>> rates such as 48kHz on Chromebook, making other parameters unnecessary.
>> By restricting the configuration, unexpected usage can be prevented and
>> the alsa_conformance_test process which checks all parameters provided
>> by an ALSA driver can be sped up.
> 
> That's a userspace policy decision, we shouldn't be enforcing this in
> the kernel - even for Chromebooks people can install other OSs on them
> which may make different decisions, and it's always possible that the
> ChromeOS people might change their mind later.  If they're only
> interested in testing 48kHz and it's slowing things down unreasonably
> to test more then they should just only test 48kHz rather than changing
> the driver to work around it.
> 
>> Would it be more beneficial to establish the criteria as a general rule
>> for this machine driver, while limiting the use of the machine driver
>> solely to the Chromebook project? Or do you just suggest that I add
>> more details in the commit messages?
> 
> I think we just shouldn't do this, it's policy for ChromeOS rather than
> something that's actually needed.  If we were doing this it would need a
> much clearer commit message and we should be restricting things to
> Chromebooks only.

I agree with Mark. Except for me it's not a *should not* but a *shall not*.

Such other configurations are supported by the hardware and it is the driver's
duty to support all of them - otherwise I deem the driver to be *incomplete*.
It's then the userspace's duty to properly use the sound APIs and request the
right sampling rate for specific usecases.

Chromebooks aren't special at all in this regard.

Regards,
Angelo
