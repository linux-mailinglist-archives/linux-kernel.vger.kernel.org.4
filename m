Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29E96F14FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345909AbjD1KIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjD1KI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:08:28 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB29129
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:08:26 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 27F2916773F;
        Fri, 28 Apr 2023 12:08:23 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1682676503; bh=GTxUJDFsZHT3lyeCkP6UicSTVbHr563AdVuyeGOcPsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0QSfs/P5+3nG0tMqfKKUTqQ8Gda1wMNxh9zG6q/qnOIo1fEjQQbxM+iWvzBKZ47e7
         LIixbbDDDpZrhFf+1AU5xrL1zKoy8oxbOwI+W2eKWzMyzHa8n72/H0ciQxnYdGWYBX
         rVJxauM/DutPMDe+jyTYul8mo7xMXJfgCid4TOmTZdkLdz+h6J0TxSCw+nHZGZFm4B
         9tMixNJWCFySAnL52nre9VLWob26f291WoeOkYDxmw4E8NhQidM6CFSHWXn4AuXTu9
         R7IRtmbJTLGV4FDtvO2zZoDNOzoeXph34hjk9hvYA+1BfhBLf9mtOXbx00wgwyTPnC
         cURTRx05Q0Y5A==
Date:   Fri, 28 Apr 2023 12:08:22 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 10/34] maple_tree: Use MAS_BUG_ON() when setting a leaf
 node as a parent
Message-ID: <20230428120822.26aaa9c8@meshulam.tesarici.cz>
In-Reply-To: <20230425140955.3834476-11-Liam.Howlett@oracle.com>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
        <20230425140955.3834476-11-Liam.Howlett@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 10:09:31 -0400
"Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> Use MAS_BUG_ON() to dump the maple state and tree in the unlikely even
                                                                    ^^^^
nitpick: event

Petr T
