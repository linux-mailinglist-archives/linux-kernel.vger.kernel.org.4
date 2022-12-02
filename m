Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D97640FC8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiLBVHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiLBVHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:07:06 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ABEEAB48
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 13:07:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x2so8075454edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 13:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YG6hTh+FCQ7Vhwk2YTsAR9WCKbvsgjHffAXIAMSQQXE=;
        b=EtLQ7QEfMcaMrIovG7+WD5OQdw1nuVTeAzDFu6fA8T4BO3+NO0U/w9tEi/YfN3yV8U
         bCxOdh0EDxDEklKVaSEQ1jgpwTjfF7yaOxZIf1V0Ig7aDo82tETW85BTvYVQVajrALXC
         T+he4/ywG5KJ9TlT/ErITn+RAmKPYrxCX7+N1xGScGniFFc3KyqlpnqLXdRuBlbmuq5k
         2o1Kgp48zJzsc1lVST4vxbpDeaqy68tVWSwGQEJxNUbE+yWDJB6hvEGPqbuYgmJXJRA4
         B/iy8WTMbO4nkcQ3oVaZLeKGAhW2OPrZbvILCzCYbIko4S3HS8lCb1BTJ+vYnGismn9T
         dzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YG6hTh+FCQ7Vhwk2YTsAR9WCKbvsgjHffAXIAMSQQXE=;
        b=hvaX6UeAgzzssJoGlILc3IyBWZmHCOEJU3ow9m07/343I7e/5coZ+QruSuGWWLhiSk
         H0wNBgRoVad83kZXIVMHDforvGYlXnY5+Ks6lWquIAO2nLqzJtQEruX4FXFSWO/7hIQs
         sFqEaNpTMffB43W/iKQ6Z2nhfX0iic4hIgbWKM84On4NVjYy2LgCNKQPxY8V/YmpX/kN
         YhGmH8/kGd1YdcOyRYNX41aHWn7qARZSwOkAuioPPbqHKJ4+xOE5j5yvyh3OM85a2/rY
         TxMtoZQ7dIDRjNiBxg3UAWAvKHsu2ImULiV8D3Sxy+9wVJIaUt0qSt6YHQb8qnJPxxOi
         Jp2A==
X-Gm-Message-State: ANoB5pl9s6tGnGDbLH7JJuLdIuIazbU2FyN1ckPxe4BTlWvGLCUB18Sj
        bbv5H+O41kipnZoBXHwRYb4=
X-Google-Smtp-Source: AA0mqf7gHXipCDI+yM+6VTNxlzvNYEM1zW5ANWd6eMsOVJB8sa6aUeSv9oaDvRXk59+AbWt4/20PXg==
X-Received: by 2002:a05:6402:1145:b0:46a:d5ee:d150 with SMTP id g5-20020a056402114500b0046ad5eed150mr30204609edw.312.1670015223913;
        Fri, 02 Dec 2022 13:07:03 -0800 (PST)
Received: from [192.168.1.101] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090676c200b00770812e2394sm3396499ejn.160.2022.12.02.13.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 13:07:03 -0800 (PST)
Message-ID: <4701500f-8184-0006-2d10-b8640e335a79@gmail.com>
Date:   Fri, 2 Dec 2022 22:07:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] staging: r8188eu: issue_probereq_p2p
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221202092525.403887-1-martin@kaiser.cx>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221202092525.403887-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 10:25, Martin Kaiser wrote:
> Clean up the issue_probereq_p2p function.
> 
> Martin Kaiser (2):
>    staging: r8188eu: merge two probereq_p2p functions
>    staging: r8188eu: remove unused da parameter
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 40 ++++++-------------
>   drivers/staging/r8188eu/core/rtw_p2p.c        |  8 ++--
>   .../staging/r8188eu/include/rtw_mlme_ext.h    |  2 +-
>   3 files changed, 18 insertions(+), 32 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
