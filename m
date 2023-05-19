Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6E7709706
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjESMEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjESMEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:04:45 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2C8F5;
        Fri, 19 May 2023 05:04:43 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-195ee1be418so2468951fac.2;
        Fri, 19 May 2023 05:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684497883; x=1687089883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jmpizCaVOeCP1r1p2VyeIJckntY5BckfPqM9Nsz8n4=;
        b=V/Yn4/NxgQPXvWF8hVm4JaNB0A7WHvHdopqNl/U/yuGD4//t6lFyb0d6MhEuhy41Z6
         BS8LJsvDFBbOUxV/1EQzeCx8Wc6vIMIU6THXj2CUofkjq722/e+L/q1DhdiUac2x2HuN
         twqL5w6vzUTTycYx0gbjfrTpx5FuB0LZG1uOVO27oizvAmX34QlXMtwjf8aOMkdnH1zS
         lglD5aoNF65wVXriGzrJ0acuJYeLdWzzhjfBKYTyWdwQnQINA1KyJC+JfvAspTfSVAVj
         99P11UrSB46FDXp7rU+uF1qKhXXcSc2g1BLQ5C3AnBBCqUU1zjTFi5BPwS9fnnw7DG+v
         Sg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684497883; x=1687089883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jmpizCaVOeCP1r1p2VyeIJckntY5BckfPqM9Nsz8n4=;
        b=M1+npcdxeuyC9QpwLoYDpskzaFvreg4Srm0EnTls9f/4CQGYt8gsSVJSmADJWfGEWW
         tlmyJo5GZaW7QM5MPpdAEOXa5zoFuqtmcHq5eBibBia8+FzN4SqalMZidJGMDzWNXy5v
         EasqJR5anNlMJIM4WLFQrzJccx2IQfo+FkR/2mxv1RLZ6UXjiHwey4IFIS4+icsVWvrw
         KcJKrOZQn7gzRGePz4wav0bzcDylIjC+uxN1YyIzml58t+nAjPKizGrrZC448m9VVW5U
         hqBaxbXcvbG8nnH9a4MoD+/7pnQYjODct1uwyrlOiJAUFTwZIF2maYT+Woa3mUdogu3A
         hqeA==
X-Gm-Message-State: AC+VfDxj3b7RSBsU2L+Ge6Zyvmg2TUg8oSREDLFGzkpaIGt1YWGwWcUi
        Pc8s01HvRuyTpqgRGL24T5c=
X-Google-Smtp-Source: ACHHUZ6jWONxjseiTxpvmAU7vOOx9nwPIKW7k7HlSt6MQyAC7YvKhLNkrZPKsdvwRNbVhk+geIoX+g==
X-Received: by 2002:a05:6870:7406:b0:18e:2f29:1099 with SMTP id x6-20020a056870740600b0018e2f291099mr869338oam.53.1684497883167;
        Fri, 19 May 2023 05:04:43 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id b1-20020a05687061c100b00199be6e2b75sm1832109oah.41.2023.05.19.05.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 05:04:42 -0700 (PDT)
Message-ID: <beb2932e-7f16-e368-9cb5-edbe115fcb67@gmail.com>
Date:   Fri, 19 May 2023 09:04:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/7] rust: workqueue: add low-level workqueue bindings
Content-Language: en-US
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com
References: <8e42aad3-d94e-3cb4-ee59-90ded31cea9e@gmail.com>
 <20230519094042.3432952-1-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230519094042.3432952-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/23 06:40, Alice Ryhl wrote:
> On 5/18/23 16:51, Martin Rodriguez Reboredo wrote:
>> On 5/17/23 17:31, Alice Ryhl wrote:
>>> +    /// Enqueues a work item.
>>> +    ///
>>> +    /// This may fail if the work item is already enqueued in a workqueue.
>>
>> Wouldn't be worth to mention that, if not implied, the item it's going
>> to be worked on an unbound CPU?
> 
> I'm not really sure what you mean. Can you elaborate?
> 
> Alice

I've meant that if it's good to mention that `queue_work_on` is going
to be called with `WORK_CPU_UNBOUND` so that API users know about it.
