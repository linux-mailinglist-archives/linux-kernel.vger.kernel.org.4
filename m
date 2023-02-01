Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85FD6866FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjBANcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjBANcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:32:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0C565F15
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:31:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1760E6179C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 13:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD08C433D2;
        Wed,  1 Feb 2023 13:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675258292;
        bh=kd4WPoU9evsMcNwChABWzHebzvoWpWd1TGsGdrEabso=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dphgVWlyyQ9/+CiOzWhauSG/G8ZtT2bbsdsmOzFhqOnHb6+r2MLYtyx6yXq5sbogI
         qdMdIWx1dIhz23KxahTP765pqEi05kH8ELR2PsiHqRyFSqWh3iwaLO3fiTj3ImGmIZ
         eNaIIi/Q6rpKxkMYG9wvHmLvvGG3O/gz8RLX16rT34MF5BM+0MjVd6nZDgZoAimd3y
         nPIPqUobUSj7Pik3DP4F8thvdpKBiEyO1FHqwH6lQ/O+ffU9Y3Syf6LTsGAZfritNX
         YlkBJ2OjengnI3qRZdB55OrLXp6OcXBvgJ+mcWTaUxgpW41dluwldZxgMFMDs77l+5
         Zv7o4R9Y5OX8A==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v6 09/13] riscv/kprobe: Search free registers from
 unused caller-saved ones
In-Reply-To: <20230127130541.1250865-10-chenguokai17@mails.ucas.ac.cn>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
 <20230127130541.1250865-10-chenguokai17@mails.ucas.ac.cn>
Date:   Wed, 01 Feb 2023 14:31:30 +0100
Message-ID: <87pmattsul.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:

> This patch further allows optprobe to use caller-saved registers that
> is not used across the function being optimized as free registers.
>
> Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
> Co-developed-by: Liao Chang <liaochang1@huawei.com>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

Reported-by: should be used for fixes. Please change to Suggested-by:,
or simply remove.


Bj=C3=B6rn
