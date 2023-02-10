Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70B2692C5E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 02:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBKBC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 20:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKBCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 20:02:22 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B18E75F52;
        Fri, 10 Feb 2023 17:02:21 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id by3so5539794wrb.10;
        Fri, 10 Feb 2023 17:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2hmU167TsLSJ0D5985lF6+WQ0nnKX9IYBooX0KRJnaU=;
        b=XnJCsibpYSf3oJib4tnZKcuOa1t/DxwZrMEEQWmVwbm9d+H4OKDUiC6FndBrIoCMKj
         zczDQ22YWI5BBZrwTXN4sJ/rK/vYsexAp3QJvyumJkPK7GaRhMch3V7p6Zd63yXOpXOI
         kajDAIAtFc6yLXk1YRgh5jZBR4p5utnz6fNMmFSNUWnObTuW2cJm3KsfksOhI9CwotSj
         U4I0SeABSZSiO787vl1RgWjAmEaF7lE6IlvW7DeMvuT9ghyR25ofDvtehHB2rdbI3k93
         DcrKWBMAGwTzU5G+RjhNsLB3L+E6/i8aEl4ZkxyWgIP4cMjNWTH8roKCoDvc9xLOHwJO
         PHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hmU167TsLSJ0D5985lF6+WQ0nnKX9IYBooX0KRJnaU=;
        b=tiAubio4EZUxc/pgpNm22K1iGSj7jGVlKkx8khGDDcsOoxulVxSj0BIuXN0gupvL48
         LhAM5hr/NyTnqoCny0njf34p9AE8vZa9hlR63sQ3FdWZ4DNFunV8RFjluIhxuEqHYZHv
         LLyJI0tUDKMLLQkNbMOcZwVFPx0g5h2Fn6a72VfBJ+o8h4Y8G6gvCwVqAog5p1EXUk0C
         SVzlq4OGTfEaGcWurpaKuTAzM8r6f9aQ6FPu5+iRwxGoWcg2+pFs/ypgN1tF3MB8FPOg
         SpcL2u8EsMj62Ulyhk4gM3drJ3Dm051xsZ7NJacEqv+gAlz1QDGZC7eWYGF6a88gABad
         0zoA==
X-Gm-Message-State: AO0yUKWqTM2XnAz8HMxIcuif3k0iI5NthQn+kMCdhASbBF/q2m6gzzWr
        GUyk1iOqN6d8sRjskcGv0yk=
X-Google-Smtp-Source: AK7set8Ie/b3gl1B4RIkzMj7sctRlJ0HFO4iGaPG6AMMjKsA1OogsICeqy8h8udqh0PzJQQlrIZ/Qg==
X-Received: by 2002:a5d:61cb:0:b0:2c3:dc62:e682 with SMTP id q11-20020a5d61cb000000b002c3dc62e682mr14931867wrv.10.1676077339706;
        Fri, 10 Feb 2023 17:02:19 -0800 (PST)
Received: from Ansuel-xps. (93-34-91-73.ip49.fastwebnet.it. [93.34.91.73])
        by smtp.gmail.com with ESMTPSA id d2-20020adfe2c2000000b002c3f7dfd15csm4818532wrj.32.2023.02.10.17.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 17:02:19 -0800 (PST)
Message-ID: <63e6e91b.df0a0220.417f9.3a7b@mx.google.com>
X-Google-Original-Message-ID: <Y+aPS4FPzhM3uPLo@Ansuel-xps.>
Date:   Fri, 10 Feb 2023 19:39:07 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/2] clk: gate: Add missing fw_name for
 clk_gate_register_test_parent_data_legacy
References: <20230131160829.23369-1-ansuelsmth@gmail.com>
 <20230131160829.23369-2-ansuelsmth@gmail.com>
 <47e7fa4c103d08374d071fdf6de3b8ca.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47e7fa4c103d08374d071fdf6de3b8ca.sboyd@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 04:52:36PM -0800, Stephen Boyd wrote:
> Quoting Christian Marangi (2023-01-31 08:08:29)
> > Fix warning for missing .fw_name in parent_data based on names.
> > It's wrong to define only .name since clk core expect always .fw_name to
> > be defined.
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> What was the report?
>

With the previous patch applied kernel test robot report the WARN for
declaring a parent_data with .name but no .fw_name.

> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/clk/clk-gate_test.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/clk-gate_test.c b/drivers/clk/clk-gate_test.c
> > index e136aaad48bf..a0a63cd4ce0b 100644
> > --- a/drivers/clk/clk-gate_test.c
> > +++ b/drivers/clk/clk-gate_test.c
> > @@ -74,6 +74,7 @@ static void clk_gate_register_test_parent_data_legacy(struct kunit *test)
> >                                             1000000);
> >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> >         pdata.name = "test_parent";
> > +       pdata.fw_name = "test_parent";
> >  
> >         ret = clk_hw_register_gate_parent_data(NULL, "test_gate", &pdata, 0,
> 
> We don't pass a 'dev' here, so the pdata.index isn't looked at. I
> suppose we can assign .index to -1 to be more explicit, but because
> there isn't a device used for registering, we won't try to use the
> .index. Instead we'll try to use .fw_name for clkdev, of which there
> won't be a clkdev lookup either. Eventually we'll fallback to the .name
> lookup, and it will be fine.

Problem is that from what we observed, it won't fallback to .name if
.fw_name is not declared.

But it will work if .fw_name is declared but not exposed by DT. (and
will correctly fallback to .name as .fw_name is not found)
(but this is to explain why the change in the other patch is needed so I
may be OT here)

> 
> We need tests that exercises the 'dev' path and also the DT path and the
> clkdev path. I was thinking about working on that outside of the gate
> test though, and just having a generic clk test for that with simple
> clk_ops that do basically nothing.

-- 
	Ansuel
