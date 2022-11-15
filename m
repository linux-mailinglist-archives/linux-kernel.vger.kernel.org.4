Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71D0629CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKOOyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKOOyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:54:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C628F036;
        Tue, 15 Nov 2022 06:54:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBC8B617C8;
        Tue, 15 Nov 2022 14:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B70C433D6;
        Tue, 15 Nov 2022 14:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668524040;
        bh=fbIWojubXodIJ1FHKbRAX7quL96K4Jpg6lapDdJFksA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PQjJGWmL0WXWLPfPJHHsDuvs7hZXH9NJssREheNU4/psTZPYRnlBWfxLiVbex2uE5
         vwkSU7blMkcoWZSaSPpEkhbawCzgbEBAxFnQ2TXtXGzfKc64q2CRkK8z3y4k1iP+K+
         8WotE2zZ8Aky1+OGRudvK6M6oAZ1LRtcXMM4FIfnKMqaI3L1e9xzxUrvSMouPhS0Ur
         +y3mJ6kenxw3gGXJKzDl3y1BVU62xWHSg45Hjsn6G1jPDhw5iGxnhaaJftAR5xGRhY
         9lpqzBqeZIk3kuzrVF1vQxM1GluGyj5D8Rvyp0wB3VMPVvS9UdS2/uT00YD3da7l0v
         EFOZUKwmAlA9w==
Received: by mail-lf1-f49.google.com with SMTP id j4so24863255lfk.0;
        Tue, 15 Nov 2022 06:54:00 -0800 (PST)
X-Gm-Message-State: ANoB5plcY5Mnj7F3QvspUdLGs80gFq2N0TYS9fz1RkLo+nkeNCko5GfV
        mkKfiit8SEdsqsahrdeK/rFMdUwki7QyqGy+LA==
X-Google-Smtp-Source: AA0mqf7BFHKb3QwAbtjRBeUHg0VriQfG0v4tMZXxpjjvv7eArCZ9FE8KHaucdRBF0MiusQTrNzEeJUYN7kyPf32MgPo=
X-Received: by 2002:a05:6512:b1a:b0:4b0:3e46:2b75 with SMTP id
 w26-20020a0565120b1a00b004b03e462b75mr5540087lfu.368.1668524038181; Tue, 15
 Nov 2022 06:53:58 -0800 (PST)
MIME-Version: 1.0
References: <202211150903277271642@zte.com.cn>
In-Reply-To: <202211150903277271642@zte.com.cn>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Nov 2022 08:53:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLuWhQw52O4aWS=Z4T=0McjiPqtJMiFbvR-Rmwy3=+wBw@mail.gmail.com>
Message-ID: <CAL_JsqLuWhQw52O4aWS=Z4T=0McjiPqtJMiFbvR-Rmwy3=+wBw@mail.gmail.com>
Subject: Re: [PATCH linux-next] scripts/dtc: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
To:     guo.ziliang@zte.com.cn
Cc:     gustavoars@kernel.org, frowand.list@gmail.com,
        keescook@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 7:03 PM <guo.ziliang@zte.com.cn> wrote:
>
> From: guo ziliang <guo.ziliang@zte.com.cn>
>
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
>
> Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
> ---
>  scripts/dtc/libfdt/fdt.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Changes to dtc/libfdt must go upstream first and then we sync upstream
back to the kernel.
