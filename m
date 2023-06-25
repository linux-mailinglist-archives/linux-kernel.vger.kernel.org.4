Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACED73CE4F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 05:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjFYDuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 23:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjFYDuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 23:50:01 -0400
Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5C218E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 20:49:59 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 1EA2F440049;
        Sun, 25 Jun 2023 06:49:50 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1687664990;
        bh=9n0Q8B2bEkqPmvBoKm8p6RZbm9Lb0VPlfmrfd1XcakY=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=eTanaV6sAwFznE5Tlp+umS8US1TZyqDRhGmPmTRzlF9FSuyjiUWo/9uJHWjWiJcMT
         NceXjpQs89+fpxxFk6IMQJt5GTW3Y1PAbA4DvJLLGZBZHaCBf7IiDo/VnwdsrV6oUh
         eJxrpqbdiyierqq2fch3VL0iEpL3e9x0VD3jekllDD+SwEndW3Qdn+LOqZfh9WycTW
         Cd2ySrpWRJ9hqCZVvrD0JxHJI6KymQnMn5kQ2J2Mov4iog+rVdHeAZWeaQdFXBtdCa
         re8qmZ57iXmpFwA599gDREhBQOUWMCihUm6k16NtI40+3ULdFQudRljwoNLdkyX77k
         Olv3D3vii/o6A==
References: <455b22b986de4d3bc6d9bfd522378e442943de5f.1687499411.git.baruch@tkos.co.il>
 <202306230934.C235D5751@keescook>
User-agent: mu4e 1.9.21; emacs 28.2
From:   Baruch Siach <baruch@tkos.co.il>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] elf: correct note name comment
Date:   Sun, 25 Jun 2023 06:44:09 +0300
In-reply-to: <202306230934.C235D5751@keescook>
Message-ID: <875y7c5hgd.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Fri, Jun 23 2023, Kees Cook wrote:
> On Fri, Jun 23, 2023 at 08:50:11AM +0300, Baruch Siach wrote:
>> NT_PRFPREG note is named "CORE". Correct the comment accordingly.
>> 
>> Fixes: 00e19ceec80b ("ELF: Add ELF program property parsing support")
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>> 
>> v2: Swap "CORE" and "LINUX" as noted by Kees
>> ---
>>  include/uapi/linux/elf.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git include/uapi/linux/elf.h include/uapi/linux/elf.h
>> index ac3da855fb19..4d1c8d46e7f0 100644
>> --- include/uapi/linux/elf.h
>> +++ include/uapi/linux/elf.h
>
> Hi, I took this patch, but it seems something is misconfigured on your
> end for patch generation -- normally I'd expect to need "-p1", not "-p0"
> to apply patches. Are you using "git format-patch" to produce these
> patches?

I recently enabled diff.noprefix for easier copying of file names from
git-diff output. I have now noticed the git-format-patch is also
affected, and that it breaks the default git-am -p1. So I have reverted
diff.noprefix to its default.

Sorry for the inconvenience, and thanks for letting me know.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
