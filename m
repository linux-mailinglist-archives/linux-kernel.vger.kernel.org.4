Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7641163A2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiK1I1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiK1I1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:27:06 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C78C63E2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1669624019; bh=/NvhJG+rqUvTCbK0vNxiyNK+85hTvfLth9ocA0GhXQo=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Jh9UXgXtey/aO6iW2SnkwMt2AqIvHvWSW/exFVhMPIHzH5mryO+xbG6DlgUrIyGP6
         2JWaJQG8NkWQ1+Evoxn03frfIUEcIYurPgnYYezSaGHlCRC3WzdDNG+A8a2mXMyDpL
         KPlYZkKsFHA26ReC4KxwAUcg998ikFZucy2lvAJ8=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 28 Nov 2022 09:26:59 +0100 (CET)
X-EA-Auth: uZKC0MjozQHYPB5F8zENZ73MSjUBB7FQ7PGAv5EJpMeRH8PX1WJwoP8kQkJKelMJEGp+EGK1S+bGxuUZf57Tvox8z43eMp15
Date:   Mon, 28 Nov 2022 13:56:53 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        gustavoars@kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <Y4RwzX2Wzguw703W@qemulion>
References: <Y3YKhee8L+kAfHM4@qemulion>
 <Y3YvGdkyGm7azGg4@kroah.com>
 <Y3Y1N6AwWEXLpSrx@qemulion>
 <Y3Z3aatcaISvqURJ@kroah.com>
 <Y3jqUpNOygJ4+2jy@qemulion>
 <Y4RnJyiCDYavLAJq@qemulion>
 <Y4RoOxgo76Hc5RRP@kadam>
 <Y4RvpvpmFL8zNvfB@qemulion>
 <Y4RwXSs9ha0zepxZ@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4RwXSs9ha0zepxZ@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:25:01AM +0300, Dan Carpenter wrote:
> On Mon, Nov 28, 2022 at 01:51:58PM +0530, Deepak R Varma wrote:
> > On Mon, Nov 28, 2022 at 10:50:19AM +0300, Dan Carpenter wrote:
> > > Like this:
> >
> > Thank you Dan. This takes me back to the very first version of this patch. I
> > will send in the clean up.
>
> Don't just send what I sent you, look around and try to see if there are
> other issues with the code.

Yes, I will follow your advise.

Thanks,
./drv

>
> regards,
> dan carpenter
>
>


