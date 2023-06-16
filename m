Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63227338A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345353AbjFPS7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbjFPS7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:59:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4D64499;
        Fri, 16 Jun 2023 11:58:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E13862938;
        Fri, 16 Jun 2023 18:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61203C433C9;
        Fri, 16 Jun 2023 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686941906;
        bh=VOHpLEDV+8BIkjZXHrBZZ2UFV+UD+LSshDuMiTLdS7Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uihH+15p+0SPbRXmsa71eHDnZ5DTQCRJwbgIyt0sjtl814HoG/mCiriEoQoeZYjCw
         HUYVZ/jfuCvWU3WjIQjse6wo4tyU1YXuB/Scf32+Q+LJhLgPU+9qQmj6+As1B39Ryu
         /+Y+JOk3pKyS4qbJwWTgiKHHtl9V6XbAqXAA/PMpXaoPQU7RT8yR19wGGACoAWus69
         jZ8EFZeCjdMWRlxzJeTqmUEK2+VoxrIhuomitLJI/zZBDMAnYbk/KFKPqFPpkZfVwi
         bbstIAu8XkbAtWURr3ljGpNJ2G/E06u3wb5NjZmxfTr4BR6paf9gnB6HpFpjJoeunK
         UMJ92FZDcC0Kg==
Message-ID: <0ea8308998c8ceffd1b0564d25579077.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230516184626.154892-2-afd@ti.com>
References: <20230516184626.154892-1-afd@ti.com> <20230516184626.154892-2-afd@ti.com>
Subject: Re: [PATCH 2/2] dt-bindings: clock: ehrpwm: Remove unneeded syscon compatible
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>
To:     Andrew Davis <afd@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Date:   Fri, 16 Jun 2023 11:58:24 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Davis (2023-05-16 11:46:26)
> This node's register space is not accessed by any other node, which
> is the traditional use for the "syscon" hint. It looks to have been
> added here to make use of a Linux kernel helper syscon_node_to_regmap().
> The Linux driver now uses a more appropriate helper that does not
> require the hint, so let's remove it from the binding.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Applied to clk-next
