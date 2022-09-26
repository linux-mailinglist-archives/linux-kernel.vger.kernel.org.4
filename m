Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB35EB2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiIZVJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiIZVJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:09:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B010A3467
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:09:13 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id l65so7905418pfl.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=z2N8LaF32sVo0MzpvnaJgrHDNgj6iB+hPRs2AGkWfto=;
        b=iNU6fF1RWdROt/mKhKh4y/8mQA0kXSsvh1U2vUwg0opVJI50FrW0nhkdSisbS+YFN9
         B8Gv0OIsH5ynOXaMK89XrVLTRyEeZ4gikeERElQneRjRrgHWrUGTYPtORP/zSK1VOOZj
         wsqw+bXF8lV8ERMgHOCH+e2L1ZvocMDhekVx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=z2N8LaF32sVo0MzpvnaJgrHDNgj6iB+hPRs2AGkWfto=;
        b=4io3cfj9Y2TMAFCqSygHU+eJWZ86Ys6UoSDZSbrLfKU2vxtUsGBFKvQKaWztO9hevl
         03PbbXwymfsZ0royXjcmQaQ/z7hzx2LTI3eVGnV3qjlBuuo8Z/c7YUOT292zzQgLPLOO
         wvtPf49OoKTY3ZPdxw17Z3W+7Jf3oAWoJCINoF5HLRC3PxTXqQCCiyb/gZFKGnIY4L8d
         rHM1D+eFAXTDWyf4OM7d14ihogWdyMFgzHQTQ9detgf931KsPdEI+15VOryr8c76sunv
         n8C6reNoNgs4dyAlo4Eacatq91XjYDwKupwKMeTMoXuVn7CDApVK+K+IQ/s9j6Z34DEz
         i+sQ==
X-Gm-Message-State: ACrzQf39JIbKN/207HogCiZJcp83CXu1f8jP+FCTPioknfENo6BOXITS
        FBqddy9IyNThfRMVUNAjuzey5A==
X-Google-Smtp-Source: AMsMyM5WIe3hqBa57RBis752CH191gAYntlDiD5fJNhEuECKTcn7TB+Nt6Sb9VomPqk1ExNiN3sNcg==
X-Received: by 2002:a63:3348:0:b0:439:db24:8b02 with SMTP id z69-20020a633348000000b00439db248b02mr21236503pgz.425.1664226552446;
        Mon, 26 Sep 2022 14:09:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p7-20020aa79e87000000b005459e8a103asm12569831pfq.167.2022.09.26.14.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:09:11 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:09:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: Fix kern-doc markup for functions
Message-ID: <202209261408.59F78C0D@keescook>
References: <20220926194713.1806917-1-keescook@chromium.org>
 <YzIUS/+H2YA7RBvA@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIUS/+H2YA7RBvA@casper.infradead.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 10:06:19PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 26, 2022 at 12:47:13PM -0700, Kees Cook wrote:
> > -/** check_add_overflow() - Calculate addition with overflow checking
> > +/**
> > + * check_add_overflow - Calculate addition with overflow checking
> >   *
> >   * @a: first addend
> >   * @b: second addend
> 
> Why did you remove the ()?  And why didn't you delete the blank line?
> According to our documentation, the canonical form is:
> 
>   /**
>    * function_name() - Brief description of function.
>    * @arg1: Describe the first argument.
>    * @arg2: Describe the second argument.
>    *        One can provide multiple line descriptions
>    *        for arguments.
> 
> I don't usually complain about people getting that wrong, but when
> people correct it to be wrong ...

Hunh, everywhere I'd looked didn't have the "()" (which seems
redundant). The blank line was entirely aesthetics for me. If it's
supposed to be without a blank, I can fix it up everwhere.

-- 
Kees Cook
