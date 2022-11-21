Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A239063212D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiKULtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiKULtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:49:01 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF976286E2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:Cc:Subject:From:To:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1g943rh/a2EtqDcIab+Z59tn2hnQTsjs1qXHUMFguac=; b=k4xrJGgbU71tffXtbjg27l+WxP
        v9kJbJ/+4LFQPySkqSVehcM/qSaXVlCbJtrUmkHO4IcbM0bSAaFtndDlGUMKRp0idFuuf+SAm6aML
        AOHVtUtwEemkdeHNZFfG861k1TizJeioh8imU6r6NfGhRYC5Q8OziQoAh/eJAn50AXoGO1CVbOghO
        Ps3ZaoW4YeEB2lMjHRVQ8hB/bJtkBgLoaMYkj06LoXU4bYKpAfA2n1i1zcPkOV7iIo8YRynOTQn4A
        pZGrY2aTYgW7ru/qLh5hYAgJaR8odFPZ9fJsjHeNPGU991u+Y6hp7lIeB6AFkVJhc4Z/k7nYVLK7d
        Q/8t+0dw==;
Received: from [2a01:799:95e:1700:6395:ccbd:d000:d42b] (port=56753)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1ox5IE-0004Kk-BV; Mon, 21 Nov 2022 12:48:54 +0100
Message-ID: <1bc45775-0667-01f8-36e1-9f65d3081092@tronnes.org>
Date:   Mon, 21 Nov 2022 12:48:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To:     dri-devel@lists.freedesktop.org
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: git send-email friendly smtp provider anyone?
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

A couple of years ago my email provider blocked me from using git
send-email with their smtp server. So I switched to the one my ISP
provides. Now my ISP have outsourced their email service so the first 3
emails gets through and the rest looks like it ends up in a tar pit or
something, 18 hours later and 5 of 7 emails have gotten through. I have
asked them about this, but I fear the answer will be this is not
supported since they now don't have the service in-house anymore. I'm
waiting for a reply.

Today I tried sendinblue.com since they have a free plan, but they
insert <br> in the emails so that didn't work out. They also have some
kind of queue, after 1 hour 6 of 7 emails have gotten through.

Does anyone have an smtp provider to recommend that works with git
send-email and that sends out all the emails at once?

I have a patchset that I want to send out.

Noralf.
