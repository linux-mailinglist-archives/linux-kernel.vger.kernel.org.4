Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B7A5F124C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiI3TTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiI3TTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:19:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1852197F0E;
        Fri, 30 Sep 2022 12:19:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4678A623E4;
        Fri, 30 Sep 2022 19:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C378C433D6;
        Fri, 30 Sep 2022 19:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664565551;
        bh=DiN9MtLFNf7YLaifl0hJ3/nCg3eh+XZGECMBb0tbbF4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=axy2ncIrgnrwLGdExAo/xs92K0OQQXvy2pMf4G2pLhUIcCRECotdOSvR+o4FWhKXE
         WNoDiaUt+v0GtB4vsqU1p2k9fvnP1+7BUVevyqAwTHdmM4VI0kqtKq90zYDzeenCnv
         wI5ZxrSAyz7+sUh0c+W7pJ/OULO9zGqZ0tDU7bdn/PaG/F8KpG+ewvOKVu2NnD5pSv
         bRQPD0JDbiw8eh3mBHJkdvaktKeVuPkZjIblNP4oK6VDDRLEsXAM8b7ks/MTptrpAq
         RAtkgF3cPA9GnhKOhd+O6D+C+7Z+8IDe8OW6Idxe5hj3598yrzsNZFyxCNlXlkUeTZ
         sV1F0Zaulg+4Q==
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
Date:   Fri, 30 Sep 2022 12:19:09 -0700
User-Agent: alot/0.10
Message-Id: <20220930191911.9C378C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Acked-by: Stephen Boyd <sboyd@kernel.org>

or I'll pick it up after Bjorn sends qcom PR.
