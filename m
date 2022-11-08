Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799FA621B1C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbiKHRuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbiKHRuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:50:10 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068DCFC9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667929801; bh=+NOhY9cMPYMZoVEU1AbEPcrtIM+hVlOUBhjYh0sY7+I=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=BhnlnN821nRvoicXUe2C8HbodRGTjjFz8AemyVxzGlSgAPKXREkR93meXRpyYLXgC
         227L29KDaR5MHZRMN8X9W5AzldckrTa4DvXxjdjmnaPNDbgz3hxKncwryCziJu8kl6
         fEO6IDtN8F+TUL0X34Rw1kQq2oUwqKDbO/E5aaqc=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue,  8 Nov 2022 18:50:01 +0100 (CET)
X-EA-Auth: OT8zaZpmWzh0aQdK0flkYBr9OxQaV++XHIQ5uECHuTZRg8ofv+M7kTKRMT+3r6H4njd1P/qZBDFa3NvpCjpHmdibuC5xTG2S
Date:   Tue, 8 Nov 2022 23:19:56 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8723bs: Simplify underutilized 2D array
 to 1D array
Message-ID: <Y2qWxOqEZNWekzUJ@qemulion>
References: <cover.1667586648.git.drv@mailo.com>
 <4fb8d9783553d15a58e774d7137519d46e58ee3a.1667586648.git.drv@mailo.com>
 <Y2YghalNBdtaAQdr@kroah.com>
 <Y2YiXCCyH9zJssCX@qemulion>
 <Y2YqPatklSEPx5EV@qemulion>
 <Y2pzjVVtBe04Zyna@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2pzjVVtBe04Zyna@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 04:19:41PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Nov 05, 2022 at 02:47:49PM +0530, Deepak R Varma wrote:
> > On Sat, Nov 05, 2022 at 02:14:12PM +0530, Deepak R Varma wrote:
> > Hello Greg,
> > Upon further review of the structure, I observed that the member "bIQKDone" is
> > also not used anywhere in the code and it can be removed as well. That cleanup
> > will lead to replacing this entire structure by a simple one dimensional 'Value"
> > array.
> >
> > Please suggest if I should make that change and send in a revision?
>
> Yes, that would be a better overall change.

Hello Greg,
The patch is resubmitted earlier with following subject:
	[PATCH v2] staging: rtl8723bs: replace underutilized struct by array variable

Thank you,
./drv

>
> thanks,
>
> greg k-h
>


