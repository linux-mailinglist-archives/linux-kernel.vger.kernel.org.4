Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C58573D272
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjFYQeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjFYQeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:34:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2B6171D
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:33:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98e109525d6so183166366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687710815; x=1690302815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nScTdQvpM7AM9qvgSXkt+CMEW4pA3CqvS9Ovt74lcv0=;
        b=Daa03xmBUcJzI1P5Cjq//x2PTnD1CAQ4voGLYhDh52BWZqqMIL6FtdVtSsiO6ACKLC
         A5KpeXdRy8qEjAyxUJG6fHd65duBtOUX/lqt8QghFK1wVKER47XJJ16lb8FACMCSZrik
         ffNrS82tDrwc6gnHDFHstBTKM7sfx1YgRM5WeIEw24CD/TBS2ZocEac8qBUrCS9oLbEj
         QgOaTWVj5Q1jeKSKZN0APZVzSxCGMpxhKoMus11XZiTpMzg73gugrhDQTq9yxW4dJfTT
         LNz/9oqZqIz185AHSa2HdoSnK8nn6QKa/G4PLL3C/nRh4JzCNG3JAqVq13tpLJRYQ0ui
         k+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687710815; x=1690302815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nScTdQvpM7AM9qvgSXkt+CMEW4pA3CqvS9Ovt74lcv0=;
        b=j4gs+Y1Ja6BIyrwz3AmlXAoABPJn6yTpNqm7YhsHeDN2HohtIvbBs6W9FmLonPtCkT
         pXJA4mucDWyo5rsg2dleREMhuwRTmywDt9DaDkvS28qLlqEJHDW1onc6dU8MKGpvwBjd
         6HJEODW8OwR6rc24ckkUlmKw5pzapUBqMNd6b9JxXDMp3M3H1jbQK4RVCt+uDSa3BqoD
         6C2OSTZ5z8KQ4N2ms+wAf5udwQ1UjQg4oGeYOSjfFfS3lpwJtwLN44nTDtZcd+GcaOiY
         3gm1tx99bw31SQic7T1jWrwPbWeP5SJWhRSAJeZ1EPafoIavd3ugWabcm5VjZq3Lxhrx
         mipQ==
X-Gm-Message-State: AC+VfDyVaiMus0p0w4tKYDJ7ExKxE2DXInVR65tOAKly0LVgeORcqqnR
        8y7yZI93ZlI6HO/qguLHzJo=
X-Google-Smtp-Source: ACHHUZ6PsmNGxfQW9UahY8fUKpsiMFcjiehPqgjf+rQ9sLH2KLLOdDS0OjaAjry4/vghNsU8IxbYsw==
X-Received: by 2002:a17:907:3f87:b0:977:d660:c5aa with SMTP id hr7-20020a1709073f8700b00977d660c5aamr24821855ejc.31.1687710815044;
        Sun, 25 Jun 2023 09:33:35 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id gg18-20020a170906e29200b0098d2d219649sm2264553ejb.174.2023.06.25.09.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 09:33:34 -0700 (PDT)
Message-ID: <81c94a1e-b316-c195-402c-01776f3200dc@gmail.com>
Date:   Sun, 25 Jun 2023 18:33:33 +0200
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
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <ZJhlGCP0gTz7T3gG@itl-email>
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

On 6/25/23 18:02, Demi Marie Obenour wrote:
> On Sun, Jun 25, 2023 at 03:25:38PM +0200, Milan Broz wrote:
>> On 6/25/23 01:09, Demi Marie Obenour wrote:
>>> Userspace can use this to avoid spamming udev with events that udev
>>> should ignore.
>>
>> Well, does it also mean that udev will not create /dev/disk/by-* symlinks
>> (as response to the change udev event followed by internal udev blkid scan)?
> 
> In the use-case I have for this feature (block devices for Qubes VMs)
> the blkid scan is unwanted and there are udev rules to prevent this.
> 
>> If it is a private device, that is ok. But for a visible device I think
>> that it breaks some assumptions in userspace (presence of symlinks mentioned
>> above etc).
> 
> The devices I am considering are implementation details of a userspace
> process.  Nobody else should be opening them.  Ideally, no other
> userspace process would even know they exist, at least without mucking
> around in /proc or using ptrace.
> 
>> So, what is the exact use for this patch?
> 
> Ephemeral devices that are created, opened, marked for deferred removal,
> assigned to a Xen VM (needs another patch currently being worked on),
> and then closed.  udev has no business scanning these devices, and
> indeed for it to scan them at all would be a security vulnerability
> since their contents are under guest control.  There are udev rules to
> ignore these devices, but for udev to even process the event wastes CPU
> time and delays processing of other events that actually matter.  The
> only symlink that possibly ought to be created is /dev/disk/by-diskseq
> and I can just do that myself.
But this is not clear from the patch header. I guess you also need
to disable udev inotify on close on write, which will trigger device scan too.

BTW we use exactly this scenario in cryptsetup for years with existing flags
(DM_UDEV_DISABLE_SUBSYSTEM_RULES_FLAG | DM_UDEV_DISABLE_DISK_RULES_FLAG
DM_UDEV_DISABLE_OTHER_RULES_FLAG) - just rules are ignored while uevent is still
sent.
Anyway, not sure we need another way to disable it; I just asked do you need it.

Milan
