Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636C670EE95
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbjEXGxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239727AbjEXGw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:52:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F02F1B4;
        Tue, 23 May 2023 23:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YRw9OpJPOYvTEj//3KZeiED/BNHcvsHuScYwpGfneP8=; b=qltV6rhjDIMg/g2XyqByozJe6x
        5HRs/uboAJULBbyDCoqw+AGZ+IA2sitjTioscw+unolLNXvDijODh2rHe6Ivd1nDBFx0/Pf1Kn5Bk
        skR0IwWiZ8ytqfMXj7XNmqelqPWQPuV46CBwf03v8GetMkz7sQrPae1fCUMxLCxE4F+zzUUbSL9kx
        wIF2FxZN57H1Bz9PPJwjorWWgc+DB66ONlw/kRohx2vC5a1m33XAUn/29R0g2E+cAU2AIveIJkc93
        9i3pr4Rz9mvRGeCOEYN/daFNi6Hunxo54+DZ0vRT6sOkBwBfLQsv/J0vST/BYGhlEYJOemjKNnDht
        E1Vgilbg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1iMD-00CXNZ-2i;
        Wed, 24 May 2023 06:52:25 +0000
Date:   Tue, 23 May 2023 23:52:25 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, christophe.leroy@csgroup.eu,
        nick.alcock@oracle.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v10 03/11] stmpe-spi: Fix MODULE_DEVICE_TABLE entries
Message-ID: <ZG20KZ6Quk87zm8l@bombadil.infradead.org>
References: <20221219204619.2205248-1-allenwebb@google.com>
 <20230406190030.968972-1-allenwebb@google.com>
 <20230406190030.968972-4-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406190030.968972-4-allenwebb@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 02:00:22PM -0500, Allen Webb wrote:
> A one character difference in the name supplied to MODULE_DEVICE_TABLE
> breaks compilation for STMPE_SPI after built-in modules can generate
> match-id based module aliases. Since this wasn't being used before and
> builtin aliases aren't needed in this case, remove it.
> 
> This was not caught earlier because STMPE_SPI can not be built as a
> module and MODULE_DEVICE_TABLE is a no-op for built-in modules.
> 
> Fixes: e789995d5c61 ("mfd: Add support for STMPE SPI interface")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202212171140.NB93eVvI-lkp@intel.com/
> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---

Oh feel free to add Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
on patches 1-3.

  Luis
