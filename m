Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543116154D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiKAWPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKAWPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:15:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D541A383
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 15:15:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f5so19124864ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 15:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Tj6LMlid1xqeP/OugEx6eshEoLxwhpJ2MaPH/4J8sc=;
        b=HTFJBL9J0F7Z1cd/8Hjsp3KSPVYnmAiSIdeEF+dtoljPVhoG5SMj9H8jzOvl/1ur2b
         INV80sxQYR6xrhtKoMgnQI8qr+moluapFVh0T1sGH+k+oTlVt7CzdEzhLmSpfMfCTEMz
         Mu/uX7n+gyVhBQASGIOpfy+OmRrgQHvseyi5eDbcLrqm5AoKI+hsZPfXIWOkgmJK4CPd
         LL9gCZS8ptzuhukIUo8s51ZwGvvmAfMT0Os816kLJYxWsjUCUUAVb+aIXgYClDB82h8J
         XRhihvbP1Mivm2jnjFuB+8KkIxrwluOUZs4YeisAirTZzli6odoGA5JrkhKAJf7ECoW8
         j/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Tj6LMlid1xqeP/OugEx6eshEoLxwhpJ2MaPH/4J8sc=;
        b=BdUIqgR62V98io7oXoRpcmqJ15OLlpOujmSNI8yVhu8+yQoEeBGZga+4zR0ekEeITa
         oSuxtD50a0xq625nwH7QrLD6ycrQZZGyWPh0v/gEz/+X+jo0ZrmMKCW7wXyBla2mUmyX
         9hBxONnc2zVFGrgiWqPcBYvE2rcQxFmkmV5OvdBghHr4mA2vmJbrsmDkjBKr3dEKybSa
         vTh4et308NO7HZetkSnfKlb1aqj1PP9h8wbejzX03aamw+9VZiCYSeJMhu+mUdQUS4su
         lMFdm8sifr4AESfaSqdDtVKWFs0E0fvabPviEp3kd1u1uO8DxxHXaMFEhA4vIK2V7auV
         z2CQ==
X-Gm-Message-State: ACrzQf39a1yDK5KMMrRz23WsyxHlt4GjOxHfCzfoHAWH5P/I7llHDGSb
        Iqy3mXtfwni3ZYxqdzxJbdg=
X-Google-Smtp-Source: AMsMyM61egOW8fwD1jxTVRXlrrlYoJderSJOPSy+elRTByUuddOZPISb2AArbAAKex/5lgo5BZLTrw==
X-Received: by 2002:a17:907:971f:b0:7ad:e232:f115 with SMTP id jg31-20020a170907971f00b007ade232f115mr8922207ejc.754.1667340938658;
        Tue, 01 Nov 2022 15:15:38 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:b885:c7c8:ee47:4872:331d? (p200300c78f2ab885c7c8ee474872331d.dip0.t-ipconnect.de. [2003:c7:8f2a:b885:c7c8:ee47:4872:331d])
        by smtp.gmail.com with ESMTPSA id d25-20020aa7c1d9000000b00456c6b4b777sm4874818edp.69.2022.11.01.15.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 15:15:38 -0700 (PDT)
Message-ID: <f67a1a02-addf-3197-e423-7c66ab97f6df@gmail.com>
Date:   Tue, 1 Nov 2022 23:15:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/2] staging: vt6655: some checkpatch fixes in the file
 rxtx.c
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <cover.1667326000.git.tanjubrunostar0@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1667326000.git.tanjubrunostar0@gmail.com>
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

On 11/1/22 19:17, Tanjuate Brunostar wrote:
> These fixes are focused on the function s_vFillRTSHead
> 
> v3: changed the function name from fill_rts_head to fill_rts_header as
> head is conventionally used in lists
> 
> v2: changed confusing changelog messages
> 
> Tanjuate Brunostar (2):
>    staging: vt6655: change the function name s_vFillRTSHead
>    staging: vt6655: Join some lines of code to avoid code lines ending in
>      (
> 
>   drivers/staging/vt6655/rxtx.c | 48 ++++++++++++++++-------------------
>   1 file changed, 22 insertions(+), 26 deletions(-)
> 

Patch failed at 0001 staging: vt6655: change the function name 
s_vFillRTSHead


WARNING: line length of 138 exceeds 100 columns
#58: FILE: drivers/staging/vt6655/rxtx.c:915:
+			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, 
bDisCRC, psEthHeader, wCurrentRate, byFBOption);

WARNING: line length of 138 exceeds 100 columns
#67: FILE: drivers/staging/vt6655/rxtx.c:934:
+			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, 
bDisCRC, psEthHeader, wCurrentRate, byFBOption);

WARNING: line length of 138 exceeds 100 columns
#76: FILE: drivers/staging/vt6655/rxtx.c:948:
+			fill_rts_header(pDevice, byPktType, pvRTS, cbFrameSize, bNeedACK, 
bDisCRC, psEthHeader, wCurrentRate, byFBOption);

May be you need to consider to break this lines.

Bye Philipp
