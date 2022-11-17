Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B845D62E530
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbiKQTZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiKQTZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:25:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0440DA4;
        Thu, 17 Nov 2022 11:25:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 35DDBCE1F2B;
        Thu, 17 Nov 2022 19:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B2FC433C1;
        Thu, 17 Nov 2022 19:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668713112;
        bh=uhIeKvgVfo1hBvIQHkhhEHq38wFUDZbWEAfYIe3i9oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HieVomyzsdbSRWx0U5g2pOBNo7nWzCg9lLGe83lZ0VPtF1/SWS60bHq1Ye6fEE5ly
         cIlTuGW9Qz/yncze5gw0YK74M4EXNP7YwDxdoYQ9eRVry+qlROKV+JyWzpdBPJMW6H
         pCIZAPHau6b+CfwjR56wgrZ60yxP6b+z+rKXwwb/7gYlyyg2kZezn1TbA5wWbX3mwQ
         6gh4ACyG4a24aja63+UVqlFNI1nWxCv7qp40JkJojqt2jjJsObABHH5sSmyIHmJpzf
         PgDiieO4PQJkLnbEkzyXIqpMq7dXWtQRBk+LODoYSuSOVcGioKZnWSXLkJ10tqQltt
         I/55MgDoT5S9A==
From:   Conor Dooley <conor@kernel.org>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] riscv: dts: microchip: remove pcie node from the sev kit
Date:   Thu, 17 Nov 2022 19:24:55 +0000
Message-Id: <166871307494.3905205.15646099439203275372.b4-ty@microchip.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221115152546.1425309-1-conor.dooley@microchip.com>
References: <20221115152546.1425309-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 15 Nov 2022 15:25:46 +0000, Conor Dooley wrote:
> The SEV kit reference design does not hook up the PCIe root port to the
> core complex including it is misleading.
> The entry is a re-use mistake - I was not aware of this when I moved
> the PCIe node out of mpfs.dtsi so that individual bistreams could
> connect it to different fics etc.
> 
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/2] riscv: dts: microchip: remove pcie node from the sev kit
      https://git.kernel.org/conor/c/1150f4cff831
[2/2] riscv: dts: microchip: remove unused pcie clocks
      https://git.kernel.org/conor/c/f4e700fd9466

Thanks,
Conor.
