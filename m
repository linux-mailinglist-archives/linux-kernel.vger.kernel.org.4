Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07C9600901
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJQIpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiJQIox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:44:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F232D1E2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:44:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ot12so23313147ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/OVv+puCl+RQRM9zhQGR8lncVSVca+QHB0gRflBJ//Q=;
        b=i/rUSlQBenPAyfceTiwTGO+jhdjLwzrRYlVwYw9Rw4gSXj4SgptNYbRAkgt3e7Twzn
         FcBl0AvjmtZHC33jiqgiWFpc5YQiKnu5BBtnjcxxPlO8+CkujRDNrTq31P74HCBz8agp
         5u/1chNeuJ1JSJm5mWB/xgZbA2RjdUdxvrKt0UiW7ft14ZS7BeILfawp+UCQvpDy0bX/
         ee4rRi3tISwq9VvSDU/ig1zVdyCF7jshH6jXQQiIx9Fj4R3lIJ7qZWnubzSBWGgkZVZX
         FNXCy/JiRbt5XwfHlDAdajqHfEtw68g17TmzUm8YY/GRTEpwSlr5dqgAGzD89SIqBzh2
         7PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OVv+puCl+RQRM9zhQGR8lncVSVca+QHB0gRflBJ//Q=;
        b=vQmHOItZuCxOdLSOeQZJaf1wFnAiLeRYfB2jjTIYMxBEvpa4Vet2H7dFc/jObHGAmw
         f8ETYTN5Y/tSoldexK/7o0z2awe546wmpR0t4otMnfIcRVVqCUuAgVmHq+HvF/mZkHbO
         S/gXp6E+c8L4w8r4Iyr7Ba5DQkh20uExehkD3JNRPDVQje7wwoknUxITlKLGZuY8YwzB
         b1XKmAgm1mN5EVONIEUAadZsmiFbxsrw06d+fjPPJxEnj9Pv0upuk/dikOUQye57hURC
         r8GvebE34d9HmDNxjrnofZTbaOgFMyhhmz6OIB4OTeQdccF/t2vg7InSWZF2I4kp2U4U
         S2tQ==
X-Gm-Message-State: ACrzQf3Pnm6SQD8k9I+7LrojWFXjwaC7GSC9R1mwQAoYqcnIV65YS9/u
        5C9vMcwBtcBJZzoxuikpP33gF8wj788Pa3vXFwdteRgEzVU=
X-Google-Smtp-Source: AMsMyM49b5U7oAouHD2U0NEtNBrMwVZryMS2GdwJ8IX6bhaC6lAzqvCxAyiBmjd0NxrhR38RYKHh9ezr0bAAXY1w1pA=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr7661722ejc.440.1665996284981; Mon, 17
 Oct 2022 01:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220925021258.1492905-1-yangyingliang@huawei.com>
 <CACRpkdZijkQAT84mfP06SgxBjHmrqSbWwctBBA0pvb_1xYzGvA@mail.gmail.com>
 <CACRpkda6kCL-FbEdfu9msXH6xnLn9fLC-q6hcm=e_H_AT_uVEQ@mail.gmail.com> <ddd58293-0b5b-3c34-c396-0a635444410d@huawei.com>
In-Reply-To: <ddd58293-0b5b-3c34-c396-0a635444410d@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Oct 2022 10:44:33 +0200
Message-ID: <CACRpkdafE7Nrv0YwC2z8PWcUxRUyAjXnoTPsPPLAug-g18XBXw@mail.gmail.com>
Subject: Re: [PATCH -next v3] pinctrl: ocelot: add missing destroy_workqueue()
 in error path in ocelot_pinctrl_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, horatiu.vultur@microchip.com,
        andy.shevchenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 7:54 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> On 2022/10/5 3:57, Linus Walleij wrote:
> > On Tue, Oct 4, 2022 at 1:46 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >> On Sun, Sep 25, 2022 at 4:06 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> >>
> >>> Using devm_add_action_or_reset() to make workqueue device-managed, so it can be
> >>> destroy whenever the driver is unbound.
> >>>
> >>> Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
> >>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> >>> ---
> >>> v3:
> >>>    Using devm_add_action_or_reset().
> >> Patch applied, after deleting the hunks removing .remove because
> >> that was already gone upstream.
> > Ah, the patch introducing that is in the MFD tree is it not?
> >
> > Either ask Lee to apply it or wait until -rc1 it's no big deal
> > anyway. Remind me in two weeks.
>
> It's OK.
>
> Thanks,
> Yang

I rebased my development on v6.1-rc1 now and applied this patch!

Yours,
Linus Walleij
