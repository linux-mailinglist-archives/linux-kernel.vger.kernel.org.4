Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE455F88A6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 02:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJIAxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 20:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJIAxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 20:53:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3687CE6
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 17:53:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b15so7238577pje.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 17:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yH25RyDrgB/CHrd3oT3w5RJPoVT7/+e3hVxNpT5AUKM=;
        b=wHVWpGwwakxY8QjLniIt4xKr4MTLDNSifAj1pE4j0IC9BMHi/hZdM+cvdt/51j33WO
         Pt5nb29Ii+3VxL7ajUZ7J8HmXrdQcMim7h1WJk0FYIPKMntFoSPD6DcOJJjpk85DjTlh
         A4Da17orqREmCshiGODhBQ4zUsTr+esxy08/BUUxLhdu28sh8g9qcUFAHmfo4+TSreqk
         S9dTH5v/dyQzvfn/UBrUl+8Tp1rSlhW/e4U8AZogOFtzRbri6swEIsId2rwPB7ZOx/8e
         +GMr3RQrNORWXajSNDhJXG3qLLjRBlm7YmRd7LmMgkaOkYmAhZi/dU9IDS1kT8Hsmu7j
         1+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yH25RyDrgB/CHrd3oT3w5RJPoVT7/+e3hVxNpT5AUKM=;
        b=F+Ex1A5q5q/vDyYlxH2TzDLJueEGyjhMYwNHBI5Md9s2oTuEj2c5K8atuqcqyQVRIK
         Vec2BpmIEJtoy6zsPaMaBWGfwucnOGu0LaqiCQikZ780/03S8L5oclT9U4+zlBuFKC6z
         3t52HTLNNKK6A6H67DDlNqrPlvQHEvE88+Abhc0YTm4lnbhE2471yqIpNvBkoY4Gb4uq
         gWMuV9sPVlmPJhBqsfz4KkQy85jxDJmC9P/DA3UeDPPl1FMEWGDrhWOnYfPc6VqYIXX1
         Oga7Z34Yo4zD8tXQabJ/3wGjfI4l8h/8eszCv5SBx1Ma+zPhMzj7XJyg3UPsghmxP/j0
         g/ng==
X-Gm-Message-State: ACrzQf2kltIe/uA//aVv8vRAnTZmcvgCyfnd/DmSUVR31CZrieKWvS3i
        1mgl/S9e8Tu3C9fIJVXviMpCI5duEGA6GA==
X-Google-Smtp-Source: AMsMyM4gUYBHIPfolci8Wx6a+KdbvBPYFIhxNeIxfHsZbqEINFtVr6P1PmISrWoqLYWx24OK39Sh1w==
X-Received: by 2002:a17:902:76c3:b0:17a:68:767d with SMTP id j3-20020a17090276c300b0017a0068767dmr11964720plt.109.1665276809468;
        Sat, 08 Oct 2022 17:53:29 -0700 (PDT)
Received: from [10.200.9.255] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0016c50179b1esm3845768pln.152.2022.10.08.17.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 17:53:28 -0700 (PDT)
Message-ID: <298867dd-01d9-cd61-cdaa-95bbaf2dd2e4@bytedance.com>
Date:   Sun, 9 Oct 2022 08:53:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH 1/3] ipmi: fix msg stack when IPMI is disconnected
Content-Language: en-US
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qi.zheng@linux.dev
References: <20221007092617.87597-1-zhangyuchen.lcr@bytedance.com>
 <20221007092617.87597-2-zhangyuchen.lcr@bytedance.com>
 <Y0CBbRqGPDU3g9hQ@minyard.net>
 <28367829-10e1-1a74-5572-ba01b8f8b716@bytedance.com>
 <Y0FjriRusk0H4Fxp@minyard.net>
From:   Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
In-Reply-To: <Y0FjriRusk0H4Fxp@minyard.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I will send v2 today.

On 10/8/22 7:49 PM, Corey Minyard wrote:
> On Sat, Oct 08, 2022 at 09:36:16AM +0800, Yuchen Zhang wrote:
>>> Also, the following is in start_kcs_transaction():
>>>
>>> 	if ((kcs->state != KCS_IDLE) && (kcs->state != KCS_HOSED)) {
>>> 		dev_warn(kcs->io->dev, "KCS in invalid state %d\n", kcs->state);
>>> 		return IPMI_NOT_IN_MY_STATE_ERR;
>>> 	}
>>>
>>> You probably need to remove the (kcs->state != KCS_HOSED) part of this
>>> now.  Would you agree?
>>>
>>> -corey
>>>
>> I agree. KCS_HOSED state should be an invalid state.
> 
> Can you make this change, run a quick test, and re-submit this one
> patch?  With that, I can include this.
> 
> Thanks,
> 
> -corey

--
Thanks,
Zhang Yuchen
