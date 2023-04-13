Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA66E0F38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjDMNvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjDMNvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:51:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6578A6A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17A4763EC8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE7DC433D2;
        Thu, 13 Apr 2023 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681393903;
        bh=s/dmCaH25uHi9qR1VOOh32+D5s22j7AfxC7emCEAXUk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EmxbZaXmOKsfFhrWOWe9XZto2cFMKYdqZfWd2awovET6dWD3kOE742H29DzV1bg0l
         fBQpsb6Ctw3O3CyE9JmOkSJYnVadG6S/veP6zHbD4K4IF+8HW0uGphWDw8EssTychz
         EAWtReusOZABW2XvWOyjiV7j1rDviVH+BFgmmqKNYH7xzLl4HYNQg8lgKvfdl4pQRu
         Db6mmx4R1jxNIRtpy8ef+aRN7Iy4N8+Xxv9d/06rAzCp2rCIEqrdm4XM/1vzUM9XQW
         vQ5D20MJw6FKqsQZF6YhDnNH2UtARDE21u8H1FPmNVwuB6Lf/9Vp8cx3rbeWMgSt56
         IRPtWcq3N59MQ==
Message-ID: <e66f438c-b1b3-ab9e-319d-939fa665746f@kernel.org>
Date:   Thu, 13 Apr 2023 21:51:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix passing relative address when
 discard zones
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20230406221104.992322-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230406221104.992322-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/7 6:11, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We should not pass relative address in a zone to
> __f2fs_issue_discard_zone().
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
