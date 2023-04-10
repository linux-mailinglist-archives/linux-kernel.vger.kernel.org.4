Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708B86DCE54
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjDJX7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjDJX7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0701BE7;
        Mon, 10 Apr 2023 16:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AEF16201F;
        Mon, 10 Apr 2023 23:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B11C433EF;
        Mon, 10 Apr 2023 23:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681171170;
        bh=JVXtANLCoXKH4bGk9XkI7snII9iDxlueE91bJgDTERM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=k6A7+qy1kZ+Sfd2025/ayUX8uj9rh0rS6djSM6jD5ilFLdGQ1kACZvpNWq0UWh7jQ
         ZGGmcdbzYYd0qFPIyUkySlNe2M3YlFPPRYZp7yyFwfPUSXVNArr0pshgN77ZrMrSSi
         6YJVthmIfXDPBQXnWlTh1Ti+2S8gWaKjvPYd7/RsO3Y74IF5//1wt9XmaUwG4i/oBz
         hnxC+cT24qIHDjzJHAWs8ZGtzdGp0K0EzTEoU0Tmz+LQMO3OMeNb/eAZSIEBQqHtve
         yvzYtpvLGl0MegvHkh8vxuctEb919+dCkd0NlB3OcBEUvqL416KjvgLyJfRwPcLRd5
         pfn5oUKxVy/qQ==
Message-ID: <502bacd2b6b0f448106d82b2d8c5c9d4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230406010935.1944976-1-trix@redhat.com>
References: <20230406010935.1944976-1-trix@redhat.com>
Subject: Re: [PATCH] clk: mediatek: fhctl: set varaiables fhctl_offset_v1,2 storage-class-specifier to static
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Tom Rix <trix@redhat.com>
To:     Tom Rix <trix@redhat.com>, angelogioacchino.delregno@collabora.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        matthias.bgg@gmail.com, mturquette@baylibre.com, wenst@chromium.org
Date:   Mon, 10 Apr 2023 16:59:28 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tom Rix (2023-04-05 18:09:35)
> smatch reports
> drivers/clk/mediatek/clk-fhctl.c:17:27: warning: symbol
>   'fhctl_offset_v1' was not declared. Should it be static?
> drivers/clk/mediatek/clk-fhctl.c:30:27: warning: symbol
>   'fhctl_offset_v2' was not declared. Should it be static?
>=20
> These variables are only used in one file so should be static.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Applied to clk-next
