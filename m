Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4037B612C62
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 20:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJ3TPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 15:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3TPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 15:15:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E4DAE7D
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 12:15:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y14so24710811ejd.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCt//reQCph6olqDoKtED7itGlrW7yrg5Li1Wffc30A=;
        b=W6b1rTaklPfa16uZMAp2Ndof1pbYMCMUcVa/FB6uMEujB2tSJISZhhS+Mk/7JHhxF3
         TeNgUOJpv99D+hS5I73n+w8e9qTh2OGSpOke+4fAHExS6Rzk6OKbTxgD+t0wIB2Sw803
         uroft+ddfcLuEjrNZ3rVgn1D/psr47583WyLAkVokqwVn7n1cspz2Qv5ESM6RNbOZIaA
         ypw+E8P/dox+CZAVXSHrCA5PXfVg/Osa3JHC8tMLY/wps/QS4i6dS8rkYVFxgk4igtEu
         H809QfVM5E2vOPei8Ckl2gmUVnUV1KZXnPdN2mQj0uGjxNrKyDiM8RvYuY1CcMuiAp0T
         ILmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCt//reQCph6olqDoKtED7itGlrW7yrg5Li1Wffc30A=;
        b=wxIo0YV2sLPjtehVv9JHbpQOVjHmwrdD3/sRB3gMlgAm03hbOjq+boI0PkyHAQWQ3F
         5G8JYPSOhYvr7iv3Q0aLTchPoK8h9/B8LlpKd2PtctLWfgO+Acn27lsyMgByxY9olpC8
         UbeHon7tdpKIcxWj3oLN2bRpyA1X5WM6L1MV48YXP46Nl35M1ebq1GuXWHj6Pe5XyPLC
         kHFipzuddf6rUE/YuMef/qnQa6PlHlIk/1xiJOEYO0LFcbKHdjY884n0AlDMUtY5PIGm
         ONXOsAFVH1Uie2VwCNmYCnzDdBd700eIERi/16IbDe7Udz9uxUXFLalgQ/d9tcrlKnxQ
         y3ow==
X-Gm-Message-State: ACrzQf080i7NA4zCKtO8s+fQH30BuKPq5DNkXskeZLLR50NEDhxY9/UX
        FGPA8eGZzPIA7Ci6tHly2e8=
X-Google-Smtp-Source: AMsMyM6v6VmlO+ju8JeVienNERY/Zhv62XiVmwS1oScww+yPkbn76f46Xgf3QkI7vg/n0cn6KKLMpg==
X-Received: by 2002:a17:906:9be3:b0:7ad:d3a4:9df3 with SMTP id de35-20020a1709069be300b007add3a49df3mr1023758ejc.682.1667157340784;
        Sun, 30 Oct 2022 12:15:40 -0700 (PDT)
Received: from [192.168.1.102] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id ss23-20020a170907039700b0077a201f6d1esm2099475ejb.87.2022.10.30.12.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 12:15:40 -0700 (PDT)
Message-ID: <3aa15459-6e0b-7101-178c-424a066b7dbc@gmail.com>
Date:   Sun, 30 Oct 2022 20:15:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 00/13] staging: r8188eu: clean up action frame handlers
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221030173326.1588647-1-martin@kaiser.cx>
 <e032d410-60ed-9e0b-2818-bb849adebc78@gmail.com>
 <20221030184840.2root56lrro57xo5@viti.kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221030184840.2root56lrro57xo5@viti.kaiser.cx>
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

On 10/30/22 19:48, Martin Kaiser wrote:
> Thus wrote Philipp Hortmann (philipp.g.hortmann@gmail.com):
> 
>> On 10/30/22 18:33, Martin Kaiser wrote:
>>> Clean up the handlers for action frames. Summarize common code, remove
>>> unnecessary return values.
> 
>>> Please apply this on top of the "remove the last get_da calls" series.
> 
>>> Changes in v2
>>> - remove on_action_public's ret variable in patch 3, not in patch 9
> 
>>> Martin Kaiser (13):
>>>     staging: r8188eu: replace a GetAddr1Ptr call
>>>     staging: r8188eu: remove duplicate category check
>>>     staging: r8188eu: make on_action_public static void
>>>     staging: r8188eu: make OnAction_back static void
>>>     staging: r8188eu: make OnAction_p2p static void
>>>     staging: r8188eu: remove category check in OnAction_p2p
>>>     staging: r8188eu: replace switch-case with if
>>>     staging: r8188eu: replace GetAddr1Ptr call in OnAction_p2p
>>>     staging: r8188eu: clean up on_action_public
>>>     staging: r8188eu: remove return value from on_action_public_vendor
>>>     staging: r8188eu: remove return value from on_action_public_default
>>>     staging: r8188eu: rtw_action_public_decache's token is a u8
>>>     staging: r8188eu: check destination address in OnAction
> 
>>>    drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 116 +++++-------------
>>>    .../staging/r8188eu/include/rtw_mlme_ext.h    |   7 --
>>>    2 files changed, 28 insertions(+), 95 deletions(-)
> 
> 
>> Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
> 
> Thanks, Philipp.
> 
> I just realized that I forgot to add your Tested-by from the previous
> version. The final code hasn't changed in v2, only the intermediate
> steps were fixed.
> 
> Martin

Hi Martin,

thanks for the offer but I prefer to test each new version by myself.

I do trust you a lot but mistakes can always happen.

Bye Philipp
