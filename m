Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5126165B059
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjABLNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjABLNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:13:47 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F2D62D7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:13:47 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 2046A32008FC;
        Mon,  2 Jan 2023 06:13:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 02 Jan 2023 06:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672658025; x=1672744425; bh=AeCxzdEEDX
        jsBxrZ1LBS601ThZjz/mppC452AduVDQA=; b=XYYjydhSD7SEVV8fomPxX4DGgB
        coW2BPhbN1WaJuTwfphNSoij6BgiV331j8h7FaeY2jI/S9aH9V7MkoM4rZTeVPqc
        9T2rKkcTwEDrsu5p7X866NOHSN5PkfqLfIbt8SuASbOaWjvZkHpT+LlJCSd+sqlw
        8l5atpjoL4MAMiIY0yzrpDefPcI79dQJMkGJA8XxRl3XLFxLlVr459QWi1EAgoGZ
        eTTqXELUiph8BqWe9cTNzOBy5RnyyPDLX6XoZ9APgaRftXH1ncwb1WE0SK+LYUkG
        DJtFHI8D1lSpyL/+dCYeHltkBw7IAOaVJzl49qTAaJhWb1gu7kfFXPDmUSaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672658025; x=
        1672744425; bh=AeCxzdEEDXjsBxrZ1LBS601ThZjz/mppC452AduVDQA=; b=M
        FaytC+s6K5DUgqnI86Da9oEjmhms6gV5ELE/1vcy8XT751voH80wF/BYu5l7+PfK
        9/gLrau3k6DTOeIhcbdoC0loEO9jORp89UyR0IyQSsCEZBbyBJ/KGSoKM4Tgm++h
        XOnYDAbHquukWRwHbhsORlcexDk8lQ5GzIMO7flXLdiHAyy8EP3DTyaoaAVeAZza
        N9bgN/hFsbyyv6BmelIP9i9SjY9/SRr/TQER3FBXaP7pX9EKGK/M0BWcvvEGsDMb
        v2Eg+VaxLf4U6E3nC6uRukrbjBGSHvJyICRrFLSPEmUAzJYdMW/iu4botavSgLqj
        PZgn5wWBK7xg6NqvXMbGw==
X-ME-Sender: <xms:abyyYwYksfDkdpGjQr9goDw_CxQztD9EE7J9d_4UVIjrq-gb3ZhI6A>
    <xme:abyyY7bWR1MTkiarCHjpUZWHXZRzsX_inRTNHxmrAHveP4nMDvejKS0_DJgdfqKb-
    d_MiOGjcjuToiE0_Q>
X-ME-Received: <xmr:abyyY69Hpru1k2QirWoIMB9X2fXNq2U1h9Mb4n6VhSZ1RReYDU7xkm0ZBPLMBAwq2qEMWm_tz-onbCjMLD-cS-ct>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedvgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepvfhomhcu
    hfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhkqe
    enucggtffrrghtthgvrhhnpeefgfekteduffeiudegfeejfefgvddufefhvedukeeiffdu
    gfeludfhhefgvdegffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:abyyY6ora2bXoGXBGGv1d2UetLqwfW2ndeIFTPh3r1wya0jI56PujA>
    <xmx:abyyY7oX2M2yc5dUxrqho_kx5QiFPd2m-m7PKygEsRvQY3T_AoCZLw>
    <xmx:abyyY4TSsXYLw9b9WZfzbC0STdDvsqtMfv82XFqMUwCD-ydl9d9X3Q>
    <xmx:abyyY-2Kqn3BR9T06RyovQfUjJ6xfuhgy34NOcwMmxwIZJe-79zZNw>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 06:13:43 -0500 (EST)
Message-ID: <aef7295e-264c-4812-06f5-b8f7a8339ed9@tom-fitzhenry.me.uk>
Date:   Mon, 2 Jan 2023 22:13:41 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mfd: rk808: re-add rk808-clkout to RK818
To:     neil.armstrong@linaro.org, Lee Jones <lee@kernel.org>
Cc:     Ondrej Jirman <megi@xff.cz>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Martijn Braam <martijn@brixit.nl>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221228140708.26431-1-tom@tom-fitzhenry.me.uk>
 <3f40e58a-dcd2-7c9a-1a9d-cae36719352f@linaro.org>
Content-Language: en-US
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <3f40e58a-dcd2-7c9a-1a9d-cae36719352f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/23 21:06, Neil Armstrong wrote:
> On 28/12/2022 15:07, Tom Fitzhenry wrote:
>> Fixes RK818 (e.g. on Pinephone Pro) to register its clock, without which
>> dependent devices (e.g. wifi/BT, via sdio-wifi-pwrseq) fail to probe.
>>
>> This line was removed in commit 3633daacea2e
>> ("mfd: rk808: Permit having multiple PMIC instances"), but only from 
>> RK818.
>>
>> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
>> ---
>>   drivers/mfd/rk808.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
>> index f44fc3f080a8..0f22ef61e817 100644
>> --- a/drivers/mfd/rk808.c
>> +++ b/drivers/mfd/rk808.c
>> @@ -189,6 +189,7 @@ static const struct mfd_cell rk817s[] = {
>>   };
>>   static const struct mfd_cell rk818s[] = {
>> +    { .name = "rk808-clkout", .id = PLATFORM_DEVID_NONE, },
>>       { .name = "rk808-regulator", .id = PLATFORM_DEVID_NONE, },
>>       {
>>           .name = "rk808-rtc",
>>
>> base-commit: c76083fac3bae1a87ae3d005b5cb1cbc761e31d5
> 
> Sorry, my bad...

No worries!

> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks, I have added this to the v2 patch.
