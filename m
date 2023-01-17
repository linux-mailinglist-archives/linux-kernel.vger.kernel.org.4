Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E91366E239
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjAQPdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjAQPdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:33:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EC53FF20;
        Tue, 17 Jan 2023 07:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VQZ7HmGNIOLXCftXZ531kTqZjZKKw65xP3ndBtQciAM=; b=VG5hFdcYWwFqpDE9EAjMtC6qO3
        VPHPjGO9Ui0yZNu0fMG3jMdiCkVw0AwY+DLmpfxnZPFaFLvec70QkaYtpLLE1/ZVX9k9gY1PNsv/B
        3BqQBK3pZxgsUlXOW9JT4/0TWiom2A0aR9sc313eM3Hm12Q7DEq2g9nxY+pkSEiIP8uFvPJFma9lH
        CdAcwcv+o2PSAgkPxpbYLA/yvpzzKR6CP7XFjCUem83jH1EC2z2WPhm52LsDSjpAbi9ps03RjNUS/
        s0d8ddXwRej5Ma/ElT/UyivbQBHifIoGEokXiWprN719tlzMreAbJ2hoVov2IUDw9957Nl+4bWnGu
        l263FwYA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHnxQ-00Eqmi-BS; Tue, 17 Jan 2023 15:33:04 +0000
Date:   Tue, 17 Jan 2023 07:33:04 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     gregkh@linuxfoundation.org, russell.h.weight@intel.com,
        tianfei.zhang@intel.com, shaozhengchao@huawei.com,
        colin.i.king@gmail.com, error27@gmail.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] test_firmware: Use kstrtobool() instead of strtobool()
Message-ID: <Y8a/sILCmAt7oHLv@bombadil.infradead.org>
References: <34f04735d20e0138695dd4070651bd860a36b81c.1673688120.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34f04735d20e0138695dd4070651bd860a36b81c.1673688120.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Jan 14, 2023 at 10:22:03AM +0100, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
