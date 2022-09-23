Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72EF5E7934
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiIWLOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiIWLOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:14:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9201332E3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 04:14:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYqKf4fsdz4xGD;
        Fri, 23 Sep 2022 21:14:14 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     npiggin@gmail.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu
In-Reply-To: <20220906141703.118192-1-zhengyongjun3@huawei.com>
References: <20220906141703.118192-1-zhengyongjun3@huawei.com>
Subject: Re: [PATCH -next] powerpc/powernv: add missing of_node_put() in opal_export_attrs()
Message-Id: <166393161547.498456.17807482481125185495.b4-ty@ellerman.id.au>
Date:   Fri, 23 Sep 2022 21:13:35 +1000
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

On Tue, 6 Sep 2022 14:17:03 +0000, Zheng Yongjun wrote:
> After using 'np' returned by of_find_node_by_path(), of_node_put()
> need be called to decrease the refcount.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/powernv: add missing of_node_put() in opal_export_attrs()
      https://git.kernel.org/powerpc/c/71a92e99c47900cc164620948b3863382cec4f1a

cheers
