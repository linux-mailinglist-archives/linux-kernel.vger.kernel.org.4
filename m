Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3FD61E152
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 10:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiKFJhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 04:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiKFJhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 04:37:53 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FDE3B7
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:37:52 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id l11so13370992edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 01:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=io0/8bk23qfo5CTsPUcvXEb6MGcn33aYZt9gOjPuGXI=;
        b=Dj6BHM0FILQ+S8vjBLGgRJrvGiAGvjHQCCxlNtlYEMmA5waobtlnz0w5oFNqgJ1/as
         AO+XzcybTmbo9U8tXt5YzHupgd/XhhIbc0nI2sTc8ZdtLl8u1Z3FT+1RNcdUaAeaN8C+
         Zx4gjP+acw1eD/R4lUcUoI3ndpGxLgx68b6POiRY624+x4EAiUi/qB1bnyt82+LGi0Bi
         BNyMIRFTlF85VFiknNre4hRjnMBz63bajVoJIBnLjgOh02aEEQ9RiNFf2mVhwu/CTCyJ
         +35zTv+tEoa05MBiM15bqOCArw3R0xgIXJHT2NFuY28lW3NXJaIc4Kikmb4Nvy2H5Jt6
         8LCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=io0/8bk23qfo5CTsPUcvXEb6MGcn33aYZt9gOjPuGXI=;
        b=GuYagqEgKBudtzzpikbdk4S0clGHNNfZtvVPyvkTiRpw4l9yUdIwY7wcpVHiI5bbg4
         aS6tSGu+iGjolc4DpopMoAYq2aTXrLdqBn5ea2KG1I7L5HmXHw5a3rhEO2dTPFBK+Xja
         +s1pA7V8WBcq2G5cFsse4uURA2y5fEQI+JRecSLsjmza/nFB+wrqecA3n69yI4y0Vk8S
         tvspA5TPqHncrd63n9AVPYb0JMuZsvZMQ0NjNAuVX4w9N1gNykQFeOj/1ftNYZifaA4S
         6ZdJ8m5w9oBpkxUJdB8+K34OrokG2zyOxI/cBN0spyYUbPiNf0O2sRCBh4QPKOTFn7Jy
         tK7g==
X-Gm-Message-State: ACrzQf3skKTB+4VbYBVNG06tE2rBrCvGfqk69cmaIOEGqciGzP/i3+ZA
        sP0CpHD3JaND/BIOlxRHxKw=
X-Google-Smtp-Source: AMsMyM4XpkPstkk1eZEL2oVdpiHe0WCxgkqtOASRuqNIW07B0OkrJOVWofCYsTeWF6RvVwIMspg6yQ==
X-Received: by 2002:a05:6402:2073:b0:461:5462:9dc9 with SMTP id bd19-20020a056402207300b0046154629dc9mr45132451edb.52.1667727471043;
        Sun, 06 Nov 2022 01:37:51 -0800 (PST)
Received: from [192.168.0.101] (ip5f5abba7.dynamic.kabel-deutschland.de. [95.90.187.167])
        by smtp.gmail.com with ESMTPSA id n20-20020a05640204d400b004588ef795easm2402500edw.34.2022.11.06.01.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 01:37:50 -0800 (PST)
Message-ID: <c630dd74-83a2-5f98-bd8f-c1eab7df5f96@gmail.com>
Date:   Sun, 6 Nov 2022 10:37:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] staging: r8188eu: convert three functions to bool
To:     Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221105093916.8255-1-straube.linux@gmail.com>
 <Y2ZD0B6bsDbdpa6A@equinox> <Y2ZIMCv7n8OgzqTG@kroah.com>
Content-Language: en-US
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <Y2ZIMCv7n8OgzqTG@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/22 12:25, Greg KH wrote:
> However, these function names are horrible for being in the global
> namespace, but that's a totally different issue that can be fixed up in
> a later patch.
> 

I'll send a patch to address that after this patch is accepted.

Thanks,
Michael
