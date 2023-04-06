Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C616D8BF1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjDFAg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjDFAgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:36:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4061769B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:36:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsMxY1hyzz4x91;
        Thu,  6 Apr 2023 10:36:17 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Kautuk Consul <kconsul@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230327113320.3407491-1-kconsul@linux.vnet.ibm.com>
References: <20230327113320.3407491-1-kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH v5] KVM: PPC: Book3S HV: kvmppc_hv_entry: remove .global scope
Message-Id: <168074126986.3672916.9668279446750796507.b4-ty@ellerman.id.au>
Date:   Thu, 06 Apr 2023 10:34:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 07:33:20 -0400, Kautuk Consul wrote:
> kvmppc_hv_entry isn't called from anywhere other than
> book3s_hv_rmhandlers.S itself. Removing .global scope for
> this function and annotating it with SYM_CODE_START_LOCAL
> and SYM_CODE_END.
> 
> 

Applied to powerpc/topic/ppc-kvm.

[1/1] KVM: PPC: Book3S HV: kvmppc_hv_entry: remove .global scope
      https://git.kernel.org/powerpc/c/5f4f53d28cde2cc7be96f657229c8603da578500

cheers
