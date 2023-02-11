Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5999069335B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 20:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBKTqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 14:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBKTqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 14:46:32 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B73B1815A;
        Sat, 11 Feb 2023 11:46:31 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gr7so23283988ejb.5;
        Sat, 11 Feb 2023 11:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2AhTCgEyNW01Hpz3xoMcaeloiLVbQZG4MDKBPmxYU6s=;
        b=j0X5ehi1qAfwx88YgGhGEDbyYiu+Rr1ydszKqhaxGYwiDHTtCYroGG0h+JiDG2YKGC
         RyCQd6DVtp1pPQF1BczXRcDR16kC4ytbs6KFJsIAIgtr2RcEvnwzj0TzfXoBGt4jVyUY
         iDroILtZ3OzJvKdSgooY6MZBx7pj3QtO4YTRCcw2DptzPLdLZlkVdkL24T5WIsaGQ2kI
         0/sAhFA3ZiWrsSmitS7vkPR7iEt6AXQ50US98CVAYSd3vcMMGHidTmta/urAFxcraROz
         CWQaI+PKeWTf7UEjltapF3T/aIwaMtC2PVYr1m3pPRlhTg8IvznjPhMDMlUfqTA9D4Kq
         s2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AhTCgEyNW01Hpz3xoMcaeloiLVbQZG4MDKBPmxYU6s=;
        b=Ectht3C7oYCscV6jscsgxgtJEdxdPo7UQ1v2S87ALsF8McPtQVvHKqBjW/4mI6AEvA
         kqF1r1nkTvno0f9XN8cGswl93Kcg7uDKX614pYSgH4LM1JxkpNtQQAgf/FCBa42vZs1M
         84TcIQOI7MpBAtb8gICwZdTg3hdC6oo0PzEfiZ5TGhSeCzPhdXYry2DWoBY3r4e2yAoB
         NbAidvgolHl7LMa5Ahu5HSnS5TcF5Qree8nX+q1DcK6gDe/CPEHMgj7yPGVCQofWrsco
         v94RD4C5W3HaDyWnkj6rsxPRE7/FZeCWWHJfbEWVP/iX22Y5WZpJH4O8EJzapABTfVG+
         AC5w==
X-Gm-Message-State: AO0yUKXvSu37AXZ/XcqLd6hPlMEsRiJpi3ErjvM6Uqk3aua3XPisjfdx
        kqCAqe4a7okktEuV1fmEy3ZqdcVKC5PahxRU5Fc=
X-Google-Smtp-Source: AK7set/nJdmi3PMS/VE7RInIufqL6RVJYPN9xEhALHj25oE+x3WlxzfNBMmASPK7wsxXCUM3BmbMcWnYf9nvi9Hrnc0=
X-Received: by 2002:a17:906:c44e:b0:8af:341c:1f82 with SMTP id
 ck14-20020a170906c44e00b008af341c1f82mr2595900ejb.4.1676144789870; Sat, 11
 Feb 2023 11:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
 <20230207-b4-amlogic-bindings-fixups-v2-v1-1-93b7e50286e7@linaro.org>
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-1-93b7e50286e7@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 20:46:18 +0100
Message-ID: <CAFBinCBWkBWkTR6F2+zO5OGh1tmbwh8X8aTLTar=SqSEZ6iMAA@mail.gmail.com>
Subject: Re: [PATCH 1/8] arm64: dts: amlogic: meson-sm1-bananapi: correct
 usb-hub hog node name
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 4:08 PM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Fixes the following bindings check error:
> usb-hub: $nodename:0: 'usb-hub' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
