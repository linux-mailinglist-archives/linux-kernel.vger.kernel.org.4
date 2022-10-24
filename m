Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8EA60B48E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiJXRv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiJXRvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:51:00 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0AC95AC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:28:14 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e15so8162144iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3g+bkjM2aLE89DNRSDM2T8ChFwJPRhsaqoMBtdss+dU=;
        b=Zg07LsUOcAemNKd20eWUxNt6ByNmgYS4gNYlMDhU126dG0TVv890ZLNLEwGzvn/KiW
         gdNQHGa5LNf3Z9pfjH3Z5NNK9Bztfs1BhYzmQp7gliwAuVj4VPHTh0MoeWOFANLJBI51
         0eN88c4ZvNo+hXFSljoEOVRCYRT6E07DLNIdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3g+bkjM2aLE89DNRSDM2T8ChFwJPRhsaqoMBtdss+dU=;
        b=zC2E30UQitAsIl1o4xJ+L9HSqpQSfJ8dYEm1OtfAWAR8Jq2yvleJsqDycVKltt+l7Q
         Rx/ZBJ6Mt5NxihgqP0uLdgHwRIpT2zF6/p+K+shZlA0kz+sKY7FtswOpx0UbdvWz7qA8
         CjSddxY1zJi6e03pBpqvEiUnb7XediqNZxK68BFenWP7CYlY+TUlpq9Wjtxh3MweAmMZ
         Ta61Kxjp/5QbCwgkBF7YYAafUuw0VFQ5IH0eblh9IbuvecfojLvn5AVM4D0r4+OI7ZNp
         A8PUEQVVbN2I9NmrUVLVgiRJ8MncvIy4uNAbxe/3/BUi67cm8fs8UMS/cCRYeY1rJxGl
         tKvw==
X-Gm-Message-State: ACrzQf2wlRihr7FoZYpwAk0FVb1HUU4zt/TJczrgS09mu/ledl0E+XWW
        HcELqD+zPS+zFqtevaDZCiMFwg==
X-Google-Smtp-Source: AMsMyM6WFW3ZRXsjK8sdosEdiCKJdCs3m7HnmiF/6fRyIg7dRoFf2yxBzcsLjo+7e5xUTrSqLxqa1g==
X-Received: by 2002:a6b:d004:0:b0:69e:2636:85df with SMTP id x4-20020a6bd004000000b0069e263685dfmr20994565ioa.19.1666628754707;
        Mon, 24 Oct 2022 09:25:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u15-20020a056e02170f00b002f52f029b4asm120464ill.32.2022.10.24.09.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 09:25:54 -0700 (PDT)
Message-ID: <ee507a45-c815-cd17-29e4-25d5b32e8938@linuxfoundation.org>
Date:   Mon, 24 Oct 2022 10:25:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/2] selftests/ftrace: Capture dependency on external
 programs
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1666101523.git.naveen.n.rao@linux.vnet.ibm.com>
 <20221018103033.3af4c9d2@gandalf.local.home>
 <20221024122202.01b643c6@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221024122202.01b643c6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 10:22, Steven Rostedt wrote:
> 
> Hi Shuah,
> 
> Can you take this through your tree?
> 
> -- Steve
> 

Yes. I will take this through my tree.

Naveen, please send it to linux-kselftest list with all the
reviewed by tags.

thanks,
-- Shuah

