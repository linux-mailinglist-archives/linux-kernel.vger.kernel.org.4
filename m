Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6560BB58
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiJXU4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiJXU4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:56:11 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9496E6EF1D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:02:25 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id p8so18165360lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Arus5XmLATh0hrszBUYGKJKk3UkG2N7lr9RQnONL+hA=;
        b=CGGp2YNMdt8XsvQvysckO5V4zZaQvng0llkIgMcgjwM17om7FSIewR8exp9f4V+9Gf
         gZd6x/F+b6J4CtMD04rnw+Kai+UMy5Fb1dVwO6mwKy3pmG9wC8VWqTpafnFyvE0vIKqk
         uJ3038/greWpQ5SdE/1gHcToDnBjcJpXyNK9bBtqeekkGmIutAIIZkiLQMbPrIlixMOn
         nnUU1odS45fwWk6YLIMq7fiR03c3ow6+wENXEjnQo9RBXmdoCT5MjticWAkGJOj07rF3
         S5v/KvPW7zieUbuIiYL7fafH+cw0j/zcf4mjdGfKYfwJdOSLT6FIVA6AkIDJMU6JLOYD
         H2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Arus5XmLATh0hrszBUYGKJKk3UkG2N7lr9RQnONL+hA=;
        b=u+aAkOBg2JryA+y6NqDFQntdQyCkMCDnbl2IDCUWnQnRmopltkbGOwY2TBruq67LTb
         TeO9eNCeCar0y8WtHBKJoC5AWi7snYg5S0/6Z9+FofiNHdgeqpUQrjEe2dY1sS4lw+P7
         gz8qCqWOw3OI+xH9gmmx4D25WBrJZMB66m4ZVOeidO6mP7eJQ2/AN2WYvDcCOd0NUDWB
         /AzSzTuzQay/sJKSHWo0+h28ObHMg7UUqLUcjl3QfUs6KtGMLcmTjpzNHKueu8Eimxkv
         axc0KU7WwI9pI/8ufP/DS1F+hA15sIWLf6qD+oYY+Ba+o8z43Hef9+fZqJItkApgQcPK
         GvEw==
X-Gm-Message-State: ACrzQf2kEAEK96UCBtF4a/E/06Z0dtfDiK6ugDyd1rp+5CaSomwh00vC
        CN58HJGuXMph4EOTq8DHVpIt5r0YF9g=
X-Google-Smtp-Source: AMsMyM5LcLhvlqgdoWsNB+Hcbxc1CZFnxBHYUwXqDUQLSs1dFYr6aPpyn4GbexRwJVvOjU68Ouq1Ow==
X-Received: by 2002:a05:6402:3512:b0:461:e146:d2e7 with SMTP id b18-20020a056402351200b00461e146d2e7mr3682600edd.39.1666633389656;
        Mon, 24 Oct 2022 10:43:09 -0700 (PDT)
Received: from [192.168.1.103] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906318d00b007317f017e64sm173889ejy.134.2022.10.24.10.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 10:43:09 -0700 (PDT)
Message-ID: <f4a70a29-4c27-c091-4332-dc476e258b74@gmail.com>
Date:   Mon, 24 Oct 2022 19:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/17] staging: r8188eu: clean up mlme handlers
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221024081417.66441-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221024081417.66441-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 10:14, Martin Kaiser wrote:
> This series cleans up the mlme handlers that process incoming management
> frames.
> 
> We can reorder the handler functions and remove forward declarations. We
> can also remove unused return values and simplify the error handling.
> 
> This series should be applied after the "some more small cleanups" series.
> 
> As usual, this series was tested with EdimaxV2 on an arm32 system.
> 
> Martin Kaiser (17):
>    staging: r8188eu: restructure mlme subfunction handling
>    staging: r8188eu: make OnAssocReq static
>    staging: r8188eu: make OnAssocRsp static
>    staging: r8188eu: make OnProbeReq static
>    staging: r8188eu: make OnProbeRsp static
>    staging: r8188eu: make OnBeacon static
>    staging: r8188eu: make OnDisassoc static
>    staging: r8188eu: make OnAuthClient static
>    staging: r8188eu: make OnDeAuth static
>    staging: r8188eu: make OnAction static
>    staging: r8188eu: make OnAuth static
>    staging: r8188eu: change mlme handlers to void
>    staging: r8188eu: remove unnecessary label
>    staging: r8188eu: remove unnecessary else branch
>    staging: r8188eu: remove unnecessary return
>    staging: r8188eu: remove an else branch
>    staging: r8188eu: go2asoc is not needed
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 226 ++++++++----------
>   .../staging/r8188eu/include/rtw_mlme_ext.h    |  23 +-
>   2 files changed, 100 insertions(+), 149 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
