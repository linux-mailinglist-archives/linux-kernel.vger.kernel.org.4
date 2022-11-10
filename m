Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF002624E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 00:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKJX1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 18:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJX1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 18:27:15 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45E51C1B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 15:27:13 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v3so3018397pgh.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 15:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UcLMI3vp5Cvde9QY/uosm7zChP071vvBM9Ol4j5zGgQ=;
        b=oJigWOJ0qesBcbojzt/AKN1ejoq2v3WZQauPJ29KqPgb70flchvlvvCMvWk/yYxQpX
         cIk5hwZeGMM38ZqsDGO7fo1c/Aw5fvF53GAo9VKDNmpWyECpBY7qRwjzIS+37H9I0fdr
         lUGaYUCW9sSp9bPXoqub1WeZNHKRUxK3iYWDxUH5jGr2p6X38CLx3G6CR/bk0JbJXfFM
         nJewBn36OYygu2XavLysOng+JxK1RhQaL3+Ql6g/4D06tzOIMY2OR4wCb+c8y6NHFIuW
         SWRFFKqLOlPz8rI744/V20r5LCkqCM/6S69msyaMdZj0e7TxWqsykKna4ab1Hlhq4laa
         cLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcLMI3vp5Cvde9QY/uosm7zChP071vvBM9Ol4j5zGgQ=;
        b=UAPtVbYVuaJ4/Ra/MN274LUpzK6QViJgFuAYMqZPzuEnW2YCC5n9JnLfvTXSf24cY8
         GfJ3Hn5JD4z7CZk1lHMQUHCiUpvm0Mljyg7rwA36o1ee9QQ06ZXRv+9q0Mg3TCZX2KwP
         /FT13cOVJQmZmKz6i0K4gF0qPDweEQo62IsHyr8v1Wv5xHXZYYupaXh5i1DtzWa8nONM
         P3Tk4bXL4AMRkYgJlvOYfi3ZCmU+nntWbG0Hoc8pmuK5nDBccdJ4q0LP3/x94BKDRFV5
         pbGLN87JMR077x4b0yGTuYqoqytAKpwwXceusFieipNU+xXbqllcDEEO0f5yuK4TWZ3I
         cTrg==
X-Gm-Message-State: ACrzQf1od4tkRfm1M4Jv3SWTpXbWeDFfWxGmj5W4y3MMIfxFvTMENXY6
        TF1f+86f04yTFfPzGJNuznpV5Q==
X-Google-Smtp-Source: AMsMyM49ZzwICoNTFqxrfsSgYu6CBrhcjOCRNu6k96k9gDb/QsDNLbm+0OmozCBcR2NzrTWJpCDHkg==
X-Received: by 2002:a63:d62:0:b0:430:9008:4e0a with SMTP id 34-20020a630d62000000b0043090084e0amr3804036pgn.191.1668122832420;
        Thu, 10 Nov 2022 15:27:12 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id fa13-20020a17090af0cd00b002086ac07041sm315867pjb.44.2022.11.10.15.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 15:27:11 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:27:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/cpu: Start documenting what the X86_FEATURE_ flag
 testing macros do
Message-ID: <Y22IzA9DN/xYWgWN@google.com>
References: <20221107211505.8572-1-bp@alien8.de>
 <50b2113d-d6a8-ab36-028d-b78c41142c18@intel.com>
 <Y2okdzF60XHLCK2v@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2okdzF60XHLCK2v@zn.tnic>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022, Borislav Petkov wrote:
> On Mon, Nov 07, 2022 at 02:13:52PM -0800, Dave Hansen wrote:
> > It seems to be mildly warning against using _static_cpu_has()
> > indiscriminately.  Should we tone that down a bit if we're recommending
> > implicit use of static_cpu_has() via cpu_feature_enabled() everywhere?
> 
> Yeah, that comment is mine AFAIR. I was thinking of simply removing
> it as part of a long-term effort of converting everything to
> cpu_feature_enabled() and hiding static_cpu_has() eventually...

What about doing the opposite and folding cpu_feature_enabled()'s build-time
functionality into static_cpu_has() _and_ boot_cpu_has(), and then dropping
cpu_feature_enabled()?  That way the tradeoffs of using the static variant are
still captured in code (cpu_feature_enabled() sounds too innocuous to my ears),
and as an added bonus even slow paths benefit from build-time disabling of features.

Hiding the use of alternatives in cpu_feature_enabled() seems like it will lead to
unnecessary code patching.
