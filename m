Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48926C3EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCUXrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCUXrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:47:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052F95709C;
        Tue, 21 Mar 2023 16:47:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8644261EE3;
        Tue, 21 Mar 2023 23:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20C5C433D2;
        Tue, 21 Mar 2023 23:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679442455;
        bh=Dueco9S6WPNbyt2iYcz2EyLFSTR3HIetRYyWH4Q6aIk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bUndYTbajsb4+QiWJFSlXKBL7wuuniI9RgFonPYQouhZ5TX3cQ/PlZSxmsmMZ3R1Z
         p/qGUS/GypjcFcqCVgBX8NIP6tV/sV0S0qqWQ/XUhZuFHPveTdBaBoDVm3wuS77Vpk
         RhsigtddEjFWcKVRJXUHAMuBR9YuXG5ZncXrYT6q3J29iL+0X2XfGR6eI6qK4JEgep
         8itRF+E+9+qSyPFtJpG15SQbNK94lOJje6+AKhNSeGE9MbjZ5857/hBA8ueowDgE38
         1fqmhrkNOVi9UEwTq/EdOLkt/GygdptzcNxJ5KGGXWXcnrNBP84hi7TTq8+VbVUNWT
         jjMHqOhrIWEiA==
Message-ID: <cf42169cfd04c5cee84fb14e1824666f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221209152913.1335068-1-marpagan@redhat.com>
References: <20221209152913.1335068-1-marpagan@redhat.com>
Subject: Re: [PATCH 0/6] clk: socfpga: use of_clk_add_hw_provider and improve error handling
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 21 Mar 2023 16:47:33 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marco Pagani (2022-12-09 07:29:07)
> This patch set improves error handling and replaces the deprecated
> of_clk_add_provider() function with of_clk_add_hw_provider() in the
> Intel SoC-FPGA family clock drivers.
>=20
> The patch set is based on top of the patch: "Fix memory leak in
> socfpga_gate_init()" to avoid a conflict.
>=20
> https://lore.kernel.org/all/20221123031622.63171-1-xiujianfeng@huawei.com/

I was waiting for Dinh to review this. I guess that won't happen so I'll
just go apply this.
