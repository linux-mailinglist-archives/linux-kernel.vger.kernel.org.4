Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917196C00BE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjCSLTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCSLTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:19:10 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEFF166E0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CQbZdqTfpVu04Ol9krfmhGs0dWnMUsVc9ERV0IPCHsY=;
  b=TUYsFGhB6RGQGpI5HNU/e8R5tyhjwlf4NekFFoOVsbSn6Z9yBI5+1zC+
   b0PatNixPTPwidnW79TDtgImtXTt5+zc4Gf5bI1XdxIgeB8YRtn6k+8tN
   uCpT//ok+WFIFbWDGccRY+2JB5uoaLu14janzobW89CQnykZzxFcQsllJ
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,273,1673910000"; 
   d="scan'208";a="50605204"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 12:19:06 +0100
Date:   Sun, 19 Mar 2023 12:19:04 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: add blank line after struct
In-Reply-To: <20230319110831.39931-1-eng.mennamahmoud.mm@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2303191216240.2867@hadrien>
References: <20230319110831.39931-1-eng.mennamahmoud.mm@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Mar 2023, Menna Mahmoud wrote:

> add blank line after struct for readability as

The log message should start with a capital letter, so "Add".

> reported by checkpatch script

"reported by checkpatch" or "reported by the checkpatch script".
The first is more concise, and it doesn't really matter whether checkpatch
is a script or something else.

> " CHECK: Please use a blank line after function/struct/union/enum
> declarations"

I guess the #define was concatenated to the end of the definition to show
that it is closely related to the definition.  With the #define, it seems
rather natural, but the better soltution would be to make a static inline
function in both cases.  There would naturally be a blank line before a
function definition as well.

julia

>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
>  drivers/staging/greybus/gbphy.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
> index d4a225b76338..1de510499480 100644
> --- a/drivers/staging/greybus/gbphy.h
> +++ b/drivers/staging/greybus/gbphy.h
> @@ -15,6 +15,7 @@ struct gbphy_device {
>  	struct list_head list;
>  	struct device dev;
>  };
> +
>  #define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
>
>  static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
> @@ -43,6 +44,7 @@ struct gbphy_driver {
>
>  	struct device_driver driver;
>  };
> +
>  #define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
>
>  int gb_gbphy_register_driver(struct gbphy_driver *driver,
> --
> 2.34.1
>
>
>
