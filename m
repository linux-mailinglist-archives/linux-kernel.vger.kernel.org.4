Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40708606D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJUBs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJUBsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:48:54 -0400
Received: from p3plwbeout22-05.prod.phx3.secureserver.net (p3plsmtp22-05-2.prod.phx3.secureserver.net [68.178.252.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6702822C61D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 18:48:52 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.145])
        by :WBEOUT: with ESMTP
        id lh9Xoo2hFa94Ilh9XoQmt9; Thu, 20 Oct 2022 18:48:52 -0700
X-CMAE-Analysis: v=2.4 cv=VO0YI/DX c=1 sm=1 tr=0 ts=6351fa84
 a=7e6w4QD8YWtpVJ/7+iiidw==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=FXvPX3liAAAA:8 a=iYUCbxK1D4EDwxi5o2oA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  lh9Xoo2hFa94I
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp07.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1olh9W-0007gx-8q; Fri, 21 Oct 2022 02:48:50 +0100
Message-ID: <3a6c0d0c-68ad-ffbb-0e56-c0282ac84149@squashfs.org.uk>
Date:   Fri, 21 Oct 2022 02:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Slade Watkins <srw@sladewatkins.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jintao Yin <nicememory@gmail.com>, hsinyi@chromium.org,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        mirsad.todorovac@alu.unizg.hr, regressions@leemhuis.info,
        regressions@lists.linux.dev
References: <20221018174157.1897-1-phillip@squashfs.org.uk>
 <20221020135545.586-1-nicememory@gmail.com>
 <41ef4b22-eea8-2d67-99d8-6aaae7d25ac1@squashfs.org.uk>
 <02b72b86-7240-5530-477a-c8bdcfd35ef5@gmail.com>
 <CA+pv=HO36vMH6Uqu412MF+Hmu-+57QeapGt6k+QDDxr-AsbJkw@mail.gmail.com>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <CA+pv=HO36vMH6Uqu412MF+Hmu-+57QeapGt6k+QDDxr-AsbJkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfEyqtsxLz1gEmZjxX+VafDIUyUYkZMC4FdqorbjnsnfWydBU6r/m1SiKSml88rcxkCATtC10fWtZACjvl3c5JxPOM+4YQmoIOSytZMrMaOH8ni5Pcwc9
 Oo7AhZrNRihfjNQI6JjEQFgN0D2K8WanAetxC4ezBDjdwJuG4Tffx8QuAxPU+GEiMdrktzJU+ODDhY/YQiO46BrmpXaRJxyMivo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 00:44, Slade Watkins wrote:
> [Resend due to formatting issue, thanks gmail.]
> 
> On Thu, Oct 20, 2022 at 7:23 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> Ah! I was about to test his third fixup patch. I prefer to go
>> with your fix instead (as the formal patch).
> 
> +1, agreed.
> 
> -srw

His patch is wrong, plus he's broken a number of rules of conduct, two 
serious.  But, I will not reprimand him as kernel maintainer for what is
probably extreme naivety, unless I have to.

The link to the full set of patches is here

https://lore.kernel.org/lkml/20221020223616.7571-1-phillip@squashfs.org.uk/

The first patch fixes the regression reported here in the correct way.

The second patch fixes another regression (which is separate to the
regression causing the issue here).  This is where the code incorrectly
extends readahead beyond the end of the file.  This is the reason for
the unused trailing pages that Jintao Yin noticed.  But, this patch
fixes the cause, rather than fixing the symptom.

The third patch fixes the buffer release race condition that I
posted a fix for earlier.

Spitting this into three patches is one of the rules.  Each patch should
do one thing, and one thing only.  Three separate regressions means
three separate patches.  This is a requirement for "git bisect" to work
effectively.

Phillip

