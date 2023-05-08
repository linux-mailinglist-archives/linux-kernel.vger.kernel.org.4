Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B196FB5D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjEHRVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjEHRVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:21:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1ADE76
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 10:21:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so5490729e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566478; x=1686158478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGF9Bdb9JOj4ZKrCw770yZ6qanDIda3Of6R8VUahyS0=;
        b=VsL5h7zKMPs8Q7T4GaqwhDe0M3SaDXdFdUp6gR7o664fIAPEUCyV4Pb43Dop55RNHW
         glHp7weXenZXMh3BaH58FJFUqVqai1vYkHY8etK5czOgBN1DF7ZdeHFjbrtXxnSBPc34
         ZhIfEhIMdAp4NiLuRxnfsUbijWeh/sCfaAmSs5ACwdAK9gHubvuib0vBx1Z2bxy+nLdW
         kLclBgUmwJTKHrjSttIkZKLk9pk7DwByR12vZYsWO+cCX/rVi4setysscov+Xh9WNiwN
         PyawKVKMWGZvrZgFhWLo5SYYSrRwrGuf6LfBrmtZVSPWjZqW5+elTXznLSDBfT49uaoe
         lpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566478; x=1686158478;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGF9Bdb9JOj4ZKrCw770yZ6qanDIda3Of6R8VUahyS0=;
        b=B1I7ytQWBxpjUJXxbBH49suscG9G1rlPjfo6/A64y3Bkv+hfz66jlrMVJ5ZpvELSDx
         V5CufNKed2wb3i8U017UGCn1DdVlrsDeQZiqQ8cnouQC+8Onx5re0PbjyAdxySSIMEtI
         hze4HNkm2DgDthZAfXiWYb2OEm1nzifpK/7X0ybEgT+uWIwfX4YvcZeDmPdH7/nBDfE+
         /sDz7qkcS/iKrDrK4Sfm70G09Wwcg9127x4e8KDImK4yb4IcVMotUkKcSHhOG/+jMbqy
         E7F36gunDjDgn1rKTJ3Q6Yc56asd0+xKtlEE04ymXxUEehegCeAihFeEjttTUf1ohgnr
         kNaA==
X-Gm-Message-State: AC+VfDxL2zREAcKo/TN5yauIcGL7Uwkfw0GsqZxHISWVBIn9cCIegaGn
        y71J10elWVhPQW+OWGNvyKU/lXuIWWA=
X-Google-Smtp-Source: ACHHUZ4dVI80FNEX6T5ejMuHXHeThUuqEEjmxZ8iOPMrmvM3U8wzY3U13oIxVMuR6XBI1z9RVavMfA==
X-Received: by 2002:ac2:44a6:0:b0:4ea:e0e7:d12d with SMTP id c6-20020ac244a6000000b004eae0e7d12dmr2617051lfm.1.1683566477979;
        Mon, 08 May 2023 10:21:17 -0700 (PDT)
Received: from [192.168.1.12] (81-197-197-13.elisa-laajakaista.fi. [81.197.197.13])
        by smtp.gmail.com with ESMTPSA id q5-20020ac25fc5000000b004f1477cf8a7sm50172lfg.115.2023.05.08.10.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 10:21:17 -0700 (PDT)
Message-ID: <ccc1a37b-f0f4-82da-22e8-d7b2a88afb0c@gmail.com>
Date:   Mon, 8 May 2023 20:21:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/4] MDWE without inheritance
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Florent Revest <revest@chromium.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, izbyshev@ispras.ru,
        nd@arm.com, broonie@kernel.org, szabolcs.nagy@arm.com,
        lennart@poettering.net
References: <20230504170942.822147-1-revest@chromium.org>
 <ZFQQSKijXQHWlYaI@x1n>
 <CABRcYmJFcUs=3QYXz8iq7qvu2orJ4HL-cHdBKg9o7=Ma=nfPLw@mail.gmail.com>
 <ZFhQcwDBFWcRCC4N@x1n>
 <CABRcYm+RquNGYUyfCEmLrcaoMSKagzwXgto-24ZCaLAdFUKUjg@mail.gmail.com>
 <ZFkCugTkQmZh3sJo@arm.com>
Content-Language: en-US
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <ZFkCugTkQmZh3sJo@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.5.2023 17.10, Catalin Marinas wrote:
> I think we should keep the original behaviour of systemd here, otherwise
> they won't transition to the new interface and keep using the SECCOMP
> BPF approach (which, in addition, prevents glibc from setting PROT_BTI
> on an already executable mapping).

Systemd has transitioned to prctl(PR_SET_MDWE) method since release of 
v253, so the original behaviour definitely should be kept.

> To me MDWE is not about preventing JITs but rather ensuring buggy
> programs don't end up with WX mappings. We ended up this way because of
> the SECCOMP BPF limitations (just guessing, I haven't been involved in
> its design). With a no-inherit MDWE, one can introduce an additional
> policy for systemd. It would be a sysadmin decision which one to enable
> and maybe current (inherit) MDWE will disappear in time.

There could be a new setting for this, like 
MemoryDenyWriteExecute=no-inherit. I'd only use it for those special 
cases where MemoryDenyWriteExecute=yes can't be used.

> x86 has protection keys and arm64 will soon have permission overlays
> that allow user-space to toggle between RX and RW (Joey is looking at
> the arm64 support). I'm not sure how we'll end up implemented this on
> arm64 (and haven't looked at x86) but I have a suspicion MDWE will get
> in the way as the base page table permission will probably need
> PROT_WRITE|PROT_EXEC.

Wouldn't those features defeat any gains from MDWE? The features 
probably should be forbidden with MemoryDenyWriteExecute=yes.

-Topi

