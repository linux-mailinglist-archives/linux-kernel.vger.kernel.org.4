Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FE570B7AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjEVIcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjEVIcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:32:22 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4812012D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:32:01 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 286326000E;
        Mon, 22 May 2023 08:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684744320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9nA+yCnDD+jGhOJLKYTP39879FYeAa+yLpi/+lBJP00=;
        b=M8brq2KG5LVLd/nmRiduJj+MxtYR2sEYsKOlV2bS9D+idgLdJPi/mcdyAkgoWFZUSbTp4B
        TpGUQlC8uXHNTUSmVvF2Bzj96QStKnsKleQNeP5jBxGhCJRI2A19fDkyACFvLihNB1hRPe
        cKQVG0+BF6w4uxoMquzGGnUEDN6H/OIvNFsVOBs+5Ic0v3ma5+59zmj9lAL2Re/FqrmMTK
        8F10dAJcN2bGRTrP5bOXGbKJvpnL/qGlk/92TRP8ILJkgvK635VZ4X5cAIfmAN11pj00fx
        lBo1HOeHEoH24PmQjVslJDE1dFpVaff76YchKM0lgF/DyEyhQ8Zd6F/iJC6A+Q==
Date:   Mon, 22 May 2023 10:31:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: fix i3c suspend/resume issue
Message-ID: <20230522103158.016ae674@xps-13>
In-Reply-To: <20230517033030.3068085-1-xiaoning.wang@nxp.com>
References: <20230517033030.3068085-1-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

xiaoning.wang@nxp.com wrote on Wed, 17 May 2023 11:30:28 +0800:

> When system suspends, if i3c module is powered down, register
> value will lose.
> Need to save the key registers before system suspend.
> So save these registers value in runtime pm suspend, and restore them
> if these register's value is different with the saved values
> when runtime pm resume.
>=20
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
