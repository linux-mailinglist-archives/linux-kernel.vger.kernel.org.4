Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDAE6524CD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiLTQkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLTQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:40:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019DFCDA;
        Tue, 20 Dec 2022 08:40:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D20D0614F8;
        Tue, 20 Dec 2022 16:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CDDC433EF;
        Tue, 20 Dec 2022 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671554408;
        bh=M9dWYNH12Wxtbj66Ae5BgZjxSkhFr5pV8ZS66+CzCck=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BouhkvfmFAl3cXATPuwd9v7mjFGXgZd6VrzW0qJ5wnDapuiGs3sAEiet6hZYrBY2Q
         CiYp+dl9n4p9r4wu/y8LO+UxCi7jZKGS3VGKFfPWtXYQNwhtlR69ejsn+gmNop2LKx
         XZDnZcY7qU3OkGkTaocZiiq7QXIG/rGIpVGcVCqaaHNUJs/ao1ogulySxlgAzwtLrJ
         3mJlB8AnGgVg8LE0+2vib6QE6qUM2qzSD86AsxeqNVC92AYYUL1zxKDAh3Of14mCE+
         KhnZ3pqoBtPJIU29f6T3mxpyhBNRVbnQe0/1T0Sd7RBu9P+DeOBPoHdv++jjYIRkR2
         z3FnF0HApvFnw==
Message-ID: <51ff4c08-e330-70b6-389d-6b6787f85686@kernel.org>
Date:   Tue, 20 Dec 2022 17:40:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH linux-next] tools/rv: Remove unneeded semicolon
Content-Language: en-US
To:     zhang.songyi@zte.com.cn
Cc:     rostedt@goodmis.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202212191431057948891@zte.com.cn>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <202212191431057948891@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 07:31, zhang.songyi@zte.com.cn wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
> 
> The semicolon after the "}" is unneeded.
> 
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel
