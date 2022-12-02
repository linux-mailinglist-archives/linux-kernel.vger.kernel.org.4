Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1EC640CAB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiLBR4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiLBR4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:56:20 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0869EE11AE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:56:20 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id x12so2382814ilg.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVoAug5gtejJ7/IIk4d5/d0qHj9yVDsmAukGbbYb1cA=;
        b=E07yENdBA00zt//BbQlbasnVIc0xyAswa76oEqdXbhsEAURO/LuHpFMUlXgWEYe9Yz
         QnlwfyBzNr9hiREgzpQpSmu0b+EV0vGXb7EwNlBRJ7bqzAfK71E20I0RrZaJ7JOjwlYk
         hkpr1T57uA8sQjmSrazUJh73SvMtrFdp23eDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVoAug5gtejJ7/IIk4d5/d0qHj9yVDsmAukGbbYb1cA=;
        b=SaznEEwxUQGyJTqBU0zSJuL/ZdlEqrslP/VHuK3VGATLsE8pOWzmg1r6V8JRgws5S/
         jehzyEhKEmM6G1vTutvVfKoAtw4sdAIWldX3zPvZQDvl1fUeCeL0YCqxJAvR9knSDict
         dq5oS0QtYhjFT1rsDskhHdmGWkg832RTkAmWB8BHin4N+kZFJ5/uV7FvuInrDfwI31Qx
         lQxA9lpvQ390L5mR8yCiOR427Wp5vbXwcsAGYWawswFPUTOK10R+5P4JMLqwdCefh11I
         rJlp/E0wRFD50qmfeqCdJNjqgdRyl+TZnCz38Z82/82y3jKNIiEIShISKZu7VHpvHN3b
         oX5w==
X-Gm-Message-State: ANoB5pnlZ3M93p4bO+OUyHnUhYFcaiv3Tr4/wJgWQpWANmmaACywOX8g
        nyULJ/odk7dBeCvtYUl2jmPLkw==
X-Google-Smtp-Source: AA0mqf7fs6vkd4J//JOhif7iVzs8494VtF07NA9AMLmqJ2gEGD7iBnwcqaZNp3LsGelk4gMMUisFlQ==
X-Received: by 2002:a92:c004:0:b0:303:42f5:4268 with SMTP id q4-20020a92c004000000b0030342f54268mr1165054ild.205.1670003779347;
        Fri, 02 Dec 2022 09:56:19 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l18-20020a026a12000000b0038826e709e2sm2871976jac.111.2022.12.02.09.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 09:56:18 -0800 (PST)
Message-ID: <ef842cd8-1228-54e2-c298-f524be7abc59@linuxfoundation.org>
Date:   Fri, 2 Dec 2022 10:56:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests/ftrace: Use long for synthetic event probe test
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221202120331.343a821d@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221202120331.343a821d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 10:03, Steven Rostedt wrote:
>  From 8bb1734388b89bdb2ac176882786dc02b7df92c2 Mon Sep 17 00:00:00 2001

Steve,

git am doesn't like the line above and I get "Patch is empty"
error.

I had to manually remove this to apply the patch to linux-kselftest
next for the merge window.

Please check if there is something in your workflow that adds this
problematic line.

thanks,
-- Shuah
