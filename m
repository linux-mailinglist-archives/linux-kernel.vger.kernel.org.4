Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E22B74D77A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjGJNZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjGJNZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA94103
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FFE160FE9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD85C433C8;
        Mon, 10 Jul 2023 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688995547;
        bh=DBTnG3NT6q7l3gSvnGGpj3TXOecrRDn54B394iM4p1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wOnS6jo/4yjtXUlG2LFx3WExxXqcWzY44vALS6OvC0Th+gehv7IEukDQrnDzKeVxa
         vyX+uNnuJDOKJNpQX2660mRtiYJgYUg2rrgvuapX6/ZOrUjTUN2mLQYTZfDVcSb9YF
         knXu9LVkBpz+PKEBqrRjSm1GlLgY2sXxMAI4pJMo=
Date:   Mon, 10 Jul 2023 15:25:45 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "yiyang (D)" <yiyang13@huawei.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>,
        "Guozihua (Scott)" <guozihua@huawei.com>
Subject: Re: [PATCH RFC] tty: tty_jobctrl: fix pid memleak in
 tty_signal_session_leader()
Message-ID: <2023071020-raven-maggot-b854@gregkh>
References: <20230703080323.76548-1-yiyang13@huawei.com>
 <cb540eb6c27f4a71803d094505725ae1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb540eb6c27f4a71803d094505725ae1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 07:23:57AM +0000, yiyang (D) wrote:
> Ping 

What does this mean?

