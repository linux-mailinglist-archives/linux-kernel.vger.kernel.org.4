Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4618B676055
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjATWoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjATWoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:44:18 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D2813DC6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 14:44:01 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so4706415wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 14:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uni4fgWzey2A2pr/65sW4fSjZ1BK0qfdeoeclceKc+I=;
        b=p587u395pzhdB1gao6W8PwGUdEh0uuwLLyLD0oCi2QsiNyXvUhdZ7UYWqIjlE8qtF8
         PIwCWEOuQw3HEf7nVesE8DnpT6plVIKMIvGLvSvQR40MUXDgWUUJMsD4/wJW6n/8MiJt
         hesXHJB9ytz+ZbOsYOFhHVJediFtzXim9MvQO44xUqF5c9soPa0e6/ADR8s1SLgT+qWw
         CJWXxTLF9NZfQ9oeoIQVgyopDsRvYx8pXpZV7TDwnjwtlOtFiJXCcvOsBjANblgIlg6W
         jArcVnSXy1bKKfZzXeYeg91cCjQn3lzFkA5ib9QHryDkj7jNDBSJxZS6DQLcrCOOVVB2
         JRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uni4fgWzey2A2pr/65sW4fSjZ1BK0qfdeoeclceKc+I=;
        b=Fu0BPOvMrWPHZHm8ZRzY1ndqcy/mjLXuN7F0Z4O1DXodA/S1qmdK0vrafghSppKPyO
         hmJ4zJetq4ieppHW1H8DHVdrA6BUVaWYANsqS7FJ/Ue6wYIz9vyQgYiyrHCdzlAPp3EQ
         0psLHh1h/c+ptD1FbuG/xAXGJiApl4RaZ7shnZs14tNGGd77wJ2X7iQ5XYaZdayLxZ2z
         codH9ojEe8hwGbU25p8BzwXjeyAeC+VP75PtO9RR81bq8HYFR5N+Um7WwxEgaORhbBLM
         D27Wmpk+CXb1DFDaiibDcQHlIPkoubgWeQuGVXs9Mor6CRj46PSiUXIH4ITfU3Leuz9o
         CFRg==
X-Gm-Message-State: AFqh2koS2XvQ5jcdCq1+FpkVfairqag2S2bBOyC6OiSwqxSMZmh8aPDm
        42KqfchTMm4Wh9qpXV+GEQa8PQ==
X-Google-Smtp-Source: AMrXdXuFooVJ5PKTGIO+sDLW3dqj2bMA3ND7vGcK7Lo8MNL+a+xqlJM/2QCAAHuUDKj7rzRll+eJLg==
X-Received: by 2002:a05:600c:5409:b0:3da:f66a:e866 with SMTP id he9-20020a05600c540900b003daf66ae866mr15767602wmb.10.1674254639777;
        Fri, 20 Jan 2023 14:43:59 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bg1-20020a05600c3c8100b003db09eaddb5sm12011498wmb.3.2023.01.20.14.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 14:43:59 -0800 (PST)
Message-ID: <4c532a7b-d5b4-da5e-5703-c6f8ebfbc62b@linaro.org>
Date:   Fri, 20 Jan 2023 23:43:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/2] thermal: Fail object registration if thermal class
 is not registered
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <5905717.lOV4Wx5bFT@kreacher> <4780418.GXAFRqVoOG@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4780418.GXAFRqVoOG@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 20:48, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If thermal_class is not registered with the driver core, there is no way
> to expose the interfaces used by the thermal control framework, so
> prevent thermal zones and cooling devices from being registered in
> that case by returning an error from object registration functions.
> 
> For this purpose, introduce class_is_registered() that checks the
> private pointer of the given class and returns 'false' if it is NULL,
> which means that the class has not been registered, and use it in the
> thermal framework.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

