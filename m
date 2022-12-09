Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6CF647B40
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLIBTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiLIBTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:19:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8ECA84BF;
        Thu,  8 Dec 2022 17:19:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 415506200C;
        Fri,  9 Dec 2022 01:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BE0C433EF;
        Fri,  9 Dec 2022 01:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670548782;
        bh=y/JkA1z3j5ghb+0sq8CbfGQoFeR3nhwZAt4hqaZxAMM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=b1To0AP5faUnujcQjy6qc3OgbBl+hOHhovAIu08bSLzYWqKrz4Y+DbSo3KfaeRfAc
         62WDJxvbcZ3AaPlZ46KRbkLFoGlM6AR6nri3gq1med7Eeu28vl3hMZ6rayBrkGlxWL
         WML24tI1ghdBmUk4fwDArh767uGqC/UnyjjCEBJQLr3D/FLJAEawwlIeL1Yc4qr9nB
         vpImNJ8LAWw6V6wWX/w0kFCoAFVJq4LqJISDE5VlUKEWqUMuiMbjFKkTJlHtDm5e4F
         zv8nX7rav70r4fI+QtHxF6/FsyojUm7+QUi54ToiP9wDbN0ygUM4dbLFgFLb0xK0Kg
         Ihl+r9mDu1AVw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221120030257.531153-5-liambeguin@gmail.com>
References: <20221120030257.531153-1-liambeguin@gmail.com> <20221120030257.531153-5-liambeguin@gmail.com>
Subject: Re: [PATCH v1 4/4] clk: lmk04832: fix kernel-doc warnings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Liam Beguin <liambeguin@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 08 Dec 2022 17:19:40 -0800
User-Agent: alot/0.10
Message-Id: <20221209011942.93BE0C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liam Beguin (2022-11-19 19:02:57)
> Fix syntax generating the following kernel-doc warnings:
>=20
> drivers/clk/clk-lmk04832.c:189: warning: cannot understand function proto=
type: 'struct lmk04832_device_info '
> drivers/clk/clk-lmk04832.c:193: warning: Function parameter or member 'pi=
d' not described in 'lmk04832_device_info'
> drivers/clk/clk-lmk04832.c:193: warning: Function parameter or member 'ma=
skrev' not described in 'lmk04832_device_info'
> drivers/clk/clk-lmk04832.c:193: warning: Function parameter or member 'nu=
m_channels' not described in 'lmk04832_device_info'
> drivers/clk/clk-lmk04832.c:193: warning: Function parameter or member 'vc=
o0_range' not described in 'lmk04832_device_info'
> drivers/clk/clk-lmk04832.c:193: warning: Function parameter or member 'vc=
o1_range' not described in 'lmk04832_device_info'
> drivers/clk/clk-lmk04832.c:420: warning: No description found for return =
value of 'lmk04832_check_vco_ranges'
> drivers/clk/clk-lmk04832.c:459: warning: No description found for return =
value of 'lmk04832_calc_pll2_params'
>=20
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> ---

Applied to clk-next
