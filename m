Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F1074C960
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 02:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGJA7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 20:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGJA7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 20:59:15 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B01B1;
        Sun,  9 Jul 2023 17:59:13 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9D3B3413E6;
        Mon, 10 Jul 2023 00:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688950751;
        bh=mK6n+/4iZKOHIOsh2YzYIgnziHiQD/4k5lJoDd1mIi4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=OeWpWGIbl1VDL+PJbpJl37PbeQHB0c0oA+zeO4SM0TVYw1K2tsJeIlyulEq/Avp/6
         +hwzRtxdKinLXCbyh6yj2mf7q1nKWjfL0WJdaCnjrCveR5w/t53yZU21YTR1PGDoAm
         2axXa8xdo4yPFX4OGuUFuTDJSTXPdKdeI20xXr1oA2hqsiKVRHFSqwE/kwn6O/sNIX
         2Ii1O0WEPGdqUBOkJWNewP47D6FuxITe4ap5L8P5KsHX+WbRYwNq4z97IwbkpVge35
         zma8K9nEQT2ZPrOAc8MUBb3O6GCbmzz+DE9W0SStAz6lZNGZ5q/ZTA+W97rpMUJz0T
         wGYJFWAVvzEFw==
Message-ID: <e6de7335-67d6-f7c7-21d5-09956045b7a1@canonical.com>
Date:   Sun, 9 Jul 2023 17:59:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: linux-next: duplicate patches in the apparmor tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230710082223.7585feb8@canb.auug.org.au>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230710082223.7585feb8@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/23 15:22, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>    0bb84cff96af ("apparmor: fix missing error check for rhashtable_insert_fast")
>    1079ff8963ca ("AppArmor: Fix some kernel-doc comments")
>    97a79eea1797 ("apparmor: Fix kernel-doc header for verify_dfa_accept_index")
>    b45be9bd7cf9 ("apparmor: fix policy_compat permission remap with extended permissions")
>    c96a8a8c021b ("apparmor: aa_buffer: Convert 1-element array to flexible array")
>    cb60752f0c37 ("apparmor: fix use of strcpy in policy_unpack_test")
>    e31dd6e412f7 ("apparmor: fix: kzalloc perms tables for shared dfas")
>    fd18ddebace4 ("apparmor: Return directly after a failed kzalloc() in two functions")
>    ff9b84eade6d ("apparmor: add missing failure check in compute_xmatch_perms")
> 

my bad, it should be fixed now

