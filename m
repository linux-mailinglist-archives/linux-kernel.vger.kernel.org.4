Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058E8615184
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiKASYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiKASYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:24:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7535FB3;
        Tue,  1 Nov 2022 11:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CC46B81ED5;
        Tue,  1 Nov 2022 18:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CE5C433C1;
        Tue,  1 Nov 2022 18:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667327042;
        bh=RiQ6hmbbDKjN56WMBDF9HbQKmD5/XSttT1qEH2JORhs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PSTYBS9dYSocLfmY0rWiiaYQ8qTfzDtJ/cnql25PRwBxf3452zzmkqVqjV5njGz9m
         l2+DCqfjdBBvdN+nVLUspAEEjGj4XA8rh7WT451pdcPINtO9he4YQ4MXjQhffXgq9B
         WUqRJpTs1w9LsyMBNvVgdXgjw6WDY5v+Vjzw/sTigI3SC5/NkOBGl2qXP/h/l92dbe
         T+mCEuLr/7B83/uwzFSJdYwZXtagJ9oxbMQJ0cagVNPZ0rSgYCCD56tL5yeZrZ5dLD
         M80fNCSiERSMa/9n/E4CA8xcH8rq6LuU68l4+GGf2aOzDOhn6TWfRLCFNDGuR1hCFd
         jDQg7NXpWl9vw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221030142333.31019-1-quic_shazhuss@quicinc.com>
References: <20221030142333.31019-1-quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v1] clk: qcom: gcc-sc8280xp: add cxo as parent for gcc_ufs_ref_clkref_clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bmasney@redhat.com, Shazad Hussain <quic_shazhuss@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Shazad Hussain <quic_shazhuss@quicinc.com>, andersson@kernel.org
Date:   Tue, 01 Nov 2022 11:23:59 -0700
User-Agent: alot/0.10
Message-Id: <20221101182402.32CE5C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shazad Hussain (2022-10-30 07:23:33)
> Since 'commit f3aa975e230e ("arm64: dts: qcom: sc8280xp: correct ref

So we should have a Fixes tag for this commit? Or really back to the
beginning of the driver?

> clock for ufs_mem_phy")' we need to explicitly make cxo as parent to
> gcc_ufs_ref_clkref_clk to have an independent vote from ufs_mem_phy.
>
