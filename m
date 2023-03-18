Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8DA6BF87A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 08:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjCRHey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 03:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRHev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 03:34:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9B1366A3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 00:34:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 675B6603F6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 07:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686A7C433EF;
        Sat, 18 Mar 2023 07:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679124888;
        bh=ewRBc1+B2HDjz4vSj66bUEibvnGnXnIhfMHz5hGJjVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jk7si+xP22+xoH16ds32wkKzivzQmd8dlhtP3QueTzWu4kTzmHl1keRdldVrBGs1y
         4+b45ZOBCunw8YRtlSZmiwAdUJcNXRzKbYMvL8DkYBPCGbHMbcQEZZcUC9sBo8kDiU
         PjvAQwahNznEXtlojC5HPRt/EoGpU3IMWPx0/umA=
Date:   Sat, 18 Mar 2023 08:34:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alex Komrakov <alexander.komrakov@broadcom.com>
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] pps: Add elapsed realtime timestamping
Message-ID: <ZBVplilCE0LSJx1k@kroah.com>
References: <20230317074739.193965-1-alexander.komrakov@broadcom.com>
 <ZBQdWRHzakFLzSkb@kroah.com>
 <CAMedr-_ssg-baCz94ExMVTeXr2Qivzop1kEpx0S4PWuQdAiGaw@mail.gmail.com>
 <2713f092-5d21-ad5e-c5f4-87c927b18a27@enneenne.com>
 <ZBR3t0D0JEl8feRt@kroah.com>
 <f8ea9ab9-e1c1-7962-dab4-126beda74046@enneenne.com>
 <ZBSeGjBEEzeBv35c@kroah.com>
 <CAMedr-9CvSRmMLhzDatdOvwHDjkxwehOfkEg5WYpxBvEcsYMig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMedr-9CvSRmMLhzDatdOvwHDjkxwehOfkEg5WYpxBvEcsYMig@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 01:32:16PM -0700, Alex Komrakov wrote:
>     AOSP time tags reported location with elapsed realtime and pps provides
> best accuracy.

<snip>

Again, please do not send HTML and please do not top-post as the mailing
list rejects HTML email and top-posting makes it impossible to have a
technical discussion on your changes.

thanks,

greg k-h
