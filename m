Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AE1665BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjAKMxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjAKMxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:53:05 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7C518B14
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:53:04 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso17033244pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2iGMpxokFpDfVlZYV+E36A3NeQpDbr43kl6CX+6LaXY=;
        b=J+AFfq9zjK6MT9E2Nd6NqCsD+rYjKNIRAwBmesh4nG/WIXLTzftCZYreF3yu15v9y7
         C2aYUp3iXGoL4r9DA/9+Uls8xSSkaeS4aVSgXARj2cUU7Fh5usy8A/U1s6FGiy+ttV5V
         mZAHjTy3Z7fApTC71dKCAIJphG5XxjdK2otWoP3bgFY470/I9sp1n4/WTceTVlnYU5SY
         IEv5w/zc+c1x/V1fkz+06AOT2FXhlnM+00Cu4HULt8ngurjowz6/mjYw8x2q2HG5BQmT
         KiZ2gVdqu0FhCHIs6kLlB1pF4gLeAcWADnTHxcaLupA6jTSBVtL3ljTd04wO6MSKog27
         f12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iGMpxokFpDfVlZYV+E36A3NeQpDbr43kl6CX+6LaXY=;
        b=NaeS+DkK2y29YmZEnc0S9ISBYdFDED2o7ti+QPbOkcPSuMhzucqgAZU97/T3RFK5aZ
         3XIHLEAQYZD9U2UW2ewdS28xh3vdTzkC+E9Rp8OuCqYT2NAueB4cEittdcomRvxnLJHA
         qMXN/Gd0zEx774uu7eG/440zgfR5S8M0Rhl87TcMtgecvky0Q0t3UZmw++XubGy7QhXx
         HHWVQlyk/4Nw6u6gbM/9G5DmyP/UCtOsrlxGdOMsUdNa5KXcV5ao2TacOYnSPD95EJZZ
         ZGj0g1MJX28if2b/792fLoQUlaNOAiL6Ukv12d4OHc0at40vIpxEfGMa9/prcDGH1LHS
         tQaQ==
X-Gm-Message-State: AFqh2kp4p+fc7gp5dy8TuJb7gllDLRxKUEVfJGHhRwnI9Sp4uH6KElMJ
        d3Bxn3HWi0yXBh9cNt7hLDc=
X-Google-Smtp-Source: AMrXdXuP+zL0MHGG+j9BNjzQg+mTvIOZHx2MvwjZ0xotPqpnTF1tOtO2L9rsU+e1/0ARfTEsNtgrEQ==
X-Received: by 2002:a17:903:1d0:b0:192:4f32:3ba7 with SMTP id e16-20020a17090301d000b001924f323ba7mr90515249plh.18.1673441583578;
        Wed, 11 Jan 2023 04:53:03 -0800 (PST)
Received: from vernon-pc ([49.67.3.29])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f7c500b0019337bf957dsm5469986plw.296.2023.01.11.04.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 04:53:02 -0800 (PST)
Date:   Wed, 11 Jan 2023 20:52:57 +0800
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maple_tree: fix comment of mte_destroy_walk
Message-ID: <Y76wO5srhqFlRfAU@vernon-pc>
References: <20230110152216.1712120-1-vernon2gm@gmail.com>
 <Y72xykdPydb1Gav6@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y72xykdPydb1Gav6@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 06:43:22PM +0000, Matthew Wilcox wrote:
> On Tue, Jan 10, 2023 at 11:22:16PM +0800, Vernon Yang wrote:
> >  /*
> >   * mte_destroy_walk() - Free a tree or sub-tree.
> >   * @enode - the encoded maple node (maple_enode) to start
> > - * @mn - the tree to free - needed for node types.
> > + * @mt - the tree to free - needed for node types.
>
> Should probably also fix the separator between the parameter name and
> the description to be : instead of -.

Okay, thanks you for review.

