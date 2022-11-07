Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D7A61EAE4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiKGGYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiKGGYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:24:21 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1331276A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:24:20 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id t25so27342644ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 22:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1sRwCA8KHUhxNcfYSilemI92Zg7l5g6gONZv/WfRaY=;
        b=g3h4mAUIxRoseTXzmO3t3ygPXXVDYF+I8+edFSVrLLFQ7iQe1hlKcHSwPEWxJza2ro
         mSyGvhSeDOfWD9RAgwTkR/HIkoaePVKuBjyjouEVbtxGpxqi7vXgP4fjwGwPycrWoPn/
         6BRFVUtMXzSj0npCXNjCzJ6rR2PsgUJFEYQquiPLBUE+WNgWsVGFqAcyi5cfVI2Lo/Cu
         y+vP4Jpe+Op9whnsyOAv+XpN2bDuUrsK33xdVkEsYGURFT5uzHfmbLS4m/qR/a242+HR
         AD26ZOMPHr4t9+AyRdu2B0LCtnJ4cB6wYLAzEORdB450lutp8HsWT4nbB+Zl37C+7htj
         aH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1sRwCA8KHUhxNcfYSilemI92Zg7l5g6gONZv/WfRaY=;
        b=Wn0x6O9ScIQqyVFxe7OPT8OKki1w+r4BcXk0Ulau28KzCHVSyvoqSdRXMSa0T/Ewv8
         EAgjczpREgM7x4GBDObi/rMsYs+XBKYPDZRcBz0FewDZS3YpoJWoBJUMU21/HH6WfTSu
         FFg/EeKNW2rhJS6NexrVr2ssVlnpy0/WV3fYgiv3+FzuLkYWwlWkLcwJ8VcefMnnKFFz
         9lP28s7uC30vXYkUk5FgKL3ET4elHY3B7TctEcDZKAv18q2hA7WD/yPF2lwy1uI7oyEa
         RMci0WzhyRuEoMlFLgfhSFHhDclGZqO7+zMaw+43TFS/21hgimaRANFNtzu1nImCCQAJ
         aR4g==
X-Gm-Message-State: ACrzQf1J112cACaq+jn9+vZHkRxAuIKHfuXgXq8pazgZQ0VVBS5hWjGt
        VguNBC3YKdEmcr37heo+Zjw=
X-Google-Smtp-Source: AMsMyM5VkUYckAFnZXci2vZlVZisY5bq5bOgu5zyWo61Z7rd25U6wjfhbbXaKV4wZOSrMh+98OEnxw==
X-Received: by 2002:a17:907:847:b0:77f:f489:cc25 with SMTP id ww7-20020a170907084700b0077ff489cc25mr45610765ejb.80.1667802258910;
        Sun, 06 Nov 2022 22:24:18 -0800 (PST)
Received: from [192.168.1.100] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id gv57-20020a1709072bf900b007acd04fcedcsm2891085ejc.46.2022.11.06.22.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 22:24:18 -0800 (PST)
Message-ID: <8ae354fe-ca24-1c51-2cb9-230e5e8b74ee@gmail.com>
Date:   Mon, 7 Nov 2022 07:24:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] staging: r8188eu: casting simplified
Content-Language: en-US
To:     Deepak R Varma <drv@mailo.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1667755987.git.drv@mailo.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1667755987.git.drv@mailo.com>
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

On 11/6/22 18:54, Deepak R Varma wrote:
> Patch set proposes variable casting simplifications. Change improves code
> readability and appears more maintainable.
> 
> Changes in v2:
>     1. Patch set introduced.
>        Changes associated with pointer casting and variable casting are
>        split into separate patches. Hence the patch set.
>        Suggested by gregkh@linuxfoundation.org
> 
> 
> Deepak R Varma (2):
>    staging: r8188eu: simplify complex pointer casting
>    staging: r8188eu: remove unnecessary casting
> 
>   drivers/staging/r8188eu/core/rtw_br_ext.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> --
> 2.34.1
> 
> 
> 
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
