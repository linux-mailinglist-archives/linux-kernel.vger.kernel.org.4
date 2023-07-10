Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC22C74DAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGJQPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGJQPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:15:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56A3DF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6465F6108E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 16:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5836DC433C7;
        Mon, 10 Jul 2023 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689005746;
        bh=EnHiiTkYovbRCqP6GjWdTZK3cChn2ZgTf/L/xSKlxg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qsXqxqLtPs5Kh7AH2qMcLa6/7Hf6Kx9qDckz7k49WWVlUY5f9qoXDq6IuC8Kt59Qo
         tKivWokTCFCjmICnjs6cladxP4VxbaDp8j0oMlg8hQjlqjTHc0ZKHVZ9AzPzZk73UB
         4B8cmDgBKIjSMCsYsnumgCbNGvr1FzNwesOfbsVY4DTz/UZiB+cOW/jq7BtVrshItP
         E8CMr/zhwj8vLXkqRI8NWJXd0sEhkkiZTorh0XgJBxy6tJydlK006/bsTgivdQZgnf
         bUqyV1Sq8ePyXa3hdPuNza45a+rUfyTmqthAVSh6G/dg/6o8Xl/eZmHKN50IgQj+a0
         3xvT7zXk3lXVg==
Date:   Mon, 10 Jul 2023 09:15:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lee Jones <lee@kernel.org>, s.shtylyov@omp.ru
Cc:     Zheng Wang <zyytlz.wz@163.com>, davem@davemloft.net,
        linyunsheng@huawei.com, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Subject: Re: [PATCH net v3] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230710091545.5df553fc@kernel.org>
In-Reply-To: <20230710114253.GA132195@google.com>
References: <20230311180630.4011201-1-zyytlz.wz@163.com>
        <20230710114253.GA132195@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 12:42:53 +0100 Lee Jones wrote:
> For better or worse, it looks like this issue was assigned a CVE.

Ugh, what a joke. 

Sergey, could you take a look at fixing this properly?
