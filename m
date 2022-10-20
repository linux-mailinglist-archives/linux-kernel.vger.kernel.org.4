Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C6560562E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 05:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJTD6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 23:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJTD6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC971197FA2;
        Wed, 19 Oct 2022 20:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50D0661995;
        Thu, 20 Oct 2022 03:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47030C433C1;
        Thu, 20 Oct 2022 03:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666238321;
        bh=tZLEOSmLZX9fAjwEpzjOiiXPK8cCgzbSv+ofgqwpMjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpNkVYQ7zj1ggo48POKzGIxFc3C6BqZ7K0a/4IKbrEm/NbcPgtX68orL9nKLdueuz
         wR297dV/gmel1valM0nTLGZC5nC1ec5q8NNyF8r321gIJ3/W8JKGFxWRFKMIifC/+0
         8B93SV0m4THHI9hK4/wU0y+wnHJIKc1PwavtTRD7pjLkv0OUS4i4mcI1CLIh8N8p/o
         Nx4T+b9CeNhCuBO9+wsjjTFV0DhUcPg2CbTZIZ2vIqgtGjcCdqQrgKxAQLEAE3GBLU
         0GOCd7eJ1c6qWXY07/LO4NYGa0sskglW3OlAIcoWj2HEeCiQOTA4uD0sNDjPwb25d6
         ZMSceoXYCOiOA==
Date:   Wed, 19 Oct 2022 20:58:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 12/15] crypto: arm64/sm4 - add CE implementation for
 ESSIV mode
Message-ID: <Y1DHb66VYPzFlTwh@sol.localdomain>
References: <20221018071006.5717-1-tianjia.zhang@linux.alibaba.com>
 <20221018071006.5717-13-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018071006.5717-13-tianjia.zhang@linux.alibaba.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:10:03PM +0800, Tianjia Zhang wrote:
> This patch is a CE-optimized assembly implementation for ESSIV mode.
> The assembly part is realized by reusing the CBC mode.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Is there still a use case for CBC-ESSIV mode these days, now that everyone is
using XTS instead?

- Eric
