Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB905E99F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiIZG7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiIZG7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:59:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BF32BE05
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:59:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r7so8694964wrm.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=AsWHnMe9jhg1La/KfPcn1a5vs8e9lFnP8YYGHKY0Bl8=;
        b=wH4UGjvNQT5EjpZsfHk2g9ZNyAi9B2zL+bhqh9L3cv4B5zX5dw42USyRhOeJRJqZlA
         5yNTnAoSiwN0uU6yK3uiN5eP2ITJ9L5HqQrYNjq0Wqd2Mru94t31Sn9hsKBp+aleIbY/
         L98rHyIxie0YpCNKZe8ldFEsMnhDcagrAu8D/NGLPzMOuS5t1hzgWl0kFsvZUrcBSNLu
         CcR8euMHxlFlr1Swn9ZoMOzpZzd1NTxtLze08h4mGFQv2j6COKnqeqcEoqt3HRU9htX+
         fX3AxavZLTAr+sGImgA55mnRDxa2fWThl/8bt3NWT0RspDSuRhlXbQRuO9l5QtRxGdaG
         5foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AsWHnMe9jhg1La/KfPcn1a5vs8e9lFnP8YYGHKY0Bl8=;
        b=tCrEvoJj/HpoiYUR8hU3g0iQgE3nXujuwxOoE/Y8J4Gn2jKYcLjSvnAeyW7g2Zo1Aw
         sVSaLqu3kyA/o5MNXp24I04qCIR/XlLms+lfa3X1ju71L2HkzpPTLxOd6eoBgYhgjNel
         vSe+bL5pVvyP/foZR5V9ekTfLnKespakz7kA5aqKpvGlg5MAM4aGLFx4mhfhnEz91XTd
         4tfVnVTMbckrMTigaTjvsuYi0ZclykwM4FvPcYPXwTpQqxAhWl7h7Ucp9Rd9bHNt9O0k
         FYHBqbzZFyR9GC8XiNoELZiZj3hqpN2uCB7MeSJfOcPiXB/LiyaXBd9V6EtOqHZTewcP
         1GKg==
X-Gm-Message-State: ACrzQf0zI09i3cd5fBC/I/taXbyUTuJrpKSdAKSUquC/0fTkDI3r5GmV
        0CLdIQ0RXMvjNC4wdJVNuf1bLQ==
X-Google-Smtp-Source: AMsMyM4Af2+g8T7GtLQLiDbIHhO3sVKNRIw65E8JMYvjCsWbm6FvNFM/F2QV1jFodQ4IQcxLqmwqDQ==
X-Received: by 2002:a05:6000:1849:b0:228:c87d:2578 with SMTP id c9-20020a056000184900b00228c87d2578mr12384711wri.274.1664175552984;
        Sun, 25 Sep 2022 23:59:12 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id bv3-20020a0560001f0300b0022b014fb0b7sm13869912wrb.110.2022.09.25.23.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 23:59:12 -0700 (PDT)
Date:   Mon, 26 Sep 2022 07:59:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: regulator: Add bindings for Unisoc's
 SC2730 regulator
Message-ID: <YzFNvByGG7ADWfmd@google.com>
References: <20211008031953.339461-1-zhang.lyra@gmail.com>
 <20211008031953.339461-3-zhang.lyra@gmail.com>
 <YY5wPh0rwRvFjSRG@sirena.org.uk>
 <CAAfSe-uA3iowafC25zRqoTSaub1PbOzUvQgukLm=szEge_abvw@mail.gmail.com>
 <Yyw2nAAjN6NxmS09@google.com>
 <YyxKSjMPlGPfegpJ@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyxKSjMPlGPfegpJ@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022, Mark Brown wrote:

> On Thu, Sep 22, 2022 at 11:19:08AM +0100, Lee Jones wrote:
> > On Thu, 22 Sep 2022, Chunyan Zhang wrote:
> 
> > > I understand your point. But like I described previously [1], if we
> > > still use the current solution (i.e. use devm_of_platform_populate()
> > > to register MFD subdevices), a compatible string is required. I'm open
> > > to switching to other solutions, do you have some suggestions?
> > 
> > Many IPs encompassing multiple functions are described that way in
> > DT.  I don't have the details for *this* device to hand, so my
> > comments here aren't specific to this use-case, but describing each
> > function individually does describe the H/W accurately, which is all
> > DT calls for.
> 
> If people want to describe the individual regulators that'd be
> less of an issue, it's mainly when you're nesting what's
> effectively another MFD within a parent MFD that it's just noise
> that's being added to the DT.

As I say, I haven't studied this use-case.

These comments were designed to be more generic.

What do you mean by nested MFDs?

> > Can you imagine describing an SoC, which can be considered as a huge
> > MFD, with only a single node?
> 
> Honestly we should be arranging things so they're more like that,
> at least using overlays for the internals of the SoC so you don't
> have to rebuild the whole DT for updates to the SoC internals.

Right, there would be one device root node.  However each function;
clock providers, regulator controllers, PWMs, GPIOs, networking
(various), reset, watchdog, etc would have their own nodes.  Rather
than attempting to describe everything in the parent's node.

-- 
DEPRECATED: Please use lee@kernel.org
