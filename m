Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BF864637A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLGVth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiLGVtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:49:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0BE84DE4;
        Wed,  7 Dec 2022 13:48:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0CE5B8216E;
        Wed,  7 Dec 2022 21:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74030C433D7;
        Wed,  7 Dec 2022 21:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670449734;
        bh=5dCNbmox6waUeuX2Iir4OK5SdTorc7GU4B8l9qRHQWQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vIYh4Har7Mb8hxyOkjyXUxLcj2ioKv8LNilKJqHb2rNIcREFqI9CBb5Ya5smNOJ0S
         Bn7Y/u6vdr+V5UAGtGXPRS73IBztInR4k7P+hdWcejUTpZPNk2/qyxOklRkxKpS18Y
         gIR9qEYDgN8JtNkPOc2N+yRdxBAqNmW8LNNkRuU7vqGopEwRuTN0HUYN/qlq7QuWAI
         2hwc7Nzg2f7CbnvSF0AGs8BS6xOsg4lrAjafBp7c2SAcdjMFEpC29lN+hzlSv2FwEN
         48yYrCbRgAknQg7VqPpEq7mfcMSC2DK/FZ+Dxjcq12G8ek1AzuizNfEepN91Kjb4vx
         Kv2apagmDsBYA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221018-clk-rate-request-tracing-v2-2-5170b363c413@cerno.tech>
References: <20221018-clk-rate-request-tracing-v2-0-5170b363c413@cerno.tech> <20221018-clk-rate-request-tracing-v2-2-5170b363c413@cerno.tech>
Subject: Re: [PATCH v2 2/2] clk: Add trace events for rate requests
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Steven Rostedt <rostedt@goodmis.org>, maxime@cerno.tech
Date:   Wed, 07 Dec 2022 13:48:52 -0800
User-Agent: alot/0.10
Message-Id: <20221207214854.74030C433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting maxime@cerno.tech (2022-10-26 06:46:59)
> It is currently fairly difficult to follow what clk_rate_request are
> issued, and how they have been modified once done.
>=20
> Indeed, there's multiple paths that can be taken, some functions are
> recursive and will just forward the request to its parent, etc.
>=20
> Adding a lot of debug prints is just not very convenient, so let's add
> trace events for the clock requests, one before they are submitted and
> one after they are returned.
>=20
> That way we can simply toggle the tracing on without modifying the
> kernel code and without affecting performances or the kernel logs too
> much.
>=20
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
