Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39E76C23F9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCTVit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjCTVi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:38:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692803B679
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:37:42 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso137434wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1679348225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+JBGNE71KIeNyxioxmJue3iSV7XIAmXSn9GD38nB+U=;
        b=tKAMh9F8K5dc0nBmwa8/75WOpXNaVg6XjW9Vk6qOI/XkFYxkBT1kWB1u9MVvfZCQA8
         f7ubGwmEekE/gjSVzv15oaojzMV2WmYTwuUQl0cRyg+MSyLgBhu4aZ7fCmkcetkVYKv/
         +ciFs/C9MkMCbr07EzLv/cvMeVy1JJta0EvDkt9NOihXcyxkMebNS5pqWoJ1prtCZUcp
         EyJaxZo00R1xfFoARV45b+tPcNN+ypketgxHRRscG5DDCXbBWhxh0676k1hz9MWcpomW
         pvYeGD2IWY3UaKM/JhhO0/+Eyfl91eh1PWTAruCnFPWibt1NPlCxPTShqHglE0mzHR9p
         +sXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679348225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+JBGNE71KIeNyxioxmJue3iSV7XIAmXSn9GD38nB+U=;
        b=aGqQl7G//U99DNLUfhFHxKA6iRE20pY1N3BkGDcMf683JWXDlZsgmh06WL74PwxiBr
         pWFa9mu2c6lIrMMmPCPQ65HsWR9B3ovYC29A7DYwvnLHGLXKhqj3vrVdCdkp2++VofXh
         944xMdviKWUnS7Y8vOM2/PVA9kuR1aVT1BldYiSB1ZFmXMRy6b3984ph/yLb93i6vhik
         1Uaiburyz3cNYvF+UOgTPXSZ9ieuFZGJjMUKW8Zaw/ltozUX/FvPzpFVcAbGmFN+E0Fm
         3KEMq2DBMttOV001o/rIg+m5EDK7XxGMpJw4nj3LECwXZH+FDKrjgt7OFL7PMpcY416j
         beDA==
X-Gm-Message-State: AO0yUKV1SZK/sNXWWaYd7tH6Rtjc5kuV9E/RmXRsgIpGonTg/ncnGBBh
        EQDh6NngdjeUbuER8z0AitXde9eRNYGhtOTBo68=
X-Google-Smtp-Source: AK7set+bRFlMGZkBgA0KDMiP6kPbOuZ7rPadME0mRoSdo6j/MS5HxwEp1K6zJjAJqy6AHtNEjHdztg==
X-Received: by 2002:a05:600c:254:b0:3ed:253c:621b with SMTP id 20-20020a05600c025400b003ed253c621bmr713231wmj.21.1679348225369;
        Mon, 20 Mar 2023 14:37:05 -0700 (PDT)
Received: from ?IPV6:2003:f6:af11:1000:ea7:9b12:7b30:c669? (p200300f6af1110000ea79b127b30c669.dip0.t-ipconnect.de. [2003:f6:af11:1000:ea7:9b12:7b30:c669])
        by smtp.gmail.com with ESMTPSA id s12-20020a05600c45cc00b003ee0eb4b45csm2487142wmo.24.2023.03.20.14.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 14:37:05 -0700 (PDT)
Message-ID: <b97698b9-1b90-5282-213c-0efe38cd7081@grsecurity.net>
Date:   Mon, 20 Mar 2023 22:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] KVM: Shrink struct kvm_mmu_memory_cache
Content-Language: en-US, de-DE
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230217193336.15278-1-minipli@grsecurity.net>
 <20230217193336.15278-3-minipli@grsecurity.net> <ZBTtjTFPCRtK0Cy8@google.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <ZBTtjTFPCRtK0Cy8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.23 23:45, Sean Christopherson wrote:
> On Fri, Feb 17, 2023, Mathias Krause wrote:
>> Move the 'capacity' member around to make use of the padding hole on 64
> 
> Nit, 'nobjs' is the field that gets moved in this version.  No need for another
> version, I can fix up when applying.

Ahh, forgot to update the changelog after switching the layout. But as
it was 'nobjs' next to 'capacity' for both variants, I wrongly thought
there's no need to. But sure, you're right.

> 
> If no one objects, I'll plan on taking this through kvm-x86/generic.

Thanks,
Mathias
