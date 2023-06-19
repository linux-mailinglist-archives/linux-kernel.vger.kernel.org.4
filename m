Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09B273552F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjFSLCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjFSLBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:01:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7104719BA;
        Mon, 19 Jun 2023 04:00:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 010BA60BA2;
        Mon, 19 Jun 2023 11:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8866C433CB;
        Mon, 19 Jun 2023 11:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687172454;
        bh=P18pbPD6vuPCbw9QzcSrESz215K6BSQTQUGHn6iOUK4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Dwx8LFrJ7rLWMmUfb0tJSP7XvGxgFgEueH00zQOUnB8zJJeygOklU7wf0+ziYphoz
         MKN/FCzS+maQ/DBPLAFgYUDJYRTDZTMNGjT09piDXz5sZz0dNwqkIdLbQwdV/R6eRp
         7vjSv3vs8ucZPpx4aqmavUf4I6Nd29F4VNSStx7IptPnzDsEQA7cA/fh/snJRKpxej
         BaVFamiK+0CPq4DVcbS5zC75QNR8wHO8+hI7YEWtunUOTUZJjZQQHOQ2gSKSY9e4HG
         HoTS0hzmGCp0HEalcPO7VHsuAZEeopFZ59J/93qls9XXJpQr8m6fbPe2nZzJeaxGs6
         w+pua1pdkaFXQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
In-Reply-To: <20230619094705.51337-1-alexghiti@rivosinc.com>
References: <20230619094705.51337-1-alexghiti@rivosinc.com>
Date:   Mon, 19 Jun 2023 13:00:51 +0200
Message-ID: <87sfanbtss.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> This document describes the constraints and requirements of the early
> boot process in a RISC-V kernel.
>
> Szigned-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Additional 'z'; "Signed-off-by:"

Nice writeup!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
