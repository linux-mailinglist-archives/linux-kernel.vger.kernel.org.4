Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E879772339F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjFEXV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjFEXVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:21:24 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76425D2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 16:21:23 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-777a9ca9112so12650639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 16:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686007283; x=1688599283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ns90En3R1m3gcQd2QfTPzP8O2oKizg1bDEC4L7QPGmc=;
        b=h87lzPx+eobEm2lDs1rAZBjzsC4XnnsXBGy8ZeOR4ZgrP10Ya3u1wJlyQuerRuI6/y
         pyUVigyxguSkbCmUzoniSDixdXIc46NDFV0gfyUj0f+imlCkhwtYPBNFV9SlGagIPJIS
         DvlDiGd+lx1LGf5us1Aj8oidZvxyGXvVfziss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686007283; x=1688599283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns90En3R1m3gcQd2QfTPzP8O2oKizg1bDEC4L7QPGmc=;
        b=imak405pTHNQcW/mrXr1g7niEgASTb3HGi2emmM1aXoALfDbp3mi0Qw5E9wLh43iVI
         PfVV7PZg6QkdDxIhIZzdUiQH3LqxWo9bx5s74HyseLPmmS60S639EGg6fyX413vkinp6
         6xBMqN+GCOb4uwSuxg0TzFYyrO+bB6ZNhWsoIUvI49ttdYuRdPNr2ywbY45cgUey+KMj
         anlha7rgz+kGqEp7Avb/9LxjPPdR0xbd0yyyx8HFPEXR2E4jksXO8KjGO5+97yM3i2XQ
         vRmRxnYUIsWJZ+RGQlUw7RnHMM2ttVp5CdENFm/C1LsyJaEP4GwwA/yQzwOjISSeGdSP
         0dyA==
X-Gm-Message-State: AC+VfDxTPRil0B3seb9VYlm+tvz2UJnRFUGoB0PNCarnbREqrcKxt0O+
        Cyn5f001aN09FWFHeM/EuNEDdA==
X-Google-Smtp-Source: ACHHUZ42F9PJUfuW6xvzNSCBwzV9l33tzKp1JyZjBWXTjiGTfIbPD++dBqvQNsSiqZom+FQC2g3UsA==
X-Received: by 2002:a05:6602:370a:b0:777:a94d:a362 with SMTP id bh10-20020a056602370a00b00777a94da362mr523088iob.2.1686007282800;
        Mon, 05 Jun 2023 16:21:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v6-20020a02cba6000000b0041f5f4c5f95sm850768jap.164.2023.06.05.16.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 16:21:22 -0700 (PDT)
Message-ID: <dceb9437-096d-850e-77c0-5a2bf0b9ff57@linuxfoundation.org>
Date:   Mon, 5 Jun 2023 17:21:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: linux-next: duplicate patch in the kselftest tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <shuah@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230606090216.731ca640@canb.auug.org.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230606090216.731ca640@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/23 17:02, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
> 
>    54f389ba0efb ("tracing/selftests: Update synthetic event selftest to use common_stacktrace")
> 
> This is commit
> 
>    f1aab363438c ("tracing/selftests: Update synthetic event selftest to use common_stacktrace")
> 
> in Linus' tree.
> 

Thanks - I will drop this one.

thanks,
-- Shuah
