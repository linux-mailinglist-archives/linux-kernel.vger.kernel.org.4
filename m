Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730C374628C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGCSfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGCSfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:35:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07F91A7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:35:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8918dadbdso7841475ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688409339; x=1691001339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bUmtkPfGFGLt/sWqyxDB3seIbhKCcY0ouJFur5sT6is=;
        b=T3xfRpMZUBrRfRyVx/RvzEmOyeERM4oSUVGO+qOoivWCgbOAFaQmQo4cY/xiie+cay
         nad8N913HoffqJe8j0NmInCTvMDNeC2XRRK5qs/rq0d4i75H3KuXwTApYMvrU3Tlld3Q
         2hVUeub3JzmYokqGbjoCg907XEIogd8u7b+8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409339; x=1691001339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUmtkPfGFGLt/sWqyxDB3seIbhKCcY0ouJFur5sT6is=;
        b=JbQFspfD9oo+Vmxp71AdDTi9xVdOB3/MV+BHXTTKyiRYcSOIdfdA05LwAIRZvXT5Gw
         RU1W0JCp3DRFzD/Oy3cEeCxJ9cZVPCQJk0vQd3XYruAL9YDpZWwuc1vHk59ljDm6cyYq
         l7E2qSpQzqbdEyvm70nbHCfBCYxB1JaCh/1UdnFDrviI3ppvh1msastlIQ0LXh0299t+
         hsqRATg+vnglXINHsV9DZgKc6JijsKDevlRXv6AGgsrda84nOehhzELyoYxtnUDrCTHt
         NHlmWW0c+ztf32CafEi3ANoBcPqeAcdvHDE9ZtOkFlIN5f6Qs5PqSaGwyld3ea44TPPW
         DK4w==
X-Gm-Message-State: ABy/qLZzqtdN28Ro4L349s33r3Qri0hkdFMukIwTPbqFM0pjzA++oO6B
        ploIgUEocTGURt7/YGzBOMhVRQ==
X-Google-Smtp-Source: APBJJlE0gEja4grNegOCxc+0vth+lPOPSiYX92TLbp6hq3tCxb8WUto6r2gI8npoQ6pZD8Ee1nBiVQ==
X-Received: by 2002:a17:902:efd6:b0:1b3:fb76:215b with SMTP id ja22-20020a170902efd600b001b3fb76215bmr8489185plb.48.1688409339122;
        Mon, 03 Jul 2023 11:35:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902a5c400b001b077301a58sm15603963plq.79.2023.07.03.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:35:38 -0700 (PDT)
Date:   Mon, 3 Jul 2023 11:35:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, security@kernel.org, corbet@lwn.net,
        workflows@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: security-bugs.rst: clarify CVE
 handling
Message-ID: <202307031131.51907BC65@keescook>
References: <2023063020-throat-pantyhose-f110@gregkh>
 <2023063022-retouch-kerosene-7e4a@gregkh>
 <202306301114.E199B136@keescook>
 <2023070213-capacity-moneybags-3668@gregkh>
 <ZKJJoK4kyOCEYcOR@1wt.eu>
 <2023070335-groggily-catfish-9ad5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023070335-groggily-catfish-9ad5@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 05:00:15PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 03, 2023 at 06:08:00AM +0200, Willy Tarreau wrote:
> >   The security team does not assign CVEs, nor do we require them for
> >   reports or fixes, as this can needlessly complicate the process and may
> >   delay the bug handling.  If a reporter wishes to have a CVE identifier
> >   assigned, they should find one by themselves, for example by contacting
> >   MITRE directly.  However under no circumstances will a patch inclusion
> >   be delayed to wait for a CVE identifier to arrive.
> > 
> > This puts the responsibility for finding one in time on the reporter
> > depending on what they expect, and if they want it in the commit
> > message, they'd rather have one before reporting the problem.
> 
> Oh, nice wording, let me steal that!  :)

Yeah, this is good. The last sentence is a little hard to parse, so how
about this, with a little more rationale expansion:

However under no circumstances will patch publication be delayed for
CVE identifier assignment. Getting fixes landed takes precedence; the
CVE database entry will already reference the commit, so there is no loss
of information if the CVE is assigned later.


-Kees

-- 
Kees Cook
