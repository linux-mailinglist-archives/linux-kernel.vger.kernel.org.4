Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973EA6479F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLHXb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLHXb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:31:26 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4565C5F6E8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:31:25 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id o13so1904421ilc.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 15:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FV3wpSUefX/PcYICHHfwY5Z4y5Zte+XPd9H0LpIR36Y=;
        b=lJ0iS5gPJ4rlcWmv+546tiaO4lzaDKBJkQwcqSe9xUXv5pSttUd6DRVC+XDVam+MVP
         t0g1XTbaNGl5MK0s80HWMY3uKd/36qpX3Y5n8RzEZ4jr/TlvEsRJtvq9RFBe0KhLLLyC
         36gRI5DgIkC0uFWx6t97uYRu9H4k0m+1ZbVWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FV3wpSUefX/PcYICHHfwY5Z4y5Zte+XPd9H0LpIR36Y=;
        b=1yXpFKkwMwIHtLLdN7cdledugNUXyLn5wOTSPwVYXzRYwIUaoLw8qIQ6n4hytFpZMY
         iJbq5g97hvbwtnxNCWAj/+E69rzc+SWr84JVO0eVh3eBLsLXKDcOVKbKldo96I7gReGH
         25hEn1il1I/KsDkpAHNX3Gh6syalavGVSKLIseDcsJBNEs0RplbW+HKJ7/oPzgSYkJyD
         Sq8wJkZ6LhzdMTYmPf+krx+CAulRh+Sa0aE8qgUiHUBEPSG5pxkADeolYR8hGPDTj1/x
         /cWNuANX74lEpraAY14OynSiaHuCWyRd1/y3zziuBfiN1fVu0h7oDjOdCPpR0cjBbYS7
         XcpA==
X-Gm-Message-State: ANoB5pkRW6Yz254OpEK2YWYEEuve23R9peFKu0VjS0aoQP48I58vTyKD
        HgGlGTcTOwOmMwp+YbtFoEwv2Q==
X-Google-Smtp-Source: AA0mqf6bgTHcg2kInnMk80L1L32E9Q4xc840yl7AcjpfQ/F0Oy5zpG8kBq8XYFt2ZP7TBlg/OUY6SQ==
X-Received: by 2002:a92:7302:0:b0:303:41bf:fab5 with SMTP id o2-20020a927302000000b0030341bffab5mr2086390ilc.27.1670542284656;
        Thu, 08 Dec 2022 15:31:24 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id a1-20020a029401000000b0038a346207cdsm5925554jai.84.2022.12.08.15.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 15:31:24 -0800 (PST)
Date:   Thu, 8 Dec 2022 23:31:23 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sc7180: Add trogdor
 eDP/touchscreen regulator off-on-time
Message-ID: <Y5Jzy4hL2x4qcATT@google.com>
References: <20221208192006.1070898-1-dianders@chromium.org>
 <20221208111910.2.I65ac577411b017eff50e7a4fda254e5583ccdc48@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221208111910.2.I65ac577411b017eff50e7a4fda254e5583ccdc48@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 11:20:03AM -0800, Douglas Anderson wrote:
> In general, the timing diagrams for components specify a minimum time
> for power cycling the component. When we remove power from a device we
> need to let the device fully discharge and get to a quiescent state
> before applying power again. If we power a device on too soon then it
> might not have fully powered off and might be in a weird in-between /
> invalid state.
> 
> eDP panels typically have a time that's at least 500 ms here. You can
> see that in Linux's panel-edp driver that nearly every device

nit: s/that nearly/nearly/

no need to re-spin just for this.

> specifies a "unprepare" time of at least 500 ms. This is a common
> minimum and the 500 ms is even in the example in the eDP spec.
> 
> In Linux, the "panel-edp" driver enforces this delay for its own
> control of the regulator, but the "panel-edp" driver can't do anything
> about other control of the regulator (for instance, by the touchpanel
> driver).
> 
> Let's add 500 ms as a board constraint for the regulator that's used
> for eDP/touchpanel on trogdor boards. If a given trogdor board stuffs
> only panels that can use a shorter time or stuff some panels that need
> a larger time then they can manually adjust this timing.
> 
> We'll only do this minimum delay for trogdor devices with eDP (ones
> that use either bridge chip), not for devices with MIPI panels. MIPI
> panels could have similar constraints but the 500 ms isn't necessarily
> as standard and there are no known cases where this delay is needed.
> 
> For most trogdor boards, this doesn't actually seem to affect anything
> when testing against shipping Linux. However, with pazqel360 it seems
> that this does make a difference. It seems that the touchscreen on
> this board _also_ needs some time for the regulator to discharge. That
> time is much less than 500 ms, so we'll just put the eDP panel 500 ms
> in there since the board constraint should be the "max" of the
> components.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
