Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766926C4D98
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCVO1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjCVO1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:27:00 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FED359429;
        Wed, 22 Mar 2023 07:26:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 3A383604EF;
        Wed, 22 Mar 2023 15:26:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679495215; bh=QntMlCvHSJ7qSQGLQ8fUDyBw+ENjmuXdkBOooLGQVes=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=0q19GV9lX0QR40tfumeFy+6sCXDr7ezNJgdBbsFpPboLun90mRq0Wb0vDcLUaFfLi
         oS+RajGReKrHdGKvQkZgXuv8KFyyccME9j657jnxLsMwsgqo94xD/n1xDYxnUmiAUL
         wkpXvzksE248vuSmRXwa5Jj5DJZMk+lT2fyZUWLnpVqbZxMVsJMACCeIgk4CYbjgNe
         irB1MkgRlho8npcBol4UI4RIX0exdRIjtz1DXLYhtYN5S8b7F/o2yvX5ddG1UwaMOH
         KmfC690iT4mcRW+b7AyfSt08WzBGXe8Fxktp9Q4mifW6Qiz6YZL1GR4Tt5eYsedcJI
         pI8cyfZB7oLKw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FMZzsA_Nuq3x; Wed, 22 Mar 2023 15:26:53 +0100 (CET)
Received: from [193.198.186.200] (PC-MTODOROV.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 29A2A604F0;
        Wed, 22 Mar 2023 15:26:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679495213; bh=QntMlCvHSJ7qSQGLQ8fUDyBw+ENjmuXdkBOooLGQVes=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xB7K0ClyYqzGPwcczXAv0KjkgO3aNHWT66baADIAzBtjYVwa0WU4unx/vh01PFqOQ
         /roZWMNagnIgUcleRwiwPuEZYju5gp+kDBfqph/F5LtbA8p3U06Ps1dwNSEb4qA8YX
         8IX2BNqMdf1q1+Ghbi9VlBcrYBgPnqKz9G4A8a0YU+lFq3KY332ZrYyN2WKbysP5kZ
         dO2sUPj4P5suaQMSCzauGylLHkf59q2oEaKs3DnNKafPcdRe6MoSEGbh2wBrrSw286
         qhQSsRuEsd/RPqOFd6mBxtAwcSEfQIQcckaIDEXh0ARuW0u80SBigJt5F4myeqvFYQ
         fOVAzWtE27gFg==
Message-ID: <2de3724c-9288-9971-52a7-c86039a653d3@alu.unizg.hr>
Date:   Wed, 22 Mar 2023 15:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/1] scripts: merge_config: Fix typo in variable name.
Content-Language: en-US, hr, en-GB, de-DE
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20230322085106.16629-1-mirsad.todorovac@alu.unizg.hr>
 <ZBsAG50+zCe8WFTt@sirena.org.uk>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZBsAG50+zCe8WFTt@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/2023 14:18, Mark Brown wrote:
> On Wed, Mar 22, 2023 at 09:51:07AM +0100, Mirsad Goran Todorovac wrote:
>> ${WARNOVERRIDE} was misspelled as ${WARNOVVERIDE}, which caused a shell
>> syntax error in certain paths of the script execution.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>
> 
> Sorry about that.

You shouldn't be. Errare humanum est.

I had worse blunders in the last couple of months, i.e.
setting chattr +a on log files until /var/log filled up (old logs couldn't
have been rotated).

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
--
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
tel. +385 (0)1 3711 451
mob. +385 91 57 88 355
