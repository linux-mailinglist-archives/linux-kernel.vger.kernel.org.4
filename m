Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48EB63DD15
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiK3SWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiK3SVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:21:49 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A15BF8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:20:22 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z92so14748381ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9xqRGz1xSslCtB0mvFK3dCdt0jFZSRD11Uuiv//RHo=;
        b=TLD/IceM5UcmZNQ1KZemZVo2iQVdc/1MDLhV7LoqCtcRZS8sC/pVSZRSshoHCn+ZWm
         Oo6fUQbyy2D6/fT9i8pQSi47O1wB8ZZsKsfN/GUceaBVRCes76FHL2W9FU/ABSgE1PAv
         +CQojOwtmAqwA2QJ20hTUsL7umC6zmvsRG8axjI9FNBfamhMHpA3vpoxASJTSL1h9JOy
         txi6lKp8UropEUUGRuyVzwmTUocI5ynwNFQVhf9DX4Bw6Q6JZeGrN2UD330Qz3Qwry3I
         B7+Iq45euH4iFnh/FuSF2sGiiNfU54ndk2yaTIiDSmZovkE4zGA58cwF0K1uV81x4MB7
         i8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9xqRGz1xSslCtB0mvFK3dCdt0jFZSRD11Uuiv//RHo=;
        b=xsHe31YIfybFYLUM80rUgUBm7MPTU+0TGmE67TJ/YvqfrjvpgKrbeZ8VBm5d3d/nhD
         vBMamXi+hrpKxo/zkrgwai2WunwUlv04KtLET5BgamlTOc6FAJU4zIbUfjoGNjHHS+m4
         eVV3DRU9dtOfL+m3ZRbImjLN4gPSWGEta5xikM9pmRy73g7MboTUGUFo9WiYrU6idWdl
         xP5UDuhHcaa4QkAL0igmVoS/IjWYVxX1aCBRaREwIgcvgT1txJThLkUKwoE8E0t5nMMy
         uwGETb2t6o2nlAKmfVvr9/BwWk6lD78t35Z6cr0qK0qRq/2CMqYYP68QepvWr1GvTvkm
         gIyQ==
X-Gm-Message-State: ANoB5pnJbTPPuy8NkEuz+T6fHTYEEqsfjfDua62tm3/qIAmIRPDU3dck
        ao+AaZT3dh7RSeaiUQOp+hs=
X-Google-Smtp-Source: AA0mqf5neyWSsNdfRR7tR8TUGmuQLDl8sVDAGKKnK+PbwdhNqO4Lfr/sfsSthWGU48gQTGRpZ4bNnw==
X-Received: by 2002:a05:6402:530c:b0:462:df63:5ec5 with SMTP id eo12-20020a056402530c00b00462df635ec5mr56788105edb.147.1669832420465;
        Wed, 30 Nov 2022 10:20:20 -0800 (PST)
Received: from [192.168.1.100] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id ky16-20020a170907779000b007c08091ad7esm887001ejc.208.2022.11.30.10.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 10:20:19 -0800 (PST)
Message-ID: <a9f7f851-af2e-a0e1-adb9-d7cac6c0c57f@gmail.com>
Date:   Wed, 30 Nov 2022 19:20:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/5] staging: r8188eu: clean up OnDisassoc
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221129205152.128172-1-martin@kaiser.cx>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221129205152.128172-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 21:51, Martin Kaiser wrote:
> Clean up the OnDisassoc function. Use a struct ieee80211_mgmt for parsing
> the incoming message and reduce the indentation levels.
> 
> Please apply this after the two series I sent some days ago
> 
> Martin Kaiser (5):
>    staging: r8188eu: use ieee80211_mgmt to parse addresses
>    staging: r8188eu: read reason code from ieee80211_mgmt
>    staging: r8188eu: move bBusyTraffic update
>    staging: r8188eu: handle the non-ap case first
>    staging: r8188eu: simplify err handling for unknown station
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 47 ++++++++++-----------
>   1 file changed, 22 insertions(+), 25 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
