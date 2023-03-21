Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078096C3E95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCUXf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjCUXf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:35:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE0E4D291;
        Tue, 21 Mar 2023 16:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4692061ED2;
        Tue, 21 Mar 2023 23:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF01C433D2;
        Tue, 21 Mar 2023 23:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679441718;
        bh=la84fR21p6BkrAgYSHC0TlI4voKp0tvsxTcIWMyXByc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fxZoYEY9ikSfQ9HBAPTYX0eEPLJ6X5ZvfIae5OIsik+/Sq51snrbQceb9hDETif4f
         ryJXut/pInboEwqqbejedBA94Q0ZmraZxuHvkeMU+/F7L6IUtUjhA+29LCuUzNExq/
         t5hsDjS5oJL6/nqktIdELca1PWHU+FJjE2zezcHHmhkaBQS0qkyZ94i1cmA711Apxz
         zJQioymcaCXxNcLgniBhwOT0WeNcpxOUvU7uR9VuHuiMlXjhuTkOsiEadT8B/+4qQD
         NOEWljMO4qS5/DTiWXNRRlb05FtPn5UnKFJD7ugo4ucMFwZ2HqEsKhTlxBVx88tEdT
         gGKFCOvEF37Tw==
Message-ID: <0ab905641f5bb8515467b46f4bbb740a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230321111817.71756-3-keguang.zhang@gmail.com>
References: <20230321111817.71756-1-keguang.zhang@gmail.com> <20230321111817.71756-3-keguang.zhang@gmail.com>
Subject: Re: [PATCH v5 2/4] clk: loongson1: Remove the outdated driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Date:   Tue, 21 Mar 2023 16:35:16 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Keguang Zhang (2023-03-21 04:18:15)
> Remove the outdated driver due to the following aspects.
> - no DT support
> - duplicate code across LS1B and LS1C
> - does not fit into the current clock framework
>=20
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---

Applied to clk-next
