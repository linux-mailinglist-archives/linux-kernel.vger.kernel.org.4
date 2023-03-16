Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4926BCEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCPMD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCPMD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:03:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6296A6D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:03:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eh3so6536595edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678968235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlpeM5UguksmXESG0oRb11EaXAJOpN9tS9q1lJArhJQ=;
        b=JDPEEgm2VfHy9iCZT4/fnPcLSzoP4unFp6RLVhbnGDcIt56+r0ofQizctvGDPHnC4h
         Isfq2bmUDep1orRzSWR2pcjFH3TNyMdSI2rFkuEB7ycxKtBLE1/J/NAXYkYj6NwNU07T
         7RMv6EHiv1nf9/XuQgDGmKHktvnTqpkyuOrX/KEY3yn5MrHOUCewNvlzC/oF6PhuWYus
         evCd/OigZNfCS3/WygWJTCxRs6YwVCc1E6GyGn7fB+GZH/CxNBlBdDv7tR4DSPxgI5aL
         MSk29fEfAzJ/TxQyiavCfEukRsadc3QpGpuaeFKb/lqCFoMsuoRKG5gqY+jqvppg2LRa
         LpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678968235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlpeM5UguksmXESG0oRb11EaXAJOpN9tS9q1lJArhJQ=;
        b=KaJ6F7sZVJG/aYy1iR1ybuYtBl92vb/VbwrD7tBb5ZR7l4M2M8GZVaCuLLwVVxM25F
         nF7UfTh98itXD2OqbkWAUzftnlhFRL5QhexYV4Lwd5D7Fzw5GQUlEjgM1NHHcK9oZqxf
         lBOEqJSoZfd7dy8Qu3dvo3SdjV5FVbogjHvCZubb1n3l7NZLfDskfYqEKA4z6NbcvABv
         P8sayw8MBzvkYJcHi9rBapqVx779G86Fl4mZjWE/wzW7a7Kdzbt0tPynYlQJukNNZUXP
         rdePjreQNIvs1Nm2ANsmFnXIbAzTJ6Q5OO+vw/QwR9XSmIj8J7Yyh7PZFpPmpiUM5ZWQ
         p4cA==
X-Gm-Message-State: AO0yUKUqjiQ09a3W1HBZs6PytdVC4woxu8bUe9mUPC9VpMNsnSerCE46
        2lkYmZPei2wQOmwgEx39+go=
X-Google-Smtp-Source: AK7set8S05CDQKjQ5gYxFTUel7gKHxL7+STiiRFF0iHPqzYWoEH3WZUr/hulMkZpdlRqMW6u/v9UQQ==
X-Received: by 2002:a17:906:a215:b0:889:b38b:4bb2 with SMTP id r21-20020a170906a21500b00889b38b4bb2mr9623247ejy.49.1678968234967;
        Thu, 16 Mar 2023 05:03:54 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.209.88])
        by smtp.gmail.com with ESMTPSA id tk13-20020a170907c28d00b0090e0a4e1bacsm3740039ejc.159.2023.03.16.05.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 05:03:54 -0700 (PDT)
Date:   Thu, 16 Mar 2023 17:03:52 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBMFqDWuZQdg3YP3@khadija-virtual-machine>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <3096768.uvML7RA1vL@suse>
 <ZBLmev7BaIhYQXIz@khadija-virtual-machine>
 <1797409.3VsfAaAtOV@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1797409.3VsfAaAtOV@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:13:23PM +0100, Fabio M. De Francesco wrote:
> Khadija,
> 
> I'm not yet sure whether or not you are doing well with reserving 13GB to a 
> VM. First of all you should better use multiples of 2GB. Furthermore it looks 
> too much memory unless you have a total "real" RAM in your host exceeding 
> 18GB. You must be sure you are leaving enough room for the Windows host to run 
> smoothly and avoid too much swapping to/from disk.
>

Hey Fabio,

I have 16GB RAM. I just chose the highest option that VMware
recommended. My Windows is running smoothly. 

> At the same time I doubt that you can reserve 8 logical cores (2x4) for 
> running the VM on VMWare.
> 
> However, we have time to investigate and adjust your configuration (if it 
> really needs to be fine tuned). I'll try to reach you on IRC, open a private 
> window, and assist with this task ASAP.
> 
> At the moment I'd prefer to see you focusing on getting your first patch 
> accepted by Greg.
>

I am working on the new [PATCH v5] as I was able to remove the warnings.
However, If you still think that we should work on the configurations
then we can start working on it. :)

Thank you for all the help.

Regards,
Khadija



> Thanks,
> 
> Fabio 
>  
> 
> 
