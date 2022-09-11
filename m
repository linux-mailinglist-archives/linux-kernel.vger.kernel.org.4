Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A85B4FC2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 17:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiIKPnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 11:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIKPnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 11:43:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CEF6348
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 08:43:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l14so14854811eja.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Xc7E1lBgznckEXMi4QFl8det6GUa77V3zF2hPz5HuOI=;
        b=CcAT90Jbo/1/B5vl/9XzpIeRsjblN1u373zv/XAVswQ0eiKyknXbEnWTqr6EI9pYuR
         bkIA3srLZ1D7af+hiaRCl4GAtThr7pzgC1+qxN0XxllcL70H9DA2Bkg5oI0GnWm3kP+a
         Qm1Ryp7ruHA43zDV1RSJ9VRWIlXAAhdaTZAzjDp9ZPDBJ8tyRRhoSZdXty4qaN6GYpzs
         fSRO70arqIDSclMw4dJ4oU0ST2jH8j4hbINxNUZGtzBVQoq4zA8Pf8f1fQy77MHlxVFS
         8EDdscaC42cETeA/Ase6Cu2OOwn/Rlfbib/eS73Jp2QfhKVjXhO7JKAKtzwKi1JJrW/y
         euBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Xc7E1lBgznckEXMi4QFl8det6GUa77V3zF2hPz5HuOI=;
        b=E5PrqGeihNs7Xle8HB9RDF+5uVuhvIHfrZoxXtO+TbE6lqS9ERhz6p1Q2ukgSuTNFE
         XqvLnJ4C0FlM9wfJfT8SG0MGFddv8lVuCmfB9vpCMHxRmzQ/MFf5vhzL95uDB+Ueu2MT
         Akx6DmanMmFZ/MM1J3QqHRaDewrqSjqq1WXQRaxq5piLHhhA8aiwFzruzoJZ455nLVdh
         AWoCTVw2pvZlfj5ZQm+I2kZKRgapr5bUy8mQSoCkWXKWw4laI1csU4XI5GbvlIgfF1aC
         2htUx9bqmzaV4o5II/feAQn71kA7lv1m6T4Ww0lTEm2yzlMSPXM+eSB+HFZk9puQYKor
         Pf+g==
X-Gm-Message-State: ACgBeo3YXzVCF3U3WzZvLfpMnXiFiwVrYXIOBY79e6pd3uZkeyVwIupn
        FVXLhetir9lOy3hFBhPCNaM=
X-Google-Smtp-Source: AA6agR4Nt9BKU8QfZIm0dYMC8MtUv3gjwpBoX1HTk35RxiqALbEFF0CHBS1bUgRKS88nvIBF7K9K3g==
X-Received: by 2002:a17:907:2d23:b0:77c:ed93:3dc3 with SMTP id gs35-20020a1709072d2300b0077ced933dc3mr1748863ejc.705.1662911030988;
        Sun, 11 Sep 2022 08:43:50 -0700 (PDT)
Received: from [192.168.1.100] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id s1-20020a05640217c100b0044ec76521a1sm4144241edy.55.2022.09.11.08.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 08:43:50 -0700 (PDT)
Message-ID: <df265810-d580-c447-2fa0-907a773802ec@gmail.com>
Date:   Sun, 11 Sep 2022 17:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/9] staging: r8188eu: more led cleanups
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220911145122.15444-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220911145122.15444-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/22 16:51, Martin Kaiser wrote:
> Clean up the init code for some of the blink commands.
> 
> Martin Kaiser (9):
>    staging: r8188eu: simplify the code to prevent scan blinking restart
>    staging: r8188eu: cancel blink_work before scan blinking
>    staging: r8188eu: update status before scan blinking
>    staging: r8188eu: simplify the code to prevent tx/rx blinking restart
>    staging: r8188eu: cancel blink_work before tx/rx blinking
>    staging: r8188eu: update status before scan blinking
>    staging: r8188eu: simplify the code to prevent link blinking restart
>    staging: r8188eu: cancel blink_work before link blinking
>    staging: r8188eu: update status before link blinking
> 
>   drivers/staging/r8188eu/core/rtw_led.c | 120 ++++++++++++-------------
>   1 file changed, 57 insertions(+), 63 deletions(-)
> 

Observed LED: OK

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
