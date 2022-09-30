Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B005F01F5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiI3Axf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiI3AxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:53:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FC14150B;
        Thu, 29 Sep 2022 17:52:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3C83CCE23DF;
        Fri, 30 Sep 2022 00:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE49C433D6;
        Fri, 30 Sep 2022 00:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664499155;
        bh=G8ooWq9+eASigF6tCJNn6I5oAkUvcn+WF/utl7AK8AA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Z89BpygbqzFbORtprd6A7PPFg6AWlMIkEoU/pGYDml+vxdCjVfK5lVV7LsWl+AcQ8
         KFmiUEeoQq904QSyEQQi3WzpjwOePeSZxVBP7gxaDhzOqVG4nPMlNqku7MGZ8MNcq4
         8wmukZpY39LRHPyC8N7sSMs2qSiA2cxSZZbfKKIjz2bZYM0DJunDx6SOmL4OOzqok6
         RtHzm8ovNfh+FN+2HqKu7xluaVofasCiM+9B1rKLwCehBEZho2UlCGzN42bXFMtL+z
         wir8/CoJTXiBVaySrPkx1LZkS5ySbjiQ8uh0jTr4NgOeBDBzRTEJXplBT5xsQhDyL0
         FhDh1sVRp3iiw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YzVNZzp6+S7ePIRr@google.com>
References: <YzVNZzp6+S7ePIRr@google.com>
Subject: Re: [GIT PULL] MediaTek Clock Changes for 6.1
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 29 Sep 2022 17:52:33 -0700
User-Agent: alot/0.10
Message-Id: <20220930005235.6FE49C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2022-09-29 00:46:47)
> The following changes since commit 3cc53c57d0d54b7fc307879443d555c95b4665=
10:
>=20
>   clk: mediatek: mt8195: Add reset idx for USB/PCIe T-PHY (2022-08-31 18:=
16:45 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux.git tags/mtk=
-clk-for-6.1
>=20
> for you to fetch changes up to 99f3a5e851e9a1d82d73c4f396c6dbf123413c16:
>=20
>   clk: mediatek: mt8192: deduplicate parent clock lists (2022-09-29 12:27=
:33 +0800)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
