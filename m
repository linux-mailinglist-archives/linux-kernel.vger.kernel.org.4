Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2EB6BA41A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 01:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCOAju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 20:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCOAjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 20:39:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E86755054;
        Tue, 14 Mar 2023 17:39:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C30E5B81C34;
        Wed, 15 Mar 2023 00:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D80FC433EF;
        Wed, 15 Mar 2023 00:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678840784;
        bh=QbdQK8fuMA0AQYd4R9yTEMkNUpAWMytrnBo8zpO8IkY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cNJQI8MZTYS6D+HbzEhZBJGz3I6HPnt7JP2A430h3R2uz9YzZongqBIt4o/p4m8wO
         fR6C26Ra7Psqgz85ywWQiRTUi07GxXAsM4CkW632wLAbwEl56rKwSpr2jVl81OGGDF
         9r0YCwRSDczTikGIeE7Dsna3K2zOk8A3LeMu/4rJw4wo0jDPKjAKfziflqukZtkP6O
         ZR6wyDZd5Bs0pc1HZ0GoOE/HvYTMggXRInhr+L7mREbxPTxlnKbPvGbwcHQxDQqb6s
         P1OVV4fKChhfhD6+bXLVrEQ7KCj3cOHy+QgeELrDcPUibCHBYzupr1WCknfb0wipc4
         0rIKdfyea3eiA==
Message-ID: <21d82a853f1a8be64349b0f94e8429cb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230310144701.1541504-1-robh@kernel.org>
References: <20230310144701.1541504-1-robh@kernel.org>
Subject: Re: [PATCH] clk: Use of_property_present() for testing DT property presence
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>, Rob Herring <robh@kernel.org>
Date:   Tue, 14 Mar 2023 17:39:42 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2023-03-10 06:47:01)
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
