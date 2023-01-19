Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B746739B6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjASNPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjASNOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:14:22 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1057CCC6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:13:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y11so2706303edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVEp6zZy55um/Kg5TyceQi/ONI6rKZ3fmPsehIybOOY=;
        b=w1d3kWTDmpNWWVlKNqv9fNpQKrKj3y5UI07ctDMnERi7gvd8MA2PEk/5rHnEoNtwso
         /3ngEkWbrsKXvlE4raVqVJbnM1hnsEGFr1ScOnxFSh2TZI8D3YkcqH7UzF/EATqEf8nu
         bzLdFStHODMvmRYIaKPweY6tKdFZUDBHq9PG0TdBVkXzn7o1N5sxQKY8aY75bNlykgYb
         3ys84LkquqKPaHv/Auwt0+m16LA9C/ttcSkfM/rbAglD5+BF2qVAATtMtNlTMJj7If9G
         hRq/mXCKLevSoW4wiTxNG7aYUFjxFHJm5t3KW5t7ONfgOUhTXdx8yv4FlzuLgvFedPBZ
         t4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVEp6zZy55um/Kg5TyceQi/ONI6rKZ3fmPsehIybOOY=;
        b=uoBiwUw+Rv3VTWxg+T6CKwjE8XswkxLykEqbpW8CLnPJ7Nvm5aOWWWu6RkFUdR3QaY
         D2bUa2+idV5J8KgLPpsW7g3sKpEbMf429bPXDUD16+QexMo0qT+r005ARJAhlUPqNpg2
         Z3ErStR7FZs7uk1kCExRTAZ/FdPdcoyilPeoBkeNPbHpteeladGjfgwoIrfzzmWZgN/w
         I0qo5L2Swe6ph4pAbQ7jYYvH1B3/2mfypF7Hxj6j+CGl923V1bIYc0C8hiaI9tabDAE7
         Ccf1pF0EWEJs/AL6LMl+JFcXCat8P9RHOzSI+cRa5+nWCIOhhyGaOy3SrkELXBTQPOeT
         RgNA==
X-Gm-Message-State: AFqh2kqv9F7zob5pDFfZQIE22ZigwL7xG8UObZf+9hYpr8iQ0tI1mj/L
        hdYz9W0Bz1hOoQknVOWlEKId7UTX/xE9MRCS
X-Google-Smtp-Source: AMrXdXvADQTdEjyWo3ZJqemu+m3iudXR885h9SyWWUkGKAIdm+vwLpRkbbWszLPiyIwzYUSmsoo/ww==
X-Received: by 2002:a05:6402:449a:b0:499:d1ca:6d83 with SMTP id er26-20020a056402449a00b00499d1ca6d83mr10765316edb.2.1674133979820;
        Thu, 19 Jan 2023 05:12:59 -0800 (PST)
Received: from [192.168.1.213] (h-155-4-88-185.A159.priv.bahnhof.se. [155.4.88.185])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090618aa00b0084d14646fd9sm16098215ejf.165.2023.01.19.05.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 05:12:59 -0800 (PST)
Message-ID: <9d64ef0e-5e92-98f7-4620-c50561dad3a8@norrbonn.se>
Date:   Thu, 19 Jan 2023 14:12:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: vhost-net
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <75a2cb16-9e39-4123-de8e-b846c9b482f0@norrbonn.se>
 <CACGkMEu-hZ2x8EnstJ_FQ7tWMj=zLf7GAcwyHuAzvQQncTqEYg@mail.gmail.com>
From:   Jonas Bonn <jonas@norrbonn.se>
In-Reply-To: <CACGkMEu-hZ2x8EnstJ_FQ7tWMj=zLf7GAcwyHuAzvQQncTqEYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Thanks for your feedback.

On 17/01/2023 05:26, Jason Wang wrote:
> On Mon, Jan 16, 2023 at 4:59 PM Jonas Bonn <jonas@norrbonn.se> wrote:
>>
>> For an IFF_TUN device, should vhost-net not be adding an implicit
>> ethernet header in _build_xdp()?
> 
> Probably.
> 
> Actually, this makes me think that we should disable XDP for TUN?

After playing around with this for a week, I agree.  It appears that as 
soon as the XDP paths come into play there are requirements on having 
valid ethernet headers in place; the TUN interface doesn't even have a 
MAC address to validate against so packets in the TCP paths get dropped. 
  UDP packet validation apparently only cares about the ethernet "proto" 
field so these can be made to go through with less rigorous ethernet 
addressing.

That said, when the XDP path is bypassed, the TUN device works fine with 
vhost-net.

> 
>> Can this be done without backward
>> compatibility implications?
>>
> 
> The path is used by vhost-net only, so I think we are fine.
> 
> Patch is more than welcomed.

I'll try to put something together.

/Jonas
