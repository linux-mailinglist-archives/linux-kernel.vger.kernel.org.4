Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890AD6EDB5C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjDYFuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjDYFum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2CB455;
        Mon, 24 Apr 2023 22:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E6CF62B21;
        Tue, 25 Apr 2023 05:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E6AC4339B;
        Tue, 25 Apr 2023 05:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682401831;
        bh=47gVOAES9yb/PSULlzi6EcWoa4i5G7pmHEYyjzJ8u1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UNLpljvyJwnBx1t3AtXnsrZQ4Fp4+d/h/XM/KOf84oQVCJBslw6s+0hi0YOEBM/aH
         tVtQVEXMv1UT3zFvmJZrSuN9BhMV9AAR9blgE1JElGqD3+71qGWZ8bD/Q5XnAMmkee
         DaXlKE9AbiJVEY4GVQUvpL7ByRaxhFk3m5AeMBVk=
Date:   Tue, 25 Apr 2023 07:50:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     ktestrobot@126.com, U201911841@hust.edu.cn, lidaxian@hust.edu.cn,
        hust-os-kernel-patches@googlegroups.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org, s.shtylyov@omp.ru
Subject: Re: [PATCH v2] usb: phy: phy-tahvo: fix memory leak in
 tahvo_usb_probe()
Message-ID: <ZEdqIz8Vfd09zBFL@kroah.com>
References: <644741EB.013E97.00008@m126.mail.126.com>
 <ZEdh-_Jv02qb6K4n@kroah.com>
 <9c09cb12-05d1-7c50-0d99-945fd384e3a3@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c09cb12-05d1-7c50-0d99-945fd384e3a3@hust.edu.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 01:32:35PM +0800, Dongliang Mu wrote:
> 
> On 2023/4/25 13:15, Greg KH wrote:
> > On Tue, Apr 25, 2023 at 10:58:51AM +0800, ktestrobot@126.com wrote:
> > > Hi, Li Yang
> > > This email is automatically replied by KTestRobot(Beta). Please do not reply to this email.
> > But I will!
> > 
> > > If you have any questions or suggestions about KTestRobot, please contact ZhongYong <U201911841@hust.edu.cn>
> > First question, why are you responding from an email that is not allowed
> > to be responded to and forced to have us manually add an address?
> > That's not very nice or helpful for us who have to see these messages,
> > please fix that.
> 
> Hi greg,
> 
> thanks for your feedback.
> 
> This robot is only used for our internal patch review. It should not send
> any email out to Linux kernel mailing list.

But it did :(

> Sorry about this false alarm.

It happened more than once here, so please be more careful with the bot.

thanks,

greg k-h
