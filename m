Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41C6733730
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345794AbjFPRK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345304AbjFPRK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:10:26 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B4B1BE5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 10:10:25 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7623bd6933eso17802585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 10:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686935424; x=1689527424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=13Ub72LeNXocacDH8iq4dsRSC3PCfVbZC0BT5ktGknQ=;
        b=K2++xF6Vx0ws0J6uj4X1wisvjM3l1xIveAWOl4e8+ZmaBcxl2KJFMRX1zv2Ry7JpzG
         9+2RZsQY1ijumTVgctdxPIY1c0QMyWbastHlS0wIXF4T2df1S883+ivLHJbbO+WPr6/T
         u1kl9G4+vq+KnRvA6kTpb+e9d26pE90sUOQjvp/OlBAy/CbbHrZ+KTRRPX2x2y3KzkWE
         EpPedQJfPjWcRF5aRfx/5CIvpy1hNquop+wtUSRpk5oWBvzEX5lxD1xIBbQusErwtAq+
         ns64wLHnszc2Q7Smw/uCWh1uRgT4y41L+S95OJXE15WYXJltPvllZ6SroP5bgIwTUPnL
         LsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686935424; x=1689527424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13Ub72LeNXocacDH8iq4dsRSC3PCfVbZC0BT5ktGknQ=;
        b=dcN96Dq3ag3BpvVYP0ekLxbHmRISqqrZT+tUGvdxXL91mbpIEUmFbC/81XUaVzmHMD
         KuiQID0kpDsWTFErPW7Ar8PPNQWO+TGKPbqSsgHbZddwY/hTZOD9Qhrb5iSct+mUEMkz
         5drrWIS7TRsJu521uwDT6KSkiPQCBm7DSXjhRHuaM1hujEd82xKd8RydzldI9bbVWfST
         rn8rGMcF1HVHe4zPng5+CLvo3DOX9IV9DaQyKcNWA8EdHaftTBO4luj1dIgtgLZgB0Y5
         aJUKN8Vay64KWuola5DvX5nQOwW9WDlNn1cej45BB3Na2yrioSggZ9mY2VwXffXlon3G
         bckA==
X-Gm-Message-State: AC+VfDx+gScZUdUTOedIlBdffrcy06o/NOtaQO6pIcmj6ui/zqlVfS0p
        UXfKijsCCdd9KfKvF+YZhRods8Em520juW8mGhKRow==
X-Google-Smtp-Source: ACHHUZ6lpFZ09A9IHX3P4ygHt4+nMALCSy4x/x3LBageSe+7wXjEyTwO2TPHfFUg00vHZLl+yvNChqtDn2H/xoOW7GA=
X-Received: by 2002:a05:6214:1c0a:b0:62d:ddeb:3770 with SMTP id
 u10-20020a0562141c0a00b0062dddeb3770mr8653889qvc.0.1686935424170; Fri, 16 Jun
 2023 10:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230602161246.1855448-1-amit.pundir@linaro.org>
 <358c69ad-fa8a-7386-fe75-92369883ee48@leemhuis.info> <0f6c9dcb-b7f6-fff9-6bed-f4585ea8e487@linaro.org>
 <CAMi1Hd3Cv1i06NhpY6Jqu7OvMpOdzTj6nTEMJNWLrMwMLsugZA@mail.gmail.com>
 <CAMi1Hd0=KV7k82ARadF45nqX+Cv6zPLCxfDvOyAPeXiFd8jpVA@mail.gmail.com>
 <0ec6c988-d678-c96c-a7a2-af38e6701404@linaro.org> <CAMi1Hd33_Ccxkf9C5_QBO3tvOZcGnYh+_CKcACUtoY2qAuOzRA@mail.gmail.com>
 <12d6b687-5e5a-bd7c-ff5c-007a74753edb@linaro.org>
In-Reply-To: <12d6b687-5e5a-bd7c-ff5c-007a74753edb@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Fri, 16 Jun 2023 22:39:47 +0530
Message-ID: <CAMi1Hd2H2aA6EYp5-46dWe0eu0_hAWUumoQbnk7WR0q9bhppog@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 16 Jun 2023 at 13:57, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
>
> So you have interconnect as module - this is not a supported setup. It
> might work with if all the modules are loaded very early or might not.
> Pinctrl is another driver which should be built-in.
>
> With your defconfig I see regular issue - console and system dies
> because of lack of interconnects, most likely. I don't see your WARNs -
> I just see usual hang.
>
> See:
> https://lore.kernel.org/all/20221021032702.1340963-1-krzysztof.kozlowski@linaro.org/
>
> If you want them to really be modules, then you need to fix all the
> dependencies (SOFTDEP?), probe ordering glitches. It's not a problem of
> DTS. Just because something can be built as module, does not mean it
> will work. We don't test it, we don't work with them as modules.

I do somewhat agree with most of your arguments but not this one. If a
driver doesn't work as a module then it shouldn't be allowed to build
as a module. I took a quick look at the history of the interconnect
driver and it is tristate from the beginning. And not converted to a
modular build later-on like some of the other drivers to support GKI.

>
> It's kind of the same as here:
> https://lore.kernel.org/all/ac328b6a-a8e2-873d-4015-814cb4f5588e@canonical.com/
>
> I understand that we might have here regression, if these were working
> as modules, but I don't think we ever really committed to it. We can as
> well make it non-module to solve the regression.

Sure. But since v6.4 is around the corner, can we merge this
workaround for now, while a proper fix is being worked upon.

Regards,
Amit Pundir
