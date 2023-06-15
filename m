Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A036731684
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbjFOL3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbjFOL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:29:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAD8268C;
        Thu, 15 Jun 2023 04:29:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f8c65020dfso19007395e9.2;
        Thu, 15 Jun 2023 04:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686828568; x=1689420568;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cLMoHRQkNaVEJbS7Ev0Yvn4A21A5U5fl8EoeJfa1evM=;
        b=Yv73hjsA1PHoQjwh0SsiNTpMlq5QMrgH+ucTTQ/1umRZrbHvX22JoOHVuTJuNLbrqj
         T2vWpV4Ql+QoWdNJqa8JK6rG80PvZZr80XIAg49x1i8wIErCOb9tKAN1gn96fHA3vrS2
         qs8ZHcBbeTX7odc4cMhnK/jf0v0V/I/Ujn2Z7qfVaQxkHo0AxCzkbbfAip4Zs9hyZ7tj
         7yIpudhrLL3XTK/axjjYFGbIV/XXrcDOo5oUlYEem8Uf+tqzJ5+mpoZ9SaAxh5webClz
         3rHMw6HUNUNvXDBK8EYkTl9G/axO0ipwCDHwaBfctT7bXOiLCsQHG4lH55qUTqs+xEiK
         pHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686828568; x=1689420568;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLMoHRQkNaVEJbS7Ev0Yvn4A21A5U5fl8EoeJfa1evM=;
        b=afuvhfh8GvL/qzIa7JFLBOml6YQPKExYYD2wPEeIJA5BPDnoC8O9qLX/0aP2FgC0gu
         bqRsCgcasSGdnMyTHF8QDOFofZdOK4F2wKYVTfNVHpuW7twPUjSyD1k18mGfncTNRU2E
         5QPjepYZl61qGPzXBILNsLAHZO7Yul2CWpjn9apWcqZlcogc03GXniQNDTcgGkXF7pTs
         Nvo2mUYU4nZAZDF/AZ7wdPfGY0jd6abW0g5KLdREJwLG8KmlD8W1/hTEHAg5RXu0Buot
         BYPplgQy0dJhs8fMbCJMbBP/3GF1dETPuxoMHeVGPsQnA2eJ/ivQTdZHmOpp5fV5+ffb
         70iA==
X-Gm-Message-State: AC+VfDwF5q9gUxVvbPyNKdlEv0RUiOVIxKQ5GS+G2fkAXWkQm6YAKdhY
        PjPmFlufSW7eRuBaG9W1di1f6rNiFjc=
X-Google-Smtp-Source: ACHHUZ58KwgDXTDG6pMkF9+44DVif+hPHlagF+7zOsU6Ghm0GF/2b1zRlRePitJfpW2ZKw7zaRiwoA==
X-Received: by 2002:a05:600c:2144:b0:3f7:5e07:ea54 with SMTP id v4-20020a05600c214400b003f75e07ea54mr14233392wml.13.1686828567565;
        Thu, 15 Jun 2023 04:29:27 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id p17-20020a1c7411000000b003f7e4639aabsm20220093wmc.10.2023.06.15.04.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 04:29:26 -0700 (PDT)
Message-ID: <648af616.1c0a0220.f8289.b7a9@mx.google.com>
X-Google-Original-Message-ID: <ZIr2FGIXzvMD1PWg@Ansuel-xps.>
Date:   Thu, 15 Jun 2023 13:29:24 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] clk: qcom: clk-rcg2: add support for rcg2 freq
 multi ops
References: <20230427150717.20860-1-ansuelsmth@gmail.com>
 <20230427150717.20860-3-ansuelsmth@gmail.com>
 <82072c2b-8483-6fb6-a9d1-c9882825c9cb@linaro.org>
 <6473e34c.df0a0220.33a79.6c95@mx.google.com>
 <4afbcdd0-a11c-4826-d669-2ffc9488a8b6@linaro.org>
 <64749bf4.5d0a0220.325c0.64b5@mx.google.com>
 <d251be3e02b2fe28357c884e39fe7601.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d251be3e02b2fe28357c884e39fe7601.sboyd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:28:08PM -0700, Stephen Boyd wrote:
> Quoting Christian Marangi (2023-05-29 05:34:57)
> > On Mon, May 29, 2023 at 02:12:23PM +0200, Konrad Dybcio wrote:
> > > On 28.05.2023 14:37, Christian Marangi wrote:
> > > > On Sat, May 27, 2023 at 06:11:16PM +0200, Konrad Dybcio wrote:
> > > >> On 27.04.2023 17:07, Christian Marangi wrote:
> > > >>> +  * Force the first conf if we can't find a correct config.
> > > >>> +  */
> > > >>> + if (unlikely(i == f->num_confs))
> > > >>> +         best_conf = f->confs;
> > > >> Is that a supported scenario or would it be a device driver / clock
> > > >> driver error?
> > > >>
> > > > 
> > > > It's to handle case for the 2 continue in the loop and arriving in a
> > > > situation where best_conf was never set?
> > > > 
> > > > Should we return a warning and an ERR_PTR? Idea was to provide a best
> > > > effort selection.
> > > Hm.. I'm not sure what's the expected behavior here.. Stephen?
> > > 
> > 
> > I have this implementation rady, if you want I can send this revision
> > and discuss that in v5 directly. It's WARN and returning -EINVAL.
> 
> I'd only have a WARN if you never expect to hit that case. Otherwise, it
> should return -EINVAL and not warn. At a quick glance it sounds like
> some sort of rounding policy, so just make sure the
> round_rate/determine_rate implementation agrees with what set_rate()
> will do and it should be good.

Hi, in theory the WAN path should never happen, as it means no parent
for the clk are present. So I guess with your logic printing a WARN is
correct.

About the rounding policy this is more or less problematic, it's a
CLOSEST policy, so not a CEIL or FLOOR one. The determine_rate apply the
very same selection logic of set_rate so also that should be good.

I sent v5 some time ago with the concern here addressed so if you have
time it would be good if you can check that.

-- 
	Ansuel
