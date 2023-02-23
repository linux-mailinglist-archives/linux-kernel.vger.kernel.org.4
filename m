Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF22E6A0FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjBWTAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjBWTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:00:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783DE38EB8;
        Thu, 23 Feb 2023 11:00:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1601FB81ADA;
        Thu, 23 Feb 2023 19:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D242C433EF;
        Thu, 23 Feb 2023 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677178848;
        bh=o+9OUCJEUF/e/DNRPCuGj5G4gOxfD6JOcy8ro1x4DlY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UOl6KisagTexv6cBiOuPq+pi7uj8GUp0CMkJdMz/aub/RrKd7vvV4by8Q87gAJ6Vz
         zFSJlSl6+41PSZ0xee5k+G/wjEfrbyzwTxuQNODrrm5v5pZwE3F1XZBI/1Fqp6Mu2x
         HbHJdjJnsu+vTNfKjARXvNhIudRJJIfgW07ykrC7B3N2TeACHjj1sZUmav31/d6r46
         TPQgLt8Vl2bsZq+C2rnEUEtjPzphmFyIge1T7IgFGPind3u5UXiapHNXrrp3+dhyRi
         1jmKES6DzpSKNfZhCv2HLIrveybXxKaL5AljE6qhcSmRIKT5purGAC0GDS9eBS86Hg
         2RO4yhQdQsijg==
Message-ID: <9e408dc917cbbc08d68c7a3195c12484.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230223013847.1218900-1-sboyd@kernel.org>
References: <20230223013847.1218900-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: qcom: apcs-msm8986: Include bitfield.h for FIELD_PREP
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 23 Feb 2023 11:00:46 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2023-02-22 17:38:47)
> Otherwise some configurations fail.
>=20
> Fixes: 027726365906 ("clk: qcom: add the driver for the MSM8996 APCS cloc=
ks")
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
