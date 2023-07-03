Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF7745514
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGCFwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjGCFws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:52:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BDEBC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:52:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZp61c54z4wqZ;
        Mon,  3 Jul 2023 15:52:46 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230609182926.1763589-1-robh@kernel.org>
References: <20230609182926.1763589-1-robh@kernel.org>
Subject: Re: [PATCH] macintosh: Use of_property_read_reg() to parse "reg"
Message-Id: <168836201902.50010.13752927342697965130.b4-ty@ellerman.id.au>
Date:   Mon, 03 Jul 2023 15:26:59 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023 12:29:25 -0600, Rob Herring wrote:
> Use the recently added of_property_read_reg() helper to get the
> untranslated "reg" address value.
> 
> 

Applied to powerpc/next.

[1/1] macintosh: Use of_property_read_reg() to parse "reg"
      https://git.kernel.org/powerpc/c/6f3bdbbeafbbcb1a6540307e4eaee10ecae4f9a5

cheers
