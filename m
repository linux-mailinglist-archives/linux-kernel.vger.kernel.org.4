Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5766769C6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 23:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjAUW1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 17:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjAUW1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 17:27:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880FF144AB
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:27:41 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q8so6487539wmo.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GmylMIf3aHHkmi/5Sgb1izWdeS450WFaci3rWz8JdqU=;
        b=xzmKZS6u0wrFE8ox6tf7GOh2HslQvWiNbPqZ53x8nMyY3vle1x3/Dz+saInnGOudr4
         4lV+dRdB+izyXtee65ybT5JcZ3Hhs44q2u+5Xkf3x6JH2ya9zzgRJFyhDYLJnLEj9zJ4
         wqDb+DEEtzPn6XTC08L/Cvl6uI9dqdk/MrM5S25sHM4FMpkjuKS98ljD2UWzRxnWpjiu
         S41h1H7sBX6nYbf2d1QDQQvbvg4VwCq7hkir6apA86whDAeUddUegKjxUW1WFA0vdAYH
         8pKMs+f3wN+dqQEOj9j/1I93wA+99uFRbS9DLK9K7OPPQcESHE8f9g2BzWB6nBazMW62
         r7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmylMIf3aHHkmi/5Sgb1izWdeS450WFaci3rWz8JdqU=;
        b=CcDqhouuooaDXljraIuPPYGO8PthIXA/q9nrRFsdm6P/nCNfd3pdQUZ+8XA5p4XLcI
         10eED0hyloRH+KAYN0aeppseC93BYM3EjLKgPkvf31U4X682UmXPpLbf5ze5Q/kxjPAc
         AkJ1F4jgQB23AmTWFb3lj7LYcPTPqU/la4C2v8tG+NjY3Z1vaYHtxxNDH+Puov9Be2fL
         morYCdUUGZVSWOMydLFw2KFN03j5c6gHS9urFaIF1vx43V7K6rH9txgTrUJzuVS5oL+3
         zeDPFhZ+kYwWyHK8bUXENtLHoiCATx5WNm8bAiNVh5JtVeRORELnuRD4TFhWi3Gp9Hfk
         WXfw==
X-Gm-Message-State: AFqh2kr0qqUOY0mqv94te5fOOftBY3VmA7OOhOkhnml7R3Og7qPkFIwH
        LwErLIAgHWxhSLP36hngnVJDdQ==
X-Google-Smtp-Source: AMrXdXvbFnSebCeGuRQDNyfSvRAHW+VudjwMJvppK1u+fO9MDIqBBQLW0z0PbxGLW7l0UuUQKA08CQ==
X-Received: by 2002:a05:600c:540c:b0:3da:fa18:a535 with SMTP id he12-20020a05600c540c00b003dafa18a535mr18857447wmb.29.1674340059896;
        Sat, 21 Jan 2023 14:27:39 -0800 (PST)
Received: from [192.168.0.26] (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003db0b0cc2afsm6985243wmq.30.2023.01.21.14.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 14:27:39 -0800 (PST)
Message-ID: <2366a482-404d-7288-a25d-e847ba2d9161@smile.fr>
Date:   Sat, 21 Jan 2023 23:27:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] Documentation: kprobetrace: Fix some typos
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230121142242.1706081-1-yoann.congal@smile.fr>
 <20230121143110.1706962-1-yoann.congal@smile.fr>
 <20230121122519.17eebdc9@gandalf.local.home>
From:   Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <20230121122519.17eebdc9@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/23 18:25, Steven Rostedt wrote:> On Sat, 21 Jan 2023 15:31:08 +0100
 > Yoann Congal <yoann.congal@smile.fr> wrote:
 >
 >> @@ -76,14 +76,15 @@ or 'x64' is used depends on the architecture 
(e.g. x86-32 uses x32, and
 >>   x86-64 uses x64).
 >>   These value types can be an array. To record array data, you can 
add '[N]'
 >>   (where N is a fixed number, less than 64) to the base type.
 >> -E.g. 'x16[4]' means an array of x16 (2bytes hex) with 4 elements.
 >> +E.g. 'x16[4]' means an array of x16 (2-bytes hex) with 4 elements.
 >
 > As we are correcting this, let's correct it correctly ;-)
 >
 > Adjectives do not turn into plurals. It's "2-byte hex" not "2-bytes hex".
Ok! Will fix and send a v3.

Thanks!
-- 
Yoann Congal
Smile ECS - Tech Expert
