Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512ED5ECCD2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiI0T0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiI0T0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:26:20 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BBC7A75E;
        Tue, 27 Sep 2022 12:26:17 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id u8so1225498qvv.9;
        Tue, 27 Sep 2022 12:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Kr7tLF2CC4J0CPLN4su6LZMbQ22kO06Sw9K3ve+dLaQ=;
        b=29JOFTwG1Kbl6c0ZIqVxhopKRdsWswrvLIgv7WDt1NHZnYmk31K9Zh48TYhCyYdEEV
         8Rbe85JSspcmaCTWK1DGx5OLXgKvWBc6zD7+cdnjWaHDk/4i1gnUufhvWGE6w8SmEjpt
         hfgWWIklFarxmsdd0OzDbqJxwv5lBdKyx+h3/LjZzcCY6fHJLgmuJVRdndL4BjI+uXel
         wLfQunrfrUUtotW9NRkV0QJniyGR8kK+UxAGDI95S2lboRv8RR6YXU6rf5bMe1FtTkT1
         Sqi9gJbOKSvmTChXJXFQurG0DpAq+ydClE//qDNf7elPs3hJ3TAON8PD1lecQxAzO6NB
         1KYA==
X-Gm-Message-State: ACrzQf10khQN6O3cBO8M9/+Azwjh1JEGn9LjVRCGh4Y40UqXpBP67ROD
        9YPpenMafdZFaFWfR1drhYw=
X-Google-Smtp-Source: AMsMyM7FkhH6qAETn9aEWbPttg/QMrgBH/EReDTzRL0iOrpvs0yI55k1big0ocPSz4jMfppFkpBNyQ==
X-Received: by 2002:a05:6214:d8b:b0:4ad:26cf:3d0b with SMTP id e11-20020a0562140d8b00b004ad26cf3d0bmr22646444qve.74.1664306776724;
        Tue, 27 Sep 2022 12:26:16 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::13c6])
        by smtp.gmail.com with ESMTPSA id q14-20020a37f70e000000b006bba46e5eeasm1478968qkj.37.2022.09.27.12.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:26:16 -0700 (PDT)
Date:   Tue, 27 Sep 2022 14:26:20 -0500
From:   David Vernet <void@manifault.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 6/7] docs: put atomic*.txt and memory-barriers.txt
 into the core-api book
Message-ID: <YzNOXO7K3QbwwL/t@maniforge.dhcp.thefacebook.com>
References: <20220927160559.97154-1-corbet@lwn.net>
 <20220927160559.97154-7-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927160559.97154-7-corbet@lwn.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:05:58AM -0600, Jonathan Corbet wrote:
> These files describe part of the core API, but have never been converted to
> RST due to ... let's say local oppposition.  So, create a set of
> special-purpose wrappers to ..include these files into a separate page so
> that they can be a part of the htmldocs build.  Then link them into the
> core-api manual and remove them from the "staging" dumping ground.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---

Reviewed-by: David Vernet <void@manifault.com>
