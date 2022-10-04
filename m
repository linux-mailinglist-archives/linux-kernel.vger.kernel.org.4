Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC6A5F3BDD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 05:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJDDvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 23:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJDDvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:51:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B194320BFB;
        Mon,  3 Oct 2022 20:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5CDD61215;
        Tue,  4 Oct 2022 03:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F3EC433D6;
        Tue,  4 Oct 2022 03:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664855469;
        bh=ehU3pSePbzri0KePyWSjjBINxgWQpiYhH7V/OSm5Wng=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DxP8ve9dumPXSvnxKkAyDtoSsIbSkeCTYoXBZ9dFCJjXT2skD7D4TF6h7sVlsKkCT
         i37VjHqo/V9vPmMZPF2HTEYj6ECmIbg4nPRD6VHed67pQsqZBqhNEZds+t/zkKvkSC
         NCHIW1CHF0V00BTf0xiIkHSNZH5kCu4rAuGiLToIKDuMKKv71om5aphmVxuRfZUWa0
         5lzW07I/Z6XwJfGwn54S4+CsSdy5s7pz86UHkZYuYK9mqL7XVqBIklY7l6FTjnhYej
         kcm/R/ABfLZ6KYXCs+rYEhPcCVr/dEcqYITRcCHPEzftEpUcE8z+z5fIeR+UaSEB3u
         4IJVggGvyYFzg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220914144743.17369-1-ansuelsmth@gmail.com>
References: <20220914144743.17369-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 1/2] clk: introduce (devm_)hw_register_mux_parent_data_table API
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 03 Oct 2022 20:51:07 -0700
User-Agent: alot/0.10
Message-Id: <20221004035109.42F3EC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christian Marangi (2022-09-14 07:47:42)
> Introduce (devm_)hw_register_mux_parent_data_table new API. We have
> basic support for clk_register_mux using parent_data but we lack any API
> to provide a custom parent_map. Add these 2 new API to correctly handle
> these special configuration instead of using the generic
> __(devm_)clk_hw_register_mux API.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

Applied to clk-next
