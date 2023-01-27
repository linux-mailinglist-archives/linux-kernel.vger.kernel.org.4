Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD12767E1E1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjA0Kj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjA0Kjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:39:52 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73BC1735
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:39:43 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m2so12061695ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHUCKrA1MY38l7jRww/OzcG36j2wbt8exUM91ClGZ4Y=;
        b=5d6apryI9mFbBoUjZOS8Xx1ePaL4MxM3dEbE5pWtVW8mPdMWkqpsB84y55XhvLEkAs
         E1r7D3SNDM4nhNiRs43v4lYkMD7jYBz9gVlGfCxWEQRyUs+rPmnbSwzif5IeGeyjcN8C
         Zcu9pP4M5yYJSdL5O1qezEhrzlf8fvahLBwReFvKawehm7xtpz+bfx5VtcGaa4umgjOm
         s1kUiIrWx73bFXL9Id4uzksKiSdNuxYrUhe7G/78yTG5ESqjvYfcdJG/RRzT+1bcDMCU
         v4gSITujqY5K7DrOI8KgkxsNVaG/MjXnndyCsQ9wVak5ppj6a34t0k3d8xN/eYb4xSvB
         8uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHUCKrA1MY38l7jRww/OzcG36j2wbt8exUM91ClGZ4Y=;
        b=aELMUNFB1ZteJ7+Xs2yvnsee39lqbThDfraE9oqgmd0dpOpjjKLUE4xFFeT9CvdhTk
         +j+ngFltt8SCpLcTjg4rYSeDFCnHLp+gIuQP1IhgapSYB/UV1CHiX7z1tBd9VyJbYCNg
         xzHg2iPnS+7UhvRnBKcDov1r4ekmjKUuD5zyGXV/semgQMnRWptso7cxFwMWGqtJwNOr
         mWBoBDdvM2vuRv+LVR9LyZ1IrUhkyDamc+q0AU1n2VsUpVv5MjeNLqZI4kbwcZm+CEhm
         C5kRXN7DqOpyQ5FqDpa9j3PCCxhGfNMkgd+9FmfOAy8UbfRcbw8w6soDyBEUgmX6tUbr
         e7Qg==
X-Gm-Message-State: AFqh2krl7IT5Fyz50FtslBhJlQc/m3I4kbnuL2zAY8X150QuadN8WADu
        M9oSjcuLDx9ZUq8nVRkqGZ/SQQ==
X-Google-Smtp-Source: AMrXdXukb3OHj8+zRZM4EDwTZoRvm5RlruWK3CW5QoarRIhNICqbspdxta5wCU8TbbyusGrXGZr2Mw==
X-Received: by 2002:a17:906:8608:b0:86b:9216:2ddb with SMTP id o8-20020a170906860800b0086b92162ddbmr42868059ejx.52.1674815982304;
        Fri, 27 Jan 2023 02:39:42 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id hd16-20020a170907969000b0087854d35687sm2049640ejc.172.2023.01.27.02.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 02:39:41 -0800 (PST)
Message-ID: <1de50d67-1c1d-bf5e-5409-d0cc19aeda73@tessares.net>
Date:   Fri, 27 Jan 2023 11:39:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Content-Language: en-GB
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Gerhard Engleder <gerhard@engleder-embedded.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230127123604.36bb3e99@canb.auug.org.au>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230127123604.36bb3e99@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 27/01/2023 02:36, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   drivers/net/ethernet/engleder/tsnep_main.c
> 
> between commit:
> 
>   3d53aaef4332 ("tsnep: Fix TX queue stop/wake for multiple queues")
> 
> from the net tree and commit:
> 
>   25faa6a4c5ca ("tsnep: Replace TX spin_lock with __netif_tx_lock")
> 
> from the net-next tree.

Thank you for the proposed patch. I had the same conflict on my side
with MPTCP when merging net-next with -net and your fix seems to do the
job correctly!

Tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
