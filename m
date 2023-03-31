Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15446D17E9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjCaHAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCaHAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:00:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4EAAD0D;
        Fri, 31 Mar 2023 00:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=osScnoo8TL5BiOd6R4ozuuVkhPFMoQ4zL9oQF6cBOEg=; b=YfTBVGvRE/RvvQntBfCYvHiytP
        mTByV3+JpT4EdI5LcIvhbGKNhUb5PQcVE/AwquTEc6OnM2khM3YxCmXQqIwdPaT1t/JM+1KdstCDw
        iwSnG3G+9dBkGi1tyH3hb3O4rSbWql//abWBDaqTQFmhEQ9+GkMZkDOckouf31b2wPF/UzoK36UNe
        KwhV2FAxP6O4DaITuBhs4Oj5NivtBZmI7MZMTlqZ+mmabQlwl/joD/4WQAmICVV0HZkXpBKpK3ojw
        nEE/iIesu9W0nMh5cGX94MPAkllgxbZ/pmUzXz4LPJVRTeAGcEQJZtJ8qk3b9D6HmL8oWUaygo8bc
        Vw8LglQQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pi8jv-0065y8-1n;
        Fri, 31 Mar 2023 06:59:59 +0000
Date:   Thu, 30 Mar 2023 23:59:59 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jim.cromie@gmail.com
Cc:     linux-modules@vger.kernel.org, song@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: kmemleaks on ac3b43283923 ("module: replace module_layout with
 module_memory")
Message-ID: <ZCaE71aPvvQ/L05L@bombadil.infradead.org>
References: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 04:45:43PM -0600, jim.cromie@gmail.com wrote:
> hi Luis, etal
> 
> kmemleak is reporting 19 leaks during boot
> 
> because the hexdumps appeared to have module-names,
> and Ive been hacking nearby, and see the same names
> every time I boot my test-vm, I needed a clearer picture
> Jason corroborated and bisected.
> 
> the 19 leaks split into 2 groups,
> 9 with names of builtin modules in the hexdump,
> all with the same backtrace
> 9 without module-names (with a shared backtrace)
> +1 wo name-ish and a separate backtrace

Song, please take a look.

Thanks for the report Jim, what kernel are you on exactly?

  Luis
