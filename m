Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9092C5B4B06
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 02:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiIKAsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 20:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIKAsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 20:48:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A091AF1A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 17:48:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id nc14so12536961ejc.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 17:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9edV5rmSSmQGfryMF8ZLiaiKUCdN0PMDm3CEK4ihJ9s=;
        b=gywwlPiIG5LPRnzM47WAaJ9kupy1tv2SXfZzAgtHJHfBgv8tB0gi7/OKn+zEcUSSja
         aSaNfHiYiV7bhSz07/Qm4Jl/CCG/Tmmtd34XBMWPHS1xzXV3/NyvToXKTKfYl1S+KtyE
         FF4vmIKFrksSuyLuFZSLlOt+xQgNVGc4eG4KE0htAD0jYHjflOhfGsKfwDkL6QzGJTWe
         8BxifUWyPaOEs+Z01NUoM2lOuuX2naxPE+muUIxQypWe/A/cHrmQcuPRAg6Rmg7wmY7q
         O8rHgFdxqMWApmEgRGtkBrpgsRsdnzavUbz+9hcZ6zU3qPJKPuhozvNCIH3IQCSKWRB2
         mfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9edV5rmSSmQGfryMF8ZLiaiKUCdN0PMDm3CEK4ihJ9s=;
        b=WIRK0U4IXDo0ID8og/8G/D/Hv8nNMXClmRJfWD3XXx5bHzMb6xOdf9AZtGX+bim3MS
         0Q7GG1NTjoLkDCKOqeyYz75R725VGA/f+VWn9LYZkXmghcE5wmXXEaB4fBF+scEAJTsM
         jbXuJ8QOQ+wtd8Fusy0u/vOf2AMvD3xCOmdgamCR/0sOpNt6aclDsymqUgb7G4JwO6yz
         kqsi/vF9vBz3dYlqGZRg4ARuSDFmUvEVyd1jhY7aqukWbvWIgG2zPsaUYiBnZCr9XGXs
         KF7hEL7s2n4dxGBtllPg/TphjKEjcRToDM0pMIrb3uHYM9YdX/smfIeedq+280q5/UuJ
         vHjw==
X-Gm-Message-State: ACgBeo1yjDN88w0ROVXW76gS/uvhXXiIu8ebFkQNLbJQTaD7JMlSVaAo
        ZLRCaGnZ7bsp54JmVlnxrNI=
X-Google-Smtp-Source: AA6agR6yp4ZaDiCMbxkMg5jcgXlBBsyqAhSX/EAQ3Ry+Z4lx/0MCr1hiehIzOkmVcgqKohxiIPnr2Q==
X-Received: by 2002:a17:907:9495:b0:734:e049:3d15 with SMTP id dm21-20020a170907949500b00734e0493d15mr14857226ejc.187.1662857324079;
        Sat, 10 Sep 2022 17:48:44 -0700 (PDT)
Received: from [192.168.1.101] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id x17-20020a1709065ad100b0073d87068042sm2316664ejs.110.2022.09.10.17.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 17:48:43 -0700 (PDT)
Message-ID: <227276e2-1bad-a342-eea4-c3672e50d275@gmail.com>
Date:   Sun, 11 Sep 2022 02:48:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] staging: r8188eu: remove empty rtw_*scan* macros
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220910180236.489808-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220910180236.489808-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/22 20:02, Martin Kaiser wrote:
> Remove four rtw_*scan* macros which are empty or constant.
> 
> Martin Kaiser (4):
>    staging: r8188eu: remove empty rtw_set_scan_deny macro
>    staging: r8188eu: remove rtw_set_scan_deny_timer_hdl
>    staging: r8188eu: remove rtw_clear_scan_deny
>    staging: r8188eu: rtw_is_scan_deny is always false
> 
>   drivers/staging/r8188eu/core/rtw_ioctl_set.c | 5 -----
>   drivers/staging/r8188eu/core/rtw_mlme.c      | 5 -----
>   drivers/staging/r8188eu/core/rtw_xmit.c      | 3 ---
>   drivers/staging/r8188eu/include/rtw_mlme.h   | 4 ----
>   4 files changed, 17 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
