Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9555F225A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJBJfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 05:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJBJfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:35:21 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240B93335A;
        Sun,  2 Oct 2022 02:35:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0647C32008FB;
        Sun,  2 Oct 2022 05:35:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 02 Oct 2022 05:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664703318; x=1664789718; bh=8bchpnxrRv
        N9buSlyqfr4HeiutePi3l9kvoIge3/5PY=; b=dDhvCkoqtZCQBzGCDjC/eYRBJb
        zSSvtZZeFA8gC+59LKsZMNoXk7PcK3Qo+9ds9euiayM3r2C4HiPstBM88vyoCOQ9
        0R4aUcA7uDBvvqaZQeWvHRYXlX7A0ycgSt5RophRm5kY1F7Xd/+kSvs/o7hUpfe4
        xBgu+s2Ckx4V6Eeol9xgdnjAmS8EeY00cpgmkoa9YBEDEeGs8rdEabjb+G0KrIzd
        jUhe8yxoBUNaDOzaWlUJ6kgg7tA7kFKpasH7zKjgV1//wOG5GD1P1pA5NMaObLRV
        NLFVP5pm2bQ86z1tffth55CrLKCPtztIpZ227EwCVfiYhEixxTtolgFfjIFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1664703318; x=
        1664789718; bh=8bchpnxrRvN9buSlyqfr4HeiutePi3l9kvoIge3/5PY=; b=C
        /vYuHvEpEQwfv1nSs2bnlIFAjWjJruQWzGRVtlaLj14ecZ8Gbb/05jNGIvF2omPA
        3ePGn4RgIpXcB0Ip1mwro38MQuZ0WUF2qGzhetGsmDuf1U9ZnQWshVmL1/1hAY6c
        hmVJ4acsMEINHIKA28NtlzAEy73UZQ3B1VpWwqAZq4Eqrgb/XwzfzwOdno4jNSMM
        Ub96dBAy3++C6KeDKjMRtecHKUa6uJFSqA1z+SHQ4Fg6Av5+J59tqbTHmFeZRAgO
        DTXvmvEYjOsZ79c1ogRgJ8KbDqDi9ORUY4rSKh90R6Eapuz1J6ZXCLhLkrcXSbt7
        cCe1VqsnD5oTkajSdID1Q==
X-ME-Sender: <xms:Vls5Y8WeCAQXx1yGLRraHSkcGDtu4dMEFh5iHYmR-mSu7uo2Se-Qnw>
    <xme:Vls5Ywm04vGiEqBgJyOHxlLHqUopouNr3N8RDsdo1wk2N_Jgci9_BGGdgArdAgeR7
    Nb27GoqHtR4o6o7Gw>
X-ME-Received: <xmr:Vls5YwYW82jGR1EBOsOGkn9o4BkM9N6GrX8mupy6LD0pzAIa4EYviCjg8AwPCZAZOn7wzEIX59IWxpJp8PjsrIJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehjedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefvohhm
    ucfhihhtiihhvghnrhihuceothhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukh
    eqnecuggftrfgrthhtvghrnhepfefgkeetudffiedugeefjeefgfdvudefhfevudekieff
    udfgleduhfehgfdvgeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepthhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:Vls5Y7Uwtdsq9PkUYBIjz2KDRpB3Lg6yjAYsiNHiwN55k8FbIbzv4Q>
    <xmx:Vls5Y2kfCG9U_blE311z6fVxT4fn1XnKfBJW4xD3KRimpwdI_QLvmA>
    <xmx:Vls5YwdSYBZs_QQJGZtgpfMxAzgRO0HYSsEFvTOAWw09hQQhQ_ywXA>
    <xmx:Vls5Y4f02ngk-cZ5dMzif0_SiGngN_7hqirBN476PMEKtSe2wdSrKw>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Oct 2022 05:35:15 -0400 (EDT)
Message-ID: <5ba8f523-dc55-1f12-729e-c65d741c4175@tom-fitzhenry.me.uk>
Date:   Sun, 2 Oct 2022 20:35:14 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] arm64: dts: rockchip: add BT/wifi nodes to Pinephone Pro
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <kc@postmarketos.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <Rk3c--Dksit7gaQSddtVEaF5_7FlNYE4KZKQKaLsRu2GXMXoBgp5C2DSPNublHMr6E135nPS2B9JkQyf6aSZjw==@protonmail.internalid>
 <20220906124713.1683587-1-tom@tom-fitzhenry.me.uk>
 <57395b20-6352-8414-3078-cdad6bbbe999@postmarketos.org>
 <46977559.XUcTiDjVJD@diego>
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <46977559.XUcTiDjVJD@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Caleb and Heiko,

Thank you for your reviews.

On 7/9/22 18:26, Heiko Stübner wrote:
>>> +	/* Power sequence for SDIO WiFi module */
>>
>> This comment isn't needed, instead give the node a better name/label
>>> +	sdio_pwrseq: sdio-pwrseq {
>>
>> 	wifi_pwrseq: sdio-pwrseq-wifi {
> 
> I guess, I'd move the components around a tiny bit and go with
> 
> 	wifi_pwrseq: sdio-wifi-pwrseq {
> 
> So far everywhere the "-pwrseq" is at the end and while I don't
> think that this is enforced (yet), keeping some sort of consistency
> might be nice :-)

Done. I have applied this in v2.
