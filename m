Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E528E5E79D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIWLma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIWLm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:42:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70900115A7F;
        Fri, 23 Sep 2022 04:42:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CCC83CE1FC7;
        Fri, 23 Sep 2022 11:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172C4C433C1;
        Fri, 23 Sep 2022 11:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663933344;
        bh=IElaqsOl19jCfCbDLSc5sGJfrq6cxuQVuid0ksi5A+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wIvn0SOnHl8RBAPfFyF9eoV9KD5v3JKKWdLFVnHlkZkmPmScuzEVCYRhaUOSpj1aJ
         PGV16QnCe099Z+MVjCa/BSO9TJzIZ1LM1S3J+YdybP07p5MdnieUTB9409hKH9BdFi
         fPzexCEgMMfGKZ0UHuQkclRm5fV8O3AF2sY2uAbU=
Date:   Fri, 23 Sep 2022 13:42:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     krzk@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Solve warning regarding inexistent
 atmel-usart binding
Message-ID: <Yy2bnM30h/d0kFae@kroah.com>
References: <20220923113415.90236-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923113415.90236-1-sergiu.moga@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 02:34:18PM +0300, Sergiu Moga wrote:
> After the conversion to json-schema, what was previously known as
> `Documentation/devicetree/bindings/mfd/atmel-usart.txt`
> has been moved to another bindings directory and renamed to
> `Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml`.
> Thus, make `MAINTAINERS` reflect this change.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> Reported-by: kernel test robot <lkp@intel.com>

What commit id does this fix?

thanks,

greg k-h
