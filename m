Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81C36C3E42
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCUXFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCUXFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:05:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B88113F2;
        Tue, 21 Mar 2023 16:05:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94E9761ED0;
        Tue, 21 Mar 2023 23:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E0CC433D2;
        Tue, 21 Mar 2023 23:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679439902;
        bh=QRjAYUgIt13KpQxvYGuXrwOtuwnYCgLana+4NeHCu0g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UyJ6QzHkSxaMq+nZP7RzuK3LrikLv5LdqqC9C8CJhy3Q41I7Bis0uytG1iD27h1pa
         qq80LrOq43MDVOj4N+e3LzBqnVGmKLOloYMura2Fyo6EcPcK+b1JMYbuIH7wecysaz
         xSxlIb+FaWCv2D5rn4B/63btQIosc+20ePKNekU0LcASJAe9PcYrvnJqIh7E9wRkjj
         LXHqFlN/arvGpzuhpoPmwKsqXAjSxqancliHIWU425y2ZAHrm2iaSluA/yiPo+Q83Y
         N3ft+FFXeEaRfxuhisK6YrZu69D9YbUZhDqFnsLay4Rta/7S7KX7s0aGKLfxQM3OUS
         cvghZ94uZVdQg==
Message-ID: <2cafff47ba27fb712146019b6e283ab3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230321200031.1812026-1-mmyangfl@gmail.com>
References: <20230321200031.1812026-1-mmyangfl@gmail.com>
Subject: Re: [PATCH v6 0/6] Add CRG driver for Hi3798MV100 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     David Yang <mmyangfl@gmail.com>
Date:   Tue, 21 Mar 2023 16:04:59 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Yang (2023-03-21 13:00:21)
> This series adds CRG driver for Hi3798MV100 SoC.
>=20
> v2: move bindings to a separate patch
> v3: fix bindings commit message, reorganize patches
> v4: add ethernet and gpu clocks
> v5: add complex clock
> v6: migrate devm api

Some general comments. Typically we link to previous rounds with lore
links like
https://lore.kernel.org/r/message.id.of.previous.cover.letter

and also generate patches with `git format-patch --base` so we know what
baseline kernel version was used to develop on. And, please send your
emails To: something/somebody. Right now the To: header is empty, so it
looks like spam.
