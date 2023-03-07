Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E746AF582
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjCGT03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbjCGTZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:25:56 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED42BA83BC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:11:57 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s11so56596173edy.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 11:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678216316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjGDHfradnreRo6UYfZKEzLKIIACc35OFmOSBsjm060=;
        b=FtJ1nYeuEz41S28/CR0DwKgcS398lgjovYepPHPKp9REZv4pwacwpzKBowOlb/zq8P
         adPOda1T8fLngDaP4vRSMC3nwRat4Lbh6K9btiJa5KKevsugQzv/GAalZ4by6wr6JLUC
         RM4mjj36zaN1ItOo6B+ecrIBKC1PnbsrGCTFG86YMIjaIcIA+Aqy2DezL2dw2lVAR+Y1
         VhLFEVdJO4FICq0q9bdSLa37Bwed/WqYWD+8TNDgQ4clG7NMUdsXQyXoUPINW2gy1pc2
         JCdhLUys7EmGtH+aUs52VeY3UkIv3/ql8Y8OiXiYVanLylXpzcR5Z+AGzAc9cBNPVtrl
         us0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678216316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjGDHfradnreRo6UYfZKEzLKIIACc35OFmOSBsjm060=;
        b=ffoAILF/WG/qO11Ir6Xnq4XQgeCrg7MoKBz8Pdk6rVVyPd23ZWfwS8m4QlhIWHsrNh
         DL0MeE88AFHzOetlkXg6DCucBLGUQgj2PkiQe0NsAe+BHAdfLbtEigmz1ltxl0C6d8s2
         shKTeC/fQ9cbAKuTI7+sHcI04PopewjziKFdZQ2OHY7AmFQszYiQiRMJ+Ac9a2QDbviE
         uGSqiMgwFyld9t0z/LEephuJTRmk2djoHB2/tqIlz9yZea/iMH/PFcp8Z3zuMo3VSFiq
         bDNqyDS+SNfJveGpFG3s+s8+00BsDWtxPUmGgRzQVFgkrDPTxTR+mSEQVqoovOZDanOC
         KgpA==
X-Gm-Message-State: AO0yUKXcGDIfBz2qFMdRAD/foI+q068gK8IeLyw0omLFG9YTkIWCxmFj
        ogKQkmF5XBdaFV/VMxO5nfg=
X-Google-Smtp-Source: AK7set9TV4xCaOp6dxMSitSrkqtkZx3mwXks/3BaV44OP6uLvLbewHjyan74xGKvfAIhn55BLzehrQ==
X-Received: by 2002:a05:6402:26d4:b0:4af:81f1:5af0 with SMTP id x20-20020a05640226d400b004af81f15af0mr17211932edd.2.1678216315642;
        Tue, 07 Mar 2023 11:11:55 -0800 (PST)
Received: from [192.168.0.103] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id mb3-20020a170906eb0300b008e772c97db6sm6433990ejb.128.2023.03.07.11.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 11:11:55 -0800 (PST)
Message-ID: <11dafbf3-9ee3-515e-c4ec-e33020501097@gmail.com>
Date:   Tue, 7 Mar 2023 20:11:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] staging: r8188eu: two simple cleanups
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230307085003.5025-1-straube.linux@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230307085003.5025-1-straube.linux@gmail.com>
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

On 3/7/23 09:50, Michael Straube wrote:
> This series contains two simple cleanups.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (2):
>    staging: r8188eu: busetkipkey is boolean
>    staging: r8188eu: bgrpkey_handshake is set but never used
> 
>   drivers/staging/r8188eu/core/rtw_mlme.c        | 1 -
>   drivers/staging/r8188eu/core/rtw_recv.c        | 2 +-
>   drivers/staging/r8188eu/core/rtw_xmit.c        | 2 +-
>   drivers/staging/r8188eu/include/rtw_security.h | 1 -
>   4 files changed, 2 insertions(+), 4 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
