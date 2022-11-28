Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A998D63ACEA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiK1Pro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiK1Prd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:47:33 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918F3240A5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:47:29 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id q21so7862075iod.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/cQ59vOik41OykSQHWqPX7qqvxHpSfUuLTGjrvRrWE=;
        b=e6WKcfvuFskoTqvkFnYzs5n4pKicXD/S//eX+zT8/VbvwWZ2l0siPUpLSb2xB8qFjd
         ydyPMmcHtVF6FZUPX9aP/H4MjP2P9kh5Q/TlXYMTBASbEUREKFynobNRGgsTEgV/eQFG
         WmrCgzU7NOcd5K3o8AgRV7RqL7dM2dJW617Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/cQ59vOik41OykSQHWqPX7qqvxHpSfUuLTGjrvRrWE=;
        b=6R6lcy+B9PeAb74TDQPxpngj7sI12yQbGWRB37QZeAtrnjQXHCRP/asQN6wfl2LcUb
         P5iA8WuFG5x7Q7s1qkR4vjFsx2UHXxqzYr853fG9OKQRgUewb2gfV7ciyL97H99XlWps
         Fdl0N5GVh3Ht4EgYC2jN4BAOeM4HKYtnN58ChEiHkohjNlNo7jtK/SYbz8u0Y/PhjYtU
         wCE8v70g2ETh542cIUMCW3F8Hc6aLcURJ6G1isKOka5T/xySbnitrKab1YcgekCQ1Lvy
         mEGsV6wROJMUySosw5i0Hmi+t4iCwDjI5RYvOsx5NP0WM/vby1K7NyoSUBbK0QKao29s
         6hcA==
X-Gm-Message-State: ANoB5pld+wyRg/1tJDJCmnM1AOnM8pjjwDD1kiyq1ziVVE0/WHim2ZnL
        I76qJw+CkkXxWo+mG6Lp24CoQtnNHfn0dw==
X-Google-Smtp-Source: AA0mqf4oV2IgM3hVWJ4/Hf0Bcyr23uIBeqXArE8+RH+dqG1++mK8FJY8uYOvm94JWWWZwZae2Fpp+w==
X-Received: by 2002:a6b:d117:0:b0:6d6:bff5:bbdf with SMTP id l23-20020a6bd117000000b006d6bff5bbdfmr23860797iob.156.1669650448956;
        Mon, 28 Nov 2022 07:47:28 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f21-20020a02a115000000b00389c2fe0f9dsm3166506jag.85.2022.11.28.07.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 07:47:28 -0800 (PST)
Message-ID: <94cadc83-b4b8-d423-82ab-748e39c3769d@linuxfoundation.org>
Date:   Mon, 28 Nov 2022 08:47:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] cpupower: Add Georgian translation for cpupower
To:     Zurab Kargareteli <zuraxt@gmail.com>
Cc:     trenn@suse.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221119100320.10022-1-zuraxt@gmail.com>
 <CAB1QXY9V7y7gD_skRfWFqdT6LQi9+7CK1ikYeWoNh6yXr42i-A@mail.gmail.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAB1QXY9V7y7gD_skRfWFqdT6LQi9+7CK1ikYeWoNh6yXr42i-A@mail.gmail.com>
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

On 11/27/22 04:50, Zurab Kargareteli wrote:
> Add Georgian language for cpupower
> 
> Signed-off-by: Zurab Kargareteli <zuraxt@gmail.com>
> 
> changelog:
> 
> - Initial commit of Georgian translation
> ---

Please generate v2 patch and resend and not as a response.

thanks,
-- Shuah

