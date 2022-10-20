Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBB8605EED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiJTLeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiJTLeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:34:16 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420F01D73E5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:34:15 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id r19so13455434qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+QdMHmI8npmmp+iYes8th9cPUVQ/ZQTtTKsNhs4o290=;
        b=qheArqHOO71lgaxRDsfwopO5wrdcUUQ0s20Pl8qqXReJ13WtTpgMzxd9t6rvKMctJA
         JA7IkSeVg63ohWqHrjF7GkpLcWCR1YgyKPszJabKQJk74iIeR2F714hcTC5jLyVQ4DSI
         H8IDJBj5FSETG5M399pKEBTt+VMH8hjrCMm5r6O7AsYxkqOpkNbDz8guGIpBEERd1nqI
         V4BuE2GmjfrXL8dvJShmgeuXEGVL4V1MeySxm5IMkqrujd5+rK5FubbP5ufjWfpQ4dNZ
         wpvbdWmSgg/3TNtv+L9Xs2SRqCn7V//yuu0fK9LV2YwI10BweGOZhjK1JJQaWJhb6GSf
         pt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QdMHmI8npmmp+iYes8th9cPUVQ/ZQTtTKsNhs4o290=;
        b=2GxfyCftDHty2AYWEZ+RvBV6T/IUOrapRo3O3th1I8+hR18seHofh8U2yeFaC2nmap
         WBpCOt1h5OihJRxTtUZo0MCwzARCM9IqjkRa0ET3mb903STCtCwrmxMMp9oPltYyT3bM
         Bdtfz/qNiEE8M9eIduFtwD0PT5+761FP/X5K6QVLs7wnN2imdvahDeWh/XaBHtXZQnOe
         /xuqFRR7dSU2vTs2thiH4HyFaLLhmRYxAQHzmJN3D449HK2P0QNHumFkDSYQYrWd1nnM
         CATQcdNt7ZMtQgJE23BbhGz7Vn5JRlkzMSZVYIfuBKZ9WI0qBuRd67oZ9BaGQ7iKHAri
         PnqQ==
X-Gm-Message-State: ACrzQf2lcJ7JM2tz1LdreWOA2B7PWtWuqnt3ywUl/ScQy7/xkRZMUnGX
        TruEMBkl91E7Ka0huHlY/OS5M5zt2q39p29tVBe9KTs48jpnLYzqBz8=
X-Google-Smtp-Source: AMsMyM7JviV/L/yl/wxRPTtsFVdFqARChEv1PYvqyMCb1l0y7trenutZtt5XlmVfuNH+RGmWfIimVg9AZZAugCVNgXo=
X-Received: by 2002:a05:622a:147:b0:39c:dc0d:7d0f with SMTP id
 v7-20020a05622a014700b0039cdc0d7d0fmr10070312qtw.281.1666265654402; Thu, 20
 Oct 2022 04:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <Y1Eqa7uKB+Wk+Mb+@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <CAOkYk0iU0B98JsH77avky--AS19V=GhQox2f_b4PAG3ZBB+SVQ@mail.gmail.com>
In-Reply-To: <CAOkYk0iU0B98JsH77avky--AS19V=GhQox2f_b4PAG3ZBB+SVQ@mail.gmail.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Thu, 20 Oct 2022 12:34:02 +0100
Message-ID: <CAHJEyKX=yyuyYFajs880CuPdc019dBOm_LCkgXHzjFaA-Jgt2A@mail.gmail.com>
Subject: Re: Request for assistance
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 12:27 PM Bhaskar Chowdhury
<unixbhaskar@gmail.com> wrote:
>
> Use forward slash at the end every single chunk or piece of that line.
>
> Example :
>
> Veryyyyyyylooooooong. Linerrrrrrrrrrrrrrr
>
> Veryyyyyyyyyyyyy /
>
> Looooonggggggggg /
>
>
> Linerrrrrrrrrrr /
>
Thanks

>
> On Thu, 20 Oct 2022 at 16:43, Ubuntu <tanjubrunostar0@gmail.com> wrote:
>>
>> Hello,
>> I have a diffictly deciding where exactly to split a long line of code. for example, this line of code is too long
>>
>> uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
>>
>> if i spit it this way:
>> uCTSTime =
>>         bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);
>>
>> It does not help as the second line is still too long. I considered doing it this way instead:
>> uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
>>                                 pDevice->byTopCCKBasicRate);
>> But i did this on one of my patches and i was told it is not advisable to split a line between
>> parenthesis '(' and ')'
>>
>> how can i go about this please?
>
> --
>
>
> Bhaskar Chowdhury
> about.me/unixbhaskar
