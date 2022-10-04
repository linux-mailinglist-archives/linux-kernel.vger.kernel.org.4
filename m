Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475695F4458
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiJDNiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJDNis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:38:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09BF4DB67
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:38:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1K3Njnz4xGt;
        Wed,  5 Oct 2022 00:38:45 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     cgel.zte@gmail.com, fbarrat@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
        ajd@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        christophe.leroy@csgroup.eu, npiggin@gmail.com, mpe@ellerman.id.au
In-Reply-To: <20220906072006.337099-1-ye.xingchen@zte.com.cn>
References: <20220906072006.337099-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] ocxl: Remove the unneeded result variable
Message-Id: <166488996048.779920.14294683333465677232.b4-ty@ellerman.id.au>
Date:   Wed, 05 Oct 2022 00:26:00 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 07:20:06 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value opal_npu_spa_clear_cache() directly instead of storing
> it in another redundant variable.
> 
> 

Applied to powerpc/next.

[1/1] ocxl: Remove the unneeded result variable
      https://git.kernel.org/powerpc/c/5e4952656bca1b5d8c2be36682dc66d844797ad2

cheers
