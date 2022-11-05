Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F02F61DBBB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiKEPri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKEPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:47:36 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145B2D10B;
        Sat,  5 Nov 2022 08:47:34 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A86EE5C00CE;
        Sat,  5 Nov 2022 11:47:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 05 Nov 2022 11:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1667663252; x=
        1667749652; bh=YL3S4NenSE4TP/W7I52bjSz//ihpV/zOu8M8yMIxby8=; b=K
        CxZLqEnCUL6d6FVeTSTNiWXbKRDHliIGrffvTK1TFYZ9aIwYtF+X7FJGdmNCu3T8
        Qn4oAAVGBicwQNUxnfRd3QsyBgQLMZVYi1K1B4jiQMVsLt+h0B8jSCiKszOzb6oT
        YV0J5DaKFrrM8Y84h756sN946Nh+BMpQExakfbM/PptrNgX5TyfuunSfOeLcGJGe
        SkDQTmAGizlhRuQmzHHr2K2uYF+dpYoHtE7Soe9aAcjRe1RrQduE3KCTgrap72IE
        KZdZUTnQI4UVvG7PtErDk1IljLaDbwJt6xFIt6slBHa9+EScw4sbCqMn6kS9yubx
        k6uplZecOGxpBpJY/Sxig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667663252; x=
        1667749652; bh=YL3S4NenSE4TP/W7I52bjSz//ihpV/zOu8M8yMIxby8=; b=X
        FYljsa//xW4pYNZi8si9BEe6iJifS04iuBY0I0NJVmuznM+xSuCMLEXrCd5Sy21N
        yjgwWeJAvxUApbYFV8WcSucgekxQL4KQ1IQfUYaFstDixZBnLDqHtmbms3foYjmX
        407GHn4gZNeoYTG9PSwjokr765b0Wg8nGN5JIlr6q/9kJan2C1hIdDWjO0BWIgjm
        R/xjdQZjcsN+q7TZHvHHlQEvSlaOkQ8s6zUQmVjywnigrvoftqEwe7M2W351iEBw
        W6XL6tV6dy/Jky3hXQPgr/Wo+jbJzjS1adE9hBJeAw/rZ8jRBnfqAaUiB+siEffN
        snTCUVbnYjL8RMRARy9Jw==
X-ME-Sender: <xms:lIVmY022xeGih54dszIt0gDhfWZ9-1mqv-3YX9F7IEiSgj8IPNjY5Q>
    <xme:lIVmY_Ho6d-pE0DuLoATE7pRYZ0xnsBxnQZljpYlQY3iwbv8qXVpIPjeqlefVjXpt
    EaN6rjttzMltvzxUA>
X-ME-Received: <xmr:lIVmY84MbTEOZN6stCVmLyGuoWSup01TmiZ0rdwVWakJLGKxuiHL5bEMW5KCUOTQkhSeZGjUZinckHtgx47_GiDFds5eCq_ATrJaBoykPI_LtMHMPBZghhEBUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdefgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
    tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:lIVmY93zurtB9kwaf0ek95V1nR36FAmtnkXf7e0KgAbiJcvokUh_4w>
    <xmx:lIVmY3Enspe_EodxmeDEi8W7oCK9yvLvk3fFDksLkbUEXb9B1l8WrA>
    <xmx:lIVmY2_tXIGNcj5WtICOOqiNUyMDMk41jt1d0rzGVm7gZGRuojdvfA>
    <xmx:lIVmY9bE0KsvuVY9LJqtHXh6Fq_OMoo9e8T9m1WAplIr5Zes5BnaPw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Nov 2022 11:47:31 -0400 (EDT)
Message-ID: <b0d317ad-9198-94d5-ecaa-78b8066b5168@sholland.org>
Date:   Sat, 5 Nov 2022 10:47:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/1] arm64: dts: allwinner: a64: enable Bluetooth on
 Pinebook
Content-Language: en-US
To:     Bastian Germann <bage@debian.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221105153319.19345-1-bage@debian.org>
 <20221105153319.19345-2-bage@debian.org>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221105153319.19345-2-bage@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/22 10:33, Bastian Germann wrote:
> From: Vasily Khoruzhick <anarsoul@gmail.com>
> 
> Pinebook has an RTL8723CS WiFi + BT chip. BT is connected to UART1
> and uses PL5 as device wake GPIO and PL6 as host wake GPIO.
> 
> Enable it in the device tree.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Bastian Germann <bage@debian.org>
> ---
>  .../boot/dts/allwinner/sun50i-a64-pinebook.dts     | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Samuel Holland <samuel@sholland.org>

