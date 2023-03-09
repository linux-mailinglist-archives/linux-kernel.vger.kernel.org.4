Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBA16B2F29
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCIU6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCIU6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:58:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA2319F2B;
        Thu,  9 Mar 2023 12:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zceKrdyITtJ+tdJeVSz+INsZ8xQPZxjCEDK2Td9PBf8=; b=x4PpSZTh3M8fAYO5pAq45zenlx
        Tql6W3lAt5OTQpg2nzoQkW6xqmGfspp3AWM6HHb5LqbG6RcwPfy2v+49WsUD2NGxmAJ2as0rip2gN
        RWA8iAqpcxT6G8N/5LANGynWU8xkYwbXv6Z+QRrytmvLHiGgnETOiXRBpAR9Kyjk83GBsrgpYywLH
        dNStTCwPi1YHR+W2oHqbh4Q2hE/Qy6BZtKJ2ZMgh+cd6QT0dce+tvi0RzZS5iNrj9LX5hS+DCZtr9
        cY5MZlWtEOlAZPCVFvXsJNzSsw+6kz6PXlyOUo9FRrxy5hs14QuvwDhA3PQw3S4LGUmjWiLogfqrH
        kUOZadFg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paNKv-00Bu1I-Jm; Thu, 09 Mar 2023 20:58:05 +0000
Date:   Thu, 9 Mar 2023 12:58:05 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     Jason Baron <jbaron@akamai.com>, jim.cromie@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dyndbg: remove unused 'base' arg from
 __ddebug_add_module()
Message-ID: <ZApIXdMGACZJEwd2@bombadil.infradead.org>
References: <cover.1677612539.git.jbaron@akamai.com>
 <855201dc0204a1428a79d415c97df2b6e11c95c3.1677612539.git.jbaron@akamai.com>
 <CR22F969CUPF.1MU6YEMD6OE7W@vincent-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CR22F969CUPF.1MU6YEMD6OE7W@vincent-arch>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 07:31:21PM +0100, Vincenzo Palazzo wrote:
> > __ddebug_add_module() doesn't use the 'base' arg. Remove it.
> >
> > Cc: Jim Cromie <jim.cromie@gmail.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Tested-by: Jim Cromie <jim.cromie@gmail.com>
> > Signed-off-by: Jason Baron <jbaron@akamai.com>
> > ---
> 
> Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

Tag applied, thanks.

  Luis
