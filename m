Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDA05EF9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiI2P7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiI2P73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:59:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD721D05E9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:59:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w20so1604243ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=OMBU0E3rBwVLpdnESWIpXBaqoayQue7L0QHmCU0mV5k=;
        b=lN7E1wcWbcDjAnu84JSmhcWkWfNcBaDemsedDvLY941G37ojljZ7+qWcx4MRKZn4At
         ZQ3xhLvnvfooYdZgJEVPFT8FgUqgHExEhGGmZr3/pwnBx1vfCKYt2GeZvlF47+X2A29O
         LxWxYAqp/dcbJmZ7zyJy3Bo4Palnclw9iRVHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=OMBU0E3rBwVLpdnESWIpXBaqoayQue7L0QHmCU0mV5k=;
        b=RCUUC1XhPqcRnDRm27OA4Dua2U2VTC/oQ7p4JYhJs3ZbihrsVLAg2l2Rx/k5Je8UO2
         +DPk4ojaW1/7SJPUUzOrT6JHBzs9yH2cOWAdg8wQdTjYSLQ2PVlVHoSn85KN6J4xYxBS
         yOiy2JFdQcqTFSMqz0UvdXxrLlKWlDa/uUYIsJ2lma4oCmRIIKfMFkcUyZhBXPFquulD
         yaOWiwMjFm23VZll9svbTnuiU1NkqRMmR8IOY6wITnwPEuiZJHsA7PWs5FpFG7SYe88i
         3hIMNc/p9NYw0sIh8GOVTdpLbmq446n1ofony0J7WuHlK+QnytDpPWrUPtS+oA5fp8C2
         CSnQ==
X-Gm-Message-State: ACrzQf21QTwCp0ukgfWfADS+E6SOAqBOFMJDOAq9YeA3Ia6IoG0vOPDV
        IeupEYzgDGuqUddXUghp+xB15iHetwWamg==
X-Google-Smtp-Source: AMsMyM7q0DV47G5Pc+m5fG9Z+UvBqj0E617XkyNG23EBh/pYVn1W5jKnv7vAWOc3XwtTDou50A2nWA==
X-Received: by 2002:a17:902:6542:b0:172:95d8:a777 with SMTP id d2-20020a170902654200b0017295d8a777mr4050426pln.61.1664467168058;
        Thu, 29 Sep 2022 08:59:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902dcd400b00178a8f4d4f2sm56544pll.74.2022.09.29.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 08:59:27 -0700 (PDT)
Date:   Thu, 29 Sep 2022 08:59:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v3 0/7] Rewrite the top-level index.rst
Message-ID: <202209290858.4A3FC9082@keescook>
References: <20220927160559.97154-1-corbet@lwn.net>
 <87mtaii491.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtaii491.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 09:34:18AM -0600, Jonathan Corbet wrote:
> Jonathan Corbet <corbet@lwn.net> writes:
> 
> > The top-level index.rst file is the entry point for the kernel's
> > documentation, especially for readers of the HTML output.  It is currently
> > a mess containing everything we thought to throw in there.  Firefox says it
> > would require 26 pages of paper to print it.  That is not a user-friendly
> > introduction.
> >
> > This series aims to improve our documentation entry point with a focus on
> > rewriting index.rst.  The result is, IMO, simpler and more approachable.
> > For anybody who wants to see the rendered results without building the
> > docs, have a look at:
> >
> >   https://static.lwn.net/kerneldoc/
> 
> So I think I'll go ahead and drop this into docs-next shortly.  Thanks
> to everybody who has commented.
> 
> This, of course, has the potential to create conflicts with other 6.1
> work that touches Documentation/index.rst.  Amazingly, as far as I can
> tell, there is only one linux-next commit touching that file - the
> addition of the Rust docs.  We'll want to be sure that doesn't get lost
> during the merge window.  I'll be sure to include a suitable heads-up in
> my pull request.

I can add a note in my PR of Rust too -- how should I suggest it be
resolved?

-- 
Kees Cook
