Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6C72CD7B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbjFLSGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbjFLSGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:06:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C228CE67
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/GozTe9HlFUqNYSETpcizL/YWyf3mlAzaY05FXEg0Vw=; b=Yzta4brR9YZYsmuXOAwnAUiDJZ
        FlE3PB39tfMb0xG7XUNFDwj95/KoQajwhu7XTKIxfKA5k6vnXU/4mngmyZMveLQhEUqNSi9BQSPUV
        dk9rxoaVdgCxkpzjzzFUbW5G9YALz0zOmZeF48rAmA5KO3i4Xql6dsGg45tHkYzTWSz6VoycIkubT
        ndQjpyEKUsj3HBr27KIkDaDZ8qKpqoi3LHWI3wb81mOpbf0MPFbzvCU3nW1Fn/HEpqTlEZoriAni1
        0n0WgX1YhHhSxDMLXhmILKeB6KAzJ0roiJYkv6iQ/I+TyTGQ0huTFIKKi/OmJbBfRnOmHipeTdDaC
        c1ZZiNmw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8lw4-004scv-10;
        Mon, 12 Jun 2023 18:06:36 +0000
Message-ID: <3289c90b-afee-67b9-8143-344afd47f1da@infradead.org>
Date:   Mon, 12 Jun 2023 11:06:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        pawan.kumar.gupta@linux.intel.com, paul@paul-moore.com,
        leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20230203120615.1121272-1-leitao@debian.org> <87352z7xld.ffs@tglx>
 <ZIcVoIAQbRl1GTo5@gmail.com>
 <20230612133230.GJZIcebkHxd8QJs0Dv@fat_crate.local>
 <ZIchqLWousxkCqyB@gmail.com>
 <20230612135301.GKZIcjPY0xvbNsiVNd@fat_crate.local>
 <ZIcoss0r/898/CpH@gmail.com>
 <20230612160807.GNZIdC58KQ8IibZjrt@fat_crate.local>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230612160807.GNZIdC58KQ8IibZjrt@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/23 09:08, Borislav Petkov wrote:
> On Mon, Jun 12, 2023 at 07:16:18AM -0700, Breno Leitao wrote:
>> Sorry, to waht menu specifically?
> 
> CONFIG_SPECULATION_MITIGATIONS
> 
> It even has the proper text in there, warning people.
> 
> menuconfig SPECULATION_MITIGATIONS
>         bool "Mitigations for speculative execution vulnerabilities"
>         default y
>         help
>           Say Y here to enable options which enable mitigations for
>           speculative execution hardware vulnerabilities.
> 
>           If you say N, all mitigations will be disabled. You really
>           should know what you are doing to say so.

I would say:                         doing to say No.

Was there a typo there?

thanks.
-- 
~Randy
