Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD996957AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 05:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjBNEBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 23:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjBNEBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 23:01:38 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A852910AA3;
        Mon, 13 Feb 2023 20:01:36 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id bd6so12044067oib.6;
        Mon, 13 Feb 2023 20:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JDOB47jyfKN5KErSHTMXnOCV8uvdMv6HLEbTTUpfVc=;
        b=PvH4ywpa+2KCQubu0hvx8E4h3Rm8Pe9P2NZ+NhUibOlKrSornMpsZHwL8sjw3kC/a/
         b2U5W9NCyOpyz+5PbesdQkNtJUwbnQYh/JwK/0Q449IdDSj8TV59Jz0OV6m/DXWnQDOn
         Sj63vAzgj2mY0n57joUvI6eg9XC3FqUY2WUIpqA1xDtxzVrgwXe0BLRRV6G0OPLJLLYS
         f8QKHb1sG/umGWuNYg/CRVmSd3QIisgI8RW8ytF/trAxtMIAGSgTW1+yUzUiA34g2Sxz
         pcIdXwU4R+ew58P/3eck4PbSuD/9M6TZVO0ttv7UuFOdgnjJQDcnC4rhmEukChrqsfGT
         /x7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JDOB47jyfKN5KErSHTMXnOCV8uvdMv6HLEbTTUpfVc=;
        b=Q2ttfN3YoLkhGQOmBPfrtxE2k79v++7gQWH4Ew2tMEtM/duSx1KS3z2oytWiXlCmbT
         ze8TgFYN966O00s9lBq2+ba0yPXz68+qxRglEFtjFyxdD9H7/OhZZk/D2y7jHwygyE1W
         qc4e1doBMdhGszvul0MYOMq8wT4c+3oFAwFJSQidhw+fx63uhlLh6GG8JcP4c43qUy+c
         cggWseVfH3Ynkv3lE/Z/ayoRxmWRHXs8lYlciH8cyHZF7Uai6uht7uKZK9WVg6ZeJ/Qr
         Hs3QXhLCVvHz1JLQBdui4lbHcgneiH6CLhK7B/6Q1rQ+VnWgFUm96GRZgywgNVAKWQu8
         MQ4g==
X-Gm-Message-State: AO0yUKXQraubmHukxgniDoIs2Jf+9AyA7cWkRHPhqEw3/HXm41HI996f
        l5E/F1scGUMmwZ1Il5Ev0vfJL1fQNNo=
X-Google-Smtp-Source: AK7set90lp2VkK76+s92grnXK338HpX+PhyFW0Fs6BGnZPjlTYHNCREMMyuYsQucX7m2cxUiWC1aRA==
X-Received: by 2002:a05:6808:18b:b0:378:8a89:95df with SMTP id w11-20020a056808018b00b003788a8995dfmr461073oic.34.1676347295929;
        Mon, 13 Feb 2023 20:01:35 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g18-20020a9d6b12000000b0068d6ed06b73sm5974460otp.18.2023.02.13.20.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 20:01:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <58fb32f8-ce1e-913b-3b85-c41b0630d4c6@roeck-us.net>
Date:   Mon, 13 Feb 2023 20:01:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        linux-mm@kvack.org
References: <ed33b9ff-e6f2-dae8-ede6-59dc3c649ece@roeck-us.net>
 <20230213094754.397f86af6b2dea4aafd92344@linux-foundation.org>
 <a276d6ae-677d-e4cf-13d7-934c0a7639d2@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: nvme boot problems after merge of mm-stable tree into linux-next
In-Reply-To: <a276d6ae-677d-e4cf-13d7-934c0a7639d2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 18:23, Bagas Sanjaya wrote:
> On 2/14/23 00:47, Andrew Morton wrote:
>>> I am having problems booting from nvme in linux-next. Bisect points to 06e5887cdcc11
>>> ("Merge branch 'mm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm").
>>> The problem was first seen on February 8.
>>>
> 
> Hi,
> 
> Can you please directly test mm-stable tree instead and bisect from there?
> 

