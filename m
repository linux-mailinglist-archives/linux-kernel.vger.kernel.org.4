Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96CB5BD160
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiISPqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiISPqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:46:03 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0528C1A391
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:46:01 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D370DFF806;
        Mon, 19 Sep 2022 15:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663602358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n7Wxr9PSijhZGWTkRtV1y/YLavAq24fTU1JLn1YD7jA=;
        b=OFGnC/qeE7JttDYUfQlXdAmhk4US/RyAF6ZtNeiQGRwpnCvEWyglpSs+K4yPDga7sMlQor
        A40FED73dSh30eixYQ0K/EKDhojSLE0xYdKDdg3wrA6rUJ5Nn00NTNfeqTNjZOsjCESyPt
        usMgoIxDlTodvXpoO1d+dc5zw149/eLqWpR7AL5he+sNqLUrxSDnGyGc66uQlXQ9c8AgfB
        AlXQNFOGujXbL7gmy/XdY0FCdKeAVMKVHndQsnVZuubI0VRClKUetbAVG4vwH3nkD9L/gB
        6f8bT+YtjfuLr4+/Md/r/Wsrob1jhD80CQUQzipLipbQCnRyWpoBSkXmP73J9A==
Date:   Mon, 19 Sep 2022 17:45:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/mtd: fix repeated words in comments
Message-ID: <20220919174556.35597018@xps-13>
In-Reply-To: <20220810131539.51108-1-yuanjilin@cdjrlc.com>
References: <20220810131539.51108-1-yuanjilin@cdjrlc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jilin,

yuanjilin@cdjrlc.com wrote on Wed, 10 Aug 2022 21:15:39 +0800:

>  Delete the redundant word 'it'.
  ^
No space=20

>=20
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  drivers/mtd/inftlcore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/inftlcore.c b/drivers/mtd/inftlcore.c
> index 6b48397c750c..1709f7f6bf6f 100644
> --- a/drivers/mtd/inftlcore.c
> +++ b/drivers/mtd/inftlcore.c
> @@ -356,7 +356,7 @@ static u16 INFTL_foldchain(struct INFTLrecord *inftl,=
 unsigned thisVUC, unsigned
>  	 * Newest unit in chain now contains data from _all_ older units.
>  	 * So go through and erase each unit in chain, oldest first. (This
>  	 * is important, by doing oldest first if we crash/reboot then it
> -	 * it is relatively simple to clean up the mess).
> +	 * is relatively simple to clean up the mess).

Please send only one patch for the three "double words" you've found in
mtd, and prefix the subject with "mtd: ".

>  	 */
>  	pr_debug("INFTL: want to erase virtual chain %d\n", thisVUC);
> =20


Thanks,
Miqu=C3=A8l
