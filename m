Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2AB5F1414
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiI3Urn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiI3Ura (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9941F8C32;
        Fri, 30 Sep 2022 13:47:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F38BB624E1;
        Fri, 30 Sep 2022 20:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F7FC433D7;
        Fri, 30 Sep 2022 20:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664570846;
        bh=1kBogdkDwdfzOTT9JxvRdfBm3gXj78ET9quOYxLRvKE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KRzdyt/o1YuEH170y8VW5ye7V6ZK13Z/hZZuZhmBHzyBIuvgJufIwR/FhRnoeX2dq
         OZGMneXa43Bv9XHwg3Eg4El/0kz0obG2XlhZbHUJQom2MBdMNlff0/Wk8J2rH/Bgtd
         9jajOaJtCPpUdUIFVCMtldir6p/PzWTTL+ynYSN/xfkoN0y/KtD4nEuwjry/D0uP23
         MLs2HZAMgxPn3PCsj+D6n9BUyF7L9l4hqqzGDDAUH/02wyGtf/+omQ239AdXjSyOL6
         rZBWghdBFPz2nvIudmoQ5E7ZLRlo4PG+9yxVJUtgV+nd9wIalbRiXCR/oEIFhWL5QL
         GmluJ1LAmmKQw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220913032228.985852-1-yangyingliang@huawei.com>
References: <20220913032228.985852-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] clk: davinci: cfgchip: Use dev_err_probe() helper
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     david@lechnology.com, nsekhar@ti.com, mturquette@baylibre.com
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Sep 2022 13:47:24 -0700
User-Agent: alot/0.10
Message-Id: <20220930204726.53F7FC433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yang Yingliang (2022-09-12 20:22:28)
> dev_err() can be replace with dev_err_probe() which will check if error
> code is -EPROBE_DEFER.
>=20
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Applied to clk-next