I'd love to, but as it turns out today's next release (next-20230213)
bisects to a different merge. Still mm, but this time it is the merge
of mm-everything, and both the merge of mm-stable as well as mm/mm-stable
itself are fine. See below for the updated bisect results. mm/mm-everything
itself (mm-hotfixes-stable-2023-02-13-13-50-593-g48de1df158c9) is fine as well.
The merge of mm-nonmm-stable into linux-next (v6.2-rc7-12363-g214c8cfc3507)
is also fine. However, the merge of mm-everything into linux-next) is broken.

Overall, that suggests that there may have been a change somewhere
else in the kernel which is incompatible with a change in one of
the mm branches. It is interesting that the problem in next-20230210
was seen after the merge of mm-stable, and that it is now seen after
the merge of mm-everything.

Guenter

---
# bad: [09e41676e35ab06e4bce8870ea3bf1f191c3cb90] Add linux-next specific files for 20230213
# good: [4ec5183ec48656cec489c49f989c508b68b518e3] Linux 6.2-rc7
git bisect start 'HEAD' 'v6.2-rc7'
# good: [8b065aee8dfbecc978324b204fc897168c9adcd0] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good 8b065aee8dfbecc978324b204fc897168c9adcd0
# good: [72655d7bf4966cc46ac85ef74b26eb74e251ae4a] Merge branch 'rcu/next' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
git bisect good 72655d7bf4966cc46ac85ef74b26eb74e251ae4a
# good: [11b208f696c4111c8bd66863b8306d7857266e4c] Merge branch 'staging-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
git bisect good 11b208f696c4111c8bd66863b8306d7857266e4c
# good: [d69b9b369439219613ca6df66745217f1f56a533] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git
git bisect good d69b9b369439219613ca6df66745217f1f56a533
# good: [37598f5a9d8b63b91cce0cb6bac5f6374ed1bb80] mlock: convert mlock to vma iterator
git bisect good 37598f5a9d8b63b91cce0cb6bac5f6374ed1bb80
# good: [1c2080951a87c3f146c9f9f837ec3c877d4a3c87] Merge branch 'mm-nonmm-unstable' into mm-everything
git bisect good 1c2080951a87c3f146c9f9f837ec3c877d4a3c87
# good: [d1b7f15191d2c203b48eff421f65effce20faa4b] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git
git bisect good d1b7f15191d2c203b48eff421f65effce20faa4b
# good: [7223173e7652230265ba89c5a12eacab1d416797] Merge branch 'bitmap-for-next' of https://github.com/norov/linux.git
git bisect good 7223173e7652230265ba89c5a12eacab1d416797
# good: [70d207cb345c41262a24973e1a40f5015c2c309f] Merge branch 'for-next/kspp' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
git bisect good 70d207cb345c41262a24973e1a40f5015c2c309f
# good: [84798f2849942bb5e8817417adfdfa6241df2835] iommufd: Add three missing structures in ucmd_buffer
git bisect good 84798f2849942bb5e8817417adfdfa6241df2835
# good: [e5773cfccc0b3c35cef89129f45087d43c136a2d] Merge branch 'for-next/kspp' of git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
git bisect good e5773cfccc0b3c35cef89129f45087d43c136a2d
# good: [77ce632bfb804e4d71bd7aa106cc5b10f164cb14] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git
git bisect good 77ce632bfb804e4d71bd7aa106cc5b10f164cb14
# good: [214c8cfc350729dcce2f2e6d228b996ff568626c] Merge branch 'mm-nonmm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good 214c8cfc350729dcce2f2e6d228b996ff568626c
# bad: [a037e6164093ebb92745768a59e1e2ff8c731d57] Merge branch 'mm-everything' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad a037e6164093ebb92745768a59e1e2ff8c731d57
# first bad commit: [a037e6164093ebb92745768a59e1e2ff8c731d57] Merge branch 'mm-everything' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

