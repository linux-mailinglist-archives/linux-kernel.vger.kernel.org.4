Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DE05BE005
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiITI3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiITI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:28:35 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EE360FA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:27:06 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 790374000C;
        Tue, 20 Sep 2022 08:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663662425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XTnfaAUrVolUOjcW97DzGgJ1A+KBifmDkjE9TXjCqls=;
        b=nm4Gg80xC+WeYs/9o/3GCz9rjrFy6ESk0mN9SqydE8JULcv2PIRKll5OnkHqaemHV6K41q
        oT0PSt2bJ5nGlleuB+nmJpWMwJ4fbBdU1oUrKpO21OlP/zVmWHLCWqkhMIQLUHXoKw9SKh
        Bg6+R7noq54LDlXWOUGqhybN3i0t3mb2PKy+QqTnNEIjraTY2usu+mq4ueDlj3RWNS15xg
        ln3Xvz5Kdkq0YpGCVSsRR7Wt5eATZl2U5ZxF4r8Xs2pIXB65bbC4Gb76dDQtrmArdgIdjr
        nW35/45GQRROjvWHt1qtMwfEP2C3Ztmk0aq/9laZ8JBrpnsIAzJ0y0sOdi+lrQ==
Date:   Tue, 20 Sep 2022 10:27:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     han.xu@nxp.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: gpmi: Fix comment typo
Message-ID: <20220920102703.20bbf413@xps-13>
In-Reply-To: <20220811135854.27036-1-wangborong@cdjrlc.com>
References: <20220811135854.27036-1-wangborong@cdjrlc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

wangborong@cdjrlc.com wrote on Thu, 11 Aug 2022 21:58:54 +0800:

> The double `the' is duplicated in the comment, remove one.
>=20
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

I've alredy received another patch for that.

Thanks,
Miqu=C3=A8l
