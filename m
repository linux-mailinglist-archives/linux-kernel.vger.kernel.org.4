Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573EB6FBCD2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjEICCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEICCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:02:42 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B071FF5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:02:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683597760; x=1683604960; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=85DF44OvPh9bvuw6QTzTB086lSeIBOMa8KtI2mLti0w=;
 b=W96+9oTTRmQ9lyUPML0QLiB6lfckb4FOn3jfzT10g9Xx7rvbnlQm8FgNT7V9SAvy88KRizZ1fsei4eWgQFidpFqEf7PTs/izlLKQIMf28L3O+jHiLic6vFsZKDf9OUjT+sdzNqW5Tzf4JHkrJJwbjWPGHrlB/fLL3xZut3ecFeFsKcfFF/1d7mR0pNUIKVDla3yVANq0gazRRDxwu5fFjLTZnSGPXTSxVy6ATPwQI6IEDy9BGhagKmcJUeEZZBW9CWKmCl6whq48GuRXgdLyJU3p9Cryzej3mBEUiUxIJFuzk2FHvEZLV1ucO2+EF3SR1JvzijBiIR9Im6LEEqmlew==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 8759390b49a2 with SMTP id
 6459a71b91aa19be7d14f921 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 May 2023 01:51:23 GMT
Sender: james@equiv.tech
Date:   Mon, 8 May 2023 18:51:20 -0700
From:   James Seo <james@equiv.tech>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     James Seo <james@equiv.tech>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: device.h: add some missing kerneldocs
Message-ID: <ZFmnGGzcTPdrvJrn@equiv.tech>
References: <20230508154849.1946589-1-james@equiv.tech>
 <ZFkftcxqQRblDgzX@equiv.tech>
 <0a75a41e-6458-8f7a-67cd-89eb05eb822f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a75a41e-6458-8f7a-67cd-89eb05eb822f@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 11:55:47AM -0700, Randy Dunlap wrote:
> On 5/8/23 09:13, James Seo wrote:
>> On Mon, May 08, 2023 at 08:48:50AM -0700, James Seo wrote:
>>> Add the missing kerneldocs (except for DEVICE_ATTR_IGNORE_LOCKDEP(),
>>> which is only meaningful on debug builds with CONFIG_DEBUG_LOCK_ALLOC
>>> not #defined, and is aliased to DEVICE_ATTR() otherwise).
>>>
>>> Signed-off-by: James Seo <james@equiv.tech>
>>> ---
>> 
>> I just noticed that there shouldn't be a "not" before "#defined" in the
>> last line of the commit message. Apologies.
>> 
> 
> Other than that (above), LGTM.
> 
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> -- 
> ~Randy

Thanks for the review!

Just to be clear, that line should read "defined, and is aliased to..."
as commit messages can't have lines that begin with '#'.

James

