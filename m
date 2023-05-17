Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC095707461
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjEQVfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEQVfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:35:22 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A548D4496
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:35:20 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-331333e6bf1so3331715ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684359320; x=1686951320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cpkfZK97bVUEfKM/JFk2OFlMLe5KFCATcquMVOj4mM0=;
        b=XC/fdbzdrA/Wqaw9xO05G9XJX8u9UxQZ2fmLTfWLyyyXOAW8DtSyHTkJF/cACQ1fl4
         b8/M2NBZsvD1dIIQf19gcJt0Rm5lIgNmHO0XQusiIQ2gJyJ4l59RskZTBBtK1We9r9bn
         hIUITaGFX+fA+53j9vKcIWoeKwdcLio2DCMKb0byC9nmz7iLWDW11Xg4CiAz11xC1Ynz
         sVZ3W7kuWdSjAVBX9pC6N6H/Lq6vE7mSRpaGMMTvqIsuk8B0QBuo4+zv6yqdANWe3GvD
         rUwSm96MFppVeNCebrY4a7iFilpirnQLs05AiS2WNpTO2g7dWYhqHY3jOx0GWn81SnPK
         u9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684359320; x=1686951320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpkfZK97bVUEfKM/JFk2OFlMLe5KFCATcquMVOj4mM0=;
        b=Pc6bzeV9rssjZKucOkT5uoKbvBbu+l9JNOsnCAcTyZZqnNY7CAl1iSA1J8psjT8Kr2
         21d9P9k1Otqp0IhQ2B/LHnRz1gsArnpiqtRfJHuHYWeYYGiBpVpIl0o/HRh+i6oNdnuH
         i8Jetx2xb4ybLOYFGpmYktpGjLiKZGx9aFHMpWFMHD9Q6UsBXk4v648CA3enA1nlyigo
         36oIKRwrDm9qzbyqZBmW7+2UQ3YXPiN+ppBlYBByYVCqtuil7HjjWW77Snc0ybXHFINL
         AGubhzAYAqfmtgG0AnIOEpqgMVXcWrN9jHA8npuXVayEZN7h3TAVuyZ+PKYxnSrmEPTi
         gxag==
X-Gm-Message-State: AC+VfDzCMdlyXLwUAJ4bg82K47LWaym4ER+Lp2a1ThCBOLAis9Ii7jrk
        BHMNIAZ8wpfocm3rsYZ9gXFXWNaYw7yi0GAI69JhLw==
X-Google-Smtp-Source: ACHHUZ6qs205H89i4Rzdl5Vy49xmYJmIIJne+edDb2ytneRBrC22RkUb1g2Tb88ZcMXjbD+dVP+Tug==
X-Received: by 2002:a92:c8c3:0:b0:337:de0c:9c89 with SMTP id c3-20020a92c8c3000000b00337de0c9c89mr2705536ilq.28.1684359319883;
        Wed, 17 May 2023 14:35:19 -0700 (PDT)
Received: from [10.211.55.3] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id o15-20020a92c04f000000b003315d22557bsm8384212ilf.57.2023.05.17.14.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 14:35:19 -0700 (PDT)
Message-ID: <e8391577-3883-9e31-b5a5-b407927a56d5@linaro.org>
Date:   Wed, 17 May 2023 16:35:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: IPA_STATUS_SIZE, commit b8dc7d0eea5a7709bb534f1b3ca70d2d7de0b42c
Content-Language: en-US
To:     Bert Karwatzki <spasswolf@web.de>
Cc:     linux-kernel@vger.kernel.org
References: <8a1beef0bc605756f8a45acf86f6bb58c188ae21.camel@web.de>
From:   Alex Elder <alex.elder@linaro.org>
In-Reply-To: <8a1beef0bc605756f8a45acf86f6bb58c188ae21.camel@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/23 8:04 AM, Bert Karwatzki wrote:
> commit b8dc7d0eea5a7709bb534f1b3ca70d2d7de0b42c
> Author: Alex Elder <elder@linaro.org>
> Date:   Wed Jan 25 14:45:39 2023 -0600
> 
>      net: ipa: stop using sizeof(status)
>      
>      The IPA packet status structure changes in IPA v5.0 in ways that
> are
>      difficult to represent cleanly.  As a small step toward redefining
>      it as a parsed block of data, use a constant to define its size,
>      rather than the size of the IPA status structure type.
>      
>      Signed-off-by: Alex Elder <elder@linaro.org>
>      Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> introduced the IPA_STATUS_SIZE constant as a replacent for
> sizeof(struct ipa_status). IPA_STATUS_SIZE is defined as
> sizeof(__le32[4]), but sizeof(struct ipa_status) = sizeof(__le32[8])
> and the newly introducded ipa_status_extract operates on 8 __le32
> words, so I wondered if IPA_STATUS_SIZE is correct.

You are right to wonder about this.  I think you have identified
a bug.  It is a bug that most likely almost never matters (because
the status size is always proper--and not too small), but it is
a bug nevertheless.

Would you like to provide a patch to fix this?  Otherwise I can
do that, and I'll provide credit to you:

     Reported-by: Bert Karwatzki <spasswolf@web.de>

Please let me know.  Thanks for inquiring about/reporting this.

					-Alex

> 
> Bert Karwatzki

