Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F356F73D2AA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 19:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjFYRNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 13:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFYRNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 13:13:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF31197
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 10:13:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98df6bc0048so158059066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687713197; x=1690305197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6DtUGF5Qpp5liEBW4Fkja7ol+KO9225qbllTSnW6B/Y=;
        b=DxScvo/F5NopWxQwqzDJ+mLPN3REjdDbdAtNZ7ZdG8fZXNUX5DDiAecEZzr+P0fImh
         qR2UyQ8J/0DUe+d20DtecOt25bLMRnjTuj/cEs5CZkazzdUoaMc9VVv+Z2dSAh5TbqQ9
         9D9yiJPLr/1reab4fk3C/n3PCyk9HzwmgM1RKOzasD6PjBUXQO0adoACYbNdJaBv0QQy
         V5viM7S0Vkal0fi0dwslCezBSl1TWOKUjjOydDpuy8YkSt5nbfiMCgBWnfG7h8eXgZbh
         fqkorkMf2eVpECpIPMVGHvPmchH34iOgELRcXREAqj35X2PkcIXMxprhTjrSH/p5zWQZ
         E4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687713197; x=1690305197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DtUGF5Qpp5liEBW4Fkja7ol+KO9225qbllTSnW6B/Y=;
        b=azzKd14Kzv/tKY/iM3rZ86NgSRR4CSCz9JSkkCLr/NHIEruw1wlAKz6SKQieiF+pP6
         ef9jmnwQJRh2fYh7wJ0om6iVBnPo0P2lN+RLYyH2bf6iDJj/2wSwkANFYVwBXfriFjQE
         hHDV2ZjISpGR0KG5TzJn2Mm/9vmy0Tlmc95zf/p0upG2LVJmRRQxwhrO36cBHeVHd/hK
         vnsHgKJMCsjc+LBgtARJYBKrL/uvHaKQvOTrcos5S1iGyYOq3x7RRxlzcd5s+WrmhCRK
         wyEHdXGFzTQVKLykUGTKjm9r0lohWPbfaDCDasp7nPBAuMmhw221A2bRmaxoaFU5zMUM
         w5GA==
X-Gm-Message-State: AC+VfDx1pwyGP/JLk2/gN1zaikbmC3GFzPCMzek7UCwwgcq/jP1YXXQC
        B9F/VegYnqGEe/P5HaF7Ub0=
X-Google-Smtp-Source: ACHHUZ7MqiTR1ZIv4/lR3yo9zuXR8WjrHRh2UkkFL6VVLnMuyAw2c8g5nFjyq3Ytz8IdrobUnf643w==
X-Received: by 2002:a17:906:fe4e:b0:96f:c46f:d8fe with SMTP id wz14-20020a170906fe4e00b0096fc46fd8femr22094622ejb.27.1687713197211;
        Sun, 25 Jun 2023 10:13:17 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id ci8-20020a170906c34800b009888aa1da11sm2238306ejb.188.2023.06.25.10.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 10:13:16 -0700 (PDT)
Message-ID: <364d626b-c3cf-8492-6c85-38417f2432b4@gmail.com>
Date:   Sun, 25 Jun 2023 19:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [dm-devel] [PATCH v2 3/4] dm ioctl: Allow userspace to suppress
 uevent generation
Content-Language: en-US
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20230624230950.2272-1-demi@invisiblethingslab.com>
 <20230624230950.2272-4-demi@invisiblethingslab.com>
 <0b22e328-40e1-54d7-367c-96059a3fef7c@gmail.com> <ZJhlGCP0gTz7T3gG@itl-email>
 <81c94a1e-b316-c195-402c-01776f3200dc@gmail.com> <ZJhuw3MaFjW5Bocw@itl-email>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <ZJhuw3MaFjW5Bocw@itl-email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/23 18:43, Demi Marie Obenour wrote:
> On Sun, Jun 25, 2023 at 06:33:33PM +0200, Milan Broz wrote:

...

>> BTW we use exactly this scenario in cryptsetup for years with existing flags
>> (DM_UDEV_DISABLE_SUBSYSTEM_RULES_FLAG | DM_UDEV_DISABLE_DISK_RULES_FLAG
>> DM_UDEV_DISABLE_OTHER_RULES_FLAG) - just rules are ignored while uevent is still
>> sent.
>> Anyway, not sure we need another way to disable it; I just asked do you need it.
> 
> How can one set these flags using the raw kernel ioctls?  The code I am
> working on does not use libdevmapper at all and just uses the kernel API
> directly.

IIRC you need to set cookie (kernel DM_COOKIE env), then default udev dm.rules decode
the flags from it.

(It is libdevmapper internal magic for me, the design is kind of complicated, but works.)

Better ask on LVM list (but the udev DM rules are pretty well inline documented).

Milan
