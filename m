Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C0970F1D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbjEXJKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240548AbjEXJKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C0512B;
        Wed, 24 May 2023 02:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EC3C62E1B;
        Wed, 24 May 2023 09:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01F2C433EF;
        Wed, 24 May 2023 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684919417;
        bh=W8HWtStbDZqhZruPggcwStOJ7mNKd3pQ/1x8r+G6DMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u1OQit3TXyjPAcUn81+mCtS0rcNk7LEMrmcBUptvnsIU/dQThktPqPtq82zuxm0k8
         KkHLOMvERfHj2DDY2wceGvqSH9RHHQPaNdFHTjoIKJW8GYcrYvHeSiTfIH75tSHKHy
         m8UpdwvmGESD8MotjkvZsPTgIX7dwL5/b4EQ083sw4NTF32F8APl/tXVyxTvLUrNb1
         jZrtlvDsJDUk6pJD4NfDFg5e8I50NUMr+H/0XgYCMJjVZ5Ao4hE0GkImS1qI4dXc4t
         QzMbOtGrkPHuemAht2nChWhE7ohcH3cuVt5ixzw48IseoZeyex7w3eCS6lmWj5dus6
         oOfN8OB5dm/vg==
Date:   Wed, 24 May 2023 11:10:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the vfs-brauner
 tree
Message-ID: <20230524-ersuchen-artischocken-ca05dcf0daf2@brauner>
References: <20230524081805.4c969d7f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230524081805.4c969d7f@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 08:18:05AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   ee3b4556cee8 ("ntfs: do not dereference a null ctx on error")
> 
> is missing a Signed-off-by from its committer.

Fixed. Thanks!
