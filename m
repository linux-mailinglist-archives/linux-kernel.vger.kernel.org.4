Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA89572E649
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242843AbjFMOvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbjFMOvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:51:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5911BC6;
        Tue, 13 Jun 2023 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=3pC1z5Kz0Os/ZjccBXRn1lob4yWiIrBMeB5JFUKr/kE=; b=WWZHUBK4cidU54WmGLYdDUo0Y+
        MFGc18fOBwTQYF+FOTQbBf8F5SBBUOwQZrvBOcveEiVR7C3Tll2TE17jkwSjcO3rt/87YkKimNjsK
        RX1ilywD0AdgLFxMwF2iNwnimGob0rZVB9M55Hcn92G7hPus3PqBSNcyB0d9EGNfe99q8p/KeT2jQ
        MxKI8Wn9tmHj+TgWxJ+5oIx3IEXxZYwgpc/Flwj7HKPmj4YBhAtiVPR7v/iWcRH719/0Y171XaAzI
        mDfFJCJ28e1lp6EyWqONRstmKwPtkbW8kCrr70pPOTPhIBIf1OblJzMQGEdNhdwCSEFBXIFAjXNlb
        FC567GXw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q95MZ-008OKe-0t;
        Tue, 13 Jun 2023 14:51:15 +0000
Message-ID: <1ef14551-e85b-b5ad-bbe8-091180745417@infradead.org>
Date:   Tue, 13 Jun 2023 07:51:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: linux-next: Tree for Jun 13 (drivers/block/swim3.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20230613165903.5cc10e58@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230613165903.5cc10e58@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/23 23:59, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230609:
> 

../drivers/block/swim3.c: In function 'floppy_ioctl':
../drivers/block/swim3.c:919:15: error: too many arguments to function 'floppy_locked_ioctl'
  919 |         ret = floppy_locked_ioctl(bdev, mode, cmd, param);
      |               ^~~~~~~~~~~~~~~~~~~
../drivers/block/swim3.c:885:12: note: declared here
  885 | static int floppy_locked_ioctl(struct block_device *bdev,
      |            ^~~~~~~~~~~~~~~~~~~


-- 
~Randy
