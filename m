Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B91B653D65
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLVJUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiLVJUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:20:06 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8757321839
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:20:05 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h7so998820wrs.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjgQOOM0LndXbSekqrlHxP9Q5j0PBJkQ1caUYMWBeA8=;
        b=eJGDya+riRrsaY92y3ZW2VGbaK0zqrUozYCIjZs9EPPwztC0GbkEr4UpVO+jDUjuy8
         4dgfo0jwsp9tI4zh5xgnx+tDPDEhVpgx5J7rSENBzW3tkG3rfFgsLW3fd5cwkumlsYc5
         gWmLl4JWnqaybkI+6Z3SDcZfVNyuJrCnAs0mhspMAF4n2xj3GAbft6v6y8ICa0FcLy1Y
         AuW+kC+fzTanc9b3bOkYaNR5IpMcA6fMbLv13/etnyUAVu404DvTMaK/n6Jcs8fxF4aa
         hJcz4v3MPbOZxuqkD8N0wScsG5fsITjEL3GISHkDbXJbwbExXeG/mPsE8AVVb2CGPCDh
         Mqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjgQOOM0LndXbSekqrlHxP9Q5j0PBJkQ1caUYMWBeA8=;
        b=PhLQi59u6/rd6xw/GKeHxNmMIEQ+iXu7S/ArCwweeSyqaduiu8YulEZUOzJ+q27UnR
         WOeCYAevI3JILfgoIkXuwGDryuhgUcFWSMAeJTxriwzh2Q8FlY+An2SGy5KPTiyCtdvj
         j3+2sAHv/opcK/VJrE6RKub4N7QvIPCHXt+W75VXwRKvXy9P0YQT8TMCsfJfM7bPNBxq
         zclajC8IKymyVNrY1BluxhXosxvq7twZv4/q25bEVBTdtzKZjePdx6jxCaIvOL0HNR3e
         wa4yWzD3QU8SuZdJtAdUFUnvJMa2UzvlsxYi+ZdMeLQxF1cD3Q7AizAYlkcyvXtNnLS5
         +pqQ==
X-Gm-Message-State: AFqh2krg2k3Qrz5usALzWKLQjFE0biSqx5gQmTSrXc60ea/XXxFnXWdK
        V8UO2v4xRXD/qktWv2IzagrNgg==
X-Google-Smtp-Source: AMrXdXvgK+M12PDcOC6lX+3wM32Tx+wJiKIYzOkbPVRFe8/WcbcMqKaOtgmyULN79PnURezIE4WJqA==
X-Received: by 2002:adf:e303:0:b0:242:1926:783c with SMTP id b3-20020adfe303000000b002421926783cmr3037517wrj.58.1671700804067;
        Thu, 22 Dec 2022 01:20:04 -0800 (PST)
Received: from [192.168.0.173] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id i7-20020adffc07000000b00241d544c9b1sm20161609wrr.90.2022.12.22.01.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 01:20:03 -0800 (PST)
Message-ID: <544202ef-37f8-9055-7f2e-69fa46907930@linaro.org>
Date:   Thu, 22 Dec 2022 11:20:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: kernel BUG in __skb_gso_segment
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, willemb@google.com,
        syzkaller@googlegroups.com, liuhangbin@gmail.com,
        linux-kernel@vger.kernel.org, joneslee@google.com
References: <82b18028-7246-9af9-c992-528a0e77f6ba@linaro.org>
 <CAF=yD-KEwVnH6PRyxbJZt4iGfKasadYwU_6_V+hHW2s+ZqFNcw@mail.gmail.com>
 <a13f83f3-737d-1bfe-c9ef-031a6cd4d131@linaro.org>
 <Y6K3q6Bo3wwC57bK@kroah.com>
 <fc60e8da-1187-ca2b-1aa8-28e01ea2769a@linaro.org>
 <Y6L/F2Hwm7BRdYj8@kroah.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <Y6L/F2Hwm7BRdYj8@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.12.2022 14:41, Greg KH wrote:
> On Wed, Dec 21, 2022 at 09:42:59AM +0200, Tudor Ambarus wrote:
>>
>>
>> On 21.12.2022 09:37, Greg KH wrote:
>>> On Wed, Dec 21, 2022 at 09:28:16AM +0200, Tudor Ambarus wrote:
>>>> Hi,
>>>>
>>>> I added Greg KH to the thread, maybe he can shed some light on whether
>>>> new support can be marked as fixes and backported to stable. The rules
>>>> on what kind of patches are accepted into the -stable tree don't mention
>>>> new support:
>>>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>>
>>> As you say, we don't take new features into older kernels.  Unless they
>>> fix a reported problem, if so, submit the git ids to us and we will be
>>> glad to review them.
>>>
>>
>> They do fix a bug. I'm taking care of it. Shall I update
>> Documentation/process/stable-kernel-rules.rst to mention this rule as
>> well?
> 
> How exactly would you change it, and why?

Something like this:

https://lore.kernel.org/linux-kernel/20221222091658.1975240-1-tudor.ambarus@linaro.org/T/#u

Cheers,
ta
