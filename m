Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADE76988D8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBOXmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBOXmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:42:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61A52E80D;
        Wed, 15 Feb 2023 15:42:21 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so3357291wms.0;
        Wed, 15 Feb 2023 15:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C+ybmLDCWMfPyfiTtsVa8IGPymIM7ZxA5t8F8E2tAsk=;
        b=e6PostQ7Pm1XUYk7VcyETj2TGIkE9KGyAeEs+RSuBF2qF0FltnhEwdGlp4gzvQS7YI
         vhV9nFmiAP5K3BFfN1dqyJX6/Y4muYW4fFfJL/1qRQtSfyiKW6TmeRJjHoBNRcjw6fuw
         EE5UZYwiIwnw5HdX7QzTVAKUpzQt9B44NOIwmUpuQYssoapDdijrUWCImUB7HfVJH8YA
         PntLzYDB8OPA8hmSv45As6TS//cI/n1QyF3ult7sOiqQx75xt9nxl4Jha7zU/Bz6e7rM
         zyyuQv5AmxcyxGzOFLZbnFejs6Bbpe+1YWrnpJ1rT4nyOfSTlNO0iLPIlroctxRptnhC
         D/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+ybmLDCWMfPyfiTtsVa8IGPymIM7ZxA5t8F8E2tAsk=;
        b=tElBdFZ/EnpxjQ0K3+diB1LSQCx7FXz2FFuA5U8vEECO5zVj/y7tBi83FxWmBxX2gt
         UD7rlT5G/aomcemLND8L+9M3IIIYe4UxJZkKdieiK1qyCJsWuEOab+PflORIHLTqfg1d
         uZkbeGooqAvTkAV4/2+sGeDkLeB3G8ru4a4tHcE6KN6emQ3YwgqDYPmn8k3dPUatJ84u
         QTrl6RjWC9xRM4X9nE6d70ssR+lkIK3kqAKA0a7YgieQVdaqMyZalMZPy94C6OlM6ZOI
         71gPmwCRvLIdCZncqDYcc4L0N5mV54tgPM4YyTMVqDgG9qZrq4851q7+mR8U+2+C2S0I
         Yakg==
X-Gm-Message-State: AO0yUKUvedHRnwEKluQHp2zsnvfXJGUxDYf5NtH4q6sC8oJeTjTfZXL9
        MvrbOyVfCfNi/fEXCK5S7vg=
X-Google-Smtp-Source: AK7set+Seub3lM8LHEzXSEILBWFg2v+gSabmJWb2pNvNVTO/aVo2LUUtrKJZSWVyKzh/SolRpTJ+cQ==
X-Received: by 2002:a05:600c:2ed2:b0:3df:eda1:43b9 with SMTP id q18-20020a05600c2ed200b003dfeda143b9mr3444779wmn.4.1676504540187;
        Wed, 15 Feb 2023 15:42:20 -0800 (PST)
Received: from Ansuel-xps. (93-34-91-73.ip49.fastwebnet.it. [93.34.91.73])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b003db06224953sm3791806wmo.41.2023.02.15.15.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 15:42:19 -0800 (PST)
Message-ID: <63ed6ddb.050a0220.beb77.bf66@mx.google.com>
X-Google-Original-Message-ID: <Y+1ryQsemKb6pHKs@Ansuel-xps.>
Date:   Thu, 16 Feb 2023 00:33:29 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: Warn and add workaround on misuse of
 .parent_data with .name only
References: <20230131160829.23369-1-ansuelsmth@gmail.com>
 <e5b71c243022d341022b4f172060268b.sboyd@kernel.org>
 <63e6e809.050a0220.af3df.d908@mx.google.com>
 <96040456fd5c127497de93980eb7db83.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96040456fd5c127497de93980eb7db83.sboyd@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 10:54:56AM -0800, Stephen Boyd wrote:
> Quoting Christian Marangi (2023-02-10 10:34:11)
> > On Fri, Feb 10, 2023 at 04:40:29PM -0800, Stephen Boyd wrote:
> > > Quoting Christian Marangi (2023-01-31 08:08:28)
> > > > By a simple mistake in a .parent_names to .parent_data conversion it was
> > > > found that clk core assume fw_name is always provided with a parent_data
> > > > struct for each parent and never fallback to .name to get parent name even
> > > > if declared.
> > > 
> > > It sounds like you have clk_parent_data and the .index member is 0? Can
> > > you show an example structure? I'm guessing it is like this:
> > > 
> > >       struct clk_parent_data pdata = { .name = "global_name" };
> > >
> > 
> > An example of this problem and the relative fix is here
> > 35dc8e101a8e08f69f4725839b98ec0f11a8e2d3
> > 
> > You example is also ok and this patch wants to handle just a case like
> > that.
> 
> Ok, so you have a firmware .index of 0. The .name is a fallback. I
> suppose you want the .name to be a fallback if there isn't a clocks
> property in the registering device node? I thought that should already
> work but maybe there is a bug somewhere. Presumably you have a gcc node
> that doesn't have a clocks property
> 
>                 gcc: gcc@1800000 {
>                         compatible = "qcom,gcc-ipq8074";
>                         reg = <0x01800000 0x80000>;
>                         #clock-cells = <0x1>;
>                         #power-domain-cells = <1>;
>                         #reset-cells = <0x1>;
>                 };	
> 
> Looking at clk_core_get() we'll call of_parse_clkspec() and that should fail
> 
> 	struct clk_hw *hw = ERR_PTR(-ENOENT);
> 
> 	...
> 
>         if (np && (name || index >= 0) &&
>             !of_parse_clkspec(np, index, name, &clkspec)) {
> 		...
> 	} else if (name) {
> 		...
> 	}
> 
>         if (IS_ERR(hw))
>                 return ERR_CAST(hw);
> 
> so we should have a -ENOENT clk_hw pointer in
> clk_core_fill_parent_index(). That should land in this if condition in
> clk_core_fill_parent_index()
> 
>                 parent = clk_core_get(core, index);
>                 if (PTR_ERR(parent) == -ENOENT && entry->name)
>                         parent = clk_core_lookup(entry->name);
> 
> and then entry->name should be used. 
>

Hi, thanks for making me give this an extra check... I think I found
the real cause.
I send a patch that should suppress this and give an extensive
explaination of the problem.
This is the ID: 20230215232712.17072-1-ansuelsmth@gmail.com

The hint that made me get what was wrong was a problem with index and
the fact that it should have returned -ENOENT... Fun to discover a clock
was actually returned and the function never returned an error.

> > 
> > > > 
> > > > This is caused by clk_core_get that only checks for parent .fw_name and
> > > > doesn't handle .name.
> > > 
> > > clk_core_get() is not supposed to operate on the .name member. It is a
> > > firmware based lookup with clkdev as a fallback because clkdev is a
> > > psudeo-firmware interface to assign a name to a clk when some device
> > > pointer is used in conjunction with it.
> > > 
> > 
> > And the problem is just that. We currently permit to have a
> > configuration with .name but no .fw_name. In a case like that a dev may
> > think that this configuration is valid but in reality the clk is
> > silently ignored/not found and cause clk problem with selecting a
> > parent.
> 
> It is valid though.
> 
> > 
> > Took some good hours to discover this and to me it seems an error that
> > everybody can do since nowhere is specificed that the following
> > parent_data configuration is illegal. 
> > 
> 
> I'll look at adding a test. Seems to be the best way to solve this.

Eh probably a test may have made this more clear. The main problem  here
was that the function never returned an error but under the hood the
parent was pointing to another clock.

-- 
	Ansuel
