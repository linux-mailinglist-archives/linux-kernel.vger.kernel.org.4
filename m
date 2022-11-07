Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727F261EAA3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 06:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiKGFqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 00:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKGFqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 00:46:15 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FB6E19
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 21:46:13 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o7so9575069pjj.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 21:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3O6nJYiSOnp6ov4FLvbHZ8pnu6HF5fNZ0WPiGV8NazE=;
        b=rAEI4Th/b82vKd0S/pe4KCZglgnjDd+X6p1UpwAvTPx/a0zOa0o9aBWYg2lB8N1Pms
         xW0jCu7lHH83MgADi1yWDiDCaiER6ret1LdyN0v6+8jqSA9DZc4dMU4WC0X3Mu1efXmm
         Cwgk1j9pGpizo1N/JlZa+D683evX6xdgdT2LhEabfIdnZVkRhkzVvuOwJ9uOy+QRVPEc
         oyELYAmIag1pANoSjv3HmsR3ypZsFOaZSOzizG3jCzZ0w61VINom2lnfA0FHnWonavXJ
         6LmFwySf+RAub6SyDP4WXoGetQHRZha6zDc80mlTwEE2llFddT+zC5hVuCzn7nguVPJh
         GJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3O6nJYiSOnp6ov4FLvbHZ8pnu6HF5fNZ0WPiGV8NazE=;
        b=OrdQIA5TBib+uY2BHpVRK7fWc71ltULQvuFvq4YDbW3nsZa3e0XqMtcmU4sh/wWVYg
         LKnsfOJ/NOJcbXFRHviMigwAPx1UUBi5mtKLWq490dHEVdCmv8zSbQ7jENdcf36AhlKT
         MrqZva2mssoJi5iOoIRI8JPU6zTmKj+shI69PPGzGAC4YNRlZzuVp4em12pz1d7FeaWo
         5mCw3M0qx0GirmZrgNj2H99Wr4XumMkNKN1ZMERuUb3Z+fGWb+vVcgX8znGR4Rj+s6Np
         j9Fzm3hZqsifJBdWqBoES7zKzIPl6nxjbCcJLWRThUcb16Ix+uef0XqbOJbVskGBvvF/
         QfcQ==
X-Gm-Message-State: ACrzQf3OiYNvO+KPcBFh5OEztvIOoVdyzeWlvE1T8lkfvJHD0lYFYVNU
        fUWYTfgsspRebzr6DFngKQSk6w==
X-Google-Smtp-Source: AMsMyM4xVXSvqK7ym9fQ6l4LKmbvI4cK95YnKXzmptqsS/DTOvTiGJRWo85XBdzTE1u8b5zAv6VlGQ==
X-Received: by 2002:a17:90b:524f:b0:212:c22f:fbd1 with SMTP id sh15-20020a17090b524f00b00212c22ffbd1mr50915748pjb.155.1667799973215;
        Sun, 06 Nov 2022 21:46:13 -0800 (PST)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902dacf00b00179e1f08634sm4022649plx.222.2022.11.06.21.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 21:46:12 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:16:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Russell King <linux@armlinux.org.uk>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4a 02/38] ARM: spear: Do not use timer namespace for
 timer_shutdown() function
Message-ID: <20221107054610.o4h5xh3osy4tggej@vireshk-i7>
References: <20221105060024.598488967@goodmis.org>
 <20221105060155.228348078@goodmis.org>
 <20221105140553.GC1606271@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105140553.GC1606271@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-11-22, 07:05, Guenter Roeck wrote:
> On Sat, Nov 05, 2022 at 02:00:26AM -0400, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > A new "shutdown" timer state is being added to the generic timer code. One
> > of the functions to change the timer into the state is called
> > "timer_shutdown()". This means that there can not be other functions
> > called "timer_shutdown()" as the timer code owns the "timer_*" name space.
> > 
> > Rename timer_shutdown() to evt_timer_shutdown() to avoid this conflict.
> > 
> > Cc: Viresh Kumar <vireshk@kernel.org>
> > Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: soc@kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Nitpick: I would have called it spear_timer_shutdown(). POV, so

+1

Other than that:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
