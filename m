Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B46030FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJRQru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJRQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:47:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE587EA374;
        Tue, 18 Oct 2022 09:47:44 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7c1329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7c1:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46E231EC06EE;
        Tue, 18 Oct 2022 18:47:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666111659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SzR5aucNzYth/ilLrj8wXigxDEHh6z7QEBNhMFKzJ1Q=;
        b=KofcBB3zWnY4gvrj9X0NQGj8nXKqkuLPZHz8zXTQFhQRaGEMEDu5y9pGdVSZj2AV6+bp5P
        GEYux0xaFU9ezR0u97sLiaSNrwGB6QwTenR8UqlGzUjkG2z7wKb1H/rPbqkEsR/3Pg60P7
        GUXLo/Op7L3fTxeUw7B6uF8xGlFJ54k=
Date:   Tue, 18 Oct 2022 18:47:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, fenghua.yu@intel.com,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 0/2] x86/resctrl: Fix min_cbm_bits for AMD and code
 cleanup
Message-ID: <Y07Yp4C6Qkk8lt/b@zn.tnic>
References: <166430959655.372014.14294247239089851375.stgit@bmoger-ubuntu>
 <703e6dfd-68d6-6def-183d-fb99b39692b3@intel.com>
 <Y07VzWTRpSnpbuc2@zn.tnic>
 <fe3baf5f-1536-46d7-9472-5ab908b8f4f2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe3baf5f-1536-46d7-9472-5ab908b8f4f2@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:43:15AM -0700, Reinette Chatre wrote:
> Correct. Apologies for missing the "Cc: stable@vger.kernel.org" in
> that one.

Nothing to apologize, all good.

Lemme take care of them.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
