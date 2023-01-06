Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998E865F8B8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbjAFBMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbjAFBMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:12:17 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DD7772D07
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:12:17 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 6DEFC92009C; Fri,  6 Jan 2023 02:12:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6B3F692009B;
        Fri,  6 Jan 2023 01:12:16 +0000 (GMT)
Date:   Fri, 6 Jan 2023 01:12:16 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH][PATCH] parport_pc: Limit the number of PCI BAR pairs to 2
In-Reply-To: <alpine.DEB.2.21.2209260132340.29493@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2301060111330.54090@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2209260132340.29493@angie.orcam.me.uk>
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

> Decrease the number of PCI BAR pair slots allocated for port subdrivers 
> from 4 to 2 as none wants more than 2 at this time, reducing the memory 
> footprint a little.  No functional change.

 Ping for: 
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2209260132340.29493@angie.orcam.me.uk/>.

  Maciej
