Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F9A6BA411
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 01:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCOAaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 20:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCOAaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 20:30:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB665293E;
        Tue, 14 Mar 2023 17:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCDD7B81C1F;
        Wed, 15 Mar 2023 00:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802D2C4339B;
        Wed, 15 Mar 2023 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678840219;
        bh=vyxKtWor1GgdsppazI1GKwisemf4cHbxxelfecejTFc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NwFgn7no1SNf9/Rt1sFsLJD1oT/5V7FTSVvRdgb++JWqbm2PG4XvNrrV9gburbViy
         4op48ZM4uRZWCc3BkufMBigumIFPwvlP7dtGsocEqafLnRqsNj+uun79AUOORXhVSr
         YN3Sd0LliOZfItxXUXo8DzJNaTuUEjdHEixB9gjOZGrDq7aLZhzoqoCqM5CCOZ7PZe
         9RckPqB/fDqIMgUFNJ54NSrsJpt3ggxHxgCbgSe74NJJHoeZPT9GOfDbB5sfMx83Ya
         a6vOrLjsDh7xTE2YcGSf4ORT8PKBJrTpiatDjqtUyX60EL8vn1veekMgsWHGtF5WtZ
         Keem5xeyl8Z3Q==
Message-ID: <de14f63beb2b3e424ec2375187c8087f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230314124404.117592-1-xingyu.wu@starfivetech.com>
References: <20230314124404.117592-1-xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v3 00/11] Add new partial clock and reset drivers for StarFive JH7110
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Tue, 14 Mar 2023 17:30:17 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xingyu Wu (2023-03-14 05:43:53)
> This patch serises are to add new partial clock drivers and reset
> supports about System-Top-Group(STG), Image-Signal-Process(ISP)
> and Video-Output(VOUT) for the StarFive JH7110 RISC-V SoC.

What is your merge plan for this series? Did you intend for clk tree to
take the majority of patches? We won't take the dts changes through the
clk tree.

I think Philipp Zabel reviewed some earlier version of the patches and
provided reviewed-by tags. Can you check if they can be added here? If
so, please resend again, or get those merged through the reset tree.
