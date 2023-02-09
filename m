Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E49969114C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBIT0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:26:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35C36952E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:26:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 610D3B82287
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 19:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EF2C433EF;
        Thu,  9 Feb 2023 19:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675970780;
        bh=xJOpuC/jnkOpB1TfegYUp9iG2RA/aGYjPn9FEMaQM/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmESZp7GIbeqRmRzThJmal8xi7/4ALToj38nIJfwr0S0jiLHiuAVqLROkQbTID5Dy
         EPSulQ9WDCdwDv4gYPyCrjOsYgHagdVVFGYFZPpVTa9CRdHOUoePZoO8OV/Np03hC1
         9yLLXmgSTUQ1vTUyfN4olXMVAOpr5VbxjmFIpDr7PFfKZq9faOncR2f80WGGy+ars7
         5N7b0gTFYk2GfRktKTTiKco3hchec3n+9zZ0eFXIEbrL8v7pG7KOPZKqQ9zwWfAEqi
         fvpTxwIgYGgshKKTK2q7XbBwpRvyBpgaFzslG2IlVO/51a8Eg4IRfLJR9ntuVtmzZs
         n82a1fMGtJLeA==
Date:   Thu, 9 Feb 2023 11:26:17 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] kasan: mark addr_has_metadata __always_inline
Message-ID: <20230209192617.mc4fvwe3ryyzdhve@treble>
References: <20230208164011.2287122-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230208164011.2287122-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:39:55PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When the compiler decides not to inline this function, objdump

"objdump" -> "objtool" here and in patch subject.

-- 
Josh
