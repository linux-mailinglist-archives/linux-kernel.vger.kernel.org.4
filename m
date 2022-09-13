Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6FF5B6CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiIMMBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiIMMBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:01:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99916371A6;
        Tue, 13 Sep 2022 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663070466;
        bh=2f96pn4UIFUvK+G0zJudGrPeTA7P8Z3ba2bU4qOzo0Q=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dgGK4ooSjbX0R9ANla/QfSGJcd2IbOjVAzaocYThGe9nf8SJpfojCLL7NgevhAurp
         tAmzLeoOzlX9q6NzWNpwBdEwymJUpJKB/injdplK0ns706XLkF3dPNsRRPRZ7TzT2B
         Kclnb46IPyCvtrPinwLX4L2otI3pcMwQpst8t5Uc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.190.164]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1pIrlo1Txq-012Zm5; Tue, 13
 Sep 2022 14:01:06 +0200
Message-ID: <a9c8f766-f0f8-b85f-cb11-70accdc6ad93@gmx.de>
Date:   Tue, 13 Sep 2022 14:01:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] Input: hp_sdc: fix spelling typo in comment
Content-Language: en-US
To:     Jiangshan Yi <13667453960@163.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
References: <20220906054901.2283059-1-13667453960@163.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220906054901.2283059-1-13667453960@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jvGN3DYfjyIxOxutLjd/88EjLs0cSoDEh88edzs4lqkQND4bjfK
 3b1pGM+0Nm/JfAiVbz1HnJBSrkQJsj5iVJmWHM3di4m8Z/sCK6103R6ZynDTPiTN/U3L8BH
 q16i4Sx8beURtT4eDHxLGTFtSjICczWm14bZdDTuKZKr9+LaUdY7KPYJ0sAzCUSuOghQ4P5
 g/B6UnTs2PmB/lsPsZq0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QUhVHo29Hnc=:rRpQr8CG7+udNZM41tTlFN
 eC0aXeelAHxnrKjsHtPPILMp11gChk9pK3NNUD2aVSdnAzxChkmWRb2sa4xN4/CJ5gpjN7Gr/
 z3lMq5PJF+H0Cxh5hpeFNK2f3MLMbF2AAlda2AZ4+PTlyLxa0hhDaUyDvW2MjzFfTKzVd7uVK
 v31V5n2iE9zDJR+DTxHvvZFivxmVK3LIw0DMdrir/z4wos1EOvd7fVePQKe+2I3/lVAVXR4ry
 Vt8BaJZDEMZGmiiJkJixot9QxvNF08xF8SWPwir8Yqml+JpgWtXwELTOMuzXqF3D18I6rxbGm
 GPwaFkDEyKUq3Q5DETcNxzX1ROWq6xcMJPfI7Xhq/dGV4klBMy7oOyh5hyt7oPYAwGVY0j9OO
 Emhmpn9wKaxbw2Lsm4Is6ybbsFcFPnRY1Wwq1iemOkjLdChaQ1OLiCjDAtg4xiyVq4oX0uLj4
 T7e5wTcgZ7itmuCCEtHJYC8Wdk3y4TMtqi3vVwHCfDtUFE4bbL99vsX0U2EhrgwLSvncBlAUF
 c2wgD9nXBU0DZ3NBQH29ot3R9MbgGXdEbV8YgBjagVdFJDhhN5qqDzDqvm4nIUVMqoDRbhNUE
 h1gItrm83Kmv8cLijCn+diQVQJU3GIFFjzmbdbnMWPyfjlOxwDL7CI6dFwrWEMVx/v87Yk6Li
 c5IV7UPoE1C4Pl4BlpLX+ymd50IFsiQ9YWL1Ree6DSObgeO7YdTeKviDE7pZJp1X0mMBQzTKg
 e5Nbtb6DzoPYMQxMvHGkZQr0CIU060RHRHBCHDgrM+g5lFDFopaoW17C+h1fa12uqyRCbNbsg
 Th8XDxmSeWHKWaR8399y7aWAh2LjSi4kjWo5ReutMljDu1uJ6G7jhslAMGmaVb582QCRvazOo
 wrFWZ0cpGAGvB45gjdulZg6D6w6dxAAH8/OZZOkzmmn7ZcMKIeP7JG2gvuaEoHEYwJtsYisLc
 lZYJgAvNO7XH0e5t/FThB+ZSkE0EdAW2/HFDsKWOKKPXjr6k7rfAwX3tvV/pEah/uxXF9t+CC
 0w6Yhq9jlnsMSntn+r/4M8irTkYKuh1hyfxDb/BPLGqhqToMZDeBIHVHW7Q6q87WCQ0bUx76Q
 DPA0mb3qtqnr6Ymnyf8h+CIeHcoyQQJwt+pLBA2clj8LZt6H1wrWmAYag/JImgJl5j0suPmyY
 7d6LJjU7DkJlIWuXM8D8WqinCX
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/22 07:49, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
>
> Fix spelling typo in comment.
>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

applied.

Thanks!
Helge

> ---
>   include/linux/hp_sdc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/hp_sdc.h b/include/linux/hp_sdc.h
> index 6f1dee7e67e0..9be8704e2d38 100644
> --- a/include/linux/hp_sdc.h
> +++ b/include/linux/hp_sdc.h
> @@ -180,7 +180,7 @@ switch (val) {						\
>
>   #define HP_SDC_CMD_SET_IM	0x40    /* 010xxxxx =3D=3D set irq mask */
>
> -/* The documents provided do not explicitly state that all registers be=
tweem
> +/* The documents provided do not explicitly state that all registers be=
tween
>    * 0x01 and 0x1f inclusive can be read by sending their register index=
 as a
>    * command, but this is implied and appears to be the case.
>    */

