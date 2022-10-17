Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592A8601665
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJQSe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiJQSez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:34:55 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26314237CA;
        Mon, 17 Oct 2022 11:34:54 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id o64so13064030oib.12;
        Mon, 17 Oct 2022 11:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4FmwvBqnJTncoPiKUPBPPBe171UWUDniXQaooeZxpw=;
        b=cUtLFDCVPom9VJCBq9yxFHz+45hYXRfVxxbfwS4vTRR4L5jBfanW/xQGF97wjcilmF
         J/EETbdnb0i4tY0juFXcW6wd3vO+pKfXF4hT/DW/e3kn+pC7uiQF7TuweGlThc/dLaVG
         d0OyeiZtdmbUoXDXgerlAtsU9uGh/LF39J7yhOtjArpzVuzwBREVp5GEXO5sir///958
         HFCnZU7jxUST22URv/usi6+BtI1ZGvKdbTl3rNEsWPCZZUWRSgKjv/msxuhIyZTeDOhO
         1ma3NioE1JNyPhU6aqSoTYnl5cf1BMdpSPi2IMWg/5w1jpIj9U23BE4GeBFcyXc8lOV6
         j6Xg==
X-Gm-Message-State: ACrzQf1CUpRoZJovLX7AKSsQ26UW+EodKrNgUQuE5kMef/08k+wDkzlm
        EWRAexqJvFLzjDaSJePu1fzd4SRQRA==
X-Google-Smtp-Source: AMsMyM6zWSIgmd+I4omxIOYg2rHsSiGZaz0fVmjUISZiTCI2iq+9HRTI45XL5vYpiTUKkezyqPBipw==
X-Received: by 2002:aca:240c:0:b0:355:41a7:d4dd with SMTP id n12-20020aca240c000000b0035541a7d4ddmr1197974oic.281.1666031693439;
        Mon, 17 Oct 2022 11:34:53 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bv13-20020a0568300d8d00b006618eb616dbsm4977077otb.8.2022.10.17.11.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:34:52 -0700 (PDT)
Received: (nullmailer pid 2255311 invoked by uid 1000);
        Mon, 17 Oct 2022 18:34:53 -0000
Date:   Mon, 17 Oct 2022 13:34:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: clock: Add Ingenic JZ4755 CGU header
Message-ID: <20221017183453.GA2253413-robh@kernel.org>
References: <20221016150110.3020451-1-lis8215@gmail.com>
 <20221016150110.3020451-4-lis8215@gmail.com>
 <c2accc8b-f4eb-47ca-333f-eeb98da6a363@linaro.org>
 <CAKNVLfZ8qi4MS6ineF4M5xnSmHW+=P5mdgifmr74g4kOSK2wGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKNVLfZ8qi4MS6ineF4M5xnSmHW+=P5mdgifmr74g4kOSK2wGA@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 09:21:18PM +0300, Siarhei Volkau wrote:
> вс, 16 окт. 2022 г. в 18:32, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>:
> 
> > Why did you choose 2.0+?
> 
> It's the first time that I need to choose a license, so it's a bit
> confusing what
> side effects they have, especially in that particular case.
> 
> What do you recommend?

Are you fine with GPLv4, GPLv5? Considering they haven't been written, I 
wouldn't be.

Rob
