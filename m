Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947D76A62B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjB1Wov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjB1Wou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:44:50 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3448F2E0CB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:44:49 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B134A92009C; Tue, 28 Feb 2023 23:44:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id A34A592009B;
        Tue, 28 Feb 2023 22:44:47 +0000 (GMT)
Date:   Tue, 28 Feb 2023 22:44:47 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Palmer Dabbelt <palmer@dabbelt.com>
cc:     gerg@kernel.org, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv: support ELF format binaries in nommu mode
In-Reply-To: <mhng-20faeb04-8ed4-4759-8f13-aef3d2446d15@palmer-ri-x1c9a>
Message-ID: <alpine.DEB.2.21.2302282242270.50005@angie.orcam.me.uk>
References: <mhng-20faeb04-8ed4-4759-8f13-aef3d2446d15@palmer-ri-x1c9a>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023, Palmer Dabbelt wrote:

> Adding Damien, as IIRC he's had some hacked up userspace bits for the K210.
> I'm yet to get anything running, but it'd be great if we get this to a point
> where I can actually boot test this on QEMU (I'm just doing builds now).

 And I'm still around should someone want to proceed with FDPIC support in 
the toolchain.

  Maciej
