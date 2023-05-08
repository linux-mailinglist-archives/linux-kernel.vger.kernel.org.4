Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E413E6FB4E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjEHQNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjEHQNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:13:45 -0400
Received: from m228-13.mailgun.net (m228-13.mailgun.net [159.135.228.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5EB49EE
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:13:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683562422; x=1683569622; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=hLUctUNuRMNIWC7TGpkyun0GttzEEowczu+MhwkqfZ4=;
 b=DuPu0feSQgBaI52SfabX0Q0nUWn5MyhHGjUzSAof7zg694fOu0KS58vQfeINQELxvZqmYvqTgclAp0iS9vgS9IViKg7BqUitP2KsUWNTKS1Q13bQUB7U70dBzSsJH0BbB1+FRaOaD9HbhAfuAoy7+9jlJNF5mb/xMLtAttLXc9HCI3Z3wnhGcsckvfrV8vWHphzdq7oRPS+NLKU9CkQTa3qanh3dQBwQxbMZizRpZtEreyONzzewualr7YA/ysb4axQVMjN2kt0q5d1F18RFaB9jL+iziyOGQk7JPH26tX4vVZSx9BeNOb0+52RqJgSTWoSaUEJHWbG+A+6nWorwug==
X-Mailgun-Sending-Ip: 159.135.228.13
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by e56841f6d002 with SMTP id
 64591fb6692de41d454a82a9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 May 2023 16:13:42 GMT
Sender: james@equiv.tech
Date:   Mon, 8 May 2023 09:13:41 -0700
From:   James Seo <james@equiv.tech>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     James Seo <james@equiv.tech>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: device.h: add some missing kerneldocs
Message-ID: <ZFkftcxqQRblDgzX@equiv.tech>
References: <20230508154849.1946589-1-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230508154849.1946589-1-james@equiv.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 08:48:50AM -0700, James Seo wrote:
> Add the missing kerneldocs (except for DEVICE_ATTR_IGNORE_LOCKDEP(),
> which is only meaningful on debug builds with CONFIG_DEBUG_LOCK_ALLOC
> not #defined, and is aliased to DEVICE_ATTR() otherwise).
> 
> Signed-off-by: James Seo <james@equiv.tech>
> ---

I just noticed that there shouldn't be a "not" before "#defined" in the
last line of the commit message. Apologies.

