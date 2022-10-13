Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E165FD3E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 06:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJMEn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 00:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJMEnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 00:43:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FD5115421
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:43:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso4803875pjq.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JsHC8swQSZ5Fh6XAG3L1qnH+ruxn+bGz4WF3nlLiN14=;
        b=rBIFU4eRo/WpDg/QEh2oJxLGHZQB9RyNylwSEeOmWfhmViWkXHPnzgt/ooxvQxMAdB
         4W2jp6szEyHadTa3hJSosN09WQZEQc0IrUW8Sk/Z+FX4YQrACflpk8kBbzXMMz7rXFUE
         TR9LRp1pI/NezJm76CcNgizpKkFgBNXpYcTO/jXG+8f9dGkq4Fs6ki3Nz3zhULbKe5cW
         r78h5BfBMwBwvrre2/Bg0mWlECKuTreAMREvAChPAfdB9/cDzVqQmeTOwZJ46754QNiP
         f9Eq3xnYy03TPYl5CYuzv0q6sO26Ix2HgHqLv1VUAVE1VFNE3WrCRZjsBtm2MzOMDLQP
         +lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsHC8swQSZ5Fh6XAG3L1qnH+ruxn+bGz4WF3nlLiN14=;
        b=ZU9T7hZKauy9EoqFJ4ICnD6cfdMOor3ah2HWN1UZoyfwEwWN5SErIFkhH49vfR0BLY
         /1r15kg+iUQQ9kn7cdM/slfujP83pr35UjlQiIRLxoyl4ogwdAbb92cP7PXRh347CIOe
         pfnzv5D3k8Z5D6GMOwDIBWWjlNmHUTpwkTjf8+ttOR7uPJg6tl3kYv/6Ie7ktWDN58ec
         qSV5vohJaw+40eCFutnuejbeirq02aRSDQGrqXAbcCSI/IVNJV4ge7FUPV8CCL2R5kAi
         QhaH9qVz/OozXKL0yCniiEr24am51Biogswc8UewLr+mauqzNxTXg2IiNombuMsmx0l+
         oIVA==
X-Gm-Message-State: ACrzQf3b38OAi1g2nG9yNHtsWroGiI6kMCHykLUEfRTLbCMpi8zCWPDw
        b/mwCWszS5yCLK4F+tGRqEu+rA==
X-Google-Smtp-Source: AMsMyM5XRtwhaYB95jGH35Dz5kPov+mIJZSO8TpKLW4k/dJ2ZMmZudjH0qpr+vXhFbRgPhkDeVK6pw==
X-Received: by 2002:a17:90a:5308:b0:20b:1eae:c94e with SMTP id x8-20020a17090a530800b0020b1eaec94emr9018473pjh.88.1665636198670;
        Wed, 12 Oct 2022 21:43:18 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w68-20020a626247000000b00537eacc8fa6sm782238pfb.40.2022.10.12.21.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 21:43:17 -0700 (PDT)
Date:   Thu, 13 Oct 2022 04:43:13 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the mm-stable
 tree
Message-ID: <Y0eXYYG4FXbdNbYO@google.com>
References: <20221013104234.11e88852@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013104234.11e88852@canb.auug.org.au>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 10:42:34AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   db24ef4e6b0a ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> 
> is missing a Signed-off-by from its author.
> 
> -- 
> Cheers,
> Stephen Rothwell

Sorry this was my fault as I used a three-dash line to comment a code
section in the commit message. Which instead just cuts the commit log
short when applying the patch. Sigh.

You can see this in the original post:
https://lkml.kernel.org/r/20220930003844.1210987-1-cmllamas@google.com

I believe Andrew noticed this error and fixed the patch. However, the
Signed-off-by tag probably got dropped in the process. I'm unsure if
this can be amended in the mm tree?

Thanks Stephen for flagging this and apologies Andrew for the trouble.

--
Carlos Llamas
