Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F7C6C44E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCVIaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCVIad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:30:33 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CCB59437
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:30:31 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 61D6FE0016;
        Wed, 22 Mar 2023 08:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679473830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s30knEgyz141A4mH34EilC/GtHAUuX2LIT467JfKUBg=;
        b=Nj9sECjLO5HpDgwl42PSdE4VAZ3F2ZJn7OZO+XU5UJrD/UJ9pSwysX/Uad/HwmkUh+/bzj
        e3fuVVQ/pUwEPkfdk0ypxelvTtfGWssVfs1e7gmxR2+teRUBMdEVjprOh+V0hAXSnSJECV
        M7o+RdIyNAKgfErEQHDLCUhfDa3RHgk/Xqwy6wmmCcjpFQwO042EEmW0lER+jfHnPMFGiK
        ltjtl+ABAtASOWSSNdOpR7pfWJrVInlHkRCyGosLd73HXJUGjrJqQjyH437t1S+FbLl8bq
        TCDPqyxpR6OcHJ6Sd+myWLL56QN0ggr+DNm4V8nrX2kl0yEQbKW4Yqowl4FJCQ==
Date:   Wed, 22 Mar 2023 09:30:27 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     <ye.xingchen@zte.com.cn>
Cc:     <kishon@kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <vkoul@kernel.org>
Subject: Re: [PATCH] phy: marvell: phy-mvebu-a3700-comphy: use
 devm_platform_ioremap_resource_byname()
Message-ID: <20230322093027.4c1e2176@xps-13>
In-Reply-To: <202303221007049346627@zte.com.cn>
References: <202303221007049346627@zte.com.cn>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ye.xingchen@zte.com.cn wrote on Wed, 22 Mar 2023 10:07:04 +0800 (CST):

> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>=20
> Convert platform_get_resource_byname(),devm_ioremap_resource() to a single
> call to devm_platform_ioremap_resource_byname(), as this is exactly what
> this function does.
>=20
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
