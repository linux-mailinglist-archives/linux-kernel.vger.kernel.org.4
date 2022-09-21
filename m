Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D465BFAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiIUJTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiIUJTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:19:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEA08E46D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:18:24 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w28so7694407edi.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=g9hIzzknQ13g39V8zpuvSuUDV45dCJUmErfkHCUCb8c=;
        b=NYwy1GLqAsBJD7t33Akjui0Lw79QpqGY9V+l6RjjMPtpTrZIwVW4J6FsuZE1LR+0Cm
         V/L4MrzwTLRWYQHh03VZOL40WVAGx+gzyqOiZjNjUlNPXTBjSUoeqd+gKcv6UQqPFH0U
         MEgcuRJUKE+bpTD9v4bchtMJ2aeD4Db35Lo7cFro9DbaVLz9rNlEbuyuqCgJmAXrvOQy
         chSq+cYuDwRVxlmguvhBFI51ZvSVMokkZD/xX7pGlV/SWYj+/nsv12Grztrraj0LemLX
         BC7u0mGI0Jdo0RzaEeHGoxKIgSXDEH3dYe33H1S4lhrYx/HH+0KmXLZVGJ6lAeVN5J2k
         sPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=g9hIzzknQ13g39V8zpuvSuUDV45dCJUmErfkHCUCb8c=;
        b=3wsk7li3ooUwZ0dxRk6bjV9n4zrpLZZ1BINzewfk+cBb5B7Nj7h9vVXHmceWryylNs
         0x8jGpRBCu8n1bYvS+tGIJu3oC1wU+vQ++QPAjhLpwkeK23BBLEPTp5TEntDYBsqH0R+
         17Jri/IlokhdbwdB0EoxgwOGjDGn4BEwtZNvLzMoWv5ZmV2+BuTeSoq+ageoI08HWQnu
         w2OxCZ6WHu4MWMxvtulCZccf+4B08v+LdfwSb6sj+yrdgYA0NzOb6N81EuqavLX7VxUg
         b9xabH5EMiNGX7+Fk4EXq38KetgVmdxo7q9FeIgZIaDMrc3z/mIJHhAGa4fvglW4gv00
         rUqA==
X-Gm-Message-State: ACrzQf3WEwuCUtRaiDjweocR2mioeVJ3KcRm4TaVEOw3H17Va5Y7s+pA
        kptA05APu1ICcobXWUzrgJci1Q==
X-Google-Smtp-Source: AMsMyM6bPQ7zayJ+9UZNoM2Gek0kEtRZlXiCyyRJsqf5v+folfznpu2y8B5YkymscGMGAOTjv8C3Bg==
X-Received: by 2002:aa7:c415:0:b0:44d:f432:3e84 with SMTP id j21-20020aa7c415000000b0044df4323e84mr24335129edq.56.1663751898858;
        Wed, 21 Sep 2022 02:18:18 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e650:9a94:d180:442c? ([2a02:578:8593:1200:e650:9a94:d180:442c])
        by smtp.gmail.com with ESMTPSA id gs13-20020a170906f18d00b007724b8e6576sm1073164ejb.32.2022.09.21.02.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:18:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------PnZdDX0mbgnHJpzmr15LlbVj"
Message-ID: <2b4722a2-04cd-5e8f-ee09-c01c55aee7a7@tessares.net>
Date:   Wed, 21 Sep 2022 11:18:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Content-Language: en-GB
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Benjamin Poirier <bpoirier@nvidia.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220921110437.5b7dbd82@canb.auug.org.au>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220921110437.5b7dbd82@canb.auug.org.au>
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------PnZdDX0mbgnHJpzmr15LlbVj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Stephen,

On 21/09/2022 03:04, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   tools/testing/selftests/drivers/net/bonding/Makefile
> 
> between commit:
> 
>   bbb774d921e2 ("net: Add tests for bonding and team address list management")
> 
> from the net tree and commit:
> 
>   152e8ec77640 ("selftests/bonding: add a test for bonding lladdr target")
> 
> from the net-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.
Thank you for sharing this fix (and all the others!).

I also had this conflict on my side[1] and I resolved it differently,
more like what is done in the -net tree I think, please see the patch
attached to this email.

I guess I should probably use your version. It is just I saw it after
having resolved the conflict on my side :)
I will check later how the network maintainers will resolve this
conflict and update my tree if needed.

Cheers,
Matt

[1] https://github.com/multipath-tcp/mptcp_net-next/commit/c02e0180887c
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--------------PnZdDX0mbgnHJpzmr15LlbVj
Content-Type: text/x-patch; charset=UTF-8;
 name="c02e0180887cdb8c2bc98fcbb0ad6a6d7c68578c.patch"
Content-Disposition: attachment;
 filename="c02e0180887cdb8c2bc98fcbb0ad6a6d7c68578c.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RyaXZlcnMvbmV0L2JvbmRpbmcv
TWFrZWZpbGUKaW5kZXggMGY5NjU5NDA3OTY5LGQyMDlmN2E5OGI2Yy4uMWVkMDFlOTYwZDUx
Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RyaXZlcnMvbmV0L2JvbmRpbmcvTWFr
ZWZpbGUKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVycy9uZXQvYm9uZGlu
Zy9NYWtlZmlsZQpAQEAgLTEsOSAtMSw3ICsxLDEwIEBAQAogICMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAKICAjIE1ha2VmaWxlIGZvciBuZXQgc2VsZnRlc3RzCiAgCiAt
VEVTVF9QUk9HUyA6PSBib25kLWJyZWFrLWxhY3BkdS10eC5zaAogLVRFU1RfUFJPR1MgKz0g
Ym9uZC1sbGFkZHItdGFyZ2V0LnNoCiArVEVTVF9QUk9HUyA6PSBib25kLWJyZWFrLWxhY3Bk
dS10eC5zaCBcCisrCSAgICAgIGJvbmQtbGxhZGRyLXRhcmdldC5zaCBcCiArCSAgICAgIGRl
dl9hZGRyX2xpc3RzLnNoCiArCiArVEVTVF9GSUxFUyA6PSBsYWdfbGliLnNoCiAgCiAgaW5j
bHVkZSAuLi8uLi8uLi9saWIubWsK

--------------PnZdDX0mbgnHJpzmr15LlbVj--
