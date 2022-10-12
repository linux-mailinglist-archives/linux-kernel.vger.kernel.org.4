Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F095FC84C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJLPVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJLPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:21:29 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101F7DD886;
        Wed, 12 Oct 2022 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1665588082;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=YIHasWTRuNMrnwJtbfmb3Tp7u61kv2WGbfpow4gG9/w=;
    b=Ylm3PXFWtnzC6bE9VBzHCPvyvKoVszSqWNSamPecx4chnPt6Am6g61FBnKwW+3E5OX
    scPD9Wjb3SnRygPoGAI0t1LoVF+Qw7sWHGkEIH5jjVqa3dv/m0aejlfrNVhENRd/D1fR
    mNicX5uBKl0SHRoFRaQEW//7gsOUMPfI4zzo0P9CgosKMBCDTt2eyG6rT2lGWWNtK+i/
    78fCz/MuYjtMnEggENzp0C4AeRBWrZBj5vEMvID5dFPrzyVz0TycnJUeVLUC/+OdQ38u
    EBNzLPjrc/ObDbR0CwqkI3Y6Z1+1zHE/tN+zj7ve0rQTLb+W+NpvZORqfbPJrHCIhDXP
    aOrw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaJfSfIdNJ"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 48.2.0 DYNA|AUTH)
    with ESMTPSA id za5fe3y9CFLLGJi
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 12 Oct 2022 17:21:21 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Eric Biggers <ebiggers@kernel.org>,
        Frederick Lawler <fred@cloudflare.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        kernel-team@cloudflare.com, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [RFC PATCH 1/1] crypto: af_alg - Support symmetric encryption via keyring keys
Date:   Wed, 12 Oct 2022 17:21:21 +0200
Message-ID: <6063928.z1iD19Vvxs@tauon.chronox.de>
In-Reply-To: <cc5c3efe-7dc3-65d6-d7d9-761bfc2c9711@cloudflare.com>
References: <20221004212927.1539105-1-fred@cloudflare.com> <Y0X3L/jhinCqJXxj@sol.localdomain> <cc5c3efe-7dc3-65d6-d7d9-761bfc2c9711@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 12. Oktober 2022, 16:49:56 CEST schrieb Frederick Lawler:

Hi Frederick,

> I believe I've addressed most of the feedback. Starting with we agree
> preferring key_serial_t. I changed to to use IS_REACHABLE(), and set
> ALG_SET_KEY_BY_KEY_SERIAL to 10 leaving a comment about libkcapi
> reserving values 7-9.

This reservation should not be observed. I provided patches for adding AF_ALG 
interfaces for KPP and AKCIPHER some time ago which were rejected. Libkcapi 
still contains the interface implementations but are not compiled by default. 

As the patches are rejected, their values should not be considered as 
relevant. Thus, I think your patch should not keep holes in the numbers.

Ciao
Stephan


