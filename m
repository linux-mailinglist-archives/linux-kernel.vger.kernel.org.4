Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ACC6B50CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCJTS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCJTSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:18:25 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B811637E0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1678475885; bh=zqyO4bs9LK6fs7y+SygD1t3p1TpwGsNuiTjcvcdIkXs=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=MUB6BV/FUJDpFeU7hzTviUmzIbBlYgtRZ1wMOGkjLXzhZXG/uhiZB/AAQh9/14XWj
         UlgNqtWZTYA4k37y1aP2bhDhKke2DWLsxdDW/tr69qvt9b/pnOEP3oqmb2prcri1U7
         90M6p8OO/X8ERY4ACp2yXZuIlD9lvZ3u9qYNrniw=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Fri, 10 Mar 2023 20:18:05 +0100 (CET)
X-EA-Auth: jpHp83SeGtVf0lyiyIBpKOv7LiaKqrsgrRLCj45b0ccQgIpkccUPzAItcRyxtWX2bBdgaIpc2eke/ePNeXkXSKwkRtgLm+lv
Date:   Sat, 11 Mar 2023 00:47:59 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix exceeds line length
Message-ID: <ZAuCZ/xD/UaR+6kR@ubun2204.myguest.virtualbox.org>
References: <ZAtkW6g6DwPg/pDp@khadija-virtual-machine>
 <ZAt4irZnVJW4zQNb@ubun2204.myguest.virtualbox.org>
 <ZAt9e8Xnd4wAnjPn@khadija-virtual-machine>
 <ZAt+wJIhq780Ms4T@ubun2204.myguest.virtualbox.org>
 <ZAuB6hJ3pOWxnWuS@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAuB6hJ3pOWxnWuS@khadija-virtual-machine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:15:54AM +0500, Khadija Kamran wrote:
> Hi Deepak!
> If I join the if condition to one line, the line length becomes 97
> columns. Would that be okay?

Yes, the line length limit is recently revised to 100 characters.


