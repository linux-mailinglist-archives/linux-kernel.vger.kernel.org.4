Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23851617A37
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiKCJsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCJrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:47:55 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C81E000
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667468857; bh=mAFMlhBrnqdkVI9PXuWkqqbxF2DjPNvJ9IhFJvqdOVo=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=h4Wz34UUxeJ8s6rpH8sXT0f8pKWEYqcefmbzOxGTIO9ZCZgidDnRjnJVXuialwvU5
         2ayvNwhCJXYC4P6SYsMMoqMxJPKTk8zA1jEgyf7OWhZlIkc9/fOl9uBv14c8vleJWl
         0NUL7GZ4bJqolqJUId8r2OCTH0cagdv57wXgIRLU=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Thu,  3 Nov 2022 10:47:36 +0100 (CET)
X-EA-Auth: yTdpYMwEK5LwbRoruVtM0kM+WYm0pxaNZg8ri2b78h6/fZ/bX61SRRGztsAWjrODKklY4rIOgKodwmq59mpdNramcbircz2G
Date:   Thu, 3 Nov 2022 15:17:31 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unused struct declarations
Message-ID: <Y2OOM8g0Qj1o6dRI@qemulion>
References: <Y2LYvhr74ng+xFbz@qemulion>
 <e76c5fd4-442b-0f0e-73e8-c17acf11b471@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e76c5fd4-442b-0f0e-73e8-c17acf11b471@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 11:09:46PM +0100, Philipp Hortmann wrote:
> On 11/2/22 21:53, Deepak R Varma wrote:
> > Some structures are only declared but have not been used anywhere
> > in the code. Remove such unused structs. Issue identified as part
> > of coccicheck report driven code investigation.
> >
>
> Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

Hello Philipp,
Thank you for testing the changes.

Request (not urgent):
Can you please help me understand how do you
test such changes? Do we need specific hardware for functional tests? Is there a
documentation available to know more about the testing? I am interested in
attaching a physical device to my machine and be able to debug and test the
changes. Can you please provide details when you have time?

Thank you in advance!
./drv


>


