Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3D272A836
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjFJCO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjFJCOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:14:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F6C35A9;
        Fri,  9 Jun 2023 19:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 298BB63C58;
        Sat, 10 Jun 2023 02:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB02C433D2;
        Sat, 10 Jun 2023 02:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686363292;
        bh=Ud+eEivIcnu7J9J5nBUGtGRWTzlzjz0B2BcKWne/ues=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mKHYPpgIX1YTbNSfiw5A8f90UWlgWb7/IZVKZG+ABIYeb0KpqSLo9v8Vyupgb1Cfo
         5PIBdSN09SlwRgnVzJFjq9axGkX9gGs34Ahgo9X2NtViYiPBbJ7Vr8Gx2zHQZhMpFV
         t+QO8Jpf+5t9GfUoBfsreQQSHhGjJ30Z0WyxKdTdB7TUGmYE18TG0MAFvfgM/QqSp4
         8mK0dhCy8VIz2iPrsdWAkTSn0Vj/XYd2wQMRvThVzG41AnwoTTpDX2ILBKru1KdQwh
         jqDvO+LVYMbEVtoJ9WcOTrJ52ONIuDWoXrPrKWM2+I+6oBBXvTicEbtQAFkGSHd8ko
         gWTn0I5xx9UiQ==
Date:   Fri, 9 Jun 2023 19:14:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dongsoo Lee <letrhee@nsr.re.kr>
Cc:     'Herbert Xu' <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, letrhee@gmail.com
Subject: Re: [PATCH v2 0/2] crypto: LEA block cipher implementation
Message-ID: <20230610021450.GA872@sol.localdomain>
References: <20230525121301.722682-1-letrhee@nsr.re.kr>
 <ZHh1H3yKPU68J7Uv@gondor.apana.org.au>
 <008d01d99518$33db63f0$9b922bd0$@nsr.re.kr>
 <20230602213946.GD628@quark.localdomain>
 <005601d99ac9$954f0c70$bfed2550$@nsr.re.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005601d99ac9$954f0c70$bfed2550$@nsr.re.kr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 08:57:36PM +0900, Dongsoo Lee wrote:
> Unfortunately, currently, vendors trying to supply Linux-based data-at-rest
> encryption products by utilizing the dm-crypt or the fscrypt modules to
> government agencies or public institutions in Korea are experiencing great
> difficulties.

Why are they having "great difficulties" when the kernel already supports two
other "KCMVP-approved block ciphers", ARIA and SEED?  Why aren't they using
dm-crypt with ARIA or SEED?

> According to Korean regulations, the data transmitted and stored by
> government agencies and public institutions must be protected using KCMVP
> validated cryptographic modules.

And does LEA (or SEED or ARIA) support in Linux actually solve that problem?
Just adding support for these algorithms to Linux does not mean that Linux
automatically becomes a "KCMVP validated cryptographic module", right?  Do you
have a complete plan that would actually solve the claimed problem?

- Eric
