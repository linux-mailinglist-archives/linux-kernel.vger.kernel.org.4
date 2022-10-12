Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3545FBFDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 06:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJLEU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 00:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJLEU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 00:20:56 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B926AEA5;
        Tue, 11 Oct 2022 21:20:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c24so15171889plo.3;
        Tue, 11 Oct 2022 21:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrQZ7wkvPyfXPn4tQlrkO4jutsFSESCnUHTr1m5jM2w=;
        b=jPZucRVcWRQhMERl9IZVh0eg7TIEQmvuraV8RToTzaUJc96lrJ9WFRkxYvjDFqcFKr
         8Gno3FzzV64+/xmWdCXvtPJZdJ5z2Lypb8fp7G43pXxZXcaDeP6gkhUFLDCG/rIqAduk
         SZAFcXsiLXfsqquWpvAdKI3sWnbAOhb7MmMb4dwD4TzKsOGWnrU6gQ2sNO9JQIzKypUa
         zjJcWXrkmOMJt6t8Iv3lzWPaQAzEQyhBrRzt1+Y0dTexmmtlcEmIPMCVyDAIMz7TRQiD
         AVZ65Zu+h9/TfpnqdSOmv351k4u9EvQ7MYsWZp6DEMUmh4ZGIok4YX/jk8qugaQVep88
         KdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OrQZ7wkvPyfXPn4tQlrkO4jutsFSESCnUHTr1m5jM2w=;
        b=ZbHNxZGdn3ZdUFDxXfOQO9VoiRK4SIoZuE9u2kDrE1yWF54iXhMEHBrVvztcHbAa27
         718SejeomD5AoAcDIyI1NGcWfjE57UepsHGc8abP/c+2R9EeZ+NqUraeGLpERDV5PlYM
         7uYikHBjsQPV/BzsztEKnscaAY3SO8ZddE/TgZhYjNivNOAELSBZCXp9g+H0rtKKMLgK
         58EJk32aVIpH2BoYvTVwreFm9igD+OVcj4ZMaNeeUBhT8aHJbCn9JmHdM5ONM1dOB2JF
         CXG5SUuu9j1p2LMcIAOzjsUt5ZtfW6z+rxO7ML4yfCTakeWtg7u7Thp0CJGiO3XnmLiZ
         xafw==
X-Gm-Message-State: ACrzQf0dynn3sP5i7n3FnYsOnalmBnlSLG7dqaPikCsB6mJ6KDhNhyie
        HWEjSPlFscT2os24nYgw078=
X-Google-Smtp-Source: AMsMyM5ZCf5i1UFSBPBYhnqCdO0wkXA6bx1x+wVk74HOBPEakpPB5LFW+bUd0J9YyVjtYF08GFFGQg==
X-Received: by 2002:a17:902:ce8f:b0:176:e0b3:cf14 with SMTP id f15-20020a170902ce8f00b00176e0b3cf14mr27323864plg.153.1665548455045;
        Tue, 11 Oct 2022 21:20:55 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-2.three.co.id. [180.214.232.2])
        by smtp.gmail.com with ESMTPSA id p14-20020aa79e8e000000b005625f08116esm9840983pfq.68.2022.10.11.21.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 21:20:53 -0700 (PDT)
Message-ID: <6e30cfb2-b69c-b56a-bcd0-e9c12d984fd2@gmail.com>
Date:   Wed, 12 Oct 2022 11:20:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 0/6] docs: Improvements to our HTML output
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20221011190047.749145-1-corbet@lwn.net>
 <3c65451e-c9bf-55ea-02af-f375346c955a@gmail.com>
 <254fd34d-a234-7959-2bd2-bbc1ac45629f@infradead.org>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <254fd34d-a234-7959-2bd2-bbc1ac45629f@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 09:25, Randy Dunlap wrote:
>> Hmm, I can't cleanly apply this patch series on top of either Linus's tree
>> or linux-next due to conflicts on [1/6]. On what commit this series is based
>> on?
> 
> Normally Jon uses this (from the MAINTAINERS file):
> 
> DOCUMENTATION
> M:	Jonathan Corbet <corbet@lwn.net>
> L:	linux-doc@vger.kernel.org
> S:	Maintained
> P:	Documentation/doc-guide/maintainer-profile.rst
> T:	git git://git.lwn.net/linux.git docs-next
> 
> 
> Did you try that one?
> 

Hi Randy,

I can't fetch that repo (possibly blocked by my ISP), so I have to apply
against linux-next instead.

-- 
An old man doll... just what I always wanted! - Clara

