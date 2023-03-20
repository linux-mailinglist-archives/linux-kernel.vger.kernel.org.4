Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F836C21CC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCTToL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCTTnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:43:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5409837560;
        Mon, 20 Mar 2023 12:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A72B9617AF;
        Mon, 20 Mar 2023 19:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0426EC433D2;
        Mon, 20 Mar 2023 19:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679341136;
        bh=xw7yWF8qm73chBz32rRP1ijEJSTjInaPKsdd1qVK5HM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=n+xBaCiehuuGEAUfECWs9RatEiWhhHrMX7r8r3XZXyPrvBI3T8hPrXoAPIwulENLU
         lUYyhLWvUGA9HC0VYzdPuDVc/rUeGaZq3+W2NHbRdm08mDzX5rGmjdLfadYRo9krR3
         TS6ZOCH7HJYgdPVo6hSPzJaMvYiubVvd1ptuD9UmSP5eTJzd/lqjmNxcEn79ICXt/S
         BcmO4ybDzyS50d418FbZL/UbBbC+UlSLnbO0zW2CDYosGK4UE67f7T1PkqmdmOpewV
         f6v68HggM2zyaEDBDolh3GecsqUzg51TEzS7ybfLtduXbbKoQSpHFo9JB5nCIWBV6O
         XcWCan0yaHi+A==
Message-ID: <966523bee1d28d546969a24eff60d315.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230320161823.1424278-8-sergio.paracuellos@gmail.com>
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com> <20230320161823.1424278-8-sergio.paracuellos@gmail.com>
Subject: Re: [PATCH 07/10] mips: ralink: remove clock related function prototypes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 20 Mar 2023 12:38:53 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2023-03-20 09:18:20)
> Clock related code has been removed from 'arch/mips/ralink' folder and put
> into drivers space. Hence remove clock related prototypes which are not
> used anymore.
>=20
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  arch/mips/ralink/common.h | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
> index 87fc16751281..fcdfc9dc6210 100644
> --- a/arch/mips/ralink/common.h
> +++ b/arch/mips/ralink/common.h
> @@ -23,9 +23,6 @@ extern struct ralink_soc_info soc_info;
> =20
>  extern void ralink_of_remap(void);
> =20
> -extern void ralink_clk_init(void);

Why isn't this removed in the patch that removes the function?

> -extern void ralink_clk_add(const char *dev, unsigned long rate);
> -

Same comment.

>  extern void ralink_rst_init(void);
>
