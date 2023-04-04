Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820A66D5A7E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjDDIN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjDDINu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:13:50 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B1D271C;
        Tue,  4 Apr 2023 01:13:37 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6C970320091D;
        Tue,  4 Apr 2023 04:13:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 04 Apr 2023 04:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=undef.tools; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680596016; x=1680682416; bh=Tp7vkOp/dRBPmzCPLBDIQLpP/CNY6jKNBGa
        bOjO2c4Q=; b=cM5tsIonRSSfT/eA/CMmsVcDKSwhNqpYL0Y0NrWQYBw4p/OX0eL
        iDbyB910BN0U+bI5mVZeov7NXFuAKzmJrODsqp+KLhVAaBIApVF8cayWoinTZNMw
        4da04eSZlWPlVQLusYN+VnPua0ysWa7tLRZ+bTjBiWJWplE880hH5bm552QysswC
        rrvMY8yHvKNS9wylZHMCwcN/ZtFgNrH0vAUEPdqfrTkTlYUE1LBL+6cGKazJJdrV
        xjKBZQqKXETg9IslXwXged7l81JSDNAACKP237THlB6IfnKPCG7k4b+N34Ga1cQU
        LyTH/BFTlEAYUxi3ANyVOh4I+qs22yOCVkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680596016; x=1680682416; bh=Tp7vkOp/dRBPmzCPLBDIQLpP/CNY6jKNBGa
        bOjO2c4Q=; b=eccndBjgyirL0Fbcfk6U1BZgJZKRUcKfKCvBcO5cfsuwwcKRvO5
        ImO5wqYDG9UKW0AI2XH0TE7imWlbGtuyBoqglpr9+sUYSP5oJoZ2Qc0dvZ4V3F0T
        Rbmk8GpLzIskyOtwNOoZ5a9dJbt/7ZtwvC9PW3nrDy6IXoJyn8sx4/dDxLrSBZ5y
        jnKltJAw+7KLlFZAIOXF4mKGfj0Idc+b9yuaXuR2sQipxR1rmH4HrGoTfT5gRzWU
        qJyTvE+XtfBHM/HORWptvKk7RxcPHS0dNj5hfvZTOqpcExnJKvZmJw/P2RLVSshh
        eLigdoYkHxJ6yF+p5FY9RZ6ycVcJOF5GQGQ==
X-ME-Sender: <xms:L9wrZIsWuJlvPYf4-mCl4kinjJdaXIYXkkW5APRikREjZMyPoPq3aA>
    <xme:L9wrZFeXvHFh7UF_xbd-gaBaegfny8mHBWFA6u4LI9r3lVvQkjgH3JNm3uYnWeviY
    2dviL7m17ZQjJpuJ1c>
X-ME-Received: <xmr:L9wrZDzy2MqUzxNRDzOg6Y_THwoqekykcDZGiDjBQpToPoTq4v4AqRhexPJVfLPIVZKBYnkd81A7kVkTIOsT0gkW2r3ZSECQG6VV8dfqpqRASYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeilecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfgrrhhrrghh
    uceokhgvrhhnvghlsehunhguvghfrdhtohholhhsqeenucggtffrrghtthgvrhhnpeetke
    evgfegudetveeigffhtefhleeugedvieeiuddtfedvkeegieetfeefffeuhfenucffohhm
    rghinhepthhofidqsghoohhtrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsehunhguvghfrdhtohholhhs
X-ME-Proxy: <xmx:L9wrZLN3NOQxdzkpYvgT_7FKOICKDSZvMja4YklKCMYZoZIZioNzoA>
    <xmx:L9wrZI-NKR355ZY7pM8IyOK7LTFfOFaR1Mv_Tr1de6scnwQZj9yVaQ>
    <xmx:L9wrZDVcmsJL0rKvEWOfBr9kXi83HosaxiCIirJh9oHu6hQLQ3PrWg>
    <xmx:MNwrZDXmg4TgFBveXiYkbGYJW0_8xVuSnfkRK_fStULP82-WlR8Otw>
Feedback-ID: id76147eb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 04:13:31 -0400 (EDT)
Message-ID: <d7efebcc-5b5b-185e-bec8-b6b9d5d27d93@undef.tools>
Date:   Tue, 4 Apr 2023 18:13:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20230403175937.2842085-1-javierm@redhat.com>
 <3738011.44csPzL39Z@diego>
Content-Language: en-US
From:   Jarrah <kernel@undef.tools>
In-Reply-To: <3738011.44csPzL39Z@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/4/23 17:51, Heiko Stübner wrote:
> The interesting question is always if this will break someone else's setup.
> I've never really understood the strange setting of 1.5MBps, but on the
> other hand it _is_ a reality on most boards.
>
> Personally I don't care that much either way, but would like a comment
> from the other people working on that device - if possible.


I don't have a strong opinion either way, but I would note that 
Tow-Boot[0] which later models of this device ship with uses 115200, 
meaning that this would put the device out of sync with the default 
u-boot implementation from the factory.

At least for me it's been convenient to have both the PP and PPP use the 
same settings while debugging.


Thanks,

Jarrah.


[0] https://tow-boot.org/

