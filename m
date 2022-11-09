Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE74162329B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiKISfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiKISfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:35:43 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D667B626A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 10:35:40 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c15so10849796qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 10:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iZ/4tmsjV7ZPuMXnzOLu/+WMpzhYIpIQo4hyCHCrQq0=;
        b=agiHR4vcOVWhu4jFxDehFO2Xt/DHL6n6i97wfbIK8zHP9wLPGHDWIel/mKX7Cfk2JO
         NYQlaA8D8jADhehfZINiVB5LOjRmA0K6pSNzFOJJRzLHqxMtrC2hQrz+k5ivwBk4jwoW
         bKnaBNmu3m800uZ76oXOl02U0hmJ8k0w2ViwvrQguPZuKNjG76sDHdh2JCxQeMiS6Seg
         lLTPzHBrKkE0c4A8bldPOkRV6hdtyt1m6ZcIQ6pQMwviqb74B4+dpGCip9uVo8tUvhTc
         /673WBU19XerGEJ1ziLIQMsqeL7tfG6VqTV8yDHAomqydeIWNrC7I6xSh8rdgL1H4SlS
         Xcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZ/4tmsjV7ZPuMXnzOLu/+WMpzhYIpIQo4hyCHCrQq0=;
        b=QeDWiANWm5msPHQeQyv4Zha9mBbrsLIlgUjqu01cvnAWkE4w46h1BN1OHNaF13rDTY
         YVh/5RL0tl9R7aAPA6WfoVhWMKvX1vAx+qAcRzXqJEQbdM1Eg+bqNXTPSYTqB+S2cf9w
         7GqIxPOlQFERTNwuJsDgljxt3VD47M7QcHsDn2IhDvAVVyRc4PXOOGy1hLZNmAewPb24
         UhTrIpFlBTI3YSsY643qoRFcUbBO7bMEr4bqXQSUieTQo97MGwQut4Q9iFkGi2neVigV
         X/R8aOad51pEsx3xeQqdy8RyAbOcyZ+lGmS4u8L/CvaehdygEAQ66F969w8eKiuqe/pf
         Jydw==
X-Gm-Message-State: ACrzQf2cxRxk40zYTi2e66/AOhn7oAv+B7h+jRI9Z7k1yvdHkWulYb21
        /XEwPiSv+Wvot7CM+wnMFr0=
X-Google-Smtp-Source: AMsMyM6apDk/KAtv2qKSCu/8HXleKiDQp+eIHm0+w0/UCq8ojqtNuMk4gUMJpVSbHAMLSO0B4jBuSA==
X-Received: by 2002:a05:622a:5d1:b0:3a5:3818:a067 with SMTP id d17-20020a05622a05d100b003a53818a067mr36277856qtb.574.1668018939544;
        Wed, 09 Nov 2022 10:35:39 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6-20020ac84e86000000b0039cb5c9dbacsm10287856qtp.22.2022.11.09.10.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 10:35:39 -0800 (PST)
Message-ID: <ae008dd1-8dda-56a0-d877-de925e628438@gmail.com>
Date:   Wed, 9 Nov 2022 10:35:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] ARM: mm: fix repeated words in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220831062708.10239-1-yuanjilin@cdjrlc.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220831062708.10239-1-yuanjilin@cdjrlc.com>
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

On 8/30/22 23:27, Jilin Yuan wrote:
> Delete the redundant word 'there'.
> Delete the redundant word 'as'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Can you toss that patch into RMK's patch tracker:

https://www.armlinux.org.uk/developer/patches/
-- 
Florian

