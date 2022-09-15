Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5947B5B93FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 07:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIOFfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 01:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIOFfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 01:35:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E9A6FA14;
        Wed, 14 Sep 2022 22:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663220089;
        bh=4nieZw5geSNA7yue4365PqN3YDOxsAGZvwH9Xy/fnQw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lpmZBMXkb8xZxg++ZcaTNw+CSRUMScGrdWE8sOAunf+aFnybcaUcGjbBcleHYmci7
         mSk03/pNWxNHzkjH3w/gm2bZT+XWW7b3VwSwvNm6lWdsR9PAlvEGY0y8MlD38jMxjr
         qjppofH7CVf83vqAGewFj7kVyBhCvGLsdEQ42Gz8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.174.140]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0G1d-1pUdrS1RYt-00xNJf; Thu, 15
 Sep 2022 07:34:49 +0200
Message-ID: <76919d92-0a85-8c83-c434-ba8998d19a07@gmx.de>
Date:   Thu, 15 Sep 2022 07:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] parisc: remove obsolete manual allocation aligning
Content-Language: en-US
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>,
        linux-parisc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <2442384.MTfJ8ztCV8@eto.sf-tec.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <2442384.MTfJ8ztCV8@eto.sf-tec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tUEK0Er3yd2fxKJW47f5w/Osc1fKAlq9XXT7w8+50NDZXFdb/0O
 lCzSmXKoffQQktklPO77RrCRSMxgIPbkD5Eiddg+9elMH1ftuDRAWaiDT9HlqdLjwvSs3Oh
 nZZj6BgF2ACJaSC215OOKw7q0D4HLAb/2wHYm3pj1zgeuTFMVe5r2wZGQyjuEAFE2I6D3dW
 6as0w2AW8SlMCM4w8VvCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:39nUoAt6lQ8=:CamLCCfW77OJskz4kntuiD
 mOqGFS82i16XOZ36Yu8g7qptLFoxCPUGiD2FWVcraotz2mETN0CCT6A7n2XoM9ftf8Zhbn3xP
 DAZo3nvNI8DH/eM105NIDp0yDn1nBbrbkjlv0TgNo0PAg1lmzrwnWxqL5pYOT//7IS8Ywudw+
 yrkN9XJ1vLIzCnjMA6eKoFHUXKnSJn+t9ZMnttdyWD4a4+60UlWgNhtarLFEUehqGdu3FWx6O
 o+7/j4+o1nIvOAUuvFFf35zncXUj0F2SAN907LIdyZLqzgsWfuTX2ohCCrytjnjG4ndB1CfHV
 lE4WnDXEIEcxfCB/FvHUx2rRGG1dRfot627tvww2izqw0z/Ywwxkp8IVBRR+4TRwSVQD0eIWE
 lRc6NFMTUMXYGWx5aFGJ/vge4V5j2MJw0rQrHq5MCa9jf/srQP6C0OqLRFPK/xtFEp9a2xZd5
 UYFPmFbCqPDU3ETimkeATI93d8I3vNAcwqUa3LGDZJBWwiILtBjxjFG7iJSDhoRvi1c0oPRA+
 UpPPGxZBq67k/0mi3s8otZTE8Xs2Jld5ErEHfHa2rkCLa5UjXbBLK5rszXwEBFUUJxl55iTeN
 GCjGWgS7RtljWTAcZrs8mwjCJi2Ve6dXzzXZ5C0+IW4dvAQEGxGQU12deEoLPc8JL1RAvvB77
 52gViI7mxJURLpQk58+nbg4027xC85rYOY1XejdcRnsFpMer1ME2e5KgQeosQnQUutJgQ349p
 X/WgzaSFF/WBdj12TxB0WiXD/f4mhdNG7cFc3itESqniRLZ8nhAXRjy5KaZyg/ZeUeFX6kSdt
 zqPhkLEb0fSnIBLAg/Teh3fz7Da2DkVIUTjaDmZ/P3QXCDRcGxABsbjKEW01BlNoK1Dl/uOmC
 gRQNjtopLZUj1EZTzq/aAc1l/yUGZ9HEMfAxpG73fhOonrxFcNaQUlQOwgHmTsg6P55GKhexk
 HduwYVVP3uYDILjLy7uGnlMkxLPxoNmS8cgZWbkoqoF06QvuLloxD+yqlEZ8cSctRLB9u55ad
 MZxH575ZPb4m96DzGbIqnGZWwS5pn2TfdqZaxIuEMg++ixe/a5Ihlqmi0KKTWj7+YgF45h+Gs
 vv50Xnolmau6bvoOJtvpAroA6Llk0/75ypuoSjZrafdqT7K3245YXmTYywkbgul5Ze2/y65+S
 fEvac=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/22 16:23, Rolf Eike Beer wrote:
> kmalloc() returns memory with __assume_kmalloc_alignment, which is
> __alignof__(unsigned long long) for parisc.
>
> Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

applied.

Thanks!
Helge


> ---
>   drivers/parisc/iosapic.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
>
> I must confirm it's entirely untested.
>
> diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
> index 3a8c98615634..bdef7a8d6ab8 100644
> --- a/drivers/parisc/iosapic.c
> +++ b/drivers/parisc/iosapic.c
> @@ -221,16 +221,7 @@ static size_t irt_num_entry;
>
>   static struct irt_entry *iosapic_alloc_irt(int num_entries)
>   {
> -	unsigned long a;
> -
> -	/* The IRT needs to be 8-byte aligned for the PDC call.
> -	 * Normally kmalloc would guarantee larger alignment, but
> -	 * if CONFIG_DEBUG_SLAB is enabled, then we can get only
> -	 * 4-byte alignment on 32-bit kernels
> -	 */
> -	a =3D (unsigned long)kmalloc(sizeof(struct irt_entry) * num_entries + =
8, GFP_KERNEL);
> -	a =3D (a + 7UL) & ~7UL;
> -	return (struct irt_entry *)a;
> +	return kcalloc(num_entries, sizeof(struct irt_entry), GFP_KERNEL);
>   }
>
>   /**

