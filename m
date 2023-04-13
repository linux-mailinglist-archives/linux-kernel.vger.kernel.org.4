Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216FE6E14B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDMS5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDMS5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAA3211F;
        Thu, 13 Apr 2023 11:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF7EE640D3;
        Thu, 13 Apr 2023 18:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20531C433EF;
        Thu, 13 Apr 2023 18:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681412213;
        bh=UR21SnuIZMBQQnJcXzM5XSzqIBVio9J7W8EzLGxD1mo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=feRStNIa1VlFUDqzgb0UzPlch+AicEbc6yH6aSNHsBdTJYEgMv8e3LzQXtNkVojtf
         9guSyqr1LF2KIad3uwnPqGrySfRoNHK7KGPL63VVj8TIZ1zWan+XjY/mKj3ypsocxO
         OFn4aqZYFe7WQnlgjS5aD7tUrzuK19qJZ04rix7xHrqI7wQOmR+NYG8ia5lTxN/Hvw
         PP91IKxa3ecdTRWqZhiSg9Xi1lpw9PYmH2TJ9hC4UvhPFTKuJB7mxnxbVx7qgiaEt4
         kGt2qqh9EFTZY04rvpZ1tZdrY/YQS3NhO6egM8rzCaevq2MvBfwtOCuWYFxz+bNx9I
         EMgPAnAaeO2oA==
Message-ID: <d20a8910675be9acab3b2f4ac123fbf3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMhs-H-0Upz--k0tkm7BFCTd0b0Gso-c_uPyzeAjOigZowbK1Q@mail.gmail.com>
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com> <CAMhs-H-0Upz--k0tkm7BFCTd0b0Gso-c_uPyzeAjOigZowbK1Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] mips: ralink: add complete clock and reset driver for mtmips SoCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Date:   Thu, 13 Apr 2023 11:56:51 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2023-04-13 01:44:56)
>=20
> Gentle ping on this series :-)

Please trim replies. I had marked the whole series as superseded because
of the first patch discussions. I reviewed the clk driver now. In
general, use the fixed rate and fixed factor basic clk types. Don't
change hardware in recalc_rate().
