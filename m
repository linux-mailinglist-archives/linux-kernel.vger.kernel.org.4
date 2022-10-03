Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CCA5F39F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 01:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJCXkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 19:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJCXkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:40:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3997646;
        Mon,  3 Oct 2022 16:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hj6VoUAiKuP/EluI/8iLksuUOCqH6aetuiEUiC0KiF4=; b=gvShoPKYzAGsLgWPXFX2TdtjO1
        v8iWBcjQHUvVifadKTqy/NgLsv5O+0gFBQqmtJpnb/o/Pswu5l4b4MsgHDdNv3M+efRgae1m2V95H
        bmuy2DxU1ZBSTgH1TSWjJLUSKSap1hzBJOEjcFEz8QTnK+haOAv/hBiWBuJAhqxxfp89OHBP/DEFM
        mMpl9S3QLT61uCkDj62my0TGMAHwjHidtDHRpPzmEzduJUE9gnQTx8CTHri/T227w7fUsdyx6H3ck
        SNY8c181Pt9u7CWayQRN6tQMkeNRZ7d1OtkZnArh45uuT6qi3cmWAugEUO/Wh99jlekHGTHifaWjA
        42DooiWg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ofV2g-0084lP-Th; Mon, 03 Oct 2022 23:40:10 +0000
Date:   Mon, 3 Oct 2022 16:40:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: remove redundant module_sysfs_initialized
 variable
Message-ID: <Yzty2iIZgv7NQrqL@bombadil.infradead.org>
References: <20220929121039.702873-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929121039.702873-1-linux@rasmusvillemoes.dk>
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

On Thu, Sep 29, 2022 at 02:10:39PM +0200, Rasmus Villemoes wrote:
> The variable module_sysfs_initialized is used for checking whether
> module_kset has been initialized. Checking module_kset itself works
> just fine for that.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Looks pretty sane to me, thanks! I'll queue this up for 6.2
as we didn't get a chance to spin test this for 6.1 on linux-next.

  Luis
