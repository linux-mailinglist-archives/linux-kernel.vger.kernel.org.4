Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE35F750746
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjGLL5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjGLL5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:57:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E27F198B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B6FC61794
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021AEC433C8;
        Wed, 12 Jul 2023 11:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689163000;
        bh=1gqCSp35DYsFbYRaR4GC+IpYCqYnDKwwtWr0wadc9qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2+Ga73uPMzz0p45+jAbQpBnUGy9RL7GbDPlBinbYEElVDETeELc079NJvVXBNG1X
         YF6quaLej0Q/u9RNku8A281OttS+EX/66MJ3QO4kP/69oz/gb51sxXGfYDy5QmhBWo
         wSFOFkXhNTsdiOVJ8/VXSTukxhEYbwE7rHwOTiYEWYbcdqTyPHvH/5geNshjRNOQfu
         e8ITiJqWgTfRW2mYd018ZTCiCBMcv5ku64F5sxUAQ+3/PmPfv2bI2AhG9eQ9Qv7IyW
         GEUK9dvaMz/co1lzPi6ILGcRvnt1T9ojtHiLZcjZut3/MkcQOJWQhgikKPTTorx6dA
         PwoWrHZwQqC6A==
Date:   Wed, 12 Jul 2023 12:56:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     s.shtylyov@omp.ru, Zheng Wang <zyytlz.wz@163.com>,
        davem@davemloft.net, linyunsheng@huawei.com, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com
Subject: Re: [PATCH net v3] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230712115633.GB10768@google.com>
References: <20230311180630.4011201-1-zyytlz.wz@163.com>
 <20230710114253.GA132195@google.com>
 <20230710091545.5df553fc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230710091545.5df553fc@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023, Jakub Kicinski wrote:

> On Mon, 10 Jul 2023 12:42:53 +0100 Lee Jones wrote:
> > For better or worse, it looks like this issue was assigned a CVE.
> 
> Ugh, what a joke. 

I think that's putting it politely. :)

-- 
Lee Jones [李琼斯]
