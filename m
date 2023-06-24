Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DBF73C5BC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 03:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjFXBKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 21:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjFXBKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 21:10:15 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CACA26BC;
        Fri, 23 Jun 2023 18:10:14 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666e6541c98so1065993b3a.2;
        Fri, 23 Jun 2023 18:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687569013; x=1690161013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzyMiHrVAPBmQmrLCrjFYbL8kgy1uuE1C1QD2djiUo4=;
        b=mAhDEYwVkMSgkhJilQDlttOId2SRvWirNMLipjApHZ9EXmYnibY5nbkgA/qs9fafJX
         JPvKNwU1V51BKGHKoJnYD65/qOEcC0AxS0rEk83CKgviDC0pnOP1Q2PbYxpbD2tBu9g5
         Jj39S3twz7mCjaq5kJpt1H4bDMYSN9sM5uibmm5FZwyoBAVRZfhNY/gf8pSpCy5Ew2Ih
         SqULySkscf+/wJLPZpk1I1N63avh5lpR4ZQDBBi/7Pwkmg6mTogwDGeVnaTLi01pRXC0
         9xPtzPEtgu3LiX0pCrSt9oX+mbjkpEgGlv7lW5YtWMhsZI81fQwp5BljSAAMaPLtDOkg
         uNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687569013; x=1690161013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzyMiHrVAPBmQmrLCrjFYbL8kgy1uuE1C1QD2djiUo4=;
        b=R9QCfFXqTBCxjTJiyS8i/fj/CQt1Ud6NeTtQELGk3VYhqkVLTSOnnUgb4AzR4XqyRH
         9+C/pK36lkZC/+mJhpLofs9R3fmrticfIEXr4n23mKDPmg8mU9HOuld6Wr2RP20093Is
         zudlS4KraLy6o/cpfUbbXZx5LVpvMWRVQfbNUOSR/la3uCLHkQRMr7GJ2iFWwqHH1QGi
         6fwnMMo1udiWMyfncpappUS2ZRmapH4yoaUIRej0nnj5YVC/Ru5HN6wk2S1EjhZYYo+s
         M424fvIMGr9G04qjEuVoHlkFOJtFfoHTI/u345mt9wlHdMgoj0xiJUMjfLhNluXeidKL
         /kng==
X-Gm-Message-State: AC+VfDx89b0jNvIdu+iZB6GonC6wGyMPa1mQrgBtECmnXLG+5ZcCq0th
        bDOx8XEKDQaTtjJrgMfYRME=
X-Google-Smtp-Source: ACHHUZ6+SYzuSpOORIgwR1SDIJQkdoJoD5dBI7AUowA6ZQpr97qTzPxadexn1DrIHwtU/oNF0w1Pog==
X-Received: by 2002:a05:6a20:8f29:b0:122:c6c4:36b1 with SMTP id b41-20020a056a208f2900b00122c6c436b1mr12902482pzk.4.1687569013535;
        Fri, 23 Jun 2023 18:10:13 -0700 (PDT)
Received: from [192.168.1.180] ([50.46.170.246])
        by smtp.gmail.com with ESMTPSA id m7-20020aa78a07000000b0063f1a1e3003sm111723pfa.166.2023.06.23.18.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 18:10:13 -0700 (PDT)
Message-ID: <403108b1-5600-bb5e-a0ad-6f802b4b296f@gmail.com>
Date:   Fri, 23 Jun 2023 18:10:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v11 00/11] LSM: Three basic syscalls
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
References: <20230616165055.4705-1-casey.ref@schaufler-ca.com>
 <20230616165055.4705-1-casey@schaufler-ca.com>
Content-Language: en-US
From:   Jay Freyensee <why2jjj.linux@gmail.com>
In-Reply-To: <20230616165055.4705-1-casey@schaufler-ca.com>
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


On 6/16/23 9:50 AM, Casey Schaufler wrote:
> Add three system calls for the Linux Security Module ABI.
>
> lsm_get_self_attr() provides the security module specific attributes
> that have previously been visible in the /proc/self/attr directory.
> For each security module that uses the specified attribute on the
> current process the system call will return an LSM identifier and
> the value of the attribute. The LSM and attribute identifier values
> are defined in include/uapi/linux/lsm.h
>
> LSM identifiers are simple integers and reflect the order in which
> the LSM was added to the mainline kernel. This is a convention, not
> a promise of the API. LSM identifiers below the value of 100 are
> reserved for unspecified future uses. That could include information
> about the security infrastructure itself, or about how multiple LSMs
> might interact with each other.
>
> A new LSM hook security_getselfattr() is introduced to get the
> required information from the security modules. This is similar
> to the existing security_getprocattr() hook, but specifies the
> format in which string data is returned and requires the module
> to put the information into a userspace destination.
>
> lsm_set_self_attr() changes the specified LSM attribute. Only one
> attribute can be changed at a time, and then only if the specified
> security module allows the change.
>
> A new LSM hook security_setselfattr() is introduced to set the
> required information in the security modules. This is similar
> to the existing security_setprocattr() hook, but specifies the
> format in which string data is presented and requires the module
> to get the information from a userspace destination.
>
> lsm_list_modules() provides the LSM identifiers, in order, of the
> security modules that are active on the system. This has been
> available in the securityfs file /sys/kernel/security/lsm.
Active or available?

If I use landlock's documentation example:

Jun 07 10:37:11 fedora kernel: LSM: initializing 
lsm=lockdown,capability,yama,integrity,selinux,bpf>
Jun 07 10:37:11 fedora kernel: landlock: Up and running.

My interpretation of the two log lines is the first line tells me 
landlock is available on the distro (fedora this case), but the second 
line tells me landlock is now active. Thus the lsm available list may be 
different than the lsm active list.


So is lsm_list_modules() going to tell me just what lsm's are available 
in a distro for use, or is it going to tell me what lsm's are available 
_and_ active?

Thanks,

Jay

