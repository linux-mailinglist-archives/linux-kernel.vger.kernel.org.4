Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A18A69E546
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbjBUQ5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbjBUQ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:57:47 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534182C67A;
        Tue, 21 Feb 2023 08:57:43 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id i4so517317ils.1;
        Tue, 21 Feb 2023 08:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkSUsr7sEV0zMw0SDdpsmFb9iKPZTDAvp1jFrUn8SXE=;
        b=TZaVUXjMl6ltndJXRsnFuHQreO9asrAUaPvfoLpCi9xSKjxfecW7xT/MnzZPfSYWKu
         zqMRcLe0WwhZ3cD5fzmiJls3jWLFxDJi5TfbXcoj5LgcpcWimxbqMC50pqSHet6+S9cO
         WXFfCUFamYS/aI2FLsALk++M+6/kCQZ3q1aB++C3hyRC90WRILo3JyHgoovmMHSvE8n1
         l+VbvvejeMxDt1x143LcZOufKNlLyIeKV+QRIHp2Yl3d78O8TOaA5K72R3FHNQQXRZxu
         u1s1oh1o/0JiHNWzfC+3HRd86bEVqATkYpmt6rIFm2EqynET+wciPjKlaMnvk14mqKd+
         iAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkSUsr7sEV0zMw0SDdpsmFb9iKPZTDAvp1jFrUn8SXE=;
        b=RPrHP2ncjtW42sFMu2ivSfhSt/3g7c1TQwpHZP7JEZztEGgthDsIibMSyFo0AJhxjK
         NBz3AXusjW54AYN1P0nyGoqqEGo8riV/vzrili/S5Y4p4FkbgNy3Rw7DBISZZYNH2KsF
         iz/UtIBGIH9yHy6rh8kkujDhuivsn+Gmscpuo70C2Ao3RvjHgcCwVqQ6eLWJXYxL0wSW
         e1uROSAA5uPBAQKzJB4zO6iDUyVc7AmscIt3j9kADPXvKbl+l3vtw64wsxUd8ckPOfJy
         ZM3HF8qUs/JCq+HIbGJTYMq/N2zsPmMYBu8bTMjDDEuGHHYt9jaY4Vh11IS6/AS2DG4M
         vbog==
X-Gm-Message-State: AO0yUKVKC/OzyKoQMT5HEidnBTkHRQ+6EjqCzoMRm7+zSJN2jlY9BgRE
        Gj+hEG4Hs6qrtVnT5KX0C6m0jaIaQdU=
X-Google-Smtp-Source: AK7set+enNvn/OSrnjK+V+wzQGA0dIvRczca4mbEf17YhiYCuzKYvMnj8UR5WSyGieFxolZBba9jWg==
X-Received: by 2002:a05:6e02:1d8e:b0:313:d7fc:4c09 with SMTP id h14-20020a056e021d8e00b00313d7fc4c09mr4265304ila.18.1676998662692;
        Tue, 21 Feb 2023 08:57:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e23-20020a02a797000000b003a484df1652sm285792jaj.55.2023.02.21.08.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 08:57:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <83eee1e3-a585-d92e-c27c-e8d89dd67e58@roeck-us.net>
Date:   Tue, 21 Feb 2023 08:57:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [GIT PULL] hwmon updates for v6.2
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230221164510.1589058-1-linux@roeck-us.net>
Content-Language: en-US
In-Reply-To: <20230221164510.1589058-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 08:45, Guenter Roeck wrote:
> Hi Linus,
> 
> Please pull hwmon updates for Linux v6.2 from signed tag:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.2

Oops. I am apparently living a release in the past. Sorry for the noise.
I sent another pull request with the correct version and tag.

Guenter

