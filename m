Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0158360D98E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 05:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiJZDEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 23:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJZDDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 23:03:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2561FCD2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 20:03:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bj12so17740718ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 20:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9ynIFAF3DcHSRiFihWBoNbJID3cgAU90Hgr+Zp14k8=;
        b=YgAvV3fEXsz4gVdfGATDJcLEcI82bGyUBjf+c8tUEmHcN34J0NqyVcG0PbvSdLHn6p
         8PcisaQh2U0G1AmHb116VM9ejHomfY6UPZk7LeRAD0lY3IBIkRmjj3xSb7mxPaAT8WRk
         gWosfqjJdszBq2MLs4BVrQXVAMKVvZNFDCuMUD8I8+3V1F5A7OeBc9J914gOBfHAu4od
         LRzZqVSZmg09WK85zRqjHPnKDbK0RGYlSRflXT5H33Y4zUH3X6RsixPKTBdw+nRC75VD
         tUHd57CN0wlPZNmZVhBAilHDBFyjQ9+KJ9SIqVB6Z3oBn9OoDYiQ9sKX0qnQn8F52/xJ
         +h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9ynIFAF3DcHSRiFihWBoNbJID3cgAU90Hgr+Zp14k8=;
        b=zgnEdRghOoH+NVV9RhwS8+8ZIck4D1+z/0YKTuB0TpCz0FxfnViS9KnoYC6qIDyE7L
         bxnozVOE8L4Xz9SiWN9iL5KxR46DyGyCh4853hcDWLnIFXJ+KlckM7siXBGkNahGzqq5
         oXVWHNev5uwLSiNE6DP/Uw6lZ6nSC/gX7y/04JB85CC1ioVHHupfXOr1sp96Y/bu6fqa
         WsUKZkP0Gkiv+fh7zL5OL/DiMAChs80tyMVfJba13QmKvtpaFR2JshYUDt7p6ZH8FwiU
         FtLrNwEjd/UEo4hSUQQV0Ipfkf3lT3RaU4po/SZM+yRUawjlWYcCIBNbPpLIbOx6wuBs
         3Bhw==
X-Gm-Message-State: ACrzQf3+Nm0NAfG81YaxgQHep8uyEm3ILSQ+YTR6d2+h+n+PmhUEpAwV
        wUY++cvNsPzRaEXEX53AwjIxQqb7hqE=
X-Google-Smtp-Source: AMsMyM5BjNzJUZ8X+tJjbIq6WESS15PXp1ShFWF6a2WYtEdZoabupSiwikX42EGIj8ToVEzs03XjNw==
X-Received: by 2002:a17:907:1c8a:b0:782:1a0d:3373 with SMTP id nb10-20020a1709071c8a00b007821a0d3373mr34125357ejc.135.1666753427946;
        Tue, 25 Oct 2022 20:03:47 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:b844:c952:3daa:e0a:40ba? (p200300c78f2ab844c9523daa0e0a40ba.dip0.t-ipconnect.de. [2003:c7:8f2a:b844:c952:3daa:e0a:40ba])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b0073dd7e586f9sm2245751ejg.193.2022.10.25.20.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 20:03:47 -0700 (PDT)
Message-ID: <3c9bf2b6-1801-83eb-d4ce-418d34a31e07@gmail.com>
Date:   Wed, 26 Oct 2022 05:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/17] staging: vt6655: changed variable name: pDevice
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <cover.1666740522.git.tanjubrunostar0@gmail.com>
 <1f09760c8f6972b0e2b272060424b60a11166a0d.1666740522.git.tanjubrunostar0@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <1f09760c8f6972b0e2b272060424b60a11166a0d.1666740522.git.tanjubrunostar0@gmail.com>
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

On 10/26/22 01:36, Tanjuate Brunostar wrote:
>      change variable names pDevice to meet the
>      linux coding standard, as it says to avoid using camelCase naming
>      style. Cought by checkpatch
> 
> Signed-off-by: Tanjuate Brunostar<tanjubrunostar0@gmail.com>
> ---
>   drivers/staging/vt6655/rxtx.c | 354 +++++++++++++++++-----------------
>   1 file changed, 177 insertions(+), 177 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
> index 8bb06b142748..3565f5608790 100644
> --- a/drivers/staging/vt6655/rxtx.c
> +++ b/drivers/staging/vt6655/rxtx.c
> @@ -85,7 +85,7 @@ static const unsigned short w_fb_opt_1[2][5] = {
>   #define DATADUR_A_F1    13


WARNING: line length of 104 exceeds 100 columns
#376: FILE: drivers/staging/vt6655/rxtx.c:496:
+									    p_device->byTopCCKBasicRate,
