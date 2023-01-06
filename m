Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730F665F8B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbjAFBKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjAFBJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:09:59 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B29AA6F941
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:09:58 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 792EC92009C; Fri,  6 Jan 2023 02:09:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7671992009B;
        Fri,  6 Jan 2023 01:09:57 +0000 (GMT)
Date:   Fri, 6 Jan 2023 01:09:57 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PING][PATCH 0/6] parport_pc: Fixes for Oxford Semiconductor PCI/e
 parallel ports
In-Reply-To: <alpine.DEB.2.21.2211152336240.54611@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2301060106140.54090@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2211152336240.54611@angie.orcam.me.uk>
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

On Wed, 16 Nov 2022, Maciej W. Rozycki wrote:

>  This small patch series addresses these problems in 6 incremental steps.  
> See individual change descriptions for further details.  I have verified 
> these changes with and w/o PARPORT_PC_FIFO and PARPORT_1284 options set. 
> Please apply.

 Ping for: 
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2211152336240.54611@angie.orcam.me.uk/>.

  Maciej
