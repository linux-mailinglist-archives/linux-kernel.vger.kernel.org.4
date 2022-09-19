Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA10A5BCD28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiISN21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiISN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:27:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DD62F648;
        Mon, 19 Sep 2022 06:27:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so7182040pjm.1;
        Mon, 19 Sep 2022 06:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=mkCH4OzN8g5w9NU3RvtGIK1KLmjjbkv0z31pyt5VQ+U=;
        b=ic6BZzN79DENl3Ss/xkTywrdtJVj3Z5/lUZKEYwtYa56HmZrdQtpcLrjdbJqGv7hcK
         DdD9oq4PXqMOcZFEvSkdpFy4BHM44AkxnwbVXv52E26eQEs3Mc7DLfObBV6235Qh27sy
         5U73mBy9ihbbW1XrK4u2U/tiisfFqQLzZITxGIcFRi6YYjg5Gf+tc8cc4SMvo8Y8GIZe
         1PK7qdF4t4flwv7ux4d/YBoe9H9SvLx4W7s2ju87ZQlPvW6v+BE9X+ytUrB8v5cm+psa
         PRAJH75bKdwCXv3Cigbxx3qD+7ft6qjHLCbr4Wg8DA4EIA7SumFVnl/LhV7tp+Fy0bBq
         QupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mkCH4OzN8g5w9NU3RvtGIK1KLmjjbkv0z31pyt5VQ+U=;
        b=TbQjvDIQw5rjfHCdZbJCYRgVUnGgZRzAqYasjYbLDYSBu3BtyCYuPP8ya4E6LNKdEE
         FmnYYJUSjOH7i1aOayAyHpn2xT83hBpz8jn2eHro7BEaL8Yf+OH00fICmQkjj1paLiLe
         cx7sE1IH3aofL2iY+tP4IvtoL9g5rQxsaows9qwH94HpeyentK5fXUebsSD3JfYkq+sa
         BL8ObxziyXNFbNA2wg/EXqpM1l1P4DCqRwHhfcXVkZDCEs+HJycXlMRNi5bVkBNP1D9S
         61PvH6c2glueRpM+J3WM3s6U93Jij4Kl9FvodH69hhhI3SlTSFLM0X44ohxG7ZqNAW8r
         OEDw==
X-Gm-Message-State: ACrzQf1WJlYm79/iVy81L2AERgNlaunlTfzSpURIyPj3jqvG6aD7tCgz
        xC1xwcT900bLJU+fcRJCBvl5qRvCvo/+7g==
X-Google-Smtp-Source: AMsMyM70l0UaCXymcy79gKINZcCJtyklQX+Kjs+aSUjY3KMkxMjt0UtG1NEie5fSwYiNiSn8WwOmSA==
X-Received: by 2002:a17:90b:1d87:b0:200:b6e1:7e9f with SMTP id pf7-20020a17090b1d8700b00200b6e17e9fmr20246816pjb.235.1663594052844;
        Mon, 19 Sep 2022 06:27:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mw5-20020a17090b4d0500b002004a2eab5bsm6630417pjb.14.2022.09.19.06.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:27:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 06:27:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vladimir Panteleev <git@vladimir.panteleev.md>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: sp5100_tco: Add "action" module parameter
Message-ID: <20220919132731.GA3547700@roeck-us.net>
References: <20220918140829.443722-1-git@vladimir.panteleev.md>
 <aabb7c21-9a80-696e-6a38-29de57e025ba@roeck-us.net>
 <CAHhfkvw_U_uF1UFcLTBUsw=_YoM_7pi3tw3KCovTT6PZTnH0ig@mail.gmail.com>
 <736d150c-03fe-ce39-a42e-b9b62f40a937@roeck-us.net>
 <CAHhfkvxf5P0KYQpzjAxBbEmYtK+YRs5P1QD+28=9FLZfn_awyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhfkvxf5P0KYQpzjAxBbEmYtK+YRs5P1QD+28=9FLZfn_awyA@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 01:18:53PM +0000, Vladimir Panteleev wrote:
> Hi Guenter,
> 
> On Mon, 19 Sept 2022 at 12:29, Guenter Roeck <linux@roeck-us.net> wrote:
> > I am not getting into define name editing wars. The define is named as
> > it is. There is never a good reason to rename it. If I'd accept your
> > change, someone else might come tomorrow and want it renamed to
> > "SP5100_WDT_ACTION_POWEROFF" because setting the bit to 1 causes
> > the system to power off.
> 
> Ah, sorry - this is one of my first attempts at contributing to the
> kernel, and as such I of course fully defer to you. In case I was
> misunderstood, I was just trying to explain my line of reasoning at
> the time, which is what I thought you asked for in your previous
> message. Thank you for the explanation, I was not aware of the high
> cost of renaming defines.
> 
> I will send a V2 if this is all?
> 

Sounds good.

Thanks,
Guenter
