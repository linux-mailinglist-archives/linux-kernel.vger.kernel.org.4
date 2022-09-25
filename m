Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4C55E9294
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiIYLLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiIYLLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:11:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BE1237C3;
        Sun, 25 Sep 2022 04:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664104195;
        bh=WSEpFFTzAxr0EcxOgi+67U8ODH6/CZQ0Yv1M9TPP0js=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lVxMjC9WPtBuY5ai82OTPnw4PYPRzcsAKGcH0CGCQxK2sgtrG9eJnrjJzDPZxy0x1
         RFZb8SIjhDZ7H6lXHQuq0zo7Pb1V1VyV9t+dhwvoE8pMd1KcCfgA0Vd31UnNcYL/xt
         vxRPlJWLzZVNaelHLDxZxICP7Yu5z9Gvp3+dnqGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.188.118]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXuB-1okxCO2vB1-00Z0tT; Sun, 25
 Sep 2022 13:09:55 +0200
Message-ID: <d11a981a-1974-3092-5c81-e1f8c998c440@gmx.de>
Date:   Sun, 25 Sep 2022 13:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] video: fbdev: arkfb: Remove the unused function
 dac_read_reg()
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220914102301.87981-1-jiapeng.chong@linux.alibaba.com>
 <20220914102301.87981-3-jiapeng.chong@linux.alibaba.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20220914102301.87981-3-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C63TvgR0x02Kn5A7dmsLiaUjX6yF/lOw2ac5uz2oMvHy8Swwp1y
 OXMPgTFDPW/rUQ4Iy5anbOveh862N7oc7xDQ78CCJQr53YajKcikIBDl+1AuTl8NsDpJV3G
 2Wzf6B344LlWT9Dzb18GX7XuDFopzSN/mzmdrZuZ89RiVV7VbU1ZPik1GkvUqHW+6Tko9Ns
 155bSHCTe9gcaxH+j5GnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t/O4rTPLZmc=:SAbJGTGOyNCS3EFSBVYZFk
 oVOik03pdvV6pgQVCf1dj3GiERrEdeO553mp2wMJT6O6qPcT8IP/l7OpSCSua4FsEnF1Gt2C2
 QUv7Pc+VhHFghdXO/s3XrYJItexP6pVF2iL3NXNM2ZQ85x6nokvRx4EZPaGnVxlKOblHHwhX1
 I6NtiPGH8jYXfPpHrgkRAPpMkuc+tuGR/V4X/lfkgQk3TsY9vmS3xRSSuW15E99iSqNKcUGX4
 UMrAJKp8J8Roj7OvWpPVqTZVYaSeMViLLa7Iz9leXACF3ZvejpwK2/fa0eaUUlEflTdw3+f4s
 xD0pCGesU5Q07c2LLcLrGB8tnswqlONCRaO5uwSvUPSK1k9ElMMkrBPJpTDWZzvEFDoRNmPIv
 nx5LvSamIoMlbADuFM96/vXigvKjn+dpRyvn3uF93nMifFtgNptfCx5FztVkVsUADpvRvhCab
 VD0MhMDUhZ6E+XKnmO2GfEewj+FzqDZOadcLL5zT6AT2Q1Std6OsqIDloRsYMzpzV3VwjImy6
 3CHFHxGo9A+wt45TZJeOBLTnk4Ki/7745DE577SK9OXixWcu2v5+MusCpli5hMW2v8ifhKfYE
 DSeet6c+WVKnyWFg/K60TfmjnCMeSZafnekJ3r1qhQeUScLe2mJPzRwcvZpdVF10c2gzbNQBy
 ZBX8KChI6q2CiiJiip49Qem3WDoFOF5xG1mHfe5HbfsRcLwLQmi4iO3dMfIcGpDBXEmgRq49r
 e/K3zCUVjULBWANLr56HH7t9d75BwPY8WsoZCa0WwCFfRtCP42d8f5pDpaSrSOwMog0Y/TFWx
 NVgJOY7tXTh9rkrvnryWktN8VTXPM31pMCcBrfFnXfqUbSo4dFbmArPA/OK92ybceCPl77M5V
 bVfY+uwOuiWLw6wlGrskxmL1iD01dmV1JHJrC+juPw5qLTB1al1KBVqjXQ7BlFMQGeKOmxWbj
 A0ej4ZWVALrBo84w30+7tQuqe9b7qSuWgiGsCQUbjV27qnm2kdo3A0BGgX8/SqEGZiNZkEGAq
 KSzv6KpmhkdpbOe4mGrI2KRQfXoSV3ClsjnNzAX1hZEbAkSc56llt9zZVGAcjLTUjovuvMOKZ
 dsIvuo97iiIQYL1KMgmYU1YY7ai/KKfeG70NIxkqg0CmvedcGdSp6sPpRsKzUQI2j+FvMnGHL
 JN2PG+hxQHkxsB3GF/xBpgFyxq
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
> The function dac_read_reg() is defined in the arkfb.c file, but not
> called elsewhere, so delete this unused function.
>
> drivers/video/fbdev/arkfb.c:322:18: warning: unused function 'dac_read_r=
eg'.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D2155
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

applied.

Thanks,
Helge

> ---
>   drivers/video/fbdev/arkfb.c | 8 --------
>   1 file changed, 8 deletions(-)
>
> diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
> index a317d9fe1d67..5f8fec9e5fd4 100644
> --- a/drivers/video/fbdev/arkfb.c
> +++ b/drivers/video/fbdev/arkfb.c
> @@ -318,14 +318,6 @@ struct dac_info
>   	void *data;
>   };
>
> -
> -static inline u8 dac_read_reg(struct dac_info *info, u8 reg)
> -{
> -	u8 code[2] =3D {reg, 0};
> -	info->dac_read_regs(info->data, code, 1);
> -	return code[1];
> -}
> -
>   static inline void dac_read_regs(struct dac_info *info, u8 *code, int =
count)
>   {
>   	info->dac_read_regs(info->data, code, count);

