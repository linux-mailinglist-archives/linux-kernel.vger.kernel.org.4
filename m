Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7C25B6B57
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiIMKD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiIMKDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:03:16 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4005B7A0;
        Tue, 13 Sep 2022 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663063393; x=1694599393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CesIsMeSAuN11uLEEcY6nzqg44xgClKzHEqFMlpVQZ8=;
  b=lOF/crQ9hXjkgs8LXshm1r0gRQKPzpCKWoQcN523dW8yDEgnVAokIPEj
   9H4OfVNqNuU5cRfuB8JyuqCLBPmFM1RXAu7ymUUtsPnzdo3lTHnf63TUL
   VohfT0I6+GoRgZ+HIU9T18RmOg9muV65R666jRJQS7jtcB+IXcw7uuQ1g
   ZUAda/qX6IqTWLBQY6aJV8yVVa3lIVZDAMmclQjw/JDXLz1QJTToHG4Ib
   tjlr3iHJZx5mJOXRsNNLGaIOMGCQol94dZCiptbqqrLmzD4pqt9bQTn4B
   zvsQ2iVBk3lj2bzLmI5ZRuxGFS0gU+UeHHeY5s8Z4t4HLvC89fGFfziEK
   w==;
X-IronPort-AV: E=Sophos;i="5.93,312,1654552800"; 
   d="scan'208";a="26145945"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Sep 2022 12:03:10 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 13 Sep 2022 12:03:10 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 13 Sep 2022 12:03:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663063390; x=1694599390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CesIsMeSAuN11uLEEcY6nzqg44xgClKzHEqFMlpVQZ8=;
  b=ZPcis/4KD5e93wKAUZs+EVjX8hVaqzyKwfA/f444WkpnTykouIQoaH6K
   Bjc2N6Ki1FNOBWy4ODFOjXmM1rZhFBme2cSgQSAy5/ZJS+X+57WbsmDeO
   URyaHj+A0UhDzIpNSVdmUe/if0dSDtkIGH0J6NH3KOOPuafGKz0QZavAf
   5JqHeqoChiTFkPDqOuF4OCDci/wv+fGdUH6TsC0aTo6sne+TYBq2Q7WQc
   y5YwbTHJ0buGigNC+zD45sjdWXGrMsWnNwZME60XWBhsRB4kCqmiPeqQW
   W8IGEEzXxKnPEvD5hA7vO5KEQOYvHwDKf35NSP5J0N9PH0S+ybi9bCPcU
   A==;
X-IronPort-AV: E=Sophos;i="5.93,312,1654552800"; 
   d="scan'208";a="26145944"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Sep 2022 12:03:09 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 77509280056;
        Tue, 13 Sep 2022 12:03:09 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 0/2] clk: imx: introduce fsl,always-on-clocks
Date:   Tue, 13 Sep 2022 12:03:07 +0200
Message-ID: <13097869.uLZWGnKmhe@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220913092136.1706263-1-peng.fan@oss.nxp.com>
References: <20220913092136.1706263-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am Dienstag, 13. September 2022, 11:21:34 CEST schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
> 
> V3:
>  Rename to fsl,always-on-clocks
> 
> V2:
>  Use protected-clocks
>  https://lore.kernel.org/all/20220816130327.2987710-1-peng.fan@oss.nxp.com/
> 
> V1:
>  Use fsl,protected-clocks
>  https://lore.kernel.org/all/20220815033632.1687854-1-peng.fan@oss.nxp.com/
> 
> There are two cases that I wanna this property could serve:
> Virtualization: root cell linux run in parallel with inmate cell
> AMP: M7/4 runs in parallel with A53
> 
> The major case is:
> Jailhouse hypervisor only support partition, so devices are partitioned.
> But there is only CCM module that provides clock, the CCM is handled by
> root cell linux, need make sure the root cell linux not shutdown the
> clocks using by inmate cell.
> 
> I was thinking whether need to provide a rate entry to ask root cell
> configure the clk rate for inmate cell. But NXP downstream not have it,
> see
> https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/clk/imx/c
> lk-imx8mp.c?h=lf-5.15.y#n690 So just leave the property as uint32-array.
> 
> This patchset could also benifit AMP case, check the two commits
> commit 19565ea12d61 ("clk: imx: add mcore_booted module paratemter")
> commit d097cc045b64 ("clk: imx8mp: remove SYS PLL 1/2 clock gates")
> Although I not plan to drop the upper two patches, this patchset
> exposes opportunity for better power consumption.

Has this the same intention/effect as 'critical-clocks' from [1]? I guess in 
both cases you want to keep clocks enabled, even though there is no (local) 
user.

Best regards,
Alexander

[1] https://lore.kernel.org/linux-clk/20220517235919.200375-1-marex@denx.de/

> Peng Fan (2):
>   dt-bindings: clock: imx8m/imx93: introduce fsl,always-on-clocks
>     property
>   clk: imx: support fsl,always-on-clocks
> 
>  .../bindings/clock/imx8m-clock.yaml           |  4 ++++
>  .../bindings/clock/imx93-clock.yaml           |  4 ++++
>  drivers/clk/imx/clk-imx8mm.c                  |  2 ++
>  drivers/clk/imx/clk-imx8mn.c                  |  2 ++
>  drivers/clk/imx/clk-imx8mp.c                  |  2 ++
>  drivers/clk/imx/clk-imx8mq.c                  |  2 ++
>  drivers/clk/imx/clk.c                         | 21 +++++++++++++++++++
>  drivers/clk/imx/clk.h                         |  2 ++
>  8 files changed, 39 insertions(+)




