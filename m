Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0D85F3705
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJCUZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJCUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:25:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6010327CFE;
        Mon,  3 Oct 2022 13:25:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61F59B815E5;
        Mon,  3 Oct 2022 20:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA711C433D6;
        Mon,  3 Oct 2022 20:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664828706;
        bh=4NLuDT/H+WxNDNlwsUz7xFPTxFbdPHBFa7xzgcGjtJk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NqNFD2YybHTQpC9f2ZUO15+hRR7OyjWSF7zbNIR07i26yo2dBKHonJLzfPuwox2fX
         t2cCcooKrFKe/G3cIeSgeML8qMW9saGE3ehoxOmtHbuwc1fpn8759cyfhKzy7ouFzG
         wGBddaj7pTQVSn7juK7xRUxf265iVaGRMVWS4aSqqTaRsyVI4dbrmlURl9hdZvHdB+
         43N9qluIF38MoKuXkR2AfHF0szvI4ospzSN18Bn93IreSEhlVwx9zLyuvL2PmIz5XR
         H/5QiXpj5jXvHKlv0uLNN3D8Ok60xAsTHvn61IxzX9edUKHKuSnIx7akrc57FxSpjr
         2IZRFq8F48SXw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220913031442.980720-1-yangyingliang@huawei.com>
References: <20220913031442.980720-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] clk: clocking-wizard: Use dev_err_probe() helper
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 03 Oct 2022 13:25:05 -0700
User-Agent: alot/0.10
Message-Id: <20221003202506.DA711C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yang Yingliang (2022-09-12 20:14:42)
> dev_err() can be replace with dev_err_probe() which will check if error
> code is -EPROBE_DEFER.
>=20
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Applied to clk-next
