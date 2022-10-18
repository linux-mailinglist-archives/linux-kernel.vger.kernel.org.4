Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6367E60361D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJRWlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJRWla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:41:30 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C077C7D7A7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:41:29 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id o13so8257322ilc.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRIQ7NLQxQWJwKhbJQrXjl1ev9OrSKwjvJPyN/wgvfU=;
        b=Jrx7Ecp+i2VqXRJs3lCxayFgYp3pVM9b6yHCvu6ZxdJWGPYVFfLu7dvN5vjKPwxKwa
         +iDctykijO685Q0vOBrStuh+RGQedlAnpf2+LlfzwuXczPuDKoXCSgPzZnJoM3U6d4RD
         qd3CNNS9buoTaIM0q9GaJPCZZgWgIWPIMi2dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRIQ7NLQxQWJwKhbJQrXjl1ev9OrSKwjvJPyN/wgvfU=;
        b=MQKeLsZDQqY0pNd+6k31wTTY6CnQmiI+QZoBCumhkkwxDM32pUFbX3gUU6MF8ygSc7
         DSStoAVSqvaW1Ik0a3JWgIZmqe8Z6MbAKIgieFbFdX+rGM946yszfa0JK+6wuuEB6oj1
         E+MaJiaiGDsSsys0O8fA4kNjHwGibkaqEoyPvTUsqzV1+sqXZy0az89j1nCuTT75qmNi
         eA2J+mlPkLi1XvDtchB+cmO8cQFDc2xX3PfFjnm7BbHbs+0yXwEIexJW7u0JPbi35wuq
         sBIgV+2NmpdLUEhMZ3VVG5n7oNbPtunHTEXQ90DdnpABLd7ZO1njfys5SHoySqhC8dTU
         1q7w==
X-Gm-Message-State: ACrzQf2wASKpp93r5TJuneGe0XVLb/bMO2DZJAG6uAlZz/oR36gQRJHA
        svd9sj4RNyPNgbxUYYseS7QqkGXB/qtDPg==
X-Google-Smtp-Source: AMsMyM44wsheS9NSIFgs75Qfq1hWdGZQJHX5qwLk3AvLRosUF874PkF99X3U4BafXCRofPSjOGYoYg==
X-Received: by 2002:a92:ced0:0:b0:2f9:6c22:dece with SMTP id z16-20020a92ced0000000b002f96c22decemr3068516ilq.222.1666132889027;
        Tue, 18 Oct 2022 15:41:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h17-20020a056638063100b00363ad9656eesm1453646jar.165.2022.10.18.15.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 15:41:25 -0700 (PDT)
Message-ID: <0b747522-1398-5a68-0fb2-763db6aab5b8@linuxfoundation.org>
Date:   Tue, 18 Oct 2022 16:41:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] selftests/ftrace: Limit number of lines processed in
 'trace'
Content-Language: en-US
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221017105502.307506-1-naveen.n.rao@linux.vnet.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221017105502.307506-1-naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 04:55, Naveen N. Rao wrote:
> On very large machines, ftracetest can seem to hang or otherwise take a
> very long time to complete individual tests. This can be attributed to
> statements that try to process the entire contents of 'trace'.
> 
> Limit the number of lines processed from 'trace' to resolve this. Apart
> from the change in test.d/functions to add TRACENL, this commit is the
> result of running the below command (and fixing some whitespace errors):
>    grep -l -R 'cat trace |' -- ./tools/testing/selftests/ftrace/test.d/ | \
> 	xargs -n 1 sed --in-place -e "s/cat trace |/head -\$\{TRACENL\} trace |/g"
> 
> Reported-by: Akanksha J N <akanksha@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Please cc linux-kselftest list on all selftest patches.

thanks,
-- Shuah

