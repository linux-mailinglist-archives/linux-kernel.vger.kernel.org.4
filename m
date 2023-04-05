Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A5C6D83FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjDEQqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjDEQqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:46:36 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972B535B1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:46:33 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7589c3519bfso1094439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680713193; x=1683305193;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzDRh3J+8SvEaXn0A+6OwXdLsL1cECKaJ2d44EZkMv8=;
        b=cvI9QcotuV/WktpPWLiG9q4P4hb+fv6+L6fSPKWafHE+/Rha1cywCFPBTcxcs7VOfF
         N2ouY2O52fIxorXrYcHLYhkSGr5sQ1qOJw8wE+22T7X5px1V2h0oDQtykbM00fv+er7Y
         ciNCEt6vEUY3Ost7gBNPDhWIpDUWZrJ2f7UQ7gmXcxcDWUzSvUWcTaAn4zEZf7xmmHQ5
         JuyZih1ualPwJ4GOudcl4LRQ/+nICcjsA1Ne1W9BLHY1ePAq4HJQMeWlv1hV5wlFfj9j
         9HONukPaW9BEyzUlrOr7RjHnP0crt4tssSxH+GSgSZEv3keTR95daTnBl1Zq72l143Gf
         cA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680713193; x=1683305193;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzDRh3J+8SvEaXn0A+6OwXdLsL1cECKaJ2d44EZkMv8=;
        b=B8mysg5nFb578ZPkO2l5NPqVJzhDve9STxQ+5fJTpw8ns0ujKQncvPI+01M5xrA/NC
         NIMNJuJD+E5SrLEMQgmDBHa6oA/235CX9mnPl7Hbl6zyj1KVJsBH2Ee67o/scxsNgyi5
         YxbRITkNKnCpLs2WRFWfEaxBsgTlST7hesbgEAJyQD0GAqSR8ZIDRY/icvkOydGxsPQA
         PGRqP4BWv5S0NY+09LbgeoEAUDMMnOQ4xfJ8bB1E07OE6yBFIV5rh6RU2EeaQGDJigsj
         TMtt82P2hJcJ/LIr96NQ+zs6qPHzJSaCVXT230vNm85v0c5p11Ai7yTN38TUofjYzTeb
         h6Yg==
X-Gm-Message-State: AAQBX9dN+39EBCNzP1z6OHYGkAEUmem3PMm9IRvd5c0gG2kY2Lj4fM3f
        xVfYg9E+fb09r5SFsWwS2YcQyhCQldno0YT4WiSt1A==
X-Google-Smtp-Source: AKy350Zpwf9mFVQTQK0zdVakkitvp5e+RlJjveBB+ifhwqXu+VbfbTE1RvfDJdPOPfDc5Uo0oYEAHQ==
X-Received: by 2002:a92:7d04:0:b0:313:fb1b:2f86 with SMTP id y4-20020a927d04000000b00313fb1b2f86mr1403917ilc.0.1680713192956;
        Wed, 05 Apr 2023 09:46:32 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 19-20020a921813000000b00326ca02f30dsm800189ily.65.2023.04.05.09.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 09:46:32 -0700 (PDT)
Message-ID: <aae10acf-7567-48e9-37b5-12db6a69719e@kernel.dk>
Date:   Wed, 5 Apr 2023 10:46:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: kernel BUG in find_lock_entries
Content-Language: en-US
To:     "Dae R. Jeong" <threeearcat@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZC1S_f9nworAQpm_@dragonet>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZC1S_f9nworAQpm_@dragonet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 4:52 AM, Dae R. Jeong wrote:
> Hi,
> 
> We observed an issue "kernel BUG in find_lock_entries". This was
> observed a few months ago.
> 
> Unfortunately, we have not found a reproducer for the crash yet. We
> will inform you if we have any update on this crash.
> 
> Detailed crash information is attached below.
> 
> Best regards,
> Dae R. Jeong
> 
> -----
> - Kernel version:
> 6.0-rc7

This is pretty old. Does it trigger on a current kernel?

-- 
Jens Axboe


