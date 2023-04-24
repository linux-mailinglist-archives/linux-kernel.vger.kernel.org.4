Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514AC6EC958
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjDXJq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjDXJqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:46:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFC13C11;
        Mon, 24 Apr 2023 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682329558; i=deller@gmx.de;
        bh=r8d1kBsYn2Vsg1ZsATwHy91SjqfepNuA5xgDrCumwfk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dRDV8HlXQrskUZk9ZO2np4z+diAwOGcC0PhuyIKt4VM1A3ztdn3ya6zR9865/lqWU
         ALgbODoXl7r5IJyA/S7UzHQigKEV8C3Di+U46VmgYozZI6X+w7uw5PRRuteq9rxwCF
         q9rRF1LkdH0HQsf1Mlv3IAUtDQuCsx8OBIsFqtu+FfTWenIhercIoGj2Kf7uDw0hdE
         QXS8RrSdf7eUxvt29JIxXV8yCrFzzaHwEUzz7FDoMyiQCjdx9yd4L9SB8GImDEjApD
         RZKHjha64fCzyxldolpw+PVi3fzTND8EmyXEcC+Py2R//SGZa0h6WiJWtk7RHIB/EJ
         7sww68a60woCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.153.242]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXFx-1q4PIa3mQz-00DZsq; Mon, 24
 Apr 2023 11:45:57 +0200
Message-ID: <838c028d-92fe-df48-739e-d097ec2630c1@gmx.de>
Date:   Mon, 24 Apr 2023 11:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] MAINTAINERS: Remove rage128 framebuffer driver maintainer
Content-Language: en-US
To:     Paul Mackerras <paulus@ozlabs.org>, linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <michael@ellerman.id.au>
References: <ZEW4REOoU8XuT6sS@cleo>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <ZEW4REOoU8XuT6sS@cleo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IhVTtWYWLo15a0H4EdmZfeiNy6lP3gADo9lTVBufmIyu5b5SqJM
 mfWtfIzZhMBacVTbAHAMljACfe33kb0o4xPvTN+4Y8Ikv/n+HFKIgCTuy5FtQpJMgSQYklb
 JPHFE4PFcr1x/qLPE7ZUFPoQDxai9C8VOzl+C9JEnLQMkJ5MaDJEqwx45+mrYJk1fwrbDLd
 thwWbwuZy5AMSwir/XJwg==
UI-OutboundReport: notjunk:1;M01:P0:gQVko6niNME=;HvAg/wG+HJsCeIfrVvEemQ6KIo+
 5kNhhBP1wOLbbk0TLPx6WadSitADpEF1JKNQIK8vSN1gd5ZyNaSJmcoBo6wYSQUE0/oSNY6Pi
 7R9t/LMA5nwVOaeeqs2W/WPmklNwWR2QF5+JfW+2BaVnp8ME1UE6xQm9fOLdRY6EHxr7DAkub
 vztRVmB59EdDnzSlPRUQwzmy2S46fHZ38v0pIRWbfecV2EwQakrtPp790LBcaZBnxwHyIUSX5
 Vr5p0ypq2ZV43DeK3M0bsFUz7BXGiSiXPLdenw68t035s7kpekjI+7n4dwYOX8PH7QFI561Xl
 TQwnl4u7nfTBM8hunMSoVl9vuHtW4QNL38RTkaii5QzcquXmJ1yYB5/qZotzCG1hHub0p/xqn
 O/NvtWK5iQp4a8AxgtfwlmxVUVjBgTMlvuBiNueudvYGat9UCa1Iv3rKAldFUtWH2dxK02NLm
 QTDXIupi005ZrDb+obKxNglGlptCjrvyMab24VHdxYjl1httAf/7pTub7hNKdk8g8LpA2zlKq
 Tls/iXfWOj91M4QJjY3n629WqdrQm0+lknC7hpWG5rbPN4gR2cqgSN3a4DRCFOQOT55R7tPKP
 pHt6Q2Og3T8zgLwACnQUUbjZ3BQ8qqpxhELQfOxB0YC4Sp9fRofxEpFlVPQEmRKSfoFpDtdDD
 X7/U40fhUD1Fz83SoiO9mwuh4Q6qTkOee4Ss+QY+2Cw4oWDU+6HCBgmwMvtTBfzdnWS3e+YWm
 ++ekZqlDYKFSK4IcfGr5ogLiruh8jIjwkVBS2jS8zU8WSwqsrShBem3fBIeAZUk96FF1saZ/e
 TvKtTgqeSq3YaZP8tO5Vg2wrugtk4CAszwq/1xmaFJBNm0i1m0Q/jVgpwoPhbAONUgoGbWqOh
 V6FwHRsx8ikiU4n59jjSLbTGuWyQlCiv+ZIaU/Nz/h0jcLNMQ/g8NNwxHYw/QyfjiTQSVXA+w
 QMjQy0gh43teEJEQ/VcqVJHCypQ=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 00:59, Paul Mackerras wrote:
> I have not worked on this code for years, so remove my name as
> maintainer.
>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

applied.

Thanks!
Helge

> ---
>   MAINTAINERS | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c6545eb54104..d79bae5590f8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17462,9 +17462,8 @@ F:	drivers/block/rbd.c
>   F:	drivers/block/rbd_types.h
>
>   RAGE128 FRAMEBUFFER DISPLAY DRIVER
> -M:	Paul Mackerras <paulus@samba.org>
>   L:	linux-fbdev@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>   F:	drivers/video/fbdev/aty/aty128fb.c
>
>   RAINSHADOW-CEC DRIVER

