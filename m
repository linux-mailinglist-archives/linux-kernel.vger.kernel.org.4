Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4A2734C18
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjFSHHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjFSHGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:06:53 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9064EF4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:06:47 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-62ffb475be0so24671356d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687158406; x=1689750406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dcTIqLIrua8hUl7qFCty01+sqrygibJSr+cgV/uyuBw=;
        b=dhuj1G9ObbXiG8050tPrdfQogQjjGBCjgGWWCY2x530e8Ay1zXlUQ8DDxjIie1LtKc
         Jv+oXz31qvZBIu+QG41NtOlvcnswKyey1TP0JnQmAUD51XyVGUrZZ1RSlhFR/wpC5xSR
         +RtYIDqCye0KoMcoA5cvInToWee+J21nju4E8xZW5nvNVJp7isHcXS0+Ypm7J+tClf/r
         l7V20IXfwOqDmiXeHvNrPd6LHlBa0grI0peVs4d042H5ufvVK5CCnf3X/tmWUsx5FTFk
         ygdW2kEqoa/pwu9BLcf2y2MNVRCToHYtCX1wHO9jCSc8tpG3ptVVNFaYJ/cSsBftzdkd
         dfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687158406; x=1689750406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcTIqLIrua8hUl7qFCty01+sqrygibJSr+cgV/uyuBw=;
        b=bgzAyIu2UpQRtDqilbwUg6Xut7f8rfacehwDhcmZIf1jGRN0yP+SbN5L9NvXyLRi5Z
         zGsuF9MqKn4pqZuZc+tjd+pXR//1e8n/5wJYwHZFTt7Exf5CUMfnwvNP7S8hPeZ3hyL+
         23df6CEe6LIv7wQDhsBW6nBTCB1yfl9YXGgvHk9f4HXs0du9GvyZt4Mnic1RHtTvjqkh
         wObIu6vd0J9dfVS/yWEzgtn0h57VpWEkxpr5KdV624VJy6GXgtD60vJqa49Stsa1Ign8
         tt1C/f5cv+s9jYFEWJAHeaOfVe3MnaHNtCh5S+aW+NkKSyfo2Pl1eoG92Q5bJNwxdyDB
         8fIA==
X-Gm-Message-State: AC+VfDydqdTgFxWNvBjTcXm69ke1Haz2f3UpPS4q8L1s9aRzKItXsCVM
        WJ7/MQmJMgcrNsPeqfuQK1R3NswC/Nj92qlrYUjUMQ==
X-Google-Smtp-Source: ACHHUZ7ARWKm7YbwsnITsOzf+lnhod/hZznhV/zMYXwxum5FRhi4/yDyXvrkpBtio2s1NxOqSjn8qkY0L4ih+hjaw4Y=
X-Received: by 2002:a05:6214:2302:b0:628:74d6:ba89 with SMTP id
 gc2-20020a056214230200b0062874d6ba89mr9134579qvb.60.1687158406629; Mon, 19
 Jun 2023 00:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230602161246.1855448-1-amit.pundir@linaro.org>
 <358c69ad-fa8a-7386-fe75-92369883ee48@leemhuis.info> <0f6c9dcb-b7f6-fff9-6bed-f4585ea8e487@linaro.org>
 <CAMi1Hd3Cv1i06NhpY6Jqu7OvMpOdzTj6nTEMJNWLrMwMLsugZA@mail.gmail.com>
 <CAMi1Hd0=KV7k82ARadF45nqX+Cv6zPLCxfDvOyAPeXiFd8jpVA@mail.gmail.com>
 <0ec6c988-d678-c96c-a7a2-af38e6701404@linaro.org> <CAMi1Hd33_Ccxkf9C5_QBO3tvOZcGnYh+_CKcACUtoY2qAuOzRA@mail.gmail.com>
 <12d6b687-5e5a-bd7c-ff5c-007a74753edb@linaro.org> <CAMi1Hd2H2aA6EYp5-46dWe0eu0_hAWUumoQbnk7WR0q9bhppog@mail.gmail.com>
 <fbe5138f-fe97-11ee-a14a-4bb447c0972a@linaro.org>
In-Reply-To: <fbe5138f-fe97-11ee-a14a-4bb447c0972a@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Mon, 19 Jun 2023 12:36:10 +0530
Message-ID: <CAMi1Hd2dO9WSfRQxZLhiyTjFrC_mX6ej9Q=u=Rd1XgRd5AU=jA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Move LVS regulator nodes up
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2023 at 12:51, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/06/2023 19:09, Amit Pundir wrote:
> > Hi,
> >
> > On Fri, 16 Jun 2023 at 13:57, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >>
> >> So you have interconnect as module - this is not a supported setup. It
> >> might work with if all the modules are loaded very early or might not.
> >> Pinctrl is another driver which should be built-in.
> >>
> >> With your defconfig I see regular issue - console and system dies
> >> because of lack of interconnects, most likely. I don't see your WARNs -
> >> I just see usual hang.
> >>
> >> See:
> >> https://lore.kernel.org/all/20221021032702.1340963-1-krzysztof.kozlowski@linaro.org/
> >>
> >> If you want them to really be modules, then you need to fix all the
> >> dependencies (SOFTDEP?), probe ordering glitches. It's not a problem of
> >> DTS. Just because something can be built as module, does not mean it
> >> will work. We don't test it, we don't work with them as modules.
> >
> > I do somewhat agree with most of your arguments but not this one. If a
> > driver doesn't work as a module then it shouldn't be allowed to build
> > as a module.
>
> Of course you are right. That's why I am pushing against blindly adding
> "tristate" by everyone working on GKI. Because such folks like to make
> them tristate, but not actually test it or work on issues later.
>
> That's exactly the case from Google and Samsung patches here:
> https://lore.kernel.org/all/ac328b6a-a8e2-873d-4015-814cb4f5588e@canonical.com/
> and in previous submissions.
>
> > I took a quick look at the history of the interconnect
> > driver and it is tristate from the beginning. And not converted to a
> > modular build later-on like some of the other drivers to support GKI.
>
> OK, maybe it was never actually tested. Or maybe some versions were
> working on boards where debug serial does not have interconnect, but new
> chips just followed the pattern without testing?
> >
> >>
> >> It's kind of the same as here:
> >> https://lore.kernel.org/all/ac328b6a-a8e2-873d-4015-814cb4f5588e@canonical.com/
> >>
> >> I understand that we might have here regression, if these were working
> >> as modules, but I don't think we ever really committed to it. We can as
> >> well make it non-module to solve the regression.
> >
> > Sure. But since v6.4 is around the corner, can we merge this
> > workaround for now, while a proper fix is being worked upon.
>
> DTS workaround? No. I don't agree. Once it is merged it will not be fixed.
>
> I am perfectly fine though with making the interconnect or even rpmh
> regulator bool instead of tristate.

As Doug also mentioned in one of his earlier emails, this workaround
is only limited to one particular board. If I try to change the common
interconnect and/or rpmh driver then it will need ack from other stake
holders as well and I'll most likely get more pushback from that side.

Regards,
Amit Pundir
