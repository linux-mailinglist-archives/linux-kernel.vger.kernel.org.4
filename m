Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719B2679543
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjAXKd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjAXKd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:33:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544AC14EB9;
        Tue, 24 Jan 2023 02:33:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C46EB810F7;
        Tue, 24 Jan 2023 10:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315F9C433D2;
        Tue, 24 Jan 2023 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674556432;
        bh=ELHb8ubmUl8vqwYtUA9K5pndEoWjAdp7rVDe3vq+R+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4KiO78zxPGC141R4QcTrnuhtpXMED7D0023G7ZBVMa+o1XNN/YOB3+wDcZZauyRA
         niPzn8ZjO9XTsNVtiEpWOC2XINbwP8VMVtAw7AnUZhJWiLHEfeXq1EVw0NTKgwW+pY
         jjrQmn8h1Olo0xj2Gv88cId1ewWVNyCJQJVuBv8EizquAk2nbfn6sLuxHWdlF7ra+T
         6L/1nbceuKJgNt0hAxKPzPNNBENj4cs7TJxm3shgmeC6xkcEt2hbHYBft3tucJeyJ4
         9pXjU02BH0yNKatzGrbNGUxeuyd2qA8cWvhb1z6iQTh/LuvelPXBirrkv00JTq5FXQ
         ymcDYU/2BCQXg==
Date:   Tue, 24 Jan 2023 10:33:46 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Davis <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] TI-Nspire cleanups
Message-ID: <Y8+0CuRQ/wNLQ/LE@google.com>
References: <20230123214924.27476-1-afd@ti.com>
 <f8922fbc-13cc-4f08-a8e8-08d39ab7d63c@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8922fbc-13cc-4f08-a8e8-08d39ab7d63c@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023, Arnd Bergmann wrote:

> On Mon, Jan 23, 2023, at 22:49, Andrew Davis wrote:
> > Hello all,
> >
> > This series is an extended version of the series started here[0]
> > and here[1].
> >
> > We break out what was the first patch into one for DTS change and
> > one for code changes as suggested by Krzysztof. Those are now patches
> > 2 and 8 of this series (I kept the ACKs, hope that is okay).
> >
> > As also pointed out by Krzysztof syscon nodes need a specific
> > compatible, add that as patch 1.
> >
> > While I was adding that, I noticed some other dtbs_check issues,
> > so while here fixed some of those up too (patches 3-6).
> 
> Looks all good to me, if there are no final comments within the
> next few days, can you send this all to:soc@kernel.org, either as
> separate patches or as two pull requests (dts and code) based
> on 6.2-rc-1?

Once the dt-bindings patch has been Acked by the DT maintainers, I'll
take this via MFD.

-- 
Lee Jones [李琼斯]
