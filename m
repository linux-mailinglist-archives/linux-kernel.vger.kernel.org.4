Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA173F464
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjF0GSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjF0GSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:18:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8783599;
        Mon, 26 Jun 2023 23:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11E0B61022;
        Tue, 27 Jun 2023 06:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2604C433C8;
        Tue, 27 Jun 2023 06:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687846715;
        bh=PT1TJLw/+jsSSNNLBAlk12SUbxG6D/fqh2oAjy0ah4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZvU5iKpYqWVA3jNGsgrCoyywbuPTGdklwuTnu1DNNfnjwOvhIpNAnVnDY0xIEgRyc
         fI+BkyMWY7KkXc3N9iCxg7rsz8knJ5QS94K24eCYoftC6MxIBsLhyKJlpGEKPCIqeT
         2a96l2U7SLr5YV2EBSoZeEgD+z+XzcFzSImtezjk=
Date:   Tue, 27 Jun 2023 08:18:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>,
        axboe@kernel.dk, willy@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: add check that partition length needs to be
 aligned with block size
Message-ID: <2023062753-speech-straw-f2f6@gregkh>
References: <CGME20230627031105epcas5p3010432ebd447ad865c3ddd986b3ffee0@epcas5p3.samsung.com>
 <20230627110918.7608-1-min15.li@samsung.com>
 <8ea3bdfb-f2d9-ee5e-f623-02b2b134490d@kernel.org>
 <20230627045924.GA16913@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627045924.GA16913@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 06:59:24AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 27, 2023 at 01:39:26PM +0900, Damien Le Moal wrote:
> > See Greg's comment: this likely need a "Fixes:" tag. And I think that the tag
> > is: fa9156ae597c ("block: refactor blkpg_ioctl"). But please double check.
> 
> No, the lack of checks goes back all the way to when this code was
> added long before git was a thing.  So I don't think a Fixes tag makes
> all that much sense here.

Ok, then how about a normal "cc: stable@kernel.org" added to the s-o-b
area so it gets picked up for all stable trees as this is an issue that
has always been there?

thanks,

greg k-h
