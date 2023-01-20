Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577786757BB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjATOs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjATOsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:48:25 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56D813B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:48:08 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id h184so2526603iof.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+Lc/1zOs9zVjQHKhj/q3DPuDq0fsxu5KJBIa3ZgDz0=;
        b=F6X/fBBtix+tLsbTSnmQZblZI3+ehsb1ZUayIZ6I2ExQpuL80xT5jFJkMf1Fh94JXC
         xuQ9vJbWyYb+oBcnF7dJVQcN/Lq5BY3ZUiawFiBzoX60GrqlrBHQK69XoGBJISplSsF/
         brIPj4QARDswce3X5hytAR4K03JCq/Ly2i7iftF1I4WZNOGNbLHfsQDoE6QLJEZkJVOG
         EvApY9owntBQtHv6eYJravOJGSxgfIXwJFCPVQ2vv2tLyhWZnTcpyGeJYmA9NPf++M5Z
         df0vwbwUKnrrmcnMjr7PQxFxRgTU11yCPhdywoW4ZNzhrfA4uIvxwFu+YQsd/anHFn/d
         WPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+Lc/1zOs9zVjQHKhj/q3DPuDq0fsxu5KJBIa3ZgDz0=;
        b=7pFTUSU1Fk9K+YfN8Vf8SOJSU4wf+kcfoj5N3yuTpHpLdenBzb5GT9fyiwzwGztNz+
         9hc4il1eiCqg++RSyMo5E0ziIMCjlIbaEKVmMqN7HXakrGEUhbW/jpqdRWLGWKGocWPk
         IvNDrPH6Y4xjMeM/6gPZArlW84dZmtAO0QE72j8An8jnwZfwapsfQoXoGe/f4lN+DC5R
         iSVyl2axXWH84iyx/Hg5QpyCveEUEYe36zIg87jg/e1D2Y+kUNprVev5NnzOoUllJHqe
         VSNAcQjZ61j3wDQZSRWWbRv3/kqKRRFv9ygiBXZm1k4UI6XfL/UouViqQNDxpEs+HGfy
         t51A==
X-Gm-Message-State: AFqh2kqLByi3cuWvLz1eRLTp/DBFRC9Tf005CfT4vGoQCGvvRUyBTQ64
        uW1aECEknntKq5bcoxhOhz8Lwg==
X-Google-Smtp-Source: AMrXdXtogZictV695TbJaegK+gXCUVsi8+6MjiLwTLota9MRj8LYfKhopUAqkym/uuBc3G2GkaqIPA==
X-Received: by 2002:a6b:8fcd:0:b0:704:d16d:4a59 with SMTP id r196-20020a6b8fcd000000b00704d16d4a59mr1985073iod.2.1674226087274;
        Fri, 20 Jan 2023 06:48:07 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c72-20020a02964e000000b00363d6918540sm12159847jai.171.2023.01.20.06.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 06:48:06 -0800 (PST)
Message-ID: <37406789-0743-0d34-e8b2-f0d456833df6@kernel.dk>
Date:   Fri, 20 Jan 2023 07:48:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [ANNOUNCE] 5.10.162-rt78
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>
Cc:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Pavel Machek <pavel@denx.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>
References: <Y8VSslRJZpFbo1/u@uudg.org>
 <40de655e-26f3-aa7b-f1ec-6877396a9f1e@ti.com> <Y8krsVFguwWLy+zT@duo.ucw.cz>
 <Y8lCspFtQ0wg6uCy@uudg.org> <Y8mwF0m+M1+e/fz/@eldamar.lan>
 <a4f62523-b01e-3986-7914-767f999b4153@kernel.dk> <Y8oNTkUVDr7iQWzp@uudg.org>
 <c427d686-c850-4195-011b-93f51faa176d@kernel.dk>
 <20230120100117.desy327bamo7khrv@carbon.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230120100117.desy327bamo7khrv@carbon.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/23 3:01 AM, Daniel Wagner wrote:
> On Thu, Jan 19, 2023 at 08:49:28PM -0700, Jens Axboe wrote:
>> I do wonder why I didn't see this in testing - the kernel build bot was
>> also happy with it... But anyway, should be an easy fix.
> 
> This is caused by the RT patch set, so you wouldn't see it without all the RT
> patches applied :)

Ahhhh, I totally missed the 'rt' part of the subject. Thanks, at least it
makes sense to me now :-)

-- 
Jens Axboe


