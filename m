Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8336DB95F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjDHHu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDHHu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:50:57 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D83C142;
        Sat,  8 Apr 2023 00:50:55 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 95400403B9;
        Sat,  8 Apr 2023 12:50:53 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1680940253; bh=24srqlrig7Z6+LCxxJMtJVGkp1cP18k/U//f6Z0J2mI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZP024pPQrtFlI6gRj8N5+XqqCRV+h4EaZVykWB8PHf8cFt5dBp3BYDyeyaemRFuxa
         4oq9lW6XpQbxBNNZoLbeHASz1k4XorwQ6VKLJbNzEEr5fkMZ/PoE+woVwigmWkDNWd
         df3fp7tY4uK5Lue68IBTub9a1c7LZ8uwJmM2nWbHVoKyVKk26EVAziJ8Qb7ovViC3+
         mEKESGyZkpVxqxxxMU2ncSweuRYPmWzvddsVilL5+LRRH9Vtnofyl6mHvytc6LTaYG
         qCXekx/hDHvM1meSQaOLo6/oDYtlY1cZO1fmm+EsOFncOM77VeqyLpgQ87cWwtEyBR
         GTAwGrAUDyyKQ==
MIME-Version: 1.0
Date:   Sat, 08 Apr 2023 12:50:52 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Doug Anderson <dianders@chromium.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        quic_srivasam@quicinc.com, judyhsiao@chromium.org,
        mka@chromium.org, cros-qcom-dts-watchers@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: Add Acer Aspire 1
In-Reply-To: <CAD=FV=VR7sKsquE25eF7joc7gPApu-vqwduZzjE=wFCoXjMYnQ@mail.gmail.com>
References: <20230407151423.59993-1-nikita@trvn.ru>
 <20230407151423.59993-5-nikita@trvn.ru>
 <CAD=FV=UCJoz1E4wErJawQjpBRiXw0C0-J4TTWO1+uRiDsdzSUg@mail.gmail.com>
 <499bbd8cb7783b86108f3e6d9cc07a8a@trvn.ru>
 <CAD=FV=VR7sKsquE25eF7joc7gPApu-vqwduZzjE=wFCoXjMYnQ@mail.gmail.com>
Message-ID: <476b27c4a77118837931dc65ab511d75@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Anderson писал(а) 07.04.2023 22:06:
> Hi,
> 
> On Fri, Apr 7, 2023 at 9:46 AM Nikita Travkin <nikita@trvn.ru> wrote:
>>
>> > HPD might very well be hooked up on your board, but the current Linux
>> > ti-sn65dsi86 driver does not look at its own HPD line because it's
>> > actually slower than just pretending that HPD isn't there. On trogdor
>> > boards we ended up routing HPD to a GPIO.
>> >
>>
>> Oh, this makes so much sense then! The line is hooked up on
>> the board indeed and I remember being confused why trogdor boards
>> don't use it.
>>
>> I will try to add the suggestions (annotating the reason)
>> and verify that it works, would prefer the panel power to be
>> gated when possible. I hope this would also fix the initial
>> EDID reading issues I occasionally have and carry a hack for
>> as of now...
>>
>> Thank you a lot for this insight!
>>
>> Nikita
>>
>> > I guess your other option would be to implement HPD support in
>> > ti-sn65dsi86. That would probably be an overall slower boot for you,
>> > but is technically more correct. In the past people have posted up
>> > patches to get ti-sn65dsi86 working as a full DP port and they added
>> > HPD support for that, but none of those patch series ever go to the
>> > point of landing...
> 
> Yeah, see the big comment in ti_sn65dsi86_enable_comms().
> 
> Actually, looking at how the code has evolved in the meantime, you
> could probably get away with:
> 
> 1. Making sure you have an "hpd-absent-delay-ms" in the device tree
> for the panel.
> 
> 2. Implement "wait_hpd_asserted" in ti-sn65dsi86 to simply be a msleep
> with the passed in delay.
> 
> Then I think you don't need "no-hpd" anywhere which keeps the device
> tree pretty.
> 

Yes, implementing a dummy wait_hpd_asserted seems to indeed fix my
issues here. (Can actually see the panel dying for 200ms on boot
due to the violent takeover if the backlight driver was not built
in, so had to change my kernel config a little)

Will have the "hpd-absent-delay-ms" in v6 and submit a driver fix
alongside it.

Thanks!
Nikita

> 
> -Doug
