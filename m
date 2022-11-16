Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879EA62CE85
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiKPXHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbiKPXHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:07:32 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDB1627F0;
        Wed, 16 Nov 2022 15:07:29 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6FDCF320030E;
        Wed, 16 Nov 2022 18:07:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 16 Nov 2022 18:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1668640048; x=
        1668726448; bh=CTK8JJ2X3iARzZavmcqrT5kZXZiFN9cO54tuAX+WwP0=; b=w
        MjxU47ygntfL2uLwwO96KHj2ryftnccEek0ic33VGITOu2YAygihCctuZfDCj/ve
        OX/+wmdTQfGjTfJrWzLYI/DFBWYKYTT4CZ3//7Pi+Hy+q1+6MDU5EZEtU4LAIRdx
        1EhdFZxcgv9mu7NhOtvV0+Ot4e1RfeoyNyCdFbDzN6g/YeXGxSJ6nQ2vNaIV35pt
        UYX9BOi+1UB9hoF9ylrov0gKCo6QmNO+xapUmEgFQkjrzpnFp3KgnVE1h12cptU6
        Oq4edlJqZdyUYLC8TDXAtDDusBg2Bv750F0XuaSeHjdJVj/WOqD6DLAvqgLTL+nd
        mfk8IBU5jZx2HlLzJPl3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668640048; x=
        1668726448; bh=CTK8JJ2X3iARzZavmcqrT5kZXZiFN9cO54tuAX+WwP0=; b=f
        PLm5UKpuoPZTMhzVLI2cGmO4u00ugA5fqPkREuBvzgGNeeKVSFD1urbhD23WiBWJ
        8mrh4gWYSTGnBl1em5zbEeHrBfe/mRYQeRbDdW/SApUMofCyvLzqLcMEfsmNsK0t
        gh6xj7n+UK+KBbKZenIvpKsJtrzG6FYEBDe9S5uvJjnlxPI/DlDvNdkB6a6GvX1C
        YMCGfvLDSoLmhOGFnSP3Fv0HGuzUMrH9TSKh48Xf98yQEoqbd9fVr+3dQq4IsEGn
        9pewMzMOwpd2sFYC/KqR459nT3TfcQpKtMpSUxym4jSJC+MCTI0JdA/g3nL3p894
        lSioiq+TLU5T1nQd0l83w==
X-ME-Sender: <xms:L211Y9nROomX0u8gAI6k37TFA4uMKnb2wj7yCS9HXFh8oBwUVmIDiA>
    <xme:L211Y41rljCSkGpmAJnH3rtm1jj_aM72az00bINl8pNHaJ5va-oOc8Z01na2bFGDL
    oDAFoIofppvE5LcBw>
X-ME-Received: <xmr:L211YzrRCDh8aU8VtTnpAL4mYVMopvZSB2rXvxWxAk8TJsMsEDZgX5GlC2wl2Qq3VFo4usLLLySACqFGpZVCkMQXaanrY0d57n5QrCLU8h8Tr8BnbvWouUHXqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeejgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
    tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:L211Y9mdFjpKUk-3nCHmOT-pTHvCvdpuUJVnez9o9_-jeKyj1ENm0g>
    <xmx:L211Y73vwfvkEhBNVDdviENT25S5h3dT6zkVXh3Tt5gcTjXfdtKK9Q>
    <xmx:L211Y8t9GdhtnJd7hrgu-_-OdqjUT9xx9_wifMLzT98UN4DBicsxaA>
    <xmx:MG11Y0J81hF7RawiCii8YyDb5A-COHtVK0obJA0dA3mU3mMIphDlbg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Nov 2022 18:07:27 -0500 (EST)
Message-ID: <26d409bb-3936-6458-243e-067b99f76041@sholland.org>
Date:   Wed, 16 Nov 2022 17:07:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h6: Fix Cedrus IOMMU channels
Content-Language: en-US
To:     Jernej Skrabec <jernej.skrabec@gmail.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221116193105.363297-1-jernej.skrabec@gmail.com>
 <20221116193105.363297-3-jernej.skrabec@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221116193105.363297-3-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/22 13:31, Jernej Skrabec wrote:
> Cedrus H6 actually uses two IOMMU channels. During development page
> faults from both were observed. Documentation also lists both of them
> to be connected to Cedrus, but it doesn't make clear which is used for
> what.
> 
> Add second IOMMU channel.
> 
> Fixes: 62a8ccf3a248 ("arm64: dts: allwinner: h6: Fix Cedrus IOMMU usage")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Samuel Holland <samuel@sholland.org>

