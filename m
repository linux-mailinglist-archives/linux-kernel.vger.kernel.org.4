Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DA46C8D62
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjCYLSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYLSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:18:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0232E659D;
        Sat, 25 Mar 2023 04:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FF53B802BE;
        Sat, 25 Mar 2023 11:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB7CC433EF;
        Sat, 25 Mar 2023 11:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679743124;
        bh=wxR3HOqBzxOvg0529IlVC3xYSTh7632t2Azg94CMxqs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=q4mRCtBJG9R5U1Uu7MAm4519YvotBhL0T15GxEXeJTTv42Q3H8BHhi2Zx6Bsn8A4/
         /uzgBoHEVO3xNGCotrThDUH8bSsHzPam1MQ93L5fBfBZCq/k+rGj4d2NZpe4DdOy3Y
         ilxIPGf40TVN2Gv7XJW7a0oK8JP8ofWdXl05/IkAvf7WzW4RghYsL//glx6+eWtGKB
         lwxSOJQcW6/t4u2A3X7zNp4vPC49RkcB8xi8stysXGQZO1R0KiIuuM70Kn2SI+74qP
         kyvi/qOtIum1HE49+8B7IwNj1pwIpjZlsaSnnbqUQBfCRcaLTN70Y25dA81Mm9Byzb
         631bixTDVuTBg==
Message-ID: <9c1e61b3-b2f6-67d2-f1e7-5343b1b7db80@kernel.org>
Date:   Sat, 25 Mar 2023 12:18:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: media: gpio-ir-receiver: Document
 wakeup-souce property
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ravi Kumar V <kumarrav@codeaurora.org>,
        "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthew Lear <matthew.lear@broadcom.com>
References: <20230324203833.3540187-1-f.fainelli@gmail.com>
 <20230324203833.3540187-2-f.fainelli@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230324203833.3540187-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 21:38, Florian Fainelli wrote:
> The GPIO IR receiver can be used as a wake-up source for the system,
> document that.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

