Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCFF74DCC7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjGJRwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGJRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:52:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A030AB;
        Mon, 10 Jul 2023 10:52:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D433361178;
        Mon, 10 Jul 2023 17:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B72C433C8;
        Mon, 10 Jul 2023 17:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689011530;
        bh=YKlGppxljjRcSI8ysxSVnU0A/O3Ow0tYV8rhEbSSGJ4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uGimDA5f7tHbu5ZnNKK0X2tAluzDf4gKIGrpXUKKBTM433d+k55de/sRbA4FZbdfZ
         EK0Zb0dncnNL7qRdCdEIal0QdH4iy5BuLfpdqZ14dMVug5wF5pLnCEmqroYzCzAJxJ
         yneEIaDnZiWWj+/fo7QxqzNGO3KGnY++Q2l0zTqTigTkvCFNUOLF38NvRp8g5sAbk9
         1wojaFpn1NSUgvihyaqvdcK/jBtXLuLZes1CnExuGyxaahCm090ZYcso1o2IbsUszD
         f5xObQiHhPJ9fo39WwWp0qKjktXLk3HAZhwWctMMsCqqSd5f+oeKgYJVZ9rDnz5ldw
         1UbXpJIe60EQw==
Message-ID: <ccc0f8d4-3900-a766-7303-85e44bffd875@kernel.org>
Date:   Mon, 10 Jul 2023 10:52:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: linux-next: branches to be removed
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Leo Li <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vineet Gupta <vgupta@kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
References: <20230710172602.05d32c03@canb.auug.org.au>
Content-Language: en-US
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20230710172602.05d32c03@canb.auug.org.au>
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

Hi Stephen,

On 7/10/23 00:26, Stephen Rothwell wrote:
> Hi all,
>
> I will remove the following branches from linux-next tomorrow as they have
> not been updated in over a year.  If you want your branch retained or
> reinstated, please just send me an email letting me know.
>
> Tree			Last commit date
> ----			----------------
> arc			2022-06-05 17:18:54 -0700
>    git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git    for-next

Would request to please keep arc next around even though upstream dev is 
slow'ish these days.
I do have some patches for absolute near future as well.

Thx,
-Vineet
