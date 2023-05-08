Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168E76FB602
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjEHRge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjEHRgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:36:31 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7C85FD3
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 10:36:30 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-760b6765f36so16094039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683567390; x=1686159390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+HbhBQwCu+27FV94o7jvHpLrgJzn9eQjRRmd9ezh2M=;
        b=Ab9DrIEiUjSSy6JC7owMD4p64Az3cadSaunZHQMPx2vDDfo6mLwi96gsUsir68jSt0
         9Uu0al1HMU+wgHRUZ2v7pDWUltMcnX5x526VInhYTtHKiGbGzWr747e0M1Wus+Wwkres
         xr4+8fnHXQXCMv78mM3vNp882saMAbkUb4GRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683567390; x=1686159390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+HbhBQwCu+27FV94o7jvHpLrgJzn9eQjRRmd9ezh2M=;
        b=Hfkm7ojDy2n5pitqAaFy+C2iIC5P9sjPA/R8qnsVx3EzEQOgk92e1WV54aF2Ox6Tud
         yeRrNS2RChohsMs+9Pu8UDqoHrmSq4Luw5xb+62hbxBEVagUzgpgPPKjd2a1zDKLM87X
         afTJLVeGToeYw1D6MfowfLNwi0/6VRxPrhSExztoVDDC8eoXxRaGcEwH/C0vledtqtcP
         V1zB9MWtSEJ59BX6lN/BuP8JiT2QrY99LwTrr28RE1LOVRot5Cqhz0IycLM9GsdKOUdl
         hLFxUjEmjsC1XO6H5Q5fXQkPUm0ABNk2Gm+UnTuLBhTD8G6V16Hh3qy1OKUQmWW3MBKf
         ZpDA==
X-Gm-Message-State: AC+VfDzo/kSLiKmVJ4yHCknZ0U5VXKPdcmaGvHtvUOtfxkuHkM9E/Q2N
        JicONyo9egQahqBinHOnXLLz6g==
X-Google-Smtp-Source: ACHHUZ5sL7TFB+N6wjGVWmy6uictNrM1Houg/vRzKod82AQJoveBkuCKIPoJFw8/TwhzOSnMAssAQg==
X-Received: by 2002:a05:6602:1642:b0:763:542a:f26e with SMTP id y2-20020a056602164200b00763542af26emr8204539iow.1.1683567389868;
        Mon, 08 May 2023 10:36:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cs11-20020a056638470b00b0040bd3646d0dsm2109487jab.157.2023.05.08.10.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 10:36:29 -0700 (PDT)
Message-ID: <54bec864-5e4f-8432-a331-e4ea5fc2ba31@linuxfoundation.org>
Date:   Mon, 8 May 2023 11:36:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/2] selftests/ftrace: Add new test case which checks
 for optimized probes
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, shuah@kernel.org, naveen.n.rao@linux.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230428163842.95118-1-akanksha@linux.ibm.com>
 <20230428163842.95118-3-akanksha@linux.ibm.com>
 <20230430105231.2e7f5bd8a3f879d2330485d2@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230430105231.2e7f5bd8a3f879d2330485d2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/23 19:52, Masami Hiramatsu (Google) wrote:
> On Fri, 28 Apr 2023 22:08:42 +0530
> Akanksha J N <akanksha@linux.ibm.com> wrote:
> 
>> Add new test case kprobe_opt_types.tc which enables and checks
>> if each probe has been optimized in order to test potential issues with
>> optimized probes.
>> The '|| continue' is added with the echo statement to ignore errors that
>> are caused by trying to add kprobes to non probeable lines and continue
>> with the test.
>>
>> Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
> 
> Thanks! This looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Would you like this patch to go through kselftest tree?
If not here is my Ack:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
