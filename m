Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451C16F390F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 22:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjEAURU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 16:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEAURS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 16:17:18 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6D910F8;
        Mon,  1 May 2023 13:17:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BFC6B426E1;
        Mon,  1 May 2023 20:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1682972234;
        bh=uKSNjoWR62IesN09W0W5izEEL9wBxHLTpo5DpHXnyDo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lS2wxGL2s0hO8Q/ngJw91j8PNukyIUEuxJD4i4MROKEYYBb69yB+LyA59TDnXjFoB
         RI9fTeB0GHVusEXQMjNRzHQ6ddTm4HmZT57UIdPZD8W+/CmnTJJpZ78o+qhMiaup6U
         WmI8nISvY29/sW0nxeKDFzmvmYmhXZI5KiKgKt1XfmW/MgicUUY7YXTGAuitHOY9+a
         Jj9CckpukZGu54o3Lj025ywoqoiejTVhB3RXqbWwlZMQoBRFueAegF62O9Gi+VbaR4
         qERtK/QdiLm86oCcu26/ggyFkE/531xdbPrRKyPxHcR3eh1qPc2aHkDy1T+1Dg7FzK
         IJHg3ULEhFrrA==
Message-ID: <fe2dc70b-915c-ca2b-be81-a8ee66cf41cd@asahilina.net>
Date:   Tue, 2 May 2023 05:17:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Almeida <daniel.almeida@collabora.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com,
        Sakari Ailus <sakari.ailus@iki.fi>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
 <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <20230426003210.GA31260@pendragon.ideasonboard.com>
 <CANiq72nLtpOn2HcOneoQ6v_TcYAEj_W8z2HCQvF4HmB4+OoSZA@mail.gmail.com>
 <20230426163512.GE18120@pendragon.ideasonboard.com>
 <7b4ea4fc-7d73-d229-4645-366b1ea574fb@collabora.com>
 <20230426172539.GD2326@pendragon.ideasonboard.com>
 <9cf10a4d7a9eec237f5d18f79f6ae4bd031489bb.camel@collabora.com>
Content-Language: en-US
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <9cf10a4d7a9eec237f5d18f79f6ae4bd031489bb.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 05.10, Nicolas Dufresne wrote:
> Le mercredi 26 avril 2023 à 20:25 +0300, Laurent Pinchart a écrit :
>> Hi Daniel,
>>
>> On Wed, Apr 26, 2023 at 06:14:33PM +0100, Daniel Almeida wrote:
>>> Hi,
>>>
>>> As I said higher up on this thread, I can maintain the Rust bits and
>>> help out with the issues around it.
>>>
>>> IMHO, we should at least try this. Who knows, it might work out :)
>>>
>>> Laurent, maybe we can take a piecemeal approach? Right now there are no
>>> bindings for MC, but I wouldn't complain about fixing some of the C code
>>> when the time comes.
>>
>> The lifetime issues affect plain V4L2 video nodes too I'm afraid :-)
> 
> Everything under the bindings is unsafe code, so it does not prevent doing upper
> implementation and have other things be memory safe. It just make Rust less
> helpful in some cases (I guess everything across ops).
> 
> There is low hanging fruit if some folks are interested. I see legitimate
> benefit in rewriting in rust the JPEG parser, the H.264 reference list
> generator, and maybe VP9 probability update lib. AV1 driver will need a lib to
> reduce duplicates, this could be done straight in Rust (offering a C interface
> of course, so it does not matter if the users are written in rust or C).

Unfortunately I don't think actually replacing the C implementations 
will be possible until Rust architecture support is on par with C, which 
probably means waiting until gccrs is ready...

We could have both implementations until then (and only use the C one 
where Rust doesn't work), but the code duplication has an extra 
maintenance cost so it's not free. That's why people are mostly focusing 
on drivers first instead of core code.

~~ Lina

