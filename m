Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1493A60AF6C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiJXPtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiJXPtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:49:14 -0400
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [IPv6:2001:67c:2050:103:465::209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ABAED9A5;
        Mon, 24 Oct 2022 07:42:39 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4Mwxcg4D11z9spy;
        Mon, 24 Oct 2022 16:03:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=noorman.info;
        s=MBO0001; t=1666620211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bUqqF2wPQM4zFYYLFWVSuLSKsQw7baH8AiQHiHkoi9Y=;
        b=tqc028RVGkZIeNEO7kzRCs6080pD76MHDAgcqJyBU3CiL3MxhBuzPlmSbgmly2LkqkJbys
        yhFkWwMXkJtovkZMwabq3MWhPKYEFSiqEGyCK8/HYPcG3LiytvcdvBtia80Fkr0lCB+AIJ
        4fYn1r2RlZ6u+YZM7+SC/cU+95IWpCfaMcpGXth+s4IGGX6rqzr1XUw8GtHfjJxt6HnVsj
        e7sc5cc02JIQ3aWUWw44GVCrf47h3Oy+0c519/1PbE4+0l6k5eroU/4iAFBcawe+ZH4jbY
        lc+j05+T+6CsVPI2MHxzsSEwgs6R0J8qzpuelRbm8NIUs8cg4joDZcQvPuY+qA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Oct 2022 16:03:30 +0200
Message-Id: <CNU7K2WVE8IR.3400IWODUPYYK@ancom>
Cc:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Henrik Rydberg" <rydberg@bitmath.org>,
        "Luca Weiss" <luca@z3ntu.xyz>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] Input: add driver for Himax hx83112b touchscreen
 devices
From:   "Job Noorman" <job@noorman.info>
To:     "Jeff LaBundy" <jeff@labundy.com>
References: <20221023163032.144150-1-job@noorman.info>
 <20221023163032.144150-3-job@noorman.info> <Y1We8NgutWBbbNpV@nixie71>
In-Reply-To: <Y1We8NgutWBbbNpV@nixie71>
X-Rspamd-Queue-Id: 4Mwxcg4D11z9spy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Sun Oct 23, 2022 at 10:07 PM CEST, Jeff LaBundy wrote:
> Hi Job,
>
> Looks great; just a few tiny nits that I missed last time. Sorry
> about that!

No problem!

> > +	ts->regmap =3D devm_regmap_init_i2c(client, &himax_regmap_config);
> > +	error =3D PTR_ERR_OR_ZERO(ts->regmap);
> > +	if (error) {
> > +		dev_err(&client->dev,
>
> We already have a locally declared dev pointer which at this point is
> equal to &client->dev as well as &ts->client->dev, so we can just use
> that here instead.

Nice catch! Fixed this one and all others in v6.

> With those remaining points resolved:
>
> Reviewed-by: Jeff LaBundy <jeff@labundy.com>

Thanks! Added in v6.

Kind regards,
Job
