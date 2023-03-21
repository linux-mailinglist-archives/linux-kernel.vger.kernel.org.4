Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C593A6C3997
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCUSxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCUSxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:53:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BA1252BF;
        Tue, 21 Mar 2023 11:53:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso21331587pjb.0;
        Tue, 21 Mar 2023 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679424801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/8f05xxvJrWaCQ9xWwRvdj/1PDHRxufoOig+2JZZGSA=;
        b=TX0/yqbkTKQJ/J3wZ6X2U31yWIIWEwfP6tNk5v4Uyy1kTq8GbFkfzUpK975x2jsNAG
         3CT3LLndfm3jseSsDmvfps5V25J3w7Mc2pIxecr/ckUqjZLUSBiDbdkqRSJhUhRJPUL1
         oUn1txkdWT6wPI6BI1NQOSV4C54icjP73J20AWaLfhuQxcYNzZF2nEYbiBjwGeZCAv6V
         1UolI+9TNirID73fKTHeM03OPWIKhMlwCBr0Oh+/0NLMJldQ10pkZLGzDHRPCym/u7il
         FFNC1u81Q2Owf2nFRO2z9ugIRXNSouhfhElvWY17tFI2WBaC+Ud2QCLORZqadzU/CXY7
         o3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8f05xxvJrWaCQ9xWwRvdj/1PDHRxufoOig+2JZZGSA=;
        b=FgTfj26V85rFJocWBzt0ED1Lm0Baja4ILNSkA3jVVboxIOiD6MyE+rZ1lffDibTynU
         RWCwzJnr0RunHmXGhxJ+Elw/Q1vCIDGREuhumey6yHMrcbh1XJBqiETApm1RIhGfOi9P
         wH3p/Pil7gKOpHHgEU7fv/HiQxARXaZURudbBBebv93EIOdr22scf4wObWv7XUsyO8WS
         xJnN78hCS4EL7ogz2oMUC6HuF72KJW0FeCHYGPquGnk1HF85PtQAPClYhh+SLMXg6/UF
         WVKpjYgS73WOrtuyr6Rnie75b4JMvwXnsXbLMjQYs1hzXN4mp+DIn+d+NcU6PbbGOOpJ
         N6kQ==
X-Gm-Message-State: AO0yUKWq01aySQ5uNslwlDyS1XuZm8FwOYfFkb/m3RBvXYBrb5a/ojt6
        p43lfixpqr7eT1hzDYXGssk=
X-Google-Smtp-Source: AK7set/pAlIuGOVqkMOPzDe1xYDJ6P14joNgfPo5dRMJNUh9BVlAV9nzxoKgJUcnTxijPZ5jabtr/w==
X-Received: by 2002:a05:6a20:1aa7:b0:cd:1ccf:246b with SMTP id ci39-20020a056a201aa700b000cd1ccf246bmr2750783pzb.57.1679424801047;
        Tue, 21 Mar 2023 11:53:21 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:7d6f:600f:dc75:be38])
        by smtp.gmail.com with ESMTPSA id e25-20020aa78c59000000b006254377ce44sm8548027pfd.43.2023.03.21.11.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:53:20 -0700 (PDT)
Date:   Tue, 21 Mar 2023 11:53:17 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, tiwai@suse.de,
        samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: i8042 - add TUXEDO devices to i8042 quirk
 tables for partial fix
Message-ID: <ZBn9HYw/NOvHFkrk@google.com>
References: <20220708161005.1251929-1-wse@tuxedocomputers.com>
 <20220708161005.1251929-3-wse@tuxedocomputers.com>
 <37a7e536-252a-c8a9-1412-37d3f2052a6d@redhat.com>
 <c5a7fa10-7b6a-fa0d-622e-4392fda1ee93@tuxedocomputers.com>
 <e84a2cb3-ea2f-6ce4-aba8-4026b3e6bedd@redhat.com>
 <f50b3db3-785d-3efd-b45d-13e1e93f60cc@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f50b3db3-785d-3efd-b45d-13e1e93f60cc@tuxedocomputers.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Werner,

On Tue, Mar 21, 2023 at 05:10:19PM +0100, Werner Sembach wrote:
> Am 11.07.22 um 14:55 schrieb Hans de Goede:
> > Hi,
> > 
> > On 7/11/22 14:45, Werner Sembach wrote:
> > > Hi,
> > > 
> > > On 7/8/22 21:39, Hans de Goede wrote:
> > > > Hi,
> > > > 
> > > > On 7/8/22 18:10, Werner Sembach wrote:
> > > > > A lot of modern Clevo barebones have touchpad and/or keyboard issues after
> > > > > suspend fixable with nomux + reset + noloop + nopnp. Luckily, none of them
> > > > > have an external PS/2 port so this can safely be set for all of them.
> > > > > 
> > > > > I'm not entirely sure if every device listed really needs all four quirks,
> > > > > but after testing and production use. No negative effects could be
> > > > > observed when setting all four.
> > > > > 
> > > > > Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS on the Clevo N150CU
> > > > > and the Clevo NHxxRZQ makes the keyboard very laggy for ~5 seconds after
> > > > > boot and sometimes also after resume. However both are required for the
> > > > > keyboard to not fail completely sometimes after boot or resume.
> > > > Hmm, the very laggy bit does not sound good. Have you looked into other
> > > > solutions, e.g. what happens if you use just nomux without any of the
> > > > other 3 options ?
> > > I tried a lot of combinations, but it was some time ago.
> > > 
> > > iirc: at least nomux and reset are required and both individually cause the lagging.
> > > 
> > > So the issue is not fixed by just using a different set of quirks.
> > Hmm, ok. So given that this seems to be the best we can do
> > the patch looks good to me:
> > 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Regards,
> > 
> > Hans
> 
> Afaik this patch never got merged. Sadly I still have no better solution, so
> I wanted to bring the patch up for discussion again as it still makes the
> situation better in my opinion.

Could you rebase on top of the latest kernel?

Thanks.

-- 
Dmitry
