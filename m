Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101BE6FFA1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbjEKTZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbjEKTZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291F67DBF;
        Thu, 11 May 2023 12:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE531639CC;
        Thu, 11 May 2023 19:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBFFC433EF;
        Thu, 11 May 2023 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683833109;
        bh=y/0OoYatmFHPp5Ma0BwB2mBixbDjxt7J7Ig6y1F9nw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6nvDAk+2u7LCFD0Q+y+rdsx6+U6A1UHZ4oYnzmHy6+3I/MH8bXrIpUifRxcej4r0
         AUiMrhzx9zEeT9DA0+crjKtbQKIhEal5SDtLZ26tz4N8GJoNeUNiuE1+va/LpUXX5n
         b8NsStma0ut3f1+LXOqlUStvuexn3LJp94y0rA3Z1+pfs86cxGTgQWy4LNljCFUjLb
         Fnk2PJNYfDeyzTCrJVYUCOA8oGEpOOdUt1QqI2te9QMuxU3HgyEt352PaEGXtAiryT
         waZyhODVPMex6yWnR08hoDQup8S9/pMNxJ4fRxpbc2kQHFeyJuo39z6na+CzR/wIZW
         TrhGS9DoWRJEA==
Date:   Thu, 11 May 2023 20:25:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefank@nvidia.com
Subject: Re: [PATCH v4 5/6] dt-bindings: Add support for tegra186-bpmp DRAM
 MRQ GSCs
Message-ID: <20230511-overcrowd-puzzling-5c588d276158@spud>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-6-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dExVlHaTJTfKF/f9"
Content-Disposition: inline
In-Reply-To: <20230511132048.1122075-6-pdeschrijver@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dExVlHaTJTfKF/f9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 11, 2023 at 04:20:50PM +0300, Peter De Schrijver wrote:

> +    bpmp {
> +        compatible = "nvidia,tegra186-bpmp";
> +        interconnects = <&mc TEGRA186_MEMORY_CLIENT_BPMPR &emc>,
> +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPW &emc>,
> +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAR &emc>,
> +                        <&mc TEGRA186_MEMORY_CLIENT_BPMPDMAW &emc>;
> +        interconnect-names = "read", "write", "dma-mem", "dma-write";
> +        mboxes = <&hsp_top1 TEGRA_HSP_MBOX_TYPE_DB
> +                            TEGRA_HSP_DB_MASTER_BPMP>;

FWIW, this fits on one line - although you've just copy-pasted what was
already there in the other example.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


--dExVlHaTJTfKF/f9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF1BEAAKCRB4tDGHoIJi
0l/OAQDrOsbSFzBKvgPvjho0xJQUKaPLSTofvc6P8KB3HCIDUgEApWO5u+zl5nPW
xP1fytR5QKiCMZEpohFyfoxmpCWxRQE=
=wqSg
-----END PGP SIGNATURE-----

--dExVlHaTJTfKF/f9--
