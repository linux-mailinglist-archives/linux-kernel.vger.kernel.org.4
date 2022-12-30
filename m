Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCC4659869
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 13:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiL3Mqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 07:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiL3Mqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 07:46:52 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A8C12614
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 04:46:51 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CA7841BF203;
        Fri, 30 Dec 2022 12:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672404409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBAWrHGDoneNwgVavowtFEiZqaQWcMW84NmbAGpQ9ds=;
        b=ijPM2fanJBYP6mqQvoTSnKJSCYm3sLIPwyXvj5kOeVPOUaQTXcOEQZ4VRw+h8lnPZmz8Qz
        nmWwQhM2sMmSYEQ+l28aumtHlf7Fo6OVWzx9QmXJbh6zGW5fM523TZeRTZ87mvH5yS4q/1
        9pLSSA2/UaNVT4UJByLCfxjR13h2xJWVi4SqUqSCwJPiBwpoSTqwJQOlHDP6MUbfYI/L9k
        ARB4Wo0c5oA7tjD0TCISsX2JWrNna0LJcyuawW5aypYdWiUp/6iaD8xZl9+EAqCEB8LVLb
        N7ph1jO+OV9Du/maWujc7FgDP4qF71xIG1enwtYlqeU7MwDUtRHC3i4CtWtdCA==
Date:   Fri, 30 Dec 2022 13:46:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mtd: rawnand: hynix: Add support for
 H27UCG8T2FTR-BC MLC NAND
Message-ID: <20221230134646.2e07bcc6@xps-13>
In-Reply-To: <20221230134507.719edeae@xps-13>
References: <20221229190906.6467-1-samuel@sholland.org>
        <20221229190906.6467-2-samuel@sholland.org>
        <20221230134507.719edeae@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

miquel.raynal@bootlin.com wrote on Fri, 30 Dec 2022 13:45:07 +0100:

> Hi Samuel,
>=20
> samuel@sholland.org wrote on Thu, 29 Dec 2022 13:09:03 -0600:
>=20
> > H27UCG8T2FTR-BC is similar to the already-supported H27UCG8T2ETR-BC, but
> > reports a different ID.
>=20
> Can you provide a datasheet for this part? I am surprised by the page
> size. In general anyway, it's best to provide a link when adding
> support for a new component.
>=20
> Also, for your two series, no need to resend this time, but please use
> git-format-patch and git-send-email to create your series, so that all
> the patches are answers of the cover letter. It helps keeping all
> patches and answers in the series packed together.

You can ignore this, I did momentarily change the display inadvertently
on my side, your series are perfectly fine.

Sorry for the noise.
Miqu=C3=A8l
