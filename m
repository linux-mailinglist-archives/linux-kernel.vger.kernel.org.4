Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BD4618A6D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiKCVTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCVTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:19:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D9D1A04C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:19:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n12so8613379eja.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImDG//sNXg/oy5XZPOuBFIhl7k6YK/gX5hImljVQwNU=;
        b=i7qVVi6QJzHOHsEyF2H3U4f5BeR1vqQ/kDwBUG+qLwh2CKBdbxFvjlU1NDRlZWCCpv
         of5a1WNQfehJN8bsNpyjehVNs9eSgIztGtu/hL+pmDwe1CTX6Co8eJvifN63coVyARjd
         SvBBi6iH8toGKC6+4APYxAACJDaW316sIqWQbSQPa7XWYx8xgXYXzzH2RpjY8zu0WEPU
         TMdY43lbQ8a1wJBk1yHYHzPpIYe+c/DnyU+nVSH/su1e/aAEsZ4miSYLzLffNjRTAqNe
         m3xv4eVf22zWK86RAjEKJfL8/v9GtOInlGlmel9QLoO0pjS1mpub40YrpTl2TmfuBkvu
         azpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImDG//sNXg/oy5XZPOuBFIhl7k6YK/gX5hImljVQwNU=;
        b=N//VjMTHSceQujV7p0lN9nBj6z0X4WOEXU1UiTFHpxqVkHWoRBKwOmYjjGsrL+qjNB
         /2inrvoe2kZ57/CquyTjuIecwB8hhakPX5KpAz0FLqR3BtuTtm8RYthxLrz1FdC06pwv
         brNYOhOa1+ABP5eWqYxsWsBEdqZTJwX0E/zyhXppe+C+vZfsK8wUSTTXWTYoWSGsavr5
         AhicAbPeBVZMm2+T7OJbDKEgMQPgyX8A7PtY208pfkJDwwr6X34po4H78iQZJFVvp4uR
         q4Zj1l1QZmBOyV/MJX5xc0Yi1+8QcrLFhbjGxrbPa9qcQcxrP06h0ZkNeMatf/BwDQIX
         osJg==
X-Gm-Message-State: ACrzQf1fxe15hXX+ZW0C58SWMFx4xsM6CjN5o352cM+nophU5XozMhsf
        lcXWPEPiTmxihmFUyh+PBKY=
X-Google-Smtp-Source: AMsMyM7Kh4e60noIwDR139plI/hWSD9OSNgFT8xfKVvgoTo9o2S/R19CkOOAEcIyeni3GZNwo9ShVA==
X-Received: by 2002:a17:906:6a17:b0:794:f0e8:1918 with SMTP id qw23-20020a1709066a1700b00794f0e81918mr31466676ejc.474.1667510346827;
        Thu, 03 Nov 2022 14:19:06 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:b895:1d95:7d32:5509:657e? (p200300c78f2ab8951d957d325509657e.dip0.t-ipconnect.de. [2003:c7:8f2a:b895:1d95:7d32:5509:657e])
        by smtp.gmail.com with ESMTPSA id td11-20020a1709078c8b00b00773f3ccd989sm964617ejc.68.2022.11.03.14.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 14:19:06 -0700 (PDT)
Message-ID: <2aeb10bc-178f-836e-eecd-c77f3eb2f0b5@gmail.com>
Date:   Thu, 3 Nov 2022 22:19:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: remove unused struct declarations
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Y2LYvhr74ng+xFbz@qemulion>
 <e76c5fd4-442b-0f0e-73e8-c17acf11b471@gmail.com> <Y2OOM8g0Qj1o6dRI@qemulion>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Y2OOM8g0Qj1o6dRI@qemulion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 10:47, Deepak R Varma wrote:
> Hello Philipp,
> Thank you for testing the changes.
> 
> Request (not urgent):
> Can you please help me understand how do you
> test such changes? Do we need specific hardware for functional tests? Is there a
> documentation available to know more about the testing? I am interested in
> attaching a physical device to my machine and be able to debug and test the
> changes. Can you please provide details when you have time?
> 
> Thank you in advance!
> ./drv

Hi Deepak,

I do have one device for the following drivers:

vt6656
vt6655
r8188eu
r8192e_pci
r8712u

Minimum test is to measure the transfer speed and see if that is as 
expected.

When I doubt that the changed code is used I use ftrace to see if the 
code is used. But of course I do not test every possibility.

I hope you have the money to be able to buy hardware. Without it is not fun.

I would choose r8188eu (USB) or r8192e_pci.

Bye Philipp
