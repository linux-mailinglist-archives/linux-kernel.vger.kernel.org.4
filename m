Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFC35E9298
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiIYLLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiIYLLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:11:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEEABCA;
        Sun, 25 Sep 2022 04:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664104248;
        bh=q3tgaxmLLwHySr5xYd0o9DohrAeTmn9jyFFga8/esfA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=j77OAg1IG0TQAu2ML8ZEtQWAbjEUaJxGoPfJo9xGYELQzHQaZs1tbaVHybcylGcUW
         o/FbH4sr2WD9bBEc9/rdJH4xR/kYKjbSL0qfg+jGh+yL7hK6zyAURTntwNO8LA8Qa2
         D8wnRnvXuYP7lSyLV4sjrKzEt9+pUtF1zGScgEmc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.188.118]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUXpQ-1olFEm07kW-00QU3k; Sun, 25
 Sep 2022 13:10:48 +0200
Message-ID: <3cf0085e-3927-9049-8b92-f84b7496d59c@gmx.de>
Date:   Sun, 25 Sep 2022 13:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] video: fbdev: tridentfb: Remove the unused function
 shadowmode_off()
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220914102301.87981-1-jiapeng.chong@linux.alibaba.com>
 <20220914102301.87981-2-jiapeng.chong@linux.alibaba.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220914102301.87981-2-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RLtbfVmjosx0ENfGiiN4wJvkrUuzWdv/CwRX/7mKg1jgJ8qod8+
 PmO+KC2o4lFNjWypMgIELNqyM8ELcw1NCOxzsPjSME3YycJ+UJU7BRsRPlrv/+eBXuowE1q
 ZhKHcJ5J2MOjZuYFbZkn4ywtpAH7sn/plMSChb03CVHNLGWpSN9+drATUY649HteJWgaQfV
 jFFs3J7pzz/An8FGEiIXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oyeU2vyCYK0=:WugP9+tmwTH9x8Xi8WHHoD
 nGokr14pgbKwQJRQ2O8M6NyXZUKZ2DvF8k+rmPefGhB1gsvz1Xvin9O5Ru1S3WdU8IiVcky41
 rtvRzETH7L+qgVlDQ9NlBB+ntwyZa5qLLQ+UMBmOW4Y/CPAq5Z+ALnJf05OmVbPtA5kI00SWL
 IjGiTZUIndMbtvgLgKew0HrqdgLML3fsv7ltOA+6TOpdvWzJPvMz2J057SXsFHFmPh0fkxW+s
 lQ2oEptzRjYoiCxLKHaP1iF5JgpESOZCxkqZVezxf4+vwrZNGcrLg31BcfCYIuAbXpR8cV4rs
 qkLX/a7w+wpWAcVT7l5K5Ju9ghCYhXwuz+J3lpa/fhO0OBHh7zEVsCJ99fOrtIylrxQRN07AQ
 tIFiaQlDDYxq1zZl/MFf6ZBNWxczhlaVWdYmXfBRZU9knYdHvgDQaTs7GVjXlJIPWmkGw9Kyn
 oqk4+ZsuVSmKWg73SCgGeNQ7Lnhqzo/RjWcObDaGX+Jxmx4pUqFyTfYv4NLCFUZdPM2PcqNOV
 0gAOKutiqs3e3VQaerYxhbW7yeo2oRk3Vi86DJVSq98ZrQlNnycZf+SDQagixtMhhDdB7HtRz
 ohznmak+KYtKyjDwLdOpaDkj3ZDW04REw2PPc/8Yt+fhATJm9QR0orozxXeSzcs89Jcgr5VvQ
 bBGydsE/AGviqcyCqAJOgaEApyXqaGd/ZEY+KFlkj+vxwyt33c/T2OYm7TGtz4ejZayNGznhs
 NQFwKEmy936qsWn49x1AwU5vHu+Jckq9RVthg2fDkHU1kKWpVAK+i5FyP2NCYReOEVVUI4Xmf
 gl8r99hoezHydLRIt3HbEpbdbZ25rTeZc+hOfSzw5N+RuR1OlwnLKG1D3xjyqb5OubwYVQJY2
 93fajFgBBSEQ6fsgFJqRph5rZ1KVWjh5mSrYqku6WRmfbcUTHiw5ktQqEiicBpwj37MKrGneJ
 iD7u+lx3NM6uTPhYmZl2Vsd8FdGLothhP1DHVWfatpMGSFMN/FpI2LvfoIIsQGneK43buTHiY
 UZaC9b0qqGgWG5s49/7HBVzPb4EmM7YQXhxsckUy2niaiIElZKHFNt4MuTFWvq1Z+WNaHV1dc
 Dp3NqKDr17mgCtrofhCaVya5JqMdM6pz1gU0rEyqkbD1GUdlsEla7dSBXAni3vwkH3eOmT9jg
 4JqBGmutQP9/j/gLzRFL6EnriJ
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/22 12:23, Jiapeng Chong wrote:
> The function shadowmode_off() is defined in the tridentfb.c file, but no=
t
> called elsewhere, so delete this unused function.
>
> drivers/video/fbdev/tridentfb.c:1131:20: warning: unused function 'shado=
wmode_off'.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D2154
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

applied.

Thanks,
Helge


> ---
>   drivers/video/fbdev/tridentfb.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tride=
ntfb.c
> index f9c3b1d38fc2..2154dd5e37bd 100644
> --- a/drivers/video/fbdev/tridentfb.c
> +++ b/drivers/video/fbdev/tridentfb.c
> @@ -1128,11 +1128,6 @@ static inline void shadowmode_on(struct tridentfb=
_par *par)
>   	write3CE(par, CyberControl, read3CE(par, CyberControl) | 0x81);
>   }
>
> -static inline void shadowmode_off(struct tridentfb_par *par)
> -{
> -	write3CE(par, CyberControl, read3CE(par, CyberControl) & 0x7E);
> -}
> -
>   /* Set the hardware to the requested video mode */
>   static int tridentfb_set_par(struct fb_info *info)
>   {

