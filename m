Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3C963D201
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiK3Jc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiK3JcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:32:00 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188425B87F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:31:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqv2FR2z4xTy;
        Wed, 30 Nov 2022 20:31:39 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Christophe Lombard <clombard@linux.vnet.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220605060038.62217-1-linmq006@gmail.com>
References: <20220605060038.62217-1-linmq006@gmail.com>
Subject: Re: [PATCH] cxl: Fix refcount leak in cxl_calc_capp_routing
Message-Id: <166980022428.3017288.10905643901571385394.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:44 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jun 2022 10:00:38 +0400, Miaoqian Lin wrote:
> of_get_next_parent() returns a node pointer with refcount incremented,
> we should use of_node_put() on it when not need anymore.
> This function only calls of_node_put() in normal path,
> missing it in the error path.
> Add missing of_node_put() to avoid refcount leak.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] cxl: Fix refcount leak in cxl_calc_capp_routing
      https://git.kernel.org/powerpc/c/1d09697ff22908ae487fc8c4fbde1811732be523

cheers
