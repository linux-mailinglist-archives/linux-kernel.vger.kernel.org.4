Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014F15B3522
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiIIKVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiIIKVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:21:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E827C338;
        Fri,  9 Sep 2022 03:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BA18B82469;
        Fri,  9 Sep 2022 10:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDC6C433C1;
        Fri,  9 Sep 2022 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662718907;
        bh=b4oK314LLkf7QjaChpGaaOrLAibH7tVlQL3P06Ei2oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftY/N66OiqEPTohS2wkWfSlMKStHqxly+HbCP1kCsityq8nyAUKvK9eQFA1QPnku/
         sXSrTq8kUBByO3AgUK/gUfJkIRjKOOYbFLSBHXYijG+NeAeAKL5ibXevU+eBCYG6TK
         +TK6YBgKQyN+GwSnY4zkPiZ9qaBjpOfJsztgh6Os=
Date:   Fri, 9 Sep 2022 12:21:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heghedus.razvan@gmail.com, evgreen@chromium.org,
        yuanjilin@cdjrlc.com, stern@rowland.harvard.edu,
        jj251510319013@gmail.com
Subject: Re: [PATCH v1] drivers/usb/core/driver: check return value of
 usb_set_interface()
Message-ID: <YxsTuDsMPNE25k7S@kroah.com>
References: <20220909044215.2620024-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909044215.2620024-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 09:42:14PM -0700, Li Zhong wrote:
> Check return value of usb_set_interface() and report error if it fails.
> Otherwise usb_set_interface() may fail without any warnings. 
> 
> This flaw was found using an experimental static analysis tool we are
> developing. Report warnings when the function usb_set_interface() fails
> can increase the dianosability.

How did you test this change?

