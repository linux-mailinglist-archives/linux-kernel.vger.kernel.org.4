Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E4A65C5CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbjACSKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238686AbjACSKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:10:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368AC101D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:10:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFCA0B81081
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180EDC433F2;
        Tue,  3 Jan 2023 18:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672769401;
        bh=OA+vRsO32YXq52SFO92kpSmSbXQlrZa2Nt6anC0D3Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=an6LmPQ6ZQkM8zGdzAimnaykGMK4ITP/zBdYjfKJeo1bzP3CNwZlIXcv25mCRzW8S
         ga6mcuG3/5Xvm/KKAtxGeZwBLOZ6hiFQrKICeiaY6KnEMs1fGkMJzCr/xANi1pxCNi
         YhWVbKYmSeahd89UEbwy9aRl6LXCAoapmW3OwhpmA+LLtpXLLMm9mLwOQ/1sVTJt8c
         BDY7viiOwB6kMnwSlZgLWqcApEq815tDTt8TqoZuuoPAIFFLhk8ct0ZvRPJ5VBOWcg
         mSREzEhS7w+fZjFTwk+5TEmJK1H3kxFrWxNrWpJPGB/WE/u7vmPm2oZgdiQlEQR1jd
         hrdAjGczutZhw==
From:   SeongJae Park <sj@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        colin.i.king@gmail.com, dfustini@baylibre.com,
        linux-kernel@vger.kernel.org, joe@perches.com
Subject: Re: [PATCH] scripts/spelling: add a few more typos
Date:   Tue,  3 Jan 2023 18:09:59 +0000
Message-Id: <20230103180959.129697-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7247ac21-f06d-74bc-e9ad-34930ec6d0a4@infradead.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, 3 Jan 2023 10:04:43 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi--
> 
> On 1/3/23 09:59, SeongJae Park wrote:
> > Add a few more typos that found from real patches[1,2] to 'spelling'
> > file.
> > 
> > [1] https://lore.kernel.org/linux-mm/4bc4ab74-3ccd-f892-b387-d48451463d3c@huawei.com/
> > [2] https://lore.kernel.org/damon/20221228174621.34868-1-sj@kernel.org/
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  scripts/spelling.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> > index ded8bcfc0247..64bddbf7425b 100644
> > --- a/scripts/spelling.txt
> > +++ b/scripts/spelling.txt
> > @@ -411,6 +411,7 @@ contruction||construction
> >  contry||country
> >  conuntry||country
> >  convertion||conversion
> > +covert||convert
> 
> "covert" is a real, valid word. Is it always incorrect when used in kernel
> source or documentation?

You're right.  I will drop this in the next spin.


Thanks,
SJ

> 
> thanks.
> 
> -- 
> ~Randy
