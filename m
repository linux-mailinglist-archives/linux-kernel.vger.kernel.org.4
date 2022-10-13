Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C105FDC54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJMOVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJMOVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:21:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78733DCAEE;
        Thu, 13 Oct 2022 07:21:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 204so2059067pfx.10;
        Thu, 13 Oct 2022 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcOtwnIKDIYhDLNa+tjdb7hspR/G57m1UnHPm7nh87c=;
        b=Sg9P0zLb9j4BU/7R6DGShqJLgQ4ld7/cew4KUXy4Tj0p1wM8y2Q5FEjLwM4wiZoMU1
         j2QmZSfDfw846N6CakwAqYSXTjBNYBsrMAL3Lf2iujHeWhCgxugLopjWKT33oUKRCNfJ
         FuaVzroHoFdbsnFfr47qOBW/YKs8gAdl/x8fP4PAg6cNAybD542eOCtvG8T+hawk1yLw
         ij2K20AUQgWdj6eQNStls1CvB90pF9t980QJ2Y0oZOinszfnhhvGRzhfzvg6dMXQQ5EC
         vsPkSTGh0K+g7gjvMucYbij/Wr6FrFMsWbmq14a3BamLVtln5paDxmRW3P2a+yhnXA76
         nrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcOtwnIKDIYhDLNa+tjdb7hspR/G57m1UnHPm7nh87c=;
        b=qevlyPtADjPoC16LDvbnnYe0pD3lyNBHSXDV9kFBu9IFXcWVOQZgSRDIGxUIiXH58d
         kQHkpf/CYTXifHE7uv1wf1fbdh9d2EXl3yYU8QW1dsDGPMY+sbSQu45puQvsVirgU4C3
         VCtEjNgHeROAQn0MkKACXOi1GtIXNSd0oxqPcQuSKMMdvN31WvzvkfbXVubIWW9fbGdC
         ELosy8+jT/LgxhAY+6/BTS+s+gdZMTB7rygheP4h3UwNBgYFdJv9owY69JUSgrLTiTMm
         4FpTq0XUNVN8d5cvk/Wyw/UHNjCXWePu0dZF2LaGIWBR4+hmSyOFsQJvoUILwW+a20tF
         H6WQ==
X-Gm-Message-State: ACrzQf0eFrqtG7WW8MjNZMQQCctCUWXYWZr2eh14RKNiz7uCNgsSHJNk
        boYSE9Ggt1TlwFj1Ktb+uBs=
X-Google-Smtp-Source: AMsMyM5ESnJ1JrQczDW0yQRD/dOUJfZnh9/0VlsUVCm8pyVJc6gIkpMp1ylsMCwOI31HHd7iF1LG5g==
X-Received: by 2002:a65:580a:0:b0:439:befc:d2b0 with SMTP id g10-20020a65580a000000b00439befcd2b0mr121704pgr.302.1665670889890;
        Thu, 13 Oct 2022 07:21:29 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id r18-20020a170902e3d200b0017f75bc7a61sm12591253ple.166.2022.10.13.07.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 07:21:29 -0700 (PDT)
Message-ID: <89120a24-f622-eb9b-fde9-635caaabb67f@gmail.com>
Date:   Thu, 13 Oct 2022 23:21:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     bagasdotme@gmail.com, jani.nikula@linux.intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Randy Dunlap <rdunlap@infradead.org>
References: <87h709md2c.fsf@meer.lwn.net>
Subject: Re: [PATCH v2 0/6] docs: Improvements to our HTML output
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87h709md2c.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Wed, 12 Oct 2022 06:38:51 -0600, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> Hmm, I can't cleanly apply this patch series on top of either Linus's tree
>> or linux-next due to conflicts on [1/6]. On what commit this series is based
>> on?
> 
> docs-next, which is still running off the pre-6.0 base until after the
> merge window closes.
Hmm...

Actually, I can't apply 1/6 cleanly on docs-next, either.
As I have your tree in my local repo, "git am -3" worked and pointed
out there is a merge conflict.

It turns out that one of the hunks in 1/6 doesn't match what could be
applied cleanly.

[From 1/6]:

------------------------------------------------------
@@ -371,7 +393,7 @@ html_use_smartypants = False
 
 # Custom sidebar templates, maps document names to template names.
 # Note that the RTD theme ignores this
-html_sidebars = { '**': ['searchbox.html', 'localtoc.html', 'sourcelink.html']}
+html_sidebars = { '**': ["about.html", 'searchbox.html', 'localtoc.html', 'sourcelink.html']}
 
 # Additional templates that should be rendered to pages, maps page names to
 # template names.
------------------------------------------------------

What can be cleanly applied:

------------------------------------------------------
@@ -371,7 +393,7 @@ html_use_smartypants = False
 
 # Custom sidebar templates, maps document names to template names.
 # Note that the RTD theme ignores this.
-html_sidebars = { '**': ['searchbox.html', 'localtoc.html', 'sourcelink.html']}
+html_sidebars = { '**': ["about.html", 'searchbox.html', 'localtoc.html', 'sourcelink.html']}
 
 # Additional templates that should be rendered to pages, maps page names to
 # template names.
------------------------------------------------------

There is an additional period at the comment of:

> # Note that the RTD theme ignores this.
                                        ^
So if you remove the period first, you should be able to apply the
patch set cleanly starting from docs-next or linux-next, I guess.

Sidenote: I see this warning when applying 5/6:

  .git/rebase-apply/patch:18: trailing whitespace.
      margin: 20px 10px 0 10px; 
  warning: 1 line adds whitespace errors.

Hope this helps.

Akira

> 
> If I need to post another round before merging I'll drag everything
> forward to a more current base.
> 
> Thanks,
> 
> jon

