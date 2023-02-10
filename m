Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060C0692046
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjBJNzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjBJNzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:55:09 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09531C5BC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:55:07 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id v17so5744372qto.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XIPHxCMD5tFxCkQNamP1KwgZXhCO9JHa2zZcUYu+zE=;
        b=VNcwhXzklTCDhx2S86opLFevpUQrSXsNC7sI++lkeosdSuacvHF4EvNMIPrUVcmLE1
         ypJKr8JzEzAy57MLSz/EZH7+C7uCM+nJmskifqnbM7DCEmskPOnabBlRxkK5gtPJ0OQt
         BEOuhg04dExP0J0eYFixdeZx4sQjcYYvx6Dd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XIPHxCMD5tFxCkQNamP1KwgZXhCO9JHa2zZcUYu+zE=;
        b=s5cF2ka8A9sohrYSR2Mzflh0PBjk1zeoXhK5UdA8sy6gNhMe4+rkNQ4j0BQTaOp/az
         b2pXRPyFTIVt7noYPu+M7JsJL6rapAC9G9+zTnTPHSu+2XuPjb+7uPUK7q4xpfTA/Emn
         NswSXywRy52RAdf8H+YhEj1ZfumDm2EdbL6KV9bffgimUjiIowKmKvWqnb+uh9O1qTm1
         DRnNf2JjJM9qsWC0DrjUq9WC6FJRdzxTQWgZfnqR5zhUfFTknVDV0jNB29fklQ1kLbOf
         Dvf1Z8enHN2pFDN6CX/sbO7DMfQpUShtIXvLk/kp7FzlDvUvGfiwmrbj0xFvmqzop7a4
         1hFg==
X-Gm-Message-State: AO0yUKUS6zrccdTAJ7owi5XlFmhULkijEjpTEu9j1SBVy38zSrt0OcBw
        +VBYEh+GGe86r8+/ZaIwJkaynQ==
X-Google-Smtp-Source: AK7set+iuUVYVYSZfmqGNHWnygiBBmIGdActv8aFlM3YnnhwYp9+961GSvD8pgsm7nxBy5K7wkLKkw==
X-Received: by 2002:a05:622a:5cb:b0:3b8:6814:ea20 with SMTP id d11-20020a05622a05cb00b003b86814ea20mr26686495qtb.67.1676037306852;
        Fri, 10 Feb 2023 05:55:06 -0800 (PST)
Received: from nitro.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id c26-20020ac84e1a000000b003a5c6ad428asm3281450qtw.92.2023.02.10.05.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 05:55:06 -0800 (PST)
Date:   Fri, 10 Feb 2023 08:55:04 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1] docs: describe how to quickly build Linux
Message-ID: <20230210135504.jg7tmqhdmhfwdz5t@nitro.local>
References: <fabdb45fa44db2531f0dbe5e88545c49dfb87040.1675252073.git.linux@leemhuis.info>
 <1f217c94-b90f-359a-2142-0d3ae5d84fc6@leemhuis.info>
 <66fc12cd-65b6-0831-89a8-57636453883b@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66fc12cd-65b6-0831-89a8-57636453883b@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:38:07PM +0100, Thorsten Leemhuis wrote:
> Downloading the sources using a full git clone
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> If downloading and storing a lot of data (~4,4 Gigabyte as of early
> 2023) is nothing that bothers you, instead of a shallow clone perform a
> full git clone instead.

As a minor segue, we know we can dramatically reduce the size of the stable
repo (and the stable clone.bundle) if we drop all branches and tags for old
EOL releases and move them to a separate repo (e.g. stable-eol.git).

I have suggested this in the past, but it's not a trivial change:

- it requires a fair amount of git work
- it may disrupt some of the build infra around the world still building EOL
  kernels (for whatever reason)

In my preliminary tests, we easily dropped the size from 4GB to under 3GB.

-K
