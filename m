Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFB7618E0D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiKDCOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiKDCOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:14:49 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA98DF;
        Thu,  3 Nov 2022 19:14:45 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a27so2359740qtw.10;
        Thu, 03 Nov 2022 19:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiXbD2YNom6J2OrmtFTyJbyPTSCOMGbOUhnw6jGU9lU=;
        b=ETf7kDJ50UOqPVrffNb+QK4IELw0nXYZL4kOtjiTeV0IRPvUCEtJX3Z5PZqXeagYwl
         4j8UNqpXQ8JSvIHGzXvZ4XBsdgv4EZGMtmgwh1BkAgPD7rY6AnEDumIyaPp3GqEkNuZM
         3YLi3jTHxfCEnWeCTQ8rnXx+WieHJETRYB0XXQty2gU3cNJHeTOOdMgD+72gaWXo6Lj0
         Yw88ts44TbOT4VtuZzYcQOmlV3p661dfJoEfcIuoq1Lu3o8DsSzJv7MXxKtkBcG3wz85
         fhYAj7aBjk24p43zhSXWzh6wMrFHRXTcReHe5GlJtHfK0Tg0a/IBr600V+XvIF6SBUDr
         O+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oiXbD2YNom6J2OrmtFTyJbyPTSCOMGbOUhnw6jGU9lU=;
        b=x1A1oeFcRi/s/MMtG71hVReAPwE7lmjuyvNXzluPIxQXMgFI3XJUJXHc4h7w6SbL3h
         lRIWEBjrH1BICbcBvWnfOyE/E0mdLYU7jHRzlUxZHBWKdsDpBQiCJ82V2tk1BEIS3etK
         +yxfZw++nIX4oEjnnMAH/JAzVQjXRbD6Sc2DNAKU7M9x7vT/Ozt11EtaSf7n+A76BdY/
         Qe5IDExsaJyjcu4VtVDT+cwm+zyiBvZdrxYpNmhKqvzWWK/ZnJKO+q1hxzBCTYCCVUh8
         sHyPs39JdFfd7MXlwW7wp9zu4/v5JCepr9wDvYuGKruKdMekdkfLX4wlYypE2N85NHU3
         Y6ig==
X-Gm-Message-State: ACrzQf1SI4u26Zk60o2oEsFnu5hDI8zLRu+zp0p2uOfV/SCbHXOOGNYg
        37jiPGXiqP7vXjpFHpg7E0ruQLM4XtSy
X-Google-Smtp-Source: AMsMyM5caQt1ApaRDPX3jHlmgcvcoWlZC8MGZdIr1E4SRBxvfyBUwVA3DgO73fDJtjnwPUW0ugfvUg==
X-Received: by 2002:ac8:541:0:b0:3a5:2710:4a5c with SMTP id c1-20020ac80541000000b003a527104a5cmr20222499qth.101.1667528084663;
        Thu, 03 Nov 2022 19:14:44 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a455000b006fa313bf185sm2000859qkp.8.2022.11.03.19.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 19:14:43 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d43d:2899:6e28:9931])
        by serve.minyard.net (Postfix) with ESMTPSA id 5EF28180044;
        Fri,  4 Nov 2022 02:14:42 +0000 (UTC)
Date:   Thu, 3 Nov 2022 21:14:41 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Corey Minyard <cminyard@mvista.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ipmi tree
Message-ID: <Y2R1kdOS7pHaEtBV@minyard.net>
Reply-To: minyard@acm.org
References: <20221104124840.51ab5b5c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104124840.51ab5b5c@canb.auug.org.au>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 12:48:40PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the ipmi tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/char/ipmi/ipmi_ssif.c: In function 'shutdown_ssif':
> drivers/char/ipmi/ipmi_ssif.c:1276:9: error: implicit declaration of function 'del_timer_shutdown'; did you mean 'device_shutdown'? [-Werror=implicit-function-declaration]
>  1276 |         del_timer_shutdown(&ssif_info->watch_timer);
>       |         ^~~~~~~~~~~~~~~~~~
>       |         device_shutdown
> cc1: all warnings being treated as errors
> drivers/char/ipmi/ipmi_msghandler.c: In function 'cleanup_ipmi':
> drivers/char/ipmi/ipmi_msghandler.c:5547:17: error: implicit declaration of function 'del_timer_shutdown'; did you mean 'device_shutdown'? [-Werror=implicit-function-declaration]
>  5547 |                 del_timer_shutdown(&ipmi_timer);
>       |                 ^~~~~~~~~~~~~~~~~~
>       |                 device_shutdown
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   306ab2918b4c ("timers: ipmi: Use del_timer_shutdown() before freeing timer")
> 
> I have used the ipmi tree from next-20221103 for today.

That patch shouldn't have gone it, it's fixed now.

Thanks,

-corey
