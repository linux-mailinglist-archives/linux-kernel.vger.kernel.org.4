Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0B3686116
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjBAIBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjBAIBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:01:06 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F56E539AD;
        Wed,  1 Feb 2023 00:01:02 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7C0D63200437;
        Wed,  1 Feb 2023 03:00:58 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute5.internal (MEProxy); Wed, 01 Feb 2023 03:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1675238458; x=1675324858; bh=l/
        3BzUN/nPGqHXKbbNml7J/v+9klO2F0BB1SVEjHdD0=; b=TcYQosYcgJEYnx0flh
        Kr+VTdTsbekdCPb5qMOvj0lLpZqMo9adKCD/j9109RyktZuSqgP/+Mgp7ypZw0GG
        a36zabiFmNBZ+/7yX3QGAVRYPXha9O1fMRJfh+i9KBUEYbtuZpAZsoK8L1m3ALw+
        QqwLQqWAXLyHAKVCDimh3PkfDa2xvaujO3XuTuf09SfdfcFCcS9KSxdpFhcTBCBn
        EzDvphPkVm1rQO2Ps+ZLViBHwxu/MT00cyeKei1S/mj/w9WTfsBuLEtlHtpYpFbs
        uN6M5WiYtsP3BmrUTzshbh4a7Y/ko8q4xSzddgINS4tlHvx8nadOiOE9vV+u83bK
        55qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675238458; x=1675324858; bh=l/3BzUN/nPGqHXKbbNml7J/v+9kl
        O2F0BB1SVEjHdD0=; b=Pi0QV42q24SnfnxzC/EvZlk8+LU9hSzo12TJ+etVHAq4
        Tcws7mD9gY68r4ktdd4rOHOqs3v7Ox5Qc9wu0LKi8e+JhhnEi3pU3pZf9zGod+RQ
        JdKjAWGrsgGsg5IJxsgfSlNvhFHv97Ow+MVcProzhkRSB3HGVZdDqQ9zAnaWJktG
        dmSKf1n0LrcL4PyOzTMdHVHPlwML4K2HG/VNJo63EnPzZyfJchox6kQBT96C7eM5
        cbtvFYhQAUecCWcXeAl6aiihO9qZmr5W/Pb09KM3EZsKs9ewiFG7D1QhphAwdzw3
        vwZlRM5BpTWY7XeRRJCrgUgBRRPQAmNOYI8wkm/XQg==
X-ME-Sender: <xms:ORzaY1gddA0GY9loBdjKmJm-DOfVnbyjkjmnVQclldc09ZJgTRmwmQ>
    <xme:ORzaY6Cq47FLeTLbJcMfpzrMjnA9XRK4Opeq_ekK2Cj0ipSHrBz8LiT0JlfSEJ2uc
    aykabVEmLf_tyCXvhI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefhedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomheptehl
    ihhsthgrihhruceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtf
    frrghtthgvrhhnpeeukeffkefhjeethedtieegudejvedvhfejleekheefhfdufffhjefg
    jeeiheehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:ORzaY1G-G0wKCf4aLw-wEHJfLMIGvBvdmFnGWL4n7HdTkYmRPR85pw>
    <xmx:ORzaY6Q6XEq1jjJylmOCvmREHtFnh9hal3bVJBTNoqO2X9ftwyTGJg>
    <xmx:ORzaYywUaAl-f9cXam1I5H9cQBxaL3eNzS331IyrLE8d0t6eiFnFHw>
    <xmx:OhzaY280mlBZC_Eu5PIu4XBya9O6U8yWFCwV5v4HEOKBGk0cufGXfg>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D37952D40074; Wed,  1 Feb 2023 03:00:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <74450737-fce2-4ba8-b764-ac22c21490ad@app.fastmail.com>
In-Reply-To: <20230127102903.3317089-1-richard.kjerstadius@teledyne.com>
References: <20230127102903.3317089-1-richard.kjerstadius@teledyne.com>
Date:   Wed, 01 Feb 2023 18:00:57 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Richard Kjerstadius" <kjerstadius@gmail.com>,
        linux-input@vger.kernel.org
Cc:     "Richard Kjerstadius" <richard.kjerstadius@teledyne.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] input: cyttsp5: Fix bitmask for touch buttons
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023, at 8:29 PM, Richard Kjerstadius wrote:
> Prior to this patch, the bitmask ends up being 0x3, as opposed to 0x1
> which likely was the intention. The erroneous bit results in the driver
> reporting 2 different button activations in designs with 2 or more
> buttons.
> 
> To detect which button has been pressed, cyttsp5_btn_attention() uses a
> for loop to iterate through the input buffer, while shifting and
> applying a bitmask to determine the state for each button.
> Unfortunately, when the bitmask is 0x3 and there are multiple buttons,
> this procedure falls apart.
> 
> Consider a design with 3 buttons. Pressing the third button will result
> in a call to cyttsp5_btn_attention() with the input buffer containing
> 0x4 (binary 0100). In the first iteration of the for loop cur_btn_state
> will be:
> 
> (0x4 >> 0 * 1) & 0x3 = 0x4 & 0x3 = 0x0
> 
> This is correct. However, in the next iteration this happens:
> 
> (0x4 >> 1 * 1) & 0x3 = 0x2 & 0x3 = 0x2
> 
> Which means that a key event for key 1 is generated, even though it's
> not really active. In the third iteration, the loop detects the button
> that was actually pressed:
> 
> (0x4 >> 2 * 1) & 0x3 = 0x1 & 0x3 = 0x1
> 
> This key event is the only one that should have been detected, but it is
> accompanied by the preceding key. Ensuring the applied mask is 0x1
> solves this problem.
> 
> Signed-off-by: Richard Kjerstadius <richard.kjerstadius@teledyne.com>

Reviewed-by: Alistair Francis <alistair@alistair23.me>

Alistair

> ---
> drivers/input/touchscreen/cyttsp5.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
> index 4a23d6231382..16caffa35dd9 100644
> --- a/drivers/input/touchscreen/cyttsp5.c
> +++ b/drivers/input/touchscreen/cyttsp5.c
> @@ -29,7 +29,7 @@
> #define CY_MAX_INPUT 512
> #define CYTTSP5_PREALLOCATED_CMD_BUFFER 32
> #define CY_BITS_PER_BTN 1
> -#define CY_NUM_BTN_EVENT_ID GENMASK(CY_BITS_PER_BTN, 0)
> +#define CY_NUM_BTN_EVENT_ID GENMASK(CY_BITS_PER_BTN - 1, 0)
>  
> #define MAX_AREA 255
> #define HID_OUTPUT_BL_SOP 0x1
> -- 
> 2.39.0
> 
> 
