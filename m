Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726DE5BA214
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIOU6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIOU6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:58:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067415B055
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:58:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y8so21846366edc.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NDCKnBLvpg2LzjJfGZYpFUUWi7Xx7OQNK9I3O7rWqI4=;
        b=XkTBdCZA1pW+4DBLzM7t8sWztEr3z1dAcLmCVVVrMKZVBVZAjfmfcWiALKh7HyVULj
         bQWMJe281YQOr+OlIqDf7jo88wsF9Rjw5PQQn5wqJyCKuHsa2s5s7bKTQoTTvagbLeoG
         vXLO1KImc8WrXAk7xgN2oEm7XbMV0iSbAiBSUjRLrOdximVk5oPFti7BW82SaVfC5IZ5
         +O2daOu+hfNC7E4DArjFfYB8t0kbnViSCUpFpIlm249sRCAFrd/EenVNPowkB3g3FlSD
         6ObOzqUMEUNC15uk6ivvWSvwiE4K6pDHYTKm48ZPB4x+rC9OFUs8PTzLwUiOs3SvgTcE
         oJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NDCKnBLvpg2LzjJfGZYpFUUWi7Xx7OQNK9I3O7rWqI4=;
        b=KveJARQN6ISTwvx95XSTaQ+FblzO0iUHXjFyYIG03r1hQaHXaxQQeFsHy9Ix/scgfa
         NDkKCUUmriCa+6AOaKy07eO24h6GkimBL2lzKhwDJTdQsEJZmLNlBWyU8Ew6lGd+SJN0
         y3KYfsX6xVQEV5p6SMRcCtc2SG2FCuFVmDNPiTQo2KXENnWR96GcCDw0c9O17quRkMYd
         TUqD0Fu+SlGuPVQJlvcPD83o4+/GIzVLPgzuBuL5AxNn5/MWUYs462PEjkmWxmAeQ/X2
         znLiOlQhYY9bvIG6FGeyQMuEi+APpfGv+QX0+TS5SzlTQmdLXnMhwe6KHfsamltQIuOK
         Ra9g==
X-Gm-Message-State: ACrzQf3eb0+snzt2XgwMPe+waWsjJN0uCRDolbVJTsDcQ/k+DaDCbai9
        2hY9srtSU0HSmE2iz1TmpmQ=
X-Google-Smtp-Source: AMsMyM5AX4Q55lUYX4I+iFuCwfkIARLhUl+5P7BJuNiQ4hZIr9T+skJIc5H0zzhkIUVx3CA9JqoBlw==
X-Received: by 2002:a05:6402:1655:b0:44e:b208:746d with SMTP id s21-20020a056402165500b0044eb208746dmr1410266edx.229.1663275489620;
        Thu, 15 Sep 2022 13:58:09 -0700 (PDT)
Received: from [192.168.1.100] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709063ca200b00777249e951bsm9593972ejh.51.2022.09.15.13.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 13:58:09 -0700 (PDT)
Message-ID: <a046af7f-7b60-108a-39e8-9ac3b5ce7733@gmail.com>
Date:   Thu, 15 Sep 2022 22:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/5] staging: vt6655: Implement allocation failure
 handling
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>, forest@alittletooquiet.net,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <cover.1663273218.git.namcaov@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1663273218.git.namcaov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/22 22:29, Nam Cao wrote:
> This driver does not handle allocation failure when receiving data very well.
> This patchset implements better handling in the case of allocation failure.
> 
> Nam Cao (5):
>    staging: vt6655: remove redundant if condition
>    staging: vt6655: change vnt_receive_frame return type to void
>    staging: vt6655: split device_alloc_rx_buf
>    staging: vt6655: change device_alloc_rx_buf's argument
>    staging: vt6655: implement allocation failure handling
> 
>   drivers/staging/vt6655/device_main.c | 41 ++++++++++++++++++----------
>   drivers/staging/vt6655/dpc.c         |  8 +++---
>   drivers/staging/vt6655/dpc.h         |  2 +-
>   3 files changed, 31 insertions(+), 20 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>


Find in this email a comment from Greg about RFC:
https://lore.kernel.org/linux-gpio/YwS4WDekXM3UQ7Yo@kroah.com/
This patch is marked as "RFC" but I don't see any questions that you
have here.  Please resolve anything you think needs to be handled and
submit a "this series is ok to be merged" version.

May be this is applicable to this patch as well.


