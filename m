Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130846F05BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbjD0M1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243155AbjD0M1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:27:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914AE30E8;
        Thu, 27 Apr 2023 05:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C66C60A53;
        Thu, 27 Apr 2023 12:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4145FC4339B;
        Thu, 27 Apr 2023 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682598428;
        bh=OlYqoix/LTad+dgc4s998RetonnnpYbifeK1u1g4fRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6+sdU47yhwn+Ipbc5M7rH4D+fMp9q9jrRqR5TlUyXNg2iRunEl/9jHfiTHDaO8hO
         mWS42Lj4sRYoI904bQUq5J3SYpttuuNjY/dGQzYdNrByPl6dkEMVBDQvOAehNDPw3L
         N9AGgKxnrsslv0XkLSb/4nQ38zKC9iweb68m4wi4=
Date:   Thu, 27 Apr 2023 14:27:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     sangsup lee <k1rh4.lee@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: Fix a Use after-free-bug by race
 condition
Message-ID: <2023042722-humble-unthread-9597@gregkh>
References: <20230323013655.366-1-k1rh4.lee@gmail.com>
 <CAJkuJRjFCXkS+osc8ezpAw0E2W7WMAJnnxMt_cs4deqgm5OzHw@mail.gmail.com>
 <2023042702-shuffling-tweet-d9f6@gregkh>
 <CAJkuJRhqU++S+xYPDFDyxawfz_ePGJ0oTk-ZZg8N8BSfKcSdDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJkuJRhqU++S+xYPDFDyxawfz_ePGJ0oTk-ZZg8N8BSfKcSdDA@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Apr 27, 2023 at 08:51:48PM +0900, sangsup lee wrote:
> I reported fastrpc bug in
> Feb,2023.(https://lore.kernel.org/lkml/20230216014120.3110-1-k1rh4.lee@gmail.com)

That was a patch, not a bug report.  How was this tested?

> And Srinivas recommended this patch code for patch v2.
> That's why I sent this patch v2 however, I haven't received any reply
> after that.
> 
> I just want to know the next step for patching this code.
> Should I just keep waiting ? Or Please let me know if I need to
> provide you with more information.

Please read my comments on my last email on the patch for what you need
to address.

thanks,

greg k-h
