Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E6E5FE12D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiJMS15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiJMS1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:27:20 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3470618A3ED
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:22:59 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id hh9so2199304qtb.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=suxgB8zSFnaEv2TbfPDgM7+/gv0M8Wi74P7m4uO83dg=;
        b=LojiYug43L+QSx/dY6UCZF5lMIesCgzeJdBnGH1WiosPo07fZD5iqC6FWYlOIZHmed
         gbUCQHJIJnFcxxJe4dhdY7n9tpWq53jglw+H8hoYEHjdPEzdGUvO0KJmnpjILXzonlyc
         +OQYk8hGHzmaeaOb2ZwiQM/75t7k2kA60iYKTnFVtbXU3w47nL0lE44o9woq2tJXE5/F
         hIsd5YRQCIp9ovvy8xZr2AlIYiUX+n9gDSSVfn/PohQlnrDA/Wn0F83SNBbXkr5W+fz4
         eWCz9zm+8DSsf9WtjHA40HAHDyGqHUMsJ0PpD1OAnnSUbGB6Sgj0RJ0NVJv5GG/I7DrS
         th+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suxgB8zSFnaEv2TbfPDgM7+/gv0M8Wi74P7m4uO83dg=;
        b=RZM1zf/LYvLMZ10O5mSs100N7jynIDknnR6yi6YUUF1ZELmHfG6FRvgF4Uq/iMxFCn
         XtBShzZWSpAr7IS3u042nKPbHrFY4T4+vgC+tHqHzb/y9PbtSoMSsMRL/6HJd8P70aDl
         pisS/G7s/pEO+JqiHanQjs1BcIY5jDb3hHzs776bMAzv0KSyJ8Bzzr/lvZUHf7F3Ci3s
         slP0m5jwz7LwpwAktF1WkfD02tNYlHN/hVOLeeoGCb3juqahjpv8FhsVBpI95wuVduHZ
         +SyTY5/kZVwWEn8gRrjuX124UmEfwfJzCCkR+12Eiz09JCvn0Wnwdd3Tp0C+NKY6QuB6
         qUPg==
X-Gm-Message-State: ACrzQf3B38WvVEyloHy/GzQoFYI/lNvCtA/1RLdypnJFCKqw2aWtbqM6
        p5v/zuEMA+mnrf5AB5Pl3kY=
X-Google-Smtp-Source: AMsMyM7dmdTnL1UrAhrTp37H4Qr/vGhvaYMUHv/C7ZmdZTzFrXZjWS98q6X6B9fZae5o3XgDYqlTuQ==
X-Received: by 2002:a05:620a:318d:b0:6ee:9097:ccc8 with SMTP id bi13-20020a05620a318d00b006ee9097ccc8mr991922qkb.2.1665685274876;
        Thu, 13 Oct 2022 11:21:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i9-20020a05620a404900b006bc192d277csm399057qko.10.2022.10.13.11.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 11:21:13 -0700 (PDT)
Message-ID: <a5380bc2-08f9-1f09-343b-0e1a86693721@gmail.com>
Date:   Thu, 13 Oct 2022 11:20:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] MAINTAINERS: Move from git://github.com to
 https://github.com
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-kernel@vger.kernel.org
References: <20221013153258.28228-1-palmer@rivosinc.com>
 <Y0hEt51q+Fs0ICbB@spud>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Y0hEt51q+Fs0ICbB@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 10:02, Conor Dooley wrote:
> On Thu, Oct 13, 2022 at 08:32:58AM -0700, Palmer Dabbelt wrote:
>> Github deprecated the git:// links about a year ago, but it looks like
>> there's still a handful of them in the MAINTAINERS file.  Conor pointed
>> this out about the RISC-V KVM tree, but I figured it'd be better to just
>> fix them all -- I've got a bunch of insteadOf so I didn't even notice
>> the deprecation, but new contributors probably don't and might get a bit
>> confused.
>>
>> Reported-by: Conor Dooley <conor@kernel.org>
>> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>> @@ -3990,7 +3990,7 @@ M:	Ray Jui <rjui@broadcom.com>
>>   M:	Scott Branden <sbranden@broadcom.com>
>>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>>   S:	Maintained
>> -T:	git git://github.com/broadcom/mach-bcm
>> +T:	git https://github.com/broadcom/mach-bcm
> 
> This link is dead, I can't find a repo with that name on their GitHub
> profile.
> @Florian, should this be updated to the stblinux repo instead?

Yes this should be updated to the stblinux repository, thanks! If you 
want to split on a per-maintainer basis, I can take the Broadcom entries 
separately  through the Broadcom ARM SoC pull request, else:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
