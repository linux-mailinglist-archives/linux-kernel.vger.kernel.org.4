Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4BB601AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiJQVGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiJQVGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:06:34 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B327A79A59
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:06:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so10909380wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ny9S84ddMU/C3tkLJNxlEIFlBnKSkg7GhMCarBjMO4Q=;
        b=QlTlQ0/Gn+KJSTCePByReUXYSh/U0B4FRFME4WIA6QXwUPH+oMXWtbKdMueJ2F9N8i
         UFvPp5gZhswevOSeG/3xinkO/wBwalFH/8vdhqDu42/o9B6KqawED2AIA7kB0VVAmKFH
         Sgw1bceGoRnG+C5wLhBaBWO9YI+FhEbwd8sKyn/TKWQKDioYUPdsWVTVcjEVSWLYj61j
         yNDJaXQ57YW5v0iqXIAABEghuroeKbBQ/wFPppeCXsJY4ZBCVrtHdUTsRGAnTJpsaiaU
         dxao9aDjAK9HuE2xwShYxiuxsVyQaxbWhsdwMpU4DJrqg70j+qLhTZkc3QS8efmsviwW
         /sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ny9S84ddMU/C3tkLJNxlEIFlBnKSkg7GhMCarBjMO4Q=;
        b=sXxTlYHPOnul+UKVP5ft9y23WbHVIBcSnVeR9XxqV/M+XrDLIu8lmbGJOWHSI2J77w
         j3doneor543C6nVMnX7I9yJhGl0S32PekjFnB7+bVgD3KQCCtaWZ6X7ovb0znp5A6BeE
         Wnvdpk5Z3jMGk4ROUabsgNXh91h8bReR/KN9obrJxRaAoUCtN7/WzhkY02yF3rysR87x
         tFnqE2ZCCtcIdByO/yXJ7qsVpdB25zY71zUk0+xuz1Iy1SnhwXe6HLLIpBIyTj1R0pt3
         Pggkai5yNWct5e4KTfIIGynzGTCiI06jDiLVC2wHba+4ldOX9DewLqL1VE7s9Y2EhD4h
         3kDg==
X-Gm-Message-State: ACrzQf0VXUZprVgct9EggsUj6SmAkLm5BY+J7yleKeVcqSUvmKtKGeRW
        pByD2uDHOSFaVYXoe/fPnyw=
X-Google-Smtp-Source: AMsMyM4XdCoQpXejZXuEi4kxewPjDf//Qgwvgno6/Vza+YHole7Od6uFXjHHZOLzidb9HSq2V6ROww==
X-Received: by 2002:a05:600c:4e51:b0:3c0:55e0:7719 with SMTP id e17-20020a05600c4e5100b003c055e07719mr8919840wmq.3.1666040781142;
        Mon, 17 Oct 2022 14:06:21 -0700 (PDT)
Received: from [192.168.1.104] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c499500b003c4ecff4e25sm11058305wmp.9.2022.10.17.14.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 14:06:20 -0700 (PDT)
Message-ID: <da0daaa7-8e2c-103e-0261-8685739e297d@gmail.com>
Date:   Mon, 17 Oct 2022 23:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: Re: [PATCH v1 0/4] staging: r8188eu: trivial code cleanup patches
To:     Deepak R Varma <drv@mailo.com>, outreachy@lists.linux.dev,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        paskripkin@gmail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
References: <cover.1666021212.git.drv@mailo.com>
Content-Language: en-US
In-Reply-To: <cover.1666021212.git.drv@mailo.com>
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

On 10/17/22 17:56, Deepak R Varma wrote:
> Address different kinds of checkpatch complains for the staging/r8188eu module.
> The patches are required to be applied in sequence.
> 
> Changes in v1:
>     1. Improve language / grammar for the patch descriptions
>     2. Further improve code reformatting
> 
> Deepak R Varma (4):
>    staging: r8188eu: use Linux kernel variable naming convention
>    staging: r8188eu: reformat long computation lines
>    staging: r8188eu: remove {} for single statement blocks
>    staging: r8188eu: use htons macro instead of __constant_htons
> 
>   drivers/staging/r8188eu/core/rtw_br_ext.c | 122 +++++++++++-----------
>   1 file changed, 62 insertions(+), 60 deletions(-)
> 
> --
> 2.30.2
> 
> 
> 
> 

I think this patch series should be v2 as the first one was a v1. The 
next one should be the v3.

Please do variable changes driver wide and not only limited to a file.
Example:
This line contains the old variable:
void *scdb_findEntry(struct adapter *priv, unsigned char *ipAddr);

But in this line you have already changed ip_addr.
void *scdb_findEntry(struct adapter *priv, unsigned char *ip_addr)
{
	unsigned char network_addr[MAX_NETWORK_ADDR_LEN];
	struct nat25_network_db_entry *db;
	int hash;
...


Please change all networkAddr and not only some.

Is it possible to changing __constant_htons as well in the entire driver?

Driver can be applied and compiled.
Tested device.

Thanks

Bye Philipp


