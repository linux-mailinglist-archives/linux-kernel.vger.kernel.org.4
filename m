Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9074E74FCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGLBmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGLBmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA141717
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:42:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66F7361646
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B788C433C7;
        Wed, 12 Jul 2023 01:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689126167;
        bh=HcjfZVS5j2QnPWisyqJiHTOrvnNm8k6hX0Manu9q8/8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B8aJ2GG+y/4t3XEzdp/waPtP6ocY9E6lnlx+ug/lldeFATlh4BTecbXjwUztC3TsF
         0t/o0sz1LQYlj1fuwN7s+qUApGcfv0OUrSSaPwXG0+V9LYGvpU4/4OCWhbV80N7Diu
         SlJlcjxd72USrsutUGUgLJU7XDjkaag1HdohcoO0NFzeW5zbeXwouQTBVNXqUczuEA
         4J1vcFyqHgT9uNnFHrKG+rw4FVTUAUxGXHvzUmFu/wINpnzVhhPEXiIGQ/lAWwCO76
         dT22G2bIVPE13YaOZc+2xINJbiJ3n4pqsYEBHmpNd/3Or9lSl9nVv/G0JORAAQpbPk
         1rRYYWLJMAJ+g==
Message-ID: <a7885677-68ef-59c8-0639-579a688fcdad@kernel.org>
Date:   Wed, 12 Jul 2023 11:42:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] riscv: support the elf-fdpic binfmt loader
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com, brauner@kernel.org
References: <20230711130754.481209-1-gerg@kernel.org>
 <20230711130754.481209-3-gerg@kernel.org> <202307110852.E093C93F@keescook>
From:   Greg Ungerer <gerg@kernel.org>
In-Reply-To: <202307110852.E093C93F@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On 12/7/23 01:53, Kees Cook wrote:
> On Tue, Jul 11, 2023 at 11:07:54PM +1000, Greg Ungerer wrote:
>> Add support for enabling and using the binfmt_elf_fdpic program loader
>> on RISC-V platforms. The most important change is to setup registers
>> during program load to pass the mapping addresses to the new process.
>>
>> One of the interesting features of the elf-fdpic loader is that it
>> also allows appropriately compiled ELF format binaries to be loaded on
>> nommu systems. Appropriate being those compiled with -pie.
>>
>> Signed-off-by: Greg Ungerer <gerg@kernel.org>
> 
> ELF stuff looks fine to me. If the RISC-V folks are happy with the rest,
> this looks good.
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> Please feel free to carry this in the RISC-V tree. If you'd rather it go
> via execve tree, please let me know. :)

Thanks for the feedback, much appreciated!

Regards
Greg


