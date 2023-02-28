Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9AC6A5FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjB1TlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjB1TlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:41:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4911499A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:41:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F098BCE19FF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F063C433D2;
        Tue, 28 Feb 2023 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677613265;
        bh=30kPHMTvf9IF3XE2xLeD5hW+gxkyjy3HKdW7y5ZQaAE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=vJXU+9iK9fRWPssxiKgTLPyYfCohny+8DPpXHTDpRCiGHcwv6TP8m+aI97Hq8OYNy
         spEO9O0HKPuh8VwxGiTTEK7dfHCmeHDMH/gkox7ltHzv58BzvaWiumP1C7D7NrbGO+
         60FYa8rzNkVuMvGFXeHmfjwgwdXtf0GLNSWu/L6b2J8MBVGXP7ffP8YnSrT5i+3Fmk
         3zk2d0r/kp2bhTTNrf8Fd2RMloxcnX6PLGpzLETp798Aww3127UuKTOOeRCr+vQH7h
         nj77UqAf8XSX4YUuqZ6J5X5rNv82xfPZ/6lUp1Cr80/8DPXgo1MsEHdnYUjt8Y/cNE
         BohuTvKFXfvyQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Andy Shevchenko <andy@kernel.org>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/2] lib/test_string.c: Make definition less dense
In-Reply-To: <CAHp75VfK3RM+SP90d3nOXEobY81Xd_94tLL=Qt86mmdNwXaQpg@mail.gmail.com>
References: <20230228184245.1585775-1-bjorn@kernel.org>
 <CAHp75VfK3RM+SP90d3nOXEobY81Xd_94tLL=Qt86mmdNwXaQpg@mail.gmail.com>
Date:   Tue, 28 Feb 2023 20:41:03 +0100
Message-ID: <87o7pdfui8.fsf@all.your.base.are.belong.to.us>
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

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Tue, Feb 28, 2023 at 8:42=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> Checkpatch seems to have trouble making sense of the situation when
>> struct definitions, variable definitions, and __initconst marking is
>> done in one go.
>>
>> Let's be nicer to checkpatch, and move the struct definition out,
>> which removes the error.
>
> Not that I'm against the patch, but how hard is it to fix the checkpatch?

Uhm, good one. I'll have a look (the .pl scared me off).
