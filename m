Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94A26569EB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiL0L1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiL0L0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:26:54 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E846568
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fbDuEclhbUSpZiJFnhFQKq7fs2reDAEBvERmqyYTs9Q=;
  b=UnXDBHNRO9vm7N7B0o0Z6X5caoJWsuXZQMOTQJDUv/t0VX+uggG4hjAA
   T9ZBEifuFF6b4qk2W6mN+Ydh0SLijdyFOwnW3JChAJkP/0MqTEj9wWnuc
   WDc2whMT1V/+d5Z/d4oTLou2gwWzMTYKegZ46PKYLR/ofCpIutxk+oc4x
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.96,278,1665439200"; 
   d="scan'208";a="85148369"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 12:26:51 +0100
Date:   Tue, 27 Dec 2022 12:26:50 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de, cocci@inria.fr
Subject: Re: coccinelle: How to remove a return at the end of a void
 function?
In-Reply-To: <20221227095517.mzjmqse5wvaielev@pengutronix.de>
Message-ID: <e39bbae4-7929-b1b0-ea42-11825d98e43e@inria.fr>
References: <20221224115657.kqyocti356cwm7hc@pengutronix.de> <alpine.DEB.2.22.394.2212241326310.2711@hadrien> <20221225212011.6il5egocxtx5zupa@pengutronix.de> <be39f7d-31ab-24c-61c5-6daabdef9267@inria.fr> <20221227095517.mzjmqse5wvaielev@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @p2@
> identifier pdev;
> @@
>  void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev) {
>  ...
> -Return();
>  }

You need when any on the ... to allow there to be Returns();s along the
way.

julia
