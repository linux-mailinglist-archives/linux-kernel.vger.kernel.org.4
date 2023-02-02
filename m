Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD2A687344
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 03:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjBBCNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 21:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBBCNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 21:13:02 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EF3A25D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 18:13:01 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id s4so532809qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 18:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmp+gLg2mSwFYsxZZpssJ7RfilX35F9BxrqBwqKEOfM=;
        b=CMH1KQaeR1zBMkTvorqv6ltZsHsXpyIxEnJIO+Wi88DESKoLf5MC9TsmRskvy4/IVc
         mGU1VWpCFb2D4Kz+Na9vZEF9uQR6CdUTI8EFbNY/JPy/f/JbNOPmv106EEEZREc6Oc77
         8lwBAEgzxjDKaH1JpUNwOWvRhVTLIHP/Yd4KkbRJNLQFXMFXy5E0aLZQxHmbgZYGZygA
         tVxbZOhsow7KI6vaiEJHor6+QfAbSzs0VoGbmbKtia/wHorQj42Cs9Si/TEut2uolTTl
         nK9dxUwoZBmvfvz3UKAimUrnOlYJsCYq2NT5GQtFMPKT4TaOtAjPCQU3NfnioTRHanic
         rerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmp+gLg2mSwFYsxZZpssJ7RfilX35F9BxrqBwqKEOfM=;
        b=UblQiglrBCb9RhTvXzAcvHmMjCiSAplEatHxtsaaAcOahwu4+Lgz+pNUAObyyuXS1o
         U6sEC0vRfYT4ET89sbHfyDm11Qg+nKPoTgmZj2HP8dFFCTd73HmQtIOaEV3N23tdSkVP
         Vr0lmKJ0E1xBMPx0vgizZx5Ew7Ud5+AXhRHGEdLHs+BpYJHj4DU29JPJZNToxYGQwA5O
         JM4IhX4Cdup1wfH6Zo7v318KMOCy8ntk0web84V5ZZZ5hcLzGyLyhYMa9JwZw/9y8HgR
         yQ8Ae6lA+wtdkO5/Qr2YQDPNJjdcYid8izLFQ0T00k6c8UXGfUp8TV8T4LNXUGyUfItO
         Lvag==
X-Gm-Message-State: AO0yUKVpdEXc9RusG/UcDl/LPqrH8UJHS3llb//yjGZgCmxD4z5p0/kM
        iCKWlnjU7m77Ecd2qX5rXOywpGRANq8481EY
X-Google-Smtp-Source: AK7set/NhmMODJ/+csynPebZ9of6l0csjZa+SU2VJG6GGm64zASG23DDTN79qA1xq1PXjeP78iRLKw==
X-Received: by 2002:ac8:5ac5:0:b0:3b8:6c80:c113 with SMTP id d5-20020ac85ac5000000b003b86c80c113mr8779770qtd.66.1675303980154;
        Wed, 01 Feb 2023 18:13:00 -0800 (PST)
Received: from [192.168.0.162] (cpe-74-69-166-246.stny.res.rr.com. [74.69.166.246])
        by smtp.gmail.com with ESMTPSA id p3-20020ae9f303000000b006fa43e139b5sm13188164qkg.59.2023.02.01.18.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 18:12:59 -0800 (PST)
Message-ID: <f72469f6-60bd-6bcf-be73-a804a1193e54@gmail.com>
Date:   Wed, 1 Feb 2023 21:12:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To:     faenkhauser@gmail.com
Cc:     alsa-devel@alsa-project.org, david.rhodes@cirrus.com,
        james.schulman@cirrus.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, perex@perex.cz,
        rf@opensource.cirrus.com, tanureal@opensource.cirrus.com,
        tiwai@suse.com
References: <20220811152923.10143-1-faenkhauser@gmail.com>
Subject: Re: [PATCH] Sound: pci/hda: Add quirk for HP Envy x360 ey0xxx
Content-Language: en-US
From:   Albert Tseng <tsengalb99@gmail.com>
In-Reply-To: <20220811152923.10143-1-faenkhauser@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies if this thread is already dead, but I came across this thread 
while debugging an audio issue with my HP 865 G9 (bugzilla report 
https://bugzilla.kernel.org/show_bug.cgi?id=216927). I think the issue 
with my machine is the same and related to the cirrus logic driver code, 
as suggested by Jaroslav (apparently also on this thread). The bug 
appears to have been fixed in 6.2rc6, but not in 6.1.8. Can someone add 
whatever got fixed to 6.1 since 6.1 is the stable kernel? This is also 
my first time using the kernel mailing list so I hope I am not emailing 
1000 people or doing something wrong like not opening a new thread.

