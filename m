Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4932465A372
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 11:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiLaKJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 05:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLaKIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 05:08:55 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA623D
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:08:54 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gh17so56317802ejb.6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J1HYc6BialSacaveLTPV1yjJMIxmzPFwz0VYaQcNW2E=;
        b=RFf+40SHbhjGwbDYN7lMMm3xQ7zh2IB7U3D5THpTXjiLuvehp1sDGw0J4yi6OM1nQG
         HFRgjJ8gw2S+iSR2aK7+wctCAxp0/cQIi08oa6A5+fZ9NQC0n2mxkY6IfEHzQtG+VI6m
         hKUxPAJsoGh6JpASjTXfi+MPauB3GpnEFN5wYD7plcGg/pPBQY2YfAyyh5Lo3ic+s9AU
         cdD3vCteE545Td0GdXKhFEETvvAocaxGF7L3/geO1xyzM4W4cVRKRANE1+jZvt4qYk3n
         tUbyNzcr8O8HNoxAIW5tfMVRdxJfa1zWkzz/FOstr5DB3jabbEBOsUMcMj94No/od4xt
         C41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1HYc6BialSacaveLTPV1yjJMIxmzPFwz0VYaQcNW2E=;
        b=HVoDytxxs/KOPzGKRgeqAV49jy0L1LfbfsDBrfF9gVhAAvQu6R4FL0jRgL/R/j8PhY
         XdexdaL4G+Hkt3Om612FJ2qca8QzoBTD2hpchgG+8OAAPic6qV3jeu+IlBH3OAhqGz9+
         FTVbefZFlg/7LH/TbJFgkKIfLZvWLIQNmmFYMKgHHFkkp8Q/dpThFnUGpLTmUgCdP0ti
         cW3LwejldrWF10ysol9ZOoHDTYtBYYcbKEYOL2yaRl8rKhExhz0WvJKNLxL4ItJlmdpA
         rGpgBsNXE+QvNKbC+uSPWW9j4E6TK5w5+W8GQkf8S81FO2+pKrpGiWpIw9POiEYLTw6C
         i06w==
X-Gm-Message-State: AFqh2ko1jIvSRiVjBgz0ct1aOyr7QtA1NTzbbnMrLN/U0EByFAKQA9Fj
        eidbUPJViFOWHFRFCBit0bk=
X-Google-Smtp-Source: AMrXdXvnSBeDaOINm7wcMXY3KGwaq7rtFQdi2kD3HW7ZhTpe9e3hjUF7IofQGk3ONtkxJ8WUZBvpDg==
X-Received: by 2002:a17:906:9f28:b0:7c1:6f1f:6f8f with SMTP id fy40-20020a1709069f2800b007c16f1f6f8fmr6214084ejc.6.1672481332625;
        Sat, 31 Dec 2022 02:08:52 -0800 (PST)
Received: from [192.168.1.102] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id ky17-20020a170907779100b00849c1e5c00esm9773341ejc.72.2022.12.31.02.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 02:08:51 -0800 (PST)
Message-ID: <6a199e03-267d-9924-9926-22a4175596ff@gmail.com>
Date:   Sat, 31 Dec 2022 11:08:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/20] staging: r8188eu: some xmit cleanups
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221230180646.91008-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221230180646.91008-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/22 19:06, Martin Kaiser wrote:
> Start cleaning up the code that transmits data frames to the dongle
> via USB.
> 
> This should be applied on top of the "merge public action functions"
> series.
> 
> Martin Kaiser (20):
>    staging: r8188eu: make xmitframe_swencrypt a void function
>    staging: r8188eu: remove some unused CAM defines
>    staging: r8188eu: cmd_seq is write-only
>    staging: r8188eu: return immediately if we're not meant to encrypt
>    staging: r8188eu: remove unused parameter
>    staging: r8188eu: simplify rtl8188eu_xmit_tasklet
>    staging: r8188eu: remove rtl8188eu_init_xmit_priv
>    staging: r8188eu: remove duplicate psta check
>    staging: r8188eu: simplify frame type check
>    staging: r8188eu: simplify rtw_make_wlanhdr's error handling
>    staging: r8188eu: clean up qos_option setting
>    staging: r8188eu: remove unused bpending array
>    staging: r8188eu: remove unused dma_transfer_addr
>    staging: r8188eu: bm_pending is not used
>    staging: r8188eu: terminate_xmitthread_sema is not used
>    staging: r8188eu: tx_retevt semaphore is not used
>    staging: r8188eu: remove unnecessary rtw_free_xmitframe call
>    staging: r8188eu: phwxmit parameter is unused
>    staging: r8188eu: rtw_init_hwxmits is not needed
>    staging: r8188eu: we use a constant number of hw_xmit entries
> 
>   drivers/staging/r8188eu/core/rtw_cmd.c        |   4 -
>   drivers/staging/r8188eu/core/rtw_xmit.c       | 239 ++++++++----------
>   drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  27 +-
>   drivers/staging/r8188eu/hal/usb_ops_linux.c   |  14 +-
>   .../staging/r8188eu/include/rtl8188e_spec.h   |  21 --
>   .../staging/r8188eu/include/rtl8188e_xmit.h   |   4 +-
>   drivers/staging/r8188eu/include/rtw_cmd.h     |   1 -
>   drivers/staging/r8188eu/include/rtw_xmit.h    |   9 +-
>   8 files changed, 116 insertions(+), 203 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
