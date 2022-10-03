Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0765F381D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJCVud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJCVu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:50:29 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9250A2649F;
        Mon,  3 Oct 2022 14:50:26 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.126.114.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9164F3F13C;
        Mon,  3 Oct 2022 21:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664833824;
        bh=d6tCjDffPeli2JJdw1WBF6N1QkxsauynHCZBmzSHuuk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=p8at9MG17qhjNAsuAWKGnZwSBhTABQGPFV99tfTpaO3jaI/2mUZD0U5Oym+Gch7Uc
         CoPw7+Sdo6FCVppK8EYtOrLi7XcB2Gh/1iS5arTs9BAqcSSpOU6CGAUrLZt9ONNLKV
         gRGYdc0ptrOTUjB34wsy90qsky3ivIGssuf+GT8nvo2Su+0ftG/oBbUdAb/2p/Z2Xi
         8de2ZF+aPqevWzmhJS+VfcBNx6bfKJJ8Nirak5kyGaHpsggGusDv9WRWgv5UtETxGS
         /xbZrOiprRPGCkRZLrXor2azUGOZUssIWEiUG5+My5g3gr+VN+4bZqbfM2EHDSsVb4
         0jq+Dndvlyjhg==
Message-ID: <c427736e-8ac1-777f-d414-c6eecade78fe@canonical.com>
Date:   Mon, 3 Oct 2022 14:50:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-next: Signed-off-by missing for commit in the apparmor tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221004072740.5fb5f841@canb.auug.org.au>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20221004072740.5fb5f841@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/22 13:27, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>    4c212501f8c9 ("apparmor: fix a memleak in multi_transaction_new()")
> 
> is missing a Signed-off-by from its committer.
> 
arrggghh,

how did I miss that

thanks Stephan

