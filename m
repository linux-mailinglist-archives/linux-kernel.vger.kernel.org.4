Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FD15ECC2E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiI0SeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiI0Sd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:33:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0841B8CA4;
        Tue, 27 Sep 2022 11:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31193B81D36;
        Tue, 27 Sep 2022 18:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9909C433D7;
        Tue, 27 Sep 2022 18:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664303636;
        bh=p88RSSMmSULebAyngf3hc6AaDM4Hg67OZpKwETod/JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzAHVK2Al7ph1LUauN9QbFsX5mqgFWIUCZYAFZWoQAlBU343bPfyeRDVXOWvsY1U2
         nSK6Gnfwz85W8wxOJMoWFbI9mF3C13ZLF6LgDzs2iv+t5doQPwDW4FJLHSszZaX2Or
         LBqPyekmnxoA6QqG2nwcDoz5c5nI0A27wlLX6jAkawLmIHwEUvKhb0MCYyUfzy8RNj
         35k2XxUMmVc3aCsY/Av4VnWXBUb6pQo0Yoi4RHhKVqgihgcdv+nga96FWnGCPxHbpg
         ckHjXHdagq1GdH7xInqsaXrMu/RHJIl3VmYxgnNKebif4SsAWwyE3H5xsg2Dvhw/fP
         pxmZB5Xbg80fw==
From:   Conor Dooley <conor@kernel.org>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        devicetree@vger.kernel.org, Cyril Jean <Cyril.Jean@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        Lewis Hanly <lewis.hanly@microchip.com>
Subject: Re: [PATCH v6 00/11] New PolarFire SoC devkit devicetrees & 22.09 reference design updates
Date:   Tue, 27 Sep 2022 19:33:32 +0100
Message-Id: <166430333467.135094.14015061795483453798.b4-ty@microchip.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927111922.3602838-1-conor.dooley@microchip.com>
References: <20220927111922.3602838-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 27 Sep 2022 12:19:12 +0100, Conor Dooley wrote:
> Resending with an extra patch making some more memory map changes that
> are to be introduced in the v2022.10 reference design. Since the
> v2022.10 and v2022.09 reference designs both indepedently break
> backwards compat, v2022.09 is not compatible with <= v2022.05 and
> v2022.10 is not compatible with v2022.09, I am doing the jump directly
> to v2022.10 rather than putting an intermediate step at v2022.09.
> 
> [...]

Applied to dt-for-next (in place of v5). As I pointed out earlier, I
will not make a PR for this until the reference design is available
on the PolarFire SoC GitHub.

[01/11] dt-bindings: riscv: microchip: document icicle reference design
        https://git.kernel.org/conor/c/a0d49a8f77f2
[02/11] dt-bindings: riscv: microchip: document the aries m100pfsevp
        https://git.kernel.org/conor/c/0ebdc51787db
[03/11] dt-bindings: riscv: microchip: document the sev kit
        https://git.kernel.org/conor/c/db3d481698ef
[04/11] riscv: dts: microchip: add pci dma ranges for the icicle kit
        https://git.kernel.org/conor/c/f890e67f292d
[05/11] riscv: dts: microchip: move the mpfs' pci node to -fabric.dtsi
        https://git.kernel.org/conor/c/99d451a7db16
[06/11] riscv: dts: microchip: icicle: update pci address properties
        https://git.kernel.org/conor/c/6fc655ed4986
[07/11] riscv: dts: microchip: icicle: re-jig fabric peripheral addresses
        https://git.kernel.org/conor/c/ab291621a8b8
[08/11] riscv: dts: microchip: reduce the fic3 clock rate
        https://git.kernel.org/conor/c/fa52935abef4
[09/11] riscv: dts: microchip: add sevkit device tree
        https://git.kernel.org/conor/c/978a17d1a688
[10/11] riscv: dts: microchip: add a devicetree for aries' m100pfsevp
        https://git.kernel.org/conor/c/d49166646e44
[11/11] riscv: dts: microchip: update memory configuration for v2022.10
        https://git.kernel.org/conor/c/6c1193301791

Thanks,
Conor.
