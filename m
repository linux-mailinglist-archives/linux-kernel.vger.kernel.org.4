Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA4774CC5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjGJFrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjGJFrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D245F1;
        Sun,  9 Jul 2023 22:47:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C629460E05;
        Mon, 10 Jul 2023 05:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5146C433C8;
        Mon, 10 Jul 2023 05:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688968027;
        bh=d8K4eM0jKwdKQA1s85MdlK6toxYLzAe2+LGYszPYOvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xxzPFNL9Xda0x+ebbSA6bXOUrCEBExZFFL3vWt/RQLkRX5SFmhMDakVNgm/CX3Apl
         o+H6SD3aHGnknNqFaOV2GqU8LL5p4VhxIUQiFCp1wmrKhSLVJjvkk0kyK0LHdNs/+n
         D1e0nTwQAj6OOYG3dpZ5jaB1mxoO8Z8flSVd9xZU=
Date:   Mon, 10 Jul 2023 07:47:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        Xu Panda <xu.panda@zte.com.cn>
Subject: Re: staging: ks7010: potential buffer overflow in
 ks_wlan_set_encode_ext()
Message-ID: <2023071056-amused-yam-5e29@gregkh>
References: <tencent_5153B668C0283CAA15AA518325346E026A09@qq.com>
 <2a41ca22-a0eb-df38-be43-7175e1230bd0@web.de>
 <2023070919-monetary-sleet-2f5c@gregkh>
 <e24f9c2c-1163-631a-f8c0-b6dcb445a858@web.de>
 <tencent_BB4124566E846A2FB6ECC0F63C5A15BE5009@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_BB4124566E846A2FB6ECC0F63C5A15BE5009@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 01:41:07PM +0800, Zhang Shurong wrote:
> Hi Markus,
> 
> > 2023年7月10日 03:56，Markus Elfring <Markus.Elfring@web.de> 写道：
> > 
> >>>> The "exc->key_len" is a u16 that comes from the user.  If it's over
> >>>> IW_ENCODING_TOKEN_MAX (64) that could lead to memory corruption.
> >>> 
> >>> Please choose an imperative change suggestion.
> >> 
> >> Please stop reviewing staging patches, it is not helpful for anyone.
> > 
> > It seems that further contributors need to become more aware about
> > (and finally adhere to) requirements from the Linux development documentation.
> > 
> > Regards,
> > Markus
> 
> I'm guilty of my incorrect patch format. And do I need to write another
> patch to fix this format issue?

One of the hardest things in kernel development is learning what
reviews, and what reviewers, should be ignored.  This is one of them :)

No need to change the patch yet, let me get to this change this week and
I'll let you know.

thanks,

greg k-h
