Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74BF639701
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiKZQEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiKZQDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:03:52 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4992E7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:03:51 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id k206so7104273ybk.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oPI4AZ2eAdf9dpFkRgyi9VOqBdgUQo1/pANTi1uI3pg=;
        b=qb5b/2eXX4lPgYmeza0r1fNs84UXtLmZSNW4snW99vNTkKqz8V51lyk6Xtm+CAmEFl
         x33Ecu160iOmJS5UcAezKA6sjS7lkrnxtgxjqTurCKvvjnfJyzWXA60T6vokaYPZr0Cz
         PwNKTT2jlBga46ujI5OOamevM4GfwPQSpg2eslJK9BGIF2amBN5CbGONjDfNU622sBAq
         TijvaxYrvE8pLH+pFR7JtUNGccqDlLcdkRFfov158Nm5hX596DQPKTS1AhfqNftdEblb
         su+vD1lRSuyszk8v8ipoLQFlRa1lh2H23gXn9jo1ApbAvrGz+00SuSJ1qTmXahHlpLFU
         tJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPI4AZ2eAdf9dpFkRgyi9VOqBdgUQo1/pANTi1uI3pg=;
        b=FSdaU2EC9wDS1RT3UnP6J+OBlJYVd/8PAAkJW/mKh7voq8sq/gtvMRU30NSOfeEU/0
         BUv5+2lafBPwi3vC+a1+PB3hjFkjKDmlFv5D+b2ExFTEZetAPWE31dT//O2HA1kSoIS0
         HEas0IDG0PDn/H6fusBQCbeLgwFMUN+4wVWsZncYfWiBui3eyUdRI8mkcEKrb0LlyUpT
         YmpqISDbBmNEUlsX9hn/2vDK+pHu8/L2uZFFSvra7TsPqAUq+STWE4Y0+10baaxl7pBI
         vK/GYtBg8m/vK1AsDgl9hPx6negYbsph4YJjmrxVx9+cjQxsvMlqWgIEG15jY+PS24EI
         5l1Q==
X-Gm-Message-State: ANoB5pm0G2RRdzLvMPDnDUkA1pjki2v4z55Fd1E0dpxoKThiGc1VVw4E
        UH9ed/Ud3ygqRTVOhk8513RS5SV8btUB5qBlKAZepw==
X-Google-Smtp-Source: AA0mqf7hvcnOUxnzNtLIoGMAMAsp39IkIkzo1prQTdpWorNW60u6DsujeEGHp6iwBrCpbf4h0RTRClHXC0VgntqE92g=
X-Received: by 2002:a25:3c82:0:b0:6e7:39db:aeb5 with SMTP id
 j124-20020a253c82000000b006e739dbaeb5mr24048591yba.304.1669478630995; Sat, 26
 Nov 2022 08:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20221125144141.477253-1-krzysztof.kozlowski@linaro.org>
 <3719828c-0ac5-34c9-a04b-251cbeb5f6ef@linaro.org> <a135f93a-235a-27b8-f649-69d62f6ebd30@linaro.org>
 <54f500cb-d7d0-8af1-eb58-99fbe71791a5@linaro.org>
In-Reply-To: <54f500cb-d7d0-8af1-eb58-99fbe71791a5@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Sat, 26 Nov 2022 17:03:39 +0100
Message-ID: <CAB6niQ4808JEgdQEvRvaYqq8YmFCGo_YLnxXo+rjpSgxQxu+7g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: amlogic: align LED node names with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Nov 2022 at 15:24, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/11/2022 15:16, Krzysztof Kozlowski wrote:
> > On 25/11/2022 18:16, Neil Armstrong wrote:
> >> On 25/11/2022 15:41, Krzysztof Kozlowski wrote:
> >>> The node names should be generic and DT schema expects certain pattern:
> >>>
> >>>    amlogic/meson-sm1-bananapi-m5.dtb: leds: 'blue' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> ---
> >>>   arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 4 ++--
> >>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>
> >>
> >> <snip>
> >>
> >>
> >> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> >
> > Aren't you maintainer of the platform? This means I should take care of
> > this patch?
>
> Ah, this will be picked up by Kevin or Jerome? So this tag means only
> Reviewer's statement of oversight, right?

Of course I'll pick it.

Neil


>
> Best regards,
> Krzysztof
>
