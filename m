Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B0D680DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbjA3McO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbjA3McL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:32:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F8C36FEC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:31:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45A75B8108B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA5CC433D2;
        Mon, 30 Jan 2023 12:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675081907;
        bh=1owcSCoKbfIMbxpA4IUXuT/V6qrKuhQ2DkpDz3IcX/4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=reVpaRHIlaXaCGccMb3DZuBWu+eWpPJfYI9T3r3MTrbx3J6HMvC3+65W38nfzoQyA
         SRuRbu0O0TYRwWYp5LS5z9EvI2GbUHjEVi+1rW5RPCaDSxHXZirSSoVupq84Tu8S1+
         l2qK4PEp889vLErM2aCwOWwUKianGi8FKDgIvwaKPYR6ihw9tyKD4avPqNzEF5cd1M
         BVgpvRIS1cIu32eQux4nqoehFlG5h7NDPxvQEFJvGt3AyhoR7L1tu+JE124N7+SzGi
         IY1aaiD4G2Lj6lbxL3KmnynmF28bDQCuu158LYZjwqeuI6BZZiLsBu89qeW9zkmk3E
         pTwKYtogMy6TQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: Re: [PATCH v6 00/13] Add OPTPROBES feature on RISCV
In-Reply-To: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
Date:   Mon, 30 Jan 2023 13:31:45 +0100
Message-ID: <87wn54i4pa.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:

> Add jump optimization support for RISC-V.

I'd like to take the series for a spin, but I'm having trouble applying
the the patches; What base commit did you use? Or point me to a git
repo.

(It's nice to use "--base" to git-format-patch.)


Thanks!
Bj=C3=B6rn
