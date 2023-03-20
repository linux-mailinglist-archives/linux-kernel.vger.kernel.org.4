Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574C06C1205
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjCTMjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCTMjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:39:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60912D48;
        Mon, 20 Mar 2023 05:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CFA0614AE;
        Mon, 20 Mar 2023 12:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE693C433EF;
        Mon, 20 Mar 2023 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679315958;
        bh=4XG5NumHQKLf7FXfSZYEUp83adPFqOHQkgN7kVusg2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZ4FwmPJRa87abfQt+BW5QGgP2z4Fn9mlFEqZdMmW7gioonSgMDl34Vn2nFf1FcRJ
         eHqbSNDDbWVk/8f50Zsf1ijUinjooB9Pngpmc1lUjg1c1osv6iuaTDzuADL0tRbQuJ
         +7Hrwx2TKF9vmLBaWdzR7B43dxl7w7kagGNtKyXIUDfzPoKZNg5u0I0TINRkb6Oo3K
         eWweZDcup8tHiets3d3n3NzNHbaXhFk0HE7MJGJzJWG1fpis5UE+bqNGy+s744LsNX
         PSCaUz0mz5S4nM2QbvyxsXULT1ehPK+4LG6jNqT69HUht2QDShQbCiVDs+Uaj9soIb
         uHc7PTATmHIYg==
Date:   Mon, 20 Mar 2023 18:09:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Add JH7110 MIPI DPHY RX support
Message-ID: <ZBhT8tpBhdFugurm@matsya>
References: <20230223015952.201841-1-changhuang.liang@starfivetech.com>
 <7e525c7d-d534-adba-4aea-a485ba37bcc7@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e525c7d-d534-adba-4aea-a485ba37bcc7@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-03-23, 14:05, Changhuang Liang wrote:
> 
> 
> On 2023/2/23 9:59, Changhuang Liang wrote:
> > This patchset adds mipi dphy rx driver for the StarFive JH7110 SoC.
> > It is used to transfer CSI camera data. The series has been tested on
> > the VisionFive 2 board.
> > 
> > This patchset should be applied after the patchset [1] and patch [2]:
> > [1] https://lore.kernel.org/all/20230221083323.302471-1-xingyu.wu@starfivetech.com/
> > [2] https://lore.kernel.org/all/20230215113249.47727-4-william.qiu@starfivetech.com/
> > 
> Hi, Vinod and Kishon
> 
> Could you please help to review and give me some suggestions
> for this patch series? Thank you for your time.

There are already comments on dt-binding, please address them!

> 
> Best regards,
> Changhuang

-- 
~Vinod
