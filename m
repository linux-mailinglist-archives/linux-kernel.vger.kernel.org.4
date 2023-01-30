Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDBE681F81
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjA3XT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjA3XTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:19:51 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F9E144A9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:19:50 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id l128so1114524iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMcPwu5SiIWveNVrDQNoDl9A6srhkjO0Si1Imvta0bU=;
        b=DuJ+v8ysOfolKNGr0VRytffDtQzmOKicJIouxufYi9tJAulc15ID9MwKQqhJJR6lbK
         iARF5XTCP4B1vER/x7UztGYvII1vYhmAl9h6lGKxAIo9o6eNv4eaqXgiM0Zbn9nONVQo
         +64DGx4VISVvfzcruo5/6HzYukXQ/yMcXLNMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMcPwu5SiIWveNVrDQNoDl9A6srhkjO0Si1Imvta0bU=;
        b=DFbuhonXepWH1218DqvoQQZGRcas5Aqf2sBsoJl1/Cb0VHKU6qeh+VUiboKMHfBpRe
         G06gFk4KynQBoKFDqgo/DwqFNa8Xqm50D+HQrsCz/9DpBCz9aQfdDenh8qZPNZLrfpmU
         dby9vPanTcqMZFl/NEWQeOgWT0WBKgKp6gx+kyLVTLFVfXFVfnPKL/e201en0h7WfINV
         bOtKajIhu0gajiMWT56UYl5qUSsaakHA28Mfjx2Et8emA1IATCPE24Q3liJWPcwwDo0j
         B50klT4DiAoTeQqYykxGuIKr6DddIIlNOjNKiq2cAQk7tui1qYfBw6xJ7lb5JjLvzs7v
         2Ieg==
X-Gm-Message-State: AO0yUKU4ZUOIyJkjRmGNdiOjH/IuIrGXNYDYD8sm0/1zYWaDXKH7v/b2
        Z6nnsGZtEeqNv4QOXTE/qGMfig==
X-Google-Smtp-Source: AK7set+xCMfnO8UwnHAL2ENPa+W72PezgD9lGzCIj1F5JbYGEO0ibR/3BTrwW2TjhD4lteSSurk4OQ==
X-Received: by 2002:a5e:a50f:0:b0:71d:63e5:7b5f with SMTP id 15-20020a5ea50f000000b0071d63e57b5fmr923535iog.2.1675120790010;
        Mon, 30 Jan 2023 15:19:50 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m8-20020a5d9688000000b0071b08c66155sm1817068ion.38.2023.01.30.15.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 15:19:49 -0800 (PST)
Message-ID: <d532dc0c-4a5d-986e-19d4-1c90071d2cdb@linuxfoundation.org>
Date:   Mon, 30 Jan 2023 16:19:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] docs: add workload-tracing document to admin-guide
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, corbet@lwn.net
Cc:     sshefali021@gmail.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230127234616.55137-1-skhan@linuxfoundation.org>
 <Y9STCwt2FnYf4/X4@debian.me>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Y9STCwt2FnYf4/X4@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 20:14, Bagas Sanjaya wrote:
> On Fri, Jan 27, 2023 at 04:46:16PM -0700, Shuah Khan wrote:
>> +strace tool can be used to trace system calls made by a process and signals
>> +it receives. a process to the perf, stress-ng, paxtest workloads. System
> 
> "... to trace system calls made by a process (which can be perf, stress-ng,
> paxtest workloads, or neither)."
> 
>> +Before we can get started we will have to get our system ready. We assume
> 
> "Before we can get started the system must be prepared first."
> 
>> +Browsing kernel sources ::
> 
> "To browse kernel sources, you will need:"
> 
>> +Workload overview
>> +=================
>> +
>> +We used strace to trace perf bench, stress-ng and paxtest workloads to
> 
> "In this section, we use strace to trace ..."
> 

Thank you for the review. I will address them in v3.

thanks,
-- Shuah

