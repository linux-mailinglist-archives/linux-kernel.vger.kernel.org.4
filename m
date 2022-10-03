Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA41F5F3654
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJCTcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJCTcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:32:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F12230565;
        Mon,  3 Oct 2022 12:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C381611AA;
        Mon,  3 Oct 2022 19:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748B8C433D6;
        Mon,  3 Oct 2022 19:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664825558;
        bh=MAtg7jDIDFO35CN+8Gz4aSXHpYT+vFmA/qwTbN35zxs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TfagG6Q0/LUDJa2smU0DUyNLU0O3D0KiaK/b0WexBMUdOKQ1mMjZvBzhjmwleljyE
         AmgT0DUcY497aryhqUgKLY5Q7f7GzL6gjrghL6FI3AruPqmBFVpu9gwSM7jnLJC4In
         IFgCHvv3zJKfYW04b4zA3Nn0TgyTyiOrT2/oXI4ArFEjjX5mFy6G6+HSjbfsldYgYz
         lCJ9g19I/oRgp44naRPPMRwBf8ppUJlPjC7oSQB9tQkJ3XlcXIvuRsNehaovIHQKnk
         8JlJm3mNlJZLg+cwhQW6Q+ovzD+qlRA/o46CvJLjKpL5PNJ5bnNOKIRUM3WsEPSjd/
         ves7P0z7/OLWw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <tencent_2B9817738F38B02844C245946EFF3B407E09@qq.com>
References: <tencent_2B9817738F38B02844C245946EFF3B407E09@qq.com>
Subject: Re: [PATCH v2] clk: pxa: add a check for the return value of kzalloc()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
To:     mturquette@baylibre.com, xkernel.wang@foxmail.com
Date:   Mon, 03 Oct 2022 12:32:36 -0700
User-Agent: alot/0.10
Message-Id: <20221003193238.748B8C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting xkernel.wang@foxmail.com (2022-04-07 02:33:49)
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
>=20
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to check it to
> prevent potential wrong memory access.
>=20
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---

Applied to clk-next
