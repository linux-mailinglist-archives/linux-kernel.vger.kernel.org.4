Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2625B6D059F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjC3NA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjC3NAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:00:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A32EAD27;
        Thu, 30 Mar 2023 06:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ECBA8CE2A67;
        Thu, 30 Mar 2023 13:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0314CC433D2;
        Thu, 30 Mar 2023 13:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680181208;
        bh=lQjT9u0QiI93GzA4zuiaCmVz/t8Vr34KEmtX0zEjsWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EGgAKfDnmn1bK04UtJg9001JUdYjVM8JejGQNguo5mn6m5ExHmwleJrcZ0smOEGzS
         vBPiLlvo0r/WvjIpUFrum18B6eJo442F5NgcnrK2NOxQQ/7DXnBfOCNuI1RQS1xddQ
         1idQt6Xpj/jzElx70h7DfDv31JhWWVI/1bON2Kwc53Ac/B412bSX4k7XtJJFebqhDx
         y3wJJC5VoaKVau28PQJTB5NFEx6qBKhTZZejtIodeImkFJVzz1Hn455odKflpHFNIM
         iS4giE87UuUseFO0JmmEKJfxI0pJRTknBPyNLJkjzWC1/ytBEr/BRk/oyuuq6oNjyB
         Jx/zwBLgBj9mQ==
Date:   Thu, 30 Mar 2023 14:00:04 +0100
From:   Lee Jones <lee@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     pavel@ucw.cz, quic_fenglinw@quicinc.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: flash: set varaiables mvflash_3,4ch_regs
 storage-class-specifier to static
Message-ID: <20230330130004.GN434339@google.com>
References: <20230317191341.1670660-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230317191341.1670660-1-trix@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023, Tom Rix wrote:

> smatch reports
> drivers/leds/flash/leds-qcom-flash.c:103:18: warning:
>   symbol 'mvflash_3ch_regs' was not declared. Should it be static?
> drivers/leds/flash/leds-qcom-flash.c:115:18: warning:
>   symbol 'mvflash_4ch_regs' was not declared. Should it be static?
>
> These variables are only used in leds-qcom-flash.c,
> so it should be static.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/leds/flash/leds-qcom-flash.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I fixed-up some spelling / formatting issues and ...

Applied, thanks

--
Lee Jones [李琼斯]
