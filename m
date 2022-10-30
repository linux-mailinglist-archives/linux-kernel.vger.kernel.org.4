Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50C1612A2B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJ3KkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJ3KkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:40:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A370B7E7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:40:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x2so13797472edd.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fWh0jiw47wr5EpTblkOIk2Y0gZ5oFXjTyvGDtppfH6g=;
        b=RvdX4EeB4VauGLFSIqplc5pDhWhiZW2n2yUHMU9dsTSPAKV4OwnyOcHfzJkpYzk/nQ
         L6Zmdzi5HtlwmuQLHHZO8UnFuPMVaMEH38lYLXkky0MZO1Wg4Fy5Z6QI1X0Liubtb6ZC
         zOijB7Ogv8CM9UVlgkORYNbd/SqguGVSenqbTv4q8sbyRcDJzwqk8cGGhmj06UGHPVqE
         1n5BecfsKoYGmXWdlMa/3lRY0vaithZyjpDW56YNP4ZJklpLU2aA7ZlT+5x63jr0C2iL
         hdyn62Y21IYQVATUdV+zPmZSQ1ANsRtIFDi8/XC4DJ3gTFTnGAc+NzFb7SsIiyWBVDxg
         Gbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWh0jiw47wr5EpTblkOIk2Y0gZ5oFXjTyvGDtppfH6g=;
        b=m+pAFagPCyLGwoHrcieE7Elx/bidrs/F5Niy+0wIWDD2x0QMN9HxidEyrEAZIA3X+d
         QT8L5llyKNug8kNy404+wM2Q7Dx+gtmc70815xhNXUcnalmWyhh9sYa/tf6mQ8Iis2Om
         gMi2wU47WEuTLf+LpYFWrZA2Cd1ROT7IIHZ7TcVr45OIbAtdUmCp5Q7lOYhkmcPRv0He
         149WBrChWx3Hm6LzSBXB5wjKGpsdARq/V/d9P/Selkue7iQHg8XaUwkzlfHBbIgDaSWM
         8LaKhX48uDA+LR0sV1hss9PGII6S+dviwS4E5EcaYPbG5T13kTvk13B5a83DfRP3a/I/
         K+Cw==
X-Gm-Message-State: ACrzQf1RaBMXz/HKms/Z2AtstMTArHRIiSf7/EsdVCcisotUb94/BY1n
        uraGIFGtCQ3/jR+Sdz9Bxdw=
X-Google-Smtp-Source: AMsMyM5CE1OQ9M24HRS7BXtxwFnHLbCMv4ssc2A+JyI1WUaFYZmEQk9j9AdBivPLgiC5eSDIvEVgqQ==
X-Received: by 2002:a05:6402:2989:b0:44e:90d0:b9ff with SMTP id eq9-20020a056402298900b0044e90d0b9ffmr8049193edb.110.1667126406972;
        Sun, 30 Oct 2022 03:40:06 -0700 (PDT)
Received: from [192.168.1.102] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id i2-20020aa7c9c2000000b00458947539desm1906119edt.78.2022.10.30.03.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 03:40:06 -0700 (PDT)
Message-ID: <b589cbce-87a2-d58c-72e0-3f334a026ea7@gmail.com>
Date:   Sun, 30 Oct 2022 11:40:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/13] staging: r8188eu: clean up action frame handlers
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221029172337.1574593-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221029172337.1574593-1-martin@kaiser.cx>
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

On 10/29/22 19:23, Martin Kaiser wrote:
> Clean up the handlers for action frames. Summarize common code, remove
> unnecessary return values.
> 
> Please apply this on top of the "remove the last get_da calls" series.
> 
> Martin Kaiser (13):
>    staging: r8188eu: replace a GetAddr1Ptr call
>    staging: r8188eu: remove duplicate category check
>    staging: r8188eu: make on_action_public static void
>    staging: r8188eu: make OnAction_back static void
>    staging: r8188eu: make OnAction_p2p static void
>    staging: r8188eu: remove category check in OnAction_p2p
>    staging: r8188eu: replace switch-case with if
>    staging: r8188eu: replace GetAddr1Ptr call in OnAction_p2p
>    staging: r8188eu: clean up on_action_public
>    staging: r8188eu: remove return value from on_action_public_vendor
>    staging: r8188eu: remove return value from on_action_public_default
>    staging: r8188eu: rtw_action_public_decache's token is a u8
>    staging: r8188eu: check destination address in OnAction
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 116 +++++-------------
>   .../staging/r8188eu/include/rtw_mlme_ext.h    |   7 --
>   2 files changed, 28 insertions(+), 95 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
