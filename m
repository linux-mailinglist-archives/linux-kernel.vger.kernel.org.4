Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F54A61EAE3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiKGGXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiKGGXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:23:47 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ADCB4AC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:23:46 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a13so15975782edj.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 22:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YU1NqnDArxJp709VcJ7r/DP7G4tQ3jXGslvaPz+DMKo=;
        b=HJE9EWhjB0mZ6aBsFeh/m4SskQnF/pnXs+i7XSjawxpV1Odi48ASM99BRa8tIOROGU
         8u2wY6JzxyYG5b00CCwyb2crNDeno5EG1yw9L2EzsYRFpYuiPOyhz9xlyl8RbaMFqnFP
         OsvZHth71dLqWqcATbe04Pbwgi6lm/qJaZiHTb839bDa6TqaiUtDS9lbFlIeQtnYxxF8
         CX8swEnR+ccNFXWLw64a7CmIRFWDc5bVijQJAGzTGBNLwgfpG1Nd9AGLjWQnFcmu8rQu
         G6hWHdV30hAs92yxSB6JPaD4FEzvWp/ATKSC7fbZWbPo0Y8NDFELpXRLHzSlNv7yODj2
         b4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YU1NqnDArxJp709VcJ7r/DP7G4tQ3jXGslvaPz+DMKo=;
        b=jA1b0u4O7rRRyvI8J5Q21vjSs60XI1VoMP+Vg7Jx7X67XBfHCuLODiu9fv5tbReCEb
         D7KqjfSGUwTrvgGKZv376Jv8aC9pOlKvp8x0uRTF9lTMvdoePR+x0jFDM+UfpG4AXVAj
         7xkmP9hfVVSR5hPNzJfPNxJOSsg0z9NUSDKazBAq5jlvKWafrJ4Maw4ksY6iXaGvtchW
         Us4EAP4vVMSUSyJgcFr5uOE8KSBjv0ER7WRpiwOmpmm3kJfMRg19ECjbQFFs0Opcteal
         R9XEHLyl6JTppitg2EUQIEuyLVRgoJSYixikdrWFfw5ipGXlKLPWB7rJEQrWAhDNhEW5
         HGnA==
X-Gm-Message-State: ACrzQf3jPU67QeVsomU9tRVt/jUW6+WhXZJ8Lvaxk1RLxkfnmFUzG9j0
        sMFItJBfgtqgQFOrO7ft7pY=
X-Google-Smtp-Source: AMsMyM7z3vPPcU55MFoOxF+8JwvmJzZZWq+jXbZSgGwshsZcGMOiZXhsrfEFbn8L+NrvjQIFsW/qTg==
X-Received: by 2002:a05:6402:3896:b0:45c:93c3:3569 with SMTP id fd22-20020a056402389600b0045c93c33569mr18034380edb.37.1667802224909;
        Sun, 06 Nov 2022 22:23:44 -0800 (PST)
Received: from [192.168.1.100] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id u18-20020a509512000000b004611c230bd0sm3681366eda.37.2022.11.06.22.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 22:23:44 -0800 (PST)
Message-ID: <a70ad5a2-d8cc-da70-2b00-d6d545088b20@gmail.com>
Date:   Mon, 7 Nov 2022 07:23:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] staging: r8188eu: another round of cleanups
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221106170455.743058-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221106170455.743058-1-martin@kaiser.cx>
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

On 11/6/22 18:04, Martin Kaiser wrote:
> Here's some more cleanups, mostly related to bSurpriseRemoved and
> bDriverStopped.
> 
> Please apply them after the first patchset I sent earlier today.
> 
> Martin Kaiser (3):
>    staging: r8188eu: use a qos_hdr in validate_recv_data_frame
>    staging: r8188eu: drop another removal/stop check
>    staging: r8188eu: drop removal/stop check in
>      dump_mgntframe_and_wait_ack
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 6 ------
>   drivers/staging/r8188eu/core/rtw_recv.c     | 9 +++++----
>   2 files changed, 5 insertions(+), 10 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
